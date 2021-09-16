Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E3CBC433EF
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 10:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1CCC61108
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 10:33:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236617AbhIPKep (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 06:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236417AbhIPKem (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Sep 2021 06:34:42 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15001C061574
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 03:33:22 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id mv7-20020a17090b198700b0019c843e7233so679694pjb.4
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 03:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jyJRk25V1xD/bDKjcHw3Oz1rresiepiqo0Y3rP3RvFo=;
        b=mW2jzL59JtKi2+kVmWc6J/HhiUXIPr40Rknwm+bkBT2mQ73ijvPAHv+vrHUPiF+dtI
         NZ2apLq7lUo74Jq8Offy37vOlBPHUX5QiEWhrIfh0akm5lNSSWXyB6qM86zJFlPjhr0Y
         URUHEvz/5f/BhvYftQ4WCzvBIlOB/5RpAiVqBZtkn+B7KO5vQbGXEhQXdwsKKuenXl/n
         bYZvFYMsdQhrpgGeWoVStLA4qrlFQ0bmhXyDQkylM3ghuEqFCu38PK7PhgN5OwZDgd/L
         BytxCPCrRmxrwvqGAGQletTSRFY2p40NIdhY4GxHcpGmMIug4CakF/+arxpQUC2oquCq
         7Alg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jyJRk25V1xD/bDKjcHw3Oz1rresiepiqo0Y3rP3RvFo=;
        b=fN3kGGnHKSujrS45QEDZEJLWe/vK0YF3iT/y+KL2+QaAyLEFihInDd9uHZYqlkEWSe
         B1rnP0xDi01xovWJ5IrMFrsQV6iNh+KkxiPUxGunrrPSr+RXibRmaqlT8lLyzS3QT23l
         WPyNdxMEWJx/R96zdxOnBTt1smgzYE3Ak0mPmA/wLwk+frOx7Ng1gd3ieCHmWFE7muOg
         Zc3THSRqsQefCYCB4dlxJEZEhA/pWQQL9AYae1bxhCqjZ8y2n6npd4CXWk3t/4MmwH/x
         vjtmjFrsCK7sQHWQGgPgeTgew9NvwIkBYdHuFKA/jpd4vNM7bQO43koFCk/84fOCe66P
         EZ/g==
X-Gm-Message-State: AOAM530K5rojU0Ssr/xzDtZ+fq2np2Z9CjNFD9hrPk3Su9gZHlipbstH
        cQ3mnn84fWgWG/kimrquyp0=
X-Google-Smtp-Source: ABdhPJxogTe7Y2nuAEcEcuF2+2HP6+W80lmLu3tTKghYGEUVgier8cjowMKuhCo3wigsezrzfyyN/A==
X-Received: by 2002:a17:903:120e:b0:138:d732:3b01 with SMTP id l14-20020a170903120e00b00138d7323b01mr4158794plh.21.1631788401452;
        Thu, 16 Sep 2021 03:33:21 -0700 (PDT)
Received: from atharva-on-air.Dlink ([119.82.121.182])
        by smtp.gmail.com with ESMTPSA id c199sm2642605pfb.152.2021.09.16.03.33.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Sep 2021 03:33:21 -0700 (PDT)
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     raykar.ath@gmail.com
Cc:     avarab@gmail.com, christian.couder@gmail.com,
        emilyshaffer@google.com, git@vger.kernel.org, gitster@pobox.com,
        jrnieder@gmail.com, kaartic.sivaraam@gmail.com, pc44800@gmail.com,
        periperidip@gmail.com
Subject: [PATCH v2 5/8] submodule: move core cmd_update() logic to C
Date:   Thu, 16 Sep 2021 16:02:38 +0530
Message-Id: <20210916103241.62376-6-raykar.ath@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210916103241.62376-1-raykar.ath@gmail.com>
References: <20210907115932.36068-1-raykar.ath@gmail.com>
 <20210916103241.62376-1-raykar.ath@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch completes the conversion past the flag parsing of
`submodule update` by introducing a helper subcommand called
`submodule--helper update`. The behaviour of `submodule update` should
remain the same after this patch.

We add more fields to the `struct update_data` that are required by
`struct submodule_update_clone` to be able to perform a clone, when that
is needed to be done.

Recursing on a submodule is done by calling a subprocess that launches
`submodule--helper update`, with a modified `--recursive-prefix` and
`--prefix` parameter.

We also introduce `update_submodules()` and `update_submodule()` which
are quite similar to `update_clone_submodules()` and
`update_clone_submodule()`, and will supersede them.

When the `--init` flag is passed to the subcommand, we do not spawn a
new subprocess and call `submodule--helper init` on the submodule paths,
because the Git machinery is not able to pick up the configuration
changes introduced by that init call[1]. So we instead run the
`init_submodule_cb()` callback over each submodule directly.

This introduces another problem, because there is no mechanism to pass
the superproject path prefix (ie, `--super-prefix`) without starting a
new git process. This field is required for obtaining the display path
for that is used by the command's output messages. So let's add a field
into the `init_cb` struct that lets us pass this information to
`init_submodule()`, which will now also take an explicit 'superprefix'
argument.

While we are at it, we also remove the fetch_in_submodule() shell
function since it is no longer used anywhere.

[1] https://lore.kernel.org/git/CAP8UFD0NCQ5w_3GtT_xHr35i7h8BuLX4UcHNY6VHPGREmDVObA@mail.gmail.com/

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Shourya Shukla <periperidip@gmail.com>
Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
---
 builtin/submodule--helper.c | 505 ++++++++++++++++++++++++++++++------
 git-submodule.sh            | 145 +----------
 2 files changed, 433 insertions(+), 217 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 10de01a1f7..1eea626864 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -634,18 +634,22 @@ static char *compute_submodule_clone_url(const char *rel_url)
 
 struct init_cb {
 	const char *prefix;
+	const char *superprefix;
 	unsigned int flags;
 };
-#define INIT_CB_INIT { NULL, 0 }
+#define INIT_CB_INIT { 0 }
 
 static void init_submodule(const char *path, const char *prefix,
-			   unsigned int flags)
+			   const char *superprefix, unsigned int flags)
 {
 	const struct submodule *sub;
 	struct strbuf sb = STRBUF_INIT;
 	char *upd = NULL, *url = NULL, *displaypath;
 
-	displaypath = get_submodule_displaypath(path, prefix);
+	/* try superprefix from the environment, if it is not passed explicitly */
+	if (!superprefix)
+		superprefix = get_super_prefix();
+	displaypath = do_get_submodule_displaypath(path, prefix, superprefix);
 
 	sub = submodule_from_path(the_repository, null_oid(), path);
 
@@ -719,7 +723,7 @@ static void init_submodule(const char *path, const char *prefix,
 static void init_submodule_cb(const struct cache_entry *list_item, void *cb_data)
 {
 	struct init_cb *info = cb_data;
-	init_submodule(list_item->name, info->prefix, info->flags);
+	init_submodule(list_item->name, info->prefix, info->superprefix, info->flags);
 }
 
 static int module_init(int argc, const char **argv, const char *prefix)
@@ -2039,7 +2043,6 @@ struct submodule_update_clone {
 	const char *prefix;
 	int single_branch;
 
-	/* to be consumed by git-submodule.sh */
 	struct update_clone_data *update_clone;
 	int update_clone_nr; int update_clone_alloc;
 
@@ -2062,19 +2065,63 @@ struct submodule_update_clone {
 }
 
 struct update_data {
+	const char *prefix;
 	const char *recursive_prefix;
 	const char *sm_path;
 	const char *displaypath;
 	struct object_id oid;
 	struct object_id suboid;
-	struct submodule_update_strategy update_strategy;
+	int max_jobs;
 	int depth;
+	int recommend_shallow;
+	int single_branch;
+	unsigned int init: 1;
 	unsigned int force: 1;
 	unsigned int quiet: 1;
 	unsigned int nofetch: 1;
-	unsigned int just_cloned: 1;
+	unsigned int remote: 1;
+	unsigned int recursive: 1;
+	unsigned int progress: 1;
+	unsigned int dissociate: 1;
+	unsigned int require_init: 1;
+	unsigned warn_if_uninitialized : 1;
+	unsigned int just_cloned : 1;
+	struct submodule_update_strategy update_strategy;
+	struct string_list references;
+	struct module_list list;
 };
-#define UPDATE_DATA_INIT { .update_strategy = SUBMODULE_UPDATE_STRATEGY_INIT }
+#define UPDATE_DATA_INIT { \
+	.list = MODULE_LIST_INIT, \
+	.update_strategy = SUBMODULE_UPDATE_STRATEGY_INIT, \
+	.recommend_shallow = -1, \
+	.references = STRING_LIST_INIT_DUP, \
+	.single_branch = -1, \
+	.max_jobs = 1, \
+}
+
+static void update_clone_from_update_data(struct submodule_update_clone *suc,
+					  struct update_data *update_data)
+{
+	suc->prefix = update_data->prefix;
+	suc->recursive_prefix = update_data->recursive_prefix;
+	suc->max_jobs = update_data->max_jobs;
+	suc->progress = update_data->progress;
+	suc->quiet = update_data->quiet;
+	suc->dissociate = update_data->dissociate;
+	suc->require_init = update_data->require_init;
+	suc->single_branch = update_data->single_branch;
+	suc->warn_if_uninitialized = update_data->warn_if_uninitialized;
+	suc->list = update_data->list;
+	suc->update = update_data->update_strategy;
+	suc->recommend_shallow = update_data->recommend_shallow;
+	if (update_data->depth)
+		suc->depth = xstrfmt("--depth=%d", update_data->depth);
+	if (update_data->references.nr) {
+		struct string_list_item *item;
+		for_each_string_list_item(item, &update_data->references)
+			string_list_append(&suc->references, item->string);
+	}
+}
 
 static void next_submodule_warn_missing(struct submodule_update_clone *suc,
 		struct strbuf *out, const char *displaypath)
@@ -2369,111 +2416,113 @@ static int fetch_in_submodule(const char *module_path, int depth, int quiet, str
 	return run_command(&cp);
 }
 
-static int run_update_command(struct update_data *ud, int subforce)
+static int run_update_command(struct update_data *ud, int subforce, struct string_list *err)
 {
-	struct strvec args = STRVEC_INIT;
-	struct strvec child_env = STRVEC_INIT;
+	struct child_process cp = CHILD_PROCESS_INIT;
 	char *oid = oid_to_hex(&ud->oid);
+	struct strbuf out = STRBUF_INIT;
 	int must_die_on_failure = 0;
-	int git_cmd;
+	struct submodule_update_strategy strategy = SUBMODULE_UPDATE_STRATEGY_INIT;
 
-	switch (ud->update_strategy.type) {
+	if (ud->update_strategy.type == SM_UPDATE_UNSPECIFIED || ud->just_cloned)
+		determine_submodule_update_strategy(the_repository, ud->just_cloned,
+						    ud->sm_path, NULL, &strategy);
+	else
+		strategy = ud->update_strategy;
+
+	cp.dir = xstrdup(ud->sm_path);
+	switch (strategy.type) {
 	case SM_UPDATE_CHECKOUT:
-		git_cmd = 1;
-		strvec_pushl(&args, "checkout", "-q", NULL);
+		cp.git_cmd = 1;
+		strvec_pushl(&cp.args, "checkout", "-q", NULL);
 		if (subforce)
-			strvec_push(&args, "-f");
+			strvec_push(&cp.args, "-f");
 		break;
 	case SM_UPDATE_REBASE:
-		git_cmd = 1;
-		strvec_push(&args, "rebase");
+		cp.git_cmd = 1;
+		strvec_push(&cp.args, "rebase");
 		if (ud->quiet)
-			strvec_push(&args, "--quiet");
+			strvec_push(&cp.args, "--quiet");
 		must_die_on_failure = 1;
 		break;
 	case SM_UPDATE_MERGE:
-		git_cmd = 1;
-		strvec_push(&args, "merge");
+		cp.git_cmd = 1;
+		strvec_push(&cp.args, "merge");
 		if (ud->quiet)
-			strvec_push(&args, "--quiet");
+			strvec_push(&cp.args, "--quiet");
 		must_die_on_failure = 1;
 		break;
 	case SM_UPDATE_COMMAND:
-		git_cmd = 0;
-		strvec_push(&args, ud->update_strategy.command);
+		cp.git_cmd = 0;
+		cp.use_shell = 1;
+		strvec_push(&cp.args, strategy.command);
 		must_die_on_failure = 1;
 		break;
 	default:
 		BUG("unexpected update strategy type: %s",
-		    submodule_strategy_to_string(&ud->update_strategy));
+		    submodule_strategy_to_string(&strategy));
 	}
-	strvec_push(&args, oid);
+	strvec_push(&cp.args, oid);
 
-	prepare_submodule_repo_env(&child_env);
-	if (run_command_v_opt_cd_env(args.v, git_cmd ? RUN_GIT_CMD : RUN_USING_SHELL,
-				     ud->sm_path, child_env.v)) {
-		switch (ud->update_strategy.type) {
-		case SM_UPDATE_CHECKOUT:
-			printf(_("Unable to checkout '%s' in submodule path '%s'"),
-			       oid, ud->displaypath);
-			break;
-		case SM_UPDATE_REBASE:
-			printf(_("Unable to rebase '%s' in submodule path '%s'"),
-			       oid, ud->displaypath);
-			break;
-		case SM_UPDATE_MERGE:
-			printf(_("Unable to merge '%s' in submodule path '%s'"),
-			       oid, ud->displaypath);
-			break;
-		case SM_UPDATE_COMMAND:
-			printf(_("Execution of '%s %s' failed in submodule path '%s'"),
-			       ud->update_strategy.command, oid, ud->displaypath);
-			break;
-		default:
-			BUG("unexpected update strategy type: %s",
-			    submodule_strategy_to_string(&ud->update_strategy));
+	prepare_submodule_repo_env(&cp.env_array);
+	if (capture_command(&cp, &out, 0)) {
+		if (must_die_on_failure) {
+			switch (strategy.type) {
+			case SM_UPDATE_CHECKOUT:
+				die(_("Unable to checkout '%s' in submodule path '%s'"),
+				    oid, ud->displaypath);
+				break;
+			case SM_UPDATE_REBASE:
+				die(_("Unable to rebase '%s' in submodule path '%s'"),
+				    oid, ud->displaypath);
+				break;
+			case SM_UPDATE_MERGE:
+				die(_("Unable to merge '%s' in submodule path '%s'"),
+				    oid, ud->displaypath);
+				break;
+			case SM_UPDATE_COMMAND:
+				die(_("Execution of '%s %s' failed in submodule path '%s'"),
+				    strategy.command, oid, ud->displaypath);
+				break;
+			default:
+				BUG("unexpected update strategy type: %s",
+				    submodule_strategy_to_string(&strategy));
+			}
 		}
-		/*
-		 * NEEDSWORK: We are currently printing to stdout with error
-		 * return so that the shell caller handles the error output
-		 * properly. Once we start handling the error messages within
-		 * C, we should use die() instead.
-		 */
-		if (must_die_on_failure)
-			return 2;
-		/*
-		 * This signifies to the caller in shell that the command
-		 * failed without dying
-		 */
+
+		/* the command failed, but update must continue */
+		string_list_append(err, out.buf);
 		return 1;
 	}
 
-	switch (ud->update_strategy.type) {
-	case SM_UPDATE_CHECKOUT:
-		printf(_("Submodule path '%s': checked out '%s'\n"),
-		       ud->displaypath, oid);
-		break;
-	case SM_UPDATE_REBASE:
-		printf(_("Submodule path '%s': rebased into '%s'\n"),
-		       ud->displaypath, oid);
-		break;
-	case SM_UPDATE_MERGE:
-		printf(_("Submodule path '%s': merged in '%s'\n"),
-		       ud->displaypath, oid);
-		break;
-	case SM_UPDATE_COMMAND:
-		printf(_("Submodule path '%s': '%s %s'\n"),
-		       ud->displaypath, ud->update_strategy.command, oid);
-		break;
-	default:
-		BUG("unexpected update strategy type: %s",
-		    submodule_strategy_to_string(&ud->update_strategy));
+	if (!ud->quiet) {
+		switch (strategy.type) {
+		case SM_UPDATE_CHECKOUT:
+			printf(_("Submodule path '%s': checked out '%s'\n"),
+			       ud->displaypath, oid);
+			break;
+		case SM_UPDATE_REBASE:
+			printf(_("Submodule path '%s': rebased into '%s'\n"),
+			       ud->displaypath, oid);
+			break;
+		case SM_UPDATE_MERGE:
+			printf(_("Submodule path '%s': merged in '%s'\n"),
+			       ud->displaypath, oid);
+			break;
+		case SM_UPDATE_COMMAND:
+			printf(_("Submodule path '%s': '%s %s'\n"),
+			       ud->displaypath, strategy.command, oid);
+			break;
+		default:
+			BUG("unexpected update strategy type: %s",
+			    submodule_strategy_to_string(&strategy));
+		}
 	}
 
 	return 0;
 }
 
-static int do_run_update_procedure(struct update_data *ud)
+static int do_run_update_procedure(struct update_data *ud, struct string_list *err)
 {
 	int subforce = is_null_oid(&ud->suboid) || ud->force;
 
@@ -2500,7 +2549,7 @@ static int do_run_update_procedure(struct update_data *ud)
 			    ud->displaypath, oid_to_hex(&ud->oid));
 	}
 
-	return run_update_command(ud, subforce);
+	return run_update_command(ud, subforce, err);
 }
 
 static void update_clone_submodule(struct update_clone_data *ucd)
@@ -2605,6 +2654,7 @@ static int run_update_procedure(int argc, const char **argv, const char *prefix)
 	int force = 0, quiet = 0, nofetch = 0, just_cloned = 0;
 	char *prefixed_path, *update = NULL;
 	struct update_data update_data = UPDATE_DATA_INIT;
+	struct string_list err = STRING_LIST_INIT_DUP;
 
 	struct option options[] = {
 		OPT__QUIET(&quiet, N_("suppress output for update by rebase or merge")),
@@ -2662,7 +2712,7 @@ static int run_update_procedure(int argc, const char **argv, const char *prefix)
 	free(prefixed_path);
 
 	if (!oideq(&update_data.oid, &update_data.suboid) || update_data.force)
-		return do_run_update_procedure(&update_data);
+		return do_run_update_procedure(&update_data, &err);
 
 	return 3;
 }
@@ -3038,6 +3088,291 @@ static int module_set_branch(int argc, const char **argv, const char *prefix)
 	return !!ret;
 }
 
+static void update_data_to_args(struct update_data *update_data, struct strvec *args)
+{
+	const char *update = submodule_strategy_to_string(&update_data->update_strategy);
+
+	strvec_pushl(args, "submodule--helper", "update", "--recursive", NULL);
+	strvec_pushf(args, "--jobs=%d", update_data->max_jobs);
+	if (update_data->prefix)
+		strvec_pushl(args, "--prefix", update_data->prefix, NULL);
+	if (update_data->recursive_prefix)
+		strvec_pushl(args, "--recursive-prefix",
+			     update_data->recursive_prefix, NULL);
+	if (update_data->quiet)
+		strvec_push(args, "--quiet");
+	if (update_data->force)
+		strvec_push(args, "--force");
+	if (update_data->init)
+		strvec_push(args, "--init");
+	if (update_data->remote)
+		strvec_push(args, "--remote");
+	if (update_data->nofetch)
+		strvec_push(args, "--no-fetch");
+	if (update_data->dissociate)
+		strvec_push(args, "--dissociate");
+	if (update_data->progress)
+		strvec_push(args, "--progress");
+	if (update_data->require_init)
+		strvec_push(args, "--require-init");
+	if (update_data->depth)
+		strvec_pushf(args, "--depth=%d", update_data->depth);
+	if (update)
+		strvec_pushl(args, "--update", update, NULL);
+	if (update_data->references.nr) {
+		struct string_list_item *item;
+		for_each_string_list_item(item, &update_data->references)
+			strvec_pushl(args, "--reference", item->string, NULL);
+	}
+	if (update_data->recommend_shallow == 0)
+		strvec_push(args, "--no-recommend-shallow");
+	else if (update_data->recommend_shallow == 1)
+		strvec_push(args, "--recommend-shallow");
+	if (update_data->single_branch >= 0)
+		strvec_push(args, "--single-branch");
+}
+
+static int update_submodule(struct update_data *update_data)
+{
+	char *prefixed_path;
+	struct string_list err = STRING_LIST_INIT_DUP;
+
+	do_ensure_core_worktree(update_data->sm_path);
+
+	if (update_data->recursive_prefix)
+		prefixed_path = xstrfmt("%s%s", update_data->recursive_prefix,
+					update_data->sm_path);
+	else
+		prefixed_path = xstrdup(update_data->sm_path);
+
+	update_data->displaypath = get_submodule_displaypath(prefixed_path,
+							     update_data->prefix);
+	free(prefixed_path);
+
+	if (update_data->just_cloned) {
+		oidcpy(&update_data->suboid, null_oid());
+	} else {
+		if (resolve_gitlink_ref(update_data->sm_path, "HEAD", &update_data->suboid))
+			die(_("Unable to find current revision in submodule path '%s'"),
+			    update_data->displaypath);
+	}
+
+	if (update_data->remote) {
+		char *remote_name = get_default_remote_submodule(update_data->sm_path);
+		const char *branch = remote_submodule_branch(update_data->sm_path);
+		char *remote_ref = xstrfmt("refs/remotes/%s/%s", remote_name, branch);
+
+		if (!update_data->nofetch) {
+			if(fetch_in_submodule(update_data->sm_path, update_data->depth,
+					      0, NULL))
+				die(_("Unable to fetch in submodule path '%s'"),
+				    update_data->sm_path);
+		}
+
+		if (resolve_gitlink_ref(update_data->sm_path, remote_ref, &update_data->oid))
+			die(_("Unable to find %s revision in submodule path '%s'"),
+			    remote_ref, update_data->sm_path);
+
+		free(remote_ref);
+	}
+
+	if (!oideq(&update_data->oid, &update_data->suboid) || update_data->force)
+		if (do_run_update_procedure(update_data, &err))
+			return 1;
+
+	if (update_data->recursive) {
+		int res;
+		struct child_process cp = CHILD_PROCESS_INIT;
+		struct update_data next = *update_data;
+		char *die_msg = xstrfmt(_("Failed to recurse into submodule path '%s'"),
+					update_data->displaypath);
+
+		if (update_data->recursive_prefix)
+			prefixed_path = xstrfmt("%s%s/", update_data->recursive_prefix,
+						update_data->sm_path);
+		else
+			prefixed_path = xstrfmt("%s/", update_data->sm_path);
+
+		next.recursive_prefix = get_submodule_displaypath(prefixed_path,
+								  update_data->prefix);
+		next.prefix = NULL;
+		oidcpy(&next.oid, null_oid());
+		oidcpy(&next.suboid, null_oid());
+
+		cp.dir = update_data->sm_path;
+		cp.git_cmd = 1;
+		prepare_submodule_repo_env(&cp.env_array);
+		update_data_to_args(&next, &cp.args);
+
+		/* die() if child process die()'d */
+		if ((res = run_command(&cp)) == 128)
+			die("%s", die_msg);
+		if (res)
+			string_list_append(&err, die_msg);
+
+		free(die_msg);
+	}
+
+	if (err.nr) {
+		struct string_list_item *item;
+		for_each_string_list_item(item, &err)
+			fputs(item->string, stderr);
+		return 1;
+	}
+
+	return 0;
+}
+
+static int update_submodules(struct update_data *update_data)
+{
+	int i, res = 0;
+	struct submodule_update_clone suc = SUBMODULE_UPDATE_CLONE_INIT;
+
+	update_clone_from_update_data(&suc, update_data);
+	run_processes_parallel_tr2(suc.max_jobs, update_clone_get_next_task,
+				   update_clone_start_failure,
+				   update_clone_task_finished, &suc, "submodule",
+				   "parallel/update");
+
+	/*
+	 * We saved the output and put it out all at once now.
+	 * That means:
+	 * - the listener does not have to interleave their (checkout)
+	 *   work with our fetching.  The writes involved in a
+	 *   checkout involve more straightforward sequential I/O.
+	 * - the listener can avoid doing any work if fetching failed.
+	 */
+	if (suc.quickstop) {
+		string_list_clear(&update_data->references, 0);
+		return 1;
+	}
+
+	for (i = 0; i < suc.update_clone_nr; i++) {
+		struct update_clone_data ucd = suc.update_clone[i];
+
+		oidcpy(&update_data->oid, &ucd.oid);
+		update_data->just_cloned = ucd.just_cloned;
+		update_data->sm_path = ucd.sub->path;
+
+		if (update_submodule(update_data))
+			res = 1;
+	}
+
+	string_list_clear(&update_data->references, 0);
+	return res;
+}
+
+static int module_update(int argc, const char **argv, const char *prefix)
+{
+	int init = 0, force = 0, quiet = 0, nofetch = 0;
+	int remote = 0, recursive = 0, dissociate = 0;
+	int progress = 0, require_init = 0;
+	const char *update = NULL;
+	struct pathspec pathspec;
+	struct update_data update_data = UPDATE_DATA_INIT;
+
+	struct option module_update_clone_options[] = {
+		OPT__FORCE(&force, N_("force checkout updates"), 0),
+		OPT_BOOL(0, "init", &init,
+			 N_("initialize uninitialized submodules before update")),
+		OPT_BOOL(0, "remote", &remote,
+			 N_("use SHA-1 of submodule's remote tracking branch")),
+		OPT_BOOL(0, "recursive", &recursive,
+			 N_("traverse submodules recursively")),
+		OPT_BOOL('N', "no-fetch", &nofetch,
+			 N_("don't fetch new objects from the remote site")),
+		OPT_STRING(0, "prefix", &prefix,
+			   N_("path"),
+			   N_("path into the working tree")),
+		OPT_STRING(0, "recursive-prefix", &update_data.recursive_prefix,
+			   N_("path"),
+			   N_("path into the working tree, across nested "
+			      "submodule boundaries")),
+		OPT_STRING(0, "update", &update,
+			   N_("string"),
+			   N_("rebase, merge, checkout or none")),
+		OPT_STRING_LIST(0, "reference", &update_data.references, N_("repo"),
+				N_("reference repository")),
+		OPT_BOOL(0, "dissociate", &dissociate,
+			 N_("use --reference only while cloning")),
+		OPT_INTEGER(0, "depth", &update_data.depth,
+			    N_("create a shallow clone truncated to the "
+			       "specified number of revisions")),
+		OPT_INTEGER('j', "jobs", &update_data.max_jobs,
+			    N_("parallel jobs")),
+		OPT_BOOL(0, "recommend-shallow", &update_data.recommend_shallow,
+			 N_("whether the initial clone should follow the shallow recommendation")),
+		OPT__QUIET(&quiet, N_("don't print cloning progress")),
+		OPT_BOOL(0, "progress", &progress,
+			 N_("force cloning progress")),
+		OPT_BOOL(0, "require-init", &require_init,
+			 N_("disallow cloning into non-empty directory")),
+		OPT_BOOL(0, "single-branch", &update_data.single_branch,
+			 N_("clone only one branch, HEAD or --branch")),
+		OPT_END()
+	};
+
+	const char *const git_submodule_helper_usage[] = {
+		N_("git submodule--helper update-clone [--prefix=<path>] [<path>...]"),
+		NULL
+	};
+
+	update_clone_config_from_gitmodules(&update_data.max_jobs);
+	git_config(git_update_clone_config, &update_data.max_jobs);
+
+	argc = parse_options(argc, argv, prefix, module_update_clone_options,
+			     git_submodule_helper_usage, 0);
+	update_data.prefix = prefix;
+
+	update_data.force = !!force;
+	update_data.quiet = !!quiet;
+	update_data.nofetch = !!nofetch;
+	update_data.init = !!init;
+	update_data.require_init = !!require_init;
+	update_data.remote = !!remote;
+	update_data.recursive = !!recursive;
+	update_data.progress = !!progress;
+	update_data.dissociate = !!dissociate;
+	oidcpy(&update_data.oid, null_oid());
+	oidcpy(&update_data.suboid, null_oid());
+
+	if (update)
+		if (parse_submodule_update_strategy(update,
+						    &update_data.update_strategy) < 0)
+			die(_("bad value for update parameter"));
+
+	if (module_list_compute(argc, argv, prefix, &pathspec, &update_data.list) < 0)
+		return 1;
+
+	if (pathspec.nr)
+		update_data.warn_if_uninitialized = 1;
+
+	if (update_data.init) {
+		struct module_list list = MODULE_LIST_INIT;
+		struct init_cb info = INIT_CB_INIT;
+
+		if (module_list_compute(argc, argv, update_data.prefix,
+					&pathspec, &list) < 0)
+			return 1;
+
+		/*
+		 * If there are no path args and submodule.active is set then,
+		 * by default, only initialize 'active' modules.
+		 */
+		if (!argc && git_config_get_value_multi("submodule.active"))
+			module_list_active(&list);
+
+		info.prefix = update_data.prefix;
+		info.superprefix = update_data.recursive_prefix;
+		if (update_data.quiet)
+			info.flags |= OPT_QUIET;
+
+		for_each_listed_submodule(&list, init_submodule_cb, &info);
+	}
+
+	return update_submodules(&update_data);
+}
+
 struct add_data {
 	const char *prefix;
 	const char *branch;
@@ -3213,6 +3548,7 @@ static int add_clone(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
+
 #define SUPPORT_SUPER_PREFIX (1<<0)
 
 struct cmd_struct {
@@ -3226,6 +3562,7 @@ static struct cmd_struct commands[] = {
 	{"name", module_name, 0},
 	{"clone", module_clone, 0},
 	{"add-clone", add_clone, 0},
+	{"update", module_update, 0},
 	{"update-module-mode", module_update_module_mode, 0},
 	{"update-clone", update_clone, 0},
 	{"run-update-procedure", run_update_procedure, 0},
diff --git a/git-submodule.sh b/git-submodule.sh
index f703cddce8..5197de4551 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -369,20 +369,6 @@ cmd_deinit()
 	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper deinit ${GIT_QUIET:+--quiet} ${force:+--force} ${deinit_all:+--all} -- "$@"
 }
 
-# usage: fetch_in_submodule <module_path> [<depth>] [<sha1>]
-# Because arguments are positional, use an empty string to omit <depth>
-# but include <sha1>.
-fetch_in_submodule () (
-	sanitize_submodule_env &&
-	cd "$1" &&
-	if test $# -eq 3
-	then
-		echo "$3" | git fetch ${GIT_QUIET:+--quiet} --stdin ${2:+"$2"}
-	else
-		git fetch ${GIT_QUIET:+--quiet} ${2:+"$2"}
-	fi
-)
-
 #
 # Update each submodule path to correct revision, using clone and checkout as needed
 #
@@ -484,133 +470,26 @@ cmd_update()
 		shift
 	done
 
-	if test -n "$init"
-	then
-		cmd_init "--" "$@" || return
-	fi
-
-	{
-	git submodule--helper update-clone ${GIT_QUIET:+--quiet} \
-		${progress:+"--progress"} \
+	git ${wt_prefix:+-C "$wt_prefix"} ${prefix:+--super-prefix "$prefix"} submodule--helper update \
+		${GIT_QUIET:+--quiet} \
+		${force:+--force} \
+		${progress:+--progress} \
+		${dissociate:+--dissociate} \
+		${remote:+--remote} \
+		${recursive:+--recursive} \
+		${init:+--init} \
+		${require_init:+--require-init} \
+		${nofetch:+--no-fetch} \
 		${wt_prefix:+--prefix "$wt_prefix"} \
 		${prefix:+--recursive-prefix "$prefix"} \
 		${update:+--update "$update"} \
 		${reference:+"$reference"} \
-		${dissociate:+"--dissociate"} \
-		${depth:+--depth "$depth"} \
-		${require_init:+--require-init} \
+		${depth:+"$depth"} \
 		$single_branch \
 		$recommend_shallow \
 		$jobs \
 		-- \
-		"$@" || echo "#unmatched" $?
-	} | {
-	err=
-	while read -r quickabort sha1 just_cloned sm_path
-	do
-		die_if_unmatched "$quickabort" "$sha1"
-
-		git submodule--helper ensure-core-worktree "$sm_path" || exit 1
-
-		displaypath=$(git submodule--helper relative-path "$prefix$sm_path" "$wt_prefix")
-
-		if test $just_cloned -eq 1
-		then
-			subsha1=
-		else
-			just_cloned=
-			subsha1=$(sanitize_submodule_env; cd "$sm_path" &&
-				git rev-parse --verify HEAD) ||
-			die "fatal: $(eval_gettext "Unable to find current revision in submodule path '\$displaypath'")"
-		fi
-
-		if test -n "$remote"
-		then
-			branch=$(git submodule--helper remote-branch "$sm_path")
-			if test -z "$nofetch"
-			then
-				# Fetch remote before determining tracking $sha1
-				fetch_in_submodule "$sm_path" $depth ||
-				die "fatal: $(eval_gettext "Unable to fetch in submodule path '\$sm_path'")"
-			fi
-			remote_name=$(sanitize_submodule_env; cd "$sm_path" && git submodule--helper print-default-remote)
-			sha1=$(sanitize_submodule_env; cd "$sm_path" &&
-				git rev-parse --verify "${remote_name}/${branch}") ||
-			die "fatal: $(eval_gettext "Unable to find current \${remote_name}/\${branch} revision in submodule path '\$sm_path'")"
-		fi
-
-		out=$(git submodule--helper run-update-procedure \
-			  ${wt_prefix:+--prefix "$wt_prefix"} \
-			  ${GIT_QUIET:+--quiet} \
-			  ${force:+--force} \
-			  ${just_cloned:+--just-cloned} \
-			  ${nofetch:+--no-fetch} \
-			  ${depth:+"$depth"} \
-			  ${update:+--update "$update"} \
-			  ${prefix:+--recursive-prefix "$prefix"} \
-			  ${sha1:+--oid "$sha1"} \
-			  ${subsha1:+--suboid "$subsha1"} \
-			  "--" \
-			  "$sm_path")
-
-		# exit codes for run-update-procedure:
-		# 0: update was successful, say command output
-		# 1: update procedure failed, but should not die
-		# 2 or 128: subcommand died during execution
-		# 3: no update procedure was run
-		res="$?"
-		case $res in
-		0)
-			say "$out"
-			;;
-		1)
-			err="${err};fatal: $out"
-			continue
-			;;
-		2|128)
-			die_with_status $res "fatal: $out"
-			;;
-		esac
-
-		if test -n "$recursive"
-		then
-			(
-				prefix=$(git submodule--helper relative-path "$prefix$sm_path/" "$wt_prefix")
-				wt_prefix=
-				sanitize_submodule_env
-				cd "$sm_path" &&
-				eval cmd_update
-			)
-			res=$?
-			if test $res -gt 0
-			then
-				die_msg="fatal: $(eval_gettext "Failed to recurse into submodule path '\$displaypath'")"
-				if test $res -ne 2
-				then
-					err="${err};$die_msg"
-					continue
-				else
-					die_with_status $res "$die_msg"
-				fi
-			fi
-		fi
-	done
-
-	if test -n "$err"
-	then
-		OIFS=$IFS
-		IFS=';'
-		for e in $err
-		do
-			if test -n "$e"
-			then
-				echo >&2 "$e"
-			fi
-		done
-		IFS=$OIFS
-		exit 1
-	fi
-	}
+		"$@"
 }
 
 #
-- 
2.32.0

