Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35F51C636CC
	for <git@archiver.kernel.org>; Mon, 13 Feb 2023 18:22:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbjBMSWk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Feb 2023 13:22:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbjBMSW0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2023 13:22:26 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2236199EC
        for <git@vger.kernel.org>; Mon, 13 Feb 2023 10:22:11 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id h11-20020a17090adb8b00b00233cde95f87so3562221pjv.9
        for <git@vger.kernel.org>; Mon, 13 Feb 2023 10:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UIXNxru0UF2Rv0J4xEkgtDeaLbMVDvXFb3u7iw7mSH4=;
        b=lsWRY98Zj//daooWqGbiiH4jt91t6y9DmFrxgg0I+Z4iCAIckPnl3ULi9C7xex3cyX
         uGEZVqDvlVulmJP7GW/U9vRqObl00vnC5rTDb+po5XE9GSt3tk4V8j9tgz7mFTHycZhe
         VJsaF+DZr4OVn+87vP4Phr8h4ZSTBab3KAcmMRjJf5g7BwTyg4X0xOVM0GgWKWGTZKKh
         zWNgTge1NjZUxA2/70v06fXct67/M5o319IM5Lg3JUg5rbUxjI/cH6zOCcgsNuSLh5x/
         4iH+aJa0zytG5OTc+50uHFSfYcFd0anyGSwwxTgBcuLDAmf4IwRzxRv0okilXZMtoQcE
         HI4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UIXNxru0UF2Rv0J4xEkgtDeaLbMVDvXFb3u7iw7mSH4=;
        b=1h18yCzLx7WsieaHXZg/cNJszOCd4A1svjweEQraqTHesqyp4ZA3sD05U5McD6f2wq
         04zhC8zXek6fFnaQMziTdg8RJMklzbA1vtjjfdYWf7NivnAmskP+IJRUdCSU2UTEklH9
         K+UsaJWU+PdXkJNUGMbWJHVkF/OK9L9HmLGAlUDxQ17caXD30PY2yFTqAApC+yM10SGN
         KvFnyPwcQz6isIHyXl3wc6dvGC5F5i7SvRzbgcQL798pUFBcDxiEztwM3SoppRQA8Dle
         t0wf1DjEfdneCEVz1HLL5+Dj3WWP4EKuNLAT+DxXwewxIaeUJ97ZceXop1TaB2bH0QpZ
         Em6Q==
X-Gm-Message-State: AO0yUKWi/9B7AcWes0vGeN9yeMEOW6rE1DDDRxUJ27/KEAc66L9fqrQ+
        hf3ve36RtigsCV/f51MftyfKWABZfG50VZy8OTEPTWhf7/iElzIlUg1nna90ELziEBf2UwEfvbr
        fCGHZ9uaYk0LDyYxBD3ZWB+XmJys9isYwMy4Qn8Rqvcn6XMny+UmvU5FtTgMVKJoVnA==
X-Google-Smtp-Source: AK7set92qnjSkVqelc1ZjFrDgKrFGQeE2lit5nwlgXobsb4ka32mkYl9SL2tlli6XLaBAkFF6z7tHoFcsXmDn24=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:aa7:9576:0:b0:5a8:ab92:d78d with SMTP id
 x22-20020aa79576000000b005a8ab92d78dmr1017655pfq.22.1676312531366; Mon, 13
 Feb 2023 10:22:11 -0800 (PST)
Date:   Mon, 13 Feb 2023 18:21:33 +0000
In-Reply-To: <20230213182134.2173280-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230213182134.2173280-1-calvinwan@google.com>
X-Mailer: git-send-email 2.39.1.581.gbfd45094c4-goog
Message-ID: <20230213182134.2173280-6-calvinwan@google.com>
Subject: [RFC PATCH 5/6] tests: use `git submodule add` and fix expected status
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Josh Steadmon <steadmon@google.com>,
        Calvin Wan <calvinwan@google.com>
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
2.39.1.581.gbfd45094c4-goog

