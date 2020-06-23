Return-Path: <SRS0=IiYM=AE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4877DC433E3
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 17:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B94B20774
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 17:47:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lABiXFKK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733212AbgFWRra (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 13:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733242AbgFWRrT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jun 2020 13:47:19 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E24C061573
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 10:47:19 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id a6so2737704wmm.0
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 10:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=CGtwHe9y0z0MVNXHg1zh9emF5kH93HRl2YP/jm/T5uc=;
        b=lABiXFKKkfwACuvb0lhWnn+3lI7m4DFkzdnTgzi+WpDsejAxMahsgtKZ0HIfJnHmrF
         WWT/qVeFZUIuMhOW1ac7VX2c9f0xOiWR5yLfK5OBhI+YncmPvd6ArCTK938C5Xucu6Uz
         b5cK5HSWsBOv6UpfKeifzoHC1V5p6UM/sT04UgiGcWeEoXPH1J4vSoX5LL8egV9GkEf4
         HjzNuJ8dn12GSj90mMK0mGW8wyGRtkAY5zsHGCNTNlq+045Kxqw/fGjqJtfDBysvuHt7
         1dpPcW4CTsSXZOpnre9DlAQiiX7EdMIlOzFbGNeaBn5WYJyJF8MvH6LeDPmVjPol/owU
         A6fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=CGtwHe9y0z0MVNXHg1zh9emF5kH93HRl2YP/jm/T5uc=;
        b=WUPmBGBRDaAGbL8j8R4j6ktkRvZDW6IV+s4Rc+00R2ujIs0KqxMoflNWBjgy5USO6T
         Ud71JHbQzgEQjF7wnLhmLYIYwnZSptb0rhKKCOqQOao1l5BTHpNqwN889hoBEVJUKI+8
         K7j5ZzYCFhy905KQgAnSWz+R39mYUWJS3nDGSvPzKFAptkqkqvqhINGXrsSr7uYF4Yu+
         NjKVWphT3+jW3OUgtbpv1i63nEaZPwSXBOTxOIWMrbdoT9CSUskStLkdISX17RE/KLxj
         IsHAP1R60t8thgdx39ns2P2Fjh3MoXDIHuY44a42jAkr3Ii0GVeUTF0Zw/9ErEDVqrYn
         un4A==
X-Gm-Message-State: AOAM5308rZHyRUFqEJueADUUyNphbVujOodIeraw17lY6Of6B386pUCg
        yWfk4uNfCU1ohio7QugvPlJD7vxg
X-Google-Smtp-Source: ABdhPJyzXXjOVD4nbwV44xVGCovRpVGlZBlrKT6PCFkwwqz+bgv8cfsDcffPXqx2a33SwKA37n4AsA==
X-Received: by 2002:a1c:a512:: with SMTP id o18mr15604527wme.101.1592934437806;
        Tue, 23 Jun 2020 10:47:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u65sm4899873wmg.5.2020.06.23.10.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 10:47:17 -0700 (PDT)
Message-Id: <3eb10933dc8517ab01eff17a179e484068d29724.1592934430.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.659.v2.git.1592934430.gitgitgadget@gmail.com>
References: <pull.659.git.1592252093.gitgitgadget@gmail.com>
        <pull.659.v2.git.1592934430.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?SZEDER=20G=C3=A1bor?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Tue, 23 Jun 2020 17:47:06 +0000
Subject: [PATCH v2 07/11] commit-graph: check chunk sizes after writing
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

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/commit-graph.c b/commit-graph.c
index 086fc2d070..1de6800d74 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1683,12 +1683,21 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 			num_chunks * ctx->commits.nr);
 	}
 
+	chunk_offset = f->total + f->offset;
 	for (i = 0; i < num_chunks; i++) {
+		uint64_t end_offset;
+
 		if (chunks[i].write_fn(f, ctx)) {
 			error(_("failed writing chunk with id %"PRIx32""),
 			      chunks[i].id);
 			return -1;
 		}
+
+		end_offset = f->total + f->offset;
+		if (end_offset - chunk_offset != chunks[i].size)
+			BUG("expected to write %"PRId64" bytes to chunk %"PRIx32", but wrote %"PRId64" instead",
+			    chunks[i].size, chunks[i].id, end_offset - chunk_offset);
+		chunk_offset = end_offset;
 	}
 
 	stop_progress(&ctx->progress);
-- 
gitgitgadget

