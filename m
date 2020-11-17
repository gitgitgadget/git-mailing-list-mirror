Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73D15C8300B
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 16:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F0A8221F8
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 16:13:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cc3jZczD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbgKQQM5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Nov 2020 11:12:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727454AbgKQQMz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Nov 2020 11:12:55 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6919DC061A4A
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 08:12:54 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id s13so3739153wmh.4
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 08:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=c1o3HZBCJUKehk8bRkjmxh7o5ADycOrNPBk/lBevBZ0=;
        b=cc3jZczDxamTAOjkIvF4Xliv+v/sa/VboJ6WIrbTHyosxd2Lh9y8xxPLHHDV4AbDON
         qLcY9k4lB3qa94uxUsinWzBuRydQwWK4Kq+uT6KBllky3HnPElSUs2PBfXafd1dIZ/qu
         SGoBSV/eGOk0rz0U6zAxLZ+Gho9+18pRxGg+BAlanVAlDkPGD7wz2orAjZ1fd4u9+SdF
         ebUeeSrX9tz79SAheGX+FVoHPxvEMi7GiPaCrJgdeKXZQLNo9x87nJx99zbEmMJBxamE
         wDnqhI0rUmwL3mW1a0dreb1moSOz+hzF/Af7Zsc/PYlDn59vmEsw/hcX0DH0UhdVzX05
         5LNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=c1o3HZBCJUKehk8bRkjmxh7o5ADycOrNPBk/lBevBZ0=;
        b=Tm0kubZdeLdBs3tTs+KeALYwj0XZCwf0rJ9DeMvnfE5WZshMePgKgIOdIFYXaiLPty
         wWkBCy5d9gzgn9kg/xfP6jhQqNEDMGDQZkOByeEr3upBev7AoNpSb7zhhDbkHk/BwY1v
         0f3YjJiLOiL/CeUvqKzjffQfaThGGZkCjGJH/0BNPZKgX2dd++diFMH2JpKbcBclFIDS
         DWJUWVsFplMg+5QFR/jMbJXPmKz25GsYI9G0//dxTpWU4IXcAjH7illdAZu714dz62ek
         wXqEceskQvb5++I10zx9vPqOTxGdZUb3/FRh/OtOowIuuSgXIS+U4jkYLMPWurWw/qKY
         m8NQ==
X-Gm-Message-State: AOAM531ttPSfrRgXrETYzHwVlNauhTDWqJ3WuKJteByaKUl9nlTZJqeV
        nMnQXBxqcEoKNu6JMWWlBhkyggPpTYQ=
X-Google-Smtp-Source: ABdhPJzt/ixvoXKJRV79dT6nrzCPL9H6aXxqVIHi/I7zEDggPfWpx9h4/+vuMjDAGaD7gkIYc9l4LA==
X-Received: by 2002:a1c:61c5:: with SMTP id v188mr359805wmb.141.1605629572901;
        Tue, 17 Nov 2020 08:12:52 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b124sm4272729wmh.13.2020.11.17.08.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 08:12:52 -0800 (PST)
Message-Id: <4da4b69114b597cf27baee63313663ccd1d8d28c.1605629549.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.762.v2.git.1605629547.gitgitgadget@gmail.com>
References: <pull.762.git.1605221038.gitgitgadget@gmail.com>
        <pull.762.v2.git.1605629547.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 17 Nov 2020 16:12:25 +0000
Subject: [PATCH v2 25/27] tests(git-p4): transition to the default branch name
 `main`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In the previous commits, we adjusted the test suite to use the branch
name `main` for initial branches.

The `git p4`-related tests are a bit harder to adjust because `git p4`
uses the ref `refs/heads/p4/master` to track the remote branches, and
for now, we do not want to change that (this might be the subject of a
future patch series). We only need to adjust for the actual initial
branch name to be changed to `main`.

This allows us to define `GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main`
for those tests.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t9800-git-p4-basic.sh        |  2 +-
 t/t9801-git-p4-branch.sh       | 16 ++++++++--------
 t/t9806-git-p4-options.sh      | 18 +++++++++---------
 t/t9807-git-p4-submit.sh       |  2 +-
 t/t9811-git-p4-label-import.sh |  2 +-
 t/test-lib.sh                  |  2 +-
 6 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/t/t9800-git-p4-basic.sh b/t/t9800-git-p4-basic.sh
