Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E24C9C43334
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 20:47:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240011AbiGSUra (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 16:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239593AbiGSUr3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 16:47:29 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B6845247C
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 13:47:26 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id z12so23361107wrq.7
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 13:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bSSvH4VAKYA/g8IAztEuX+92Yw+MI6UiE3IHgFpHoTU=;
        b=GkUfeR7oVsmzsRNxCkWqfNd/MzgJ5oBt0xClIEiTylLqHsk5y2NOqMF0I5OO5+55hN
         QKar6LTTGnYj6x2D3NZPQsvxryM2xPRPHMk+lmUWA2mtQOydeRva3VFkVMoAhilpI70q
         VGybVNgeVsMARMKJxxyNqFNPT7RdlEjE4AgDgVnhSJ+MoTLt3/xgJw4beMQXzytquUuA
         jcJjp5tgKFv4aoXGz54Qp/e3Rl52rhw5IxgfCEttc8t+kSGmijZrrT2tbE8WAqdY4ZTX
         k2doYREUMBQBi1ja7isba/dK2BsboIMyQVjfNI3/EsuyVmtkveGHedF5LvMEuVwTVc4j
         Psrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bSSvH4VAKYA/g8IAztEuX+92Yw+MI6UiE3IHgFpHoTU=;
        b=0xzKFlMYKEJj5vOrK1LuDlvRZJTXLyljsjffepWQE3EIZsZ0dOPBbnhEkEWmmWTKdV
         dvOoX07b9KsTkViy3U864nB0nGHRxm9r+c7Q0CahuQ6i8bmdCPG0nXM/4jOxCNOEbIRb
         74aacOVVxWYXlAZhLmL2FkGjlEwa3nfYoywx2OggSDU+KHLu9e+Ht4BMV8EBAStdf7M7
         Mu+gD1fYMjTiwV8eR7yOxum5lI9p+aAVMsLEbL2isK+0y7jFeh9W5lLfIxZhxQI75PG8
         DvNiu2bx8uVwsRdVcmaZUz2YL5HdAqqOVjwqxZcUhR41ERphLeCtixyNsjYe3FzIbWqR
         33dQ==
X-Gm-Message-State: AJIora8c7Yk9Biz+ZFD/aYt7Wx6EnOTaYc7n7b0QbwpFyXnLUbwVPrCu
        dgRT9YmpYxnwJjIMKWMeq7GfSuuKBMuD3g==
X-Google-Smtp-Source: AGRyM1tWO2SSt6kfquSjeEqp6pgata4Kz2vyhoQv+kQ0i2uTzYyUp/CBnJCFvO7AmsymKYC5L7rJ5w==
X-Received: by 2002:a5d:4c88:0:b0:21d:a699:d553 with SMTP id z8-20020a5d4c88000000b0021da699d553mr28186841wrs.344.1658263644143;
        Tue, 19 Jul 2022 13:47:24 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l18-20020a05600c1d1200b003a04d19dab3sm4711348wms.3.2022.07.19.13.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 13:47:23 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 00/24] submodule--helper: fix memory leaks
Date:   Tue, 19 Jul 2022 22:46:51 +0200
Message-Id: <cover-v2-00.24-00000000000-20220719T204458Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1062.g385eac7fccf
In-Reply-To: <cover-00.11-00000000000-20220713T131601Z-avarab@gmail.com>
References: <cover-00.11-00000000000-20220713T131601Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series fixes all of the memory leaks in
builtin/submodule--helper.c. The v1 went on top of
gc/submodule-use-super-prefix (which in turn was on top ofmy
ab/submodule-cleanup). Both of those have landed on "master", so this
is directly on master.

Thanks a lot to everyone who looked at this & especially to Glen Choo,
I think this re-roll addresses all of his comments.

This is now 24 patches, up from 11, but there's not much of an
increase in complexity here. The growth in size is because I chased
down the rest of the leaks from "submodule--helper", and to show the
progression for certain fixes. E.g. 19-22/24 are all working towards
22/24, but doing so stepwise, to make it easier to reason about each
individual step.

There are leaks that are left that "submodule--helper" runs into, but
it's not in the submodule--helper.c code. E.g. there's one in
submodule & branch.c, and another to do with the object code, etc.. I
thought it was best to leave those for now.

Glen Choo (2):
  submodule--helper: add "const" to copy of "update_data"
  submodule--helper: refactor "errmsg_str" to be a "struct strbuf"

