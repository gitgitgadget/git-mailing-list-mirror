Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F6CCC00528
	for <git@archiver.kernel.org>; Mon,  7 Aug 2023 16:38:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbjHGQih (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Aug 2023 12:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232048AbjHGQiS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2023 12:38:18 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AA321BF0
        for <git@vger.kernel.org>; Mon,  7 Aug 2023 09:37:50 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-58969d4f1b6so3974957b3.2
        for <git@vger.kernel.org>; Mon, 07 Aug 2023 09:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1691426269; x=1692031069;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6hNgaqdkXVqYDmmToyvEtrm4AFGkngfyVKUn0kaylRY=;
        b=w7FCWjlgKsZNJrdTaaTLLmsksZbQ3T02oX/c1aXK5TWKA9gGGIjGICxjsoxMQp5Dyc
         SF1gWGM1QShHcbKJj3Zc+asWb8UBr6x37WUTiWnyBjkCBCmq9Qlo0+c3PwMfc1CL3OFi
         ndOZg7yTDIk6eCuSU1/ymBMgcIka9meRAERZBKF0JbRjBo8leqUwZxEJcvfbFBqo/6Dh
         JAv1SCWUNC6YT9PwPWafA+hLnfloa2Bg1h8PtMyW2yYKC6WFbWK2/iqUKH0YTb4sBEuO
         PqHVA39Ia6W53CrkLdbhqZtnzQLnnBfbJqYy2YNznDAPSjnXoa9fEcq7I+Z9bQ+WQh3s
         2abA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691426269; x=1692031069;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6hNgaqdkXVqYDmmToyvEtrm4AFGkngfyVKUn0kaylRY=;
        b=jxsp4YYi2KGHGz5MclMY9T91Nwpo0JgIN2DQ7Vjt0TEC4TyqemZV4QmRdEKgGRnvhy
         giFIA2Qxc8cuxtENyLHy2wZhqGMnskSLp60FrLbPk8uqnXn8m9dpbqOQyHJhjW0I8HcP
         gxdSFjKCU12x7lbAfMyQm/WaO844B1TyXcNvkQ7SR6a4BwfKL+AOmroyevuDZ3EOT6HL
         y4At0+3em0pnm2LbjVPk6o7lFhdo3NK7rVyNW4V8B0z+xfDUPcRSw2fM4CKIAPBAP9Bl
         WZyAAnVGUNMOH2Sz9XWrx4Td9rCF0HOVTkpHDuF5fZq48UxV7z67+BxHzi83rODzqPtk
         BfWA==
X-Gm-Message-State: AOJu0YxY/P28gL7+1POmtLP8sn87DJB7j7cpt6FsV0784ZmVCWOckc0i
        suRNbIWSlLh0YKoTiE9Je12CEcUTAtAOKIR1qOif0w==
X-Google-Smtp-Source: AGHT+IFZrhcXcGUV1wPYqc8twG0voE1LkCBJx5Tv6LeumP/dWdf7wZ5cgOfuZiwPNOLF3QrKSgxPvw==
X-Received: by 2002:a81:8ac7:0:b0:576:a603:e733 with SMTP id a190-20020a818ac7000000b00576a603e733mr11897607ywg.22.1691426268807;
        Mon, 07 Aug 2023 09:37:48 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id v184-20020a0dd3c1000000b00586a3283e64sm2707007ywd.143.2023.08.07.09.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 09:37:48 -0700 (PDT)
Date:   Mon, 7 Aug 2023 12:37:47 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [RFC PATCH 2/6] bloom: prepare to discard incompatible Bloom filters
Message-ID: <a4cb5fe69247ba737a8373948c1f4ff8a150d283.1691426160.git.me@ttaylorr.com>
References: <cover.1691426160.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1691426160.git.me@ttaylorr.com>
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
index 330a140520..2b1c124bb5 100644
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
+ *   - the repository does not have a commit-graph
+ *   - it has a commit-graph, but reading the commit-graph is disabled
+ *   - the given commit does not have a Bloom filter computed
+ *   - there is a Bloom filter for commit "c", but it cannot be read because
+ *     disabled
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
2.41.0.407.g6d1c33951b

