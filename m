Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7478247368
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 18:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="HqiwmHRW"
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39CD311A
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 11:33:06 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-77891f362cfso94159185a.1
        for <git@vger.kernel.org>; Wed, 18 Oct 2023 11:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1697653985; x=1698258785; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/NdqeADlm8MlHqMkDFkBT34FdrCZHUx2vMpvbO2dIUI=;
        b=HqiwmHRW6rOPP69aumUPeLm9WpCKbQ/W5Zscji/LaLbtMs5y1UiwSKAU4bm/ISNOtY
         6nROp7G7zSOOwuKOypAYI7xmWUjBYqfGzQSJwQgnlTzRWyX/cmydDlyTJ3oVU4r0Wz5p
         IFUxyV761bhIhCsDnGOeg3ZUUg5SFdxcF8qk6pgfoLDeBqCWCWw0RCvB2P6eNM9ECOE0
         AYJU8aTFNCK1WQ9IGHlpHHvbmG/xgeoUS1Srqx11VnVyFGGIA0gUvK+Tk6e1VhucgVZg
         OwyYeBWiVyMJZZR8ljJtHb6NQmlW7yUWQOkgtNHPc8kbZCbnObrskOEMwQgyhkyBpUM6
         hv+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697653985; x=1698258785;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/NdqeADlm8MlHqMkDFkBT34FdrCZHUx2vMpvbO2dIUI=;
        b=qj2nZ2QFr4wQ62T+TR6Ho9bfkdjQDEkIlrX85fXEywcoRl2qtFGzDgMGU2uoajuInJ
         8K3CZQdfyoIWRcVhmRk5nsyGkyQQX657ghoJC8idhFDvc+18KTcBOq2MbghkVhSZY1yc
         SPvxkSZvIPGldxmHuaPiRlAsPJIHsuL5ao7BWKEvCqGTMFlNjhJdr5mp7HySRPtPALxH
         3r0OEB9z4azBuFqTek/YBal7AmC+ryYujrWtNom38cdID07hOrW9KtFH3da2l6oKdXh0
         saKy9bjvFfY4ZTyEakGQxu/e8LGU8m5yWvMMm5hMb0B/TrhGgpJtp2hDqYYTBw/3JeZt
         e2aw==
X-Gm-Message-State: AOJu0YyuyV4CpFy9++VGg6r/iAw+jQT94kzFWjgkzkDYXMmO+c8vIvsH
	j4p/veP2CrL7rHfbmBfOjyIlTkNr+2Xz9MAwpyTH/g==
X-Google-Smtp-Source: AGHT+IHF25VkaUbYLk9LUwUOtNY258TRVEShZ2+p7CPiIMY6VfzbNjkdF7LZ0GnZ9AKhkYB54gM0bQ==
X-Received: by 2002:a05:620a:24c2:b0:775:c335:1f2a with SMTP id m2-20020a05620a24c200b00775c3351f2amr233071qkn.38.1697653985152;
        Wed, 18 Oct 2023 11:33:05 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id p19-20020a05620a22f300b00777063b89casm155978qki.5.2023.10.18.11.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 11:33:04 -0700 (PDT)
Date: Wed, 18 Oct 2023 14:33:03 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
	"Eric W. Biederman" <ebiederm@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 11/17] bloom: annotate filters with hash version
Message-ID: <dc69b28329557a6a090cd54dd34d7032462a7155.1697653929.git.me@ttaylorr.com>
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
2.42.0.415.g8942f205c8

