From: Stephan Beyer <s-beyer@gmx.net>
Subject: [PATCH v2 2/2] Merge t4150-am-subdir.sh and t4151-am.sh into t4150-am.sh
Date: Sun,  1 Jun 2008 00:11:43 +0200
Message-ID: <1212271903-14037-2-git-send-email-s-beyer@gmx.net>
References: <20080531220723.GD5907@leksak.fem-net>
 <1212271903-14037-1-git-send-email-s-beyer@gmx.net>
Cc: Stephan Beyer <s-beyer@gmx.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 01 00:12:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2ZJi-00050W-As
	for gcvg-git-2@gmane.org; Sun, 01 Jun 2008 00:12:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754174AbYEaWLz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 May 2008 18:11:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754135AbYEaWLy
	(ORCPT <rfc822;git-outgoing>); Sat, 31 May 2008 18:11:54 -0400
Received: from mail.gmx.net ([213.165.64.20]:38959 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753816AbYEaWLx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 May 2008 18:11:53 -0400
Received: (qmail invoked by alias); 31 May 2008 22:11:52 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp009) with SMTP; 01 Jun 2008 00:11:52 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1+7TG5XJ5W7PAV6ez3Ca94GRsG4YMyGZWSfI4cfW+
	Wv3TM1pf49uu1V
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1K2ZId-0003ep-LR; Sun, 01 Jun 2008 00:11:43 +0200
X-Mailer: git-send-email 1.5.5.1.320.gf00a5
In-Reply-To: <1212271903-14037-1-git-send-email-s-beyer@gmx.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83408>

This patch moves the am test cases in t4150-am.sh and the
am subdirectory test cases from t/t4150-am-subdir.sh into
t/4151-am.sh.

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---
 t/t4150-am-subdir.sh           |   72 ----------------------------------------
 t/{t4151-am.sh => t4150-am.sh} |   34 +++++++++++++++++++
 2 files changed, 34 insertions(+), 72 deletions(-)
 delete mode 100755 t/t4150-am-subdir.sh
 rename t/{t4151-am.sh => t4150-am.sh} (90%)

diff --git a/t/t4150-am-subdir.sh b/t/t4150-am-subdir.sh
deleted file mode 100755
index 52069b4..0000000
--- a/t/t4150-am-subdir.sh
+++ /dev/null
@@ -1,72 +0,0 @@
-#!/bin/sh
-
-test_description='git am running from a subdirectory'
-
-. ./test-lib.sh
-
-test_expect_success setup '
-	echo hello >world &&
-	git add world &&
-	test_tick &&
-	git commit -m initial &&
-	git tag initial &&
-	echo goodbye >world &&
-	git add world &&
-	test_tick &&
-	git commit -m second &&
-	git format-patch --stdout HEAD^ >patchfile &&
-	: >expect
-'
-
-test_expect_success 'am regularly from stdin' '
-	git checkout initial &&
-	git am <patchfile &&
-	git diff master >actual &&
-	test_cmp expect actual
-'
-
-test_expect_success 'am regularly from file' '
-	git checkout initial &&
-	git am patchfile &&
-	git diff master >actual &&
-	test_cmp expect actual
-'
-
-test_expect_success 'am regularly from stdin in subdirectory' '
-	rm -fr subdir &&
-	git checkout initial &&
-	(
-		mkdir -p subdir &&
-		cd subdir &&
-		git am <../patchfile
-	) &&
-	git diff master>actual &&
-	test_cmp expect actual
-'
-
-test_expect_success 'am regularly from file in subdirectory' '
-	rm -fr subdir &&
-	git checkout initial &&
-	(
-		mkdir -p subdir &&
-		cd subdir &&
-		git am ../patchfile
-	) &&
-	git diff master >actual &&
-	test_cmp expect actual
-'
-
-test_expect_success 'am regularly from file in subdirectory with full path' '
-	rm -fr subdir &&
-	git checkout initial &&
-	P=$(pwd) &&
-	(
-		mkdir -p subdir &&
-		cd subdir &&
-		git am "$P/patchfile"
-	) &&
-	git diff master >actual &&
-	test_cmp expect actual
-'
-
-test_done
diff --git a/t/t4151-am.sh b/t/t4150-am.sh
similarity index 90%
rename from t/t4151-am.sh
rename to t/t4150-am.sh
index ec1b442..722ae96 100755
--- a/t/t4151-am.sh
+++ b/t/t4150-am.sh
@@ -223,4 +223,38 @@ test_expect_success 'am fails on empty patch' '
 	! test -d .dotest
 '
 
+test_expect_success 'am works from stdin in subdirectory' '
+	rm -fr subdir &&
+	git checkout first &&
+	(
+		mkdir -p subdir &&
+		cd subdir &&
+		git am <../patch1
+	) &&
+	test -z "$(git diff second)"
+'
+
+test_expect_success 'am works from file (relative path given) in subdirectory' '
+	rm -fr subdir &&
+	git checkout first &&
+	(
+		mkdir -p subdir &&
+		cd subdir &&
+		git am ../patch1
+	) &&
+	test -z "$(git diff second)"
+'
+
+test_expect_success 'am works from file (absolute path given) in subdirectory' '
+	rm -fr subdir &&
+	git checkout first &&
+	P=$(pwd) &&
+	(
+		mkdir -p subdir &&
+		cd subdir &&
+		git am "$P/patch1"
+	) &&
+	test -z "$(git diff second)"
+'
+
 test_done
-- 
1.5.5.1
