Return-Path: <SRS0=BxWL=AF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F44BC433DF
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 14:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A72820724
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 14:46:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pDUPFtPP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403966AbgFXOqq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Jun 2020 10:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391287AbgFXOqm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jun 2020 10:46:42 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE188C061795
        for <git@vger.kernel.org>; Wed, 24 Jun 2020 07:46:41 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id q15so2582943wmj.2
        for <git@vger.kernel.org>; Wed, 24 Jun 2020 07:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jtKNRKyNK0pm+pzvtSrLPRTWgAmrhZfAuicDx7P3gtk=;
        b=pDUPFtPPl1gCpiRa2j+eb6XVnvqPO5q7dmokMplCmtsXTkYdFk+v36+CfbJaMXDihy
         I+RLz+8Q2uyGq7R9gyoOQX3y2jkeBP9Dfdhtm75ekW7V/89l2lOfictZsu0GPsttBKpe
         OoAtHRsXQ6p/h8HfPTuLQsUAO3NKm7eKAdwcGRFBSxJVGFIaLsEAGEEEs4kpFNN9pKsV
         J6Tl0SKN4o/mB4BrO5E3yHKQvJXop2aLHOjk+dlB9Qs890ABIWU71nq+Q2BXR0PABAlE
         N0m2z9HfjSJ1nAbggn0/XA4t7+Sj/Yjfqd7QFpZxnKBSOiZ9Cbcr8ZLyPLd1a4B3hjYl
         zTzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=jtKNRKyNK0pm+pzvtSrLPRTWgAmrhZfAuicDx7P3gtk=;
        b=tmjwyCm2VwPuGOnWrh8JdZWrojToGECobFW8Yr34ikTa1U2aT8KSYAGqdlf85gFQXD
         9V/2hxsDko6nTYlwrPN9p3c8VHnwkbX325E5svRI+OyeSpwjkNkAzNqd83hqVnol5Ah8
         vTvAF0B2cDuN2IpZC2ZtI63NyZVJ8zQJUqmXqtzgK/guZyP1LZJkXSBpt+5lyeChQr+h
         toPi5lYeU1P1Lem2/Qz3d0ExzSBfwVYNXD9Lmpiu1aqcAetmNG5ikPH6Br+zQM0UPJkD
         iarRcFLkC6/hdMu07TiZ8zuWUE/2x/chG5HSH/tVrnEluxYoNKxq3XZgkIJUjBCUnp3/
         mHcw==
X-Gm-Message-State: AOAM532AcSF6bh380XXvAoWWebtBahqeAlbXkjIwcI6yn0fSqBLO0dBV
        I9yMfaTO2vDbrzY+dL51YpEwEaCTUMk=
X-Google-Smtp-Source: ABdhPJwg1lfoN6FVokvtGlmB3b3Odqo04Ce2MvGl+8GFMRCYMeawvERK7H4g6ib8ZXNx9pgh4pF3fA==
X-Received: by 2002:a05:600c:218f:: with SMTP id e15mr17228355wme.63.1593010000452;
        Wed, 24 Jun 2020 07:46:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f16sm8533893wmh.27.2020.06.24.07.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 07:46:40 -0700 (PDT)
Message-Id: <54563642dbf96fcb36993c2c2d36ebefaf220cce.1593009996.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.656.v4.git.1593009996.gitgitgadget@gmail.com>
References: <pull.656.v3.git.1592951611.gitgitgadget@gmail.com>
        <pull.656.v4.git.1593009996.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 24 Jun 2020 14:46:30 +0000
Subject: [PATCH v4 3/9] submodule: fall back to remote's HEAD for missing
 remote.<name>.branch
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     don@goodman-wilson.com, stolee@gmail.com, peff@peff.net,
        sandals@crustytoothpaste.net, Matt Rogers <mattr94@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Denton Liu <liu.denton@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Philippe Blain <levraiphilippeblain@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When `remote.<name>.branch` is not configured, `git submodule update`
currently falls back to using the branch name `master`. A much better
idea, however, is to use the remote `HEAD`: on all Git servers running
reasonably recent Git versions, the symref `HEAD` points to the main
branch.

Note: t7419 demonstrates that there _might_ be use cases out there that
_expect_ `git submodule update --remote` to update submodules to the
remote `master` branch even if the remote `HEAD` points to another
branch. Arguably, this patch makes the behavior more intuitive, but
there is a slight possibility that this might cause regressions in
obscure setups.

Even so, it should be okay to fix this behavior without anything like a
longer transition period:

- The `git submodule update --remote` command is not really common.

- Current Git's behavior when running this command is outright
  confusing, unless the remote repository's current branch _is_ `master`
  (in which case the proposed behavior matches the old behavior).

- If a user encounters a regression due to the changed behavior, the fix
  is actually trivial: setting `submodule.<name>.branch` to `master`
  will reinstate the old behavior.

Helped-by: Philippe Blain <levraiphilippeblain@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/git-submodule.txt | 12 ++++++------
 Documentation/gitmodules.txt    |  6 +++---
 builtin/submodule--helper.c     |  2 +-
 t/t7406-submodule-update.sh     | 16 ++++++++++++++++
 t/t7419-submodule-set-branch.sh |  7 +++++--
 5 files changed, 31 insertions(+), 12 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index c9ed2bf3d5..7e5f995f77 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -183,7 +183,7 @@ set-branch (-d|--default) [--] <path>::
 	Sets the default remote tracking branch for the submodule. The
 	`--branch` option allows the remote branch to be specified. The
 	`--default` option removes the submodule.<name>.branch configuration
