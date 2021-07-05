Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A23C07E98
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 04:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE3D1613CB
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 04:45:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbhGEEsJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jul 2021 00:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbhGEEsI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jul 2021 00:48:08 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85842C061574
        for <git@vger.kernel.org>; Sun,  4 Jul 2021 21:45:31 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id s18so2077833pgg.8
        for <git@vger.kernel.org>; Sun, 04 Jul 2021 21:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+wSIKG+BUfrfrOvnZg1TVt1sdyGUU58clgwAs4vaXkM=;
        b=DIo7Iw5D5dVjdzXNQpgKr6ww5eHbob+B/Jeh7v0Onw9NETqqLhFdWIFavaa22SlTiO
         B6dr3HY/p/y3A1XNdCYZ4qGbyusml3pJzRlw5JOONDUxAHIPAJEtdrtusGEX9OT7A4GL
         8eHHdTzenGpORleMY2H8M4MIZUG68NVDxBu5eo1re4jAB3NnTFTxp57sNpoQYbcla/c5
         ESiijnJqmwF9ccS78aSd1nol37JmO6ZTZApJT8rSqkA84iN27NasOclDfQdBLPleCDPE
         PgEHFc8SHAF6t7uxPdcrPCn4bg22jPLVubmxkE7OARJMIANeEK/wzihsVDXwOpOUlRMC
         zcWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+wSIKG+BUfrfrOvnZg1TVt1sdyGUU58clgwAs4vaXkM=;
        b=RHEWRumjk0h067UxWZXIe5ZWNc/hu3PCfzLWJ2nsEwN20O0SZP/pKn6Vm82ifNDnm5
         d9b//1B6LkrmaDC9K+C0uOFC9u2OVGeuNC7cg9wdLUv7yosG0mYI/VUqH0unPZvV0o21
         RtdML0Yc60AZehODUl1JzD5OUBNYHQOWPbPdnLb2XGZwsS0NxdvxO2neEtvaDUim/gEG
         D+q5va0ZZEjY4LCa2707/aqBoqSyKzpoWKITZucB5kKsCa6udMH7QxpAHwQ5NAlzeizv
         roTta7gsMe0yxXWoYyv8UcSLjBlu4Dkh4u2pF6hIyzd5csCRXQaNZ9+Mjpk4Yr0fXDxB
         bzMQ==
X-Gm-Message-State: AOAM5307BD5ksK7f1fFZBsjQ1HOqceCAccT4SsFTzKDr6KaqGbBdKacE
        onAsOTvWBAPoshIltN3SxpV3d3UYEuGBzw==
X-Google-Smtp-Source: ABdhPJyg10jRu7qJbz/Vqadt4GEH80iLtGRQgToSc+rXnzOf/Bqcquf1CvETSyEzDbsLG2r0L1nv5g==
X-Received: by 2002:a63:2208:: with SMTP id i8mr13434506pgi.71.1625460330133;
        Sun, 04 Jul 2021 21:45:30 -0700 (PDT)
Received: from xavier.lan ([2001:470:b:114::cc1])
        by smtp.gmail.com with ESMTPSA id x13sm9792233pjh.30.2021.07.04.21.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jul 2021 21:45:29 -0700 (PDT)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, gitster@pobox.com, newren@gmail.com
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH RFC] rebase: respect --ff-only option
Date:   Sun,  4 Jul 2021 22:45:05 -0600
Message-Id: <20210705044505.666977-1-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.32.0.94.ge083fb24f6
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The warning about pulling without specifying how to reconcile divergent
branches says that after setting pull.rebase to true, --ff-only can
still be passed on the command line to require a fast-forward. Make that
actually work.

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
I'm sending this patch as an RFC because I'm sure someone will find at
least one thing that needs to be changed before it's committed.
---
 advice.c                          |  6 +++
 advice.h                          |  1 +
 builtin/merge.c                   |  6 ---
 builtin/pull.c                    |  2 +
 builtin/rebase.c                  | 68 +++++++++++++++++++------------
 builtin/revert.c                  |  6 +--
 sequencer.c                       | 53 ++++++++++++++----------
 sequencer.h                       |  9 +++-
 t/t3404-rebase-interactive.sh     |  5 +++
 t/t3409-rebase-preserve-merges.sh |  4 ++
 t/t3420-rebase-autostash.sh       |  9 ++++
 t/t7601-merge-pull-config.sh      | 10 +++++
 12 files changed, 121 insertions(+), 58 deletions(-)

