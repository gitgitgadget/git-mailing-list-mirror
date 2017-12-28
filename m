Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91DC81F404
	for <e@80x24.org>; Thu, 28 Dec 2017 04:14:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753335AbdL1EOZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Dec 2017 23:14:25 -0500
Received: from mail-io0-f194.google.com ([209.85.223.194]:36579 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753321AbdL1EOU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Dec 2017 23:14:20 -0500
Received: by mail-io0-f194.google.com with SMTP id i143so17043770ioa.3
        for <git@vger.kernel.org>; Wed, 27 Dec 2017 20:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zbWZPTiZ0LmzKiC8HQIUejF7Rp1fD6Y1I/8gRn3k+mI=;
        b=LdbNWAat3B9kesMcZOYLGW3pZNXxCWlkmEKoNenEsbA61JLJaUaD2gJ4VTJS/PVYsa
         pXwC8DqeGM/I5OAd5x4GQe6eKoWSafn+agqmGapUEpQc1kFZEslFpUKQUJuk4Ud5OxsI
         sxoVAMMcsItLeyYwlylhq8TIlSilqJM4e7b9S3tg1ZOdZVC4fFn/DXbFwoNGeR37r80D
         X92FUf06WoWdMg0Ch1QVQLH5g2W8sJ394sA/OJspjMqdW/I23WkBoNzeWg/20Tp/1DYQ
         B1q0Auy6Y9ceckB0YQsXcedXICysQRks3o5pYV0iA/YSJ1KUpdQRvn9vKEyamcVh/eWk
         SRig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zbWZPTiZ0LmzKiC8HQIUejF7Rp1fD6Y1I/8gRn3k+mI=;
        b=E9X3ZBs7C6MToiHDvQJLWw+BnwQhCL/h8z83taS+ZmoGM8fSaJa2jBSFFBPQ06ErkN
         RiKkqZMPb0o5/krojS0DtdjTnembWUgSMxozBijguJvJn7c8Gmhi2AYCuMzmHQWlK+FZ
         6LFsIjhShoFQqMexEjDzsBuGoacrYPCtgppiAGdLjPxeDdJ02669PdA/KsRXYSOfrjdq
         jE9RiBz4D0ENX6Hpp9KxxchMa6FuJ86WhLzk8zFu42Ff46lozg1NUJyW1j/Ymkqxm+b3
         hYmVemKvcGZxy3KVlZUEyBPGEJmYXsiMCrMf4JpAasIHyIV2BZpSJlPQgq78xAWUCE2d
         YyKg==
X-Gm-Message-State: AKGB3mJpU7UVeuz1FdSoaYRrnwOe6Ad4c5+6xMhZvY/Hf9DP7Hci/UqU
        +yoKDkFsN7I+SNhPBIjh9JSWSg==
X-Google-Smtp-Source: ACJfBotcB0OG3K/xCOQ9xRLy65cgNRjSlk7p9yv8J1IZa/y39LcXJSYPYqmdHQxJIEbsz7xKzKihQw==
X-Received: by 10.107.175.144 with SMTP id p16mr32461511ioo.199.1514434459917;
        Wed, 27 Dec 2017 20:14:19 -0800 (PST)
Received: from localhost.localdomain (170-72-6-219.ut.vivintwireless.net. [170.72.6.219])
        by smtp.gmail.com with ESMTPSA id f207sm11201841ita.26.2017.12.27.20.14.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Dec 2017 20:14:19 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH v5 19/34] merge-recursive: split out code for determining diff_filepairs
Date:   Wed, 27 Dec 2017 20:13:37 -0800
Message-Id: <20171228041352.27880-20-newren@gmail.com>
X-Mailer: git-send-email 2.15.0.408.g8e199d483
In-Reply-To: <20171228041352.27880-1-newren@gmail.com>
References: <20171228041352.27880-1-newren@gmail.com>
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
2.15.0.408.g8e199d483

