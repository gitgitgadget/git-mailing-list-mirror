Return-Path: <SRS0=FGj8=74=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF87CC433DF
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 12:50:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB73420739
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 12:50:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I0YB3kFl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730063AbgFOMus (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Jun 2020 08:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729976AbgFOMu2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jun 2020 08:50:28 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EFBDC08C5C6
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 05:50:26 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id j198so14068625wmj.0
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 05:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=gmcSGL/wCVPZSTRUUANoxjlRu5t6lHB51p5LG05l5OU=;
        b=I0YB3kFl5dT14dW0iEpYlc/YV5zyVGSFI282WyzI8LTW470+kLCMqAA0bbywp8yajQ
         HQRJBn3rILe0EORfcl9uIZ0MaxsOxFkm+y9PCbujMNMF80+Z4NykjalcJb9HY4YznkBU
         WXErV84p5N+l6r78mcmRPXBBy3Dg+lPBHkTTGCZB3k10u1DV+jqsdRIQHGiHiePPDUfZ
         +TFyDTyGsNurQCIihq8wylXNfkeLVax+7+P+Vu2YqWnEje2JIXtUqrK8lr9K/8bvD4i7
         mhh1Sta9nEKZmBMKqxqIlGUaK0S/XG7Qg/PMin3MNUZCgl9hMnphKRVfOL4CPwOzB2+4
         rwHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=gmcSGL/wCVPZSTRUUANoxjlRu5t6lHB51p5LG05l5OU=;
        b=donpjoB7nT/t5GVTV+oIelKlp9jRtU0aCVvOMpDD2VgC+B6X6wOXe97pLZxAdgZk7p
         QdVePrH+M9jg9sD4VYNMF9squFs2m4tZ4S1qPXADCrpMOBKpZXXnpKVZmVLr9YP69+bo
         I8AP429K8Z5MjW9FoGTwD9f2a4XXbY49w1sACa6bwd+uNFG2NI7/dkDLWhKxdmllkPcv
         5K6/HGwPifXLHiBcpgHMi2RIfS48rT54OMUVEHeq9ghK2MyqyeNceHXQQO28AM9i7SaP
         18Gn3hVev9I5j93KuD9Hcdv9DhTZAedpA/JmICt5xXHQEA5yuAw1A7m2yuHCg1Ddidin
         XmTA==
X-Gm-Message-State: AOAM530QUv0Jt2C7koJv7AQU0GSC/EZxbmVX7Vlw5Qzx3TXd/NMuhbWT
        dnssSMUQw41y4HgDTkfHlxMD4aJ/
X-Google-Smtp-Source: ABdhPJwvaEf5pp3UA+dcD11FrVXJb3n/3RAqEtqiyWtDFkZ86Q2PbCM9qnMT+kLRuGdYq1LrhaN7MQ==
X-Received: by 2002:a1c:e90a:: with SMTP id q10mr13564736wmc.140.1592225424938;
        Mon, 15 Jun 2020 05:50:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b14sm22210770wmj.47.2020.06.15.05.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 05:50:24 -0700 (PDT)
Message-Id: <0ec04b2086ee72f71a0328553752ea031e14ec44.1592225416.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.656.v2.git.1592225416.gitgitgadget@gmail.com>
References: <pull.656.git.1591823971.gitgitgadget@gmail.com>
        <pull.656.v2.git.1592225416.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 15 Jun 2020 12:50:11 +0000
Subject: [PATCH v2 07/12] init: allow specifying the main branch name for the
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
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

There is a growing number of projects trying to avoid the non-inclusive
name `master` in their repositories: The `master`/`slave` terminology is
insensitive and perpetuates injustice. This `master`/`slave` idea is
actually where Git's naming comes from, as it was inherited from
BitKeeper which uses the term in exactly this way, see
https://mail.gnome.org/archives/desktop-devel-list/2019-May/msg00066.html

To change that branch name for new repositories, currently the only way
to do that automatically is by copying all of Git's template directory,
then hard-coding the desired default branch name into the `.git/HEAD`
file, and then configuring `init.templateDir` to point to those copied
template files.

To make this process much less cumbersome, let's introduce a new option:
`--main-branch=<branch-name>`.

This will not only initialize the repository with the specified initial
branch; It will also record that branch name in `core.mainBranch`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/git-init.txt |  7 +++++++
 builtin/clone.c            |  3 ++-
 builtin/init-db.c          | 34 +++++++++++++++++++++++++++-------
 cache.h                    |  2 +-
 t/t0001-init.sh            | 15 +++++++++++++++
 5 files changed, 52 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
index adc6adfd380..011a7ff4d76 100644
--- a/Documentation/git-init.txt
+++ b/Documentation/git-init.txt
@@ -11,6 +11,7 @@ SYNOPSIS
 [verse]
 'git init' [-q | --quiet] [--bare] [--template=<template_directory>]
 	  [--separate-git-dir <git dir>] [--object-format=<format]
+	  [-b <branch-name> | --main-branch=<branch-name>]
 	  [--shared[=<permissions>]] [directory]
 
 
@@ -67,6 +68,12 @@ repository.
 +
 If this is reinitialization, the repository will be moved to the specified path.
 
+-b <branch-name::
+--main-branch=<branch-name>::
+
+Use the specified name for the main (or: initial) branch in the newly created
+repository. If not specified, fall back to the default name: `master`.
+
 --shared[=(false|true|umask|group|all|world|everybody|0xxx)]::
 
 Specify that the Git repository is to be shared amongst several users.  This
diff --git a/builtin/clone.c b/builtin/clone.c
index cb48a291caf..487b0a42d75 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1108,7 +1108,8 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		}
 	}
 
