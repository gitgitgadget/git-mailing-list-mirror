From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 1/1] gitweb: javascript ability to adjust time based on timezone
Date: Thu, 24 Mar 2011 16:17:35 +0100
Message-ID: <201103241617.37400.jnareb@gmail.com>
References: <dab08d0ff27b0f571a17ed4f1ab0f39b@localhost> <1300925335-3212-2-git-send-email-warthog9@eaglescrag.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Kevin Cernekee <cernekee@gmail.com>,
	Junio Hamano <gitster@pobox.com>
To: "John 'Warthog9' Hawley" <warthog9@eaglescrag.net>
X-From: git-owner@vger.kernel.org Thu Mar 24 16:18:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2mIT-0007h0-Q9
	for gcvg-git-2@lo.gmane.org; Thu, 24 Mar 2011 16:18:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756582Ab1CXPRy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2011 11:17:54 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:38821 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932287Ab1CXPRw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2011 11:17:52 -0400
Received: by mail-bw0-f46.google.com with SMTP id 15so134228bwz.19
        for <git@vger.kernel.org>; Thu, 24 Mar 2011 08:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=R+ed98V/BW+iTOgeTvK539Yql+i+UDel66XVkuc+/vk=;
        b=cHmTPM5zPOMo/TvZcJZ5lg6bypERXfOLZPSGryfl4rYnarMroqvwiDrkGGevf7DrTr
         4RF0geZ/b3Du6Z61jB/QqAnJKfkm6NdW9dcQy33SpOP9yJWvauHX+Xdws4D1HujAVmbk
         AW/ndCf16FiP3UDgQMyQ2uLORaAR5uiIDS0N8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=ou+FoSmiVWnT45Sd7uk3M4O0jurEr0n4Eq/IiCw+04plp+5/BuA/bzuXA/Cp7uJCoA
         c7yUJqnmLwPxANOa3622HorfF1lLRHpajqrQxummyDlOM8xm4+Yg2UvsU2JEUhE1nQKM
         JVzhy1rEz32VE6FMzvqysC8KyLwUG2IceDHfE=
Received: by 10.204.154.74 with SMTP id n10mr7421202bkw.33.1300979871460;
        Thu, 24 Mar 2011 08:17:51 -0700 (PDT)
Received: from [192.168.1.13] (abwk251.neoplus.adsl.tpnet.pl [83.8.234.251])
        by mx.google.com with ESMTPS id x6sm9468bkv.12.2011.03.24.08.17.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 24 Mar 2011 08:17:48 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1300925335-3212-2-git-send-email-warthog9@eaglescrag.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169925>

On Thu, 24 Mar 2011, John 'Warthog9' Hawley wrote:

> This patch is based on Kevin Cernekee's <cernekee@gmail.com>
> patch series entitled "gitweb: introduce localtime feature".  While
> Kevin's patch changed the server side output so that the timezone
> was output from gitweb itself, this has a number of drawbacks, in
> particular with respect to gitweb-caching.

Excuse me, but the above is not true, Kevin Cernekee's patches, 
_as they are implemented_, would not interfere with [future] gitweb
caching.  What might and probably would interfere with output caching
is hypothetical vaguely proposed series that would implement on server
choosing of timezone on client stored in a cookie.  But Kevin's patches
do not do this.

