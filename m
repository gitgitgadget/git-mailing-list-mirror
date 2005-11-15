From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] Fix cg-version -h by sourcing cg-Xlib
Date: Tue, 15 Nov 2005 13:03:12 +0100
Message-ID: <20051115120312.GA13925@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 15 13:05:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EbzWy-00021V-9z
	for gcvg-git@gmane.org; Tue, 15 Nov 2005 13:03:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932377AbVKOMDS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Nov 2005 07:03:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932390AbVKOMDR
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Nov 2005 07:03:17 -0500
Received: from nhugin.diku.dk ([130.225.96.140]:25308 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S932377AbVKOMDR (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Nov 2005 07:03:17 -0500
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id C10926DFF39; Tue, 15 Nov 2005 13:02:50 +0100 (CET)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 1F33D6DFD84; Tue, 15 Nov 2005 13:02:48 +0100 (CET)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 2E13261339; Tue, 15 Nov 2005 13:03:13 +0100 (CET)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11899>

Also requires cg-version to become a bash script.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---
diff --git a/Makefile b/Makefile
index 72d7d12..b18e79f 100644
--- a/Makefile
+++ b/Makefile
@@ -42,7 +42,7 @@ endif
 cg-version: $(VERSION) $(GIT_HEAD) Makefile
 	@echo Generating cg-version...
 	@rm -f $@
-	@echo "#!/bin/sh" > $@
+	@echo "#!/usr/bin/env bash" >> $@
 	@echo "#" >> $@
 	@echo "# Show the version of the Cogito toolkit." >> $@
 	@echo "# Copyright (c) Petr Baudis, 2005" >> $@
@@ -53,6 +53,9 @@ cg-version: $(VERSION) $(GIT_HEAD) Makef
 	@echo "# at the build time." >> $@
 	@echo >> $@
 	@echo "USAGE=\"cg-version\"" >> $@
+	@echo "_git_repo_unneeded=1" >> $@
+	@echo >> $@
+	@echo ". \$${COGITO_LIB}cg-Xlib || exit 1" >> $@
 	@echo >> $@
 	@echo "echo \"$(shell cat $(VERSION))$(GIT_HEAD_ID)\"" >> $@
 	@chmod +x $@
@@ -92,7 +95,7 @@ install-cogito: $(SCRIPT) $(LIB_SCRIPT) 
 	$(INSTALL) -m755 -d $(DESTDIR)$(libdir)
 	$(INSTALL) $(LIB_SCRIPT) $(DESTDIR)$(libdir)
 	cd $(DESTDIR)$(bindir); \
-	for file in $(SCRIPT); do \
+	for file in $(SCRIPT) $(GEN_SCRIPT); do \
 		sed -e 's/\$${COGITO_LIB}/"\$${COGITO_LIB:-$(sedlibdir)\/}"/g' $$file > $$file.new; \
 		cat $$file.new > $$file; rm $$file.new; \
 	done
-- 
Jonas Fonseca