diff --git a/advice.c b/advice.c
index 0b9c89c48a..8571ab7d0f 100644
--- a/advice.c
+++ b/advice.c
@@ -246,6 +246,12 @@ void list_config_advices(struct string_list *list, const char *prefix)
 		list_config_item(list, prefix, advice_setting[i].key);
 }
 
+int error_ff_impossible(void)
+{
+	error(_("Not possible to fast-forward, aborting."));
+	return -1;
+}
+
 int error_resolve_conflict(const char *me)
 {
 	if (!strcmp(me, "cherry-pick"))
diff --git a/advice.h b/advice.h
index bd26c385d0..49017f931e 100644
--- a/advice.h
+++ b/advice.h
@@ -93,6 +93,7 @@ int advice_enabled(enum advice_type type);
 void advise_if_enabled(enum advice_type type, const char *advice, ...);
 
 int error_resolve_conflict(const char *me);
+int error_ff_impossible(void);
 void NORETURN die_resolve_conflict(const char *me);
 void NORETURN die_conclude_merge(void);
 void advise_on_updating_sparse_paths(struct string_list *pathspec_list);
diff --git a/builtin/merge.c b/builtin/merge.c
index a8a843b1f5..eb25c30e70 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -98,12 +98,6 @@ static struct strategy all_strategy[] = {
 
 static const char *pull_twohead, *pull_octopus;
 
-enum ff_type {
-	FF_NO,
-	FF_ALLOW,
-	FF_ONLY
-};
-
 static enum ff_type fast_forward = FF_ALLOW;
 
 static const char *cleanup_arg;
diff --git a/builtin/pull.c b/builtin/pull.c
index e8927fc2ff..c285e9cc89 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -889,6 +889,8 @@ static int run_rebase(const struct object_id *newbase,
 		strvec_push(&args, "--interactive");
 	if (opt_diffstat)
 		strvec_push(&args, opt_diffstat);
+	if (opt_ff)
+		strvec_push(&args, opt_ff);
 	strvec_pushv(&args, opt_strategies.v);
 	strvec_pushv(&args, opt_strategy_opts.v);
 	if (opt_gpg_sign)
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 12f093121d..b88f0cbcca 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -81,9 +81,9 @@ struct rebase_options {
 		REBASE_NO_QUIET = 1<<0,
 		REBASE_VERBOSE = 1<<1,
 		REBASE_DIFFSTAT = 1<<2,
-		REBASE_FORCE = 1<<3,
-		REBASE_INTERACTIVE_EXPLICIT = 1<<4,
+		REBASE_INTERACTIVE_EXPLICIT = 1<<3,
 	} flags;
+	enum ff_type fast_forward;
 	struct strvec git_am_opts;
 	const char *action;
 	int signoff;
@@ -110,6 +110,7 @@ struct rebase_options {
 		.keep_empty = 1,			\
 		.default_backend = "merge",	  	\
 		.flags = REBASE_NO_QUIET, 		\
+		.fast_forward = FF_ALLOW,   		\
 		.git_am_opts = STRVEC_INIT,		\
 		.git_format_patch_opt = STRBUF_INIT,	\
 		.fork_point = -1,			\
@@ -124,7 +125,7 @@ static struct replay_opts get_replay_opts(const struct rebase_options *opts)
 	sequencer_init_config(&replay);
 
 	replay.signoff = opts->signoff;
-	replay.allow_ff = !(opts->flags & REBASE_FORCE);
+	replay.fast_forward = opts->fast_forward;
 	if (opts->allow_rerere_autoupdate)
 		replay.allow_rerere_auto = opts->allow_rerere_autoupdate;
 	replay.allow_empty = 1;
@@ -488,8 +489,11 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
 	struct object_id squash_onto = *null_oid();
 	enum action command = ACTION_NONE;
 	struct option options[] = {
-		OPT_NEGBIT(0, "ff", &opts.flags, N_("allow fast-forward"),
-			   REBASE_FORCE),
+		OPT_SET_INT(0, "ff", &opts.fast_forward, N_("allow fast-forward"),
+			    FF_ALLOW),
+		OPT_SET_INT_F(0, "ff-only", &opts.fast_forward,
+			      N_("abort if fast-forward is not possible"),
+			      FF_ONLY, PARSE_OPT_NONEG),
 		OPT_CALLBACK_F('k', "keep-empty", &options, NULL,
 			N_("keep commits which start empty"),
 			PARSE_OPT_NOARG | PARSE_OPT_HIDDEN,
@@ -651,7 +655,7 @@ static int read_basic_state(struct rebase_options *opts)
 
 	if (file_exists(state_dir_path("signoff", opts))) {
 		opts->signoff = 1;
-		opts->flags |= REBASE_FORCE;
+		opts->fast_forward = FF_NO;
 	}
 
 	if (file_exists(state_dir_path("allow_rerere_autoupdate", opts))) {
@@ -991,7 +995,7 @@ static int run_specific_rebase(struct rebase_options *opts, enum action action)
 	add_var(&script_snippet, "diffstat",
 		opts->flags & REBASE_DIFFSTAT ? "t" : "");
 	add_var(&script_snippet, "force_rebase",
-		opts->flags & REBASE_FORCE ? "t" : "");
+		opts->fast_forward == FF_NO ? "" : "t");
 	if (opts->switch_to)
 		add_var(&script_snippet, "switch_to", opts->switch_to);
 	add_var(&script_snippet, "action", opts->action ? opts->action : "");
@@ -1345,12 +1349,14 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			 N_("ignore changes in whitespace")),
 		OPT_PASSTHRU_ARGV(0, "whitespace", &options.git_am_opts,
 				  N_("action"), N_("passed to 'git apply'"), 0),
-		OPT_BIT('f', "force-rebase", &options.flags,
-			N_("cherry-pick all commits, even if unchanged"),
-			REBASE_FORCE),
-		OPT_BIT(0, "no-ff", &options.flags,
-			N_("cherry-pick all commits, even if unchanged"),
-			REBASE_FORCE),
+		OPT_SET_INT_F('f', "force-rebase", &options.fast_forward,
+			      N_("cherry-pick all commits, even if unchanged"),
+			      FF_NO, PARSE_OPT_NONEG),
+		OPT_SET_INT(0, "ff", &options.fast_forward, N_("allow fast-forward"),
+			    FF_ALLOW),
+		OPT_SET_INT_F(0, "ff-only", &options.fast_forward,
+			      N_("abort if fast-forward is not possible"),
+			      FF_ONLY, PARSE_OPT_NONEG),
 		OPT_CMDMODE(0, "continue", &action, N_("continue"),
 			    ACTION_CONTINUE),
 		OPT_CMDMODE(0, "skip", &action,
@@ -1635,7 +1641,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		allow_preemptive_ff = 0;
 	}
 	if (options.committer_date_is_author_date || options.ignore_date)
-		options.flags |= REBASE_FORCE;
+		options.fast_forward = FF_NO;
 
 	for (i = 0; i < options.git_am_opts.nr; i++) {
 		const char *option = options.git_am_opts.v[i], *p;
@@ -1809,7 +1815,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			die("cannot combine '--signoff' with "
 			    "'--preserve-merges'");
 		strvec_push(&options.git_am_opts, "--signoff");
-		options.flags |= REBASE_FORCE;
+		options.fast_forward = FF_NO;
 	}
 
 	if (options.type == REBASE_PRESERVE_MERGES) {
@@ -1952,6 +1958,24 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	if (repo_read_index(the_repository) < 0)
 		die(_("could not read index"));
 
+	/*
+	 * Check if we are already based on onto with linear history,
+	 * in which case we could fast-forward without replacing the commits
+	 * with new commits recreated by replaying their changes.
+	 *
+	 * Note that can_fast_forward() initializes merge_base, so we have to
+	 * call it before checking allow_preemptive_ff.
+	 */
+	allow_preemptive_ff = can_fast_forward(options.onto, options.upstream,
+					       options.restrict_revision,
+					       &options.orig_head, &merge_base)
+			      && allow_preemptive_ff;
+
+	if (!allow_preemptive_ff && options.fast_forward == FF_ONLY) {
+		ret = error_ff_impossible();
+		goto cleanup;
+	}
+
 	if (options.autostash) {
 		create_autostash(the_repository, state_dir_path("autostash", &options),
 				 DEFAULT_REFLOG_ACTION);
@@ -1968,20 +1992,10 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	 * everything leading up to orig_head) on top of onto.
 	 */
 
-	/*
-	 * Check if we are already based on onto with linear history,
-	 * in which case we could fast-forward without replacing the commits
-	 * with new commits recreated by replaying their changes.
-	 *
-	 * Note that can_fast_forward() initializes merge_base, so we have to
-	 * call it before checking allow_preemptive_ff.
-	 */
-	if (can_fast_forward(options.onto, options.upstream, options.restrict_revision,
-		    &options.orig_head, &merge_base) &&
-	    allow_preemptive_ff) {
+	if (allow_preemptive_ff) {
 		int flag;
 
-		if (!(options.flags & REBASE_FORCE)) {
+		if (options.fast_forward != FF_NO) {
 			/* Lazily switch to the target branch if needed... */
 			if (options.switch_to) {
 				strbuf_reset(&buf);
diff --git a/builtin/revert.c b/builtin/revert.c
index 237f2f18d4..f9b61478a2 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -123,7 +123,7 @@ static int run_sequencer(int argc, const char **argv, struct replay_opts *opts)
 	if (opts->action == REPLAY_PICK) {
 		struct option cp_extra[] = {
 			OPT_BOOL('x', NULL, &opts->record_origin, N_("append commit name")),
-			OPT_BOOL(0, "ff", &opts->allow_ff, N_("allow fast-forward")),
+			OPT_SET_INT(0, "ff", &opts->fast_forward, N_("allow fast-forward"), FF_ALLOW),
 			OPT_BOOL(0, "allow-empty", &opts->allow_empty, N_("preserve initially empty commits")),
 			OPT_BOOL(0, "allow-empty-message", &opts->allow_empty_message, N_("allow commits with empty messages")),
 			OPT_BOOL(0, "keep-redundant-commits", &opts->keep_redundant_commits, N_("keep redundant, empty commits")),
@@ -166,7 +166,7 @@ static int run_sequencer(int argc, const char **argv, struct replay_opts *opts)
 				"--strategy", opts->strategy ? 1 : 0,
 				"--strategy-option", opts->xopts ? 1 : 0,
 				"-x", opts->record_origin,
-				"--ff", opts->allow_ff,
+				"--ff", opts->fast_forward == FF_ALLOW,
 				"--rerere-autoupdate", opts->allow_rerere_auto == RERERE_AUTOUPDATE,
 				"--no-rerere-autoupdate", opts->allow_rerere_auto == RERERE_NOAUTOUPDATE,
 				NULL);
@@ -177,7 +177,7 @@ static int run_sequencer(int argc, const char **argv, struct replay_opts *opts)
 		opts->default_strategy = NULL;
 	}
 
-	if (opts->allow_ff)
+	if (opts->fast_forward == FF_ALLOW)
 		verify_opt_compatible(me, "--ff",
 				"--signoff", opts->signoff,
 				"--no-commit", opts->no_commit,
diff --git a/sequencer.c b/sequencer.c
index 0bec01cf38..84447937d2 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2120,18 +2120,23 @@ static int do_pick_commit(struct repository *r,
 		return error(_("cannot get commit message for %s"),
 			oid_to_hex(&commit->object.oid));
 
-	if (opts->allow_ff && !is_fixup(command) &&
-	    ((parent && oideq(&parent->object.oid, &head)) ||
-	     (!parent && unborn))) {
-		if (is_rebase_i(opts))
-			write_author_script(msg.message);
-		res = fast_forward_to(r, &commit->object.oid, &head, unborn,
-			opts);
-		if (res || command != TODO_REWORD)
+	if (opts->fast_forward != FF_NO) {
+		if (!is_fixup(command) &&
+		    ((parent && oideq(&parent->object.oid, &head)) ||
+		     (!parent && unborn))) {
+			if (is_rebase_i(opts))
+				write_author_script(msg.message);
+			res = fast_forward_to(r, &commit->object.oid, &head, unborn,
+				opts);
+			if (res || command != TODO_REWORD)
+				goto leave;
+			reword = 1;
+			msg_file = NULL;
+			goto fast_forward_edit;
+		} else if (opts->fast_forward == FF_ONLY) {
+			res = error_ff_impossible();
 			goto leave;
-		reword = 1;
-		msg_file = NULL;
-		goto fast_forward_edit;
+		}
 	}
 	if (parent && parse_commit(parent) < 0)
 		/* TRANSLATORS: The first %s will be a "todo" command like
@@ -2764,7 +2769,7 @@ static int populate_opts_cb(const char *key, const char *value, void *data)
 	else if (!strcmp(key, "options.record-origin"))
 		opts->record_origin = git_config_bool_or_int(key, value, &error_flag);
 	else if (!strcmp(key, "options.allow-ff"))
-		opts->allow_ff = git_config_bool_or_int(key, value, &error_flag);
+		opts->fast_forward = git_config_bool_or_int(key, value, &error_flag) ? FF_ALLOW : FF_NO;
 	else if (!strcmp(key, "options.mainline"))
 		opts->mainline = git_config_int(key, value);
 	else if (!strcmp(key, "options.strategy"))
@@ -2853,17 +2858,17 @@ static int read_populate_opts(struct replay_opts *opts)
 			opts->quiet = 1;
 
 		if (file_exists(rebase_path_signoff())) {
-			opts->allow_ff = 0;
+			opts->fast_forward = FF_NO;
 			opts->signoff = 1;
 		}
 
 		if (file_exists(rebase_path_cdate_is_adate())) {
-			opts->allow_ff = 0;
+			opts->fast_forward = FF_NO;
 			opts->committer_date_is_author_date = 1;
 		}
 
 		if (file_exists(rebase_path_ignore_date())) {
-			opts->allow_ff = 0;
+			opts->fast_forward = FF_NO;
 			opts->ignore_date = 1;
 		}
 
@@ -3320,7 +3325,7 @@ static int save_opts(struct replay_opts *opts)
 	if (opts->record_origin)
 		res |= git_config_set_in_file_gently(opts_file,
 					"options.record-origin", "true");
-	if (opts->allow_ff)
+	if (opts->fast_forward == FF_ALLOW)
 		res |= git_config_set_in_file_gently(opts_file,
 					"options.allow-ff", "true");
 	if (opts->mainline) {
@@ -3849,9 +3854,9 @@ static int do_merge(struct repository *r,
 	 * If HEAD is not identical to the first parent of the original merge
 	 * commit, we cannot fast-forward.
 	 */
-	can_fast_forward = opts->allow_ff && commit && commit->parents &&
-		oideq(&commit->parents->item->object.oid,
-		      &head_commit->object.oid);
+	can_fast_forward = opts->fast_forward != FF_NO && commit &&
+		commit->parents && oideq(&commit->parents->item->object.oid,
+					 &head_commit->object.oid);
 
 	/*
 	 * If any merge head is different from the original one, we cannot
@@ -3885,6 +3890,11 @@ static int do_merge(struct repository *r,
 		goto leave_merge;
 	}
 
+	if (opts->fast_forward == FF_ONLY && !can_fast_forward) {
+		ret = error_ff_impossible();
+		goto leave_merge;
+	}
+
 	if (strategy || to_merge->next) {
 		/* Octopus merge */
 		struct child_process cmd = CHILD_PROCESS_INIT;
@@ -4276,7 +4286,7 @@ static int pick_commits(struct repository *r,
 	/* Note that 0 for 3rd parameter of setenv means set only if not set */
 	setenv(GIT_REFLOG_ACTION, action_name(opts), 0);
 	prev_reflog_action = xstrdup(getenv(GIT_REFLOG_ACTION));
-	if (opts->allow_ff)
+	if (opts->fast_forward != FF_NO)
 		assert(!(opts->signoff || opts->no_commit ||
 			 opts->record_origin || should_edit(opts) ||
 			 opts->committer_date_is_author_date ||
@@ -5646,7 +5656,8 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
 		BUG("invalid todo list after expanding IDs:\n%s",
 		    new_todo.buf.buf);
 
-	if (opts->allow_ff && skip_unnecessary_picks(r, &new_todo, &oid)) {
+	if (opts->fast_forward != FF_NO
+	    && skip_unnecessary_picks(r, &new_todo, &oid)) {
 		todo_list_release(&new_todo);
 		return error(_("could not skip unnecessary pick commands"));
 	}
diff --git a/sequencer.h b/sequencer.h
index d57d8ea23d..e188dec312 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -28,6 +28,12 @@ enum commit_msg_cleanup_mode {
 	COMMIT_MSG_CLEANUP_ALL
 };
 
+enum ff_type {
+	FF_NO,
+	FF_ALLOW,
+	FF_ONLY
+};
+
 struct replay_opts {
 	enum replay_action action;
 
@@ -38,7 +44,6 @@ struct replay_opts {
 	int record_origin;
 	int no_commit;
 	int signoff;
-	int allow_ff;
 	int allow_rerere_auto;
 	int allow_empty;
 	int allow_empty_message;
@@ -50,6 +55,8 @@ struct replay_opts {
 	int committer_date_is_author_date;
 	int ignore_date;
 
+	enum ff_type fast_forward;
+
 	int mainline;
 
 	char *gpg_sign;
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 66bcbbf952..858e406725 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -895,6 +895,11 @@ test_expect_success 'always cherry-pick with --no-ff' '
 	test_must_be_empty out
 '
 
+test_expect_success 'interactive rebase prevents non-fast-forward with --ff-only' '
+	git checkout primary &&
+	test_must_fail git rebase -i --ff-only branch1
+'
+
 test_expect_success 'set up commits with funny messages' '
 	git checkout -b funny A &&
 	echo >>file1 &&
diff --git a/t/t3409-rebase-preserve-merges.sh b/t/t3409-rebase-preserve-merges.sh
index ec8062a66a..e656b5bd28 100755
--- a/t/t3409-rebase-preserve-merges.sh
+++ b/t/t3409-rebase-preserve-merges.sh
@@ -127,4 +127,8 @@ test_expect_success 'rebase -p ignores merge.log config' '
 	)
 '
 
+test_expect_success 'rebase -p prevents non-fast-forward with --ff-only' '
+	test_must_fail git rebase -p --ff-only main
+'
+
 test_done
diff --git a/t/t3420-rebase-autostash.sh b/t/t3420-rebase-autostash.sh
index 43fcb68f27..69a85cb645 100755
--- a/t/t3420-rebase-autostash.sh
+++ b/t/t3420-rebase-autostash.sh
@@ -246,6 +246,15 @@ test_expect_success "rebase: fast-forward rebase" '
 	git checkout feature-branch
 '
 
+test_expect_success "rebase: impossible fast-forward rebase" '
+	test_config rebase.autostash true &&
+	git reset --hard &&
+	echo dirty >>file1 &&
+	(git rebase --ff-only unrelated-onto-branch || true) &&
+	grep dirty file1 &&
+	git checkout feature-branch
+'
+
 test_expect_success "rebase: noop rebase" '
 	test_config rebase.autostash true &&
 	git reset --hard &&
diff --git a/t/t7601-merge-pull-config.sh b/t/t7601-merge-pull-config.sh
index 52e8ccc933..af260b9faa 100755
--- a/t/t7601-merge-pull-config.sh
+++ b/t/t7601-merge-pull-config.sh
@@ -183,6 +183,16 @@ test_expect_success 'pull prevents non-fast-forward with "only" in pull.ff' '
 	test_must_fail git pull . c3
 '
 
+test_expect_success 'pull prevents non-fast-forward with --rebase --ff-only' '
+	git reset --hard c1 &&
+	test_must_fail git pull --rebase --ff-only . c3
+'
+
+test_expect_success 'pull prevents non-fast-forward with --no-rebase --ff-only' '
+	git reset --hard c1 &&
+	test_must_fail git pull --no-rebase --ff-only . c3
+'
+
 test_expect_success 'merge c1 with c2 (ours in pull.twohead)' '
 	git reset --hard c1 &&
 	git config pull.twohead ours &&
-- 
2.32.0.94.ge083fb24f6

