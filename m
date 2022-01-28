Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E246FC433EF
	for <git@archiver.kernel.org>; Fri, 28 Jan 2022 12:56:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236430AbiA1M4u (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Jan 2022 07:56:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbiA1M4t (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jan 2022 07:56:49 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECC87C061714
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 04:56:48 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id s5so15794775ejx.2
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 04:56:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+HQwfgQosdcXKBXFOicGaxAUsB72squtDXTMG8uP5zM=;
        b=lyi1trXJhzZiSI6SJitDowzSo00bXxCdMxEb1tJ6ub27DPM9UttLNYeQqTgpt219TD
         awQB3Dgh9SQiwYx4W6c+MSKn5OsRAjcBL32/AchUb3jFzjB2HMGqr+eBZdQGdzeDEs+M
         JEpF13E+OVxvmxT9IZYVRiqdXZhBdcmuDy3Ke0K2QyAZ8s9X1CzAznjtxjpZTP5kkdTx
         PWMeJqtxZiZ3TIHgBHgEdJqePFNYyn5WehSvfe9PSB0VNJaJOmVY01RjfvPhQSXcTsxB
         c8X4Mcb0m7QpPvOFDkvcqWQEtu8gBQHDGeU8kI2gSji5BThryF+P27sQMkPxcXYAbSwN
         Eafw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+HQwfgQosdcXKBXFOicGaxAUsB72squtDXTMG8uP5zM=;
        b=nE2ZXSnXaKwfIUxjzIgsTu7D2g024fQUNILcJQfx1XMMkd/OUoE0FfXvlGHewOdb1A
         PJuHbYUqmkZHn1uR7WXgZptIso7CFms7L6KX/eXNWJ013fKL7n8MlS3KzBoBrAyGceoR
         ZwS5gSWyNhd4c4v81JMsohAwbNPKhLJWOZucEYnuA/HXJ0tPLTLe33g3VTeWzz3B8Nab
         lFsJbHb4v4Rw4rJOSocF1wHbYeCTW5WT23Co/mxa4M8Ff7uoyRfzTrYG1CtKcUvn2sGN
         DHe4UYJ46jXwiVTuyY/FiEgdFWv3koNXFfcpug3sXY/YtDQPHlR6AGr3mywyQo9PpUHF
         01oA==
X-Gm-Message-State: AOAM532fRX4DgOyG4Vyu+rSOX3yUdg1+mvU98dTtm0Mf/MF435l3P3eu
        nArV7qRrqbMmtEz6K8pFsGO15OJUNX7nWQ==
X-Google-Smtp-Source: ABdhPJzACLbg10E1IvA+M/EN+QKwK3JLx1Vjhx/gwL8YwkSdI29mOT0x3T+HN5wmcu30T5d4cFfOvQ==
X-Received: by 2002:a17:906:9b8d:: with SMTP id dd13mr91001ejc.121.1643374606755;
        Fri, 28 Jan 2022 04:56:46 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g8sm10154691ejt.26.2022.01.28.04.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 04:56:46 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrn@google.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        pc44800@gmail.com, Shourya Shukla <periperidip@gmail.com>,
        Glen Choo <chooglen@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 0/9] submodule: convert the rest of 'update' to C
Date:   Fri, 28 Jan 2022 13:56:31 +0100
Message-Id: <cover-v5-0.9-00000000000-20220128T125206Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.0.914.ge5c8aab0d5b
In-Reply-To: <cover-v4-0.7-00000000000-20220127T143552Z-avarab@gmail.com>
References: <cover-v4-0.7-00000000000-20220127T143552Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A rewrite of "git submodule" in C, except the trivial pass-through
wrapping code (basically getopt etc.) in git-submodule.sh. For a
greater summary & context see v4's CL:
https://lore.kernel.org/git/cover-v4-0.7-00000000000-20220127T143552Z-avarab@gmail.com/

Changes in v5:

 * Took Glen Choo's suggestion for a code change in 1/8, thanks!

 * A bit more mid-series churn to make the large commit at the end
   have a smaller diff. The result is that in v4/v5 we have in that
   last commit (but see below).

   - 2 files changed, 389 insertions(+), 418 deletions(-)
   + 2 files changed, 357 insertions(+), 388 deletions(-)

 * There were some logic errors in v4 around how we handled error
   reporting. A new 8/9 adds tests for the existing behavior, and
   we're now bug-for-bug compatible.

   It turned out that we were passing around string lists of errors
   etc. in a way that wasn't needed, i.e. the initial code can just
   report the error.

   Much of this was also simplified with my recently added
   die_message() function. I.e. sometimes we want to have a "fatal: "
   message, but exit non-128.

Atharva Raykar (6):
  submodule--helper: get remote names from any repository
  submodule--helper: refactor get_submodule_displaypath()
  submodule--helper: allow setting superprefix for init_submodule()
  submodule--helper: run update using child process struct
  builtin/submodule--helper.c: reformat designated initializers
  submodule: move core cmd_update() logic to C

Ævar Arnfjörð Bjarmason (3):
  builtin/submodule--helper.c: rename option variables to "opt"
  submodule--helper: don't use bitfield indirection for parse_options()
  submodule tests: test for init and update failure output

 builtin/submodule--helper.c    | 706 +++++++++++++++++++--------------
 git-submodule.sh               | 145 +------
 t/t7406-submodule-update.sh    |  14 +-
 t/t7408-submodule-reference.sh |  14 +-
 4 files changed, 444 insertions(+), 435 deletions(-)

Range-diff against v4:
 1:  1a0b1323cd7 !  1:  088c7236a16 submodule--helper: get remote names from any repository
    @@ Commit message
     
         Mentored-by: Christian Couder <christian.couder@gmail.com>
         Mentored-by: Shourya Shukla <periperidip@gmail.com>
    +    Helped-by: Glen Choo <chooglen@google.com>
         Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
    @@ builtin/submodule--helper.c
      				  void *cb_data);
      
     -static char *get_default_remote(void)
    -+static char *repo_get_default_remote(struct repository *repo, const char *refname)
    ++static char *repo_get_default_remote(struct repository *repo)
      {
      	char *dest = NULL, *ret;
      	struct strbuf sb = STRBUF_INIT;
     -	const char *refname = resolve_ref_unsafe("HEAD", 0, NULL, NULL);
    ++	struct ref_store *store = get_main_ref_store(repo);
    ++	int ignore_errno;
    ++	const char *refname = refs_resolve_ref_unsafe(store, "HEAD", 0, NULL,
    ++						      NULL, &ignore_errno);
      
      	if (!refname)
      		die(_("No such ref: %s"), "HEAD");
    @@ builtin/submodule--helper.c: static char *get_default_remote(void)
      
     +static char *get_default_remote_submodule(const char *module_path)
     +{
    -+	const char *refname;
     +	struct repository subrepo;
    -+	int ignore_errno;
     +
    -+	refname = refs_resolve_ref_unsafe(get_submodule_ref_store(module_path),
    -+					  "HEAD", 0, NULL, NULL,
    -+					  &ignore_errno);
     +	repo_submodule_init(&subrepo, the_repository, module_path, null_oid());
    -+	return repo_get_default_remote(&subrepo, refname);
    ++	return repo_get_default_remote(&subrepo);
     +}
     +
     +static char *get_default_remote(void)
     +{
    -+	const char *refname = resolve_ref_unsafe("HEAD", 0, NULL, NULL);
    -+	return repo_get_default_remote(the_repository, refname);
    ++	return repo_get_default_remote(the_repository);
     +}
     +
      static int print_default_remote(int argc, const char **argv, const char *prefix)
 2:  7e2df3ff220 =  2:  bc694987893 submodule--helper: refactor get_submodule_displaypath()
 3:  f31fd72fba2 =  3:  e2cc7f0e23b submodule--helper: allow setting superprefix for init_submodule()
 4:  76c5a826a80 =  4:  e1df2dd4457 submodule--helper: run update using child process struct
 5:  29aa2fc0851 =  5:  fa815e37f9f builtin/submodule--helper.c: reformat designated initializers
 6:  d3ad6e7a351 !  6:  ef097f7ea51 builtin/submodule--helper.c: rename "suc" variable to "opt"
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    builtin/submodule--helper.c: rename "suc" variable to "opt"
    +    builtin/submodule--helper.c: rename option variables to "opt"
     
    -    Rename the "suc" variable in "builtin/submodule--helper.c" to
    -    "opt". The only reason for this change is to make the subsequent
    -    commit's diff smaller, by doing this rename we can "anchor" the diff
    -    better, as it "borrow" most of the options declared here as-is as far
    -    as the diff rename detection is concerned.
    +    Rename the "suc" variable in update_clone() to "opt", and do the same
    +    for the "update_data" variable in run_update_procedure().
    +
    +    The only reason for this change is to make the subsequent commit's
    +    diff smaller, by doing this rename we can "anchor" the diff better, as
    +    it "borrow" most of the options declared here as-is as far as the diff
    +    rename detection is concerned.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ builtin/submodule--helper.c: static int update_clone(int argc, const char **argv
      }
      
      static int run_update_procedure(int argc, const char **argv, const char *prefix)
    + {
    + 	int force = 0, quiet = 0, nofetch = 0, just_cloned = 0;
    + 	char *prefixed_path, *update = NULL;
    +-	struct update_data update_data = UPDATE_DATA_INIT;
    ++	struct update_data opt = UPDATE_DATA_INIT;
    + 
    + 	struct option options[] = {
    + 		OPT__QUIET(&quiet, N_("suppress output for update by rebase or merge")),
    +@@ builtin/submodule--helper.c: static int run_update_procedure(int argc, const char **argv, const char *prefix)
    + 			 N_("don't fetch new objects from the remote site")),
    + 		OPT_BOOL(0, "just-cloned", &just_cloned,
    + 			 N_("overrides update mode in case the repository is a fresh clone")),
    +-		OPT_INTEGER(0, "depth", &update_data.depth, N_("depth for shallow fetch")),
    ++		OPT_INTEGER(0, "depth", &opt.depth, N_("depth for shallow fetch")),
    + 		OPT_STRING(0, "prefix", &prefix,
    + 			   N_("path"),
    + 			   N_("path into the working tree")),
    + 		OPT_STRING(0, "update", &update,
    + 			   N_("string"),
    + 			   N_("rebase, merge, checkout or none")),
    +-		OPT_STRING(0, "recursive-prefix", &update_data.recursive_prefix, N_("path"),
    ++		OPT_STRING(0, "recursive-prefix", &opt.recursive_prefix, N_("path"),
    + 			   N_("path into the working tree, across nested "
    + 			      "submodule boundaries")),
    +-		OPT_CALLBACK_F(0, "oid", &update_data.oid, N_("sha1"),
    ++		OPT_CALLBACK_F(0, "oid", &opt.oid, N_("sha1"),
    + 			       N_("SHA1 expected by superproject"), PARSE_OPT_NONEG,
    + 			       parse_opt_object_id),
    +-		OPT_CALLBACK_F(0, "suboid", &update_data.suboid, N_("subsha1"),
    ++		OPT_CALLBACK_F(0, "suboid", &opt.suboid, N_("subsha1"),
    + 			       N_("SHA1 of submodule's HEAD"), PARSE_OPT_NONEG,
    + 			       parse_opt_object_id),
    + 		OPT_END()
    +@@ builtin/submodule--helper.c: static int run_update_procedure(int argc, const char **argv, const char *prefix)
    + 	if (argc != 1)
    + 		usage_with_options(usage, options);
    + 
    +-	update_data.force = !!force;
    +-	update_data.quiet = !!quiet;
    +-	update_data.nofetch = !!nofetch;
    +-	update_data.just_cloned = !!just_cloned;
    +-	update_data.sm_path = argv[0];
    ++	opt.force = !!force;
    ++	opt.quiet = !!quiet;
    ++	opt.nofetch = !!nofetch;
    ++	opt.just_cloned = !!just_cloned;
    ++	opt.sm_path = argv[0];
    + 
    +-	if (update_data.recursive_prefix)
    +-		prefixed_path = xstrfmt("%s%s", update_data.recursive_prefix, update_data.sm_path);
    ++	if (opt.recursive_prefix)
    ++		prefixed_path = xstrfmt("%s%s", opt.recursive_prefix, opt.sm_path);
    + 	else
    +-		prefixed_path = xstrdup(update_data.sm_path);
    ++		prefixed_path = xstrdup(opt.sm_path);
    + 
    +-	update_data.displaypath = get_submodule_displaypath(prefixed_path, prefix);
    ++	opt.displaypath = get_submodule_displaypath(prefixed_path, prefix);
    + 
    +-	determine_submodule_update_strategy(the_repository, update_data.just_cloned,
    +-					    update_data.sm_path, update,
    +-					    &update_data.update_strategy);
    ++	determine_submodule_update_strategy(the_repository, opt.just_cloned,
    ++					    opt.sm_path, update,
    ++					    &opt.update_strategy);
    + 
    + 	free(prefixed_path);
    + 
    +-	if (!oideq(&update_data.oid, &update_data.suboid) || update_data.force)
    +-		return do_run_update_procedure(&update_data);
    ++	if (!oideq(&opt.oid, &opt.suboid) || opt.force)
    ++		return do_run_update_procedure(&opt);
    + 
    + 	return 3;
    + }
 -:  ----------- >  7:  6b038f558c1 submodule--helper: don't use bitfield indirection for parse_options()
 -:  ----------- >  8:  b4f84132201 submodule tests: test for init and update failure output
 7:  02954603763 !  9:  e8e57606ee9 submodule: move core cmd_update() logic to C
    @@ Commit message
     
      ## builtin/submodule--helper.c ##
     @@ builtin/submodule--helper.c: static char *get_default_remote(void)
    - 	return repo_get_default_remote(the_repository, refname);
    + 	return repo_get_default_remote(the_repository);
      }
      
     -static int print_default_remote(int argc, const char **argv, const char *prefix)
    @@ builtin/submodule--helper.c: struct submodule_update_clone {
      	const char *recursive_prefix;
      	const char *sm_path;
      	const char *displaypath;
    - 	struct object_id oid;
    +@@ builtin/submodule--helper.c: struct update_data {
      	struct object_id suboid;
      	struct submodule_update_strategy update_strategy;
    -+	int max_jobs;
      	int depth;
    --	unsigned int force: 1;
    --	unsigned int quiet: 1;
    --	unsigned int nofetch: 1;
    --	unsigned int just_cloned: 1;
     +	int recommend_shallow;
     +	int single_branch;
    ++	int max_jobs;
     +	unsigned int init;
    -+	unsigned int force;
    -+	unsigned int quiet;
    -+	unsigned int nofetch;
    + 	unsigned int force;
    + 	unsigned int quiet;
    + 	unsigned int nofetch;
    + 	unsigned int just_cloned;
     +	unsigned int remote;
     +	unsigned int recursive;
     +	unsigned int progress;
     +	unsigned int dissociate;
     +	unsigned int require_init;
     +	unsigned warn_if_uninitialized ;
    -+	unsigned int just_cloned ;
     +	struct string_list references;
     +	struct module_list list;
      };
    @@ builtin/submodule--helper.c: struct submodule_update_clone {
      }
      
      static void next_submodule_warn_missing(struct submodule_update_clone *suc,
    -@@ builtin/submodule--helper.c: static int fetch_in_submodule(const char *module_path, int depth, int quiet, str
    - 	return run_command(&cp);
    - }
    - 
    --static int run_update_command(struct update_data *ud, int subforce)
    -+static int run_update_command(struct update_data *ud, int subforce, struct string_list *err)
    - {
    +@@ builtin/submodule--helper.c: static int run_update_command(struct update_data *ud, int subforce)
      	struct child_process cp = CHILD_PROCESS_INIT;
      	char *oid = oid_to_hex(&ud->oid);
    -+	struct strbuf out = STRBUF_INIT;
      	int must_die_on_failure = 0;
     +	struct submodule_update_strategy strategy = SUBMODULE_UPDATE_STRATEGY_INIT;
      
    @@ builtin/submodule--helper.c: static int run_update_command(struct update_data *u
      
      	cp.dir = xstrdup(ud->sm_path);
      	prepare_submodule_repo_env(&cp.env_array);
    --	if (run_command(&cp)) {
    + 	if (run_command(&cp)) {
     -		switch (ud->update_strategy.type) {
    -+	if (capture_command(&cp, &out, 0)) {
    -+		if (must_die_on_failure) {
    -+			switch (strategy.type) {
    -+			case SM_UPDATE_CHECKOUT:
    -+				die(_("Unable to checkout '%s' in submodule path '%s'"),
    -+				    oid, ud->displaypath);
    -+				break;
    -+			case SM_UPDATE_REBASE:
    -+				die(_("Unable to rebase '%s' in submodule path '%s'"),
    -+				    oid, ud->displaypath);
    -+				break;
    -+			case SM_UPDATE_MERGE:
    -+				die(_("Unable to merge '%s' in submodule path '%s'"),
    -+				    oid, ud->displaypath);
    -+				break;
    -+			case SM_UPDATE_COMMAND:
    -+				die(_("Execution of '%s %s' failed in submodule path '%s'"),
    -+				    strategy.command, oid, ud->displaypath);
    -+				break;
    -+			default:
    -+				BUG("unexpected update strategy type: %s",
    -+				    submodule_strategy_to_string(&strategy));
    -+			}
    -+		}
    -+
    -+		/* the command failed, but update must continue */
    -+		string_list_append_nodup(err, strbuf_detach(&out, NULL));
    -+		return 1;
    -+	}
    -+
    -+	if (!ud->quiet) {
     +		switch (strategy.type) {
      		case SM_UPDATE_CHECKOUT:
     -			printf(_("Unable to checkout '%s' in submodule path '%s'"),
     -			       oid, ud->displaypath);
    -+			printf(_("Submodule path '%s': checked out '%s'\n"),
    -+			       ud->displaypath, oid);
    ++			die_message(_("Unable to checkout '%s' in submodule path '%s'"),
    ++				    oid, ud->displaypath);
      			break;
      		case SM_UPDATE_REBASE:
     -			printf(_("Unable to rebase '%s' in submodule path '%s'"),
     -			       oid, ud->displaypath);
    -+			printf(_("Submodule path '%s': rebased into '%s'\n"),
    -+			       ud->displaypath, oid);
    ++			if (!must_die_on_failure)
    ++				break;
    ++			die(_("Unable to rebase '%s' in submodule path '%s'"),
    ++			    oid, ud->displaypath);
      			break;
      		case SM_UPDATE_MERGE:
     -			printf(_("Unable to merge '%s' in submodule path '%s'"),
     -			       oid, ud->displaypath);
    -+			printf(_("Submodule path '%s': merged in '%s'\n"),
    -+			       ud->displaypath, oid);
    ++			if (!must_die_on_failure)
    ++				break;
    ++			die(_("Unable to merge '%s' in submodule path '%s'"),
    ++			    oid, ud->displaypath);
      			break;
      		case SM_UPDATE_COMMAND:
     -			printf(_("Execution of '%s %s' failed in submodule path '%s'"),
     -			       ud->update_strategy.command, oid, ud->displaypath);
    -+			printf(_("Submodule path '%s': '%s %s'\n"),
    -+			       ud->displaypath, strategy.command, oid);
    ++			if (!must_die_on_failure)
    ++				break;
    ++			die(_("Execution of '%s %s' failed in submodule path '%s'"),
    ++			    strategy.command, oid, ud->displaypath);
      			break;
      		default:
      			BUG("unexpected update strategy type: %s",
    @@ builtin/submodule--helper.c: static int run_update_command(struct update_data *u
     -		 * This signifies to the caller in shell that the command
     -		 * failed without dying
     -		 */
    --		return 1;
    --	}
    --
    ++
    ++		/* the command failed, but update must continue */
    + 		return 1;
    + 	}
    + 
     -	switch (ud->update_strategy.type) {
    --	case SM_UPDATE_CHECKOUT:
    --		printf(_("Submodule path '%s': checked out '%s'\n"),
    --		       ud->displaypath, oid);
    --		break;
    --	case SM_UPDATE_REBASE:
    --		printf(_("Submodule path '%s': rebased into '%s'\n"),
    --		       ud->displaypath, oid);
    --		break;
    --	case SM_UPDATE_MERGE:
    --		printf(_("Submodule path '%s': merged in '%s'\n"),
    --		       ud->displaypath, oid);
    --		break;
    --	case SM_UPDATE_COMMAND:
    --		printf(_("Submodule path '%s': '%s %s'\n"),
    ++	if (ud->quiet)
    ++		return 0;
    ++
    ++	switch (strategy.type) {
    + 	case SM_UPDATE_CHECKOUT:
    + 		printf(_("Submodule path '%s': checked out '%s'\n"),
    + 		       ud->displaypath, oid);
    +@@ builtin/submodule--helper.c: static int run_update_command(struct update_data *ud, int subforce)
    + 		break;
    + 	case SM_UPDATE_COMMAND:
    + 		printf(_("Submodule path '%s': '%s %s'\n"),
     -		       ud->displaypath, ud->update_strategy.command, oid);
    --		break;
    --	default:
    --		BUG("unexpected update strategy type: %s",
    ++		       ud->displaypath, strategy.command, oid);
    + 		break;
    + 	default:
    + 		BUG("unexpected update strategy type: %s",
     -		    submodule_strategy_to_string(&ud->update_strategy));
    ++		    submodule_strategy_to_string(&strategy));
      	}
      
    -+	strbuf_release(&out);
      	return 0;
      }
      
     -static int do_run_update_procedure(struct update_data *ud)
    -+static int run_update_procedure(struct update_data *ud, struct string_list *err)
    ++static int run_update_procedure(struct update_data *ud)
      {
      	int subforce = is_null_oid(&ud->suboid) || ud->force;
      
     @@ builtin/submodule--helper.c: static int do_run_update_procedure(struct update_data *ud)
    - 			    ud->displaypath, oid_to_hex(&ud->oid));
    - 	}
    + 	return run_update_command(ud, subforce);
    + }
      
    --	return run_update_command(ud, subforce);
    --}
    --
     -static void update_submodule(struct update_clone_data *ucd)
     -{
     -	fprintf(stdout, "dummy %s %d\t%s\n",
    @@ builtin/submodule--helper.c: static int do_run_update_procedure(struct update_da
     -
     -static int run_update_procedure(int argc, const char **argv, const char *prefix)
     -{
    --	int force = 0, quiet = 0, nofetch = 0, just_cloned = 0;
     -	char *prefixed_path, *update = NULL;
    --	struct update_data update_data = UPDATE_DATA_INIT;
    +-	struct update_data opt = UPDATE_DATA_INIT;
     -
     -	struct option options[] = {
    --		OPT__QUIET(&quiet, N_("suppress output for update by rebase or merge")),
    --		OPT__FORCE(&force, N_("force checkout updates"), 0),
    --		OPT_BOOL('N', "no-fetch", &nofetch,
    +-		OPT__QUIET(&opt.quiet,
    +-			   N_("suppress output for update by rebase or merge")),
    +-		OPT__FORCE(&opt.force, N_("force checkout updates"),
    +-			   0),
    +-		OPT_BOOL('N', "no-fetch", &opt.nofetch,
     -			 N_("don't fetch new objects from the remote site")),
    --		OPT_BOOL(0, "just-cloned", &just_cloned,
    +-		OPT_BOOL(0, "just-cloned", &opt.just_cloned,
     -			 N_("overrides update mode in case the repository is a fresh clone")),
    --		OPT_INTEGER(0, "depth", &update_data.depth, N_("depth for shallow fetch")),
    +-		OPT_INTEGER(0, "depth", &opt.depth, N_("depth for shallow fetch")),
     -		OPT_STRING(0, "prefix", &prefix,
     -			   N_("path"),
     -			   N_("path into the working tree")),
     -		OPT_STRING(0, "update", &update,
     -			   N_("string"),
     -			   N_("rebase, merge, checkout or none")),
    --		OPT_STRING(0, "recursive-prefix", &update_data.recursive_prefix, N_("path"),
    +-		OPT_STRING(0, "recursive-prefix", &opt.recursive_prefix, N_("path"),
     -			   N_("path into the working tree, across nested "
     -			      "submodule boundaries")),
    --		OPT_CALLBACK_F(0, "oid", &update_data.oid, N_("sha1"),
    +-		OPT_CALLBACK_F(0, "oid", &opt.oid, N_("sha1"),
     -			       N_("SHA1 expected by superproject"), PARSE_OPT_NONEG,
     -			       parse_opt_object_id),
    --		OPT_CALLBACK_F(0, "suboid", &update_data.suboid, N_("subsha1"),
    +-		OPT_CALLBACK_F(0, "suboid", &opt.suboid, N_("subsha1"),
     -			       N_("SHA1 of submodule's HEAD"), PARSE_OPT_NONEG,
     -			       parse_opt_object_id),
     -		OPT_END()
    @@ builtin/submodule--helper.c: static int do_run_update_procedure(struct update_da
     -	if (argc != 1)
     -		usage_with_options(usage, options);
     -
    --	update_data.force = !!force;
    --	update_data.quiet = !!quiet;
    --	update_data.nofetch = !!nofetch;
    --	update_data.just_cloned = !!just_cloned;
    --	update_data.sm_path = argv[0];
    +-	opt.sm_path = argv[0];
     -
    --	if (update_data.recursive_prefix)
    --		prefixed_path = xstrfmt("%s%s", update_data.recursive_prefix, update_data.sm_path);
    +-	if (opt.recursive_prefix)
    +-		prefixed_path = xstrfmt("%s%s", opt.recursive_prefix, opt.sm_path);
     -	else
    --		prefixed_path = xstrdup(update_data.sm_path);
    +-		prefixed_path = xstrdup(opt.sm_path);
     -
    --	update_data.displaypath = get_submodule_displaypath(prefixed_path, prefix);
    +-	opt.displaypath = get_submodule_displaypath(prefixed_path, prefix);
     -
    --	determine_submodule_update_strategy(the_repository, update_data.just_cloned,
    --					    update_data.sm_path, update,
    --					    &update_data.update_strategy);
    +-	determine_submodule_update_strategy(the_repository, opt.just_cloned,
    +-					    opt.sm_path, update,
    +-					    &opt.update_strategy);
     -
     -	free(prefixed_path);
     -
    --	if (!oideq(&update_data.oid, &update_data.suboid) || update_data.force)
    --		return do_run_update_procedure(&update_data);
    +-	if (!oideq(&opt.oid, &opt.suboid) || opt.force)
    +-		return do_run_update_procedure(&opt);
     -
     -	return 3;
     -}
    @@ builtin/submodule--helper.c: static int do_run_update_procedure(struct update_da
     -	printf("%s", relative_path(argv[1], argv[2], &sb));
     -	strbuf_release(&sb);
     -	return 0;
    -+	return run_update_command(ud, subforce, err);
    - }
    - 
    +-}
    +-
      static const char *remote_submodule_branch(const char *path)
    + {
    + 	const struct submodule *sub;
     @@ builtin/submodule--helper.c: static int push_check(int argc, const char **argv, const char *prefix)
      	return 0;
      }
    @@ builtin/submodule--helper.c: static int module_set_branch(int argc, const char *
     +static int update_submodule(struct update_data *update_data)
     +{
     +	char *prefixed_path;
    -+	struct string_list err = STRING_LIST_INIT_DUP;
     +
     +	ensure_core_worktree(update_data->sm_path);
     +
    @@ builtin/submodule--helper.c: static int module_set_branch(int argc, const char *
     +	}
     +
     +	if (!oideq(&update_data->oid, &update_data->suboid) || update_data->force)
    -+		if (run_update_procedure(update_data, &err))
    ++		if (run_update_procedure(update_data))
     +			return 1;
     +
     +	if (update_data->recursive) {
    -+		int res;
     +		struct child_process cp = CHILD_PROCESS_INIT;
     +		struct update_data next = *update_data;
    -+		char *die_msg = xstrfmt(_("Failed to recurse into submodule path '%s'"),
    -+					update_data->displaypath);
    ++		int res;
     +
     +		if (update_data->recursive_prefix)
     +			prefixed_path = xstrfmt("%s%s/", update_data->recursive_prefix,
    @@ builtin/submodule--helper.c: static int module_set_branch(int argc, const char *
     +		update_data_to_args(&next, &cp.args);
     +
     +		/* die() if child process die()'d */
    -+		if ((res = run_command(&cp)) == 128)
    -+			die("%s", die_msg);
    -+		if (res)
    -+			string_list_append(&err, die_msg);
    -+
    -+		free(die_msg);
    -+	}
    -+
    -+	if (err.nr) {
    -+		struct string_list_item *item;
    -+		for_each_string_list_item(item, &err)
    -+			fputs(item->string, stderr);
    -+		string_list_clear(&err, 0);
    -+		return 1;
    ++		res = run_command(&cp);
    ++		if (!res)
    ++			return 0;
    ++		die_message(_("Failed to recurse into submodule path '%s'"),
    ++			    update_data->displaypath);
    ++		if (res == 128)
    ++			exit(res);
    ++		else if (res)
    ++			return 1;
     +	}
     +
     +	return 0;
-- 
2.35.0.914.ge5c8aab0d5b

