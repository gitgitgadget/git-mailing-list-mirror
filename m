Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8126FC433EF
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 19:13:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233278AbiGUTNi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 15:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiGUTNg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 15:13:36 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B07D588740
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 12:13:33 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id m17so3325975wrw.7
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 12:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mpAQD4JARXqwfAaDyXiS+SZ0C0EGvatI5zhmG7FuwMk=;
        b=WC8qjiBnAPnRy+ufeLa+9X4xHDj2QU3wtaUMJEDGmYDQHcVw8Wq7D/6yihwRkx9XXV
         dHKmNqORMLDuGn7Y54GxKm6edsjciZzXuaFSl2T4/5QqtDxBg287ECb0mEb9Lw1WnkTk
         LryBGO45Owzx6uv+vpWGjBuxJVebjuswGkqY02uCug5qop3bJ0CNhc1t4xYTlQO29/o7
         DNt8BE3LCDw3ZamJpYgeY5C59qJQArrWQ8soSORuAFM2IsIr8gI1EGLJ7AMYlcr+NLUc
         2jqJvnsgV7D9I2K2VRMwF4WQCQqnan/hqW5bTRzuao/cPz5uBHKXsfqwJ6wau3CJVx7M
         g+bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mpAQD4JARXqwfAaDyXiS+SZ0C0EGvatI5zhmG7FuwMk=;
        b=Jpz7ka9iaU2K9CudTEf/Ejx8q1yPtRPuQ/ZzcY5EdrkIolQzkpZ8GREfPQOJXxp23W
         M6ROqW8TQo93+4OB6faOLe+NfWeGIYYNgCcNIN0PSx/iMKdO/zPRiCoSk1ORwTVEWxVi
         pBL+qy3cdg9gVMCJON+K6zZII3UZQPTujD5p2QChvQ9ua2k9MmNjkZZWTNMpx2HtOGbf
         tsj6h/PQw4L9ln2Vwv7/HQ2F3QMLeZmokVsgOegaZZftYAl4h2fMg2UD4zYU0V6SuKAP
         VkZet3DehfYUVuJEmH6oCPxMKQkW+I6oCp6XJVFQo7yNzEBZOIv7Hw/3bgf32n2AI2OM
         EW1A==
X-Gm-Message-State: AJIora8JFobM4zJbdbk2+vgIJY4cPuMxzaeKV/i49UpJAL56SRov1223
        Zl4E0uTZIcDvYML1OITGU02/D50J8Nt1dg==
X-Google-Smtp-Source: AGRyM1vGy5pyRWq3MN+VDotHOKs6z10OUC0wHFKFggRyk5WtVL1SBUnBWPnwc0/M5s5Avczic78FYQ==
X-Received: by 2002:adf:e708:0:b0:21e:59c8:d2ea with SMTP id c8-20020adfe708000000b0021e59c8d2eamr2405303wrm.499.1658430811866;
        Thu, 21 Jul 2022 12:13:31 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h13-20020a05600016cd00b0021e4e9f6450sm2630637wrf.84.2022.07.21.12.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 12:13:30 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 00/26] submodule--helper: fix memory leaks
Date:   Thu, 21 Jul 2022 21:12:56 +0200
Message-Id: <cover-v3-00.26-00000000000-20220721T191249Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1095.g0bd6f54ba8a
In-Reply-To: <cover-v2-00.24-00000000000-20220719T204458Z-avarab@gmail.com>
References: <cover-v2-00.24-00000000000-20220719T204458Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series fixes all of the memory leaks in submodule--helper.c that
the test suite spots (which aren't really in submodule.c, branch.c,
object code etc.).

For the v2, see:
https://lore.kernel.org/git/cover-v2-00.24-00000000000-20220719T204458Z-avarab@gmail.com/

Junio: I only replied to one feedback E-Mail of yours, but I think
this re-roll addresses all the rest, as well as the "pathspec" comment
Glen sent in earlier today.

Glen Choo (2):
  submodule--helper: add "const" to copy of "update_data"
  submodule--helper: refactor "errmsg_str" to be a "struct strbuf"

