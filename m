Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 934171F404
	for <e@80x24.org>; Thu, 28 Dec 2017 04:15:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753373AbdL1EPC (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Dec 2017 23:15:02 -0500
Received: from mail-it0-f48.google.com ([209.85.214.48]:44322 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753336AbdL1EO1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Dec 2017 23:14:27 -0500
Received: by mail-it0-f48.google.com with SMTP id b5so26985427itc.3
        for <git@vger.kernel.org>; Wed, 27 Dec 2017 20:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YXT8iLPOBxIY0oV6XdEmmTVORfOxrHeIKvBwn9VwL8I=;
        b=DvlCewdPCleKN3YhkiNnAIIfFfWli/DWqvgLIcCDn2xQ7dEgsIbc0kE9jUk9FfbbD7
         lcj1EoJLnsqhIiUSTRZRlG8hXlm3HWWvaPs9heqq023YLCFq49KnXVHveYrXfi3Xist7
         9G3WfA6ZMNHwb72jAUso5tsSmtcCft9nYwyMXeLyn//Xfdw1k7E14jjXhrLmu1VcaF8+
         ISd6MkcnfWBRkcq9sAIGNSStU4LFOMpuzzjevBAOPUGa46WbI/v30Sroo9msZ4RIFjaj
         GdT4zzhYIQSCxeqEbuzltvM+IttZOo5PcFxvvE1OTkIF2TQQL3zzWWm1RyPHrXhVwZHZ
         D5DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YXT8iLPOBxIY0oV6XdEmmTVORfOxrHeIKvBwn9VwL8I=;
        b=l40Wgc0TTiQHxXfKhkF5KugD6jGr5NKnL3YVNeKrHbQ8nVzDiUPs3s8Ym6gS72lsAJ
         MtI7tebq/PCjBk+l59VEY77xm9ApwmrRW6g7MRzjRN/Yo0xzmmns0uBb1em55+FBgJHs
         Vb66AXYM+2ovkGH1cZKd6c5AkDjmH5yHlmBUjPYIUZff9bkRzT27L22iUWTrt9FB70Um
         InlziUSxfbRmyxQY5++xA4ZdGan+sdG3xvzR+f8mDPjw3sBuxPPE0eYtI1eNMJrADt4F
         h5sWH1+TxI9+6Ay5zdjED+B/vFDhYMcMAftqCmCOAqqOqBGAUMSZ8t7p1km7AYR+MAj3
         CAbw==
X-Gm-Message-State: AKGB3mJWyjQyr6cMCfb5BPpJLFJPwco92ooBobtXgkMq4Ay2pzq0C6QR
        eZLrjgQM8r0V+uBDDRJRvrQz/A==
X-Google-Smtp-Source: ACJfBovBhgc7ojlZgfIaBEmcDhHVqZmItYqhNQhA/ZFRo3djHIrYoYjS+k++U4PZtmui+XqDn4CucQ==
X-Received: by 10.36.127.67 with SMTP id r64mr36891320itc.4.1514434466287;
        Wed, 27 Dec 2017 20:14:26 -0800 (PST)
Received: from localhost.localdomain (170-72-6-219.ut.vivintwireless.net. [170.72.6.219])
        by smtp.gmail.com with ESMTPSA id f207sm11201841ita.26.2017.12.27.20.14.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Dec 2017 20:14:25 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH v5 25/34] merge-recursive: add computation of collisions due to dir rename & merging
Date:   Wed, 27 Dec 2017 20:13:43 -0800
Message-Id: <20171228041352.27880-26-newren@gmail.com>
X-Mailer: git-send-email 2.15.0.408.g8e199d483
In-Reply-To: <20171228041352.27880-1-newren@gmail.com>
References: <20171228041352.27880-1-newren@gmail.com>
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
2.15.0.408.g8e199d483