Any server-side implemented feature that depends only on server-side
configuration, and always create exactly the same view for the same
URL (assuming that repository didn't change), wouldn't interfere with
gitweb-caching.


I agree that implementing what this patch does on server-side would
make gitweb-caching implementation harder, and reduce gains from
caching output.
 
> This patch takes the same basic goal, display the appropriate times
> in a given timezone, and implements it in Javascript.  This requires
> adding / using a new class, dtcommit, which is based on the
> dtstart/dtend microformats.  Appropriate commit dates are wrapped in
> a span with this class, and a title of the time in ISO8601 format.

Is it ISO8601 format with timezone, or in UTC?

Note that currently this pattern is discouraged for accesibility reasons;
http://microformats.org/wiki/datetime-design-pattern says:

  Note: Some accessibility-issues have been raised with Datetime Design
  Pattern, that have been addressed with the completion of the 
  value-class-pattern.

But using value-class-pattern would make it harder for JavaScript to
handle, and at least in short form does not provide us with original
timezone.

> 
> Enabling this will then add several javascript files to be loaded,

While I agree that for maintenance reasons JavaScript files should be
split, most web best practice pages[1][2][3] recommends to combine
JavaScript files for performance.  

[1]: http://developer.yahoo.com/performance/rules.html
     "Minimize HTTP Requests" section
[2]: http://code.google.com/speed/articles/include-scripts-properly.html
     "1. Combine external JavaScript files"
[3]: http://javascript-reference.info/speed-up-your-javascript-load-time.htm
     "Combine Your Files" section.

See also comments below.

But as an RFC / weatherballoon patch it is all right.

> a default timezone to be selected and a single onloadTZSetup()
> function to be called.

What about 'window.onload = fixLinks;' that gitweb used to use to be
able to detect by server-side code if JavaScript-only views (such as
'blame_incremental') should/could be used in place of non-JavaScript
ones?  Ah, I see that it is solved in different way: instead of
window.onload, embedded JavaScript snippet is used.

> 
> This will place a "+" to the right of an appropriate time and clicking
> on it will give you a drop down to choose the timezone to change to.

User interface part would probably be bikeshedded to death... ;-P

> 
> All changes are saved to a Javascript cookie, so page changes and
> browser closure / reopening retains the last known setting used.

Good... assuming that we respect user's choice to not allow cookies.

> 
> Fallback (should Javascript not be enabled) is to treat dates as
> they have been and display them, only, in UTC.

That is sane solution.

> 
> Valid timezones, currently, are:
> 
> utc
> local
> -1200
> -1100
> ...
> +1100
> +1200

I guess that it would be difficult to support 'original' / 'asis' timezone,
i.e. the timezone that author / committer / tagger used, and which is saved
in git object... and it wouldn't be more useful than 'local', I guess.

> 
> With each timezone being +1hr to the previous.  The code is capable of
> handling fractional timezones, but those have not been added.

NOTE: I think that current gitweb code (parse_date / format_date) doesn't
handle negative fractional timezones correctly.  

	$tz =~ m/^([+\-][0-9][0-9])([0-9][0-9])$/;
	my $local = $epoch + ((int $1 + ($2/60)) * 3600);


Though git.git repository doesn't contain negative fractional timezones...
it does contain positive fractional timezones however.

  $ git log --pretty='%ai%n%ci' --all | cut -d' ' -f 3 | sort -n | uniq

Could anyone check it e.g. on Linux kernel repository?

> 
> Pages Affected:
> * 'summary' view, "last change" field (commit time from latest change)
> * 'log' view, author time
> * 'commit' and 'commitdiff' views, author/committer time

I guess other pages (like e.g. feed pages, i.e. 'rss' and 'atom' views)
are not affected?

> 
> Based-on-code-from: Kevin Cernekee <cernekee@gmail.com>

Is it Based-on-code-from, or Idea-by / Inspired-by?  ;-)

> Signed-off-by: John 'Warthog9' Hawley <warthog9@eaglescrag.net>
> ---
>  gitweb/gitweb.perl              |   64 +++++++++++++++-
>  gitweb/static/js/common-defs.js |   12 +++
>  gitweb/static/js/common-lib.js  |   32 ++++++++
>  gitweb/static/js/cookies.js     |   35 +++++++++
>  gitweb/static/js/date.js        |  160 +++++++++++++++++++++++++++++++++++++++
>  5 files changed, 300 insertions(+), 3 deletions(-)
>  create mode 100644 gitweb/static/js/common-defs.js
>  create mode 100644 gitweb/static/js/common-lib.js
>  create mode 100644 gitweb/static/js/cookies.js
>  create mode 100644 gitweb/static/js/date.js

[...]
> @@ -3728,6 +3772,19 @@ sub git_footer_html {
>  		      qq!</script>\n!;
>  	}
>  
> +	print "<!-- jslocaltime: $jslocaltime -->";

Is the above line leftover debugging?

> +	if( $jslocaltime ne '' ){
> +		my $js_path = File::Basename::dirname($javascript);
> +		print qq!<script type="text/javascript" src="!. esc_url( $js_path ."/js/common-defs.js" )	.qq!"></script>\n!;
> +		print qq!<script type="text/javascript" src="!. esc_url( $js_path ."/js/common-lib.js" )	.qq!"></script>\n!;
> +		print qq!<script type="text/javascript" src="!. esc_url( $js_path ."/js/date.js" )		.qq!"></script>\n!;
> +		print qq!<script type="text/javascript" src="!. esc_url( $js_path ."/js/cookies.js" )		.qq!"></script>\n!;
> +		print "<script type=\"text/javascript\">\n".
> +				"var tzDefault = \"$jslocaltime\";\n".
> +				"onloadTZSetup();\n".
> +		      "</script>";
> +	}