Ævar Arnfjörð Bjarmason (24):
  submodule--helper: replace memset() with { 0 }-initialization
  submodule--helper: stop conflating "sb" in clone_submodule()
  submodule--helper: pass a "const struct module_clone_data" to
    clone_submodule()
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

 builtin/submodule--helper.c        | 374 ++++++++++++++++++++---------
 t/t1500-rev-parse.sh               |   1 +
 t/t2403-worktree-move.sh           |   1 +
 t/t6008-rev-list-submodule.sh      |   1 +
 t/t6134-pathspec-in-submodule.sh   |   1 +
 t/t7412-submodule-absorbgitdirs.sh |   1 +
 t/t7413-submodule-is-active.sh     |   1 +
 t/t7414-submodule-mistakes.sh      |   2 +
 t/t7506-status-submodule.sh        |   1 +
 t/t7507-commit-verbose.sh          |   2 +
 10 files changed, 270 insertions(+), 115 deletions(-)

Range-diff against v2:
 1:  fcdf4a2e2d9 =  1:  3c7ae3e0222 submodule--helper: replace memset() with { 0 }-initialization
 -:  ----------- >  2:  32e4ae7ead5 submodule--helper: stop conflating "sb" in clone_submodule()
 -:  ----------- >  3:  eee6ca28c6f submodule--helper: pass a "const struct module_clone_data" to clone_submodule()
 2:  130a396b837 !  4:  26f0caf0386 submodule--helper: fix a leak in "clone_submodule"
    @@ Metadata
      ## Commit message ##
         submodule--helper: fix a leak in "clone_submodule"
     
    -    Fix a memory leak of the "path" member of the "struct
    -    module_clone_data" in clone_submodule(). This fixes leaks in code
    -    added in f8eaa0ba98b (submodule--helper, module_clone: always operate
    +    Fix a memory leak of the "clone_data_path" variable that we copy or
    +    derive from the "struct module_clone_data" in clone_submodule(). This
    +    code was refactored in preceding commits, but the leak has been with
    +    us since f8eaa0ba98b (submodule--helper, module_clone: always operate
         on absolute paths, 2016-03-31).
     
         For the "else" case we don't need to xstrdup() the "clone_data->path",
    -    if we're not creating a new one we'll leave it to our caller to keep
    -    track of it.
    +    and we don't need to free our own "clone_data_path".
     
         In the case of the module_clone() caller it's from "argv", and doesn't
         need to be free'd, and in the case of the add_submodule() caller we
    @@ Commit message
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/submodule--helper.c ##
    -@@ builtin/submodule--helper.c: static int clone_submodule(struct module_clone_data *clone_data)
    +@@ builtin/submodule--helper.c: static int clone_submodule(const struct module_clone_data *clone_data,
      	char *sm_alternate = NULL, *error_strategy = NULL;
    - 	struct strbuf sb = STRBUF_INIT;
      	struct child_process cp = CHILD_PROCESS_INIT;
    + 	const char *clone_data_path;
     +	char *to_free = NULL;
      
    - 	submodule_name_to_gitdir(&sb, the_repository, clone_data->name);
    - 	sm_gitdir = absolute_pathdup(sb.buf);
    -@@ builtin/submodule--helper.c: static int clone_submodule(struct module_clone_data *clone_data)
    - 
      	if (!is_absolute_path(clone_data->path)) {
    + 		struct strbuf sb = STRBUF_INIT;
    + 
      		strbuf_addf(&sb, "%s/%s", get_git_work_tree(), clone_data->path);
    --		clone_data->path = strbuf_detach(&sb, NULL);
    -+		clone_data->path = to_free = strbuf_detach(&sb, NULL);
    +-		clone_data_path = strbuf_detach(&sb, NULL);
    ++		clone_data_path = to_free = strbuf_detach(&sb, NULL);
      	} else {
    --		clone_data->path = xstrdup(clone_data->path);
    -+		clone_data->path = clone_data->path;
    +-		clone_data_path = xstrdup(clone_data_path);
    ++		clone_data_path = clone_data->path;
      	}
      
      	if (validate_submodule_git_dir(sm_gitdir, clone_data->name) < 0)
    -@@ builtin/submodule--helper.c: static int clone_submodule(struct module_clone_data *clone_data)
    - 	strbuf_release(&sb);
    +@@ builtin/submodule--helper.c: static int clone_submodule(const struct module_clone_data *clone_data,
    + 
      	free(sm_gitdir);
      	free(p);
     +	free(to_free);
 3:  25e17bbb058 =  5:  75775bf4f6c submodule--helper: fix trivial get_default_remote_submodule() leak
 4:  9fb60485c3e !  6:  7672ef1305f submodule--helper: fix most "struct pathspec" memory leaks
    @@ builtin/submodule--helper.c: static int module_list(int argc, const char **argv,
      			   N_("alternative anchor for relative paths")),
      		OPT_END()
      	};
    -+	int ret;
    ++	int ret = 1;
      
      	const char *const git_submodule_helper_usage[] = {
      		N_("git submodule--helper list [--prefix=<path>] [<path>...]"),
     @@ builtin/submodule--helper.c: static int module_list(int argc, const char **argv, const char *prefix)
    - 	argc = parse_options(argc, argv, prefix, module_list_options,
      			     git_submodule_helper_usage, 0);
      
    --	if (module_list_compute(argc, argv, prefix, &pathspec, &list) < 0)
    + 	if (module_list_compute(argc, argv, prefix, &pathspec, &list) < 0)
     -		return 1;
    -+	if (module_list_compute(argc, argv, prefix, &pathspec, &list) < 0) {
    -+		ret = 1;
     +		goto cleanup;
    -+	}
      
      	for (i = 0; i < list.nr; i++) {
      		const struct cache_entry *ce = list.entries[i];
    @@ builtin/submodule--helper.c: static int module_foreach(int argc, const char **ar
      		N_("git submodule foreach [--quiet] [--recursive] [--] <command>"),
      		NULL
      	};
    -+	int ret;
    ++	int ret = 1;
      
      	argc = parse_options(argc, argv, prefix, module_foreach_options,
      			     git_submodule_helper_usage, 0);
      
    --	if (module_list_compute(0, NULL, prefix, &pathspec, &list) < 0)
    + 	if (module_list_compute(0, NULL, prefix, &pathspec, &list) < 0)
     -		return 1;
    -+	if (module_list_compute(0, NULL, prefix, &pathspec, &list) < 0) {
    -+		ret = 1;
     +		goto cleanup;
    -+	}
      
      	info.argc = argc;
      	info.argv = argv;
    @@ builtin/submodule--helper.c: static int module_init(int argc, const char **argv,
      		N_("git submodule init [<options>] [<path>]"),
      		NULL
      	};
    -+	int ret;
    ++	int ret = 1;
      
      	argc = parse_options(argc, argv, prefix, module_init_options,
      			     git_submodule_helper_usage, 0);
      
    --	if (module_list_compute(argc, argv, prefix, &pathspec, &list) < 0)
    + 	if (module_list_compute(argc, argv, prefix, &pathspec, &list) < 0)
     -		return 1;
    -+	if (module_list_compute(argc, argv, prefix, &pathspec, &list) < 0) {
    -+		ret = 1;
     +		goto cleanup;
    -+	}
      
      	/*
      	 * If there are no path args and submodule.active is set then,
    @@ builtin/submodule--helper.c: static int module_status(int argc, const char **arg
      		N_("git submodule status [--quiet] [--cached] [--recursive] [<path>...]"),
      		NULL
      	};
    -+	int ret;
    ++	int ret = 1;
      
      	argc = parse_options(argc, argv, prefix, module_status_options,
      			     git_submodule_helper_usage, 0);
      
    --	if (module_list_compute(argc, argv, prefix, &pathspec, &list) < 0)
    + 	if (module_list_compute(argc, argv, prefix, &pathspec, &list) < 0)
     -		return 1;
    -+	if (module_list_compute(argc, argv, prefix, &pathspec, &list) < 0) {
    -+		ret = 1;
     +		goto cleanup;
    -+	}
      
      	info.prefix = prefix;
      	if (quiet)
    @@ builtin/submodule--helper.c: static int module_status(int argc, const char **arg
      }
      
      static int module_name(int argc, const char **argv, const char *prefix)
    -@@ builtin/submodule--helper.c: static int compute_summary_module_list(struct object_id *head_oid,
    - 	struct strvec diff_args = STRVEC_INIT;
    - 	struct rev_info rev;
    - 	struct module_cb_list list = MODULE_CB_LIST_INIT;
    --	int ret = 0;
    -+	int ret;
    - 
    - 	strvec_push(&diff_args, get_diff_cmd(diff_cmd));
    - 	if (info->cached)
    -@@ builtin/submodule--helper.c: static int compute_summary_module_list(struct object_id *head_oid,
    - 	else
    - 		run_diff_files(&rev, 0);
    - 	prepare_submodule_summary(info, &list);
    -+	ret = 0;
    - cleanup:
    - 	strvec_clear(&diff_args);
    - 	release_revisions(&rev);
     @@ builtin/submodule--helper.c: static void sync_submodule_cb(const struct cache_entry *list_item, void *cb_data
      static int module_sync(int argc, const char **argv, const char *prefix)
      {
    @@ builtin/submodule--helper.c: static void sync_submodule_cb(const struct cache_en
      	struct module_list list = MODULE_LIST_INIT;
      	int quiet = 0;
      	int recursive = 0;
    -+	int ret;
    ++	int ret = 1;
      
      	struct option module_sync_options[] = {
      		OPT__QUIET(&quiet, N_("suppress output of synchronizing submodule url")),
     @@ builtin/submodule--helper.c: static int module_sync(int argc, const char **argv, const char *prefix)
    - 	argc = parse_options(argc, argv, prefix, module_sync_options,
      			     git_submodule_helper_usage, 0);
      
    --	if (module_list_compute(argc, argv, prefix, &pathspec, &list) < 0)
    + 	if (module_list_compute(argc, argv, prefix, &pathspec, &list) < 0)
     -		return 1;
    -+	if (module_list_compute(argc, argv, prefix, &pathspec, &list) < 0) {
    -+		ret = 1;
     +		goto cleanup;
    -+	}
      
      	info.prefix = prefix;
      	if (quiet)
    @@ builtin/submodule--helper.c: static int module_deinit(int argc, const char **arg
      		N_("git submodule deinit [--quiet] [-f | --force] [--all | [--] [<path>...]]"),
      		NULL
      	};
    -+	int ret;
    ++	int ret = 1;
      
      	argc = parse_options(argc, argv, prefix, module_deinit_options,
      			     git_submodule_helper_usage, 0);
     @@ builtin/submodule--helper.c: static int module_deinit(int argc, const char **argv, const char *prefix)
    - 	if (!argc && !all)
      		die(_("Use '--all' if you really want to deinitialize all submodules"));
      
    --	if (module_list_compute(argc, argv, prefix, &pathspec, &list) < 0)
    + 	if (module_list_compute(argc, argv, prefix, &pathspec, &list) < 0)
     -		return 1;
    -+	if (module_list_compute(argc, argv, prefix, &pathspec, &list) < 0) {
    -+		ret = 1;
     +		goto cleanup;
    -+	}
      
      	info.prefix = prefix;
      	if (quiet)
    @@ builtin/submodule--helper.c: static int push_check(int argc, const char **argv,
     +	struct pathspec pathspec = { 0 };
      	struct module_list list = MODULE_LIST_INIT;
      	unsigned flags = ABSORB_GITDIR_RECURSE_SUBMODULES;
    -+	int ret;
    ++	int ret = 1;
      
      	struct option embed_gitdir_options[] = {
      		OPT_STRING(0, "prefix", &prefix,
     @@ builtin/submodule--helper.c: static int absorb_git_dirs(int argc, const char **argv, const char *prefix)
    - 	argc = parse_options(argc, argv, prefix, embed_gitdir_options,
      			     git_submodule_helper_usage, 0);
      
    --	if (module_list_compute(argc, argv, prefix, &pathspec, &list) < 0)
    + 	if (module_list_compute(argc, argv, prefix, &pathspec, &list) < 0)
     -		return 1;
    -+	if (module_list_compute(argc, argv, prefix, &pathspec, &list) < 0) {
    -+		ret = 1;
     +		goto cleanup;
    -+	}
      
      	for (i = 0; i < list.nr; i++)
      		absorb_git_dir_into_superproject(list.entries[i]->name, flags);
 5:  a4672aa9c94 =  7:  325aa1521e2 submodule--helper: "struct pathspec" memory leak in module_update()
 6:  7925db18b33 =  8:  424b24961b5 submodule--helper: don't leak {run,capture}_command() cp.dir argument
 7:  30883f3aa01 =  9:  abf5c4754a4 submodule--helper: add "const" to copy of "update_data"
 8:  b7582391c91 = 10:  6ab5aabae35 submodule--helper: add and use *_release() functions
 9:  92737916083 = 11:  feec1f20bf9 submodule--helper: refactor "errmsg_str" to be a "struct strbuf"
10:  c81a4f69179 = 12:  d368db73de7 submodule--helper: fix "errmsg_str" memory leak
11:  c25b55c9528 ! 13:  5be941b3d1b submodule--helper: fix "sm_path" and other "module_cb_list" leaks
    @@ builtin/submodule--helper.c: struct module_cb {
     +	char *sm_path;
      };
      #define MODULE_CB_INIT { 0 }
    + 
     +static void module_cb_release(struct module_cb *mcb)
     +{
     +	free(mcb->sm_path);
     +}
    - 
    ++
      struct module_cb_list {
      	struct module_cb **entries;
    -@@ builtin/submodule--helper.c: struct module_cb_list {
    + 	int alloc, nr;
      };
      #define MODULE_CB_LIST_INIT { 0 }
      
12:  303447bd4f5 = 14:  b8560e8c111 submodule--helper: fix a leak with repo_clear()
13:  f8ededcdf77 = 15:  abfd61f9f05 submodule--helper: fix a memory leak in get_default_remote_submodule()
14:  c7610088968 ! 16:  b8df96a9cf0 submodule--helper: fix "reference" leak is "module_clone_data"
    @@ Commit message
         Those commits added an xstrdup()'d member of the
         STRING_LIST_INIT_NODUP'd "struct string_list". We need to free()
         those, but not the ones we get from argv, let's make use of the "util"
    -    member, if it has a pointer it's the pointer we'll need to free.
    +    member, if it has a pointer it's the pointer we'll need to free,
    +    otherwise it'll be NULL (i.e. from argv).
     
         To fix this create a a module_clone_data_release() function to go with
         the MODULE_CLONE_DATA_INIT added in a98b02c1128 (submodule--helper:
    @@ builtin/submodule--helper.c: static int add_possible_reference_from_superproject
      			switch (sas->error_mode) {
     @@ builtin/submodule--helper.c: static int module_clone(int argc, const char **argv, const char *prefix)
      
    - 	clone_submodule(&clone_data);
    + 	clone_submodule(&clone_data, &clone_data.reference);
      	list_objects_filter_release(&filter_options);
     +	module_clone_data_release(&clone_data);
      	return 0;
    @@ builtin/submodule--helper.c: static int add_submodule(const struct add_data *add
      {
      	char *submod_gitdir_path;
      	struct module_clone_data clone_data = MODULE_CLONE_DATA_INIT;
    -+	int ret;
    ++	int ret = -1;
      
      	/* perhaps the path already exists and is already a git repo, else clone it */
      	if (is_directory(add_data->sm_path)) {
    @@ builtin/submodule--helper.c: static int add_submodule(const struct add_data *add
      		if (add_data->depth >= 0)
      			clone_data.depth = xstrfmt("%d", add_data->depth);
      
    --		if (clone_submodule(&clone_data))
    + 		if (clone_submodule(&clone_data, &clone_data.reference))
     -			return -1;
    -+		if (clone_submodule(&clone_data)) {
    -+			ret = -1;
     +			goto cleanup;
    -+		}
      
      		prepare_submodule_repo_env(&cp.env);
      		cp.git_cmd = 1;
15:  abd8e2eef3a ! 17:  7811bdbf149 submodule--helper: fix obscure leak in module_add()
    @@ builtin/submodule--helper.c: static int module_add(int argc, const char **argv,
      	struct add_data add_data = ADD_DATA_INIT;
      	char *to_free = NULL;
     +	struct strbuf sb = STRBUF_INIT;
    -+	int ret;
    ++	int ret = 1;
      
      	struct option options[] = {
      		OPT_STRING('b', "branch", &add_data.branch, N_("branch"),
    @@ builtin/submodule--helper.c: static int module_add(int argc, const char **argv,
      
      	if(!add_data.sm_name)
     @@ builtin/submodule--helper.c: static int module_add(int argc, const char **argv, const char *prefix)
    + 	add_data.progress = !!progress;
      	add_data.dissociate = !!dissociate;
      
    - 	if (add_submodule(&add_data)) {
    +-	if (add_submodule(&add_data)) {
     -		free(add_data.sm_path);
     -		return 1;
    -+		ret = 1;
    +-	}
    ++	if (add_submodule(&add_data))
     +		goto cleanup;
    - 	}
      	configure_added_submodule(&add_data);
     +
     +	ret = 0;
16:  1f01203d154 = 18:  01566d63926 submodule--helper: fix a leak in module_add()
17:  12b8a945486 = 19:  7ef89abed86 submodule--helper: fix a memory leak in print_status()
18:  fac2c4491f3 = 20:  b8d47fc7d70 submodule--helper: free some "displaypath" in "struct update_data"
19:  cf0c8851954 = 21:  4fb17f0dff1 submodule--helper: rename "int res" to "int ret"
20:  7882e33cdca ! 22:  af83925046b submodule--helper: add skeleton "goto cleanup" to update_submodule()
    @@ builtin/submodule--helper.c: static void update_data_to_args(struct update_data
      
      static int update_submodule(struct update_data *update_data)
      {
    -+	int ret;
    ++	int ret = 1;
     +
      	ensure_core_worktree(update_data->sm_path);
      
    @@ builtin/submodule--helper.c: static int update_submodule(struct update_data *upd
      	}
      
     -	if (!oideq(&update_data->oid, &update_data->suboid) || update_data->force)
    --		if (run_update_procedure(update_data))
    --			return 1;
     +	if (!oideq(&update_data->oid, &update_data->suboid) || update_data->force) {
    -+		ret = run_update_procedure(update_data);
    -+		if (ret) {
    -+			ret = 1;
    + 		if (run_update_procedure(update_data))
    +-			return 1;
     +			goto cleanup;
    -+		}
     +	}
      
      	if (update_data->recursive) {
21:  31395a2b4f8 ! 23:  4c60784d281 submodule--helper: don't exit() on failure, return
    @@ builtin/submodule--helper.c: static void update_data_to_args(struct update_data
     +static int update_submodule(struct update_data *update_data,
     +			    int *must_die_on_failure)
      {
    - 	int ret;
    + 	int ret = 1;
      
     @@ builtin/submodule--helper.c: static int update_submodule(struct update_data *update_data)
      	}
      
      	if (!oideq(&update_data->oid, &update_data->suboid) || update_data->force) {
    --		ret = run_update_procedure(update_data);
    --		if (ret) {
    +-		if (run_update_procedure(update_data))
     +		ret = run_update_procedure(update_data, must_die_on_failure);
     +		if (ret && *must_die_on_failure) {
     +			goto cleanup;
     +		} else if (ret) {
    - 			ret = 1;
    ++			ret = 1;
      			goto cleanup;
    - 		}
    ++		}
    + 	}
    + 
    + 	if (update_data->recursive) {
     @@ builtin/submodule--helper.c: static int update_submodule(struct update_data *update_data)
      		die_message(_("Failed to recurse into submodule path '%s'"),
      			    update_data->displaypath);
22:  a2168cf1378 ! 24:  7551af195ad submodule--helper: free rest of "displaypath" in "struct update_data"
    @@ builtin/submodule--helper.c
     @@ builtin/submodule--helper.c: static int update_submodule(struct update_data *update_data,
      			    int *must_die_on_failure)
      {
    - 	int ret;
    + 	int ret = 1;
     +	char *to_free, *restore = update_data->displaypath;
      
      	ensure_core_worktree(update_data->sm_path);
23:  d77c6665ca9 = 25:  f650716cd7e submodule--helper: fix bad config API usage
24:  531db4ddae6 = 26:  581ce0872c0 submodule--helper: fix a configure_added_submodule() leak
-- 
2.37.1.1095.g0bd6f54ba8a

