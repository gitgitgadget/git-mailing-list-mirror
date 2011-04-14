From: =?ISO-8859-2?Q?Micha=B3_=A3owicki?= <mlowicki@gmail.com>
Subject: Re: The future of gitweb - part 2: JavaScript
Date: Thu, 14 Apr 2011 21:30:55 +0200
Message-ID: <BANLkTik1dZ-_DGmj70=-+9j0EsUQZ=BbaQ@mail.gmail.com>
References: <201102142039.59416.jnareb@gmail.com>
	<201104141154.55078.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, John Hawley <warthog9@kernel.org>,
	Kevin Cernekee <cernekee@gmail.com>,
	Petr Baudis <pasky@suse.cz>, Petr Baudis <pasky@ucw.cz>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 14 21:31:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QASFs-0007kM-O0
	for gcvg-git-2@lo.gmane.org; Thu, 14 Apr 2011 21:31:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758011Ab1DNTa6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Apr 2011 15:30:58 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:39326 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757215Ab1DNTa5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Apr 2011 15:30:57 -0400
Received: by yia27 with SMTP id 27so874137yia.19
        for <git@vger.kernel.org>; Thu, 14 Apr 2011 12:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Pq4UG5ITcJv/BlYTtkhV1EhWKj5XMZwSsgsTkQUrqro=;
        b=sm/AZVEYEjhsv2jiSxDDtUvtebkaGjopW1MRGrrG4BYsx566+UF8/bu9SIG5I1yMy3
         KrTI5/LWNyBqH1D9LV1Rgf1Q13He5A4ptJXhI/do3JazPrHxHaRs3CRGo352HP/BYEJZ
         N9KwOgdn/8RQYL0ZZB0R9rjDz9eCXNtMo/Qfw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=v+6Ai05/2NYFpK5xq5QFj8M7/UzDN3qaQa1OMpIbPd8tTE1pqy8gM99zKDYfqqJX/T
         xU+vc+jtkDanNX0UxNflJjOX490WhoZLKP5BwtC1ri3Q4zfe9vBTkymo9+gZFUavSWzp
         Vrm/hemMnKI8R8Hao12AeQ3jMrkJPZELjyRKc=
Received: by 10.42.246.131 with SMTP id ly3mr1589795icb.418.1302809456024;
 Thu, 14 Apr 2011 12:30:56 -0700 (PDT)
Received: by 10.42.222.195 with HTTP; Thu, 14 Apr 2011 12:30:55 -0700 (PDT)
In-Reply-To: <201104141154.55078.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171539>

2011/4/14 Jakub Narebski <jnareb@gmail.com>:
>> Now that we are talking about future of git, including breaking some
>> of backwards compatibility bugs / misdesigns for 1.8.0, perhaps it i=
s
>> the time to discuss long term goals and the future of gitweb.
>
> This is second installment, talking about JavaScript (client-side)
> part of gitweb code.
>
> Recently there were sent to git mailing list a new feature which
> further extended use of JavaScript in gitweb, namely adjusting common
> timezone in which dates are shown:
> =A0http://thread.gmane.org/gmane.comp.version-control.git/169384/focu=
s=3D169881
> =A0http://thread.gmane.org/gmane.comp.version-control.git/171212
>
> It looks like there would be more proposals on (optional) enhancing
> gitweb with JavaScript.
>
> Currently JavaScript is used for the following (optional) features:
> * detecting if javascript is enabled (not a feature per se)
> * incremental blame (Ajax-y, requires server side knowing above)
> * setting local timezone in which dates are shown
>
> Possible other JavaScript-based enhancements include:
> * sorting tables like in Wikipedia, avoiding trip to server
> * MediaWiki-like history view for selecting commits to compare
> =A0(base does not exist yet, and could be used without JavaScript)
>
>
> There was one simple issue that for maintenance and readability it is
> better to have code split into small modules (into separate files),
> while for page performance and interactivity it is better to limit
> number of scripts. =A0This issue can be simply solved by combining
> JavaScript files on build.
>
> There was and is more important issue, namely that in our JavaScript
> we have to abstract or work around differences in web browsers, and
> backport features. =A0This includes:
> * Ajax (generating XmlHttpRequest, handling XHR events)
> * emulating getElementsByClassName if native implementation is absent
> * workaround differences in setting up event handlers by using
> =A0'elem.onevent =3D function () { ... }' etc.
> * manipulating stylesheets (CSS)
>
> Those issues are already solved in __JavaScript libraries__ and
> frameworks, probably better way than in our attempt. =A0Using JavaScr=
ipt
> framework would also give as higher level constructs, and could
> replace what we have and could have in gitweb/static/js/lib:
> * popup menu like the one used to select timezone
> * date parsing and formatting, string formatting
> * handling cookies
>
> Using some JavaScript framework / library could help a lot with
> developing and improving JavaScript part of gitweb code. =A0We would =
no
> longer need to worry so much on how to do it, but could concentrate o=
n
> what to do.
>
> Unfortunately the decision to use JavaScript framework brings its own
> new problems.
>
> First issue is which JavaScript framework or library to use:
> * jQuery (lightweight, most popular, used e.g. by MediaWiki)
> * MooTools (lightweight, 2nd most popular, opbject-oriented)
> * YUI, The Yahoo! User Interface Library
> * other: Prototype, Dojo, ExtJS, SproutCore,...
>
>
> Second issue is how to use it / how to include it:
>
> * Use some external Content Delivery Network (CDN), like
> =A0Google Libraries API
> =A0 =A0 http://code.google.com/apis/libraries/devguide.html
> =A0e.g.:
>
> =A0<script src=3D"https://ajax.googleapis.com/ajax/libs/jquery/1.5.2/=
jquery.min.js"></script>
> =A0<script src=3D"http://code.jquery.com/jquery-1.5.2.min.js"></scrip=
t>
>
> =A0or
>
> =A0<script src=3D"https://ajax.googleapis.com/ajax/libs/mootools/1.3.=
1/mootools-yui-compressed.js"></script>
>
> =A0This is nice solution... if we don't need plugin / extension
> =A0which usually are not available in CDN version of library.
>
> =A0Also this makes gitweb dependent on third-party service, and requi=
re
> =A0network connectivity to Internet to have access to JavaScript-base=
d
> =A0features.
>
> * Mark appropriate JavaScript library as dependency in gitweb/INSTALL
> =A0to be downloaded in appropriate place but do not provide sources.
> =A0Perhaps add target in gitweb/Makefile that automatically downloads
> =A0it.
>
> =A0This would make installing gitweb correctly more complicated.
> =A0JavaScript-based features would not work if somebody instals gitwe=
b
> =A0incorrectly.
>
> =A0I think we can set up gitweb build so that one can configure at
> =A0build stage whether to use CDN or download library, or use
> =A0pre-downloaded (and perhaps instaled somewhere) version of framewo=
rk
> =A0(combining JavaScript on build in all but first case).

