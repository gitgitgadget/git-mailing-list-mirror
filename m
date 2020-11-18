Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5B50C71155
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 23:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76B04246BC
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 23:45:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MRZt1fej"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbgKRXpS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Nov 2020 18:45:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726944AbgKRXpQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Nov 2020 18:45:16 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 704BEC0617A7
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 15:45:16 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id d12so4250348wrr.13
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 15:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=51oO9A7B+MXVNOVfQ40521gM4MQUo1ATNPfx9GqBqoo=;
        b=MRZt1fejW0VQUAzbQEzB/AzMgu2e+St8Fu5D4wGcBXHkV2C/uSiPLS1DiTXEW2HOn8
         7790vKk4+O2YNQYv3aEffkw0JdFfM8/ioBzTf5ujUb+kYG7B7DvTQFNuoz8kc1UajtIn
         n3bpPCmh+DGT0qqGzfCuzek3s4a5ojUBJ6ctdBMjAx4W8shC8ijEh6gAXPJSQlmOJMN7
         8fdV9pl5g/N1tTGqlxUq3/XvHOKanJhcL6GVN+8+cU8g1rHuKA00TLho2zSaUkyLgsKp
         F1hIypyMVHywonbZFK1RE5jIYBA8z389nm8nD7yM+g3g1UFwwXRbTixW0KZXPYp9mJaA
         uOKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=51oO9A7B+MXVNOVfQ40521gM4MQUo1ATNPfx9GqBqoo=;
        b=dUpKFRrl4P2kM8xW8Qnkchys0wic/mBlydVdNocqopnoI1X77jmgYBc/MJu54+MTDT
         Uk97TVF8zjnv/YVwpZZGd+Ebv+t/BTGFh0+fhwRKgctG0AgdOSz7MZR7sj/Ma5RGFMZ+
         XPpUPZUKJmAvv4ctiFWouI25decz6S7QBKuh1DV0eAaFKQqI4dJWC3rfEp2jGixMYh4E
         YYVgybJcYVpdLo7Fji6YdVLFreVFshWzNf9zo5Amp3+MTcPZZ4ryQ8o2q8R/ig8f2A67
         z3YjD7QTRLQCGoHc9kIep4zWc5dBg0Q3tcufVZG5RFkkUKN5ZHn7zi6ua9hfbux3qxJF
         J4aQ==
X-Gm-Message-State: AOAM533uVkYfigbvvDv0dYnb0LtHIH3q8N57dTfJ9Runlfbbz3jYIw43
        yvIzfheRLaTkiHTgED5rKb5uuaReZgk=
X-Google-Smtp-Source: ABdhPJxebT3iUxcK+5Xj/BUE7b7mVTUp6t17UnhTgYW9IwkLTZl7k/ijOPhBQ1EqY809MlfR45RgAA==
X-Received: by 2002:adf:fd06:: with SMTP id e6mr7290540wrr.206.1605743114946;
        Wed, 18 Nov 2020 15:45:14 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q7sm39835350wrg.95.2020.11.18.15.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 15:45:14 -0800 (PST)
Message-Id: <fb8584d993fe07b48ab8225b681d15a47872cfc1.1605743088.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.762.v3.git.1605743086.gitgitgadget@gmail.com>
References: <pull.762.v2.git.1605629547.gitgitgadget@gmail.com>
        <pull.762.v3.git.1605743086.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 18 Nov 2020 23:44:44 +0000
Subject: [PATCH v3 26/28] tests(git-p4): transition to the default branch name
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
        Jonathan Nieder <jrnieder@gmail.com>,
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
 t/t9800-git-p4-basic.sh        |  4 ++--
 t/t9801-git-p4-branch.sh       | 18 +++++++++---------
 t/t9806-git-p4-options.sh      | 20 ++++++++++----------
 t/t9807-git-p4-submit.sh       |  4 ++--
 t/t9811-git-p4-label-import.sh |  4 ++--
 5 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/t/t9800-git-p4-basic.sh b/t/t9800-git-p4-basic.sh
index c920b84778..81bc8e8da1 100755
--- a/t/t9800-git-p4-basic.sh
+++ b/t/t9800-git-p4-basic.sh
@@ -2,7 +2,7 @@
 
 test_description='git p4 tests'
 
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./lib-git-p4.sh
@@ -229,7 +229,7 @@ test_expect_success 'clone --bare should make a bare repository' '
 		git config --get --bool core.bare true &&
 		git rev-parse --verify refs/remotes/p4/master &&
 		git rev-parse --verify refs/remotes/p4/HEAD &&
-		git rev-parse --verify refs/heads/master &&
+		git rev-parse --verify refs/heads/main &&
 		git rev-parse --verify HEAD
 	)
 '
diff --git a/t/t9801-git-p4-branch.sh b/t/t9801-git-p4-branch.sh
index ebfe9d8195..56e64697a8 100755
--- a/t/t9801-git-p4-branch.sh
+++ b/t/t9801-git-p4-branch.sh
@@ -2,7 +2,7 @@
 
 test_description='git p4 tests for p4 branches'
 
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./lib-git-p4.sh
@@ -70,7 +70,7 @@ test_expect_success 'import main, no branch detection' '
 	(
 		cd "$git" &&
 		git log --oneline --graph --decorate --all &&
-		git rev-list master -- >wc &&
+		git rev-list main -- >wc &&
 		test_line_count = 4 wc
 	)
 '
