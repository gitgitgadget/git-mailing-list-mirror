Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF4652027C
	for <e@80x24.org>; Tue, 30 May 2017 17:32:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751272AbdE3RcJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 May 2017 13:32:09 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:34724 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750995AbdE3RcB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2017 13:32:01 -0400
Received: by mail-pf0-f180.google.com with SMTP id 9so78332453pfj.1
        for <git@vger.kernel.org>; Tue, 30 May 2017 10:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nmztLdTELGhC1h/KILIxOimYwcBkK6UqXxgPTt7oinE=;
        b=bVTDOswhZ4GGnYL1puzNGum+nZAeH5p74JFKcKxuSa6ynNNp7553Oh6+dWg+kPHIyw
         DE849pqw+55teshMBS460cAKZSWF3T2tIDjEs/AFY4VR+H3mJe+31tYmw2ckoj8SENdf
         ngja14VgAbZTrxPUChpPoBooMPz7lUgAyu5NT1w6p8rQ+ZUQAfkM/4IcNBoppmx+dOrL
         /1tyiGG5XaoOmvL6Bcnnfi/p1nru/j+jdxjuZ0znTC5loxH8N0uAJQxAQy7FEgYE3bCd
         D+sIv5S2kghBjHnC8r3WkyxWE+x5xdAVV6K1pjnctJhtKrKDPIjLbmPyYaSXMicY36co
         FiDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nmztLdTELGhC1h/KILIxOimYwcBkK6UqXxgPTt7oinE=;
        b=la9r1ounbw2K6RiJcT0hGbbsCFcC+eM5Xjh1rtZd8UyGu/1jhVWI2dqQnqpaP9PANg
         CDAVXBmnmRAkqW6Dy6k/GzXLIzHMPoLHcYOZEVfeSfQcwrFJ8Xcxic91WdA1Y3VSxhmb
         LZDP3WsCubTxZC/BRMNQuNOGaU2BaXLvnbTC/7z2juL7m+03hjFSGHk+4pGNzyYUYeup
         Rim80Bvf+zstYG5wXj7XRlcFpl1ftvGEsU/5oBuZBqGVpp73uO0PsDiEySdp4DyEkF0w
         tG8EOYNoQEbcXdOphFpj68/Hkit3LN7tppCBwL9NC/mH67eogx3JFgv6x7V4tbNu/S23
         x6zQ==
X-Gm-Message-State: AODbwcD0kXhgc4MqXFChPCJb4GorCAV5P+DNGqIDhZk+PB4Lh8ua+6SU
        dKtpBSSWu+Zlqu/NS7FbUw==
X-Received: by 10.99.145.65 with SMTP id l62mr26152770pge.106.1496165520468;
        Tue, 30 May 2017 10:32:00 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id t19sm24940187pfg.31.2017.05.30.10.31.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 30 May 2017 10:31:59 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, sandals@crustytoothpaste.net,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH 29/33] tree-diff: convert try_to_follow_renames to struct object_id
Date:   Tue, 30 May 2017 10:31:05 -0700
Message-Id: <20170530173109.54904-30-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.219.gdb65acc882-goog
In-Reply-To: <20170530173109.54904-1-bmwill@google.com>
References: <20170530173109.54904-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Signed-off-by: Brandon Williams <bmwill@google.com>
---
 tree-diff.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tree-diff.c b/tree-diff.c
index fc020d76d..29e3f6144 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -577,7 +577,9 @@ static inline int diff_might_be_rename(void)
 		!DIFF_FILE_VALID(diff_queued_diff.queue[0]->one);
 }
 
-static void try_to_follow_renames(const unsigned char *old, const unsigned char *new, struct strbuf *base, struct diff_options *opt)
+static void try_to_follow_renames(const struct object_id *old_oid,
+				  const struct object_id *new_oid,
+				  struct strbuf *base, struct diff_options *opt)
 {
 	struct diff_options diff_opts;
 	struct diff_queue_struct *q = &diff_queued_diff;
@@ -615,7 +617,7 @@ static void try_to_follow_renames(const unsigned char *old, const unsigned char
 	diff_opts.break_opt = opt->break_opt;
 	diff_opts.rename_score = opt->rename_score;
 	diff_setup_done(&diff_opts);
-	ll_diff_tree_sha1(old, new, base, &diff_opts);
+	ll_diff_tree_sha1(old_oid->hash, new_oid->hash, base, &diff_opts);
 	diffcore_std(&diff_opts);
 	clear_pathspec(&diff_opts.pathspec);
 
@@ -706,7 +708,7 @@ int diff_tree_oid(const struct object_id *old_oid,
 
 	retval = ll_diff_tree_sha1(old_oid->hash, new_oid->hash, &base, opt);
 	if (!*base_str && DIFF_OPT_TST(opt, FOLLOW_RENAMES) && diff_might_be_rename())
-		try_to_follow_renames(old_oid->hash, new_oid->hash, &base, opt);
+		try_to_follow_renames(old_oid, new_oid, &base, opt);
 
 	strbuf_release(&base);
 
-- 
2.13.0.219.gdb65acc882-goog

