# Select working database
use Assignment;

# All CSV files imported

## Bajaj ##

# formatting date column 
UPDATE `bajaj`
SET `Date` = STR_TO_DATE(`Date`,'%d-%M-%Y');

# Date column type convertion to date from string
alter table bajaj modify column `date` date;

# Creating bajaj1 table
create table bajaj1 as
(select `Date`,`Close Price`,
CASE WHEN 
	ROW_NUMBER() OVER w >= 20 THEN 
		avg(`Close Price`) over(order by Date ROWS 20 PRECEDING) 
	ELSE NULL 
END AS `20 Day MA`,
CASE WHEN 
	ROW_NUMBER() OVER w >= 50 THEN 
		avg(`Close Price`) over(order by Date ROWS 50 PRECEDING) 
	ELSE NULL 
END AS `50 Day MA`
from bajaj
window w as (ORDER BY DATE));

# Creating bajaj2 table
create table bajaj2 as
(select Date, `Close Price`, 
CASE 
	WHEN `20 Day MA`>`50 Day MA` then 'BUY'
    WHEN `20 Day MA`<`50 Day MA` then 'SELL'
    ELSE 'HOLD'
END AS `Signal` 
from bajaj1);

## Eicher ##

# formatting date column 
UPDATE `eicher` 
SET `Date` = STR_TO_DATE(`Date`,'%d-%M-%Y');

# Date column type convertion to date from string
alter table eicher modify column `date` date;

# Creating eicher1 table
create table eicher1 as
(select `Date`,`Close Price`,
CASE WHEN 
	ROW_NUMBER() OVER w >= 20 THEN 
		avg(`Close Price`) over(order by Date ROWS 20 PRECEDING) 
	ELSE NULL 
END AS `20 Day MA`,
CASE WHEN 
	ROW_NUMBER() OVER w >= 50 THEN 
		avg(`Close Price`) over(order by Date ROWS 50 PRECEDING) 
	ELSE NULL 
END AS `50 Day MA`
from eicher
window w as (ORDER BY DATE));

# Creating eicher2 table
create table eicher2 as
(select Date, `Close Price`, 
CASE 
	WHEN `20 Day MA`>`50 Day MA` then 'BUY'
    WHEN `20 Day MA`<`50 Day MA` then 'SELL'
    ELSE 'HOLD'
END AS `Signal` 
from eicher1);

## Hero ##

# formatting date column 
UPDATE `hero` SET `Date` = STR_TO_DATE(`Date`,'%d-%M-%Y');

# Date column type convertion to date from string
alter table hero modify column `date` date;

# Creating hero1 table
create table hero1 as
(select `Date`,`Close Price`,
CASE WHEN 
	ROW_NUMBER() OVER w >= 20 THEN 
		avg(`Close Price`) over(order by Date ROWS 20 PRECEDING) 
	ELSE NULL 
END AS `20 Day MA`,
CASE WHEN 
	ROW_NUMBER() OVER w >= 50 THEN 
		avg(`Close Price`) over(order by Date ROWS 50 PRECEDING) 
	ELSE NULL 
END AS `50 Day MA`
from hero
window w as (ORDER BY DATE));

# Creating hero2 table
create table hero2 as
(select Date, `Close Price`, 
CASE 
	WHEN `20 Day MA`>`50 Day MA` then 'BUY'
    WHEN `20 Day MA`<`50 Day MA` then 'SELL'
    ELSE 'HOLD'
END AS `Signal` 
from hero1);

## Infosys ##

# formatting date column
UPDATE `infosys` SET `Date` = STR_TO_DATE(`Date`,'%d-%M-%Y');

# Date column type convertion to date from string
alter table infosys modify column `date` date;

# Creating infosys1 table
create table infosys1 as
(select `Date`,`Close Price`,
CASE WHEN 
	ROW_NUMBER() OVER w >= 20 THEN 
		avg(`Close Price`) over(order by Date ROWS 20 PRECEDING) 
	ELSE NULL 
END AS `20 Day MA`,
CASE WHEN 
	ROW_NUMBER() OVER w >= 50 THEN 
		avg(`Close Price`) over(order by Date ROWS 50 PRECEDING) 
	ELSE NULL 
END AS `50 Day MA`
from infosys
window w as (ORDER BY DATE));

# Creating infosys2 table
create table infosys2 as
(select Date, `Close Price`, 
CASE 
	WHEN `20 Day MA`>`50 Day MA` then 'BUY'
    WHEN `20 Day MA`<`50 Day MA` then 'SELL'
    ELSE 'HOLD'
END AS `Signal` 
from infosys1);

## TCS ##

# formatting date column
UPDATE `tcs` SET `Date` = STR_TO_DATE(`Date`,'%d-%M-%Y');

# Date column type convertion to date from string
alter table tcs modify column `date` date;
select * from tcs order by date;

# Creating tcs1 table
create table tcs1 as
(select `Date`,`Close Price`,
CASE WHEN 
	ROW_NUMBER() OVER w >= 20 THEN 
		avg(`Close Price`) over(order by Date ROWS 20 PRECEDING) 
	ELSE NULL 
END AS `20 Day MA`,
CASE WHEN 
	ROW_NUMBER() OVER w >= 50 THEN 
		avg(`Close Price`) over(order by Date ROWS 50 PRECEDING) 
	ELSE NULL 
END AS `50 Day MA`
from tcs
window w as (ORDER BY DATE));

# Creating tcs2 table
create table tcs2 as
(select Date, `Close Price`, 
CASE 
	WHEN `20 Day MA`>`50 Day MA` then 'BUY'
    WHEN `20 Day MA`<`50 Day MA` then 'SELL'
    ELSE 'HOLD'
END AS `Signal` 
from tcs1);

## TVS ##

# formatting date column
UPDATE `tvs` SET `Date` = STR_TO_DATE(`Date`,'%d-%M-%Y');

# Date column type convertion to date from string
alter table tvs modify column `date` date;

# Creating tvs1 table
create table tvs1 as
(select `Date`,`Close Price`,
CASE WHEN 
	ROW_NUMBER() OVER w >= 20 THEN 
		avg(`Close Price`) over(order by Date ROWS 20 PRECEDING) 
	ELSE NULL 
END AS `20 Day MA`,
CASE WHEN 
	ROW_NUMBER() OVER w >= 50 THEN 
		avg(`Close Price`) over(order by Date ROWS 50 PRECEDING) 
	ELSE NULL 
END AS `50 Day MA`
from tvs
window w as (ORDER BY DATE));

# Creating tvs2 table
create table tvs2 as
(select Date, `Close Price`, 
CASE 
	WHEN `20 Day MA`>`50 Day MA` then 'BUY'
    WHEN `20 Day MA`<`50 Day MA` then 'SELL'
    ELSE 'HOLD'
END AS `Signal` 
from tvs1);


## Creating Master table
create table master as 
(select b.date Date, 
b.`close price` Bajaj, 
tc.`close price` TCS, 
tv.`close price` TVS, 
i.`close price` Infosys,
e.`close price` Eicher,
h.`close price` Hero 
from bajaj1 b inner join tcs1 tc 
	on b.date = tc.date
inner join tvs1 tv 
	on tc.date = tv.date
inner join infosys1 i 
	on i.date = tv.date
inner join eicher1 e 
	on e.date = i.date
inner join hero1 h
	on h.date = e.date
);
 
# UserDefinedFunction to sell/hold/signal Bajaj stocks
CREATE FUNCTION BajajStock(d date)
returns char(4) deterministic
return (select `Signal` from bajaj2 where date=d);




