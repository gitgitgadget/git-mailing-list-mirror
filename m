From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 1/6] merge-recur: Convert variable names to lower_case
Date: Thu, 27 Jul 2006 19:12:29 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607271912020.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Thu Jul 27 19:12:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G69PZ-0002DH-6P
	for gcvg-git@gmane.org; Thu, 27 Jul 2006 19:12:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750920AbWG0RMd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Jul 2006 13:12:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750939AbWG0RMd
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Jul 2006 13:12:33 -0400
Received: from mail.gmx.net ([213.165.64.21]:35051 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750920AbWG0RMc (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Jul 2006 13:12:32 -0400
Received: (qmail invoked by alias); 27 Jul 2006 17:12:30 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp018) with SMTP; 27 Jul 2006 19:12:30 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24309>


Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 merge-recursive.c |  380 ++++++++++++++++++++++++++---------------------------
 1 files changed, 189 insertions(+), 191 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 85bb47a..b0035cc 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -122,8 +122,8 @@ struct stage_data
 	unsigned processed:1;
 };
 
-static struct path_list currentFileSet = {NULL, 0, 0, 1};
-static struct path_list currentDirectorySet = {NULL, 0, 0, 1};
+static struct path_list current_file_set = {NULL, 0, 0, 1};
+static struct path_list current_directory_set = {NULL, 0, 0, 1};
 
 static int output_indent = 0;
 
@@ -335,9 +335,9 @@ static int save_files_dirs(const unsigne
 	newpath[baselen + len] = '\0';
 
 	if (S_ISDIR(mode))
-		path_list_insert(newpath, &currentDirectorySet);
+		path_list_insert(newpath, &current_directory_set);
 	else
-		path_list_insert(newpath, &currentFileSet);
+		path_list_insert(newpath, &current_file_set);
 	free(newpath);
 
 	return READ_TREE_RECURSIVE;
@@ -351,7 +351,7 @@ static int get_files_dirs(struct tree *t
 		debug("  get_files_dirs done (0)\n");
 		return 0;
 	}
-	n = currentFileSet.nr + currentDirectorySet.nr;
+	n = current_file_set.nr + current_directory_set.nr;
 	debug("  get_files_dirs done (%d)\n", n);
 	return n;
 }
@@ -378,7 +378,7 @@ static struct stage_data *insert_stage_d
 }
 
 /*
- * Create a dictionary mapping file names to CacheEntry objects. The
+ * Create a dictionary mapping file names to stage_data objects. The
  * dictionary contains one entry for every path with a non-zero stage entry.
  */
 static struct path_list *get_unmerged(void)
@@ -420,15 +420,15 @@ struct rename
 };
 
 /*
- * Get information of all renames which occured between 'oTree' and
- * 'tree'. We need the three trees in the merge ('oTree', 'aTree' and
- * 'bTree') to be able to associate the correct cache entries with
- * the rename information. 'tree' is always equal to either aTree or bTree.
+ * Get information of all renames which occured between 'o_tree' and
+ * 'tree'. We need the three trees in the merge ('o_tree', 'a_tree' and
+ * 'b_tree') to be able to associate the correct cache entries with
+ * the rename information. 'tree' is always equal to either a_tree or b_tree.
  */
 static struct path_list *get_renames(struct tree *tree,
-					struct tree *oTree,
-					struct tree *aTree,
-					struct tree *bTree,
+					struct tree *o_tree,
+					struct tree *a_tree,
+					struct tree *b_tree,
 					struct path_list *entries)
 {
 	int i;
@@ -437,7 +437,7 @@ static struct path_list *get_renames(str
 #ifdef DEBUG
 	time_t t = time(0);
 
-	debug("getRenames ...\n");
+	debug("get_renames ...\n");
 #endif
 
 	renames = xcalloc(1, sizeof(struct path_list));
@@ -447,7 +447,7 @@ #endif
 	opts.output_format = DIFF_FORMAT_NO_OUTPUT;
 	if (diff_setup_done(&opts) < 0)
 		die("diff setup failed");
-	diff_tree_sha1(oTree->object.sha1, tree->object.sha1, "", &opts);
+	diff_tree_sha1(o_tree->object.sha1, tree->object.sha1, "", &opts);
 	diffcore_std(&opts);
 	for (i = 0; i < diff_queued_diff.nr; ++i) {
 		struct path_list_item *item;
@@ -463,14 +463,14 @@ #endif
 		item = path_list_lookup(re->pair->one->path, entries);
 		if (!item)
 			re->src_entry = insert_stage_data(re->pair->one->path,
-					oTree, aTree, bTree, entries);
+					o_tree, a_tree, b_tree, entries);
 		else
 			re->src_entry = item->util;
 
 		item = path_list_lookup(re->pair->two->path, entries);
 		if (!item)
 			re->dst_entry = insert_stage_data(re->pair->two->path,
-					oTree, aTree, bTree, entries);
+					o_tree, a_tree, b_tree, entries);
 		else
 			re->dst_entry = item->util;
 		item = path_list_insert(pair->one->path, renames);
@@ -480,7 +480,7 @@ #endif
 	diff_queued_diff.nr = 0;
 	diff_flush(&opts);
 #ifdef DEBUG
-	debug("  getRenames done in %ld\n", time(0)-t);
+	debug("  get_renames done in %ld\n", time(0)-t);
 #endif
 	return renames;
 }
