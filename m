Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91235C433EF
	for <git@archiver.kernel.org>; Tue, 15 Mar 2022 21:09:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351874AbiCOVLF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Mar 2022 17:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351871AbiCOVLD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Mar 2022 17:11:03 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 976845AEF7
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 14:09:46 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id q21-20020a17090a2e1500b001c44f70fd38so326994pjd.6
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 14:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Y1zD3+5mO8FHtvmlCO6/OvQLcxDsm95dgbDiBKQoRKg=;
        b=ZoCTDI7ZwhYpgOIzBny1u7a0kDPTA0Mhj/+qtddjDarofBfzyvF5HrTNVdlGTePzV7
         VmaJ0+D3mLv7WiIClUifeQ6PUNZ7/5MnzyqVz0cTLDY0AGbbQdBPwRBk4IZ3UwlX7ne0
         HEG0kVEqecy4qUXzHhQu9Y0M9dFR13SW8Gxkmk6hgi6I1OnLWiWbS2qXCMNSornNdZuq
         cjYDI5f0j5koTUUIlXvrXDvyqOSCMWoTxgXvnqnK0HKeMz2MFjG6RBgsCSN+phrMT8h4
         cwvBA6/Z6bulqgGlUZVAlxJleWhW4BVOedk4DjDz+yi/xqBdZFJ9l5vcFn6CRrz/MqvQ
         mmEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Y1zD3+5mO8FHtvmlCO6/OvQLcxDsm95dgbDiBKQoRKg=;
        b=4fn/o5uJqSPG3xYxTuEvN52aoW6zrmGXD71NN5mS1R1vDeIZdL0zOas9TXy/f0gbyy
         Re2MHx+XrdOn9gR6Hfhzm7J7OCAzck0kpLjBGaAPNUp/0EPBzSBktp/h1i8Y/RuwmT3y
         R9h83Ep6L2ZI7FClXqQyzccgAyrkiFzutWDPGFuj4xUEWg8sI4FxCpFXjMM7phg0deiU
         bpRcuH4CEsiMUttyFeSs8Zl0iClw25ZkK3ntmrCttjrtwT8M1d8BxF+aMp+7VC/593c5
         kQQPq0J+HVg6w2S6VqMSHu4rbQMFM6nIIGg3XDcfoGekGtk4ouGQqbAtzyHgVNDJ9pF0
         QAiQ==
X-Gm-Message-State: AOAM5327NqbE8KeEWGS2ZIxyx/rerTr1GL2Ped9kWOBllGz9wf+gHgd/
        N66c7UXjbQlqwpjTocHNNhJqpqx7N2OD7RTIVkLUBqfXA81GkWP3bZiEbOVEn9JWJcGrtZgaiv2
        U5O/5E80doWoZOBe4vW2+FU08uL08wei/uyoyjGroMupYrDpOIz9sI6qZ6KyE37Y=
X-Google-Smtp-Source: ABdhPJwK9hyqJy+Vd2zbMC5+T19LKtsZYLTzG+M9aOTMtbLxf5tnMX8EZ4SA473Y8t38QdAeawpbMZ+5IYOzyw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:ce08:b0:153:8d90:a109 with SMTP
 id k8-20020a170902ce0800b001538d90a109mr6507994plg.157.1647378585982; Tue, 15
 Mar 2022 14:09:45 -0700 (PDT)
Date:   Tue, 15 Mar 2022 14:09:22 -0700
In-Reply-To: <20220315210925.79289-1-chooglen@google.com>
Message-Id: <20220315210925.79289-5-chooglen@google.com>
Mime-Version: 1.0
References: <20220315210925.79289-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [PATCH 4/7] submodule--helper: teach update_data more options
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor 'struct update_data' to hold the parsed args needed by "git
submodule--helper update" and refactor "update-clone" and
"run-update-procedure" (the functions that will be combined to form
"update") to use these options.

For "run-update-procedure", 'struct update_data' already holds its args,
so only arg parsing code needs to be updated.

For "update-clone", move its args from 'struct submodule_update_clone'
into 'struct update_data', and replace them with a pointer to 'struct
update_data'. Its other members hold the submodule iteration state of
"update-clone", so those are unchanged.

