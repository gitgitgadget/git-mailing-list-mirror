Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F0621F428
	for <e@80x24.org>; Fri,  5 Jan 2018 20:29:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752835AbeAEU3c (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 15:29:32 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:35833 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752778AbeAEU2l (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jan 2018 15:28:41 -0500
Received: by mail-io0-f193.google.com with SMTP id 14so6993197iou.2
        for <git@vger.kernel.org>; Fri, 05 Jan 2018 12:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LN1L1r1CLih0kE5kHLhTfUZJo5oPpqHNwp0CkuywK6k=;
        b=RzXSbp+lKB6Ilm2zV/qEj3qm8XMgR/YVPvh7FzL0wmueyQB3mVBQqtAY61H+/HTLLj
         WMgXctG6rS2KkGwtlDmKzAih/H6iJ6XfBg2sawc4ntbY9qDAcuNHIyLo7BL0QCDs78Vo
         1SOt5EuYGQx/So7JjFXUpxcH3UgrV83/UgyICLqpUx5mYGOJ5HNVoUXYpVuaR2H2dyAK
         /kmkwhHbpvTucOtP7w5XXIcq3Z9v8/gWdwh+eySCOD9vfvAFzb8frpeZgupQKR4bC7Kc
         gKkbewQxt5V4+rFtE7cAGYkD4HI09n8pIh2NE+WETzV7v/EYSsgzhzHLbfls7lutloLk
         LCzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LN1L1r1CLih0kE5kHLhTfUZJo5oPpqHNwp0CkuywK6k=;
        b=G6FUyCt2EOlTq00aDgf9Awxogs+fIEKPk5bgpq4BGcSScTBK+zmoqlCVwUG00YXeIn
         6GI9JGFt3bCQOuC14IRqwS3JzukjA2RxDdPEBPNgEHde4LopAwVkoviQvwXy5PmgGLr9
         SXPYMtiMbKqbx5wpIaFMDz6S/vvuRR70q0psbSAKEJLrajg0qxfkpCS0skaO5gN2XSZp
         DhRIV3rq8zp7gnaHAbZOl/1pxEcrdw31pXELOyQpDXobmaXWPQcxetYtL0koNm+SU1J3
         7uY1PADijlYpWKTNinyAzygNYFTwNx9i/K0hkfAtMg0Fc53kRIPoQELs+NmYoI2j4fML
         +Mug==
X-Gm-Message-State: AKGB3mI9fh5R45tpOHqaJ1Rj1x/xUXTPiMEMz3D6ty+cyFOHPNjUitKH
        gKnbHxR3Z76bqcwcs2FJuoqUyMmU
X-Google-Smtp-Source: ACJfBos1TRmo2m4gxNlO45mZXTIlgQSMjyYxsSL+N6uCMGFyQJsTrSUO/S0O3HZA43W7AzZ00h9P9g==
X-Received: by 10.107.183.149 with SMTP id h143mr4618907iof.166.1515184120556;
        Fri, 05 Jan 2018 12:28:40 -0800 (PST)
Received: from localhost.localdomain (c-73-20-122-173.hsd1.ut.comcast.net. [73.20.122.173])
        by smtp.gmail.com with ESMTPSA id 6sm3739659iow.55.2018.01.05.12.28.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Jan 2018 12:28:40 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, szeder.dev@gmail.com, j6t@kdbg.org,
        jrnieder@gmail.com, peff@peff.net, git@matthieu-moy.fr,
        Elijah Newren <newren@gmail.com>
Subject: [PATCHv6 16/31] merge-recursive: split out code for determining diff_filepairs
Date:   Fri,  5 Jan 2018 12:26:56 -0800
Message-Id: <20180105202711.24311-17-newren@gmail.com>
X-Mailer: git-send-email 2.15.0.409.g72e1e5805
In-Reply-To: <20180105202711.24311-1-newren@gmail.com>
References: <20180105202711.24311-1-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Create a new function, get_diffpairs() to compute the diff_filepairs
between two trees.  While these are currently only used in
get_renames(), I want them to be available to some new functions.  No
actual logic changes yet.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c | 86 +++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 64 insertions(+), 22 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index da7c67eb8..4adff2d53 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1312,24 +1312,15 @@ static int conflict_rename_rename_2to1(struct merge_options *o,
 }
 
 /*
- * Get information of all renames which occurred between 'o_tree' and
- * 'tree'. We need the three trees in the merge ('o_tree', 'a_tree' and
- * 'b_tree') to be able to associate the correct cache entries with
- * the rename information. 'tree' is always equal to either a_tree or b_tree.
+ * Get the diff_filepairs changed between o_tree and tree.
  */
-static struct string_list *get_renames(struct merge_options *o,
-				       struct tree *tree,
-				       struct tree *o_tree,
-				       struct tree *a_tree,
-				       struct tree *b_tree,
-				       struct string_list *entries)
+static struct diff_queue_struct *get_diffpairs(struct merge_options *o,
+					       struct tree *o_tree,
+					       struct tree *tree)
 {
-	int i;
-	struct string_list *renames;
+	struct diff_queue_struct *ret;
 	struct diff_options opts;
 
-	renames = xcalloc(1, sizeof(struct string_list));
-
 	diff_setup(&opts);
 	opts.flags.recursive = 1;
 	opts.flags.rename_empty = 0;
@@ -1345,10 +1336,43 @@ static struct string_list *get_renames(struct merge_options *o,
 	diffcore_std(&opts);
 	if (opts.needed_rename_limit > o->needed_rename_limit)
 		o->needed_rename_limit = opts.needed_rename_limit;
-	for (i = 0; i < diff_queued_diff.nr; ++i) {
+
+	ret = malloc(sizeof(struct diff_queue_struct));
+	ret->queue = diff_queued_diff.queue;
+	ret->nr = diff_queued_diff.nr;
+	/* Ignore diff_queued_diff.alloc; we won't be changing size at all */
+
+	opts.output_format = DIFF_FORMAT_NO_OUTPUT;
+	diff_queued_diff.nr = 0;
+	diff_queued_diff.queue = NULL;
+	diff_flush(&opts);
+	return ret;
+}
+
+/*
+ * Get information of all renames which occurred in 'pairs', making use of
+ * any implicit directory renames inferred from the other side of history.
+ * We need the three trees in the merge ('o_tree', 'a_tree' and 'b_tree')
+ * to be able to associate the correct cache entries with the rename
+ * information; tree is always equal to either a_tree or b_tree.
+ */
+static struct string_list *get_renames(struct merge_options *o,
+				       struct diff_queue_struct *pairs,
+				       struct tree *tree,
+				       struct tree *o_tree,
+				       struct tree *a_tree,
+				       struct tree *b_tree,
+				       struct string_list *entries)
+{
+	int i;
+	struct string_list *renames;
+
+	renames = xcalloc(1, sizeof(struct string_list));
+
+	for (i = 0; i < pairs->nr; ++i) {
 		struct string_list_item *item;
 		struct rename *re;
-		struct diff_filepair *pair = diff_queued_diff.queue[i];
+		struct diff_filepair *pair = pairs->queue[i];
 
 		if (pair->status != 'R') {
 			diff_free_filepair(pair);
@@ -1373,9 +1397,6 @@ static struct string_list *get_renames(struct merge_options *o,
 		item = string_list_insert(renames, pair->one->path);
 		item->util = re;
 	}
-	opts.output_format = DIFF_FORMAT_NO_OUTPUT;
-	diff_queued_diff.nr = 0;
-	diff_flush(&opts);
 	return renames;
 }
 
@@ -1646,15 +1667,36 @@ static int handle_renames(struct merge_options *o,
 			  struct string_list *entries,
 			  struct rename_info *ri)
 {
+	struct diff_queue_struct *head_pairs, *merge_pairs;
+	int clean;
+
 	ri->head_renames = NULL;
 	ri->merge_renames = NULL;
 
 	if (!o->detect_rename)
 		return 1;
 
-	ri->head_renames  = get_renames(o, head, common, head, merge, entries);
-	ri->merge_renames = get_renames(o, merge, common, head, merge, entries);
-	return process_renames(o, ri->head_renames, ri->merge_renames);
+	head_pairs = get_diffpairs(o, common, head);
+	merge_pairs = get_diffpairs(o, common, merge);
+
+	ri->head_renames  = get_renames(o, head_pairs, head,
+					 common, head, merge, entries);
+	ri->merge_renames = get_renames(o, merge_pairs, merge,
+					 common, head, merge, entries);
+	clean = process_renames(o, ri->head_renames, ri->merge_renames);
+
+	/*
+	 * Some cleanup is deferred until cleanup_renames() because the
+	 * data structures are still needed and referenced in
+	 * process_entry().  But there are a few things we can free now.
+	 */
+
+	free(head_pairs->queue);
+	free(head_pairs);
+	free(merge_pairs->queue);
+	free(merge_pairs);
+
+	return clean;
 }
 
 static void cleanup_rename(struct string_list *rename)
-- 
2.14.2

