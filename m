From: Petr Baudis <pasky@suse.cz>
Subject: Re: PPC SHA-1 Updates in "pu"
Date: Sun, 25 Jun 2006 03:02:02 +0200
Message-ID: <20060625010202.GX21864@pasky.or.cz>
References: <7vzmg376ee.fsf@assigned-by-dhcp.cox.net> <20060624012202.4822.qmail@science.horizon.com> <7vfyhv11ej.fsf@assigned-by-dhcp.cox.net> <7vwtb6yip5.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0606241147480.6483@g5.osdl.org> <7vhd2atid1.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0606241338370.6483@g5.osdl.org> <7vd5cyt8a3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 25 03:02:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FuJ0r-0007wB-Dl
	for gcvg-git@gmane.org; Sun, 25 Jun 2006 03:02:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751287AbWFYBCF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Jun 2006 21:02:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751290AbWFYBCF
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jun 2006 21:02:05 -0400
Received: from w241.dkm.cz ([62.24.88.241]:11222 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751287AbWFYBCE (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Jun 2006 21:02:04 -0400
Received: (qmail 19905 invoked by uid 2001); 25 Jun 2006 03:02:02 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vd5cyt8a3.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22555>

Dear diary, on Sun, Jun 25, 2006 at 01:59:16AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
> Linus Torvalds <torvalds@osdl.org> writes:
> 
> > how does that compile for anybody else, when -DSHA1_HEADER isn't set 
> > correctly? The quotes have gone missing:
> >
> > 	-DSHA1_HEADER='ppc/sha1.h' 
> >
> > don't ask me why.
> 
> That is, as usual, caused by careless shell quoting.
> 
>         : gitster; PPC_SHA1=YesPlease Meta/Make perl/Makefile
>         GIT_VERSION = 1.4.1.rc1.g9adbe
>         (cd perl && /usr/bin/perl Makefile.PL \
>                         PREFIX="/home/junio/git-test" \
>                         DEFINE="-O2 -Wall -Wdeclaration-after-statement
>                         -g -fPIC -DSHA1_HEADER='"ppc/sha1.h"'
>                         -DGIT_VERSION=\\\"1.4.1.rc1.g9adbe\\\"" \
>                         LIBS="libgit.a xdiff/lib.a -lz")
>         Unrecognized argument in LIBS ignored: 'libgit.a'
>         Unrecognized argument in LIBS ignored: 'xdiff/lib.a'
>         Writing Makefile for Git

Oops...

----

Git.pm build: Fix $DEFINE quoting and missing GIT-CFLAGS dependency

Signed-off-by: Petr Baudis <pasky@suse.cz>

diff --git a/Makefile b/Makefile
index 9a59466..64375f6 100644
--- a/Makefile
+++ b/Makefile
@@ -608,10 +608,12 @@ XDIFF_OBJS=xdiff/xdiffi.o xdiff/xprepare
 	rm -f $@ && $(AR) rcs $@ $(XDIFF_OBJS)
 
 
-perl/Makefile:	perl/Git.pm perl/Makefile.PL
+PERL_DEFINES = $(ALL_CFLAGS) -DGIT_VERSION='"$(GIT_VERSION)"'
+PERL_DEFINES_SQ = $(subst ','\'',$(PERL_DEFINES))
+perl/Makefile:	perl/Git.pm perl/Makefile.PL GIT-CFLAGS
 	(cd perl && $(PERL_PATH) Makefile.PL \
 		PREFIX="$(prefix)" \
-		DEFINE="$(ALL_CFLAGS) -DGIT_VERSION=\\\"$(GIT_VERSION)\\\"" \
+		DEFINE='$(PERL_DEFINES_SQ)' \
 		LIBS="$(EXTLIBS)")
 
 doc:

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
A person is just about as big as the things that make them angry.
