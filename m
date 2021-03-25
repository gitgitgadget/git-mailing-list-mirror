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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C46C433DB
	for <git@archiver.kernel.org>; Thu, 25 Mar 2021 11:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0EAA61A26
	for <git@archiver.kernel.org>; Thu, 25 Mar 2021 11:10:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbhCYLJq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Mar 2021 07:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbhCYLJZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Mar 2021 07:09:25 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE8FC06174A
        for <git@vger.kernel.org>; Thu, 25 Mar 2021 04:09:20 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id j9so121345wrx.12
        for <git@vger.kernel.org>; Thu, 25 Mar 2021 04:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=xRxJegNd1DDpht9Rg43F/k3kIAe83vl+KvAaLj8kYkw=;
        b=SLqPVLsAKNN2jJkKEjpyV02kNyUpAshaNg9ZrlqGb6ZPokhEqKNu1z4IINXvluyR9Y
         11AfqNdclKIoipmkgDcLrMm9UI06bsdycg+8L8/dF49sLvcnMZtlFOWqsVs1FiZw1hyL
         dEy9cswYBp3ErTsdMKCHK9RIpTSA0CGIuoBsqCsBh14Br9SI1bKOiulsmDaYHvebXWMU
         GSAc5keouwPM0gJxfOD8f6ZE9n7a01ETb9tNjoLpaE0hwi6dlh/HIIDSoa3Uudt81eNg
         tPcj6Sg6WR/53Ch6uawavv5ikRefdz/JV4IRr80oQT858L6StyPwTatwXe2ZtRrw/+2Q
         vurA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=xRxJegNd1DDpht9Rg43F/k3kIAe83vl+KvAaLj8kYkw=;
        b=jc2Ae88qs7Az2psr0w4a23Q2VKRam9zB3CzLHB9h5+LKdDYgVAeb77dy9ctWNpfyXO
         WJkk8oQlJeq+o/QwubUIFlGyPhLQ25a7gObdQ7m4+32C2qtseYylkQOzq0Nx5aWkHKOo
         X8qO7c58ib2RifyBtUYeKCiOtey4zW2ye9sbgjI+2XejUfmmeh5utK/CBuxlf+SINSKq
         l1Cx7xTbkjYhuMmyKX5ITEbFUOROZi3HgIMhr19MaE1niYqQijd0dRGKklqPCeLo9uiN
         2GylzITz2ezYf8R5n/vE9raYgWsD8WXZjbJTvzWD2ufZ1XSN3N3+qFQkQ21taJQqQNe8
         5EDQ==
X-Gm-Message-State: AOAM531gShPRqbb8++XNv4wV/Yqj7wu5vATk4r88YpFQPffH9XVYsCVV
        mRpFDADrA62LXNa+TNjzFMrsRnBfbE0=
X-Google-Smtp-Source: ABdhPJyPe5NI3bbgRE+zK7QGUELg6O93py2yBz/oVQ29Y30aZVFBwgteb1Awx2AtupolZwzbUR05mA==
X-Received: by 2002:a5d:6a11:: with SMTP id m17mr8577094wru.361.1616670559571;
        Thu, 25 Mar 2021 04:09:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y205sm7176787wmc.18.2021.03.25.04.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 04:09:18 -0700 (PDT)
Message-Id: <pull.865.v7.git.1616670558261.gitgitgadget@gmail.com>
In-Reply-To: <pull.865.v6.git.1614878345754.gitgitgadget@gmail.com>
References: <pull.865.v6.git.1614878345754.gitgitgadget@gmail.com>
From:   "Li Linchao via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 25 Mar 2021 11:09:17 +0000
Subject: [PATCH v7] builtin/clone.c: add --reject-shallow option
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

Reviewed-by: Derrick Stolee <dstolee@microsoft.com>
Reviewed-by: Junio C Hamano<gitster@pobox.com>
Reviewed-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Reviewed-by: Jonathan Tan<jonathantanmy@google.com>
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

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-865%2FCactusinhand%2Fgit-clone-options-v7
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-865/Cactusinhand/git-clone-options-v7
Pull-Request: https://github.com/gitgitgadget/git/pull/865

