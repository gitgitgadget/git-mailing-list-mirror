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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5FE9C433DB
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 11:17:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A18C4229C4
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 11:17:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbgL1LQy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Dec 2020 06:16:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727019AbgL1LQy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Dec 2020 06:16:54 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C58C061794
        for <git@vger.kernel.org>; Mon, 28 Dec 2020 03:16:13 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id d13so10983207wrc.13
        for <git@vger.kernel.org>; Mon, 28 Dec 2020 03:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/BNtyX8PkcS7Xyds8I9R8qvbFAHFtzF4geBA1+bG1i4=;
        b=PplEAYQNRj3R5TOmlrnfGyP8Xsem9qQfc0L+Cg6MnhTyEJZjcPg0HpgPSYR6gLzLLM
         LBC4L2p1HxpjsvQaTOn2uKySndUws2Lowax2HZAmhiuvizq719eOEvnR/uvcIQweo55p
         SrnE1DxVA4bZMXsi6TaUyek3yA248EdmMUFbhhKwTIr8XEXXl2nW/qtWdVyOwVWRia4w
         Ipm0VdIFicu3ZPjqN8MgnI3ijcBM0v4vzBszyKuKlHALZ1dxNaEp7bXpiBk+4rxKPo5J
         nPkvmGILmW4pkj9N3Dy8GmjNARejPOBElGkRc3KdFwOySGJKaKhZP5SRYaTPtD6u/Hcp
         gjOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/BNtyX8PkcS7Xyds8I9R8qvbFAHFtzF4geBA1+bG1i4=;
        b=YTEWH5uKZFqPVziSGZZ60vLaEo/VHvIj6Ns2P61CRtpx7l0WiRhdNEn1GMyJS700aA
         9ql/IFHhK+w4dANJEukLvC3IfMB3ssn3881t1JboBYYgNAdFkKWI+cR1qHidsKChjzC8
         E38RTAt8baldn2NDAoOLF2zkbkpJs1Ix5k225lcmkoTxIj1tzeZp+9M+jS83yu+ctbKY
         5nZnvffmeD9q1P1u3p2akTz9HVCKkiybXyib+vjR44zHaBMsIgHvHaSSKuDwAG9XprXY
         FuJZtEevMUQdjn/Ix3dtEk1V0DIkSv/JVJSxXYvDsix0bS4L/udjwmfvqI/liAex5WFt
         HM5Q==
X-Gm-Message-State: AOAM533MRIN6e5lW56WjjbJHpYfEgVQcGZvY2NePbV8AUr7ux+Px8fbK
        9xXQYilr5K95/j70Xu5q4finlqMcH78=
X-Google-Smtp-Source: ABdhPJzXpiaJ07JYUffXYWyo0L1fGSjXIkZBFKvd7LY3cRN9HSQuS/660z7z+1xOTsm/2L89f5ZhoA==
X-Received: by 2002:adf:fe05:: with SMTP id n5mr51414352wrr.9.1609154171717;
        Mon, 28 Dec 2020 03:16:11 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x17sm55338130wro.40.2020.12.28.03.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Dec 2020 03:16:11 -0800 (PST)
Message-Id: <c4e817abf7dbcd6c99da404507ea940305c521b6.1609154168.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.676.v5.git.1609154168.gitgitgadget@gmail.com>
References: <pull.676.v4.git.1602079785.gitgitgadget@gmail.com>
        <pull.676.v5.git.1609154168.gitgitgadget@gmail.com>
From:   "Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 28 Dec 2020 11:15:58 +0000
Subject: [PATCH v5 01/11] commit-graph: fix regression when computing Bloom
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
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Abhishek Kumar <abhishekkumar8222@gmail.com>

Before computing Bloom fitlers, the commit-graph machinery uses
commit_gen_cmp to sort commits by generation order for improved diff
performance. 3d11275505 (commit-graph: examine commits by generation
number, 2020-03-30) claims that this sort can reduce the time spent to
compute Bloom filters by nearly half.

But since c49c82aa4c (commit: move members graph_pos, generation to a
slab, 2020-06-17), this optimization is broken, since asking for a
'commit_graph_generation()' directly returns GENERATION_NUMBER_INFINITY
while writing.

Not all hope is lost, though: 'commit_graph_generation()' falls back to
comparing commits by their date when they have equal generation number,
and so since c49c82aa4c is purely a date comparision function. This
heuristic is good enough that we don't seem to loose appreciable
performance while computing Bloom filters. Applying this patch (compared
with v2.29.1) speeds up computing Bloom filters by around ~4
seconds.

So, avoid the useless 'commit_graph_generation()' while writing by
instead accessing the slab directly. This returns the newly-computed
generation numbers, and allows us to avoid the heuristic by directly
comparing generation numbers.

Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
---
 commit-graph.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 06f8dc1d896..caf823295f4 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -144,8 +144,8 @@ static int commit_gen_cmp(const void *va, const void *vb)
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

