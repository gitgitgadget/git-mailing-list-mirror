From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: [PATCH] t6022: Use -eq not = to test output of wc -l
Date: Mon,  8 Nov 2010 16:29:26 -0500
Message-ID: <1289251766-48316-1-git-send-email-brian@gernhardtsoftware.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 08 22:29:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFZHW-0001Lv-68
	for gcvg-git-2@lo.gmane.org; Mon, 08 Nov 2010 22:29:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755127Ab0KHV3c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Nov 2010 16:29:32 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:47660 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754361Ab0KHV3c (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Nov 2010 16:29:32 -0500
Received: by silverinsanity.com (Postfix, from userid 5001)
	id A0FE01FFC061; Mon,  8 Nov 2010 21:29:24 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.5
Received: from localhost.localdomain (cpe-74-65-60-43.rochester.res.rr.com [74.65.60.43])
	by silverinsanity.com (Postfix) with ESMTPA id 3FA151FFC058;
	Mon,  8 Nov 2010 21:29:23 +0000 (UTC)
X-Mailer: git-send-email 1.7.3.2.333.g23b6d8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160991>

When comparing numbers such as "3" to "$(wc -l)", we should check for
numerical equality using -eq instead of string equality using = because
some implementations of wc output extra whitespace.

Signed-off-by: Brian Gernhardt <brian@gernhardtsoftware.com>
---
 The alternative would be to use 3 = $(wc -l) (sans quotes), but other parts
 of the test used the -eq method.

 t/t6022-merge-rename.sh |   64 +++++++++++++++++++++++-----------------------
 1 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/t/t6022-merge-rename.sh b/t/t6022-merge-rename.sh
index 422092e..66473f0 100755
--- a/t/t6022-merge-rename.sh
+++ b/t/t6022-merge-rename.sh
@@ -404,8 +404,8 @@ test_expect_success 'Rename+D/F conflict; renamed file merges but dir in way' '
 	grep "Auto-merging dir" output &&
 	grep "Adding as dir~HEAD instead" output &&
 
-	test 2 = "$(git ls-files -u | wc -l)" &&
-	test 2 = "$(git ls-files -u dir/file-in-the-way | wc -l)" &&
+	test 2 -eq "$(git ls-files -u | wc -l)" &&
+	test 2 -eq "$(git ls-files -u dir/file-in-the-way | wc -l)" &&
 
 	test_must_fail git diff --quiet &&
 	test_must_fail git diff --cached --quiet &&
@@ -426,8 +426,8 @@ test_expect_success 'Same as previous, but merged other way' '
 	grep "Auto-merging dir" output &&
 	grep "Adding as dir~renamed-file-has-no-conflicts instead" output &&
 
-	test 2 = "$(git ls-files -u | wc -l)" &&
-	test 2 = "$(git ls-files -u dir/file-in-the-way | wc -l)" &&
+	test 2 -eq "$(git ls-files -u | wc -l)" &&
+	test 2 -eq "$(git ls-files -u dir/file-in-the-way | wc -l)" &&
 
 	test_must_fail git diff --quiet &&
 	test_must_fail git diff --cached --quiet &&
@@ -461,8 +461,8 @@ test_expect_success 'Rename+D/F conflict; renamed file cannot merge, dir not in
 	git checkout -q renamed-file-has-conflicts^0 &&
 	test_must_fail git merge --strategy=recursive dir-not-in-way &&
 
-	test 3 = "$(git ls-files -u | wc -l)" &&
-	test 3 = "$(git ls-files -u dir | wc -l)" &&
+	test 3 -eq "$(git ls-files -u | wc -l)" &&
+	test 3 -eq "$(git ls-files -u dir | wc -l)" &&
 
 	test_must_fail git diff --quiet &&
 	test_must_fail git diff --cached --quiet &&
@@ -479,9 +479,9 @@ test_expect_success 'Rename+D/F conflict; renamed file cannot merge and dir in t
 	git checkout -q renamed-file-has-conflicts^0 &&
 	test_must_fail git merge --strategy=recursive dir-in-way &&
 
-	test 5 = "$(git ls-files -u | wc -l)" &&
-	test 3 = "$(git ls-files -u dir | grep -v file-in-the-way | wc -l)" &&
-	test 2 = "$(git ls-files -u dir/file-in-the-way | wc -l)" &&
+	test 5 -eq "$(git ls-files -u | wc -l)" &&
+	test 3 -eq "$(git ls-files -u dir | grep -v file-in-the-way | wc -l)" &&
+	test 2 -eq "$(git ls-files -u dir/file-in-the-way | wc -l)" &&
 
 	test_must_fail git diff --quiet &&
 	test_must_fail git diff --cached --quiet &&
@@ -515,9 +515,9 @@ test_expect_success 'Same as previous, but merged other way' '
 	git checkout -q dir-in-way^0 &&
 	test_must_fail git merge --strategy=recursive renamed-file-has-conflicts &&
 
-	test 5 = "$(git ls-files -u | wc -l)" &&
-	test 3 = "$(git ls-files -u dir | grep -v file-in-the-way | wc -l)" &&
-	test 2 = "$(git ls-files -u dir/file-in-the-way | wc -l)" &&
+	test 5 -eq "$(git ls-files -u | wc -l)" &&
+	test 3 -eq "$(git ls-files -u dir | grep -v file-in-the-way | wc -l)" &&
+	test 2 -eq "$(git ls-files -u dir/file-in-the-way | wc -l)" &&
 
 	test_must_fail git diff --quiet &&
 	test_must_fail git diff --cached --quiet &&
@@ -555,7 +555,7 @@ test_expect_success 'both rename source and destination involved in D/F conflict
 	git checkout -q rename-dest^0 &&
 	test_must_fail git merge --strategy=recursive source-conflict &&
 
-	test 1 = "$(git ls-files -u | wc -l)" &&
+	test 1 -eq "$(git ls-files -u | wc -l)" &&
 
 	test_must_fail git diff --quiet &&
 
@@ -594,13 +594,13 @@ test_expect_success 'pair rename to parent of other (D/F conflicts) w/ untracked
 	mkdir one &&
 	test_must_fail git merge --strategy=recursive rename-two &&
 
-	test 2 = "$(git ls-files -u | wc -l)" &&
-	test 1 = "$(git ls-files -u one | wc -l)" &&
-	test 1 = "$(git ls-files -u two | wc -l)" &&
+	test 2 -eq "$(git ls-files -u | wc -l)" &&
+	test 1 -eq "$(git ls-files -u one | wc -l)" &&
+	test 1 -eq "$(git ls-files -u two | wc -l)" &&
 
 	test_must_fail git diff --quiet &&
 
-	test 4 = $(find . | grep -v .git | wc -l) &&
+	test 4 -eq $(find . | grep -v .git | wc -l) &&
 
 	test -d one &&
 	test -f one~rename-two &&
@@ -614,13 +614,13 @@ test_expect_success 'pair rename to parent of other (D/F conflicts) w/ clean sta
 	git clean -fdqx &&
 	test_must_fail git merge --strategy=recursive rename-two &&
 
-	test 2 = "$(git ls-files -u | wc -l)" &&
-	test 1 = "$(git ls-files -u one | wc -l)" &&
-	test 1 = "$(git ls-files -u two | wc -l)" &&
+	test 2 -eq "$(git ls-files -u | wc -l)" &&
+	test 1 -eq "$(git ls-files -u one | wc -l)" &&
+	test 1 -eq "$(git ls-files -u two | wc -l)" &&
 
 	test_must_fail git diff --quiet &&
 
-	test 3 = $(find . | grep -v .git | wc -l) &&
+	test 3 -eq $(find . | grep -v .git | wc -l) &&
 
 	test -f one &&
 	test -f two &&
@@ -656,12 +656,12 @@ test_expect_success 'check handling of differently renamed file with D/F conflic
 	git checkout -q first-rename^0 &&
 	test_must_fail git merge --strategy=recursive second-rename &&
 
-	test 5 = "$(git ls-files -s | wc -l)" &&
-	test 3 = "$(git ls-files -u | wc -l)" &&
-	test 1 = "$(git ls-files -u one | wc -l)" &&
-	test 1 = "$(git ls-files -u two | wc -l)" &&
-	test 1 = "$(git ls-files -u original | wc -l)" &&
-	test 2 = "$(git ls-files -o | wc -l)" &&
+	test 5 -eq "$(git ls-files -s | wc -l)" &&
+	test 3 -eq "$(git ls-files -u | wc -l)" &&
+	test 1 -eq "$(git ls-files -u one | wc -l)" &&
+	test 1 -eq "$(git ls-files -u two | wc -l)" &&
+	test 1 -eq "$(git ls-files -u original | wc -l)" &&
+	test 2 -eq "$(git ls-files -o | wc -l)" &&
 
 	test -f one/file &&
 	test -f two/file &&
@@ -696,11 +696,11 @@ test_expect_success 'check handling of differently renamed file with D/F conflic
 	git checkout -q first-rename-redo^0 &&
 	test_must_fail git merge --strategy=recursive second-rename-redo &&
 
-	test 3 = "$(git ls-files -u | wc -l)" &&
-	test 1 = "$(git ls-files -u one | wc -l)" &&
-	test 1 = "$(git ls-files -u two | wc -l)" &&
-	test 1 = "$(git ls-files -u original | wc -l)" &&
-	test 0 = "$(git ls-files -o | wc -l)" &&
+	test 3 -eq "$(git ls-files -u | wc -l)" &&
+	test 1 -eq "$(git ls-files -u one | wc -l)" &&
+	test 1 -eq "$(git ls-files -u two | wc -l)" &&
+	test 1 -eq "$(git ls-files -u original | wc -l)" &&
+	test 0 -eq "$(git ls-files -o | wc -l)" &&
 
 	test -f one &&
 	test -f two &&
-- 
1.7.3.2.333.g23b6d8
