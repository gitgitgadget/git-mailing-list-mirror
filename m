Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1CB9C19F29
	for <git@archiver.kernel.org>; Thu, 28 Jul 2022 16:17:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232179AbiG1QRb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jul 2022 12:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232925AbiG1QRQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jul 2022 12:17:16 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78CAD6FA26
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 09:17:12 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id a11so1235749wmq.3
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 09:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=sNkzO2Au7RcrNv2axEq2vU3BjeuGPx/F/gPXu8RYrGg=;
        b=cGGYaGnF7l6wpIrkQ92vtOF31Tua6DVt7brepOpU74qHkNfadE1396z8jUiv4ibzya
         Aybns6K/+lCl5Vw6hAGLM+Ya+63yCICRJhVllB9AFOeJ+7T0V9OvDkTRe1nqDEBecyll
         5mqPpHWEm9gRRa3jNhKT+x21sqyXOGyDv87bVVDCJvNtbWqWue74/YD6TE29u73t3eBG
         dJ7AdnEllCmmexVCm09E2JTMgtxu0o/VvIhCDoBZaxy4ysqZj6VRM2Qj1Vu5Mmf3VASU
         QyoGk1zmg+A7NqFRKvYGq4SF+7VEQSUZ0aaSvMkhtauaT+QyJpKGFCoU52A97kJ+K68U
         r8bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=sNkzO2Au7RcrNv2axEq2vU3BjeuGPx/F/gPXu8RYrGg=;
        b=kLDRTC+seVr4e3JMr5lkmiFGV/IgGjTUQYW/s1vhG6xnYYJIot9ddq6fNRQRhgFTK9
         tx2yO0uLe0IIeZcSSKvvkAY+odExFKDN8VQ32qeMaON/J0V26lwoIK2g8K6L6ArdvWql
         m/j1IHnTBuLvpd2z74PrUx/M6mb5ON8mhduHewwbID/K7DwUxQqOowhxitGq6IqiTsM2
         Tk9dRQCR8fSMzn+4ubvAnqQqLus52V12RygsC+b8uyYWBzoaKMhReiKGUuKS6vdTSV4t
         IZ3fMQDQNQMBvJaIbKhPm73TFF9zMg0Hrl6bVvWExKNcyFpZ42/gP9cY4ZnciTFAK/Jd
         P9lg==
X-Gm-Message-State: AJIora9cEKg4XyRiqFQYELyLVU9iqdckAJSNXlAzM7Z75SpemxLQSc/K
        Izgkj3gIGJrJzFQoVctkw6KFngmM+CCaAw==
X-Google-Smtp-Source: AGRyM1vXe2FGy+sqfeCq7I2xTOU16bb/qKWwXlsU2CNrcRhf3G7xyLL9iwL+gjRdYmJiy4k25rBFGA==
X-Received: by 2002:a05:600c:a07:b0:39e:da6e:fc49 with SMTP id z7-20020a05600c0a0700b0039eda6efc49mr90373wmp.143.1659025029681;
        Thu, 28 Jul 2022 09:17:09 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w13-20020adfee4d000000b0021f0af83142sm1220117wro.91.2022.07.28.09.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 09:17:08 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 00/20] submodule--helper: add tests, rm dead code, refactor & leak prep
Date:   Thu, 28 Jul 2022 18:16:45 +0200
Message-Id: <cover-00.20-00000000000-20220728T161116Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1167.g38fda70d8c4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This new series based on "master" splits out the non-leak fixes from
v3 of the submodule leaks series [1]. Sorry about the churn, but with
e.g. the thread at [2] the "leaks" series was accumulating a lot of
non-leaks related fixes, just so that we could get to the point of
fixing various leaks.

The immediate reason I split this off was because of the new
"remove..helper" and "test-tool" patches here. I.e. some things that
the leaks series was changing was test-only code, or code that was
simply unused (or we had no business using anymore).

The [1] series will then be re-rolled on top of this series, which
will hopefully make it a lot easier to digest, as it'll now *just*
focus on leak fixes.

A passing CI run for this can be found at [3].

1. https://lore.kernel.org/git/cover-v3-00.26-00000000000-20220721T191249Z-avarab@gmail.com/
2. https://lore.kernel.org/git/220722.86y1wlqmqr.gmgdl@evledraar.gmail.com/
3. https://github.com/avar/git/tree/avar/submodule--helper-cleanup-and-tests

