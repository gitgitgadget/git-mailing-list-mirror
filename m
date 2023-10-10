Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5134CD8CB7
	for <git@archiver.kernel.org>; Tue, 10 Oct 2023 20:34:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343829AbjJJUeY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Oct 2023 16:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344204AbjJJUeI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2023 16:34:08 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8944D8
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 13:34:04 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-4195fddd6d7so2497971cf.0
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 13:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1696970044; x=1697574844; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hy3AUi1FbnH1wytiKQkQYCfah7452QZi9oIeAiyMxsA=;
        b=mde5Vb8okEpY/l1vs1vDjKxwM7mD/pn2WvtJnKKYl33jfkvDMPClNdIfZIyWlr/IPA
         eGzFxg6rOO+JNRe5PO+N1yjUkhRyS8KtNK7dSC6mWlfunAOIPpbOi5PuchuHNPAeG6+P
         fPtkDlUqm52MQF5Cu3EaI5+N84OhObCeRO8JevmPsUKudR/MDCcAslRXyG97KqPha2BL
         jjtqhH5PwjXwm+D4BxRTDFGJ1XpfUKiU4rSxwzuCAvcyfnQKbM4xmc9WydGCDTNnrFBL
         bJKU3nbUJttr9tpn7rBdDHa3QzK27EOBm8Y3yq6P60EuKCP89Xf97bgznpiG/M8cggZ+
         Gl8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696970044; x=1697574844;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hy3AUi1FbnH1wytiKQkQYCfah7452QZi9oIeAiyMxsA=;
        b=RRnGFIS+pdJ3hxp/9clzyIpfw/3N9U2KYucEhm4tnZvYmX0ecfS5tI87oySXTnXVkR
         yCUrY4SRzpNEmansskUPNlo9lc8qzyLw+ircZJ9SVu4rnu3dq4daEr5jehJT8qa0AKUO
         4LEIgpJpyegseB41kSRGlsNKOkFpDVzgcZIYRpVQB1Y6Zzp9hriKJAIWhzlrfihD0lZf
         +J36uT1V1bPvXcnQu5Yia2l3ElDupMafDlx+dyB1n4EbkCPlR1stSwkulks9CK3Zsyd8
         sYx/uOG2Jkisi52U7PVnxduma1+txyK33Pycg7yYMMcm7Z3kG1Q5MVa8UCLGP1HgPu2c
         AH+A==
X-Gm-Message-State: AOJu0Yzpc1GkRhWbf6753ATMNVOw/IrEWFzuWP+jTP7GuDzV2zQDfh0A
        X+TCDeNMWQz5iSdFjVsttZ41mAt7MkVg35Q1Xko/pg==
X-Google-Smtp-Source: AGHT+IFECsWAXtLKYdn2nQth2zCTrMoLBp5EY+U+hmyS4k2t8e6FyV5XC0kJE5+SfNAapF1RuzYeGg==
X-Received: by 2002:a05:622a:34a:b0:418:1437:303b with SMTP id r10-20020a05622a034a00b004181437303bmr23948161qtw.27.1696970043707;
        Tue, 10 Oct 2023 13:34:03 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id pj30-20020a05620a1d9e00b00775afce4235sm4571876qkn.131.2023.10.10.13.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 13:34:03 -0700 (PDT)
Date:   Tue, 10 Oct 2023 16:34:02 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: [PATCH v3 14/17] commit-graph: drop unnecessary
 `graph_read_bloom_data_context`
Message-ID: <0d4f9dc4ee58feb81928f92f6f8ac465e49083c0.1696969994.git.me@ttaylorr.com>
References: <cover.1692654233.git.me@ttaylorr.com>
 <cover.1696969994.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1696969994.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The `graph_read_bloom_data_context` struct was introduced in an earlier
commit in order to pass pointers to the commit-graph and changed-path
Bloom filter version when reading the BDAT chunk.

The previous commit no longer writes through the changed_paths_version
pointer, making the surrounding context structure unnecessary. Drop it
and pass a pointer to the commit-graph directly when reading the BDAT
chunk.

Noticed-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 commit-graph.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index fa3b58e762..e0fc62e110 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -314,16 +314,10 @@ static int graph_read_oid_lookup(const unsigned char *chunk_start,
 	return 0;
 }
 
-struct graph_read_bloom_data_context {
-	struct commit_graph *g;
-	int *commit_graph_changed_paths_version;
-};
-
 static int graph_read_bloom_data(const unsigned char *chunk_start,
 				  size_t chunk_size, void *data)
 {
-	struct graph_read_bloom_data_context *c = data;
-	struct commit_graph *g = c->g;
+	struct commit_graph *g = data;
 	uint32_t hash_version;
 	hash_version = get_be32(chunk_start);
 
@@ -415,14 +409,10 @@ struct commit_graph *parse_commit_graph(struct repo_settings *s,
 	}
 
 	if (s->commit_graph_changed_paths_version) {
-		struct graph_read_bloom_data_context context = {
-			.g = graph,
-			.commit_graph_changed_paths_version = &s->commit_graph_changed_paths_version
-		};
 		pair_chunk(cf, GRAPH_CHUNKID_BLOOMINDEXES,
 			   &graph->chunk_bloom_indexes);
 		read_chunk(cf, GRAPH_CHUNKID_BLOOMDATA,
-			   graph_read_bloom_data, &context);
+			   graph_read_bloom_data, graph);
 	}
 
 	if (graph->chunk_bloom_indexes && graph->chunk_bloom_data) {
-- 
2.42.0.342.g8bb3a896ee

