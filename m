Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D08C51F428
	for <e@80x24.org>; Fri,  5 Jan 2018 20:29:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752796AbeAEU2s (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 15:28:48 -0500
Received: from mail-it0-f65.google.com ([209.85.214.65]:38766 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751723AbeAEU2q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jan 2018 15:28:46 -0500
Received: by mail-it0-f65.google.com with SMTP id r6so2972094itr.3
        for <git@vger.kernel.org>; Fri, 05 Jan 2018 12:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QEpf4qC8R6scGHet7x5/48yVQTiVO4XUkJBQ80NC6Fk=;
        b=eBPoqt+hQ81vn6lSBNpiRN/veRgzSnJganbPT0DTWQTvZnEFNXSsuZbyO64aY9dP/V
         ntuSmGRSphy85P/6LHYmL1odu1F/GhApDbbcKASh/91iNZs05LI6WlgH95/2WAQJnUPq
         u9ZX8Gku+sEwSc7WEZatfenWtpm3xkhGwfXCv1qDhVHxD4VfKCbgzocCJKUX9aMipXjS
         BHyRLeqLZEWv9yRNwbwayLAksRqxqAWCj8wREaaOwGK1NkhwILNnBNZvF3OAJps3YvQU
         HRGGgJA+qfv2xx1Pw9RyyOpV1X55xxjAeig5EXciO9cCjZUjwtMUaorMHL5mCIZNKk3U
         fVWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QEpf4qC8R6scGHet7x5/48yVQTiVO4XUkJBQ80NC6Fk=;
        b=fOS7I2lyLI7ltDwUScxvl9bcqN3tERD7Xj/kbbzyZ2jP5kH1gA+1H3aJJtGCAdZakK
         Hq5vUM803UCVhGTjVX0h2MdE3ogL2h1/ZQpMyRrMmLyhNT8c8qOsnvXaNDnD52ds7fl4
         eH3klcKyxD0um8aY6VGnMVegRvgFAfii//y0TpXDI7F5rgZF5/tYPphLHbiBZQR324WC
         2I55jUmcXm9kJkywv/VLVs7u/R1Z5b7ZoYt3qTxxRtbEEkUw8VZ8UhQLXiCpLMo8P5bv
         7HnHnzHAG1QfGYwSg9WiUH8J4pGI67ZUz1EsROKN5C6CiEVaXcQL6amUp5/vutcFceDh
         gmxw==
X-Gm-Message-State: AKGB3mLuQ1SLIW6uhB9ha/86DKL30a7v9oDBC5P0p8yF3fQU8R03gBDs
        6ae7AjS7tnjlyjChB7BCtMOmKre9
X-Google-Smtp-Source: ACJfBos5gkux9Mo+OJYQ6HN9yv2U392v2yhmSWAE+FXdZLiHnekdggdYVS0uliKtt12dqzN5HCtF/w==
X-Received: by 10.36.103.75 with SMTP id u72mr4137462itc.77.1515184125596;
        Fri, 05 Jan 2018 12:28:45 -0800 (PST)
Received: from localhost.localdomain (c-73-20-122-173.hsd1.ut.comcast.net. [73.20.122.173])
        by smtp.gmail.com with ESMTPSA id 6sm3739659iow.55.2018.01.05.12.28.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Jan 2018 12:28:45 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, szeder.dev@gmail.com, j6t@kdbg.org,
        jrnieder@gmail.com, peff@peff.net, git@matthieu-moy.fr,
        Elijah Newren <newren@gmail.com>
Subject: [PATCHv6 20/31] merge-recursive: check for directory level conflicts
Date:   Fri,  5 Jan 2018 12:27:00 -0800
Message-Id: <20180105202711.24311-21-newren@gmail.com>
X-Mailer: git-send-email 2.15.0.409.g72e1e5805
In-Reply-To: <20180105202711.24311-1-newren@gmail.com>
References: <20180105202711.24311-1-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before trying to apply directory renames to paths within the given
directories, we want to make sure that there aren't conflicts at the
directory level.  There will be additional checks at the individual
file level too, which will be added later.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c | 119 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 119 insertions(+)

diff --git a/merge-recursive.c b/merge-recursive.c
index 6aef357e7..d92fba277 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1384,6 +1384,15 @@ static struct diff_queue_struct *get_diffpairs(struct merge_options *o,
 	return ret;
 }
 
+static int tree_has_path(struct tree *tree, const char *path)
+{
+	unsigned char hashy[20];
+	unsigned int mode_o;
+
+	return !get_tree_entry(tree->object.oid.hash, path,
+			       hashy, &mode_o);
+}
+
 static void get_renamed_dir_portion(const char *old_path, const char *new_path,
 				    char **old_dir, char **new_dir)
 {
@@ -1438,6 +1447,112 @@ static void get_renamed_dir_portion(const char *old_path, const char *new_path,
 	}
 }
 
+static void remove_hashmap_entries(struct hashmap *dir_renames,
+				   struct string_list *items_to_remove)
+{
+	int i;
+	struct dir_rename_entry *entry;
+
+	for (i = 0; i < items_to_remove->nr; i++) {
+		entry = items_to_remove->items[i].util;
+		hashmap_remove(dir_renames, entry, NULL);
+	}
+	string_list_clear(items_to_remove, 0);
+}
+
+/*
+ * There are a couple things we want to do at the directory level:
+ *   1. Check for both sides renaming to the same thing, in order to avoid
+ *      implicit renaming of files that should be left in place.  (See
+ *      testcase 6b in t6043 for details.)
+ *   2. Prune directory renames if there are still files left in the
+ *      the original directory.  These represent a partial directory rename,
+ *      i.e. a rename where only some of the files within the directory
+ *      were renamed elsewhere.  (Technically, this could be done earlier
+ *      in get_directory_renames(), except that would prevent us from
+ *      doing the previous check and thus failing testcase 6b.)
+ *   3. Check for rename/rename(1to2) conflicts (at the directory level).
+ *      In the future, we could potentially record this info as well and
+ *      omit reporting rename/rename(1to2) conflicts for each path within
+ *      the affected directories, thus cleaning up the merge output.
+ *   NOTE: We do NOT check for rename/rename(2to1) conflicts at the
+ *         directory level, because merging directories is fine.  If it
+ *         causes conflicts for files within those merged directories, then
+ *         that should be detected at the individual path level.
+ */
+static void handle_directory_level_conflicts(struct merge_options *o,
+					     struct hashmap *dir_re_head,
+					     struct tree *head,
+					     struct hashmap *dir_re_merge,
+					     struct tree *merge)
+{
+	struct hashmap_iter iter;
+	struct dir_rename_entry *head_ent;
+	struct dir_rename_entry *merge_ent;
+
+	struct string_list remove_from_head = STRING_LIST_INIT_NODUP;
+	struct string_list remove_from_merge = STRING_LIST_INIT_NODUP;
+
+	hashmap_iter_init(dir_re_head, &iter);
+	while ((head_ent = hashmap_iter_next(&iter))) {
+		merge_ent = dir_rename_find_entry(dir_re_merge, head_ent->dir);
+		if (merge_ent &&
+		    !head_ent->non_unique_new_dir &&
+		    !merge_ent->non_unique_new_dir &&
+		    !strbuf_cmp(&head_ent->new_dir, &merge_ent->new_dir)) {
+			/* 1. Renamed identically; remove it from both sides */
+			string_list_append(&remove_from_head,
+					   head_ent->dir)->util = head_ent;
+			strbuf_release(&head_ent->new_dir);
+			string_list_append(&remove_from_merge,
+					   merge_ent->dir)->util = merge_ent;
+			strbuf_release(&merge_ent->new_dir);
+		} else if (tree_has_path(head, head_ent->dir)) {
+			/* 2. This wasn't a directory rename after all */
+			string_list_append(&remove_from_head,
+					   head_ent->dir)->util = head_ent;
+			strbuf_release(&head_ent->new_dir);
+		}
+	}
+
+	remove_hashmap_entries(dir_re_head, &remove_from_head);
+	remove_hashmap_entries(dir_re_merge, &remove_from_merge);
+
+	hashmap_iter_init(dir_re_merge, &iter);
+	while ((merge_ent = hashmap_iter_next(&iter))) {
+		head_ent = dir_rename_find_entry(dir_re_head, merge_ent->dir);
+		if (tree_has_path(merge, merge_ent->dir)) {
+			/* 2. This wasn't a directory rename after all */
+			string_list_append(&remove_from_merge,
+					   merge_ent->dir)->util = merge_ent;
+		} else if (head_ent &&
+			   !head_ent->non_unique_new_dir &&
+			   !merge_ent->non_unique_new_dir) {
+			/* 3. rename/rename(1to2) */
+			/*
+			 * We can assume it's not rename/rename(1to1) because
+			 * that was case (1), already checked above.  So we
+			 * know that head_ent->new_dir and merge_ent->new_dir
+			 * are different strings.
+			 */
+			output(o, 1, _("CONFLICT (rename/rename): "
+				       "Rename directory %s->%s in %s. "
+				       "Rename directory %s->%s in %s"),
+			       head_ent->dir, head_ent->new_dir.buf, o->branch1,
+			       head_ent->dir, merge_ent->new_dir.buf, o->branch2);
+			string_list_append(&remove_from_head,
+					   head_ent->dir)->util = head_ent;
+			strbuf_release(&head_ent->new_dir);
+			string_list_append(&remove_from_merge,
+					   merge_ent->dir)->util = merge_ent;
+			strbuf_release(&merge_ent->new_dir);
+		}
+	}
+
+	remove_hashmap_entries(dir_re_head, &remove_from_head);
+	remove_hashmap_entries(dir_re_merge, &remove_from_merge);
+}
+
 static struct hashmap *get_directory_renames(struct diff_queue_struct *pairs,
 					     struct tree *tree)
 {
@@ -1869,6 +1984,10 @@ static int handle_renames(struct merge_options *o,
 	dir_re_head = get_directory_renames(head_pairs, head);
 	dir_re_merge = get_directory_renames(merge_pairs, merge);
 
+	handle_directory_level_conflicts(o,
+					 dir_re_head, head,
+					 dir_re_merge, merge);
+
 	ri->head_renames  = get_renames(o, head_pairs, head,
 					 common, head, merge, entries);
 	ri->merge_renames = get_renames(o, merge_pairs, merge,
-- 
2.14.2

