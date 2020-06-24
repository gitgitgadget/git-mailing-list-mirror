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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF5C9C433E2
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 14:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6F8120724
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 14:47:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M+bCEOPf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404021AbgFXOrC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Jun 2020 10:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403926AbgFXOqo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jun 2020 10:46:44 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6EDDC061573
        for <git@vger.kernel.org>; Wed, 24 Jun 2020 07:46:43 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id l2so1313057wmf.0
        for <git@vger.kernel.org>; Wed, 24 Jun 2020 07:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=YR5mgWvq8oel7pskivydUczFijobGIiMDxUn4vO8/EQ=;
        b=M+bCEOPfMRkn2cJcsK49iXFEoMjKNpyJ3N78nRAjVpc4e6BirfysxE6vYNUfvX+X0I
         Rk8FSgbdsGI2g7Fe05qLGFnoQkNnZSX5X16of1/krz/oc4BKdG2mD8GI7MvBLIu//Y6N
         li2nZu31QcrijYSEbl+jUdskY+6dPrcGJT639vbXgY6fPPjrERTwhB4MV1LFGXIAVFOV
         MFsW6zeZ/0jLSjWcR0o5xf1xYPzUTrvbiqPbTNzR8bzyhmE8yp31evoPXjkE7qxyslW6
         ANjsfWl4llInYWuxYsiPEoNbAY2xNxEGcc37MVceoH9fbO/8lK3wlt9GsMusyErs8L30
         f3Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=YR5mgWvq8oel7pskivydUczFijobGIiMDxUn4vO8/EQ=;
        b=HuXp3RfB9nzKX1QQe0vf1XoEVOBj+hWk37Dz5rSFy//3dy0gvzYqdDPU0pBUBCEa6M
         f9C3cc1Z6IhWC7q5I4KK330XCmT4rqHHDvCUYu5LkdrdEhth7IFLuYPTn+rBJfILtM79
         Mxkc4gzJaOovasxfX2Kd3vwq2glletJ1CBWmGW7fleUpTN1ikborZEpltQeh32RHqeC2
         0D+xpMP7SX/FnjuJwWJN7Jc5B/3BXL7P18S2zh6rKjKeyp+jbFleoTzUxkEPZrcGk6dB
         Igm+w4S6uyKS7cYM948/Go6k1V8zEdk83OMmj9+u1BvTH2xwwQ1t6Lm1pp2yo79VYnOt
         gtWA==
X-Gm-Message-State: AOAM532tThT2SR341wfgveYiLEUx6WU7NNGX5MXq23U2kLfUgNnNiG7a
        +FZiUAFjT37YorqdujTNExOTKt5rMFA=
X-Google-Smtp-Source: ABdhPJzI3i/LSuQhphtxSWOD1XPxx+uHgUhKtfeml+60f6xiOEPfjaIIvcnv3bniHikwqCeODpgmTg==
X-Received: by 2002:a1c:ed17:: with SMTP id l23mr30052476wmh.175.1593010002188;
        Wed, 24 Jun 2020 07:46:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f13sm7978578wmb.33.2020.06.24.07.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 07:46:41 -0700 (PDT)
Message-Id: <9edd4fd3b26cef4ff8ffb99be6647055ebb76ed6.1593009996.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.656.v4.git.1593009996.gitgitgadget@gmail.com>
References: <pull.656.v3.git.1592951611.gitgitgadget@gmail.com>
        <pull.656.v4.git.1593009996.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 24 Jun 2020 14:46:32 +0000
Subject: [PATCH v4 5/9] init: allow specifying the initial branch name for the
 new repository
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

There is a growing number of projects and companies desiring to change
the main branch name of their repositories (see e.g.
https://twitter.com/mislav/status/1270388510684598272 for background on
this).

To change that branch name for new repositories, currently the only way
to do that automatically is by copying all of Git's template directory,
then hard-coding the desired default branch name into the `.git/HEAD`
file, and then configuring `init.templateDir` to point to those copied
template files.

To make this process much less cumbersome, let's introduce a new option:
`--initial-branch=<branch-name>`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/git-init.txt |  7 +++++++
 builtin/clone.c            |  3 ++-
 builtin/init-db.c          | 33 +++++++++++++++++++++++++++------
 cache.h                    |  2 +-
 t/t0001-init.sh            | 13 +++++++++++++
 5 files changed, 50 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
index f9467cc6a4..ddfe265da5 100644
--- a/Documentation/git-init.txt
+++ b/Documentation/git-init.txt
@@ -11,6 +11,7 @@ SYNOPSIS
 [verse]
 'git init' [-q | --quiet] [--bare] [--template=<template_directory>]
 	  [--separate-git-dir <git dir>] [--object-format=<format>]
+	  [-b <branch-name> | --initial-branch=<branch-name>]
 	  [--shared[=<permissions>]] [directory]
 
 
@@ -67,6 +68,12 @@ repository.
 +
 If this is reinitialization, the repository will be moved to the specified path.
 
+-b <branch-name::
+--initial-branch=<branch-name>::
+
+Use the specified name for the initial branch in the newly created repository.
+If not specified, fall back to the default name: `master`.
+
 --shared[=(false|true|umask|group|all|world|everybody|0xxx)]::
 
 Specify that the Git repository is to be shared amongst several users.  This
diff --git a/builtin/clone.c b/builtin/clone.c
index 2a8e3aaaed..b751bdf13e 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1111,7 +1111,8 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		}
 	}
 
