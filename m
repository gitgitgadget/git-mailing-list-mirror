Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64323EE49A6
	for <git@archiver.kernel.org>; Mon, 21 Aug 2023 21:44:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbjHUVo6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Aug 2023 17:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231183AbjHUVoz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2023 17:44:55 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6222123
        for <git@vger.kernel.org>; Mon, 21 Aug 2023 14:44:48 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-58c5642701fso43854607b3.0
        for <git@vger.kernel.org>; Mon, 21 Aug 2023 14:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1692654288; x=1693259088;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eIyUsHtsDpp7Haa++pzGZqnhdSljz2LPLeXiNQz8j1Q=;
        b=TtnbVh+l1CIPd9Y+KvyglYP+hTslA6tFXOAai7gVv57JW4WPmkwdboV7nvpQJIpPh5
         fwREYOn2sImEf3v3wQRef+WfAEHz8naSi5OyzphC5v35kGHNRwMfgf6U1jGwWwplRVkK
         cBnJ/izUHIgxSh+8DWbF7O/M+xQT2xbe52r9Av1Em90FQZRQXsoSaL408HCpYmlygzxx
         jj78Q4DPHm9tq1eWfm0NELzTUez71VxPesoh8LD8pmsaXthBznaPZpeHJ3R36UnyHcDR
         EHQ0SvhdKx3HHg8cl7ju0CvL4L3w4yLkXTauwcH8f6Anm0r2OX9xe32IUmNqMB3YFKgB
         tjlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692654288; x=1693259088;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eIyUsHtsDpp7Haa++pzGZqnhdSljz2LPLeXiNQz8j1Q=;
        b=HCmxXbGU7HIA7fk9TyIjOWoWSGmp9RlWdeDw62BgvRmCAwUPHeYpl/vdciLkX/x96z
         Ank9KU/N1X8sc9BK7eRHRfJCgg7LWedcg9P9b2Z1nXmSPSBqYUSjpJwdj4QMJWOeEZS9
         ou3hQ2tmu9igQdcgifvTagJQ/CKVl/17viEiNXw9q8oG8Vonz+n1fByXcnPGK3HmzCw4
         6E+MaQnIN9X1modHhoiijtOWsqDWSLC6OfbLcvu5/5tZY7EXRglWd9/vpLi2WTI0Xt95
         8U0DHhz7ueNSEropVf2+m/1z+zi7UZd/xf1qoY64rA9IKRGJewMFkbvoHchSzwR28NEF
         LX1A==
X-Gm-Message-State: AOJu0Yw0tDJKWs5NPVS+wh/FR9gWgeWGiBnEBvWKKwbGvvBK0sOBkPp+
        CaBbYJkAAjAwSOUIBWMxfUnJtqIS6MJehqOLnPq3WA==
X-Google-Smtp-Source: AGHT+IEqfMYqjP64ZqtlJ2HrOMGYvEipqU3g192GkvWTDHYO6ojQzDNM8ahq84J+2UJu+2MMOKZCyQ==
X-Received: by 2002:a0d:ccc2:0:b0:58c:f957:d1c4 with SMTP id o185-20020a0dccc2000000b0058cf957d1c4mr7888390ywd.36.1692654287899;
        Mon, 21 Aug 2023 14:44:47 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id t125-20020a0dd183000000b005837fe8dbe8sm2435897ywd.8.2023.08.21.14.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 14:44:47 -0700 (PDT)
Date:   Mon, 21 Aug 2023 17:44:46 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>
Subject: [PATCH 15/15] bloom: introduce `deinit_bloom_filters()`
Message-ID: <eed1e1a32af0ad343023a5143722226d2ef595bb.1692654233.git.me@ttaylorr.com>
References: <cover.1692654233.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1692654233.git.me@ttaylorr.com>
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
index a3473df515..585539da2f 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -723,6 +723,7 @@ static void close_commit_graph_one(struct commit_graph *g)
 void close_commit_graph(struct raw_object_store *o)
 {
 	close_commit_graph_one(o->commit_graph);
+	deinit_bloom_filters();
 	o->commit_graph = NULL;
 }
 
@@ -2523,6 +2524,9 @@ int write_commit_graph(struct object_directory *odb,
 
 	res = write_commit_graph_file(ctx);
 
+	if (ctx->changed_paths)
+		deinit_bloom_filters();
+
 	if (ctx->split)
 		mark_commit_graphs(ctx);
 
-- 
2.42.0.4.g52b49bb434
