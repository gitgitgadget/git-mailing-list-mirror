From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: gitweb: (potential) problems with new installation
Date: Mon, 05 Mar 2012 19:39:48 +0000
Message-ID: <4F551684.8020701@ramsay1.demon.co.uk>
References: <201202281825.03904.jnareb@gmail.com> <4F51211C.2090201@ramsay1.demon.co.uk> <201203030055.34912.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 05 20:42:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4dny-00078R-PE
	for gcvg-git-2@plane.gmane.org; Mon, 05 Mar 2012 20:42:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757434Ab2CETmi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Mar 2012 14:42:38 -0500
Received: from anchor-post-1.mail.demon.net ([195.173.77.132]:47125 "EHLO
	anchor-post-1.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751563Ab2CETmg (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Mar 2012 14:42:36 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-1.mail.demon.net with esmtp (Exim 4.69)
	id 1S4dnm-0003Fl-iq; Mon, 05 Mar 2012 19:42:35 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <201203030055.34912.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192268>

Jakub Narebski wrote:
> Do you use CGI (mod_cgi or mod_cgid), or mod_perl?

mod_cgid although mod_perl is also available (and *is* used by git-instaweb).

>>> You can move to using "AddHandler cgi-script .cgi" instead.
>> I remember having tried that as well - without success.
> 
> This must be done _instead_ of ScriptAlias directive and/or ExecCGI option.

Indeed :-D

I had another quick look at this and (I now remember) the AddHandler approach
actually *did* work. However, I already had some other (perl, shell) scripts
in cgi-bin and would have had to add file extensions ('.pl' or '.sh') in order
for them to keep working.

The relevant part of httpd.conf looks like this:

<Directory /var/www/>
        Options Indexes FollowSymLinks MultiViews
        AllowOverride None
        Order allow,deny
        allow from all
        # This directive allows us to have apache2's default start page
        # in /apache2-default/, but still have / go to the right place
        #RedirectMatch ^/$ /apache2-default/
</Directory>

ScriptAlias /cgi-bin/ /var/www/cgi-bin/
<Directory "/var/www/cgi-bin">
       Options +ExecCGI
</Directory>
<Directory "/var/www/cgi-bin/static">
       Options -ExecCGI
</Directory>

#<Directory "/var/www/cgi-bin">
#        Options +ExecCGI
#        AddHandler cgi-script .cgi .pl .sh
#</Directory>

Note that the "/var/www/cgi-bin/static" directory entry *should* have solved
the problem, but it does not make any difference at all!

BTW, the error.log entries look like:

[Sun Mar 04 15:06:03 2012] [error] (13)Permission denied: exec of '/var/www/cgi-bin/static/gitweb.css' failed
[Sun Mar 04 15:06:03 2012] [error] [client 127.0.0.1] Premature end of script headers: gitweb.css, referer: http://localhost/cgi-bin/gitweb.cgi

with similar entries for git-logo.png and gitweb.js. The access log show
"500 Internal Server error" responses for gitweb.css, git-logo.png and gitweb.js.

Maybe I should re-visit the decision and swap over to using the AddHadler
approach - adding file extensions is not that hard! ;-)

Anyway, the above should work as-is, and I'm somewhat puzzled that it doesn't.
However, as I said before, it's not a gitweb fault.

>>> Could you at minimum check for JavaScript errors using JavaScript Console
>>> (clearing it and reloading gitweb page if needed)?  Please provide line
>>> where error is with a bit of context (around 3 lines).
>> I don't have a JavaScript Console. (I suppose that is an add-on? Hmm, I don't
>> have internet access from Linux... ).
> 
> JavaScript Console is built in, though there are plugins like Console^2
> that extend it.
> 
> In Mozilla 1.7.12 it is "Tools > Web Development > JavaScript Console"
> It is "Tools > Errors Console" or "Tools > Web Console" in modern Firefox.

Ah, OK. I thought you meant something other than the "Error Console".
In that case, *no* javascript errors appear in the error console.

ATB,
Ramsay Jones
