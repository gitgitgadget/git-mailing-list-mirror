Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35D2B1F404
	for <e@80x24.org>; Thu, 28 Dec 2017 04:15:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753392AbdL1EPc (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Dec 2017 23:15:32 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:41055 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753306AbdL1EOS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Dec 2017 23:14:18 -0500
Received: by mail-it0-f66.google.com with SMTP id x28so26998577ita.0
        for <git@vger.kernel.org>; Wed, 27 Dec 2017 20:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BacHJVcl+PagT38QDpplDnqldO7PpK3/Zv/qs/jL1g0=;
        b=dcqG1Zm3A6lo6g0u6FXAgu7ZsJ24FGllzo12XEkAcDUDAJ9iVZ4gw/DeV0wbuKPpan
         +XYbrrx6ru8UbgRMVWuDbW40hkBJf0QUxPX6nsb6U4+avG9eGdvE7qbas6nGyQwPc0Ob
         DERZy4OO9M0o/Pr1e943QDg1Xp6x6A6GjsQMBudTqZuJMi4uBMc1Ah+zdUe/wuwr3Pmx
         d4w2TLCxWnmEo7Ubrcf8JDmSpXugksGN8cpJR2EA7/X6LIEuWdaPR//a6k4YGLN/NYn/
         REBZpCixWMbvToiIX1aYs9VlaY+lT+bd0VgWzBMNkIffZBtAxGg0Tem1QqueUfC+HffR
         YLoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BacHJVcl+PagT38QDpplDnqldO7PpK3/Zv/qs/jL1g0=;
        b=lLM5MNI8noybDQq2x6tNc+f+heKh55pr8E3SRJBwupcVcTDCeM8/yXIxJaNf48tZRB
         ttBUc4w9kY+kogl+M4W9k3zvRaGzF46xjUXB2rNHJSDgmpz072KOiJcqphQyJTgzOzal
         zjYTof3mP42SDInArVNgWL7esNeOGSSiQbyj/qaapQsZnCm63Z/0qvoIliA8i5bvpcJW
         NRPirxWU9pRuEZMfZXxIjtOC38ixNyuhhc1pS2PyVopBcKHZ51FZns5x6CZ/HOsIkAtn
         FWDhH0VfscmvkPnaTcDSvUTp1tipAqL5SwDOnRE9QolPD3PkKBpwA3CWxmKAPx1f+Din
         TF7A==
X-Gm-Message-State: AKGB3mKIYa4Pzh44fEmEEqrKG12w4GrWnMMVUzkmsAT2uS48txAkyVRf
        g3P5ccZh8OpDwhmMp1pBWS/VQg==
X-Google-Smtp-Source: ACJfBouqfbkx33J9VHfSmxb0qNwnyRJFKWH9NE5nRVqjAn0gZTPX9NuuugAGmtJmeUtokVtbDX1CTQ==
X-Received: by 10.36.66.209 with SMTP id i200mr41219067itb.102.1514434456374;
        Wed, 27 Dec 2017 20:14:16 -0800 (PST)
Received: from localhost.localdomain (170-72-6-219.ut.vivintwireless.net. [170.72.6.219])
        by smtp.gmail.com with ESMTPSA id f207sm11201841ita.26.2017.12.27.20.14.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Dec 2017 20:14:15 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH v5 15/34] merge-recursive: move the get_renames() function
Date:   Wed, 27 Dec 2017 20:13:33 -0800
Message-Id: <20171228041352.27880-16-newren@gmail.com>
X-Mailer: git-send-email 2.15.0.408.g8e199d483
In-Reply-To: <20171228041352.27880-1-newren@gmail.com>
References: <20171228041352.27880-1-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I want to re-use some other functions in the file without moving those
other functions or dealing with a handful of annoying split function
declarations and definitions.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c | 139 +++++++++++++++++++++++++++---------------------------
 1 file changed, 70 insertions(+), 69 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index d78853d5e..08bf26b9c 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -537,75 +537,6 @@ struct rename {
 	unsigned processed:1;
 };
 
