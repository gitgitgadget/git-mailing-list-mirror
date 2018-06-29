Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 585841F516
	for <e@80x24.org>; Fri, 29 Jun 2018 00:20:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030281AbeF2AUZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 20:20:25 -0400
Received: from mail-vk0-f73.google.com ([209.85.213.73]:40006 "EHLO
        mail-vk0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030243AbeF2AUY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 20:20:24 -0400
Received: by mail-vk0-f73.google.com with SMTP id y200-v6so2752097vky.7
        for <git@vger.kernel.org>; Thu, 28 Jun 2018 17:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=pYCVJqBA/AuMLx2Z7JUE+3SWT/5IfXgSglXZD5OBS48=;
        b=BkABnFAbCnUkhRw22NvT854Zz4ja6XUcaRNhfjPTI/mw8/TTpF64ncDsJwsZJhQlpI
         3RQmlen+hEzW8IvLg82dmNN+yfaz2kcHToYmibLd5rLjdBqbAlkE4dgxritxQyUDUqOj
         EGI+C6X6cRTY2WY11GqUUofnP4A20Faa9gKT8UeQa03ZIpp/U4TVbxIZ1mDGLN2u9XTq
         jRec1qtswV9T0D0y9X5XAjG5CqeKRVuaXh6nTQRFd9pzDe8okyJGx1VxGrkA2eZpS/ax
         jqGJKL6U2328HJjqt/qz4ZLBkIzzDZQd3w8r1DNGuhMOKVjI0RPF/kvfKiveH7a+X9NL
         OpOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=pYCVJqBA/AuMLx2Z7JUE+3SWT/5IfXgSglXZD5OBS48=;
        b=YU/YgQSqZsKBLEoNBLj2rtkrd28fOi0NzbOnVQ3YSy2y5BW3ZHSy3Logd/xnr/anBx
         kBNZ6NCkw6krPZMTSy28qPL90pfjSAfxWXByT69O1ZqO7Il7HV8Mxq9FRhhAVcJnejWv
         MHFX67hx1h50oT4Gq2gNXZQpk39AfC4pn2DmOkm2NhRvMru/BAXLCKgV9jZg5ir1t5qw
         WAKPfcQZE38EvkTu/+JDpmko0cwiBJife9xGIjpqGfWuHD7Gn71nikwlvdVcE2FN+8ru
         sRx+5RXcrry2omcTn81EIb+G1wEKMHJwseh+yC1ve9tuzT7ExwPpTT5QCaMQ1Z9IYmPy
         fhnw==
X-Gm-Message-State: APt69E3TM7y6kzpV09+6ThA6gX/+SiQp9XkyHn2wjWrlFuSWP+8Rvtln
        e588/gczFeUKwNvx5CdJ4oSoPO7Eczad
X-Google-Smtp-Source: AAOMgpdlb9vE80QxlXjR6UB1khujgWAZey34TNwyCm/aHB4flmh0vNWDPmsdV0W3aYfYL18DxJpVsUHr+ZJ7
MIME-Version: 1.0
X-Received: by 2002:a1f:e106:: with SMTP id y6-v6mr5332777vkg.30.1530231623341;
 Thu, 28 Jun 2018 17:20:23 -0700 (PDT)
Date:   Thu, 28 Jun 2018 17:19:54 -0700
In-Reply-To: <20180629001958.85143-1-sbeller@google.com>
Message-Id: <20180629001958.85143-6-sbeller@google.com>
References: <20180622015725.219575-1-sbeller@google.com> <20180629001958.85143-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.399.gad0ab374a1-goog
Subject: [PATCH v4 5/9] diff.c: adjust hash function signature to match
 hashmap expectation
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, jacob.keller@gmail.com,
        jonathantanmy@google.com, simon@ruderich.org, bmwill@google.com,
        Junio C Hamano <gitster@pobox.com>
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
2.18.0.399.gad0ab374a1-goog

