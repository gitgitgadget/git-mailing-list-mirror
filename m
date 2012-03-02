From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: gitweb: (potential) problems with new installation
Date: Fri, 02 Mar 2012 19:35:56 +0000
Message-ID: <4F51211C.2090201@ramsay1.demon.co.uk>
References: <201202281825.03904.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 02 20:46:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3YRI-0006Yv-Ke
	for gcvg-git-2@plane.gmane.org; Fri, 02 Mar 2012 20:46:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755926Ab2CBTqs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Mar 2012 14:46:48 -0500
Received: from lon1-post-3.mail.demon.net ([195.173.77.150]:33517 "EHLO
	lon1-post-3.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754118Ab2CBTqr (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Mar 2012 14:46:47 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-3.mail.demon.net with esmtp (Exim 4.69)
	id 1S3YRA-00072M-f2; Fri, 02 Mar 2012 19:46:45 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <201202281825.03904.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192065>

Jakub Narebski wrote:
>> First, I should say that I had to modify the script, and move the static
>> directory out of cgi-bin, in order to get it to work.
> 
> You should never have to modify generated gitweb.cgi script; that is what
> configuration file, gitweb_config.perl by default, is for.  It is well
> documented in gitweb.conf(5) manpage, which in turn is referenced in
> gitweb(1) manpage... at least with modern git.

Indeed, but I find "sudo bash; cd /var/www/cgi-bin; vim gitweb.cgi; etc..."
just as easy! :-D

However, ... point taken.

>>                                                       However, this is 
>> not something new; I had to do the same with the previous version. The
>> problem is obviously an apache configuration problem, which I tried to
>> fix last time and (having spent *lots* of effort) gave up on; the main
>> symptom of the problem is that apache attempts to *exec* any file in
>> cgi-bin (e.g. gitweb.css, git-logo.png, git-favicon.png, etc.) which
>> fills up the apache error logs with "permission denied" errors while
>> trying to exec.
> 
> Strange.  Which version of Apache are you using, and how do relevant
> parts of Apache configuration (httpd.conf etc.) look like?

Heh, I only described the above apache config problems (in the spirit of
full disclosure) so that you would not be surprised by certain files not
being in their usual location ... It wasn't a sneeky attempt to get some
apache support! Having said that, my apache version is:

    Apache/2.2.3 (Ubuntu) mod_perl/2.0.2 Perl/v5.8.8 configured

> If you use ScriptAlias directive, or ExecCGI option, then the problem
> might be executable permissions -- Apache shouldn't execute scripts
> without execute permission set as CGI scripts... errr... are you running
> httpd as root?

No, it's running as www-data (well, the initial apache is run as root, but
all worker processes are run as www-data - only the worker processes actually
handle requests, I think).

> You can move to using "AddHandler cgi-script .cgi" instead.

I remember having tried that as well - without success.

>>     1. The new date timezone pop-up; The pop-up window comes up directly
>>        over the date, so you can no longer read it, and once you have set
>>        the desired timezone, it can not be dismissed. (including the x
>>        button on the window). The only way to remove it is to refresh the
>>        page, which makes it a little less that useful ... :-D
> 
> Hmmm... I have tested this code on Mozilla 1.7.12, and on modern at the time
> of writing Firefox, Chrome, IE, and ancient Konqueror without encountering
> any problems.
> 
> Could you at minimum check for JavaScript errors using JavaScript Console
> (clearing it and reloading gitweb page if needed)?  Please provide line
> where error is with a bit of context (around 3 lines).

I don't have a JavaScript Console. (I suppose that is an add-on? Hmm, I don't
have internet access from Linux... ).

> Note also that as workaround you can simply turn off this feature: put
> the following line in gitweb configuration file:
> 
>   $feature{'javascript-timezone'}{'default'} = [];

Thanks. [BTW, if it wasn't clear before, you cannot grab the pop-up and move
it out of the way...]

>>     2. The error console shows a repeated warning about the css file, like
>>        so:
>>
>>            Warning: Error in parsing value for property 'display'.  \
>>            Declaration dropped.
>>            Source File: http://localhost/gitweb/static/gitweb.css
>>            Line: 621

> 
> This is probably caused by the fact that your web browser doesn't
> understand this value of 'display' property because it is too old,
> and does not implement CSS2.1 fully.

Yep, I suspected as much. Not a Problem.

>>        The apache error log looked correct:
>>
>>            [Sun Feb 26 16:50:52 2012] gitweb.cgi: Quantifier follows nothing \
>>            in regex; marked by <-- HERE in m/* <-- HERE git.*\.git/ at \
>>            /var/www/cgi-bin/gitweb.cgi line 3084.
> 
> Hmmm... if we don't use regexp search, then all metacharacters should be
> quoted, including leading '*'.  Strange.

Yes, this happens whether the re checkbox is set or *not*.

> If you did use regexp search, then it is a real issue, and it is not
> something I have thought about.  Your search term
> 
>   *git.*\.git
> 
> is invalid regexp, because '*' quantifier which means zero or more 
> occurrences does not follow any term.  Valid regexp is
> 
>   .*git.*\.git

Indeed, this is the regexp I had intended. (I started with a glob pattern,
noticed the re checkbox, checked it, then went back to edit the search
text, but forgot the initial '*' quantifier)

Thanks.

ATB,
Ramsay Jones
