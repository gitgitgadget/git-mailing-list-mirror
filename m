Return-Path: <SRS0=vH5l=CZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB4BEC433E2
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 18:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6907B20838
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 18:07:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="LqvmniE5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727710AbgIPSHw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Sep 2020 14:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727646AbgIPSHc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Sep 2020 14:07:32 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58AD8C061756
        for <git@vger.kernel.org>; Wed, 16 Sep 2020 11:07:31 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id h6so6861269qtd.6
        for <git@vger.kernel.org>; Wed, 16 Sep 2020 11:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kJmFu6amOf+j9yAsUT2d9jTiADgXE3/HBBFXOzZpDx4=;
        b=LqvmniE54GCrqph+GfZSJlyJ676Mreq4bGFrhHhNEkfRrtvtPGqc1Pa3sRjIxd9jHt
         AiZ0QdNNesHKK4aYz/V/bv2K+UWdaPk6U6O4hLzoGmV1w1BNA4rHMAwKlziMCMUN8HAA
         MIImWlgIB9yzvc5KphbXVaZyaUMsY5cDyF9sm2lkrZ1YASr0ZrXd1dCom5al7GW/omjb
         Kxe+SlHdMwcD/LHDyp8xO306dJZKeyvukC+uy0ABLOSSvoPvJ277S+bxaOxaJJR/LyHu
         UTjycQ7VZf96bwldclcrrP8rlAA+GYaNIycfvBSENhZEVty1A/psawao+XudGl+2jll3
         3oFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kJmFu6amOf+j9yAsUT2d9jTiADgXE3/HBBFXOzZpDx4=;
        b=YYi9Qmv5LpORI1MvTaxL2P/XW6YEv9BU6ebc1YWeHdcwJBpEb1eeH3jzy7kYv5zP4W
         2DQX6W3MHv9fiWiB0iZooganmbVomKC13r6Gtv8HSkJ5aE27FzuO+uyhcvqctq9jamsH
         cq7W0DnnjXD6PxeH0ytIOlkLucqoNjJttm8qow1REWz5YBSO9zdCyIjPpKq0cZMly1um
         P1g20tnyhl1ysS43HJHXhjEZRUIkNQzbWQ9Tj3JFlDgu/aXynl3rmQ0j0idK8MQzfMnU
         JbUgBFfELMH0wxyUOn1LJo/w2e421wfDCsPbiNARHLQLANS6UDDlXPGoGaAyrqcYuslX
         RyGg==
X-Gm-Message-State: AOAM533ig4Ro7cUjl66YfBRdiKysml6XKKRlTXLfbPDxn5XbDx+Bl0LO
        pMxStfYPFZ7+dApvmB+PYa+57HrhGTBIrXaa
X-Google-Smtp-Source: ABdhPJxdE136vdRoqqlN+TMrs+jct+myU+NMb/QAd2NWc4oNQ+QA2ePRw97oVLZGvhtlhquphJjKhg==
X-Received: by 2002:ac8:7219:: with SMTP id a25mr25057194qtp.4.1600279650048;
        Wed, 16 Sep 2020 11:07:30 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:e86e:6adf:7537:ae24])
        by smtp.gmail.com with ESMTPSA id x124sm20164972qkd.72.2020.09.16.11.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 11:07:29 -0700 (PDT)
Date:   Wed, 16 Sep 2020 14:07:26 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net,
        szeder.dev@gmail.com
Subject: [PATCH v2 06/13] commit-graph.c: store maximum changed paths
Message-ID: <dcc6769ca9fcf3496f266c9131ac355ad422642f.1600279373.git.me@ttaylorr.com>
References: <cover.1599664389.git.me@ttaylorr.com>
 <cover.1600279373.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1600279373.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For now, we assume that there is a fixed constant describing the
maximum number of changed paths we are willing to store in a Bloom
filter.

Prepare for that to (at least partially) not be the case by making it a
member of the 'struct bloom_filter_settings'. This will be helpful in
the subsequent patches by reducing the size of test cases that exercise
storing too many changed paths, as well as preparing for an eventual
future in which this value might change.

