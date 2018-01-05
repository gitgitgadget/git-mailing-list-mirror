Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 465591F428
	for <e@80x24.org>; Fri,  5 Jan 2018 20:28:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752798AbeAEU2t (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 15:28:49 -0500
Received: from mail-it0-f67.google.com ([209.85.214.67]:37884 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752791AbeAEU2p (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jan 2018 15:28:45 -0500
Received: by mail-it0-f67.google.com with SMTP id d137so2980938itc.2
        for <git@vger.kernel.org>; Fri, 05 Jan 2018 12:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AVL4ipuoZhHc/pQLmnHX25dRM+Aj6TjJ9AxjIzidwU4=;
        b=ujaHWUOXXxg6iw4C8fC2XGTUBHRGMjW1w0vSBU/MrFgyVEgaSObAOlSsKrk5BpR6xo
         rw0TjjzOVhC/hik9EPJtOJronmEjSICEwa8HTKWLKdrhqPKzl3UjOPSO8mejJKgO5zX1
         yoOH8Wsu8lzJk45IxZSMaX+a6H27xweC9oN05Ndu6GgB7YyWUV/HfwFx13/NpxwfmFm6
         DECJdrIKHLS4JFhzDwI8URKXXTfDoTCqt3Sad5fCqH+DAlMggZS6mVqf4Vp4V0sx5+1o
         bkF94hWm4U1VEEzOqDpaAn5wVPzAUvnH5qRSrDJE7Ia2GGsZNtudGXqfkMT9/qEgr+8c
         JWvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AVL4ipuoZhHc/pQLmnHX25dRM+Aj6TjJ9AxjIzidwU4=;
        b=EWK9gjLsiCJH9agnvCiBkYmnB7g8jpEeSz5pd9RkPyN63OtvxATpCuEeK+btQkI/W4
         1Iv8ywUSL98YKb+2EOLa99ocNUsxs6qUBxyKP/Ik+fY9y6goTJm3g8KQ9288OzZfpXfc
         sCoOSnXfMqzD4W5w8uda6A98TaQCvERxUKjevReMVwaA4Mm0y0+ABn64kJQ4+DpDKlss
         wtED25hyvciE15X/ZfYt1S2Brr12balioSwAoqUUBMfmbtmp6ALZiVSNEpy//eiIGOO9
         V+QFbgcr5w1lUQFsEHrdtIYPv6GAviS6N71f3rMOCaha4MvuhXRz7cM0l/9Mv2nTZVyw
         zV/Q==
X-Gm-Message-State: AKwxytdpt1lgOviofNKxdZZXtGjkJ9Dgk0bs9SvLjc0k217Q0lkf2QHO
        z/xVmGc2NQClv6nGaVjP4JViI0A1
X-Google-Smtp-Source: ACJfBouHfHAQ31kTlReJdrbgyNYW2ykol+Nt1TIh433svdOYoD+BxfcRf6fUpCXGIz/IQ7HWwJuing==
X-Received: by 10.36.181.9 with SMTP id v9mr47482ite.27.1515184124319;
        Fri, 05 Jan 2018 12:28:44 -0800 (PST)
Received: from localhost.localdomain (c-73-20-122-173.hsd1.ut.comcast.net. [73.20.122.173])
        by smtp.gmail.com with ESMTPSA id 6sm3739659iow.55.2018.01.05.12.28.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Jan 2018 12:28:43 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, szeder.dev@gmail.com, j6t@kdbg.org,
        jrnieder@gmail.com, peff@peff.net, git@matthieu-moy.fr,
        Elijah Newren <newren@gmail.com>
Subject: [PATCHv6 19/31] merge-recursive: add get_directory_renames()
Date:   Fri,  5 Jan 2018 12:26:59 -0800
Message-Id: <20180105202711.24311-20-newren@gmail.com>
X-Mailer: git-send-email 2.15.0.409.g72e1e5805
In-Reply-To: <20180105202711.24311-1-newren@gmail.com>
References: <20180105202711.24311-1-newren@gmail.com>
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
2.14.2

