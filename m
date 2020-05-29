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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E8B7C433DF
	for <git@archiver.kernel.org>; Fri, 29 May 2020 08:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33AD5207BC
	for <git@archiver.kernel.org>; Fri, 29 May 2020 08:51:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Umxakuz8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbgE2IvE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 May 2020 04:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbgE2IvB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 May 2020 04:51:01 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B14C03E969
        for <git@vger.kernel.org>; Fri, 29 May 2020 01:51:00 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id j198so6306951wmj.0
        for <git@vger.kernel.org>; Fri, 29 May 2020 01:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X1qP0yIzBq54g87TwIKpV0SZXbQXFiYLM+euJ7imfDI=;
        b=Umxakuz81juFaz7GejIqZc14icOYWJyeRTlP+MB8yVjPacdu2wuwvGMXGXPxtK5pvi
         UatcJGgEa17PK23qUIzL14qr+HEwarUGWwAT33iSuFXDcUIph8f9s+rPs/flAAKxs6EY
         PRNljga7miQ0zNuHaYlOy4D7WzVeeq33fTlyFE+bB6HiO5CizS0tH1q84OTvGrIYZEja
         JEs1x/K/MFVkf5w58AFnMGA95BVk8NvQzmQKzQNLeFTlngqr3Wq4Omzfv3IdYe3gJx2y
         xX2+wukKSPZbvjceQtUVEBsA62TIWkgyCPCN0N2YuyLUs5nJcBI3lffyK8LyrDNUe88L
         N0ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X1qP0yIzBq54g87TwIKpV0SZXbQXFiYLM+euJ7imfDI=;
        b=iDgwuk1c4fAwF9tHFf1Q73XGunIfpy2J0t3lVgEnvCY/2rAdBmNYp2HqR5rDuhxK/W
         09rmcxhixTpFrDZ7Kpc9+VbnsVdCsF4DBMhqXRbPDassx+8xl1Xtcmg6xbQngEcpi5SA
         Hm6zGTWByjSOZtK1blOXzgQgkqxI/6Qy/8OMjEDXuwG1IDEBh/99qzEALVbwSiKnEgTl
         39Qq4StY/r+WN4EStb0PktJCPlXb1lV4osoX4I1eQdSCd0RFEBlfr9CzcAvKTBBrmLDQ
         AqX5AmSR7YhcWy9LzduVAC1IO7TrJ1/Rxgk0QK3of7vaJc210orzw4dyD0C9NliYJNaD
         0g1w==
X-Gm-Message-State: AOAM532jkmA0edYVSxZBp9T/3LLWrFwgkscH6w4YlxqBqOHaJ3YC+N+G
        Xc0xI5sVIKL+zjvWvhaRQdmOmv/4
X-Google-Smtp-Source: ABdhPJz86zEf39sMAZCXFBcoN9KWx5Gynq1s1fwiimZjjhFYamq+nzqqDckTcdV9PP4WxM4jWFM6Cw==
X-Received: by 2002:a1c:2bc2:: with SMTP id r185mr7954274wmr.49.1590742259324;
        Fri, 29 May 2020 01:50:59 -0700 (PDT)
Received: from localhost.localdomain (84-236-109-105.pool.digikabel.hu. [84.236.109.105])
        by smtp.gmail.com with ESMTPSA id f11sm3525255wrj.2.2020.05.29.01.50.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 May 2020 01:50:58 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Garima Singh <garima.singh@microsoft.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 02/34] commit-graph: fix parsing the Chunk Lookup table
Date:   Fri, 29 May 2020 10:50:06 +0200
Message-Id: <20200529085038.26008-3-szeder.dev@gmail.com>
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

The commit-graph file format specifies that the chunks may be in any
order.  However, if the OID Lookup chunk happens to be the last one in
the file, then any command attempting to access the commit-graph data
will fail with:

  fatal: invalid commit position. commit-graph is likely corrupt

In this case the error is wrong, the commit-graph file does conform to
the specification, but the parsing of the Chunk Lookup table is a bit
buggy, and leaves the field holding the number of commits in the
commit-graph zero-initialized.

The number of commits in the commit-graph is determined while parsing
the Chunk Lookup table, by dividing the size of the OID Lookup chunk
with the hash size.  However, the Chunk Lookup table doesn't actually
store the size of the chunks, but it stores their starting offset.
Consequently, the size of a chunk can only be calculated by
subtracting the starting offsets of that chunk from the offset of the
subsequent chunk, or in case of the last chunk from the offset
recorded in the terminating label.  This is currenly implemented in a
bit complicated way: as we iterate over the entries of the Chunk
Lookup table, we check the ID of each chunk and store its starting
offset, then we check the ID of the last seen chunk and calculate its
size using its previously saved offset if necessary (at the moment
it's only necessary for the OID Lookup chunk).  Alas, while parsing
the Chunk Lookup table we only interate through the "real" chunks, but
never look at the terminating label, thus don't even check whether
it's necessary to calulate the size of the last chunk.  Consequently,
if the OID Lookup chunk is the last one, then we don't calculate its
size and turn don't run the piece of code determining the number of
commits in the commit graph, leaving the field holding that number
unchanged (i.e. zero-initialized), eventually triggering the sanity
check in load_oid_from_graph().

Fix this by iterating through all entries in the Chunk Lookup table,
including the terminating label.

Note that this is the minimal fix, suitable for the maintenance track.
A better fix would be to simplify how the chunk sizes are calculated,
but that is a more invasive change, less suitable for 'maint', so that
will be done in later patches.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 commit-graph.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/commit-graph.c b/commit-graph.c
index b205e65ed1..12df74c925 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -222,7 +222,7 @@ struct commit_graph *parse_commit_graph(void *graph_map, int fd,
 	last_chunk_id = 0;
 	last_chunk_offset = 8;
 	chunk_lookup = data + 8;
-	for (i = 0; i < graph->num_chunks; i++) {
+	for (i = 0; i <= graph->num_chunks; i++) {
 		uint32_t chunk_id;
 		uint64_t chunk_offset;
 		int chunk_repeated = 0;
-- 
2.27.0.rc1.431.g5c813f95dc

