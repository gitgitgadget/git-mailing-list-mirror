Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7C931F404
	for <e@80x24.org>; Sun, 26 Aug 2018 10:03:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbeHZNpr (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Aug 2018 09:45:47 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46426 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbeHZNpr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Aug 2018 09:45:47 -0400
Received: by mail-lj1-f194.google.com with SMTP id 203-v6so9988957ljj.13
        for <git@vger.kernel.org>; Sun, 26 Aug 2018 03:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4ABPlcKg4yel10hPaWMV8pqLYvSK+2yU7PwjPDCE7ME=;
        b=XgaLFzktKTjRMAv7uuiV5NkYaZXGwRht84BbMLibmJ8x/c6Oz9GXpUEf8tF4si8QNq
         c7FGvzgFFlp/OxdilUUILERKBknagqaDRH7umrO0z3RUF2XN6X1Vqy+a5jzvPyn63XcG
         I6JYsLXGIgoT776v6gm3xkrxvGudPETtcJPWSv0e1Nr4Hl3zpoDzZOaEWLsXbYokXGhX
         JD/CJNrVVzOfaDP9xPnrVIzJOBX9wag0V6KgBqWcLdbX/iR+tMoK+uzTLPBz84B9n3J3
         3RvO40qwX8/erNzlNenU41s33KkJ5oT79knzYTP1ybr2p9MMXRgm5UB5oY3ait1U0DE/
         bs4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4ABPlcKg4yel10hPaWMV8pqLYvSK+2yU7PwjPDCE7ME=;
        b=lIcZCU4VFYNQhJ9bUNVM+Jfzs+IUFUPCrCB9FerSuMbQWG7xKsV8Tpeth2CaNKqxJL
         BtJQO01AgmoFXjsp3lgij+M7rcbMKdsDGdvu+YXBYWb3pFqumq6IF5Jr1zriYbtrAZIB
         DG9+YndkOQSc/E1IUzkb6OQ0eI5sAlRAsK6oK8Nx4F+7TTNx+iFWWAqGx6slp2G7Kjq+
         4K0lV5JOBAshRDh5Vg8NlqJB3PYDCciReq47+AWh7Zb1jAAzQ3Pdag1JibmGdhpcB3Bf
         +PGIElGvB1zenMXC2oVrGoUm/BGCaaPzelAd4BSXM4kNxpUs2dhkWeRuQHbE+4oG57SF
         Xe8w==
X-Gm-Message-State: APzg51Ad5/aD7vwxZAdyCl0nGyFR8KhdSyqhnYH4UL6OkCIMYaS818nX
        pijUc5hyPPUVqepFkWXcSAagahLK
X-Google-Smtp-Source: ANB0VdYo4UuHlpeRrWSJAODuEf2KK+G8vURLgQeCjOWxn/fuZDtBqEZ+a08Mhr1NMCyzBddfDpNQgQ==
X-Received: by 2002:a2e:1301:: with SMTP id 1-v6mr5561386ljt.56.1535277818328;
        Sun, 26 Aug 2018 03:03:38 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id z5-v6sm2276882lfg.75.2018.08.26.03.03.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Aug 2018 03:03:37 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 20/21] wt-status.c: remove implicit dependency on the_index