@@ -526,25 +526,23 @@ static int remove_path(const char *name)
 	return ret;
 }
 
-/* General TODO: unC99ify the code: no declaration after code */
-/* General TODO: no javaIfiCation: rename updateCache to update_cache */
 /*
  * TODO: once we no longer call external programs, we'd probably be better off
  * not setting / getting the environment variable GIT_INDEX_FILE all the time.
  */
 int remove_file(int clean, const char *path)
 {
-	int updateCache = index_only || clean;
-	int updateWd = !index_only;
+	int update_cache = index_only || clean;
+	int update_working_directory = !index_only;
 
-	if (updateCache) {
+	if (update_cache) {
 		if (!cache_dirty)
 			read_cache_from(getenv("GIT_INDEX_FILE"));
 		cache_dirty++;
 		if (remove_file_from_cache(path))
 			return -1;
 	}
-	if (updateWd)
+	if (update_working_directory)
 	{
 		unlink(path);
 		if (errno != ENOENT || errno != EISDIR)
@@ -566,12 +564,12 @@ static char *unique_path(const char *pat
 	for (; *p; ++p)
 		if ('/' == *p)
 			*p = '_';
-	while (path_list_has_path(&currentFileSet, newpath) ||
-	       path_list_has_path(&currentDirectorySet, newpath) ||
+	while (path_list_has_path(&current_file_set, newpath) ||
+	       path_list_has_path(&current_directory_set, newpath) ||
 	       lstat(newpath, &st) == 0)
 		sprintf(p, "_%d", suffix++);
 
-	path_list_insert(newpath, &currentFileSet);
+	path_list_insert(newpath, &current_file_set);
 	return newpath;
 }
 
@@ -784,22 +782,22 @@ static void conflict_rename_rename(struc
 	int delp = 0;
 	const char *ren1_dst = ren1->pair->two->path;
 	const char *ren2_dst = ren2->pair->two->path;
-	const char *dstName1 = ren1_dst;
-	const char *dstName2 = ren2_dst;
-	if (path_list_has_path(&currentDirectorySet, ren1_dst)) {
-		dstName1 = del[delp++] = unique_path(ren1_dst, branch1);
+	const char *dst_name1 = ren1_dst;
+	const char *dst_name2 = ren2_dst;
+	if (path_list_has_path(&current_directory_set, ren1_dst)) {
+		dst_name1 = del[delp++] = unique_path(ren1_dst, branch1);
 		output("%s is a directory in %s adding as %s instead",
-		       ren1_dst, branch2, dstName1);
+		       ren1_dst, branch2, dst_name1);
 		remove_file(0, ren1_dst);
 	}
-	if (path_list_has_path(&currentDirectorySet, ren2_dst)) {
-		dstName2 = del[delp++] = unique_path(ren2_dst, branch2);
+	if (path_list_has_path(&current_directory_set, ren2_dst)) {
+		dst_name2 = del[delp++] = unique_path(ren2_dst, branch2);
 		output("%s is a directory in %s adding as %s instead",
-		       ren2_dst, branch1, dstName2);
+		       ren2_dst, branch1, dst_name2);
 		remove_file(0, ren2_dst);
 	}
-	update_stages(dstName1, NULL, ren1->pair->two, NULL, 1);
-	update_stages(dstName2, NULL, NULL, ren2->pair->two, 1);
+	update_stages(dst_name1, NULL, ren1->pair->two, NULL, 1);
+	update_stages(dst_name2, NULL, NULL, ren2->pair->two, 1);
 	while (delp--)
 		free(del[delp]);
 }
@@ -807,11 +805,11 @@ static void conflict_rename_rename(struc
 static void conflict_rename_dir(struct rename *ren1,
 				const char *branch1)
 {
-	char *newPath = unique_path(ren1->pair->two->path, branch1);
-	output("Renaming %s to %s instead", ren1->pair->one->path, newPath);
+	char *new_path = unique_path(ren1->pair->two->path, branch1);
+	output("Renaming %s to %s instead", ren1->pair->one->path, new_path);
 	remove_file(0, ren1->pair->two->path);
-	update_file(0, ren1->pair->two->sha1, ren1->pair->two->mode, newPath);
-	free(newPath);
+	update_file(0, ren1->pair->two->sha1, ren1->pair->two->mode, new_path);
+	free(new_path);
 }
 
 static void conflict_rename_rename_2(struct rename *ren1,
@@ -819,74 +817,74 @@ static void conflict_rename_rename_2(str
 				     struct rename *ren2,
 				     const char *branch2)
 {
-	char *newPath1 = unique_path(ren1->pair->two->path, branch1);
-	char *newPath2 = unique_path(ren2->pair->two->path, branch2);
+	char *new_path1 = unique_path(ren1->pair->two->path, branch1);
+	char *new_path2 = unique_path(ren2->pair->two->path, branch2);
 	output("Renaming %s to %s and %s to %s instead",
-	       ren1->pair->one->path, newPath1,
-	       ren2->pair->one->path, newPath2);
+	       ren1->pair->one->path, new_path1,
+	       ren2->pair->one->path, new_path2);
 	remove_file(0, ren1->pair->two->path);
-	update_file(0, ren1->pair->two->sha1, ren1->pair->two->mode, newPath1);
-	update_file(0, ren2->pair->two->sha1, ren2->pair->two->mode, newPath2);
-	free(newPath2);
-	free(newPath1);
+	update_file(0, ren1->pair->two->sha1, ren1->pair->two->mode, new_path1);
+	update_file(0, ren2->pair->two->sha1, ren2->pair->two->mode, new_path2);
+	free(new_path2);
+	free(new_path1);
 }
 
 /* General TODO: get rid of all the debug messages */
-static int process_renames(struct path_list *renamesA,
-			   struct path_list *renamesB,
-			   const char *branchNameA,
-			   const char *branchNameB)
+static int process_renames(struct path_list *a_renames,
+			   struct path_list *b_renames,
+			   const char *a_branch,
+			   const char *b_branch)
 {
-	int cleanMerge = 1, i, j;
-	struct path_list byDstA = {NULL, 0, 0, 0}, byDstB = {NULL, 0, 0, 0};
+	int clean_merge = 1, i, j;
+	struct path_list a_by_dst = {NULL, 0, 0, 0}, b_by_dst = {NULL, 0, 0, 0};
 	const struct rename *sre;
 
-	for (i = 0; i < renamesA->nr; i++) {
-		sre = renamesA->items[i].util;
-		path_list_insert(sre->pair->two->path, &byDstA)->util
+	for (i = 0; i < a_renames->nr; i++) {
+		sre = a_renames->items[i].util;
+		path_list_insert(sre->pair->two->path, &a_by_dst)->util
 			= sre->dst_entry;
 	}
-	for (i = 0; i < renamesB->nr; i++) {
-		sre = renamesB->items[i].util;
-		path_list_insert(sre->pair->two->path, &byDstB)->util
+	for (i = 0; i < b_renames->nr; i++) {
+		sre = b_renames->items[i].util;
+		path_list_insert(sre->pair->two->path, &b_by_dst)->util
 			= sre->dst_entry;
 	}
 
-	for (i = 0, j = 0; i < renamesA->nr || j < renamesB->nr;) {
+	for (i = 0, j = 0; i < a_renames->nr || j < b_renames->nr;) {
 		int compare;
 		char *src;
 		struct path_list *renames1, *renames2, *renames2Dst;
 		struct rename *ren1 = NULL, *ren2 = NULL;
-		const char *branchName1, *branchName2;
+		const char *branch1, *branch2;
 		const char *ren1_src, *ren1_dst;
 
-		if (i >= renamesA->nr) {
+		if (i >= a_renames->nr) {
 			compare = 1;
-			ren2 = renamesB->items[j++].util;
-		} else if (j >= renamesB->nr) {
+			ren2 = b_renames->items[j++].util;
+		} else if (j >= b_renames->nr) {
 			compare = -1;
-			ren1 = renamesA->items[i++].util;
+			ren1 = a_renames->items[i++].util;
 		} else {
-			compare = strcmp(renamesA->items[i].path,
-					renamesB->items[j].path);
-			ren1 = renamesA->items[i++].util;
-			ren2 = renamesB->items[j++].util;
+			compare = strcmp(a_renames->items[i].path,
+					b_renames->items[j].path);
+			ren1 = a_renames->items[i++].util;
+			ren2 = b_renames->items[j++].util;
 		}
 
 		/* TODO: refactor, so that 1/2 are not needed */
 		if (ren1) {
-			renames1 = renamesA;
-			renames2 = renamesB;
-			renames2Dst = &byDstB;
-			branchName1 = branchNameA;
-			branchName2 = branchNameB;
+			renames1 = a_renames;
+			renames2 = b_renames;
+			renames2Dst = &b_by_dst;
+			branch1 = a_branch;
+			branch2 = b_branch;
 		} else {
 			struct rename *tmp;
-			renames1 = renamesB;
-			renames2 = renamesA;
-			renames2Dst = &byDstA;
-			branchName1 = branchNameB;
-			branchName2 = branchNameA;
+			renames1 = b_renames;
+			renames2 = a_renames;
+			renames2Dst = &a_by_dst;
+			branch1 = b_branch;
+			branch2 = a_branch;
 			tmp = ren2;
 			ren2 = ren1;
 			ren1 = tmp;
@@ -912,21 +910,21 @@ static int process_renames(struct path_l
 			ren2->dst_entry->processed = 1;
 			ren2->processed = 1;
 			if (strcmp(ren1_dst, ren2_dst) != 0) {
-				cleanMerge = 0;
+				clean_merge = 0;
 				output("CONFLICT (rename/rename): "
 				       "Rename %s->%s in branch %s "
 				       "rename %s->%s in %s",
-				       src, ren1_dst, branchName1,
-				       src, ren2_dst, branchName2);
-				conflict_rename_rename(ren1, branchName1, ren2, branchName2);
+				       src, ren1_dst, branch1,
+				       src, ren2_dst, branch2);
+				conflict_rename_rename(ren1, branch1, ren2, branch2);
 			} else {
-				remove_file(1, ren1_src);
 				struct merge_file_info mfi;
+				remove_file(1, ren1_src);
 				mfi = merge_file(ren1->pair->one,
 						 ren1->pair->two,
 						 ren2->pair->two,
-						 branchName1,
-						 branchName2);
+						 branch1,
+						 branch2);
 				if (mfi.merge || !mfi.clean)
 					output("Renaming %s->%s", src, ren1_dst);
 
@@ -936,7 +934,7 @@ static int process_renames(struct path_l
 				if (!mfi.clean) {
 					output("CONFLICT (content): merge conflict in %s",
 					       ren1_dst);
-					cleanMerge = 0;
+					clean_merge = 0;
 
 					if (!index_only)
 						update_stages(ren1_dst,
@@ -952,7 +950,7 @@ static int process_renames(struct path_l
 			struct path_list_item *item;
 			/* we only use sha1 and mode of these */
 			struct diff_filespec src_other, dst_other;
-			int tryMerge, stage = renamesA == renames1 ? 3: 2;
+			int try_merge, stage = a_renames == renames1 ? 3: 2;
 
 			remove_file(1, ren1_src);
 
@@ -963,52 +961,52 @@ static int process_renames(struct path_l
 					ren1->dst_entry->stages[stage].sha, 20);
 			dst_other.mode = ren1->dst_entry->stages[stage].mode;
 
-			tryMerge = 0;
+			try_merge = 0;
 
-			if (path_list_has_path(&currentDirectorySet, ren1_dst)) {
-				cleanMerge = 0;
+			if (path_list_has_path(&current_directory_set, ren1_dst)) {
+				clean_merge = 0;
 				output("CONFLICT (rename/directory): Rename %s->%s in %s "
 				       " directory %s added in %s",
-				       ren1_src, ren1_dst, branchName1,
-				       ren1_dst, branchName2);
-				conflict_rename_dir(ren1, branchName1);
+				       ren1_src, ren1_dst, branch1,
+				       ren1_dst, branch2);
+				conflict_rename_dir(ren1, branch1);
 			} else if (sha_eq(src_other.sha1, null_sha1)) {
-				cleanMerge = 0;
+				clean_merge = 0;
 				output("CONFLICT (rename/delete): Rename %s->%s in %s "
 				       "and deleted in %s",
-				       ren1_src, ren1_dst, branchName1,
-				       branchName2);
+				       ren1_src, ren1_dst, branch1,
+				       branch2);
 				update_file(0, ren1->pair->two->sha1, ren1->pair->two->mode, ren1_dst);
 			} else if (!sha_eq(dst_other.sha1, null_sha1)) {
-				const char *newPath;
-				cleanMerge = 0;
-				tryMerge = 1;
+				const char *new_path;
+				clean_merge = 0;
+				try_merge = 1;
 				output("CONFLICT (rename/add): Rename %s->%s in %s. "
 				       "%s added in %s",
-				       ren1_src, ren1_dst, branchName1,
-				       ren1_dst, branchName2);
-				newPath = unique_path(ren1_dst, branchName2);
-				output("Adding as %s instead", newPath);
-				update_file(0, dst_other.sha1, dst_other.mode, newPath);
+				       ren1_src, ren1_dst, branch1,
+				       ren1_dst, branch2);
+				new_path = unique_path(ren1_dst, branch2);
+				output("Adding as %s instead", new_path);
+				update_file(0, dst_other.sha1, dst_other.mode, new_path);
 			} else if ((item = path_list_lookup(ren1_dst, renames2Dst))) {
 				ren2 = item->util;
-				cleanMerge = 0;
+				clean_merge = 0;
 				ren2->processed = 1;
 				output("CONFLICT (rename/rename): Rename %s->%s in %s. "
 				       "Rename %s->%s in %s",
-				       ren1_src, ren1_dst, branchName1,
-				       ren2->pair->one->path, ren2->pair->two->path, branchName2);
-				conflict_rename_rename_2(ren1, branchName1, ren2, branchName2);
+				       ren1_src, ren1_dst, branch1,
+				       ren2->pair->one->path, ren2->pair->two->path, branch2);
+				conflict_rename_rename_2(ren1, branch1, ren2, branch2);
 			} else
-				tryMerge = 1;
+				try_merge = 1;
 
-			if (tryMerge) {
+			if (try_merge) {
 				struct diff_filespec *o, *a, *b;
 				struct merge_file_info mfi;
 				src_other.path = (char *)ren1_src;
 
 				o = ren1->pair->one;
-				if (renamesA == renames1) {
+				if (a_renames == renames1) {
 					a = ren1->pair->two;
 					b = &src_other;
 				} else {
@@ -1016,7 +1014,7 @@ static int process_renames(struct path_l
 					a = &src_other;
 				}
 				mfi = merge_file(o, a, b,
-						branchNameA, branchNameB);
+						a_branch, b_branch);
 
 				if (mfi.merge || !mfi.clean)
 					output("Renaming %s => %s", ren1_src, ren1_dst);
@@ -1025,7 +1023,7 @@ static int process_renames(struct path_l
 				if (!mfi.clean) {
 					output("CONFLICT (rename/modify): Merge conflict in %s",
 					       ren1_dst);
-					cleanMerge = 0;
+					clean_merge = 0;
 
 					if (!index_only)
 						update_stages(ren1_dst,
@@ -1035,12 +1033,12 @@ static int process_renames(struct path_l
 			}
 		}
 	}
-	path_list_clear(&byDstA, 0);
-	path_list_clear(&byDstB, 0);
+	path_list_clear(&a_by_dst, 0);
+	path_list_clear(&b_by_dst, 0);
 
 	if (cache_dirty)
 		flush_cache();
-	return cleanMerge;
+	return clean_merge;
 }
 
 static unsigned char *has_sha(const unsigned char *sha)
@@ -1057,116 +1055,116 @@ static int process_entry(const char *pat
 	printf("processing entry, clean cache: %s\n", index_only ? "yes": "no");
 	print_index_entry("\tpath: ", entry);
 	*/
-	int cleanMerge = 1;
-	unsigned char *oSha = has_sha(entry->stages[1].sha);
-	unsigned char *aSha = has_sha(entry->stages[2].sha);
-	unsigned char *bSha = has_sha(entry->stages[3].sha);
-	unsigned oMode = entry->stages[1].mode;
-	unsigned aMode = entry->stages[2].mode;
-	unsigned bMode = entry->stages[3].mode;
-
-	if (oSha && (!aSha || !bSha)) {
+	int clean_merge = 1;
+	unsigned char *o_sha = has_sha(entry->stages[1].sha);
+	unsigned char *a_sha = has_sha(entry->stages[2].sha);
+	unsigned char *b_sha = has_sha(entry->stages[3].sha);
+	unsigned o_mode = entry->stages[1].mode;
+	unsigned a_mode = entry->stages[2].mode;
+	unsigned b_mode = entry->stages[3].mode;
+
+	if (o_sha && (!a_sha || !b_sha)) {
 		/* Case A: Deleted in one */
-		if ((!aSha && !bSha) ||
-		    (sha_eq(aSha, oSha) && !bSha) ||
-		    (!aSha && sha_eq(bSha, oSha))) {
+		if ((!a_sha && !b_sha) ||
+		    (sha_eq(a_sha, o_sha) && !b_sha) ||
+		    (!a_sha && sha_eq(b_sha, o_sha))) {
 			/* Deleted in both or deleted in one and
 			 * unchanged in the other */
-			if (aSha)
+			if (a_sha)
 				output("Removing %s", path);
 			remove_file(1, path);
 		} else {
 			/* Deleted in one and changed in the other */
-			cleanMerge = 0;
-			if (!aSha) {
+			clean_merge = 0;
+			if (!a_sha) {
 				output("CONFLICT (delete/modify): %s deleted in %s "
 				       "and modified in %s. Version %s of %s left in tree.",
 				       path, branch1Name,
 				       branch2Name, branch2Name, path);
-				update_file(0, bSha, bMode, path);
+				update_file(0, b_sha, b_mode, path);
 			} else {
 				output("CONFLICT (delete/modify): %s deleted in %s "
 				       "and modified in %s. Version %s of %s left in tree.",
 				       path, branch2Name,
 				       branch1Name, branch1Name, path);
-				update_file(0, aSha, aMode, path);
+				update_file(0, a_sha, a_mode, path);
 			}
 		}
 
-	} else if ((!oSha && aSha && !bSha) ||
-		   (!oSha && !aSha && bSha)) {
+	} else if ((!o_sha && a_sha && !b_sha) ||
+		   (!o_sha && !a_sha && b_sha)) {
 		/* Case B: Added in one. */
-		const char *addBranch;
-		const char *otherBranch;
+		const char *add_branch;
+		const char *other_branch;
 		unsigned mode;
 		const unsigned char *sha;
 		const char *conf;
 
-		if (aSha) {
-			addBranch = branch1Name;
-			otherBranch = branch2Name;
-			mode = aMode;
-			sha = aSha;
+		if (a_sha) {
+			add_branch = branch1Name;
+			other_branch = branch2Name;
+			mode = a_mode;
+			sha = a_sha;
 			conf = "file/directory";
 		} else {
-			addBranch = branch2Name;
-			otherBranch = branch1Name;
-			mode = bMode;
-			sha = bSha;
+			add_branch = branch2Name;
+			other_branch = branch1Name;
+			mode = b_mode;
+			sha = b_sha;
 			conf = "directory/file";
 		}
-		if (path_list_has_path(&currentDirectorySet, path)) {
-			const char *newPath = unique_path(path, addBranch);
-			cleanMerge = 0;
+		if (path_list_has_path(&current_directory_set, path)) {
+			const char *new_path = unique_path(path, add_branch);
+			clean_merge = 0;
 			output("CONFLICT (%s): There is a directory with name %s in %s. "
 			       "Adding %s as %s",
-			       conf, path, otherBranch, path, newPath);
+			       conf, path, other_branch, path, new_path);
 			remove_file(0, path);
-			update_file(0, sha, mode, newPath);
+			update_file(0, sha, mode, new_path);
 		} else {
 			output("Adding %s", path);
 			update_file(1, sha, mode, path);
 		}
-	} else if (!oSha && aSha && bSha) {
+	} else if (!o_sha && a_sha && b_sha) {
 		/* Case C: Added in both (check for same permissions). */
-		if (sha_eq(aSha, bSha)) {
-			if (aMode != bMode) {
-				cleanMerge = 0;
+		if (sha_eq(a_sha, b_sha)) {
+			if (a_mode != b_mode) {
+				clean_merge = 0;
 				output("CONFLICT: File %s added identically in both branches, "
 				       "but permissions conflict %06o->%06o",
-				       path, aMode, bMode);
-				output("CONFLICT: adding with permission: %06o", aMode);
-				update_file(0, aSha, aMode, path);
+				       path, a_mode, b_mode);
+				output("CONFLICT: adding with permission: %06o", a_mode);
+				update_file(0, a_sha, a_mode, path);
 			} else {
 				/* This case is handled by git-read-tree */
 				assert(0 && "This case must be handled by git-read-tree");
 			}
 		} else {
-			const char *newPath1, *newPath2;
-			cleanMerge = 0;
-			newPath1 = unique_path(path, branch1Name);
-			newPath2 = unique_path(path, branch2Name);
+			const char *new_path1, *new_path2;
+			clean_merge = 0;
+			new_path1 = unique_path(path, branch1Name);
+			new_path2 = unique_path(path, branch2Name);
 			output("CONFLICT (add/add): File %s added non-identically "
 			       "in both branches. Adding as %s and %s instead.",
-			       path, newPath1, newPath2);
+			       path, new_path1, new_path2);
 			remove_file(0, path);
-			update_file(0, aSha, aMode, newPath1);
-			update_file(0, bSha, bMode, newPath2);
+			update_file(0, a_sha, a_mode, new_path1);
+			update_file(0, b_sha, b_mode, new_path2);
 		}
 
-	} else if (oSha && aSha && bSha) {
+	} else if (o_sha && a_sha && b_sha) {
 		/* case D: Modified in both, but differently. */
 		struct merge_file_info mfi;
 		struct diff_filespec o, a, b;
 
 		output("Auto-merging %s", path);
 		o.path = a.path = b.path = (char *)path;
-		memcpy(o.sha1, oSha, 20);
-		o.mode = oMode;
-		memcpy(a.sha1, aSha, 20);
-		a.mode = aMode;
-		memcpy(b.sha1, bSha, 20);
-		b.mode = bMode;
+		memcpy(o.sha1, o_sha, 20);
+		o.mode = o_mode;
+		memcpy(a.sha1, a_sha, 20);
+		a.mode = a_mode;
+		memcpy(b.sha1, b_sha, 20);
+		b.mode = b_mode;
 		
 		mfi = merge_file(&o, &a, &b,
 				 branch1Name, branch2Name);
@@ -1174,14 +1172,14 @@ static int process_entry(const char *pat
 		if (mfi.clean)
 			update_file(1, mfi.sha, mfi.mode, path);
 		else {
-			cleanMerge = 0;
+			clean_merge = 0;
 			output("CONFLICT (content): Merge conflict in %s", path);
 
 			if (index_only)
 				update_file(0, mfi.sha, mfi.mode, path);
 			else
 				update_file_flags(mfi.sha, mfi.mode, path,
-					      0 /* updateCache */, 1 /* updateWd */);
+					      0 /* update_cache */, 1 /* update_working_directory */);
 		}
 	} else
 		die("Fatal merge failure, shouldn't happen.");
@@ -1189,7 +1187,7 @@ static int process_entry(const char *pat
 	if (cache_dirty)
 		flush_cache();
 
-	return cleanMerge;
+	return clean_merge;
 }
 
 static int merge_trees(struct tree *head,
@@ -1218,8 +1216,8 @@ static int merge_trees(struct tree *head
 	if (!*result) {
 		struct path_list *entries, *re_head, *re_merge;
 		int i;
-		path_list_clear(&currentFileSet, 1);
-		path_list_clear(&currentDirectorySet, 1);
+		path_list_clear(&current_file_set, 1);
+		path_list_clear(&current_directory_set, 1);
 		get_files_dirs(head);
 		get_files_dirs(merge);
 
@@ -1265,12 +1263,12 @@ int merge(struct commit *h1,
 			  struct commit *h2,
 			  const char *branch1Name,
 			  const char *branch2Name,
-			  int callDepth /* =0 */,
+			  int call_depth /* =0 */,
 			  struct commit *ancestor /* =None */,
 			  struct commit **result)
 {
 	struct commit_list *ca = NULL, *iter;
-	struct commit *mergedCA;
+	struct commit *merged_common_ancestors;
 	struct tree *mrtree;
 	int clean;
 
@@ -1287,10 +1285,10 @@ int merge(struct commit *h1,
 	for (iter = ca; iter; iter = iter->next)
 		output_commit_title(iter->item);
 
-	mergedCA = pop_commit(&ca);
+	merged_common_ancestors = pop_commit(&ca);
 
 	for (iter = ca; iter; iter = iter->next) {
-		output_indent = callDepth + 1;
+		output_indent = call_depth + 1;
 		/*
 		 * When the merge fails, the result contains files
 		 * with conflict markers. The cleanness flag is
@@ -1298,19 +1296,19 @@ int merge(struct commit *h1,
 		 * merge_trees has always overwritten it: the commited
 		 * "conflicts" were already resolved. 
 		 */
-		merge(mergedCA, iter->item,
+		merge(merged_common_ancestors, iter->item,
 		      "Temporary merge branch 1",
 		      "Temporary merge branch 2",
-		      callDepth + 1,
+		      call_depth + 1,
 		      NULL,
-		      &mergedCA);
-		output_indent = callDepth;
+		      &merged_common_ancestors);
+		output_indent = call_depth;
 
-		if (!mergedCA)
+		if (!merged_common_ancestors)
 			die("merge returned no commit");
 	}
 
-	if (callDepth == 0) {
+	if (call_depth == 0) {
 		setup_index(0 /* $GIT_DIR/index */);
 		index_only = 0;
 	} else {
@@ -1319,7 +1317,7 @@ int merge(struct commit *h1,
 		index_only = 1;
 	}
 
-	clean = merge_trees(h1->tree, h2->tree, mergedCA->tree,
+	clean = merge_trees(h1->tree, h2->tree, merged_common_ancestors->tree,
 			    branch1Name, branch2Name, &mrtree);
 
 	if (!ancestor && (clean || index_only)) {
-- 
1.4.2.rc2.g6a4e
