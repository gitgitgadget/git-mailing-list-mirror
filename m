From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] Fix cygwin install issues
Date: Mon, 10 Oct 2005 10:52:59 +0200
Message-ID: <20051010085259.GA18009@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 10 10:54:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EOtP9-00022l-19
	for gcvg-git@gmane.org; Mon, 10 Oct 2005 10:53:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750757AbVJJIxD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Oct 2005 04:53:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750772AbVJJIxD
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Oct 2005 04:53:03 -0400
Received: from nhugin.diku.dk ([130.225.96.140]:10483 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S1750757AbVJJIxB (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Oct 2005 04:53:01 -0400
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id ADBDF6E19BB; Mon, 10 Oct 2005 10:52:46 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 7FBB56E19B2; Mon, 10 Oct 2005 10:52:46 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 25F7E60FBD; Mon, 10 Oct 2005 10:53:00 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Spam-Checker-Version: SpamAssassin 2.60 (1.212-2003-09-23-exp) on 
	nhugin.diku.dk
X-Spam-Status: No, hits=-4.9 required=5.0 tests=BAYES_00,UPPERCASE_25_50 
	autolearn=no version=2.60
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9877>

Support installing to paths including spaces.
Remove any old .exe files so ln will succeed.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>

---

diff --git a/Makefile b/Makefile
index ac384c7..9ae0dfd 100644
--- a/Makefile
+++ b/Makefile
@@ -397,13 +397,13 @@ check:
 ### Installation rules
 
 install: $(PROGRAMS) $(SCRIPTS)
-	$(INSTALL) -d -m755 $(DESTDIR)$(bindir)
-	$(INSTALL) $(PROGRAMS) $(SCRIPTS) $(DESTDIR)$(bindir)
-	$(INSTALL) git-revert $(DESTDIR)$(bindir)/git-cherry-pick
-	sh ./cmd-rename.sh $(DESTDIR)$(bindir)
+	$(INSTALL) -d -m755 "$(DESTDIR)$(bindir)"
+	$(INSTALL) $(PROGRAMS) $(SCRIPTS) "$(DESTDIR)$(bindir)"
+	$(INSTALL) git-revert "$(DESTDIR)$(bindir)/git-cherry-pick"
+	sh ./cmd-rename.sh "$(DESTDIR)$(bindir)" "$X"
 	$(MAKE) -C templates install
-	$(INSTALL) -d -m755 $(DESTDIR)$(GIT_PYTHON_DIR)
-	$(INSTALL) $(PYMODULES) $(DESTDIR)$(GIT_PYTHON_DIR)
+	$(INSTALL) -d -m755 "$(DESTDIR)$(GIT_PYTHON_DIR)"
+	$(INSTALL) $(PYMODULES) "$(DESTDIR)$(GIT_PYTHON_DIR)"
 
 install-doc:
 	$(MAKE) -C Documentation install
diff --git a/cmd-rename.sh b/cmd-rename.sh
index 34e7f49..c9d3171 100755
--- a/cmd-rename.sh
+++ b/cmd-rename.sh
@@ -1,9 +1,10 @@
 #!/bin/sh
 d="$1"
+X="$2"
 test -d "$d" || exit
 while read old new
 do
-	rm -f "$d/$old"
+	rm -f "$d/$old" "$d/$old$X"
 	if test -f "$d/$new"
 	then
 		ln -s "$new" "$d/$old" || exit
-- 
Jonas Fonseca
