Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3EC331F428
	for <e@80x24.org>; Fri,  5 Jan 2018 20:29:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752813AbeAEU25 (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 15:28:57 -0500
Received: from mail-io0-f195.google.com ([209.85.223.195]:43113 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752804AbeAEU2x (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jan 2018 15:28:53 -0500
Received: by mail-io0-f195.google.com with SMTP id w188so6962540iod.10
        for <git@vger.kernel.org>; Fri, 05 Jan 2018 12:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2Ydxj8/0oyjb5mmLu7GzbjC5f27JIyJ5aeh2ecfir8E=;
        b=rp5sk0QCK2IKVLFphYflxTynUdGJyyYRk/cbLgr6CqJHn3uUC2fnY4XEJ7lK5SsDzu
         7ZaFpVUDS2pCErLfgBFHhemAo37S6wpQHPOKS8xdc/27WpMMPh69CTqnIvmPiWNCM3Ih
         wON3CleCKslEcWLwQ0uTQgxY4SFA5oqcwWirbZ/wuJceKWqlg4yOz3Bb0P8lzGcE8/J1
         OtK+EIV3DOr6YJSg1wVPLemOqLCs806cCK06Fuqdh7xC3HwDrkUroPu5ik8I8yKEdh59
         gyS3rZSJFAda2IC3q2bLuEKDq1dufac5BdGzDq4HcZS00o+qpDIHPcdelp825DMrHHiV
         OJTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2Ydxj8/0oyjb5mmLu7GzbjC5f27JIyJ5aeh2ecfir8E=;
        b=VuXbo++bDVMWyowWgT6eewuiKhR3ug9VtbIqLf3mc5aPJSqsfuGd17J6/MYe6NG6pH
         T98XOfKWM+X0m5mJ9RHDzaLhCdDNtv7T2HxgzIEOkxIrytuDSOG7A89Jc3eOHRE6QOVV
         FYE4wRKzoNlxaM1k1qnWHV7jCx7tgDm9pMiTLT/LG9W5VhWFjmc14i/7jOUvz7DLS7EX
         Iv1K5W9E1FDn3S7rj2CfnvJxSW1bCtgJAyCmgU+QpeEf2PuvE4dmfnB41r/MvygDixmt
         7LU2l70maOm30MrPn70daZAc+kn9iP1PYdEg20aUsmBEH0tocAuxUMsb7G7nx3PTlx1d
         XS/Q==
X-Gm-Message-State: AKGB3mKDmTqD4QRsCG2IRCkXd+1e8awEop0a8sk/S9PYBlXHwVUl1rIy
        cx2eyRb1NjEM33hHDtlK5kaG9Fga
X-Google-Smtp-Source: ACJfBovg1IOpragkGl3p3RrxRSdkon/5eJgjesaugtmgUzzLzXmxgzXHr0mfrylwwLkZCiuB383sYw==
X-Received: by 10.107.170.198 with SMTP id g67mr3960996ioj.183.1515184132149;
        Fri, 05 Jan 2018 12:28:52 -0800 (PST)
Received: from localhost.localdomain (c-73-20-122-173.hsd1.ut.comcast.net. [73.20.122.173])
        by smtp.gmail.com with ESMTPSA id 6sm3739659iow.55.2018.01.05.12.28.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Jan 2018 12:28:51 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, szeder.dev@gmail.com, j6t@kdbg.org,
        jrnieder@gmail.com, peff@peff.net, git@matthieu-moy.fr,
        Elijah Newren <newren@gmail.com>
Subject: [PATCHv6 25/31] merge-recursive: apply necessary modifications for directory renames
Date:   Fri,  5 Jan 2018 12:27:05 -0800
Message-Id: <20180105202711.24311-26-newren@gmail.com>
X-Mailer: git-send-email 2.15.0.409.g72e1e5805
In-Reply-To: <20180105202711.24311-1-newren@gmail.com>
References: <20180105202711.24311-1-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This commit hooks together all the directory rename logic by making the
necessary changes to the rename struct, it's dst_entry, and the
diff_filepair under consideration.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c                   | 187 +++++++++++++++++++++++++++++++++++-
 t/t6043-merge-rename-directories.sh |  50 +++++-----
 2 files changed, 211 insertions(+), 26 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 01934bc1e..cdf8588c7 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -177,6 +177,7 @@ static int oid_eq(const struct object_id *a, const struct object_id *b)
 
 enum rename_type {
 	RENAME_NORMAL = 0,
+	RENAME_DIR,
 	RENAME_DELETE,
 	RENAME_ONE_FILE_TO_ONE,
 	RENAME_ONE_FILE_TO_TWO,
@@ -607,6 +608,7 @@ struct rename {
 	 */
 	struct stage_data *src_entry;
 	struct stage_data *dst_entry;
+	unsigned add_turned_into_rename:1;
 	unsigned processed:1;
 };
 
@@ -641,6 +643,27 @@ static int update_stages(struct merge_options *opt, const char *path,
 	return 0;
 }
 
+static int update_stages_for_stage_data(struct merge_options *opt,
+					const char *path,
+					const struct stage_data *stage_data)
+{
+	struct diff_filespec o, a, b;
+
+	o.mode = stage_data->stages[1].mode;
+	oidcpy(&o.oid, &stage_data->stages[1].oid);
+
+	a.mode = stage_data->stages[2].mode;
+	oidcpy(&a.oid, &stage_data->stages[2].oid);
+
+	b.mode = stage_data->stages[3].mode;
+	oidcpy(&b.oid, &stage_data->stages[3].oid);
+
+	return update_stages(opt, path,
+			     is_null_sha1(o.oid.hash) ? NULL : &o,
+			     is_null_sha1(a.oid.hash) ? NULL : &a,
+			     is_null_sha1(b.oid.hash) ? NULL : &b);
+}
+
 static void update_entry(struct stage_data *entry,
 			 struct diff_filespec *o,
 			 struct diff_filespec *a,
@@ -1108,6 +1131,18 @@ static int merge_file_one(struct merge_options *o,
 	return merge_file_1(o, &one, &a, &b, branch1, branch2, mfi);
 }
 
+static int conflict_rename_dir(struct merge_options *o,
+			       struct diff_filepair *pair,
+			       const char *rename_branch,
+			       const char *other_branch)
+{
+	const struct diff_filespec *dest = pair->two;
+
+	if (update_file(o, 1, &dest->oid, dest->mode, dest->path))
+		return -1;
+	return 0;
+}
+
 static int handle_change_delete(struct merge_options *o,
 				 const char *path, const char *old_path,
 				 const struct object_id *o_oid, int o_mode,
@@ -1377,6 +1412,24 @@ static int conflict_rename_rename_2to1(struct merge_options *o,
 		if (!ret)
 			ret = update_file(o, 0, &mfi_c2.oid, mfi_c2.mode,
 					  new_path2);
+		/*
+		 * unpack_trees() actually populates the index for us for
+		 * "normal" rename/rename(2to1) situtations so that the
+		 * correct entries are at the higher stages, which would
+		 * make the call below to update_stages_for_stage_data
+		 * unnecessary.  However, if either of the renames came
+		 * from a directory rename, then unpack_trees() will not
+		 * have gotten the right data loaded into the index, so we
+		 * need to do so now.  (While it'd be tempting to move this
+		 * call to update_stages_for_stage_data() to
+		 * apply_directory_rename_modifications(), that would break
+		 * our intermediate calls to would_lose_untracked() since
+		 * those rely on the current in-memory index.  See also the
+		 * big "NOTE" in update_stages()).
+		 */
+		if (update_stages_for_stage_data(o, path, ci->dst_entry1))
+			ret = -1;
+
 		free(new_path2);
 		free(new_path1);
 	}
@@ -1910,6 +1963,111 @@ static char *check_for_directory_rename(struct merge_options *o,
 	return new_path;
 }
 
+static void apply_directory_rename_modifications(struct merge_options *o,
+						 struct diff_filepair *pair,
+						 char *new_path,
+						 struct rename *re,
+						 struct tree *tree,
+						 struct tree *o_tree,
+						 struct tree *a_tree,
+						 struct tree *b_tree,
+						 struct string_list *entries,
+						 int *clean)
+{
+	struct string_list_item *item;
+	int stage = (tree == a_tree ? 2 : 3);
+
+	/*
+	 * In all cases where we can do directory rename detection,
+	 * unpack_trees() will have read pair->two->path into the
+	 * index and the working copy.  We need to remove it so that
+	 * we can instead place it at new_path.  It is guaranteed to
+	 * not be untracked (unpack_trees() would have errored out
+	 * saying the file would have been overwritten), but it might
+	 * be dirty, though.
+	 */
+	remove_file(o, 1, pair->two->path, 0 /* no_wd */);
+
+	/* Find or create a new re->dst_entry */
+	item = string_list_lookup(entries, new_path);
+	if (item) {
+		/*
+		 * Since we're renaming on this side of history, and it's
+		 * due to a directory rename on the other side of history
+		 * (which we only allow when the directory in question no
+		 * longer exists on the other side of history), the
+		 * original entry for re->dst_entry is no longer
+		 * necessary...
+		 */
+		re->dst_entry->processed = 1;
+
+		/*
+		 * ...because we'll be using this new one.
+		 */
+		re->dst_entry = item->util;
+	} else {
+		/*
+		 * re->dst_entry is for the before-dir-rename path, and we
+		 * need it to hold information for the after-dir-rename
+		 * path.  Before creating a new entry, we need to mark the
+		 * old one as unnecessary (...unless it is shared by
+		 * src_entry, i.e. this didn't use to be a rename, in which
+		 * case we can just allow the normal processing to happen
+		 * for it).
+		 */
+		if (pair->status == 'R')
+			re->dst_entry->processed = 1;
+
+		re->dst_entry = insert_stage_data(new_path,
+						  o_tree, a_tree, b_tree,
+						  entries);
+		item = string_list_insert(entries, new_path);
+		item->util = re->dst_entry;
+	}
+
+	/*
+	 * Update the stage_data with the information about the path we are
+	 * moving into place.  That slot will be empty and available for us
+	 * to write to because of the collision checks in
+	 * handle_path_level_conflicts().  In other words,
+	 * re->dst_entry->stages[stage].oid will be the null_oid, so it's
+	 * open for us to write to.
+	 *
+	 * It may be tempting to actually update the index at this point as
+	 * well, using update_stages_for_stage_data(), but as per the big
+	 * "NOTE" in update_stages(), doing so will modify the current
+	 * in-memory index which will break calls to would_lose_untracked()
+	 * that we need to make.  Instead, we need to just make sure that
+	 * the various conflict_rename_*() functions update the index
+	 * explicitly rather than relying on unpack_trees() to have done it.
+	 */
+	get_tree_entry(tree->object.oid.hash,
+		       pair->two->path,
+		       re->dst_entry->stages[stage].oid.hash,
+		       &re->dst_entry->stages[stage].mode);
+
+	/* Update pair status */
+	if (pair->status == 'A') {
+		/*
+		 * Recording rename information for this add makes it look
+		 * like a rename/delete conflict.  Make sure we can
+		 * correctly handle this as an add that was moved to a new
+		 * directory instead of reporting a rename/delete conflict.
+		 */
+		re->add_turned_into_rename = 1;
+	}
+	/*
+	 * We don't actually look at pair->status again, but it seems
+	 * pedagogically correct to adjust it.
+	 */
+	pair->status = 'R';
+
+	/*
+	 * Finally, record the new location.
+	 */
+	pair->two->path = new_path;
+}
+
 /*
  * Get information of all renames which occurred in 'pairs', making use of
  * any implicit directory renames inferred from the other side of history.
@@ -1959,6 +2117,7 @@ static struct string_list *get_renames(struct merge_options *o,
 
 		re = xmalloc(sizeof(*re));
 		re->processed = 0;
+		re->add_turned_into_rename = 0;
 		re->pair = pair;
 		item = string_list_lookup(entries, re->pair->one->path);
 		if (!item)
@@ -1975,6 +2134,12 @@ static struct string_list *get_renames(struct merge_options *o,
 			re->dst_entry = item->util;
 		item = string_list_insert(renames, pair->one->path);
 		item->util = re;
+		if (new_path)
+			apply_directory_rename_modifications(o, pair, new_path,
+							     re, tree, o_tree,
+							     a_tree, b_tree,
+							     entries,
+							     clean_merge);
 	}
 
 	hashmap_iter_init(&collisions, &iter);
@@ -2144,7 +2309,19 @@ static int process_renames(struct merge_options *o,
 			dst_other.mode = ren1->dst_entry->stages[other_stage].mode;
 			try_merge = 0;
 
-			if (oid_eq(&src_other.oid, &null_oid)) {
+			if (oid_eq(&src_other.oid, &null_oid) &&
+			    ren1->add_turned_into_rename) {
+				setup_rename_conflict_info(RENAME_DIR,
+							   ren1->pair,
+							   NULL,
+							   branch1,
+							   branch2,
+							   ren1->dst_entry,
+							   NULL,
+							   o,
+							   NULL,
+							   NULL);
+			} else if (oid_eq(&src_other.oid, &null_oid)) {
 				setup_rename_conflict_info(RENAME_DELETE,
 							   ren1->pair,
 							   NULL,
@@ -2561,6 +2738,14 @@ static int process_entry(struct merge_options *o,
 						    o_oid, o_mode, a_oid, a_mode, b_oid, b_mode,
 						    conflict_info);
 			break;
+		case RENAME_DIR:
+			clean_merge = 1;
+			if (conflict_rename_dir(o,
+						conflict_info->pair1,
+						conflict_info->branch1,
+						conflict_info->branch2))
+				clean_merge = -1;
+			break;
 		case RENAME_DELETE:
 			clean_merge = 0;
 			if (conflict_rename_delete(o,
diff --git a/t/t6043-merge-rename-directories.sh b/t/t6043-merge-rename-directories.sh
index b164498ed..aa8f79638 100755
--- a/t/t6043-merge-rename-directories.sh
+++ b/t/t6043-merge-rename-directories.sh
@@ -69,7 +69,7 @@ test_expect_success '1a-setup: Simple directory rename detection' '
 	)
 '
 
-test_expect_failure '1a-check: Simple directory rename detection' '
+test_expect_success '1a-check: Simple directory rename detection' '
 	(
 		cd 1a &&
 
@@ -136,7 +136,7 @@ test_expect_success '1b-setup: Merge a directory with another' '
 	)
 '
 
-test_expect_failure '1b-check: Merge a directory with another' '
+test_expect_success '1b-check: Merge a directory with another' '
 	(
 		cd 1b &&
 
@@ -194,7 +194,7 @@ test_expect_success '1c-setup: Transitive renaming' '
 	)
 '
 
-test_expect_failure '1c-check: Transitive renaming' '
+test_expect_success '1c-check: Transitive renaming' '
 	(
 		cd 1c &&
 
@@ -263,7 +263,7 @@ test_expect_success '1d-setup: Directory renames cause a rename/rename(2to1) con
 	)
 '
 
-test_expect_failure '1d-check: Directory renames cause a rename/rename(2to1) conflict' '
+test_expect_success '1d-check: Directory renames cause a rename/rename(2to1) conflict' '
 	(
 		cd 1d &&
 
@@ -342,7 +342,7 @@ test_expect_success '1e-setup: Renamed directory, with all files being renamed t
 	)
 '
 
-test_expect_failure '1e-check: Renamed directory, with all files being renamed too' '
+test_expect_success '1e-check: Renamed directory, with all files being renamed too' '
 	(
 		cd 1e &&
 
@@ -408,7 +408,7 @@ test_expect_success '1f-setup: Split a directory into two other directories' '
 	)
 '
 
-test_expect_failure '1f-check: Split a directory into two other directories' '
+test_expect_success '1f-check: Split a directory into two other directories' '
 	(
 		cd 1f &&
 
@@ -899,7 +899,7 @@ test_expect_success '5a-setup: Merge directories, other side adds files to origi
 	)
 '
 
-test_expect_failure '5a-check: Merge directories, other side adds files to original and target' '
+test_expect_success '5a-check: Merge directories, other side adds files to original and target' '
 	(
 		cd 5a &&
 
@@ -973,7 +973,7 @@ test_expect_success '5b-setup: Rename/delete in order to get add/add/add conflic
 	)
 '
 
-test_expect_failure '5b-check: Rename/delete in order to get add/add/add conflict' '
+test_expect_success '5b-check: Rename/delete in order to get add/add/add conflict' '
 	(
 		cd 5b &&
 
@@ -1053,7 +1053,7 @@ test_expect_success '5c-setup: Transitive rename would cause rename/rename/renam
 	)
 '
 
-test_expect_failure '5c-check: Transitive rename would cause rename/rename/rename/add/add/add' '
+test_expect_success '5c-check: Transitive rename would cause rename/rename/rename/add/add/add' '
 	(
 		cd 5c &&
 
@@ -1137,7 +1137,7 @@ test_expect_success '5d-setup: Directory/file/file conflict due to directory ren
 	)
 '
 
-test_expect_failure '5d-check: Directory/file/file conflict due to directory rename' '
+test_expect_success '5d-check: Directory/file/file conflict due to directory rename' '
 	(
 		cd 5d &&
 
@@ -1575,7 +1575,7 @@ test_expect_success '7a-setup: rename-dir vs. rename-dir (NOT split evenly) PLUS
 	)
 '
 
-test_expect_failure '7a-check: rename-dir vs. rename-dir (NOT split evenly) PLUS add-other-file' '
+test_expect_success '7a-check: rename-dir vs. rename-dir (NOT split evenly) PLUS add-other-file' '
 	(
 		cd 7a &&
 
@@ -1647,7 +1647,7 @@ test_expect_success '7b-setup: rename/rename(2to1), but only due to transitive r
 	)
 '
 
-test_expect_failure '7b-check: rename/rename(2to1), but only due to transitive rename' '
+test_expect_success '7b-check: rename/rename(2to1), but only due to transitive rename' '
 	(
 		cd 7b &&
 
@@ -1723,7 +1723,7 @@ test_expect_success '7c-setup: rename/rename(1to...2or3); transitive rename may
 	)
 '
 
-test_expect_failure '7c-check: rename/rename(1to...2or3); transitive rename may add complexity' '
+test_expect_success '7c-check: rename/rename(1to...2or3); transitive rename may add complexity' '
 	(
 		cd 7c &&
 
@@ -1787,7 +1787,7 @@ test_expect_success '7d-setup: transitive rename involved in rename/delete; how
 	)
 '
 
-test_expect_failure '7d-check: transitive rename involved in rename/delete; how is it reported?' '
+test_expect_success '7d-check: transitive rename involved in rename/delete; how is it reported?' '
 	(
 		cd 7d &&
 
@@ -1877,7 +1877,7 @@ test_expect_success '7e-setup: transitive rename in rename/delete AND dirs in th
 	)
 '
 
-test_expect_failure '7e-check: transitive rename in rename/delete AND dirs in the way' '
+test_expect_success '7e-check: transitive rename in rename/delete AND dirs in the way' '
 	(
 		cd 7e &&
 
@@ -1968,7 +1968,7 @@ test_expect_success '8a-setup: Dual-directory rename, one into the others way' '
 	)
 '
 
-test_expect_failure '8a-check: Dual-directory rename, one into the others way' '
+test_expect_success '8a-check: Dual-directory rename, one into the others way' '
 	(
 		cd 8a &&
 
@@ -2113,7 +2113,7 @@ test_expect_success '8c-setup: rename+modify/delete' '
 	)
 '
 
-test_expect_failure '8c-check: rename+modify/delete' '
+test_expect_success '8c-check: rename+modify/delete' '
 	(
 		cd 8c &&
 
@@ -2200,7 +2200,7 @@ test_expect_success '8d-setup: rename/delete...or not?' '
 	)
 '
 
-test_expect_failure '8d-check: rename/delete...or not?' '
+test_expect_success '8d-check: rename/delete...or not?' '
 	(
 		cd 8d &&
 
@@ -2275,7 +2275,7 @@ test_expect_success '8e-setup: Both sides rename, one side adds to original dire
 	)
 '
 
-test_expect_failure '8e-check: Both sides rename, one side adds to original directory' '
+test_expect_success '8e-check: Both sides rename, one side adds to original directory' '
 	(
 		cd 8e &&
 
@@ -2362,7 +2362,7 @@ test_expect_success '9a-setup: Inner renamed directory within outer renamed dire
 	)
 '
 
-test_expect_failure '9a-check: Inner renamed directory within outer renamed directory' '
+test_expect_success '9a-check: Inner renamed directory within outer renamed directory' '
 	(
 		cd 9a &&
 
@@ -2432,7 +2432,7 @@ test_expect_success '9b-setup: Transitive rename with content merge' '
 	)
 '
 
-test_expect_failure '9b-check: Transitive rename with content merge' '
+test_expect_success '9b-check: Transitive rename with content merge' '
 	(
 		cd 9b &&
 
@@ -2522,7 +2522,7 @@ test_expect_success '9c-setup: Doubly transitive rename?' '
 	)
 '
 
-test_expect_failure '9c-check: Doubly transitive rename?' '
+test_expect_success '9c-check: Doubly transitive rename?' '
 	(
 		cd 9c &&
 
@@ -2610,7 +2610,7 @@ test_expect_success '9d-setup: N-way transitive rename?' '
 	)
 '
 
-test_expect_failure '9d-check: N-way transitive rename?' '
+test_expect_success '9d-check: N-way transitive rename?' '
 	(
 		cd 9d &&
 
@@ -2688,7 +2688,7 @@ test_expect_success '9e-setup: N-to-1 whammo' '
 	)
 '
 
-test_expect_failure C_LOCALE_OUTPUT '9e-check: N-to-1 whammo' '
+test_expect_success C_LOCALE_OUTPUT '9e-check: N-to-1 whammo' '
 	(
 		cd 9e &&
 
@@ -2766,7 +2766,7 @@ test_expect_success '9f-setup: Renamed directory that only contained immediate s
 	)
 '
 
-test_expect_failure '9f-check: Renamed directory that only contained immediate subdirs' '
+test_expect_success '9f-check: Renamed directory that only contained immediate subdirs' '
 	(
 		cd 9f &&
 
-- 
2.14.2