Ævar Arnfjörð Bjarmason (22):
  submodule--helper: replace memset() with { 0 }-initialization
  submodule--helper: fix a leak in "clone_submodule"
  submodule--helper: fix trivial get_default_remote_submodule() leak
  submodule--helper: fix most "struct pathspec" memory leaks
  submodule--helper: "struct pathspec" memory leak in module_update()
  submodule--helper: don't leak {run,capture}_command() cp.dir argument
  submodule--helper: add and use *_release() functions
  submodule--helper: fix "errmsg_str" memory leak
  submodule--helper: fix "sm_path" and other "module_cb_list" leaks
  submodule--helper: fix a leak with repo_clear()
  submodule--helper: fix a memory leak in get_default_remote_submodule()
  submodule--helper: fix "reference" leak is "module_clone_data"
  submodule--helper: fix obscure leak in module_add()
  submodule--helper: fix a leak in module_add()
  submodule--helper: fix a memory leak in print_status()
  submodule--helper: free some "displaypath" in "struct update_data"
  submodule--helper: rename "int res" to "int ret"
  submodule--helper: add skeleton "goto cleanup" to update_submodule()
  submodule--helper: don't exit() on failure, return
  submodule--helper: free rest of "displaypath" in "struct update_data"
  submodule--helper: fix bad config API usage
  submodule--helper: fix a configure_added_submodule() leak

 builtin/submodule--helper.c        | 347 +++++++++++++++++++++--------
 t/t1500-rev-parse.sh               |   1 +
 t/t2403-worktree-move.sh           |   1 +
 t/t6008-rev-list-submodule.sh      |   1 +
 t/t6134-pathspec-in-submodule.sh   |   1 +
 t/t7412-submodule-absorbgitdirs.sh |   1 +
 t/t7413-submodule-is-active.sh     |   1 +
 t/t7414-submodule-mistakes.sh      |   2 +
 t/t7506-status-submodule.sh        |   1 +
 t/t7507-commit-verbose.sh          |   2 +
 10 files changed, 259 insertions(+), 99 deletions(-)

