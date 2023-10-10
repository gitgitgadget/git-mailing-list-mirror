Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A536BCD8CB4
	for <git@archiver.kernel.org>; Tue, 10 Oct 2023 20:34:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343941AbjJJUec (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Oct 2023 16:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjJJUeQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2023 16:34:16 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C4398E
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 13:34:14 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-7741c5bac51so359153385a.1
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 13:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1696970053; x=1697574853; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5VrBPDmOjWxdllfTw2xH8Ary/m77UeoLJiNh2idn7Tg=;
        b=LZrg42pef0uPyMbDRKR9Xy8M2GsZuFS9OPlVwQefIGqV1aYPcTzkXVz+v3HyS0v3Ix
         eU4PQwQEnniS+9cb2EmqGDOIbYS6ew2RukcrdZlxvtx0gGTugvo8dHaUgl4eZyxonPn/
         pzHt3wXxo5RKOH3UuZj9b/cpJPHId6d4gM9VCTyuCyA8jj9N+trFmB+y2QfHIy4iAsBI
         RUhCcSc2TrElNX8qygmvoISB0kFsiztsxrbUaq5ZAJ16XJxbbuQWks6be9DKEIsyoXns
         NDMjIs2AwKGOxiZcZlE/D+fYOqB8qllKei153JiEo/l02cXHNVeUQoR/NJaFci2y0lVG
         igEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696970053; x=1697574853;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5VrBPDmOjWxdllfTw2xH8Ary/m77UeoLJiNh2idn7Tg=;
        b=iBEwYxsicRwzWnyjC5V/AC8/JgD2dl4A2qvt2zC2cHxuEEgQpNsoaSgl5NxT7moyIu
         42fAFKeZ1XevRX+rH5QsijGwaZ1vw3FZG87VYM7RfxxFWG+GSRHqXt9U5TODxfSw+/jW
         OvQZPj/Hi5tiDZ4wZNssMslva10W2bl1P6qPqOVDsCnk9jJnc8vuaCvyi1j1QwluECrf
         BGKk6dTUq7zJ4aa8sEV9sxK9VAbhIOVBw/7+f+DDMpAygqv3Sch/1Ia7tYLO0LO71H4P
         zAc3HoDwQOQrhkWhAhDNynd22TbeEo332t+jHayy2cNQgwRfgUQDQXlLZg7Zx233MsGN
         6Rqg==
X-Gm-Message-State: AOJu0YwZv+AOldLWgwiIroBVl5Pm7J+oBkbOrdpFQtjk3LBh3yKxQK7s
        pjJ9neV03Cg9J5a7CmI0vSo9T2u6I7ubAMTjYtvWAA==
X-Google-Smtp-Source: AGHT+IG5Y2KUKyp7QWO6BA3VoqcvZYLBSh+/8URNymrkL/hyRMuJug0z2DT2uxvCYxz7sp+f9MKrMw==
X-Received: by 2002:a05:620a:2952:b0:773:bdb3:1318 with SMTP id n18-20020a05620a295200b00773bdb31318mr22105446qkp.15.1696970052883;
        Tue, 10 Oct 2023 13:34:12 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id pj40-20020a05620a1da800b007743360b3fasm4632735qkn.34.2023.10.10.13.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 13:34:12 -0700 (PDT)
Date:   Tue, 10 Oct 2023 16:34:11 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: [PATCH v3 17/17] bloom: introduce `deinit_bloom_filters()`
Message-ID: <ca362408d59f903f0c8094e5290fdd03e54ec195.1696969995.git.me@ttaylorr.com>
References: <cover.1692654233.git.me@ttaylorr.com>
 <cover.1696969994.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1696969994.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After we are done using Bloom filters, we do not currently clean up any
memory allocated by the commit slab used to store those filters in the
first place.

Besides the bloom_filter structures themselves, there is mostly nothing
to free() in the first place, since in the read-only path all Bloom
filter's `data` members point to a memory mapped region in the
commit-graph file itself.

But when generating Bloom filters from scratch (or initializing
truncated filters) we allocate additional memory to store the filter's
data.

Keep track of when we need to free() this additional chunk of memory by
using an extra pointer `to_free`. Most of the time this will be NULL
(indicating that we are representing an existing Bloom filter stored in
a memory mapped region). When it is non-NULL, free it before discarding
the Bloom filters slab.

Suggested-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 bloom.c        | 16 +++++++++++++++-
 bloom.h        |  3 +++
 commit-graph.c |  4 ++++
 3 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/bloom.c b/bloom.c
index 24dd874e46..ff131893cd 100644
--- a/bloom.c
+++ b/bloom.c
@@ -59,6 +59,7 @@ int load_bloom_filter_from_graph(struct commit_graph *g,
 					sizeof(unsigned char) * start_index +
 					BLOOMDATA_CHUNK_HEADER_SIZE);
 	filter->version = g->bloom_filter_settings->hash_version;
+	filter->to_free = NULL;
 
 	return 1;
 }
