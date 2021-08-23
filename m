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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC318C432BE
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 10:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF7A56137D
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 10:44:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235421AbhHWKpO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 06:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234962AbhHWKpB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 06:45:01 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EBE6C06175F
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 03:44:17 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id z4so9966962wrr.6
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 03:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EtePsMPUARz/2ZbW7R61SPXNBQelPtsLroTGowPYI5c=;
        b=Pxuu9iJeXEdgeBy42vB84eayqg6nbFgvNwBGBQSZwFABaQC3MtB1nYGDoneJEdKmUc
         qoeyhBWcUEwrtEanD5xf6yHyw/+EeN1Jxa+5mfYYQAfMV5i2uyOACpCL+x0wkq1DkcIP
         hWdM8eJwJKivxz7LpDMkLDw39DdaHyzZLTB9AeDvS0Iwy7cEhDHCeQDsXXYSA6Af3VHe
         xB7jHxXH472ZMZBBNbztYeBEGs3vg5T4NuWeXvHVjjZsbmwWT+lfRhMp8+9f3pyOpSri
         HgYUvH9Tw5+dbKC4OLd7iBT481y0g0bWr/jDD+QvKj+tUqNW4s/0QIYQHNf6/frDcyEg
         h2rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EtePsMPUARz/2ZbW7R61SPXNBQelPtsLroTGowPYI5c=;
        b=AyB1n5+9ridnfwe2E1cEBviJ3h8Gkbp6z0Lw3902vNzlDredyxlJVffHJZNjKHCzV2
         4Ewpt9pI6kgCH92SYowsVdnbHClv79dDlBHIfQpakLyP9xmKGt4/WlFiCUmjoUnrU6za
         weZ50b5SXb/gcSejSy6z4f9uARKcgTGdHIVM82DFZw6LCrW1TIBYyur7f2Dec8/Spciy
         nEUe6HcOOiuN3+DO+xdbFA6fOnII3D1XjU3YAwYBm5Tb0AIM3cV/IbPS/Sot9hl3HqNS
         s+yqx7TtJLw944YMHhyy7Nb17D/YocVZr82sWI8n3yMhwUGzky9+sF1jQJqM6M3r3Q12
         E1GA==
X-Gm-Message-State: AOAM530POs0mdjqkekfO8vbQWYjK6P0O9RiFeO8KbD6KUSzctaXvosh6
        q8yn1ptV6so9xVQDC/6q9kczC773+juAapjq
X-Google-Smtp-Source: ABdhPJxJs9sPtwpQB8gcF1eQy9taR8xD0G9ceWA0u7sgfrQpKG1tR8jG+Ucg6zsftm85kHckGRS8ZQ==
X-Received: by 2002:a5d:4311:: with SMTP id h17mr12775113wrq.263.1629715455045;
        Mon, 23 Aug 2021 03:44:15 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k12sm15351187wrd.75.2021.08.23.03.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 03:44:14 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Ben Boeckel <mathstuf@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 2/4] advice: remove read uses of most global `advice_` variables
Date:   Mon, 23 Aug 2021 12:44:00 +0200
Message-Id: <patch-v4-2.4-3869bda3b39-20210823T103719Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.663.gfcc3c7013a8
In-Reply-To: <cover-v4-0.4-00000000000-20210823T103719Z-avarab@gmail.com>
References: <RFC-cover-v3-0.4-0000000000-20210806T191231Z-avarab@gmail.com> <cover-v4-0.4-00000000000-20210823T103719Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ben Boeckel <mathstuf@gmail.com>

In c4a09cc9ccb (Merge branch 'hw/advise-ng', 2020-03-25), a new API for
accessing advice variables was introduced and deprecated `advice_config`
in favor of a new array, `advice_setting`.

This patch ports all but two uses which read the status of the global
`advice_` variables over to the new `advice_enabled` API. We'll deal
with advice_add_embedded_repo and advice_graft_file_deprecated
separately.

Signed-off-by: Ben Boeckel <mathstuf@gmail.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 advice.c                    | 63 ++-----------------------------------
 advice.h                    | 28 -----------------
 branch.c                    |  2 +-
 builtin/add.c               |  4 +--
 builtin/am.c                |  2 +-
 builtin/checkout.c          |  6 ++--
 builtin/clone.c             |  2 +-
 builtin/commit.c            |  4 +--
 builtin/fetch.c             |  2 +-
 builtin/merge.c             |  4 +--
 builtin/push.c              | 12 +++----
 builtin/reset.c             |  2 +-
 builtin/rm.c                |  2 +-
 builtin/submodule--helper.c |  2 +-
 editor.c                    |  2 +-
 notes-merge.c               |  2 +-
 object-name.c               |  2 +-
 remote.c                    | 12 +++----
 run-command.c               |  2 +-
 sequencer.c                 |  8 ++---
 unpack-trees.c              | 18 +++++------
 wt-status.c                 |  6 ++--
 22 files changed, 50 insertions(+), 137 deletions(-)