index c98c1dfc23..0c543a8708 100755
--- a/t/t9800-git-p4-basic.sh
+++ b/t/t9800-git-p4-basic.sh
@@ -226,7 +226,7 @@ test_expect_success 'clone --bare should make a bare repository' '
 		git config --get --bool core.bare true &&
 		git rev-parse --verify refs/remotes/p4/master &&
 		git rev-parse --verify refs/remotes/p4/HEAD &&
-		git rev-parse --verify refs/heads/master &&
+		git rev-parse --verify refs/heads/main &&
 		git rev-parse --verify HEAD
 	)
 '
diff --git a/t/t9801-git-p4-branch.sh b/t/t9801-git-p4-branch.sh
index a3abd778f9..94161d4b57 100755
--- a/t/t9801-git-p4-branch.sh
+++ b/t/t9801-git-p4-branch.sh
@@ -67,7 +67,7 @@ test_expect_success 'import main, no branch detection' '
 	(
 		cd "$git" &&
 		git log --oneline --graph --decorate --all &&
-		git rev-list master -- >wc &&
+		git rev-list main -- >wc &&
 		test_line_count = 4 wc
 	)
 '
@@ -78,7 +78,7 @@ test_expect_success 'import branch1, no branch detection' '
 	(
 		cd "$git" &&
 		git log --oneline --graph --decorate --all &&
-		git rev-list master -- >wc &&
+		git rev-list main -- >wc &&
 		test_line_count = 2 wc
 	)
 '
@@ -89,7 +89,7 @@ test_expect_success 'import branch2, no branch detection' '
 	(
 		cd "$git" &&
 		git log --oneline --graph --decorate --all &&
-		git rev-list master -- >wc &&
+		git rev-list main -- >wc &&
 		test_line_count = 2 wc
 	)
 '
@@ -100,7 +100,7 @@ test_expect_success 'import depot, no branch detection' '
 	(
 		cd "$git" &&
 		git log --oneline --graph --decorate --all &&
-		git rev-list master -- >wc &&
+		git rev-list main -- >wc &&
 		test_line_count = 8 wc
 	)
 '
@@ -114,7 +114,7 @@ test_expect_success 'import depot, branch detection' '
 		git log --oneline --graph --decorate --all &&
 
 		# 4 main commits
-		git rev-list master -- >wc &&
+		git rev-list main -- >wc &&
 		test_line_count = 4 wc &&
 
 		# 3 main, 1 integrate, 1 on branch2
@@ -137,7 +137,7 @@ test_expect_success 'import depot, branch detection, branchList branch definitio
 		git log --oneline --graph --decorate --all &&
 
 		# 4 main commits
-		git rev-list master -- >wc &&
+		git rev-list main -- >wc &&
 		test_line_count = 4 wc &&
 
 		# 3 main, 1 integrate, 1 on branch2
