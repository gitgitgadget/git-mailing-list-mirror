Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6B1AC433DB
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 17:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9316264EAC
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 17:15:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbhBARP5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 12:15:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbhBARP4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 12:15:56 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15184C061786
        for <git@vger.kernel.org>; Mon,  1 Feb 2021 09:15:16 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id u14so13841768wmq.4
        for <git@vger.kernel.org>; Mon, 01 Feb 2021 09:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/U6UDAGaH1mCjnX82IwAUqNIZFhOQLAUI+ugKX9Q2tk=;
        b=kDIv91brKm1ilrz19as9TNlZmc+dQDu5v7Tbm3LyjWOmeMaCoDKvK5bzLX9ZbeY60a
         PMlxwn/ylsA7oA7FMGxpOhOEB5f6+t4MBOY120wNCVSk5P917YhkxaGq11o3D/SA7/ne
         a90sR1BeuDcBbmzYwdK9cohQ92dH5XlqlU0JYCsV65SoB5OHeN0qHhOlnbz3MVqsxSFd
         hNOqs9guGDrspanKtDoZ3a7zWnJtMHsKdYY9NP+BHi4twH7DfF6AdlJGnuFe8T5fh3if
         NCfGOBJJHfKRIDUtrCmvYM79K6Q0WXtdD6g0nVEJO2H9ig91cL0ftZ7L0lXHkYIrZHKf
         gFIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/U6UDAGaH1mCjnX82IwAUqNIZFhOQLAUI+ugKX9Q2tk=;
        b=MYuKvgsfIvZZNS9nAnPrdl6JMXiMiVRfTZaL6szaCZrApvv1Zqr5WMDmsu2NQabhNZ
         0GRKB6vQ7ltX2ktXH25t0u22oiw2xLQWdVUOL1ai1/xXnhdgk3VEii0a/XdWAGqdQztq
         4KGz13wtHXvDXhB3FP78pSKB1YGWgERp9htW0Ha3EYy26VYYLj+ya37nZa2zfrz3cwD+
         HYp8kle5cg1z7l3vubQ4wErwB5oi/wvWyKkcyUeREZ/wR2PZ6Cdj2OaG1nLbIne22xCu
         HMTQ0kQsToobXtNnRCbREBup99T5AtBhqK6GKh7JYn5Hn0mVnKZnKZxnylH/zPfTyOsx
         nDwA==
X-Gm-Message-State: AOAM532brHxeoiou0tpKnD5gRAKAHlm7LizSkeDmvCIc0DxTBFIGTfcI
        DNvjKV91dk27zRLs2unvZy+hIfzZ5mo=
X-Google-Smtp-Source: ABdhPJxI2bVuG/h0oxJorAreE5RSbIYrx6UeJo/zE13H2C/nPyk4bbzG52+dBI7gF5OCyHcv87e9Qw==
X-Received: by 2002:a1c:4e:: with SMTP id 75mr16125092wma.150.1612199714307;
        Mon, 01 Feb 2021 09:15:14 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n9sm27931727wrq.41.2021.02.01.09.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 09:15:13 -0800 (PST)
Message-Id: <d554fa306601c9e5e0e804d10b7a73b6eece6b04.1612199707.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.850.git.1612199707.gitgitgadget@gmail.com>
References: <pull.850.git.1612199707.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 01 Feb 2021 17:15:05 +0000
Subject: [PATCH 3/5] commit-graph: validate layers for generation data
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, peff@peff.net, gister@pobox.com,
        abhishekkumar8222@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

We need to be extra careful that we don't use corrected
commit dates from any layer of a commit-graph chain if there is a
single commit-graph file that is missing the generation_data chunk.
Update validate_mixed_generation_chain() to correctly update each
layer to ignore the generation_data chunk in this case. It now also
returns 1 if all layers have a generation_data chunk. This return
value will be used in the next change.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index edbb3a0f2cc..13992137dd0 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -614,19 +614,26 @@ static struct commit_graph *load_commit_graph_chain(struct repository *r,
 	return graph_chain;
 }
 
-static void validate_mixed_generation_chain(struct commit_graph *g)
+/*
+ * returns 1 if and only if all graphs in the chain have
+ * corrected commit dates stored in the generation_data chunk.
+ */
+static int validate_mixed_generation_chain(struct commit_graph *g)
 {
-	int read_generation_data;
+	int read_generation_data = 1;
+	struct commit_graph *p = g;
 
-	if (!g)
-		return;
-
-	read_generation_data = !!g->chunk_generation_data;
+	while (read_generation_data && p) {
+		read_generation_data = p->read_generation_data;
+		p = p->base_graph;
+	}
 
 	while (g) {
 		g->read_generation_data = read_generation_data;
 		g = g->base_graph;
 	}
+
+	return read_generation_data;
 }
 
 struct commit_graph *read_commit_graph_one(struct repository *r,
-- 
gitgitgadget