diff --git a/advice.c b/advice.c
index 6da51be63c1..b18833bc807 100644
--- a/advice.c
+++ b/advice.c
@@ -4,36 +4,8 @@
 #include "help.h"
 #include "string-list.h"
 
-int advice_fetch_show_forced_updates = 1;
-int advice_push_update_rejected = 1;
-int advice_push_non_ff_current = 1;
-int advice_push_non_ff_matching = 1;
-int advice_push_already_exists = 1;
-int advice_push_fetch_first = 1;
-int advice_push_needs_force = 1;
-int advice_push_unqualified_ref_name = 1;
-int advice_push_ref_needs_update = 1;
-int advice_status_hints = 1;
-int advice_status_u_option = 1;
-int advice_status_ahead_behind_warning = 1;
-int advice_commit_before_merge = 1;
-int advice_reset_quiet_warning = 1;
-int advice_resolve_conflict = 1;
-int advice_sequencer_in_use = 1;
-int advice_implicit_identity = 1;
-int advice_detached_head = 1;
-int advice_set_upstream_failure = 1;
-int advice_object_name_warning = 1;
-int advice_amworkdir = 1;
-int advice_rm_hints = 1;
 int advice_add_embedded_repo = 1;
-int advice_ignored_hook = 1;
-int advice_waiting_for_editor = 1;
 int advice_graft_file_deprecated = 1;
