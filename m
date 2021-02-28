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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 056FEC433E0
	for <git@archiver.kernel.org>; Sun, 28 Feb 2021 18:07:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B349F64E74
	for <git@archiver.kernel.org>; Sun, 28 Feb 2021 18:07:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbhB1SHP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Feb 2021 13:07:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbhB1SHM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Feb 2021 13:07:12 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04DE5C06174A
        for <git@vger.kernel.org>; Sun, 28 Feb 2021 10:06:32 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id 7so13719965wrz.0
        for <git@vger.kernel.org>; Sun, 28 Feb 2021 10:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=arIEoPeuqw6WbaMhLZ8/W4LMBJk3G8knNDxBfT+scx4=;
        b=WAz8YuDcRr3NjqjGOnINij6iAhTCdYPm2ShxLloIYejjVhHk7VAvzizTPMdbk52Xo7
         lqM8GQa5biIkKVKH+HJnzr7jl/r9DB7wYfbBezbu7+nZ0GTxBgS8W1ZlX/Tq/gTJWZAx
         dPyNYKZQGNJrAkLWTCkM8hJO+b00zv8Y4/MFTrWuXN+UouBypyyJMbj/ZBillUar6rrQ
         gsfCjt3mDOBmTF8K0DsJvWa1fVMKKsuSHUVsvKHMMoKS5xFrENGf3MC2JFrbajoAk9Jg
         M1JPcVIz6MYDlZEc2vhuetCsgbZUCeC2oqXW1yrCgkz3gEQYrPyclofZHrMOkJhsCk4h
         fPFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=arIEoPeuqw6WbaMhLZ8/W4LMBJk3G8knNDxBfT+scx4=;
        b=cvlNxHx0c3rpSY25Qz9DzgNppk88QEFbtECH0IXUr9PQDp1BsWOsq2XCwEFalcnVwi
         bf5qx/NDKWjIpqzuYPd/M1x+/s59KMzInaKbly/O/12afs3gzHWHCIMwnb/KnHtaPseZ
         0/xHmsEtZHuDq/z1qloYhpB/L9WNgBpE5q4j2j1/xrqpADosb7RCTWG2JnPiSopYvxs4
         7rTDO6YpL4EiaZvDoC1LmAFqu+NoSxdBuvT+KhdkUIOCqsVkxXggE5OyT2M20ZKLo62P
         bYT38vq4mgJ/wtU3Bqgeb5r0HCKU4OLPFJxB27WOCTT9026WUgWwDFBuMoFCnqfln+s5
         3Nvw==
X-Gm-Message-State: AOAM530oHhdBEpgKTBhkhLuThcwTGAND4H79eAjzZsHOZh+WPeE2HPxK
        e0bT1fbdYbV0mRCtPmbJbClDXN1hm54=
X-Google-Smtp-Source: ABdhPJxWymLXnEv06YbaPzpCUUqaAdP+N/Wn2WwOfZM3EJeRZzVhi074LPNV3hz9njvcLAdMgrKylg==
X-Received: by 2002:a5d:554b:: with SMTP id g11mr10012858wrw.411.1614535589338;
        Sun, 28 Feb 2021 10:06:29 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x13sm28206063wmj.2.2021.02.28.10.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Feb 2021 10:06:29 -0800 (PST)
Message-Id: <pull.865.v5.git.1614535588332.gitgitgadget@gmail.com>
In-Reply-To: <pull.865.v4.git.1613891147977.gitgitgadget@gmail.com>
References: <pull.865.v4.git.1613891147977.gitgitgadget@gmail.com>
From:   "Li Linchao via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 28 Feb 2021 18:06:27 +0000
Subject: [PATCH v5] builtin/clone.c: add --reject-shallow option
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

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-865%2FCactusinhand%2Fgit-clone-options-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-865/Cactusinhand/git-clone-options-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/865

