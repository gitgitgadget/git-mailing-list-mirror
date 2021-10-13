Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B83C433F5
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 05:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEEA560F23
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 05:18:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237604AbhJMFUg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Oct 2021 01:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237600AbhJMFUf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Oct 2021 01:20:35 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D16C061570
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 22:18:32 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id m26so1432901pff.3
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 22:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D174ic3soNlwRhkYAt9/p06JCwkpFnBxzvy1Py72A70=;
        b=d3nGM1z2gY9YmPcWF7sW7F4n0gj8eSYWSUUJ58Ja3wc1sdqPgcoCp89ygnXLoEuRDc
         XDeZaM7KT5VnFXEDsd5V7UPscBHj71QPzKAwdJ74N/inb4hN5fiD0eCgde91rXGvjh4g
         kBE2VibT0Ez4DG7SK2vaCAQVRDJeKRLEAU+WYfa59dMSWOiGffyhL0bFsIpTTLV4NlxF
         tJ7vMzahGwP9gIqCJPcJH2MI68hmX+ZQ/w944RGY2o8XD4T2M0DGK/y0IUUo0INYUr1Q
         gA5fO0SFIb4Fj0H9Vg53LTx91Hwc4cqzDBeHnMq4QenpCboDpdz7ew1WlOZ9Ye+EjM5I
         a3yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D174ic3soNlwRhkYAt9/p06JCwkpFnBxzvy1Py72A70=;
        b=nK6bwK6bVjV0ilwMsApAvpfA4VvQpbxbKdlJF1RueifufPtc8B8XZgW69eXvEC/OH6
         rlrZaCkIyxLb0lmFZjGXFlaKdCR3Cm6ow6CwgGGTsOeza6lFJO49lNRt0E2GM0Ddqrbm
         5YkhgLg38rNV0Y0NpHNbq0kC01XCXGPmEoHgcvhnGRopD58MuhOBkhkL/OW51m5ZGc0S
         qUfOHuTcb7C42Ag2PXukFMoJh2dfOzC277aB9SWpCAzTMHSBjjHlTJOiW/gwr4FDE8j+
         Fhd6zhnKw9NtlBqHE2Og8tg443bb9tAzV7lGWhl/34QJ2awkx1EcfKNa9L4vA0deyqg2
         jtYg==
X-Gm-Message-State: AOAM530CsSeG7KVnd8MTKSr3EG1tAXAjMYTIlpgFaWZB2D9iBPw1G5jL
        e4Kl2zxlDEMagLDEYVE6yvk=
X-Google-Smtp-Source: ABdhPJx5ICHOLMDhkbtQ9iahxF3aJNM838n1bFI60zSPZbaeYGoOgUYDeblc0zp/KVG6oT2GISSc5w==
X-Received: by 2002:a65:6aa8:: with SMTP id x8mr26156448pgu.136.1634102312059;
        Tue, 12 Oct 2021 22:18:32 -0700 (PDT)
Received: from atharva-on-air.Dlink ([119.82.121.111])
        by smtp.gmail.com with ESMTPSA id 12sm12481197pfz.133.2021.10.12.22.18.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Oct 2021 22:18:31 -0700 (PDT)
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     raykar.ath@gmail.com
Cc:     avarab@gmail.com, christian.couder@gmail.com,
        emilyshaffer@google.com, git@vger.kernel.org, gitster@pobox.com,
        jrnieder@gmail.com, kaartic.sivaraam@gmail.com, pc44800@gmail.com,
        periperidip@gmail.com
Subject: [PATCH v3 0/9] submodule: convert the rest of 'update' to C
Date:   Wed, 13 Oct 2021 10:47:56 +0530
Message-Id: <20211013051805.45662-1-raykar.ath@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210916103241.62376-1-raykar.ath@gmail.com>
References: <20210916103241.62376-1-raykar.ath@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since v2:
 - Rebased this series on top of a more up-to-date master branch.

 - Reorganized this series to (hopefully) make it easier to review, as per
   Junio's suggestions. I split up the patch that converts the rest of the
   update shell script to C into multiple steps. I also squashed the patches
   that removed unused helpers, as there was not clear criteria for it being two
   patches.

 - Plugged a memory leak while refactoring sync_submodule() to use my new
   helper.

