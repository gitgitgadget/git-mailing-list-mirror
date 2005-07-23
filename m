From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Install tools with "make install-tools".
Date: Fri, 22 Jul 2005 19:09:20 -0700
Message-ID: <7vll3y6zov.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 23 04:11:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dw9Ts-0008Nn-Ib
	for gcvg-git@gmane.org; Sat, 23 Jul 2005 04:11:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262279AbVGWCKj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Jul 2005 22:10:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262281AbVGWCK1
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jul 2005 22:10:27 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:1011 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S262279AbVGWCJW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2005 22:09:22 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050723020920.WUOT18672.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 22 Jul 2005 22:09:20 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Match the main Makefile by separating COPTS from CFLAGS,
defining INSTALL, prefix, and bin.  Add a new target 'install-tools'
to the main Makefile to install them.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 Makefile       |    4 ++++
 tools/Makefile |   13 +++++++++++--
 2 files changed, 15 insertions(+), 2 deletions(-)

b0189708a35914c504e7bfa8914d1f5ff029a3a4
diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -195,12 +195,16 @@ test: all
 doc:
 	$(MAKE) -C Documentation all
 
+install-tools:
+	$(MAKE) -C tools install
+
 install-doc:
 	$(MAKE) -C Documentation install
 
 clean:
 	rm -f *.o mozilla-sha1/*.o ppc/*.o $(PROG) $(LIB_FILE)
 	rm -f git-core-*.tar.gz git-core.spec
+	$(MAKE) -C tools/ clean
 	$(MAKE) -C Documentation/ clean
 
 backup: clean
diff --git a/tools/Makefile b/tools/Makefile
--- a/tools/Makefile
+++ b/tools/Makefile
@@ -1,6 +1,14 @@
+#
+# Make Linus git-tools
+#
 CC=gcc
-CFLAGS=-Wall -O2
+COPTS=-O2
+CFLAGS=-g $(COPTS) -Wall
+INSTALL=install
 HOME=$(shell echo $$HOME)
+prefix=$(HOME)
+bin=$(prefix)/bin
+# dest=
 
 PROGRAMS=mailsplit mailinfo
 SCRIPTS=applymbox applypatch
@@ -8,7 +16,8 @@ SCRIPTS=applymbox applypatch
 all: $(PROGRAMS)
 
 install: $(PROGRAMS) $(SCRIPTS)
-	cp -f $(PROGRAMS) $(SCRIPTS) $(HOME)/bin/
+	$(INSTALL) -m755 -d $(dest)$(bin)
+	$(INSTALL) $(PROGRAMS) $(SCRIPTS) $(dest)$(bin)
 
 clean:
 	rm -f $(PROGRAMS) *.o
