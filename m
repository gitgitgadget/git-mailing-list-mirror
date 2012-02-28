From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: gitweb: (potential) problems with new installation
Date: Tue, 28 Feb 2012 18:25:03 +0100
Message-ID: <201202281825.03904.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 28 18:25:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2Qnf-0007Or-F0
	for gcvg-git-2@plane.gmane.org; Tue, 28 Feb 2012 18:25:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965456Ab2B1RZJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Feb 2012 12:25:09 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:36356 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964770Ab2B1RZF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Feb 2012 12:25:05 -0500
Received: by eekc41 with SMTP id c41so1258548eek.19
        for <git@vger.kernel.org>; Tue, 28 Feb 2012 09:25:04 -0800 (PST)
Received-SPF: pass (google.com: domain of jnareb@gmail.com designates 10.14.39.6 as permitted sender) client-ip=10.14.39.6;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of jnareb@gmail.com designates 10.14.39.6 as permitted sender) smtp.mail=jnareb@gmail.com; dkim=pass header.i=jnareb@gmail.com
Received: from mr.google.com ([10.14.39.6])
        by 10.14.39.6 with SMTP id c6mr11672954eeb.41.1330449904719 (num_hops = 1);
        Tue, 28 Feb 2012 09:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=content-disposition:from:to:subject:date:user-agent:cc:mime-version
         :content-type:content-transfer-encoding:message-id;
        bh=gyaheoTUyCU4guSL19iH34HCFJDaYAPvpKi2+Uln1qw=;
        b=MSVpHWDQw+eBPmF8t3zJqD574P5EmC3mTCdy/6xTqgTZJoftKPqfJjL+wFOYfVtxqo
         ZCMN8NJQj0yQ5jVmacpaXm8TT4F/Zl+BNUpf03H41Ugvn85mIV7DElblcLAlsgxpEUN1
         rqJPV13WkLDSp+H923stBoAqXhxwwe72TIsK0=
Received: by 10.14.39.6 with SMTP id c6mr8723388eeb.41.1330449904570;
        Tue, 28 Feb 2012 09:25:04 -0800 (PST)
Received: from [192.168.1.13] (abwh28.neoplus.adsl.tpnet.pl. [83.8.231.28])
        by mx.google.com with ESMTPS id y14sm72386857eef.10.2012.02.28.09.25.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 28 Feb 2012 09:25:03 -0800 (PST)
Content-Disposition: inline
User-Agent: KMail/1.9.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191746>

[Cc-ed to git mailing list, again this time without HTML]

On Mon, 27 Feb 2012, Ramsay Jones wrote:
 
> I recently decided to update the gitweb installation on my laptop, since
> it was still running version 1.5.5! (also, the cgit I have installed is
> about the same vintage ...)
> 
> The version of gitweb I installed was, simply because I had just built
> and tested it, the version included in the pu branch as of a couple of
> days ago (commit 8544a26).
> 
> First, I should say that I had to modify the script, and move the static
> directory out of cgi-bin, in order to get it to work.

You should never have to modify generated gitweb.cgi script; that is what
configuration file, gitweb_config.perl by default, is for.  It is well
documented in gitweb.conf(5) manpage, which in turn is referenced in
gitweb(1) manpage... at least with modern git.

Note also that you can specify where to put static files (page 
prerequisites) during "make install"... though that it would not obviate
need to create and edit gitweb configuration file.

>                                                       However, this is 
> not something new; I had to do the same with the previous version. The
> problem is obviously an apache configuration problem, which I tried to
> fix last time and (having spent *lots* of effort) gave up on; the main
> symptom of the problem is that apache attempts to *exec* any file in
> cgi-bin (e.g. gitweb.css, git-logo.png, git-favicon.png, etc.) which
> fills up the apache error logs with "permission denied" errors while
> trying to exec.

Strange.  Which version of Apache are you using, and how do relevant
parts of Apache configuration (httpd.conf etc.) look like?  

If you use ScriptAlias directive, or ExecCGI option, then the problem
might be executable permissions -- Apache shouldn't execute scripts
without execute permission set as CGI scripts... errr... are you running
httpd as root?

You can move to using "AddHandler cgi-script .cgi" instead.

> 
> Anyway, I moved the static directory into a gitweb directory (as a sibling
> to cgi-bin) and changed the paths in gitweb.cgi by prefixing "../gitweb/".
> 
> Now that I had working gitweb, I played with some of the new features and
> noticed a few problems ... I suspect that most of the problems are caused
> by my *old* version of firefox, which is:
> 
>     firefox version 2.0.0.3
> 
>     Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.3) \
>     Gecko/20061201 Firefox/2.0.0.3

