Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE066C433E0
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 14:16:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70D6A64E56
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 14:16:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232754AbhBHOP7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Feb 2021 09:15:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232164AbhBHONl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Feb 2021 09:13:41 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A4AC06178A
        for <git@vger.kernel.org>; Mon,  8 Feb 2021 06:13:00 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id n6so4476858wrv.8
        for <git@vger.kernel.org>; Mon, 08 Feb 2021 06:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=RSKDtX7+p7nDewcO39/G+qJngoFrhLhcp1V6AZDBb7k=;
        b=mVQWjZCgNV+jHPakgWN8vv7a9VFIroS6yjz20rvo+z1T1ri4UJpjy0VV+8X0xaNcvH
         T+yyEPvbv/ybiH9avUu2a9lBvUpWwr9sqrBeVGGIAgixoLcFmIIbpK4RAFg+B81af0lt
         I/jDK0SB+enXQGBQRhVgVCY82AsM9anRt7xGJS175N6ECXC/WR8cY4ODEv9n5L7snArL
         w45Rz3SxLhqdU/d8iaDVFaGIRWF4dpzS2hFnYjWrFHffW9qNJiJDiEXJDXQoM3dDOxRI
         z7tICh3ib1VI7kxwGKqnLPg5HyrbFbj4d7/bnPA3yy6nX79Um3tPaXg/kUQsHLjsaBuX
         O8cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=RSKDtX7+p7nDewcO39/G+qJngoFrhLhcp1V6AZDBb7k=;
        b=BB8VBN4L5v3kE2CuR1o8TWXCYIRcyVFqhUFUbCPaYgEIpnaIpqd4veL5CVwTz1csBv
         X9iKES8jjcH7zT4pqbv744wcD/9/dffFPGVf08A1+M0smYTSHVYhF6aLGgO8WzlutiiK
         suvJ/XsRre5u0HXGZL6nBfPN0uGG2+lMbqjpLpu8N13wXbAyqEpE86k3lnomSmElgXBb
         p8YRuycQazpTpogdSNtrUFq4UCFyjfQCiuB+i6FhvalclGITvcwq+ihVz3cqGM6n1mv5
         1cjr0c6CZ7ATAta4pTruKU9kcq+la5wnTeqo37ER96R80d2C6SRO+mKRo8U6HANAjSSM
         BJDg==
X-Gm-Message-State: AOAM531RQRlOKt0aCl6o1KIqhpEmSYpfTTcurI0M4gBGwFvSYBSZHUSM
        XiwYs18AoXritiYXRkJf5ReChZOsj2Y=
X-Google-Smtp-Source: ABdhPJyQ479cua3p1KyzFF8K+jm+SDnRwenW4Xdz8CLEKDsbanibTq46zbKMV+bxbH0IZpmICmrRsA==
X-Received: by 2002:adf:f1cd:: with SMTP id z13mr19952964wro.126.1612793578513;
        Mon, 08 Feb 2021 06:12:58 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z15sm27374775wrs.25.2021.02.08.06.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 06:12:57 -0800 (PST)
Message-Id: <pull.865.v3.git.1612793576910.gitgitgadget@gmail.com>
In-Reply-To: <pull.865.v2.git.1612773119.gitgitgadget@gmail.com>
References: <pull.865.v2.git.1612773119.gitgitgadget@gmail.com>
From:   "Li Linchao via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 08 Feb 2021 14:12:56 +0000
Subject: [PATCH v3] builtin/clone.c: add --reject-shallow option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        dscho <johannes.schindelin@gmx.de>,
        Li Linchao <lilinchao@oschina.cn>,
        lilinchao <lilinchao@oschina.cn>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: lilinchao <lilinchao@oschina.cn>

In some scenarios, users may want more history than the repository
offered for cloning, which mostly to be a shallow repository, can
give them. But users don't know it is a shallow repository until
they download it to local, users should have the option to refuse
to clone this kind of repository, and may want to exit the process
immediately without creating any unnecessary files.