Note on conflicting series:
--------------------------

This series currently conflicts with the work being done by Emily in
'es/superproject-aware-submodules' [1], mainly in the part where they cache the
superproject gitdir in the shell script that gets removed during conversion in
this series.

I have attempted to make a version of this series that is based on that topic [2],
and added the superproject gitdir caching code in C [3]. It passes the tests,
but I am not too confident about its correctness. I hope that branch can be
helpful in some way.

[1] https://lore.kernel.org/git/20210819200953.2105230-1-emilyshaffer@google.com/
[2] https://github.com/tfidfwastaken/git/commits/submodule-update-on-es-superproject-aware
    (fetch-it-via: git fetch https://github.com/tfidfwastaken/git submodule-update-on-es-superproject-aware)
[3] https://github.com/tfidfwastaken/git/blob/a74aaf2540c536970f2541d3042c825f82a69770/builtin/submodule--helper.c#L2922-L2930

Fetch-it-Via:
git fetch https://github.com/tfidfwastaken/git submodule-update-list-3

Atharva Raykar (9):
  submodule--helper: split up ensure_core_worktree()
  submodule--helper: get remote names from any repository
  submodule--helper: rename helpers for update-clone
  submodule--helper: refactor get_submodule_displaypath()
  submodule--helper: allow setting superprefix for init_submodule()
  submodule--helper: run update using child process struct
  submodule: move core cmd_update() logic to C
  submodule--helper: remove unused helpers
  submodule--helper: rename helper functions

 builtin/submodule--helper.c | 771 +++++++++++++++++++++---------------
 git-submodule.sh            | 145 +------
 2 files changed, 458 insertions(+), 458 deletions(-)

Range diff against the previous version:

 1:  f83a5b7f34 !  1:  d057ba04bd submodule--helper: split up ensure_core_worktree()
    @@ builtin/submodule--helper.c: static int push_check(int argc, const char **argv,
     -static int ensure_core_worktree(int argc, const char **argv, const char *prefix)
     +static void do_ensure_core_worktree(const char *path)
      {
    - 	const struct submodule *sub;
     -	const char *path;
      	const char *cw;
      	struct repository subrepo;
    @@ builtin/submodule--helper.c: static int push_check(int argc, const char **argv,
     -
     -	path = argv[1];
     -
    - 	sub = submodule_from_path(the_repository, null_oid(), path);
    - 	if (!sub)
    - 		BUG("We could get the submodule handle before?");
    + 	if (repo_submodule_init(&subrepo, the_repository, path, null_oid()))
    + 		die(_("could not get a repository handle for submodule '%s'"), path);
    +
     @@ builtin/submodule--helper.c: static int ensure_core_worktree(int argc, const char **argv, const char *prefix)
      		free(abs_path);
      		strbuf_release(&sb);
 2:  7f4e24ce25 !  2:  895cc10b97 submodule--helper: get remote names from any repository
    @@ builtin/submodule--helper.c: static char *get_default_remote(void)
     +static char *get_default_remote_submodule(const char *module_path)
     +{
     +	const char *refname;
    -+	const struct submodule *sub;
     +	struct repository subrepo;
     +
     +	refname = refs_resolve_ref_unsafe(get_submodule_ref_store(module_path),
     +					  "HEAD", 0, NULL, NULL);
    -+	sub = submodule_from_path(the_repository, null_oid(), module_path);
    -+	repo_submodule_init(&subrepo, the_repository, sub);
    ++	repo_submodule_init(&subrepo, the_repository, module_path, null_oid());
     +	return repo_get_default_remote(&subrepo, refname);
     +}
     +
    @@ builtin/submodule--helper.c: static char *get_default_remote(void)
      {
      	char *remote;
     @@ builtin/submodule--helper.c: static void sync_submodule(const char *path, const char *prefix,
    + {
    + 	const struct submodule *sub;
      	char *remote_key = NULL;
    - 	char *sub_origin_url, *super_config_url, *displaypath;
    +-	char *sub_origin_url, *super_config_url, *displaypath;
    ++	char *sub_origin_url, *super_config_url, *displaypath, *default_remote;
      	struct strbuf sb = STRBUF_INIT;
     -	struct child_process cp = CHILD_PROCESS_INIT;
      	char *sub_config_path = NULL;
    @@ builtin/submodule--helper.c: static void sync_submodule(const char *path, const
     -
      	strbuf_reset(&sb);
     -	if (capture_command(&cp, &sb, 0))
    -+	strbuf_addstr(&sb, get_default_remote_submodule(path));
    -+	if (!sb.buf)
    ++	default_remote = get_default_remote_submodule(path);
    ++	if (!default_remote)
      		die(_("failed to get the default remote for submodule '%s'"),
      		      path);

    +-	strbuf_strip_suffix(&sb, "\n");
    +-	remote_key = xstrfmt("remote.%s.url", sb.buf);
    ++	remote_key = xstrfmt("remote.%s.url", default_remote);
    ++	free(default_remote);
    +
    +-	strbuf_reset(&sb);
    + 	submodule_to_gitdir(&sb, path);
    + 	strbuf_addstr(&sb, "/config");
    +
 3:  390596ee7c =  3:  1defe3e0ca submodule--helper: rename helpers for update-clone
 4:  2a2ddcac91 =  4:  693b23772a submodule--helper: refactor get_submodule_displaypath()
 -:  ---------- >  5:  d1fd902a2a submodule--helper: allow setting superprefix for init_submodule()
 -:  ---------- >  6:  19c6c4e81a submodule--helper: run update using child process struct
 5:  832020a290 !  7:  7cc32ad6f9 submodule: move core cmd_update() logic to C
    @@ Commit message
         new subprocess and call `submodule--helper init` on the submodule paths,
         because the Git machinery is not able to pick up the configuration
         changes introduced by that init call[1]. So we instead run the
    -    `init_submodule_cb()` callback over each submodule directly.
    -
    -    This introduces another problem, because there is no mechanism to pass
    -    the superproject path prefix (ie, `--super-prefix`) without starting a
    -    new git process. This field is required for obtaining the display path
    -    for that is used by the command's output messages. So let's add a field
    -    into the `init_cb` struct that lets us pass this information to
    -    `init_submodule()`, which will now also take an explicit 'superprefix'
    -    argument.
    +    `init_submodule_cb()` callback over each submodule in the same process.

         While we are at it, we also remove the fetch_in_submodule() shell
         function since it is no longer used anywhere.
    @@ Commit message
         Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>

      ## builtin/submodule--helper.c ##
    -@@ builtin/submodule--helper.c: static char *compute_submodule_clone_url(const char *rel_url)
    -
    - struct init_cb {
    - 	const char *prefix;
    -+	const char *superprefix;
    - 	unsigned int flags;
    - };
    --#define INIT_CB_INIT { NULL, 0 }
    -+#define INIT_CB_INIT { 0 }
    -
    - static void init_submodule(const char *path, const char *prefix,
    --			   unsigned int flags)
    -+			   const char *superprefix, unsigned int flags)
    - {
    - 	const struct submodule *sub;
    - 	struct strbuf sb = STRBUF_INIT;
    - 	char *upd = NULL, *url = NULL, *displaypath;
    -
    --	displaypath = get_submodule_displaypath(path, prefix);
    -+	/* try superprefix from the environment, if it is not passed explicitly */
    -+	if (!superprefix)
    -+		superprefix = get_super_prefix();
    -+	displaypath = do_get_submodule_displaypath(path, prefix, superprefix);
    -
    - 	sub = submodule_from_path(the_repository, null_oid(), path);
    -
    -@@ builtin/submodule--helper.c: static void init_submodule(const char *path, const char *prefix,
    - static void init_submodule_cb(const struct cache_entry *list_item, void *cb_data)
    - {
    - 	struct init_cb *info = cb_data;
    --	init_submodule(list_item->name, info->prefix, info->flags);
    -+	init_submodule(list_item->name, info->prefix, info->superprefix, info->flags);
    - }
    -
    - static int module_init(int argc, const char **argv, const char *prefix)
     @@ builtin/submodule--helper.c: struct submodule_update_clone {
      	const char *prefix;
      	int single_branch;
    @@ builtin/submodule--helper.c: static int fetch_in_submodule(const char *module_pa
     -static int run_update_command(struct update_data *ud, int subforce)
     +static int run_update_command(struct update_data *ud, int subforce, struct string_list *err)
      {
    --	struct strvec args = STRVEC_INIT;
    --	struct strvec child_env = STRVEC_INIT;
    -+	struct child_process cp = CHILD_PROCESS_INIT;
    + 	struct child_process cp = CHILD_PROCESS_INIT;
      	char *oid = oid_to_hex(&ud->oid);
     +	struct strbuf out = STRBUF_INIT;
      	int must_die_on_failure = 0;
    --	int git_cmd;
     +	struct submodule_update_strategy strategy = SUBMODULE_UPDATE_STRATEGY_INIT;
    -+
    +
    +-	switch (ud->update_strategy.type) {
     +	if (ud->update_strategy.type == SM_UPDATE_UNSPECIFIED || ud->just_cloned)
     +		determine_submodule_update_strategy(the_repository, ud->just_cloned,
     +						    ud->sm_path, NULL, &strategy);
     +	else
     +		strategy = ud->update_strategy;
    -
    --	switch (ud->update_strategy.type) {
    -+	cp.dir = xstrdup(ud->sm_path);
    ++
     +	switch (strategy.type) {
      	case SM_UPDATE_CHECKOUT:
    --		git_cmd = 1;
    --		strvec_pushl(&args, "checkout", "-q", NULL);
    -+		cp.git_cmd = 1;
    -+		strvec_pushl(&cp.args, "checkout", "-q", NULL);
    - 		if (subforce)
    --			strvec_push(&args, "-f");
    -+			strvec_push(&cp.args, "-f");
    - 		break;
    - 	case SM_UPDATE_REBASE:
    --		git_cmd = 1;
    --		strvec_push(&args, "rebase");
    -+		cp.git_cmd = 1;
    -+		strvec_push(&cp.args, "rebase");
    - 		if (ud->quiet)
    --			strvec_push(&args, "--quiet");
    -+			strvec_push(&cp.args, "--quiet");
    - 		must_die_on_failure = 1;
    - 		break;
    - 	case SM_UPDATE_MERGE:
    --		git_cmd = 1;
    --		strvec_push(&args, "merge");
    -+		cp.git_cmd = 1;
    -+		strvec_push(&cp.args, "merge");
    - 		if (ud->quiet)
    --			strvec_push(&args, "--quiet");
    -+			strvec_push(&cp.args, "--quiet");
    - 		must_die_on_failure = 1;
    + 		cp.git_cmd = 1;
    + 		strvec_pushl(&cp.args, "checkout", "-q", NULL);
    +@@ builtin/submodule--helper.c: static int run_update_command(struct update_data *ud, int subforce)
      		break;
      	case SM_UPDATE_COMMAND:
    --		git_cmd = 0;
    --		strvec_push(&args, ud->update_strategy.command);
    -+		cp.git_cmd = 0;
    -+		cp.use_shell = 1;
    + 		cp.use_shell = 1;
    +-		strvec_push(&cp.args, ud->update_strategy.command);
     +		strvec_push(&cp.args, strategy.command);
      		must_die_on_failure = 1;
      		break;
    @@ builtin/submodule--helper.c: static int fetch_in_submodule(const char *module_pa
     -		    submodule_strategy_to_string(&ud->update_strategy));
     +		    submodule_strategy_to_string(&strategy));
      	}
    --	strvec_push(&args, oid);
    -+	strvec_push(&cp.args, oid);
    + 	strvec_push(&cp.args, oid);

    --	prepare_submodule_repo_env(&child_env);
    --	if (run_command_v_opt_cd_env(args.v, git_cmd ? RUN_GIT_CMD : RUN_USING_SHELL,
    --				     ud->sm_path, child_env.v)) {
    + 	cp.dir = xstrdup(ud->sm_path);
    + 	prepare_submodule_repo_env(&cp.env_array);
    +-	if (run_command(&cp)) {
     -		switch (ud->update_strategy.type) {
    -+	prepare_submodule_repo_env(&cp.env_array);
     +	if (capture_command(&cp, &out, 0)) {
     +		if (must_die_on_failure) {
     +			switch (strategy.type) {
    @@ builtin/submodule--helper.c: static int module_set_branch(int argc, const char *
      struct add_data {
      	const char *prefix;
      	const char *branch;
    -@@ builtin/submodule--helper.c: static int add_clone(int argc, const char **argv, const char *prefix)
    +@@ builtin/submodule--helper.c: static int module_add(int argc, const char **argv, const char *prefix)
      	return 0;
      }

    @@ builtin/submodule--helper.c: static int add_clone(int argc, const char **argv, c
     @@ builtin/submodule--helper.c: static struct cmd_struct commands[] = {
      	{"name", module_name, 0},
      	{"clone", module_clone, 0},
    - 	{"add-clone", add_clone, 0},
    + 	{"add", module_add, SUPPORT_SUPER_PREFIX},
     +	{"update", module_update, 0},
      	{"update-module-mode", module_update_module_mode, 0},
      	{"update-clone", update_clone, 0},
 6:  fb3fa8174a <  -:  ---------- submodule--helper: remove update-clone subcommand
 7:  364f72f870 !  8:  486f9d0a0e submodule--helper: remove unused helpers
    @@ Commit message
         These helpers were useful back when 'submodule update' had most of its
         logic in shell. Now that they will never be invoked, let us remove them.

    +    We also no longer need the 'update_clone_submodules()' and
    +    'update_clone_submodule()' functions, so we remove those as well.
    +
         Mentored-by: Christian Couder <christian.couder@gmail.com>
         Mentored-by: Shourya Shukla <periperidip@gmail.com>
         Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
    @@ builtin/submodule--helper.c: static int do_run_update_procedure(struct update_da
      	return run_update_command(ud, subforce, err);
      }

    +-static void update_clone_submodule(struct update_clone_data *ucd)
    +-{
    +-	fprintf(stdout, "dummy %s %d\t%s\n",
    +-		oid_to_hex(&ucd->oid),
    +-		ucd->just_cloned,
    +-		ucd->sub->path);
    +-}
    +-
    +-static int update_clone_submodules(struct submodule_update_clone *suc)
    +-{
    +-	int i;
    +-
    +-	run_processes_parallel_tr2(suc->max_jobs, update_clone_get_next_task,
    +-				   update_clone_start_failure,
    +-				   update_clone_task_finished, suc, "submodule",
    +-				   "parallel/update");
    +-
    +-	/*
    +-	 * We saved the output and put it out all at once now.
    +-	 * That means:
    +-	 * - the listener does not have to interleave their (checkout)
    +-	 *   work with our fetching.  The writes involved in a
    +-	 *   checkout involve more straightforward sequential I/O.
    +-	 * - the listener can avoid doing any work if fetching failed.
    +-	 */
    +-	if (suc->quickstop)
    +-		return 1;
    +-
    +-	for (i = 0; i < suc->update_clone_nr; i++)
    +-		update_clone_submodule(&suc->update_clone[i]);
    +-
    +-	return 0;
    +-}
    +-
    +-static int update_clone(int argc, const char **argv, const char *prefix)
    +-{
    +-	const char *update = NULL;
    +-	struct pathspec pathspec;
    +-	struct submodule_update_clone suc = SUBMODULE_UPDATE_CLONE_INIT;
    +-
    +-	struct option module_update_clone_options[] = {
    +-		OPT_STRING(0, "prefix", &prefix,
    +-			   N_("path"),
    +-			   N_("path into the working tree")),
    +-		OPT_STRING(0, "recursive-prefix", &suc.recursive_prefix,
    +-			   N_("path"),
    +-			   N_("path into the working tree, across nested "
    +-			      "submodule boundaries")),
    +-		OPT_STRING(0, "update", &update,
    +-			   N_("string"),
    +-			   N_("rebase, merge, checkout or none")),
    +-		OPT_STRING_LIST(0, "reference", &suc.references, N_("repo"),
    +-			   N_("reference repository")),
    +-		OPT_BOOL(0, "dissociate", &suc.dissociate,
    +-			   N_("use --reference only while cloning")),
    +-		OPT_STRING(0, "depth", &suc.depth, "<depth>",
    +-			   N_("create a shallow clone truncated to the "
    +-			      "specified number of revisions")),
    +-		OPT_INTEGER('j', "jobs", &suc.max_jobs,
    +-			    N_("parallel jobs")),
    +-		OPT_BOOL(0, "recommend-shallow", &suc.recommend_shallow,
    +-			    N_("whether the initial clone should follow the shallow recommendation")),
    +-		OPT__QUIET(&suc.quiet, N_("don't print cloning progress")),
    +-		OPT_BOOL(0, "progress", &suc.progress,
    +-			    N_("force cloning progress")),
    +-		OPT_BOOL(0, "require-init", &suc.require_init,
    +-			   N_("disallow cloning into non-empty directory")),
    +-		OPT_BOOL(0, "single-branch", &suc.single_branch,
    +-			 N_("clone only one branch, HEAD or --branch")),
    +-		OPT_END()
    +-	};
    +-
    +-	const char *const git_submodule_helper_usage[] = {
    +-		N_("git submodule--helper update-clone [--prefix=<path>] [<path>...]"),
    +-		NULL
    +-	};
    +-	suc.prefix = prefix;
    +-
    +-	update_clone_config_from_gitmodules(&suc.max_jobs);
    +-	git_config(git_update_clone_config, &suc.max_jobs);
    +-
    +-	argc = parse_options(argc, argv, prefix, module_update_clone_options,
    +-			     git_submodule_helper_usage, 0);
    +-
    +-	if (update)
    +-		if (parse_submodule_update_strategy(update, &suc.update) < 0)
    +-			die(_("bad value for update parameter"));
    +-
    +-	if (module_list_compute(argc, argv, prefix, &pathspec, &suc.list) < 0)
    +-		return 1;
    +-
    +-	if (pathspec.nr)
    +-		suc.warn_if_uninitialized = 1;
    +-
    +-	return update_clone_submodules(&suc);
    +-}
    +-
     -static int run_update_procedure(int argc, const char **argv, const char *prefix)
     -{
     -	int force = 0, quiet = 0, nofetch = 0, just_cloned = 0;
    @@ builtin/submodule--helper.c: static void do_ensure_core_worktree(const char *pat
      	int i;
     @@ builtin/submodule--helper.c: static struct cmd_struct commands[] = {
      	{"clone", module_clone, 0},
    - 	{"add-clone", add_clone, 0},
    + 	{"add", module_add, SUPPORT_SUPER_PREFIX},
      	{"update", module_update, 0},
     -	{"update-module-mode", module_update_module_mode, 0},
    +-	{"update-clone", update_clone, 0},
     -	{"run-update-procedure", run_update_procedure, 0},
     -	{"ensure-core-worktree", ensure_core_worktree, 0},
     -	{"relative-path", resolve_relative_path, 0},
    - 	{"resolve-relative-url", resolve_relative_url, 0},
      	{"resolve-relative-url-test", resolve_relative_url_test, 0},
      	{"foreach", module_foreach, SUPPORT_SUPER_PREFIX},
      	{"init", module_init, SUPPORT_SUPER_PREFIX},
 8:  ca48dd452c !  9:  7b5b2be1a0 submodule--helper: rename helper functions
    @@ builtin/submodule--helper.c: static int push_check(int argc, const char **argv,
     -static void do_ensure_core_worktree(const char *path)
     +static void ensure_core_worktree(const char *path)
      {
    - 	const struct submodule *sub;
      	const char *cw;
    + 	struct repository subrepo;
     @@ builtin/submodule--helper.c: static int update_submodule(struct update_data *update_data)
      	char *prefixed_path;
      	struct string_list err = STRING_LIST_INIT_DUP;

-- 
2.32.0
