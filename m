Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_06_12,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24DCE1F597
	for <e@80x24.org>; Sun, 15 Jul 2018 21:56:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbeGOWVJ (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Jul 2018 18:21:09 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:34987 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726940AbeGOWVJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Jul 2018 18:21:09 -0400
Received: by mail-pl0-f67.google.com with SMTP id w3-v6so1273994plq.2
        for <git@vger.kernel.org>; Sun, 15 Jul 2018 14:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+MNwXtpMoaIMz2PSXJxpcB9ke/mnRxaJrfDyhzpH22w=;
        b=ZII4lUQ+HprKtRtV2BNHsCacrW9UUfLRkpPR8JZIyfzcZpJzuS3SNud658Xijra1ti
         s273IdW6CMknGz4ccCg6Thrw9VKsG6mT1VSSKMpHB4RJmxnFEaaXGxSJ6HPTal/2aCb4
         jKQ0HKwBI9NGdstGnOs5mKx7/1F7Ce8JfyHMGokOIgXgwQlm7UMAeNFT6qcRjpe3vQ9k
         Fu5ShfQgbuDkxz0SbcxE0hR3Pnq+GaPMtIeav8ISe2zag1qoMX0QunVqpC/oo4B70VDn
         Bee6YNQSLEEuATrgrlTZ6YRfY41nwznYXBM7EWqcplD5TezzafJuw0Mm1oxOSZluRiCn
         K5WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+MNwXtpMoaIMz2PSXJxpcB9ke/mnRxaJrfDyhzpH22w=;
        b=Owho9aPvK0BIllb0umg0BpXju1Q5FAuQZo49yODDYY4gr0dvsRk/OVW7IXTB8srW9k
         Jhd8AQdGNNsp+/8y/IyrNLYrhefkuLXqNWL3WKg0FqjkOniHXpiHjuPTnPk5nwOurUB0
         n5R8ipd7JfTPn7wv0qzolsBf6BkMibFQp/5nOlpRR39VXxa5Hwmsjnuhm+lE5/y1cm7f
         dMQkLgCIIIRZ5tbs2UB1CRipoFAHJdGXQz0FocviPbnXZszHOSloHEfGALHQahC1PIpO
         +Qnk0ElGma/imq0fn/fFYQQ0ZgEuG8DX4Cck8C7F1SlqBmC5NkjHzbgl+QtJahHX2iVG
         cE4w==
X-Gm-Message-State: AOUpUlGnB2htTOcYJZ8VTjxgJt5myyq6Y0q7rcgS+lBz1JGbzN7XWCKp
        WmDlffVN84cQ0bDTPBFaFt62avwY
X-Google-Smtp-Source: AAOMgpdAbyqG8pWb8bwvvmy5l3KCavjNX6XrHIRCfSrK414ZoEMVcF6x4Er38hYHXciXVe3iRXLaGw==
X-Received: by 2002:a17:902:7891:: with SMTP id q17-v6mr14612183pll.186.1531691806914;
        Sun, 15 Jul 2018 14:56:46 -0700 (PDT)
Received: from localhost.localdomain (adsl-76-236-28-204.dsl.chi2ca.sbcglobal.net. [76.236.28.204])
        by smtp.gmail.com with ESMTPSA id e82-v6sm81924819pfk.87.2018.07.15.14.56.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Jul 2018 14:56:46 -0700 (PDT)
From:   Samuel Lijin <sxlijin@gmail.com>
To:     git@vger.kernel.org
Cc:     Samuel Lijin <sxlijin@gmail.com>
Subject: [PATCH v3 2/3] wt-status: teach wt_status_collect about merges in progress
Date:   Sun, 15 Jul 2018 07:08:06 -0400
Message-Id: <20180715110807.25544-3-sxlijin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180426092524.25264-1-sxlijin@gmail.com>
References: <20180426092524.25264-1-sxlijin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To fix the breakages documented by t7501, the next patch in this series
will teach wt_status_collect() to set the committable bit, instead of
having wt_longstatus_print_updated() and show_merge_in_progress() set it
(which is what currently happens). Unfortunately, wt_status_collect()
needs to know whether or not there is a merge in progress to set the bit
correctly, so teach its (two) callers to create, initialize, and pass
in instances of wt_status_state, which records this metadata.

Since wt_longstatus_print() and show_merge_in_progress() are in the same
callpaths and currently create and init copies of wt_status_state,
remove that logic and instead pass wt_status_state through.

Make wt_status_get_state easier to use, add a helper method to clean up
wt_status_state, const-ify as many struct pointers in method signatures
as possible, and add a FIXME for a struct pointer which should be const
but isn't (that this patch series will not address).

Signed-off-by: Samuel Lijin <sxlijin@gmail.com>
---
 builtin/commit.c |  32 ++++----
 ref-filter.c     |   3 +-
 wt-status.c      | 188 +++++++++++++++++++++++------------------------
 wt-status.h      |  13 ++--
 4 files changed, 120 insertions(+), 116 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 37fcb55ab..79ef4f11a 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -463,6 +463,7 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
 static int run_status(FILE *fp, const char *index_file, const char *prefix, int nowarn,
 		      struct wt_status *s)
 {
+	struct wt_status_state state;
 	struct object_id oid;
 
 	if (s->relative_paths)
@@ -482,10 +483,12 @@ static int run_status(FILE *fp, const char *index_file, const char *prefix, int
 	s->status_format = status_format;
 	s->ignore_submodule_arg = ignore_submodule_arg;
 
-	wt_status_collect(s);
-	wt_status_print(s);
+	wt_status_get_state(s, &state);
+	wt_status_collect(s, &state);
+	wt_status_print(s, &state);
+	wt_status_clear_state(&state);
 
-	return s->commitable;
+	return s->committable;
 }
 
 static int is_a_merge(const struct commit *current_head)
@@ -631,7 +634,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 {
 	struct stat statbuf;
 	struct strbuf committer_ident = STRBUF_INIT;
-	int commitable;
+	int committable;
 	struct strbuf sb = STRBUF_INIT;
 	const char *hook_arg1 = NULL;
 	const char *hook_arg2 = NULL;
@@ -848,7 +851,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 
 		saved_color_setting = s->use_color;
 		s->use_color = 0;
-		commitable = run_status(s->fp, index_file, prefix, 1, s);
+		committable = run_status(s->fp, index_file, prefix, 1, s);
 		s->use_color = saved_color_setting;
 	} else {
 		struct object_id oid;
@@ -866,7 +869,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 			for (i = 0; i < active_nr; i++)
 				if (ce_intent_to_add(active_cache[i]))
 					ita_nr++;
-			commitable = active_nr - ita_nr > 0;
+			committable = active_nr - ita_nr > 0;
 		} else {
 			/*
 			 * Unless the user did explicitly request a submodule
@@ -882,7 +885,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 			if (ignore_submodule_arg &&
 			    !strcmp(ignore_submodule_arg, "all"))
 				flags.ignore_submodules = 1;
-			commitable = index_differs_from(parent, &flags, 1);
+			committable = index_differs_from(parent, &flags, 1);
 		}
 	}
 	strbuf_release(&committer_ident);
@@ -894,7 +897,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	 * explicit --allow-empty. In the cherry-pick case, it may be
 	 * empty due to conflict resolution, which the user should okay.
 	 */
-	if (!commitable && whence != FROM_MERGE && !allow_empty &&
+	if (!committable && whence != FROM_MERGE && !allow_empty &&
 	    !(amend && is_a_merge(current_head))) {
 		s->display_comment_prefix = old_display_comment_prefix;
 		run_status(stdout, index_file, prefix, 0, s);
@@ -1164,14 +1167,14 @@ static int parse_and_validate_options(int argc, const char *argv[],
 static int dry_run_commit(int argc, const char **argv, const char *prefix,
 			  const struct commit *current_head, struct wt_status *s)
 {
-	int commitable;
+	int committable;
 	const char *index_file;
 
 	index_file = prepare_index(argc, argv, prefix, current_head, 1);
-	commitable = run_status(stdout, index_file, prefix, 0, s);
+	committable = run_status(stdout, index_file, prefix, 0, s);
 	rollback_index_files();
 
-	return commitable ? 0 : 1;
+	return committable ? 0 : 1;
 }
 
 static int parse_status_slot(const char *slot)
@@ -1266,6 +1269,7 @@ static int git_status_config(const char *k, const char *v, void *cb)
 int cmd_status(int argc, const char **argv, const char *prefix)
 {
 	static struct wt_status s;
+	struct wt_status_state state;
 	int fd;
 	struct object_id oid;
 	static struct option builtin_status_options[] = {
@@ -1338,7 +1342,8 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 	s.status_format = status_format;
 	s.verbose = verbose;
 
-	wt_status_collect(&s);
+	wt_status_get_state(&s, &state);
+	wt_status_collect(&s, &state);
 
 	if (0 <= fd)
 		update_index_if_able(&the_index, &index_lock);
@@ -1346,7 +1351,8 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 	if (s.relative_paths)
 		s.prefix = prefix;
 
-	wt_status_print(&s);
+	wt_status_print(&s, &state);
+	wt_status_clear_state(&state);
 	return 0;
 }
 
diff --git a/ref-filter.c b/ref-filter.c
index 9a333e21b..280ef9713 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1306,8 +1306,7 @@ char *get_head_description(void)
 {
 	struct strbuf desc = STRBUF_INIT;
 	struct wt_status_state state;
-	memset(&state, 0, sizeof(state));
-	wt_status_get_state(&state, 1);
+	wt_status_get_state(NULL, &state);
 	if (state.rebase_in_progress ||
 	    state.rebase_interactive_in_progress)
 		strbuf_addf(&desc, _("(no branch, rebasing %s)"),
diff --git a/wt-status.c b/wt-status.c
index 50815e5fa..75d389944 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -33,7 +33,7 @@ static char default_wt_status_colors[][COLOR_MAXLEN] = {
 	GIT_COLOR_NIL,    /* WT_STATUS_ONBRANCH */
 };
 
-static const char *color(int slot, struct wt_status *s)
+static const char *color(int slot, const struct wt_status *s)
 {
 	const char *c = "";
 	if (want_color(s->use_color))
@@ -43,7 +43,7 @@ static const char *color(int slot, struct wt_status *s)
 	return c;
 }
 
-static void status_vprintf(struct wt_status *s, int at_bol, const char *color,
+static void status_vprintf(const struct wt_status *s, int at_bol, const char *color,
 		const char *fmt, va_list ap, const char *trail)
 {
 	struct strbuf sb = STRBUF_INIT;
@@ -89,7 +89,7 @@ static void status_vprintf(struct wt_status *s, int at_bol, const char *color,
 	strbuf_release(&sb);
 }
 
-void status_printf_ln(struct wt_status *s, const char *color,
+void status_printf_ln(const struct wt_status *s, const char *color,
 			const char *fmt, ...)
 {
 	va_list ap;
@@ -99,7 +99,7 @@ void status_printf_ln(struct wt_status *s, const char *color,
 	va_end(ap);
 }
 
-void status_printf(struct wt_status *s, const char *color,
+void status_printf(const struct wt_status *s, const char *color,
 			const char *fmt, ...)
 {
 	va_list ap;
@@ -109,7 +109,7 @@ void status_printf(struct wt_status *s, const char *color,
 	va_end(ap);
 }
 
-static void status_printf_more(struct wt_status *s, const char *color,
+static void status_printf_more(const struct wt_status *s, const char *color,
 			       const char *fmt, ...)
 {
 	va_list ap;
@@ -140,7 +140,7 @@ void wt_status_prepare(struct wt_status *s)
 	s->display_comment_prefix = 0;
 }
 
-static void wt_longstatus_print_unmerged_header(struct wt_status *s)
+static void wt_longstatus_print_unmerged_header(const struct wt_status *s)
 {
 	int i;
 	int del_mod_conflict = 0;
@@ -192,7 +192,7 @@ static void wt_longstatus_print_unmerged_header(struct wt_status *s)
 	status_printf_ln(s, c, "%s", "");
 }
 
-static void wt_longstatus_print_cached_header(struct wt_status *s)
+static void wt_longstatus_print_cached_header(const struct wt_status *s)
 {
 	const char *c = color(WT_STATUS_HEADER, s);
 
@@ -208,7 +208,7 @@ static void wt_longstatus_print_cached_header(struct wt_status *s)
 	status_printf_ln(s, c, "%s", "");
 }
 
-static void wt_longstatus_print_dirty_header(struct wt_status *s,
+static void wt_longstatus_print_dirty_header(const struct wt_status *s,
 					     int has_deleted,
 					     int has_dirty_submodules)
 {
@@ -227,7 +227,7 @@ static void wt_longstatus_print_dirty_header(struct wt_status *s,
 	status_printf_ln(s, c, "%s", "");
 }
 
-static void wt_longstatus_print_other_header(struct wt_status *s,
+static void wt_longstatus_print_other_header(const struct wt_status *s,
 					     const char *what,
 					     const char *how)
 {
@@ -239,7 +239,7 @@ static void wt_longstatus_print_other_header(struct wt_status *s,
 	status_printf_ln(s, c, "%s", "");
 }
 
-static void wt_longstatus_print_trailer(struct wt_status *s)
+static void wt_longstatus_print_trailer(const struct wt_status *s)
 {
 	status_printf_ln(s, color(WT_STATUS_HEADER, s), "%s", "");
 }
@@ -305,7 +305,7 @@ static int maxwidth(const char *(*label)(int), int minval, int maxval)
 	return result;
 }
 
-static void wt_longstatus_print_unmerged_data(struct wt_status *s,
+static void wt_longstatus_print_unmerged_data(const struct wt_status *s,
 					      struct string_list_item *it)
 {
 	const char *c = color(WT_STATUS_UNMERGED, s);
@@ -332,7 +332,7 @@ static void wt_longstatus_print_unmerged_data(struct wt_status *s,
 	strbuf_release(&onebuf);
 }
 
-static void wt_longstatus_print_change_data(struct wt_status *s,
+static void wt_longstatus_print_change_data(const struct wt_status *s,
 					    int change_type,
 					    struct string_list_item *it)
 {
@@ -718,7 +718,7 @@ static void wt_status_collect_untracked(struct wt_status *s)
 		s->untracked_in_ms = (getnanotime() - t_begin) / 1000000;
 }
 
-void wt_status_collect(struct wt_status *s)
+void wt_status_collect(struct wt_status *s, const struct wt_status_state *state)
 {
 	wt_status_collect_changes_worktree(s);
 
@@ -726,10 +726,11 @@ void wt_status_collect(struct wt_status *s)
 		wt_status_collect_changes_initial(s);
 	else
 		wt_status_collect_changes_index(s);
+
 	wt_status_collect_untracked(s);
 }
 
-static void wt_longstatus_print_unmerged(struct wt_status *s)
+static void wt_longstatus_print_unmerged(const struct wt_status *s)
 {
 	int shown_header = 0;
 	int i;
@@ -767,7 +768,7 @@ static void wt_longstatus_print_updated(struct wt_status *s)
 			continue;
 		if (!shown_header) {
 			wt_longstatus_print_cached_header(s);
-			s->commitable = 1;
+			s->committable = 1;
 			shown_header = 1;
 		}
 		wt_longstatus_print_change_data(s, WT_STATUS_UPDATED, it);
@@ -781,7 +782,7 @@ static void wt_longstatus_print_updated(struct wt_status *s)
  *  0 : no change
  *  1 : some change but no delete
  */
-static int wt_status_check_worktree_changes(struct wt_status *s,
+static int wt_status_check_worktree_changes(const struct wt_status *s,
 					     int *dirty_submodules)
 {
 	int i;
@@ -805,7 +806,7 @@ static int wt_status_check_worktree_changes(struct wt_status *s,
 	return changes;
 }
 
-static void wt_longstatus_print_changed(struct wt_status *s)
+static void wt_longstatus_print_changed(const struct wt_status *s)
 {
 	int i, dirty_submodules;
 	int worktree_changes = wt_status_check_worktree_changes(s, &dirty_submodules);
@@ -837,7 +838,7 @@ static int stash_count_refs(struct object_id *ooid, struct object_id *noid,
 	return 0;
 }
 
-static void wt_longstatus_print_stash_summary(struct wt_status *s)
+static void wt_longstatus_print_stash_summary(const struct wt_status *s)
 {
 	int stash_count = 0;
 
@@ -849,7 +850,7 @@ static void wt_longstatus_print_stash_summary(struct wt_status *s)
 				 stash_count);
 }
 
-static void wt_longstatus_print_submodule_summary(struct wt_status *s, int uncommitted)
+static void wt_longstatus_print_submodule_summary(const struct wt_status *s, int uncommitted)
 {
 	struct child_process sm_summary = CHILD_PROCESS_INIT;
 	struct strbuf cmd_stdout = STRBUF_INIT;
@@ -895,8 +896,8 @@ static void wt_longstatus_print_submodule_summary(struct wt_status *s, int uncom
 	strbuf_release(&summary);
 }
 
-static void wt_longstatus_print_other(struct wt_status *s,
-				      struct string_list *l,
+static void wt_longstatus_print_other(const struct wt_status *s,
+				      const struct string_list *l,
 				      const char *what,
 				      const char *how)
 {
@@ -969,7 +970,7 @@ void wt_status_add_cut_line(FILE *fp)
 	strbuf_release(&buf);
 }
 
-static void wt_longstatus_print_verbose(struct wt_status *s)
+static void wt_longstatus_print_verbose(const struct wt_status *s)
 {
 	struct rev_info rev;
 	struct setup_revision_opt opt;
@@ -1000,7 +1001,7 @@ static void wt_longstatus_print_verbose(struct wt_status *s)
 		rev.diffopt.use_color = 0;
 		wt_status_add_cut_line(s->fp);
 	}
-	if (s->verbose > 1 && s->commitable) {
+	if (s->verbose > 1 && s->committable) {
 		/* print_updated() printed a header, so do we */
 		if (s->fp != stdout)
 			wt_longstatus_print_trailer(s);
@@ -1021,7 +1022,7 @@ static void wt_longstatus_print_verbose(struct wt_status *s)
 	}
 }
 
-static void wt_longstatus_print_tracking(struct wt_status *s)
+static void wt_longstatus_print_tracking(const struct wt_status *s)
 {
 	struct strbuf sb = STRBUF_INIT;
 	const char *cp, *ep, *branch_name;
@@ -1055,7 +1056,7 @@ static void wt_longstatus_print_tracking(struct wt_status *s)
 	strbuf_release(&sb);
 }
 
-static int has_unmerged(struct wt_status *s)
+static int has_unmerged(const struct wt_status *s)
 {
 	int i;
 
@@ -1069,7 +1070,7 @@ static int has_unmerged(struct wt_status *s)
 }
 
 static void show_merge_in_progress(struct wt_status *s,
-				struct wt_status_state *state,
+				const struct wt_status_state *state,
 				const char *color)
 {
 	if (has_unmerged(s)) {
@@ -1081,7 +1082,7 @@ static void show_merge_in_progress(struct wt_status *s,
 					 _("  (use \"git merge --abort\" to abort the merge)"));
 		}
 	} else {
-		s-> commitable = 1;
+		s-> committable = 1;
 		status_printf_ln(s, color,
 			_("All conflicts fixed but you are still merging."));
 		if (s->hints)
@@ -1091,8 +1092,8 @@ static void show_merge_in_progress(struct wt_status *s,
 	wt_longstatus_print_trailer(s);
 }
 
-static void show_am_in_progress(struct wt_status *s,
-				struct wt_status_state *state,
+static void show_am_in_progress(const struct wt_status *s,
+				const struct wt_status_state *state,
 				const char *color)
 {
 	status_printf_ln(s, color,
@@ -1130,7 +1131,7 @@ static char *read_line_from_git_path(const char *filename)
 	}
 }
 
-static int split_commit_in_progress(struct wt_status *s)
+static int split_commit_in_progress(const struct wt_status *s)
 {
 	int split_in_progress = 0;
 	char *head, *orig_head, *rebase_amend, *rebase_orig_head;
@@ -1224,8 +1225,8 @@ static int read_rebase_todolist(const char *fname, struct string_list *lines)
 	return 0;
 }
 
-static void show_rebase_information(struct wt_status *s,
-					struct wt_status_state *state,
+static void show_rebase_information(const struct wt_status *s,
+					const struct wt_status_state *state,
 					const char *color)
 {
 	if (state->rebase_interactive_in_progress) {
@@ -1278,8 +1279,8 @@ static void show_rebase_information(struct wt_status *s,
 	}
 }
 
-static void print_rebase_state(struct wt_status *s,
-				struct wt_status_state *state,
+static void print_rebase_state(const struct wt_status *s,
+				const struct wt_status_state *state,
 				const char *color)
 {
 	if (state->branch)
@@ -1292,8 +1293,8 @@ static void print_rebase_state(struct wt_status *s,
 				 _("You are currently rebasing."));
 }
 
-static void show_rebase_in_progress(struct wt_status *s,
-				struct wt_status_state *state,
+static void show_rebase_in_progress(const struct wt_status *s,
+				const struct wt_status_state *state,
 				const char *color)
 {
 	struct stat st;
@@ -1345,8 +1346,8 @@ static void show_rebase_in_progress(struct wt_status *s,
 	wt_longstatus_print_trailer(s);
 }
 
-static void show_cherry_pick_in_progress(struct wt_status *s,
-					struct wt_status_state *state,
+static void show_cherry_pick_in_progress(const struct wt_status *s,
+					const struct wt_status_state *state,
 					const char *color)
 {
 	status_printf_ln(s, color, _("You are currently cherry-picking commit %s."),
@@ -1364,8 +1365,8 @@ static void show_cherry_pick_in_progress(struct wt_status *s,
 	wt_longstatus_print_trailer(s);
 }
 
-static void show_revert_in_progress(struct wt_status *s,
-					struct wt_status_state *state,
+static void show_revert_in_progress(const struct wt_status *s,
+					const struct wt_status_state *state,
 					const char *color)
 {
 	status_printf_ln(s, color, _("You are currently reverting commit %s."),
@@ -1383,8 +1384,8 @@ static void show_revert_in_progress(struct wt_status *s,
 	wt_longstatus_print_trailer(s);
 }
 
-static void show_bisect_in_progress(struct wt_status *s,
-				struct wt_status_state *state,
+static void show_bisect_in_progress(const struct wt_status *s,
+				const struct wt_status_state *state,
 				const char *color)
 {
 	if (state->branch)
@@ -1538,12 +1539,16 @@ int wt_status_check_bisect(const struct worktree *wt,
 	return 0;
 }
 
-void wt_status_get_state(struct wt_status_state *state,
-			 int get_detached_from)
+void wt_status_get_state(
+		const struct wt_status *s, struct wt_status_state *state)
 {
+	int get_detached_from =
+		(s == NULL) || (s->branch && !strcmp(s->branch, "HEAD"));
 	struct stat st;
 	struct object_id oid;
 
+	memset(state, 0, sizeof(*state));
+
 	if (!stat(git_path_merge_head(), &st)) {
 		state->merge_in_progress = 1;
 	} else if (wt_status_check_rebase(NULL, state)) {
@@ -1564,8 +1569,15 @@ void wt_status_get_state(struct wt_status_state *state,
 		wt_status_get_detached_from(state);
 }
 
+void wt_status_clear_state(struct wt_status_state *state)
+{
+	free(state->branch);
+	free(state->onto);
+	free(state->detached_from);
+}
+
 static void wt_longstatus_print_state(struct wt_status *s,
-				      struct wt_status_state *state)
+				      const struct wt_status_state *state)
 {
 	const char *state_color = color(WT_STATUS_HEADER, s);
 	if (state->merge_in_progress)
@@ -1582,30 +1594,25 @@ static void wt_longstatus_print_state(struct wt_status *s,
 		show_bisect_in_progress(s, state, state_color);
 }
 
-static void wt_longstatus_print(struct wt_status *s)
+static void wt_longstatus_print(struct wt_status *s, const struct wt_status_state *state)
 {
 	const char *branch_color = color(WT_STATUS_ONBRANCH, s);
 	const char *branch_status_color = color(WT_STATUS_HEADER, s);
-	struct wt_status_state state;
-
-	memset(&state, 0, sizeof(state));
-	wt_status_get_state(&state,
-			    s->branch && !strcmp(s->branch, "HEAD"));
 
 	if (s->branch) {
 		const char *on_what = _("On branch ");
 		const char *branch_name = s->branch;
 		if (!strcmp(branch_name, "HEAD")) {
 			branch_status_color = color(WT_STATUS_NOBRANCH, s);
-			if (state.rebase_in_progress || state.rebase_interactive_in_progress) {
-				if (state.rebase_interactive_in_progress)
+			if (state->rebase_in_progress || state->rebase_interactive_in_progress) {
+				if (state->rebase_interactive_in_progress)
 					on_what = _("interactive rebase in progress; onto ");
 				else
 					on_what = _("rebase in progress; onto ");
-				branch_name = state.onto;
-			} else if (state.detached_from) {
-				branch_name = state.detached_from;
-				if (state.detached_at)
+				branch_name = state->onto;
+			} else if (state->detached_from) {
+				branch_name = state->detached_from;
+				if (state->detached_at)
 					on_what = _("HEAD detached at ");
 				else
 					on_what = _("HEAD detached from ");
@@ -1622,10 +1629,7 @@ static void wt_longstatus_print(struct wt_status *s)
 			wt_longstatus_print_tracking(s);
 	}
 
-	wt_longstatus_print_state(s, &state);
-	free(state.branch);
-	free(state.onto);
-	free(state.detached_from);
+	wt_longstatus_print_state(s, state);
 
 	if (s->is_initial) {
 		status_printf_ln(s, color(WT_STATUS_HEADER, s), "%s", "");
@@ -1657,14 +1661,14 @@ static void wt_longstatus_print(struct wt_status *s)
 					   "new files yourself (see 'git help status')."),
 					 s->untracked_in_ms / 1000.0);
 		}
-	} else if (s->commitable)
+	} else if (s->committable)
 		status_printf_ln(s, GIT_COLOR_NORMAL, _("Untracked files not listed%s"),
 			s->hints
 			? _(" (use -u option to show untracked files)") : "");
 
 	if (s->verbose)
 		wt_longstatus_print_verbose(s);
-	if (!s->commitable) {
+	if (!s->committable) {
 		if (s->amend)
 			status_printf_ln(s, GIT_COLOR_NORMAL, _("No changes"));
 		else if (s->nowarn)
@@ -1700,7 +1704,7 @@ static void wt_longstatus_print(struct wt_status *s)
 }
 
 static void wt_shortstatus_unmerged(struct string_list_item *it,
-			   struct wt_status *s)
+			   const struct wt_status *s)
 {
 	struct wt_status_change_data *d = it->util;
 	const char *how = "??";
@@ -1727,7 +1731,7 @@ static void wt_shortstatus_unmerged(struct string_list_item *it,
 }
 
 static void wt_shortstatus_status(struct string_list_item *it,
-			 struct wt_status *s)
+			 const struct wt_status *s)
 {
 	struct wt_status_change_data *d = it->util;
 
@@ -1770,7 +1774,7 @@ static void wt_shortstatus_status(struct string_list_item *it,
 }
 
 static void wt_shortstatus_other(struct string_list_item *it,
-				 struct wt_status *s, const char *sign)
+				 const struct wt_status *s, const char *sign)
 {
 	if (s->null_termination) {
 		fprintf(stdout, "%s %s%c", sign, it->string, 0);
@@ -1784,7 +1788,7 @@ static void wt_shortstatus_other(struct string_list_item *it,
 	}
 }
 
-static void wt_shortstatus_print_tracking(struct wt_status *s)
+static void wt_shortstatus_print_tracking(const struct wt_status *s)
 {
 	struct branch *branch;
 	const char *header_color = color(WT_STATUS_HEADER, s);
@@ -1860,7 +1864,7 @@ static void wt_shortstatus_print_tracking(struct wt_status *s)
 	fputc(s->null_termination ? '\0' : '\n', s->fp);
 }
 
-static void wt_shortstatus_print(struct wt_status *s)
+static void wt_shortstatus_print(const struct wt_status *s)
 {
 	struct string_list_item *it;
 
@@ -1924,18 +1928,14 @@ static void wt_porcelain_print(struct wt_status *s)
  * upstream.  When AHEAD_BEHIND_QUICK is requested and the branches
  * are different, '?' will be substituted for the actual count.
  */
-static void wt_porcelain_v2_print_tracking(struct wt_status *s)
+static void wt_porcelain_v2_print_tracking(const struct wt_status *s, const struct wt_status_state *state)
 {
 	struct branch *branch;
 	const char *base;
 	const char *branch_name;
-	struct wt_status_state state;
 	int ab_info, nr_ahead, nr_behind;
 	char eol = s->null_termination ? '\0' : '\n';
 
-	memset(&state, 0, sizeof(state));
-	wt_status_get_state(&state, s->branch && !strcmp(s->branch, "HEAD"));
-
 	fprintf(s->fp, "# branch.oid %s%c",
 			(s->is_initial ? "(initial)" : sha1_to_hex(s->sha1_commit)),
 			eol);
@@ -1946,10 +1946,10 @@ static void wt_porcelain_v2_print_tracking(struct wt_status *s)
 		if (!strcmp(s->branch, "HEAD")) {
 			fprintf(s->fp, "# branch.head %s%c", "(detached)", eol);
 
-			if (state.rebase_in_progress || state.rebase_interactive_in_progress)
-				branch_name = state.onto;
-			else if (state.detached_from)
-				branch_name = state.detached_from;
+			if (state->rebase_in_progress || state->rebase_interactive_in_progress)
+				branch_name = state->onto;
+			else if (state->detached_from)
+				branch_name = state->detached_from;
 			else
 				branch_name = "";
 		} else {
@@ -1983,10 +1983,6 @@ static void wt_porcelain_v2_print_tracking(struct wt_status *s)
 			}
 		}
 	}
-
-	free(state.branch);
-	free(state.onto);
-	free(state.detached_from);
 }
 
 /*
@@ -1994,7 +1990,7 @@ static void wt_porcelain_v2_print_tracking(struct wt_status *s)
  * fixed-length string of characters in the buffer provided.
  */
 static void wt_porcelain_v2_submodule_state(
-	struct wt_status_change_data *d,
+	const struct wt_status_change_data *d,
 	char sub[5])
 {
 	if (S_ISGITLINK(d->mode_head) ||
@@ -2017,8 +2013,8 @@ static void wt_porcelain_v2_submodule_state(
  * Fix-up changed entries before we print them.
  */
 static void wt_porcelain_v2_fix_up_changed(
-	struct string_list_item *it,
-	struct wt_status *s)
+	const struct string_list_item *it,
+	const struct wt_status *s)
 {
 	struct wt_status_change_data *d = it->util;
 
@@ -2066,8 +2062,8 @@ static void wt_porcelain_v2_fix_up_changed(
  * Print porcelain v2 info for tracked entries with changes.
  */
 static void wt_porcelain_v2_print_changed_entry(
-	struct string_list_item *it,
-	struct wt_status *s)
+	const struct string_list_item *it,
+	const struct wt_status *s)
 {
 	struct wt_status_change_data *d = it->util;
 	struct strbuf buf = STRBUF_INIT;
@@ -2130,8 +2126,8 @@ static void wt_porcelain_v2_print_changed_entry(
  * Print porcelain v2 status info for unmerged entries.
  */
 static void wt_porcelain_v2_print_unmerged_entry(
-	struct string_list_item *it,
-	struct wt_status *s)
+	const struct string_list_item *it,
+	const struct wt_status *s)
 {
 	struct wt_status_change_data *d = it->util;
 	const struct cache_entry *ce;
@@ -2211,8 +2207,8 @@ static void wt_porcelain_v2_print_unmerged_entry(
  * Print porcelain V2 status info for untracked and ignored entries.
  */
 static void wt_porcelain_v2_print_other(
-	struct string_list_item *it,
-	struct wt_status *s,
+	const struct string_list_item *it,
+	const struct wt_status *s,
 	char prefix)
 {
 	struct strbuf buf = STRBUF_INIT;
@@ -2242,14 +2238,14 @@ static void wt_porcelain_v2_print_other(
  * [<v2_ignored_items>]*
  *
  */
-static void wt_porcelain_v2_print(struct wt_status *s)
+static void wt_porcelain_v2_print(const struct wt_status *s, const struct wt_status_state *state)
 {
 	struct wt_status_change_data *d;
 	struct string_list_item *it;
 	int i;
 
 	if (s->show_branch)
-		wt_porcelain_v2_print_tracking(s);
+		wt_porcelain_v2_print_tracking(s, state);
 
 	for (i = 0; i < s->change.nr; i++) {
 		it = &(s->change.items[i]);
@@ -2276,7 +2272,9 @@ static void wt_porcelain_v2_print(struct wt_status *s)
 	}
 }
 
-void wt_status_print(struct wt_status *s)
+// FIXME: `struct wt_status *` should be `const struct wt_status` but because
+// `wt_porcelain_print()` modifies it, that has to first be fixed
+void wt_status_print(struct wt_status *s, const struct wt_status_state *state)
 {
 	switch (s->status_format) {
 	case STATUS_FORMAT_SHORT:
@@ -2286,14 +2284,14 @@ void wt_status_print(struct wt_status *s)
 		wt_porcelain_print(s);
 		break;
 	case STATUS_FORMAT_PORCELAIN_V2:
-		wt_porcelain_v2_print(s);
+		wt_porcelain_v2_print(s, state);
 		break;
 	case STATUS_FORMAT_UNSPECIFIED:
 		die("BUG: finalize_deferred_config() should have been called");
 		break;
 	case STATUS_FORMAT_NONE:
 	case STATUS_FORMAT_LONG:
-		wt_longstatus_print(s);
+		wt_longstatus_print(s, state);
 		break;
 	}
 }
diff --git a/wt-status.h b/wt-status.h
index 430770b85..6cccfd7a0 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -94,7 +94,7 @@ struct wt_status {
 	unsigned char sha1_commit[GIT_MAX_RAWSZ]; /* when not Initial */
 
 	/* These are computed during processing of the individual sections */
-	int commitable;
+	int committable;
 	int workdir_dirty;
 	const char *index_file;
 	FILE *fp;
@@ -126,18 +126,19 @@ struct wt_status_state {
 size_t wt_status_locate_end(const char *s, size_t len);
 void wt_status_add_cut_line(FILE *fp);
 void wt_status_prepare(struct wt_status *s);
-void wt_status_print(struct wt_status *s);
-void wt_status_collect(struct wt_status *s);
-void wt_status_get_state(struct wt_status_state *state, int get_detached_from);
+void wt_status_print(struct wt_status *s, const struct wt_status_state *state);
+void wt_status_collect(struct wt_status *s, const struct wt_status_state *state);
+void wt_status_get_state(const struct wt_status *s, struct wt_status_state *state);
+void wt_status_clear_state(struct wt_status_state *state);
 int wt_status_check_rebase(const struct worktree *wt,
 			   struct wt_status_state *state);
 int wt_status_check_bisect(const struct worktree *wt,
 			   struct wt_status_state *state);
 
 __attribute__((format (printf, 3, 4)))
-void status_printf_ln(struct wt_status *s, const char *color, const char *fmt, ...);
+void status_printf_ln(const struct wt_status *s, const char *color, const char *fmt, ...);
 __attribute__((format (printf, 3, 4)))
-void status_printf(struct wt_status *s, const char *color, const char *fmt, ...);
+void status_printf(const struct wt_status *s, const char *color, const char *fmt, ...);
 
 /* The following functions expect that the caller took care of reading the index. */
 int has_unstaged_changes(int ignore_submodules);
-- 
2.18.0

