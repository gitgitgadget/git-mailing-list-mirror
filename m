From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/5] Rename functions in preparation for get_pathspec() restructure
Date: Sat,  9 Apr 2011 23:54:16 +0700
Message-ID: <1302368060-23827-2-git-send-email-pclouds@gmail.com>
References: <1302368060-23827-1-git-send-email-pclouds@gmail.com>
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Sat Apr 09 18:54:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8bQu-0004g8-OC
	for gcvg-git-2@lo.gmane.org; Sat, 09 Apr 2011 18:54:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754814Ab1DIQyo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Apr 2011 12:54:44 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:39895 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754329Ab1DIQyi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Apr 2011 12:54:38 -0400
Received: by iwn34 with SMTP id 34so4339826iwn.19
        for <git@vger.kernel.org>; Sat, 09 Apr 2011 09:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=mlfz6BKBT32+2zxQgcB62y1HSLcQGm5O8OfNjnWa3DI=;
        b=a8TEnlEA2+DQoOrLPPwnuRUSwEvs7hDu95uudIrRmZvZLO0eo4tE8VJOkRp3wIt35k
         xaqt+mX63KWuIXzD0Gb+UWQREn/foS4BzKbziccDK8FaSo4R/+r2hi2EKC3Ys6gugJSs
         xP8NIcmb21126clIySn6Jh+GfQkTRj1cSgNNc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=O7lObDbT8L7Cn1xkoTpgMuJKFZJLijSafruNPMiZrY8u+r8aRxR6jRqot8E+ARoPfZ
         IVsWAnIdp6sri5aT+gyCEVcdcmmJ88KAbNaopNczbqXh9f2qAP/5/xCLYC3sRR8dBMa3
         5I5/IEVLQhOWsswxO67eV+rt19J99IhLN67tk=
Received: by 10.231.55.90 with SMTP id t26mr3414279ibg.116.1302368077163;
        Sat, 09 Apr 2011 09:54:37 -0700 (PDT)
Received: from tre ([115.73.238.90])
        by mx.google.com with ESMTPS id e9sm2754977ibb.32.2011.04.09.09.54.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 09 Apr 2011 09:54:35 -0700 (PDT)
Received: by tre (sSMTP sendmail emulation); Sat, 09 Apr 2011 23:54:28 +0700
X-Mailer: git-send-email 1.7.4.74.g639db
In-Reply-To: <1302368060-23827-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171196>

This renames:

 - get_pathspec()         to get_pathspec_old()
 - match_pathspec()       to match_pathspec_old()
 - match_pathspec_depth() to match_pathspec()

The name get_pathspec() will be used for a new function which produces
struct pathspec directly.

Both get_pathspec implementations will co-exist for a while until
everything is converted to get_pathspec(). By that point, both
match_pathspec_old() and get_pathspec_old() would be removed.

Because two get_pathspec impl must provide the same functionality, the
new get_pathspec() can't (or shouldn't) implement any magic other than
'top' and 'icase' already supported by get_pathspec_old().
---
 archive.c              |    2 +-
 builtin/add.c          |    6 +++---
 builtin/checkout.c     |    8 ++++----
 builtin/clean.c        |    4 ++--
 builtin/commit.c       |    6 +++---
 builtin/grep.c         |    6 +++---
 builtin/ls-files.c     |    8 ++++----
 builtin/ls-tree.c      |    2 +-
 builtin/mv.c           |    2 +-
 builtin/rerere.c       |    2 +-
 builtin/reset.c        |    4 ++--
 builtin/rm.c           |    4 ++--
 builtin/update-index.c |    2 +-
 cache.h                |    2 +-
 dir.c                  |    4 ++--
 dir.h                  |    4 ++--
 read-cache.c           |    4 ++--
 rerere.c               |    2 +-
 resolve-undo.c         |    2 +-
 revision.c             |    2 +-
 setup.c                |    2 +-
 wt-status.c            |    4 ++--
 22 files changed, 41 insertions(+), 41 deletions(-)

