$stdout = File.open('output.txt', 'w')

require 'base64'
require 'open-uri'

path = '/Users/tomixy/Local Sites/tetracalibers/app/public/wp-content/themes/tetracalibers/bg.svg'

File.open(path, 'rt') do |f|
    f.each_line do |line|
        #img_url = line[/(https:\/\/cdn\..+\/file\.jpeg)|(https:\/\/cdn\..+\/file\.webp)/]
        img_url = line[/http:\/\/tetracalibers\.local\/wp-content\/uploads\/\d{4}\/\d{2}\/.+\.jpg/i]
        if img_url
            file = URI.open(img_url)
            binary_data = file.read
            img_url_encoded = Base64.strict_encode64(binary_data)
            puts line.gsub!(img_url, 'data:image/jpg;base64,' + img_url_encoded)
        else
            puts line
        end
    end
end
