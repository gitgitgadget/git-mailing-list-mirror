From: "J.H." <warthog9@eaglescrag.net>
Subject: Re: [PATCH 16/18] gitweb: When changing output (STDOUT) change STDERR
 as well
Date: Sat, 11 Dec 2010 21:25:42 -0800
Message-ID: <4D045CD6.9060806@eaglescrag.net>
References: <1291931844-28454-1-git-send-email-warthog9@eaglescrag.net>	<1291931844-28454-17-git-send-email-warthog9@eaglescrag.net> <m3vd32z9yk.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 12 06:24:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PRePq-0005J7-AV
	for gcvg-git-2@lo.gmane.org; Sun, 12 Dec 2010 06:24:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751190Ab0LLFXx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Dec 2010 00:23:53 -0500
Received: from shards.monkeyblade.net ([198.137.202.13]:52898 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750744Ab0LLFXw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Dec 2010 00:23:52 -0500
Received: from voot-cruiser.eaglescrag.net (adsl-70-231-245-44.dsl.snfc21.sbcglobal.net [70.231.245.44])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.4/8.14.3) with ESMTP id oBC5Nn87018491
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
	Sat, 11 Dec 2010 21:23:50 -0800
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.95.3 at shards.monkeyblade.net
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Lightning/1.0b2pre Thunderbird/3.0.10
In-Reply-To: <m3vd32z9yk.fsf@localhost.localdomain>
X-Enigmail-Version: 1.0.1
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.3 (shards.monkeyblade.net [198.137.202.13]); Sat, 11 Dec 2010 21:23:50 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163471>

> Hmm... anuthing that happens after 'use CGI::Carp;' is parsed should
> have STDERR redirected to web server logs, see CGI::Carp manpage
> 
>     [...]
>  
>        use CGI::Carp
> 
>     And the standard warn(), die (), croak(), confess() and carp() calls will
>     automagically be replaced with functions that write out nicely time-stamped
>     messages to the HTTP server error log.
> 
>     [...]
> 
>     REDIRECTING ERROR MESSAGES
> 
>        By default, error messages are sent to STDERR.  Most HTTPD servers direct
>        STDERR to the server's error log.
> 
>     [...]
> 
> Especially the second part.

That was not what I was seeing, so either something I was doing was
horking how CGI::Carp works, or their claim that "most HTTPD server
direct STDERR to the server's error log" is false.

> Could you give us example which causes described misbehaviour?

While I was working on the trapping of the error pages I started getting
500 errors when going to a non-existent sha1.  Running the command from
the cli revealed that a message from a git command was making it out to
the console.  Redirecting STDERR masked the error from git, and stopped
premature data being sent out before the headers were sent.

> I have nothing against this patch: if you have to have it, then you
> have to have it.  I oly try to understand what might be core cause
> behind the issue that this patch is to solve...

I've re-tried this, if you remove this patch and attempt to visit a
non-exist sha1, *boom*

I can only speculate that CGI::Carp only redirects the output inside of
perl, and does not handle the case when called programs (like git) write
more directly to STDERR.

- John 'Warthog9' Hawley
