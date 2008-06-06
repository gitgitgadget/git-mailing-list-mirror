From: Boyd Lynn Gerber <gerberb@zenez.com>
Subject: Re: [PATCH] This patch is to allow 12 different OS's to compile and
 run git.
Date: Fri, 6 Jun 2008 17:17:59 -0600
Message-ID: <Pine.LNX.4.64.0806061702240.18454@xenau.zenez.com>
References: <Pine.LNX.4.64.0806061330180.18454@xenau.zenez.com>
 <alpine.LNX.1.00.0806061835430.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git List <git@vger.kernel.org>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sat Jun 07 01:19:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4lD8-0000Eq-0D
	for gcvg-git-2@gmane.org; Sat, 07 Jun 2008 01:19:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752218AbYFFXSD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 19:18:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760760AbYFFXSB
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 19:18:01 -0400
Received: from zenez.com ([166.70.62.2]:19612 "EHLO xenau.zenez.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751908AbYFFXSA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 19:18:00 -0400
Received: by xenau.zenez.com (Postfix, from userid 1000)
	id 4E50FE5118; Fri,  6 Jun 2008 17:17:59 -0600 (MDT)
Received: from localhost (localhost [127.0.0.1])
	by xenau.zenez.com (Postfix) with ESMTP id 3FC4FE50DB;
	Fri,  6 Jun 2008 17:17:59 -0600 (MDT)
In-Reply-To: <alpine.LNX.1.00.0806061835430.19665@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84137>

On Fri, 6 Jun 2008, Daniel Barkalow wrote:
> On Fri, 6 Jun 2008, Boyd Lynn Gerber wrote:
> > This patch has patches to
> > 
> > Makefile
> > git-compat-util.h
> > progress.c
...
> > diff --git a/Makefile b/Makefile
> > index cce5a6e..6df008a 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -165,6 +165,20 @@ uname_P := $(shell sh -c 'uname -p 2>/dev/null || echo not')
> >  # CFLAGS and LDFLAGS are for the users to override from the command line.
> >  
> >  CFLAGS = -g -O2 -Wall
> > +ifeq ($(uname_S),SCO_SV)
> > +  ifeq ($(uname_R),3.2)
> > +#    CFLAGS = -g -O2
> > +    CFLAGS = -g
> > +  endif
> > +  ifeq ($(uname_R),5)
> > +    CFLAGS = -g -O2 -Wall
> > +#    CFLAGS = -g -O2
> > +  endif
> > +endif
> > +ifeq ($(uname_S),UnixWare)
> > +    CFLAGS = -g -O2 -Wall
> > +#    CFLAGS = -g -O2
> > +endif
> 
> Might be better to have something for CFLAGS to filter out. Also, as a 
> general rule, remove old lines instead of commentting them out. If we want 
> to undo a change, we can get it out of the version control. :) (More of 
> these below)
> 
> Also, only the SCO_SV 3.2 one actually does anything here, right?

SCO has SCO_SV defined for all OpenServer/SCO Unix/XENIX Versions from 
about 1983/4.  My memory is a bit fogey on the exact first Release of 
XENIX.  The problem is that with OpenServer 6 you have to use the UnixWare 
stuff.  OpenServer 6 is a highly modified Unixware 7.1.4, but changed for 
98 % of the OpenServer 5 stuff.  I am running XENIX binaries from the mid 
to late 80's on it.  So you have to do some really strange things because 
of it.  I had git working on SCO UNIX 3.2v4.2/Open Server/ODT 3.0.  I have 
to use gcc and FSU-threads for threads.  FSU-threads is a user threads. 