This patch alone does not cause newly generated Bloom filters to use
a custom upper-bound on the maximum number of changed paths a single
Bloom filter can hold, that will occur in a later patch.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 bloom.h              | 11 ++++++++++-
 commit-graph.c       |  3 +++
 t/t4216-log-bloom.sh |  4 ++--
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/bloom.h b/bloom.h
index d8fbb0fbf1..0b9b59a6fe 100644
--- a/bloom.h
+++ b/bloom.h
@@ -28,9 +28,18 @@ struct bloom_filter_settings {
 	 * that contain n*b bits.
 	 */
 	uint32_t bits_per_entry;
+
+	/*
+	 * The maximum number of changed paths per commit
+	 * before declaring a Bloom filter to be too-large.
+	 *
+	 * Not written to the commit-graph file.
+	 */
+	uint32_t max_changed_paths;
 };
 
-#define DEFAULT_BLOOM_FILTER_SETTINGS { 1, 7, 10 }
+#define DEFAULT_BLOOM_MAX_CHANGES 512
+#define DEFAULT_BLOOM_FILTER_SETTINGS { 1, 7, 10, DEFAULT_BLOOM_MAX_CHANGES }
 #define BITS_PER_WORD 8
 #define BLOOMDATA_CHUNK_HEADER_SIZE 3 * sizeof(uint32_t)
 
diff --git a/commit-graph.c b/commit-graph.c
index ea54d108b9..55af498aa0 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1201,6 +1201,7 @@ static void trace2_bloom_filter_settings(struct write_commit_graph_context *ctx)
 	jw_object_intmax(&jw, "hash_version", ctx->bloom_settings->hash_version);
 	jw_object_intmax(&jw, "num_hashes", ctx->bloom_settings->num_hashes);
 	jw_object_intmax(&jw, "bits_per_entry", ctx->bloom_settings->bits_per_entry);
+	jw_object_intmax(&jw, "max_changed_paths", ctx->bloom_settings->max_changed_paths);
 	jw_end(&jw);
 
 	trace2_data_json("bloom", ctx->r, "settings", &jw);
@@ -1669,6 +1670,8 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 							      bloom_settings.bits_per_entry);
 		bloom_settings.num_hashes = git_env_ulong("GIT_TEST_BLOOM_SETTINGS_NUM_HASHES",
 							  bloom_settings.num_hashes);
+		bloom_settings.max_changed_paths = git_env_ulong("GIT_TEST_BLOOM_SETTINGS_MAX_CHANGED_PATHS",
+							  bloom_settings.max_changed_paths);
 		ctx->bloom_settings = &bloom_settings;
 	}
 
diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
index fc7693806c..47ddf2641f 100755
--- a/t/t4216-log-bloom.sh
+++ b/t/t4216-log-bloom.sh
@@ -174,11 +174,11 @@ test_expect_success 'persist filter settings' '
 		GIT_TEST_BLOOM_SETTINGS_NUM_HASHES=9 \
 		GIT_TEST_BLOOM_SETTINGS_BITS_PER_ENTRY=15 \
 		git commit-graph write --reachable --changed-paths &&
-	grep "{\"hash_version\":1,\"num_hashes\":9,\"bits_per_entry\":15}" trace2.txt &&
+	grep "{\"hash_version\":1,\"num_hashes\":9,\"bits_per_entry\":15" trace2.txt &&
 	GIT_TRACE2_EVENT="$(pwd)/trace2-auto.txt" \
 		GIT_TRACE2_EVENT_NESTING=5 \
 		git commit-graph write --reachable --changed-paths &&
-	grep "{\"hash_version\":1,\"num_hashes\":9,\"bits_per_entry\":15}" trace2-auto.txt
+	grep "{\"hash_version\":1,\"num_hashes\":9,\"bits_per_entry\":15" trace2-auto.txt
 '
 
 test_expect_success 'correctly report changes over limit' '
-- 
2.28.0.510.g86fdc5f89a

