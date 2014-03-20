require 'yaml'

def h1(section)
  "= #{section['title']} ="
end

def h2(section)
  "== #{section['title']} =="
end

def no_table?(section)
  section['headers'].nil? || section['jmods'].nil?
end

def table(section)
  headers = section['headers']
  widths = ['25%','35%','25%']
  avatars = section['avatars']
  jmods = section['jmods']
  output = []
  
  output << '{| class="prettytable" width="75%"'
  
  if avatars
    headers.unshift "Avatar"
    widths.unshift "15%"
  end
  
  headers.each_with_index do |header,i|
    output << "! width=\"#{widths[i]}\" | #{header}"
  end
  
  jmods.each do |jmod|
    output << '|-'
    output << "| <div style=\"width:100px; height:100px; background: url('http://services.runescape.com/m=avatar-rs/#{jmod[0]}/chat.png')\"></div>" if avatars
    output << "| #{jmod[0]}"
    output << "| #{jmod[1]}"
    output << "| [https://twitter.com/#{jmod[2]} @#{jmod[2]}]"
  end
  
  output << '|}'
  
  output.join "\n"
end

sections = YAML.load_file 'j-mods.yml'

sections.each do |section|
  puts h1(section)
  puts table(section) unless no_table?(section)
  
  section['subsections'].each do |subsection|
    puts h2(subsection)
    puts table(subsection) unless no_table?(subsection)
  end unless section['subsections'].nil?
end