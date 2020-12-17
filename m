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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB60C1B0D8
	for <git@archiver.kernel.org>; Thu, 17 Dec 2020 01:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEDC622D74
	for <git@archiver.kernel.org>; Thu, 17 Dec 2020 01:08:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732309AbgLQBIi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 20:08:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727933AbgLQBIf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 20:08:35 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6436C06138C
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 17:07:16 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id g185so4125197wmf.3
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 17:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+lOQKUPmSBEDPkKrvskIPeD+ShJQK4Gm5nvaMGGK4kA=;
        b=mw/VOosRtaGA2l4A63lyWP0wivZRAoUOkV7HeXsJbV9erCd46sO3JVdR822DDGIANi
         eroLzZV7Er7wHLFyxhZwL6nkv+Lh6cbsRR2FRXxumzoS6OwBxaMwDmXsZALz1LSqX8uR
         pPKNBtvc6ZHvZj+nINoBGC69ot7AgGVi5l6Bshz4XqOceoMsxzk3y+veLNoe3eLiicQd
         HpGr2+KfH5BdlA8y98c3XfpX8MlJb1RXCleU8gN1uhobzOqHFQXc96s9ITupOUt0wvNm
         0wfy9NVwhBaLhhTvDXqIB/U0sZ0tFOBNgX7c7oCXeuyly2K4ocjp7/l6pCKpi+1BoOGF
         477g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+lOQKUPmSBEDPkKrvskIPeD+ShJQK4Gm5nvaMGGK4kA=;
        b=QVKo0vPJQDoRNqizstb/V6AWbxV+uTlXEpfzNXaoDs11h87IUeCl2xeINt1Fw1R7ru
         Y1keOgXCoYBIOqyMO5uG+wIE40/rVaAfNO75wo5piH6Wag1zhNGg7iFQAYRhiEheScgv
         pDwIiIYWj542rqtnfUiwetRzyeRyCLylQKrtYhE/6g+x2VDH/j7fcCo8u1S/y3QyDycE
         cDzeCOzdX175Cj/oKQiQYZs9V23mHvRRMyE9EoYzI8GJEum2PhMgj5p1u5JLFXoI1KoY
         jZsR/lmtksc7TZCbYymA1fc7qs9TYHJcvL7GcltsaH95DGzWLdd51xNV38gGOibUdO+1
         lv+Q==
X-Gm-Message-State: AOAM532C4urDskobqahXTumbV1b1T+UjAQ9ttrsSBnA3KZlj3oCcNW1j
        QiEYSX2Ap28Gbf9codLbBXFXUXwLsrU=
X-Google-Smtp-Source: ABdhPJz15AMUOygftJwn2jORGfULUQ8/LhjG4M6AEvk75oYIS4VdwsbqcicMqX1i8TtslALOEaSdzg==
X-Received: by 2002:a1c:7703:: with SMTP id t3mr5872896wmi.47.1608167235398;
        Wed, 16 Dec 2020 17:07:15 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y130sm5563495wmc.22.2020.12.16.17.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 17:07:14 -0800 (PST)
Message-Id: <b8e7b6ed428b8ebd4ae7625cf818ed523535f6fd.1608167230.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.816.git.1608167230.gitgitgadget@gmail.com>
References: <pull.816.git.1608167230.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 17 Dec 2020 01:07:03 +0000
Subject: [PATCH 04/11] t3203: complete the transition to using the branch name
 `main`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In 66713e84e71 (tests: prepare aligned mentions of the default branch
name, 2020-10-23), we started that transition, trying to prepare for a
time when `git init` would use that name for the initial branch.

Even if that time has not arrived, we can complete the transition by
making the test script independent of the default branch name. This also
allows us to drop the `PREPARE_FOR_MAIN_BRANCH` prereq from one test
case.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t3203-branch-output.sh | 43 ++++++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 21 deletions(-)

diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
index d65586541d2..b945faf4702 100755
--- a/t/t3203-branch-output.sh
+++ b/t/t3203-branch-output.sh
@@ -8,6 +8,7 @@ test_expect_success 'make commits' '
 	echo content >file &&
 	git add file &&
 	git commit -m one &&
+	git branch -M main &&
 	echo content >>file &&
 	git commit -a -m two
 '
@@ -26,7 +27,7 @@ test_expect_success 'make remote branches' '
 cat >expect <<'EOF'
   branch-one
   branch-two
-* master
+* main
 EOF
 test_expect_success 'git branch shows local branches' '
 	git branch >actual &&
@@ -60,7 +61,7 @@ test_expect_success 'git branch -r shows remote branches' '
 cat >expect <<'EOF'
   branch-one
   branch-two
-* master
+* main
   remotes/origin/HEAD -> origin/branch-one
   remotes/origin/branch-one
   remotes/origin/branch-two
@@ -152,7 +153,7 @@ test_expect_success 'git branch shows detached HEAD properly' '
 * (HEAD detached at $(git rev-parse --short HEAD^0))
   branch-one
   branch-two
