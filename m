Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD2B51F404
	for <e@80x24.org>; Thu, 28 Dec 2017 04:15:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753371AbdL1EPA (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Dec 2017 23:15:00 -0500
Received: from mail-it0-f65.google.com ([209.85.214.65]:45446 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753337AbdL1EO2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Dec 2017 23:14:28 -0500
Received: by mail-it0-f65.google.com with SMTP id z6so26969848iti.4
        for <git@vger.kernel.org>; Wed, 27 Dec 2017 20:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DoafF3RLuMCnqQVC6HojnFMvqrsWMfjn3p3zplqOOkA=;
        b=Y/8x0Jp5+k+N3Vv9eHvyyH+lNBP3j1r2LUP8RsB/P7ADo8Ad+Y6+50r1JfRHPj3Axf
         gp5xqAIa0CU9jQP9FqEup6HP6aUqm1pR7IbzJRp0QO/+MhewXfEAdoebqBhyRFr4Dclk
         tBqM+try2gUJEOfBBHMVs3C6brne/iGAskwM/BR0yS/+qjHEyHNi10LhAxSVUQpZfkID
         EGPUmeB0lwgM395GY9Rmcc+6O9i1LD+eron28mDfSlfBAWV/p3kAxM30eKUxUF1qEP9r
         SLShsDe5bzSo+9EQvei9HBDtjBquqpCZ4da6JRlm+Zun62dEfB+lLIVGlJMfB7ELtqMX
         7dtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DoafF3RLuMCnqQVC6HojnFMvqrsWMfjn3p3zplqOOkA=;
        b=cSUGw/gtzFc9Z58EUQ5jwoVuQRjy4hGrkqvboVAIByqeajYrC35exkrTwCuiK8JP/p
         dIyXQ6eVZVx4LYNk2ZYxZf/aydp+rMwt2IDkFcBFcP1fR49YVV1W46mdpSc/g00GWUsa
         y0ktX/z1NfkZQLK0S0w4hY44lcAYP+8Zi3UkOEDHbSnrsDWbyMomchcgnbd+3i5Q3XMa
         1WD9mp5ro2LQUeQ82kKCFk+kyxppVYlTJArrrJfB+ag0IMb77kEn9uuSS5qLmq8XX0kF
         h0D5hOB3z3p0YFri9qrWwIIh763kK1It4pgXawgCGBiYeDXh0TNftvq5WZa3gHw/aGkj
         VrNg==
X-Gm-Message-State: AKGB3mJWmuLhuGYB1Z33/fRa27mTOLhRH3a6ZJ4XoVEZdqRkiUTOCm7w
        bWw5jKAj1yQ0laGypapjOBJZVQ==
X-Google-Smtp-Source: ACJfBou1I/svy3+FSMBT4i/f+WJcqjV3nVOOjWGjsKv8gO9QnWfgdK9TaZ/YPT2t+PdqPtMQZmWctA==
X-Received: by 10.36.217.208 with SMTP id p199mr22738704itg.106.1514434467479;
        Wed, 27 Dec 2017 20:14:27 -0800 (PST)
Received: from localhost.localdomain (170-72-6-219.ut.vivintwireless.net. [170.72.6.219])
        by smtp.gmail.com with ESMTPSA id f207sm11201841ita.26.2017.12.27.20.14.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Dec 2017 20:14:26 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH v5 26/34] merge-recursive: check for file level conflicts then get new name
Date:   Wed, 27 Dec 2017 20:13:44 -0800
Message-Id: <20171228041352.27880-27-newren@gmail.com>
X-Mailer: git-send-email 2.15.0.408.g8e199d483
In-Reply-To: <20171228041352.27880-1-newren@gmail.com>
References: <20171228041352.27880-1-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before trying to apply directory renames to paths within the given
directories, we want to make sure that there aren't conflicts at the
file level either.  If there aren't any, then get the new name from
any directory renames.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c                   | 174 ++++++++++++++++++++++++++++++++++--
 strbuf.c                            |  16 ++++
 strbuf.h                            |  16 ++++
 t/t6043-merge-rename-directories.sh |   2 +-
 4 files changed, 199 insertions(+), 9 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 9e31baaf3..78f707d0d 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1508,6 +1508,91 @@ static void remove_hashmap_entries(struct hashmap *dir_renames,
 	string_list_clear(items_to_remove, 0);
 }
 
+/*
+ * See if there is a directory rename for path, and if there are any file
+ * level conflicts for the renamed location.  If there is a rename and
+ * there are no conflicts, return the new name.  Otherwise, return NULL.
+ */
+static char *handle_path_level_conflicts(struct merge_options *o,
+					 const char *path,
+					 struct dir_rename_entry *entry,
+					 struct hashmap *collisions,
+					 struct tree *tree)
+{
+	char *new_path = NULL;
+	struct collision_entry *collision_ent;
+	int clean = 1;
+	struct strbuf collision_paths = STRBUF_INIT;
+
+	/*
+	 * entry has the mapping of old directory name to new directory name
+	 * that we want to apply to path.
+	 */
+	new_path = apply_dir_rename(entry, path);
+
+	if (!new_path) {
+		/* This should only happen when entry->non_unique_new_dir set */
+		if (!entry->non_unique_new_dir)
+			BUG("entry->non_unqiue_dir not set and !new_path");
+		output(o, 1, _("CONFLICT (directory rename split): "
+			       "Unclear where to place %s because directory "
+			       "%s was renamed to multiple other directories, "
+			       "with no destination getting a majority of the "
+			       "files."),
+		       path, entry->dir);
+		clean = 0;
+		return NULL;
+	}
+
+	/*
+	 * The caller needs to have ensured that it has pre-populated
+	 * collisions with all paths that map to new_path.  Do a quick check
+	 * to ensure that's the case.
+	 */
+	collision_ent = collision_find_entry(collisions, new_path);
+	if (collision_ent == NULL)
+		BUG("collision_ent is NULL");
+
+	/*
+	 * Check for one-sided add/add/.../add conflicts, i.e.
+	 * where implicit renames from the other side doing
+	 * directory rename(s) can affect this side of history
+	 * to put multiple paths into the same location.  Warn
+	 * and bail on directory renames for such paths.
+	 */
+	if (collision_ent->reported_already) {
+		clean = 0;
+	} else if (tree_has_path(tree, new_path)) {
+		collision_ent->reported_already = 1;
+		strbuf_add_separated_string_list(&collision_paths, ", ",
+						 &collision_ent->source_files);
+		output(o, 1, _("CONFLICT (implicit dir rename): Existing "
+			       "file/dir at %s in the way of implicit "
+			       "directory rename(s) putting the following "
+			       "path(s) there: %s."),
+		       new_path, collision_paths.buf);
+		clean = 0;
+	} else if (collision_ent->source_files.nr > 1) {
+		collision_ent->reported_already = 1;
+		strbuf_add_separated_string_list(&collision_paths, ", ",
+						 &collision_ent->source_files);
+		output(o, 1, _("CONFLICT (implicit dir rename): Cannot map "
+			       "more than one path to %s; implicit directory "
+			       "renames tried to put these paths there: %s"),
+		       new_path, collision_paths.buf);
+		clean = 0;
+	}
+
+	/* Free memory we no longer need */
+	strbuf_release(&collision_paths);
+	if (!clean && new_path) {
+		free(new_path);
+		return NULL;
+	}
+
+	return new_path;
+}
+
 /*
  * There are a couple things we want to do at the directory level:
  *   1. Check for both sides renaming to the same thing, in order to avoid
@@ -1757,6 +1842,59 @@ static void compute_collisions(struct hashmap *collisions,
 	}
 }
 
+static char *check_for_directory_rename(struct merge_options *o,
+					const char *path,
+					struct tree *tree,
+					struct hashmap *dir_renames,
+					struct hashmap *dir_rename_exclusions,
+					struct hashmap *collisions,
+					int *clean_merge)
+{
+	char *new_path = NULL;
+	struct dir_rename_entry *entry = check_dir_renamed(path, dir_renames);
+	struct dir_rename_entry *oentry = NULL;
+
+	if (!entry)
+		return new_path;
+
+	/*
+	 * This next part is a little weird.  We do not want to do an
+	 * implicit rename into a directory we renamed on our side, because
+	 * that will result in a spurious rename/rename(1to2) conflict.  An
+	 * example:
+	 *   Base commit: dumbdir/afile, otherdir/bfile
+	 *   Side 1:      smrtdir/afile, otherdir/bfile
+	 *   Side 2:      dumbdir/afile, dumbdir/bfile
+	 * Here, while working on Side 1, we could notice that otherdir was
+	 * renamed/merged to dumbdir, and change the diff_filepair for
+	 * otherdir/bfile into a rename into dumbdir/bfile.  However, Side
+	 * 2 will notice the rename from dumbdir to smrtdir, and do the
+	 * transitive rename to move it from dumbdir/bfile to
+	 * smrtdir/bfile.  That gives us bfile in dumbdir vs being in
+	 * smrtdir, a rename/rename(1to2) conflict.  We really just want
+	 * the file to end up in smrtdir.  And the way to achieve that is
+	 * to not let Side1 do the rename to dumbdir, since we know that is
+	 * the source of one of our directory renames.
+	 *
+	 * That's why oentry and dir_rename_exclusions is here.
+	 *
+	 * As it turns out, this also prevents N-way transient rename
+	 * confusion; See testcases 9c and 9d of t6043.
+	 */
+	oentry = dir_rename_find_entry(dir_rename_exclusions, entry->new_dir.buf);
+	if (oentry) {
+		output(o, 1, _("WARNING: Avoiding applying %s -> %s rename "
+			       "to %s, because %s itself was renamed."),
+		       entry->dir, entry->new_dir.buf, path, entry->new_dir.buf);
+	} else {
+		new_path = handle_path_level_conflicts(o, path, entry,
+						       collisions, tree);
+		*clean_merge &= (new_path != NULL);
+	}
+
+	return new_path;
+}
+
 /*
  * Get information of all renames which occurred in 'pairs', making use of
  * any implicit directory renames inferred from the other side of history.
@@ -1767,11 +1905,13 @@ static void compute_collisions(struct hashmap *collisions,
 static struct string_list *get_renames(struct merge_options *o,
 				       struct diff_queue_struct *pairs,
 				       struct hashmap *dir_renames,
+				       struct hashmap *dir_rename_exclusions,
 				       struct tree *tree,
 				       struct tree *o_tree,
 				       struct tree *a_tree,
 				       struct tree *b_tree,
-				       struct string_list *entries)
+				       struct string_list *entries,
+				       int *clean_merge)
 {
 	int i;
 	struct hashmap collisions;
@@ -1786,11 +1926,22 @@ static struct string_list *get_renames(struct merge_options *o,
 		struct string_list_item *item;
 		struct rename *re;
 		struct diff_filepair *pair = pairs->queue[i];
+		char *new_path; /* non-NULL only with directory renames */
 
