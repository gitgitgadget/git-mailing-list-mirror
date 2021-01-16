Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B99C433E6
	for <git@archiver.kernel.org>; Sat, 16 Jan 2021 18:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56F912255F
	for <git@archiver.kernel.org>; Sat, 16 Jan 2021 18:12:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727923AbhAPSMX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Jan 2021 13:12:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727883AbhAPSME (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Jan 2021 13:12:04 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 953FAC061574
        for <git@vger.kernel.org>; Sat, 16 Jan 2021 10:11:23 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id m187so3819098wme.2
        for <git@vger.kernel.org>; Sat, 16 Jan 2021 10:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=LGssCpLC5Gno2NgmTlbRNzcGw8aNrcxnTttkKi2m33A=;
        b=dUBqVQs/B+9LXWFQ1/Z6H98Oh00gl5qphWw8KkDjYfprX27JkxLKL6gQRXAAPWzmMU
         cxXFxBwCMD2mBttQM6TJwxajh+Ed+Ed6k/Q/r9NSQ5lupi8F+NpisahXaxl/6HHZanZJ
         OqLin2i9kn13HBX/t8tdRQ65ugDa8SKSPAxfGyCD9SN8txygQLwL2dnk2m9bCQv1afqN
         m3bsheo13ite8MVxS7DOWb9nIKAyzMsb+p8fc0P/Efbt10SQvYz1w8CsQBb9X1LMgzoA
         FAG+EYJnUsF91dZMim0Vg7a25aZ67NahA7ZzjWAvQ6nIW2lVBUIBShfYZt251n9AnaKN
         fo8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=LGssCpLC5Gno2NgmTlbRNzcGw8aNrcxnTttkKi2m33A=;
        b=iS+m0Cw0OgLf9Q0rYRpwPuAYpBncupomr22rkB7nHIpzpz0sQQCy1VIf+MJQzp2Jie
         iFT38n3zqHTF3Rmh8Yb1kvQBRl8pGgEW/uGvRAQUVUEG6p1XzN84z6OyN2c3I5y6Ni7T
         W+iLGZHu0+x7aSTW4DJbp2ZEwKpbUfimxLQRfk+gjWqMV94doGUXc63oRrGUcnTCkFpX
         1nGkcbt55PRDkdVeTwNyqn01FNNwxK1RYnSbqckcrsDESZb1LhUsupIB34m7f2KIjrZd
         JA6dXFKq7ev/xPH1jT7Xyok2sdH92Uf7AfnnO4r6QOHM4DNBc5jpLi+WBopS1whEWKyY
         oSVw==
X-Gm-Message-State: AOAM530SQ4jUPu5jHkFV6YLHluoCVYp4cqTjQwHkyVpmRlKu9z5X7vc4
        xPq+/iWA7lwobWspWNGGEF4WhBUGCHQ=
X-Google-Smtp-Source: ABdhPJzUbijJtejkKX/GCNzknuVG+ywBb+mW05nr4ZsizlRqHnbAzLwFdAGZyIa2BGLZu5i33aogjw==
X-Received: by 2002:a1c:8153:: with SMTP id c80mr11892196wmd.74.1610820682051;
        Sat, 16 Jan 2021 10:11:22 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z8sm2197705wmi.44.2021.01.16.10.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Jan 2021 10:11:21 -0800 (PST)
Message-Id: <4d8eb415578e67ab91ebbeefa158425da226ebbd.1610820679.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.676.v6.git.1610820679.gitgitgadget@gmail.com>
References: <pull.676.v5.git.1609154168.gitgitgadget@gmail.com>
        <pull.676.v6.git.1610820679.gitgitgadget@gmail.com>
From:   "Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 16 Jan 2021 18:11:08 +0000
Subject: [PATCH v6 01/11] commit-graph: fix regression when computing Bloom
 filters
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Jakub =?UTF-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Taylor Blau <me@ttaylor.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Abhishek Kumar <abhishekkumar8222@gmail.com>

Before computing Bloom filters, the commit-graph machinery uses
commit_gen_cmp to sort commits by generation order for improved diff
performance. 3d11275505 (commit-graph: examine commits by generation
number, 2020-03-30) claims that this sort can reduce the time spent to
compute Bloom filters by nearly half.

But since c49c82aa4c (commit: move members graph_pos, generation to a
slab, 2020-06-17), this optimization is broken, since asking for a
'commit_graph_generation()' directly returns GENERATION_NUMBER_INFINITY
while writing.

Not all hope is lost, though: 'commit_gen_cmp()' falls back to
comparing commits by their date when they have equal generation number,
and so since c49c82aa4c is purely a date comparison function. This
heuristic is good enough that we don't seem to loose appreciable
performance while computing Bloom filters.

Applying this patch (compared with v2.30.0) speeds up computing Bloom
filters by factors ranging from 0.40% to 5.19% on various repositories [1].

So, avoid the useless 'commit_graph_generation()' while writing by
instead accessing the slab directly. This returns the newly-computed
generation numbers, and allows us to avoid the heuristic by directly
comparing generation numbers.

[1]: https://lore.kernel.org/git/20210105094535.GN8396@szeder.dev/

Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
---
 commit-graph.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index e9124d4a412..0267886e76c 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -139,13 +139,17 @@ static struct commit_graph_data *commit_graph_data_at(const struct commit *c)
 	return data;
 }
 
+/* 
+ * Should be used only while writing commit-graph as it compares
+ * generation value of commits by directly accessing commit-slab.
+ */
 static int commit_gen_cmp(const void *va, const void *vb)
 {
 	const struct commit *a = *(const struct commit **)va;
 	const struct commit *b = *(const struct commit **)vb;
 
-	uint32_t generation_a = commit_graph_generation(a);
-	uint32_t generation_b = commit_graph_generation(b);
+	uint32_t generation_a = commit_graph_data_at(a)->generation;
+	uint32_t generation_b = commit_graph_data_at(b)->generation;
 	/* lower generation commits first */
 	if (generation_a < generation_b)
 		return -1;
-- 
gitgitgadget

