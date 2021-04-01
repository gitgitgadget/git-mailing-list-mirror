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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A544C433B4
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 10:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5307C60FED
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 10:47:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233985AbhDAKrL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Apr 2021 06:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234133AbhDAKrD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Apr 2021 06:47:03 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F06C0613E6
        for <git@vger.kernel.org>; Thu,  1 Apr 2021 03:47:03 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id k8so1346940wrc.3
        for <git@vger.kernel.org>; Thu, 01 Apr 2021 03:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=U4gtpLRud8J1itEs7IAkM1zMEQalaYO7qGPdvzRhYS4=;
        b=lv2g1t+RqSOCQUaEELgw6Mijyct44uHddSgPiyuq6Nq1i3LxMnxlHcN5n1ph9QGC5o
         EyuqEKsEC+yVQqxSmpr3LRERhwO23G7gk7IeluWoLvav1mo/wFjirriNyD+2ScGuL3YX
         p8gX9tKOZUMKZ5KaG+S8yjscpuL83UmPuySCw2V+kfCaQWVVameXJRxOgDLWg7pHDftI
         wHTuikVvzaFy2WNMKN2R1NV7EmyHWJtbhCQAMC899xZ7VPzFWe2dfoKdgssKI1Q/SNGJ
         rMm/rsit7fuMAevlgV7Iee9r4DO3hMGlOExfm3zdosGmQBUGfSZ4LbfbOQQ5qDzjpGpu
         Q0hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=U4gtpLRud8J1itEs7IAkM1zMEQalaYO7qGPdvzRhYS4=;
        b=tpuFL6YoCbExEe8CBMu11CjIwglsSpNZWMtEdbGD7nDLzORHXAQJ9DVMgC3BH1hXTJ
         m+fUrEsS9k08w5jVdif9uNdr4XaSIvwrRz+P5FHG5fX01oCRiGEMQ1LawAuYWMr6cEZR
         gPrwqFHOKaL4N14xZTR+6aw7SMmwW8fJ+4XLhr6AWBqUI/gw6i6LmXOs6YNLaShSEXMC
         OPOVfWJIoz21M1tmCaYwahBgvDyQHBQdHf27Irm1lb1GuU7DGjZ8Z4NSAi5sJQDus4ou
         49j5TFzaEdrlkXVcmzrRi7WH5kJ7jqs3enoEs/f684H6HXtGf9lye7W6XJAaG3v91J95
         aKvA==
X-Gm-Message-State: AOAM531bOW657Q6hubHei2/WtcGDT+rCObo6bvYw2gjGXy55/6K3L1Vg
        WXVzEN2sh2ldWDhbfAZ4OEZ/6Wh/nVg=
X-Google-Smtp-Source: ABdhPJyGPSzuPFjbaSIdsP/lUqDSWqUAK6Vp4UP105LqvBkjfHQUV7q2WFHqaLiFo9+O63orck/Cag==
X-Received: by 2002:a5d:591a:: with SMTP id v26mr8885534wrd.172.1617274021792;
        Thu, 01 Apr 2021 03:47:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n6sm9493498wmd.27.2021.04.01.03.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 03:47:01 -0700 (PDT)
Message-Id: <pull.865.v10.git.1617274020517.gitgitgadget@gmail.com>
In-Reply-To: <pull.865.v9.git.1617205915876.gitgitgadget@gmail.com>
References: <pull.865.v9.git.1617205915876.gitgitgadget@gmail.com>
From:   "Li Linchao via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Apr 2021 10:46:59 +0000
Subject: [PATCH v10] builtin/clone.c: add --reject-shallow option
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
        Li Linchao <lilinchao@oschina.cn>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Li Linchao <lilinchao@oschina.cn>

In some scenarios, users may want more history than the repository
offered for cloning, which happens to be a shallow repository, can
give them. But because users don't know it is a shallow repository
until they download it to local, we may want to refuse to clone
this kind of repository, without creating any unnecessary files.

