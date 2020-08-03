Return-Path: <SRS0=/7R8=BN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9148C433DF
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 18:57:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9D4E207DF
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 18:57:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="ux3NmyfZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbgHCS5m (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Aug 2020 14:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgHCS5l (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Aug 2020 14:57:41 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB11C06174A
        for <git@vger.kernel.org>; Mon,  3 Aug 2020 11:57:40 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id j10so11150945qvo.13
        for <git@vger.kernel.org>; Mon, 03 Aug 2020 11:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vOk5ic67xvfei8DJOzwHeQejYjg9ZmCch1Q+Sa7yk0g=;
        b=ux3NmyfZDDSF7poGfzdF8RHM8ALAvqhxK7hkOZjHAT4qkdk5JnQ3Ru8bBkLms7XB6J
         scQKlyHmd+KOiTT0nmKLLlezQz7tmckGD/iDQlRkBf9vAqG1o2UOjEEFDun2/Zwjp8up
         tSIhtAgQPkC2lQCHMqyWF7KSoIO71+QferQ4TlA2MqLucKBemXrv2UmaQuYJE0ra3lAE
         lhAOXdOstj2ionL5Vc0kCdcxLe3yrgIho+2v4oPJ6lMdTnbKr/7Sdaf2KabYIOhgy8/y
         x4vntr3hn+Kn9ha9rYHeRo/9iIYiep40zZUXvzZZXtV9tHW3foQrkswNLry6NV1mqAMU
         /++w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vOk5ic67xvfei8DJOzwHeQejYjg9ZmCch1Q+Sa7yk0g=;
        b=ACwhVXazA+1PjmOvX3mEAdCurFv/Y6tFCBfyNf9dipVklo/ssw0mhk2sTKCZwvuZd9
         OO3tKVnQLHFfM0zJwomN8LsQA8/dvJqZGE9mJu3Lulr9xAGBqYNlWyBV7RL5NMO+lb8G
         XpswkYADqdVl4uS284hKTKMlwn/QLFdupQzEfZeNAkt9bVDdh8a2OOqVnN97cOnEoO3a
         RtH42W7uIgEho1NWdCtKzWKHgB2TrDaDj6aYm1tIaZFfIKshbfwAiizLFvcJ0l7+PCjI
         6u+sO99Gh6CTImhYqPxmqlPix/xAf5rw5GkMkxA/1b1kYTx+xARetvE7qP1MaG9Uv2Wm
         TsIw==
X-Gm-Message-State: AOAM532z6rhIxLkuRlqM1mhWwkQKSsGDZ2c/Y2rjp/bxTtGdTMvUaFg9
        9WjjFTV1prlmpHD/7xFm5TGY7xnSL38bxg==
X-Google-Smtp-Source: ABdhPJwVlPjBAJnN7VIUdyePY7VcirucOIhDRnN14E+sKIPH5X5mDMsxMas3/ln+Ah05+S+DB3dsRA==
X-Received: by 2002:a0c:b604:: with SMTP id f4mr11724578qve.68.1596481059101;
        Mon, 03 Aug 2020 11:57:39 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:3475:b417:c07c:c811])
        by smtp.gmail.com with ESMTPSA id p53sm24029164qtc.85.2020.08.03.11.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 11:57:38 -0700 (PDT)
Date:   Mon, 3 Aug 2020 14:57:37 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com
Subject: [PATCH 08/10] bloom: split 'get_bloom_filter()' in two
Message-ID: <a494094c10f9bddca5743973409ccb4540841116.1596480582.git.me@ttaylorr.com>
References: <cover.1596480582.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1596480582.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

'get_bloom_filter' takes a flag to control whether it will compute a
Bloom filter if the requested one is missing. In the next patch, we'll
add yet another flag to this method, which would force all but one
caller to specify an extra 'NULL' parameter at the end.

Instead of doing this, split 'get_bloom_filter' into two functions:
'get_bloom_filter' and 'get_or_compute_bloom_filter'. The former only
looks up a Bloom filter (and does not compute one if it's missing,
thus dropping the 'compute_if_not_present' flag). The latter does
compute missing Bloom filters, with an additional parameter to store
whether or not it needed to do so.

This simplifies many call-sites, since the majority of existing callers
to 'get_bloom_filter' do not want missing Bloom filters to be computed
(so they can drop the parameter entirely and use the simpler version of
the function).

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 blame.c               |  2 +-
 bloom.c               | 13 ++++++++++---
 bloom.h               |  9 ++++++---
 commit-graph.c        |  6 +++---
 line-log.c            |  2 +-
 revision.c            |  2 +-
 t/helper/test-bloom.c |  2 +-
 7 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/blame.c b/blame.c
