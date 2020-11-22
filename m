Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C06BC56202
	for <git@archiver.kernel.org>; Sun, 22 Nov 2020 23:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0257E20776
	for <git@archiver.kernel.org>; Sun, 22 Nov 2020 23:23:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OOXZ9thY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbgKVXXd (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Nov 2020 18:23:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbgKVXXd (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Nov 2020 18:23:33 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCDEAC061A4A
        for <git@vger.kernel.org>; Sun, 22 Nov 2020 15:23:32 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id h21so15717262wmb.2
        for <git@vger.kernel.org>; Sun, 22 Nov 2020 15:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=HIXWg5NASEJYPPFPRKFNmHdYeJbKX8MR2xWBJPTNR6M=;
        b=OOXZ9thYGw24XRqv97HPK8odtTd6Uf8FF1RAKn9kogK0h0sz41BTPXGvtQqsok/GHT
         kj6UDctW+L32PQhv+6h+LSeRKjF7I/TJlbMrWsoEPOSpVu3q4SZeauj4s9nilIl8fjhH
         ZtTadKLFyoCdD5Ph8g00jTRCCMsnegXMkp7v0BNbSOgsyvmuG0fZxQYyXDT0xYbKRqzH
         LS4hgOmmci9G9hiDOj+NxKPgKl7GIfoYo+biiRPWjHh9Fc3f3QZAJP5EtiW2/MDeDDIy
         zJbEw9BiHnIUGGqG64qUnpm1/KhMBephWyhf7hZrBJBZ6Sg/rO5ch4CFzQ0qO5NfF0/d
         I/yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=HIXWg5NASEJYPPFPRKFNmHdYeJbKX8MR2xWBJPTNR6M=;
        b=gTiSt+JQj4zFN647sj3KfktPZ+PoZ7Mb+tO4C3ffrmhu286hC5RxFQa9KD0M1+gfyp
         kMejWhUd/MXvkdWp54wGoEzFl4JBl7kUNGPEWHYo383t4I7VnmcVCRCyOvqrt4jh+bio
         jJ7/3m33sxbPuzklKzMCtOxEmewqfvovto+rfhiugzVxdvvaTVZt8PR469RZt0fquSDB
         JPEk4CDVL+jpNFj+wCDiwBTvYKYA/oRSPIm4n9WeJ5p3mDbeJhEeRqEU4x767nXBIs9r
         6BkIa+aOWl2isTyGBwJVujHsJM46vrqghAVbiBNKpCcR/OiC3yaTILQ0aQk4wVb9dJI+
         3lCA==
X-Gm-Message-State: AOAM532Hyd/+uibuw1MeEM/PcQezr9fZGh3HmHatchucUDNWN0jOcnif
        it6CcsQWXW0OG9YwJurUhQQZqOczY/E=
X-Google-Smtp-Source: ABdhPJzf1jwlFNkuIfP9czEW4733s3sxNpDgZ5yjEJlUT8LM/Sni7WWBqHXazhxeuX4I7JLMxj691g==
X-Received: by 2002:a1c:b787:: with SMTP id h129mr18883776wmf.67.1606087411353;
        Sun, 22 Nov 2020 15:23:31 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l16sm15278811wrx.5.2020.11.22.15.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2020 15:23:30 -0800 (PST)
Message-Id: <253d6706e6ab97e71ec012f6de33c75f3e980701.1606087406.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.921.git.git.1606087406.gitgitgadget@gmail.com>
References: <pull.921.git.git.1606087406.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 22 Nov 2020 23:23:26 +0000
Subject: [PATCH 3/3] init: provide useful advice about init.defaultBranch
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

To give ample warning in case we decide to change the fall-back for an
unconfigured `init.defaultBranch`, let's introduce some advice that is
shown upon `git init` when that value is not set.

Note: three test cases in Git's test suite want to verify that the
`stderr` output of `git init` is empty. With this patch, that is only
true if `init.defaultBranch` is configured, so let's do exactly that in
those test cases. The same reasoning applies to `test_create_repo()`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 refs.c                        | 13 ++++++++++++-
 t/t0001-init.sh               |  9 ++++++++-
 t/t1510-repo-setup.sh         |  2 +-
 t/t7414-submodule-mistakes.sh |  2 +-
 t/test-lib-functions.sh       |  3 ++-
 5 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/refs.c b/refs.c
index 8df03122d6..61d712ca05 100644
--- a/refs.c
+++ b/refs.c
@@ -562,6 +562,14 @@ void expand_ref_prefix(struct strvec *prefixes, const char *prefix)
 		strvec_pushf(prefixes, *p, len, prefix);
 }
 
+static const char default_branch_name_advice[] = N_(
+"Using '%s' as the name for the initial branch. This name is subject\n"
+"to change. To configure the name to use as the initial branch name in\n"
+"new repositories, or to silence this warning, run:\n"
+"\n"
+"\tgit config --global init.defaultBranch <name>\n"
+);
+
 char *repo_default_branch_name(struct repository *r, int quiet)
 {
 	const char *config_key = "init.defaultbranch";
@@ -574,8 +582,11 @@ char *repo_default_branch_name(struct repository *r, int quiet)
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
index 69a320489f..754dab3bab 100755
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
diff --git a/t/t7414-submodule-mistakes.sh b/t/t7414-submodule-mistakes.sh
index f2e7df59cf..0ed02938f9 100755
--- a/t/t7414-submodule-mistakes.sh
+++ b/t/t7414-submodule-mistakes.sh
@@ -30,7 +30,7 @@ test_expect_success 'no warning when updating entry' '
 
 test_expect_success 'submodule add does not warn' '
 	test_when_finished "git rm -rf submodule .gitmodules" &&
-	git submodule add ./embed submodule 2>stderr &&
+	git -c init.defaultBranch=x submodule add ./embed submodule 2>stderr &&
 	test_i18ngrep ! warning stderr
 '
 
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 59bbf75e83..772152320a 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1202,7 +1202,8 @@ test_create_repo () {
 	mkdir -p "$repo"
 	(
 		cd "$repo" || error "Cannot setup test environment"
-		"${GIT_TEST_INSTALLED:-$GIT_EXEC_PATH}/git$X" init \
+		"${GIT_TEST_INSTALLED:-$GIT_EXEC_PATH}/git$X" \
+			-c init.defaultBranch=master init \
 			"--template=$GIT_BUILD_DIR/templates/blt/" >&3 2>&4 ||
 		error "cannot run git init -- have you built things yet?"
 		mv .git/hooks .git/hooks-disabled
-- 
gitgitgadget
