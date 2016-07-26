Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F3AE203E4
	for <e@80x24.org>; Tue, 26 Jul 2016 21:14:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161041AbcGZVOD (ORCPT <rfc822;e@80x24.org>);
	Tue, 26 Jul 2016 17:14:03 -0400
Received: from siwi.pair.com ([209.68.5.199]:19343 "EHLO siwi.pair.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758245AbcGZVNr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2016 17:13:47 -0400
Received: from jeffhost-linux1.corp.microsoft.com (unknown [167.220.24.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by siwi.pair.com (Postfix) with ESMTPSA id 1170A84630;
	Tue, 26 Jul 2016 17:13:39 -0400 (EDT)
From:	Jeff Hostetler <git@jeffhostetler.com>
To:	git@vger.kernel.org
Cc:	gitster@pobox.com, Johannes.Schindelin@gmx.de,
	Jeff Hostetler <jeffhost@microsoft.com>,
	Jeff Hostetler <git@jeffhostetler.com>
Subject: [PATCH v3 1/8] status: rename long-format print routines
Date:	Tue, 26 Jul 2016 17:11:16 -0400
Message-Id: <1469567483-58794-2-git-send-email-git@jeffhostetler.com>
X-Mailer: git-send-email 2.8.0.rc4.17.gac42084.dirty
In-Reply-To: <1469567483-58794-1-git-send-email-git@jeffhostetler.com>
References: <1469567483-58794-1-git-send-email-git@jeffhostetler.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Renamed the various wt_status_print*() routines to be
wt_longstatus_print*() to make it clear that these
routines are only concerned with the normal/long
status output.

This will hopefully reduce confusion as other status
formats are added in the future.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Jeff Hostetler <git@jeffhostetler.com>
---
 builtin/commit.c |   4 +-
 wt-status.c      | 110 +++++++++++++++++++++++++++----------------------------
 wt-status.h      |   2 +-
 3 files changed, 58 insertions(+), 58 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 1f6dbcd..b80273b 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -515,7 +515,7 @@ static int run_status(FILE *fp, const char *index_file, const char *prefix, int
 		break;
 	case STATUS_FORMAT_NONE:
 	case STATUS_FORMAT_LONG:
-		wt_status_print(s);
+		wt_longstatus_print(s);
 		break;
 	}
 
@@ -1403,7 +1403,7 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 	case STATUS_FORMAT_LONG:
 		s.verbose = verbose;
 		s.ignore_submodule_arg = ignore_submodule_arg;
-		wt_status_print(&s);
+		wt_longstatus_print(&s);
 		break;
 	}
 	return 0;
diff --git a/wt-status.c b/wt-status.c
index de62ab2..b9a58fd 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -139,7 +139,7 @@ void wt_status_prepare(struct wt_status *s)
 	s->display_comment_prefix = 0;
 }
 
-static void wt_status_print_unmerged_header(struct wt_status *s)
+static void wt_longstatus_print_unmerged_header(struct wt_status *s)
 {
 	int i;
 	int del_mod_conflict = 0;
@@ -191,7 +191,7 @@ static void wt_status_print_unmerged_header(struct wt_status *s)
 	status_printf_ln(s, c, "%s", "");
 }
 
-static void wt_status_print_cached_header(struct wt_status *s)
+static void wt_longstatus_print_cached_header(struct wt_status *s)
 {
 	const char *c = color(WT_STATUS_HEADER, s);
 
@@ -207,9 +207,9 @@ static void wt_status_print_cached_header(struct wt_status *s)
 	status_printf_ln(s, c, "%s", "");
 }
 
-static void wt_status_print_dirty_header(struct wt_status *s,
-					 int has_deleted,
-					 int has_dirty_submodules)
+static void wt_longstatus_print_dirty_header(struct wt_status *s,
+					     int has_deleted,
+					     int has_dirty_submodules)
 {
 	const char *c = color(WT_STATUS_HEADER, s);
 
@@ -226,9 +226,9 @@ static void wt_status_print_dirty_header(struct wt_status *s,
 	status_printf_ln(s, c, "%s", "");
 }
 
-static void wt_status_print_other_header(struct wt_status *s,
-					 const char *what,
-					 const char *how)
+static void wt_longstatus_print_other_header(struct wt_status *s,
+					     const char *what,
+					     const char *how)
 {
 	const char *c = color(WT_STATUS_HEADER, s);
 	status_printf_ln(s, c, "%s:", what);
@@ -238,7 +238,7 @@ static void wt_status_print_other_header(struct wt_status *s,
 	status_printf_ln(s, c, "%s", "");
 }
 
-static void wt_status_print_trailer(struct wt_status *s)
+static void wt_longstatus_print_trailer(struct wt_status *s)
 {
 	status_printf_ln(s, color(WT_STATUS_HEADER, s), "%s", "");
 }
@@ -304,8 +304,8 @@ static int maxwidth(const char *(*label)(int), int minval, int maxval)
 	return result;
 }
 
-static void wt_status_print_unmerged_data(struct wt_status *s,
-					  struct string_list_item *it)
+static void wt_longstatus_print_unmerged_data(struct wt_status *s,
+					      struct string_list_item *it)
 {
 	const char *c = color(WT_STATUS_UNMERGED, s);
 	struct wt_status_change_data *d = it->util;
@@ -331,9 +331,9 @@ static void wt_status_print_unmerged_data(struct wt_status *s,
 	strbuf_release(&onebuf);
 }
 
-static void wt_status_print_change_data(struct wt_status *s,
-					int change_type,
-					struct string_list_item *it)
+static void wt_longstatus_print_change_data(struct wt_status *s,
+					    int change_type,
+					    struct string_list_item *it)
 {
 	struct wt_status_change_data *d = it->util;
 	const char *c = color(change_type, s);
@@ -378,7 +378,7 @@ static void wt_status_print_change_data(struct wt_status *s,
 		status = d->worktree_status;
 		break;
 	default:
-		die("BUG: unhandled change_type %d in wt_status_print_change_data",
+		die("BUG: unhandled change_type %d in wt_longstatus_print_change_data",
 		    change_type);
 	}
 
@@ -627,7 +627,7 @@ void wt_status_collect(struct wt_status *s)
 	wt_status_collect_untracked(s);
 }
 
-static void wt_status_print_unmerged(struct wt_status *s)
+static void wt_longstatus_print_unmerged(struct wt_status *s)
 {
 	int shown_header = 0;
 	int i;
@@ -640,17 +640,17 @@ static void wt_status_print_unmerged(struct wt_status *s)
 		if (!d->stagemask)
 			continue;
 		if (!shown_header) {
-			wt_status_print_unmerged_header(s);
+			wt_longstatus_print_unmerged_header(s);
 			shown_header = 1;
 		}
-		wt_status_print_unmerged_data(s, it);
+		wt_longstatus_print_unmerged_data(s, it);
 	}
 	if (shown_header)
-		wt_status_print_trailer(s);
+		wt_longstatus_print_trailer(s);
 
 }
 
-static void wt_status_print_updated(struct wt_status *s)
+static void wt_longstatus_print_updated(struct wt_status *s)
 {
 	int shown_header = 0;
 	int i;
@@ -664,14 +664,14 @@ static void wt_status_print_updated(struct wt_status *s)
 		    d->index_status == DIFF_STATUS_UNMERGED)
 			continue;
 		if (!shown_header) {
-			wt_status_print_cached_header(s);
+			wt_longstatus_print_cached_header(s);
 			s->commitable = 1;
 			shown_header = 1;
 		}
-		wt_status_print_change_data(s, WT_STATUS_UPDATED, it);
+		wt_longstatus_print_change_data(s, WT_STATUS_UPDATED, it);
 	}
 	if (shown_header)
-		wt_status_print_trailer(s);
+		wt_longstatus_print_trailer(s);
 }
 
 /*
@@ -703,7 +703,7 @@ static int wt_status_check_worktree_changes(struct wt_status *s,
 	return changes;
 }
 
-static void wt_status_print_changed(struct wt_status *s)
+static void wt_longstatus_print_changed(struct wt_status *s)
 {
 	int i, dirty_submodules;
 	int worktree_changes = wt_status_check_worktree_changes(s, &dirty_submodules);
@@ -711,7 +711,7 @@ static void wt_status_print_changed(struct wt_status *s)
 	if (!worktree_changes)
 		return;
 
-	wt_status_print_dirty_header(s, worktree_changes < 0, dirty_submodules);
+	wt_longstatus_print_dirty_header(s, worktree_changes < 0, dirty_submodules);
 
 	for (i = 0; i < s->change.nr; i++) {
 		struct wt_status_change_data *d;
@@ -721,12 +721,12 @@ static void wt_status_print_changed(struct wt_status *s)
 		if (!d->worktree_status ||
 		    d->worktree_status == DIFF_STATUS_UNMERGED)
 			continue;
-		wt_status_print_change_data(s, WT_STATUS_CHANGED, it);
+		wt_longstatus_print_change_data(s, WT_STATUS_CHANGED, it);
 	}
-	wt_status_print_trailer(s);
+	wt_longstatus_print_trailer(s);
 }
 
-static void wt_status_print_submodule_summary(struct wt_status *s, int uncommitted)
+static void wt_longstatus_print_submodule_summary(struct wt_status *s, int uncommitted)
 {
 	struct child_process sm_summary = CHILD_PROCESS_INIT;
 	struct strbuf cmd_stdout = STRBUF_INIT;
@@ -772,10 +772,10 @@ static void wt_status_print_submodule_summary(struct wt_status *s, int uncommitt
 	strbuf_release(&summary);
 }
 
-static void wt_status_print_other(struct wt_status *s,
-				  struct string_list *l,
-				  const char *what,
-				  const char *how)
+static void wt_longstatus_print_other(struct wt_status *s,
+				      struct string_list *l,
+				      const char *what,
+				      const char *how)
 {
 	int i;
 	struct strbuf buf = STRBUF_INIT;
@@ -785,7 +785,7 @@ static void wt_status_print_other(struct wt_status *s,
 	if (!l->nr)
 		return;
 
-	wt_status_print_other_header(s, what, how);
+	wt_longstatus_print_other_header(s, what, how);
 
 	for (i = 0; i < l->nr; i++) {
 		struct string_list_item *it;
@@ -845,7 +845,7 @@ void wt_status_add_cut_line(FILE *fp)
 	strbuf_release(&buf);
 }
 
-static void wt_status_print_verbose(struct wt_status *s)
+static void wt_longstatus_print_verbose(struct wt_status *s)
 {
 	struct rev_info rev;
 	struct setup_revision_opt opt;
@@ -878,7 +878,7 @@ static void wt_status_print_verbose(struct wt_status *s)
 	if (s->verbose > 1 && s->commitable) {
 		/* print_updated() printed a header, so do we */
 		if (s->fp != stdout)
-			wt_status_print_trailer(s);
+			wt_longstatus_print_trailer(s);
 		status_printf_ln(s, c, _("Changes to be committed:"));
 		rev.diffopt.a_prefix = "c/";
 		rev.diffopt.b_prefix = "i/";
@@ -896,7 +896,7 @@ static void wt_status_print_verbose(struct wt_status *s)
 	}
 }
 