Range-diff against v1:
 2:  4049362e9b4 =  1:  fcdf4a2e2d9 submodule--helper: replace memset() with { 0 }-initialization
 3:  e5ec6945409 !  2:  130a396b837 submodule--helper: fix "module_clone_data" memory leaks
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    submodule--helper: fix "module_clone_data" memory leaks
    +    submodule--helper: fix a leak in "clone_submodule"
     
    -    Fix memory leaks related to the "struct module_clone_data" by creating
    -    a module_clone_data_release() function to go with the
    -    MODULE_CLONE_DATA_INIT added in a98b02c1128 (submodule--helper:
    -    refactor module_clone(), 2021-07-10).
    +    Fix a memory leak of the "path" member of the "struct
    +    module_clone_data" in clone_submodule(). This fixes leaks in code
    +    added in f8eaa0ba98b (submodule--helper, module_clone: always operate
    +    on absolute paths, 2016-03-31).
     
    -    The "path" member can come from "argv" (i.e. not malloc'd), or it can
    -    be something we determine at runtime. In the latter case let's save
    -    away a pointer to free() to avoid leaking memory.
    +    For the "else" case we don't need to xstrdup() the "clone_data->path",
    +    if we're not creating a new one we'll leave it to our caller to keep
    +    track of it.
    +
    +    In the case of the module_clone() caller it's from "argv", and doesn't
    +    need to be free'd, and in the case of the add_submodule() caller we
    +    get a pointer to "sm_path", which doesn't need to be directly free'd
    +    either.
     
         Fixing this leak makes several tests pass, so let's mark them as
         passing with TEST_PASSES_SANITIZE_LEAK=true.
    @@ Commit message
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/submodule--helper.c ##
    -@@ builtin/submodule--helper.c: static int module_deinit(int argc, const char **argv, const char *prefix)
    - struct module_clone_data {
    - 	const char *prefix;
    - 	const char *path;
    -+	char *path_free;
    - 	const char *name;
    - 	const char *url;
    - 	const char *depth;
    -@@ builtin/submodule--helper.c: struct module_clone_data {
    - 	.single_branch = -1, \
    - }
    +@@ builtin/submodule--helper.c: static int clone_submodule(struct module_clone_data *clone_data)
    + 	char *sm_alternate = NULL, *error_strategy = NULL;
    + 	struct strbuf sb = STRBUF_INIT;
    + 	struct child_process cp = CHILD_PROCESS_INIT;
    ++	char *to_free = NULL;
      
    -+static void module_clone_data_release(struct module_clone_data *cd)
    -+{
    -+	free(cd->path_free);
    -+}
    -+
    - struct submodule_alternate_setup {
    - 	const char *submodule_name;
    - 	enum SUBMODULE_ALTERNATE_ERROR_MODE {
    + 	submodule_name_to_gitdir(&sb, the_repository, clone_data->name);
    + 	sm_gitdir = absolute_pathdup(sb.buf);
     @@ builtin/submodule--helper.c: static int clone_submodule(struct module_clone_data *clone_data)
      
      	if (!is_absolute_path(clone_data->path)) {
      		strbuf_addf(&sb, "%s/%s", get_git_work_tree(), clone_data->path);
     -		clone_data->path = strbuf_detach(&sb, NULL);
    -+		clone_data->path = clone_data->path_free = strbuf_detach(&sb, NULL);
    ++		clone_data->path = to_free = strbuf_detach(&sb, NULL);
      	} else {
     -		clone_data->path = xstrdup(clone_data->path);
    -+		clone_data->path = clone_data->path_free = xstrdup(clone_data->path);
    ++		clone_data->path = clone_data->path;
      	}
      
      	if (validate_submodule_git_dir(sm_gitdir, clone_data->name) < 0)
    -@@ builtin/submodule--helper.c: static int module_clone(int argc, const char **argv, const char *prefix)
    - 
    - 	clone_submodule(&clone_data);
    - 	list_objects_filter_release(&filter_options);
    -+
    -+	module_clone_data_release(&clone_data);
    +@@ builtin/submodule--helper.c: static int clone_submodule(struct module_clone_data *clone_data)
    + 	strbuf_release(&sb);
    + 	free(sm_gitdir);
    + 	free(p);
    ++	free(to_free);
      	return 0;
      }
      
    -@@ builtin/submodule--helper.c: static int add_submodule(const struct add_data *add_data)
    - {
    - 	char *submod_gitdir_path;
    - 	struct module_clone_data clone_data = MODULE_CLONE_DATA_INIT;
    -+	int ret;
    - 
    - 	/* perhaps the path already exists and is already a git repo, else clone it */
    - 	if (is_directory(add_data->sm_path)) {
    -@@ builtin/submodule--helper.c: static int add_submodule(const struct add_data *add_data)
    - 		if (add_data->depth >= 0)
    - 			clone_data.depth = xstrfmt("%d", add_data->depth);
    - 
    --		if (clone_submodule(&clone_data))
    --			return -1;
    -+		if (clone_submodule(&clone_data)) {
    -+			ret = -1;
    -+			goto cleanup;
    -+		}
    +
    + ## t/t1500-rev-parse.sh ##
    +@@ t/t1500-rev-parse.sh: test_description='test git rev-parse'
    + GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
    + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
      
    - 		prepare_submodule_repo_env(&cp.env);
    - 		cp.git_cmd = 1;
    -@@ builtin/submodule--helper.c: static int add_submodule(const struct add_data *add_data)
    - 		if (run_command(&cp))
    - 			die(_("unable to checkout submodule '%s'"), add_data->sm_path);
    - 	}
    --	return 0;
    -+	ret = 0;
    -+cleanup:
    -+	module_clone_data_release(&clone_data);
    -+	return ret;
    - }
    ++TEST_PASSES_SANITIZE_LEAK=true
    + . ./test-lib.sh
      
    - static int config_submodule_in_gitmodules(const char *name, const char *var, const char *value)
    + test_one () {
     
      ## t/t6008-rev-list-submodule.sh ##
     @@ t/t6008-rev-list-submodule.sh: test_description='git rev-list involving submodules that this repo has'
 -:  ----------- >  3:  25e17bbb058 submodule--helper: fix trivial get_default_remote_submodule() leak
 4:  cdefd283c23 !  4:  9fb60485c3e submodule--helper: fix "struct pathspec" memory leaks
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    submodule--helper: fix "struct pathspec" memory leaks
    +    submodule--helper: fix most "struct pathspec" memory leaks
     
         Call clear_pathspec() at the end of various functions that work with
         and allocate a "struct pathspec".
 -:  ----------- >  5:  a4672aa9c94 submodule--helper: "struct pathspec" memory leak in module_update()
 5:  76eab92c8b6 !  6:  7925db18b33 submodule--helper: free() leaking {run,capture}_command() argument
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    submodule--helper: free() leaking {run,capture}_command() argument
    +    submodule--helper: don't leak {run,capture}_command() cp.dir argument
     
    -    Free the "dir" member of "struct child_process" that various functions
    -    in submodule-helper.c allocate allocates with xstrdup().
    +    Fix a memory leak in c51f8f94e5b (submodule--helper: run update
    +    procedures from C, 2021-08-24) and 3c3558f0953 (submodule--helper: run
    +    update using child process struct, 2022-03-15) by not allocating
    +    memory in the first place.
     
    -    Since the "dir" argument is "const char *" let's keep a
    -    "char *to_free" variable around for this rather than casting when we
    -    call free().
    +    The "dir" member of "struct child_process" will not be modified by
    +    that API, and it's declared to be "const char *". So let's not
    +    needlessly duplicate these strings.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/submodule--helper.c ##
     @@ builtin/submodule--helper.c: static int is_tip_reachable(const char *path, struct object_id *oid)
    - 	struct child_process cp = CHILD_PROCESS_INIT;
    - 	struct strbuf rev = STRBUF_INIT;
      	char *hex = oid_to_hex(oid);
    -+	char *to_free;
    -+	int ret;
      
      	cp.git_cmd = 1;
     -	cp.dir = xstrdup(path);
    -+	cp.dir = to_free = xstrdup(path);
    ++	cp.dir = path;
      	cp.no_stderr = 1;
      	strvec_pushl(&cp.args, "rev-list", "-n", "1", hex, "--not", "--all", NULL);
      
    - 	prepare_submodule_repo_env(&cp.env);
    - 
    --	if (capture_command(&cp, &rev, GIT_MAX_HEXSZ + 1) || rev.len)
    --		return 0;
    -+	if (capture_command(&cp, &rev, GIT_MAX_HEXSZ + 1) || rev.len) {
    -+		ret = 0;
    -+		goto cleanup;
    -+	}
    - 
    --	return 1;
    -+	ret = 1;
    -+cleanup:
    -+	free(to_free);
    -+	return ret;
    - }
    - 
    - static int fetch_in_submodule(const char *module_path, int depth, int quiet, struct object_id *oid)
    - {
    - 	struct child_process cp = CHILD_PROCESS_INIT;
    -+	char *to_free;
    -+	int ret;
    +@@ builtin/submodule--helper.c: static int fetch_in_submodule(const char *module_path, int depth, int quiet, str
      
      	prepare_submodule_repo_env(&cp.env);
      	cp.git_cmd = 1;
     -	cp.dir = xstrdup(module_path);
    -+	cp.dir = to_free = xstrdup(module_path);
    ++	cp.dir = module_path;
      
      	strvec_push(&cp.args, "fetch");
      	if (quiet)
    -@@ builtin/submodule--helper.c: static int fetch_in_submodule(const char *module_path, int depth, int quiet, str
    - 		free(remote);
    - 	}
    - 
    --	return run_command(&cp);
    -+	ret = run_command(&cp);
    -+	free(to_free);
    -+	return ret;
    - }
    - 
    - static int run_update_command(struct update_data *ud, int subforce)
    -@@ builtin/submodule--helper.c: static int run_update_command(struct update_data *ud, int subforce)
    - 	struct child_process cp = CHILD_PROCESS_INIT;
    - 	char *oid = oid_to_hex(&ud->oid);
    - 	int must_die_on_failure = 0;
    -+	char *to_free;
    -+	int ret;
    - 
    - 	switch (ud->update_strategy.type) {
    - 	case SM_UPDATE_CHECKOUT:
     @@ builtin/submodule--helper.c: static int run_update_command(struct update_data *ud, int subforce)
      	}
      	strvec_push(&cp.args, oid);
      
     -	cp.dir = xstrdup(ud->sm_path);
    -+	cp.dir = to_free = xstrdup(ud->sm_path);
    ++	cp.dir = ud->sm_path;
      	prepare_submodule_repo_env(&cp.env);
      	if (run_command(&cp)) {
      		switch (ud->update_strategy.type) {
    -@@ builtin/submodule--helper.c: static int run_update_command(struct update_data *ud, int subforce)
    - 			exit(128);
    - 
    - 		/* the command failed, but update must continue */
    --		return 1;
    -+		ret = 1;
    -+		goto cleanup;
    - 	}
    - 
    --	if (ud->quiet)
    --		return 0;
    -+	if (ud->quiet) {
    -+		ret = 0;
    -+		goto cleanup;
    -+	}
    - 
    - 	switch (ud->update_strategy.type) {
    - 	case SM_UPDATE_CHECKOUT:
    -@@ builtin/submodule--helper.c: static int run_update_command(struct update_data *ud, int subforce)
    - 		    submodule_strategy_to_string(&ud->update_strategy));
    - 	}
    - 
    --	return 0;
    -+	ret = 0;
    -+cleanup:
    -+	free(to_free);
    -+	return ret;
    - }
    - 
    - static int run_update_procedure(struct update_data *ud)
 -:  ----------- >  7:  30883f3aa01 submodule--helper: add "const" to copy of "update_data"
 6:  b9984e982db !  8:  b7582391c91 submodule--helper: add and use *_release() functions
    @@ Commit message
         submodule--helper: add and use *_release() functions
     
         Add release functions for "struct module_list", "struct
    -    submodule_update_clone" and "struct update_data". For now we're
    -    leaving some of the "struct update_data" members, we'll deal with
    -    those in a subsequent commit.
    +    submodule_update_clone" and "struct update_data".
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ builtin/submodule--helper.c: struct submodule_update_clone {
      
     +static void submodule_update_clone_release(struct submodule_update_clone *suc)
     +{
    -+	/* Not "update_data", owned by update_data_release() */
     +	free(suc->update_clone);
     +	free(suc->failed_clones);
     +}
    @@ builtin/submodule--helper.c: static int update_submodules(struct update_data *up
     @@ builtin/submodule--helper.c: static int module_update(int argc, const char **argv, const char *prefix)
      
      		if (module_list_compute(argc, argv, opt.prefix,
    - 					&pathspec, &list) < 0) {
    + 					&pathspec2, &list) < 0) {
     +			module_list_release(&list);
      			ret = 1;
      			goto cleanup;
    @@ builtin/submodule--helper.c: static int module_update(int argc, const char **arg
     +	update_data_release(&opt);
      	list_objects_filter_release(&filter_options);
      	clear_pathspec(&pathspec);
    - 	return ret;
    + 	clear_pathspec(&pathspec2);
     @@ builtin/submodule--helper.c: static int absorb_git_dirs(int argc, const char **argv, const char *prefix)
      	ret = 0;
      cleanup:
 7:  f8c20bbf266 !  9:  92737916083 submodule--helper: fix "errmsg_str" memory leak
    @@
      ## Metadata ##
    -Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
    +Author: Glen Choo <chooglen@google.com>
     
      ## Commit message ##
    -    submodule--helper: fix "errmsg_str" memory leak
    +    submodule--helper: refactor "errmsg_str" to be a "struct strbuf"
     
    -    Fix a memory leak introduced in e83e3333b57 (submodule: port submodule
    -    subcommand 'summary' from shell to C, 2020-08-13), to do that stop
    -    juggling around the "errmsg" and "struct strbuf", let's instead move
    -    the "struct strbuf errmsg" to the top-level.
    +    Refactor code added in e83e3333b57 (submodule: port submodule
    +    subcommand 'summary' from shell to C, 2020-08-13) so that "errmsg" and
    +    "errmsg_str" are folded into one. The distinction between the empty
    +    string and NULL is something that's tested for by
    +    e.g. "t/t7401-submodule-summary.sh".
     
    -    Now we don't need to strbuf_detach() it anymore, but we do need to
    -    ensure that we pass NULL to print_submodule_summary() when we have no
    -    error message.
    +    This is in preparation for fixing a memory leak the "struct strbuf" in
    +    the pre-image.
     
    +    Let's also pass a "const char *" to print_submodule_summary(), as it
    +    should not be modifying the "errmsg".
    +
    +    Signed-off-by: Glen Choo <chooglen@google.com>
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/submodule--helper.c ##
    +@@ builtin/submodule--helper.c: static char *verify_submodule_committish(const char *sm_path,
    + 	return strbuf_detach(&result, NULL);
    + }
    + 
    +-static void print_submodule_summary(struct summary_cb *info, char *errmsg,
    ++static void print_submodule_summary(struct summary_cb *info, const char *errmsg,
    + 				    int total_commits, const char *displaypath,
    + 				    const char *src_abbrev, const char *dst_abbrev,
    + 				    struct module_cb *p)
     @@ builtin/submodule--helper.c: static void generate_submodule_summary(struct summary_cb *info,
      {
      	char *displaypath, *src_abbrev = NULL, *dst_abbrev;
      	int missing_src = 0, missing_dst = 0;
     -	char *errmsg = NULL;
    -+	char *errmsg;
    -+	struct strbuf errmsg_str = STRBUF_INIT;
    ++	struct strbuf errmsg = STRBUF_INIT;
      	int total_commits = -1;
      
      	if (!info->cached && oideq(&p->oid_dst, null_oid())) {
    @@ builtin/submodule--helper.c: static void generate_submodule_summary(struct summa
      		if (S_ISGITLINK(p->mod_dst)) {
     -			struct strbuf errmsg_str = STRBUF_INIT;
      			if (missing_src && missing_dst) {
    - 				strbuf_addf(&errmsg_str, "  Warn: %s doesn't contain commits %s and %s\n",
    +-				strbuf_addf(&errmsg_str, "  Warn: %s doesn't contain commits %s and %s\n",
    ++				strbuf_addf(&errmsg, "  Warn: %s doesn't contain commits %s and %s\n",
      					    displaypath, oid_to_hex(&p->oid_src),
    -@@ builtin/submodule--helper.c: static void generate_submodule_summary(struct summary_cb *info,
    + 					    oid_to_hex(&p->oid_dst));
    + 			} else {
    +-				strbuf_addf(&errmsg_str, "  Warn: %s doesn't contain commit %s\n",
    ++				strbuf_addf(&errmsg, "  Warn: %s doesn't contain commit %s\n",
    + 					    displaypath, missing_src ?
      					    oid_to_hex(&p->oid_src) :
      					    oid_to_hex(&p->oid_dst));
      			}
    @@ builtin/submodule--helper.c: static void generate_submodule_summary(struct summa
      		}
      	}
      
    -+	errmsg = errmsg_str.len ? errmsg_str.buf : NULL;
    - 	print_submodule_summary(info, errmsg, total_commits,
    - 				displaypath, src_abbrev,
    +-	print_submodule_summary(info, errmsg, total_commits,
    +-				displaypath, src_abbrev,
    ++	print_submodule_summary(info, errmsg.len ? errmsg.buf : NULL,
    ++				total_commits, displaypath, src_abbrev,
      				dst_abbrev, p);
    -@@ builtin/submodule--helper.c: static void generate_submodule_summary(struct summary_cb *info,
    - 	free(displaypath);
    - 	free(src_abbrev);
    - 	free(dst_abbrev);
    -+	strbuf_release(&errmsg_str);
    - }
      
    - static void prepare_submodule_summary(struct summary_cb *info,
    + 	free(displaypath);
 -:  ----------- > 10:  c81a4f69179 submodule--helper: fix "errmsg_str" memory leak
 8:  c8bb7bb7bb3 = 11:  c25b55c9528 submodule--helper: fix "sm_path" and other "module_cb_list" leaks
10:  e6c633256f3 ! 12:  303447bd4f5 submodule--helper: fix a leak with repo_clear()
    @@ builtin/submodule--helper.c: static void ensure_core_worktree(const char *path)
      }
      
      static const char *submodule_update_type_to_label(enum submodule_update_type type)
    -
    - ## t/t2403-worktree-move.sh ##
    -@@
    - 
    - test_description='test git worktree move, remove, lock and unlock'
    - 
    -+TEST_PASSES_SANITIZE_LEAK=true
    - . ./test-lib.sh
    - 
    - test_expect_success 'setup' '
    -
    - ## t/t7412-submodule-absorbgitdirs.sh ##
    -@@ t/t7412-submodule-absorbgitdirs.sh: This test verifies that `git submodue absorbgitdirs` moves a submodules git
    - directory into the superproject.
    - '
    - 
    -+TEST_PASSES_SANITIZE_LEAK=true
    - . ./test-lib.sh
    - 
    - test_expect_success 'setup a real submodule' '
 -:  ----------- > 13:  f8ededcdf77 submodule--helper: fix a memory leak in get_default_remote_submodule()
11:  475b1196a93 ! 14:  c7610088968 submodule--helper: fix "reference" leak is "module_clone_data"
    @@ Commit message
         those, but not the ones we get from argv, let's make use of the "util"
         member, if it has a pointer it's the pointer we'll need to free.
     
    +    To fix this create a a module_clone_data_release() function to go with
    +    the MODULE_CLONE_DATA_INIT added in a98b02c1128 (submodule--helper:
    +    refactor module_clone(), 2021-07-10). We only need to add it to
    +    add_submodule() to fix the leak, but let's add it to module_clone() as
    +    well for consistency.
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/submodule--helper.c ##
     @@ builtin/submodule--helper.c: struct module_clone_data {
    - static void module_clone_data_release(struct module_clone_data *cd)
    - {
    - 	free(cd->path_free);
    -+	string_list_clear(&cd->reference, 1);
    + 	.single_branch = -1, \
      }
      
    ++static void module_clone_data_release(struct module_clone_data *cd)
    ++{
    ++	string_list_clear(&cd->reference, 1);
    ++}
    ++
      struct submodule_alternate_setup {
    + 	const char *submodule_name;
    + 	enum SUBMODULE_ALTERNATE_ERROR_MODE {
     @@ builtin/submodule--helper.c: static int add_possible_reference_from_superproject(
      
      		sm_alternate = compute_alternate_path(sb.buf, &err);
    @@ builtin/submodule--helper.c: static int add_possible_reference_from_superproject
      			free(sm_alternate);
      		} else {
      			switch (sas->error_mode) {
    +@@ builtin/submodule--helper.c: static int module_clone(int argc, const char **argv, const char *prefix)
    + 
    + 	clone_submodule(&clone_data);
    + 	list_objects_filter_release(&filter_options);
    ++	module_clone_data_release(&clone_data);
    + 	return 0;
    + }
    + 
    +@@ builtin/submodule--helper.c: static int add_submodule(const struct add_data *add_data)
    + {
    + 	char *submod_gitdir_path;
    + 	struct module_clone_data clone_data = MODULE_CLONE_DATA_INIT;
    ++	int ret;
    + 
    + 	/* perhaps the path already exists and is already a git repo, else clone it */
    + 	if (is_directory(add_data->sm_path)) {
     @@ builtin/submodule--helper.c: static int add_submodule(const struct add_data *add_data)
      		clone_data.url = add_data->realrepo;
      		clone_data.quiet = add_data->quiet;
    @@ builtin/submodule--helper.c: static int add_submodule(const struct add_data *add
      		clone_data.dissociate = add_data->dissociate;
      		if (add_data->depth >= 0)
      			clone_data.depth = xstrfmt("%d", add_data->depth);
    + 
    +-		if (clone_submodule(&clone_data))
    +-			return -1;
    ++		if (clone_submodule(&clone_data)) {
    ++			ret = -1;
    ++			goto cleanup;
    ++		}
    + 
    + 		prepare_submodule_repo_env(&cp.env);
    + 		cp.git_cmd = 1;
    +@@ builtin/submodule--helper.c: static int add_submodule(const struct add_data *add_data)
    + 		if (run_command(&cp))
    + 			die(_("unable to checkout submodule '%s'"), add_data->sm_path);
    + 	}
    +-	return 0;
    ++	ret = 0;
    ++cleanup:
    ++	module_clone_data_release(&clone_data);
    ++	return ret;
    + }
    + 
    + static int config_submodule_in_gitmodules(const char *name, const char *var, const char *value)
 -:  ----------- > 15:  abd8e2eef3a submodule--helper: fix obscure leak in module_add()
 -:  ----------- > 16:  1f01203d154 submodule--helper: fix a leak in module_add()
 -:  ----------- > 17:  12b8a945486 submodule--helper: fix a memory leak in print_status()
 9:  7b36f71879e ! 18:  fac2c4491f3 submodule--helper: free "char *" in "struct update_data"
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    submodule--helper: free "char *" in "struct update_data"
    +    submodule--helper: free some "displaypath" in "struct update_data"
     
    -    Make the update_data_release() function free the "recursive_prefix"
    -    and "displaypath" members when appropriate. For the former it could
    -    come from either "argv" or from our own allocation, so we need to keep
    -    track of a "to_free" sibling seperately.
    +    Make the update_data_release() function free "displaypath" member when
    +    appropriate. The "displaypath" member is always ours, the "const" on
    +    the "char *" was wrong to begin with.
     
    -    For "displaypath" it's always ours, so the "const char *" type was
    -    wrong to begin with, it should be a "char *" instead.
    -
    -    For update_submodule() we'll free() these as we go along, it's called
    -    in a loop by update_submodules(), and we'll need to free the "last"
    -    one.
    +    This leaves a leak of "displaypath" in update_submodule(), which as
    +    we'll see in subsequent commits is harder to deal with than this
    +    trivial fix.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ builtin/submodule--helper.c: struct update_data {
      	module_list_release(&ud->list);
      }
      
    +
    + ## t/t2403-worktree-move.sh ##
    +@@
    + 
    + test_description='test git worktree move, remove, lock and unlock'
    + 
    ++TEST_PASSES_SANITIZE_LEAK=true
    + . ./test-lib.sh
    + 
    + test_expect_success 'setup' '
    +
    + ## t/t7412-submodule-absorbgitdirs.sh ##
    +@@ t/t7412-submodule-absorbgitdirs.sh: This test verifies that `git submodue absorbgitdirs` moves a submodules git
    + directory into the superproject.
    + '
    + 
    ++TEST_PASSES_SANITIZE_LEAK=true
    + . ./test-lib.sh
    + 
    + test_expect_success 'setup a real submodule' '
 -:  ----------- > 19:  cf0c8851954 submodule--helper: rename "int res" to "int ret"
 -:  ----------- > 20:  7882e33cdca submodule--helper: add skeleton "goto cleanup" to update_submodule()
 1:  f1c847ad613 ! 21:  31395a2b4f8 submodule.c: free() memory from xgetcwd()
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    submodule.c: free() memory from xgetcwd()
    +    submodule--helper: don't exit() on failure, return
     
    -    Fix a memory leak in code added in bf0231c6614 (rev-parse: add
    -    --show-superproject-working-tree, 2017-03-08), we should never have
    -    made the result of xgetcwd() a "const char *", as we return a
    -    strbuf_detach()'d value. Let's fix that and free() it when we're done
    -    with it.
    +    Change code downstream of module_update() to short-circuit and return
    +    to the top-level on failure, rather than calling exit().
     
    -    We can't mark any tests passing passing with SANITIZE=leak using
    -    "TEST_PASSES_SANITIZE_LEAK=true" as a result of this change, but
    -    e.g. "t/t1500-rev-parse.sh" now gets closer to passing.
    +    To do so we need to diligently check whether we "must_die_on_failure",
    +    which is a pattern started in c51f8f94e5b (submodule--helper: run
    +    update procedures from C, 2021-08-24), but which hadn't been completed
    +    to the point where we could avoid calling exit() here.
    +
    +    This introduces no functional changes, but makes it easier to both
    +    call these routines as a library in the future, and to avoid leaking
    +    memory.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    - ## submodule.c ##
    -@@ submodule.c: int get_superproject_working_tree(struct strbuf *buf)
    + ## builtin/submodule--helper.c ##
    +@@ builtin/submodule--helper.c: static int fetch_in_submodule(const char *module_path, int depth, int quiet, str
    + 	return run_command(&cp);
    + }
    + 
    +-static int run_update_command(struct update_data *ud, int subforce)
    ++static int run_update_command(struct update_data *ud, int subforce,
    ++			      int *must_die_on_failurep)
    + {
      	struct child_process cp = CHILD_PROCESS_INIT;
    - 	struct strbuf sb = STRBUF_INIT;
    - 	struct strbuf one_up = STRBUF_INIT;
    --	const char *cwd = xgetcwd();
    -+	char *cwd = xgetcwd();
    - 	int ret = 0;
    - 	const char *subpath;
    - 	int code;
    -@@ submodule.c: int get_superproject_working_tree(struct strbuf *buf)
    - 		ret = 1;
    - 		free(super_wt);
    + 	char *oid = oid_to_hex(&ud->oid);
    +@@ builtin/submodule--helper.c: static int run_update_command(struct update_data *ud, int subforce)
    + 			BUG("unexpected update strategy type: %s",
    + 			    submodule_strategy_to_string(&ud->update_strategy));
    + 		}
    +-		if (must_die_on_failure)
    +-			exit(128);
    ++		if (must_die_on_failure) {
    ++			*must_die_on_failurep = 1;
    ++			return 128;
    ++		}
    + 
    + 		/* the command failed, but update must continue */
    + 		return 1;
    +@@ builtin/submodule--helper.c: static int run_update_command(struct update_data *ud, int subforce)
    + 	return 0;
    + }
    + 
    +-static int run_update_procedure(struct update_data *ud)
    ++static int run_update_procedure(struct update_data *ud,
    ++				int *must_die_on_failure)
    + {
    + 	int subforce = is_null_oid(&ud->suboid) || ud->force;
    + 
    +@@ builtin/submodule--helper.c: static int run_update_procedure(struct update_data *ud)
    + 			    ud->displaypath, oid_to_hex(&ud->oid));
    + 	}
    + 
    +-	return run_update_command(ud, subforce);
    ++	return run_update_command(ud, subforce, must_die_on_failure);
    + }
    + 
    + static const char *remote_submodule_branch(const char *path)
    +@@ builtin/submodule--helper.c: static void update_data_to_args(struct update_data *update_data, struct strvec *
    + 				    "--no-single-branch");
    + }
    + 
    +-static int update_submodule(struct update_data *update_data)
    ++static int update_submodule(struct update_data *update_data,
    ++			    int *must_die_on_failure)
    + {
    + 	int ret;
    + 
    +@@ builtin/submodule--helper.c: static int update_submodule(struct update_data *update_data)
    + 	}
    + 
    + 	if (!oideq(&update_data->oid, &update_data->suboid) || update_data->force) {
    +-		ret = run_update_procedure(update_data);
    +-		if (ret) {
    ++		ret = run_update_procedure(update_data, must_die_on_failure);
    ++		if (ret && *must_die_on_failure) {
    ++			goto cleanup;
    ++		} else if (ret) {
    + 			ret = 1;
    + 			goto cleanup;
    + 		}
    +@@ builtin/submodule--helper.c: static int update_submodule(struct update_data *update_data)
    + 		die_message(_("Failed to recurse into submodule path '%s'"),
    + 			    update_data->displaypath);
    + 		if (ret == 128) {
    +-			exit(ret);
    ++			*must_die_on_failure = 1;
    ++			goto cleanup;
    + 		} else if (ret) {
    + 			ret = 1;
    + 			goto cleanup;
    +@@ builtin/submodule--helper.c: static int update_submodules(struct update_data *update_data)
    + 
    + 	for (i = 0; i < suc.update_clone_nr; i++) {
    + 		struct update_clone_data ucd = suc.update_clone[i];
    ++		int code;
    ++		int must_die_on_failure = 0;
    + 
    + 		oidcpy(&update_data->oid, &ucd.oid);
    + 		update_data->just_cloned = ucd.just_cloned;
    + 		update_data->sm_path = ucd.sub->path;
    + 
    +-		if (update_submodule(update_data))
    +-			res = 1;
    ++		code = update_submodule(update_data, &must_die_on_failure);
    ++		if (code)
    ++			res = code;
    ++		if (must_die_on_failure)
    ++			goto cleanup;
      	}
    -+	free(cwd);
    - 	strbuf_release(&sb);
      
    - 	code = finish_command(&cp);
    + cleanup:
 -:  ----------- > 22:  a2168cf1378 submodule--helper: free rest of "displaypath" in "struct update_data"
 -:  ----------- > 23:  d77c6665ca9 submodule--helper: fix bad config API usage
 -:  ----------- > 24:  531db4ddae6 submodule--helper: fix a configure_added_submodule() leak
-- 
2.37.1.1062.g385eac7fccf