-  master
+  main
 EOF
 	git checkout HEAD^0 &&
 	git branch >actual &&
@@ -160,12 +161,12 @@ EOF
 '
 
 test_expect_success 'git branch shows detached HEAD properly after checkout --detach' '
-	git checkout master &&
+	git checkout main &&
 	cat >expect <<EOF &&
 * (HEAD detached at $(git rev-parse --short HEAD^0))
   branch-one
   branch-two
-  master
+  main
 EOF
 	git checkout --detach &&
 	git branch >actual &&
@@ -177,7 +178,7 @@ test_expect_success 'git branch shows detached HEAD properly after moving' '
 * (HEAD detached from $(git rev-parse --short HEAD))
   branch-one
   branch-two
-  master
+  main
 EOF
 	git reset --hard HEAD^1 &&
 	git branch >actual &&
@@ -189,9 +190,9 @@ test_expect_success 'git branch shows detached HEAD properly from tag' '
 * (HEAD detached at fromtag)
   branch-one
   branch-two
-  master
+  main
 EOF
-	git tag fromtag master &&
+	git tag fromtag main &&
 	git checkout fromtag &&
 	git branch >actual &&
 	test_i18ncmp expect actual
@@ -202,7 +203,7 @@ test_expect_success 'git branch shows detached HEAD properly after moving from t
 * (HEAD detached from fromtag)
   branch-one
   branch-two
-  master
+  main
 EOF
 	git reset --hard HEAD^1 &&
 	git branch >actual &&
@@ -214,7 +215,7 @@ test_expect_success 'git branch `--sort` option' '
 	* (HEAD detached from fromtag)
 	  branch-two
 	  branch-one
-	  master
+	  main
 	EOF
 	git branch --sort=objectsize >actual &&
 	test_i18ncmp expect actual
@@ -223,7 +224,7 @@ test_expect_success 'git branch `--sort` option' '
 test_expect_success 'git branch --points-at option' '
 	cat >expect <<-\EOF &&
 	  branch-one
-	  master
+	  main
 	EOF
 	git branch --points-at=branch-one >actual &&
 	test_cmp expect actual
@@ -251,7 +252,7 @@ test_expect_success 'local-branch symrefs shortened properly' '
 
 test_expect_success 'sort branches, ignore case' '
 	(
-		git init sort-icase &&
+		git init -b main sort-icase &&
 		cd sort-icase &&
 		test_commit initial &&
 		git branch branch-one &&
@@ -260,14 +261,14 @@ test_expect_success 'sort branches, ignore case' '
 		cat >expected <<-\EOF &&
 		BRANCH-two
 		branch-one
-		master
+		main
 		EOF
 		test_cmp expected actual &&
 		git branch --list -i | awk "{print \$NF}" >actual &&
 		cat >expected <<-\EOF &&
 		branch-one
 		BRANCH-two
-		master
+		main
 		EOF
 		test_cmp expected actual
 	)
@@ -279,7 +280,7 @@ test_expect_success 'git branch --format option' '
 	Refname is refs/heads/ambiguous
 	Refname is refs/heads/branch-one
 	Refname is refs/heads/branch-two
-	Refname is refs/heads/master
+	Refname is refs/heads/main
 	Refname is refs/heads/ref-to-branch
 	Refname is refs/heads/ref-to-remote
 	EOF
@@ -293,7 +294,7 @@ test_expect_success 'worktree colors correct' '
 	  ambiguous<RESET>
 	  branch-one<RESET>
 	+ <CYAN>branch-two<RESET>
-	  master<RESET>
+	  main<RESET>
 	  ref-to-branch<RESET> -> branch-one
 	  ref-to-remote<RESET> -> origin/branch-one
 	EOF
@@ -306,9 +307,9 @@ test_expect_success 'worktree colors correct' '
 '
 
 test_expect_success "set up color tests" '
-	echo "<RED>master<RESET>" >expect.color &&
-	echo "master" >expect.bare &&
-	color_args="--format=%(color:red)%(refname:short) --list master"
+	echo "<RED>main<RESET>" >expect.color &&
+	echo "main" >expect.bare &&
+	color_args="--format=%(color:red)%(refname:short) --list main"
 '
 
 test_expect_success '%(color) omitted without tty' '
@@ -329,9 +330,9 @@ test_expect_success '--color overrides auto-color' '
 	test_cmp expect.color actual
 '
 
-test_expect_success PREPARE_FOR_MAIN_BRANCH 'verbose output lists worktree path' '
+test_expect_success 'verbose output lists worktree path' '
 	one=$(git rev-parse --short HEAD) &&
-	two=$(git rev-parse --short master) &&
+	two=$(git rev-parse --short main) &&
 	cat >expect <<-EOF &&
 	* (HEAD detached from fromtag) $one one
 	  ambiguous                    $one one
-- 
gitgitgadget