-int advice_checkout_ambiguous_remote_branch_name = 1;
-int advice_submodule_alternate_error_strategy_die = 1;
-int advice_add_ignored_file = 1;
-int advice_add_empty_pathspec = 1;
 
 static int advice_use_color = -1;
 static char advice_colors[][COLOR_MAXLEN] = {
@@ -66,39 +38,8 @@ static struct {
 	const char *name;
 	int *preference;
 } advice_config[] = {
-	{ "fetchShowForcedUpdates", &advice_fetch_show_forced_updates },
-	{ "pushUpdateRejected", &advice_push_update_rejected },
-	{ "pushNonFFCurrent", &advice_push_non_ff_current },
-	{ "pushNonFFMatching", &advice_push_non_ff_matching },
-	{ "pushAlreadyExists", &advice_push_already_exists },
-	{ "pushFetchFirst", &advice_push_fetch_first },
-	{ "pushNeedsForce", &advice_push_needs_force },
-	{ "pushUnqualifiedRefName", &advice_push_unqualified_ref_name },
-	{ "pushRefNeedsUpdate", &advice_push_ref_needs_update },
-	{ "statusHints", &advice_status_hints },
-	{ "statusUoption", &advice_status_u_option },
-	{ "statusAheadBehindWarning", &advice_status_ahead_behind_warning },
-	{ "commitBeforeMerge", &advice_commit_before_merge },
-	{ "resetQuiet", &advice_reset_quiet_warning },
-	{ "resolveConflict", &advice_resolve_conflict },
-	{ "sequencerInUse", &advice_sequencer_in_use },
-	{ "implicitIdentity", &advice_implicit_identity },
-	{ "detachedHead", &advice_detached_head },
-	{ "setUpstreamFailure", &advice_set_upstream_failure },
-	{ "objectNameWarning", &advice_object_name_warning },
-	{ "amWorkDir", &advice_amworkdir },
-	{ "rmHints", &advice_rm_hints },
 	{ "addEmbeddedRepo", &advice_add_embedded_repo },
-	{ "ignoredHook", &advice_ignored_hook },
-	{ "waitingForEditor", &advice_waiting_for_editor },
 	{ "graftFileDeprecated", &advice_graft_file_deprecated },
-	{ "checkoutAmbiguousRemoteBranchName", &advice_checkout_ambiguous_remote_branch_name },
-	{ "submoduleAlternateErrorStrategyDie", &advice_submodule_alternate_error_strategy_die },
-	{ "addIgnoredFile", &advice_add_ignored_file },
-	{ "addEmptyPathspec", &advice_add_empty_pathspec },
-
-	/* make this an alias for backward compatibility */
-	{ "pushNonFastForward", &advice_push_update_rejected }
 };
 
 static struct {
@@ -264,7 +205,7 @@ int error_resolve_conflict(const char *me)
 		error(_("It is not possible to %s because you have unmerged files."),
 			me);
 
-	if (advice_resolve_conflict)
+	if (advice_enabled(ADVICE_RESOLVE_CONFLICT))
 		/*
 		 * Message used both when 'git commit' fails and when
 		 * other commands doing a merge do.
@@ -283,7 +224,7 @@ void NORETURN die_resolve_conflict(const char *me)
 void NORETURN die_conclude_merge(void)
 {
 	error(_("You have not concluded your merge (MERGE_HEAD exists)."));
-	if (advice_resolve_conflict)
+	if (advice_enabled(ADVICE_RESOLVE_CONFLICT))
 		advise(_("Please, commit your changes before merging."));
 	die(_("Exiting because of unfinished merge."));
 }
diff --git a/advice.h b/advice.h
index 68629b5ba1d..ed51db0f057 100644
--- a/advice.h
+++ b/advice.h
@@ -5,36 +5,8 @@
 
 struct string_list;
 
-extern int advice_fetch_show_forced_updates;
-extern int advice_push_update_rejected;
-extern int advice_push_non_ff_current;
-extern int advice_push_non_ff_matching;
-extern int advice_push_already_exists;
-extern int advice_push_fetch_first;
-extern int advice_push_needs_force;
-extern int advice_push_unqualified_ref_name;
-extern int advice_push_ref_needs_update;
-extern int advice_status_hints;
-extern int advice_status_u_option;
-extern int advice_status_ahead_behind_warning;
-extern int advice_commit_before_merge;
-extern int advice_reset_quiet_warning;
-extern int advice_resolve_conflict;
-extern int advice_sequencer_in_use;
-extern int advice_implicit_identity;
-extern int advice_detached_head;
-extern int advice_set_upstream_failure;
-extern int advice_object_name_warning;
-extern int advice_amworkdir;
-extern int advice_rm_hints;
 extern int advice_add_embedded_repo;
-extern int advice_ignored_hook;
-extern int advice_waiting_for_editor;
 extern int advice_graft_file_deprecated;
-extern int advice_checkout_ambiguous_remote_branch_name;
-extern int advice_submodule_alternate_error_strategy_die;
-extern int advice_add_ignored_file;
-extern int advice_add_empty_pathspec;
 
 /*
  * To add a new advice, you need to:
diff --git a/branch.c b/branch.c
index 7a88a4861e7..07a46430b38 100644
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
index 09e684585d9..cf29b302d44 100644
--- a/builtin/add.c
+++ b/builtin/add.c
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
index 0c2ad96b70e..ff7dd33fcd4 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1820,7 +1820,7 @@ static void am_run(struct am_state *state, int resume)
 			printf_ln(_("Patch failed at %s %.*s"), msgnum(state),
 				linelen(state->msg), state->msg);
 
-			if (advice_amworkdir)
+			if (advice_enabled(ADVICE_AM_WORK_DIR))
 				advise(_("Use 'git am --show-current-patch=diff' to see the failed patch"));
 
 			die_user_resolve(state);
diff --git a/builtin/checkout.c b/builtin/checkout.c
index b5d477919a7..1c6307d456b 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -918,7 +918,7 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
 			   REF_NO_DEREF, UPDATE_REFS_DIE_ON_ERR);
 		if (!opts->quiet) {
 			if (old_branch_info->path &&
-			    advice_detached_head && !opts->force_detach)
+			    advice_enabled(ADVICE_DETACHED_HEAD) && !opts->force_detach)
 				detach_advice(new_branch_info->name);
 			describe_detached_head(_("HEAD is now at"), new_branch_info->commit);
 		}
@@ -1011,7 +1011,7 @@ static void suggest_reattach(struct commit *commit, struct rev_info *revs)
 		sb.buf);
 	strbuf_release(&sb);
 
-	if (advice_detached_head)
+	if (advice_enabled(ADVICE_DETACHED_HEAD))
 		fprintf(stderr,
 			Q_(
 			/* The singular version */
@@ -1182,7 +1182,7 @@ static const char *parse_remote_branch(const char *arg,
 	}
 
 	if (!remote && num_matches > 1) {
-	    if (advice_checkout_ambiguous_remote_branch_name) {
+	    if (advice_enabled(ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME)) {
 		    advise(_("If you meant to check out a remote tracking branch on, e.g. 'origin',\n"
 			     "you can do so by fully qualifying the name with the --track option:\n"
 			     "\n"
diff --git a/builtin/clone.c b/builtin/clone.c
index 66fe66679c8..c1603aa82ba 100644
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
index 243c626307c..df8bcc27ae9 100644
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
@@ -1033,7 +1033,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	 */
 	if (!committable && whence != FROM_MERGE && !allow_empty &&
 	    !(amend && is_a_merge(current_head))) {
-		s->hints = advice_status_hints;
+		s->hints = advice_enabled(ADVICE_STATUS_HINTS);
 		s->display_comment_prefix = old_display_comment_prefix;
 		run_status(stdout, index_file, prefix, 0, s);
 		if (amend)
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 25740c13df1..2501e1d10d9 100644
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
index 22f23990b37..1b3d98d5fd4 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1368,14 +1368,14 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
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
index e8b10a9b7ed..4b026ce6c6a 100644
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
diff --git a/builtin/reset.c b/builtin/reset.c
index 43e855cb887..51c9e2f43ff 100644
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
index 8a24c715e02..3b44b807e5f 100644
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
index ef2776a9e45..4da9781b991 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1724,7 +1724,7 @@ static int add_possible_reference_from_superproject(
 		} else {
 			switch (sas->error_mode) {
 			case SUBMODULE_ALTERNATE_ERROR_DIE:
-				if (advice_submodule_alternate_error_strategy_die)
+				if (advice_enabled(ADVICE_SUBMODULE_ALTERNATE_ERROR_STRATEGY_DIE))
 					advise(_(alternate_error_advice));
 				die(_("submodule '%s' cannot add alternate: %s"),
 				    sas->submodule_name, err.buf);
diff --git a/editor.c b/editor.c
index 6303ae0ab0d..fdd3eeafa94 100644
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
index 46c1f7c7f11..b4a3a903e86 100644
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
index 3263c19457f..fdff4601b2c 100644
--- a/object-name.c
+++ b/object-name.c
@@ -806,7 +806,7 @@ static int get_oid_basic(struct repository *r, const char *str, int len,
 			refs_found = repo_dwim_ref(r, str, len, &tmp_oid, &real_ref, 0);
 			if (refs_found > 0) {
 				warning(warn_msg, len, str);
-				if (advice_object_name_warning)
+				if (advice_enabled(ADVICE_OBJECT_NAME_WARNING))
 					fprintf(stderr, "%s\n", _(object_name_msg));
 			}
 			free(real_ref);
diff --git a/remote.c b/remote.c
index dfb863d8083..4ef53a6e30b 100644
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
index f72e72cce73..28e3eb57328 100644
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
index 7f07cd00f3f..ab63eede45b 100644
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
index 5786645f315..d9907faf7b6 100644
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
index eaed30eafba..e4f29b2b4c9 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -787,7 +787,7 @@ static void wt_status_collect_untracked(struct wt_status *s)
 
 	dir_clear(&dir);
 
-	if (advice_status_u_option)
+	if (advice_enabled(ADVICE_STATUS_U_OPTION))
 		s->untracked_in_ms = (getnanotime() - t_begin) / 1000000;
 }
 
@@ -1158,7 +1158,7 @@ static void wt_longstatus_print_tracking(struct wt_status *s)
 	if (!format_tracking_info(branch, &sb, s->ahead_behind_flags))
 		return;
 
-	if (advice_status_ahead_behind_warning &&
+	if (advice_enabled(ADVICE_STATUS_AHEAD_BEHIND_WARNING) &&
 	    s->ahead_behind_flags == AHEAD_BEHIND_FULL) {
 		uint64_t t_delta_in_ms = (getnanotime() - t_begin) / 1000000;
 		if (t_delta_in_ms > AB_DELAY_WARNING_IN_MS) {
@@ -1845,7 +1845,7 @@ static void wt_longstatus_print(struct wt_status *s)
 		wt_longstatus_print_other(s, &s->untracked, _("Untracked files"), "add");
 		if (s->show_ignored_mode)
 			wt_longstatus_print_other(s, &s->ignored, _("Ignored files"), "add -f");
-		if (advice_status_u_option && 2000 < s->untracked_in_ms) {
+		if (advice_enabled(ADVICE_STATUS_U_OPTION) && 2000 < s->untracked_in_ms) {
 			status_printf_ln(s, GIT_COLOR_NORMAL, "%s", "");
 			status_printf_ln(s, GIT_COLOR_NORMAL,
 					 _("It took %.2f seconds to enumerate untracked files. 'status -uno'\n"
-- 
2.33.0.663.gfcc3c7013a8