Incidentally, since we reformat the designated initializers of the
affected structs, also reformat MODULE_CLONE_DATA_INIT for consistency.

Signed-off-by: Glen Choo <chooglen@google.com>
---
For reviewers who have also looked at ar/submodule-update, note that
this patch changes how the CLI args are stored. In that series, the
update_clone logic continues to read the CLI args from 'struct
submodule_update_clone' (the CLI args are copied over from 'struct
update_data'). In this series, however, all of these CLI args are moved
from 'struct submodule_update_clone' to 'struct update_data'.

This patch also incorporates some reformatting from
https://lore.kernel.org/git/patch-v5-5.9-fa815e37f9f-20220128T125206Z-avarab@gmail.com,
but that patch is now largely obsolete because the initializers are
quite different now.

 builtin/submodule--helper.c | 150 ++++++++++++++++++------------------
 git-submodule.sh            |   2 +-
 2 files changed, 76 insertions(+), 76 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 0e3cafb500..04874ce111 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1643,7 +1643,10 @@ struct module_clone_data {
 	unsigned int require_init: 1;
 	int single_branch;
 };
-#define MODULE_CLONE_DATA_INIT { .reference = STRING_LIST_INIT_NODUP, .single_branch = -1 }
+#define MODULE_CLONE_DATA_INIT { \
+	.reference = STRING_LIST_INIT_NODUP, \
+	.single_branch = -1, \
+}
 
 struct submodule_alternate_setup {
 	const char *submodule_name;
@@ -1967,26 +1970,11 @@ struct update_clone_data {
 };
 
 struct submodule_update_clone {
-	/* index into 'list', the list of submodules to look into for cloning */
+	/* index into 'update_data.list', the list of submodules to look into for cloning */
 	int current;
-	struct module_list list;
-	unsigned warn_if_uninitialized : 1;
-
-	/* update parameter passed via commandline */
-	struct submodule_update_strategy update;
 
 	/* configuration parameters which are passed on to the children */
-	int progress;
-	int quiet;
-	int recommend_shallow;
-	struct string_list references;
-	int dissociate;
-	unsigned require_init;
-	const char *depth;
-	const char *recursive_prefix;
-	const char *prefix;
-	int single_branch;
-	struct list_objects_filter_options *filter_options;
+	struct update_data *update_data;
 
 	/* to be consumed by git-submodule.sh */
 	struct update_clone_data *update_clone;
@@ -1998,34 +1986,45 @@ struct submodule_update_clone {
 	/* failed clones to be retried again */
 	const struct cache_entry **failed_clones;
 	int failed_clones_nr, failed_clones_alloc;
-
-	int max_jobs;
-	unsigned int init;
 };
-#define SUBMODULE_UPDATE_CLONE_INIT { \
-	.list = MODULE_LIST_INIT, \
-	.update = SUBMODULE_UPDATE_STRATEGY_INIT, \
-	.recommend_shallow = -1, \
-	.references = STRING_LIST_INIT_DUP, \
-	.single_branch = -1, \
-	.max_jobs = 1, \
-}
+#define SUBMODULE_UPDATE_CLONE_INIT { 0 }
 
 struct update_data {
+	const char *prefix;
 	const char *recursive_prefix;
 	const char *sm_path;
 	const char *displaypath;
+	const char *update_default;
 	struct object_id oid;
 	struct object_id suboid;
+	struct string_list references;
 	struct submodule_update_strategy update_strategy;
+	struct list_objects_filter_options *filter_options;
+	struct module_list list;
 	int depth;
+	int max_jobs;
+	int single_branch;
+	int recommend_shallow;
+	unsigned int require_init;
 	unsigned int force;
 	unsigned int quiet;
 	unsigned int nofetch;
 	unsigned int just_cloned;
 	unsigned int remote;
+	unsigned int progress;
+	unsigned int dissociate;
+	unsigned int init;
+	unsigned int warn_if_uninitialized;
 };
-#define UPDATE_DATA_INIT { .update_strategy = SUBMODULE_UPDATE_STRATEGY_INIT }
+#define UPDATE_DATA_INIT { \
+	.update_strategy = SUBMODULE_UPDATE_STRATEGY_INIT, \
+	.list = MODULE_LIST_INIT, \
+	.recommend_shallow = -1, \
+	.references = STRING_LIST_INIT_DUP, \
+	.single_branch = -1, \
+	.max_jobs = 1, \
+	.warn_if_uninitialized = 1, \
+}
 
 static void next_submodule_warn_missing(struct submodule_update_clone *suc,
 		struct strbuf *out, const char *displaypath)
