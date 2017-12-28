Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E3081F404
	for <e@80x24.org>; Thu, 28 Dec 2017 04:14:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753342AbdL1EOa (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Dec 2017 23:14:30 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:41059 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753330AbdL1EOZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Dec 2017 23:14:25 -0500
Received: by mail-it0-f66.google.com with SMTP id x28so26998711ita.0
        for <git@vger.kernel.org>; Wed, 27 Dec 2017 20:14:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7QR3VUmDKSVqrKZ0DPr1UmAjWDpfS9kKAb0OiwRhOwE=;
        b=WcSuaL3x4X0N7Z6dt9OKdlc26BLbkk4Sd9DbFrKX/OcS+4TVypoAvAKyHMk2Py9u3v
         KI3ZgOf/KC+0ZkSls7awxdRJKpD0xpB8sEzte/Q2HXa9pgFG4kTHgIRO1Kw0L9VMACtm
         8CtG4AOK0HLMHHRpoo6cV/vfoQegHJcL6poSKGtUQgxgLrKA1yz7jJxrk5b1KwCSKv5S
         ltZJJLgELlqi+/lMkKEFhCF473Cg/VKq/MIeQf8dh6qU22YW8IjEUwSZeKqDuvPzyOLl
         zAl8vx2NmRvRRVFuAyMQrdRFSkc8eKK1dEgp4fXY/dT8nqaBvluC3Z9dixsNNEOwSk3f
         r4SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7QR3VUmDKSVqrKZ0DPr1UmAjWDpfS9kKAb0OiwRhOwE=;
        b=KfGIHynDog5Ck7i0X6InXIydVnRAAY2VaZ1Ffb8vze7TaSkEZwhBBeXtx9WQL8qZch
         wRa3FywWQopEqRFtm+LEr6+JCb2QsAta8i+Zq2HFD51skfBQ9FV0wKqsmD5aiOJicRsK
         aAXsuVJozg1mxrIfkPwnJzcho0ULXVB69kU0N0bw5NK1t5JzJE+5oiVOL2Ih9fz44dBu
         62iZQHO1lWA1wuNev8igRkKjXza6qhYs0kNiM8YOTOFllDvMud4tp58vSgHrcaTTe5Wz
         o+L+Z5rDUzGq1R1h0Z/4r5RLx5fxkWhEcNq8NMRGqUBxnSS0BFsiRPffzVexsHHdLJOA
         NfRg==
X-Gm-Message-State: AKGB3mIYm7EwMsWfsj6gSZvpgGuuGBJbvmwRi7y0bIDao2u60/JD5FlX
        3pcuwaQrrte/Gecwzz/KaFBYCA==
X-Google-Smtp-Source: ACJfBosESWqZE2u7Cj+kG4Cty1ay4Df4umIVVCM5RQLpZlSNzbmgzZslnhIRm+r1dnGQaptyAFpIhQ==
X-Received: by 10.36.189.205 with SMTP id x196mr13681365ite.152.1514434464036;
        Wed, 27 Dec 2017 20:14:24 -0800 (PST)
Received: from localhost.localdomain (170-72-6-219.ut.vivintwireless.net. [170.72.6.219])
        by smtp.gmail.com with ESMTPSA id f207sm11201841ita.26.2017.12.27.20.14.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Dec 2017 20:14:23 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH v5 23/34] merge-recursive: check for directory level conflicts
Date:   Wed, 27 Dec 2017 20:13:41 -0800
Message-Id: <20171228041352.27880-24-newren@gmail.com>
X-Mailer: git-send-email 2.15.0.408.g8e199d483
In-Reply-To: <20171228041352.27880-1-newren@gmail.com>
References: <20171228041352.27880-1-newren@gmail.com>
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
2.15.0.408.g8e199d483

