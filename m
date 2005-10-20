From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Make git-cherry-pick in target "all"
Date: Thu, 20 Oct 2005 17:13:24 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0510201712150.29282@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Thu Oct 20 17:17:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESc6j-0000Au-Dk
	for gcvg-git@gmane.org; Thu, 20 Oct 2005 17:13:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751714AbVJTPN0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Oct 2005 11:13:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751739AbVJTPN0
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Oct 2005 11:13:26 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:17074 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751714AbVJTPNZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Oct 2005 11:13:25 -0400
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id C729813F12B; Thu, 20 Oct 2005 17:13:24 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id A73B4B4E0E; Thu, 20 Oct 2005 17:13:24 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 8CDD5B4E01; Thu, 20 Oct 2005 17:13:24 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 7554D13F12B; Thu, 20 Oct 2005 17:13:24 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10365>

Since git-cherry-pick is simply a copy of git-revert, it can be created
before installing (so that it can be used without installing, too).

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

 .gitignore |    1 +
 Makefile   |    6 ++++--
 2 files changed, 5 insertions(+), 2 deletions(-)

applies-to: 4380edd21387645ec027e365df316e93820cfc13
35408716ef9d85bc2feaf71c3d6cf20345c7f635
diff --git a/.gitignore b/.gitignore
index 975e773..52cb9e2 100644
--- a/.gitignore
+++ b/.gitignore
@@ -12,6 +12,7 @@ git-check-ref-format
 git-checkout
 git-checkout-index
 git-cherry
+git-cherry-pick
 git-clone
 git-clone-pack
 git-commit
diff --git a/Makefile b/Makefile
index 5fa9f4f..b043175 100644
--- a/Makefile
+++ b/Makefile
@@ -314,7 +314,7 @@ DEFINES += -DSHA1_HEADER=$(call shellquo
 SCRIPTS = $(patsubst %.sh,%,$(SCRIPT_SH)) \
 	  $(patsubst %.perl,%,$(SCRIPT_PERL)) \
 	  $(patsubst %.py,%,$(SCRIPT_PYTHON)) \
-	  gitk
+	  gitk git-cherry-pick
 
 export prefix TAR INSTALL DESTDIR SHELL_PATH template_dir
 ### Build rules
@@ -355,6 +355,9 @@ $(patsubst %.py,%,$(SCRIPT_PYTHON)) : % 
 	    $@.py >$@
 	chmod +x $@
 
+git-cherry-pick: git-revert
+	cp $< $@
+
 %.o: %.c
 	$(CC) -o $*.o -c $(ALL_CFLAGS) $<
 %.o: %.S
@@ -414,7 +417,6 @@ check:
 install: $(PROGRAMS) $(SCRIPTS)
 	$(INSTALL) -d -m755 $(call shellquote,$(DESTDIR)$(bindir))
 	$(INSTALL) $(PROGRAMS) $(SCRIPTS) $(call shellquote,$(DESTDIR)$(bindir))
-	$(INSTALL) git-revert $(call shellquote,$(DESTDIR)$(bindir)/git-cherry-pick)
 	sh ./cmd-rename.sh $(call shellquote,$(DESTDIR)$(bindir))
 	$(MAKE) -C templates install
 	$(INSTALL) -d -m755 $(call shellquote,$(DESTDIR)$(GIT_PYTHON_DIR))
---
0.99.8.GIT
