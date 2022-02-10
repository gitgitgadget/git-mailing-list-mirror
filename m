Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E07AC433F5
	for <git@archiver.kernel.org>; Thu, 10 Feb 2022 09:34:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238777AbiBJJez (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Feb 2022 04:34:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235553AbiBJJey (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Feb 2022 04:34:54 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 576A5C64
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 01:34:56 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id m6-20020a056a00080600b004e06140d481so2347388pfk.9
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 01:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=57AHdyT5MFWYpZI/8XBhvWJbHOBIfLMNc/nZSExxLR0=;
        b=otKPlSpOm+voymFNNulGq+Y7Da5/XY/bNbygge8ceMAKCVbIkPYR25Lx9kYJ1MMGmm
         vaIcr4kCRB6X+MwVYfJu/9QCJI2mXZ4yB8Kt6avKYmC4PYtpTPFuHhW89vY2pSmVbrNh
         NRuFYm6TYCgUPKXo8IieQsvm4jUHH6G7gItsLv0Gz3LPdQeuCe3eBX+4laqFExq/9oDF
         nCFv3RwstCOA3721vuSxmuUyJzeWYQZPsNqJ2QEbYhs6N4nbb56mpq5cgCVeUtqFnO3G
         7TS1rivRD3VXSOcnGSSORnzEKiBc1ixrNqLlLRBkdwskUjklPpEDazGAHSqittJhwdLB
         2tPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=57AHdyT5MFWYpZI/8XBhvWJbHOBIfLMNc/nZSExxLR0=;
        b=42gXPSCfrqeW5y1knb/jLiYSaTyRUvCis95jPR2XWlSPGAWJ+YUzsHbRR8tV7IGidG
         +U5Nd4WeTzC9uH43MVtGyOBz7XU84LjuOFNt0TsAt3o8TU1m8YQkrJk94MxwMz6fqMrO
         3oXiFkpL8GZgufPPRSQEpcdI57h8RC0TFkuxDh673eUsMFlV06qS+XJQ6YAKQUP0kL5q
         nyupjBFzBCXbdtb4RhArPy+UsB+zqgO1V6ARALUl3AFp6MuPaG7AW59D3FoeF+EhbKTu
         2tHjbHayfsshJu9N4L+Qsm+lmfhp6futTWoZMAWf8e3rehBDbK7dJzMAexjMj3G3rIwb
         QtXg==
X-Gm-Message-State: AOAM533MrAai/pqJfcD6zHFotU/sXDrXpnNvW0CQEm1RQa1yDpLAufn5
        k5CWW7fzQe4AUrd5ozEIPuBE/9d3EOlWT99LKY/4t6w0bYhDtPCO63viB0bzzf+Yw78Dy8QCK92
        q7IvV9wfkTdp0RdfNOImQuh9FDr5Is1mKu3CpDKWyh3mhs3umC9dISk+SCq2eA3w=
X-Google-Smtp-Source: ABdhPJxtGrDTyqbA9zkBxy+BusgV8Xjwo8t2XFj2JLpjJpQ4XCixEhODKbSsGEHemXDJVMW0lD3eWp7VOfGkMg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a62:5383:: with SMTP id
 h125mr6779667pfb.30.1644485695763; Thu, 10 Feb 2022 01:34:55 -0800 (PST)
Date:   Thu, 10 Feb 2022 17:34:53 +0800
In-Reply-To: <20220210092833.55360-18-chooglen@google.com>
Message-Id: <kl6lwni3dpz6.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20220208083952.35036-1-chooglen@google.com> <20220210092833.55360-1-chooglen@google.com>
 <20220210092833.55360-18-chooglen@google.com>
Subject: Re: [PATCH v7 17/20] submodule: move core cmd_update() logic to C
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrn@google.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        pc44800@gmail.com, Shourya Shukla <periperidip@gmail.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Here is the diff between this tree (+) and that of v5's [1] (-).

[1] https://lore.kernel.org/git/patch-v5-9.9-e8e57606ee9-20220128T125206Z-avarab@gmail.com

----- >8 --------- >8 --------- >8 --------- >8 --------- >8 ----

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 1c28b6f479..b895e88a64 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2003,6 +2003,7 @@ struct update_data {
 	const char *recursive_prefix;
 	const char *sm_path;
 	const char *displaypath;
+	const char *update_default;
 	struct object_id oid;
 	struct object_id suboid;
 	struct submodule_update_strategy update_strategy;
@@ -2355,15 +2356,8 @@ static int run_update_command(struct update_data *ud, int subforce)
 	struct child_process cp = CHILD_PROCESS_INIT;
 	char *oid = oid_to_hex(&ud->oid);
 	int must_die_on_failure = 0;
-	struct submodule_update_strategy strategy = SUBMODULE_UPDATE_STRATEGY_INIT;
 
-	if (ud->update_strategy.type == SM_UPDATE_UNSPECIFIED || ud->just_cloned)
-		determine_submodule_update_strategy(the_repository, ud->just_cloned,
-						    ud->sm_path, NULL, &strategy);
-	else
-		strategy = ud->update_strategy;
-
-	switch (strategy.type) {
+	switch (ud->update_strategy.type) {
 	case SM_UPDATE_CHECKOUT:
 		cp.git_cmd = 1;
 		strvec_pushl(&cp.args, "checkout", "-q", NULL);
@@ -2386,45 +2380,41 @@ static int run_update_command(struct update_data *ud, int subforce)
 		break;
 	case SM_UPDATE_COMMAND:
 		cp.use_shell = 1;
-		strvec_push(&cp.args, strategy.command);
+		strvec_push(&cp.args, ud->update_strategy.command);
 		must_die_on_failure = 1;
 		break;
 	default:
 		BUG("unexpected update strategy type: %s",
-		    submodule_strategy_to_string(&strategy));
+		    submodule_strategy_to_string(&ud->update_strategy));
 	}
 	strvec_push(&cp.args, oid);
 
 	cp.dir = xstrdup(ud->sm_path);
 	prepare_submodule_repo_env(&cp.env_array);
 	if (run_command(&cp)) {
-		switch (strategy.type) {
+		switch (ud->update_strategy.type) {
 		case SM_UPDATE_CHECKOUT:
 			die_message(_("Unable to checkout '%s' in submodule path '%s'"),
 				    oid, ud->displaypath);
 			break;
 		case SM_UPDATE_REBASE:
-			if (!must_die_on_failure)
-				break;
-			die(_("Unable to rebase '%s' in submodule path '%s'"),
+			die_message(_("Unable to rebase '%s' in submodule path '%s'"),
 			    oid, ud->displaypath);
 			break;
 		case SM_UPDATE_MERGE:
-			if (!must_die_on_failure)
-				break;
-			die(_("Unable to merge '%s' in submodule path '%s'"),
+			die_message(_("Unable to merge '%s' in submodule path '%s'"),
 			    oid, ud->displaypath);
 			break;
 		case SM_UPDATE_COMMAND:
-			if (!must_die_on_failure)
-				break;
-			die(_("Execution of '%s %s' failed in submodule path '%s'"),
-			    strategy.command, oid, ud->displaypath);
+			die_message(_("Execution of '%s %s' failed in submodule path '%s'"),
+			    ud->update_strategy.command, oid, ud->displaypath);
 			break;
 		default:
 			BUG("unexpected update strategy type: %s",
-			    submodule_strategy_to_string(&strategy));
+			    submodule_strategy_to_string(&ud->update_strategy));
 		}
+		if (must_die_on_failure)
+			exit(128);
 
 		/* the command failed, but update must continue */
 		return 1;
@@ -2433,7 +2423,7 @@ static int run_update_command(struct update_data *ud, int subforce)
 	if (ud->quiet)
 		return 0;
 
-	switch (strategy.type) {
+	switch (ud->update_strategy.type) {
 	case SM_UPDATE_CHECKOUT:
 		printf(_("Submodule path '%s': checked out '%s'\n"),
 		       ud->displaypath, oid);
@@ -2448,11 +2438,11 @@ static int run_update_command(struct update_data *ud, int subforce)
 		break;
 	case SM_UPDATE_COMMAND:
 		printf(_("Submodule path '%s': '%s %s'\n"),
-		       ud->displaypath, strategy.command, oid);
+		       ud->displaypath, ud->update_strategy.command, oid);
 		break;
 	default:
 		BUG("unexpected update strategy type: %s",
-		    submodule_strategy_to_string(&strategy));
+		    submodule_strategy_to_string(&ud->update_strategy));
 	}
 
 	return 0;
@@ -2832,10 +2822,12 @@ static int module_set_branch(int argc, const char **argv, const char *prefix)
 
 static void update_data_to_args(struct update_data *update_data, struct strvec *args)
 {
-	const char *update = submodule_strategy_to_string(&update_data->update_strategy);
-
 	strvec_pushl(args, "submodule--helper", "update", "--recursive", NULL);
 	strvec_pushf(args, "--jobs=%d", update_data->max_jobs);
+	/*
+	 * NEEDSWORK: the equivalent code in git-submodule.sh does not
+	 * pass --prefix, so this shouldn't either
+	*/
 	if (update_data->prefix)
 		strvec_pushl(args, "--prefix", update_data->prefix, NULL);
 	if (update_data->recursive_prefix)
@@ -2859,8 +2851,8 @@ static void update_data_to_args(struct update_data *update_data, struct strvec *
 		strvec_push(args, "--require-init");
 	if (update_data->depth)
 		strvec_pushf(args, "--depth=%d", update_data->depth);
-	if (update)
-		strvec_pushl(args, "--update", update, NULL);
+	if (update_data->update_default)
+		strvec_pushl(args, "--update", update_data->update_default, NULL);
 	if (update_data->references.nr) {
 		struct string_list_item *item;
 		for_each_string_list_item(item, &update_data->references)
@@ -2890,6 +2882,11 @@ static int update_submodule(struct update_data *update_data)
 							     update_data->prefix);
 	free(prefixed_path);
 
+	determine_submodule_update_strategy(the_repository, update_data->just_cloned,
+					    update_data->sm_path, update_data->update_default,
+					    &update_data->update_strategy);
+
+	/* NEEDSWORK: fix the style issues e.g. braces */
 	if (update_data->just_cloned) {
 		oidcpy(&update_data->suboid, null_oid());
 	} else {
@@ -3000,10 +2997,10 @@ static int update_submodules(struct update_data *update_data)
 
 static int module_update(int argc, const char **argv, const char *prefix)
 {
-	const char *update = NULL;
 	struct pathspec pathspec;
 	struct update_data opt = UPDATE_DATA_INIT;
 
+	/* NEEDSWORK: update names and strings */
 	struct option module_update_clone_options[] = {
 		OPT__FORCE(&opt.force, N_("force checkout updates"), 0),
 		OPT_BOOL(0, "init", &opt.init,
@@ -3021,7 +3018,7 @@ static int module_update(int argc, const char **argv, const char *prefix)
 			   N_("path"),
 			   N_("path into the working tree, across nested "
 			      "submodule boundaries")),
-		OPT_STRING(0, "update", &update,
+		OPT_STRING(0, "update", &opt.update_default,
 			   N_("string"),
 			   N_("rebase, merge, checkout or none")),
 		OPT_STRING_LIST(0, "reference", &opt.references, N_("repo"),
@@ -3058,8 +3055,8 @@ static int module_update(int argc, const char **argv, const char *prefix)
 	oidcpy(&opt.oid, null_oid());
 	oidcpy(&opt.suboid, null_oid());
 
-	if (update)
-		if (parse_submodule_update_strategy(update,
+	if (opt.update_default)
+		if (parse_submodule_update_strategy(opt.update_default,
 						    &opt.update_strategy) < 0)
 			die(_("bad value for update parameter"));
 
@@ -3490,6 +3487,7 @@ static struct cmd_struct commands[] = {
 	{"sync", module_sync, SUPPORT_SUPER_PREFIX},
 	{"deinit", module_deinit, 0},
 	{"summary", module_summary, SUPPORT_SUPER_PREFIX},
+	/* NEEDSWORK: remote-branch is also obsolete */
 	{"remote-branch", resolve_remote_submodule_branch, 0},
 	{"push-check", push_check, 0},
 	{"absorb-git-dirs", absorb_git_dirs, SUPPORT_SUPER_PREFIX},
diff --git a/git-submodule.sh b/git-submodule.sh
index bcd8b92aab..d176469fb1 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -50,6 +50,7 @@ single_branch=
 jobs=
 recommend_shallow=
 
+# NEEDSWORK this is now unused
 die_if_unmatched ()
 {
 	if test "$1" = "#unmatched"
@@ -347,6 +348,8 @@ cmd_update()
 		shift
 	done
 
+	# NEEDSWORK --super-prefix isn't actually supported by this
+	# command - we just pass the $prefix to --recursive-prefix.
 	git ${wt_prefix:+-C "$wt_prefix"} ${prefix:+--super-prefix "$prefix"} submodule--helper update \
 		${GIT_QUIET:+--quiet} \
 		${force:+--force} \