First, it is recommended for better performance to consolidate JavaScript
files into single file (or load them dynamically).  gitweb/Makefile could
do this, though it would mean that installing gitweb by hand would be even
more difficult.  But this can be left for later commit.

Second, I guess that some of functions from current gitweb.js could be
moved to js/common-lib.js.  But that can be left for later commit.

Third, I wonder if instead of creating our own library, it wouldn't be
better if gitweb used (perhaps loaded from external source, like Google)
some JavaScript library, like e.g. jQuery.

> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 9dccfb0..2a662d8 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -261,6 +261,49 @@ our %highlight_ext = (
>  	map { $_ => 'xml' } qw(xhtml html htm),
>  );
>  
> +
> +# Enable / Disable the ability for gitweb to use a small amount of 
> +# javascript, along with a javascript cookie, to display commit
> +# times in the preffered timezone.  Time zones can be pre-set 
> +# by specifying it in $jslocaltime with one of the following:
> +#
> +#	utc
> +#	local

See above about lack of 'original' / 'asis' here.

> +#	-1200
> +#	-1100
> +#	-1000
> +#	-0900
> +#	-0800
> +#	-0700
> +#	-0600
> +#	-0500
> +#	-0400
> +#	-0300
> +#	-0200
> +#	-0100
> +#	+0000
> +#	+0100
> +#	+0200
> +#	+0300
> +#	+0400
> +#	+0500
> +#	+0600
> +#	+0700
> +#	+0800
> +#	+0900
> +#	+1000
> +#	+1100
> +#	+1200

Must we list all those timezones explicitely?

> +#
> +# utc is identical to +0000, and local will use the
> +# timezone that the browser thinks it is in.
> +#
> +# Enabled by default.
> +#
> +# To disable set to null or ''

I guess it is "To disable set to undef or ''", isn't it?  BTW. would
any false-ish value (undef, '', 0, 0.0, ()) work?

> +
> +our $jslocaltime = 'local';

Hmmm... I wonder if it wouldn't be better to use non-overridable %feature
for this, instead of introducing yet another [global] variable...


> @@ -504,6 +547,7 @@ our %feature = (
>  		'sub' => sub { feature_bool('remote_heads', @_) },
>  		'override' => 0,
>  		'default' => [0]},
> +
>  );
>  
>  sub gitweb_get_feature {

> +
>  	print "</body>\n" .
>  	      "</html>";
>  }

Stray change?

> -	      " [$ad{'rfc2822'}";
> +	      " [<span class=\"dtcommit\" title=\"$ad{'iso-8601'}\">$ad{'rfc2822'}</span>";
[...]
> -		      "<td></td><td> $wd{'rfc2822'}";
> +		      "<td></td><td> <span class=\"dtcommit\" title=\"$wd{'iso-8601'}\">$wd{'rfc2822'}</span>";
[...]
> -		print "<tr id=\"metadata_lchange\"><td>last change</td><td>$cd{'rfc2822'}</td></tr>\n";
> +		print "<tr id=\"metadata_lchange\"><td>last change</td>\n";
> +		print "<td><span class=\"dtcommit\" title=\"$cd{'iso-8601'}\">$cd{'rfc2822'}</span></td></tr>\n";

This code repetition just begs for a helper subroutine, like e.g.

  -	      " [$ad{'rfc2822'}";
  +	      " [" . format_timestamp($ad, 'rfc2822');

or

  +	      " [" . format_timestamp($ad, -format=>'rfc2822');

> diff --git a/gitweb/static/js/common-defs.js b/gitweb/static/js/common-defs.js
> new file mode 100644
> index 0000000..23a1cc2
> --- /dev/null
> +++ b/gitweb/static/js/common-defs.js
> @@ -0,0 +1,12 @@
> +// Copyright (C) 2011, John 'Warthog9' Hawley <warthog9@eaglescrag.net>
> +//
> +//
> +// JavaScript common globals for gitweb (git web interface).
> +// @license GPLv2 or later
> +//
> +
> +// Common universal values get set here
> +// Things like cookie names, and other just
> +// basic global variables.
> +
> +getwebCookieTZOffset = "tzOffset";
   ^^^^^^
        \- typo, probably should be "gitweb" here

Is it really worth adding extra JavaScript file?

