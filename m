Return-Path: <SRS0=IiYM=AE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D3BC433E0
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 17:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB705206D4
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 17:47:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GRizELV1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733203AbgFWRrS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 13:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733119AbgFWRrQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jun 2020 13:47:16 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C2AC061755
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 10:47:15 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id o8so2012432wmh.4
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 10:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=sSgnGIxsYvHWBit9NpSFFpRWHko+DGmjncngfvE17G0=;
        b=GRizELV1zXGtgXDArCzh9vhxpWH6BdElvHXzUpuYw3RsRtmFtwlKjnPuR26c1sRUk/
         inZVx5XCBxu9GdNYMZXF16WqbhVrI8RTYbNG+RY77F3CZVT2bGWVO516rgsBIXAMAghO
         wbuVwWlyXG8PR3YGBoS5UtO8J0ByG01/CtrtI9n2a/PC83m0jRoqIGSWrUmMbXpxoSnZ
         /9A6LMfytiwZXOesAGouUdy4vmqiIQ7TejTLCE+fU2MvBgIRuThhb9DLHCCj9uJiBNwq
         HNikp03zYrdBtpl3m4vIlchOUpYPKEKupHeOqBcoMgtiv64+zBIksxeiPN+CXW+Eng/I
         oOog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=sSgnGIxsYvHWBit9NpSFFpRWHko+DGmjncngfvE17G0=;
        b=rwhpWf9b2sA/UeBdnBAwkB3jDf3elvV0zjGmbSVxNere3IoQG3QbYkl6H+oWmBj2wk
         zy4ZhUa1xduXlDzMwU49mYLISTm9dO+F9OIwiqBCg86MhtsX5icXYOI3uGF09FQIgYSm
         UZ7OtVdGc7CBWufkvRZrpkDaN8h0PN8yRf++g7EqhR4YMQMqudT9J75qWGkBPHLX+dGQ
         f+N8GbM2o6bOfUE7hhH3ux70TQxdyCpj4Vz0Gkz6wsqPLz4HJzH+7TS4elVEnxcP0KO0
         nUKc2WANta8d1kSTqcgtLKmD21uvV9Pa7FEPwfu9otXYFYcg26tWpQMXyrs4aGGWpB53
         DGGw==
X-Gm-Message-State: AOAM531GUo0UlgF6FKGG/gdWp480jB2oXvGvfPnhsQlX5tFQSwKDR41L
        zDzLwDdGECbjKj2Lp34UEq5wttZl
X-Google-Smtp-Source: ABdhPJwXEiE+LlAFNCuThPttOyp7L97plwUNVPvn7JPkoqu7ZZy7adhtsYMN7QMhSHZFAKrhg/9Dbw==
X-Received: by 2002:a7b:cbc5:: with SMTP id n5mr11874663wmi.95.1592934434490;
        Tue, 23 Jun 2020 10:47:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o29sm15941117wra.5.2020.06.23.10.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 10:47:14 -0700 (PDT)
Message-Id: <492deaf916464abedc7fc2d3de41fe690a558d9b.1592934430.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.659.v2.git.1592934430.gitgitgadget@gmail.com>
References: <pull.659.git.1592252093.gitgitgadget@gmail.com>
        <pull.659.v2.git.1592934430.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 23 Jun 2020 17:47:02 +0000
Subject: [PATCH v2 03/11] bloom: get_bloom_filter() cleanups
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
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

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 bloom.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/bloom.c b/bloom.c
index c38d1cff0c..7291506564 100644
--- a/bloom.c
+++ b/bloom.c
@@ -186,7 +186,7 @@ struct bloom_filter *get_bloom_filter(struct repository *r,
 	struct diff_options diffopt;
 	int max_changes = 512;
 
-	if (bloom_filters.slab_size == 0)
+	if (!bloom_filters.slab_size)
 		return NULL;
 
 	filter = bloom_filter_slab_at(&bloom_filters, c);
@@ -194,16 +194,15 @@ struct bloom_filter *get_bloom_filter(struct repository *r,
 	if (!filter->data) {
 		load_commit_graph_info(r, c);
 		if (c->graph_pos != COMMIT_NOT_FROM_GRAPH &&
-			r->objects->commit_graph->chunk_bloom_indexes) {
-			if (load_bloom_filter_from_graph(r->objects->commit_graph, filter, c))
-				return filter;
-			else
-				return NULL;
-		}
+		    r->objects->commit_graph->chunk_bloom_indexes &&
+		    load_bloom_filter_from_graph(r->objects->commit_graph, filter, c))
+			return filter;
 	}
 
-	if (filter->data || !compute_if_not_present)
+	if (filter->data)
 		return filter;
+	if (!filter->data && !compute_if_not_present)
+		return NULL;
 
 	repo_diff_setup(r, &diffopt);
 	diffopt.flags.recursive = 1;
-- 
gitgitgadget

