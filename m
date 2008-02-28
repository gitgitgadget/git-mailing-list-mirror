From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: [PATCH 02/40] Compile some programs only conditionally.
Date: Thu, 28 Feb 2008 21:30:10 +0100
Message-ID: <200802282130.10225.johannes.sixt@telecom.at>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at> <1204138503-6126-3-git-send-email-johannes.sixt@telecom.at> <alpine.LSU.1.00.0802281146050.22527@racer.site>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 28 21:31:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUpP2-0002wV-CS
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 21:30:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752195AbYB1UaP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 15:30:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751888AbYB1UaO
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 15:30:14 -0500
Received: from smtp4.srv.eunet.at ([193.154.160.226]:58367 "EHLO
	smtp4.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751434AbYB1UaM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 15:30:12 -0500
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp4.srv.eunet.at (Postfix) with ESMTP id A245F972E9;
	Thu, 28 Feb 2008 21:30:10 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 6C2EB5B9E3;
	Thu, 28 Feb 2008 21:30:10 +0100 (CET)
User-Agent: KMail/1.9.3
In-Reply-To: <alpine.LSU.1.00.0802281146050.22527@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75443>

On Thursday 28 February 2008 12:57, Johannes Schindelin wrote:
> Hi,
>
> On Wed, 27 Feb 2008, Johannes Sixt wrote:
> > On MinGW, we won't compile some programs.
>
> This explanation is good (even if I recall that we compile git-daemon.exe
> just fine now).
>
> > @@ -264,7 +263,7 @@ PROGRAMS = \
> >  	git-update-server-info$X \
> >  	git-upload-pack$X \
> >  	git-pack-redundant$X git-var$X \
> > -	git-merge-tree$X git-imap-send$X \
> > +	git-merge-tree$X \
>
> We do not compile git-imap-send because MinGW lacks socketpair() and
> getpass().  Why not say it explicitely, and have a NO_SOCKETPAIR variable?
> Likewise, for git-daemon we should say NO_SYSLOG.

Where are NO_WNOHANG, NO_GETPASS, NO_SELECT, NO_SIGCHLD, NO_EXECVE etc in your 
list? A condition on MINGW32 is certainly sufficient.

> > +ifndef NO_EXTRA_PROGRAMS
>
> The name NO_EXTRA_PROGRAMS is definitely not illustrating the reasons why
> we exclude those programs, so I'd rather not have this patch as-is.

I agree.

> NOTE: I think that both programs are fixable, but only git-daemon is
> important enough that I would like to see patch of the "daemon" branch in
> 4msysgit.git cherry picked into this series (maybe we should implement a
> compat/syslog.c using the ReportEvent() function of the win32 API?).

openlog() etc. is only one problem in git-daemon. It also depends on SIGCHLD, 
a non-blocking waitpid, and a lot more. The patch that is in 4msysgit.git 
allows only a single connection, IIRC, after which it terminates. But I also 
think that git-daemon can be made more complete on Windows, but it certainly 
requires a major surgery.

-- Hannes