I'm not sure about pre-downloaded version of libs. Most of the time
it's not a big deal but sometimes it may introduce hard to detect
issues when someone use different version of the lib -
http://ejohn.org/blog/learning-from-twitter/ .But the idea with
options - CDN or download is very good. CDNs can improve the page
download speed by increasing simultaneous connections if files are
downloaded from many hostnames but for companies where instances of
gitweb are on the Intrantet the 2nd option could be better I think (at
least in my case). Additionaly CDNs can save some money when you pay
for data traffic :)

>
> * Provide copy in git sources (in git.git repository), minified or
> =A0development version or both. =A0This would bloat git repository a =
bit,
> =A0and we would probably want/have to update library at its releases.
>
> =A0 =A0jQuery =A0 =A0 =A0| 24 kB (minified & gzipped), 72 kB (minifie=
d),
> =A0 =A0MooTools =A0 =A0| 25 kB (minified & gzipped), 86 kB (minified)
> =A0 =A0YUI =A0 =A0 =A0 =A0 | 31 kB (library core only)
> =A0 =A0Prototype =A0 | 46-278 kB
> =A0 =A0Dojo =A0 =A0 =A0 =A0| 28 kB (minified & gzipped), 65 kB (minif=
ied)
> =A0 =A0ExtJS =A0 =A0 =A0 | 84-502 kB
>
> =A0Some of those, like MooTools[1] and YUI[2], include dependency
> =A0calculator (library builder) where you can get customized version
> =A0with only relevant/required parts included.
>
> =A0[1]: http://mootools.net/core/ =A0and =A0http://mootools.net/more/
> =A0[2]: http://developer.yahoo.com/yui/3/configurator/
>
> =A0Anyway it could be configurable fallback for other methods; this w=
ay
> =A0we don't have to keep library up to date.
>
> * Instead of including source code or build (minified) version in git
> =A0repository, we could include JavaScript library as a _submodule_.
>
> =A0This of course is possible only if library in question procides
> =A0source repository, and if it uses Git for version control (like
> =A0jQuery, MooTools, YUI or Prototype)... or if we can trust our remo=
te
> =A0helper for SCM in question (hmmm... I thought that jQuery uses
> =A0Subversion, but it moved to Git).
>
> =A0This way you don't need to have it if you don't need it... but on
> =A0the other hand if you need it you have to download (clone) much
> =A0larger development version. =A0Sidenote: I wonder how well shallow
> =A0clone and narrow checkout works with submodules.
>
> =A0And of course we would have to somehow integrate build systems,
> =A0i.e. have git call build system of JavaScript library when buildin=
g
> =A0and installing gitweb.
>
>
> We can check how other projects solve this issue:
>
> * MediaWiki (jQuery)::
>
> =A0 =A0The jQuery file is in /resources/jquery/jquery.js, loaded
> =A0 =A0(and minified) via ResourceLoader since version 1.17
>
> * WordPress (jQuery)::
>
> =A0 =A0jQuery (development version) is in wp-includes/js/jquery/*
> =A0 =A0in wordpress RPM
>
> * Movable Type (jQuery)::
>
> =A0 =A0<script type=3D"text/javascript" src=3D"http://www.google.com/=
jsapi"></script>
> =A0 =A0<script type=3D"text/javascript">google.load("jquery", "1.3.2"=
);</script>
>
> * Ruby on Rails (Prototype)
>
> =A0 =A0jQuery (single file) is in gems/rails-*/html/javascripts/proto=
type.js
> =A0 =A0in rails RPM
>
> There is of course question if theirs approach is good for gitweb...
>
>
> So what are your ideas and comments on the issue of JavaScript code
> and JavaScript libraries / frameworks in gitweb?
> --
> Jakub Narebski
> ShadeHawk on #git
> Poland
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>



--=20
Pozdrawiam,
Micha=B3 =A3owicki
