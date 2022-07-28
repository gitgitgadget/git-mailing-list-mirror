Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8781AC19F2B
	for <git@archiver.kernel.org>; Thu, 28 Jul 2022 16:30:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbiG1QaX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jul 2022 12:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbiG1QaV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jul 2022 12:30:21 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB26DD8
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 09:30:17 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id j7so2910546wrh.3
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 09:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=UCtcLTuxx/HLg8OaKNO8NKZJPibUXx8etZSPFwWv80A=;
        b=Q+6a7HR2p/0uGgMagnPFy+0toUnk43+GDog+T++9ifUADaqYOZTHCH5WzFmBseRnaQ
         UTt+eKPHYNyjE9Cpw84qnd1yGeBqtyaWXuXqHHRM0aHMigRY5/yCBMhLSFkOZt8Y9vuz
         gJcCot+tdQYAiajRIgH83KDWINMMcPOsJ1oTf/23VE0afreGN+GtzWDkWAngpY6tuIxn
         PYntu1z0IIIOeW4gm9N8JOS9aiT7AiCRHeqIqIGF/hKt7NqaIFZJqpxpTdpz3f+sM9j4
         RWBSWlQ68Yfn09pOb3MMhRLOwdMlMA30F/hmwonPcvCn4q8t3XmtvwVxP6gFiPoffZdr
         6APw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=UCtcLTuxx/HLg8OaKNO8NKZJPibUXx8etZSPFwWv80A=;
        b=n7B1jY/JeW1OpgzmJWnTw9ZNTTFGmOjHG55cQdLTMZhzWXDzt7SptlViZov/LripQN
         t4UivjaJdW6f8msNzq9bEwHMX4S8jKJ5z05D8eRFEoqQWWOk9fvMazVLGgo8yStQoOtX
         YPpENpy16N4F7fQYMA67ykL2S0CAP7+JSHw/pi7ZRty1lCcDMFKZxEryydEU9IpPKM0V
         AZIyyoF84K9GkbXPFXNW7e8z3dyc6CSrRygVDfRVVL0O+LWqT45iHM0CkXwMDV8PZLEC
         nRjIHUYUfMWuAvZHQflZIqR19Z6/kPa+1ML67sSOcOI3C2mw3gbBuBP3Z8aS0ZRttb3W
         rbHA==
X-Gm-Message-State: AJIora8DuFMv+HLT0iE/8XYWtIEFtgtVqFEQhQHfEvn0DBqLhzH3UHYa
        8XU6Zqc3CsjRRjI0069mRYczBOZmPQsitw==
X-Google-Smtp-Source: AGRyM1sxRo60tL2SHVTN+abQMV1cpxRCw0PaDF06TmRJoUNoNrfzMJnhzDgrC4PqXlP6MmR8PwXAcw==
X-Received: by 2002:a5d:5847:0:b0:21d:b75e:12d0 with SMTP id i7-20020a5d5847000000b0021db75e12d0mr17389139wrf.208.1659025815024;
        Thu, 28 Jul 2022 09:30:15 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c13-20020a5d528d000000b0021ef34124ebsm1492018wrv.11.2022.07.28.09.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 09:30:14 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 00/17] submodule--helper: (only) fix memory leaks
Date:   Thu, 28 Jul 2022 18:29:54 +0200
Message-Id: <cover-v4-00.17-00000000000-20220728T162442Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1197.g7ed548b7807
In-Reply-To: <cover-v3-00.26-00000000000-20220721T191249Z-avarab@gmail.com>
References: <cover-v3-00.26-00000000000-20220721T191249Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series fixes all of the memory leaks in
builtin/submodule--helper.c that our test suite spots, except for
those where the leak is downstream of cmd_submodule__helper() and
caused by code that's not in builtin/submodule--helper.c (e.g. leaks
in the object or config APIs, and in submodule.c).

For the v3 see [1]. The v3 was 26 patches, but this one's 17. The
reason for the reduction is that this is now based on a just-submitted
"prep" series[2].

The sum total is much larger now, but hopefully easier to digest, much
of the new "prep" series is either trivial patches (like whitespace
fixes), or deletion or moving (into test-tool) of code that this
"leak" series doesn't need to deal with anymore.

I think this should address all outstanding comments on the v3. In the
case of Glen's comment at [3] I dealt with my updating a commit
message in the "prep" series, see the last two paragraphs of [4] (also
shown in the range-diff of [2]).