@@ -484,7 +484,7 @@ test_expect_success 'use-client-spec detect-branches files in top-level' '
 	(
 		cd "$git" &&
 		git p4 sync --detect-branches --use-client-spec //depot/usecs@all &&
-		git checkout -b master p4/usecs/b1 &&
+		git checkout -b main p4/usecs/b1 &&
 		test_path_is_file b1-file1 &&
 		test_path_is_missing b2-file2 &&
 		test_path_is_missing b1 &&
@@ -537,7 +537,7 @@ test_expect_success 'use-client-spec detect-branches skips files in branches' '
 	(
 		cd "$git" &&
 		git p4 sync --detect-branches --use-client-spec //depot/usecs@all &&
-		git checkout -b master p4/usecs/b3 &&
+		git checkout -b main p4/usecs/b3 &&
 		test_path_is_file b1-file1 &&
 		test_path_is_file b3-file3_2 &&
 		test_path_is_missing b3-file3_1
diff --git a/t/t9806-git-p4-options.sh b/t/t9806-git-p4-options.sh
index 4e794a01bf..0beae2e3f3 100755
--- a/t/t9806-git-p4-options.sh
+++ b/t/t9806-git-p4-options.sh
@@ -27,14 +27,14 @@ test_expect_success 'clone no --git-dir' '
 	test_must_fail git p4 clone --git-dir=xx //depot
 '
 
-test_expect_success 'clone --branch should checkout master' '
+test_expect_success 'clone --branch should checkout main' '
 	git p4 clone --branch=refs/remotes/p4/sb --dest="$git" //depot &&
 	test_when_finished cleanup_git &&
 	(
 		cd "$git" &&
 		git rev-parse refs/remotes/p4/sb >sb &&
-		git rev-parse refs/heads/master >master &&
-		test_cmp sb master &&
+		git rev-parse refs/heads/main >main &&
+		test_cmp sb main &&
 		git rev-parse HEAD >head &&
 		test_cmp sb head
 	)
@@ -147,22 +147,22 @@ test_expect_success 'clone --changesfile, @all' '
 	test_must_fail git p4 clone --changesfile="$TRASH_DIRECTORY/cf" --dest="$git" //depot@all
 '
 
-# imports both master and p4/master in refs/heads
+# imports both main and p4/master in refs/heads
 # requires --import-local on sync to find p4 refs/heads
-# does not update master on sync, just p4/master
+# does not update main on sync, just p4/master
 test_expect_success 'clone/sync --import-local' '
 	git p4 clone --import-local --dest="$git" //depot@1,2 &&
 	test_when_finished cleanup_git &&
 	(
 		cd "$git" &&
-		git log --oneline refs/heads/master >lines &&
+		git log --oneline refs/heads/main >lines &&
 		test_line_count = 2 lines &&
 		git log --oneline refs/heads/p4/master >lines &&
 		test_line_count = 2 lines &&
 		test_must_fail git p4 sync &&
 
 		git p4 sync --import-local &&
-		git log --oneline refs/heads/master >lines &&
+		git log --oneline refs/heads/main >lines &&
 		test_line_count = 2 lines &&
 		git log --oneline refs/heads/p4/master >lines &&
 		test_line_count = 3 lines
@@ -174,7 +174,7 @@ test_expect_success 'clone --max-changes' '
 	test_when_finished cleanup_git &&
 	(
 		cd "$git" &&
-		git log --oneline refs/heads/master >lines &&
+		git log --oneline refs/heads/main >lines &&
 		test_line_count = 2 lines
 	)
 '
@@ -237,7 +237,7 @@ test_expect_success 'clone --use-client-spec' '
 			git init &&
 			git config git-p4.useClientSpec true &&
 			git p4 sync //depot/... &&
-			git checkout -b master p4/master &&
+			git checkout -b main p4/master &&
 			test_path_is_file bus/dir/f4 &&
 			test_path_is_missing file1
 		)
diff --git a/t/t9807-git-p4-submit.sh b/t/t9807-git-p4-submit.sh
index eaaae414a1..e45104d1ef 100755
--- a/t/t9807-git-p4-submit.sh
+++ b/t/t9807-git-p4-submit.sh
@@ -114,7 +114,7 @@ test_expect_success 'submit with allowSubmit' '
 		git config git-p4.skipSubmitEdit true &&
 		git config git-p4.allowSubmit "nobranch" &&
 		test_must_fail git p4 submit &&
-		git config git-p4.allowSubmit "nobranch,master" &&
+		git config git-p4.allowSubmit "nobranch,main" &&
 		git p4 submit
 	)
 '
diff --git a/t/t9811-git-p4-label-import.sh b/t/t9811-git-p4-label-import.sh
index c1446f26ab..c722b5a176 100755
--- a/t/t9811-git-p4-label-import.sh
+++ b/t/t9811-git-p4-label-import.sh
@@ -185,7 +185,7 @@ test_expect_success 'tag that cannot be exported' '
 		git add main/f12 &&
 		git commit -m "adding f12" &&
 		git tag -m "tag on a_branch" GIT_TAG_ON_A_BRANCH &&
-		git checkout master &&
+		git checkout main &&
 		git p4 submit --export-labels
 	) &&
 	(
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 58267802f9..0ec93a2eec 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -263,7 +263,7 @@ case "$TEST_NUMBER" in
 	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
 	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 	;;
-[0-8]*|9[0-7]*)
+[0-8]*|9[0-8]*)
 	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 	;;
-- 
gitgitgadget

