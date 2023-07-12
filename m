Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF59EB64DA
	for <git@archiver.kernel.org>; Wed, 12 Jul 2023 23:38:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233354AbjGLXi6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jul 2023 19:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233360AbjGLXim (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2023 19:38:42 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59BA32707
        for <git@vger.kernel.org>; Wed, 12 Jul 2023 16:38:16 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-577412111f0so88156647b3.0
        for <git@vger.kernel.org>; Wed, 12 Jul 2023 16:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1689205094; x=1691797094;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QpgFrrXneU3h2NNXvTA4B6p+UpggFpNMU+6bC1dHaEY=;
        b=dZ4pGhxhSZrcGEBcj8gDDCCo/B3fx5s5HM3xwpohdzGZHVXwLgDnmYq1E0eo4TNElv
         XlDazy2Ez2fZh0T2U7uqigsvE0kGQ3fepmJG65w0J6jQP/EjcieviH/Ap8JvEviXz5C7
         o+uFgKH0S5f7+S+VBcSVYBJdhkARHU0aPOXhc0DmMMqMjb2OEN6FeOifFQpqvXXWv78h
         6h3h2tB0RWTx6UG5G3MsQpp26/U/2JtGbKXcgj3kC1uDWEAEP6yZnElNxOM2++hes7A3
         KflhwsAo5tlGyQBT8LnfU92T7X6qC1qZl1x3y+/62hpNF0jLbpr8fC2mhCcEuxVK2y73
         hP/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689205094; x=1691797094;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QpgFrrXneU3h2NNXvTA4B6p+UpggFpNMU+6bC1dHaEY=;
        b=YdzE/hgZuq5AKlEM6/BrVhv1rEVMcekzF9KxKIQ/VfsjW8D0NoLk1HPFPmQmyQZ/hU
         wE+ueqJURfPFx76+hJ/oKyOF7skHQpisvzmInZKBZAtJBVNcHBSxplxiyAaoDKbf7R6C
         Z4kuWV6MZXr+UIcnQAa/R5tbe8Cc1dyVyVQ7qfeQ0FTtAGp5BZAiEtjhqRsIVNIkZIRj
         zs/pxbQwFyph9QO6yG3aI+7g1A41YxTFG2spDk+hoJ4Q4nVWwtj86B0G+OyGzc4BkBep
         FV5puecQGdbvSy9wz/FA70zFFxg7R92aLetKrl6+zaA2OaxINSa5BIGkEpfGxvF1qRBe
         Gz6A==
X-Gm-Message-State: ABy/qLaarja959MGbn4qhRMwNkjxMz4XSarqL5/ij5c06fdmPv6EL5zo
        yz6rLCXmncIuqdKH/pRp0wS87rNSUXPmZWLy+mLFaw==
X-Google-Smtp-Source: APBJJlFECIAi/EB4Jo0jEpqxlEG0Uw61sIod/2G8eTnX3Dm6Vr6UNH/T/4iPxSj2oqmzbTAJRLNcbA==
X-Received: by 2002:a81:4e16:0:b0:577:1909:ee16 with SMTP id c22-20020a814e16000000b005771909ee16mr86248ywb.30.1689205094604;
        Wed, 12 Jul 2023 16:38:14 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id o123-20020a0dfe81000000b0057069c60799sm1468233ywf.53.2023.07.12.16.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 16:38:14 -0700 (PDT)
Date:   Wed, 12 Jul 2023 19:38:13 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Victoria Dye <vdye@github.com>
Subject: [PATCH 18/20] commit-graph.c: prevent overflow in
 `merge_commit_graph()`
Message-ID: <094aca51c2c23fe74016c60d5ba31c325da038d2.1689205042.git.me@ttaylorr.com>
References: <cover.1689205042.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1689205042.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When merging two commit graphs, ensure that we don't attempt to merge
two graphs which, when combined, have more total commits than the 32-bit
unsigned maximum.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 commit-graph.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/commit-graph.c b/commit-graph.c
index 8010e0763e..c679d1d633 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -2178,6 +2178,11 @@ static void merge_commit_graph(struct write_commit_graph_context *ctx,
 	uint32_t i;
 	uint32_t offset = g->num_commits_in_base;
 
+	if (unsigned_add_overflows(ctx->commits.nr, g->num_commits))
+		die(_("cannot merge graph %s, too many commits: %"PRIuMAX),
+		    oid_to_hex(&g->oid),
+		    (uintmax_t)st_add(ctx->commits.nr, g->num_commits));
+
 	ALLOC_GROW(ctx->commits.list, ctx->commits.nr + g->num_commits, ctx->commits.alloc);
 
 	for (i = 0; i < g->num_commits; i++) {
-- 
2.41.0.347.g7b976b8871f

