Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22B79EB64DA
	for <git@archiver.kernel.org>; Wed, 12 Jul 2023 23:38:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231723AbjGLXid (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jul 2023 19:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232285AbjGLXiY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2023 19:38:24 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16FEF1BF2
        for <git@vger.kernel.org>; Wed, 12 Jul 2023 16:38:05 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-c4dd264359cso84276.3
        for <git@vger.kernel.org>; Wed, 12 Jul 2023 16:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1689205084; x=1691797084;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2juJz+XqNUzfjF+rbmcIRT44Yh17DlsW3aU6M8fDG3w=;
        b=TPNSYA8sAqiSd16SLB2y0zPCoFqxvDwFHTf+DbUw9YrCLfLI/Mzg6ytsvCNsP2tAl5
         LJrQx/id7OtUQcUyjmILrtJDakjQxcplaQfImk78TnxgoZ5IT09lTtZNDBfl2NgmnScw
         KHpAj+GKurCifjULUjNiojZ4lvkcSMgz3oyljXd5wxMN+U1Cb/uOljyMlGlbVdX3Pv79
         dUE3oklI2lfCKRZsB2dBzGtsJVqoqjwMncx9+hqpYEgXs0DhvOtXN/xQzJvqzFUhCQlj
         L7eQqxsCV+qbi8Nf7M4GQ5eg6ovAggtEJEvrHZkfJrplwibh52MkLvGGKBitGIWhwpwk
         FMKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689205084; x=1691797084;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2juJz+XqNUzfjF+rbmcIRT44Yh17DlsW3aU6M8fDG3w=;
        b=NrPkQXQ/ykbpfnW9Hm9+LlO6qglGZeuPUs+6RzcND7LQPZ6pBYBl6Pmcxj7U8I9qGY
         dYB/AWoV4KPeLLXORDh+pe9tBG2TO4Io6k1utsHoxDUQLKc/Q/gBFGeEfiKB+QqtRBQo
         PcQudx1j7+Tj33s3tUmpe619V7kswbEhHFjy+nVu0DBXvsLNRknLkYpMnvkw1fuiWnMi
         Ck7Xdr/T3csga6oRVFvKJE4DeMVggnyS2qPI1AK3fRDv5jSbe3hRW3plTc9x4axJcm3+
         1Lv+ANL/iFJ+GzyKhbvtf4ySvZnkznbxGK99sN0e0ZX07tHpknvqqXZP73L8DoofC9sf
         ILBw==
X-Gm-Message-State: ABy/qLYddaCemELfbJBQwFD6NZYlqmyAX/dOUzOFaQ8Y8B1GSTQLb4H4
        ribsJjQcFWCDKJll+0KrS+xpIO0BKnzItG+1Mo473w==
X-Google-Smtp-Source: APBJJlGhbtUnmFzN6YOj9kkRbRviwRFy/Zqh1crTQ9VZhlVFIL/L1RYL826fHdUmkZChm58XXvfxag==
X-Received: by 2002:a25:4c07:0:b0:bc6:5d71:f820 with SMTP id z7-20020a254c07000000b00bc65d71f820mr17869102yba.55.1689205084094;
        Wed, 12 Jul 2023 16:38:04 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id z1-20020a25ad81000000b00c581e8d0ae4sm1180626ybi.56.2023.07.12.16.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 16:38:03 -0700 (PDT)
Date:   Wed, 12 Jul 2023 19:38:03 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Victoria Dye <vdye@github.com>
Subject: [PATCH 14/20] commit-graph.c: prevent overflow in
 `fill_commit_graph_info()`
Message-ID: <62a3e40b9714bb8739ab32eceda8816b073ba5de.1689205042.git.me@ttaylorr.com>
References: <cover.1689205042.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1689205042.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a similar spirit as previous commits, ensure that we don't overflow
in a few spots within `fill_commit_graph_info()`:

  - First, when computing an offset into the commit data chunk, which
    can occur when the `lex_index` of the item we're looking up exceeds
    2^32-1/GRAPH_DATA_WIDTH.

  - A similar issue when computing the generation date offset for
    commits with `lex_index` greater than 2^32-1/4. Note that in
    practice this will never overflow, since the left-hand operand is
    from calling `sizeof(...)` and is thus already a `size_t`. But wrap
    that in an `st_mult()` to make it clear that we intend to perform
    this computation using 64-bit operands.

  - Finally, a nearly identical issue as above when computing an offset
    into the `generation_data_overflow` chunk.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 commit-graph.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 1b70bdb07e..ceaeb8b785 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -789,7 +789,7 @@ static void fill_commit_graph_info(struct commit *item, struct commit_graph *g,
 		die(_("invalid commit position. commit-graph is likely corrupt"));
 
 	lex_index = pos - g->num_commits_in_base;
-	commit_data = g->chunk_commit_data + GRAPH_DATA_WIDTH * lex_index;
+	commit_data = g->chunk_commit_data + st_mult(GRAPH_DATA_WIDTH, lex_index);
 
 	graph_data = commit_graph_data_at(item);
 	graph_data->graph_pos = pos;
@@ -799,14 +799,14 @@ static void fill_commit_graph_info(struct commit *item, struct commit_graph *g,
 	item->date = (timestamp_t)((date_high << 32) | date_low);
 
 	if (g->read_generation_data) {
-		offset = (timestamp_t)get_be32(g->chunk_generation_data + sizeof(uint32_t) * lex_index);
+		offset = (timestamp_t)get_be32(g->chunk_generation_data + st_mult(sizeof(uint32_t), lex_index));
 
 		if (offset & CORRECTED_COMMIT_DATE_OFFSET_OVERFLOW) {
 			if (!g->chunk_generation_data_overflow)
 				die(_("commit-graph requires overflow generation data but has none"));
 
 			offset_pos = offset ^ CORRECTED_COMMIT_DATE_OFFSET_OVERFLOW;
-			graph_data->generation = item->date + get_be64(g->chunk_generation_data_overflow + 8 * offset_pos);
+			graph_data->generation = item->date + get_be64(g->chunk_generation_data_overflow + st_mult(8, offset_pos));
 		} else
 			graph_data->generation = item->date + offset;
 	} else
-- 
2.41.0.347.g7b976b8871f

