Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55201CD8CB4
	for <git@archiver.kernel.org>; Tue, 10 Oct 2023 20:34:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343768AbjJJUeU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Oct 2023 16:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344150AbjJJUeE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2023 16:34:04 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69343B0
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 13:33:58 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-4195fddd6d7so2497121cf.0
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 13:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1696970037; x=1697574837; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vky+ZwHmD3rWBOf6rqDZIiCrZcxnIkK2Pg5TwQcxMGM=;
        b=ShZs/IJWVnk+WiSuVdzK1E3HGq4oub/n2ZBzKf6WIRNRp0GqMqzfggA2TwyCmrRxuC
         RlE7iSN16yVcT1hXkQcz5R8UL0OVyLR9M6AFATr91Z7TAlTjzGTtk6PwvBlYO5t/nAL6
         dDH6L1yxOo8wSjHcw0gnOvk3+9sNqUruPbiwlIUSdbwYug86i1sg+Qwb9Q+fvO/h8sEA
         ZGb3EYea5p3MMw1xz/53vk59C+uZbg6GTXZzobgqSf2LzlBB6pMNUHVp+nhHKxlLbLPt
         kdvLK7ljEuBnFiTzodf0fGj+x73WP0XwpvZ7q+1QyszsgIkTQXURu8ipacwRZwftSt6W
         xFNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696970037; x=1697574837;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vky+ZwHmD3rWBOf6rqDZIiCrZcxnIkK2Pg5TwQcxMGM=;
        b=TN+GNyhWEwhxhqOQVPqwqcqDTNmseCmHtgJDLwCq1mMc83baYz7VAFQGKg06PK67Ic
         gDnmGBCNZQeuHxS3OVTiyyM9NXeosu3C2BSsP2gHPgg/8Nqvut76/W4BGdou9bO/G+Dc
         SBTpm81imxPqJRr0LfM8LN8Ww6huorOQxwySopAX4JR07jrZkaiWH8R6aPEWPzR5h1Bn
         c3rTR5eVhwckI6IzBSPw1Zd4IvUIsP+WumVL4rrUI+SaTqweuapXi03FKfVPXZO9lqhz
         xwkYLIKAiWVRlgdA4KctWyywlcrgrTk8IR2vXfnyyZsdAZwLHUYHZuiHDM5w4DTR/TQ6
         U4LA==
X-Gm-Message-State: AOJu0YzQUjrvLpSyN3psSNYu9sbzNt11D3nWeNYRYatTZ6NtQASLqf2i
        rxUkV934BEXc3ryWoZnWTiuy2Rigr3YRaI33Vp+Aqw==
X-Google-Smtp-Source: AGHT+IF5srpGevBBOjhs2H0ODTZ+os1UaZXggwQBwKGIwNscsXY0yMOnVYZ3jtfKAFckLX9HyWks5Q==
X-Received: by 2002:a05:622a:10f:b0:403:a662:a3c1 with SMTP id u15-20020a05622a010f00b00403a662a3c1mr22923360qtw.29.1696970037211;
        Tue, 10 Oct 2023 13:33:57 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id o20-20020ac86d14000000b0041950c7f6d8sm4719147qtt.60.2023.10.10.13.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 13:33:56 -0700 (PDT)
Date:   Tue, 10 Oct 2023 16:33:55 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: [PATCH v3 12/17] bloom: prepare to discard incompatible Bloom filters
Message-ID: <2ba10a4b4b890d3c75f128a972a93889edc4f60e.1696969994.git.me@ttaylorr.com>
References: <cover.1692654233.git.me@ttaylorr.com>
 <cover.1696969994.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1696969994.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Callers use the inline `get_bloom_filter()` implementation as a thin
wrapper around `get_or_compute_bloom_filter()`. The former calls the
latter with a value of "0" for `compute_if_not_present`, making
`get_bloom_filter()` the default read-only path for fetching an existing
Bloom filter.

Callers expect the value returned from `get_bloom_filter()` is usable,
that is that it's compatible with the configured value corresponding to
`commitGraph.changedPathsVersion`.

This is OK, since the commit-graph machinery only initializes its BDAT
chunk (thereby enabling it to service Bloom filter queries) when the
Bloom filter hash_version is compatible with our settings. So any value
returned by `get_bloom_filter()` is trivially useable.

However, subsequent commits will load the BDAT chunk even when the Bloom
filters are built with incompatible hash versions. Prepare to handle
this by teaching `get_bloom_filter()` to discard filters that are
incompatible with the configured hash version.

Callers who wish to read incompatible filters (e.g., for upgrading
filters from v1 to v2) may use the lower level routine,
`get_or_compute_bloom_filter()`.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 bloom.c | 20 +++++++++++++++++++-
 bloom.h | 20 ++++++++++++++++++--
 2 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/bloom.c b/bloom.c
index 9b6a30f6f6..739fa093ba 100644
--- a/bloom.c
+++ b/bloom.c
@@ -250,6 +250,23 @@ static void init_truncated_large_filter(struct bloom_filter *filter,
 	filter->version = version;
 }
 
+struct bloom_filter *get_bloom_filter(struct repository *r, struct commit *c)
+{
+	struct bloom_filter *filter;
+	int hash_version;
+
+	filter = get_or_compute_bloom_filter(r, c, 0, NULL, NULL);
+	if (!filter)
+		return NULL;
+
+	prepare_repo_settings(r);
+	hash_version = r->settings.commit_graph_changed_paths_version;
+
+	if (!(hash_version == -1 || hash_version == filter->version))
+		return NULL; /* unusable filter */
+	return filter;
+}
+
 struct bloom_filter *get_or_compute_bloom_filter(struct repository *r,
 						 struct commit *c,
 						 int compute_if_not_present,
@@ -275,7 +292,8 @@ struct bloom_filter *get_or_compute_bloom_filter(struct repository *r,
 						     filter, graph_pos);
 	}
 
-	if (filter->data && filter->len)
+	if ((filter->data && filter->len) &&
+	    (!settings || settings->hash_version == filter->version))
 		return filter;
 	if (!compute_if_not_present)
 		return NULL;
diff --git a/bloom.h b/bloom.h
index 330a140520..bfe389e29c 100644
--- a/bloom.h
+++ b/bloom.h
@@ -110,8 +110,24 @@ struct bloom_filter *get_or_compute_bloom_filter(struct repository *r,
 						 const struct bloom_filter_settings *settings,
 						 enum bloom_filter_computed *computed);
 
-#define get_bloom_filter(r, c) get_or_compute_bloom_filter( \
-	(r), (c), 0, NULL, NULL)
+/*
+ * Find the Bloom filter associated with the given commit "c".
+ *
+ * If any of the following are true
+ *
+ *   - the repository does not have a commit-graph, or
+ *   - the repository disables reading from the commit-graph, or
+ *   - the given commit does not have a Bloom filter computed, or
+ *   - there is a Bloom filter for commit "c", but it cannot be read
+ *     because the filter uses an incompatible version of murmur3
+ *
+ * , then `get_bloom_filter()` will return NULL. Otherwise, the corresponding
+ * Bloom filter will be returned.
+ *
+ * For callers who wish to inspect Bloom filters with incompatible hash
+ * versions, use get_or_compute_bloom_filter().
+ */
+struct bloom_filter *get_bloom_filter(struct repository *r, struct commit *c);
 
 int bloom_filter_contains(const struct bloom_filter *filter,
 			  const struct bloom_key *key,
-- 
2.42.0.342.g8bb3a896ee

