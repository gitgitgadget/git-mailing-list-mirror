Return-Path: <SRS0=EAeL=AM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80FF0C433E1
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 13:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 557E8206BE
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 13:27:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DSJELQeK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731089AbgGAN1i (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jul 2020 09:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731084AbgGAN1g (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jul 2020 09:27:36 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA17C08C5C1
        for <git@vger.kernel.org>; Wed,  1 Jul 2020 06:27:35 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id j4so21378213wrp.10
        for <git@vger.kernel.org>; Wed, 01 Jul 2020 06:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=ufveTMOU4PgwU7CXupDCHbMnWVklWfJci0tSzN1i++o=;
        b=DSJELQeKSPYrRNCOxvgjm+Whu2cxEHKg6O2i3y4x4poWlMqNAfVxh4xeSuAUvva/Mt
         QjJzIRAUe2F9PTLTjYgsdaZ3TL8iHfydqZQJrFZ8o0KC3r+f8a60p8CD2iowlZjRLfZV
         Cv9dqAw/EABUAJJ84OfeaOpecKYssIr+Jx9895x1WV9+2gnVA9fMSiBVC2RxYVYJOOpy
         potjzXHMhSW4zR6cvdIqg14AOiQW6UkfYGDB1qCT909+Nq4pbmShET8PPrXTD8BHak6k
         J/cHwie3hpe80PUAvSn76Q1oYXH0mAsD5lDkDEUPbvGvV+NfJU9hsvWkYy0gh0bimFja
         VyvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=ufveTMOU4PgwU7CXupDCHbMnWVklWfJci0tSzN1i++o=;
        b=dCW6cgy/2hBrRIeCXwkzhRNk6J3/nxaKoe8VIP3hjhOM9sGYzbStQkFb6k/M3d9JJb
         TbpGUkYl6MM6nJ2H83c/Mq/KXu5nfsQUM9FieLnNhPAzP/+18HZTtLZg/TpcGRyNUW1B
         cGoXw7rpZBBgn9LFZ7J1WYkI5r3ilo6FhuN/ChQL6U4hqvTOiJT0x4gZsXfnfomUsHQL
         5IliHvCvd0aCEZjg+W4k9NQjCwhb88uXPBFSE1/YVXWbU3Za7PzHcp4XWUu298b3sTki
         mXjHD5KYaNulkQEA6alzMT7mGW3YRDUI+D8FsTYWpwV4ivKEzC/4+xbteg6jV+RWGGjK
         c5YQ==
X-Gm-Message-State: AOAM532jUaHAE9HEApm0bP9zGSTHYldpXC+KSqbtE3XyFwcLmp3yxQqN
        7/KbEjsAQJXyHlsjITq6D9IoXCdn
X-Google-Smtp-Source: ABdhPJzrCkE3UkGkXU8wXvn0VTiLwhMu4v3IeYJgtj0hixgh/dsXBw4L7MXuEao5eEyCqxxRrSHPFg==
X-Received: by 2002:adf:f104:: with SMTP id r4mr27954536wro.90.1593610054407;
        Wed, 01 Jul 2020 06:27:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n16sm7212839wra.19.2020.07.01.06.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 06:27:33 -0700 (PDT)
Message-Id: <3c532ebabc17fef9149e477b7263cbf11c4d7cb9.1593610050.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.659.v4.git.1593610050.gitgitgadget@gmail.com>
References: <pull.659.v3.git.1593174636.gitgitgadget@gmail.com>
        <pull.659.v4.git.1593610050.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 01 Jul 2020 13:27:23 +0000
Subject: [PATCH v4 03/10] bloom: fix logic in get_bloom_filter()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, szeder.dev@gmail.com, l.s.r@web.de,
        Derrick Stolee <dstolee@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The get_bloom_filter() method is a bit complicated in some parts where
it does not need to be. In particular, it needs to return a NULL filter
only when compute_if_not_present is zero AND the filter data cannot be
loaded from a commit-graph file. This currently happens by accident
because the commit-graph does not load changed-path Bloom filters from
an existing commit-graph when writing a new one. This will change in a
later patch.

Also clean up some style issues while we are here.

One side-effect of returning a NULL filter is that the filters that are
reported as "too large" will now be reported as NULL insead of length
zero. This case was not properly covered before, so add a test. Further,
remote the counting of the zero-length filters from revision.c and the
trace2 logs.

Helped-by: René Scharfe <l.s.r@web.de>
Helped-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 bloom.c              | 14 ++++++--------
 commit-graph.c       |  8 ++++++--
 revision.c           |  7 -------
 t/t4216-log-bloom.sh | 24 ++++++++++++++++++++++--
 4 files changed, 34 insertions(+), 19 deletions(-)

diff --git a/bloom.c b/bloom.c
index c38d1cff0c..2af5389795 100644
--- a/bloom.c
+++ b/bloom.c
@@ -186,7 +186,7 @@ struct bloom_filter *get_bloom_filter(struct repository *r,
 	struct diff_options diffopt;
 	int max_changes = 512;
 
-	if (bloom_filters.slab_size == 0)
+	if (!bloom_filters.slab_size)
 		return NULL;
 
 	filter = bloom_filter_slab_at(&bloom_filters, c);
@@ -194,16 +194,14 @@ struct bloom_filter *get_bloom_filter(struct repository *r,
 	if (!filter->data) {
 		load_commit_graph_info(r, c);
 		if (c->graph_pos != COMMIT_NOT_FROM_GRAPH &&
-			r->objects->commit_graph->chunk_bloom_indexes) {
-			if (load_bloom_filter_from_graph(r->objects->commit_graph, filter, c))
-				return filter;
-			else
-				return NULL;
-		}
+		    r->objects->commit_graph->chunk_bloom_indexes)
+			load_bloom_filter_from_graph(r->objects->commit_graph, filter, c);
 	}
 
-	if (filter->data || !compute_if_not_present)
+	if (filter->data)
 		return filter;
+	if (!compute_if_not_present)
+		return NULL;
 
 	repo_diff_setup(r, &diffopt);
 	diffopt.flags.recursive = 1;
diff --git a/commit-graph.c b/commit-graph.c
index 6a28d4a5a6..50ce039a53 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1098,7 +1098,8 @@ static void write_graph_chunk_bloom_indexes(struct hashfile *f,
 
 	while (list < last) {
 		struct bloom_filter *filter = get_bloom_filter(ctx->r, *list, 0);
-		cur_pos += filter->len;
+		size_t len = filter ? filter->len : 0;
+		cur_pos += len;
 		display_progress(progress, ++i);
 		hashwrite_be32(f, cur_pos);
 		list++;
@@ -1126,8 +1127,11 @@ static void write_graph_chunk_bloom_data(struct hashfile *f,
 
 	while (list < last) {
 		struct bloom_filter *filter = get_bloom_filter(ctx->r, *list, 0);
+		size_t len = filter ? filter->len : 0;
 		display_progress(progress, ++i);
-		hashwrite(f, filter->data, filter->len * sizeof(unsigned char));
+
+		if (len)
+			hashwrite(f, filter->data, len * sizeof(unsigned char));
 		list++;
 	}
 
diff --git a/revision.c b/revision.c
index c644c66091..7339750af1 100644
--- a/revision.c
+++ b/revision.c
@@ -633,7 +633,6 @@ static unsigned int count_bloom_filter_maybe;
 static unsigned int count_bloom_filter_definitely_not;
 static unsigned int count_bloom_filter_false_positive;
 static unsigned int count_bloom_filter_not_present;
-static unsigned int count_bloom_filter_length_zero;
 
 static void trace2_bloom_filter_statistics_atexit(void)
 {
@@ -641,7 +640,6 @@ static void trace2_bloom_filter_statistics_atexit(void)
 
 	jw_object_begin(&jw, 0);
 	jw_object_intmax(&jw, "filter_not_present", count_bloom_filter_not_present);
-	jw_object_intmax(&jw, "zero_length_filter", count_bloom_filter_length_zero);
 	jw_object_intmax(&jw, "maybe", count_bloom_filter_maybe);
 	jw_object_intmax(&jw, "definitely_not", count_bloom_filter_definitely_not);
 	jw_object_intmax(&jw, "false_positive", count_bloom_filter_false_positive);
@@ -735,11 +733,6 @@ static int check_maybe_different_in_bloom_filter(struct rev_info *revs,
 		return -1;
 	}
 
-	if (!filter->len) {
-		count_bloom_filter_length_zero++;
-		return -1;
-	}
-
 	result = bloom_filter_contains(filter,
 				       revs->bloom_key,
 				       revs->bloom_filter_settings);
diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
index c7011f33e2..2761208e74 100755
--- a/t/t4216-log-bloom.sh
+++ b/t/t4216-log-bloom.sh
@@ -60,7 +60,7 @@ setup () {
 
 test_bloom_filters_used () {
 	log_args=$1
-	bloom_trace_prefix="statistics:{\"filter_not_present\":0,\"zero_length_filter\":0,\"maybe\""
+	bloom_trace_prefix="statistics:{\"filter_not_present\":0,\"maybe\""
 	setup "$log_args" &&
 	grep -q "$bloom_trace_prefix" "$TRASH_DIRECTORY/trace.perf" &&
 	test_cmp log_wo_bloom log_w_bloom &&
@@ -142,7 +142,7 @@ test_expect_success 'setup - add commit-graph to the chain with Bloom filters' '
 
 test_bloom_filters_used_when_some_filters_are_missing () {
 	log_args=$1
-	bloom_trace_prefix="statistics:{\"filter_not_present\":3,\"zero_length_filter\":0,\"maybe\":8,\"definitely_not\":6"
+	bloom_trace_prefix="statistics:{\"filter_not_present\":3,\"maybe\":8,\"definitely_not\":6"
 	setup "$log_args" &&
 	grep -q "$bloom_trace_prefix" "$TRASH_DIRECTORY/trace.perf" &&
 	test_cmp log_wo_bloom log_w_bloom
@@ -152,4 +152,24 @@ test_expect_success 'Use Bloom filters if they exist in the latest but not all c
 	test_bloom_filters_used_when_some_filters_are_missing "-- A/B"
 '
 
+test_expect_success 'correctly report changes over limit' '
+	git init 513changes &&
+	(
+		cd 513changes &&
+		for i in $(test_seq 1 513)
+		do
+			echo $i >file$i.txt || return 1
+		done &&
+		git add . &&
+		git commit -m "files" &&
+		git commit-graph write --reachable --changed-paths &&
+		for i in $(test_seq 1 513)
+		do
+			git -c core.commitGraph=false log -- file$i.txt >expect &&
+			git log -- file$i.txt >actual &&
+			test_cmp expect actual || return 1
+		done
+	)
+'
+
 test_done
\ No newline at end of file
-- 
gitgitgadget

