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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 915C6C64E75
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 15:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 553E020715
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 15:08:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D5nhKZr7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389595AbgKXPHj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Nov 2020 10:07:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389084AbgKXPHi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Nov 2020 10:07:38 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D32EBC0613D6
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 07:07:37 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id a65so3215819wme.1
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 07:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=MkFqOJuWMH4ERXouqLxuQMPLWBPdoS5jNAFLvyF+QxI=;
        b=D5nhKZr76G3a6J2j06P1HWr+LKpqKLDwnxDaMJmhpNQ79Bn4MruB62oad1V5jqQJsO
         t/RFXHNQqhqXj//RHMF1cCSC8nmuCuV5gJE9JPHtWjl+FHB7+/Zj2jIbi8Yr2H7wYUGl
         4h4PcudUXQdvDA1lQgOXZ0196zXPTGD2B63+PR84CL8th1dwY8iLGcYHCnGJzS/A9C7v
         x1H1UdQb45g3arpeKj8oBu9W3mUEUXUyH1Z1+GwJ3wkMJ+e2Vsu4Mmfr5h3Fkv7f4nnq
         uRkyLISOQuHsNC64IS9Z1d9gOZjEFsr77Gliov3o55qxEb1SpttSlRAp3JgoLMxUajkD
         HIDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=MkFqOJuWMH4ERXouqLxuQMPLWBPdoS5jNAFLvyF+QxI=;
        b=Gzq/Ns3S1yn+BosxaOorPCU4VESVLWeI+qcUyk2KvjTvQTHyxd5eM6RPj6zmo1R3MP
         hwpHuEJgq+4EZ2v+K/LAy8poXYmzfdduoprwb/NprTXD39uofmgwTRm32mGBfoUPX+y9
         Xf4i9qKUbeXJwvJE6cvv1JAX6paV+xToqesPQAqlJVOZTrvikZXpS3G9pKGIsCPuXN4r
         25qi0B9J5yQLYT4u9d2HrHOFcOxca72S3JLJsBOLwywr9qx0u08CIxpTmdjrbMM/wjry
         iWt82Akj5bVSA4vidpkfegqdGJJmxpJGS6aSEVwpAlwV5MrYKfKwC/785c/edHB68Umy
         SD8Q==
X-Gm-Message-State: AOAM533NjDBBrSAD7Vg1TF1rfP31/TmnsSPCVi6oO+pFqLV7Ic37G/Ew
        inwTU7LVCV7HI6heN3XeP/8krukisC0=
X-Google-Smtp-Source: ABdhPJykrB6K/cSlmlKv7y9jkoWAnaup0pnPpQhj6WT3PMe79Kxep7nyXAia1YzaHj5YzWAiZHvxZw==
X-Received: by 2002:a1c:f619:: with SMTP id w25mr4995896wmc.55.1606230456321;
        Tue, 24 Nov 2020 07:07:36 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 17sm8196170wma.3.2020.11.24.07.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 07:07:35 -0800 (PST)
Message-Id: <87c93068771238a65d0753cc41261c2a97ca4fd9.1606230450.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.921.v3.git.git.1606230450.gitgitgadget@gmail.com>
References: <pull.921.v2.git.git.1606173607.gitgitgadget@gmail.com>
        <pull.921.v3.git.git.1606230450.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 24 Nov 2020 15:07:29 +0000
Subject: [PATCH v3 4/4] init: provide useful advice about init.defaultBranch
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

To give ample warning for users wishing to override Git's the fall-back
for an unconfigured `init.defaultBranch` (in case we decide to change it
in a future Git version), let's introduce some advice that is shown upon
`git init` when that value is not set.

Note: two test cases in Git's test suite want to verify that the
`stderr` output of `git init` is empty. It is now necessary to suppress
the advice using the newly-added `advice.defaultBranchName` setting.
While not strictly necessary, we also set this to `false` in
`test_create_repo()`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 advice.c                |  1 +
 advice.h                |  1 +
 refs.c                  | 23 ++++++++++++++++++++++-
 t/t0001-init.sh         |  9 ++++++++-
 t/t1510-repo-setup.sh   |  2 +-
 t/test-lib-functions.sh |  3 ++-
 6 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/advice.c b/advice.c