diff --git a/archive.c b/archive.c
index 1944ed4..884bb2f 100644
--- a/archive.c
+++ b/archive.c
@@ -231,7 +231,7 @@ static int path_exists(struct tree *tree, const char *path)
 static void parse_pathspec_arg(const char **pathspec,
 		struct archiver_args *ar_args)
 {
-	ar_args->pathspec = pathspec = get_pathspec("", pathspec);
+	ar_args->pathspec = pathspec = get_pathspec_old("", pathspec);
 	if (pathspec) {
 		while (*pathspec) {
 			if (!path_exists(ar_args->tree, *pathspec))
diff --git a/builtin/add.c b/builtin/add.c
index e127d5a..552801a 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -112,7 +112,7 @@ static void fill_pathspec_matches(const char **pathspec, char *seen, int specs)
 		return;
 	for (i = 0; i < active_nr; i++) {
 		struct cache_entry *ce = active_cache[i];
-		match_pathspec(pathspec, ce->name, ce_namelen(ce), 0, seen);
+		match_pathspec_old(pathspec, ce->name, ce_namelen(ce), 0, seen);
 	}
 }
 
@@ -142,7 +142,7 @@ static char *prune_directory(struct dir_struct *dir, const char **pathspec, int
 	i = dir->nr;
 	while (--i >= 0) {
 		struct dir_entry *entry = *src++;
-		if (match_pathspec(pathspec, entry->name, entry->len,
+		if (match_pathspec_old(pathspec, entry->name, entry->len,
 				   prefix, seen))
 			*dst++ = entry;
 	}
@@ -197,7 +197,7 @@ static void refresh(int verbose, const char **pathspec)
 
 static const char **validate_pathspec(int argc, const char **argv, const char *prefix)
 {
-	const char **pathspec = get_pathspec(prefix, argv);
+	const char **pathspec = get_pathspec_old(prefix, argv);
 
 	if (pathspec) {
 		const char **p;
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 2bf02f2..3bcff35 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -223,7 +223,7 @@ static int checkout_paths(struct tree *source_tree, const char **pathspec,
 
 	for (pos = 0; pos < active_nr; pos++) {
 		struct cache_entry *ce = active_cache[pos];
-		match_pathspec(pathspec, ce->name, ce_namelen(ce), 0, ps_matched);
+		match_pathspec_old(pathspec, ce->name, ce_namelen(ce), 0, ps_matched);
 	}
 
 	if (report_path_error(ps_matched, pathspec, 0))
@@ -236,7 +236,7 @@ static int checkout_paths(struct tree *source_tree, const char **pathspec,
 	/* Any unmerged paths? */
 	for (pos = 0; pos < active_nr; pos++) {
 		struct cache_entry *ce = active_cache[pos];
-		if (match_pathspec(pathspec, ce->name, ce_namelen(ce), 0, NULL)) {
+		if (match_pathspec_old(pathspec, ce->name, ce_namelen(ce), 0, NULL)) {
 			if (!ce_stage(ce))
 				continue;
 			if (opts->force) {
@@ -261,7 +261,7 @@ static int checkout_paths(struct tree *source_tree, const char **pathspec,
 	state.refresh_cache = 1;
 	for (pos = 0; pos < active_nr; pos++) {
 		struct cache_entry *ce = active_cache[pos];
-		if (match_pathspec(pathspec, ce->name, ce_namelen(ce), 0, NULL)) {
+		if (match_pathspec_old(pathspec, ce->name, ce_namelen(ce), 0, NULL)) {
 			if (!ce_stage(ce)) {
 				errs |= checkout_entry(ce, &state, NULL);
 				continue;
@@ -1005,7 +1005,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 		opts.track = git_branch_track;
 
 	if (argc) {
-		const char **pathspec = get_pathspec(prefix, argv);
+		const char **pathspec = get_pathspec_old(prefix, argv);
 
 		if (!pathspec)
 			die("invalid path specification");
diff --git a/builtin/clean.c b/builtin/clean.c
index 4a312ab..92889c6 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -95,7 +95,7 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 	for (i = 0; i < exclude_list.nr; i++)
 		add_exclude(exclude_list.items[i].string, "", 0, dir.exclude_list);
 
-	pathspec = get_pathspec(prefix, argv);
+	pathspec = get_pathspec_old(prefix, argv);
 
 	fill_directory(&dir, pathspec);
 
@@ -137,7 +137,7 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 
 		if (pathspec) {
 			memset(seen, 0, argc > 0 ? argc : 1);
-			matches = match_pathspec(pathspec, ent->name, len,
+			matches = match_pathspec_old(pathspec, ent->name, len,
 						 0, seen);
 		}
 
diff --git a/builtin/commit.c b/builtin/commit.c
index 3979b82..efdc7ae 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -264,7 +264,7 @@ static int list_paths(struct string_list *list, const char *with_tree,
 
 		if (ce->ce_flags & CE_UPDATE)
 			continue;
-		if (!match_pathspec(pattern, ce->name, ce_namelen(ce), 0, m))
+		if (!match_pathspec_old(pattern, ce->name, ce_namelen(ce), 0, m))
 			continue;
 		item = string_list_insert(list, ce->name);
 		if (ce_skip_worktree(ce))
@@ -350,7 +350,7 @@ static char *prepare_index(int argc, const char **argv, const char *prefix, int
 	}
 
 	if (*argv)
-		pathspec = get_pathspec(prefix, argv);
+		pathspec = get_pathspec_old(prefix, argv);
 
 	if (read_cache_preload(pathspec) < 0)
 		die("index file corrupt");
@@ -1197,7 +1197,7 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 	if (show_ignored_in_status)
 		s.show_ignored_files = 1;
 	if (*argv)
-		s.pathspec = get_pathspec(prefix, argv);
+		s.pathspec = get_pathspec_old(prefix, argv);
 
 	read_cache_preload(s.pathspec);
 	refresh_index(&the_index, REFRESH_QUIET|REFRESH_UNMERGED, s.pathspec, NULL, NULL);
diff --git a/builtin/grep.c b/builtin/grep.c
index 0bf8c01..2826ca8 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -490,7 +490,7 @@ static int grep_cache(struct grep_opt *opt, const struct pathspec *pathspec, int
 		struct cache_entry *ce = active_cache[nr];
 		if (!S_ISREG(ce->ce_mode))
 			continue;
-		if (!match_pathspec_depth(pathspec, ce->name, ce_namelen(ce), 0, NULL))
+		if (!match_pathspec(pathspec, ce->name, ce_namelen(ce), 0, NULL))
 			continue;
 		/*
 		 * If CE_VALID is on, we assume worktree file and its cache entry
@@ -627,7 +627,7 @@ static int grep_directory(struct grep_opt *opt, const struct pathspec *pathspec)
 	for (i = 0; i < dir.nr; i++) {
 		const char *name = dir.entries[i]->name;
 		int namelen = strlen(name);
-		if (!match_pathspec_depth(pathspec, name, namelen, 0, NULL))
+		if (!match_pathspec(pathspec, name, namelen, 0, NULL))
 			continue;
 		hit |= grep_file(opt, dir.entries[i]->name);
 		if (hit && opt->status_only)
@@ -957,7 +957,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	}
 
 	if (i < argc)
-		paths = get_pathspec(prefix, argv + i);
+		paths = get_pathspec_old(prefix, argv + i);
 	else if (prefix) {
 		paths = xcalloc(2, sizeof(const char *));
 		paths[0] = prefix;
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index fb2d5f4..8e39503 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -58,7 +58,7 @@ static void show_dir_entry(const char *tag, struct dir_entry *ent)
 	if (len >= ent->len)
 		die("git ls-files: internal error - directory entry not superset of prefix");
 
-	if (!match_pathspec(pathspec, ent->name, ent->len, len, ps_matched))
+	if (!match_pathspec_old(pathspec, ent->name, ent->len, len, ps_matched))
 		return;
 
 	fputs(tag, stdout);
@@ -133,7 +133,7 @@ static void show_ce_entry(const char *tag, struct cache_entry *ce)
 	if (len >= ce_namelen(ce))
 		die("git ls-files: internal error - cache entry not superset of prefix");
 
-	if (!match_pathspec(pathspec, ce->name, ce_namelen(ce), len, ps_matched))
+	if (!match_pathspec_old(pathspec, ce->name, ce_namelen(ce), len, ps_matched))
 		return;
 
 	if (tag && *tag && show_valid_bit &&
@@ -187,7 +187,7 @@ static void show_ru_info(void)
 		len = strlen(path);
 		if (len < max_prefix_len)
 			continue; /* outside of the prefix */
-		if (!match_pathspec(pathspec, path, len, max_prefix_len, ps_matched))
+		if (!match_pathspec_old(pathspec, path, len, max_prefix_len, ps_matched))
 			continue; /* uninterested */
 		for (i = 0; i < 3; i++) {
 			if (!ui->mode[i])
@@ -568,7 +568,7 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 	if (require_work_tree && !is_inside_work_tree())
 		setup_work_tree();
 
-	pathspec = get_pathspec(prefix, argv);
+	pathspec = get_pathspec_old(prefix, argv);
 
 	/* be nice with submodule paths ending in a slash */
 	if (pathspec)
diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index f73e6bd..f55dba9 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -166,7 +166,7 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 	if (get_sha1(argv[0], sha1))
 		die("Not a valid object name %s", argv[0]);
 
-	pathspec = get_pathspec(prefix, argv + 1);
+	pathspec = get_pathspec_old(prefix, argv + 1);
 	tree = parse_tree_indirect(sha1);
 	if (!tree)
 		die("not a tree object");
diff --git a/builtin/mv.c b/builtin/mv.c
index 93e8995..37a285e 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -32,7 +32,7 @@ static const char **copy_pathspec(const char *prefix, const char **pathspec,
 			result[i] = base_name ? strdup(basename(it)) : it;
 		}
 	}
-	return get_pathspec(prefix, result);
+	return get_pathspec_old(prefix, result);
 }
 
 static const char *add_slash(const char *path)
diff --git a/builtin/rerere.c b/builtin/rerere.c
index 8235885..d31cc95 100644
--- a/builtin/rerere.c
+++ b/builtin/rerere.c
@@ -139,7 +139,7 @@ int cmd_rerere(int argc, const char **argv, const char *prefix)
 		const char **pathspec;
 		if (argc < 2)
 			warning("'git rerere forget' without paths is deprecated");
-		pathspec = get_pathspec(prefix, argv + 1);
+		pathspec = get_pathspec_old(prefix, argv + 1);
 		return rerere_forget(pathspec);
 	}
 
diff --git a/builtin/reset.c b/builtin/reset.c
index 5de2bce..7d8a29a 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -182,7 +182,7 @@ static int interactive_reset(const char *revision, const char **argv,
 	const char **pathspec = NULL;
 
 	if (*argv)
-		pathspec = get_pathspec(prefix, argv);
+		pathspec = get_pathspec_old(prefix, argv);
 
 	return run_add_interactive(revision, "--patch=reset", pathspec);
 }
@@ -195,7 +195,7 @@ static int read_from_tree(const char *prefix, const char **argv,
 	struct diff_options opt;
 
 	memset(&opt, 0, sizeof(opt));
-	diff_tree_setup_paths(get_pathspec(prefix, (const char **)argv), &opt);
+	diff_tree_setup_paths(get_pathspec_old(prefix, (const char **)argv), &opt);
 	opt.output_format = DIFF_FORMAT_CALLBACK;
 	opt.format_callback = update_index_from_diff;
 	opt.format_callback_data = &index_was_discarded;
diff --git a/builtin/rm.c b/builtin/rm.c
index ff491d7..65a0e07 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -161,7 +161,7 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 	if (read_cache() < 0)
 		die("index file corrupt");
 
-	pathspec = get_pathspec(prefix, argv);
+	pathspec = get_pathspec_old(prefix, argv);
 	refresh_index(&the_index, REFRESH_QUIET, pathspec, NULL, NULL);
 
 	seen = NULL;
@@ -171,7 +171,7 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 
 	for (i = 0; i < active_nr; i++) {
 		struct cache_entry *ce = active_cache[i];
-		if (!match_pathspec(pathspec, ce->name, ce_namelen(ce), 0, seen))
+		if (!match_pathspec_old(pathspec, ce->name, ce_namelen(ce), 0, seen))
 			continue;
 		ALLOC_GROW(list.name, list.nr + 1, list.alloc);
 		list.name[list.nr++] = ce->name;
diff --git a/builtin/update-index.c b/builtin/update-index.c
index d7850c6..4ac72cf 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -546,7 +546,7 @@ static int do_reupdate(int ac, const char **av,
 	 */
 	int pos;
 	int has_head = 1;
-	const char **paths = get_pathspec(prefix, av + 1);
+	const char **paths = get_pathspec_old(prefix, av + 1);
 	struct pathspec pathspec;
 
 	init_pathspec(&pathspec, paths);
diff --git a/cache.h b/cache.h
index be6ce72..27ac8a7 100644
--- a/cache.h
+++ b/cache.h
@@ -425,7 +425,7 @@ extern void set_git_work_tree(const char *tree);
 
 #define ALTERNATE_DB_ENVIRONMENT "GIT_ALTERNATE_OBJECT_DIRECTORIES"
 
-extern const char **get_pathspec(const char *prefix, const char **pathspec);
+extern const char **get_pathspec_old(const char *prefix, const char **pathspec);
 extern void setup_work_tree(void);
 extern const char *setup_git_directory_gently(int *);
 extern const char *setup_git_directory(void);
diff --git a/dir.c b/dir.c
index 325fb56..6eb04ea 100644
--- a/dir.c
+++ b/dir.c
@@ -172,7 +172,7 @@ static int match_one(const char *match, const char *name, int namelen)
  * and a mark is left in seen[] array for pathspec element that
  * actually matched anything.
  */
-int match_pathspec(const char **pathspec, const char *name, int namelen,
+int match_pathspec_old(const char **pathspec, const char *name, int namelen,
 		int prefix, char *seen)
 {
 	int i, retval = 0;
@@ -244,7 +244,7 @@ static int match_pathspec_item(const struct pathspec_item *item, int prefix,
  * and a mark is left in seen[] array for pathspec element that
  * actually matched anything.
  */
-int match_pathspec_depth(const struct pathspec *ps,
+int match_pathspec(const struct pathspec *ps,
 			 const char *name, int namelen,
 			 int prefix, char *seen)
 {
diff --git a/dir.h b/dir.h
index aa511da..758ab6c 100644
--- a/dir.h
+++ b/dir.h
@@ -64,8 +64,8 @@ struct dir_struct {
 #define MATCHED_RECURSIVELY 1
 #define MATCHED_FNMATCH 2
 #define MATCHED_EXACTLY 3
-extern int match_pathspec(const char **pathspec, const char *name, int namelen, int prefix, char *seen);
-extern int match_pathspec_depth(const struct pathspec *pathspec,
+extern int match_pathspec_old(const char **pathspec, const char *name, int namelen, int prefix, char *seen);
+extern int match_pathspec(const struct pathspec *pathspec,
 				const char *name, int namelen,
 				int prefix, char *seen);
 extern int within_depth(const char *name, int namelen, int depth, int max_depth);
diff --git a/read-cache.c b/read-cache.c
index 98d526b..6644869 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -708,7 +708,7 @@ int ce_same_name(struct cache_entry *a, struct cache_entry *b)
 
 int ce_path_match(const struct cache_entry *ce, const struct pathspec *pathspec)
 {
-	return match_pathspec_depth(pathspec, ce->name, ce_namelen(ce), 0, NULL);
+	return match_pathspec(pathspec, ce->name, ce_namelen(ce), 0, NULL);
 }
 
 /*
@@ -1130,7 +1130,7 @@ int refresh_index(struct index_state *istate, unsigned int flags, const char **p
 			continue;
 		}
 
-		if (pathspec && !match_pathspec(pathspec, ce->name, strlen(ce->name), 0, seen))
+		if (pathspec && !match_pathspec_old(pathspec, ce->name, strlen(ce->name), 0, seen))
 			continue;
 
 		new = refresh_cache_ent(istate, ce, options, &cache_errno);
diff --git a/rerere.c b/rerere.c
index 22996bd..af42948 100644
--- a/rerere.c
+++ b/rerere.c
@@ -665,7 +665,7 @@ int rerere_forget(const char **pathspec)
 	find_conflict(&conflict);
 	for (i = 0; i < conflict.nr; i++) {
 		struct string_list_item *it = &conflict.items[i];
-		if (!match_pathspec(pathspec, it->string, strlen(it->string),
+		if (!match_pathspec_old(pathspec, it->string, strlen(it->string),
 				    0, NULL))
 			continue;
 		rerere_forget_one_path(it->string, &merge_rr);
diff --git a/resolve-undo.c b/resolve-undo.c
index 72b4612..8400db6 100644
--- a/resolve-undo.c
+++ b/resolve-undo.c
@@ -165,7 +165,7 @@ void unmerge_index(struct index_state *istate, const char **pathspec)
 
 	for (i = 0; i < istate->cache_nr; i++) {
 		struct cache_entry *ce = istate->cache[i];
-		if (!match_pathspec(pathspec, ce->name, ce_namelen(ce), 0, NULL))
+		if (!match_pathspec_old(pathspec, ce->name, ce_namelen(ce), 0, NULL))
 			continue;
 		i = unmerge_index_entry_at(istate, i);
 	}
diff --git a/revision.c b/revision.c
index 86d2470..b1edc2f 100644
--- a/revision.c
+++ b/revision.c
@@ -1617,7 +1617,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 	}
 
 	if (prune_data)
-		init_pathspec(&revs->prune_data, get_pathspec(revs->prefix, prune_data));
+		init_pathspec(&revs->prune_data, get_pathspec_old(revs->prefix, prune_data));
 
 	if (revs->def == NULL)
 		revs->def = opt ? opt->def : NULL;
diff --git a/setup.c b/setup.c
index 51e354c..4e5ac5e 100644
--- a/setup.c
+++ b/setup.c
@@ -251,7 +251,7 @@ const char *prefix_pathspec(const char *prefix, int prefixlen, const char *elt)
 	return retval;
 }
 
-const char **get_pathspec(const char *prefix, const char **pathspec)
+const char **get_pathspec_old(const char *prefix, const char **pathspec)
 {
 	const char *entry = *pathspec;
 	const char **src, **dst;
diff --git a/wt-status.c b/wt-status.c
index 53558d7..2785bc3 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -472,7 +472,7 @@ static void wt_status_collect_untracked(struct wt_status *s)
 	for (i = 0; i < dir.nr; i++) {
 		struct dir_entry *ent = dir.entries[i];
 		if (cache_name_is_other(ent->name, ent->len) &&
-		    match_pathspec(s->pathspec, ent->name, ent->len, 0, NULL))
+		    match_pathspec_old(s->pathspec, ent->name, ent->len, 0, NULL))
 			string_list_insert(&s->untracked, ent->name);
 		free(ent);
 	}
@@ -484,7 +484,7 @@ static void wt_status_collect_untracked(struct wt_status *s)
 		for (i = 0; i < dir.nr; i++) {
 			struct dir_entry *ent = dir.entries[i];
 			if (cache_name_is_other(ent->name, ent->len) &&
-			    match_pathspec(s->pathspec, ent->name, ent->len, 0, NULL))
+			    match_pathspec_old(s->pathspec, ent->name, ent->len, 0, NULL))
 				string_list_insert(&s->ignored, ent->name);
 			free(ent);
 		}
-- 
1.7.4.74.g639db
