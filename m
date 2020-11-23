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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D58AFC6379F
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 23:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EC1A206B6
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 23:20:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h8IFO6If"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgKWXUR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Nov 2020 18:20:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbgKWXUP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Nov 2020 18:20:15 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 563CAC0613CF
        for <git@vger.kernel.org>; Mon, 23 Nov 2020 15:20:15 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id c198so912958wmd.0
        for <git@vger.kernel.org>; Mon, 23 Nov 2020 15:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=S1mJYwfot+/yR0Z+YdILZrd7BIOV3xV2oa6vSLvNCSc=;
        b=h8IFO6IfK5CRER7EaeOsHp4gf81Tf7NEkcqf4BYMCyS/DHkNqJRodPSYx6cdgmXxhv
         sZlMaXWefExuvkWfv77kuqGPOgi51Go+jnTI5gaVzKfWXM21pBDrclbQlOTlvDwp/6r0
         gS8S1QjeOzfJt0v/n+eKiOlIEszhnXFqC/1kxsTm+cRjUyY6CPVfJPjWkgRw5RqEF0LG
         U7VTW+E7G7oV5Fk9j/8CGlK1TjyYClsZN82YdSdf0+ZyQhAevVf7Nh+GTooxlES6s6VB
         0vhbc4FUV7/+daWblBvQY44NTnOl2xnHjR9J8QwKsS3XS/ZESTeW9cqLeU4VM5ulWqEv
         jYTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=S1mJYwfot+/yR0Z+YdILZrd7BIOV3xV2oa6vSLvNCSc=;
        b=oVOWjQrzwO7r+KbUtN/LoXCOXME8/4yesmtrSdF2ki69PwGsEXO+y9kjlFyeNN3Y95
         Ok9Ms3p+NcEjWEwW+li3TKTvlnlchida1MTA32m+mxnsZNxOEaF4Ogq1VGK2QIohHjls
         NMElgcDwSN0KsmvBAqJXkEuQXQ4NiNw0PosPgeq38dkeoXd8EWCM0WuA5McBKzm8s3t0
         K1mgdPrWwnQXnxbMwHGjEzjbtLwrX/NgomvDvi0FJne0vscVSFSPRTBhkxclhtW4mfAL
         xv4k9HpGfCEjKavWG0bILOoGkL6Bbzrny+VscdasxTv0IO40pca0Ma/03E2sieUQ9kCw
         riXw==
X-Gm-Message-State: AOAM530vcWef2VBsrm8bSAYK5jJ+WRt51NQ2ieJngTQlM4ZusyX1gUJx
        ubSuKaNu8pLfA2M5+FmY7WP4gGahKOA=
X-Google-Smtp-Source: ABdhPJyhm7ZDD2YlGyDDBjbYvYI3fveuI3qm8mY7orvAM1/4bUniiWj7b0qa14JJgNo/+X6nbCoQUQ==
X-Received: by 2002:a1c:9ad3:: with SMTP id c202mr1157403wme.43.1606173613432;
        Mon, 23 Nov 2020 15:20:13 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u203sm1419485wme.32.2020.11.23.15.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 15:20:12 -0800 (PST)
Message-Id: <bccef953913da629057b3e9b211bc54081fa4475.1606173607.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.921.v2.git.git.1606173607.gitgitgadget@gmail.com>
References: <pull.921.git.git.1606087406.gitgitgadget@gmail.com>
        <pull.921.v2.git.git.1606173607.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 23 Nov 2020 23:20:07 +0000
Subject: [PATCH v2 4/4] init: provide useful advice about init.defaultBranch
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
`stderr` output of `git init` is empty. With this patch, that is only
true if `init.defaultBranch` is configured, so let's do exactly that in
those test cases. The same reasoning applies to `test_create_repo()`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 refs.c                  | 19 ++++++++++++++++++-
 t/t0001-init.sh         |  9 ++++++++-
 t/t1510-repo-setup.sh   |  2 +-
 t/test-lib-functions.sh |  3 ++-
 4 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index 8df03122d6..67275858fc 100644
--- a/refs.c
+++ b/refs.c
@@ -562,6 +562,20 @@ void expand_ref_prefix(struct strvec *prefixes, const char *prefix)
 		strvec_pushf(prefixes, *p, len, prefix);
 }
 
+static const char default_branch_name_advice[] = N_(
+"Using '%s' as the name for the initial branch. This default branch name\n"
+"is subject to change. To configure the initial branch name to use in all\n"
+"of your new repositories, run:\n"
+"\n"
+"\tgit config --global init.defaultBranch <name>\n"
+"\n"
+"Common names are 'main', 'trunk' and 'development'. If you merely wish\n"
+"to suppress this warning, you can also use the current default branch\n"
+"name. The current branch can be renamed via this command:\n"
+"\n"
+"\tgit branch -m <name>\n"
+);
+
 char *repo_default_branch_name(struct repository *r, int quiet)
 {
 	const char *config_key = "init.defaultbranch";
@@ -574,8 +588,11 @@ char *repo_default_branch_name(struct repository *r, int quiet)
 	else if (repo_config_get_string(r, config_key, &ret) < 0)
 		die(_("could not retrieve `%s`"), config_display_key);
 
-	if (!ret)
+	if (!ret) {
 		ret = xstrdup("master");
+		if (!quiet)
+			advise(_(default_branch_name_advice), ret);
+	}
 
 	full_ref = xstrfmt("refs/heads/%s", ret);
 	if (check_refname_format(full_ref, 0))
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 69c5ad179c..6f693d9609 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -163,7 +163,7 @@ test_expect_success 'reinit' '
 	(
 		mkdir again &&
 		cd again &&
-		git init >out1 2>err1 &&
+		git -c init.defaultBranch=initial init >out1 2>err1 &&
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
index 9974457f56..5189a520a2 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -79,7 +79,7 @@ setup_repo () {
 	name=$1 worktreecfg=$2 gitfile=$3 barecfg=$4 &&
 	sane_unset GIT_DIR GIT_WORK_TREE &&
 
-	git init "$name" &&
+	git -c init.defaultBranch=repo init "$name" &&
 	maybe_config "$name/.git/config" core.worktree "$worktreecfg" &&
 	maybe_config "$name/.git/config" core.bare "$barecfg" &&
 	mkdir -p "$name/sub/sub" &&
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 59bbf75e83..68305a4939 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1202,7 +1202,8 @@ test_create_repo () {
 	mkdir -p "$repo"
 	(
 		cd "$repo" || error "Cannot setup test environment"
-		"${GIT_TEST_INSTALLED:-$GIT_EXEC_PATH}/git$X" init \
+		"${GIT_TEST_INSTALLED:-$GIT_EXEC_PATH}/git$X" \
+			-c init.defaultBranch=${GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME-master} init \
 			"--template=$GIT_BUILD_DIR/templates/blt/" >&3 2>&4 ||
 		error "cannot run git init -- have you built things yet?"
 		mv .git/hooks .git/hooks-disabled
-- 
gitgitgadget
