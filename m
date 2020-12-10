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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08461C2BBCD
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 23:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C72F223BA7
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 23:00:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732119AbgLJW6l (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Dec 2020 17:58:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727271AbgLJWzN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Dec 2020 17:55:13 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B56C0619D5
        for <git@vger.kernel.org>; Thu, 10 Dec 2020 14:42:15 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id q75so6884267wme.2
        for <git@vger.kernel.org>; Thu, 10 Dec 2020 14:42:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=gR3Wi8MHOg1gRLpuWQSqw16pla/znuCkCkhB3wQWEEw=;
        b=fBMkVQWpPztS+tlzK7RxBLptbDGefe1o38g1RUCEnQwC6gSMGTWlGVTXTHp6f/fR1H
         o3eaYwr3/LBfQRkTZvKo1jcOutoJ3GVxokDdEdSbKInzFhSOVSnHvQdoaURyNlFy46I6
         clqCg+rKU0jUXIIxpXsUlYCQybGjgwTBIk/9pUQX8VXE9JguVodPpDqdDTt9zSUGk1ME
         hl/GSmLdRY/2U4S/m5Q0tTLVxgU6iD+yjL59teFliYyUCuwEdXZWQ5APwAVSFepbGVaH
         1GRpS/9jbFhcfGU3wpF2dCq21WmCr0XGQHBf1P3WJb9da+16C4O5woDyEaB0vc/dOjaO
         UyHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=gR3Wi8MHOg1gRLpuWQSqw16pla/znuCkCkhB3wQWEEw=;
        b=JDYqek1g0tWxFJXRO+3T2X++qW5QKszd3knZYHXWFjPhmkhfd78cmBWXl0ZjQBHiIJ
         xdhIIPkJCJxJUSfQqC8xnZ/53Ted8rijXNs6OaxohcHJtBivUIAdpRRI3TYm6IfAhwc2
         RqBmtykQjrePxwCh1oY6+gnfh3QFvRn9nAQIMQb2Ibv2YN5Z7sYpj1qXML4SUTWjW7/v
         wnCkO70BOBzbJsnKnSYeieY8GW8sJ4z4QRnpUhznRSVmXvN5JhgOHaDUtTsIQhw/uC62
         kSUoOzjM4TeLoSDOugCtUIxLehqmEK74A1LadDk05e02yYSPgLu8RX0vfCOqPt7pLXSk
         WucA==
X-Gm-Message-State: AOAM532k4+nq8ItxOvpQDOP12iCdim/h7Qb7oXW1B4rz6MdbcqXCSTLs
        w+KyBHRvzs6097WyljhaYkMZZMSu4LM=
X-Google-Smtp-Source: ABdhPJwisjDuSC08NsYzMrgq/nqzcj4RSV8/rieYXm/GH0O5bCGmdPt8wLbXkrLhWew+ItWrVDxEEA==
X-Received: by 2002:a1c:2ec6:: with SMTP id u189mr10526924wmu.31.1607637522638;
        Thu, 10 Dec 2020 13:58:42 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 65sm11229699wri.95.2020.12.10.13.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 13:58:42 -0800 (PST)
Message-Id: <2f21c505d560132b4563849f955554fc7d79a9cb.1607637517.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.921.v4.git.git.1607637517.gitgitgadget@gmail.com>
References: <pull.921.v3.git.git.1606230450.gitgitgadget@gmail.com>
        <pull.921.v4.git.git.1607637517.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 10 Dec 2020 21:58:36 +0000
Subject: [PATCH v4 4/4] init: provide useful advice about init.defaultBranch
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
index 8df03122d69..6e047b3d1b4 100644
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
+"Common names are 'main', 'trunk' and 'development'. The initial branch\n"
+"that was created can be renamed via this command:\n"
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