-	init_db(git_dir, real_git_dir, option_template, GIT_HASH_UNKNOWN, INIT_DB_QUIET);
+	init_db(git_dir, real_git_dir, option_template, GIT_HASH_UNKNOWN, NULL,
+		INIT_DB_QUIET);
 
 	if (real_git_dir)
 		git_dir = real_git_dir;
diff --git a/builtin/init-db.c b/builtin/init-db.c
index 0b7222e7188..287cdafaab1 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -203,6 +203,7 @@ void initialize_repository_version(int hash_algo)
 
 static int create_default_files(const char *template_path,
 				const char *original_git_dir,
+				const char *main_branch,
 				const struct repository_format *fmt)
 {
 	struct stat st1;
@@ -258,16 +259,29 @@ static int create_default_files(const char *template_path,
 		die("failed to set up refs db: %s", err.buf);
 
 	/*
-	 * Create the default symlink from ".git/HEAD" to the "master"
-	 * branch, if it does not exist yet.
+	 * Create the default symlink from ".git/HEAD" to the default
+	 * branch name, if it does not exist yet.
 	 */
 	path = git_path_buf(&buf, "HEAD");
 	reinit = (!access(path, R_OK)
 		  || readlink(path, junk, sizeof(junk)-1) != -1);
 	if (!reinit) {
-		if (create_symref("HEAD", "refs/heads/master", NULL) < 0)
+		char *ref;
+
+		if (!main_branch)
+			main_branch = "master";
+
+		ref = xstrfmt("refs/heads/%s", main_branch);
+		if (check_refname_format(ref, 0) < 0)
+			die(_("invalid main branch name: '%s'"), main_branch);
+
+		if (create_symref("HEAD", ref, NULL) < 0)
 			exit(1);
-	}
+		free(ref);
+
+		git_config_set("core.mainbranch", main_branch);
+	} else if (main_branch)
+		warning(_("re-init: ignoring --main-branch=%s"), main_branch);
 
 	initialize_repository_version(fmt->hash_algo);
 
@@ -383,7 +397,8 @@ static void validate_hash_algorithm(struct repository_format *repo_fmt, int hash
 }
 
 int init_db(const char *git_dir, const char *real_git_dir,
-	    const char *template_dir, int hash, unsigned int flags)
+	    const char *template_dir, int hash, const char *main_branch,
+	    unsigned int flags)
 {
 	int reinit;
 	int exist_ok = flags & INIT_DB_EXIST_OK;
@@ -425,7 +440,8 @@ int init_db(const char *git_dir, const char *real_git_dir,
 
 	validate_hash_algorithm(&repo_fmt, hash);
 
-	reinit = create_default_files(template_dir, original_git_dir, &repo_fmt);
+	reinit = create_default_files(template_dir, original_git_dir,
+				      main_branch, &repo_fmt);
 
 	create_object_directory();
 
@@ -528,6 +544,7 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 	const char *template_dir = NULL;
 	unsigned int flags = 0;
 	const char *object_format = NULL;
+	const char *main_branch = NULL;
 	int hash_algo = GIT_HASH_UNKNOWN;
 	const struct option init_db_options[] = {
 		OPT_STRING(0, "template", &template_dir, N_("template-directory"),
@@ -541,6 +558,8 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 		OPT_BIT('q', "quiet", &flags, N_("be quiet"), INIT_DB_QUIET),
 		OPT_STRING(0, "separate-git-dir", &real_git_dir, N_("gitdir"),
 			   N_("separate git dir from working tree")),
+		OPT_STRING('b', "main-branch", &main_branch, N_("name"),
+			   N_("override the name of the main branch")),
 		OPT_STRING(0, "object-format", &object_format, N_("hash"),
 			   N_("specify the hash algorithm to use")),
 		OPT_END()
@@ -652,5 +671,6 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 	UNLEAK(work_tree);
 
 	flags |= INIT_DB_EXIST_OK;
-	return init_db(git_dir, real_git_dir, template_dir, hash_algo, flags);
+	return init_db(git_dir, real_git_dir, template_dir, hash_algo,
+		       main_branch, flags);
 }
diff --git a/cache.h b/cache.h
index 0f0485ecfe2..afd5ad3121f 100644
--- a/cache.h
+++ b/cache.h
@@ -628,7 +628,7 @@ int path_inside_repo(const char *prefix, const char *path);
 
 int init_db(const char *git_dir, const char *real_git_dir,
 	    const char *template_dir, int hash_algo,
-	    unsigned int flags);
+	    const char *main_branch, unsigned int flags);
 void initialize_repository_version(int hash_algo);
 
 void sanitize_stdfds(void);
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 1edd5aeb8f0..5d8e321a703 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -464,4 +464,19 @@ test_expect_success MINGW 'redirect std handles' '
 	grep "Needed a single revision" output.txt
 '
 
+test_expect_success '--main-branch' '
+	git init --main-branch=hello main-branch-option &&
+	git -C main-branch-option symbolic-ref HEAD >actual &&
+	echo refs/heads/hello >expect &&
+	test_cmp expect actual &&
+
+	: re-initializing should not change the main branch name &&
+	git init --main-branch=ignore main-branch-option 2>err &&
+	test_i18ngrep "ignoring --main-branch" err &&
+	git -C main-branch-option symbolic-ref HEAD >actual &&
+	grep hello actual &&
+	git -C main-branch-option config core.mainBranch >actual &&
+	grep hello actual
+'
+
 test_done
-- 
gitgitgadget

