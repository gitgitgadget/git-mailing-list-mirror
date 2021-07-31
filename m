Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0631FC4338F
	for <git@archiver.kernel.org>; Sat, 31 Jul 2021 02:25:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9D6C60F46
	for <git@archiver.kernel.org>; Sat, 31 Jul 2021 02:25:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236661AbhGaCZc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Jul 2021 22:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235754AbhGaCZ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jul 2021 22:25:27 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2794CC0613D3
        for <git@vger.kernel.org>; Fri, 30 Jul 2021 19:25:17 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id h10so7817621qth.5
        for <git@vger.kernel.org>; Fri, 30 Jul 2021 19:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/TNxEKpzPorlAAxfKgSWGhfsRyYbjAtTHXdP74Y7Sa0=;
        b=LtQuepJ2rNKaUzoh/iF8DskQ2tm4rS66szYcZfdhKjKyLwvmnXh5y45b3c2/sBBtHa
         NwaPAK5/On14n7RW/vkml4DdFXV9uD62piQOfCPpeJnPn6O5FqeczBTYgMhw9xf7IBVb
         pID8qiGfjiYDRw+7BVORCzS4qtfLIrWZNr8ySynkN0w8UN444DDG/UazQbhGKH9f0FcE
         hVz0+qWkJ+6bAZqBmvczbIZnTepmUAPlCDXCslWW+Qk8OHPrqJz5SdAxKZQHtf5bsUKS
         pBO5TRDl73YfZGY3pGh8e7Qk0P/5Or3p9ORhHQsyUZRaEmfqAWzTrt0S0P7X1Cit11mh
         ff7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/TNxEKpzPorlAAxfKgSWGhfsRyYbjAtTHXdP74Y7Sa0=;
        b=krTSGNhMUfCN+ktrhmzvFe5Mtwx5QquEdNx9stM3QCRiq6o9algoZJxsegBdQU+4vd
         FNwbWgdAYqsdlV0eIq2cFZUi1q5eArntSstzPQCPdhIzjRFKr7Qfe594Aaa0dLuOTQIs
         TE1kZy1ZISWLR2C4QW/ehPt+TLN2KhTCTlX5rLbJlduG3PLVhRnPsuJuZXW7tzAuLVWx
         K65vqaGmOKcu9GtN9EkDcmDRqLiumpfvR/XPnbF5f1Gxc7QDIPtoEk2SBhkkufR7PMtM
         Q+ZV+PiaCu27TlMSlUrHGeKpwpC6QLCXtoo/sHNis8smE0o/Pgh1XVMfbWHDg4DmUPMS
         oIIw==
X-Gm-Message-State: AOAM532yGF8m7u6yKvqBDpf3XdQIDzhNztVtEdecsCj7pKDx7D5t0L3W
        cs6ICr9rMY1bDKg00ypwiab3ZYUggoEuBA==
X-Google-Smtp-Source: ABdhPJxoX0HsmcL+3laArn/cxiwoYcDpWeBEdc/tVCz8d8SLAzuTc7aDNgdhd9WoLnDSMknvSJJGFg==
X-Received: by 2002:ac8:734b:: with SMTP id q11mr4994534qtp.105.1627698316092;
        Fri, 30 Jul 2021 19:25:16 -0700 (PDT)
Received: from localhost ([24.169.20.255])
        by smtp.gmail.com with ESMTPSA id o63sm1924246qkf.4.2021.07.30.19.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 19:25:15 -0700 (PDT)
From:   Ben Boeckel <mathstuf@gmail.com>
To:     git@vger.kernel.org
Cc:     Ben Boeckel <mathstuf@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v1 3/4] advice: remove uses of global `advice_` variables
Date:   Fri, 30 Jul 2021 22:25:03 -0400
Message-Id: <20210731022504.1912702-4-mathstuf@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210731022504.1912702-1-mathstuf@gmail.com>
References: <20210731022504.1912702-1-mathstuf@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are now function APIs to access this information, so the global
variables are no longer needed to communicate their values.

