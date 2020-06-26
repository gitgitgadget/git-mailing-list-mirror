Return-Path: <SRS0=gJGs=AH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B832BC433E3
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 12:30:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D97C207E8
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 12:30:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SqR1wqAh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728506AbgFZMaw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Jun 2020 08:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728508AbgFZMaq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jun 2020 08:30:46 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43427C08C5DE
        for <git@vger.kernel.org>; Fri, 26 Jun 2020 05:30:46 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id r12so9276976wrj.13
        for <git@vger.kernel.org>; Fri, 26 Jun 2020 05:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=QPKu9JDnmIUHwV48dQdj+pAvu1r4U1ggMHyYype5dBw=;
        b=SqR1wqAhUxO+trzfE8BB4m3bJAHWXwSdB+PMpP23Vx8Am9y5H+tU7QA2TZHHVIzzdY
         i0NyK7u0/OZIsQMbuCrDNJbwnQhLxfkxK0j9HxlA+drqmk/vI2dDHIYFwbRUG9LKdS4j
         cmMudXGjo0wqcNW7hYuSNFIlBvmvxN5oc/2lhrkt8ewVZ4R2HiKq9zYMXrvAFP9J5zS8
         gT+W/pL46Me/pGdIgNIaWsWcjfCxdxxeJOxQ07fS3gk+yGMKRrPHJsMC7s7dzXdwoIRe
         +UZX11VdFe4U92lSeZsh5XrAsD4bsAaCXAxRehX7Nw26rlZgq9HBP4aEoQPpIyEeuODv
         j6rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=QPKu9JDnmIUHwV48dQdj+pAvu1r4U1ggMHyYype5dBw=;
        b=APWvkxENPfHyQWgbCdJenwvxum62/G9ssyz51uRTvvXapvWoyuimGs4Wsey4E4WDZM
         oBnpMQ2rPuvKbEoRx0aKpVKUeVMV6i4n6VKCmnZW0lpKm11y/9MjDAh/7fDqVEsgW5hT
         AjJWJ+jYdpRnkVGLkEfT8ZBVHOI5nCgc3uR3BtvDsR4OXJQRCt6MdVNvZHkiuF76+j0E
         uMUC/Gnd+EwSOixe3X0+qY7L9731HPTbHIeWcZDoYytwyxslgZQcPwPnzq1a6nMlVsjc
         o1a55agQ108Or5L9nb/od6Gg6CRuuqkdR/pSnPNxvPvTPUwWyjticUqq9225EPE3aERS
         GxKg==
X-Gm-Message-State: AOAM530QYZnauQ9R7qxU2ENfD8dX1invgWy7pxE4wvTJzR/J8UVNMWMW
        VgpyNhsc9BC8eG+dXmaXjS1t/CS6
X-Google-Smtp-Source: ABdhPJzxRIqeh6mfG9O7Ka8pPxNLZ3k18z/X6ohdJnPaNNbGgiBKIgZWKfmq5KIZCJRLnA7brMMj2Q==
X-Received: by 2002:a05:6000:1182:: with SMTP id g2mr3336130wrx.44.1593174644880;
        Fri, 26 Jun 2020 05:30:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w14sm36425270wrt.55.2020.06.26.05.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 05:30:44 -0700 (PDT)
Message-Id: <ddbf297755cc133fd3111a4accfee306e9f27c9b.1593174637.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.659.v3.git.1593174636.gitgitgadget@gmail.com>
References: <pull.659.v2.git.1592934430.gitgitgadget@gmail.com>
        <pull.659.v3.git.1593174636.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?SZEDER=20G=C3=A1bor?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Fri, 26 Jun 2020 12:30:33 +0000
Subject: [PATCH v3 07/10] commit-graph: check chunk sizes after writing
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, szeder.dev@gmail.com, l.s.r@web.de,
        Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>

In my experience while experimenting with new commit-graph chunks,
early versions of the corresponding new write_commit_graph_my_chunk()
functions are, sadly but not surprisingly, often buggy, and write more
or less data than they are supposed to, especially if the chunk size
is not directly proportional to the number of commits.  This then
causes all kinds of issues when reading such a bogus commit-graph
file, raising the question of whether the writing or the reading part
happens to be buggy this time.

Let's catch such issues early, already when writing the commit-graph
file, and check that each write_graph_chunk_*() function wrote the
amount of data that it was expected to, and what has been encoded in
the Chunk Lookup table.  Now that all commit-graph chunks are written
in a loop we can do this check in a single place for all chunks, and
any chunks added in the future will get checked as well.

Helped-by: René Scharfe <l.s.r@web.de>
Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/commit-graph.c b/commit-graph.c
index e43ee58ea6..a0766a86f5 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1689,8 +1689,15 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 	}
 
 	for (i = 0; i < num_chunks; i++) {
+		uint64_t start_offset = f->total + f->offset;
+
 		if (chunks[i].write_fn(f, ctx))
 			return -1;
+
+		if (f->total + f->offset != start_offset + chunks[i].size)
+			BUG("expected to write %"PRId64" bytes to chunk %"PRIx32", but wrote %"PRId64" instead",
+			    chunks[i].size, chunks[i].id,
+			    f->total + f->offset - start_offset);
 	}
 
 	stop_progress(&ctx->progress);
-- 
gitgitgadget

