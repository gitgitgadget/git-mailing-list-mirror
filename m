Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E68381F404
	for <e@80x24.org>; Thu, 28 Dec 2017 04:14:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753346AbdL1EOb (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Dec 2017 23:14:31 -0500
Received: from mail-io0-f194.google.com ([209.85.223.194]:36584 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753329AbdL1EOY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Dec 2017 23:14:24 -0500
Received: by mail-io0-f194.google.com with SMTP id i143so17043839ioa.3
        for <git@vger.kernel.org>; Wed, 27 Dec 2017 20:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dt8E/zmO9R1WHOLNrdwlwXW0lXKZp42KcJ22D2hj83I=;
        b=gsEQvYeVeBN60xkJ3BTyP7wI/+wQ1OHnOJYSk0ZKitU/DOEXCfz/3+k0Tuv0a2Fn6i
         t4Z9W5kF/XD5Qg/7vUHrPMLlK85KPyN9lDzjd5hnG5DIChRPILeOJgNwa3wSXboRwc3V
         gjqu2SXcPCsUAsfCNRr8GVxceZfaGDQYSoq57sV4KY8SQ5RPZasYXLtK17VRF0oj9kib
         SxyGAHvfodRE10AhbFWHn2QGETsd/T8d/JCOZU4DYY7J4B/jwguRz110aTnM0Hd3nFYG
         D90jPYgB5QdNC8GCWmC2i0zRbWFobmu1rHw4dEI91YBnC+ZcVy6c4kTwTZFcMbu6dx6I
         VEhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dt8E/zmO9R1WHOLNrdwlwXW0lXKZp42KcJ22D2hj83I=;
        b=VN6h9cFe2p44e0z+ddqCVrr5o+NfPbjOoR3Ql9RB7zl5T05yFxF6jQV+/JKLqd2l4f
         QMPZ+uOKJC32oaCdQ+4r/rwBLzkO4pafZcS29TBAdkKCnkf2lstqEMbKKsm66K2Uv5xK
         MZrMYiamjb1f4qwQqeJLr6GMGdn/JH7pQvoS47Tbv2wchnp7DDnjrqbxh88zWRMDlwPb
         PCaFGlN5eEHiyCSYl3jOlusARXDwb7BRI7HJqsiLvw6OcNY8F1gCIhWi+46WgXI3ieVV
         CfHgWuiS29n5m7wdXgPasQCQiEH18UOyhPo+SeTrvdao447EYTZ3QPXY0xzL6Uu6HZ14
         03MQ==
X-Gm-Message-State: AKGB3mJrHBi4B4H41epDwgsJbmCl1qsAYe5z0TjFibFY8z+nyPgoSvMS
        bLcdXy+i7zDfJPSlDIkiIjxfkg==
X-Google-Smtp-Source: ACJfBove6ViVHjpbcWIsMUnCzT6/Tw8v6/fofYioSSqSWNLHezLVN5+DrW3TtfAsQ+3bz0uMj2ohvA==
X-Received: by 10.107.146.9 with SMTP id u9mr39125954iod.37.1514434462994;
        Wed, 27 Dec 2017 20:14:22 -0800 (PST)
Received: from localhost.localdomain (170-72-6-219.ut.vivintwireless.net. [170.72.6.219])
        by smtp.gmail.com with ESMTPSA id f207sm11201841ita.26.2017.12.27.20.14.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Dec 2017 20:14:22 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH v5 22/34] merge-recursive: add get_directory_renames()
Date:   Wed, 27 Dec 2017 20:13:40 -0800
Message-Id: <20171228041352.27880-23-newren@gmail.com>
X-Mailer: git-send-email 2.15.0.408.g8e199d483
In-Reply-To: <20171228041352.27880-1-newren@gmail.com>
References: <20171228041352.27880-1-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This populates a list of directory renames for us.  The list of
directory renames is not yet used, but will be in subsequent commits.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c | 155 ++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 152 insertions(+), 3 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index c5932d5c5..6aef357e7 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1384,6 +1384,138 @@ static struct diff_queue_struct *get_diffpairs(struct merge_options *o,
 	return ret;
 }
 
+static void get_renamed_dir_portion(const char *old_path, const char *new_path,
+				    char **old_dir, char **new_dir)
+{
+	char *end_of_old, *end_of_new;
+	int old_len, new_len;
+
+	*old_dir = NULL;
+	*new_dir = NULL;
+
+	/* For
+	 *    "a/b/c/d/foo.c" -> "a/b/something-else/d/foo.c"
+	 * the "d/foo.c" part is the same, we just want to know that
+	 *    "a/b/c" was renamed to "a/b/something-else"
+	 * so, for this example, this function returns "a/b/c" in
+	 * *old_dir and "a/b/something-else" in *new_dir.
+	 *
+	 * Also, if the basename of the file changed, we don't care.  We
+	 * want to know which portion of the directory, if any, changed.
+	 */
+	end_of_old = strrchr(old_path, '/');
+	end_of_new = strrchr(new_path, '/');
+
+	if (end_of_old == NULL || end_of_new == NULL)
+		return;
+	while (*--end_of_new == *--end_of_old &&
+	       end_of_old != old_path &&
+	       end_of_new != new_path)
+		; /* Do nothing; all in the while loop */
+	/*
+	 * We've found the first non-matching character in the directory
+	 * paths.  That means the current directory we were comparing
+	 * represents the rename.  Move end_of_old and end_of_new back
+	 * to the full directory name.
+	 */
+	if (*end_of_old == '/')
+		end_of_old++;
+	if (*end_of_old != '/')
+		end_of_new++;
+	end_of_old = strchr(end_of_old, '/');
+	end_of_new = strchr(end_of_new, '/');
+
+	/*
+	 * It may have been the case that old_path and new_path were the same
+	 * directory all along.  Don't claim a rename if they're the same.
+	 */
+	old_len = end_of_old - old_path;
+	new_len = end_of_new - new_path;
+
+	if (old_len != new_len || strncmp(old_path, new_path, old_len)) {
+		*old_dir = xstrndup(old_path, old_len);
+		*new_dir = xstrndup(new_path, new_len);
+	}
+}
+
+static struct hashmap *get_directory_renames(struct diff_queue_struct *pairs,
+					     struct tree *tree)
+{
+	struct hashmap *dir_renames;
+	struct hashmap_iter iter;
+	struct dir_rename_entry *entry;
+	int i;
+
+	dir_renames = malloc(sizeof(struct hashmap));
+	dir_rename_init(dir_renames);
+	for (i = 0; i < pairs->nr; ++i) {
+		struct string_list_item *item;
+		int *count;
+		struct diff_filepair *pair = pairs->queue[i];
+		char *old_dir, *new_dir;
+
+		/* File not part of directory rename if it wasn't renamed */
+		if (pair->status != 'R')
+			continue;
+
+		get_renamed_dir_portion(pair->one->path, pair->two->path,
+					&old_dir,        &new_dir);
+		if (!old_dir)
+			/* Directory didn't change at all; ignore this one. */
+			continue;
+
+		entry = dir_rename_find_entry(dir_renames, old_dir);
+		if (!entry) {
+			entry = xmalloc(sizeof(struct dir_rename_entry));
+			dir_rename_entry_init(entry, old_dir);
+			hashmap_put(dir_renames, entry);
+		} else {
+			free(old_dir);
+		}
+		item = string_list_lookup(&entry->possible_new_dirs, new_dir);
+		if (!item) {
+			item = string_list_insert(&entry->possible_new_dirs,
+						  new_dir);
+			item->util = xcalloc(1, sizeof(int));
+		} else {
+			free(new_dir);
+		}
+		count = item->util;
+		*count += 1;
+	}
+
+	hashmap_iter_init(dir_renames, &iter);
+	while ((entry = hashmap_iter_next(&iter))) {
+		int max = 0;
+		int bad_max = 0;
+		char *best = NULL;
+
+		for (i = 0; i < entry->possible_new_dirs.nr; i++) {
+			int *count = entry->possible_new_dirs.items[i].util;
+
+			if (*count == max)
+				bad_max = max;
+			else if (*count > max) {
+				max = *count;
+				best = entry->possible_new_dirs.items[i].string;
+			}
+		}
+		if (bad_max == max)
+			entry->non_unique_new_dir = 1;
+		else {
+			assert(entry->new_dir.len == 0);
+			strbuf_addstr(&entry->new_dir, best);
+		}
+		/* Strings were xstrndup'ed before inserting into string-list,
+		 * so ask string_list to remove the entries for us.
+		 */
+		entry->possible_new_dirs.strdup_strings = 1;
+		string_list_clear(&entry->possible_new_dirs, 1);
+	}
+
+	return dir_renames;
+}
+
 /*
  * Get information of all renames which occurred in 'pairs', making use of
  * any implicit directory renames inferred from the other side of history.
@@ -1695,8 +1827,21 @@ struct rename_info {
 	struct string_list *merge_renames;
 };
 
-static void initial_cleanup_rename(struct diff_queue_struct *pairs)
+static void initial_cleanup_rename(struct diff_queue_struct *pairs,
+				   struct hashmap *dir_renames)
 {
+	struct hashmap_iter iter;
+	struct dir_rename_entry *e;
+
+	hashmap_iter_init(dir_renames, &iter);
+	while ((e = hashmap_iter_next(&iter))) {
+		free(e->dir);
+		strbuf_release(&e->new_dir);
+		/* possible_new_dirs already cleared in get_directory_renames */
+	}
+	hashmap_free(dir_renames, 1);
+	free(dir_renames);
+
 	free(pairs->queue);
 	free(pairs);
 }