-static void wt_status_print_tracking(struct wt_status *s)
+static void wt_longstatus_print_tracking(struct wt_status *s)
 {
 	struct strbuf sb = STRBUF_INIT;
 	const char *cp, *ep, *branch_name;
@@ -959,7 +959,7 @@ static void show_merge_in_progress(struct wt_status *s,
 			status_printf_ln(s, color,
 				_("  (use \"git commit\" to conclude merge)"));
 	}
-	wt_status_print_trailer(s);
+	wt_longstatus_print_trailer(s);
 }
 
 static void show_am_in_progress(struct wt_status *s,
@@ -980,7 +980,7 @@ static void show_am_in_progress(struct wt_status *s,
 		status_printf_ln(s, color,
 			_("  (use \"git am --abort\" to restore the original branch)"));
 	}
-	wt_status_print_trailer(s);
+	wt_longstatus_print_trailer(s);
 }
 
 static char *read_line_from_git_path(const char *filename)
@@ -1204,7 +1204,7 @@ static void show_rebase_in_progress(struct wt_status *s,
 				_("  (use \"git rebase --continue\" once you are satisfied with your changes)"));
 		}
 	}
-	wt_status_print_trailer(s);
+	wt_longstatus_print_trailer(s);
 }
 
 static void show_cherry_pick_in_progress(struct wt_status *s,
@@ -1223,7 +1223,7 @@ static void show_cherry_pick_in_progress(struct wt_status *s,
 		status_printf_ln(s, color,
 			_("  (use \"git cherry-pick --abort\" to cancel the cherry-pick operation)"));
 	}
-	wt_status_print_trailer(s);
+	wt_longstatus_print_trailer(s);
 }
 
 static void show_revert_in_progress(struct wt_status *s,
@@ -1242,7 +1242,7 @@ static void show_revert_in_progress(struct wt_status *s,
 		status_printf_ln(s, color,
 			_("  (use \"git revert --abort\" to cancel the revert operation)"));
 	}
-	wt_status_print_trailer(s);
+	wt_longstatus_print_trailer(s);
 }
 
 static void show_bisect_in_progress(struct wt_status *s,
@@ -1259,7 +1259,7 @@ static void show_bisect_in_progress(struct wt_status *s,
 	if (s->hints)
 		status_printf_ln(s, color,
 			_("  (use \"git bisect reset\" to get back to the original branch)"));
-	wt_status_print_trailer(s);
+	wt_longstatus_print_trailer(s);
 }
 
 /*
@@ -1429,8 +1429,8 @@ void wt_status_get_state(struct wt_status_state *state,
 		wt_status_get_detached_from(state);
 }
 
-static void wt_status_print_state(struct wt_status *s,
-				  struct wt_status_state *state)
+static void wt_longstatus_print_state(struct wt_status *s,
+				      struct wt_status_state *state)
 {
 	const char *state_color = color(WT_STATUS_HEADER, s);
 	if (state->merge_in_progress)
@@ -1447,7 +1447,7 @@ static void wt_status_print_state(struct wt_status *s,
 		show_bisect_in_progress(s, state, state_color);
 }
 
-void wt_status_print(struct wt_status *s)
+void wt_longstatus_print(struct wt_status *s)
 {
 	const char *branch_color = color(WT_STATUS_ONBRANCH, s);
 	const char *branch_status_color = color(WT_STATUS_HEADER, s);
@@ -1484,10 +1484,10 @@ void wt_status_print(struct wt_status *s)
 		status_printf_more(s, branch_status_color, "%s", on_what);
 		status_printf_more(s, branch_color, "%s\n", branch_name);
 		if (!s->is_initial)
-			wt_status_print_tracking(s);
+			wt_longstatus_print_tracking(s);
 	}
 
-	wt_status_print_state(s, &state);
+	wt_longstatus_print_state(s, &state);
 	free(state.branch);
 	free(state.onto);
 	free(state.detached_from);
@@ -1498,19 +1498,19 @@ void wt_status_print(struct wt_status *s)
 		status_printf_ln(s, color(WT_STATUS_HEADER, s), "%s", "");
 	}
 
-	wt_status_print_updated(s);
-	wt_status_print_unmerged(s);
-	wt_status_print_changed(s);
+	wt_longstatus_print_updated(s);
+	wt_longstatus_print_unmerged(s);
+	wt_longstatus_print_changed(s);
 	if (s->submodule_summary &&
 	    (!s->ignore_submodule_arg ||
 	     strcmp(s->ignore_submodule_arg, "all"))) {
-		wt_status_print_submodule_summary(s, 0);  /* staged */
-		wt_status_print_submodule_summary(s, 1);  /* unstaged */
+		wt_longstatus_print_submodule_summary(s, 0);  /* staged */
+		wt_longstatus_print_submodule_summary(s, 1);  /* unstaged */
 	}
 	if (s->show_untracked_files) {
-		wt_status_print_other(s, &s->untracked, _("Untracked files"), "add");
+		wt_longstatus_print_other(s, &s->untracked, _("Untracked files"), "add");
 		if (s->show_ignored_files)
-			wt_status_print_other(s, &s->ignored, _("Ignored files"), "add -f");
+			wt_longstatus_print_other(s, &s->ignored, _("Ignored files"), "add -f");
 		if (advice_status_u_option && 2000 < s->untracked_in_ms) {
 			status_printf_ln(s, GIT_COLOR_NORMAL, "%s", "");
 			status_printf_ln(s, GIT_COLOR_NORMAL,
@@ -1525,7 +1525,7 @@ void wt_status_print(struct wt_status *s)
 			? _(" (use -u option to show untracked files)") : "");
 
 	if (s->verbose)
-		wt_status_print_verbose(s);
+		wt_longstatus_print_verbose(s);
 	if (!s->commitable) {
 		if (s->amend)
 			status_printf_ln(s, GIT_COLOR_NORMAL, _("No changes"));
diff --git a/wt-status.h b/wt-status.h
index 2ca93f6..2023a3c 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -99,7 +99,6 @@ struct wt_status_state {
 void wt_status_truncate_message_at_cut_line(struct strbuf *);
 void wt_status_add_cut_line(FILE *fp);
 void wt_status_prepare(struct wt_status *s);
-void wt_status_print(struct wt_status *s);
 void wt_status_collect(struct wt_status *s);
 void wt_status_get_state(struct wt_status_state *state, int get_detached_from);
 int wt_status_check_rebase(const struct worktree *wt,
@@ -107,6 +106,7 @@ int wt_status_check_rebase(const struct worktree *wt,
 int wt_status_check_bisect(const struct worktree *wt,
 			   struct wt_status_state *state);
 
+void wt_longstatus_print(struct wt_status *s);
 void wt_shortstatus_print(struct wt_status *s);
 void wt_porcelain_print(struct wt_status *s);
 
-- 
2.8.0.rc4.17.gac42084.dirty