I have even older web browser:

      Mozilla 1.7.12

      Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) \
      Gecko/20050923 MultiZilla/1.7.9.0a

> However, I hope the following may be of use; even if only to document a
> version of firefox that is not supported by gitweb. ;-)
> 
>     1. The new date timezone pop-up; The pop-up window comes up directly
>        over the date, so you can no longer read it, and once you have set
>        the desired timezone, it can not be dismissed. (including the x
>        button on the window). The only way to remove it is to refresh the
>        page, which makes it a little less that useful ... :-D

Hmmm... I have tested this code on Mozilla 1.7.12, and on modern at the time
of writing Firefox, Chrome, IE, and ancient Konqueror without encountering
any problems.

Could you at minimum check for JavaScript errors using JavaScript Console
(clearing it and reloading gitweb page if needed)?  Please provide line
where error is with a bit of context (around 3 lines).


Note also that as workaround you can simply turn off this feature: put
the following line in gitweb configuration file:

  $feature{'javascript-timezone'}{'default'} = [];
 
>     2. The error console shows a repeated warning about the css file, like
>        so:
> 
>            Warning: Error in parsing value for property 'display'.  \
>            Declaration dropped.
>            Source File: http://localhost/gitweb/static/gitweb.css
>            Line: 621
> 
>        which corresponds to the following in gitweb.css:
> 
>            div.remote {
> 	       margin: .5em;
> 	       border: 1px solid #d9d8d1;
> 	       display: inline-block;       <-- line 621
>            }

This is probably caused by the fact that your web browser doesn't
understand this value of 'display' property because it is too old,
and does not implement CSS2.1 fully.


  9.2.4 The 'display' property

  inline-block
     This value causes an element to generate an inline-level block
     container. The inside of an inline-block is formatted as a block
     box, and the element itself is formatted as an atomic inline-level
     box.


Nb. this is probably not necessary, gitweb looks just fine without it.

>     3. I mis-typed an search term into the project search box and didn't
>        see the error message displayed by firefox as I expected (maybe
>        incorrectly?). Firefox displayed:
> 
>            XML Parsing Error: xml declaration not at start of external entity
>            Location: http://localhost/cgi-bin/gitweb.cgi?a=project_list&\
>                s=*git.*%5C.git&btnS=Search
>            Line Number 30, Column 1:
>            <?xml version="1.0" encoding="utf-8"?>
>            ^

It is the problem with older Firefoxes, namely that with XHTML DTD and
with application/xhtml+xml mimetype it enters strict XML compliance mode.
If webpage is not well-formed XML it would display XML error page instead.
It is enough that there is some whitespace before <?xml ... ?> processing
instruction... which might make for intermittent and annoying to squash
Heisenbug.

But in some cases it might happen if there are warnings or errors created
by Perl itself and converted to web page by CGI::Carp (fatalsToBrowser).
 
>        The apache error log looked correct:
> 
>            [Sun Feb 26 16:50:52 2012] gitweb.cgi: Quantifier follows nothing \
>            in regex; marked by <-- HERE in m/* <-- HERE git.*\.git/ at \
>            /var/www/cgi-bin/gitweb.cgi line 3084.

Hmmm... if we don't use regexp search, then all metacharacters should be
quoted, including leading '*'.  Strange.

If you did use regexp search, then it is a real issue, and it is not
something I have thought about.  Your search term

  *git.*\.git

is invalid regexp, because '*' quantifier which means zero or more 
occurrences does not follow any term.  Valid regexp is

  .*git.*\.git

or just

  git.*\.git

Gitweb should probably check that regexp is valid before using it.
Thanks for reporting this; I'll try to fix it shortly.

>        Whereas the page source did look wrong. Just in case it would be of
>        use, I have included the page source below.

Thanks.

Damn, I thought that I have that issue squashed!  The problem is when
there is error thrown or warning triggered when gitweb already printed
part of page.  The error handler then writes error page from beginning
inside existing page... not good.

I'll try to look at this.

> As I said above, I suspect these problems are caused by my relatively old
> Linux installation (I keep meaning to get around to updating, but I must
> say that I don't like the new Ubuntu, although Linux Mint 12 looks quite
> good ...).
> 
> Having said that, ignoring the new features, gitweb is working fine for
> me (I only installed it in the first place to test it out ...). Also, the
> above represents (literally) only ten minutes of playing around with the
> new features, without having read any documentation or code. So, if I have
> mis-understood how something should work, then sorry for the noise! :(
> 
> Hope this helps.
> 
> ATB,
> Ramsay Jones

[cut example HTML output]

-- 
Jakub Narebski
Poland
