Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8032C433DB
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 10:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 980F261874
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 10:20:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232154AbhC2KTl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Mar 2021 06:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbhC2KTI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Mar 2021 06:19:08 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B916C061574
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 03:19:08 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id f22-20020a7bc8d60000b029010c024a1407so8248712wml.2
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 03:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=MRHvITig7iQyhnzCyNQtfQ0NBqEkq+nOq9oMKQvW/0E=;
        b=Nh7NrmPyCFbmp0XLxxDtnVtvZY8CPnc2jI3nFL9iBfp0/V+mAySH8Ob3Fljc7YJtFI
         yVAGbZSHZiGkN1LpLvztSdtd9YiS32pSG6420LK35lNJ6CNqO5jNnA36YRr6SqLcIpcy
         Z1SqLn9hmOHEMDbNi6zD9oYa9XgECiL4JipgoTXKgaP8Sj4deFmjWM8nZ+FwqVecOBdf
         PV7Wp1jbg7GLbVxVLzDLEHHlZqxhQpaBnfZN76pIgXY/t70xBFQbvzFQrnlxpRxszuQh
         b01hF67cksAFYdCuKHeP6L0651K3f+Vqt3hOhl2zmtYGua2HAfa4GAubd498vhMp5XQu
         FEPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=MRHvITig7iQyhnzCyNQtfQ0NBqEkq+nOq9oMKQvW/0E=;
        b=jIylyz0HrDHzf00vqliyqMkH/9jtPPaGToc9wj47WteT9U5FbduSO8OmdJju8upuYY
         935Vl8/BS18x0KV5zzqkTT0fz1iWwjbafRIETLikPx0DayVGRuYkfnCiscRkQjqV2StY
         wxtbcvcT+iK8PNlBXQof4afO/NGWryzzGXJwPHKve7umGeb68Y7kvR84nl2rn44X/dWj
         VQ5KJotjfw00kk1Wh2HSo0IJfXdiz7J7ssLEbP9flrc51C6r1/lU/3FW2l6on7FQ1UXZ
         sqrPp+adjjsj1cg9WCD2d1dPJcEELwXi81phKhf05dqKA6mSicBJkOv7vuB6drBR9VDT
         ypNQ==
X-Gm-Message-State: AOAM532HdPllDy7pwB9JPfMZ12XBt08l7f1EdBBV0FU6nTzAL7wcTIT1
        3u4Nqgd2Cp8DkUn2lSbFjsmfMD6PoVo=
X-Google-Smtp-Source: ABdhPJxtEKN8YYa3+7ekpNPyxu0BCjD2vJ7iul4zWkBI6ArDMtF/xWb7pYYgp7N4SZ5Ontfm6HiUhg==
X-Received: by 2002:a7b:c410:: with SMTP id k16mr23463525wmi.121.1617013146572;
        Mon, 29 Mar 2021 03:19:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m11sm29430076wri.44.2021.03.29.03.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 03:19:06 -0700 (PDT)
Message-Id: <pull.865.v8.git.1617013145206.gitgitgadget@gmail.com>
In-Reply-To: <pull.865.v7.git.1616670558261.gitgitgadget@gmail.com>
References: <pull.865.v7.git.1616670558261.gitgitgadget@gmail.com>
From:   "Li Linchao via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 29 Mar 2021 10:19:04 +0000
Subject: [PATCH v8] builtin/clone.c: add --reject-shallow option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        dscho <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
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
    
    Changes since v5:
    
     * camelcase config variable
     * warning client that source repo is shallow
     * better support ssh:// and git:// protocol v1, v2
    
    Changes since v6:
    
     * use _() for warning/die statement
    
    Signed-off-by: lilinchao lilinchao@oschina.cn

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-865%2FCactusinhand%2Fgit-clone-options-v8
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-865/Cactusinhand/git-clone-options-v8
Pull-Request: https://github.com/gitgitgadget/git/pull/865

