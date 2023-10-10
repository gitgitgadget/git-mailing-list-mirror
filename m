Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E506CD8CB4
	for <git@archiver.kernel.org>; Tue, 10 Oct 2023 20:34:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343810AbjJJUeX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Oct 2023 16:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344066AbjJJUeC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2023 16:34:02 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D00116
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 13:33:55 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-65af726775eso2455776d6.0
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 13:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1696970034; x=1697574834; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YWjvb9Lx38HM1iTNYnkLxQZJ8NbC5I79r8imatKSbIk=;
        b=cDAyUPIYG5lWlcKCyAjsUih8avoqQwylWBkMTwu/E3CMJ6s530qk/RsVRbq/qcj6Sl
         za3Q+z0Vr8oyxiS8ltF92H25twS7UyajrKkNORWEYsQqyOXVilgY5wX2zvWgxnrHZYmv
         RwhlyfujTuomk0exnxxcxhmNdLX2c7YAVz2svfZRK1aOQMDj0TzpdUp/o2f2qMvb9u9O
         ZmpGCbYBsZPgD7KVEVuh8f4ts8XHy52sP2yEiL2LKeoAL2VimetfkzuJP6A+D1E8uvHk
         vpXjqs7XCGL35t1xdo4nQVYEN2PIAafgqvY1dzOKb/m70doDyypr42sWjqgZVzvRHHh6
         WJnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696970034; x=1697574834;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YWjvb9Lx38HM1iTNYnkLxQZJ8NbC5I79r8imatKSbIk=;
        b=GvIsXjdINNhWXBZLHa1fmChsc82KKW7a6M/DZ2Vtn8vvQPYXyxCdKfn7ipTZ42D5SQ
         BiSvre6/QCAxtvOKCgyP2fLGiEu5SpIU/ejywV/7zfVqmr7Q8Gb/n376tE1YcPpEDK3I
         aR9Z/8XhjMFrNKWA0xNUbNBLClMd7ZfK5c6ngKWzB/Kn3uKYOOZc97988GVbVXv4Yil9
         hG9DpgbXMfY8wgpaVYJF+k20VWaq+T9iEnDFmVkFIDOnWgld+t/7MOq8BArsRmQAzoTh
         fh/0WlsbnnuIWzTsr7I8XrZME2I7K/KzOHIk/O6ugcY+6EtRqDbgwv3bnDYts7lq2eFz
         i/lA==
X-Gm-Message-State: AOJu0YyN1Yz1eiVY17LSpURW/QdA8Q/Hf1FnOfX+9MCkIyClen7wO7GM
        DlkhjmDFtVdXUPOqr/DWunMxt/pbzWVcS9BeAD/Gsw==
X-Google-Smtp-Source: AGHT+IEAFBBL9gpZc346P+9dE9ZR8kXsGvsCU0TNDVBEJlg+vj0PlXc+8nT1I1n3oj0znznbSrsgYQ==
X-Received: by 2002:a05:6214:2a4e:b0:62d:ddeb:3770 with SMTP id jf14-20020a0562142a4e00b0062dddeb3770mr23512649qvb.0.1696970034179;
        Tue, 10 Oct 2023 13:33:54 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id t10-20020a0ca68a000000b0065afcf19e23sm5015025qva.62.2023.10.10.13.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 13:33:53 -0700 (PDT)
Date:   Tue, 10 Oct 2023 16:33:52 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: [PATCH v3 11/17] bloom: annotate filters with hash version
Message-ID: <a8c10f8de83eddb9a0d3e39bd31bf30808cb59ce.1696969994.git.me@ttaylorr.com>
References: <cover.1692654233.git.me@ttaylorr.com>
 <cover.1696969994.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1696969994.git.me@ttaylorr.com>
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
2.42.0.342.g8bb3a896ee

