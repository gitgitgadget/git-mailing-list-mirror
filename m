From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] Git.pm build: Fix quoting and missing GIT-CFLAGS dependency
Date: Sun, 25 Jun 2006 03:40:09 +0200
Message-ID: <20060625014009.GA21864@pasky.or.cz>
References: <7vzmg376ee.fsf@assigned-by-dhcp.cox.net> <20060624012202.4822.qmail@science.horizon.com> <7vfyhv11ej.fsf@assigned-by-dhcp.cox.net> <7vwtb6yip5.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0606241147480.6483@g5.osdl.org> <7vhd2atid1.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0606241338370.6483@g5.osdl.org> <7vd5cyt8a3.fsf@assigned-by-dhcp.cox.net> <20060625010202.GX21864@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 25 03:40:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FuJbp-0004N6-LE
	for gcvg-git@gmane.org; Sun, 25 Jun 2006 03:40:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751293AbWFYBkM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Jun 2006 21:40:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751303AbWFYBkM
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jun 2006 21:40:12 -0400
Received: from w241.dkm.cz ([62.24.88.241]:1710 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751293AbWFYBkL (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Jun 2006 21:40:11 -0400
Received: (qmail 25372 invoked by uid 2001); 25 Jun 2006 03:40:09 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <20060625010202.GX21864@pasky.or.cz>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22564>

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

  This one should do a better job; if we quote, let's do it proper. :-)

 Makefile |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index 9a59466..fb9ffad 100644
--- a/Makefile
+++ b/Makefile
@@ -608,11 +608,15 @@ XDIFF_OBJS=xdiff/xdiffi.o xdiff/xprepare
 	rm -f $@ && $(AR) rcs $@ $(XDIFF_OBJS)
 
 
-perl/Makefile:	perl/Git.pm perl/Makefile.PL
+PERL_DEFINE = $(ALL_CFLAGS) -DGIT_VERSION='"$(GIT_VERSION)"'
+PERL_DEFINE_SQ = $(subst ','\'',$(PERL_DEFINE))
+PERL_LIBS = $(EXTLIBS)
+PERL_LIBS_SQ = $(subst ','\'',$(PERL_LIBS))
+perl/Makefile:	perl/Git.pm perl/Makefile.PL GIT-CFLAGS
 	(cd perl && $(PERL_PATH) Makefile.PL \
-		PREFIX="$(prefix)" \
-		DEFINE="$(ALL_CFLAGS) -DGIT_VERSION=\\\"$(GIT_VERSION)\\\"" \
-		LIBS="$(EXTLIBS)")
+		PREFIX='$(prefix_SQ)' \
+		DEFINE='$(PERL_DEFINE_SQ)' \
+		LIBS='$(PERL_LIBS)')
 
 doc:
 	$(MAKE) -C Documentation all

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
A person is just about as big as the things that make them angry.