Range-diff vs v7:

 1:  b957b77bfd79 ! 1:  83a724f6d771 builtin/clone.c: add --reject-shallow option
     @@ Commit message
      
          Signed-off-by: lilinchao <lilinchao@oschina.cn>
      
     -    Reviewed-by: Derrick Stolee <dstolee@microsoft.com>
     -    Reviewed-by: Junio C Hamano<gitster@pobox.com>
     -    Reviewed-by: Johannes Schindelin <johannes.schindelin@gmx.de>
     -    Reviewed-by: Jonathan Tan<jonathantanmy@google.com>
     -
       ## Documentation/config/clone.txt ##
      @@ Documentation/config/clone.txt: clone.defaultRemoteName::
       	The name of the remote to create when cloning a repository.  Defaults to
     @@ builtin/clone.c: int cmd_clone(int argc, const char **argv, const char *prefix)
       		if (!access(mkpath("%s/shallow", path), F_OK)) {
      +			if (reject_shallow)
      +				die(_("source repository is shallow, reject to clone."));
     -+			else
     -+				warning(_("source repository is shallow."));
       			if (option_local > 0)
       				warning(_("source repository is shallow, ignoring --local"));
       			is_local = 0;
     @@ fetch-pack.c: static struct ref *do_fetch_pack(struct fetch_pack_args *args,
      +	else if (si->nr_ours || si->nr_theirs) {
      +		if (args->remote_shallow)
      +			die(_("source repository is shallow, reject to clone."));
     -+		else
     -+			warning(_("source repository is shallow."));
       		alternate_shallow_file = setup_temporary_shallow(si->shallow);
      -	else
      +	} else
     @@ fetch-pack.c: static void receive_shallow_info(struct fetch_pack_args *args,
      +		if (si->nr_ours || si->nr_theirs) {
      +			if (args->remote_shallow)
      +				die(_("source repository is shallow, reject to clone."));
     -+			else
     -+				warning(_("source repository is shallow."));
       			alternate_shallow_file =
       				setup_temporary_shallow(si->shallow);
      -		else
     @@ t/t5606-clone-options.sh: test_expect_success 'disallows --bare with --separate-
       
       '
       
     -+test_expect_success 'fail to clone http shallow repository' '
     ++test_expect_success 'reject cloning http shallow repository' '
      +	git clone --depth=1 --no-local parent shallow-repo &&
      +	git clone --bare --no-local shallow-repo "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
      +	test_must_fail git clone --reject-shallow $HTTPD_URL/smart/repo.git out 2>err &&
     @@ t/t5606-clone-options.sh: test_expect_success 'disallows --bare with --separate-
      +
      +'
      +
     -+test_expect_success 'fail to clone shallow repository' '
     ++test_expect_success 'reject cloning shallow repository' '
      +	rm -rf shallow-repo &&
      +	git clone --depth=1 --no-local parent shallow-repo &&
      +	test_must_fail git clone --reject-shallow shallow-repo out 2>err &&
     @@ t/t5606-clone-options.sh: test_expect_success 'disallows --bare with --separate-
      +
      +'
      +
     -+test_expect_success 'fail to clone non-local shallow repository' '
     ++test_expect_success 'reject cloning non-local shallow repository' '
      +	rm -rf shallow-repo &&
      +	git clone --depth=1 --no-local parent shallow-repo &&
      +	test_must_fail git clone --reject-shallow --no-local shallow-repo out 2>err &&
     @@ t/t5611-clone-config.sh: test_expect_success 'clone -c remote.<remote>.fetch=<re
       	test_cmp expect actual
       '
       
     -+test_expect_success 'clone.rejectshallow=true should fail to clone' '
     ++test_expect_success 'clone.rejectshallow=true should reject cloning' '
      +	rm -rf child &&
      +	git clone --depth=1 --no-local . child &&
      +	test_must_fail git -c clone.rejectshallow=true clone --no-local child out 2>err &&


 Documentation/config/clone.txt |  4 +++
 Documentation/git-clone.txt    |  7 ++++-
 builtin/clone.c                | 22 ++++++++++++++++
 fetch-pack.c                   | 12 ++++++---
 fetch-pack.h                   |  1 +
 t/t5606-clone-options.sh       | 47 ++++++++++++++++++++++++++++++++++
 t/t5611-clone-config.sh        | 32 +++++++++++++++++++++++
 transport.c                    |  4 +++
 transport.h                    |  4 +++
 9 files changed, 128 insertions(+), 5 deletions(-)

diff --git a/Documentation/config/clone.txt b/Documentation/config/clone.txt
index 47de36a5fedf..7bcfbd18a52a 100644
--- a/Documentation/config/clone.txt
+++ b/Documentation/config/clone.txt
@@ -2,3 +2,7 @@ clone.defaultRemoteName::
 	The name of the remote to create when cloning a repository.  Defaults to
 	`origin`, and can be overridden by passing the `--origin` command-line
 	option to linkgit:git-clone[1].
+
+clone.rejectShallow::
+	Reject to clone a repository if it is a shallow one, can be overridden by
+	passing option `--reject-shallow` in command line. See linkgit:git-clone[1]
diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 02d9c19cec75..0adc98fa7eee 100644
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
+	Fail if the source repository is a shallow repository.
+	The 'clone.rejectShallow' configuration variable can be used to
+	give the default.
+
 --bare::
 	Make a 'bare' Git repository.  That is, instead of
 	creating `<directory>` and placing the administrative
diff --git a/builtin/clone.c b/builtin/clone.c
index 51e844a2de0a..eeddd68a51f4 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -50,6 +50,8 @@ static int option_no_checkout, option_bare, option_mirror, option_single_branch
 static int option_local = -1, option_no_hardlinks, option_shared;
 static int option_no_tags;
 static int option_shallow_submodules;
+static int option_shallow = -1;    /* unspecified */
+static int config_shallow = -1;    /* unspecified */
 static int deepen;
 static char *option_template, *option_depth, *option_since;
 static char *option_origin = NULL;
@@ -90,6 +92,8 @@ static struct option builtin_clone_options[] = {
 	OPT__VERBOSITY(&option_verbosity),
 	OPT_BOOL(0, "progress", &option_progress,
 		 N_("force progress reporting")),
+	OPT_BOOL(0, "reject-shallow", &option_shallow,
+		 N_("don't clone shallow repository")),
 	OPT_BOOL('n', "no-checkout", &option_no_checkout,
 		 N_("don't create a checkout")),
 	OPT_BOOL(0, "bare", &option_bare, N_("create a bare repository")),
@@ -858,6 +862,9 @@ static int git_clone_config(const char *k, const char *v, void *cb)
 		free(remote_name);
 		remote_name = xstrdup(v);
 	}
+	if (!strcmp(k, "clone.rejectshallow"))
+		config_shallow = git_config_bool(k, v);
+
 	return git_default_config(k, v, cb);
 }
 
@@ -963,6 +970,7 @@ static int path_exists(const char *path)
 int cmd_clone(int argc, const char **argv, const char *prefix)
 {
 	int is_bundle = 0, is_local;
+	int reject_shallow = 0;
 	const char *repo_name, *repo, *work_tree, *git_dir;
 	char *path, *dir, *display_repo = NULL;
 	int dest_exists, real_dest_exists = 0;
@@ -1156,6 +1164,16 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	 */
 	git_config(git_clone_config, NULL);
 
+	/*
+	 * If option_shallow is specified from CLI option,
+	 * ignore config_shallow from git_clone_config.
+	 */
+	if (config_shallow != -1)
+		reject_shallow = config_shallow;
+
+	if (option_shallow != -1)
+		reject_shallow = option_shallow;
+
 	/*
 	 * apply the remote name provided by --origin only after this second
 	 * call to git_config, to ensure it overrides all config-based values.
@@ -1216,6 +1234,8 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		if (filter_options.choice)
 			warning(_("--filter is ignored in local clones; use file:// instead."));
 		if (!access(mkpath("%s/shallow", path), F_OK)) {
+			if (reject_shallow)
+				die(_("source repository is shallow, reject to clone."));
 			if (option_local > 0)
 				warning(_("source repository is shallow, ignoring --local"));
 			is_local = 0;
@@ -1227,6 +1247,8 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 
 	transport_set_option(transport, TRANS_OPT_KEEP, "yes");
 
+	if (reject_shallow)
+		transport_set_option(transport, TRANS_OPT_REJECT_SHALLOW, "1");
 	if (option_depth)
 		transport_set_option(transport, TRANS_OPT_DEPTH,
 				     option_depth);
diff --git a/fetch-pack.c b/fetch-pack.c
index fb04a76ca263..34d0c2896e2e 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1129,9 +1129,11 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 	if (args->deepen)
 		setup_alternate_shallow(&shallow_lock, &alternate_shallow_file,
 					NULL);
-	else if (si->nr_ours || si->nr_theirs)
+	else if (si->nr_ours || si->nr_theirs) {
+		if (args->remote_shallow)
+			die(_("source repository is shallow, reject to clone."));
 		alternate_shallow_file = setup_temporary_shallow(si->shallow);
-	else
+	} else
 		alternate_shallow_file = NULL;
 	if (get_pack(args, fd, pack_lockfiles, NULL, sought, nr_sought,
 		     &gitmodules_oids))
@@ -1498,10 +1500,12 @@ static void receive_shallow_info(struct fetch_pack_args *args,
 		 * rejected (unless --update-shallow is set); do the same.
 		 */
 		prepare_shallow_info(si, shallows);
-		if (si->nr_ours || si->nr_theirs)
+		if (si->nr_ours || si->nr_theirs) {
+			if (args->remote_shallow)
+				die(_("source repository is shallow, reject to clone."));
 			alternate_shallow_file =
 				setup_temporary_shallow(si->shallow);
-		else
+		} else
 			alternate_shallow_file = NULL;
 	} else {
 		alternate_shallow_file = NULL;
diff --git a/fetch-pack.h b/fetch-pack.h
index 736a3dae467a..6e4f8f0d738c 100644
--- a/fetch-pack.h
+++ b/fetch-pack.h
@@ -39,6 +39,7 @@ struct fetch_pack_args {
 	unsigned self_contained_and_connected:1;
 	unsigned cloning:1;
 	unsigned update_shallow:1;
+	unsigned remote_shallow:1;
 	unsigned deepen:1;
 
 	/*
diff --git a/t/t5606-clone-options.sh b/t/t5606-clone-options.sh
index 428b0aac93fa..de1cd85983ed 100755
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
 
+test_expect_success 'reject cloning http shallow repository' '
+	git clone --depth=1 --no-local parent shallow-repo &&
+	git clone --bare --no-local shallow-repo "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
+	test_must_fail git clone --reject-shallow $HTTPD_URL/smart/repo.git out 2>err &&
+	test_i18ngrep -e "source repository is shallow, reject to clone." err
+
+'
+
+test_expect_success 'reject cloning shallow repository' '
+	rm -rf shallow-repo &&
+	git clone --depth=1 --no-local parent shallow-repo &&
+	test_must_fail git clone --reject-shallow shallow-repo out 2>err &&
+	test_i18ngrep -e "source repository is shallow, reject to clone." err
+
+'
+
+test_expect_success 'reject cloning non-local shallow repository' '
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
index 9f555b87ecdf..adf873f60300 100755
--- a/t/t5611-clone-config.sh
+++ b/t/t5611-clone-config.sh
@@ -95,6 +95,38 @@ test_expect_success 'clone -c remote.<remote>.fetch=<refspec> --origin=<name>' '
 	test_cmp expect actual
 '
 
+test_expect_success 'clone.rejectshallow=true should reject cloning' '
+	rm -rf child &&
+	git clone --depth=1 --no-local . child &&
+	test_must_fail git -c clone.rejectshallow=true clone --no-local child out 2>err &&
+	test_i18ngrep -e "source repository is shallow, reject to clone." err
+'
+
+test_expect_success 'clone.rejectshallow=false should succeed' '
+	rm -rf child out &&
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
+	rm -rf child out &&
+	git clone --depth=1 --no-local . child &&
+	git -c clone.rejectshallow=true clone --no-reject-shallow --no-local child out
+'
+
 test_expect_success MINGW 'clone -c core.hideDotFiles' '
 	test_commit attributes .gitattributes "" &&
 	rm -rf child &&
diff --git a/transport.c b/transport.c
index 1c4ab676d1b1..a6b9f404d86a 100644
--- a/transport.c
+++ b/transport.c
@@ -236,6 +236,9 @@ static int set_git_option(struct git_transport_options *opts,
 		list_objects_filter_die_if_populated(&opts->filter_options);
 		parse_list_objects_filter(&opts->filter_options, value);
 		return 0;
+	} else if (!strcmp(name, TRANS_OPT_REJECT_SHALLOW)) {
+		opts->reject_shallow = !!value;
+		return 0;
 	}
 	return 1;
 }
@@ -370,6 +373,7 @@ static int fetch_refs_via_pack(struct transport *transport,
 	args.stateless_rpc = transport->stateless_rpc;
 	args.server_options = transport->server_options;
 	args.negotiation_tips = data->options.negotiation_tips;
+	args.remote_shallow = transport->smart_options->reject_shallow;
 
 	if (!data->got_remote_heads) {
 		int i;
diff --git a/transport.h b/transport.h
index 24e15799e714..4d5db0a7f22b 100644
--- a/transport.h
+++ b/transport.h
@@ -14,6 +14,7 @@ struct git_transport_options {
 	unsigned check_self_contained_and_connected : 1;
 	unsigned self_contained_and_connected : 1;
 	unsigned update_shallow : 1;
+	unsigned reject_shallow : 1;
 	unsigned deepen_relative : 1;
 
 	/* see documentation of corresponding flag in fetch-pack.h */
@@ -194,6 +195,9 @@ void transport_check_allowed(const char *type);
 /* Aggressively fetch annotated tags if possible */
 #define TRANS_OPT_FOLLOWTAGS "followtags"
 
+/* Reject shallow repo transport */
+#define TRANS_OPT_REJECT_SHALLOW "rejectshallow"
+
 /* Accept refs that may update .git/shallow without --depth */
 #define TRANS_OPT_UPDATE_SHALLOW "updateshallow"
 

base-commit: 84d06cdc06389ae7c462434cb7b1db0980f63860
-- 
gitgitgadget
