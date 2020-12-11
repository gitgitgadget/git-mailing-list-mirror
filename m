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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7B02C433FE
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 11:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 722C823E20
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 11:39:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390966AbgLKLin (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Dec 2020 06:38:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389656AbgLKLiR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Dec 2020 06:38:17 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B5BC0617A6
        for <git@vger.kernel.org>; Fri, 11 Dec 2020 03:37:04 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id r14so8697236wrn.0
        for <git@vger.kernel.org>; Fri, 11 Dec 2020 03:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1Rn8cyxnpONC0mqxfOOxLsJFwOMCn/nSjYZ04AwALuQ=;
        b=XECrqD+HMrgxe3bvPzwEKsG5ufV64+Anv+KE5YAXDgcX8l/zYxQ6ZnDP08w8Yvcwbc
         GjOJ7s43rL0dbZddcz54rfhIi8/kOW4ufz6T6JmQq//3S60q4Y047o7Aer7kUPPsKp19
         xeNy0KtwfuZVA4bmYCkkAHOaIae4/q9wjsnrMS6BLhTcHcmnJsckOM002up1C/n9kh9I
         3SigNs40qcdAxYNiSxf7QdpOSuFIMMk1bTtYiiLrLKE2Cvt39K0vU0TSzWq6w3+J4m36
         XXj7HcJL3aJbOCVVrDxUrYTpUQhIiJZNiSGqeWYXNaguy1m5zCvbxscW6QRl3h/1gKXy
         AJIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1Rn8cyxnpONC0mqxfOOxLsJFwOMCn/nSjYZ04AwALuQ=;
        b=QxOy8fHM2Kn8dVaailzf5CLt0svdeJl0UTG3tXugPXnGXFx3GOf3jzZ7lhm0ztBKwY
         5y2c5uLym4IgcgFCuB9sGEjUc/diEfxoCt49w4uEji9UzEAWBI2YX0kKTO7gcjTOh5Y3
         DTkRiTW2m3qpR2tDCseE/NlQz3ThV4AaAjrUQ+iYpUgmLODNGk8DynLOFN5YdteIwJ0S
         ArIJH4E8Xxj8W4hHPLVdo5pj40Es9v/6YAkhFLJVKeEdlBhw5DwaXFZD/LDx2epLr6u7
         Avd4EP1V91XXarua3Jq/Z1yWIpS6EfqCjI60EUssTJ75uPvexOlMDafZQLZHJ5wxnSVj
         rgWw==
X-Gm-Message-State: AOAM532Yj0kC8oSEvl1EB8RNKuNJOfx9fcqp5QhZnLTzbHEh2PTvz+xA
        fyjYlgmKb2tg5yAcqUX2kOw0eZ0SBFo=
X-Google-Smtp-Source: ABdhPJxpOEr8sfhdg43wmPmkZCJxO0wiXXM6NKm+utN3zQ1Sntkgm+2E4uo+0Lw4UQu1bzKC9EtuYw==
X-Received: by 2002:adf:dc08:: with SMTP id t8mr13429239wri.195.1607686623028;
        Fri, 11 Dec 2020 03:37:03 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h2sm14921047wme.45.2020.12.11.03.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Dec 2020 03:37:02 -0800 (PST)
Message-Id: <ce26446b1a2e7bf14cdf814ca56c37b2e7d6b578.1607686618.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.921.v5.git.git.1607686618.gitgitgadget@gmail.com>
References: <pull.921.v4.git.git.1607637517.gitgitgadget@gmail.com>
        <pull.921.v5.git.git.1607686618.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 11 Dec 2020 11:36:57 +0000
Subject: [PATCH v5 4/4] init: provide useful advice about init.defaultBranch
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Felipe Contreras <felipe.contreras@gmail.com>,
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
the advice, we now do that via the `init.defaultBranch` setting. While
not strictly necessary, we also set this to `false` in
`test_create_repo()`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 refs.c                  | 18 +++++++++++++++++-
 t/t0001-init.sh         |  9 ++++++++-
 t/t1510-repo-setup.sh   |  2 +-
 t/test-lib-functions.sh |  4 +++-
 4 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index 8df03122d69..13dc2c3291b 100644
--- a/refs.c
+++ b/refs.c
@@ -562,6 +562,19 @@ void expand_ref_prefix(struct strvec *prefixes, const char *prefix)
 		strvec_pushf(prefixes, *p, len, prefix);
 }
 
+static const char default_branch_name_advice[] = N_(
+"Using '%s' as the name for the initial branch. This default branch name\n"
+"is subject to change. To configure the initial branch name to use in all\n"
+"of your new repositories, which will suppress this warning, call:\n"
+"\n"
+"\tgit config --global init.defaultBranch <name>\n"
+"\n"
+"Names commonly chosen instead of 'master' are 'main', 'trunk' and\n"
+"'development'. The just-created branch can be renamed via this command:\n"
+"\n"
+"\tgit branch -m <name>\n"
+);
+
 char *repo_default_branch_name(struct repository *r, int quiet)
 {
 	const char *config_key = "init.defaultbranch";
@@ -574,8 +587,11 @@ char *repo_default_branch_name(struct repository *r, int quiet)
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
index bb23e56a165..0803994874f 100755
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
index 9974457f561..bbfe05b8e4a 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -79,7 +79,7 @@ setup_repo () {
 	name=$1 worktreecfg=$2 gitfile=$3 barecfg=$4 &&
 	sane_unset GIT_DIR GIT_WORK_TREE &&
 
-	git init "$name" &&
+	git -c init.defaultBranch=initial init "$name" &&
 	maybe_config "$name/.git/config" core.worktree "$worktreecfg" &&
 	maybe_config "$name/.git/config" core.bare "$barecfg" &&
 	mkdir -p "$name/sub/sub" &&
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 59bbf75e832..9910102ae1f 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1202,7 +1202,9 @@ test_create_repo () {
 	mkdir -p "$repo"
 	(
 		cd "$repo" || error "Cannot setup test environment"
-		"${GIT_TEST_INSTALLED:-$GIT_EXEC_PATH}/git$X" init \
+		"${GIT_TEST_INSTALLED:-$GIT_EXEC_PATH}/git$X" -c \
+			init.defaultBranch="${GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME-master}" \
+			init \
 			"--template=$GIT_BUILD_DIR/templates/blt/" >&3 2>&4 ||
 		error "cannot run git init -- have you built things yet?"
 		mv .git/hooks .git/hooks-disabled
-- 
gitgitgadget
