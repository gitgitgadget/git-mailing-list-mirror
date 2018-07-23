Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.4 required=3.0 tests=BAYES_00,DATE_IN_PAST_96_XX,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 345C5208E9
	for <e@80x24.org>; Sun, 29 Jul 2018 00:43:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731748AbeG2CLE (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Jul 2018 22:11:04 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:41356 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731550AbeG2CLE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Jul 2018 22:11:04 -0400
Received: by mail-pl0-f66.google.com with SMTP id w8-v6so3885600ply.8
        for <git@vger.kernel.org>; Sat, 28 Jul 2018 17:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DoUKWTglGamUelJ3muTylicwvnWvXEgirj0siX72KM0=;
        b=iAklMRxYpHqVyp+pWgcEE5geoBMA5uLAQIPYedc0ZRLIAx8DFxZ8gre4p78QpDQwAD
         bIIr8IocvgcphaFmGGnQggo+yuF0/7ccyljRT/UHbkkaTEjpQOJK6sQ+zCOendb6Fenz
         zCZ1LGMqAzP3ycr7+OkUow2TvsveI3vobnE3TvlULThjYu+5hJwDudara3q6vzLjF3bF
         voaoc+Z+84XOms/0FEi3WpJjDqPx8pGZnQ94kQF06RDISx6t91TiJRynYnYflddVmGjq
         utQROFLhCNHx4exdQP44tUQDJPxn1YXDdnRjEXNaDqlJzu7RxSs7DoMMMF3shc9WlWzi
         RJJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DoUKWTglGamUelJ3muTylicwvnWvXEgirj0siX72KM0=;
        b=OdsuWtjh8SUf5hX6TLg17gW6FpaIwmJlHWKmQrs72qzQgYFZC7fEYIjjtMiKqRwyFQ
         Hya2cB149j6tu7g1zbkrKWijuJBqsIsJgoaxrSQct+dGTS8nyhUtJhmm2qzerc1lVhx9
         hPWfNIu+32kzVjZW1pnosqMD0BBCreBTF3c6z/vvCNKKVkLg7b3dHTyT6GAZSQnnelZl
         U5HJQg+aPCSvn1QpmUA3uQCANGHpmAS7QmvHfO0DpqmWujVK27YkVA3qaob3XmeADN54
         EUJZeT8Wyaf6JwxIilaaRcq5BEUEejeJgDN51dQ/4nxAHIfY8NGE2+Sfz7W1uYjn+e7F
         T3wQ==
X-Gm-Message-State: AOUpUlFxaZWgPtK7ZawOrUNIoYiJy++d/WVSQrcHeu6Pq1BfUB0mE6Nr
        bPeftHb/7NCrUWaaajZReeRahSsM
X-Google-Smtp-Source: AAOMgpdcmMB2uL70lf2eKT/1VfZ74a7lZGpCCdXejK2I33/AAeXJyVebYx6Qe6DtQFDPHgnawmLBYA==
X-Received: by 2002:a17:902:b708:: with SMTP id d8-v6mr11343155pls.184.1532824958787;
        Sat, 28 Jul 2018 17:42:38 -0700 (PDT)
Received: from localhost.localdomain ([104.132.11.104])
        by smtp.gmail.com with ESMTPSA id a17-v6sm13034856pfg.106.2018.07.28.17.42.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 Jul 2018 17:42:38 -0700 (PDT)
From:   Samuel Lijin <sxlijin@gmail.com>
To:     git@vger.kernel.org
Cc:     Samuel Lijin <sxlijin@gmail.com>
Subject: [PATCH v4 3/4] wt-status: teach wt_status_collect about merges in progress
Date:   Sun, 22 Jul 2018 22:09:02 -0400
Message-Id: <20180723020903.22435-4-sxlijin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180715110807.25544-1-sxlijin@gmail.com>
References: <20180715110807.25544-1-sxlijin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To fix the breakages documented by t7501, the next patch in this series
will teach wt_status_collect() how to set the committable bit, instead
of having wt_longstatus_print_updated() and show_merge_in_progress() set
it (which is what currently happens). To set the committable bit
correctly, however, wt_status_collect() needs to know whether or not
there is a merge in progress (if a merge is in progress, the bit (1)
should not be set if there are unresolved merge conflicts and (2) should
be set even if the index is the same as HEAD), so teach its (two)
callers to create, initialize, and pass in
instances of wt_status_state, which records this metadata.

Since wt_longstatus_print() and show_merge_in_progress() are in the same
callpaths and currently create and init copies of wt_status_state,
remove that logic and instead pass wt_status_state through.

Make wt_status_get_state() easier to use, add a helper method to clean up
wt_status_state, const-ify as many struct pointers in method signatures
as possible, and add a FIXME for a struct pointer which should be const
but isn't (that this patch series will not address).

Signed-off-by: Samuel Lijin <sxlijin@gmail.com>
---
gitster: I kept the FIXME around because it wasn't clear whether or not
you were opposed to it. For what it's worth, there are only two
callsites that can't be const-ified because of this one item.

 builtin/commit.c |  14 ++--
 ref-filter.c     |   3 +-
 wt-status.c      | 178 +++++++++++++++++++++++------------------------
 wt-status.h      |  11 +--
 4 files changed, 105 insertions(+), 101 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 32f9db33b..dd3e83053 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -485,6 +485,7 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
 static int run_status(FILE *fp, const char *index_file, const char *prefix, int nowarn,
 		      struct wt_status *s)
 {
+	struct wt_status_state state;
 	struct object_id oid;
 
 	if (s->relative_paths)
@@ -504,8 +505,10 @@ static int run_status(FILE *fp, const char *index_file, const char *prefix, int
 	s->status_format = status_format;
 	s->ignore_submodule_arg = ignore_submodule_arg;
 
-	wt_status_collect(s);
-	wt_status_print(s);
+	wt_status_get_state(s, &state);
+	wt_status_collect(s, &state);
+	wt_status_print(s, &state);
+	wt_status_clear_state(&state);
 
 	return s->committable;
 }
@@ -1295,6 +1298,7 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 	static int no_renames = -1;
 	static const char *rename_score_arg = (const char *)-1;
 	static struct wt_status s;
+	struct wt_status_state state;
 	int fd;
 	struct object_id oid;
 	static struct option builtin_status_options[] = {
@@ -1379,7 +1383,8 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 			s.rename_score = parse_rename_score(&rename_score_arg);
 	}
 
-	wt_status_collect(&s);
+	wt_status_get_state(&s, &state);
+	wt_status_collect(&s, &state);
 
 	if (0 <= fd)
 		update_index_if_able(&the_index, &index_lock);
@@ -1387,7 +1392,8 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 	if (s.relative_paths)
 		s.prefix = prefix;
 
-	wt_status_print(&s);
+	wt_status_print(&s, &state);
+	wt_status_clear_state(&state);
 	return 0;
 }
 
diff --git a/ref-filter.c b/ref-filter.c
index 492f2b770..bc9b6b274 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1381,8 +1381,7 @@ char *get_head_description(void)
 {
 	struct strbuf desc = STRBUF_INIT;
 	struct wt_status_state state;
-	memset(&state, 0, sizeof(state));
-	wt_status_get_state(&state, 1);
+	wt_status_get_state(NULL, &state);
 	if (state.rebase_in_progress ||
 	    state.rebase_interactive_in_progress) {
 		if (state.branch)
diff --git a/wt-status.c b/wt-status.c
index 18ea333a5..af83fae68 100644
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
@@ -143,7 +143,7 @@ void wt_status_prepare(struct wt_status *s)
 	s->rename_limit = -1;
 }
 
-static void wt_longstatus_print_unmerged_header(struct wt_status *s)
+static void wt_longstatus_print_unmerged_header(const struct wt_status *s)
 {
 	int i;
 	int del_mod_conflict = 0;
@@ -195,7 +195,7 @@ static void wt_longstatus_print_unmerged_header(struct wt_status *s)
 	status_printf_ln(s, c, "%s", "");
 }
 
-static void wt_longstatus_print_cached_header(struct wt_status *s)
+static void wt_longstatus_print_cached_header(const struct wt_status *s)
 {
 	const char *c = color(WT_STATUS_HEADER, s);
 
@@ -211,7 +211,7 @@ static void wt_longstatus_print_cached_header(struct wt_status *s)
 	status_printf_ln(s, c, "%s", "");
 }
 
-static void wt_longstatus_print_dirty_header(struct wt_status *s,
+static void wt_longstatus_print_dirty_header(const struct wt_status *s,
 					     int has_deleted,
 					     int has_dirty_submodules)
 {
@@ -230,7 +230,7 @@ static void wt_longstatus_print_dirty_header(struct wt_status *s,
 	status_printf_ln(s, c, "%s", "");
 }
 
-static void wt_longstatus_print_other_header(struct wt_status *s,
+static void wt_longstatus_print_other_header(const struct wt_status *s,
 					     const char *what,
 					     const char *how)
 {
@@ -242,7 +242,7 @@ static void wt_longstatus_print_other_header(struct wt_status *s,
 	status_printf_ln(s, c, "%s", "");
 }
 
-static void wt_longstatus_print_trailer(struct wt_status *s)
+static void wt_longstatus_print_trailer(const struct wt_status *s)
 {
 	status_printf_ln(s, color(WT_STATUS_HEADER, s), "%s", "");
 }
@@ -308,7 +308,7 @@ static int maxwidth(const char *(*label)(int), int minval, int maxval)
 	return result;
 }
 
-static void wt_longstatus_print_unmerged_data(struct wt_status *s,
+static void wt_longstatus_print_unmerged_data(const struct wt_status *s,
 					      struct string_list_item *it)
 {
 	const char *c = color(WT_STATUS_UNMERGED, s);
@@ -335,7 +335,7 @@ static void wt_longstatus_print_unmerged_data(struct wt_status *s,
 	strbuf_release(&onebuf);
 }
 
-static void wt_longstatus_print_change_data(struct wt_status *s,
+static void wt_longstatus_print_change_data(const struct wt_status *s,
 					    int change_type,
 					    struct string_list_item *it)
 {
@@ -724,7 +724,7 @@ static void wt_status_collect_untracked(struct wt_status *s)
 		s->untracked_in_ms = (getnanotime() - t_begin) / 1000000;
 }
 
-void wt_status_collect(struct wt_status *s)
+void wt_status_collect(struct wt_status *s, const struct wt_status_state *state)
 {
 	wt_status_collect_changes_worktree(s);
 
@@ -732,10 +732,11 @@ void wt_status_collect(struct wt_status *s)
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
@@ -787,7 +788,7 @@ static void wt_longstatus_print_updated(struct wt_status *s)
  *  0 : no change
  *  1 : some change but no delete
  */
-static int wt_status_check_worktree_changes(struct wt_status *s,
+static int wt_status_check_worktree_changes(const struct wt_status *s,
 					     int *dirty_submodules)
 {
 	int i;
@@ -811,7 +812,7 @@ static int wt_status_check_worktree_changes(struct wt_status *s,
 	return changes;
 }
 
-static void wt_longstatus_print_changed(struct wt_status *s)
+static void wt_longstatus_print_changed(const struct wt_status *s)
 {
 	int i, dirty_submodules;
 	int worktree_changes = wt_status_check_worktree_changes(s, &dirty_submodules);
@@ -843,7 +844,7 @@ static int stash_count_refs(struct object_id *ooid, struct object_id *noid,
 	return 0;
 }
 
-static void wt_longstatus_print_stash_summary(struct wt_status *s)
+static void wt_longstatus_print_stash_summary(const struct wt_status *s)
 {
 	int stash_count = 0;
 
@@ -855,7 +856,7 @@ static void wt_longstatus_print_stash_summary(struct wt_status *s)
 				 stash_count);
 }
 
-static void wt_longstatus_print_submodule_summary(struct wt_status *s, int uncommitted)
+static void wt_longstatus_print_submodule_summary(const struct wt_status *s, int uncommitted)
 {
 	struct child_process sm_summary = CHILD_PROCESS_INIT;
 	struct strbuf cmd_stdout = STRBUF_INIT;
@@ -901,8 +902,8 @@ static void wt_longstatus_print_submodule_summary(struct wt_status *s, int uncom
 	strbuf_release(&summary);
 }
 
-static void wt_longstatus_print_other(struct wt_status *s,
-				      struct string_list *l,
+static void wt_longstatus_print_other(const struct wt_status *s,
+				      const struct string_list *l,
 				      const char *what,
 				      const char *how)
 {
@@ -975,7 +976,7 @@ void wt_status_add_cut_line(FILE *fp)
 	strbuf_release(&buf);
 }
 
-static void wt_longstatus_print_verbose(struct wt_status *s)
+static void wt_longstatus_print_verbose(const struct wt_status *s)
 {
 	struct rev_info rev;
 	struct setup_revision_opt opt;
@@ -1029,7 +1030,7 @@ static void wt_longstatus_print_verbose(struct wt_status *s)
 	}
 }
 
-static void wt_longstatus_print_tracking(struct wt_status *s)
+static void wt_longstatus_print_tracking(const struct wt_status *s)
 {
 	struct strbuf sb = STRBUF_INIT;
 	const char *cp, *ep, *branch_name;
@@ -1063,7 +1064,7 @@ static void wt_longstatus_print_tracking(struct wt_status *s)
 	strbuf_release(&sb);
 }
 
-static int has_unmerged(struct wt_status *s)
+static int has_unmerged(const struct wt_status *s)
 {
 	int i;
 
@@ -1077,7 +1078,7 @@ static int has_unmerged(struct wt_status *s)
 }
 
 static void show_merge_in_progress(struct wt_status *s,
-				struct wt_status_state *state,
+				const struct wt_status_state *state,
 				const char *color)
 {
 	if (has_unmerged(s)) {
@@ -1099,8 +1100,8 @@ static void show_merge_in_progress(struct wt_status *s,
 	wt_longstatus_print_trailer(s);
 }
 
-static void show_am_in_progress(struct wt_status *s,
-				struct wt_status_state *state,
+static void show_am_in_progress(const struct wt_status *s,
+				const struct wt_status_state *state,
 				const char *color)
 {
 	status_printf_ln(s, color,
@@ -1138,7 +1139,7 @@ static char *read_line_from_git_path(const char *filename)
 	}
 }
 
-static int split_commit_in_progress(struct wt_status *s)
+static int split_commit_in_progress(const struct wt_status *s)
 {
 	int split_in_progress = 0;
 	char *head, *orig_head, *rebase_amend, *rebase_orig_head;
@@ -1232,8 +1233,8 @@ static int read_rebase_todolist(const char *fname, struct string_list *lines)
 	return 0;
 }
 
-static void show_rebase_information(struct wt_status *s,
-					struct wt_status_state *state,
+static void show_rebase_information(const struct wt_status *s,
+					const struct wt_status_state *state,
 					const char *color)
 {
 	if (state->rebase_interactive_in_progress) {
@@ -1286,8 +1287,8 @@ static void show_rebase_information(struct wt_status *s,
 	}
 }
 
-static void print_rebase_state(struct wt_status *s,
-				struct wt_status_state *state,
+static void print_rebase_state(const struct wt_status *s,
+				const struct wt_status_state *state,
 				const char *color)
 {
 	if (state->branch)
@@ -1300,8 +1301,8 @@ static void print_rebase_state(struct wt_status *s,
 				 _("You are currently rebasing."));
 }
 
-static void show_rebase_in_progress(struct wt_status *s,
-				struct wt_status_state *state,
+static void show_rebase_in_progress(const struct wt_status *s,
+				const struct wt_status_state *state,
 				const char *color)
 {
 	struct stat st;
@@ -1353,8 +1354,8 @@ static void show_rebase_in_progress(struct wt_status *s,
 	wt_longstatus_print_trailer(s);
 }
 
-static void show_cherry_pick_in_progress(struct wt_status *s,
-					struct wt_status_state *state,
+static void show_cherry_pick_in_progress(const struct wt_status *s,
+					const struct wt_status_state *state,
 					const char *color)
 {
 	status_printf_ln(s, color, _("You are currently cherry-picking commit %s."),
@@ -1372,8 +1373,8 @@ static void show_cherry_pick_in_progress(struct wt_status *s,
 	wt_longstatus_print_trailer(s);
 }
 
-static void show_revert_in_progress(struct wt_status *s,
-					struct wt_status_state *state,
+static void show_revert_in_progress(const struct wt_status *s,
+					const struct wt_status_state *state,
 					const char *color)
 {
 	status_printf_ln(s, color, _("You are currently reverting commit %s."),
@@ -1391,8 +1392,8 @@ static void show_revert_in_progress(struct wt_status *s,
 	wt_longstatus_print_trailer(s);
 }
 
-static void show_bisect_in_progress(struct wt_status *s,
-				struct wt_status_state *state,
+static void show_bisect_in_progress(const struct wt_status *s,
+				const struct wt_status_state *state,
 				const char *color)
 {
 	if (state->branch)
@@ -1546,12 +1547,16 @@ int wt_status_check_bisect(const struct worktree *wt,
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
 	if (!stat(git_path_merge_head(the_repository), &st)) {
 		state->merge_in_progress = 1;
 	} else if (wt_status_check_rebase(NULL, state)) {
@@ -1572,8 +1577,15 @@ void wt_status_get_state(struct wt_status_state *state,
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
@@ -1590,30 +1602,25 @@ static void wt_longstatus_print_state(struct wt_status *s,
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
@@ -1630,10 +1637,7 @@ static void wt_longstatus_print(struct wt_status *s)
 			wt_longstatus_print_tracking(s);
 	}
 
-	wt_longstatus_print_state(s, &state);
-	free(state.branch);
-	free(state.onto);
-	free(state.detached_from);
+	wt_longstatus_print_state(s, state);
 
 	if (s->is_initial) {
 		status_printf_ln(s, color(WT_STATUS_HEADER, s), "%s", "");
@@ -1708,7 +1712,7 @@ static void wt_longstatus_print(struct wt_status *s)
 }
 
 static void wt_shortstatus_unmerged(struct string_list_item *it,
-			   struct wt_status *s)
+			   const struct wt_status *s)
 {
 	struct wt_status_change_data *d = it->util;
 	const char *how = "??";
@@ -1735,7 +1739,7 @@ static void wt_shortstatus_unmerged(struct string_list_item *it,
 }
 
 static void wt_shortstatus_status(struct string_list_item *it,
-			 struct wt_status *s)
+			 const struct wt_status *s)
 {
 	struct wt_status_change_data *d = it->util;
 
@@ -1778,7 +1782,7 @@ static void wt_shortstatus_status(struct string_list_item *it,
 }
 
 static void wt_shortstatus_other(struct string_list_item *it,
-				 struct wt_status *s, const char *sign)
+				 const struct wt_status *s, const char *sign)
 {
 	if (s->null_termination) {
 		fprintf(stdout, "%s %s%c", sign, it->string, 0);
@@ -1792,7 +1796,7 @@ static void wt_shortstatus_other(struct string_list_item *it,
 	}
 }
 
-static void wt_shortstatus_print_tracking(struct wt_status *s)
+static void wt_shortstatus_print_tracking(const struct wt_status *s)
 {
 	struct branch *branch;
 	const char *header_color = color(WT_STATUS_HEADER, s);
@@ -1868,7 +1872,7 @@ static void wt_shortstatus_print_tracking(struct wt_status *s)
 	fputc(s->null_termination ? '\0' : '\n', s->fp);
 }
 
-static void wt_shortstatus_print(struct wt_status *s)
+static void wt_shortstatus_print(const struct wt_status *s)
 {
 	struct string_list_item *it;
 
@@ -1932,18 +1936,14 @@ static void wt_porcelain_print(struct wt_status *s)
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
@@ -1954,10 +1954,10 @@ static void wt_porcelain_v2_print_tracking(struct wt_status *s)
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
@@ -1991,10 +1991,6 @@ static void wt_porcelain_v2_print_tracking(struct wt_status *s)
 			}
 		}
 	}
-
-	free(state.branch);
-	free(state.onto);
-	free(state.detached_from);
 }
 
 /*
@@ -2002,7 +1998,7 @@ static void wt_porcelain_v2_print_tracking(struct wt_status *s)
  * fixed-length string of characters in the buffer provided.
  */
 static void wt_porcelain_v2_submodule_state(
-	struct wt_status_change_data *d,
+	const struct wt_status_change_data *d,
 	char sub[5])
 {
 	if (S_ISGITLINK(d->mode_head) ||
@@ -2025,8 +2021,8 @@ static void wt_porcelain_v2_submodule_state(
  * Fix-up changed entries before we print them.
  */
 static void wt_porcelain_v2_fix_up_changed(
-	struct string_list_item *it,
-	struct wt_status *s)
+	const struct string_list_item *it,
+	const struct wt_status *s)
 {
 	struct wt_status_change_data *d = it->util;
 
@@ -2074,8 +2070,8 @@ static void wt_porcelain_v2_fix_up_changed(
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
@@ -2138,8 +2134,8 @@ static void wt_porcelain_v2_print_changed_entry(
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
@@ -2219,8 +2215,8 @@ static void wt_porcelain_v2_print_unmerged_entry(
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
@@ -2250,14 +2246,14 @@ static void wt_porcelain_v2_print_other(
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
@@ -2284,7 +2280,9 @@ static void wt_porcelain_v2_print(struct wt_status *s)
 	}
 }
 
-void wt_status_print(struct wt_status *s)
+// FIXME: `struct wt_status *` should be `const struct wt_status` but because
+// `wt_porcelain_print()` modifies it, that has to first be fixed
+void wt_status_print(struct wt_status *s, const struct wt_status_state *state)
 {
 	switch (s->status_format) {
 	case STATUS_FORMAT_SHORT:
@@ -2294,14 +2292,14 @@ void wt_status_print(struct wt_status *s)
 		wt_porcelain_print(s);
 		break;
 	case STATUS_FORMAT_PORCELAIN_V2:
-		wt_porcelain_v2_print(s);
+		wt_porcelain_v2_print(s, state);
 		break;
 	case STATUS_FORMAT_UNSPECIFIED:
 		BUG("finalize_deferred_config() should have been called");
 		break;
 	case STATUS_FORMAT_NONE:
 	case STATUS_FORMAT_LONG:
-		wt_longstatus_print(s);
+		wt_longstatus_print(s, state);
 		break;
 	}
 }
diff --git a/wt-status.h b/wt-status.h
index 937b2c352..341bda9dc 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -128,18 +128,19 @@ struct wt_status_state {
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