-/*
- * Get information of all renames which occurred between 'o_tree' and
- * 'tree'. We need the three trees in the merge ('o_tree', 'a_tree' and
- * 'b_tree') to be able to associate the correct cache entries with
- * the rename information. 'tree' is always equal to either a_tree or b_tree.
- */
-static struct string_list *get_renames(struct merge_options *o,
-				       struct tree *tree,
-				       struct tree *o_tree,
-				       struct tree *a_tree,
-				       struct tree *b_tree,
-				       struct string_list *entries)
-{
-	int i;
-	struct string_list *renames;
-	struct diff_options opts;
-
-	renames = xcalloc(1, sizeof(struct string_list));
-	if (!o->detect_rename)
-		return renames;
-
-	diff_setup(&opts);
-	opts.flags.recursive = 1;
-	opts.flags.rename_empty = 0;
-	opts.detect_rename = DIFF_DETECT_RENAME;
-	opts.rename_limit = o->merge_rename_limit >= 0 ? o->merge_rename_limit :
-			    o->diff_rename_limit >= 0 ? o->diff_rename_limit :
-			    1000;
-	opts.rename_score = o->rename_score;
-	opts.show_rename_progress = o->show_rename_progress;
-	opts.output_format = DIFF_FORMAT_NO_OUTPUT;
-	diff_setup_done(&opts);
-	diff_tree_oid(&o_tree->object.oid, &tree->object.oid, "", &opts);
-	diffcore_std(&opts);
-	if (opts.needed_rename_limit > o->needed_rename_limit)
-		o->needed_rename_limit = opts.needed_rename_limit;
-	for (i = 0; i < diff_queued_diff.nr; ++i) {
-		struct string_list_item *item;
-		struct rename *re;
-		struct diff_filepair *pair = diff_queued_diff.queue[i];
-		if (pair->status != 'R') {
-			diff_free_filepair(pair);
-			continue;
-		}
-		re = xmalloc(sizeof(*re));
-		re->processed = 0;
-		re->pair = pair;
-		item = string_list_lookup(entries, re->pair->one->path);
-		if (!item)
-			re->src_entry = insert_stage_data(re->pair->one->path,
-					o_tree, a_tree, b_tree, entries);
-		else
-			re->src_entry = item->util;
-
-		item = string_list_lookup(entries, re->pair->two->path);
-		if (!item)
-			re->dst_entry = insert_stage_data(re->pair->two->path,
-					o_tree, a_tree, b_tree, entries);
-		else
-			re->dst_entry = item->util;
-		item = string_list_insert(renames, pair->one->path);
-		item->util = re;
-	}
-	opts.output_format = DIFF_FORMAT_NO_OUTPUT;
-	diff_queued_diff.nr = 0;
-	diff_flush(&opts);
-	return renames;
-}
-
 static int update_stages(struct merge_options *opt, const char *path,
 			 const struct diff_filespec *o,
 			 const struct diff_filespec *a,
@@ -1380,6 +1311,76 @@ static int conflict_rename_rename_2to1(struct merge_options *o,
 	return ret;
 }
 
+/*
+ * Get information of all renames which occurred between 'o_tree' and
+ * 'tree'. We need the three trees in the merge ('o_tree', 'a_tree' and
+ * 'b_tree') to be able to associate the correct cache entries with
+ * the rename information. 'tree' is always equal to either a_tree or b_tree.
+ */
+static struct string_list *get_renames(struct merge_options *o,
+				       struct tree *tree,
+				       struct tree *o_tree,
+				       struct tree *a_tree,
+				       struct tree *b_tree,
+				       struct string_list *entries)
+{
+	int i;
+	struct string_list *renames;
+	struct diff_options opts;
+
+	renames = xcalloc(1, sizeof(struct string_list));
+	if (!o->detect_rename)
+		return renames;
+
+	diff_setup(&opts);
+	opts.flags.recursive = 1;
+	opts.flags.rename_empty = 0;
+	opts.detect_rename = DIFF_DETECT_RENAME;
+	opts.rename_limit = o->merge_rename_limit >= 0 ? o->merge_rename_limit :
+			    o->diff_rename_limit >= 0 ? o->diff_rename_limit :
+			    1000;
+	opts.rename_score = o->rename_score;
+	opts.show_rename_progress = o->show_rename_progress;
+	opts.output_format = DIFF_FORMAT_NO_OUTPUT;
+	diff_setup_done(&opts);
+	diff_tree_oid(&o_tree->object.oid, &tree->object.oid, "", &opts);
+	diffcore_std(&opts);
+	if (opts.needed_rename_limit > o->needed_rename_limit)
+		o->needed_rename_limit = opts.needed_rename_limit;
+	for (i = 0; i < diff_queued_diff.nr; ++i) {
+		struct string_list_item *item;
+		struct rename *re;
+		struct diff_filepair *pair = diff_queued_diff.queue[i];
+
+		if (pair->status != 'R') {
+			diff_free_filepair(pair);
+			continue;
+		}
+		re = xmalloc(sizeof(*re));
+		re->processed = 0;
+		re->pair = pair;
+		item = string_list_lookup(entries, re->pair->one->path);
+		if (!item)
+			re->src_entry = insert_stage_data(re->pair->one->path,
+					o_tree, a_tree, b_tree, entries);
+		else
+			re->src_entry = item->util;
+
+		item = string_list_lookup(entries, re->pair->two->path);
+		if (!item)
+			re->dst_entry = insert_stage_data(re->pair->two->path,
+					o_tree, a_tree, b_tree, entries);
+		else
+			re->dst_entry = item->util;
+		item = string_list_insert(renames, pair->one->path);
+		item->util = re;
+	}
+	opts.output_format = DIFF_FORMAT_NO_OUTPUT;
+	diff_queued_diff.nr = 0;
+	diff_flush(&opts);
+	return renames;
+}
+
 static int process_renames(struct merge_options *o,
 			   struct string_list *a_renames,
 			   struct string_list *b_renames)
-- 
2.15.0.408.g8e199d483

