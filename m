From: Boyd Lynn Gerber <gerberb@zenez.com>
Subject: Re: [PATCH] 0003 This patch is to allow 12 different OS's to compile
 and run git.
Date: Fri, 6 Jun 2008 20:40:34 -0600
Message-ID: <Pine.LNX.4.64.0806062015440.18454@xenau.zenez.com>
References: <Pine.LNX.4.64.0806061330180.18454@xenau.zenez.com>
 <87bq2ez72u.fsf@jeremyms.com> <Pine.LNX.4.64.0806061359080.18454@xenau.zenez.com>
 <7vmylyrwkg.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0806061718420.18454@xenau.zenez.com>
 <Pine.LNX.4.64.0806061822220.18454@xenau.zenez.com>
 <alpine.LNX.1.00.0806062043350.19665@iabervon.org>
 <Pine.LNX.4.64.0806061922290.18454@xenau.zenez.com> <7vzlpyouwf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Thomas Harning <harningt@gmail.com>,
	Jeremy Maitin-Shepard <jbms@cmu.edu>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 07 04:41:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4oMz-0006yC-Mv
	for gcvg-git-2@gmane.org; Sat, 07 Jun 2008 04:41:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752989AbYFGCkg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 22:40:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752651AbYFGCkg
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 22:40:36 -0400
Received: from zenez.com ([166.70.62.2]:12106 "EHLO xenau.zenez.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752071AbYFGCkg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 22:40:36 -0400
Received: by xenau.zenez.com (Postfix, from userid 1000)
	id E6BBAE5316; Fri,  6 Jun 2008 20:40:34 -0600 (MDT)
Received: from localhost (localhost [127.0.0.1])
	by xenau.zenez.com (Postfix) with ESMTP id B4CF7E5315;
	Fri,  6 Jun 2008 20:40:34 -0600 (MDT)
In-Reply-To: <7vzlpyouwf.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84168>

On Fri, 6 Jun 2008, Junio C Hamano wrote:
> Boyd Lynn Gerber <gerberb@zenez.com> writes:
> I guess the patch text itself seems to be getting reasonable, and perhaps
> the next few rounds would be to fix the commit log message ;-)

I have it the same, without all the >> as I first posted, but I agree. 
that it needs some tweaking.
 
> > diff --git a/Makefile b/Makefile
> > index cce5a6e..000bf1f 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -165,6 +165,11 @@ uname_P := $(shell sh -c 'uname -p 2>/dev/null || echo not')
> >  # CFLAGS and LDFLAGS are for the users to override from the command line.
> >  
> >  CFLAGS = -g -O2 -Wall
> > +ifeq ($(uname_S),SCO_SV)
> > +	ifeq ($(uname_R),3.2)
> > +		CFLAGS = -O2
> > +	endif
> > +endif
> 
> What makes SCO_SV so special that this platform specific tweak does not
> live in "Platform specific tweaks" section like others?
> 
> CFLAGS is for the user to oerride from the command line, and I do not very
> much like any tweaks in Makefile.  I'd suggest dropping this hunk.
> 
> > @@ -564,6 +569,42 @@ endif
> >  ifeq ($(uname_S),GNU/kFreeBSD)
> >  	NO_STRLCPY = YesPlease
> >  endif
> > +ifeq ($(uname_S),UnixWare)
> > +	CC=cc
> 
> s/=/ = /; you have similar one elsewhere.

I only have the one section now.  I will look at it some more.

> > +	NEEDS_SOCKET = YesPlease
> > +	NEEDS_NSL = YesPlease
> > +	NEEDS_SSL_WITH_CRYPTO = YesPlease
> > +	NEEDS_LIBICONV = YesPlease
> > +	SHELL_PATH = /usr/local/bin/bash
> > +	NO_IPV6 = YesPlease
> > +	NO_HSTRERROR = YesPlease
> > +	BASIC_CFLAGS +=  -Kalloca -Kthread
> 
> I am only guessing what -Kalloca is, but is it for alloca(3), and if so do
> you still need it?

I will make tests without it on the next run.  It takes about 3 hours for 
me to get the patches to all the system review them and then run 
everything.  Some of the machines are really slow.

> > diff --git a/git-compat-util.h b/git-compat-util.h
> > index 01c4045..b3cd7b3 100644
> > --- a/git-compat-util.h
> > +++ b/git-compat-util.h
> > @@ -39,7 +39,12 @@
> >  /* Approximation of the length of the decimal representation of this type. */
> >  #define decimal_length(x)	((int)(sizeof(x) * 2.56 + 0.5) + 1)
> >  
> > -#if !defined(__APPLE__) && !defined(__FreeBSD__)
> > +/* Added for __USLC__ for any Novell devrived Compiler and Some Sys V 
> > +   Added _M_UNIX for any XENIX/SCO UNIX/OpenServer less than or equal
> > +   OpenServer 5.0.7  This is do avoided compiler hell like the other
> > +   OS's __APPLE__ and __FreeBSD__ */
> 
> We generally do not do changelog inside the code comment.

Where do you put your change log stuff, to explain why you made the 
change.  Maybe it is a bit left over from doing things for MySQL AB.

> > +#if !defined(__APPLE__) && !defined(__FreeBSD__)  && !defined(__USLC__) && !de
> > +fined(_M_UNIX)
> 
> Linewrapped patch?  It is very curious that you have + in front of "fined(_M_UNIX)".

It is not line wrapped in my file.  I do the following after reverting 
every and strarting with a clean slate.

 cp -p .new/* . 
 git add Makefile git-compat-util.h progress.c
 git diff --cached
 git commit -s
 git format-patch -p -M -B origin

The last command above is creating the line wrapped because the line is so 
long.  I do not know enough to force the tools to not do that line wrap. 

--
Boyd Gerber <gerberb@zenez.com>
ZENEZ	1042 East Fort Union #135, Midvale Utah  84047