@@ -81,7 +81,7 @@ test_expect_success 'import branch1, no branch detection' '
 	(
 		cd "$git" &&
 		git log --oneline --graph --decorate --all &&
-		git rev-list master -- >wc &&
+		git rev-list main -- >wc &&
 		test_line_count = 2 wc
 	)
 '
@@ -92,7 +92,7 @@ test_expect_success 'import branch2, no branch detection' '
 	(
 		cd "$git" &&
 		git log --oneline --graph --decorate --all &&
-		git rev-list master -- >wc &&
+		git rev-list main -- >wc &&
 		test_line_count = 2 wc
 	)
 '
@@ -103,7 +103,7 @@ test_expect_success 'import depot, no branch detection' '
 	(
 		cd "$git" &&
 		git log --oneline --graph --decorate --all &&
-		git rev-list master -- >wc &&
+		git rev-list main -- >wc &&
 		test_line_count = 8 wc
 	)
 '
@@ -117,7 +117,7 @@ test_expect_success 'import depot, branch detection' '
 		git log --oneline --graph --decorate --all &&
 
 		# 4 main commits
-		git rev-list master -- >wc &&
+		git rev-list main -- >wc &&
 		test_line_count = 4 wc &&
 
 		# 3 main, 1 integrate, 1 on branch2
@@ -140,7 +140,7 @@ test_expect_success 'import depot, branch detection, branchList branch definitio
 		git log --oneline --graph --decorate --all &&
 
 		# 4 main commits
-		git rev-list master -- >wc &&
+		git rev-list main -- >wc &&
 		test_line_count = 4 wc &&
 
 		# 3 main, 1 integrate, 1 on branch2
@@ -487,7 +487,7 @@ test_expect_success 'use-client-spec detect-branches files in top-level' '
 	(
 		cd "$git" &&
 		git p4 sync --detect-branches --use-client-spec //depot/usecs@all &&
-		git checkout -b master p4/usecs/b1 &&
+		git checkout -b main p4/usecs/b1 &&
 		test_path_is_file b1-file1 &&
 		test_path_is_missing b2-file2 &&
 		test_path_is_missing b1 &&
@@ -540,7 +540,7 @@ test_expect_success 'use-client-spec detect-branches skips files in branches' '
 	(
 		cd "$git" &&
 		git p4 sync --detect-branches --use-client-spec //depot/usecs@all &&
-		git checkout -b master p4/usecs/b3 &&
+		git checkout -b main p4/usecs/b3 &&
 		test_path_is_file b1-file1 &&
 		test_path_is_file b3-file3_2 &&
 		test_path_is_missing b3-file3_1
diff --git a/t/t9806-git-p4-options.sh b/t/t9806-git-p4-options.sh
index c7629b6c7d..c26d297433 100755
--- a/t/t9806-git-p4-options.sh
+++ b/t/t9806-git-p4-options.sh
@@ -2,7 +2,7 @@
 
 test_description='git p4 options'
 
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./lib-git-p4.sh
@@ -30,14 +30,14 @@ test_expect_success 'clone no --git-dir' '
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
@@ -150,22 +150,22 @@ test_expect_success 'clone --changesfile, @all' '
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
@@ -177,7 +177,7 @@ test_expect_success 'clone --max-changes' '
 	test_when_finished cleanup_git &&
 	(
 		cd "$git" &&
-		git log --oneline refs/heads/master >lines &&
+		git log --oneline refs/heads/main >lines &&
 		test_line_count = 2 lines
 	)
 '
@@ -240,7 +240,7 @@ test_expect_success 'clone --use-client-spec' '
 			git init &&
 			git config git-p4.useClientSpec true &&
 			git p4 sync //depot/... &&
-			git checkout -b master p4/master &&
+			git checkout -b main p4/master &&
 			test_path_is_file bus/dir/f4 &&
 			test_path_is_missing file1
 		)
diff --git a/t/t9807-git-p4-submit.sh b/t/t9807-git-p4-submit.sh
index f12e6f7206..7d4109f29d 100755
--- a/t/t9807-git-p4-submit.sh
+++ b/t/t9807-git-p4-submit.sh
@@ -2,7 +2,7 @@
 
 test_description='git p4 submit'
 
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./lib-git-p4.sh
@@ -117,7 +117,7 @@ test_expect_success 'submit with allowSubmit' '
 		git config git-p4.skipSubmitEdit true &&
 		git config git-p4.allowSubmit "nobranch" &&
 		test_must_fail git p4 submit &&
-		git config git-p4.allowSubmit "nobranch,master" &&
+		git config git-p4.allowSubmit "nobranch,main" &&
 		git p4 submit
 	)
 '
diff --git a/t/t9811-git-p4-label-import.sh b/t/t9811-git-p4-label-import.sh
index c53952ac14..5ac5383fb7 100755
--- a/t/t9811-git-p4-label-import.sh
+++ b/t/t9811-git-p4-label-import.sh
@@ -2,7 +2,7 @@
 
 test_description='git p4 label tests'
 
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./lib-git-p4.sh
@@ -188,7 +188,7 @@ test_expect_success 'tag that cannot be exported' '
 		git add main/f12 &&
 		git commit -m "adding f12" &&
 		git tag -m "tag on a_branch" GIT_TAG_ON_A_BRANCH &&
-		git checkout master &&
+		git checkout main &&
 		git p4 submit --export-labels
 	) &&
 	(
-- 
gitgitgadget

