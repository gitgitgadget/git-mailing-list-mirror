Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9033EB64DD
	for <git@archiver.kernel.org>; Wed, 12 Jul 2023 23:38:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232369AbjGLXiL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jul 2023 19:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232659AbjGLXiC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2023 19:38:02 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A354B1FDE
        for <git@vger.kernel.org>; Wed, 12 Jul 2023 16:37:59 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-577497ec6c6so80066247b3.2
        for <git@vger.kernel.org>; Wed, 12 Jul 2023 16:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1689205079; x=1691797079;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ugsJbil9q+eRrCIb0dS2LW2SDHdbbHmbbduiUJNFGIM=;
        b=I2C/PrGD36bdsOAwwl4x3OgYdrR2ZYJ/osR+UP8mVrK7OfpXh/ojBD/4XDFmrICPdB
         dT9KJr1M5G6ZUaEQIqROD9LSxG82RAJ7bo5oLGpOrbCt/4WkTDbKCoZdG/YB7wuLgWL3
         J+GmPjhyNaWCcucFlhovrhcHfeRizvYkmMr++aJ27wHcBuarSR8zd1PU/7n+6Vx0oqRn
         5EXlVb2miFW0H8TdKV8xx60IhgXHbZqv582fNpGZawkOy+bxqlNEAgZsyv53xee78UfU
         I8uFh6tab7w85no42uPakf6cv422KZh8rB6PYYsUr4Qlw1ux6MXYH00+Ps+GcwRq1/ql
         xi5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689205079; x=1691797079;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ugsJbil9q+eRrCIb0dS2LW2SDHdbbHmbbduiUJNFGIM=;
        b=JtrXit/HfAR+1GFOzwTXnWqSqd5aJuCSvp90QQe0/v2hA+zoPaED5HhyTQ1TrBIE12
         g/LXG5ATmGMjnnSZnvUhaCm52cqe1ENelax8eDsLCCsExEZ1R49h8ZV0fmbl19LRNoWL
         Px9tvQE2KT8/S7UUodUYrzG4jp/rmB5vlQZtWSkK/dR02//Km+njefUR82eS/TT68fiL
         2x9BzQn6RyQMHB8Fg/Sib/kFMLkQMluLPeE8nIsfA5oNfFj+tAhS3+XFkoRMNPcqmM4P
         7V4zjEvZ6K0z8vVR2305Nx+wXmA2WzPTkUh1XbTAduCrv7TDG013VCgreDLDKOXCPLc8
         YXCA==
X-Gm-Message-State: ABy/qLYel8/BsAQbRSEg9Yjj6l4XJVFip5ce3tC05FyQO9joXHkx60N0
        zNu/IL6hKsI04G76emibkAOXHyMuUbJQeAbHCxKJAg==
X-Google-Smtp-Source: APBJJlFzBRYTlce7Em+x/xt3GijwTGVOszNgbPDqmMj+Qf9HyOEWcUY/VUvy1o0BmSS9R+IydiWr8g==
X-Received: by 2002:a0d:cc0c:0:b0:577:630d:ef63 with SMTP id o12-20020a0dcc0c000000b00577630def63mr96217ywd.24.1689205078621;
        Wed, 12 Jul 2023 16:37:58 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id f65-20020a0dc344000000b00565271801b6sm1464767ywd.59.2023.07.12.16.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 16:37:58 -0700 (PDT)
Date:   Wed, 12 Jul 2023 19:37:57 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Victoria Dye <vdye@github.com>
Subject: [PATCH 12/20] commit-graph.c: prevent overflow in
 add_graph_to_chain()
Message-ID: <34edcef888f0cdb25cb88d1d736e99e338317573.1689205042.git.me@ttaylorr.com>
References: <cover.1689205042.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1689205042.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The commit-graph uses a fanout table with 4-byte entries to store the
number of commits at each shard of the commit-graph. So it is OK to have
a commit graph with as many as 2^32-1 stored commits. But we risk
overflowing any computation which may exceed the 32-bit (unsigned)
maximum when those computations are (incorrectly) performed using 32-bit
operands.

There are a couple of spots in `add_graph_to_chain()` where we could
potentially overflow the result:

  - First, when comparing the list of existing entries in the
    commit-graph chain. It is unlikely that this should ever overflow,
    since it would require having roughly 2^32-1/g->hash_len
    commit-graphs in the chain. But let's guard that computation with a
    `st_mult()` just to be safe.

  - Second, when computing the number of commits in the graph added to
    the front of the chain. This value is also a 32-bit unsigned, but we
    should make sure that it does not grow beyond the maximum value.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 commit-graph.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 538f96b27a..99af73e40a 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -481,7 +481,7 @@ static int add_graph_to_chain(struct commit_graph *g,
 
 		if (!cur_g ||
 		    !oideq(&oids[n], &cur_g->oid) ||
-		    !hasheq(oids[n].hash, g->chunk_base_graphs + g->hash_len * n)) {
+		    !hasheq(oids[n].hash, g->chunk_base_graphs + st_mult(g->hash_len, n))) {
 			warning(_("commit-graph chain does not match"));
 			return 0;
 		}
@@ -491,8 +491,15 @@ static int add_graph_to_chain(struct commit_graph *g,
 
 	g->base_graph = chain;
 
-	if (chain)
+	if (chain) {
+		if (unsigned_add_overflows(chain->num_commits,
+					   chain->num_commits_in_base)) {
+			warning(_("commit count in base graph too high: %"PRIuMAX),
+				(uintmax_t)chain->num_commits_in_base);
+			return 0;
+		}
 		g->num_commits_in_base = chain->num_commits + chain->num_commits_in_base;
+	}
 
 	return 1;
 }
-- 
2.41.0.347.g7b976b8871f