> diff --git a/gitweb/static/js/common-lib.js b/gitweb/static/js/common-lib.js
> new file mode 100644
> index 0000000..2ce65ec
> --- /dev/null
> +++ b/gitweb/static/js/common-lib.js
> @@ -0,0 +1,32 @@
> +// Copyright (C) 2011, John 'Warthog9' Hawley <warthog9@eaglescrag.net>
> +//
> +//
> +// JavaScript date handling code for gitweb (git web interface).
> +// @license GPLv2 or later
> +//
> +//
> +function findElementsByClassName( className ) {
> +	if( document.getElementsByClassName == undefined) {
> +		var hasClassName = new RegExp("(?:^|\\s)" + className + "(?:$|\\s)");
> +		var allElements = document.getElementsByTagName("*");
> +		var foundElements = [];
> +
> +		var element = null;
> +		for (var x = 0; (element = allElements[x]) != null; x++) {
> +			var curClass = element.className;
> +			if(
> +				curClass				// If we've actually got something
> +				&&
> +				curClass.indexOf(className) != -1	// And it has a valid index, I.E. not -1
> +				&&
> +				hasClassName.test(curClass)		// and the regex passes
> +			) {
> +				foundElements.push(element);		// push it onto the results stack
> +			}
> +		}
> +
> +		return foundElements;
> +	}else{
> +		return document.getElementsByClassName( className );
> +	}
> +}

Hmmm... this really begs for some JavaScript library, like e.g. jQuery.
Is there any sane web browser that doesn't support getElementsByTagName?

BTW. is it your own code?

> diff --git a/gitweb/static/js/cookies.js b/gitweb/static/js/cookies.js
> new file mode 100644
> index 0000000..8c8f7aa
> --- /dev/null
> +++ b/gitweb/static/js/cookies.js
> @@ -0,0 +1,35 @@
> +// Copyright (C) 2011, John 'Warthog9' Hawley <warthog9@eaglescrag.net>
> +//
> +//
> +// JavaScript cookie handling code for gitweb (git web interface).
> +// @license GPLv2 or later
> +//
> +
> +function setCookieExp( name, value, expires ){
> +	var expDate = new Date( expires.toString() );
> +	expires = expDate.toUTCString;
> +	document.cookie = escape(name) +"="+ escape(value) +";"+ expDate.toUTCString() +";path=/";

Shouldn't it be

  +	document.cookie = escape(name) +"="+ escape(value) +";expires="+ expDate.toUTCString() +";path=/";

> +}
> +
> +function setCookie( name, value ){
> +	var txtCookie = name +"=\""+ value +"\";path=/";
> +	document.cookie = txtCookie;
> +}

Hmmm... why setCookie doesn't escape name and value, but surrounds value
with doublequotes '"', contrary to what setCookieExp does?

Should we set 'path' to anything in a cookie?

> +
> +function getCookie( name ){
> +	var allCookies = document.cookie.split(";");
> +	var value = "";
> +
> +	for( var x = 0; x < allCookies.length; x++ ){
> +		var brokenCookie = allCookies[x].split("=",2);
> +		var hasName = new RegExp("^\\s*" + name + "\\s*$");

Note: I am not sure if using '/regex/' instead of 'new RegExp("regex")'
isn't preferred way of dealing with regular expressions in JavaScript.

> +		if(
> +			hasName.test(brokenCookie[0])	// Check for the name of the cookie based on the regex
> +			&&
> +			brokenCookie.length == 2	// Just making sure there is something to actually return here
> +		){
> +			return unescape(brokenCookie[1]);
> +		}
> +	}
> +	return null;
> +}

Please do not use RegExp where string comparison would be enough.  Also,
escape cookie name first (or unescape what you got from browser):

  +function getCookie(name)
  +{
  +	var allCookies = document.cookie.split("; ");
  +
  +	for (var x = 0; x < allCookies.length; x++ ) {
  +		var oneCookie = allCookies[x].split("=", 2);
  +		if (oneCookie[0] == escape(name)) {
  +			return unescape(oneCookie[1]);
  +		}
  +	}
  +	return null;
  +}


> diff --git a/gitweb/static/js/date.js b/gitweb/static/js/date.js
> new file mode 100644
> index 0000000..a6d6f81
> --- /dev/null
> +++ b/gitweb/static/js/date.js
> @@ -0,0 +1,160 @@
> +// Copyright (C) 2011, John 'Warthog9' Hawley <warthog9@eaglescrag.net>
> +//
> +//
> +// JavaScript date handling code for gitweb (git web interface).
> +// @license GPLv2 or later
> +//
> +
> +function onloadTZSetup(){
> +	addChangeTZ();
> +	tzChangeNS( tzDefault );
> +	checkTZCookie();
> +}

