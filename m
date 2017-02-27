Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A5101F5FB
	for <e@80x24.org>; Mon, 27 Feb 2017 18:11:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751565AbdB0SL1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Feb 2017 13:11:27 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36450 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751473AbdB0SLQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2017 13:11:16 -0500
Received: by mail-wm0-f67.google.com with SMTP id r18so14674578wmd.3
        for <git@vger.kernel.org>; Mon, 27 Feb 2017 10:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IU23EE7IyLUY9ETBuNJo8/+Ai4xprNR3uymLoVyTZdo=;
        b=qpOB1SS4UIkoxR0vvWsrCGZ/HVXQ5SSJHBBgw7ufUQ+mbcRQyPYrU8SdJlT9R5/38c
         /lmJ1aAPF9+hnmRSNYWTx8ewXjEwj6yOUkRrMYyij979xQK8iYWkBBulYNh+BDO5GFyA
         36lA7tDoLiPDOydg4oUt0uaboPgys417w1BQIaij9UL9g3+GiOaJw1QTEG1p+jDNTgRl
         Qd3NcmvoTNMj3zPYRR83ycVA6Ir8tk8CZKvXFi+ZX2kcqC7QNlHpYUgYA6tl+4EJizBo
         Z/kqVdA8HLoN9TQJYpLq3kT7fKiAy5g0t9pTY6eOla9skJ/XMC3gCrrpan57wv87cGSH
         nUYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IU23EE7IyLUY9ETBuNJo8/+Ai4xprNR3uymLoVyTZdo=;
        b=BsurAUNBcuGxYBL2LRVIfhXGyCRF8AHf9HzRz2kDFPVG40WElQO/6+dhPCNxw5AU36
         kmDmfqHaax9hyvAf4a0JYZkMc8/dgc0ARPXwJ+soLyp19SAB6dxjpFdpDEiWSS8jjPpx
         2kEsjsxrCaFGYWwgPlxtgSKae8SqFZAF8goGGhivqx7tkRpC50dZrf4DWMOtPoDoFiBQ
         7gZw6NF62TdLbZCAq3hhiO4O8BmFM04wf4+fyNLbcyXW6AobUkudN2p9V0pZ2cjC47md
         CggnI6ur9CiqytewX9ccJie0XcPtFvBQkJqfIT8nNjQPqYfevd5ao4Rn9cmxi4XOGyFN
         +Erw==
X-Gm-Message-State: AMke39kFdhbgwo+xcPaHJgpg3xNTj0TSNBpf3hYEMsum0PaxhSeg7WonwTFwgwg3GNXW0w==
X-Received: by 10.28.191.194 with SMTP id o63mr4000982wmi.101.1488218463084;
        Mon, 27 Feb 2017 10:01:03 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id e73sm15226798wmi.32.2017.02.27.10.01.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 Feb 2017 10:01:02 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 19/22] read-cache: refactor read_index_from()
Date:   Mon, 27 Feb 2017 19:00:16 +0100
Message-Id: <20170227180019.18666-20-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.12.0.22.g0672473d40
In-Reply-To: <20170227180019.18666-1-chriscool@tuxfamily.org>
References: <20170227180019.18666-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It looks better and is simpler to review when we don't compute
the same things many times in the function.

It will also help make the following commit simpler.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 read-cache.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 45fc831010..3ea20701a3 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1691,6 +1691,8 @@ int read_index_from(struct index_state *istate, const char *path)
 {
 	struct split_index *split_index;
 	int ret;
+	char *base_sha1_hex;
+	const char *base_path;
 
 	/* istate->initialized covers both .git/index and .git/sharedindex.xxx */
 	if (istate->initialized)
@@ -1708,15 +1710,15 @@ int read_index_from(struct index_state *istate, const char *path)
 		discard_index(split_index->base);
 	else
 		split_index->base = xcalloc(1, sizeof(*split_index->base));
-	ret = do_read_index(split_index->base,
-			    git_path("sharedindex.%s",
-				     sha1_to_hex(split_index->base_sha1)), 1);
+
+	base_sha1_hex = sha1_to_hex(split_index->base_sha1);
+	base_path = git_path("sharedindex.%s", base_sha1_hex);
+	ret = do_read_index(split_index->base, base_path, 1);
 	if (hashcmp(split_index->base_sha1, split_index->base->sha1))
 		die("broken index, expect %s in %s, got %s",
-		    sha1_to_hex(split_index->base_sha1),
-		    git_path("sharedindex.%s",
-			     sha1_to_hex(split_index->base_sha1)),
+		    base_sha1_hex, base_path,
 		    sha1_to_hex(split_index->base->sha1));
+
 	merge_base_index(istate);
 	post_read_index_from(istate);
 	return ret;
-- 
2.12.0.22.g0672473d40