Glen Choo (2):
  submodule--helper: add "const" to copy of "update_data"
  submodule--helper: refactor "errmsg_str" to be a "struct strbuf"

Ævar Arnfjörð Bjarmason (18):
  submodule tests: test usage behavior
  submodule tests: test for "add <repository> <abs-path>"
  submodule--helper: remove unused "name" helper
  submodule--helper: remove unused "list" helper
  test-tool submodule-config: remove unused "--url" handling
  submodule--helper: move "is-active" to a test-tool
  submodule--helper: move "check-name" to a test-tool
  submodule--helper: move "resolve-relative-url-test" to a test-tool
  submodule--helper style: don't separate declared variables with \n\n
  submodule--helper style: add \n\n after variable declarations
  submodule--helper: replace memset() with { 0 }-initialization
  submodule--helper: convert a strbuf_detach() to xstrfmt()
  submodule--helper: stop conflating "sb" in clone_submodule()
  submodule--helper: pass a "const struct module_clone_data" to
    clone_submodule()
  submodule--helper: rename "int res" to "int ret"
  submodule--helper: add skeleton "goto cleanup" to update_submodule()
  submodule--helper: don't exit() on failure, return
  submodule--helper: fix bad config API usage

 Makefile                         |   1 +
 builtin/submodule--helper.c      | 338 ++++++++++++-------------------
 t/helper/test-submodule-config.c |  11 +-
 t/helper/test-submodule.c        | 146 +++++++++++++
 t/helper/test-tool-utils.h       |   9 +
 t/helper/test-tool.c             |   7 +-
 t/helper/test-tool.h             |   1 +
 t/t0060-path-utils.sh            |   2 +-
 t/t7400-submodule-basic.sh       |  56 ++---
 t/t7413-submodule-is-active.sh   |  32 +--
 t/t7450-bad-git-dotfiles.sh      |   2 +-
 11 files changed, 335 insertions(+), 270 deletions(-)
 create mode 100644 t/helper/test-submodule.c
 create mode 100644 t/helper/test-tool-utils.h

