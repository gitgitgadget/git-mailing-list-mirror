Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C35EE49A6
	for <git@archiver.kernel.org>; Mon, 21 Aug 2023 21:44:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbjHUVoZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Aug 2023 17:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbjHUVoX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2023 17:44:23 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D96136
        for <git@vger.kernel.org>; Mon, 21 Aug 2023 14:44:21 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-d62bdd1a97dso3885670276.3
        for <git@vger.kernel.org>; Mon, 21 Aug 2023 14:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1692654260; x=1693259060;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Te2AZ3P/HGGnsA/Ke/hZvaKdqlqL+o6m0CJ5WKhMSYs=;
        b=qE9TRLXwQIf2IL27dBerYKrSPU1uHZxCVrxjBqE8Kbt8A1bMCWCYI/p1ZyPN4ufAkX
         3ddZVqWh55uX6eiqjlR+8Hu3+KL0w7ncIQr1dIcuSzo+SGGuFDvXLosgqQE+zY2HzzSW
         u7/lSuWdUEkPf0pYc9GZJ8I2K16czGRy+ydlhfndK4crmmsZPSngPKvD5WSSIkiuEGeo
         Dq31B3C/ozVhjcwLyIX070vzc+HLtPPwntuxh0A0U5Kvwqye9wziJC5zr96rJVJ2r9SH
         LS7en8+rNtN4CZFTTfDVYWM+L/KYc0PQfSOvsdHTdQsjQSuyf0oH0uf3AMBy0BJTeC8X
         vjWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692654260; x=1693259060;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Te2AZ3P/HGGnsA/Ke/hZvaKdqlqL+o6m0CJ5WKhMSYs=;
        b=VKDSEax9y+fx5Ml5HGwYK/fYDoFKf/1dJXWemyvYhjQ4ewhAE9ifp+yTs2VhQEm1N/
         Ll3g31eI3oFzPHLlr4afUId40PdbR7LrxPFsx5UoSRp8iudCMzpj7tq3IPS/Ecbq4/eY
         TY5+1blX5LDr/fYnnLooj+uaF/EcrlLzMsMfuUWaRXzbrzc2u6CMb6gROKLPAfs+Jl/B
         0tOVXBgY5FImmdd70NkncHZs+BZgBj7QS64n7k4NVXgloetERfxv2WRqLT1+0Vqt4LLM
         OWPNQ6Kz5P3COYQby9RGBflp7IqWDftflVQgqC6pgDmTFTjuffb3wpYxY6WqlasSXWbY
         bTuA==
X-Gm-Message-State: AOJu0Yx27dcnuh9M7dM346Iu0p7g3a3BxEjolB6G7aR/sJOlaWm33Bfk
        zHkmq94u11ltr9BlPvJVPd9SNkcgfEGgUeUyNnKC+Q==
X-Google-Smtp-Source: AGHT+IHZ00/k3KEdYrpQOI0ODh9hQQ6B3p9g73YHc6MsbSmN0ZSIn+BCBPzCTqbCIx5aroPWHN7hGw==
X-Received: by 2002:a25:d650:0:b0:d06:f117:774a with SMTP id n77-20020a25d650000000b00d06f117774amr8772479ybg.30.1692654260325;
        Mon, 21 Aug 2023 14:44:20 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 203-20020a2510d4000000b00d05bb67965dsm2066657ybq.8.2023.08.21.14.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 14:44:20 -0700 (PDT)
Date:   Mon, 21 Aug 2023 17:44:19 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>
Subject: [PATCH 08/15] bloom: annotate filters with hash version
Message-ID: <48347796c81f03f676295cf0217715e39192a522.1692654233.git.me@ttaylorr.com>
References: <cover.1692654233.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1692654233.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In subsequent commits, we will want to load existing Bloom filters out
of a commit-graph, even when the hash version they were computed with
does not match the value of `commitGraph.changedPathVersion`.

In order to differentiate between the two, add a "version" field to each
Bloom filter.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 bloom.c | 11 ++++++++---
 bloom.h |  1 +
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/bloom.c b/bloom.c
index ebef5cfd2f..9b6a30f6f6 100644
--- a/bloom.c
+++ b/bloom.c
@@ -55,6 +55,7 @@ int load_bloom_filter_from_graph(struct commit_graph *g,
 	filter->data = (unsigned char *)(g->chunk_bloom_data +
 					sizeof(unsigned char) * start_index +
 					BLOOMDATA_CHUNK_HEADER_SIZE);
+	filter->version = g->bloom_filter_settings->hash_version;
 
 	return 1;
 }
@@ -240,11 +241,13 @@ static int pathmap_cmp(const void *hashmap_cmp_fn_data UNUSED,
 	return strcmp(e1->path, e2->path);
 }
 
-static void init_truncated_large_filter(struct bloom_filter *filter)
+static void init_truncated_large_filter(struct bloom_filter *filter,
+					int version)
 {
 	filter->data = xmalloc(1);
 	filter->data[0] = 0xFF;
 	filter->len = 1;
+	filter->version = version;
 }
 
 struct bloom_filter *get_or_compute_bloom_filter(struct repository *r,
@@ -329,13 +332,15 @@ struct bloom_filter *get_or_compute_bloom_filter(struct repository *r,
 		}
 
 		if (hashmap_get_size(&pathmap) > settings->max_changed_paths) {
-			init_truncated_large_filter(filter);
+			init_truncated_large_filter(filter,
+						    settings->hash_version);
 			if (computed)
 				*computed |= BLOOM_TRUNC_LARGE;
 			goto cleanup;
 		}
 
 		filter->len = (hashmap_get_size(&pathmap) * settings->bits_per_entry + BITS_PER_WORD - 1) / BITS_PER_WORD;
+		filter->version = settings->hash_version;
 		if (!filter->len) {
 			if (computed)
 				*computed |= BLOOM_TRUNC_EMPTY;
@@ -355,7 +360,7 @@ struct bloom_filter *get_or_compute_bloom_filter(struct repository *r,
 	} else {
 		for (i = 0; i < diff_queued_diff.nr; i++)
 			diff_free_filepair(diff_queued_diff.queue[i]);
-		init_truncated_large_filter(filter);
+		init_truncated_large_filter(filter, settings->hash_version);
 
 		if (computed)
 			*computed |= BLOOM_TRUNC_LARGE;
diff --git a/bloom.h b/bloom.h
index 138d57a86b..330a140520 100644
--- a/bloom.h
+++ b/bloom.h
@@ -55,6 +55,7 @@ struct bloom_filter_settings {
 struct bloom_filter {
 	unsigned char *data;
 	size_t len;
+	int version;
 };
 
 /*
-- 
2.42.0.4.g52b49bb434

