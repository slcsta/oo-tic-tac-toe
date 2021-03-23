require "pry"
class TicTacToe

    WIN_COMBINATIONS = [
        [0,1,2], [3,4,5], [6,7,8], 
        [0,3,6],[1,4,7], [2,5,8], 
        [0,4,8], [2,4,6], 
    ]

    attr_accessor :board

# initialize method assigns instance variable @board to an array with 9 blank spaces " "
# instance of the game will set the starting state of the board, an array with 9 indices
# within the instance variable @board

    def initialize(board = nil)
        @board = board || Array.new(9, " ")
    end

    # Prints arrangements of the board according to what the board values are
    def display_board
        puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
        puts "-----------"
        puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
        puts "-----------"
        puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
    end

    # Accepts user's input string as an argument
    def input_to_index(input)
        input.to_i-1
    end
    
    def move(index, token)
        @board[index] = token
    end

    def position_taken?(index)
        if @board[index] == " "
            false
        else
            true
        end
    end

    def valid_move?(index)
        if !position_taken?(index) && (0..8).include?(index)
            return true
        else
            return false
        end
    end

    def turn_count
        @board.count{|token| token == "X" || token == "O"}
    end

    def current_player
        turn_count.even? ? "X" : "O"
    end

    def turn
        @board
        puts "Please enter 1 - 9:"
        user_input = gets.strip
        index_num = input_to_index(user_input)
        if valid_move?(index_num)
            move(index_num, current_player)
            display_board
        else
            turn
        end
    end

    def won?
        WIN_COMBINATIONS.detect do |win_combo|
            if @board[win_combo[0]] == "X" && @board[win_combo[1]] == "X" && @board[win_combo[2]] == "X"
                return win_combo
            elsif @board[win_combo[0]] == "O" && @board[win_combo[1]] == "O" && @board[win_combo[2]] =="O"
                return win_combo
            end
        end
    end

    def full?
        @board.all? {|index| index == "X" || index == "O"}
    end

    def draw?
        if !won? && full? == true
            return true
        else
            return false
        end
    end

    def over?
        if won?
            return true
        elsif draw?
            return true
        else
            return false
        end
    end

    def winner
        if win = won?
            return @board[win[0]]
        end
    end

    def play
        while !over?
            turn
        end

        if won?
            puts "Congratulations #{winner}!"
        elsif draw?
            puts "Cat's Game!"
        end
    end
end