Date:   Sun, 26 Aug 2018 12:03:13 +0200
Message-Id: <20180826100314.5137-21-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.337.ge906d732e7
In-Reply-To: <20180826100314.5137-1-pclouds@gmail.com>
References: <20180826100314.5137-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/commit.c |  2 +-
 builtin/pull.c   |  3 ++-
 sequencer.c      |  6 ++---
 wt-status.c      | 64 ++++++++++++++++++++++++++++--------------------
 wt-status.h      | 17 +++++++++----
 5 files changed, 56 insertions(+), 36 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 731e98fd63..64adc078d7 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -183,7 +183,7 @@ static void determine_whence(struct wt_status *s)
 
 static void status_init_config(struct wt_status *s, config_fn_t fn)
 {
-	wt_status_prepare(s);
+	wt_status_prepare(s, the_repository);
 	init_diff_ui_defaults();
 	git_config(fn, s);
 	determine_whence(s);
diff --git a/builtin/pull.c b/builtin/pull.c
index 73e06625c8..ce333ac708 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -887,7 +887,8 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 			die(_("Updating an unborn branch with changes added to the index."));
 
 		if (!autostash)
-			require_clean_work_tree(N_("pull with rebase"),
+			require_clean_work_tree(the_repository,
+				N_("pull with rebase"),
 				_("please commit or stash them."), 1, 0);
 
 		if (get_rebase_fork_point(&rebase_fork_point, repo, *refspecs))
diff --git a/sequencer.c b/sequencer.c
index cb7fefde9c..4dbbc7389d 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2679,7 +2679,7 @@ static int do_exec(const char *command_line)
 	if (discard_cache() < 0 || read_cache() < 0)
 		return error(_("could not read index"));
 
-	dirty = require_clean_work_tree("rebase", NULL, 1, 1);
+	dirty = require_clean_work_tree(the_repository, "rebase", NULL, 1, 1);
 
 	if (status) {
 		warning(_("execution failed: %s\n%s"
@@ -3550,10 +3550,10 @@ static int commit_staged_changes(struct replay_opts *opts,
 	unsigned int flags = ALLOW_EMPTY | EDIT_MSG;
 	unsigned int final_fixup = 0, is_clean;
 
-	if (has_unstaged_changes(1))
+	if (has_unstaged_changes(the_repository, 1))
 		return error(_("cannot rebase: You have unstaged changes."));
 
-	is_clean = !has_uncommitted_changes(0);
+	is_clean = !has_uncommitted_changes(the_repository, 0);
 
 	if (file_exists(rebase_path_amend())) {
 		struct strbuf rev = STRBUF_INIT;
diff --git a/wt-status.c b/wt-status.c
index 5ffab61015..57bc2aac0f 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -119,9 +119,11 @@ static void status_printf_more(struct wt_status *s, const char *color,
 	va_end(ap);
 }
 
-void wt_status_prepare(struct wt_status *s)
+void wt_status_prepare(struct wt_status *s,
+		       struct repository *repo)
 {
 	memset(s, 0, sizeof(*s));
+	s->repo = repo;
 	memcpy(s->color_palette, default_wt_status_colors,
 	       sizeof(default_wt_status_colors));
 	s->show_untracked_files = SHOW_NORMAL_UNTRACKED_FILES;
@@ -494,19 +496,19 @@ static void wt_status_collect_changed_cb(struct diff_queue_struct *q,
 	}
 }
 
-static int unmerged_mask(const char *path)
+static int unmerged_mask(struct index_state *istate, const char *path)
 {
 	int pos, mask;
 	const struct cache_entry *ce;
 
-	pos = cache_name_pos(path, strlen(path));
+	pos = index_name_pos(istate, path, strlen(path));
 	if (0 <= pos)
 		return 0;
 
 	mask = 0;
 	pos = -pos-1;
-	while (pos < active_nr) {
-		ce = active_cache[pos++];
+	while (pos < istate->cache_nr) {
+		ce = istate->cache[pos++];
 		if (strcmp(ce->name, path) || !ce_stage(ce))
 			break;
 		mask |= (1 << (ce_stage(ce) - 1));
@@ -563,7 +565,8 @@ static void wt_status_collect_updated_cb(struct diff_queue_struct *q,
 			oidcpy(&d->oid_index, &p->two->oid);
 			break;
 		case DIFF_STATUS_UNMERGED:
-			d->stagemask = unmerged_mask(p->two->path);
+			d->stagemask = unmerged_mask(s->repo->index,
+						     p->two->path);
 			/*
 			 * Don't bother setting {mode,oid}_{head,index} since the print
 			 * code will output the stage values directly and not use the
@@ -640,14 +643,15 @@ static void wt_status_collect_changes_index(struct wt_status *s)
 
 static void wt_status_collect_changes_initial(struct wt_status *s)
 {
+	struct index_state *istate = s->repo->index;
 	int i;
 
-	for (i = 0; i < active_nr; i++) {
+	for (i = 0; i < istate->cache_nr; i++) {
 		struct string_list_item *it;
 		struct wt_status_change_data *d;
-		const struct cache_entry *ce = active_cache[i];
+		const struct cache_entry *ce = istate->cache[i];
 
-		if (!ce_path_match(&the_index, ce, &s->pathspec, NULL))
+		if (!ce_path_match(istate, ce, &s->pathspec, NULL))
 			continue;
 		if (ce_intent_to_add(ce))
 			continue;
@@ -679,6 +683,7 @@ static void wt_status_collect_untracked(struct wt_status *s)
 	int i;
 	struct dir_struct dir;
 	uint64_t t_begin = getnanotime();
+	struct index_state *istate = s->repo->index;
 
 	if (!s->show_untracked_files)
 		return;
@@ -693,25 +698,25 @@ static void wt_status_collect_untracked(struct wt_status *s)
 		if (s->show_ignored_mode == SHOW_MATCHING_IGNORED)
 			dir.flags |= DIR_SHOW_IGNORED_TOO_MODE_MATCHING;
 	} else {
-		dir.untracked = the_index.untracked;
+		dir.untracked = istate->untracked;
 	}
 
 	setup_standard_excludes(&dir);
 
-	fill_directory(&dir, &the_index, &s->pathspec);
+	fill_directory(&dir, istate, &s->pathspec);
 
 	for (i = 0; i < dir.nr; i++) {
 		struct dir_entry *ent = dir.entries[i];
-		if (cache_name_is_other(ent->name, ent->len) &&
-		    dir_path_match(&the_index, ent, &s->pathspec, 0, NULL))
+		if (index_name_is_other(istate, ent->name, ent->len) &&
+		    dir_path_match(istate, ent, &s->pathspec, 0, NULL))
 			string_list_insert(&s->untracked, ent->name);
 		free(ent);
 	}
 
 	for (i = 0; i < dir.ignored_nr; i++) {
 		struct dir_entry *ent = dir.ignored[i];
-		if (cache_name_is_other(ent->name, ent->len) &&
-		    dir_path_match(&the_index, ent, &s->pathspec, 0, NULL))
+		if (index_name_is_other(istate, ent->name, ent->len) &&
+		    dir_path_match(istate, ent, &s->pathspec, 0, NULL))
 			string_list_insert(&s->ignored, ent->name);
 		free(ent);
 	}
@@ -2142,6 +2147,7 @@ static void wt_porcelain_v2_print_unmerged_entry(
 	struct wt_status *s)
 {
 	struct wt_status_change_data *d = it->util;
+	struct index_state *istate = s->repo->index;
 	const struct cache_entry *ce;
 	struct strbuf buf_index = STRBUF_INIT;
 	const char *path_index = NULL;
@@ -2180,11 +2186,11 @@ static void wt_porcelain_v2_print_unmerged_entry(
 	 */
 	memset(stages, 0, sizeof(stages));
 	sum = 0;
-	pos = cache_name_pos(it->string, strlen(it->string));
+	pos = index_name_pos(istate, it->string, strlen(it->string));
 	assert(pos < 0);
 	pos = -pos-1;
-	while (pos < active_nr) {
-		ce = active_cache[pos++];
+	while (pos < istate->cache_nr) {
+		ce = istate->cache[pos++];
 		stage = ce_stage(ce);
 		if (strcmp(ce->name, it->string) || !stage)
 			break;
@@ -2309,7 +2315,8 @@ void wt_status_print(struct wt_status *s)
 /**
  * Returns 1 if there are unstaged changes, 0 otherwise.
  */
-int has_unstaged_changes(int ignore_submodules)
+int has_unstaged_changes(struct repository *repo,
+			 int ignore_submodules)
 {
 	struct rev_info rev_info;
 	int result;
@@ -2328,12 +2335,13 @@ int has_unstaged_changes(int ignore_submodules)
 /**
  * Returns 1 if there are uncommitted changes, 0 otherwise.
  */
-int has_uncommitted_changes(int ignore_submodules)
+int has_uncommitted_changes(struct repository *repo,
+			    int ignore_submodules)
 {
 	struct rev_info rev_info;
 	int result;
 
-	if (is_cache_unborn())
+	if (is_index_unborn(repo->index))
 		return 0;
 
 	init_revisions(&rev_info, NULL);
@@ -2360,24 +2368,28 @@ int has_uncommitted_changes(int ignore_submodules)
  * If the work tree has unstaged or uncommitted changes, dies with the
  * appropriate message.
  */
-int require_clean_work_tree(const char *action, const char *hint, int ignore_submodules, int gently)
+int require_clean_work_tree(struct repository *repo,
+			    const char *action,
+			    const char *hint,
+			    int ignore_submodules,
+			    int gently)
 {
 	struct lock_file lock_file = LOCK_INIT;
 	int err = 0, fd;
 
 	fd = hold_locked_index(&lock_file, 0);
-	refresh_cache(REFRESH_QUIET);
+	refresh_index(repo->index, REFRESH_QUIET, NULL, NULL, NULL);
 	if (0 <= fd)
-		update_index_if_able(&the_index, &lock_file);
+		update_index_if_able(repo->index, &lock_file);
 	rollback_lock_file(&lock_file);
 
-	if (has_unstaged_changes(ignore_submodules)) {
+	if (has_unstaged_changes(repo, ignore_submodules)) {
 		/* TRANSLATORS: the action is e.g. "pull with rebase" */
 		error(_("cannot %s: You have unstaged changes."), _(action));
 		err = 1;
 	}
 
-	if (has_uncommitted_changes(ignore_submodules)) {
+	if (has_uncommitted_changes(repo, ignore_submodules)) {
 		if (err)
 			error(_("additionally, your index contains uncommitted changes."));
 		else
diff --git a/wt-status.h b/wt-status.h
index 1673d146fa..253c5ce7ec 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -7,6 +7,7 @@
 #include "pathspec.h"
 #include "remote.h"
 
+struct repository;
 struct worktree;
 
 enum color_wt_status {
@@ -65,6 +66,7 @@ enum wt_status_format {
 };
 
 struct wt_status {
+	struct repository *repo;
 	int is_initial;
 	char *branch;
 	const char *reference;
@@ -127,7 +129,7 @@ struct wt_status_state {
 
 size_t wt_status_locate_end(const char *s, size_t len);
 void wt_status_add_cut_line(FILE *fp);
-void wt_status_prepare(struct wt_status *s);
+void wt_status_prepare(struct wt_status *s, struct repository *repo);
 void wt_status_print(struct wt_status *s);
 void wt_status_collect(struct wt_status *s);
 void wt_status_get_state(struct wt_status_state *state, int get_detached_from);
@@ -142,9 +144,14 @@ __attribute__((format (printf, 3, 4)))
 void status_printf(struct wt_status *s, const char *color, const char *fmt, ...);
 
 /* The following functions expect that the caller took care of reading the index. */
-int has_unstaged_changes(int ignore_submodules);
-int has_uncommitted_changes(int ignore_submodules);
-int require_clean_work_tree(const char *action, const char *hint,
-	int ignore_submodules, int gently);
+int has_unstaged_changes(struct repository *repo,
+			 int ignore_submodules);
+int has_uncommitted_changes(struct repository *repo,
+			    int ignore_submodules);
+int require_clean_work_tree(struct repository *repo,
+			    const char *action,
+			    const char *hint,
+			    int ignore_submodules,
+			    int gently);
 
 #endif /* STATUS_H */
-- 
2.19.0.rc0.337.ge906d732e7

