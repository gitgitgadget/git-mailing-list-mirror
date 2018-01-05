Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 86BDE1F428
	for <e@80x24.org>; Fri,  5 Jan 2018 20:29:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752831AbeAEU3W (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 15:29:22 -0500
Received: from mail-io0-f196.google.com ([209.85.223.196]:43108 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752514AbeAEU2t (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jan 2018 15:28:49 -0500
Received: by mail-io0-f196.google.com with SMTP id w188so6962416iod.10
        for <git@vger.kernel.org>; Fri, 05 Jan 2018 12:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sFhAniPGS/jGRwMerUbvW4uX9WC8+gx6DmUAmcI9e7s=;
        b=GT1FYw30Rx0s1d749gBqKUro650xqRsvyFzSBUb3YL28eiPQI+qIqqLzNFeyWt0nNn
         zpMja2EhLOgydP2rcL5cVaQgFk2u3+yaEgXoLJUH5YoUN8he7zhPeKFWRIUF78Yw5XyF
         xHeiRZo1GILLeVtJSpa/gn4nlCeftRY7x06xYnR6fksSJkU6uctJaD+FuLLqa3B/ihbs
         NaN/X3hRkvLEqQARaZhDfeTjyrqq/EXlZKnjo7c9eM7e1iVUsmxqcbz+ab8odvQubsbe
         eOTWsEZ6/bYFvzPn+6qWmHVeLF1GCg6fa8v1jQ3MTVJGMe8bW0xBLeHyMU+9xT6zuwg4
         dtGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sFhAniPGS/jGRwMerUbvW4uX9WC8+gx6DmUAmcI9e7s=;
        b=TtIwAqwDYvzGj75ZZK7kx4JiyWTiX+oVMIskIMV/Kfp8mqCgvgBpTaExyIikVgXFbO
         2dmRe7ZhlgZt7TsWTT05Sgh45Ixb3yiqD/vwBMp7VuRqtkCZ8d8Kz8bKd1AWnYbGcpfD
         9lMjBezDFK90M8SVSOnTW9esz01G+OU7lIMEXnj0fIivhlll5+MSgkl5Nah02CMZm27l
         aMRlbjdP2gFcRX9aFBDcjOGXXOd2M6uCcwoQ5fRAikcIWRYNbbDqNS/u/9FDnc0m5QrZ
         5JDSw3/KtxBp+GVtiGHefzxCCqoqC4jWTzgypeClQBXn+ABU30ndUAeFOSuso0NTqX5p
         Oc3Q==
X-Gm-Message-State: AKGB3mKbfSDnGrJINsi3aG/bGjE7M0QPAB09kAXGifRT4ps5uohjmSUN
        g7GMtLNflnax69lHFbGPZ6+tI5Xi
X-Google-Smtp-Source: ACJfBouslJA1DD0za7I+qvRmvDv4gSJ2tsKR74zmjmbT8DcTGc5rdvXock9mPYXhieHDA0vBMrQbVg==
X-Received: by 10.107.134.39 with SMTP id i39mr4205317iod.233.1515184128239;
        Fri, 05 Jan 2018 12:28:48 -0800 (PST)
Received: from localhost.localdomain (c-73-20-122-173.hsd1.ut.comcast.net. [73.20.122.173])
        by smtp.gmail.com with ESMTPSA id 6sm3739659iow.55.2018.01.05.12.28.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Jan 2018 12:28:47 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, szeder.dev@gmail.com, j6t@kdbg.org,
        jrnieder@gmail.com, peff@peff.net, git@matthieu-moy.fr,
        Elijah Newren <newren@gmail.com>
Subject: [PATCHv6 22/31] merge-recursive: add computation of collisions due to dir rename & merging
Date:   Fri,  5 Jan 2018 12:27:02 -0800
Message-Id: <20180105202711.24311-23-newren@gmail.com>
X-Mailer: git-send-email 2.15.0.409.g72e1e5805
In-Reply-To: <20180105202711.24311-1-newren@gmail.com>
References: <20180105202711.24311-1-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

directory renaming and merging can cause one or more files to be moved to
where an existing file is, or to cause several files to all be moved to
the same (otherwise vacant) location.  Add checking and reporting for such
cases, falling back to no-directory-rename handling for such paths.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c | 123 ++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 120 insertions(+), 3 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 6bd4f34d5..9e31baaf3 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1416,6 +1416,31 @@ static int tree_has_path(struct tree *tree, const char *path)
 			       hashy, &mode_o);
 }
 
+/*
+ * Return a new string that replaces the beginning portion (which matches
+ * entry->dir), with entry->new_dir.  In perl-speak:
+ *   new_path_name = (old_path =~ s/entry->dir/entry->new_dir/);
+ * NOTE:
+ *   Caller must ensure that old_path starts with entry->dir + '/'.
+ */
+static char *apply_dir_rename(struct dir_rename_entry *entry,
+			      const char *old_path)
+{
+	struct strbuf new_path = STRBUF_INIT;
+	int oldlen, newlen;
+
+	if (entry->non_unique_new_dir)
+		return NULL;
+
+	oldlen = strlen(entry->dir);
+	newlen = entry->new_dir.len + (strlen(old_path) - oldlen) + 1;
+	strbuf_grow(&new_path, newlen);
+	strbuf_addbuf(&new_path, &entry->new_dir);
+	strbuf_addstr(&new_path, &old_path[oldlen]);
+
+	return strbuf_detach(&new_path, NULL);
+}
+
 static void get_renamed_dir_portion(const char *old_path, const char *new_path,
 				    char **old_dir, char **new_dir)
 {
@@ -1654,6 +1679,84 @@ static struct hashmap *get_directory_renames(struct diff_queue_struct *pairs,
 	return dir_renames;
 }
 
+static struct dir_rename_entry *check_dir_renamed(const char *path,
+						  struct hashmap *dir_renames)
+{
+	char temp[PATH_MAX];
+	char *end;
+	struct dir_rename_entry *entry;
+
+	strcpy(temp, path);
+	while ((end = strrchr(temp, '/'))) {
+		*end = '\0';
+		entry = dir_rename_find_entry(dir_renames, temp);
+		if (entry)
+			return entry;
+	}
+	return NULL;
+}
+
+static void compute_collisions(struct hashmap *collisions,
+			       struct hashmap *dir_renames,
+			       struct diff_queue_struct *pairs)
+{
+	int i;
+
+	/*
+	 * Multiple files can be mapped to the same path due to directory
+	 * renames done by the other side of history.  Since that other
+	 * side of history could have merged multiple directories into one,
+	 * if our side of history added the same file basename to each of
+	 * those directories, then all N of them would get implicitly
+	 * renamed by the directory rename detection into the same path,
+	 * and we'd get an add/add/.../add conflict, and all those adds
+	 * from *this* side of history.  This is not representable in the
+	 * index, and users aren't going to easily be able to make sense of
+	 * it.  So we need to provide a good warning about what's
+	 * happening, and fall back to no-directory-rename detection
+	 * behavior for those paths.
+	 *
+	 * See testcases 9e and all of section 5 from t6043 for examples.
+	 */
+	collision_init(collisions);
+
+	for (i = 0; i < pairs->nr; ++i) {
+		struct dir_rename_entry *dir_rename_ent;
+		struct collision_entry *collision_ent;
+		char *new_path;
+		struct diff_filepair *pair = pairs->queue[i];
+
+		if (pair->status == 'D')
+			continue;
+		dir_rename_ent = check_dir_renamed(pair->two->path,
+						   dir_renames);
+		if (!dir_rename_ent)
+			continue;
+
+		new_path = apply_dir_rename(dir_rename_ent, pair->two->path);
+		if (!new_path)
+			/*
+			 * dir_rename_ent->non_unique_new_path is true, which
+			 * means there is no directory rename for us to use,
+			 * which means it won't cause us any additional
+			 * collisions.
+			 */
+			continue;
+		collision_ent = collision_find_entry(collisions, new_path);
+		if (!collision_ent) {
+			collision_ent = xcalloc(1,
+						sizeof(struct collision_entry));
+			hashmap_entry_init(collision_ent, strhash(new_path));
+			hashmap_put(collisions, collision_ent);
+			collision_ent->target_file = new_path;
+		} else {
+			free(new_path);
+		}
+		string_list_insert(&collision_ent->source_files,
+				   pair->two->path);
+	}
+}
+
 /*
  * Get information of all renames which occurred in 'pairs', making use of
  * any implicit directory renames inferred from the other side of history.
@@ -1663,6 +1766,7 @@ static struct hashmap *get_directory_renames(struct diff_queue_struct *pairs,
  */
 static struct string_list *get_renames(struct merge_options *o,
 				       struct diff_queue_struct *pairs,
+				       struct hashmap *dir_renames,
 				       struct tree *tree,
 				       struct tree *o_tree,
 				       struct tree *a_tree,
@@ -1670,8 +1774,12 @@ static struct string_list *get_renames(struct merge_options *o,
 				       struct string_list *entries)
 {
 	int i;
+	struct hashmap collisions;
+	struct hashmap_iter iter;
+	struct collision_entry *e;
 	struct string_list *renames;
 
+	compute_collisions(&collisions, dir_renames, pairs);
 	renames = xcalloc(1, sizeof(struct string_list));
 
 	for (i = 0; i < pairs->nr; ++i) {
@@ -1702,6 +1810,13 @@ static struct string_list *get_renames(struct merge_options *o,
 		item = string_list_insert(renames, pair->one->path);
 		item->util = re;
 	}
+
+	hashmap_iter_init(&collisions, &iter);
+	while ((e = hashmap_iter_next(&iter))) {
+		free(e->target_file);
+		string_list_clear(&e->source_files, 0);
+	}
+	hashmap_free(&collisions, 1);
 	return renames;
 }
 
@@ -2011,9 +2126,11 @@ static int handle_renames(struct merge_options *o,
 					 dir_re_head, head,
 					 dir_re_merge, merge);
 
-	ri->head_renames  = get_renames(o, head_pairs, head,
-					 common, head, merge, entries);
-	ri->merge_renames = get_renames(o, merge_pairs, merge,
+	ri->head_renames  = get_renames(o, head_pairs,
+					dir_re_merge, head,
+					common, head, merge, entries);
+	ri->merge_renames = get_renames(o, merge_pairs,
+					dir_re_head, merge,
 					 common, head, merge, entries);
 	clean = process_renames(o, ri->head_renames, ri->merge_renames);
 
-- 
2.14.2