Signed-off-by: Ben Boeckel <mathstuf@gmail.com>
---
 advice.c                    |  4 ++--
 branch.c                    |  2 +-
 builtin/add.c               |  8 ++++----
 builtin/am.c                |  2 +-
 builtin/checkout.c          |  6 +++---
 builtin/clone.c             |  2 +-
 builtin/commit.c            |  4 ++--
 builtin/fetch.c             |  2 +-
 builtin/merge.c             |  4 ++--
 builtin/push.c              | 12 ++++++------
 builtin/replace.c           |  2 +-
 builtin/reset.c             |  2 +-
 builtin/rm.c                |  2 +-
 builtin/submodule--helper.c |  2 +-
 commit.c                    |  2 +-
 editor.c                    |  2 +-
 notes-merge.c               |  2 +-
 object-name.c               |  2 +-
 remote.c                    | 12 ++++++------
 run-command.c               |  2 +-
 sequencer.c                 |  8 ++++----
 unpack-trees.c              | 18 +++++++++---------
 wt-status.c                 |  6 +++---
 23 files changed, 54 insertions(+), 54 deletions(-)

diff --git a/advice.c b/advice.c
index fd9634aa4f..ee4edc5e28 100644
--- a/advice.c
+++ b/advice.c
@@ -269,7 +269,7 @@ int error_resolve_conflict(const char *me)
 		error(_("It is not possible to %s because you have unmerged files."),
 			me);
 
-	if (advice_resolve_conflict)
+	if (advice_enabled(ADVICE_RESOLVE_CONFLICT))
 		/*
 		 * Message used both when 'git commit' fails and when
 		 * other commands doing a merge do.
@@ -288,7 +288,7 @@ void NORETURN die_resolve_conflict(const char *me)
 void NORETURN die_conclude_merge(void)
 {
 	error(_("You have not concluded your merge (MERGE_HEAD exists)."));
-	if (advice_resolve_conflict)
+	if (advice_enabled(ADVICE_RESOLVE_CONFLICT))
 		advise(_("Please, commit your changes before merging."));
 	die(_("Exiting because of unfinished merge."));
 }
diff --git a/branch.c b/branch.c
index 7a88a4861e..07a46430b3 100644
--- a/branch.c
+++ b/branch.c
@@ -271,7 +271,7 @@ void create_branch(struct repository *r,
 	real_ref = NULL;
 	if (get_oid_mb(start_name, &oid)) {
 		if (explicit_tracking) {
-			if (advice_set_upstream_failure) {
+			if (advice_enabled(ADVICE_SET_UPSTREAM_FAILURE)) {
 				error(_(upstream_missing), start_name);
 				advise(_(upstream_advice));
 				exit(1);
diff --git a/builtin/add.c b/builtin/add.c
index 09e684585d..3d1fd64294 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -430,10 +430,10 @@ static void check_embedded_repo(const char *path)
 	strbuf_strip_suffix(&name, "/");
 
 	warning(_("adding embedded git repository: %s"), name.buf);
-	if (advice_add_embedded_repo) {
+	if (advice_enabled(ADVICE_ADD_EMBEDDED_REPO)) {
 		advise(embedded_advice, name.buf, name.buf);
 		/* there may be multiple entries; advise only once */
-		advice_add_embedded_repo = 0;
+		advice_set(ADVICE_ADD_EMBEDDED_REPO, 0);
 	}
 
 	strbuf_release(&name);
@@ -447,7 +447,7 @@ static int add_files(struct dir_struct *dir, int flags)
 		fprintf(stderr, _(ignore_error));
 		for (i = 0; i < dir->ignored_nr; i++)
 			fprintf(stderr, "%s\n", dir->ignored[i]->name);
-		if (advice_add_ignored_file)
+		if (advice_enabled(ADVICE_ADD_IGNORED_FILE))
 			advise(_("Use -f if you really want to add them.\n"
 				"Turn this message off by running\n"
 				"\"git config advice.addIgnoredFile false\""));
