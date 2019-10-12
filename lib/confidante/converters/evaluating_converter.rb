module Confidante
  module Converters
    class EvaluatingConverter
      def convert(thing)
        case thing
        when Hash
          convert_hash(thing)
        when Array
          convert_array(thing)
        else
          convert_item(thing)
        end
      end

      private

      def convert_hash(thing)
        {}.tap do |h|
          thing.each { |k, v| h[k.to_sym] = convert(v) }
        end
      end

      def convert_array(thing)
        thing.map { |v| convert(v) }
      end

      def convert_item(thing)
        begin
          eval(thing, binding)
        rescue
          thing
        end
      end
    end
  end
end
