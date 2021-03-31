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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32ECFC43460
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 15:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 085236103E
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 15:52:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235410AbhCaPwI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Mar 2021 11:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235566AbhCaPv7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Mar 2021 11:51:59 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15927C061574
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 08:51:59 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id d8-20020a1c1d080000b029010f15546281so1379989wmd.4
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 08:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fQXTaG5UAJwTA7Dm6aFUIVx5fzFkWlMPuSmNCq6Nj5o=;
        b=HTZmRYkrps8Nap75sZY2HWz7O37GE83jmI8IT/azcigHyALOdFzGdksew296muVou0
         cKOu9u4qJTMUketI0UXzRQuzkJACqGWt8DzV35+bJLdV65J47sAj7df0T208WWvgrV8k
         pCSjC1ftd/VmHfFRy1vhUd/UhI92gGCXKAqT8ULkrDCufb+Wyma6uQsNycYq+ew04ipT
         LsHAxewfrKilgoUXW1QPA4QroB0Hwctw7hKGCrJ2hFpWc0Oq8SwAjZNFgI8g4c2ouRKv
         +RCHXu1LvwnQYaOsBOzHn6Qags1Lb4/HoSlpA+RrJk4I41HrXHK9hm7FojyxnHjM1qQU
         qLFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=fQXTaG5UAJwTA7Dm6aFUIVx5fzFkWlMPuSmNCq6Nj5o=;
        b=CbHESUdnUxqbKlATAslJOtzufDRnu2WeJkaaMjMb7F50ZzFujlNVIv192txp2m3fCF
         xPNtlTzw+UWmUt47/tgfyi5rmdHGYMlN0svMocYDWMh4UiYBGuSYLejhAA3JwgTa1aZF
         BATMATca+0GroVvKiV5z/uigLpJXNRWnhQduSBUKBZSVOnKVqqenUjUQAzj1BN7CsCbD
         JmkvxEWCo2PDPIdEdXZnCvW6GpbyFvpi1LWJhxi5Ayi5fFxjipe4RG42ptepTGb7mgH+
         0Cg4uwdhCDtAH6rQIctDwuKQ0lRVpdmORmwEjQeUTctrsWxPd8C0+9vqnVMvRO8GCL31
         iaYg==
X-Gm-Message-State: AOAM533gPO4C/jmJZH0mhVhNodBwo2guM62VGVT1nW6Z9ZqrGSLOqHwR
        7Cm7ek+FwI7nbMmbSv4JYic1z4+pWKM=
X-Google-Smtp-Source: ABdhPJzaoQznSabiln80d93DVoHCbUuJ9No7lFYBP3sQ4l2svjBRYkjXxN/QyfL5HIqv6yGgvdbaAA==
X-Received: by 2002:a05:600c:2945:: with SMTP id n5mr3785856wmd.78.1617205917603;
        Wed, 31 Mar 2021 08:51:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f2sm4822527wmp.20.2021.03.31.08.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 08:51:56 -0700 (PDT)
Message-Id: <pull.865.v9.git.1617205915876.gitgitgadget@gmail.com>
In-Reply-To: <pull.865.v8.git.1617013145206.gitgitgadget@gmail.com>
References: <pull.865.v8.git.1617013145206.gitgitgadget@gmail.com>
From:   "lilinchao via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 31 Mar 2021 15:51:55 +0000
Subject: [PATCH v9] builtin/clone.c: add --reject-shallow option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        dscho <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        lilinchao <lilinchao@oschina.cn>,
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
    
    Signed-off-by: lilinchao lilinchao@oschina.cn

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-865%2FCactusinhand%2Fgit-clone-options-v9
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-865/Cactusinhand/git-clone-options-v9
Pull-Request: https://github.com/gitgitgadget/git/pull/865