1. https://lore.kernel.org/git/cover-v3-00.26-00000000000-20220721T191249Z-avarab@gmail.com/
2. https://lore.kernel.org/git/cover-00.20-00000000000-20220728T161116Z-avarab@gmail.com/
3. https://lore.kernel.org/git/kl6ltu74sq3b.fsf@chooglen-macbookpro.roam.corp.google.com/
4. https://lore.kernel.org/git/patch-19.20-5a26c9428be-20220728T161116Z-avarab@gmail.com/

Ævar Arnfjörð Bjarmason (17):
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
  submodule--helper: fix "reference" leak
  submodule--helper: fix obscure leak in module_add()
  submodule--helper: fix a leak in module_add()
  submodule--helper: fix a memory leak in print_status()
  submodule--helper: free some "displaypath" in "struct update_data"
  submodule--helper: free rest of "displaypath" in "struct update_data"
  submodule--helper: fix a configure_added_submodule() leak

 builtin/submodule--helper.c        | 218 +++++++++++++++++++++--------
 t/t1500-rev-parse.sh               |   1 +
 t/t2403-worktree-move.sh           |   1 +
 t/t6008-rev-list-submodule.sh      |   1 +
 t/t6134-pathspec-in-submodule.sh   |   1 +
 t/t7412-submodule-absorbgitdirs.sh |   1 +
 t/t7413-submodule-is-active.sh     |   1 +
 t/t7414-submodule-mistakes.sh      |   2 +
 t/t7506-status-submodule.sh        |   1 +
 t/t7507-commit-verbose.sh          |   2 +
 10 files changed, 171 insertions(+), 58 deletions(-)

