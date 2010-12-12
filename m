From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 16/18] gitweb: When changing output (STDOUT) change STDERR as well
Date: Sun, 12 Dec 2010 16:17:04 +0100
Message-ID: <201012121617.04997.jnareb@gmail.com>
References: <1291931844-28454-1-git-send-email-warthog9@eaglescrag.net> <m3vd32z9yk.fsf@localhost.localdomain> <4D045CD6.9060806@eaglescrag.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "J.H." <warthog9@eaglescrag.net>
X-From: git-owner@vger.kernel.org Sun Dec 12 16:17:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PRngR-0001fp-U8
	for gcvg-git-2@lo.gmane.org; Sun, 12 Dec 2010 16:17:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753239Ab0LLPRS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Dec 2010 10:17:18 -0500
Received: from mail-bw0-f45.google.com ([209.85.214.45]:56359 "EHLO
	mail-bw0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753146Ab0LLPRO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Dec 2010 10:17:14 -0500
Received: by bwz16 with SMTP id 16so5773960bwz.4
        for <git@vger.kernel.org>; Sun, 12 Dec 2010 07:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=PKh1+lmJ+bxMQZR5iPkiC5IjWdXpXrylzZi8MQh/fPQ=;
        b=BJoPxVYyzi/x30AD9ypDDKR8ecwf2GHVN6vulyvhb++awXA+VqG900sGonknz+61Sf
         0nyfDGo+FSDzHRef43Cmw/53QAdPOAb1kBfdyg8fEQ/Xm/TJmOHJSLVX0xpTr35YLrU5
         6hZKXl/Z7aD2U2WrYpCrSdMXwxXn/kzORJTK8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=b3no7qTw4M095DVqXMkiek8fVvs2rpoe/eLbz/Qsho3kUtIoy7Pl9hOkZOaAs0YCA/
         zrjTJ2WurYAjzMsYwgMaWNz2x/JojwpkPXk3j27toSdW/BlVpZALGjhJUInK/9hBZ1lU
         dVq4zsSbBovWFhvCmmG2My6B4XeMf1cLfNbnA=
Received: by 10.204.85.90 with SMTP id n26mr809432bkl.164.1292167030519;
        Sun, 12 Dec 2010 07:17:10 -0800 (PST)
Received: from [192.168.1.13] (abve32.neoplus.adsl.tpnet.pl [83.8.202.32])
        by mx.google.com with ESMTPS id v1sm2569356bkt.17.2010.12.12.07.17.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 12 Dec 2010 07:17:08 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <4D045CD6.9060806@eaglescrag.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163483>

On Sun, 12 Dec 2010, J.H. wrote:

> > Hmm... anuthing that happens after 'use CGI::Carp;' is parsed should
> > have STDERR redirected to web server logs, see CGI::Carp manpage
> > 
> >     [...]
> >  
> >        use CGI::Carp
> > 
> >     And the standard warn(), die (), croak(), confess() and carp() calls will
> >     automagically be replaced with functions that write out nicely time-stamped
> >     messages to the HTTP server error log.
> > 
> >     [...]
> > 
> >     REDIRECTING ERROR MESSAGES
> > 
> >        By default, error messages are sent to STDERR.  Most HTTPD servers direct
> >        STDERR to the server's error log.
> > 
> >     [...]
> > 
> > Especially the second part.
> 
> That was not what I was seeing, so either something I was doing was
> horking how CGI::Carp works, or their claim that "most HTTPD server
> direct STDERR to the server's error log" is false.
> 
> > Could you give us example which causes described misbehaviour?
> 
> While I was working on the trapping of the error pages I started getting
> 500 errors when going to a non-existent sha1.  Running the command from
> the cli revealed that a message from a git command was making it out to
> the console.  Redirecting STDERR masked the error from git, and stopped
> premature data being sent out before the headers were sent.

Generally if something worked, and stopped working, don't you think
that you should concentrate on fixing your code, and not papering
over the issue?


The fact that "Running the command from the cli revealed that a message
from a git command was making it out to the console." doesn't mean
anything, because when running gitweb from commandline both stdout
and stderr are redirected to terminal, by default.  So you should
worry only if there is premature data being sent to standard output,
with standard error redirected to /dev/null (2>/dev/null).

What CGI::Carp does is (re)define 'die' and 'warn' to support
fatalsToBrowser and warningsToBrowser, and to add timestamp and other
auxiliary information: in the end 'die' calls 'CORE::die', and 'warn'
calls 'CORE::warn' - both of which write to STDERR.  This means that
warnings from git commands sent to standard error do not get timestamp
appended.  Note that standard output from git commands run by gitweb
is always captured.
 
> > I have nothing against this patch: if you have to have it, then you
> > have to have it.  I oly try to understand what might be core cause
> > behind the issue that this patch is to solve...
> 
> I've re-tried this, if you remove this patch and attempt to visit a
> non-exist sha1, *boom*
> 
> I can only speculate that CGI::Carp only redirects the output inside of
> perl, and does not handle the case when called programs (like git) write
> more directly to STDERR.

CGI::Carp doesn't redirect output: it adds timestamp and prints it to
STDERR (unless one use 'carpout') to the result of 'die' and 'warn' calls.

*Without your series* when I visit non-existing sha1, or non-existing
file I get correctly 404 error from gitweb.  So you have borked something.

The CGI standard (http://tools.ietf.org/html/rfc3875) doesn't talk about
'standard error' stream at all; on the other hand it talks only about
'standard input' and 'standard output'.  I have checked with simple CGI
script in Perl, that neither using die or warn (both before any HTTP 
headers are send), neither with plain CGI or with mod_perl 
(ModPerl::Registry), with CGI::Carp I never get the error you see.
Without CGI::Carp I get '500 Internal Server Error' instead of nicer
one formatted by CGI::Carp, but I don't get it even without CGI::Carp
with 'warn' and printing to STDERR directly.

The standard error stream either gets discarded (mod_cgid), or is
written to /var/log/httpd/error_log (mod_perl).

-- 
Jakub Narebski
Poland