index 164742305f..8a14640193 100644
--- a/advice.c
+++ b/advice.c
@@ -108,6 +108,7 @@ static struct {
 	[ADVICE_AM_WORK_DIR] 				= { "amWorkDir", 1 },
 	[ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME] 	= { "checkoutAmbiguousRemoteBranchName", 1 },
 	[ADVICE_COMMIT_BEFORE_MERGE]			= { "commitBeforeMerge", 1 },
+	[ADVICE_DEFAULT_BRANCH_NAME]			= { "defaultBranchName", 1 },
 	[ADVICE_DETACHED_HEAD]				= { "detachedHead", 1 },
 	[ADVICE_FETCH_SHOW_FORCED_UPDATES]		= { "fetchShowForcedUpdates", 1 },
 	[ADVICE_GRAFT_FILE_DEPRECATED]			= { "graftFileDeprecated", 1 },
diff --git a/advice.h b/advice.h
index bc2432980a..1ae99a1b31 100644
--- a/advice.h
+++ b/advice.h
@@ -46,6 +46,7 @@ extern int advice_add_empty_pathspec;
 	ADVICE_AM_WORK_DIR,
 	ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME,
 	ADVICE_COMMIT_BEFORE_MERGE,
+	ADVICE_DEFAULT_BRANCH_NAME,
 	ADVICE_DETACHED_HEAD,
 	ADVICE_FETCH_SHOW_FORCED_UPDATES,
 	ADVICE_GRAFT_FILE_DEPRECATED,
diff --git a/refs.c b/refs.c
index 8df03122d6..c56bc1bcfb 100644
--- a/refs.c
+++ b/refs.c
@@ -18,6 +18,7 @@
 #include "strvec.h"
 #include "repository.h"
 #include "sigchain.h"
+#include "advice.h"
 
 /*
  * List of all available backends
@@ -562,6 +563,23 @@ void expand_ref_prefix(struct strvec *prefixes, const char *prefix)
 		strvec_pushf(prefixes, *p, len, prefix);
 }
 
+static const char default_branch_name_advice[] = N_(
+"Using '%s' as the name for the initial branch. This default branch name\n"
+"is subject to change. To suppress this warning, run:\n"
+"\n"
+"\tgit config --global advice.defaultBranchName false\n"
+"\n"
+"Alternatively, you can configure the initial branch name to use in all\n"
+"of your new repositories, which will also suppress this warning:\n"
+"\n"
+"\tgit config --global init.defaultBranch <name>\n"
+"\n"
+"Common names are 'main', 'trunk' and 'development'. The initial branch\n"
+"that was created can be renamed via this command:\n"
+"\n"
+"\tgit branch -m <name>\n"
+);
+
 char *repo_default_branch_name(struct repository *r, int quiet)
 {
 	const char *config_key = "init.defaultbranch";
@@ -574,8 +592,11 @@ char *repo_default_branch_name(struct repository *r, int quiet)
 	else if (repo_config_get_string(r, config_key, &ret) < 0)
 		die(_("could not retrieve `%s`"), config_display_key);
 
-	if (!ret)
+	if (!ret) {
 		ret = xstrdup("master");
+		if (!quiet && advice_enabled(ADVICE_DEFAULT_BRANCH_NAME))
+			advise(_(default_branch_name_advice), ret);
+	}
 
 	full_ref = xstrfmt("refs/heads/%s", ret);
 	if (check_refname_format(full_ref, 0))
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index bb23e56a16..84047ac64e 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -163,7 +163,7 @@ test_expect_success 'reinit' '
 	(
 		mkdir again &&
 		cd again &&
-		git init >out1 2>err1 &&
+		git -c advice.defaultBranchName=false init >out1 2>err1 &&
 		git init >out2 2>err2
 	) &&
 	test_i18ngrep "Initialized empty" again/out1 &&
@@ -558,6 +558,13 @@ test_expect_success 'overridden default initial branch name (config)' '
 	grep nmb actual
 '
 
+test_expect_success 'advice on unconfigured init.defaultBranch' '
+	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME= git -c color.advice=always \
+		init unconfigured-default-branch-name 2>err &&
+	test_decode_color <err >decoded &&
+	test_i18ngrep "<YELLOW>hint: " decoded
+'
+
 test_expect_success 'overridden default main branch name (env)' '
 	test_config_global init.defaultBranch nmb &&
 	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=env git init main-branch-env &&
diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index 9974457f56..5305566167 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -79,7 +79,7 @@ setup_repo () {
 	name=$1 worktreecfg=$2 gitfile=$3 barecfg=$4 &&
 	sane_unset GIT_DIR GIT_WORK_TREE &&
 
-	git init "$name" &&
+	git -c advice.defaultBranchName=false init "$name" &&
 	maybe_config "$name/.git/config" core.worktree "$worktreecfg" &&
 	maybe_config "$name/.git/config" core.bare "$barecfg" &&
 	mkdir -p "$name/sub/sub" &&
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 59bbf75e83..781d47a4bb 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1202,7 +1202,8 @@ test_create_repo () {
 	mkdir -p "$repo"
 	(
 		cd "$repo" || error "Cannot setup test environment"
-		"${GIT_TEST_INSTALLED:-$GIT_EXEC_PATH}/git$X" init \
+		"${GIT_TEST_INSTALLED:-$GIT_EXEC_PATH}/git$X" \
+			-c advice.defaultBranchName=false init \
 			"--template=$GIT_BUILD_DIR/templates/blt/" >&3 2>&4 ||
 		error "cannot run git init -- have you built things yet?"
 		mv .git/hooks .git/hooks-disabled
-- 
gitgitgadget