Range-diff against v3:
 1:  3c7ae3e0222 <  -:  ----------- submodule--helper: replace memset() with { 0 }-initialization
 2:  32e4ae7ead5 <  -:  ----------- submodule--helper: stop conflating "sb" in clone_submodule()
 3:  eee6ca28c6f <  -:  ----------- submodule--helper: pass a "const struct module_clone_data" to clone_submodule()
 4:  26f0caf0386 !  1:  aac987a414a submodule--helper: fix a leak in "clone_submodule"
    @@ Commit message
         on absolute paths, 2016-03-31).
     
         For the "else" case we don't need to xstrdup() the "clone_data->path",
    -    and we don't need to free our own "clone_data_path".
    +    and we don't need to free our own "clone_data_path". We can therefore
    +    assign the "clone_data->path" to our own "clone_data_path" right away,
    +    and only override it (and remember to free it!) if we need to
    +    xstrfmt() a replacement.
     
         In the case of the module_clone() caller it's from "argv", and doesn't
         need to be free'd, and in the case of the add_submodule() caller we
    @@ Commit message
     
      ## builtin/submodule--helper.c ##
     @@ builtin/submodule--helper.c: static int clone_submodule(const struct module_clone_data *clone_data,
    + 	char *sm_gitdir = clone_submodule_sm_gitdir(clone_data->name);
      	char *sm_alternate = NULL, *error_strategy = NULL;
      	struct child_process cp = CHILD_PROCESS_INIT;
    - 	const char *clone_data_path;
    +-	const char *clone_data_path;
    ++	const char *clone_data_path = clone_data->path;
     +	char *to_free = NULL;
      
    - 	if (!is_absolute_path(clone_data->path)) {
    - 		struct strbuf sb = STRBUF_INIT;
    - 
    - 		strbuf_addf(&sb, "%s/%s", get_git_work_tree(), clone_data->path);
    --		clone_data_path = strbuf_detach(&sb, NULL);
    -+		clone_data_path = to_free = strbuf_detach(&sb, NULL);
    - 	} else {
    --		clone_data_path = xstrdup(clone_data_path);
    -+		clone_data_path = clone_data->path;
    - 	}
    + 	if (!is_absolute_path(clone_data->path))
    +-		clone_data_path = xstrfmt("%s/%s", get_git_work_tree(),
    +-					  clone_data->path);
    +-	else
    +-		clone_data_path = xstrdup(clone_data->path);
    ++		clone_data_path = to_free = xstrfmt("%s/%s", get_git_work_tree(),
    ++						    clone_data->path);
      
      	if (validate_submodule_git_dir(sm_gitdir, clone_data->name) < 0)
    + 		die(_("refusing to create/use '%s' in another submodule's "
     @@ builtin/submodule--helper.c: static int clone_submodule(const struct module_clone_data *clone_data,
      
      	free(sm_gitdir);
 5:  75775bf4f6c !  2:  390c5174e17 submodule--helper: fix trivial get_default_remote_submodule() leak
    @@ Commit message
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/submodule--helper.c ##
    -@@ builtin/submodule--helper.c: static int update_submodule(struct update_data *update_data)
    +@@ builtin/submodule--helper.c: static int update_submodule(struct update_data *update_data,
      		const char *branch = remote_submodule_branch(update_data->sm_path);
      		char *remote_ref = xstrfmt("refs/remotes/%s/%s", remote_name, branch);
      
 6:  7672ef1305f !  3:  529e10233d5 submodule--helper: fix most "struct pathspec" memory leaks
    @@ Commit message
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/submodule--helper.c ##
    -@@ builtin/submodule--helper.c: static char *get_up_path(const char *path)
    - static int module_list(int argc, const char **argv, const char *prefix)
    - {
    - 	int i;
    --	struct pathspec pathspec;
    -+	struct pathspec pathspec = { 0 };
    - 	struct module_list list = MODULE_LIST_INIT;
    - 
    - 	struct option module_list_options[] = {
    -@@ builtin/submodule--helper.c: static int module_list(int argc, const char **argv, const char *prefix)
    - 			   N_("alternative anchor for relative paths")),
    - 		OPT_END()
    - 	};
    -+	int ret = 1;
    - 
    - 	const char *const git_submodule_helper_usage[] = {
    - 		N_("git submodule--helper list [--prefix=<path>] [<path>...]"),
    -@@ builtin/submodule--helper.c: static int module_list(int argc, const char **argv, const char *prefix)
    - 			     git_submodule_helper_usage, 0);
    - 
    - 	if (module_list_compute(argc, argv, prefix, &pathspec, &list) < 0)
    --		return 1;
    -+		goto cleanup;
    - 
    - 	for (i = 0; i < list.nr; i++) {
    - 		const struct cache_entry *ce = list.entries[i];
    -@@ builtin/submodule--helper.c: static int module_list(int argc, const char **argv, const char *prefix)
    - 
    - 		fprintf(stdout, "%s\n", ce->name);
    - 	}
    --	return 0;
    -+	ret = 0;
    -+cleanup:
    -+	clear_pathspec(&pathspec);
    -+	return ret;
    - }
    - 
    - static void for_each_listed_submodule(const struct module_list *list,
     @@ builtin/submodule--helper.c: static void runcommand_in_submodule_cb(const struct cache_entry *list_item,
      static int module_foreach(int argc, const char **argv, const char *prefix)
      {
    @@ builtin/submodule--helper.c: static void runcommand_in_submodule_cb(const struct
     -	struct pathspec pathspec;
     +	struct pathspec pathspec = { 0 };
      	struct module_list list = MODULE_LIST_INIT;
    - 
      	struct option module_foreach_options[] = {
    + 		OPT__QUIET(&info.quiet, N_("suppress output of entering each submodule command")),
     @@ builtin/submodule--helper.c: static int module_foreach(int argc, const char **argv, const char *prefix)
      		N_("git submodule foreach [--quiet] [--recursive] [--] <command>"),
      		NULL
    @@ builtin/submodule--helper.c: static void init_submodule_cb(const struct cache_en
     +	struct pathspec pathspec = { 0 };
      	struct module_list list = MODULE_LIST_INIT;
      	int quiet = 0;
    - 
    + 	struct option module_init_options[] = {
     @@ builtin/submodule--helper.c: static int module_init(int argc, const char **argv, const char *prefix)
      		N_("git submodule init [<options>] [<path>]"),
      		NULL
    @@ builtin/submodule--helper.c: static void status_submodule_cb(const struct cache_
     +	struct pathspec pathspec = { 0 };
      	struct module_list list = MODULE_LIST_INIT;
      	int quiet = 0;
    - 
    + 	struct option module_status_options[] = {
     @@ builtin/submodule--helper.c: static int module_status(int argc, const char **argv, const char *prefix)
      		N_("git submodule status [--quiet] [--cached] [--recursive] [<path>...]"),
      		NULL
    @@ builtin/submodule--helper.c: static int module_status(int argc, const char **arg
     +	return ret;
      }
      
    - static int module_name(int argc, const char **argv, const char *prefix)
    + struct module_cb {
     @@ builtin/submodule--helper.c: static void sync_submodule_cb(const struct cache_entry *list_item, void *cb_data
      static int module_sync(int argc, const char **argv, const char *prefix)
      {
    @@ builtin/submodule--helper.c: static void sync_submodule_cb(const struct cache_en
      	struct module_list list = MODULE_LIST_INIT;
      	int quiet = 0;
      	int recursive = 0;
    +@@ builtin/submodule--helper.c: static int module_sync(int argc, const char **argv, const char *prefix)
    + 		N_("git submodule sync [--quiet] [--recursive] [<path>]"),
    + 		NULL
    + 	};
     +	int ret = 1;
      
    - 	struct option module_sync_options[] = {
    - 		OPT__QUIET(&quiet, N_("suppress output of synchronizing submodule url")),
    -@@ builtin/submodule--helper.c: static int module_sync(int argc, const char **argv, const char *prefix)
    + 	argc = parse_options(argc, argv, prefix, module_sync_options,
      			     git_submodule_helper_usage, 0);
      
      	if (module_list_compute(argc, argv, prefix, &pathspec, &list) < 0)
    @@ builtin/submodule--helper.c: static int push_check(int argc, const char **argv,
     +	struct pathspec pathspec = { 0 };
      	struct module_list list = MODULE_LIST_INIT;
      	unsigned flags = ABSORB_GITDIR_RECURSE_SUBMODULES;
    -+	int ret = 1;
    - 
      	struct option embed_gitdir_options[] = {
    - 		OPT_STRING(0, "prefix", &prefix,
     @@ builtin/submodule--helper.c: static int absorb_git_dirs(int argc, const char **argv, const char *prefix)
    + 		N_("git submodule absorbgitdirs [<options>] [<path>...]"),
    + 		NULL
    + 	};
    ++	int ret = 1;
    + 
    + 	argc = parse_options(argc, argv, prefix, embed_gitdir_options,
      			     git_submodule_helper_usage, 0);
      
      	if (module_list_compute(argc, argv, prefix, &pathspec, &list) < 0)
    @@ builtin/submodule--helper.c: static int absorb_git_dirs(int argc, const char **a
     +	return ret;
      }
      
    - static int is_active(int argc, const char **argv, const char *prefix)
    + static int module_config(int argc, const char **argv, const char *prefix)
 7:  325aa1521e2 =  4:  683d327752f submodule--helper: "struct pathspec" memory leak in module_update()
 8:  424b24961b5 !  5:  4e8e9197539 submodule--helper: don't leak {run,capture}_command() cp.dir argument
    @@ builtin/submodule--helper.c: static int fetch_in_submodule(const char *module_pa
      
      	strvec_push(&cp.args, "fetch");
      	if (quiet)
    -@@ builtin/submodule--helper.c: static int run_update_command(struct update_data *ud, int subforce)
    +@@ builtin/submodule--helper.c: static int run_update_command(struct update_data *ud, int subforce,
      	}
      	strvec_push(&cp.args, oid);
      
 9:  abf5c4754a4 <  -:  ----------- submodule--helper: add "const" to copy of "update_data"
10:  6ab5aabae35 !  6:  575d3e8d2e2 submodule--helper: add and use *_release() functions
    @@ builtin/submodule--helper.c: static void module_list_active(struct module_list *
      	*list = active_modules;
      }
      
    -@@ builtin/submodule--helper.c: static int module_list(int argc, const char **argv, const char *prefix)
    - 	}
    - 	ret = 0;
    - cleanup:
    -+	module_list_release(&list);
    - 	clear_pathspec(&pathspec);
    - 	return ret;
    - }
     @@ builtin/submodule--helper.c: static int module_foreach(int argc, const char **argv, const char *prefix)
      
      	ret = 0;
11:  feec1f20bf9 <  -:  ----------- submodule--helper: refactor "errmsg_str" to be a "struct strbuf"
12:  d368db73de7 =  7:  d4c81e04254 submodule--helper: fix "errmsg_str" memory leak
13:  5be941b3d1b =  8:  ef9e29d5bfe submodule--helper: fix "sm_path" and other "module_cb_list" leaks
14:  b8560e8c111 =  9:  0798a00c9ef submodule--helper: fix a leak with repo_clear()
15:  abfd61f9f05 = 10:  dae2a6f8e07 submodule--helper: fix a memory leak in get_default_remote_submodule()
16:  b8df96a9cf0 ! 11:  e7352bb8cfa submodule--helper: fix "reference" leak is "module_clone_data"
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    submodule--helper: fix "reference" leak is "module_clone_data"
    +    submodule--helper: fix "reference" leak
     
    -    Fix leaks in the "reference" member of "struct module_clone_data" that
    -    have been with us since 31224cbdc72 (clone: recursive and reference
    -    option triggers submodule alternates, 2016-08-17) and
    -    8c8195e9c3e (submodule--helper: introduce add-clone subcommand,
    -    2021-07-10).
    +    Fix leaks in the "reference" variable declared in add_submodule() and
    +    module_clone().
    +
    +    In preceding commits this variable was refactored out of the "struct
    +    module_clone_data", but the leak has been with us since
    +    31224cbdc72 (clone: recursive and reference option triggers submodule
    +    alternates, 2016-08-17) and 8c8195e9c3e (submodule--helper: introduce
    +    add-clone subcommand, 2021-07-10).
     
         Those commits added an xstrdup()'d member of the
         STRING_LIST_INIT_NODUP'd "struct string_list". We need to free()
    @@ Commit message
         member, if it has a pointer it's the pointer we'll need to free,
         otherwise it'll be NULL (i.e. from argv).
     
    -    To fix this create a a module_clone_data_release() function to go with
    -    the MODULE_CLONE_DATA_INIT added in a98b02c1128 (submodule--helper:
    -    refactor module_clone(), 2021-07-10). We only need to add it to
    -    add_submodule() to fix the leak, but let's add it to module_clone() as
    -    well for consistency.
    +    Note that the free() of the "util" member is needed in both
    +    module_clone() and add_submodule(). The module_clone() function itself
    +    doesn't populate the "util" pointer as add_submodule() does, but
    +    module_clone() is upstream of the
    +    add_possible_reference_from_superproject() caller we're modifying
    +    here, which does do that.
    +
    +    This does preclude the use of the "util" pointer for any other reasons
    +    for now, but that's OK. If we ever need to use it for something else
    +    we could turn it into a small "struct" with an optional "to_free"
    +    member, and switch to using string_list_clear_func().
    +
    +    Alternatively we could have another "struct string_list to_free" which
    +    would keep a copy of the strings we've dup'd to free(). But for now
    +    this is perfectly adequate.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/submodule--helper.c ##
    -@@ builtin/submodule--helper.c: struct module_clone_data {
    - 	.single_branch = -1, \
    - }
    - 
    -+static void module_clone_data_release(struct module_clone_data *cd)
    -+{
    -+	string_list_clear(&cd->reference, 1);
    -+}
    -+
    - struct submodule_alternate_setup {
    - 	const char *submodule_name;
    - 	enum SUBMODULE_ALTERNATE_ERROR_MODE {
     @@ builtin/submodule--helper.c: static int add_possible_reference_from_superproject(
      
      		sm_alternate = compute_alternate_path(sb.buf, &err);
    @@ builtin/submodule--helper.c: static int add_possible_reference_from_superproject
      			switch (sas->error_mode) {
     @@ builtin/submodule--helper.c: static int module_clone(int argc, const char **argv, const char *prefix)
      
    - 	clone_submodule(&clone_data, &clone_data.reference);
    + 	clone_submodule(&clone_data, &reference);
      	list_objects_filter_release(&filter_options);
    -+	module_clone_data_release(&clone_data);
    ++	string_list_clear(&reference, 1);
      	return 0;
      }
      
     @@ builtin/submodule--helper.c: static int add_submodule(const struct add_data *add_data)
    - {
      	char *submod_gitdir_path;
      	struct module_clone_data clone_data = MODULE_CLONE_DATA_INIT;
    + 	struct string_list reference = STRING_LIST_INIT_NODUP;
     +	int ret = -1;
      
      	/* perhaps the path already exists and is already a git repo, else clone it */
    @@ builtin/submodule--helper.c: static int add_submodule(const struct add_data *add
      		clone_data.quiet = add_data->quiet;
      		clone_data.progress = add_data->progress;
     -		if (add_data->reference_path)
    --			string_list_append(&clone_data.reference,
    +-			string_list_append(&reference,
     -					   xstrdup(add_data->reference_path));
     +		if (add_data->reference_path) {
     +			char *p = xstrdup(add_data->reference_path);
     +
    -+			string_list_append(&clone_data.reference, p)->util = p;
    ++			string_list_append(&reference, p)->util = p;
     +		}
      		clone_data.dissociate = add_data->dissociate;
      		if (add_data->depth >= 0)
      			clone_data.depth = xstrfmt("%d", add_data->depth);
      
    - 		if (clone_submodule(&clone_data, &clone_data.reference))
    + 		if (clone_submodule(&clone_data, &reference))
     -			return -1;
     +			goto cleanup;
      
    @@ builtin/submodule--helper.c: static int add_submodule(const struct add_data *add
     -	return 0;
     +	ret = 0;
     +cleanup:
    -+	module_clone_data_release(&clone_data);
    ++	string_list_clear(&reference, 1);
     +	return ret;
      }
      
17:  7811bdbf149 ! 12:  1adb7b66656 submodule--helper: fix obscure leak in module_add()
    @@ Metadata
      ## Commit message ##
         submodule--helper: fix obscure leak in module_add()
     
    -    Fix an obscure leak in module_add()< if the "git add" command we were
    +    Fix an obscure leak in module_add(), if the "git add" command we were
         piping to failed we'd fail to strbuf_release(&sb). This fixes a leak
         introduced in a6226fd772b (submodule--helper: convert the bulk of
         cmd_add() to C, 2021-08-10).
    @@ Commit message
     
      ## builtin/submodule--helper.c ##
     @@ builtin/submodule--helper.c: static int module_add(int argc, const char **argv, const char *prefix)
    - 	int force = 0, quiet = 0, progress = 0, dissociate = 0;
    - 	struct add_data add_data = ADD_DATA_INIT;
    - 	char *to_free = NULL;
    + 		N_("git submodule add [<options>] [--] <repository> [<path>]"),
    + 		NULL
    + 	};
     +	struct strbuf sb = STRBUF_INIT;
     +	int ret = 1;
      
    - 	struct option options[] = {
    - 		OPT_STRING('b', "branch", &add_data.branch, N_("branch"),
    + 	argc = parse_options(argc, argv, prefix, options, usage, 0);
    + 
     @@ builtin/submodule--helper.c: static int module_add(int argc, const char **argv, const char *prefix)
      	die_on_repo_without_commits(add_data.sm_path);
      
    @@ builtin/submodule--helper.c: static int module_add(int argc, const char **argv,
     -		int exit_code = -1;
     -		struct strbuf sb = STRBUF_INIT;
      		struct child_process cp = CHILD_PROCESS_INIT;
    + 
      		cp.git_cmd = 1;
      		cp.no_stdout = 1;
      		strvec_pushl(&cp.args, "add", "--dry-run", "--ignore-missing",
18:  01566d63926 ! 13:  b27b665d287 submodule--helper: fix a leak in module_add()
    @@ builtin/submodule--helper.c: static int module_add(int argc, const char **argv,
     -		add_data.sm_path = xstrfmt("%s%s", prefix, add_data.sm_path);
     +	if (prefix && *prefix && !is_absolute_path(add_data.sm_path)) {
     +		char *sm_path = add_data.sm_path;
    ++
     +		add_data.sm_path = xstrfmt("%s%s", prefix, sm_path);
     +		free(sm_path);
     +	}
19:  7ef89abed86 = 14:  53ba1705eb6 submodule--helper: fix a memory leak in print_status()
20:  b8d47fc7d70 = 15:  230e5f8ad14 submodule--helper: free some "displaypath" in "struct update_data"
21:  4fb17f0dff1 <  -:  ----------- submodule--helper: rename "int res" to "int ret"
22:  af83925046b <  -:  ----------- submodule--helper: add skeleton "goto cleanup" to update_submodule()
23:  4c60784d281 <  -:  ----------- submodule--helper: don't exit() on failure, return
24:  7551af195ad = 16:  c0fba2f1c56 submodule--helper: free rest of "displaypath" in "struct update_data"
25:  f650716cd7e <  -:  ----------- submodule--helper: fix bad config API usage
26:  581ce0872c0 ! 17:  95f8b68bd41 submodule--helper: fix a configure_added_submodule() leak
    @@ builtin/submodule--helper.c: static void configure_added_submodule(struct add_da
      		 * current configured pathspec, set the submodule's active flag
     
      ## t/t7413-submodule-is-active.sh ##
    -@@ t/t7413-submodule-is-active.sh: This test verifies that `git submodue--helper is-active` correctly identifies
    +@@ t/t7413-submodule-is-active.sh: This test verifies that `test-tool submodule is-active` correctly identifies
      submodules which are "active" and interesting to the user.
      '
      
-- 
2.37.1.1197.g7ed548b7807

