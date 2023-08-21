Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D418EE4996
	for <git@archiver.kernel.org>; Mon, 21 Aug 2023 21:44:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbjHUVoc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Aug 2023 17:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbjHUVoa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2023 17:44:30 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FEE9197
        for <git@vger.kernel.org>; Mon, 21 Aug 2023 14:44:27 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-58fc4eaa04fso25543427b3.0
        for <git@vger.kernel.org>; Mon, 21 Aug 2023 14:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1692654266; x=1693259066;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BxFnySS/I+7iqAJ3evyX3JM4TeSu6TWvOmMqyNnJz1w=;
        b=j068tic6DRqKPPBSXBs7O9MV9IF4Rfh0tOglpT+cuvPrEMP87BofaCWaKDo+UMFkhK
         M5O7oeWCV2+6VJIDDZdNvvCCKc22cvEAN84xvojHJseM0TufMkzNHSvOPo1FCAmnfeun
         dAmRp+U+2WNYjDlnQrWFbZM2RGBRAmyYm4eR0m6Ejdp9OwGys+strOvwgqEvugU4ZMuh
         javsoivlCEI0gkuVv5dTNKXj3Ph9YN+LspXaQxwhajtKEixnIkTDhJy1QVlEWgEsGNdP
         N/p+wc6Wj3W//5eaHGjudRzIIoyu06oHm95f+hInnVtaDjXaKDCe0HNjUhYH8aMnPptB
         KDMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692654266; x=1693259066;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BxFnySS/I+7iqAJ3evyX3JM4TeSu6TWvOmMqyNnJz1w=;
        b=gLu3RsFIzccJ2wQ1B96CP2Jic78goyvV+lmDWbGoKleBfvrJpl6mALZoAEaP3iBxH+
         +C8H0QpXSLUW4gurP7gfEE9jD+sIX+fmh1jqHc2iPILGT5FWGs+WLKJkq5dLTZiKKJ5p
         0hwT5K1D1ynKaF/XZzn6ov0eSBsgqQdGrCCq9BOv8f8TL2E1D1gcwb26xV35XhPjPKBW
         mZtf7BZYBxnLYW0P7d0k2VUAHLiXxp4SaX5lk5vlg/TyQ1jgSepMuJO0+1eJmKsqhGi7
         pn+UtuDQAF7fjZ0+zuwiOLAredr2g0sUnT21WGvxUYhWbDvn8JBYJnV9TZ0BxjYRCT4j
         BCzA==
X-Gm-Message-State: AOJu0YxVniKJ9riG4ouDyCLkvLbNRLbzQy7XltkxAaFLvnpreaQXjQch
        JHpXPRACgxWADS+0Uqhh/PUMAVSQvi2cfc0mvyyRVw==
X-Google-Smtp-Source: AGHT+IFGVPIzE7Ija5o+UJtX7EuLjpSnkHbAA4ECDJeNCz3DTois1Y3tcOLDT7t6MMCCz3Aq1+q7nQ==
X-Received: by 2002:a81:d346:0:b0:58c:d790:b129 with SMTP id d6-20020a81d346000000b0058cd790b129mr7841339ywl.46.1692654266188;
        Mon, 21 Aug 2023 14:44:26 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id s67-20020a817746000000b0057a05834754sm2455566ywc.75.2023.08.21.14.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 14:44:25 -0700 (PDT)
Date:   Mon, 21 Aug 2023 17:44:25 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>
Subject: [PATCH 09/15] bloom: prepare to discard incompatible Bloom filters
Message-ID: <7c5a0090b52f829cab3ab2e107029a74b7ecfa87.1692654233.git.me@ttaylorr.com>
References: <cover.1692654233.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1692654233.git.me@ttaylorr.com>
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
2.42.0.4.g52b49bb434

