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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34430C433E6
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 03:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F012664DA5
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 03:02:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbhBBDCl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 22:02:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbhBBDCh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 22:02:37 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E698C061793
        for <git@vger.kernel.org>; Mon,  1 Feb 2021 19:01:29 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 190so1072297wmz.0
        for <git@vger.kernel.org>; Mon, 01 Feb 2021 19:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=oBHpbe8SMwzLDpj1QYTBv7xfKLQQS7mGrfV1ZkEAEgA=;
        b=EY5pdShRod4U+lvvt5yXBhxvj98MDDf+IWJOe9pxvskiZzSlJu0uh4IZX8LkLIYkP0
         71ttB5VfT1w5i9ByCQMLchNAV20KDk0dE3tfL5BGiLLmBYBKwmGN8Uj824eeSZm8Onzo
         1Quuq3dpygAJ/kt6nJAfpblRfH2/QgzqRUeh2sn6WZPScBZKekd1nsQmclLtOC7tmAxa
         KMc62o93v6pAW6w0OZ3Osg2HSYxpnMY0IWYavyj+ZyOJCWJKJOGMGe2KbnRqqRhHjf0o
         IxMBwXZYsc53MCeJ7Tg2ocAbasUKLNrWIFCKSiZH7480reJWwmqyDs0a1/fnSK3OMSs1
         6G4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=oBHpbe8SMwzLDpj1QYTBv7xfKLQQS7mGrfV1ZkEAEgA=;
        b=EFoxoTRHPfrOgNtgXsN0QC4SeyXnZzaVr785wy5lWJZ92b99ZUx8ooFgsdwOZcDj09
         I92phwBsyy+PL2dizbwh0r83G7R6/fw0sYKZagrWhwTggiwsvcWX8R/ca3vaeBfwoyay
         1qybZRv5yJxN8q0YG6wheZ6WQxhegIHC4DFY5RUYZ1RgN46EGNAbAT+5/iSxQ9UJPBnL
         9QyxOrhc25nFEEbp9EhPwFLoV83D+b9JqJb2ANyLQ0uiNiF3h7REZ6U0csvlZWjUCjl+
         XOjqnVfqCCFEJ0Egl47+/puWIVSEXHckGbQ98q/3hcw6Voutuf5eEzC5l5H3Arx5MdAk
         a1ew==
X-Gm-Message-State: AOAM533jVKus/b5yhFOMPiAOUEzlMUVIC2ynEJHGEoM1Y9QnYQ1CG2Mn
        WFrt3sd3wva0OTeSdldSpohNSjHVLdU=
X-Google-Smtp-Source: ABdhPJxRPgYN3D2pLVbRbCkwv3DwJrZ05vnPpmT9fRXDs4JCFhGWnMEt7ouyCls+R1bBP9A9hC6iEw==
X-Received: by 2002:a1c:545d:: with SMTP id p29mr474603wmi.77.1612234887651;
        Mon, 01 Feb 2021 19:01:27 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o18sm1119942wmh.20.2021.02.01.19.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 19:01:27 -0800 (PST)
Message-Id: <3d223fa2156530f67997be8fa7e254e599f3b13a.1612234883.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.850.v2.git.1612234883.gitgitgadget@gmail.com>
References: <pull.850.git.1612199707.gitgitgadget@gmail.com>
        <pull.850.v2.git.1612234883.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 02 Feb 2021 03:01:20 +0000
Subject: [PATCH v2 3/6] commit-graph: validate layers for generation data
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, peff@peff.net, gitster@pobox.com,
        abhishekkumar8222@gmail.com, Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <ttaylorr@github.com>,
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
 commit-graph.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index edbb3a0f2cc..b3f7c3bbcb3 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -614,19 +614,29 @@ static struct commit_graph *load_commit_graph_chain(struct repository *r,
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
+	while (read_generation_data && p) {
+		read_generation_data = p->read_generation_data;
+		p = p->base_graph;
+	}
 
-	read_generation_data = !!g->chunk_generation_data;
+	if (read_generation_data)
+		return 1;
 
 	while (g) {
-		g->read_generation_data = read_generation_data;
+		g->read_generation_data = 0;
 		g = g->base_graph;
 	}
+
+	return 0;
 }
 
 struct commit_graph *read_commit_graph_one(struct repository *r,
-- 
gitgitgadget

