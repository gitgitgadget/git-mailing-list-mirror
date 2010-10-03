From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv5 03/16] t4017 (diff-retval): replace manual exit code check with test_expect_code
Date: Sat,  2 Oct 2010 23:10:31 -0600
Message-ID: <1286082644-31595-4-git-send-email-newren@gmail.com>
References: <1286082644-31595-1-git-send-email-newren@gmail.com>
Cc: gitster@pobox.com, avarab@gmail.com, jrnieder@gmail.com,
	Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 03 07:10:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2Gpo-0001zH-I4
	for gcvg-git-2@lo.gmane.org; Sun, 03 Oct 2010 07:10:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751961Ab0JCFJV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Oct 2010 01:09:21 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:50266 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751886Ab0JCFJU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Oct 2010 01:09:20 -0400
Received: by mail-pw0-f46.google.com with SMTP id 5so856544pwj.19
        for <git@vger.kernel.org>; Sat, 02 Oct 2010 22:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=TT4hSziq1h45GwlXbbBHxrncAuGdzRlPJKb1wn4fW3s=;
        b=SUM3XHiX3O9CgBohPkw6IUCQE8H/7O0ADfpCE3g1JvLKJ4k+YqueT0IbpzgSUlk+1Q
         cKvcPGS5xE/jG6W19fN0U8/ok2zF3KyfiIRcq+77yLNsvve8ey0y7Z4xM+KCLOvFEte2
         22gGzC56cVKsoLCtc/6dOkAuPTf8Oswg+Nu9U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=S0IcydRP4RZFMM7CXi+KpDUQWJJiPf+BZc8fVVxCNaNGyh/htrMOnCkuIheUrBhQWA
         akfppG1HqPWmijEQxNcJUkTQOH88z/zcPOoscjw4HzXmeDPU3ZEZ4oumLjaD51fGnsmh
         NTEwUApLNV4XYrOHNok9GRUanVYYxdVpOVMos=
Received: by 10.142.238.5 with SMTP id l5mr6813450wfh.337.1286082559832;
        Sat, 02 Oct 2010 22:09:19 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id o16sm4140250wfh.19.2010.10.02.22.09.17
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 02 Oct 2010 22:09:18 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.1.66.gab790
In-Reply-To: <1286082644-31595-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157830>


Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t4017-diff-retval.sh |   71 ++++++++++++++---------------------------------
 1 files changed, 21 insertions(+), 50 deletions(-)

diff --git a/t/t4017-diff-retval.sh b/t/t4017-diff-retval.sh
index 6158985..fc44850 100755
--- a/t/t4017-diff-retval.sh
+++ b/t/t4017-diff-retval.sh
@@ -29,66 +29,49 @@ test_expect_success 'git diff --quiet -w  HEAD^ HEAD' '
 '
 
 test_expect_success 'git diff-tree HEAD^ HEAD' '
-	git diff-tree --exit-code HEAD^ HEAD
-	test $? = 1
+	test_expect_code 1 git diff-tree --exit-code HEAD^ HEAD
 '
 test_expect_success 'git diff-tree HEAD^ HEAD -- a' '
 	git diff-tree --exit-code HEAD^ HEAD -- a
-	test $? = 0
 '
 test_expect_success 'git diff-tree HEAD^ HEAD -- b' '
-	git diff-tree --exit-code HEAD^ HEAD -- b
-	test $? = 1
+	test_expect_code 1 git diff-tree --exit-code HEAD^ HEAD -- b
 '
 test_expect_success 'echo HEAD | git diff-tree --stdin' '
-	echo $(git rev-parse HEAD) | git diff-tree --exit-code --stdin
-	test $? = 1
+	echo $(git rev-parse HEAD) | test_expect_code 1 git diff-tree --exit-code --stdin
 '
 test_expect_success 'git diff-tree HEAD HEAD' '
 	git diff-tree --exit-code HEAD HEAD
-	test $? = 0
 '
 test_expect_success 'git diff-files' '
 	git diff-files --exit-code
-	test $? = 0
 '
 test_expect_success 'git diff-index --cached HEAD' '
 	git diff-index --exit-code --cached HEAD
