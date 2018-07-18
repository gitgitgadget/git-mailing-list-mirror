Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38E461F597
	for <e@80x24.org>; Wed, 18 Jul 2018 19:32:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730433AbeGRULg (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 16:11:36 -0400
Received: from mail-io0-f201.google.com ([209.85.223.201]:37868 "EHLO
        mail-io0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728671AbeGRULg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 16:11:36 -0400
Received: by mail-io0-f201.google.com with SMTP id l5-v6so4167511ioh.4
        for <git@vger.kernel.org>; Wed, 18 Jul 2018 12:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=obBNKpjWCwyHoEelGiwCgYajrllMvaEh+Ws2tD1lkjg=;
        b=sOmLlelaZPIjJ2sMRThcDM8neE0JiflvWqVY0B70xqvWpM7aUV2LQtoCQzxMvh5E3M
         ztmvRcfM9PpJtDAalUk35C5GT/UUp6eiBl+Qsii/QpcI0bMxJ3IgOCDxSPdbsMKAu5KN
         uC0pYYaAoQXcNRmHqyQJYKtpFYzxXpXopyI9Bkfc0d8tEG9hQHj/swcRPzWYFSA+KhsU
         LdBbDR9Ur3TZ2VvSE68JQIe0J5tvW4j5g9kEJoJ2RlajjwZfPay9tnSTT9R6f35CCe1A
         OyjshcVkmHt/T6dUbkBeE8FLS4pWFOzyn4MMWck02y8GCilbqm+s7xUkMR9xDIz5TcNc
         LgCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=obBNKpjWCwyHoEelGiwCgYajrllMvaEh+Ws2tD1lkjg=;
        b=FvMtAoIHMAYT8scYLTpAVD4SwGbQTrvtegOFyYlHQRvHEkK9HJtXu0o7YJ9jP46rW6
         jXIite9G2XNdlfBpnMpQ3HG8erDY6Chw2PDr3JBbk4lQ9rm+lZIK1q1AyMPzSUBYVsQ7
         7obdJvjst6QUk6NduCO65c60IRBSJyjPtWdhVl/qIz2ZnNLiMYGSkCWSP6fYZ2wadzSF
         o1byE+6j7sP9EevjG+pgsXE4K3/G+ZIeTKYMXAt5kYVlqiVUwwPcjJy15iYY1xgXIgc9
         oo6Vz6T2bw8QFtGLhjO2aFHdec1O+NM7rCCKHxKXoasKc015ihWHobVjMeO+mJOzAcYg
         Arjw==
X-Gm-Message-State: AOUpUlG9RIgCIOGROeelLYk7h/bMaYNr8QwTYcZYsc83EvXHkdvihlRw
        qimwgqFppHBs3OUv0WyrzqS4W5+NPaAFhraJ38rhDc3rDaj5I8WX02ARB0nH+Te3zXugMI4pKXe
        tWDqQXKgqV+zJng9MDK3Xyg8pMp9ZDM5hz207pkwvwybaWTk93LKkQUiwtxG+
X-Google-Smtp-Source: AAOMgpdsS56A/0YUvcYhi68JW/PrR1cc49eBbLrSfpBDkDkCttZSaPfTQTDjQ4WmRRu3Wo37BoOOHEq/Fg27
MIME-Version: 1.0
X-Received: by 2002:a24:68c6:: with SMTP id v189-v6mr902389itb.11.1531942335697;
 Wed, 18 Jul 2018 12:32:15 -0700 (PDT)
Date:   Wed, 18 Jul 2018 12:31:51 -0700
In-Reply-To: <20180718193156.47365-1-sbeller@google.com>
Message-Id: <20180718193156.47365-6-sbeller@google.com>
References: <20180718193156.47365-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
Subject: [PATCH 05/10] diff.c: adjust hash function signature to match hashmap expectation
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, rybak.a.v@gmail.com,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This makes the follow up patch easier.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/diff.c b/diff.c
index ce7bedc1b92..d1bae900cdc 100644
--- a/diff.c
+++ b/diff.c
@@ -707,11 +707,15 @@ struct moved_entry {
 	struct moved_entry *next_line;
 };
 
-static int moved_entry_cmp(const struct diff_options *diffopt,
-			   const struct moved_entry *a,
-			   const struct moved_entry *b,
+static int moved_entry_cmp(const void *hashmap_cmp_fn_data,
+			   const void *entry,
+			   const void *entry_or_key,
 			   const void *keydata)
 {
+	const struct diff_options *diffopt = hashmap_cmp_fn_data;
+	const struct moved_entry *a = entry;
+	const struct moved_entry *b = entry_or_key;
+
 	return !xdiff_compare_lines(a->es->line, a->es->len,
 				    b->es->line, b->es->len,
 				    diffopt->xdl_opts);
@@ -5534,10 +5538,8 @@ static void diff_flush_patch_all_file_pairs(struct diff_options *o)
 		if (o->color_moved) {
 			struct hashmap add_lines, del_lines;
 
-			hashmap_init(&del_lines,
-				     (hashmap_cmp_fn)moved_entry_cmp, o, 0);
-			hashmap_init(&add_lines,
-				     (hashmap_cmp_fn)moved_entry_cmp, o, 0);
+			hashmap_init(&del_lines, moved_entry_cmp, o, 0);
+			hashmap_init(&add_lines, moved_entry_cmp, o, 0);
 
 			add_lines_to_move_detection(o, &add_lines, &del_lines);
 			mark_color_as_moved(o, &add_lines, &del_lines);
-- 
2.18.0.233.g985f88cf7e-goog

