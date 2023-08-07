Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D59CC00528
	for <git@archiver.kernel.org>; Mon,  7 Aug 2023 16:38:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231829AbjHGQiv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Aug 2023 12:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232009AbjHGQiP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2023 12:38:15 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A7AE1BD7
        for <git@vger.kernel.org>; Mon,  7 Aug 2023 09:37:47 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-586b78aa26eso29990877b3.1
        for <git@vger.kernel.org>; Mon, 07 Aug 2023 09:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1691426266; x=1692031066;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u7BObONqmKh/FzXouG+OOan/qZulTKn7Z1vuUuvDeqs=;
        b=ULNKDVamnJjNOq/41VhKsXotgASN0FJyB7WmDa4qb30nA9UkoYD/MB8qbeWKgW4BsL
         hMD0i1BmSpcxcIbDxI4UgQeKzEp01ATxHJrfj9Gg20SiUpwY89q42YRWNcHKSFrtGmFK
         WmwBrAtskpFQvcyuA8qEfUksMXUmcI6U350w5oXBsfcRqNboHWfw5MuOYQoG9wRZliXW
         XeEQuPfCfiMVOEZjOginAd/lA4ZJv9V7GqopD6hCP8vMvd8vHaldqiwu6jAp/VAXMuuV
         8cIjmHYO4BnKPc7t3lj1WPOaGNlmX/2CHSXwyULCASjmvXjSlhzNfxwl4UfOloO3i72h
         HD/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691426266; x=1692031066;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u7BObONqmKh/FzXouG+OOan/qZulTKn7Z1vuUuvDeqs=;
        b=jJ5d21lkWJkPsbLwONh52J1eZaxuZt1ZEnsvNRBDl8ovbeG38cuBt4AIp7Rcfhuw7O
         5WKId6z1WdYa2PXK7dqs3uHOrBZ+1hqHu5+xl78agUGLlfwJ9XLZDjQfbQ2gbTDlNb4K
         4s6awL9wYkHi2ym3pla8tKyRjS6tDg2/3ZsB2VEhrdx1cnhNkwNoHhTcW4+1/glxTAB/
         ZKAZ+6TT7w6mmJUc34bvuCmA9t/UHd6i63GSqt3OjHTO5m3JEapTR/07xBo5aEabWSKK
         7OU1bmzC+Tce2CjaR/b1pj68jh55mk+ERlbokDueMfEUiyTayTz9XDBrq6pT6HcH/aho
         p7vw==
X-Gm-Message-State: AOJu0YyVvKBQLNC5NjgTlMkZpcX4OGShXti6N97VOj5l+RHoMYYMFaMy
        bM6sgjwfYbjiVXCNaw4vpac+HoVqHJZh9gs+ciDF8g==
X-Google-Smtp-Source: AGHT+IE5+Bb9Mwe5UWrfXnRLcyPSdFXD+UwNIyfxDPM0mz8LtcuWWLKymYxEWSnllaeAYHsJ0LYZKw==
X-Received: by 2002:a0d:fd87:0:b0:577:1909:ee16 with SMTP id n129-20020a0dfd87000000b005771909ee16mr12394817ywf.30.1691426266158;
        Mon, 07 Aug 2023 09:37:46 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id m12-20020a819e0c000000b00545a08184cesm2806600ywj.94.2023.08.07.09.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 09:37:45 -0700 (PDT)
Date:   Mon, 7 Aug 2023 12:37:45 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [RFC PATCH 1/6] bloom: annotate filters with hash version
Message-ID: <e23a956401c5619bd46e8ec9b0e1df958cbcbfec.1691426160.git.me@ttaylorr.com>
References: <cover.1691426160.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1691426160.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In subsequent commits, we will want to load existing Bloom filters out
of a commit-graph, even when the hash version they were computed with
does not match the value of `commitGraph.changedPathVersion`.

In order to differentiate between the two, add a "filter" field to each
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
2.41.0.407.g6d1c33951b