Shouldn't we check cookie first, so that we can pre-select current
choice of timezone?

> +
> +function addChangeTZ() {

A bit of bikeshedding: perhaps there is a better name for adding
UI to change timezone used in all timestamps than addChangeTZ?

> +		var txtClassesFound = "";

Leftover debugging aid?

> +		var classesFound = findElementsByClassName( "dtcommit" );
> +		txtClassesFound += "Length: "+ classesFound.length +"<br>\n";
> +		for ( x = 0; x < classesFound.length; x++){
> +			curElement = classesFound[x];
> +			txtClassesFound += "<br>\n"+ x +" - "+ curElement.nodeName  +" - "+ curElement.title +" - "+ curElement.innerHTML +"<br>\n";
> +			var strExtra = " <span onclick=\"clickDate(event.target);\" title=\"+\">+</span>"

Errr... shouldn't 'title' attribute explain what this "+" is about instead?

> +			curElement.innerHTML = curElement.innerHTML + strExtra;
> +		}
> +}

Note for the future: instead of using 'onclick' handler for each event,
perhaps a better solution, though requiring more JavaScript knowledge,
is to make use of event bubbling?

But I think, user interface considerations aside, that is a good enough
solution for this/first commit.

> +
> +function checkTZCookie(){
> +	var preSetTZ = getCookie( getwebCookieTZOffset );

"preSetTZ", not "presetTZ"?  "getwebCookieTZOffset", not 
"gitwebCookieTZOffset"?

> +	if(
> +		preSetTZ != null
> +		&&
> +		preSetTZ.length != 0
> +	){
> +		tzChange( preSetTZ );
> +	}
> +}
> +
> +function formatTZ( tzOffset ) {

What does this function _do_; what are the arguments and what it returns?
There is no comment describing this function.  

I guess that it converts timezone offset as number to string.

> +		var posNeg = "+";
> +		if( tzOffset < 0 ){
> +			posNeg = "-";
> +		}

"posNeg" and not e.g. "sign"?

> +		tzOffset = Math.sqrt( Math.pow( tzOffset, 2 ) );

Uhhh?  Using something like this for abs?  WTF?

> +		if( tzOffset < 100 ){
> +			tzOffset = tzOffset * 100;
> +		}
> +		for( y = tzOffset.toString().length + 1; y <= 4; y++ ){
> +			tzOffset = "0"+ tzOffset;
> +		}

Why not use padLeft from gitweb.js here (perhaps moved to js/common-lib.js),
i.e. 

  +		tzOffset = padLeft(tzOffset, 4, '0');

> +		return posNeg + tzOffset;
> +}


> +
> +function dateOutput( objDate ) {
> +	return dateOutputTZ( objDate, "0" );
> +}

Do we really need this offset function?

> +
> +function dateOutputTZ( objDate, tzOffset ) {
> +	var strDate = "";
> +	var daysOfWeek = [ "Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat" ];
> +	var monthsOfYr = [ "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec" ];
> +
> +	if( tzOffset == "utc" ){
> +		tzOffset = 0;
> +	}else if( tzOffset == "local" ){
> +		var tempDate = new Date();
> +		tzOffset = tempDate.getTimezoneOffset() * -1 / 60 * 100; 
> +		tzOffset = formatTZ( tzOffset );

I think it might be good idea to keep return value of getTimezoneOffset,
to not recalculate it again and again.  But it might be not good because
those two values (string timezone and offset in minutes) must be kept
in sync...

> +	}

We probably should extract getting local timezone to separate function,
and save its result somewhere so that we don't have to do this calculation
for each date, only once per invocation.

> +
> +	var msPerHr = 1000 * 60 * 60;	// 1000ms/sec * 60sec/min * 60sec/hr
> +	var toDateTime = new Date();

Perhaps "offsetDate" or "dateWithOffset" would be a better name for
this variable?

> +	toDateTime.setTime( objDate.getTime() + ( tzOffset / 100 * msPerHr ) );

This doesn't deal with fractional timezones, contrary what you said
in the commit message, isn't it?

> +
> +	// Current Date Formatting:
> +	// Fri, 19 Dec 2008 11:35:33 +0000
> +	strDate += daysOfWeek[ toDateTime.getUTCDay() ] +", ";
> +	strDate += toDateTime.getUTCDate() +" ";
> +	strDate += monthsOfYr[ toDateTime.getUTCMonth() ] +" ";
> +	strDate += toDateTime.getUTCFullYear() +" ";
> +	strDate += toDateTime.getUTCHours() +":";
> +	strDate += toDateTime.getUTCMinutes() +":";
> +	strDate += toDateTime.getUTCSeconds() +" ";

Don't you need to '0'-pad hours, minutes and seconds?

> +
> +	strDate += tzOffset;

Note for the future: composing a string by repeated concatenation is not
the best solution - it is faster to create array and join it to single
string at the end.  But this could be left for late commit.

Also I'd prefer if formatting of RFC2822 date was put in a separate
function.

> +
> +	return strDate;
> +}
> +
> +function tzChange( tzOffset ){
> +	return tzChangeSNS( tzOffset, true );
> +}
> +
> +function tzChangeNS( tzOffset ){
> +	return tzChangeSNS( tzOffset, false );
> +}

