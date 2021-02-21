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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A35C433DB
	for <git@archiver.kernel.org>; Sun, 21 Feb 2021 07:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86E1264F03
	for <git@archiver.kernel.org>; Sun, 21 Feb 2021 07:06:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbhBUHGe (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Feb 2021 02:06:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbhBUHGb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Feb 2021 02:06:31 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A43C061574
        for <git@vger.kernel.org>; Sat, 20 Feb 2021 23:05:50 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id f7so14412937wrt.12
        for <git@vger.kernel.org>; Sat, 20 Feb 2021 23:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=V/QlUo1iWC74LJ5zgBwTYJ0kHp+z3PVLNe/DBqUJKdQ=;
        b=dTsV/+zKzn8197xXVzUCStBiCP2cJGwwN5H34I7ErFnvH6J1se7IvH4YPfDzn+wLet
         IqE0DPmCC5itEy3zZTSM1GIym2m/RNjeXTr+NfknUEzFNUNu910NDojNg79ZQcg0ME8n
         QGA5uJEUVCxklWVR/g7nyqoyQuvpszhdT1L4JD0HrUkfvVaVKL+fq1c11uXcnY6wxFe5
         Aq9rIDK0YIFARLFYcvBp7wxgHXCIsDKUuXaiIeDNW5fyuaW8OUiWMhdjipmsmIXdwdxJ
         KoFimtGZc9IWoga1egS7wYy8c/DqAsQYYT4sqBhWbdz9fMZKOoh3K1eNCLIRNG4gYvEX
         XXyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=V/QlUo1iWC74LJ5zgBwTYJ0kHp+z3PVLNe/DBqUJKdQ=;
        b=qUkqMgDbfol01COU+wnctqkvSz+A8QwRei4CgUvsJLaLYrnXuiKoDR6t5JeW5jr+aQ
         6+h+fejpCKwzZHtmVvMFs7pNqG/AcBwE3yZMEQ4hzEpM2SnvW5zaSb+iVGSQ88ftLnLW
         cEx3nlamLJE29SDqXPxlfcTGZbQOOtES0bSm7g/WpJ8oaS6BoGhY9XbIbvfwJoDjsEQR
         PUhsPx95VYcMoShKccbvdMlcfmfpIZAbhKuDb9qGYj+3ft6KEwQOSz5ZQv2e0wzOrymD
         9JTgwxjDsschrOEMduUa4M3NmKPtRVh+ods+6Zp8ShEZmLtvZlN2JlMCNkheMElJpKRi
         6R/w==
X-Gm-Message-State: AOAM5311XTadzMGZcqniw5ZGxsVuF9eR4SzQEh39GvY2B02bZv27lMLn
        0V0zmngNVxCiKfkHDcOaiACK+HtiD6U=
X-Google-Smtp-Source: ABdhPJyMkQHaDSU3jM+fnhkUYufECC+zabGgNlaqlzM5wCy73VsHT+wY/Aup4TiK7wvKP2wpwEtLwA==
X-Received: by 2002:a5d:58fb:: with SMTP id f27mr15964274wrd.119.1613891149466;
        Sat, 20 Feb 2021 23:05:49 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y5sm6975791wrh.38.2021.02.20.23.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Feb 2021 23:05:49 -0800 (PST)
Message-Id: <pull.865.v4.git.1613891147977.gitgitgadget@gmail.com>
In-Reply-To: <pull.865.v3.git.1612793576910.gitgitgadget@gmail.com>
References: <pull.865.v3.git.1612793576910.gitgitgadget@gmail.com>
From:   "Li Linchao via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 21 Feb 2021 07:05:47 +0000
Subject: [PATCH v4] builtin/clone.c: add --reject-shallow option
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
offered for cloning, which happens to be a shallow repository, can
give them. But because users don't know it is a shallow repository
until they download it to local, users should have the option to
refuse to clone this kind of repository, and may want to exit the
process immediately without creating any unnecessary files.

Althought there is an option '--depth=x' for users to decide how
deep history they can fetch, but as the unshallow cloning's depth
is INFINITY, we can't know exactly the minimun 'x' value that can
satisfy the minimum integrity, so we can't pass 'x' value to --depth,
and expect this can obtain a complete history of a repository.

In other scenarios, if we have an API that allow us to import external
repository, and then perform various operations on the repo.
But if the imported is a shallow one(which is actually possible), it
will affect the subsequent operations. So we can choose to refuse to
clone, and let's just import a normal repository.

This patch offers a new option '--reject-shallow' that can reject to
clone a shallow repository.

Signed-off-by: lilinchao <lilinchao@oschina.cn>
---
    builtin/clone.c: add --reject-shallow option
    
    Changes since v1:
    
     * Rename --no-shallow to --reject-shallow
     * Enable to reject a non-local clone
     * Enable --[no-]reject-shallow from CLI override configuration.
     * Add more testcases.
     * Reword commit messages and relative documentation.
    
    Changes since v3:
    
     * Add support to reject clone shallow repo over https protocol
     * Add testcase to reject clone shallow repo over https:// transport
     * Reword commit messages and relative documentation according
       suggestions from Junio.
    
    Signed-off-by: lilinchao lilinchao@oschina.cn

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-865%2FCactusinhand%2Fgit-clone-options-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-865/Cactusinhand/git-clone-options-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/865

Range-diff vs v3:

 1:  f5ed6b2e4481 ! 1:  ee4fb840a32f builtin/clone.c: add --reject-shallow option
     @@ Commit message
          builtin/clone.c: add --reject-shallow option
      
          In some scenarios, users may want more history than the repository
     -    offered for cloning, which mostly to be a shallow repository, can
     -    give them. But users don't know it is a shallow repository until
     -    they download it to local, users should have the option to refuse
     -    to clone this kind of repository, and may want to exit the process
     -    immediately without creating any unnecessary files.
     +    offered for cloning, which happens to be a shallow repository, can
     +    give them. But because users don't know it is a shallow repository
     +    until they download it to local, users should have the option to
     +    refuse to clone this kind of repository, and may want to exit the
     +    process immediately without creating any unnecessary files.
      
          Althought there is an option '--depth=x' for users to decide how
          deep history they can fetch, but as the unshallow cloning's depth
     @@ Commit message
          satisfy the minimum integrity, so we can't pass 'x' value to --depth,
          and expect this can obtain a complete history of a repository.
      
     -    In other scenarios, given that we have an API that allow us to import
     -    external repository, and then perform various operations on the repo.
     +    In other scenarios, if we have an API that allow us to import external
     +    repository, and then perform various operations on the repo.
          But if the imported is a shallow one(which is actually possible), it
          will affect the subsequent operations. So we can choose to refuse to
     -    clone, and let's just import an unshallow repository.
     +    clone, and let's just import a normal repository.
      
          This patch offers a new option '--reject-shallow' that can reject to
          clone a shallow repository.
     @@ Documentation/git-clone.txt: SYNOPSIS
       	  [--depth <depth>] [--[no-]single-branch] [--no-tags]
       	  [--recurse-submodules[=<pathspec>]] [--[no-]shallow-submodules]
      -	  [--[no-]remote-submodules] [--jobs <n>] [--sparse]
     -+	  [--[no-]remote-submodules] [--jobs <n>] [--sparse] [--reject-shallow]
     ++	  [--[no-]remote-submodules] [--jobs <n>] [--sparse] [--[no-]reject-shallow]
       	  [--filter=<filter>] [--] <repository>
       	  [<directory>]
       
     @@ Documentation/git-clone.txt: objects from the source repository into a pack in t
       --no-checkout::
       	No checkout of HEAD is performed after the clone is complete.
       
     -+--reject-shallow::
     -+	Don't clone a shallow source repository. In some scenarios, clients
     -+	want the cloned repository information to be complete. Otherwise,
     -+	the cloning process should end immediately without creating any files,
     -+	which can save some disk space. This can override `clone.rejectshallow`
     -+	from the configuration:
     -+
     -+	--------------------------------------------------------------------
     -+	$ git -c clone.rejectshallow=false clone --reject-shallow source out
     -+	--------------------------------------------------------------------
     -+
     -+	While there is a way to countermand a configured "I always refuse to
     -+	clone from a shallow repository" with "but let's allow it only this time":
     -+
     -+	----------------------------------------------------------------------
     -+	$ git -c clone.rejectshallow=true clone --no-reject-shallow source out
     -+	----------------------------------------------------------------------
     ++--[no-]reject-shallow::
     ++	Fail if the source repository is a shallow repository. The
     ++	'clone.rejectshallow' configuration variable can be used to
     ++	give the default.
      +
       --bare::
       	Make a 'bare' Git repository.  That is, instead of
       	creating `<directory>` and placing the administrative
      
       ## builtin/clone.c ##
     +@@
     + #include "connected.h"
     + #include "packfile.h"
     + #include "list-objects-filter-options.h"
     ++#include "shallow.h"
     + 
     + /*
     +  * Overall FIXMEs:
      @@ builtin/clone.c: static int option_no_checkout, option_bare, option_mirror, option_single_branch
       static int option_local = -1, option_no_hardlinks, option_shared;
       static int option_no_tags;
       static int option_shallow_submodules;
     -+static int option_no_shallow = -1;  /* unspecified */
     ++static int option_shallow = -1;    /* unspecified */
      +static int config_shallow = -1;    /* unspecified */
       static int deepen;
       static char *option_template, *option_depth, *option_since;
     @@ builtin/clone.c: static struct option builtin_clone_options[] = {
       	OPT__VERBOSITY(&option_verbosity),
       	OPT_BOOL(0, "progress", &option_progress,
       		 N_("force progress reporting")),
     -+	OPT_BOOL(0, "reject-shallow", &option_no_shallow,
     ++	OPT_BOOL(0, "reject-shallow", &option_shallow,
      +		 N_("don't clone shallow repository")),
       	OPT_BOOL('n', "no-checkout", &option_no_checkout,
       		 N_("don't create a checkout")),
     @@ builtin/clone.c: static int path_exists(const char *path)
       int cmd_clone(int argc, const char **argv, const char *prefix)
       {
       	int is_bundle = 0, is_local;
     -+	int is_shallow = 0;
     ++	int local_shallow = 0;
     ++	int reject_shallow = 0;
       	const char *repo_name, *repo, *work_tree, *git_dir;
       	char *path, *dir, *display_repo = NULL;
       	int dest_exists, real_dest_exists = 0;
      @@ builtin/clone.c: int cmd_clone(int argc, const char **argv, const char *prefix)
     + 	 */
     + 	git_config(git_clone_config, NULL);
       
     - 	path = get_repo_path(remote->url[0], &is_bundle);
     - 	is_local = option_local != 0 && path && !is_bundle;
     -+
     -+	/* Detect if the remote repository is shallow */
     -+	if (!access(mkpath("%s/shallow", path), F_OK)) {
     -+		is_shallow = 1;
     ++	/*
     ++	 * If option_shallow is specified from CLI option,
     ++	 * ignore config_shallow from git_clone_config.
     ++	 */
     ++	if (config_shallow != -1) {
     ++		reject_shallow = config_shallow;
      +	}
     -+
     - 	if (is_local) {
     - 		if (option_depth)
     - 			warning(_("--depth is ignored in local clones; use file:// instead."));
     ++	if (option_shallow != -1) {
     ++		reject_shallow = option_shallow;
     ++	}
     + 	/*
     + 	 * apply the remote name provided by --origin only after this second
     + 	 * call to git_config, to ensure it overrides all config-based values.
      @@ builtin/clone.c: int cmd_clone(int argc, const char **argv, const char *prefix)
     - 			warning(_("--shallow-exclude is ignored in local clones; use file:// instead."));
       		if (filter_options.choice)
       			warning(_("--filter is ignored in local clones; use file:// instead."));
     --		if (!access(mkpath("%s/shallow", path), F_OK)) {
     -+		if (is_shallow) {
     + 		if (!access(mkpath("%s/shallow", path), F_OK)) {
     ++			local_shallow = 1;
       			if (option_local > 0)
       				warning(_("source repository is shallow, ignoring --local"));
       			is_local = 0;
      @@ builtin/clone.c: int cmd_clone(int argc, const char **argv, const char *prefix)
     + 			goto cleanup;
       	}
     - 	if (option_local > 0 && !is_local)
     - 		warning(_("--local is ignored"));
     -+
     -+	if (is_shallow) {
     -+		int reject = 0;
     -+
     -+		/* If option_no_shallow is specified from CLI option,
     -+		 * ignore config_shallow from git_clone_config.
     -+		 */
     -+
     -+		if (config_shallow != -1) {
     -+			reject = config_shallow;
     -+		}
     -+		if (option_no_shallow != -1) {
     -+			reject = option_no_shallow;
     -+		}
     -+		if (reject) {
     + 
     ++	if (reject_shallow) {
     ++		if (local_shallow || is_repository_shallow(the_repository)) {
      +			die(_("source repository is shallow, reject to clone."));
      +		}
      +	}
      +
     - 	transport->cloning = 1;
     - 
     - 	transport_set_option(transport, TRANS_OPT_KEEP, "yes");
     + 	update_remote_refs(refs, mapped_refs, remote_head_points_at,
     + 			   branch_top.buf, reflog_msg.buf, transport,
     + 			   !is_local);
      
       ## t/t5606-clone-options.sh ##
     +@@ t/t5606-clone-options.sh: GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
     ++. "$TEST_DIRECTORY"/lib-httpd.sh
     ++start_httpd
     + 
     + test_expect_success 'setup' '
     + 
      @@ t/t5606-clone-options.sh: test_expect_success 'disallows --bare with --separate-git-dir' '
       
       '
       
     ++test_expect_success 'fail to clone http shallow repository' '
     ++	git clone --depth=1 --no-local parent shallow-repo &&
     ++	git clone --bare --no-local shallow-repo "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
     ++	test_must_fail git clone --reject-shallow $HTTPD_URL/smart/repo.git out 2>err &&
     ++	test_i18ngrep -e "source repository is shallow, reject to clone." err
     ++
     ++'
     ++
      +test_expect_success 'fail to clone shallow repository' '
     ++	rm -rf shallow-repo &&
      +	git clone --depth=1 --no-local parent shallow-repo &&
      +	test_must_fail git clone --reject-shallow shallow-repo out 2>err &&
      +	test_i18ngrep -e "source repository is shallow, reject to clone." err
     @@ t/t5611-clone-config.sh: test_expect_success 'clone -c remote.<remote>.fetch=<re
      +	test_i18ngrep -e "source repository is shallow, reject to clone." err
      +'
      +
     -+test_expect_success 'clone.rejectshallow=false should succeed cloning' '
     ++test_expect_success 'clone.rejectshallow=false should succeed' '
      +	rm -rf child &&
      +	git clone --depth=1 --no-local . child &&
      +	git -c clone.rejectshallow=false clone --no-local child out
      +'
      +
     -+test_expect_success 'clone.rejectshallow=true should succeed cloning normal repo' '
     ++test_expect_success 'clone.rejectshallow=true should succeed with normal repo' '
      +	rm -rf child out &&
      +	git clone --no-local . child &&
      +	git -c clone.rejectshallow=true clone --no-local child out
     @@ t/t5611-clone-config.sh: test_expect_success 'clone -c remote.<remote>.fetch=<re
      +test_expect_success 'option --reject-shallow override clone.rejectshallow' '
      +	rm -rf child out &&
      +	git clone --depth=1 --no-local . child &&
     -+	test_must_fail git clone -c clone.rejectshallow=false  --reject-shallow --no-local child out 2>err &&
     ++	test_must_fail git -c clone.rejectshallow=false clone --reject-shallow --no-local child out 2>err &&
      +	test_i18ngrep -e "source repository is shallow, reject to clone." err
      +'
      +
     -+test_expect_success ' option --no-reject-shallow override clone.rejectshallow' '
     ++test_expect_success 'option --no-reject-shallow override clone.rejectshallow' '
      +	rm -rf child &&
      +	git clone --depth=1 --no-local . child &&
      +	git -c clone.rejectshallow=true clone --no-reject-shallow --no-local child out


 Documentation/config/clone.txt |  4 +++
 Documentation/git-clone.txt    |  7 ++++-
 builtin/clone.c                | 27 +++++++++++++++++++
 t/t5606-clone-options.sh       | 47 ++++++++++++++++++++++++++++++++++
 t/t5611-clone-config.sh        | 32 +++++++++++++++++++++++
 5 files changed, 116 insertions(+), 1 deletion(-)

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
index 02d9c19cec75..cb458123eef6 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -15,7 +15,7 @@ SYNOPSIS
 	  [--dissociate] [--separate-git-dir <git dir>]
 	  [--depth <depth>] [--[no-]single-branch] [--no-tags]
 	  [--recurse-submodules[=<pathspec>]] [--[no-]shallow-submodules]
-	  [--[no-]remote-submodules] [--jobs <n>] [--sparse]
+	  [--[no-]remote-submodules] [--jobs <n>] [--sparse] [--[no-]reject-shallow]
 	  [--filter=<filter>] [--] <repository>
 	  [<directory>]
 
@@ -149,6 +149,11 @@ objects from the source repository into a pack in the cloned repository.
 --no-checkout::
 	No checkout of HEAD is performed after the clone is complete.
 
+--[no-]reject-shallow::
+	Fail if the source repository is a shallow repository. The
+	'clone.rejectshallow' configuration variable can be used to
+	give the default.
+
 --bare::
 	Make a 'bare' Git repository.  That is, instead of
 	creating `<directory>` and placing the administrative
diff --git a/builtin/clone.c b/builtin/clone.c
index 51e844a2de0a..6807eb954366 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -32,6 +32,7 @@
 #include "connected.h"
 #include "packfile.h"
 #include "list-objects-filter-options.h"
+#include "shallow.h"
 
 /*
  * Overall FIXMEs:
@@ -50,6 +51,8 @@ static int option_no_checkout, option_bare, option_mirror, option_single_branch
 static int option_local = -1, option_no_hardlinks, option_shared;
 static int option_no_tags;
 static int option_shallow_submodules;
+static int option_shallow = -1;    /* unspecified */
+static int config_shallow = -1;    /* unspecified */
 static int deepen;
 static char *option_template, *option_depth, *option_since;
 static char *option_origin = NULL;
@@ -90,6 +93,8 @@ static struct option builtin_clone_options[] = {
 	OPT__VERBOSITY(&option_verbosity),
 	OPT_BOOL(0, "progress", &option_progress,
 		 N_("force progress reporting")),
+	OPT_BOOL(0, "reject-shallow", &option_shallow,
+		 N_("don't clone shallow repository")),
 	OPT_BOOL('n', "no-checkout", &option_no_checkout,
 		 N_("don't create a checkout")),
 	OPT_BOOL(0, "bare", &option_bare, N_("create a bare repository")),
@@ -858,6 +863,9 @@ static int git_clone_config(const char *k, const char *v, void *cb)
 		free(remote_name);
 		remote_name = xstrdup(v);
 	}
+	if (!strcmp(k, "clone.rejectshallow")) {
+		config_shallow = git_config_bool(k, v);
+	}
 	return git_default_config(k, v, cb);
 }
 
@@ -963,6 +971,8 @@ static int path_exists(const char *path)
 int cmd_clone(int argc, const char **argv, const char *prefix)
 {
 	int is_bundle = 0, is_local;
+	int local_shallow = 0;
+	int reject_shallow = 0;
 	const char *repo_name, *repo, *work_tree, *git_dir;
 	char *path, *dir, *display_repo = NULL;
 	int dest_exists, real_dest_exists = 0;
@@ -1156,6 +1166,16 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	 */
 	git_config(git_clone_config, NULL);
 
+	/*
+	 * If option_shallow is specified from CLI option,
+	 * ignore config_shallow from git_clone_config.
+	 */
+	if (config_shallow != -1) {
+		reject_shallow = config_shallow;
+	}
+	if (option_shallow != -1) {
+		reject_shallow = option_shallow;
+	}
 	/*
 	 * apply the remote name provided by --origin only after this second
 	 * call to git_config, to ensure it overrides all config-based values.
@@ -1216,6 +1236,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		if (filter_options.choice)
 			warning(_("--filter is ignored in local clones; use file:// instead."));
 		if (!access(mkpath("%s/shallow", path), F_OK)) {
+			local_shallow = 1;
 			if (option_local > 0)
 				warning(_("source repository is shallow, ignoring --local"));
 			is_local = 0;
@@ -1363,6 +1384,12 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 			goto cleanup;
 	}
 
+	if (reject_shallow) {
+		if (local_shallow || is_repository_shallow(the_repository)) {
+			die(_("source repository is shallow, reject to clone."));
+		}
+	}
+
 	update_remote_refs(refs, mapped_refs, remote_head_points_at,
 			   branch_top.buf, reflog_msg.buf, transport,
 			   !is_local);
diff --git a/t/t5606-clone-options.sh b/t/t5606-clone-options.sh
index 52e5789fb050..6170d0513227 100755
--- a/t/t5606-clone-options.sh
+++ b/t/t5606-clone-options.sh
@@ -5,6 +5,8 @@ GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-httpd.sh
+start_httpd
 
 test_expect_success 'setup' '
 
@@ -45,6 +47,51 @@ test_expect_success 'disallows --bare with --separate-git-dir' '
 
 '
 
+test_expect_success 'fail to clone http shallow repository' '
+	git clone --depth=1 --no-local parent shallow-repo &&
+	git clone --bare --no-local shallow-repo "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
+	test_must_fail git clone --reject-shallow $HTTPD_URL/smart/repo.git out 2>err &&
+	test_i18ngrep -e "source repository is shallow, reject to clone." err
+
+'
+
+test_expect_success 'fail to clone shallow repository' '
+	rm -rf shallow-repo &&
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
index 9f555b87ecdf..18268256bfe0 100755
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
+test_expect_success 'clone.rejectshallow=false should succeed' '
+	rm -rf child &&
+	git clone --depth=1 --no-local . child &&
+	git -c clone.rejectshallow=false clone --no-local child out
+'
+
+test_expect_success 'clone.rejectshallow=true should succeed with normal repo' '
+	rm -rf child out &&
+	git clone --no-local . child &&
+	git -c clone.rejectshallow=true clone --no-local child out
+'
+
+test_expect_success 'option --reject-shallow override clone.rejectshallow' '
+	rm -rf child out &&
+	git clone --depth=1 --no-local . child &&
+	test_must_fail git -c clone.rejectshallow=false clone --reject-shallow --no-local child out 2>err &&
+	test_i18ngrep -e "source repository is shallow, reject to clone." err
+'
+
+test_expect_success 'option --no-reject-shallow override clone.rejectshallow' '
+	rm -rf child &&
+	git clone --depth=1 --no-local . child &&
+	git -c clone.rejectshallow=true clone --no-reject-shallow --no-local child out
+'
+
 test_expect_success MINGW 'clone -c core.hideDotFiles' '
 	test_commit attributes .gitattributes "" &&
 	rm -rf child &&

base-commit: 2283e0e9af55689215afa39c03beb2315ce18e83
-- 
gitgitgadget