> Probably ought to make this conditional on a flag that says that "cc" 
> works and "gcc" isn't better; there are a lot of systems, IIRC, where "cc" 
> is a lousy vendor compiler (unless you bought the expensive vendor 
> compiler) and "gcc" is the modern working compiler that everybody has 
> installed.
> 
> >  AR = ar
> >  RM = rm -f
> >  TAR = tar
> > @@ -564,6 +579,42 @@ endif
> >  ifeq ($(uname_S),GNU/kFreeBSD)
> >  	NO_STRLCPY = YesPlease
> >  endif
> > +ifeq ($(uname_S),UnixWare)
> > +	NEEDS_SOCKET = YesPlease
> > +#	NEEDS_NSL = YesPlease
> > +	NEEDS_SSL_WITH_CRYPTO = YesPlease
> > +	NEEDS_LIBICONV = YesPlease
> > +	SHELL_PATH = /usr/local/bin/bash
> > +	NO_IPV6 = YesPlease
> > +	NO_HSTRERROR = YesPlease
> > +#	BASIC_CFLAGS +=  -E -H
> > +	BASIC_CFLAGS +=  -Kalloca -Kthread
> > +	BASIC_CFLAGS += -I/usr/local/include
> > +	BASIC_LDFLAGS += -L/usr/local/lib
> > +	INSTALL = ginstall
> > +	TAR = gtar
> > +	NO_STRCASESTR = YesPlease
> > +	NO_MEMMEM = YesPlease
> > +endif
> > +ifeq ($(uname_S),SCO_SV)
> > +	NEEDS_SOCKET = YesPlease
> > +#	NEEDS_NSL = YesPlease
> > +	NEEDS_SSL_WITH_CRYPTO = YesPlease
> > +	NEEDS_LIBICONV = YesPlease
> > +	SHELL_PATH = /usr/bin/bash
> > +	NO_IPV6 = YesPlease
> > +#	NO_HSTRERROR = YesPlease
> > +#	BASIC_CFLAGS +=  -E -H
> > +      ifeq ($(uname_R),5)
> > +	BASIC_CFLAGS +=  -Kalloca -Kthread
> > +      endif
> > +#	BASIC_CFLAGS += -I/usr/local/include
> > +#	BASIC_LDFLAGS += -L/usr/local/lib
> > +	NO_STRCASESTR = YesPlease
> > +	NO_MEMMEM = YesPlease
> > +	INSTALL = ginstall
> > +	TAR = gtar
> > +endif
> >  ifeq ($(uname_S),Darwin)
> >  	NEEDS_SSL_WITH_CRYPTO = YesPlease
> >  	NEEDS_LIBICONV = YesPlease
> > diff --git a/git-compat-util.h b/git-compat-util.h
> > index 01c4045..b57041c 100644
> > --- a/git-compat-util.h
> > +++ b/git-compat-util.h
> > @@ -39,7 +39,7 @@
> >  /* Approximation of the length of the decimal representation of this type. */
> >  #define decimal_length(x)	((int)(sizeof(x) * 2.56 + 0.5) + 1)
> >  
> > -#if !defined(__APPLE__) && !defined(__FreeBSD__)
> > +#if !defined(__APPLE__) && !defined(__FreeBSD__ ) && !defined(__USLC__) && !defined(_M_UNIX)
> >  #define _XOPEN_SOURCE 600 /* glibc2 and AIX 5.3L need 500, OpenBSD needs 600 for S_ISLNK() */
> >  #define _XOPEN_SOURCE_EXTENDED 1 /* AIX 5.3L needs this */
> >  #endif
> > @@ -89,6 +89,10 @@
> >  #include <grp.h>
> >  #define _ALL_SOURCE 1
> >  #endif
> > +#if defined(__USLC__)
> > +#undef _XOPEN_SOURCE
> > +#include <grp.h>
> > +#endif
> 
> Didn't you avoid defining _XOPEN_SOURCE in this case?

Yes, I have to not have any _XOPEN_SOURCE because it ommits many defines 
that are needed by git.  I was using the -E trying to track things down.  
The only option to get everything defined because of the masking was to 
remove it.  I have the same problems on the other OS.  This is need for 
any SCO OS from Open Desktop 3 and XENIX to the three SCO support OS's.  
OpenServer 5.0.7, UnixWare 7.1.4 and OpenServer 6.  Only the last two have 
large file system and kernel threads.  There are a couple other OS's that 
Novel provided code that uses the USLC.  As it is from the orignal UNIX 
Group that Novell form when they purchase UNIX.  So any UNIX from this 
source that uses the Novell OS compiler's needs it.

> >  
> >  #ifndef NO_ICONV
> >  #include <iconv.h>
> > @@ -206,12 +210,15 @@ void *gitmemmem(const void *haystack, size_t haystacklen,
> >  #endif
> >  
> >  #ifdef FREAD_READS_DIRECTORIES
> > +#if !defined (__USLC__)
> 
> Can't you not define FREAD_READS_DIRECTORIES?

Removed see new patch that was posted.

> This seems wrong; it looks like you've added more #endifs than #ifs.

Changed in the new patch that was submitted.
 
  
> >  #ifdef SNPRINTF_RETURNS_BOGUS
> >  #define snprintf git_snprintf
> > diff --git a/progress.c b/progress.c
> > index d19f80c..11a0841 100644
> > --- a/progress.c
> > +++ b/progress.c
> > @@ -241,7 +241,8 @@ void stop_progress_msg(struct progress **p_progress, const char *msg)
> >  	*p_progress = NULL;
> >  	if (progress->last_value != -1) {
> >  		/* Force the last update */
> > -		char buf[strlen(msg) + 5];
> > +		/* char buf[strlen(msg) + 5]; */
> > +		char *buf = malloc (strlen(msg) + 5 );
> 
> Do we really have exactly one use of this pattern? I thought we either did 
> it more or excluded it by policy. Aside from not leaking the memory and 
> not leaving the old version in a comment, it's probably the right change.

I only could find the one usuage.  I am now using alloca.
 
> Incidentally, you might want to look into "sparse", and getting them have 
> an optional warning for code like this that might not be supported by some 
> compilers the project wants to support but doesn't actually use for 
> development regularly.

I am, trying to understand it right now.

Thanks,

--
Boyd Gerber <gerberb@zenez.com>
ZENEZ	1042 East Fort Union #135, Midvale Utah  84047
