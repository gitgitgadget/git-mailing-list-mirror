Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F6441F403
	for <e@80x24.org>; Wed,  6 Jun 2018 17:03:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933795AbeFFRDH (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 13:03:07 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:34875 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933029AbeFFRDE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 13:03:04 -0400
Received: by mail-lf0-f68.google.com with SMTP id y72-v6so10222787lfd.2
        for <git@vger.kernel.org>; Wed, 06 Jun 2018 10:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fOtdANV/36j/z64+QLb7xtkNusgEpqYimPkrbxP7pWM=;
        b=W6CfYd/J7ssomMUFScQ/JmlkzSOVsG7km+xfwFAIo5ABKpoprBmCr8vwkq75fWER7B
         b/1avqs9M3cLtND1bAaBRCsRsjh4aOg+9kpdpGZh77/CulJzyrmBzpDz0EWLcd7dvaKK
         Bo9Qr9DPe/JrSWd3lOBLa2zVpxmDr3mIP3UWcyvRyFY4plF9Q72lQY2Sm2ufOn4lEN0J
         QAPlyoO8aW6wHaGvIXAwWNkb6El0Uk03YwLPPaDbJTO9oZM41Ux4sOoKeQGuRefEV5HT
         fMHpANbi40/HpZPc4KzT3GQkIOeFCzv2dBX1QOLrRPu6W52AJjkhqgEM319xoAnjUeG+
         99rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fOtdANV/36j/z64+QLb7xtkNusgEpqYimPkrbxP7pWM=;
        b=CI0thFp8TgoP4tIKbgoSe09Vl1zfh8cTyD6GXHQt0GI8IGax7BlfRLMTmpP9HMPAhL
         QmTpuwpY6c8GsZJvJTHHdOl420rwYLJ83+1sa2yCL0ZHkDDNDYutjxUfWpMAgePz9ebH
         u2UNRA4gmUXtdYcRwQNpX6MEIE/82sP1E6piOQp0Dd7D6SFCP8X8+anOJKHgqCYsU9Zb
         49hrw5ol4gy/FJpSdtwYL0s3dO/y/U+xW9dAO4WoGP6fG+7FiWpm3gt6R+jm66/sX79/
         gRZm2CNAbjNjuDIOV24G06f0cCMuoyHyYI/A/JIKC2Z715A7b73Y52T9G0Xbhe1iVjQw
         HLag==
X-Gm-Message-State: APt69E2a0OuJKsYwoCJFkahdRThvAMq87se1Np9nfQRoqoi6nRdRAmXP
        hRpkGjRIykWLN60QY0yUTy4=
X-Google-Smtp-Source: ADUXVKK9Y6EMOPjttPiBgv2BGs/aoWktZMdDEwJ4+70SLQGcK2uciuLWHgIpNLRk3j0psTqdxhn0Fw==
X-Received: by 2002:a19:e9d3:: with SMTP id j80-v6mr2497024lfk.129.1528304582380;
        Wed, 06 Jun 2018 10:03:02 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g14-v6sm1485305lfb.36.2018.06.06.10.03.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Jun 2018 10:03:01 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     bmwill@google.com, git@vger.kernel.org, newren@gmail.com,
        ramsay@ramsayjones.plus.com
Subject: [PATCH v4 10/23] dir.c: remove an implicit dependency on the_index in pathspec code
Date:   Wed,  6 Jun 2018 19:02:30 +0200
Message-Id: <20180606170243.4169-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.333.g22e6ee6cdf
In-Reply-To: <20180606170243.4169-1-pclouds@gmail.com>
References: <20180606165016.3285-1-pclouds@gmail.com>
 <20180606170243.4169-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make the match_patchspec API and friends take an index_state instead
of assuming the_index in dir.c. All external call sites are converted
blindly to keep the patch simple and retain current behavior.
Individual call sites may receive further updates to use the right
index instead of the_index.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 archive.c                   |  2 +-
 builtin/add.c               |  6 +++---
 builtin/checkout.c          |  2 +-
 builtin/clean.c             |  2 +-
 builtin/commit.c            |  2 +-
 builtin/grep.c              |  6 +++---
 builtin/ls-files.c          |  6 +++---
 builtin/rm.c                |  2 +-
 builtin/submodule--helper.c |  2 +-
 builtin/update-index.c      |  2 +-
 diff-lib.c                  |  4 ++--
 dir.c                       | 27 ++++++++++++++++-----------
 dir.h                       | 16 ++++++++++------
 pathspec.c                  |  2 +-
 preload-index.c             |  2 +-
 read-cache.c                |  2 +-
 rerere.c                    |  2 +-
 resolve-undo.c              |  2 +-
 revision.c                  |  2 +-
 submodule.c                 |  2 +-
 wt-status.c                 |  6 +++---
 21 files changed, 54 insertions(+), 45 deletions(-)

diff --git a/archive.c b/archive.c
index f3631a4fb5..1b44503ebb 100644
--- a/archive.c
+++ b/archive.c
@@ -312,7 +312,7 @@ static int reject_entry(const struct object_id *oid, struct strbuf *base,
 		struct strbuf sb = STRBUF_INIT;
 		strbuf_addbuf(&sb, base);
 		strbuf_addstr(&sb, filename);
-		if (!match_pathspec(context, sb.buf, sb.len, 0, NULL, 1))
+		if (!match_pathspec(&the_index, context, sb.buf, sb.len, 0, NULL, 1))
 			ret = READ_TREE_RECURSIVE;
 		strbuf_release(&sb);
 	}
diff --git a/builtin/add.c b/builtin/add.c
index 8a155dd41e..066623a195 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -40,7 +40,7 @@ static void chmod_pathspec(struct pathspec *pathspec, char flip)
 	for (i = 0; i < active_nr; i++) {
 		struct cache_entry *ce = active_cache[i];
 
-		if (pathspec && !ce_path_match(ce, pathspec, NULL))
+		if (pathspec && !ce_path_match(&the_index, ce, pathspec, NULL))
 			continue;
 
 		if (chmod_cache_entry(ce, flip) < 0)
@@ -135,7 +135,7 @@ static int renormalize_tracked_files(const struct pathspec *pathspec, int flags)
 			continue; /* do not touch unmerged paths */
 		if (!S_ISREG(ce->ce_mode) && !S_ISLNK(ce->ce_mode))
 			continue; /* do not touch non blobs */
-		if (pathspec && !ce_path_match(ce, pathspec, NULL))
+		if (pathspec && !ce_path_match(&the_index, ce, pathspec, NULL))
 			continue;
 		retval |= add_file_to_cache(ce->name, flags | HASH_RENORMALIZE);
 	}
@@ -155,7 +155,7 @@ static char *prune_directory(struct dir_struct *dir, struct pathspec *pathspec,
 	i = dir->nr;
 	while (--i >= 0) {
 		struct dir_entry *entry = *src++;
-		if (dir_path_match(entry, pathspec, prefix, seen))
+		if (dir_path_match(&the_index, entry, pathspec, prefix, seen))
 			*dst++ = entry;
 	}
 	dir->nr = dst - dir->entries;
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 2e1d2376d2..f8c208cea1 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -316,7 +316,7 @@ static int checkout_paths(const struct checkout_opts *opts,
 		 * match_pathspec() for _all_ entries when
 		 * opts->source_tree != NULL.
 		 */
-		if (ce_path_match(ce, &opts->pathspec, ps_matched))
+		if (ce_path_match(&the_index, ce, &opts->pathspec, ps_matched))
 			ce->ce_flags |= CE_MATCHED;
 	}
 
diff --git a/builtin/clean.c b/builtin/clean.c
index fad533a0a7..d4ca64904f 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -981,7 +981,7 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 			continue;
 
 		if (pathspec.nr)
-			matches = dir_path_match(ent, &pathspec, 0, NULL);
+			matches = dir_path_match(&the_index, ent, &pathspec, 0, NULL);
 
 		if (pathspec.nr && !matches)
 			continue;
diff --git a/builtin/commit.c b/builtin/commit.c
index a842fea666..f593ec1bbc 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -238,7 +238,7 @@ static int list_paths(struct string_list *list, const char *with_tree,
 
 		if (ce->ce_flags & CE_UPDATE)
 			continue;
-		if (!ce_path_match(ce, pattern, m))
+		if (!ce_path_match(&the_index, ce, pattern, m))
 			continue;
 		item = string_list_insert(list, ce->name);
 		if (ce_skip_worktree(ce))
diff --git a/builtin/grep.c b/builtin/grep.c
index ee753a403e..2eae397e92 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -497,7 +497,7 @@ static int grep_cache(struct grep_opt *opt, struct repository *repo,
 		strbuf_addstr(&name, ce->name);
 
 		if (S_ISREG(ce->ce_mode) &&
-		    match_pathspec(pathspec, name.buf, name.len, 0, NULL,
+		    match_pathspec(&the_index, pathspec, name.buf, name.len, 0, NULL,
 				   S_ISDIR(ce->ce_mode) ||
 				   S_ISGITLINK(ce->ce_mode))) {
 			/*
@@ -515,7 +515,7 @@ static int grep_cache(struct grep_opt *opt, struct repository *repo,
 				hit |= grep_file(opt, name.buf);
 			}
 		} else if (recurse_submodules && S_ISGITLINK(ce->ce_mode) &&
-			   submodule_path_match(pathspec, name.buf, NULL)) {
+			   submodule_path_match(&the_index, pathspec, name.buf, NULL)) {
 			hit |= grep_submodule(opt, repo, pathspec, NULL, ce->name, ce->name);
 		} else {
 			continue;
@@ -678,7 +678,7 @@ static int grep_directory(struct grep_opt *opt, const struct pathspec *pathspec,
 
 	fill_directory(&dir, &the_index, pathspec);
 	for (i = 0; i < dir.nr; i++) {
-		if (!dir_path_match(dir.entries[i], pathspec, 0, NULL))
+		if (!dir_path_match(&the_index, dir.entries[i], pathspec, 0, NULL))
 			continue;
 		hit |= grep_file(opt, dir.entries[i]->name);
 		if (hit && opt->status_only)
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index d996734b45..7233b92794 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -128,7 +128,7 @@ static void show_dir_entry(const char *tag, struct dir_entry *ent)
 	if (len > ent->len)
 		die("git ls-files: internal error - directory entry not superset of prefix");
 
-	if (!dir_path_match(ent, &pathspec, len, ps_matched))
+	if (!dir_path_match(&the_index, ent, &pathspec, len, ps_matched))
 		return;
 
 	fputs(tag, stdout);
@@ -228,7 +228,7 @@ static void show_ce(struct repository *repo, struct dir_struct *dir,
 	if (recurse_submodules && S_ISGITLINK(ce->ce_mode) &&
 	    is_submodule_active(repo, ce->name)) {
 		show_submodule(repo, dir, ce->name);
-	} else if (match_pathspec(&pathspec, fullname, strlen(fullname),
+	} else if (match_pathspec(&the_index, &pathspec, fullname, strlen(fullname),
 				  max_prefix_len, ps_matched,
 				  S_ISDIR(ce->ce_mode) ||
 				  S_ISGITLINK(ce->ce_mode))) {
@@ -264,7 +264,7 @@ static void show_ru_info(const struct index_state *istate)
 		len = strlen(path);
 		if (len < max_prefix_len)
 			continue; /* outside of the prefix */
-		if (!match_pathspec(&pathspec, path, len,
+		if (!match_pathspec(&the_index, &pathspec, path, len,
 				    max_prefix_len, ps_matched, 0))
 			continue; /* uninterested */
 		for (i = 0; i < 3; i++) {
diff --git a/builtin/rm.c b/builtin/rm.c
index 65b448ef8e..eebdc4aab1 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -278,7 +278,7 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 
 	for (i = 0; i < active_nr; i++) {
 		const struct cache_entry *ce = active_cache[i];
-		if (!ce_path_match(ce, &pathspec, seen))
+		if (!ce_path_match(&the_index, ce, &pathspec, seen))
 			continue;
 		ALLOC_GROW(list.entry, list.nr + 1, list.alloc);
 		list.entry[list.nr].name = xstrdup(ce->name);
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index bd250ca216..d59c6a988e 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -330,7 +330,7 @@ static int module_list_compute(int argc, const char **argv,
 	for (i = 0; i < active_nr; i++) {
 		const struct cache_entry *ce = active_cache[i];
 
-		if (!match_pathspec(pathspec, ce->name, ce_namelen(ce),
+		if (!match_pathspec(&the_index, pathspec, ce->name, ce_namelen(ce),
 				    0, ps_matched, 1) ||
 		    !S_ISGITLINK(ce->ce_mode))
 			continue;
diff --git a/builtin/update-index.c b/builtin/update-index.c
index a8709a26ec..a181b5c14c 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -751,7 +751,7 @@ static int do_reupdate(int ac, const char **av,
 		int save_nr;
 		char *path;
 
-		if (ce_stage(ce) || !ce_path_match(ce, &pathspec, NULL))
+		if (ce_stage(ce) || !ce_path_match(&the_index, ce, &pathspec, NULL))
 			continue;
 		if (has_head)
 			old = read_one_ent(NULL, &head_oid,
diff --git a/diff-lib.c b/diff-lib.c
index 104f954a25..068d00705e 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -109,7 +109,7 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 		if (diff_can_quit_early(&revs->diffopt))
 			break;
 
-		if (!ce_path_match(ce, &revs->prune_data, NULL))
+		if (!ce_path_match(&the_index, ce, &revs->prune_data, NULL))
 			continue;
 
 		if (ce_stage(ce)) {
@@ -470,7 +470,7 @@ static int oneway_diff(const struct cache_entry * const *src,
 	if (tree == o->df_conflict_entry)
 		tree = NULL;
 
-	if (ce_path_match(idx ? idx : tree, &revs->prune_data, NULL)) {
+	if (ce_path_match(&the_index, idx ? idx : tree, &revs->prune_data, NULL)) {
 		do_oneway_diff(o, idx, tree);
 		if (diff_can_quit_early(&revs->diffopt)) {
 			o->exiting_early = 1;
diff --git a/dir.c b/dir.c
index a541be3032..1f50559548 100644
--- a/dir.c
+++ b/dir.c
@@ -275,12 +275,13 @@ static int do_read_blob(const struct object_id *oid, struct oid_stat *oid_stat,
 #define DO_MATCH_DIRECTORY (1<<1)
 #define DO_MATCH_SUBMODULE (1<<2)
 
-static int match_attrs(const char *name, int namelen,
+static int match_attrs(const struct index_state *istate,
+		       const char *name, int namelen,
 		       const struct pathspec_item *item)
 {
 	int i;
 
-	git_check_attr(&the_index, name, item->attr_check);
+	git_check_attr(istate, name, item->attr_check);
 	for (i = 0; i < item->attr_match_nr; i++) {
 		const char *value;
 		int matched;
@@ -317,7 +318,8 @@ static int match_attrs(const char *name, int namelen,
  *
  * It returns 0 when there is no match.
  */
-static int match_pathspec_item(const struct pathspec_item *item, int prefix,
+static int match_pathspec_item(const struct index_state *istate,
+			       const struct pathspec_item *item, int prefix,
 			       const char *name, int namelen, unsigned flags)
 {
 	/* name/namelen has prefix cut off by caller */
@@ -357,7 +359,7 @@ static int match_pathspec_item(const struct pathspec_item *item, int prefix,
 	    strncmp(item->match, name - prefix, item->prefix))
 		return 0;
 
-	if (item->attr_match_nr && !match_attrs(name, namelen, item))
+	if (item->attr_match_nr && !match_attrs(istate, name, namelen, item))
 		return 0;
 
 	/* If the match was just the prefix, we matched */
@@ -425,7 +427,8 @@ static int match_pathspec_item(const struct pathspec_item *item, int prefix,
  * pathspec did not match any names, which could indicate that the
  * user mistyped the nth pathspec.
  */
-static int do_match_pathspec(const struct pathspec *ps,
+static int do_match_pathspec(const struct index_state *istate,
+			     const struct pathspec *ps,
 			     const char *name, int namelen,
 			     int prefix, char *seen,
 			     unsigned flags)
@@ -471,7 +474,7 @@ static int do_match_pathspec(const struct pathspec *ps,
 		 */
 		if (seen && ps->items[i].magic & PATHSPEC_EXCLUDE)
 			seen[i] = MATCHED_FNMATCH;
-		how = match_pathspec_item(ps->items+i, prefix, name,
+		how = match_pathspec_item(istate, ps->items+i, prefix, name,
 					  namelen, flags);
 		if (ps->recursive &&
 		    (ps->magic & PATHSPEC_MAXDEPTH) &&
@@ -495,17 +498,18 @@ static int do_match_pathspec(const struct pathspec *ps,
 	return retval;
 }
 
-int match_pathspec(const struct pathspec *ps,
+int match_pathspec(const struct index_state *istate,
+		   const struct pathspec *ps,
 		   const char *name, int namelen,
 		   int prefix, char *seen, int is_dir)
 {
 	int positive, negative;
 	unsigned flags = is_dir ? DO_MATCH_DIRECTORY : 0;
-	positive = do_match_pathspec(ps, name, namelen,
+	positive = do_match_pathspec(istate, ps, name, namelen,
 				     prefix, seen, flags);
 	if (!(ps->magic & PATHSPEC_EXCLUDE) || !positive)
 		return positive;
-	negative = do_match_pathspec(ps, name, namelen,
+	negative = do_match_pathspec(istate, ps, name, namelen,
 				     prefix, seen,
 				     flags | DO_MATCH_EXCLUDE);
 	return negative ? 0 : positive;
@@ -514,11 +518,12 @@ int match_pathspec(const struct pathspec *ps,
 /**
  * Check if a submodule is a superset of the pathspec
  */
-int submodule_path_match(const struct pathspec *ps,
+int submodule_path_match(const struct index_state *istate,
+			 const struct pathspec *ps,
 			 const char *submodule_name,
 			 char *seen)
 {
-	int matched = do_match_pathspec(ps, submodule_name,
+	int matched = do_match_pathspec(istate, ps, submodule_name,
 					strlen(submodule_name),
 					0, seen,
 					DO_MATCH_DIRECTORY |
diff --git a/dir.h b/dir.h
index f5fdedbab2..e3ec26143d 100644
--- a/dir.h
+++ b/dir.h
@@ -216,7 +216,8 @@ extern int count_slashes(const char *s);
 extern int simple_length(const char *match);
 extern int no_wildcard(const char *string);
 extern char *common_prefix(const struct pathspec *pathspec);
-extern int match_pathspec(const struct pathspec *pathspec,
+extern int match_pathspec(const struct index_state *istate,
+			  const struct pathspec *pathspec,
 			  const char *name, int namelen,
 			  int prefix, char *seen, int is_dir);
 extern int report_path_error(const char *ps_matched, const struct pathspec *pathspec, const char *prefix);
@@ -326,25 +327,28 @@ extern int git_fnmatch(const struct pathspec_item *item,
 		       const char *pattern, const char *string,
 		       int prefix);
 
-extern int submodule_path_match(const struct pathspec *ps,
+extern int submodule_path_match(const struct index_state *istate,
+				const struct pathspec *ps,
 				const char *submodule_name,
 				char *seen);
 
-static inline int ce_path_match(const struct cache_entry *ce,
+static inline int ce_path_match(const struct index_state *istate,
+				const struct cache_entry *ce,
 				const struct pathspec *pathspec,
 				char *seen)
 {
-	return match_pathspec(pathspec, ce->name, ce_namelen(ce), 0, seen,
+	return match_pathspec(istate, pathspec, ce->name, ce_namelen(ce), 0, seen,
 			      S_ISDIR(ce->ce_mode) || S_ISGITLINK(ce->ce_mode));
 }
 
-static inline int dir_path_match(const struct dir_entry *ent,
+static inline int dir_path_match(const struct index_state *istate,
+				 const struct dir_entry *ent,
 				 const struct pathspec *pathspec,
 				 int prefix, char *seen)
 {
 	int has_trailing_dir = ent->len && ent->name[ent->len - 1] == '/';
 	int len = has_trailing_dir ? ent->len - 1 : ent->len;
-	return match_pathspec(pathspec, ent->name, len, prefix, seen,
+	return match_pathspec(istate, pathspec, ent->name, len, prefix, seen,
 			      has_trailing_dir);
 }
 
diff --git a/pathspec.c b/pathspec.c
index 27cd606786..897cb9cbbe 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -37,7 +37,7 @@ void add_pathspec_matches_against_index(const struct pathspec *pathspec,
 		return;
 	for (i = 0; i < istate->cache_nr; i++) {
 		const struct cache_entry *ce = istate->cache[i];
-		ce_path_match(ce, pathspec, seen);
+		ce_path_match(&the_index, ce, pathspec, seen);
 	}
 }
 
diff --git a/preload-index.c b/preload-index.c
index 4d08d44874..d61d7662d5 100644
--- a/preload-index.c
+++ b/preload-index.c
@@ -58,7 +58,7 @@ static void *preload_thread(void *_data)
 			continue;
 		if (ce->ce_flags & CE_FSMONITOR_VALID)
 			continue;
-		if (!ce_path_match(ce, &p->pathspec, NULL))
+		if (!ce_path_match(&the_index, ce, &p->pathspec, NULL))
 			continue;
 		if (threaded_has_symlink_leading_path(&cache, ce->name, ce_namelen(ce)))
 			continue;
diff --git a/read-cache.c b/read-cache.c
index 372588260e..12cc22d157 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1415,7 +1415,7 @@ int refresh_index(struct index_state *istate, unsigned int flags,
 		if (ignore_submodules && S_ISGITLINK(ce->ce_mode))
 			continue;
 
-		if (pathspec && !ce_path_match(ce, pathspec, seen))
+		if (pathspec && !ce_path_match(&the_index, ce, pathspec, seen))
 			filtered = 1;
 
 		if (ce_stage(ce)) {
diff --git a/rerere.c b/rerere.c
index e0862e2778..e3b572296d 100644
--- a/rerere.c
+++ b/rerere.c
@@ -1118,7 +1118,7 @@ int rerere_forget(struct pathspec *pathspec)
 	find_conflict(&conflict);
 	for (i = 0; i < conflict.nr; i++) {
 		struct string_list_item *it = &conflict.items[i];
-		if (!match_pathspec(pathspec, it->string,
+		if (!match_pathspec(&the_index, pathspec, it->string,
 				    strlen(it->string), 0, NULL, 0))
 			continue;
 		rerere_forget_one_path(it->string, &merge_rr);
diff --git a/resolve-undo.c b/resolve-undo.c
index fc5b3b83d9..5e4c8c5f75 100644
--- a/resolve-undo.c
+++ b/resolve-undo.c
@@ -186,7 +186,7 @@ void unmerge_index(struct index_state *istate, const struct pathspec *pathspec)
 
 	for (i = 0; i < istate->cache_nr; i++) {
 		const struct cache_entry *ce = istate->cache[i];
-		if (!ce_path_match(ce, pathspec, NULL))
+		if (!ce_path_match(&the_index, ce, pathspec, NULL))
 			continue;
 		i = unmerge_index_entry_at(istate, i);
 	}
diff --git a/revision.c b/revision.c
index 40fd91ff2b..cf6aa1f443 100644
--- a/revision.c
+++ b/revision.c
@@ -1501,7 +1501,7 @@ static void prepare_show_merge(struct rev_info *revs)
 		const struct cache_entry *ce = active_cache[i];
 		if (!ce_stage(ce))
 			continue;
-		if (ce_path_match(ce, &revs->prune_data, NULL)) {
+		if (ce_path_match(&the_index, ce, &revs->prune_data, NULL)) {
 			prune_num++;
 			REALLOC_ARRAY(prune, prune_num);
 			prune[prune_num-2] = ce->name;
diff --git a/submodule.c b/submodule.c
index 939d6870ec..955560bdbb 100644
--- a/submodule.c
+++ b/submodule.c
@@ -258,7 +258,7 @@ int is_submodule_active(struct repository *repo, const char *path)
 		}
 
 		parse_pathspec(&ps, 0, 0, NULL, args.argv);
-		ret = match_pathspec(&ps, path, strlen(path), 0, NULL, 1);
+		ret = match_pathspec(&the_index, &ps, path, strlen(path), 0, NULL, 1);
 
 		argv_array_clear(&args);
 		clear_pathspec(&ps);
diff --git a/wt-status.c b/wt-status.c
index d1c05145a4..d384294c12 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -647,7 +647,7 @@ static void wt_status_collect_changes_initial(struct wt_status *s)
 		struct wt_status_change_data *d;
 		const struct cache_entry *ce = active_cache[i];
 
-		if (!ce_path_match(ce, &s->pathspec, NULL))
+		if (!ce_path_match(&the_index, ce, &s->pathspec, NULL))
 			continue;
 		if (ce_intent_to_add(ce))
 			continue;
@@ -703,7 +703,7 @@ static void wt_status_collect_untracked(struct wt_status *s)
 	for (i = 0; i < dir.nr; i++) {
 		struct dir_entry *ent = dir.entries[i];
 		if (cache_name_is_other(ent->name, ent->len) &&
-		    dir_path_match(ent, &s->pathspec, 0, NULL))
+		    dir_path_match(&the_index, ent, &s->pathspec, 0, NULL))
 			string_list_insert(&s->untracked, ent->name);
 		free(ent);
 	}
@@ -711,7 +711,7 @@ static void wt_status_collect_untracked(struct wt_status *s)
 	for (i = 0; i < dir.ignored_nr; i++) {
 		struct dir_entry *ent = dir.ignored[i];
 		if (cache_name_is_other(ent->name, ent->len) &&
-		    dir_path_match(ent, &s->pathspec, 0, NULL))
+		    dir_path_match(&the_index, ent, &s->pathspec, 0, NULL))
 			string_list_insert(&s->ignored, ent->name);
 		free(ent);
 	}
-- 
2.18.0.rc0.333.g22e6ee6cdf