@@ -231,6 +232,18 @@ void init_bloom_filters(void)
 	init_bloom_filter_slab(&bloom_filters);
 }
 
+static void free_one_bloom_filter(struct bloom_filter *filter)
+{
+	if (!filter)
+		return;
+	free(filter->to_free);
+}
+
+void deinit_bloom_filters(void)
+{
+	deep_clear_bloom_filter_slab(&bloom_filters, free_one_bloom_filter);
+}
+
 static int pathmap_cmp(const void *hashmap_cmp_fn_data UNUSED,
 		       const struct hashmap_entry *eptr,
 		       const struct hashmap_entry *entry_or_key,
@@ -247,7 +260,7 @@ static int pathmap_cmp(const void *hashmap_cmp_fn_data UNUSED,
 static void init_truncated_large_filter(struct bloom_filter *filter,
 					int version)
 {
-	filter->data = xmalloc(1);
+	filter->data = filter->to_free = xmalloc(1);
 	filter->data[0] = 0xFF;
 	filter->len = 1;
 	filter->version = version;
@@ -449,6 +462,7 @@ struct bloom_filter *get_or_compute_bloom_filter(struct repository *r,
 			filter->len = 1;
 		}
 		CALLOC_ARRAY(filter->data, filter->len);
+		filter->to_free = filter->data;
 
 		hashmap_for_each_entry(&pathmap, &iter, e, entry) {
 			struct bloom_key key;
diff --git a/bloom.h b/bloom.h
index e3a9b68905..d20e64bfbb 100644
--- a/bloom.h
+++ b/bloom.h
@@ -56,6 +56,8 @@ struct bloom_filter {
 	unsigned char *data;
 	size_t len;
 	int version;
+
+	void *to_free;
 };
 
 /*
@@ -96,6 +98,7 @@ void add_key_to_filter(const struct bloom_key *key,
 		       const struct bloom_filter_settings *settings);
 
 void init_bloom_filters(void);
+void deinit_bloom_filters(void);
 
 enum bloom_filter_computed {
 	BLOOM_NOT_COMPUTED = (1 << 0),
diff --git a/commit-graph.c b/commit-graph.c
index 571f38335a..7ccec429cb 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -787,6 +787,7 @@ static void close_commit_graph_one(struct commit_graph *g)
 void close_commit_graph(struct raw_object_store *o)
 {
 	close_commit_graph_one(o->commit_graph);
+	deinit_bloom_filters();
 	o->commit_graph = NULL;
 }
 
@@ -2588,6 +2589,9 @@ int write_commit_graph(struct object_directory *odb,
 
 	res = write_commit_graph_file(ctx);
 
+	if (ctx->changed_paths)
+		deinit_bloom_filters();
+
 	if (ctx->split)
 		mark_commit_graphs(ctx);
 
-- 
2.42.0.342.g8bb3a896ee