Althought there is an option '--depth=x' for users to decide how
deep history they can fetch, but as the unshallow cloning's depth
is INFINITY, we can't know exactly the minimun 'x' value that can
satisfy the minimum integrity, so we can't pass 'x' value to --depth,
and expect this can obtain a complete history of a repository.

In other scenarios, given that we have an API that allow us to import
external repository, and then perform various operations on the repo.
But if the imported is a shallow one(which is actually possible), it
will affect the subsequent operations. So we can choose to refuse to
clone, and let's just import an unshallow repository.

This patch offers a new option '--reject-shallow' that can reject to
clone a shallow repository.

Signed-off-by: lilinchao <lilinchao@oschina.cn>
---
    builtin/clone.c: add --no-shallow option
    
    Change since v1:
    
     * Rename --no-shallow to --reject-shallow
     * Enable to reject a non-local clone
     * Enable --[no-]reject-shallow from CLI override configuration.
     * Add more testcases.
     * Reword commit messages and relative documentation.
    
    Signed-off-by: lilinchao lilinchao@oschina.cn

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-865%2FCactusinhand%2Fgit-clone-options-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-865/Cactusinhand/git-clone-options-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/865

Range-diff vs v2:

 1:  2f9602495eb5 < -:  ------------ builtin/clone.c: add --no-shallow option
 2:  cfcfc3ec6b37 ! 1:  f5ed6b2e4481 builtin/clone.c: add --reject-shallow option
     @@ Commit message
      
       ## Documentation/config/clone.txt ##
      @@ Documentation/config/clone.txt: clone.defaultRemoteName::
     + 	The name of the remote to create when cloning a repository.  Defaults to
     + 	`origin`, and can be overridden by passing the `--origin` command-line
       	option to linkgit:git-clone[1].
     - 
     - clone.rejectshallow::
     --	Reject to clone a repository if it is a shallow one.
     ++
     ++clone.rejectshallow::
      +	Reject to clone a repository if it is a shallow one, can be overridden by
      +	passing option `--reject-shallow` in command line. See linkgit:git-clone[1]
      
     @@ Documentation/git-clone.txt: SYNOPSIS
       	  [--dissociate] [--separate-git-dir <git dir>]
       	  [--depth <depth>] [--[no-]single-branch] [--no-tags]
       	  [--recurse-submodules[=<pathspec>]] [--[no-]shallow-submodules]
     --	  [--[no-]remote-submodules] [--jobs <n>] [--sparse] [--no-shallow]
     +-	  [--[no-]remote-submodules] [--jobs <n>] [--sparse]
      +	  [--[no-]remote-submodules] [--jobs <n>] [--sparse] [--reject-shallow]
       	  [--filter=<filter>] [--] <repository>
       	  [<directory>]
     @@ Documentation/git-clone.txt: objects from the source repository into a pack in t
       --no-checkout::
       	No checkout of HEAD is performed after the clone is complete.
       
     ----no-shallow::
     --	Don't clone a shallow source repository. In some scenariors, clients
      +--reject-shallow::
      +	Don't clone a shallow source repository. In some scenarios, clients
     - 	want the cloned repository information to be complete. Otherwise,
     - 	the cloning process should end immediately without creating any files,
     --	which can save some disk space.
     ++	want the cloned repository information to be complete. Otherwise,
     ++	the cloning process should end immediately without creating any files,
      +	which can save some disk space. This can override `clone.rejectshallow`
      +	from the configuration:
      +
     @@ Documentation/git-clone.txt: objects from the source repository into a pack in t
      +	----------------------------------------------------------------------
      +	$ git -c clone.rejectshallow=true clone --no-reject-shallow source out
      +	----------------------------------------------------------------------
     - 
     ++
       --bare::
       	Make a 'bare' Git repository.  That is, instead of
     + 	creating `<directory>` and placing the administrative
      
     - ## builtin/clone.c (mode change 100755 => 100644) ##
     + ## builtin/clone.c ##
      @@ builtin/clone.c: static int option_no_checkout, option_bare, option_mirror, option_single_branch
       static int option_local = -1, option_no_hardlinks, option_shared;
       static int option_no_tags;
       static int option_shallow_submodules;
     --static int option_no_shallow;
      +static int option_no_shallow = -1;  /* unspecified */
      +static int config_shallow = -1;    /* unspecified */
       static int deepen;
     @@ builtin/clone.c: static struct option builtin_clone_options[] = {
       	OPT__VERBOSITY(&option_verbosity),
       	OPT_BOOL(0, "progress", &option_progress,
       		 N_("force progress reporting")),
     --	OPT_BOOL(0, "no-shallow", &option_no_shallow, N_("don't clone shallow repository")),
      +	OPT_BOOL(0, "reject-shallow", &option_no_shallow,
      +		 N_("don't clone shallow repository")),
       	OPT_BOOL('n', "no-checkout", &option_no_checkout,
       		 N_("don't create a checkout")),
       	OPT_BOOL(0, "bare", &option_bare, N_("create a bare repository")),
      @@ builtin/clone.c: static int git_clone_config(const char *k, const char *v, void *cb)
     + 		free(remote_name);
       		remote_name = xstrdup(v);
       	}
     - 	if (!strcmp(k, "clone.rejectshallow")) {
     --		option_no_shallow = 1;
     ++	if (!strcmp(k, "clone.rejectshallow")) {
      +		config_shallow = git_config_bool(k, v);
     - 	}
     ++	}
       	return git_default_config(k, v, cb);
       }
     + 
     +@@ builtin/clone.c: static int path_exists(const char *path)
     + int cmd_clone(int argc, const char **argv, const char *prefix)
     + {
     + 	int is_bundle = 0, is_local;
     ++	int is_shallow = 0;
     + 	const char *repo_name, *repo, *work_tree, *git_dir;
     + 	char *path, *dir, *display_repo = NULL;
     + 	int dest_exists, real_dest_exists = 0;
      @@ builtin/clone.c: int cmd_clone(int argc, const char **argv, const char *prefix)
       
       	path = get_repo_path(remote->url[0], &is_bundle);
     @@ builtin/clone.c: int cmd_clone(int argc, const char **argv, const char *prefix)
       		if (filter_options.choice)
       			warning(_("--filter is ignored in local clones; use file:// instead."));
      -		if (!access(mkpath("%s/shallow", path), F_OK)) {
     --			is_shallow = 1;
      +		if (is_shallow) {
       			if (option_local > 0)
       				warning(_("source repository is shallow, ignoring --local"));
       			is_local = 0;
      @@ builtin/clone.c: int cmd_clone(int argc, const char **argv, const char *prefix)
     + 	}
     + 	if (option_local > 0 && !is_local)
       		warning(_("--local is ignored"));
     - 
     - 	if (is_shallow) {
     --		if (option_no_shallow)
     ++
     ++	if (is_shallow) {
      +		int reject = 0;
      +
      +		/* If option_no_shallow is specified from CLI option,
     @@ builtin/clone.c: int cmd_clone(int argc, const char **argv, const char *prefix)
      +			reject = option_no_shallow;
      +		}
      +		if (reject) {
     - 			die(_("source repository is shallow, reject to clone."));
     ++			die(_("source repository is shallow, reject to clone."));
      +		}
     - 	}
     - 
     ++	}
     ++
       	transport->cloning = 1;
     + 
     + 	transport_set_option(transport, TRANS_OPT_KEEP, "yes");
      
       ## t/t5606-clone-options.sh ##
      @@ t/t5606-clone-options.sh: test_expect_success 'disallows --bare with --separate-git-dir' '
       
       '
       
     --test_expect_success 'reject clone shallow repository' '
      +test_expect_success 'fail to clone shallow repository' '
     - 	git clone --depth=1 --no-local parent shallow-repo &&
     --	test_must_fail git clone --no-shallow shallow-repo out 2>err &&
     ++	git clone --depth=1 --no-local parent shallow-repo &&
      +	test_must_fail git clone --reject-shallow shallow-repo out 2>err &&
     - 	test_i18ngrep -e "source repository is shallow, reject to clone." err
     - 
     - '
     - 
     ++	test_i18ngrep -e "source repository is shallow, reject to clone." err
     ++
     ++'
     ++
      +test_expect_success 'fail to clone non-local shallow repository' '
      +	rm -rf shallow-repo &&
      +	git clone --depth=1 --no-local parent shallow-repo &&
     @@ t/t5611-clone-config.sh: test_expect_success 'clone -c remote.<remote>.fetch=<re
       	test_cmp expect actual
       '
       
     --test_expect_success 'clone -c clone.rejectshallow' '
      +test_expect_success 'clone.rejectshallow=true should fail to clone' '
     - 	rm -rf child &&
     - 	git clone --depth=1 --no-local . child &&
     --	test_must_fail git clone -c clone.rejectshallow child out 2>err &&
     ++	rm -rf child &&
     ++	git clone --depth=1 --no-local . child &&
      +	test_must_fail git -c clone.rejectshallow=true clone --no-local child out 2>err &&
     - 	test_i18ngrep -e "source repository is shallow, reject to clone." err
     - '
     - 
     ++	test_i18ngrep -e "source repository is shallow, reject to clone." err
     ++'
     ++
      +test_expect_success 'clone.rejectshallow=false should succeed cloning' '
      +	rm -rf child &&
      +	git clone --depth=1 --no-local . child &&


 Documentation/config/clone.txt |  4 ++++
 Documentation/git-clone.txt    | 20 ++++++++++++++++++-
 builtin/clone.c                | 35 ++++++++++++++++++++++++++++++++-
 t/t5606-clone-options.sh       | 36 ++++++++++++++++++++++++++++++++++
 t/t5611-clone-config.sh        | 32 ++++++++++++++++++++++++++++++
 5 files changed, 125 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/clone.txt b/Documentation/config/clone.txt
index 47de36a5fedf..50ebc170bb81 100644
--- a/Documentation/config/clone.txt
+++ b/Documentation/config/clone.txt
@@ -2,3 +2,7 @@ clone.defaultRemoteName::
 	The name of the remote to create when cloning a repository.  Defaults to
 	`origin`, and can be overridden by passing the `--origin` command-line
 	option to linkgit:git-clone[1].
+
+clone.rejectshallow::
+	Reject to clone a repository if it is a shallow one, can be overridden by
+	passing option `--reject-shallow` in command line. See linkgit:git-clone[1]
diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 02d9c19cec75..af5a97903a05 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -15,7 +15,7 @@ SYNOPSIS
 	  [--dissociate] [--separate-git-dir <git dir>]
 	  [--depth <depth>] [--[no-]single-branch] [--no-tags]
 	  [--recurse-submodules[=<pathspec>]] [--[no-]shallow-submodules]
-	  [--[no-]remote-submodules] [--jobs <n>] [--sparse]
+	  [--[no-]remote-submodules] [--jobs <n>] [--sparse] [--reject-shallow]
 	  [--filter=<filter>] [--] <repository>
 	  [<directory>]
 
@@ -149,6 +149,24 @@ objects from the source repository into a pack in the cloned repository.
 --no-checkout::
 	No checkout of HEAD is performed after the clone is complete.
 
+--reject-shallow::
+	Don't clone a shallow source repository. In some scenarios, clients
+	want the cloned repository information to be complete. Otherwise,
+	the cloning process should end immediately without creating any files,
+	which can save some disk space. This can override `clone.rejectshallow`
+	from the configuration:
+
+	--------------------------------------------------------------------
+	$ git -c clone.rejectshallow=false clone --reject-shallow source out
+	--------------------------------------------------------------------
+
+	While there is a way to countermand a configured "I always refuse to
+	clone from a shallow repository" with "but let's allow it only this time":
+
+	----------------------------------------------------------------------
+	$ git -c clone.rejectshallow=true clone --no-reject-shallow source out
+	----------------------------------------------------------------------
+
 --bare::
 	Make a 'bare' Git repository.  That is, instead of
 	creating `<directory>` and placing the administrative
diff --git a/builtin/clone.c b/builtin/clone.c
index e335734b4cfd..a9d49c8e13c2 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -50,6 +50,8 @@ static int option_no_checkout, option_bare, option_mirror, option_single_branch
 static int option_local = -1, option_no_hardlinks, option_shared;
 static int option_no_tags;
 static int option_shallow_submodules;
+static int option_no_shallow = -1;  /* unspecified */
+static int config_shallow = -1;    /* unspecified */
 static int deepen;
 static char *option_template, *option_depth, *option_since;
 static char *option_origin = NULL;
@@ -90,6 +92,8 @@ static struct option builtin_clone_options[] = {
 	OPT__VERBOSITY(&option_verbosity),
 	OPT_BOOL(0, "progress", &option_progress,
 		 N_("force progress reporting")),
+	OPT_BOOL(0, "reject-shallow", &option_no_shallow,
+		 N_("don't clone shallow repository")),
 	OPT_BOOL('n', "no-checkout", &option_no_checkout,
 		 N_("don't create a checkout")),
 	OPT_BOOL(0, "bare", &option_bare, N_("create a bare repository")),
@@ -858,6 +862,9 @@ static int git_clone_config(const char *k, const char *v, void *cb)
 		free(remote_name);
 		remote_name = xstrdup(v);
 	}
+	if (!strcmp(k, "clone.rejectshallow")) {
+		config_shallow = git_config_bool(k, v);
+	}
 	return git_default_config(k, v, cb);
 }
 
@@ -963,6 +970,7 @@ static int path_exists(const char *path)
 int cmd_clone(int argc, const char **argv, const char *prefix)
 {
 	int is_bundle = 0, is_local;
+	int is_shallow = 0;
 	const char *repo_name, *repo, *work_tree, *git_dir;
 	char *path, *dir, *display_repo = NULL;
 	int dest_exists, real_dest_exists = 0;
@@ -1205,6 +1213,12 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 
 	path = get_repo_path(remote->url[0], &is_bundle);
 	is_local = option_local != 0 && path && !is_bundle;
+
+	/* Detect if the remote repository is shallow */
+	if (!access(mkpath("%s/shallow", path), F_OK)) {
+		is_shallow = 1;
+	}
+
 	if (is_local) {
 		if (option_depth)
 			warning(_("--depth is ignored in local clones; use file:// instead."));
@@ -1214,7 +1228,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 			warning(_("--shallow-exclude is ignored in local clones; use file:// instead."));
 		if (filter_options.choice)
 			warning(_("--filter is ignored in local clones; use file:// instead."));
-		if (!access(mkpath("%s/shallow", path), F_OK)) {
+		if (is_shallow) {
 			if (option_local > 0)
 				warning(_("source repository is shallow, ignoring --local"));
 			is_local = 0;
@@ -1222,6 +1236,25 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	}
 	if (option_local > 0 && !is_local)
 		warning(_("--local is ignored"));
+
+	if (is_shallow) {
+		int reject = 0;
+
+		/* If option_no_shallow is specified from CLI option,
+		 * ignore config_shallow from git_clone_config.
+		 */
+
+		if (config_shallow != -1) {
+			reject = config_shallow;
+		}
+		if (option_no_shallow != -1) {
+			reject = option_no_shallow;
+		}
+		if (reject) {
+			die(_("source repository is shallow, reject to clone."));
+		}
+	}
+
 	transport->cloning = 1;
 
 	transport_set_option(transport, TRANS_OPT_KEEP, "yes");
diff --git a/t/t5606-clone-options.sh b/t/t5606-clone-options.sh
index 5d6e63a841f7..bf007448ad20 100755
--- a/t/t5606-clone-options.sh
+++ b/t/t5606-clone-options.sh
@@ -45,6 +45,42 @@ test_expect_success 'disallows --bare with --separate-git-dir' '
 
 '
 
+test_expect_success 'fail to clone shallow repository' '
+	git clone --depth=1 --no-local parent shallow-repo &&
+	test_must_fail git clone --reject-shallow shallow-repo out 2>err &&
+	test_i18ngrep -e "source repository is shallow, reject to clone." err
+
+'
+
+test_expect_success 'fail to clone non-local shallow repository' '
+	rm -rf shallow-repo &&
+	git clone --depth=1 --no-local parent shallow-repo &&
+	test_must_fail git clone --reject-shallow --no-local shallow-repo out 2>err &&
+	test_i18ngrep -e "source repository is shallow, reject to clone." err
+
+'
+
+test_expect_success 'clone shallow repository with --no-reject-shallow' '
+	rm -rf shallow-repo &&
+	git clone --depth=1 --no-local parent shallow-repo &&
+	git clone --no-reject-shallow --no-local shallow-repo clone-repo
+
+'
+
+test_expect_success 'clone normal repository with --reject-shallow' '
+	rm -rf clone-repo &&
+	git clone --no-local parent normal-repo &&
+	git clone --reject-shallow --no-local normal-repo clone-repo
+
+'
+
+test_expect_success 'unspecified any configs or options' '
+	rm -rf shallow-repo clone-repo &&
+	git clone --depth=1 --no-local parent shallow-repo &&
+	git clone shallow-repo clone-repo
+
+'
+
 test_expect_success 'uses "origin" for default remote name' '
 
 	git clone parent clone-default-origin &&
diff --git a/t/t5611-clone-config.sh b/t/t5611-clone-config.sh
index 9f555b87ecdf..00789d7487d5 100755
--- a/t/t5611-clone-config.sh
+++ b/t/t5611-clone-config.sh
@@ -95,6 +95,38 @@ test_expect_success 'clone -c remote.<remote>.fetch=<refspec> --origin=<name>' '
 	test_cmp expect actual
 '
 
+test_expect_success 'clone.rejectshallow=true should fail to clone' '
+	rm -rf child &&
+	git clone --depth=1 --no-local . child &&
+	test_must_fail git -c clone.rejectshallow=true clone --no-local child out 2>err &&
+	test_i18ngrep -e "source repository is shallow, reject to clone." err
+'
+
+test_expect_success 'clone.rejectshallow=false should succeed cloning' '
+	rm -rf child &&
+	git clone --depth=1 --no-local . child &&
+	git -c clone.rejectshallow=false clone --no-local child out
+'
+
+test_expect_success 'clone.rejectshallow=true should succeed cloning normal repo' '
+	rm -rf child out &&
+	git clone --no-local . child &&
+	git -c clone.rejectshallow=true clone --no-local child out
+'
+
+test_expect_success 'option --reject-shallow override clone.rejectshallow' '
+	rm -rf child out &&
+	git clone --depth=1 --no-local . child &&
+	test_must_fail git clone -c clone.rejectshallow=false  --reject-shallow --no-local child out 2>err &&
+	test_i18ngrep -e "source repository is shallow, reject to clone." err
+'
+
+test_expect_success ' option --no-reject-shallow override clone.rejectshallow' '
+	rm -rf child &&
+	git clone --depth=1 --no-local . child &&
+	git -c clone.rejectshallow=true clone --no-reject-shallow --no-local child out
+'
+
 test_expect_success MINGW 'clone -c core.hideDotFiles' '
 	test_commit attributes .gitattributes "" &&
 	rm -rf child &&

base-commit: fb7fa4a1fd273f22efcafdd13c7f897814fd1eb9
-- 
gitgitgadget