index 3e5f8787bc..756285fca7 100644
--- a/blame.c
+++ b/blame.c
@@ -1275,7 +1275,7 @@ static int maybe_changed_path(struct repository *r,
 	if (commit_graph_generation(origin->commit) == GENERATION_NUMBER_INFINITY)
 		return 1;
 
-	filter = get_bloom_filter(r, origin->commit, 0);
+	filter = get_bloom_filter(r, origin->commit);
 
 	if (!filter)
 		return 1;
diff --git a/bloom.c b/bloom.c
index cd9380ac62..a8a21762f4 100644
--- a/bloom.c
+++ b/bloom.c
@@ -177,9 +177,10 @@ static int pathmap_cmp(const void *hashmap_cmp_fn_data,
 	return strcmp(e1->path, e2->path);
 }
 
-struct bloom_filter *get_bloom_filter(struct repository *r,
-				      struct commit *c,
-				      int compute_if_not_present)
+struct bloom_filter *get_or_compute_bloom_filter(struct repository *r,
+						 struct commit *c,
+						 int compute_if_not_present,
+						 int *computed)
 {
 	struct bloom_filter *filter;
 	struct bloom_filter_settings settings = DEFAULT_BLOOM_FILTER_SETTINGS;
@@ -187,6 +188,9 @@ struct bloom_filter *get_bloom_filter(struct repository *r,
 	struct diff_options diffopt;
 	int max_changes = 512;
 
+	if (computed)
+		*computed = 0;
+
 	if (!bloom_filters.slab_size)
 		return NULL;
 
@@ -273,6 +277,9 @@ struct bloom_filter *get_bloom_filter(struct repository *r,
 		filter->len = 0;
 	}
 
+	if (computed)
+		*computed = 1;
+
 	free(diff_queued_diff.queue);
 	DIFF_QUEUE_CLEAR(&diff_queued_diff);
 
diff --git a/bloom.h b/bloom.h
index d8fbb0fbf1..2fdc2918f8 100644
--- a/bloom.h
+++ b/bloom.h
@@ -80,9 +80,12 @@ void add_key_to_filter(const struct bloom_key *key,
 
 void init_bloom_filters(void);
 
-struct bloom_filter *get_bloom_filter(struct repository *r,
-				      struct commit *c,
-				      int compute_if_not_present);
+struct bloom_filter *get_or_compute_bloom_filter(struct repository *r,
+						 struct commit *c,
+						 int compute_if_not_present,
+						 int *computed);
+
+#define get_bloom_filter(r, c) get_or_compute_bloom_filter((r), (c), 0, NULL)
 
 int bloom_filter_contains(const struct bloom_filter *filter,
 			  const struct bloom_key *key,
diff --git a/commit-graph.c b/commit-graph.c
index c870ffe0ed..2e765b26d5 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1214,7 +1214,7 @@ static int write_graph_chunk_bloom_indexes(struct hashfile *f,
 	uint32_t cur_pos = 0;
 
 	while (list < last) {
-		struct bloom_filter *filter = get_bloom_filter(ctx->r, *list, 0);
+		struct bloom_filter *filter = get_bloom_filter(ctx->r, *list);
 		size_t len = filter ? filter->len : 0;
 		cur_pos += len;
 		display_progress(ctx->progress, ++ctx->progress_cnt);
@@ -1253,7 +1253,7 @@ static int write_graph_chunk_bloom_data(struct hashfile *f,
 	hashwrite_be32(f, ctx->bloom_settings->bits_per_entry);
 
 	while (list < last) {
-		struct bloom_filter *filter = get_bloom_filter(ctx->r, *list, 0);
+		struct bloom_filter *filter = get_bloom_filter(ctx->r, *list);
 		size_t len = filter ? filter->len : 0;
 
 		display_progress(ctx->progress, ++ctx->progress_cnt);
@@ -1478,7 +1478,7 @@ static void compute_bloom_filters(struct write_commit_graph_context *ctx)
 			bitmap_set(ctx->bloom_large, pos);
 			ctx->count_bloom_filter_known_large++;
 		} else {
-			struct bloom_filter *filter = get_bloom_filter(ctx->r, c, 1);
+			struct bloom_filter *filter = get_or_compute_bloom_filter(ctx->r, c, 1, NULL);
 			if (!filter->len) {
 				bitmap_set(ctx->bloom_large, pos);
 				ctx->count_bloom_filter_found_large++;
diff --git a/line-log.c b/line-log.c
index c53692834d..9e58fd185a 100644
--- a/line-log.c
+++ b/line-log.c
@@ -1159,7 +1159,7 @@ static int bloom_filter_check(struct rev_info *rev,
 		return 1;
 
 	if (!rev->bloom_filter_settings ||
-	    !(filter = get_bloom_filter(rev->repo, commit, 0)))
+	    !(filter = get_bloom_filter(rev->repo, commit)))
 		return 1;
 
 	if (!range)
diff --git a/revision.c b/revision.c
index e244beed05..73b59d2134 100644
--- a/revision.c
+++ b/revision.c
@@ -756,7 +756,7 @@ static int check_maybe_different_in_bloom_filter(struct rev_info *revs,
 	if (commit_graph_generation(commit) == GENERATION_NUMBER_INFINITY)
 		return -1;
 
-	filter = get_bloom_filter(revs->repo, commit, 0);
+	filter = get_bloom_filter(revs->repo, commit);
 
 	if (!filter) {
 		count_bloom_filter_not_present++;
diff --git a/t/helper/test-bloom.c b/t/helper/test-bloom.c
index f0aa80b98e..76a28a2199 100644
--- a/t/helper/test-bloom.c
+++ b/t/helper/test-bloom.c
@@ -39,7 +39,7 @@ static void get_bloom_filter_for_commit(const struct object_id *commit_oid)
 	struct bloom_filter *filter;
 	setup_git_directory();
 	c = lookup_commit(the_repository, commit_oid);
-	filter = get_bloom_filter(the_repository, c, 1);
+	filter = get_or_compute_bloom_filter(the_repository, c, 1, NULL);
 	print_bloom_filter(filter);
 }
 
-- 
2.28.0.rc1.13.ge78abce653

