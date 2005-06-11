From: Kay Sievers <kay.sievers@vrfy.org>
Subject: Cogito: split Makefile targets of Cogito/git
Date: Sat, 11 Jun 2005 21:50:33 +0200
Message-ID: <20050611195033.GA22713@vrfy.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="9amGYk9869ThD9tj"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 11 21:46:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DhBvy-0000Eu-A1
	for gcvg-git@gmane.org; Sat, 11 Jun 2005 21:46:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261287AbVFKTuq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Jun 2005 15:50:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261783AbVFKTuq
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Jun 2005 15:50:46 -0400
Received: from soundwarez.org ([217.160.171.123]:23775 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S261287AbVFKTuf (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Jun 2005 15:50:35 -0400
Received: by soundwarez.org (Postfix, from userid 2702)
	id 0CA7A3F9FB; Sat, 11 Jun 2005 21:50:33 +0200 (CEST)
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This splits the targets of Cogito/git to be able to call it
independently. This way we can easily make Cogito a separate
package, which just requires git.

Thanks,
Kay

--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="cogito-Makefile-split-install.patch"

diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -112,9 +112,10 @@ endif
 
 CFLAGS += '-DSHA1_HEADER=$(SHA1_HEADER)'
 
-
-all: $(PROG) $(GEN_SCRIPT)
-
+.PHONY: all it cogito
+all: git cogito
+git: $(PROG)
+cogito: $(GEN_SCRIPT)
 
 test-delta: test-delta.c diff-delta.o patch-delta.o
 	$(CC) $(CFLAGS) -o $@ $^
@@ -169,9 +170,16 @@ test: all
 
 sedlibdir=$(shell echo $(libdir) | sed 's/\//\\\//g')
 
-install: $(PROG) $(SCRIPTS) $(SCRIPT) $(LIB_SCRIPT) $(GEN_SCRIPT)
+.PHONY: install install-git install-cogito
+install: install-git install-cogito
+
+install-git: $(PROG) $(SCRIPTS)
+	$(INSTALL) -m755 -d $(DESTDIR)$(bindir)
+	$(INSTALL) $(PROG) $(SCRIPTS) $(DESTDIR)$(bindir)
+
+install-cogito: $(SCRIPT) $(LIB_SCRIPT) $(GEN_SCRIPT)
 	$(INSTALL) -m755 -d $(DESTDIR)$(bindir)
-	$(INSTALL) $(PROG) $(SCRIPTS) $(SCRIPT) $(GEN_SCRIPT) $(DESTDIR)$(bindir)
+	$(INSTALL) $(SCRIPT) $(GEN_SCRIPT) $(DESTDIR)$(bindir)
 	$(INSTALL) -m755 -d $(DESTDIR)$(libdir)
 	$(INSTALL) $(LIB_SCRIPT) $(DESTDIR)$(libdir)
 	cd $(DESTDIR)$(bindir); \

--9amGYk9869ThD9tj--
