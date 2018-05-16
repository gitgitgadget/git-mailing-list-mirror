Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 999A51F406
	for <e@80x24.org>; Wed, 16 May 2018 16:31:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751642AbeEPQbx (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 May 2018 12:31:53 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:37888 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750980AbeEPQbw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 May 2018 12:31:52 -0400
Received: by mail-wr0-f193.google.com with SMTP id 94-v6so2100990wrf.5
        for <git@vger.kernel.org>; Wed, 16 May 2018 09:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gGCXVG/Lc2FYNhF7lWHDcCAr+e5ehB036uXe/IfmAA0=;
        b=X7iU7fWzj9XYz3T/9vTvhDyI7VAMFd7IMlj3W4YP/zorcVL8eYrr1EF0nnU1qKmWRc
         6iYSfcIBivdW4WqV/1vXm1BFfPNdVSomRVyQ0mEfqCPiOWfsI6NAT5H9QI+msDssDP4Q
         ux1AzcWUo3KB3NX9HhxcglsLNEGfipvC4CaZ6aNuMHDroX3rZrw5B+6Bfexec/kpO46K
         2YtL2Zz2CTHVh4ig+atWi+s6gvPRul8Dr5DlO+HuzJnv6dPC/Kf2aCU5eAd5ZvqS6Kqu
         Ig4HiOQDSMi3nGg+ikzhNpCVKTIvjM59iVp4bYJY1MwhCBlM7UUWUy80ER0EMKIHnPQM
         obqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gGCXVG/Lc2FYNhF7lWHDcCAr+e5ehB036uXe/IfmAA0=;
        b=HB6aFa6MMYZ6SUFnU/0YQJOGSRK+LNHO9IrQCNf/0nnxE3ZcUwOuVgcwU7DEMMdf1v
         m3WH+HFYdsOpq8gugN3banA1S/uwRLUngHC9QCO4VWWxN8fa2u5UfWOVpLWmR/0jyFGV
         miIPNvtIVLX4dCgNlgsSoBPDwu63mz4QWoLepPzR+vbdRMTQcReh3utFVilIzUy7mtZf
         isKIY2XTRfPNrcuTtffF9HIoU2ldLI4w/CDvZsr3GVQg873xHQhcBCL4iTssP9DS5Ox+
         MzO6YhFxbYSCTeanKGimlovfSY55kl9IvWCsJ2WKJWQWKi+l1PotnrdEVmp4Y0NHdZW6
         CCDw==
X-Gm-Message-State: ALKqPwedegxrPQrs8W12QznQNawehGwe51WHVx0uNxd7JKbE7CpGN4yF
        OoGlsTcJBC54k5lmOH7k378=
X-Google-Smtp-Source: AB8JxZqkjzvTaHVLaXVpRCiqE9QxqlcFKCsgYkD2cw1LdgIUbvl9cbPZIo96WoTmjEX/lHcLbKLpjQ==
X-Received: by 2002:adf:e447:: with SMTP id t7-v6mr1410632wrm.143.1526488311045;
        Wed, 16 May 2018 09:31:51 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id s14-v6sm3931772wmb.5.2018.05.16.09.31.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 16 May 2018 09:31:50 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org, Ben Peart <Ben.Peart@microsoft.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2 1/3] merge: setup `opts` later in `checkout_fast_forward()`
Date:   Wed, 16 May 2018 18:30:58 +0200
Message-Id: <0b7440f21e9ff7a066802fe1e7cb3078cf4ed2b8.1526488122.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.17.0.583.g9a75a153ac
In-Reply-To: <cover.1526488122.git.martin.agren@gmail.com>
References: <CABPp-BHm4B5vXZGHn_i6Aycvc_PDNWSFxLFo9s-ijb511VY9RA@mail.gmail.com> <cover.1526488122.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After we initialize the various fields in `opts` but before we actually
use them, we might return early. Move the initialization further down,
to immediately before we use `opts`.

This limits the scope of `opts` and will help a later commit fix a
memory leak without having to worry about those early returns.

This patch is best viewed using something like this (note the tab!):
--color-moved --anchored="	trees[nr_trees] = parse_tree_indirect"

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 merge.c | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/merge.c b/merge.c
index f06a4773d4..f123658e58 100644
--- a/merge.c
+++ b/merge.c
@@ -94,23 +94,7 @@ int checkout_fast_forward(const struct object_id *head,
 		return -1;
 
 	memset(&trees, 0, sizeof(trees));
-	memset(&opts, 0, sizeof(opts));
 	memset(&t, 0, sizeof(t));
-	if (overwrite_ignore) {
-		memset(&dir, 0, sizeof(dir));
-		dir.flags |= DIR_SHOW_IGNORED;
-		setup_standard_excludes(&dir);
-		opts.dir = &dir;
-	}
-
-	opts.head_idx = 1;
-	opts.src_index = &the_index;
-	opts.dst_index = &the_index;
-	opts.update = 1;
-	opts.verbose_update = 1;
-	opts.merge = 1;
-	opts.fn = twoway_merge;
-	setup_unpack_trees_porcelain(&opts, "merge");
 
 	trees[nr_trees] = parse_tree_indirect(head);
 	if (!trees[nr_trees++]) {
@@ -126,6 +110,24 @@ int checkout_fast_forward(const struct object_id *head,
 		parse_tree(trees[i]);
 		init_tree_desc(t+i, trees[i]->buffer, trees[i]->size);
 	}
+
+	memset(&opts, 0, sizeof(opts));
+	if (overwrite_ignore) {
+		memset(&dir, 0, sizeof(dir));
+		dir.flags |= DIR_SHOW_IGNORED;
+		setup_standard_excludes(&dir);
+		opts.dir = &dir;
+	}
+
+	opts.head_idx = 1;
+	opts.src_index = &the_index;
+	opts.dst_index = &the_index;
+	opts.update = 1;
+	opts.verbose_update = 1;
+	opts.merge = 1;
+	opts.fn = twoway_merge;
+	setup_unpack_trees_porcelain(&opts, "merge");
+
 	if (unpack_trees(nr_trees, t, &opts)) {
 		rollback_lock_file(&lock_file);
 		return -1;
-- 
2.17.0.583.g9a75a153ac