Range-diff vs v4:

 1:  ee4fb840a32f ! 1:  3f765e49e4a7 builtin/clone.c: add --reject-shallow option
     @@ Documentation/git-clone.txt: objects from the source repository into a pack in t
       	creating `<directory>` and placing the administrative
      
       ## builtin/clone.c ##
     -@@
     - #include "connected.h"
     - #include "packfile.h"
     - #include "list-objects-filter-options.h"
     -+#include "shallow.h"
     - 
     - /*
     -  * Overall FIXMEs:
      @@ builtin/clone.c: static int option_no_checkout, option_bare, option_mirror, option_single_branch
       static int option_local = -1, option_no_hardlinks, option_shared;
       static int option_no_tags;
     @@ builtin/clone.c: static int path_exists(const char *path)
       int cmd_clone(int argc, const char **argv, const char *prefix)
       {
       	int is_bundle = 0, is_local;
     -+	int local_shallow = 0;
      +	int reject_shallow = 0;
       	const char *repo_name, *repo, *work_tree, *git_dir;
       	char *path, *dir, *display_repo = NULL;
     @@ builtin/clone.c: int cmd_clone(int argc, const char **argv, const char *prefix)
       		if (filter_options.choice)
       			warning(_("--filter is ignored in local clones; use file:// instead."));
       		if (!access(mkpath("%s/shallow", path), F_OK)) {
     -+			local_shallow = 1;
     ++			if (reject_shallow)
     ++				die("source repository is shallow, reject to clone.");
       			if (option_local > 0)
       				warning(_("source repository is shallow, ignoring --local"));
       			is_local = 0;
      @@ builtin/clone.c: int cmd_clone(int argc, const char **argv, const char *prefix)
     - 			goto cleanup;
     - 	}
       
     -+	if (reject_shallow) {
     -+		if (local_shallow || is_repository_shallow(the_repository)) {
     -+			die(_("source repository is shallow, reject to clone."));
     -+		}
     -+	}
     + 	transport_set_option(transport, TRANS_OPT_KEEP, "yes");
     + 
     ++	if (reject_shallow)
     ++		transport_set_option(transport, TRANS_OPT_REJECT_SHALLOW, "1");
     + 	if (option_depth)
     + 		transport_set_option(transport, TRANS_OPT_DEPTH,
     + 				     option_depth);
     +
     + ## fetch-pack.c ##
     +@@ fetch-pack.c: static struct ref *do_fetch_pack(struct fetch_pack_args *args,
     + 
     + 	if (args->stateless_rpc)
     + 		packet_flush(fd[1]);
     ++
     ++	if (!args->deepen && args->remote_shallow)
     ++		die("source repository is shallow, reject to clone.");
      +
     - 	update_remote_refs(refs, mapped_refs, remote_head_points_at,
     - 			   branch_top.buf, reflog_msg.buf, transport,
     - 			   !is_local);
     + 	if (args->deepen)
     + 		setup_alternate_shallow(&shallow_lock, &alternate_shallow_file,
     + 					NULL);
     +@@ fetch-pack.c: static void receive_shallow_info(struct fetch_pack_args *args,
     + 		 * shallow. In v0, remote refs that reach these objects are
     + 		 * rejected (unless --update-shallow is set); do the same.
     + 		 */
     ++		if (args->remote_shallow)
     ++			die("source repository is shallow, reject to clone.");
     + 		prepare_shallow_info(si, shallows);
     + 		if (si->nr_ours || si->nr_theirs)
     + 			alternate_shallow_file =
     +
     + ## fetch-pack.h ##
     +@@ fetch-pack.h: struct fetch_pack_args {
     + 	unsigned self_contained_and_connected:1;
     + 	unsigned cloning:1;
     + 	unsigned update_shallow:1;
     ++	unsigned remote_shallow:1;
     + 	unsigned deepen:1;
     + 
     + 	/*
      
       ## t/t5606-clone-options.sh ##
      @@ t/t5606-clone-options.sh: GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     @@ t/t5611-clone-config.sh: test_expect_success 'clone -c remote.<remote>.fetch=<re
      +'
      +
      +test_expect_success 'clone.rejectshallow=false should succeed' '
     -+	rm -rf child &&
     ++	rm -rf child out &&
      +	git clone --depth=1 --no-local . child &&
      +	git -c clone.rejectshallow=false clone --no-local child out
      +'
     @@ t/t5611-clone-config.sh: test_expect_success 'clone -c remote.<remote>.fetch=<re
      +'
      +
      +test_expect_success 'option --no-reject-shallow override clone.rejectshallow' '
     -+	rm -rf child &&
     ++	rm -rf child out &&
      +	git clone --depth=1 --no-local . child &&
      +	git -c clone.rejectshallow=true clone --no-reject-shallow --no-local child out
      +'
     @@ t/t5611-clone-config.sh: test_expect_success 'clone -c remote.<remote>.fetch=<re
       test_expect_success MINGW 'clone -c core.hideDotFiles' '
       	test_commit attributes .gitattributes "" &&
       	rm -rf child &&
     +
     + ## transport-helper.c ##
     +@@ transport-helper.c: static const char *boolean_options[] = {
     + 	TRANS_OPT_THIN,
     + 	TRANS_OPT_KEEP,
     + 	TRANS_OPT_FOLLOWTAGS,
     +-	TRANS_OPT_DEEPEN_RELATIVE
     ++	TRANS_OPT_DEEPEN_RELATIVE,
     ++	TRANS_OPT_REJECT_SHALLOW
     + 	};
     + 
     + static int strbuf_set_helper_option(struct helper_data *data,
     +
     + ## transport.c ##
     +@@ transport.c: static int set_git_option(struct git_transport_options *opts,
     + 		list_objects_filter_die_if_populated(&opts->filter_options);
     + 		parse_list_objects_filter(&opts->filter_options, value);
     + 		return 0;
     ++	} else if (!strcmp(name, TRANS_OPT_REJECT_SHALLOW)) {
     ++		opts->reject_shallow = !!value;
     ++		return 0;
     + 	}
     + 	return 1;
     + }
     +@@ transport.c: static int fetch_refs_via_pack(struct transport *transport,
     + 	args.stateless_rpc = transport->stateless_rpc;
     + 	args.server_options = transport->server_options;
     + 	args.negotiation_tips = data->options.negotiation_tips;
     ++	args.remote_shallow = transport->smart_options->reject_shallow;
     + 
     + 	if (!data->got_remote_heads) {
     + 		int i;
     +
     + ## transport.h ##
     +@@ transport.h: struct git_transport_options {
     + 	unsigned check_self_contained_and_connected : 1;
     + 	unsigned self_contained_and_connected : 1;
     + 	unsigned update_shallow : 1;
     ++	unsigned reject_shallow : 1;
     + 	unsigned deepen_relative : 1;
     + 
     + 	/* see documentation of corresponding flag in fetch-pack.h */
     +@@ transport.h: void transport_check_allowed(const char *type);
     + /* Aggressively fetch annotated tags if possible */
     + #define TRANS_OPT_FOLLOWTAGS "followtags"
     + 
     ++/* reject shallow repo transport  */
     ++#define TRANS_OPT_REJECT_SHALLOW "rejectshallow"
     ++
     + /* Accept refs that may update .git/shallow without --depth */
     + #define TRANS_OPT_UPDATE_SHALLOW "updateshallow"
     + 


 Documentation/config/clone.txt |  4 +++
 Documentation/git-clone.txt    |  7 ++++-
 builtin/clone.c                | 22 ++++++++++++++++
 fetch-pack.c                   |  6 +++++
 fetch-pack.h                   |  1 +
 t/t5606-clone-options.sh       | 47 ++++++++++++++++++++++++++++++++++
 t/t5611-clone-config.sh        | 32 +++++++++++++++++++++++
 transport-helper.c             |  3 ++-
 transport.c                    |  4 +++
 transport.h                    |  4 +++
 10 files changed, 128 insertions(+), 2 deletions(-)

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
index 51e844a2de0a..70d8ca77988f 100644
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
+	if (!strcmp(k, "clone.rejectshallow")) {
+		config_shallow = git_config_bool(k, v);
+	}
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
+	if (config_shallow != -1) {
+		reject_shallow = config_shallow;
+	}
+	if (option_shallow != -1) {
+		reject_shallow = option_shallow;
+	}
 	/*
 	 * apply the remote name provided by --origin only after this second
 	 * call to git_config, to ensure it overrides all config-based values.
@@ -1216,6 +1234,8 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		if (filter_options.choice)
 			warning(_("--filter is ignored in local clones; use file:// instead."));
 		if (!access(mkpath("%s/shallow", path), F_OK)) {
+			if (reject_shallow)
+				die("source repository is shallow, reject to clone.");
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
index 1eaedcb5dc2e..41ef700bde38 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1071,6 +1071,10 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 
 	if (args->stateless_rpc)
 		packet_flush(fd[1]);
+
+	if (!args->deepen && args->remote_shallow)
+		die("source repository is shallow, reject to clone.");
+
 	if (args->deepen)
 		setup_alternate_shallow(&shallow_lock, &alternate_shallow_file,
 					NULL);
@@ -1440,6 +1444,8 @@ static void receive_shallow_info(struct fetch_pack_args *args,
 		 * shallow. In v0, remote refs that reach these objects are
 		 * rejected (unless --update-shallow is set); do the same.
 		 */
+		if (args->remote_shallow)
+			die("source repository is shallow, reject to clone.");
 		prepare_shallow_info(si, shallows);
 		if (si->nr_ours || si->nr_theirs)
 			alternate_shallow_file =
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
diff --git a/transport-helper.c b/transport-helper.c
index 49b7fb4dcb9a..b57b55c8180c 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -265,7 +265,8 @@ static const char *boolean_options[] = {
 	TRANS_OPT_THIN,
 	TRANS_OPT_KEEP,
 	TRANS_OPT_FOLLOWTAGS,
-	TRANS_OPT_DEEPEN_RELATIVE
+	TRANS_OPT_DEEPEN_RELATIVE,
+	TRANS_OPT_REJECT_SHALLOW
 	};
 
 static int strbuf_set_helper_option(struct helper_data *data,
diff --git a/transport.c b/transport.c
index b13fab5dc3b1..34fe01221ee0 100644
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
index 24e15799e714..f6273d268b09 100644
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
 
+/* reject shallow repo transport  */
+#define TRANS_OPT_REJECT_SHALLOW "rejectshallow"
+
 /* Accept refs that may update .git/shallow without --depth */
 #define TRANS_OPT_UPDATE_SHALLOW "updateshallow"
 

base-commit: 225365fb5195e804274ab569ac3cc4919451dc7f
-- 
gitgitgadget