-		if (pair->status != 'R') {
+		if (pair->status == 'D') {
+			diff_free_filepair(pair);
+			continue;
+		}
+		new_path = check_for_directory_rename(o, pair->two->path, tree,
+						      dir_renames,
+						      dir_rename_exclusions,
+						      &collisions,
+						      clean_merge);
+		if (pair->status != 'R' && !new_path) {
 			diff_free_filepair(pair);
 			continue;
 		}
+
 		re = xmalloc(sizeof(*re));
 		re->processed = 0;
 		re->pair = pair;
@@ -2108,7 +2259,7 @@ static int handle_renames(struct merge_options *o,
 {
 	struct diff_queue_struct *head_pairs, *merge_pairs;
 	struct hashmap *dir_re_head, *dir_re_merge;
-	int clean;
+	int clean = 1;
 
 	ri->head_renames = NULL;
 	ri->merge_renames = NULL;
@@ -2127,13 +2278,20 @@ static int handle_renames(struct merge_options *o,
 					 dir_re_merge, merge);
 
 	ri->head_renames  = get_renames(o, head_pairs,
-					dir_re_merge, head,
-					common, head, merge, entries);
+					dir_re_merge, dir_re_head, head,
+					common, head, merge, entries,
+					&clean);
+	if (clean < 0)
+		goto cleanup;
 	ri->merge_renames = get_renames(o, merge_pairs,
-					dir_re_head, merge,
-					 common, head, merge, entries);
-	clean = process_renames(o, ri->head_renames, ri->merge_renames);
+					dir_re_head, dir_re_merge, merge,
+					common, head, merge, entries,
+					&clean);
+	if (clean < 0)
+		goto cleanup;
+	clean &= process_renames(o, ri->head_renames, ri->merge_renames);
 
+cleanup:
 	/*
 	 * Some cleanup is deferred until cleanup_renames() because the
 	 * data structures are still needed and referenced in
diff --git a/strbuf.c b/strbuf.c
index 323c49ceb..6ae384f9c 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "refs.h"
+#include "string-list.h"
 #include "utf8.h"
 
 int starts_with(const char *str, const char *prefix)
@@ -141,6 +142,21 @@ struct strbuf **strbuf_split_buf(const char *str, size_t slen,
 	return ret;
 }
 
+void strbuf_add_separated_string_list(struct strbuf *str,
+				      const char *sep,
+				      struct string_list *slist)
+{
+	struct string_list_item *item;
+	int sep_needed = 0;
+
+	for_each_string_list_item(item, slist) {
+		if (sep_needed)
+			strbuf_addstr(str, sep);
+		strbuf_addstr(str, item->string);
+		sep_needed = 1;
+	}
+}
+
 void strbuf_list_free(struct strbuf **sbs)
 {
 	struct strbuf **s = sbs;
diff --git a/strbuf.h b/strbuf.h
index 0a74acb23..fd6d787a7 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -1,6 +1,8 @@
 #ifndef STRBUF_H
 #define STRBUF_H
 
+struct string_list;
+
 /**
  * strbuf's are meant to be used with all the usual C string and memory
  * APIs. Given that the length of the buffer is known, it's often better to
@@ -537,6 +539,20 @@ static inline struct strbuf **strbuf_split(const struct strbuf *sb,
 	return strbuf_split_max(sb, terminator, 0);
 }
 
+/*
+ * Adds all strings of a string list to the strbuf, separated by the given
+ * separator.  For example, if sep is
+ *   ', '
+ * and slist contains
+ *   ['element1', 'element2', ..., 'elementN'],
+ * then write:
+ *   'element1, element2, ..., elementN'
+ * to str.  If only one element, just write "element1" to str.
+ */
+extern void strbuf_add_separated_string_list(struct strbuf *str,
+					     const char *sep,
+					     struct string_list *slist);
+
 /**
  * Free a NULL-terminated list of strbufs (for example, the return
  * values of the strbuf_split*() functions).
diff --git a/t/t6043-merge-rename-directories.sh b/t/t6043-merge-rename-directories.sh
index bdffdb70b..c269aa793 100755
--- a/t/t6043-merge-rename-directories.sh
+++ b/t/t6043-merge-rename-directories.sh
@@ -477,7 +477,7 @@ test_expect_success '2a-setup: Directory split into two on one side, with equal
 	)
 '
 
-test_expect_failure '2a-check: Directory split into two on one side, with equal numbers of paths' '
+test_expect_success '2a-check: Directory split into two on one side, with equal numbers of paths' '
 	(
 		cd 2a &&
 
-- 
2.15.0.408.g8e199d483

