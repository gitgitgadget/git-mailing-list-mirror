From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] Introduce cg-version.in template
Date: Tue, 15 Nov 2005 13:23:23 +0100
Message-ID: <20051115122323.GB13925@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 15 13:24:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EbzqS-0003kT-E2
	for gcvg-git@gmane.org; Tue, 15 Nov 2005 13:23:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932407AbVKOMX0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Nov 2005 07:23:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932415AbVKOMXZ
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Nov 2005 07:23:25 -0500
Received: from nhugin.diku.dk ([130.225.96.140]:48349 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S932407AbVKOMXZ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Nov 2005 07:23:25 -0500
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id 52D326DF88D; Tue, 15 Nov 2005 13:22:59 +0100 (CET)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 161756DF823; Tue, 15 Nov 2005 13:22:59 +0100 (CET)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 28E0761339; Tue, 15 Nov 2005 13:23:24 +0100 (CET)
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, hits=-4.9 required=5.0 tests=BAYES_00 autolearn=ham 
	version=2.60
X-Spam-Checker-Version: SpamAssassin 2.60 (1.212-2003-09-23-exp) on 
	nhugin.diku.dk
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11901>

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---
diff --git a/Makefile b/Makefile
index 72d7d12..700491f 100644
--- a/Makefile
+++ b/Makefile
@@ -37,24 +37,14 @@ cogito: $(GEN_SCRIPT)
 
 ifneq (,$(wildcard .git))
 GIT_HEAD=.git/$(shell git-symbolic-ref HEAD)
-GIT_HEAD_ID=" \($(shell cat $(GIT_HEAD))\)"
+GIT_HEAD_ID=($(shell cat $(GIT_HEAD)))
 endif
-cg-version: $(VERSION) $(GIT_HEAD) Makefile
+cg-version: cg-version.in $(VERSION) $(GIT_HEAD)
 	@echo Generating cg-version...
 	@rm -f $@
-	@echo "#!/bin/sh" > $@
-	@echo "#" >> $@
-	@echo "# Show the version of the Cogito toolkit." >> $@
-	@echo "# Copyright (c) Petr Baudis, 2005" >> $@
-	@echo "#" >> $@
-	@echo "# Show which version of Cogito is installed." >> $@
-	@echo "# Additionally, the 'HEAD' of the installed Cogito" >> $@
-	@echo "# is also shown if this information was available" >> $@
-	@echo "# at the build time." >> $@
-	@echo >> $@
-	@echo "USAGE=\"cg-version\"" >> $@
-	@echo >> $@
-	@echo "echo \"$(shell cat $(VERSION))$(GIT_HEAD_ID)\"" >> $@
+	@sed -e 's/@@VERSION@@/$(shell cat $(VERSION))/' \
+	     -e 's/@@GIT_HEAD_ID@@/$(GIT_HEAD_ID)/' \
+	     < $< > $@ 
 	@chmod +x $@
 
 doc:
diff --git a/cg-version.in b/cg-version.in
new file mode 100644
index 0000000..369818e
--- /dev/null
+++ b/cg-version.in
@@ -0,0 +1,16 @@
+#!/usr/bin/env bash
+#
+# Show the version of the Cogito toolkit.
+# Copyright (c) Petr Baudis, 2005
+#
+# Show which version of Cogito is installed.
+# Additionally, the 'HEAD' of the installed Cogito
+# is also shown if this information was available
+# at the build time.
+
+USAGE="cg-version"
+_git_repo_unneeded=1
+
+. ${COGITO_LIB}cg-Xlib || exit 1
+
+echo "@@VERSION@@ @@GIT_HEAD_ID@@"
diff --git a/Documentation/Makefile b/Documentation/Makefile
index 4fe009a..3aad2fb 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -1,4 +1,4 @@
-CG_IGNORE=$(wildcard ../cg-X* ../cg-*.orig ../cg-*.rej)
+CG_IGNORE=$(wildcard ../cg-X* ../cg-*.orig ../cg-*.rej ../cg-*.in)
 CG_SRC=$(filter-out $(CG_IGNORE), $(wildcard ../cg*))
 
 PACKAGE=cogito
-- 
Jonas Fonseca
