Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DACECC6FA8E
	for <git@archiver.kernel.org>; Tue, 28 Feb 2023 18:57:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjB1S5D (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Feb 2023 13:57:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjB1S47 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2023 13:56:59 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A327234025
        for <git@vger.kernel.org>; Tue, 28 Feb 2023 10:56:56 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-536cb268ab8so231733157b3.17
        for <git@vger.kernel.org>; Tue, 28 Feb 2023 10:56:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1MkopZfLPXahIQVKEC5ptnb/+EmnusHEQ6NScH519X8=;
        b=W0L0xBzqkq2JgDCKnFTACMQBnjgY/hmZBJDNrUci4hj0i2VxdDNRiOr8qLl7I3EZjX
         /kXshHBzJIaH8XYnV10A12EUlkYdGRCHE2mtd7/Al5fvyMQ9Q+dIbNaCLpY6ruS7GE+d
         0EGRhTdMDxZmPKmDlHCALkstmDgVcdnhbSVGIpWtfzHVBKrBczVVpJc4ejjwrvRxp/gC
         V+aSLbBi8nQEUwgYZ6cZ5bS2RgNQcoQOWvOQ3P23B9nl7CSnT2R0c75T7N8Nfy72knWu
         ehYBmniPyMutEMsmw3wzKmHDFS0N9lnBYJZ/6p+q+Otrxst9Drl1We4V3O6yoE6/sTl5
         YKBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1MkopZfLPXahIQVKEC5ptnb/+EmnusHEQ6NScH519X8=;
        b=AgRKZuEA8Rcbo6QRdx6wkhZ6Dj4S7LrgVxl3U65k0fcR3J31lPCysedQv+GAO5URpd
         gJ0rV7SDbuhO6JG8H2tbeA/h7e/jBYEoU7qsD+w6ZaqoqDG0U3MrzB7rEhtZHZ8eb1XF
         /dnJ5qdnE99wCLJTsXa0PJR/Looh382EAtI9MMqsY7j4V8cwX/zNtX98wewT1zgwevrR
         rTocwJv44H0jw9rkA7vSm4QNJQM4henwYxGtNwzL6Wz+jdW2C2YtY4R124s5Pt2+CuTn
         2/O2we+gMzjG5Psn1CjjVtu/1Xh70LA3Z5ZkVXpuxtCs/Qj2ILkSJ12i4X1pZ6DNC/Ms
         RNwg==
X-Gm-Message-State: AO0yUKUlkNfQdd3jCuG4nM3cymgyaMTep1kj+FjVmmNrNKVj6iYh/JMJ
        b/d/jKVj2uu9ql2KqJZDy9Jl9saVBbpWr7AdSK2O7xm7NzHXg0iqwYK1YRsotC+ylhaV4BKnEgn
        78ADihK+n8H4CodgGVJ4NfGnxcaAGQ+qG5vv/ImaDprIgyVfXNZOrz7X8a8GdrImvOA==
X-Google-Smtp-Source: AK7set/YglQboLaDk2/tB5dVf0rsHp7bQTW3bJbwrGddnOw7jzyuXtCagwU1EYsvMhWY6A8MqLPYf+BX5aPC1tw=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a05:6902:1247:b0:90d:a6c0:6870 with SMTP
 id t7-20020a056902124700b0090da6c06870mr11329370ybu.2.1677610615796; Tue, 28
 Feb 2023 10:56:55 -0800 (PST)
Date:   Tue, 28 Feb 2023 18:56:40 +0000
In-Reply-To: <20230228185253.2356546-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230213182134.2173280-1-calvinwan@google.com>
X-Mailer: git-send-email 2.39.2.722.g9855ee24e9-goog
Message-ID: <20230228185642.2357806-4-calvinwan@google.com>
Subject: [PATCH v2 4/6] tests: use `git submodule add` and fix expected status
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Josh Steadmon <steadmon@google.com>, peff@peff.net,
        gitster@pobox.com, Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Josh Steadmon <steadmon@google.com>

This commit continues the previous work of updating the test suite to
use `git submodule add` to create submodules instead of using `git add`
to include embedded repositories.

In this commit, we update test cases where the expected status output
must change due to the presence of a .gitmodules file. We use the
pre-existing expected output as a template for cases where .gitmodules
has been modified but not committed.

Signed-off-by: Josh Steadmon <steadmon@google.com>
Signed-off-by: Calvin Wan <calvinwan@google.com>
---
 t/t4027-diff-submodule.sh |  17 +++--
 t/t7508-status.sh         | 134 ++++++++++++++++++++++++++++++++------
 2 files changed, 128 insertions(+), 23 deletions(-)

diff --git a/t/t4027-diff-submodule.sh b/t/t4027-diff-submodule.sh
index 40164ae07d..2ee9f18b38 100755
--- a/t/t4027-diff-submodule.sh
+++ b/t/t4027-diff-submodule.sh
@@ -18,7 +18,8 @@ test_expect_success setup '
 
 	test_tick &&
 	echo frotz >nitfol &&
-	git add nitfol sub &&
+	git add nitfol &&
+	git submodule add ./sub &&
 	git commit -m superproject &&
 
 	(
@@ -122,25 +123,30 @@ test_expect_success 'git diff HEAD with dirty submodule (work tree, refs match)'
 '
 
 test_expect_success 'git diff HEAD with dirty submodule (work tree, refs match) [.gitmodules]' '
+	git branch pristine-gitmodules &&
 	git config diff.ignoreSubmodules dirty &&
 	git diff HEAD >actual &&
 	test_must_be_empty actual &&
 	git config --add -f .gitmodules submodule.subname.ignore none &&
 	git config --add -f .gitmodules submodule.subname.path sub &&
+	git commit -m "Update .gitmodules" .gitmodules &&
 	git diff HEAD >actual &&
 	sed -e "1,/^@@/d" actual >actual.body &&
 	expect_from_to >expect.body $subprev $subprev-dirty &&
 	test_cmp expect.body actual.body &&
 	git config -f .gitmodules submodule.subname.ignore all &&
 	git config -f .gitmodules submodule.subname.path sub &&
+	git commit -m "Update .gitmodules" .gitmodules &&
 	git diff HEAD >actual2 &&
 	test_must_be_empty actual2 &&
 	git config -f .gitmodules submodule.subname.ignore untracked &&
+	git commit -m "Update .gitmodules" .gitmodules &&
 	git diff HEAD >actual3 &&
 	sed -e "1,/^@@/d" actual3 >actual3.body &&
 	expect_from_to >expect.body $subprev $subprev-dirty &&
 	test_cmp expect.body actual3.body &&
 	git config -f .gitmodules submodule.subname.ignore dirty &&
+	git commit -m "Update .gitmodules" .gitmodules &&
 	git diff HEAD >actual4 &&
 	test_must_be_empty actual4 &&
 	git config submodule.subname.ignore none &&
@@ -152,7 +158,7 @@ test_expect_success 'git diff HEAD with dirty submodule (work tree, refs match)
 	git config --remove-section submodule.subname &&
 	git config --remove-section -f .gitmodules submodule.subname &&
 	git config --unset diff.ignoreSubmodules &&
-	rm .gitmodules
+	git reset --hard pristine-gitmodules
 '
 
 test_expect_success 'git diff HEAD with dirty submodule (index, refs match)' '
@@ -190,12 +196,15 @@ test_expect_success 'git diff HEAD with dirty submodule (untracked, refs match)'
 test_expect_success 'git diff HEAD with dirty submodule (untracked, refs match) [.gitmodules]' '
 	git config --add -f .gitmodules submodule.subname.ignore all &&
 	git config --add -f .gitmodules submodule.subname.path sub &&
+	git commit -m "Update .gitmodules" .gitmodules &&
 	git diff HEAD >actual2 &&
 	test_must_be_empty actual2 &&
 	git config -f .gitmodules submodule.subname.ignore untracked &&
+	git commit -m "Update .gitmodules" .gitmodules &&
 	git diff HEAD >actual3 &&
 	test_must_be_empty actual3 &&
 	git config -f .gitmodules submodule.subname.ignore dirty &&
+	git commit -m "Update .gitmodules" .gitmodules &&
 	git diff HEAD >actual4 &&
 	test_must_be_empty actual4 &&
 	git config submodule.subname.ignore none &&
@@ -206,7 +215,7 @@ test_expect_success 'git diff HEAD with dirty submodule (untracked, refs match)
 	test_cmp expect.body actual.body &&
 	git config --remove-section submodule.subname &&
 	git config --remove-section -f .gitmodules submodule.subname &&
-	rm .gitmodules
+	git reset --hard pristine-gitmodules
 '
 
 test_expect_success 'git diff between submodule commits' '
@@ -243,7 +252,7 @@ test_expect_success 'git diff between submodule commits [.gitmodules]' '
 	expect_from_to >expect.body $subtip $subprev &&
 	git config --remove-section submodule.subname &&
 	git config --remove-section -f .gitmodules submodule.subname &&
-	rm .gitmodules
+	git reset --hard pristine-gitmodules
 '
 
 test_expect_success 'git diff (empty submodule dir)' '
diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index 2b7ef6c41a..5808339997 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -892,7 +892,7 @@ test_expect_success 'setup status submodule summary' '
 		git add foo &&
 		git commit -m "Add foo"
 	) &&
-	git add sm
+	git submodule add ./sm
 '
 
 test_expect_success 'status submodule summary is disabled by default' '
@@ -904,6 +904,7 @@ and have 1 and 2 different commits each, respectively.
 
 Changes to be committed:
   (use "git restore --staged <file>..." to unstage)
+	new file:   .gitmodules
 	new file:   dir2/added
 	new file:   sm
 
@@ -931,6 +932,7 @@ test_expect_success 'status --untracked-files=all does not show submodule' '
 '
 
 cat >expect <<EOF
+A  .gitmodules
  M dir1/modified
 A  dir2/added
 A  sm
@@ -961,6 +963,7 @@ and have 1 and 2 different commits each, respectively.
 
 Changes to be committed:
   (use "git restore --staged <file>..." to unstage)
+	new file:   .gitmodules
 	new file:   dir2/added
 	new file:   sm
 
@@ -998,6 +1001,7 @@ test_expect_success 'commit with submodule summary ignores status.displayComment
 '
 
 cat >expect <<EOF
+A  .gitmodules
  M dir1/modified
 A  dir2/added
 A  sm
@@ -1068,6 +1072,7 @@ and have 2 and 2 different commits each, respectively.
 
 Changes to be committed:
   (use "git restore --source=HEAD^1 --staged <file>..." to unstage)
+	new file:   .gitmodules
 	new file:   dir2/added
 	new file:   sm
 
@@ -1134,7 +1139,6 @@ Submodule changes to be committed:
 
 Untracked files:
   (use "git add <file>..." to include in what will be committed)
-	.gitmodules
 	dir1/untracked
 	dir2/modified
 	dir2/untracked
@@ -1152,8 +1156,37 @@ test_expect_success '.gitmodules ignore=untracked suppresses submodules with unt
 	test_cmp expect output &&
 	git config --add -f .gitmodules submodule.subname.ignore untracked &&
 	git config --add -f .gitmodules submodule.subname.path sm &&
+	cat > expect-modified-gitmodules << EOF &&
+On branch main
+Your branch and '\''upstream'\'' have diverged,
+and have 2 and 2 different commits each, respectively.
+  (use "git pull" to merge the remote branch into yours)
+
+Changes to be committed:
+  (use "git restore --staged <file>..." to unstage)
+	modified:   sm
+
+Changes not staged for commit:
+  (use "git add <file>..." to update what will be committed)
+  (use "git restore <file>..." to discard changes in working directory)
+	modified:   .gitmodules
+	modified:   dir1/modified
+
+Submodule changes to be committed:
+
+* sm $head...$new_head (1):
+  > Add bar
+
+Untracked files:
+  (use "git add <file>..." to include in what will be committed)
+	dir1/untracked
+	dir2/modified
+	dir2/untracked
+	untracked
+
+EOF
 	git status >output &&
-	test_cmp expect output &&
+	test_cmp expect-modified-gitmodules output &&
 	git config -f .gitmodules  --remove-section submodule.subname
 '
 
@@ -1163,7 +1196,7 @@ test_expect_success '.git/config ignore=untracked suppresses submodules with unt
 	git config --add submodule.subname.ignore untracked &&
 	git config --add submodule.subname.path sm &&
 	git status >output &&
-	test_cmp expect output &&
+	test_cmp expect-modified-gitmodules output &&
 	git config --remove-section submodule.subname &&
 	git config --remove-section -f .gitmodules submodule.subname
 '
@@ -1180,7 +1213,7 @@ test_expect_success '.gitmodules ignore=dirty suppresses submodules with untrack
 	git config --add -f .gitmodules submodule.subname.ignore dirty &&
 	git config --add -f .gitmodules submodule.subname.path sm &&
 	git status >output &&
-	test_cmp expect output &&
+	test_cmp expect-modified-gitmodules output &&
 	git config -f .gitmodules  --remove-section submodule.subname
 '
 
@@ -1190,7 +1223,7 @@ test_expect_success '.git/config ignore=dirty suppresses submodules with untrack
 	git config --add submodule.subname.ignore dirty &&
 	git config --add submodule.subname.path sm &&
 	git status >output &&
-	test_cmp expect output &&
+	test_cmp expect-modified-gitmodules output &&
 	git config --remove-section submodule.subname &&
 	git config -f .gitmodules  --remove-section submodule.subname
 '
@@ -1205,7 +1238,7 @@ test_expect_success '.gitmodules ignore=dirty suppresses submodules with modifie
 	git config --add -f .gitmodules submodule.subname.ignore dirty &&
 	git config --add -f .gitmodules submodule.subname.path sm &&
 	git status >output &&
-	test_cmp expect output &&
+	test_cmp expect-modified-gitmodules output &&
 	git config -f .gitmodules  --remove-section submodule.subname
 '
 
@@ -1215,7 +1248,7 @@ test_expect_success '.git/config ignore=dirty suppresses submodules with modifie
 	git config --add submodule.subname.ignore dirty &&
 	git config --add submodule.subname.path sm &&
 	git status >output &&
-	test_cmp expect output &&
+	test_cmp expect-modified-gitmodules output &&
 	git config --remove-section submodule.subname &&
 	git config -f .gitmodules  --remove-section submodule.subname
 '
@@ -1245,7 +1278,6 @@ Submodule changes to be committed:
 
 Untracked files:
   (use "git add <file>..." to include in what will be committed)
-	.gitmodules
 	dir1/untracked
 	dir2/modified
 	dir2/untracked
@@ -1259,8 +1291,39 @@ EOF
 test_expect_success ".gitmodules ignore=untracked doesn't suppress submodules with modified content" '
 	git config --add -f .gitmodules submodule.subname.ignore untracked &&
 	git config --add -f .gitmodules submodule.subname.path sm &&
+	cat > expect-modified-gitmodules << EOF &&
+On branch main
+Your branch and '\''upstream'\'' have diverged,
+and have 2 and 2 different commits each, respectively.
+  (use "git pull" to merge the remote branch into yours)
+
+Changes to be committed:
+  (use "git restore --staged <file>..." to unstage)
+	modified:   sm
+
+Changes not staged for commit:
+  (use "git add <file>..." to update what will be committed)
+  (use "git restore <file>..." to discard changes in working directory)
+  (commit or discard the untracked or modified content in submodules)
+	modified:   .gitmodules
+	modified:   dir1/modified
+	modified:   sm (modified content)
+
+Submodule changes to be committed:
+
+* sm $head...$new_head (1):
+  > Add bar
+
+Untracked files:
+  (use "git add <file>..." to include in what will be committed)
+	dir1/untracked
+	dir2/modified
+	dir2/untracked
+	untracked
+
+EOF
 	git status >output &&
-	test_cmp expect output &&
+	test_cmp expect-modified-gitmodules output &&
 	git config -f .gitmodules  --remove-section submodule.subname
 '
 
@@ -1270,7 +1333,7 @@ test_expect_success ".git/config ignore=untracked doesn't suppress submodules wi
 	git config --add submodule.subname.ignore untracked &&
 	git config --add submodule.subname.path sm &&
 	git status >output &&
-	test_cmp expect output &&
+	test_cmp expect-modified-gitmodules output &&
 	git config --remove-section submodule.subname &&
 	git config -f .gitmodules  --remove-section submodule.subname
 '
@@ -1306,7 +1369,6 @@ Submodules changed but not updated:
 
 Untracked files:
   (use "git add <file>..." to include in what will be committed)
-	.gitmodules
 	dir1/untracked
 	dir2/modified
 	dir2/untracked
@@ -1318,10 +1380,45 @@ EOF
 '
 
 test_expect_success ".gitmodules ignore=untracked doesn't suppress submodule summary" '
+	cat > expect-modified-gitmodules << EOF &&
+On branch main
+Your branch and '\''upstream'\'' have diverged,
+and have 2 and 2 different commits each, respectively.
+  (use "git pull" to merge the remote branch into yours)
+
+Changes to be committed:
+  (use "git restore --staged <file>..." to unstage)
+	modified:   sm
+
+Changes not staged for commit:
+  (use "git add <file>..." to update what will be committed)
+  (use "git restore <file>..." to discard changes in working directory)
+	modified:   .gitmodules
+	modified:   dir1/modified
+	modified:   sm (new commits)
+
+Submodule changes to be committed:
+
+* sm $head...$new_head (1):
+  > Add bar
+
+Submodules changed but not updated:
+
+* sm $new_head...$head2 (1):
+  > 2nd commit
+
+Untracked files:
+  (use "git add <file>..." to include in what will be committed)
+	dir1/untracked
+	dir2/modified
+	dir2/untracked
+	untracked
+
+EOF
 	git config --add -f .gitmodules submodule.subname.ignore untracked &&
 	git config --add -f .gitmodules submodule.subname.path sm &&
 	git status >output &&
-	test_cmp expect output &&
+	test_cmp expect-modified-gitmodules output &&
 	git config -f .gitmodules  --remove-section submodule.subname
 '
 
@@ -1331,7 +1428,7 @@ test_expect_success ".git/config ignore=untracked doesn't suppress submodule sum
 	git config --add submodule.subname.ignore untracked &&
 	git config --add submodule.subname.path sm &&
 	git status >output &&
-	test_cmp expect output &&
+	test_cmp expect-modified-gitmodules output &&
 	git config --remove-section submodule.subname &&
 	git config -f .gitmodules  --remove-section submodule.subname
 '
@@ -1344,7 +1441,7 @@ test_expect_success ".gitmodules ignore=dirty doesn't suppress submodule summary
 	git config --add -f .gitmodules submodule.subname.ignore dirty &&
 	git config --add -f .gitmodules submodule.subname.path sm &&
 	git status >output &&
-	test_cmp expect output &&
+	test_cmp expect-modified-gitmodules output &&
 	git config -f .gitmodules  --remove-section submodule.subname
 '
 
@@ -1354,7 +1451,7 @@ test_expect_success ".git/config ignore=dirty doesn't suppress submodule summary
 	git config --add submodule.subname.ignore dirty &&
 	git config --add submodule.subname.path sm &&
 	git status >output &&
-	test_cmp expect output &&
+	test_cmp expect-modified-gitmodules output &&
 	git config --remove-section submodule.subname &&
 	git config -f .gitmodules  --remove-section submodule.subname
 '
@@ -1387,7 +1484,6 @@ cat > expect << EOF
 ;
 ; Untracked files:
 ;   (use "git add <file>..." to include in what will be committed)
-;	.gitmodules
 ;	dir1/untracked
 ;	dir2/modified
 ;	dir2/untracked
@@ -1420,7 +1516,6 @@ Changes not staged for commit:
 
 Untracked files:
   (use "git add <file>..." to include in what will be committed)
-	.gitmodules
 	dir1/untracked
 	dir2/modified
 	dir2/untracked
@@ -1446,11 +1541,11 @@ Changes to be committed:
 Changes not staged for commit:
   (use "git add <file>..." to update what will be committed)
   (use "git restore <file>..." to discard changes in working directory)
+	modified:   .gitmodules
 	modified:   dir1/modified
 
 Untracked files:
   (use "git add <file>..." to include in what will be committed)
-	.gitmodules
 	dir1/untracked
 	dir2/modified
 	dir2/untracked
@@ -1566,6 +1661,7 @@ Changes to be committed:
 Changes not staged for commit:
   (use "git add <file>..." to update what will be committed)
   (use "git restore <file>..." to discard changes in working directory)
+	modified:   .gitmodules
 	modified:   dir1/modified
 
 Untracked files not listed (use -u option to show untracked files)
-- 
2.39.2.722.g9855ee24e9-goog

