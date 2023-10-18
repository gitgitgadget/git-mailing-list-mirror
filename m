Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69F947353
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 18:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="mLVd59p5"
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D34C11F
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 11:33:27 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-66d0169cf43so45636306d6.3
        for <git@vger.kernel.org>; Wed, 18 Oct 2023 11:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1697654006; x=1698258806; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=59wqNeBCli9n+XHZyvKFIhu32Ca1EgtEbPwN27M3Has=;
        b=mLVd59p5zX639ULlrp5Vt2SCKpeR4UiP/NCq3mQjlbVzMRrqBCIbKNovTH1s2F20Wm
         qokTlt031/mdN/mOMtJE16uA7NWkrMT90DIJlTYNT4YT4Ld3Vzz4JUCEKPXGsAqzAJOo
         IjgMqlRKg32j/HiDSNIF7ffyMgTd4aIoydx39jCezerusWT3FQGCp7y4MhXgqJ4k/pxJ
         8IHCW7gpj9YlsHyc7tZ0jpssn9VkrVcSOqiHeMhCm2+g6KfjHzYIcaCvAN7+TrD8jrkT
         Ot73n7ee07R8mtZDis0M+g4MZTmACliN/P75hUI2ORfc4xszbt2FNgCyuSBg+VoSTC2Z
         4S1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697654006; x=1698258806;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=59wqNeBCli9n+XHZyvKFIhu32Ca1EgtEbPwN27M3Has=;
        b=EskgA6auAPg1DiAOY9apurw0Cb9TQb/+GZLe3hzBG/yR77HxI8Cx3AIpbrxmoaE6ut
         VEYgA2Vxi38FIovS5m8zLo5UhjLIbk7IbRclsBu9GoxUiRYxLwpNUgKBJ2109SB8dkTg
         ZjYt/CBTM/B6P93yMCGS2ZMhI47cRnj8fkSw3fmvPoQYk8137Ot182ss/zAAgBxrmEBc
         LRisw+Mpa8XGP++XJRwgGlOT3boQCZL8N0GR/b7/faPEHeVc8fBHTZ25XJC+FVcXelie
         SJdaZiZx7WUnMqmoaBr2OQYssV+aHvzCi6692TNIOLkwyzA781yDnQ86g++N6eAnFkF2
         TiWQ==
X-Gm-Message-State: AOJu0YzEbDU0NHR+LuLmGUA6uXEWcT2OK0EgdMULIExPcIJLKVW4Yxsr
	SspC6jCMo5jmFGmkQoH9a3XgYDhh1+3MNqXGuYYARQ==
X-Google-Smtp-Source: AGHT+IHZBAPelULAadeZ+tgfK1za1Fag2h3miKMji5J7+ASDhUE9S24I3ZxuR3Mg/wcRp5duviMJ+w==
X-Received: by 2002:ad4:5fce:0:b0:66d:12a3:ec81 with SMTP id jq14-20020ad45fce000000b0066d12a3ec81mr70970qvb.62.1697654006089;
        Wed, 18 Oct 2023 11:33:26 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id w11-20020a0562140b2b00b0066cf09f5ba9sm146712qvj.131.2023.10.18.11.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 11:33:25 -0700 (PDT)
Date: Wed, 18 Oct 2023 14:33:24 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
	"Eric W. Biederman" <ebiederm@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 17/17] bloom: introduce `deinit_bloom_filters()`
Message-ID: <8942f205c84d204376033a931b1ba8a575181f1f.1697653929.git.me@ttaylorr.com>
References: <cover.1696629697.git.me@ttaylorr.com>
 <cover.1697653929.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1697653929.git.me@ttaylorr.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

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
index 50dcbb4d9b..60fa64d956 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -779,6 +779,7 @@ struct bloom_filter_settings *get_bloom_filter_settings(struct repository *r)
 void close_commit_graph(struct raw_object_store *o)
 {
 	clear_commit_graph_data_slab(&commit_graph_data_slab);
+	deinit_bloom_filters();
 	free_commit_graph(o->commit_graph);
 	o->commit_graph = NULL;
 }
@@ -2583,6 +2584,9 @@ int write_commit_graph(struct object_directory *odb,
 
 	res = write_commit_graph_file(ctx);
 
+	if (ctx->changed_paths)
+		deinit_bloom_filters();
+
 	if (ctx->split)
 		mark_commit_graphs(ctx);
 
-- 
2.42.0.415.g8942f205c8
