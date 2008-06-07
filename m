From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] 0003 This patch is to allow 12 different OS's to compile
 and run git.
Date: Fri, 6 Jun 2008 23:40:01 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0806062316270.19665@iabervon.org>
References: <Pine.LNX.4.64.0806061330180.18454@xenau.zenez.com> <87bq2ez72u.fsf@jeremyms.com> <Pine.LNX.4.64.0806061359080.18454@xenau.zenez.com> <7vmylyrwkg.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0806061718420.18454@xenau.zenez.com>
 <Pine.LNX.4.64.0806061822220.18454@xenau.zenez.com> <alpine.LNX.1.00.0806062043350.19665@iabervon.org> <Pine.LNX.4.64.0806061922290.18454@xenau.zenez.com> <7vzlpyouwf.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0806062015440.18454@xenau.zenez.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Harning <harningt@gmail.com>,
	Jeremy Maitin-Shepard <jbms@cmu.edu>,
	Git List <git@vger.kernel.org>
To: Boyd Lynn Gerber <gerberb@zenez.com>
X-From: git-owner@vger.kernel.org Sat Jun 07 05:41:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4pIl-0000aw-FN
	for gcvg-git-2@gmane.org; Sat, 07 Jun 2008 05:41:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753601AbYFGDkH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 23:40:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751909AbYFGDkG
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 23:40:06 -0400
Received: from iabervon.org ([66.92.72.58]:48642 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752991AbYFGDkE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 23:40:04 -0400
Received: (qmail 9279 invoked by uid 1000); 7 Jun 2008 03:40:01 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 7 Jun 2008 03:40:01 -0000
In-Reply-To: <Pine.LNX.4.64.0806062015440.18454@xenau.zenez.com>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84170>

On Fri, 6 Jun 2008, Boyd Lynn Gerber wrote:

> On Fri, 6 Jun 2008, Junio C Hamano wrote:
> > Boyd Lynn Gerber <gerberb@zenez.com> writes:
> > I guess the patch text itself seems to be getting reasonable, and perhaps
> > the next few rounds would be to fix the commit log message ;-)
> 
> I have it the same, without all the >> as I first posted, but I agree. 
> that it needs some tweaking.
>  
> > > diff --git a/Makefile b/Makefile
> > > index cce5a6e..000bf1f 100644
> > > --- a/Makefile
> > > +++ b/Makefile
> > > @@ -165,6 +165,11 @@ uname_P := $(shell sh -c 'uname -p 2>/dev/null || echo not')
> > >  # CFLAGS and LDFLAGS are for the users to override from the command line.
> > >  
> > >  CFLAGS = -g -O2 -Wall
> > > +ifeq ($(uname_S),SCO_SV)
> > > +	ifeq ($(uname_R),3.2)
> > > +		CFLAGS = -O2
> > > +	endif
> > > +endif
> > 
> > What makes SCO_SV so special that this platform specific tweak does not
> > live in "Platform specific tweaks" section like others?
> > 
> > CFLAGS is for the user to oerride from the command line, and I do not very
> > much like any tweaks in Makefile.  I'd suggest dropping this hunk.
> > 
> > > @@ -564,6 +569,42 @@ endif
> > >  ifeq ($(uname_S),GNU/kFreeBSD)
> > >  	NO_STRLCPY = YesPlease
> > >  endif
> > > +ifeq ($(uname_S),UnixWare)
> > > +	CC=cc
> > 
> > s/=/ = /; you have similar one elsewhere.
> 
> I only have the one section now.  I will look at it some more.
> 
> > > +	NEEDS_SOCKET = YesPlease
> > > +	NEEDS_NSL = YesPlease
> > > +	NEEDS_SSL_WITH_CRYPTO = YesPlease
> > > +	NEEDS_LIBICONV = YesPlease
> > > +	SHELL_PATH = /usr/local/bin/bash
> > > +	NO_IPV6 = YesPlease
> > > +	NO_HSTRERROR = YesPlease
> > > +	BASIC_CFLAGS +=  -Kalloca -Kthread
> > 
> > I am only guessing what -Kalloca is, but is it for alloca(3), and if so do
> > you still need it?
> 
> I will make tests without it on the next run.  It takes about 3 hours for 
> me to get the patches to all the system review them and then run 
> everything.  Some of the machines are really slow.
> 
> > > diff --git a/git-compat-util.h b/git-compat-util.h
> > > index 01c4045..b3cd7b3 100644
> > > --- a/git-compat-util.h
> > > +++ b/git-compat-util.h
> > > @@ -39,7 +39,12 @@
> > >  /* Approximation of the length of the decimal representation of this type. */
> > >  #define decimal_length(x)	((int)(sizeof(x) * 2.56 + 0.5) + 1)
> > >  
> > > -#if !defined(__APPLE__) && !defined(__FreeBSD__)
> > > +/* Added for __USLC__ for any Novell devrived Compiler and Some Sys V 
> > > +   Added _M_UNIX for any XENIX/SCO UNIX/OpenServer less than or equal
> > > +   OpenServer 5.0.7  This is do avoided compiler hell like the other
> > > +   OS's __APPLE__ and __FreeBSD__ */
> > 
> > We generally do not do changelog inside the code comment.
> 
> Where do you put your change log stuff, to explain why you made the 
> change.  Maybe it is a bit left over from doing things for MySQL AB.

In the commit message. That is, if your commit message goes:

  Allow more systems to build git

  __USLC__ indicates a Novell-derived compiler or some SysV
  __M_UNIX indicates XENIX/SCO UNIX/OpenServer before 5.0.7
  Like Apple and BSD, both of these shouldn't have _XOPEN_SOURCE defined

then an interested user can use "git blame" on the file, and then read 
that info in the commit message for the commit that introduced those 
lines.

Also on the commit message: you should put the list of affected files 
after a line with just "---", so it appears in the patch but not in the 
commit; if we want to find out what the commit affects, we can use "git 
log --stat" and find out for sure. The explanation of the sign-off can 
probably go after the "---", too, although the "Signed-off-by" line should 
be above it.

	-Daniel
*This .sig left intentionally blank*