Range-diff vs v8:

 1:  83a724f6d771 ! 1:  11043a2344dd builtin/clone.c: add --reject-shallow option
     @@ Commit message
          This patch offers a new option '--reject-shallow' that can reject to
          clone a shallow repository.
      
     -    Signed-off-by: lilinchao <lilinchao@oschina.cn>
     +    Signed-off-by: Li Linchao <lilinchao@oschina.cn>
      
       ## Documentation/config/clone.txt ##
      @@ Documentation/config/clone.txt: clone.defaultRemoteName::
     @@ Documentation/git-clone.txt: objects from the source repository into a pack in t
      +--[no-]reject-shallow::
      +	Fail if the source repository is a shallow repository.
      +	The 'clone.rejectShallow' configuration variable can be used to
     -+	give the default.
     ++	specify the default.
      +
       --bare::
       	Make a 'bare' Git repository.  That is, instead of
     @@ builtin/clone.c: static int option_no_checkout, option_bare, option_mirror, opti
       static int option_local = -1, option_no_hardlinks, option_shared;
       static int option_no_tags;
       static int option_shallow_submodules;
     -+static int option_shallow = -1;    /* unspecified */
     -+static int config_shallow = -1;    /* unspecified */
     ++static int option_reject_shallow = -1;    /* unspecified */
       static int deepen;
       static char *option_template, *option_depth, *option_since;
       static char *option_origin = NULL;
     @@ builtin/clone.c: static struct option builtin_clone_options[] = {
       	OPT__VERBOSITY(&option_verbosity),
       	OPT_BOOL(0, "progress", &option_progress,
       		 N_("force progress reporting")),
     -+	OPT_BOOL(0, "reject-shallow", &option_shallow,
     ++	OPT_BOOL(0, "reject-shallow", &option_reject_shallow,
      +		 N_("don't clone shallow repository")),
       	OPT_BOOL('n', "no-checkout", &option_no_checkout,
       		 N_("don't create a checkout")),
     @@ builtin/clone.c: static int git_clone_config(const char *k, const char *v, void
       		free(remote_name);
       		remote_name = xstrdup(v);
       	}
     -+	if (!strcmp(k, "clone.rejectshallow"))
     -+		config_shallow = git_config_bool(k, v);
     ++	if (!strcmp(k, "clone.rejectshallow") && option_reject_shallow < 0)
     ++		option_reject_shallow = git_config_bool(k, v);
      +
       	return git_default_config(k, v, cb);
       }
       
     -@@ builtin/clone.c: static int path_exists(const char *path)
     - int cmd_clone(int argc, const char **argv, const char *prefix)
     - {
     - 	int is_bundle = 0, is_local;
     -+	int reject_shallow = 0;
     - 	const char *repo_name, *repo, *work_tree, *git_dir;
     - 	char *path, *dir, *display_repo = NULL;
     - 	int dest_exists, real_dest_exists = 0;
     -@@ builtin/clone.c: int cmd_clone(int argc, const char **argv, const char *prefix)
     - 	 */
     - 	git_config(git_clone_config, NULL);
     - 
     -+	/*
     -+	 * If option_shallow is specified from CLI option,
     -+	 * ignore config_shallow from git_clone_config.
     -+	 */
     -+	if (config_shallow != -1)
     -+		reject_shallow = config_shallow;
     -+
     -+	if (option_shallow != -1)
     -+		reject_shallow = option_shallow;
     -+
     - 	/*
     - 	 * apply the remote name provided by --origin only after this second
     - 	 * call to git_config, to ensure it overrides all config-based values.
      @@ builtin/clone.c: int cmd_clone(int argc, const char **argv, const char *prefix)
       		if (filter_options.choice)
       			warning(_("--filter is ignored in local clones; use file:// instead."));
       		if (!access(mkpath("%s/shallow", path), F_OK)) {
     -+			if (reject_shallow)
     ++			if (option_reject_shallow > 0)
      +				die(_("source repository is shallow, reject to clone."));
       			if (option_local > 0)
       				warning(_("source repository is shallow, ignoring --local"));
     @@ builtin/clone.c: int cmd_clone(int argc, const char **argv, const char *prefix)
       
       	transport_set_option(transport, TRANS_OPT_KEEP, "yes");
       
     -+	if (reject_shallow)
     ++	if (option_reject_shallow > 0)
      +		transport_set_option(transport, TRANS_OPT_REJECT_SHALLOW, "1");
       	if (option_depth)
       		transport_set_option(transport, TRANS_OPT_DEPTH,
     @@ fetch-pack.c: static struct ref *do_fetch_pack(struct fetch_pack_args *args,
       					NULL);
      -	else if (si->nr_ours || si->nr_theirs)
      +	else if (si->nr_ours || si->nr_theirs) {
     -+		if (args->remote_shallow)
     ++		if (args->reject_shallow_remote)
      +			die(_("source repository is shallow, reject to clone."));
       		alternate_shallow_file = setup_temporary_shallow(si->shallow);
      -	else
     @@ fetch-pack.c: static void receive_shallow_info(struct fetch_pack_args *args,
       		prepare_shallow_info(si, shallows);
      -		if (si->nr_ours || si->nr_theirs)
      +		if (si->nr_ours || si->nr_theirs) {
     -+			if (args->remote_shallow)
     ++			if (args->reject_shallow_remote)
      +				die(_("source repository is shallow, reject to clone."));
       			alternate_shallow_file =
       				setup_temporary_shallow(si->shallow);
     @@ fetch-pack.h: struct fetch_pack_args {
       	unsigned self_contained_and_connected:1;
       	unsigned cloning:1;
       	unsigned update_shallow:1;
     -+	unsigned remote_shallow:1;
     ++	unsigned reject_shallow_remote:1;
       	unsigned deepen:1;
       
       	/*
      
     - ## t/t5606-clone-options.sh ##
     -@@ t/t5606-clone-options.sh: GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     - export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + ## t/t5601-clone.sh ##
     +@@ t/t5601-clone.sh: test_expect_success 'partial clone using HTTP' '
     + 	partial_clone "$HTTPD_DOCUMENT_ROOT_PATH/server" "$HTTPD_URL/smart/server"
     + '
       
     - . ./test-lib.sh
     -+. "$TEST_DIRECTORY"/lib-httpd.sh
     -+start_httpd
     ++test_expect_success 'reject cloning shallow repository using HTTP' '
     ++	test_when_finished "rm -rf repo" &&
     ++	git clone --bare --no-local --depth=1 src "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
     ++	test_must_fail git clone --reject-shallow $HTTPD_URL/smart/repo.git repo 2>err &&
     ++	test_i18ngrep -e "source repository is shallow, reject to clone." err &&
     ++
     ++	git clone --no-reject-shallow $HTTPD_URL/smart/repo.git repo
     ++'
     ++
     + # DO NOT add non-httpd-specific tests here, because the last part of this
     + # test script is only executed when httpd is available and enabled.
     + 
     +
     + ## t/t5606-clone-options.sh ##
     +@@ t/t5606-clone-options.sh: test_expect_success 'setup' '
     + 	mkdir parent &&
     + 	(cd parent && git init &&
     + 	 echo one >file && git add file &&
     +-	 git commit -m one)
     ++	 git commit -m one) &&
     ++	git clone --depth=1 --no-local parent shallow-repo
       
     - test_expect_success 'setup' '
     + '
       
      @@ t/t5606-clone-options.sh: test_expect_success 'disallows --bare with --separate-git-dir' '
       
       '
       
     -+test_expect_success 'reject cloning http shallow repository' '
     -+	git clone --depth=1 --no-local parent shallow-repo &&
     -+	git clone --bare --no-local shallow-repo "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
     -+	test_must_fail git clone --reject-shallow $HTTPD_URL/smart/repo.git out 2>err &&
     -+	test_i18ngrep -e "source repository is shallow, reject to clone." err
     -+
     -+'
     -+
      +test_expect_success 'reject cloning shallow repository' '
     -+	rm -rf shallow-repo &&
     -+	git clone --depth=1 --no-local parent shallow-repo &&
     ++	test_when_finished "rm -rf repo" &&
      +	test_must_fail git clone --reject-shallow shallow-repo out 2>err &&
     -+	test_i18ngrep -e "source repository is shallow, reject to clone." err
     ++	test_i18ngrep -e "source repository is shallow, reject to clone." err &&
      +
     ++	git clone --no-reject-shallow shallow-repo repo
      +'
      +
      +test_expect_success 'reject cloning non-local shallow repository' '
     -+	rm -rf shallow-repo &&
     -+	git clone --depth=1 --no-local parent shallow-repo &&
     ++	test_when_finished "rm -rf repo" &&
      +	test_must_fail git clone --reject-shallow --no-local shallow-repo out 2>err &&
     -+	test_i18ngrep -e "source repository is shallow, reject to clone." err
     ++	test_i18ngrep -e "source repository is shallow, reject to clone." err &&
      +
     ++	git clone --no-reject-shallow --no-local shallow-repo repo
      +'
      +
     -+test_expect_success 'clone shallow repository with --no-reject-shallow' '
     -+	rm -rf shallow-repo &&
     -+	git clone --depth=1 --no-local parent shallow-repo &&
     -+	git clone --no-reject-shallow --no-local shallow-repo clone-repo
     -+
     -+'
     -+
     -+test_expect_success 'clone normal repository with --reject-shallow' '
     -+	rm -rf clone-repo &&
     -+	git clone --no-local parent normal-repo &&
     -+	git clone --reject-shallow --no-local normal-repo clone-repo
     -+
     -+'
     -+
     -+test_expect_success 'unspecified any configs or options' '
     -+	rm -rf shallow-repo clone-repo &&
     -+	git clone --depth=1 --no-local parent shallow-repo &&
     -+	git clone shallow-repo clone-repo
     -+
     ++test_expect_success 'succeed cloning normal repository' '
     ++	test_when_finished "rm -rf chilad1 child2 child3 child4 " &&
     ++	git clone --reject-shallow parent child1 &&
     ++	git clone --reject-shallow --no-local parent child2 &&
     ++	git clone --no-reject-shallow parent child3 &&
     ++	git clone --no-reject-shallow --no-local parent child4
      +'
      +
       test_expect_success 'uses "origin" for default remote name' '
     @@ t/t5611-clone-config.sh: test_expect_success 'clone -c remote.<remote>.fetch=<re
       	test_cmp expect actual
       '
       
     -+test_expect_success 'clone.rejectshallow=true should reject cloning' '
     -+	rm -rf child &&
     -+	git clone --depth=1 --no-local . child &&
     -+	test_must_fail git -c clone.rejectshallow=true clone --no-local child out 2>err &&
     -+	test_i18ngrep -e "source repository is shallow, reject to clone." err
     ++test_expect_success 'set up shallow repository' '
     ++	git clone --depth=1 --no-local . shallow-repo
      +'
      +
     -+test_expect_success 'clone.rejectshallow=false should succeed' '
     -+	rm -rf child out &&
     -+	git clone --depth=1 --no-local . child &&
     -+	git -c clone.rejectshallow=false clone --no-local child out
     -+'
     ++test_expect_success 'clone.rejectshallow=true should reject cloning shallow repo' '
     ++	test_when_finished "rm -rf out" &&
     ++	test_must_fail git -c clone.rejectshallow=true clone --no-local shallow-repo out 2>err &&
     ++	test_i18ngrep -e "source repository is shallow, reject to clone." err &&
      +
     -+test_expect_success 'clone.rejectshallow=true should succeed with normal repo' '
     -+	rm -rf child out &&
     -+	git clone --no-local . child &&
     -+	git -c clone.rejectshallow=true clone --no-local child out
     ++	git -c clone.rejectshallow=false clone --no-local shallow-repo out
      +'
      +
     -+test_expect_success 'option --reject-shallow override clone.rejectshallow' '
     -+	rm -rf child out &&
     -+	git clone --depth=1 --no-local . child &&
     -+	test_must_fail git -c clone.rejectshallow=false clone --reject-shallow --no-local child out 2>err &&
     -+	test_i18ngrep -e "source repository is shallow, reject to clone." err
     ++test_expect_success 'option --[no-]reject-shallow override clone.rejectshallow config' '
     ++	test_when_finished "rm -rf out" &&
     ++	test_must_fail git -c clone.rejectshallow=false clone --reject-shallow --no-local shallow-repo out 2>err &&
     ++	test_i18ngrep -e "source repository is shallow, reject to clone." err &&
     ++
     ++	git -c clone.rejectshallow=true clone --no-reject-shallow --no-local shallow-repo out
      +'
      +
     -+test_expect_success 'option --no-reject-shallow override clone.rejectshallow' '
     -+	rm -rf child out &&
     -+	git clone --depth=1 --no-local . child &&
     -+	git -c clone.rejectshallow=true clone --no-reject-shallow --no-local child out
     ++test_expect_success 'clone.rejectshallow=true should succeed cloning normal repo' '
     ++	test_when_finished "rm -rf out" &&
     ++	git -c clone.rejectshallow=true clone --no-local . out
      +'
      +
       test_expect_success MINGW 'clone -c core.hideDotFiles' '
     @@ transport.c: static int fetch_refs_via_pack(struct transport *transport,
       	args.stateless_rpc = transport->stateless_rpc;
       	args.server_options = transport->server_options;
       	args.negotiation_tips = data->options.negotiation_tips;
     -+	args.remote_shallow = transport->smart_options->reject_shallow;
     ++	args.reject_shallow_remote = transport->smart_options->reject_shallow;
       
       	if (!data->got_remote_heads) {
       		int i;


 Documentation/config/clone.txt |  4 ++++
 Documentation/git-clone.txt    |  7 ++++++-
 builtin/clone.c                | 10 ++++++++++
 fetch-pack.c                   | 12 ++++++++----
 fetch-pack.h                   |  1 +
 t/t5601-clone.sh               |  9 +++++++++
 t/t5606-clone-options.sh       | 27 ++++++++++++++++++++++++++-
 t/t5611-clone-config.sh        | 25 +++++++++++++++++++++++++
 transport.c                    |  4 ++++
 transport.h                    |  4 ++++
 10 files changed, 97 insertions(+), 6 deletions(-)

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
index 51e844a2de0a..d67a9f254c80 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -50,6 +50,7 @@ static int option_no_checkout, option_bare, option_mirror, option_single_branch
 static int option_local = -1, option_no_hardlinks, option_shared;
 static int option_no_tags;
 static int option_shallow_submodules;
+static int option_reject_shallow = -1;    /* unspecified */
 static int deepen;
 static char *option_template, *option_depth, *option_since;
 static char *option_origin = NULL;
@@ -90,6 +91,8 @@ static struct option builtin_clone_options[] = {
 	OPT__VERBOSITY(&option_verbosity),
 	OPT_BOOL(0, "progress", &option_progress,
 		 N_("force progress reporting")),
+	OPT_BOOL(0, "reject-shallow", &option_reject_shallow,
+		 N_("don't clone shallow repository")),
 	OPT_BOOL('n', "no-checkout", &option_no_checkout,
 		 N_("don't create a checkout")),
 	OPT_BOOL(0, "bare", &option_bare, N_("create a bare repository")),
@@ -858,6 +861,9 @@ static int git_clone_config(const char *k, const char *v, void *cb)
 		free(remote_name);
 		remote_name = xstrdup(v);
 	}
+	if (!strcmp(k, "clone.rejectshallow") && option_reject_shallow < 0)
+		option_reject_shallow = git_config_bool(k, v);
+
 	return git_default_config(k, v, cb);
 }
 
@@ -1216,6 +1222,8 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		if (filter_options.choice)
 			warning(_("--filter is ignored in local clones; use file:// instead."));
 		if (!access(mkpath("%s/shallow", path), F_OK)) {
+			if (option_reject_shallow > 0)
+				die(_("source repository is shallow, reject to clone."));
 			if (option_local > 0)
 				warning(_("source repository is shallow, ignoring --local"));
 			is_local = 0;
@@ -1227,6 +1235,8 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 
 	transport_set_option(transport, TRANS_OPT_KEEP, "yes");
 
+	if (option_reject_shallow > 0)
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