Althought there is an option '--depth=x' for users to decide how
deep history they can fetch, as the unshallow cloning's depth is
INFINITY, we might start with depth x, and the source may be deep
enough to give us x right now, but we may want to deepen more than
they can offer, and such a user would want to be able to say
"I want depth=x now, but make sure they are not shallow".
it's hard to find such a x value to make sure they are not shallow.

Teach '--reject-shallow' option to "git clone" to abort as
soon as we find out that we are cloning from a shallow
repository.

Signed-off-by: Li Linchao <lilinchao@oschina.cn>
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
    
    Changes since v7:
    
     * Clear reviewed-by trailer
     * Drop warning() statement
     * Reword a few test titles
    
    Changes since v8:
    
     * Use single variable for option and config
     * Rename remote_shallow to reject_shallow_remote
     * Simplify test cases
    
    Changes since v9:
    
     * Reword commit message
     * Use option_reject_shallow and config_reject_shallow
    
    Signed-off-by: Li Linchao lilinchao@oschina.cn

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-865%2FCactusinhand%2Fgit-clone-options-v10
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-865/Cactusinhand/git-clone-options-v10
Pull-Request: https://github.com/gitgitgadget/git/pull/865

Range-diff vs v9:

 1:  11043a2344dd ! 1:  cacda5a6af07 builtin/clone.c: add --reject-shallow option
     @@
       ## Metadata ##
     -Author: lilinchao <lilinchao@oschina.cn>
     +Author: Li Linchao <lilinchao@oschina.cn>
      
       ## Commit message ##
          builtin/clone.c: add --reject-shallow option
     @@ Commit message
          In some scenarios, users may want more history than the repository
          offered for cloning, which happens to be a shallow repository, can
          give them. But because users don't know it is a shallow repository
     -    until they download it to local, users should have the option to
     -    refuse to clone this kind of repository, and may want to exit the
     -    process immediately without creating any unnecessary files.
     +    until they download it to local, we may want to refuse to clone
     +    this kind of repository, without creating any unnecessary files.
      
          Althought there is an option '--depth=x' for users to decide how
     -    deep history they can fetch, but as the unshallow cloning's depth
     -    is INFINITY, we can't know exactly the minimun 'x' value that can
     -    satisfy the minimum integrity, so we can't pass 'x' value to --depth,
     -    and expect this can obtain a complete history of a repository.
     +    deep history they can fetch, as the unshallow cloning's depth is
     +    INFINITY, we might start with depth x, and the source may be deep
     +    enough to give us x right now, but we may want to deepen more than
     +    they can offer, and such a user would want to be able to say
     +    "I want depth=x now, but make sure they are not shallow".
     +    it's hard to find such a x value to make sure they are not shallow.
      
     -    In other scenarios, if we have an API that allow us to import external
     -    repository, and then perform various operations on the repo.
     -    But if the imported is a shallow one(which is actually possible), it
     -    will affect the subsequent operations. So we can choose to refuse to
     -    clone, and let's just import a normal repository.
     -
     -    This patch offers a new option '--reject-shallow' that can reject to
     -    clone a shallow repository.
     +    Teach '--reject-shallow' option to "git clone" to abort as
     +    soon as we find out that we are cloning from a shallow
     +    repository.
      
          Signed-off-by: Li Linchao <lilinchao@oschina.cn>
      
     @@ builtin/clone.c: static int option_no_checkout, option_bare, option_mirror, opti
       static int option_no_tags;
       static int option_shallow_submodules;
      +static int option_reject_shallow = -1;    /* unspecified */
     ++static int config_reject_shallow = -1;    /* unspecified */
       static int deepen;
       static char *option_template, *option_depth, *option_since;
       static char *option_origin = NULL;
     @@ builtin/clone.c: static int git_clone_config(const char *k, const char *v, void
       		free(remote_name);
       		remote_name = xstrdup(v);
       	}
     -+	if (!strcmp(k, "clone.rejectshallow") && option_reject_shallow < 0)
     -+		option_reject_shallow = git_config_bool(k, v);
     ++	if (!strcmp(k, "clone.rejectshallow"))
     ++		config_reject_shallow = git_config_bool(k, v);
      +
       	return git_default_config(k, v, cb);
       }
       
     +@@ builtin/clone.c: static int path_exists(const char *path)
     + int cmd_clone(int argc, const char **argv, const char *prefix)
     + {
     + 	int is_bundle = 0, is_local;
     ++	int reject_shallow = 0;
     + 	const char *repo_name, *repo, *work_tree, *git_dir;
     + 	char *path, *dir, *display_repo = NULL;
     + 	int dest_exists, real_dest_exists = 0;
     +@@ builtin/clone.c: int cmd_clone(int argc, const char **argv, const char *prefix)
     + 	 */
     + 	git_config(git_clone_config, NULL);
     + 
     ++	/*
     ++	 * If option_reject_shallow is specified from CLI option,
     ++	 * ignore config_reject_shallow from git_clone_config.
     ++	 */
     ++	if (config_reject_shallow != -1)
     ++		reject_shallow = config_reject_shallow;
     ++	if (option_reject_shallow != -1)
     ++		reject_shallow = option_reject_shallow;
     ++
     + 	/*
     + 	 * apply the remote name provided by --origin only after this second
     + 	 * call to git_config, to ensure it overrides all config-based values.
      @@ builtin/clone.c: int cmd_clone(int argc, const char **argv, const char *prefix)
       		if (filter_options.choice)
       			warning(_("--filter is ignored in local clones; use file:// instead."));
       		if (!access(mkpath("%s/shallow", path), F_OK)) {
     -+			if (option_reject_shallow > 0)
     ++			if (reject_shallow)
      +				die(_("source repository is shallow, reject to clone."));
       			if (option_local > 0)
       				warning(_("source repository is shallow, ignoring --local"));
     @@ builtin/clone.c: int cmd_clone(int argc, const char **argv, const char *prefix)
       
       	transport_set_option(transport, TRANS_OPT_KEEP, "yes");
       
     -+	if (option_reject_shallow > 0)
     ++	if (reject_shallow)
      +		transport_set_option(transport, TRANS_OPT_REJECT_SHALLOW, "1");
       	if (option_depth)
       		transport_set_option(transport, TRANS_OPT_DEPTH,


 Documentation/config/clone.txt |  4 ++++
 Documentation/git-clone.txt    |  7 ++++++-
 builtin/clone.c                | 21 +++++++++++++++++++++
 fetch-pack.c                   | 12 ++++++++----
 fetch-pack.h                   |  1 +
 t/t5601-clone.sh               |  9 +++++++++
 t/t5606-clone-options.sh       | 27 ++++++++++++++++++++++++++-
 t/t5611-clone-config.sh        | 25 +++++++++++++++++++++++++
 transport.c                    |  4 ++++
 transport.h                    |  4 ++++
 10 files changed, 108 insertions(+), 6 deletions(-)

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
index 02d9c19cec75..3fe3810f1ce1 100644
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
+	specify the default.
+
 --bare::
 	Make a 'bare' Git repository.  That is, instead of
 	creating `<directory>` and placing the administrative
diff --git a/builtin/clone.c b/builtin/clone.c
index 51e844a2de0a..2a5485b72499 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -50,6 +50,8 @@ static int option_no_checkout, option_bare, option_mirror, option_single_branch
 static int option_local = -1, option_no_hardlinks, option_shared;
 static int option_no_tags;
 static int option_shallow_submodules;
+static int option_reject_shallow = -1;    /* unspecified */
+static int config_reject_shallow = -1;    /* unspecified */
 static int deepen;
 static char *option_template, *option_depth, *option_since;
 static char *option_origin = NULL;
@@ -90,6 +92,8 @@ static struct option builtin_clone_options[] = {
 	OPT__VERBOSITY(&option_verbosity),
 	OPT_BOOL(0, "progress", &option_progress,
 		 N_("force progress reporting")),
+	OPT_BOOL(0, "reject-shallow", &option_reject_shallow,
+		 N_("don't clone shallow repository")),
 	OPT_BOOL('n', "no-checkout", &option_no_checkout,
 		 N_("don't create a checkout")),
 	OPT_BOOL(0, "bare", &option_bare, N_("create a bare repository")),
@@ -858,6 +862,9 @@ static int git_clone_config(const char *k, const char *v, void *cb)
 		free(remote_name);
 		remote_name = xstrdup(v);
 	}
+	if (!strcmp(k, "clone.rejectshallow"))
+		config_reject_shallow = git_config_bool(k, v);
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
@@ -1156,6 +1164,15 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	 */
 	git_config(git_clone_config, NULL);
 
+	/*
+	 * If option_reject_shallow is specified from CLI option,
+	 * ignore config_reject_shallow from git_clone_config.
+	 */
+	if (config_reject_shallow != -1)
+		reject_shallow = config_reject_shallow;
+	if (option_reject_shallow != -1)
+		reject_shallow = option_reject_shallow;
+
 	/*
 	 * apply the remote name provided by --origin only after this second
 	 * call to git_config, to ensure it overrides all config-based values.
@@ -1216,6 +1233,8 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		if (filter_options.choice)
 			warning(_("--filter is ignored in local clones; use file:// instead."));
 		if (!access(mkpath("%s/shallow", path), F_OK)) {
+			if (reject_shallow)
+				die(_("source repository is shallow, reject to clone."));
 			if (option_local > 0)
 				warning(_("source repository is shallow, ignoring --local"));
 			is_local = 0;
@@ -1227,6 +1246,8 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 
 	transport_set_option(transport, TRANS_OPT_KEEP, "yes");
 
+	if (reject_shallow)
+		transport_set_option(transport, TRANS_OPT_REJECT_SHALLOW, "1");
 	if (option_depth)
 		transport_set_option(transport, TRANS_OPT_DEPTH,
 				     option_depth);
diff --git a/fetch-pack.c b/fetch-pack.c
index fb04a76ca263..40392692ad07 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1129,9 +1129,11 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 	if (args->deepen)
 		setup_alternate_shallow(&shallow_lock, &alternate_shallow_file,
 					NULL);
-	else if (si->nr_ours || si->nr_theirs)
+	else if (si->nr_ours || si->nr_theirs) {
+		if (args->reject_shallow_remote)
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
+			if (args->reject_shallow_remote)
+				die(_("source repository is shallow, reject to clone."));
 			alternate_shallow_file =
 				setup_temporary_shallow(si->shallow);
-		else
+		} else
 			alternate_shallow_file = NULL;
 	} else {
 		alternate_shallow_file = NULL;
diff --git a/fetch-pack.h b/fetch-pack.h
index 736a3dae467a..f114d7277567 100644
--- a/fetch-pack.h
+++ b/fetch-pack.h
@@ -39,6 +39,7 @@ struct fetch_pack_args {
 	unsigned self_contained_and_connected:1;
 	unsigned cloning:1;
 	unsigned update_shallow:1;
+	unsigned reject_shallow_remote:1;
 	unsigned deepen:1;
 
 	/*
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index e7e6c089554c..329ae599fd3c 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -759,6 +759,15 @@ test_expect_success 'partial clone using HTTP' '
 	partial_clone "$HTTPD_DOCUMENT_ROOT_PATH/server" "$HTTPD_URL/smart/server"
 '
 
+test_expect_success 'reject cloning shallow repository using HTTP' '
+	test_when_finished "rm -rf repo" &&
+	git clone --bare --no-local --depth=1 src "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
+	test_must_fail git clone --reject-shallow $HTTPD_URL/smart/repo.git repo 2>err &&
+	test_i18ngrep -e "source repository is shallow, reject to clone." err &&
+
+	git clone --no-reject-shallow $HTTPD_URL/smart/repo.git repo
+'
+
 # DO NOT add non-httpd-specific tests here, because the last part of this
 # test script is only executed when httpd is available and enabled.
 
diff --git a/t/t5606-clone-options.sh b/t/t5606-clone-options.sh
index 428b0aac93fa..3a595c0f82c7 100755
--- a/t/t5606-clone-options.sh
+++ b/t/t5606-clone-options.sh
@@ -11,7 +11,8 @@ test_expect_success 'setup' '
 	mkdir parent &&
 	(cd parent && git init &&
 	 echo one >file && git add file &&
-	 git commit -m one)
+	 git commit -m one) &&
+	git clone --depth=1 --no-local parent shallow-repo
 
 '
 
@@ -45,6 +46,30 @@ test_expect_success 'disallows --bare with --separate-git-dir' '
 
 '
 
+test_expect_success 'reject cloning shallow repository' '
+	test_when_finished "rm -rf repo" &&
+	test_must_fail git clone --reject-shallow shallow-repo out 2>err &&
+	test_i18ngrep -e "source repository is shallow, reject to clone." err &&
+
+	git clone --no-reject-shallow shallow-repo repo
+'
+
+test_expect_success 'reject cloning non-local shallow repository' '
+	test_when_finished "rm -rf repo" &&
+	test_must_fail git clone --reject-shallow --no-local shallow-repo out 2>err &&
+	test_i18ngrep -e "source repository is shallow, reject to clone." err &&
+
+	git clone --no-reject-shallow --no-local shallow-repo repo
+'
+
+test_expect_success 'succeed cloning normal repository' '
+	test_when_finished "rm -rf chilad1 child2 child3 child4 " &&
+	git clone --reject-shallow parent child1 &&
+	git clone --reject-shallow --no-local parent child2 &&
+	git clone --no-reject-shallow parent child3 &&
+	git clone --no-reject-shallow --no-local parent child4
+'
+
 test_expect_success 'uses "origin" for default remote name' '
 
 	git clone parent clone-default-origin &&
diff --git a/t/t5611-clone-config.sh b/t/t5611-clone-config.sh
index 9f555b87ecdf..f8625f915821 100755
--- a/t/t5611-clone-config.sh
+++ b/t/t5611-clone-config.sh
@@ -95,6 +95,31 @@ test_expect_success 'clone -c remote.<remote>.fetch=<refspec> --origin=<name>' '
 	test_cmp expect actual
 '
 
+test_expect_success 'set up shallow repository' '
+	git clone --depth=1 --no-local . shallow-repo
+'
+
+test_expect_success 'clone.rejectshallow=true should reject cloning shallow repo' '
+	test_when_finished "rm -rf out" &&
+	test_must_fail git -c clone.rejectshallow=true clone --no-local shallow-repo out 2>err &&
+	test_i18ngrep -e "source repository is shallow, reject to clone." err &&
+
+	git -c clone.rejectshallow=false clone --no-local shallow-repo out
+'
+
+test_expect_success 'option --[no-]reject-shallow override clone.rejectshallow config' '
+	test_when_finished "rm -rf out" &&
+	test_must_fail git -c clone.rejectshallow=false clone --reject-shallow --no-local shallow-repo out 2>err &&
+	test_i18ngrep -e "source repository is shallow, reject to clone." err &&
+
+	git -c clone.rejectshallow=true clone --no-reject-shallow --no-local shallow-repo out
+'
+
+test_expect_success 'clone.rejectshallow=true should succeed cloning normal repo' '
+	test_when_finished "rm -rf out" &&
+	git -c clone.rejectshallow=true clone --no-local . out
+'
+
 test_expect_success MINGW 'clone -c core.hideDotFiles' '
 	test_commit attributes .gitattributes "" &&
 	rm -rf child &&
diff --git a/transport.c b/transport.c
index 1c4ab676d1b1..b231894f9039 100644
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
+	args.reject_shallow_remote = transport->smart_options->reject_shallow;
 
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
 

base-commit: a65ce7f831aa5fcc596c6d23fcde543d98b39bd7
-- 
gitgitgadget