@@ -2034,7 +2033,7 @@ static void next_submodule_warn_missing(struct submodule_update_clone *suc,
 	 * Only mention uninitialized submodules when their
 	 * paths have been specified.
 	 */
-	if (suc->warn_if_uninitialized) {
+	if (suc->update_data->warn_if_uninitialized) {
 		strbuf_addf(out,
 			_("Submodule path '%s' not initialized"),
 			displaypath);
@@ -2066,8 +2065,8 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 	int need_free_url = 0;
 
 	if (ce_stage(ce)) {
-		if (suc->recursive_prefix)
-			strbuf_addf(&sb, "%s/%s", suc->recursive_prefix, ce->name);
+		if (suc->update_data->recursive_prefix)
+			strbuf_addf(&sb, "%s/%s", suc->update_data->recursive_prefix, ce->name);
 		else
 			strbuf_addstr(&sb, ce->name);
 		strbuf_addf(out, _("Skipping unmerged submodule %s"), sb.buf);
@@ -2077,8 +2076,8 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 
 	sub = submodule_from_path(the_repository, null_oid(), ce->name);
 
-	if (suc->recursive_prefix)
-		displaypath = relative_path(suc->recursive_prefix,
+	if (suc->update_data->recursive_prefix)
+		displaypath = relative_path(suc->update_data->recursive_prefix,
 					    ce->name, &displaypath_sb);
 	else
 		displaypath = ce->name;
@@ -2096,8 +2095,8 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 	}
 	free(key);
 
-	if (suc->update.type == SM_UPDATE_NONE
-	    || (suc->update.type == SM_UPDATE_UNSPECIFIED
+	if (suc->update_data->update_strategy.type == SM_UPDATE_NONE
+	    || (suc->update_data->update_strategy.type == SM_UPDATE_UNSPECIFIED
 		&& update_type == SM_UPDATE_NONE)) {
 		strbuf_addf(out, _("Skipping submodule '%s'"), displaypath);
 		strbuf_addch(out, '\n');
@@ -2141,33 +2140,33 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 	child->err = -1;
 	strvec_push(&child->args, "submodule--helper");
 	strvec_push(&child->args, "clone");
-	if (suc->progress)
+	if (suc->update_data->progress)
 		strvec_push(&child->args, "--progress");
-	if (suc->quiet)
+	if (suc->update_data->quiet)
 		strvec_push(&child->args, "--quiet");
-	if (suc->prefix)
-		strvec_pushl(&child->args, "--prefix", suc->prefix, NULL);
-	if (suc->recommend_shallow && sub->recommend_shallow == 1)
+	if (suc->update_data->prefix)
+		strvec_pushl(&child->args, "--prefix", suc->update_data->prefix, NULL);
+	if (suc->update_data->recommend_shallow && sub->recommend_shallow == 1)
 		strvec_push(&child->args, "--depth=1");
-	if (suc->filter_options && suc->filter_options->choice)
+	else if (suc->update_data->depth)
+		strvec_pushf(&child->args, "--depth=%d", suc->update_data->depth);
+	if (suc->update_data->filter_options && suc->update_data->filter_options->choice)
 		strvec_pushf(&child->args, "--filter=%s",
-			     expand_list_objects_filter_spec(suc->filter_options));
-	if (suc->require_init)
+			     expand_list_objects_filter_spec(suc->update_data->filter_options));
+	if (suc->update_data->require_init)
 		strvec_push(&child->args, "--require-init");
 	strvec_pushl(&child->args, "--path", sub->path, NULL);
 	strvec_pushl(&child->args, "--name", sub->name, NULL);
 	strvec_pushl(&child->args, "--url", url, NULL);
-	if (suc->references.nr) {
+	if (suc->update_data->references.nr) {
 		struct string_list_item *item;
-		for_each_string_list_item(item, &suc->references)
+		for_each_string_list_item(item, &suc->update_data->references)
 			strvec_pushl(&child->args, "--reference", item->string, NULL);
 	}
-	if (suc->dissociate)
+	if (suc->update_data->dissociate)
 		strvec_push(&child->args, "--dissociate");
-	if (suc->depth)
-		strvec_push(&child->args, suc->depth);
-	if (suc->single_branch >= 0)
-		strvec_push(&child->args, suc->single_branch ?
+	if (suc->update_data->single_branch >= 0)
+		strvec_push(&child->args, suc->update_data->single_branch ?
 					      "--single-branch" :
 					      "--no-single-branch");
 
@@ -2189,8 +2188,8 @@ static int update_clone_get_next_task(struct child_process *child,
 	const struct cache_entry *ce;
 	int index;
 
-	for (; suc->current < suc->list.nr; suc->current++) {
-		ce = suc->list.entries[suc->current];
+	for (; suc->current < suc->update_data->list.nr; suc->current++) {
+		ce = suc->update_data->list.entries[suc->current];
 		if (prepare_to_clone_next_submodule(ce, child, suc, err)) {
 			int *p = xmalloc(sizeof(*p));
 			*p = suc->current;
@@ -2205,7 +2204,7 @@ static int update_clone_get_next_task(struct child_process *child,
 	 * stragglers again, which we can imagine as an extension of the
 	 * entry list.
 	 */
-	index = suc->current - suc->list.nr;
+	index = suc->current - suc->update_data->list.nr;
 	if (index < suc->failed_clones_nr) {
 		int *p;
 		ce = suc->failed_clones[index];
@@ -2250,8 +2249,8 @@ static int update_clone_task_finished(int result,
 	if (!result)
 		return 0;
 
-	if (idx < suc->list.nr) {
-		ce  = suc->list.entries[idx];
+	if (idx < suc->update_data->list.nr) {
+		ce  = suc->update_data->list.entries[idx];
 		strbuf_addf(err, _("Failed to clone '%s'. Retry scheduled"),
 			    ce->name);
 		strbuf_addch(err, '\n');
@@ -2261,7 +2260,7 @@ static int update_clone_task_finished(int result,
 		suc->failed_clones[suc->failed_clones_nr++] = ce;
 		return 0;
 	} else {
-		idx -= suc->list.nr;
+		idx -= suc->update_data->list.nr;
 		ce  = suc->failed_clones[idx];
 		strbuf_addf(err, _("Failed to clone '%s' a second time, aborting"),
 			    ce->name);
@@ -2468,13 +2467,15 @@ static void update_submodule(struct update_clone_data *ucd)
 		ucd->sub->path);
 }
 
-static int update_submodules(struct submodule_update_clone *suc)
+static int update_submodules(struct update_data *update_data)
 {
 	int i;
+	struct submodule_update_clone suc = SUBMODULE_UPDATE_CLONE_INIT;
 
-	run_processes_parallel_tr2(suc->max_jobs, update_clone_get_next_task,
+	suc.update_data = update_data;
+	run_processes_parallel_tr2(suc.update_data->max_jobs, update_clone_get_next_task,
 				   update_clone_start_failure,
-				   update_clone_task_finished, suc, "submodule",
+				   update_clone_task_finished, &suc, "submodule",
 				   "parallel/update");
 
 	/*
@@ -2485,41 +2486,40 @@ static int update_submodules(struct submodule_update_clone *suc)
 	 *   checkout involve more straightforward sequential I/O.
 	 * - the listener can avoid doing any work if fetching failed.
 	 */
-	if (suc->quickstop)
+	if (suc.quickstop)
 		return 1;
 
-	for (i = 0; i < suc->update_clone_nr; i++)
-		update_submodule(&suc->update_clone[i]);
+	for (i = 0; i < suc.update_clone_nr; i++)
+		update_submodule(&suc.update_clone[i]);
 
 	return 0;
 }
 
 static int update_clone(int argc, const char **argv, const char *prefix)
 {
-	const char *update = NULL;
 	struct pathspec pathspec;
-	struct submodule_update_clone opt = SUBMODULE_UPDATE_CLONE_INIT;
+	struct update_data opt = UPDATE_DATA_INIT;
 	struct list_objects_filter_options filter_options;
 	int ret;
 
 	struct option module_update_clone_options[] = {
 		OPT_BOOL(0, "init", &opt.init,
 			 N_("initialize uninitialized submodules before update")),
-		OPT_STRING(0, "prefix", &prefix,
+		OPT_STRING(0, "prefix", &opt.prefix,
 			   N_("path"),
 			   N_("path into the working tree")),
 		OPT_STRING(0, "recursive-prefix", &opt.recursive_prefix,
 			   N_("path"),
 			   N_("path into the working tree, across nested "
 			      "submodule boundaries")),
-		OPT_STRING(0, "update", &update,
+		OPT_STRING(0, "update", &opt.update_default,
 			   N_("string"),
 			   N_("rebase, merge, checkout or none")),
 		OPT_STRING_LIST(0, "reference", &opt.references, N_("repo"),
 			   N_("reference repository")),
 		OPT_BOOL(0, "dissociate", &opt.dissociate,
 			   N_("use --reference only while cloning")),
-		OPT_STRING(0, "depth", &opt.depth, "<depth>",
+		OPT_INTEGER(0, "depth", &opt.depth,
 			   N_("create a shallow clone truncated to the "
 			      "specified number of revisions")),
 		OPT_INTEGER('j', "jobs", &opt.max_jobs,
@@ -2546,7 +2546,6 @@ static int update_clone(int argc, const char **argv, const char *prefix)
 		" [--recursive] [--[no-]single-branch] [--] [<path>...]"),
 		NULL
 	};
-	opt.prefix = prefix;
 
 	update_clone_config_from_gitmodules(&opt.max_jobs);
 	git_config(git_update_clone_config, &opt.max_jobs);
@@ -2569,8 +2568,9 @@ static int update_clone(int argc, const char **argv, const char *prefix)
 
 	opt.filter_options = &filter_options;
 
-	if (update)
-		if (parse_submodule_update_strategy(update, &opt.update) < 0)
+	if (opt.update_default)
+		if (parse_submodule_update_strategy(opt.update_default,
+						    &opt.update_strategy) < 0)
 			die(_("bad value for update parameter"));
 
 	if (module_list_compute(argc, argv, prefix, &pathspec, &opt.list) < 0) {
@@ -2611,7 +2611,7 @@ static int update_clone(int argc, const char **argv, const char *prefix)
 
 static int run_update_procedure(int argc, const char **argv, const char *prefix)
 {
-	char *prefixed_path, *update = NULL;
+	char *prefixed_path;
 	struct update_data update_data = UPDATE_DATA_INIT;
 
 	struct option options[] = {
@@ -2627,7 +2627,7 @@ static int run_update_procedure(int argc, const char **argv, const char *prefix)
 		OPT_STRING(0, "prefix", &prefix,
 			   N_("path"),
 			   N_("path into the working tree")),
-		OPT_STRING(0, "update", &update,
+		OPT_STRING(0, "update", &update_data.update_default,
 			   N_("string"),
 			   N_("rebase, merge, checkout or none")),
 		OPT_STRING(0, "recursive-prefix", &update_data.recursive_prefix, N_("path"),
@@ -2661,7 +2661,7 @@ static int run_update_procedure(int argc, const char **argv, const char *prefix)
 	update_data.displaypath = get_submodule_displaypath(prefixed_path, prefix);
 
 	determine_submodule_update_strategy(the_repository, update_data.just_cloned,
-					    update_data.sm_path, update,
+					    update_data.sm_path, update_data.update_default,
 					    &update_data.update_strategy);
 
 	free(prefixed_path);
diff --git a/git-submodule.sh b/git-submodule.sh
index a84143daab..b63a2aefa7 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -366,7 +366,7 @@ cmd_update()
 		${update:+--update "$update"} \
 		${reference:+"$reference"} \
 		${dissociate:+"--dissociate"} \
-		${depth:+--depth "$depth"} \
+		${depth:+"$depth"} \
 		${require_init:+--require-init} \
 		$single_branch \
 		$recommend_shallow \
-- 
2.33.GIT