What are those wrappers needed for?

> +
> +function tzChangeSNS( tzOffset, set ){
> +	var txtClassesFound = "";
> +	var classesFound = findElementsByClassName( "dtcommit" );
> +	for ( x = 0; x < classesFound.length; x++){
> +		curElement = classesFound[x];
> +		var origDateTime = new Date( curElement.title );

I wonder if using 'new Date( Date.parse(curElement.title) )' would make
it more portable...

...or perhaps use regexp to parse date as fallback.

> +		curElement.innerHTML = dateOutputTZ(origDateTime, tzOffset);
> +	}
> +	var tzExpDate = new Date();
> +	tzExpDate.setDate( tzExpDate.getDate() + 180 );

Why magic 180?

> +	if( set == true ){
> +		setCookieExp( getwebCookieTZOffset, tzOffset, tzExpDate.toUTCString() );
> +	}
> +	addChangeTZ();

Do we need, and should we set expiration date for this cookie?

> +}
> +
> +function clickDate( clkEvent ) {
> +	if( clkEvent.title == "+" ){
> +		clkEvent.title="-";

Nice trick to allow expansion and contracting...

> +
> +		var preSetTZ = getCookie( getwebCookieTZOffset );
> +		
> +		var arrSelected = new Array();

I think the preferred way is to use

  +		var arrSelected = [];

> +		var offsetArr = 14;
> +		arrSelected[0] = " ";
> +		arrSelected[1] = " ";
> +		if( preSetTZ == "utc" ) {
> +			arrSelected[0] = " selected=\"selected\" ";
> +		} else if( preSetTZ == "local" ){
> +			arrSelected[1] = " selected=\"selected\" ";
> +		}
> +		for( x = -12; x <= 12; x++){
> +			arrSelected[x + offsetArr] = "";
> +			if( ( x * 100 ) == preSetTZ ){
> +				arrSelected[x + offsetArr] = " selected=\"selected\" ";
> +			}
> +		}
> +		var txtTzSelect = " \
> +<span style=\"width: 10%;background-color: grey;\">- \

Probably needs some absolute or relative positioning, to avoid reflow.

> +<table border=\"1\">\
> +	<tr>\
> +		<td>\
> +			Time Zone:\
> +		</td>\
> +		<td>\
> +			<select name=\"tzoffset\" onchange=\"tzChange(this.value);\">\
> +				<option "+ arrSelected[0] +" value=\"utc\">UTC/GMT</option>\
> +				<option "+ arrSelected[1] +" value=\"local\">Local (per browser)</option>";
> +		for( x = -12; x <= 12; x++){
> +			var tzOffset = formatTZ( x );
> +			txtTzSelect +="					<option "+ arrSelected[x + offsetArr] +"value=\""+ tzOffset +"\">"+ tzOffset +"</option>";
> +		}
> +		txtTzSelect += "\
> +			</select>\
> +		</td>\
> +	</tr>\
> +</table>\
> +</span>";
> +		clkEvent.innerHTML = txtTzSelect;
> +	}else{
> +		clkEvent.parentNode.title="+";
> +		clkEvent.parentNode.innerHTML = "+";
> +	}
> +}

All right, probably using innerHTML instead of constructing DOM is 
a better solution, or at least more portable.  Well, easier anyway.

-- 
Jakub Narebski
Poland
