function contents = preprocess(file)
    contents = string(fileread(file));
    contents  = lower(contents);
    contents  = eraseBetween(contents,'<','>','Boundaries','inclusive');
    contents = replace(contents,'$','dollar');
    contents = split(contents);
    contents(startsWith(contents,['http://','https://'])) =  'httpaddr';
    contents = regexprep(contents,'.+@.+','emailaddr'); 
    contents = regexprep(contents,'[0-9]+','number');
    contents = regexprep(contents,'[^a-zA-Z0-9]','');
    contents(strlength(contents)<=1) = [];
    contents = arrayfun(@(str)string(porterStemmer(char(str))),contents);
end
