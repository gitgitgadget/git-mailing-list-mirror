Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F08D200B9
	for <e@80x24.org>; Mon, 21 May 2018 14:55:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752712AbeEUOzE (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 May 2018 10:55:04 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:44163 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751682AbeEUOzD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 May 2018 10:55:03 -0400
Received: by mail-wr0-f195.google.com with SMTP id y15-v6so16298775wrg.11
        for <git@vger.kernel.org>; Mon, 21 May 2018 07:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qqi8Aq7BlmtnzELuHHU4aif5MEFPYydVE4igRqz+n0s=;
        b=oh/SeRjy9XqsPNJ7aGC1i7zD+2rSJeS+tEe59CSSD683F26vt14JnjsRHGete4MOux
         NjSbTcJacjvpAXrBsSMhp5Vx9dd+s2nHF3Bc9z+zWXSQhgP5K10a5pmto77QbOqJXtf+
         jV8CkZFqhdnlRYy2iu0BiualJi1dpfq0on+zQ25fhKILMiybmUuI+75HAZI81HOMlOaV
         UnutwZu70pup9+vHQZ3URFYdgUOjEqE/YxDrMFlA+NkMd1btbWAftSw+RXhZV40C+/hA
         B7F4DEGinkCAVkN5iokr6CcGsSObuD3frgI6zweDCb8k/YZgSU6H7yOYnXPhf58VqqBj
         2x4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qqi8Aq7BlmtnzELuHHU4aif5MEFPYydVE4igRqz+n0s=;
        b=C49NSZbcSmjVAd/XKv7P3r9FdAFEFgtFmsh/FV3+zp6nmHjVXNsfUPxnrQgelXVg4G
         bjOy1XH6vmjOaC1X4MNaVXYUefCY9Qwux1i/KMMsEvEo0GK201OWUG4hOe7nq7dvh7MG
         +FC3qXpClTjU/EjE4wgd/RscmGqATGG64wDu6Hhf23dpNDvq7ccEFBdgM/SJ77LhIaEk
         xwAI0bC5Ysn+6dqB3oAk7iI8/D79jiAVY+I6swFZbaDO6S6pl84jK6fpqIG7G50CQRL+
         GsapkewL7xfv3Sl8ahRSWLbRhYb8tEzydHfJXvuDspXR4KlufSrHzIYK0B0JjgbemVIS
         8eCg==
X-Gm-Message-State: ALKqPweqYaEon94+nw3D27jf2ENqIU8M+egzra6NqLcguZSpRO/MdHMb
        vVHlkN+b7ZpieQ+JWn9Pp/0=
X-Google-Smtp-Source: AB8JxZpZZpiWIMJMNH0dlQC5uIAVfoAb2IOBYkR2r89WiHmtpkSVQQlLBpnOyeN3gUuMlHe9d7dF7A==
X-Received: by 2002:adf:ea84:: with SMTP id s4-v6mr4032434wrm.223.1526914501951;
        Mon, 21 May 2018 07:55:01 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id b10-v6sm37627460wrn.42.2018.05.21.07.55.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 21 May 2018 07:55:00 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jacob Keller <jacob.keller@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v5 1/4] merge: setup `opts` later in `checkout_fast_forward()`
Date:   Mon, 21 May 2018 16:54:25 +0200
Message-Id: <89e653da5b1bee9cf645e9d4bdd95f6bb31cc4b9.1526913784.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.17.0.840.g5d83f92caf
In-Reply-To: <cover.1526913784.git.martin.agren@gmail.com>
References: <xmqqr2m53leq.fsf@gitster-ct.c.googlers.com> <cover.1526913784.git.martin.agren@gmail.com>
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

