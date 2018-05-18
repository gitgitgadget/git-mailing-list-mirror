Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C26BE1F51C
	for <e@80x24.org>; Fri, 18 May 2018 21:24:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751705AbeERVYJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 May 2018 17:24:09 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:43542 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751542AbeERVYI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 May 2018 17:24:08 -0400
Received: by mail-wr0-f193.google.com with SMTP id v15-v6so10478324wrm.10
        for <git@vger.kernel.org>; Fri, 18 May 2018 14:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qqi8Aq7BlmtnzELuHHU4aif5MEFPYydVE4igRqz+n0s=;
        b=dEOXNjGZbCYG9VdNU4QfrnLLwb+3xZULL1o/EOmB610B/opyzu71l140KonZU+TNy4
         cdYZFwCXXx9PiMI+ps+ZTQ3HMrxPIrd4ZnFA/AnXNxF+68abti+G9L5gL2B4HF6VIbXd
         VcnjZw2gqB/eQ8mQEpu8IRmz/QwpON5stWgAQq/XiWD9nyFZJNWS2MASVPgtSIrDM/UY
         mzBYxFEpXy+GKbHirI3dzg0bxM3Yew2ojGqKyKzgwy/JASiruzW0C/8ml3KKD9eJ5ln7
         Tp7n7+65vLYNBbqq6qnrL8iqtJzIMC6xsgJQPiMK3t0fFUMQjjpxKyVDTk2Lm1pk+G1Y
         nUXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qqi8Aq7BlmtnzELuHHU4aif5MEFPYydVE4igRqz+n0s=;
        b=agMUnE8Tlkr+5WqXECM2pT38jKzf+zj0j+J7E68iqgTdulPi4BJa9iAKccLoP6dUnD
         Fb621D8zfv4y2v1sgoFg/J7TZ9Qx+mBLcQOQmCq8pK3hT431mLNJWHMP9sH6fWuQmXr7
         uL2toFzLobH09jcVlfkwdWNcDZJKTLfSeHz34e2nkDMn8SUIviPGBrgKFIsJ5/ZYefR6
         YzAxzVfa2N609PJKMg/9VJHY47D+4VZ0Q0zPvEf3kTluvxf4PDXJbx97XHyBn6NKCNK9
         XBtxW16Uclema5rwA9OFKYIcAFIOsFVRhTO52g/HaboK6uy6Jpn2VVvMsvkATTmmrjKR
         nmoA==
X-Gm-Message-State: ALKqPwckAjQz6xEZykYDVu++wi16JVBccBPpWNFP+lfMo/b7EtzWs2wk
        yVwoU1uWVJSZE7q0ethmrXdR48CDFgo=
X-Google-Smtp-Source: AB8JxZqTe+7pqWJSwx7bXNEVj/X/VxE9vQWJEBBrkQD4iik7YC99OPyvs9U0NysG1w82896vRqbdYg==
X-Received: by 2002:adf:9b1a:: with SMTP id b26-v6mr9218213wrc.206.1526678646645;
        Fri, 18 May 2018 14:24:06 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id u35-v6sm10969192wrc.29.2018.05.18.14.24.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 18 May 2018 14:24:05 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 1/3] merge: setup `opts` later in `checkout_fast_forward()`
Date:   Fri, 18 May 2018 23:23:25 +0200
Message-Id: <27965d978f203c5b55ce19fa03fb3e183d442c70.1526677881.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.17.0.840.g5d83f92caf
In-Reply-To: <cover.1526677881.git.martin.agren@gmail.com>
References: <CAN0heSo80SjjGtC2x9s-TmNY0=W=YWTYxyjeuAQ3utEAEynXeA@mail.gmail.com> <cover.1526677881.git.martin.agren@gmail.com>
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
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 merge.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/merge.c b/merge.c
index f06a4773d4..f123658e58 100644
--- a/merge.c
+++ b/merge.c
@@ -94,8 +94,24 @@ int checkout_fast_forward(const struct object_id *head,
 		return -1;
 
 	memset(&trees, 0, sizeof(trees));
-	memset(&opts, 0, sizeof(opts));
 	memset(&t, 0, sizeof(t));
+
+	trees[nr_trees] = parse_tree_indirect(head);
+	if (!trees[nr_trees++]) {
+		rollback_lock_file(&lock_file);
+		return -1;
+	}
+	trees[nr_trees] = parse_tree_indirect(remote);
+	if (!trees[nr_trees++]) {
+		rollback_lock_file(&lock_file);
+		return -1;
+	}
+	for (i = 0; i < nr_trees; i++) {
+		parse_tree(trees[i]);
+		init_tree_desc(t+i, trees[i]->buffer, trees[i]->size);
+	}
+
+	memset(&opts, 0, sizeof(opts));
 	if (overwrite_ignore) {
 		memset(&dir, 0, sizeof(dir));
 		dir.flags |= DIR_SHOW_IGNORED;
@@ -112,20 +128,6 @@ int checkout_fast_forward(const struct object_id *head,
 	opts.fn = twoway_merge;
 	setup_unpack_trees_porcelain(&opts, "merge");
 
-	trees[nr_trees] = parse_tree_indirect(head);
-	if (!trees[nr_trees++]) {
-		rollback_lock_file(&lock_file);
-		return -1;
-	}
-	trees[nr_trees] = parse_tree_indirect(remote);
-	if (!trees[nr_trees++]) {
-		rollback_lock_file(&lock_file);
-		return -1;
-	}
-	for (i = 0; i < nr_trees; i++) {
-		parse_tree(trees[i]);
-		init_tree_desc(t+i, trees[i]->buffer, trees[i]->size);
-	}
 	if (unpack_trees(nr_trees, t, &opts)) {
 		rollback_lock_file(&lock_file);
 		return -1;
-- 
2.17.0.840.g5d83f92caf