Range-diff vs v6:

 1:  953122588ca8 ! 1:  b957b77bfd79 builtin/clone.c: add --reject-shallow option
     @@ Commit message
      
          Signed-off-by: lilinchao <lilinchao@oschina.cn>
      
     +    Reviewed-by: Derrick Stolee <dstolee@microsoft.com>
     +    Reviewed-by: Junio C Hamano<gitster@pobox.com>
     +    Reviewed-by: Johannes Schindelin <johannes.schindelin@gmx.de>
     +    Reviewed-by: Jonathan Tan<jonathantanmy@google.com>
     +
       ## Documentation/config/clone.txt ##
      @@ Documentation/config/clone.txt: clone.defaultRemoteName::
       	The name of the remote to create when cloning a repository.  Defaults to
     @@ builtin/clone.c: int cmd_clone(int argc, const char **argv, const char *prefix)
       			warning(_("--filter is ignored in local clones; use file:// instead."));
       		if (!access(mkpath("%s/shallow", path), F_OK)) {
      +			if (reject_shallow)
     -+				die("source repository is shallow, reject to clone.");
     ++				die(_("source repository is shallow, reject to clone."));
      +			else
     -+				warning("source repository is shallow.");
     ++				warning(_("source repository is shallow."));
       			if (option_local > 0)
       				warning(_("source repository is shallow, ignoring --local"));
       			is_local = 0;
     @@ builtin/clone.c: int cmd_clone(int argc, const char **argv, const char *prefix)
      
       ## fetch-pack.c ##
      @@ fetch-pack.c: static struct ref *do_fetch_pack(struct fetch_pack_args *args,
     - 
     - 	if (args->stateless_rpc)
     - 		packet_flush(fd[1]);
     -+
       	if (args->deepen)
       		setup_alternate_shallow(&shallow_lock, &alternate_shallow_file,
       					NULL);
      -	else if (si->nr_ours || si->nr_theirs)
      +	else if (si->nr_ours || si->nr_theirs) {
      +		if (args->remote_shallow)
     -+			die("source repository is shallow, reject to clone.");
     ++			die(_("source repository is shallow, reject to clone."));
      +		else
     -+			warning("source repository is shallow.");
     ++			warning(_("source repository is shallow."));
       		alternate_shallow_file = setup_temporary_shallow(si->shallow);
      -	else
      +	} else
     @@ fetch-pack.c: static void receive_shallow_info(struct fetch_pack_args *args,
      -		if (si->nr_ours || si->nr_theirs)
      +		if (si->nr_ours || si->nr_theirs) {
      +			if (args->remote_shallow)
     -+				die("source repository is shallow, reject to clone.");
     ++				die(_("source repository is shallow, reject to clone."));
      +			else
     -+				warning("source repository is shallow.");
     ++				warning(_("source repository is shallow."));
       			alternate_shallow_file =
       				setup_temporary_shallow(si->shallow);
      -		else


 Documentation/config/clone.txt |  4 +++
 Documentation/git-clone.txt    |  7 ++++-
 builtin/clone.c                | 24 +++++++++++++++++
 fetch-pack.c                   | 16 +++++++++---
 fetch-pack.h                   |  1 +
 t/t5606-clone-options.sh       | 47 ++++++++++++++++++++++++++++++++++
 t/t5611-clone-config.sh        | 32 +++++++++++++++++++++++
 transport.c                    |  4 +++
 transport.h                    |  4 +++
 9 files changed, 134 insertions(+), 5 deletions(-)

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
index 51e844a2de0a..a1956b0c9c6f 100644
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
@@ -1216,6 +1234,10 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		if (filter_options.choice)
 			warning(_("--filter is ignored in local clones; use file:// instead."));
 		if (!access(mkpath("%s/shallow", path), F_OK)) {
+			if (reject_shallow)
+				die(_("source repository is shallow, reject to clone."));
+			else
+				warning(_("source repository is shallow."));
 			if (option_local > 0)
 				warning(_("source repository is shallow, ignoring --local"));
 			is_local = 0;
@@ -1227,6 +1249,8 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 
 	transport_set_option(transport, TRANS_OPT_KEEP, "yes");
 
+	if (reject_shallow)
+		transport_set_option(transport, TRANS_OPT_REJECT_SHALLOW, "1");
 	if (option_depth)
 		transport_set_option(transport, TRANS_OPT_DEPTH,
 				     option_depth);
diff --git a/fetch-pack.c b/fetch-pack.c
index fb04a76ca263..72b378449a07 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1129,9 +1129,13 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 	if (args->deepen)
 		setup_alternate_shallow(&shallow_lock, &alternate_shallow_file,
 					NULL);
-	else if (si->nr_ours || si->nr_theirs)
+	else if (si->nr_ours || si->nr_theirs) {
+		if (args->remote_shallow)
+			die(_("source repository is shallow, reject to clone."));
+		else
+			warning(_("source repository is shallow."));
 		alternate_shallow_file = setup_temporary_shallow(si->shallow);
-	else
+	} else
 		alternate_shallow_file = NULL;
 	if (get_pack(args, fd, pack_lockfiles, NULL, sought, nr_sought,
 		     &gitmodules_oids))
@@ -1498,10 +1502,14 @@ static void receive_shallow_info(struct fetch_pack_args *args,
 		 * rejected (unless --update-shallow is set); do the same.
 		 */
 		prepare_shallow_info(si, shallows);
-		if (si->nr_ours || si->nr_theirs)
+		if (si->nr_ours || si->nr_theirs) {
+			if (args->remote_shallow)
+				die(_("source repository is shallow, reject to clone."));
+			else
+				warning(_("source repository is shallow."));
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
index 428b0aac93fa..2863b8b28d44 100755
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
index 9f555b87ecdf..da10d3f10352 100755
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
 

base-commit: 9198c13e34f6d51c983b31a9397d4d62bc2147ac
-- 
gitgitgadget