Range-diff:
 -:  ----------- >  1:  84b05bda016 submodule tests: test usage behavior
 -:  ----------- >  2:  9671169e348 submodule tests: test for "add <repository> <abs-path>"
 -:  ----------- >  3:  7aa9c14251b submodule--helper: remove unused "name" helper
 -:  ----------- >  4:  27df2efe718 submodule--helper: remove unused "list" helper
 -:  ----------- >  5:  9fe8deb165a test-tool submodule-config: remove unused "--url" handling
 -:  ----------- >  6:  8e4d2b09d56 submodule--helper: move "is-active" to a test-tool
 -:  ----------- >  7:  a2f3d812815 submodule--helper: move "check-name" to a test-tool
 -:  ----------- >  8:  8188657cdfa submodule--helper: move "resolve-relative-url-test" to a test-tool
 -:  ----------- >  9:  79a47f9b94d submodule--helper style: don't separate declared variables with \n\n
 -:  ----------- > 10:  5e13080f894 submodule--helper style: add \n\n after variable declarations
 1:  3c7ae3e0222 ! 11:  dc5ac924496 submodule--helper: replace memset() with { 0 }-initialization
    @@ builtin/submodule--helper.c: static int module_clone(int argc, const char **argv
      	struct module_clone_data clone_data = MODULE_CLONE_DATA_INIT;
     -	struct list_objects_filter_options filter_options;
     +	struct list_objects_filter_options filter_options = { 0 };
    - 
      	struct option module_clone_options[] = {
      		OPT_STRING(0, "prefix", &clone_data.prefix,
    + 			   N_("path"),
     @@ builtin/submodule--helper.c: static int module_clone(int argc, const char **argv, const char *prefix)
      		NULL
      	};
    @@ builtin/submodule--helper.c: static int module_update(int argc, const char **arg
     -	struct list_objects_filter_options filter_options;
     +	struct list_objects_filter_options filter_options = { 0 };
      	int ret;
    - 
      	struct option module_update_options[] = {
    + 		OPT__FORCE(&opt.force, N_("force checkout updates"), 0),
     @@ builtin/submodule--helper.c: static int module_update(int argc, const char **argv, const char *prefix)
      	update_clone_config_from_gitmodules(&opt.max_jobs);
      	git_config(git_update_clone_config, &opt.max_jobs);
 -:  ----------- > 12:  08cc9ce2e24 submodule--helper: convert a strbuf_detach() to xstrfmt()
 2:  32e4ae7ead5 ! 13:  afe34d8b73b submodule--helper: stop conflating "sb" in clone_submodule()
    @@ Metadata
      ## Commit message ##
         submodule--helper: stop conflating "sb" in clone_submodule()
     
    -    Refactor the three uses of a "struct strbuf sb" such that each of them
    +    Refactor the two uses of a "struct strbuf sb" such that each of them
         exists in its own scope. This makes the control flow clearer.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
    @@ builtin/submodule--helper.c: static void prepare_possible_alternates(const char
     +	char *sm_alternate = NULL, *error_strategy = NULL;
     +	struct child_process cp = CHILD_PROCESS_INIT;
      
    - 	if (!is_absolute_path(clone_data->path)) {
    -+		struct strbuf sb = STRBUF_INIT;
    -+
    - 		strbuf_addf(&sb, "%s/%s", get_git_work_tree(), clone_data->path);
    - 		clone_data->path = strbuf_detach(&sb, NULL);
    - 	} else {
    + 	if (!is_absolute_path(clone_data->path))
    + 		clone_data->path = xstrfmt("%s/%s", get_git_work_tree(),
     @@ builtin/submodule--helper.c: static int clone_submodule(struct module_clone_data *clone_data)
      			die(_("clone of '%s' into submodule path '%s' failed"),
      			    clone_data->url, clone_data->path);
 3:  eee6ca28c6f ! 14:  b364f3200d8 submodule--helper: pass a "const struct module_clone_data" to clone_submodule()
    @@ Commit message
         clobbering the "clone_data->path".
     
         We still need to add to the "reference" member, which is a "struct
    -    string_list". We could do this by having clone_submodule() create its
    -    own, and copy the contents over, but let's instead pass it as a
    -    separate parameter. The main point of doing this is to make it clear
    -    that e.g. "clone_data->path" always comes from the "argv", there's no
    -    ambiguity about whether we can eventually free() the "struct
    -    string_list".
    +    string_list". Let's do this by having clone_submodule() create its
    +    own, and copy the contents over, allowing us to pass it as a
    +    separate parameter.
    +
    +    This new "struct string_list" still leaks memory, just as the "struct
    +    module_clone_data" did before. let's not fix that for now, to fix that
    +    we'll need to add some "goto cleanup" to the relevant code. That will
    +    be done in a follow-up commits, at that point it'll be easier to fix
    +    the memory leak.
    +
    +    The scope of the new "reference" variable in add_submodule() could be
    +    narrowed to the "else" block, but as we'll eventually free it with a
    +    "goto cleanup" let's declare it at the start of the function.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/submodule--helper.c ##
    +@@ builtin/submodule--helper.c: struct module_clone_data {
    + 	const char *url;
    + 	const char *depth;
    + 	struct list_objects_filter_options *filter_options;
    +-	struct string_list reference;
    + 	unsigned int quiet: 1;
    + 	unsigned int progress: 1;
    + 	unsigned int dissociate: 1;
    +@@ builtin/submodule--helper.c: struct module_clone_data {
    + 	int single_branch;
    + };
    + #define MODULE_CLONE_DATA_INIT { \
    +-	.reference = STRING_LIST_INIT_NODUP, \
    + 	.single_branch = -1, \
    + }
    + 
     @@ builtin/submodule--helper.c: static char *clone_submodule_sm_gitdir(const char *name)
      	return sm_gitdir;
      }
    @@ builtin/submodule--helper.c: static char *clone_submodule_sm_gitdir(const char *
      	struct child_process cp = CHILD_PROCESS_INIT;
     +	const char *clone_data_path;
      
    - 	if (!is_absolute_path(clone_data->path)) {
    - 		struct strbuf sb = STRBUF_INIT;
    - 
    - 		strbuf_addf(&sb, "%s/%s", get_git_work_tree(), clone_data->path);
    --		clone_data->path = strbuf_detach(&sb, NULL);
    -+		clone_data_path = strbuf_detach(&sb, NULL);
    - 	} else {
    + 	if (!is_absolute_path(clone_data->path))
    +-		clone_data->path = xstrfmt("%s/%s", get_git_work_tree(),
    +-					   clone_data->path);
    ++		clone_data_path = xstrfmt("%s/%s", get_git_work_tree(),
    ++					  clone_data->path);
    + 	else
     -		clone_data->path = xstrdup(clone_data->path);
    -+		clone_data_path = xstrdup(clone_data_path);
    - 	}
    ++		clone_data_path = xstrdup(clone_data->path);
      
      	if (validate_submodule_git_dir(sm_gitdir, clone_data->name) < 0)
    + 		die(_("refusing to create/use '%s' in another submodule's "
     @@ builtin/submodule--helper.c: static int clone_submodule(struct module_clone_data *clone_data)
      		if (safe_create_leading_directories_const(sm_gitdir) < 0)
      			die(_("could not create directory '%s'"), sm_gitdir);
    @@ builtin/submodule--helper.c: static int clone_submodule(struct module_clone_data
     -		if (clone_data->reference.nr) {
     +		if (reference->nr) {
      			struct string_list_item *item;
    + 
     -			for_each_string_list_item(item, &clone_data->reference)
     +			for_each_string_list_item(item, reference)
      				strvec_pushl(&cp.args, "--reference",
    @@ builtin/submodule--helper.c: static int clone_submodule(struct module_clone_data
      
      	/* setup alternateLocation and alternateErrorStrategy in the cloned submodule if needed */
      	git_config_get_string("submodule.alternateLocation", &sm_alternate);
    +@@ builtin/submodule--helper.c: static int module_clone(int argc, const char **argv, const char *prefix)
    + 	int dissociate = 0, quiet = 0, progress = 0, require_init = 0;
    + 	struct module_clone_data clone_data = MODULE_CLONE_DATA_INIT;
    + 	struct list_objects_filter_options filter_options = { 0 };
    ++	struct string_list reference = STRING_LIST_INIT_NODUP;
    + 	struct option module_clone_options[] = {
    + 		OPT_STRING(0, "prefix", &clone_data.prefix,
    + 			   N_("path"),
    +@@ builtin/submodule--helper.c: static int module_clone(int argc, const char **argv, const char *prefix)
    + 		OPT_STRING(0, "url", &clone_data.url,
    + 			   N_("string"),
    + 			   N_("url where to clone the submodule from")),
    +-		OPT_STRING_LIST(0, "reference", &clone_data.reference,
    ++		OPT_STRING_LIST(0, "reference", &reference,
    + 			   N_("repo"),
    + 			   N_("reference repository")),
    + 		OPT_BOOL(0, "dissociate", &dissociate,
     @@ builtin/submodule--helper.c: static int module_clone(int argc, const char **argv, const char *prefix)
      		usage_with_options(git_submodule_helper_usage,
      				   module_clone_options);
      
     -	clone_submodule(&clone_data);
    -+	clone_submodule(&clone_data, &clone_data.reference);
    ++	clone_submodule(&clone_data, &reference);
      	list_objects_filter_release(&filter_options);
      	return 0;
      }
     @@ builtin/submodule--helper.c: static int add_submodule(const struct add_data *add_data)
    + {
    + 	char *submod_gitdir_path;
    + 	struct module_clone_data clone_data = MODULE_CLONE_DATA_INIT;
    ++	struct string_list reference = STRING_LIST_INIT_NODUP;
    + 
    + 	/* perhaps the path already exists and is already a git repo, else clone it */
    + 	if (is_directory(add_data->sm_path)) {
    +@@ builtin/submodule--helper.c: static int add_submodule(const struct add_data *add_data)
    + 		free(submod_gitdir_path);
    + 	} else {
    + 		struct child_process cp = CHILD_PROCESS_INIT;
    ++
    + 		submod_gitdir_path = xstrfmt(".git/modules/%s", add_data->sm_name);
    + 
    + 		if (is_directory(submod_gitdir_path)) {
    +@@ builtin/submodule--helper.c: static int add_submodule(const struct add_data *add_data)
    + 		clone_data.quiet = add_data->quiet;
    + 		clone_data.progress = add_data->progress;
    + 		if (add_data->reference_path)
    +-			string_list_append(&clone_data.reference,
    ++			string_list_append(&reference,
    + 					   xstrdup(add_data->reference_path));
    + 		clone_data.dissociate = add_data->dissociate;
      		if (add_data->depth >= 0)
      			clone_data.depth = xstrfmt("%d", add_data->depth);
      
     -		if (clone_submodule(&clone_data))
    -+		if (clone_submodule(&clone_data, &clone_data.reference))
    ++		if (clone_submodule(&clone_data, &reference))
      			return -1;
      
      		prepare_submodule_repo_env(&cp.env);
 4:  26f0caf0386 <  -:  ----------- submodule--helper: fix a leak in "clone_submodule"
 5:  75775bf4f6c <  -:  ----------- submodule--helper: fix trivial get_default_remote_submodule() leak
 6:  7672ef1305f <  -:  ----------- submodule--helper: fix most "struct pathspec" memory leaks
 7:  325aa1521e2 <  -:  ----------- submodule--helper: "struct pathspec" memory leak in module_update()
 8:  424b24961b5 <  -:  ----------- submodule--helper: don't leak {run,capture}_command() cp.dir argument
 9:  abf5c4754a4 = 15:  e319f4edc54 submodule--helper: add "const" to copy of "update_data"
10:  6ab5aabae35 <  -:  ----------- submodule--helper: add and use *_release() functions
11:  feec1f20bf9 = 16:  68202100d9a submodule--helper: refactor "errmsg_str" to be a "struct strbuf"
12:  d368db73de7 <  -:  ----------- submodule--helper: fix "errmsg_str" memory leak
13:  5be941b3d1b <  -:  ----------- submodule--helper: fix "sm_path" and other "module_cb_list" leaks
14:  b8560e8c111 <  -:  ----------- submodule--helper: fix a leak with repo_clear()
15:  abfd61f9f05 <  -:  ----------- submodule--helper: fix a memory leak in get_default_remote_submodule()
16:  b8df96a9cf0 <  -:  ----------- submodule--helper: fix "reference" leak is "module_clone_data"
17:  7811bdbf149 <  -:  ----------- submodule--helper: fix obscure leak in module_add()
18:  01566d63926 <  -:  ----------- submodule--helper: fix a leak in module_add()
19:  7ef89abed86 <  -:  ----------- submodule--helper: fix a memory leak in print_status()
20:  b8d47fc7d70 <  -:  ----------- submodule--helper: free some "displaypath" in "struct update_data"
21:  4fb17f0dff1 ! 17:  e8aacb55a18 submodule--helper: rename "int res" to "int ret"
    @@ Commit message
     
         Rename the "res" variable added in b3c5f5cb048 (submodule: move core
         cmd_update() logic to C, 2022-03-15) to "ret", which is the convention
    -    in the rest of this file. Subsequent commits will change this code to
    -    a "goto cleanup" pattern, let's have the post image look consistent
    -    with the rest.
    +    in the rest of this file.
    +
    +    Eventual follow-up commits will change this code to a "goto cleanup"
    +    pattern, let's have the post image look consistent with the rest.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
22:  af83925046b ! 18:  41fb22d8549 submodule--helper: add skeleton "goto cleanup" to update_submodule()
    @@ Commit message
         submodule--helper: add skeleton "goto cleanup" to update_submodule()
     
         Add a skeleton "goto cleanup" pattern to update_submodule(), rather
    -    than having branches in it "return". This is in preparation for doing
    -    something useful with the "cleanup" label, but for now we're using it
    -    as the equivalent of a "done" label.
    +    than having branches in it "return". This is in preparation for
    +    eventually freeing data with the "cleanup" label, but for now we're
    +    using it as the equivalent of a "done" label.
     
         The "exit()" branch is not handled yet, and neither is the exit() that
         run_update_procedure() might invoke. That'll be handled in a
23:  4c60784d281 ! 19:  5a26c9428be submodule--helper: don't exit() on failure, return
    @@ Commit message
         to the point where we could avoid calling exit() here.
     
         This introduces no functional changes, but makes it easier to both
    -    call these routines as a library in the future, and to avoid leaking
    -    memory.
    +    call these routines as a library in the future, and to eventually
    +    avoid leaking memory.
    +
    +    This and similar control flow in submodule--helper.c could be made
    +    simpler by properly "libifying" it, i.e. to have it consistently
    +    return -1 on failures, and to early return on any non-success.
    +
    +    But let's leave that larger project for now, and (mostly) emulate what
    +    were doing with the "exit(128)" before this change.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
24:  7551af195ad <  -:  ----------- submodule--helper: free rest of "displaypath" in "struct update_data"
25:  f650716cd7e = 20:  579560cb9a8 submodule--helper: fix bad config API usage
26:  581ce0872c0 <  -:  ----------- submodule--helper: fix a configure_added_submodule() leak
-- 
2.37.1.1167.g38fda70d8c4

