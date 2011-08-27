From: Brandon Casey <drafnel@gmail.com>
Subject: [PATCH 1/4] t/t3905: use the name 'actual' for test output, swap arguments to test_cmp
Date: Fri, 26 Aug 2011 19:59:24 -0500
Message-ID: <1314406767-17832-1-git-send-email-drafnel@gmail.com>
Cc: git@vger.kernel.org, hilco.wijbenga@gmail.com, david@porkrind.org,
	Brandon Casey <drafnel@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Aug 27 03:01:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qx7Gd-00074o-3B
	for gcvg-git-2@lo.gmane.org; Sat, 27 Aug 2011 03:00:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754593Ab1H0BAy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Aug 2011 21:00:54 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:50847 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754411Ab1H0BAx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Aug 2011 21:00:53 -0400
Received: by yie30 with SMTP id 30so2066831yie.19
        for <git@vger.kernel.org>; Fri, 26 Aug 2011 18:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=vcbqAbJIyO63GM9qh6+sjk1wJ9vh1m5FJYFcT0V/piU=;
        b=VJ0Dq3og7VkPFxbrQMdw//v82jlRnj3JAErAVvrRKDv63xRJgOHEEyi06fGDLAJfJC
         zjcDbsZaadr/iqqrF+JBY8DVwGcFstJ2+0nH4Y5+nJGFdmb8Lw6kekySsI+79qGzqKVn
         2PDy1NCH1QF7z23FNVQ4B5t4JYts4KxJRCXfI=
Received: by 10.236.182.201 with SMTP id o49mr5129556yhm.57.1314406852923;
        Fri, 26 Aug 2011 18:00:52 -0700 (PDT)
Received: from localhost.localdomain ([96.19.140.155])
        by mx.google.com with ESMTPS id j45sm2756593yhe.36.2011.08.26.18.00.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 26 Aug 2011 18:00:51 -0700 (PDT)
X-Mailer: git-send-email 1.7.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180211>

It is common practice in the git test suite to use the file names 'actual'
and 'expect' to hold the actual and expected output of commands.  So change
the name 'output' to 'actual'.

Additionally, swap the order of arguments to test_cmp when comparing
expected output and actual output so that if diff output is produced, it
describes how the actual output differs from what was expected rather than
the other way around.

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---
 t/t3905-stash-include-untracked.sh |   24 ++++++++++++------------
 1 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/t/t3905-stash-include-untracked.sh b/t/t3905-stash-include-untracked.sh
index 4f2eedf..adc2524 100755
--- a/t/t3905-stash-include-untracked.sh
+++ b/t/t3905-stash-include-untracked.sh
@@ -23,13 +23,13 @@ test_expect_success 'stash save --include-untracked some dirty working directory
 '
 
 cat > expect <<EOF
+?? actual
 ?? expect
-?? output
 EOF
 
 test_expect_success 'stash save --include-untracked cleaned the untracked files' '
-	git status --porcelain > output
-	test_cmp output expect
+	git status --porcelain >actual
+	test_cmp expect actual
 '
 
 cat > expect.diff <<EOF
@@ -47,10 +47,10 @@ EOF
 
 test_expect_success 'stash save --include-untracked stashed the untracked files' '
 	test "!" -f file2 &&
-	git diff HEAD..stash^3 -- file2 > output &&
-	test_cmp output expect.diff &&
-	git ls-tree --name-only stash^3: > output &&
-	test_cmp output expect.lstree
+	git diff HEAD..stash^3 -- file2 >actual &&
+	test_cmp expect.diff actual &&
+	git ls-tree --name-only stash^3: >actual &&
+	test_cmp expect.lstree actual
 '
 test_expect_success 'stash save --patch --include-untracked fails' '
 	test_must_fail git stash --patch --include-untracked
@@ -64,15 +64,15 @@ git clean --force --quiet
 
 cat > expect <<EOF
  M file
+?? actual
 ?? expect
 ?? file2
-?? output
 EOF
 
 test_expect_success 'stash pop after save --include-untracked leaves files untracked again' '
 	git stash pop &&
-	git status --porcelain > output
-	test_cmp output expect
+	git status --porcelain >actual
+	test_cmp expect actual
 '
 
 git clean --force --quiet
@@ -96,8 +96,8 @@ EOF
 
 test_expect_success 'stash save --include-untracked dirty index got stashed' '
 	git stash pop --index &&
-	git diff --cached > output &&
-	test_cmp output expect
+	git diff --cached >actual &&
+	test_cmp expect actual
 '
 
 git reset > /dev/null
-- 
1.7.6