-	init_db(git_dir, real_git_dir, option_template, GIT_HASH_UNKNOWN, INIT_DB_QUIET);
+	init_db(git_dir, real_git_dir, option_template, GIT_HASH_UNKNOWN, NULL,
+		INIT_DB_QUIET);
 
 	if (real_git_dir)
 		git_dir = real_git_dir;
diff --git a/builtin/init-db.c b/builtin/init-db.c
index 0b7222e718..8fdfc334ac 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -203,6 +203,7 @@ void initialize_repository_version(int hash_algo)
 
 static int create_default_files(const char *template_path,
 				const char *original_git_dir,
+				const char *initial_branch,
 				const struct repository_format *fmt)
 {
 	struct stat st1;
@@ -258,15 +259,26 @@ static int create_default_files(const char *template_path,
 		die("failed to set up refs db: %s", err.buf);
 
 	/*
-	 * Create the default symlink from ".git/HEAD" to the "master"
-	 * branch, if it does not exist yet.
+	 * Point the HEAD symref to the initial branch with if HEAD does
+	 * not yet exist.
 	 */
 	path = git_path_buf(&buf, "HEAD");
 	reinit = (!access(path, R_OK)
 		  || readlink(path, junk, sizeof(junk)-1) != -1);
 	if (!reinit) {
-		if (create_symref("HEAD", "refs/heads/master", NULL) < 0)
+		char *ref;
+
+		if (!initial_branch)
+			initial_branch = "master";
+
+		ref = xstrfmt("refs/heads/%s", initial_branch);
+		if (check_refname_format(ref, 0) < 0)
+			die(_("invalid initial branch name: '%s'"),
+			    initial_branch);
+
+		if (create_symref("HEAD", ref, NULL) < 0)
 			exit(1);
+		free(ref);
 	}
 
 	initialize_repository_version(fmt->hash_algo);
@@ -383,7 +395,8 @@ static void validate_hash_algorithm(struct repository_format *repo_fmt, int hash
 }
 
 int init_db(const char *git_dir, const char *real_git_dir,
-	    const char *template_dir, int hash, unsigned int flags)
+	    const char *template_dir, int hash, const char *initial_branch,
+	    unsigned int flags)
 {
 	int reinit;
 	int exist_ok = flags & INIT_DB_EXIST_OK;
@@ -425,7 +438,11 @@ int init_db(const char *git_dir, const char *real_git_dir,
 
 	validate_hash_algorithm(&repo_fmt, hash);
 
-	reinit = create_default_files(template_dir, original_git_dir, &repo_fmt);
+	reinit = create_default_files(template_dir, original_git_dir,
+				      initial_branch, &repo_fmt);
+	if (reinit && initial_branch)
+		warning(_("re-init: ignored --initial-branch=%s"),
+			initial_branch);
 
 	create_object_directory();
 
@@ -528,6 +545,7 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 	const char *template_dir = NULL;
 	unsigned int flags = 0;
 	const char *object_format = NULL;
+	const char *initial_branch = NULL;
 	int hash_algo = GIT_HASH_UNKNOWN;
 	const struct option init_db_options[] = {
 		OPT_STRING(0, "template", &template_dir, N_("template-directory"),
@@ -541,6 +559,8 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 		OPT_BIT('q', "quiet", &flags, N_("be quiet"), INIT_DB_QUIET),
 		OPT_STRING(0, "separate-git-dir", &real_git_dir, N_("gitdir"),
 			   N_("separate git dir from working tree")),
+		OPT_STRING('b', "initial-branch", &initial_branch, N_("name"),
+			   N_("override the name of the initial branch")),
 		OPT_STRING(0, "object-format", &object_format, N_("hash"),
 			   N_("specify the hash algorithm to use")),
 		OPT_END()
@@ -652,5 +672,6 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 	UNLEAK(work_tree);
 
 	flags |= INIT_DB_EXIST_OK;
-	return init_db(git_dir, real_git_dir, template_dir, hash_algo, flags);
+	return init_db(git_dir, real_git_dir, template_dir, hash_algo,
+		       initial_branch, flags);
 }
diff --git a/cache.h b/cache.h
index 0f0485ecfe..654426460c 100644
--- a/cache.h
+++ b/cache.h
@@ -628,7 +628,7 @@ int path_inside_repo(const char *prefix, const char *path);
 
 int init_db(const char *git_dir, const char *real_git_dir,
 	    const char *template_dir, int hash_algo,
-	    unsigned int flags);
+	    const char *initial_branch, unsigned int flags);
 void initialize_repository_version(int hash_algo);
 
 void sanitize_stdfds(void);
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 1edd5aeb8f..386c06b5dd 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -464,4 +464,17 @@ test_expect_success MINGW 'redirect std handles' '
 	grep "Needed a single revision" output.txt
 '
 
+test_expect_success '--initial-branch' '
+	git init --initial-branch=hello initial-branch-option &&
+	git -C initial-branch-option symbolic-ref HEAD >actual &&
+	echo refs/heads/hello >expect &&
+	test_cmp expect actual &&
+
+	: re-initializing should not change the branch name &&
+	git init --initial-branch=ignore initial-branch-option 2>err &&
+	test_i18ngrep "ignored --initial-branch" err &&
+	git -C initial-branch-option symbolic-ref HEAD >actual &&
+	grep hello actual
+'
+
 test_done
-- 
gitgitgadget