-	key, which causes the tracking branch to default to 'master'.
+	key, which causes the tracking branch to default to the remote 'HEAD'.
 
 set-url [--] <path> <newurl>::
 	Sets the URL of the specified submodule to <newurl>. Then, it will
@@ -284,7 +284,7 @@ OPTIONS
 	`.gitmodules` for `update --remote`.  A special value of `.` is used to
 	indicate that the name of the branch in the submodule should be the
 	same name as the current branch in the current repository.  If the
-	option is not specified, it defaults to 'master'.
+	option is not specified, it defaults to the remote 'HEAD'.
 
 -f::
 --force::
@@ -322,10 +322,10 @@ OPTIONS
 	the superproject's recorded SHA-1 to update the submodule, use the
 	status of the submodule's remote-tracking branch.  The remote used
 	is branch's remote (`branch.<name>.remote`), defaulting to `origin`.
-	The remote branch used defaults to `master`, but the branch name may
-	be overridden by setting the `submodule.<name>.branch` option in
-	either `.gitmodules` or `.git/config` (with `.git/config` taking
-	precedence).
+	The remote branch used defaults to the remote `HEAD`, but the branch
+	name may be overridden by setting the `submodule.<name>.branch`
+	option in either `.gitmodules` or `.git/config` (with `.git/config`
+	taking precedence).
 +
 This works for any of the supported update procedures (`--checkout`,
 `--rebase`, etc.).  The only change is the source of the target SHA-1.
diff --git a/Documentation/gitmodules.txt b/Documentation/gitmodules.txt
index 67275fd187..539b4e1997 100644
--- a/Documentation/gitmodules.txt
+++ b/Documentation/gitmodules.txt
@@ -49,9 +49,9 @@ submodule.<name>.update::
 
 submodule.<name>.branch::
 	A remote branch name for tracking updates in the upstream submodule.
-	If the option is not specified, it defaults to 'master'.  A special
-	value of `.` is used to indicate that the name of the branch in the
-	submodule should be the same name as the current branch in the
+	If the option is not specified, it defaults to the remote 'HEAD'.
+	A special value of `.` is used to indicate that the name of the branch
+	in the submodule should be the same name as the current branch in the
 	current repository.  See the `--remote` documentation in
 	linkgit:git-submodule[1] for details.
 
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 46c03d2a12..f55f7b7704 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1981,7 +1981,7 @@ static const char *remote_submodule_branch(const char *path)
 	free(key);
 
 	if (!branch)
-		return "master";
+		return "HEAD";
 
 	if (!strcmp(branch, ".")) {
 		const char *refname = resolve_ref_unsafe("HEAD", 0, NULL, NULL);
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 4fb447a143..aa19ff3a2e 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -70,6 +70,22 @@ test_expect_success 'setup a submodule tree' '
 	)
 '
 
+test_expect_success 'update --remote falls back to using HEAD' '
+	test_create_repo main-branch-submodule &&
+	test_commit -C main-branch-submodule initial &&
+
+	test_create_repo main-branch &&
+	git -C main-branch submodule add ../main-branch-submodule &&
+	git -C main-branch commit -m add-submodule &&
+
+	git -C main-branch-submodule switch -c hello &&
+	test_commit -C main-branch-submodule world &&
+
+	git clone --recursive main-branch main-branch-clone &&
+	git -C main-branch-clone submodule update --remote main-branch-submodule &&
+	test_path_exists main-branch-clone/main-branch-submodule/world.t
+'
+
 test_expect_success 'submodule update detaching the HEAD ' '
 	(cd super/submodule &&
 	 git reset --hard HEAD~1
diff --git a/t/t7419-submodule-set-branch.sh b/t/t7419-submodule-set-branch.sh
index fd25f786a3..3b925c302f 100755
--- a/t/t7419-submodule-set-branch.sh
+++ b/t/t7419-submodule-set-branch.sh
@@ -52,12 +52,13 @@ test_expect_success 'test submodule set-branch --branch' '
 '
 
 test_expect_success 'test submodule set-branch --default' '
+	test_commit -C submodule c &&
 	(cd super &&
 		git submodule set-branch --default submodule &&
 		! grep branch .gitmodules &&
 		git submodule update --remote &&
 		cat <<-\EOF >expect &&
-		a
+		c
 		EOF
 		git -C submodule show -s --pretty=%s >actual &&
 		test_cmp expect actual
@@ -65,6 +66,7 @@ test_expect_success 'test submodule set-branch --default' '
 '
 
 test_expect_success 'test submodule set-branch -b' '
+	test_commit -C submodule b &&
 	(cd super &&
 		git submodule set-branch -b topic submodule &&
 		grep "branch = topic" .gitmodules &&
@@ -78,12 +80,13 @@ test_expect_success 'test submodule set-branch -b' '
 '
 
 test_expect_success 'test submodule set-branch -d' '
+	test_commit -C submodule d &&
 	(cd super &&
 		git submodule set-branch -d submodule &&
 		! grep branch .gitmodules &&
 		git submodule update --remote &&
 		cat <<-\EOF >expect &&
-		a
+		d
 		EOF
 		git -C submodule show -s --pretty=%s >actual &&
 		test_cmp expect actual
-- 
gitgitgadget

