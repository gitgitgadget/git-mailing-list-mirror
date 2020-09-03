Return-Path: <SRS0=Hc2o=CM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB05C43461
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 22:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98DE020716
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 22:46:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="S7RByym+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729603AbgICWqh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Sep 2020 18:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729598AbgICWq2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Sep 2020 18:46:28 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B07FDC061245
        for <git@vger.kernel.org>; Thu,  3 Sep 2020 15:46:27 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id n18so3307311qtw.0
        for <git@vger.kernel.org>; Thu, 03 Sep 2020 15:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VLl9/4i6W1dXFmg/9v3/RXIEbDmyDfs/63CE/yvVW30=;
        b=S7RByym+gW4fs/JvSoSaFPeIigYxKvB/AN1p7dx3Od/+hmRgRLmaZgTwA8Lx14ly5W
         6YLBZI04bcu4vTJ1Tf5/v/KXLTv6Cy1RAJtviXy+8z4ypdikecH+myvnOV5ktaEJRYE5
         IBaFTJAWEdFEEhSSXrg4kCC5B8pJCHTfoUD8WBadUNQBBBsntvW/fPovvTDikLK0hERA
         EbUU8PXMY0JsElla2KG9nOF5P7Sp3GFXR/sw2c2SbN3gqq9PhbNAIMRSPCYG0g7bRPSG
         UdFy0aht92ADyp94Xbaib2416ZM8GDLfBTpS6oYj4f5AeeNJsxuE3FlV6E+Hzm7ukql4
         deVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VLl9/4i6W1dXFmg/9v3/RXIEbDmyDfs/63CE/yvVW30=;
        b=raEGVZuufDGaezUCnYIHsK9fsDzk/Tr+UYJNZJfe2KQm8Ewvcz6fFw35fTJl2jBpMn
         fEI0deg7SD02ZuegeXyTt6XGeGfTl8IwQ6sEsXwjwnXC+vkqErUppF59zIZmQUSHJBON
         VsXY1ivb6YRySiSkn0C/I4RzlRdnP3B1LjtX4Q+PgrtRh0X50bnBc9RlvWLvNonyCOdR
         2MX6+nQuAdNmehJKwKzsyDdEqXThqNBZnMPHAegyVa/xwjRLW1CSXwIeaVByvIqSzCeb
         G7PlKZ6JdMxzvpvZBa1pgME8hUYRDdGCWGK7vj5+m4wQAWPgQfY8H6k4gxmFCAVHrAuw
         tiFw==
X-Gm-Message-State: AOAM5324Xt7tMV89AwZmd0R0pmOIyzZ6W2BWFK86xONn37sr4SBPDkC4
        51J7uMAQWjQT+kKsKXx+PXvbt3cK/lvRt15X
X-Google-Smtp-Source: ABdhPJxrE1prM1DEoweps9yE9lY+u1CGsdgPQ8zd2FW2CtjJnVg6iG//pr6C1J7UlBeTL8s/kW0cZQ==
X-Received: by 2002:ac8:794c:: with SMTP id r12mr5806467qtt.162.1599173186601;
        Thu, 03 Sep 2020 15:46:26 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:a97c:6dae:76a4:c715])
        by smtp.gmail.com with ESMTPSA id f76sm3070295qke.19.2020.09.03.15.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 15:46:26 -0700 (PDT)
Date:   Thu, 3 Sep 2020 18:46:24 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net,
        szeder.dev@gmail.com
Subject: [PATCH v4 06/14] commit-graph.c: store maximum changed paths
Message-ID: <965489d3617ec03be90d12402fda29fc2b1ead63.1599172908.git.me@ttaylorr.com>
References: <cover.1596480582.git.me@ttaylorr.com>
 <cover.1599172907.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1599172907.git.me@ttaylorr.com>
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
2.27.0.2918.gc99a27ff8f