@@ -553,7 +553,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 
 	if (require_pathspec && pathspec.nr == 0) {
 		fprintf(stderr, _("Nothing specified, nothing added.\n"));
-		if (advice_add_empty_pathspec)
+		if (advice_enabled(ADVICE_ADD_EMPTY_PATHSPEC))
 			advise( _("Maybe you wanted to say 'git add .'?\n"
 				"Turn this message off by running\n"
 				"\"git config advice.addEmptyPathspec false\""));
diff --git a/builtin/am.c b/builtin/am.c
index 0b2d886c81..040435de8f 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1819,7 +1819,7 @@ static void am_run(struct am_state *state, int resume)
 			printf_ln(_("Patch failed at %s %.*s"), msgnum(state),
 				linelen(state->msg), state->msg);
 
-			if (advice_amworkdir)
+			if (advice_enabled(ADVICE_AM_WORK_DIR))
 				advise(_("Use 'git am --show-current-patch=diff' to see the failed patch"));
 
 			die_user_resolve(state);
diff --git a/builtin/checkout.c b/builtin/checkout.c
index f4cd7747d3..6d696cf304 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -923,7 +923,7 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
 			   REF_NO_DEREF, UPDATE_REFS_DIE_ON_ERR);
 		if (!opts->quiet) {
 			if (old_branch_info->path &&
-			    advice_detached_head && !opts->force_detach)
+			    advice_enabled(ADVICE_DETACHED_HEAD) && !opts->force_detach)
 				detach_advice(new_branch_info->name);
 			describe_detached_head(_("HEAD is now at"), new_branch_info->commit);
 		}
@@ -1016,7 +1016,7 @@ static void suggest_reattach(struct commit *commit, struct rev_info *revs)
 		sb.buf);
 	strbuf_release(&sb);
 