@@ -1709,6 +1854,7 @@ static int handle_renames(struct merge_options *o,
 			  struct rename_info *ri)
 {
 	struct diff_queue_struct *head_pairs, *merge_pairs;
+	struct hashmap *dir_re_head, *dir_re_merge;
 	int clean;
 
 	ri->head_renames = NULL;
@@ -1720,6 +1866,9 @@ static int handle_renames(struct merge_options *o,
 	head_pairs = get_diffpairs(o, common, head);
 	merge_pairs = get_diffpairs(o, common, merge);
 
+	dir_re_head = get_directory_renames(head_pairs, head);
+	dir_re_merge = get_directory_renames(merge_pairs, merge);
+
 	ri->head_renames  = get_renames(o, head_pairs, head,
 					 common, head, merge, entries);
 	ri->merge_renames = get_renames(o, merge_pairs, merge,
@@ -1731,8 +1880,8 @@ static int handle_renames(struct merge_options *o,
 	 * data structures are still needed and referenced in
 	 * process_entry().  But there are a few things we can free now.
 	 */
-	initial_cleanup_rename(head_pairs);
-	initial_cleanup_rename(merge_pairs);
+	initial_cleanup_rename(head_pairs, dir_re_head);
+	initial_cleanup_rename(merge_pairs, dir_re_merge);
 
 	return clean;
 }
-- 
2.15.0.408.g8e199d483

