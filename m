Return-Path: <SRS0=mJAO=7L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 575BDC433E0
	for <git@archiver.kernel.org>; Fri, 29 May 2020 08:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 358A0207BC
	for <git@archiver.kernel.org>; Fri, 29 May 2020 08:51:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PcVX5aBT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbgE2IvX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 May 2020 04:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726892AbgE2IvT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 May 2020 04:51:19 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84672C08C5C8
        for <git@vger.kernel.org>; Fri, 29 May 2020 01:51:19 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id x13so2573183wrv.4
        for <git@vger.kernel.org>; Fri, 29 May 2020 01:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cvj8cOV7M1ndq2vXw5ET9iZ08Z+6qHGRnsITK6Jakzk=;
        b=PcVX5aBTN5UWWSbRP6yveaXNWvzfdKpwwy4Fs4LtcNckkpx0ScUeGoP6W9BFccy8H0
         qpHdBFg9ytpza1+oer7AUx6OwfudJ6HjOa5ORuG6kQNaPQ2quzo+gDos7GS6vbgbcnil
         IUppLLZaQT8N+ux4FzMDb/QcxSCwxaXyet2cFJaCzyv5P8VJRHM4HddZ8J8OFgyTWlc8
         y3JjvcenO52clwZZmwS4l1Gc/AOuMJG137RAUfcVV8xireB3m1n8RnD1EvYZF3i+Nk7z
         pBaS+BDymAhP0YhuI7c16FYy75IKL2bl6NQH08xx0dLtGj6z5wmuRaIJR+hkvfWukeyg
         Z42Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cvj8cOV7M1ndq2vXw5ET9iZ08Z+6qHGRnsITK6Jakzk=;
        b=NsAByHZuCTdnOkdm6639mfjRQO1oUWiBy+NZfIKc1CX2/9RR9cDbRdpOYZwqa+F/Em
         35xR1zHP0xNqIQrH4HrTHsimEW8JiUwpcky2OTBX74zjx0lk1t2i1cyNiDUo2vE6FrAT
         xREEo7h9ZD2O0dtW6Sm5Mdgf8CblxI/OsBl3idMI9YxdSm4QWb7uKwd8GjAy+4xD3Hcp
         pZCoXEDTZkJBzdDmtt1QYSAit10qqj3KPNg9B56FDrRDEkPmd83U6tuROElr26q+f9Nf
         dLdy66quUATBiUMMOIEhY8gqE/DWs86/ugTEqSKA/PuUsWu3dNedckP3x9eFxq89wg1I
         2lyg==
X-Gm-Message-State: AOAM533izL1H4ij3+qE1FrZSFMzpgnEsDmtyVhiecB4ldkpnV3Up07in
        pjrP+LeKMmsRPmOhEF3lAdjCn1Nb
X-Google-Smtp-Source: ABdhPJx8gt7tuqiSW8O4VvHfcIR0Nb+yggIi4cg1z0ylMh8Sl4zH2j175qnMRLni1iVnZykCdNjMxw==
X-Received: by 2002:adf:9447:: with SMTP id 65mr7773601wrq.331.1590742277996;
        Fri, 29 May 2020 01:51:17 -0700 (PDT)
Received: from localhost.localdomain (84-236-109-105.pool.digikabel.hu. [84.236.109.105])
        by smtp.gmail.com with ESMTPSA id f11sm3525255wrj.2.2020.05.29.01.51.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 May 2020 01:51:17 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Garima Singh <garima.singh@microsoft.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 14/34] commit-graph: check chunk sizes after writing
Date:   Fri, 29 May 2020 10:50:18 +0200
Message-Id: <20200529085038.26008-15-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.27.0.rc1.431.g5c813f95dc
In-Reply-To: <20200529085038.26008-1-szeder.dev@gmail.com>
References: <20200529085038.26008-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In my experience while experimenting with new commit-graph chunks,
early versions of the corresponding new write_commit_graph_my_chunk()
functions are, sadly but not surprisingly, often buggy, and write more
or less data than they are supposed to, especially if the chunk size
is not directly proportional to the number of commits.  This then
causes all kinds of issues when reading such a bogus commit-graph
file, raising the question of whether the writing or the reading part
happens to be buggy this time.

Let's catch such issues early, already when writing the commit-graph
file, and check that each write_commit_graph_*() function wrote the
amount of data that it was expected to, and what has been encoded in
the Chunk Lookup table.  Now that all commit-graph chunks are written
in a loop we can do this check in a single place for all chunks, and
any chunks added in the future will get checked as well.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 commit-graph.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/commit-graph.c b/commit-graph.c
index fe26245fad..e3adffd58b 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1474,11 +1474,22 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 			progress_title.buf,
 			chunks_nr * ctx->commits.nr);
 	}
-	for (i = 0; i < chunks_nr; i++)
+	chunk_offset = f->total + f->offset;
+	for (i = 0; i < chunks_nr; i++) {
+		uint64_t end_offset;
+
 		if (chunks[i].write_fn(f, ctx)) {
 			ret = -1;
 			goto cleanup;
 		}
+
+		end_offset = f->total + f->offset;
+		if (end_offset - chunk_offset != chunks[i].size)
+			BUG("expected to write %lu bytes to chunk %08x, but wrote %lu instead",
+			    chunks[i].size, chunks[i].id,
+			    end_offset - chunk_offset);
+		chunk_offset = end_offset;
+	}
 	stop_progress(&ctx->progress);
 	strbuf_release(&progress_title);
 
-- 
2.27.0.rc1.431.g5c813f95dc