-	test $? = 0
 '
 test_expect_success 'git diff-index --cached HEAD^' '
-	git diff-index --exit-code --cached HEAD^
-	test $? = 1
+	test_expect_code 1 git diff-index --exit-code --cached HEAD^
 '
 test_expect_success 'git diff-index --cached HEAD^' '
 	echo text >>b &&
 	echo 3 >c &&
-	git add . && {
-		git diff-index --exit-code --cached HEAD^
-		test $? = 1
-	}
+	git add . &&
+	test_expect_code 1 git diff-index --exit-code --cached HEAD^
 '
 test_expect_success 'git diff-tree -Stext HEAD^ HEAD -- b' '
-	git commit -m "text in b" && {
-		git diff-tree -p --exit-code -Stext HEAD^ HEAD -- b
-		test $? = 1
-	}
+	git commit -m "text in b" &&
+	test_expect_code 1 git diff-tree -p --exit-code -Stext HEAD^ HEAD -- b
 '
 test_expect_success 'git diff-tree -Snot-found HEAD^ HEAD -- b' '
 	git diff-tree -p --exit-code -Snot-found HEAD^ HEAD -- b
-	test $? = 0
 '
 test_expect_success 'git diff-files' '
-	echo 3 >>c && {
-		git diff-files --exit-code
-		test $? = 1
-	}
+	echo 3 >>c &&
+	test_expect_code 1 git diff-files --exit-code
 '
 test_expect_success 'git diff-index --cached HEAD' '
-	git update-index c && {
-		git diff-index --exit-code --cached HEAD
-		test $? = 1
-	}
+	git update-index c &&
+	test_expect_code 1 git diff-index --exit-code --cached HEAD
 '
 
 test_expect_success '--check --exit-code returns 0 for no difference' '
@@ -100,30 +83,26 @@ test_expect_success '--check --exit-code returns 0 for no difference' '
 test_expect_success '--check --exit-code returns 1 for a clean difference' '
 
 	echo "good" > a &&
-	git diff --check --exit-code
-	test $? = 1
+	test_expect_code 1 git diff --check --exit-code
 
 '
 
 test_expect_success '--check --exit-code returns 3 for a dirty difference' '
 
 	echo "bad   " >> a &&
-	git diff --check --exit-code
-	test $? = 3
+	test_expect_code 3 git diff --check --exit-code
 
 '
 
 test_expect_success '--check with --no-pager returns 2 for dirty difference' '
 
-	git --no-pager diff --check
-	test $? = 2
+	test_expect_code 2 git --no-pager diff --check
 
 '
 
 test_expect_success 'check should test not just the last line' '
 	echo "" >>a &&
-	git --no-pager diff --check
-	test $? = 2
+	test_expect_code 2 git --no-pager diff --check
 
 '
 
@@ -133,10 +112,8 @@ test_expect_success 'check detects leftover conflict markers' '
 	echo binary >>b &&
 	git commit -m "side" b &&
 	test_must_fail git merge master &&
-	git add b && (
-		git --no-pager diff --cached --check >test.out
-		test $? = 2
-	) &&
+	git add b &&
+	test_expect_code 2 git --no-pager diff --cached --check >test.out &&
 	test 3 = $(grep "conflict marker" test.out | wc -l) &&
 	git reset --hard
 '
@@ -145,20 +122,14 @@ test_expect_success 'check honors conflict marker length' '
 	git reset --hard &&
 	echo ">>>>>>> boo" >>b &&
 	echo "======" >>a &&
-	git diff --check a &&
-	(
-		git diff --check b
-		test $? = 2
-	) &&
+	git diff --check a
+	test_expect_code 2 git diff --check b &&
 	git reset --hard &&
 	echo ">>>>>>>> boo" >>b &&
 	echo "========" >>a &&
 	git diff --check &&
 	echo "b conflict-marker-size=8" >.gitattributes &&
-	(
-		git diff --check b
-		test $? = 2
-	) &&
+	test_expect_code 2 git diff --check b &&
 	git diff --check a &&
 	git reset --hard
 '
-- 
1.7.3.1.66.gab790
