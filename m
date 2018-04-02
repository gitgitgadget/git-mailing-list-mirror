Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6EE611F404
	for <e@80x24.org>; Mon,  2 Apr 2018 22:49:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754762AbeDBWt0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Apr 2018 18:49:26 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:39061 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754749AbeDBWtL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Apr 2018 18:49:11 -0400
Received: by mail-pl0-f66.google.com with SMTP id s24-v6so6123669plq.6
        for <git@vger.kernel.org>; Mon, 02 Apr 2018 15:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YfAOCTc3BOUmVBuzA31/WTWu613ifK/MZi6XtgCNeoU=;
        b=vNE74fjY6+wGPwdT8AHA3FMqP774d8Zy3LvZ2HYgkU09VmM7J9y55mrYqoGbeQ+prK
         9PkJUzbAZZTYEA+K60NRrGO+PSMOEi8Y4QS/kj3/N3cVwTfocXOuz36KdbBRMmDs7H0N
         bzgk9xAS1ciBXNCMBMQSLjtwWo95GtRHY7RzffPTZ/AUlLyxjvfsfcI5t6uvtKuZ9qLq
         Ma23xtLuL/Zplh7Yo3eySIQhKPN9V+kyfW2Gt6Dvss0lKgkpQFaaQsSJISkjWv0NF4JA
         z62kTj+HcdnFHHUVqu5Ypt7S0W2T0Fb51r0ULpe1vF8ql4IMzwJYwWmrK1kcxIWa98Tw
         w4Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YfAOCTc3BOUmVBuzA31/WTWu613ifK/MZi6XtgCNeoU=;
        b=gM3+58kHqMrL+M1kwmIsu+kc2iBitbmQ++7grgG6WATzesWvdn4dTfL2US6VCk5zoT
         QGwCYnc5u8aLHy+tw23V+m0njDKFC9ej7T3rXcQjPLcd2ba4oayABGDVsj/YbeAjb9Pz
         JfoYhfMjA8AnGUPYE0J9wElOFHJkWZIxiuVnal2Jy2GMKNW6GeUtMQX1/QOCVMNzOIhL
         Bj7N/wIcCsQvIb2s+g+hLnTiecnvaBIeYFj89rxmu/Y0SZ6V0OPrvV6eeo8QtIP8Oeln
         QZNx0w0MJBP5YBJ+uKHcgoO007SrSf62ukoEmFdd0Q2mNqeLGJJzPz3RXJwyMCfOrX9O
         cUAw==
X-Gm-Message-State: AElRT7HnCU8DEof0lolBkbJpwJBC46fTZBNjiGmB0TsA/DrQzd3XOOTT
        st4/BFj5c+v+SXcaJL3Hpn4EQg==
X-Google-Smtp-Source: AIpwx4/XA1Xy/5D/1dBXIeFCIOwqWPQWibmvXD17xqoB3gTBO4DGyMjKxwD1oz0mqGq7Iaq1VayKuA==
X-Received: by 2002:a17:902:900a:: with SMTP id a10-v6mr11849927plp.142.1522709350665;
        Mon, 02 Apr 2018 15:49:10 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id p86sm2437680pfi.55.2018.04.02.15.49.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Apr 2018 15:49:10 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     jonathantanmy@google.com, jacob.keller@gmail.com,
        simon@ruderich.org
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 4/7] diff.c: adjust hash function signature to match hashmap expectation
Date:   Mon,  2 Apr 2018 15:48:51 -0700
Message-Id: <20180402224854.86922-5-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
In-Reply-To: <20180402224854.86922-1-sbeller@google.com>
References: <20180402224854.86922-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This makes the follow up patch easier.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/diff.c b/diff.c
index 52f6e02130..879b8a5d9d 100644
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
2.17.0.484.g0c8726318c-goog

