Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4102C83F1E
	for <git@archiver.kernel.org>; Wed, 30 Aug 2023 18:29:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232795AbjH3S36 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Aug 2023 14:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343756AbjH3Qod (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2023 12:44:33 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC1D719A
        for <git@vger.kernel.org>; Wed, 30 Aug 2023 09:44:30 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59593051dd8so11262477b3.0
        for <git@vger.kernel.org>; Wed, 30 Aug 2023 09:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693413870; x=1694018670; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=b6hmBCSf+jsVLbO+quz67hLokPl4eNQfHa0cceH9kAM=;
        b=QJrUzFMASxALQq2uO2aEvX3L1T5aJ/AHtfoZdTbAQBZ8eV4KDY5wMjn2q5i34iT+5s
         tJkCRxIkOzX7EAZVfbgiCtZDFsyKBK/kbv5eVmMO9OhrqiGEmzj9C4uz4F8NZqatOQ4E
         Faxe80nOf2FRhZqKMY+/xfUzlWFEiJV6fRt3UzNJM902SElLSLT35Yq8CeKQmnozL6rO
         Yxq+mxKX/Ew6+e8tI1X3kqc2m/DX9wrNAJcC7jbxR/9YqCesGWJkDgjZCuMkyj4kfy0Y
         eCYVKNhjN35I9FWvUzIgs1FgYy61s3wCMD+cSidlklwBhUQhw7dCgicyvuzYB9c4hYyF
         cXQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693413870; x=1694018670;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b6hmBCSf+jsVLbO+quz67hLokPl4eNQfHa0cceH9kAM=;
        b=cJERQAeg9cLOf0UR2ukxgsmM8cGRoZIdHryPwtIxvEXQMg3w8CxOExO5y+iNzT7Q5+
         7h4KdUd/KKGn1YbwFJmjI3Tj4UOQM2jVx2ZgiA6+n8Lakh4uxOAmOwYRJx/KzVMNI6yg
         H0Y6TcCdmHBziF+9sCP+wSHXiOJd0kWarr1TTuCjbPp0dvMYZXYhYtDRqkfeAJVOkSUK
         mwr+7o7s93dq2DIBR2ohpeDkwNVVMJOb9ZhUp2yF/v0LiTjdon6IzP0t/HMc7xrSGo2O
         AkB+E3YygA30lwT5IGouXdLiokZWejKzowl3wO8PVp+XREdDseVlHjvjc0RBNlBHubYk
         OPOQ==
X-Gm-Message-State: AOJu0YycKzvr7tMiQM8fj/5f6/eS2m7T0MjTCNguNZGZE11Lcf9Uiu4T
        LIOzOSTvSZUUvWNPfLv/cFsOi66uV+mpcxfHfkzDj+/EtHmIYgsN3lmDP0DYr8zYaikXhC+cG4C
        6qUwVHu4ZZyBFNznwW3LmhgscDQJAh4L9N32Lf0CZdG90cgPPGxjYsTcj3p+bzSVVFsRWGjvzkl
        Lg
X-Google-Smtp-Source: AGHT+IEAJUrrMMflk/sbqVvVWKUO1EcVvsMMGnD5C3Civf8LYGcdTAxVpDrOiJjXki2ZqoD9Xe92+xZHOZCAjqU35U49
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:2899:32d6:b7e3:8e6e])
 (user=jonathantanmy job=sendgmr) by 2002:a81:af1b:0:b0:586:a58d:2e24 with
 SMTP id n27-20020a81af1b000000b00586a58d2e24mr79173ywh.5.1693413870005; Wed,
 30 Aug 2023 09:44:30 -0700 (PDT)
Date:   Wed, 30 Aug 2023 09:43:55 -0700
In-Reply-To: <cover.1693413637.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1692654233.git.me@ttaylorr.com> <cover.1693413637.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
Message-ID: <58a1d90e6d83506e151bba51fdddcd5cf17b9f29.1693413637.git.jonathantanmy@google.com>
Subject: [PATCH v2 15/15] bloom: introduce `deinit_bloom_filters()`
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        "SZEDER =?utf-8?B?R8OhYm9y?=" <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Taylor Blau <me@ttaylorr.com>

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
2.42.0.rc2.253.gd59a3bf2b4-goog