-	if (advice_detached_head)
+	if (advice_enabled(ADVICE_DETACHED_HEAD))
 		fprintf(stderr,
 			Q_(
 			/* The singular version */
@@ -1187,7 +1187,7 @@ static const char *parse_remote_branch(const char *arg,
 	}
 
 	if (!remote && num_matches > 1) {
-	    if (advice_checkout_ambiguous_remote_branch_name) {
+	    if (advice_enabled(ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME)) {
 		    advise(_("If you meant to check out a remote tracking branch on, e.g. 'origin',\n"
 			     "you can do so by fully qualifying the name with the --track option:\n"
 			     "\n"
diff --git a/builtin/clone.c b/builtin/clone.c
index 66fe66679c..c1603aa82b 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -786,7 +786,7 @@ static int checkout(int submodule_progress)
 		return 0;
 	}
 	if (!strcmp(head, "HEAD")) {
-		if (advice_detached_head)
+		if (advice_enabled(ADVICE_DETACHED_HEAD))
 			detach_advice(oid_to_hex(&oid));
 		FREE_AND_NULL(head);
 	} else {
diff --git a/builtin/commit.c b/builtin/commit.c
index 190d215d43..9566b030af 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -203,7 +203,7 @@ static void status_init_config(struct wt_status *s, config_fn_t fn)
 	init_diff_ui_defaults();
 	git_config(fn, s);
 	determine_whence(s);
-	s->hints = advice_status_hints; /* must come after git_config() */
+	s->hints = advice_enabled(ADVICE_STATUS_HINTS); /* must come after git_config() */
 }
 
 static void rollback_index_files(void)
@@ -1026,7 +1026,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	 */
 	if (!committable && whence != FROM_MERGE && !allow_empty &&
 	    !(amend && is_a_merge(current_head))) {
-		s->hints = advice_status_hints;
+		s->hints = advice_enabled(ADVICE_STATUS_HINTS);
 		s->display_comment_prefix = old_display_comment_prefix;
 		run_status(stdout, index_file, prefix, 0, s);
 		if (amend)
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 25740c13df..2501e1d10d 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1229,7 +1229,7 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 		      " 'git remote prune %s' to remove any old, conflicting "
 		      "branches"), remote_name);
 
-	if (advice_fetch_show_forced_updates) {
+	if (advice_enabled(ADVICE_FETCH_SHOW_FORCED_UPDATES)) {
 		if (!fetch_show_forced_updates) {
 			warning(_(warn_show_forced_updates));
 		} else if (forced_updates_ms > FORCED_UPDATES_DELAY_WARNING_IN_MS) {
diff --git a/builtin/merge.c b/builtin/merge.c
index a8a843b1f5..2efb16626c 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1367,14 +1367,14 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		 * There is no unmerged entry, don't advise 'git
 		 * add/rm <file>', just 'git commit'.
 		 */
-		if (advice_resolve_conflict)
+		if (advice_enabled(ADVICE_RESOLVE_CONFLICT))
 			die(_("You have not concluded your merge (MERGE_HEAD exists).\n"
 				  "Please, commit your changes before you merge."));
 		else
 			die(_("You have not concluded your merge (MERGE_HEAD exists)."));
 	}
 	if (ref_exists("CHERRY_PICK_HEAD")) {
-		if (advice_resolve_conflict)
+		if (advice_enabled(ADVICE_RESOLVE_CONFLICT))
 			die(_("You have not concluded your cherry-pick (CHERRY_PICK_HEAD exists).\n"
 			    "Please, commit your changes before you merge."));
 		else
diff --git a/builtin/push.c b/builtin/push.c
index e8b10a9b7e..4b026ce6c6 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -289,42 +289,42 @@ static const char message_advice_ref_needs_update[] =
 
 static void advise_pull_before_push(void)
 {
-	if (!advice_push_non_ff_current || !advice_push_update_rejected)
+	if (!advice_enabled(ADVICE_PUSH_NON_FF_CURRENT) || !advice_enabled(ADVICE_PUSH_UPDATE_REJECTED))
 		return;
 	advise(_(message_advice_pull_before_push));
 }
 
 static void advise_checkout_pull_push(void)
 {
-	if (!advice_push_non_ff_matching || !advice_push_update_rejected)
+	if (!advice_enabled(ADVICE_PUSH_NON_FF_MATCHING) || !advice_enabled(ADVICE_PUSH_UPDATE_REJECTED))
 		return;
 	advise(_(message_advice_checkout_pull_push));
 }
 
 static void advise_ref_already_exists(void)
 {
-	if (!advice_push_already_exists || !advice_push_update_rejected)
+	if (!advice_enabled(ADVICE_PUSH_ALREADY_EXISTS) || !advice_enabled(ADVICE_PUSH_UPDATE_REJECTED))
 		return;
 	advise(_(message_advice_ref_already_exists));
 }
 
 static void advise_ref_fetch_first(void)
 {
-	if (!advice_push_fetch_first || !advice_push_update_rejected)
+	if (!advice_enabled(ADVICE_PUSH_FETCH_FIRST) || !advice_enabled(ADVICE_PUSH_UPDATE_REJECTED))
 		return;
 	advise(_(message_advice_ref_fetch_first));
 }
 
 static void advise_ref_needs_force(void)
 {
-	if (!advice_push_needs_force || !advice_push_update_rejected)
+	if (!advice_enabled(ADVICE_PUSH_NEEDS_FORCE) || !advice_enabled(ADVICE_PUSH_UPDATE_REJECTED))
 		return;
 	advise(_(message_advice_ref_needs_force));
 }
 
 static void advise_ref_needs_update(void)
 {
-	if (!advice_push_ref_needs_update || !advice_push_update_rejected)
+	if (!advice_enabled(ADVICE_PUSH_REF_NEEDS_UPDATE) || !advice_enabled(ADVICE_PUSH_UPDATE_REJECTED))
 		return;
 	advise(_(message_advice_ref_needs_update));
 }
diff --git a/builtin/replace.c b/builtin/replace.c
index cd48765911..1340878021 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -507,7 +507,7 @@ static int convert_graft_file(int force)
 	if (!fp)
 		return -1;
 
-	advice_graft_file_deprecated = 0;
+	advice_set(ADVICE_GRAFT_FILE_DEPRECATED, 0);
 	while (strbuf_getline(&buf, fp) != EOF) {
 		if (*buf.buf == '#')
 			continue;
diff --git a/builtin/reset.c b/builtin/reset.c
index 43e855cb88..51c9e2f43f 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -412,7 +412,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 				refresh_index(&the_index, flags, NULL, NULL,
 					      _("Unstaged changes after reset:"));
 				t_delta_in_ms = (getnanotime() - t_begin) / 1000000;
-				if (advice_reset_quiet_warning && t_delta_in_ms > REFRESH_INDEX_DELAY_WARNING_IN_MS) {
+				if (advice_enabled(ADVICE_RESET_QUIET_WARNING) && t_delta_in_ms > REFRESH_INDEX_DELAY_WARNING_IN_MS) {
 					printf(_("\nIt took %.2f seconds to enumerate unstaged changes after reset.  You can\n"
 						"use '--quiet' to avoid this.  Set the config setting reset.quiet to true\n"
 						"to make this the default.\n"), t_delta_in_ms / 1000.0);
diff --git a/builtin/rm.c b/builtin/rm.c
index 8a24c715e0..3b44b807e5 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -55,7 +55,7 @@ static void print_error_files(struct string_list *files_list,
 			strbuf_addf(&err_msg,
 				    "\n    %s",
 				    files_list->items[i].string);
-		if (advice_rm_hints)
+		if (advice_enabled(ADVICE_RM_HINTS))
 			strbuf_addstr(&err_msg, hints_msg);
 		*errs = error("%s", err_msg.buf);
 		strbuf_release(&err_msg);
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index f73963ad67..e5a5dc6903 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1747,7 +1747,7 @@ static int add_possible_reference_from_superproject(
 		} else {
 			switch (sas->error_mode) {
 			case SUBMODULE_ALTERNATE_ERROR_DIE:
-				if (advice_submodule_alternate_error_strategy_die)
+				if (advice_enabled(ADVICE_SUBMODULE_ALTERNATE_ERROR_STRATEGY_DIE))
 					advise(_(alternate_error_advice));
 				die(_("submodule '%s' cannot add alternate: %s"),
 				    sas->submodule_name, err.buf);
diff --git a/commit.c b/commit.c
index 143f472c0f..17df05dce3 100644
--- a/commit.c
+++ b/commit.c
@@ -190,7 +190,7 @@ static int read_graft_file(struct repository *r, const char *graft_file)
 	struct strbuf buf = STRBUF_INIT;
 	if (!fp)
 		return -1;
-	if (advice_graft_file_deprecated)
+	if (advice_enabled(ADVICE_GRAFT_FILE_DEPRECATED))
 		advise(_("Support for <GIT_DIR>/info/grafts is deprecated\n"
 			 "and will be removed in a future Git version.\n"
 			 "\n"
diff --git a/editor.c b/editor.c
index 6303ae0ab0..fdd3eeafa9 100644
--- a/editor.c
+++ b/editor.c
@@ -58,7 +58,7 @@ static int launch_specified_editor(const char *editor, const char *path,
 		const char *args[] = { editor, NULL, NULL };
 		struct child_process p = CHILD_PROCESS_INIT;
 		int ret, sig;
-		int print_waiting_for_editor = advice_waiting_for_editor && isatty(2);
+		int print_waiting_for_editor = advice_enabled(ADVICE_WAITING_FOR_EDITOR) && isatty(2);
 
 		if (print_waiting_for_editor) {
 			/*
diff --git a/notes-merge.c b/notes-merge.c
index 46c1f7c7f1..b4a3a903e8 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -273,7 +273,7 @@ static void check_notes_merge_worktree(struct notes_merge_options *o)
 		 */
 		if (file_exists(git_path(NOTES_MERGE_WORKTREE)) &&
 		    !is_empty_dir(git_path(NOTES_MERGE_WORKTREE))) {
-			if (advice_resolve_conflict)
+			if (advice_enabled(ADVICE_RESOLVE_CONFLICT))
 				die(_("You have not concluded your previous "
 				    "notes merge (%s exists).\nPlease, use "
 				    "'git notes merge --commit' or 'git notes "
diff --git a/object-name.c b/object-name.c
index 64202de60b..23758190ed 100644
--- a/object-name.c
+++ b/object-name.c
@@ -812,7 +812,7 @@ static int get_oid_basic(struct repository *r, const char *str, int len,
 			refs_found = repo_dwim_ref(r, str, len, &tmp_oid, &real_ref, 0);
 			if (refs_found > 0) {
 				warning(warn_msg, len, str);
-				if (advice_object_name_warning)
+				if (advice_enabled(ADVICE_OBJECT_NAME_WARNING))
 					fprintf(stderr, "%s\n", _(object_name_msg));
 			}
 			free(real_ref);
diff --git a/remote.c b/remote.c
index dfb863d808..4ef53a6e30 100644
--- a/remote.c
+++ b/remote.c
@@ -1111,7 +1111,7 @@ static void show_push_unqualified_ref_name_error(const char *dst_value,
 		"Neither worked, so we gave up. You must fully qualify the ref."),
 	      dst_value, matched_src_name);
 
-	if (!advice_push_unqualified_ref_name)
+	if (!advice_enabled(ADVICE_PUSH_UNQUALIFIED_REF_NAME))
 		return;
 
 	if (get_oid(matched_src_name, &oid))
@@ -2118,7 +2118,7 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 		strbuf_addf(sb,
 			_("Your branch is based on '%s', but the upstream is gone.\n"),
 			base);
-		if (advice_status_hints)
+		if (advice_enabled(ADVICE_STATUS_HINTS))
 			strbuf_addstr(sb,
 				_("  (use \"git branch --unset-upstream\" to fixup)\n"));
 	} else if (!sti) {
@@ -2129,7 +2129,7 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 		strbuf_addf(sb,
 			    _("Your branch and '%s' refer to different commits.\n"),
 			    base);
-		if (advice_status_hints)
+		if (advice_enabled(ADVICE_STATUS_HINTS))
 			strbuf_addf(sb, _("  (use \"%s\" for details)\n"),
 				    "git status --ahead-behind");
 	} else if (!theirs) {
@@ -2138,7 +2138,7 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 			   "Your branch is ahead of '%s' by %d commits.\n",
 			   ours),
 			base, ours);
-		if (advice_status_hints)
+		if (advice_enabled(ADVICE_STATUS_HINTS))
 			strbuf_addstr(sb,
 				_("  (use \"git push\" to publish your local commits)\n"));
 	} else if (!ours) {
@@ -2149,7 +2149,7 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 			       "and can be fast-forwarded.\n",
 			   theirs),
 			base, theirs);
-		if (advice_status_hints)
+		if (advice_enabled(ADVICE_STATUS_HINTS))
 			strbuf_addstr(sb,
 				_("  (use \"git pull\" to update your local branch)\n"));
 	} else {
@@ -2162,7 +2162,7 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 			       "respectively.\n",
 			   ours + theirs),
 			base, ours, theirs);
-		if (advice_status_hints)
+		if (advice_enabled(ADVICE_STATUS_HINTS))
 			strbuf_addstr(sb,
 				_("  (use \"git pull\" to merge the remote branch into yours)\n"));
 	}
diff --git a/run-command.c b/run-command.c
index f72e72cce7..28e3eb5732 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1336,7 +1336,7 @@ const char *find_hook(const char *name)
 			err = errno;
 #endif
 
-		if (err == EACCES && advice_ignored_hook) {
+		if (err == EACCES && advice_enabled(ADVICE_IGNORED_HOOK)) {
 			static struct string_list advise_given = STRING_LIST_INIT_DUP;
 
 			if (!string_list_lookup(&advise_given, name)) {
diff --git a/sequencer.c b/sequencer.c
index 0bec01cf38..e0b4c86c1a 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -486,7 +486,7 @@ static int error_dirty_index(struct repository *repo, struct replay_opts *opts)
 	error(_("your local changes would be overwritten by %s."),
 		_(action_name(opts)));
 
-	if (advice_commit_before_merge)
+	if (advice_enabled(ADVICE_COMMIT_BEFORE_MERGE))
 		advise(_("commit your changes or stash them to proceed."));
 	return -1;
 }
@@ -1293,7 +1293,7 @@ void print_commit_summary(struct repository *r,
 	if (!committer_ident_sufficiently_given()) {
 		strbuf_addstr(&format, "\n Committer: ");
 		strbuf_addbuf_percentquote(&format, &committer_ident);
-		if (advice_implicit_identity) {
+		if (advice_enabled(ADVICE_IMPLICIT_IDENTITY)) {
 			strbuf_addch(&format, '\n');
 			strbuf_addstr(&format, implicit_ident_advice());
 		}
@@ -3041,7 +3041,7 @@ static int create_seq_dir(struct repository *r)
 	}
 	if (in_progress_error) {
 		error("%s", in_progress_error);
-		if (advice_sequencer_in_use)
+		if (advice_enabled(ADVICE_SEQUENCER_IN_USE))
 			advise(in_progress_advice,
 				advise_skip ? "--skip | " : "");
 		return -1;
@@ -3245,7 +3245,7 @@ int sequencer_skip(struct repository *r, struct replay_opts *opts)
 give_advice:
 	error(_("there is nothing to skip"));
 
-	if (advice_resolve_conflict) {
+	if (advice_enabled(ADVICE_RESOLVE_CONFLICT)) {
 		advise(_("have you committed already?\n"
 			 "try \"git %s --continue\""),
 			 action == REPLAY_REVERT ? "revert" : "cherry-pick");
diff --git a/unpack-trees.c b/unpack-trees.c
index f88a69f8e7..eb5015623b 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -111,17 +111,17 @@ void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
 	strvec_init(&opts->msgs_to_free);
 
 	if (!strcmp(cmd, "checkout"))
-		msg = advice_commit_before_merge
+		msg = advice_enabled(ADVICE_COMMIT_BEFORE_MERGE)
 		      ? _("Your local changes to the following files would be overwritten by checkout:\n%%s"
 			  "Please commit your changes or stash them before you switch branches.")
 		      : _("Your local changes to the following files would be overwritten by checkout:\n%%s");
 	else if (!strcmp(cmd, "merge"))
-		msg = advice_commit_before_merge
+		msg = advice_enabled(ADVICE_COMMIT_BEFORE_MERGE)
 		      ? _("Your local changes to the following files would be overwritten by merge:\n%%s"
 			  "Please commit your changes or stash them before you merge.")
 		      : _("Your local changes to the following files would be overwritten by merge:\n%%s");
 	else
-		msg = advice_commit_before_merge
+		msg = advice_enabled(ADVICE_COMMIT_BEFORE_MERGE)
 		      ? _("Your local changes to the following files would be overwritten by %s:\n%%s"
 			  "Please commit your changes or stash them before you %s.")
 		      : _("Your local changes to the following files would be overwritten by %s:\n%%s");
@@ -132,17 +132,17 @@ void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
 		_("Updating the following directories would lose untracked files in them:\n%s");
 
 	if (!strcmp(cmd, "checkout"))
-		msg = advice_commit_before_merge
+		msg = advice_enabled(ADVICE_COMMIT_BEFORE_MERGE)
 		      ? _("The following untracked working tree files would be removed by checkout:\n%%s"
 			  "Please move or remove them before you switch branches.")
 		      : _("The following untracked working tree files would be removed by checkout:\n%%s");
 	else if (!strcmp(cmd, "merge"))
-		msg = advice_commit_before_merge
+		msg = advice_enabled(ADVICE_COMMIT_BEFORE_MERGE)
 		      ? _("The following untracked working tree files would be removed by merge:\n%%s"
 			  "Please move or remove them before you merge.")
 		      : _("The following untracked working tree files would be removed by merge:\n%%s");
 	else
-		msg = advice_commit_before_merge
+		msg = advice_enabled(ADVICE_COMMIT_BEFORE_MERGE)
 		      ? _("The following untracked working tree files would be removed by %s:\n%%s"
 			  "Please move or remove them before you %s.")
 		      : _("The following untracked working tree files would be removed by %s:\n%%s");
@@ -150,17 +150,17 @@ void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
 		strvec_pushf(&opts->msgs_to_free, msg, cmd, cmd);
 
 	if (!strcmp(cmd, "checkout"))
-		msg = advice_commit_before_merge
+		msg = advice_enabled(ADVICE_COMMIT_BEFORE_MERGE)
 		      ? _("The following untracked working tree files would be overwritten by checkout:\n%%s"
 			  "Please move or remove them before you switch branches.")
 		      : _("The following untracked working tree files would be overwritten by checkout:\n%%s");
 	else if (!strcmp(cmd, "merge"))
-		msg = advice_commit_before_merge
+		msg = advice_enabled(ADVICE_COMMIT_BEFORE_MERGE)
 		      ? _("The following untracked working tree files would be overwritten by merge:\n%%s"
 			  "Please move or remove them before you merge.")
 		      : _("The following untracked working tree files would be overwritten by merge:\n%%s");
 	else
-		msg = advice_commit_before_merge
+		msg = advice_enabled(ADVICE_COMMIT_BEFORE_MERGE)
 		      ? _("The following untracked working tree files would be overwritten by %s:\n%%s"
 			  "Please move or remove them before you %s.")
 		      : _("The following untracked working tree files would be overwritten by %s:\n%%s");
diff --git a/wt-status.c b/wt-status.c
index c0dbf96749..1850251d8c 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -736,7 +736,7 @@ static void wt_status_collect_untracked(struct wt_status *s)
 
 	dir_clear(&dir);
 
-	if (advice_status_u_option)
+	if (advice_enabled(ADVICE_STATUS_U_OPTION))
 		s->untracked_in_ms = (getnanotime() - t_begin) / 1000000;
 }
 
@@ -1107,7 +1107,7 @@ static void wt_longstatus_print_tracking(struct wt_status *s)
 	if (!format_tracking_info(branch, &sb, s->ahead_behind_flags))
 		return;
 
-	if (advice_status_ahead_behind_warning &&
+	if (advice_enabled(ADVICE_STATUS_AHEAD_BEHIND_WARNING) &&
 	    s->ahead_behind_flags == AHEAD_BEHIND_FULL) {
 		uint64_t t_delta_in_ms = (getnanotime() - t_begin) / 1000000;
 		if (t_delta_in_ms > AB_DELAY_WARNING_IN_MS) {
@@ -1786,7 +1786,7 @@ static void wt_longstatus_print(struct wt_status *s)
 		wt_longstatus_print_other(s, &s->untracked, _("Untracked files"), "add");
 		if (s->show_ignored_mode)
 			wt_longstatus_print_other(s, &s->ignored, _("Ignored files"), "add -f");
-		if (advice_status_u_option && 2000 < s->untracked_in_ms) {
+		if (advice_enabled(ADVICE_STATUS_U_OPTION) && 2000 < s->untracked_in_ms) {
 			status_printf_ln(s, GIT_COLOR_NORMAL, "%s", "");
 			status_printf_ln(s, GIT_COLOR_NORMAL,
 					 _("It took %.2f seconds to enumerate untracked files. 'status -uno'\n"
-- 
2.31.1

