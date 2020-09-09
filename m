Return-Path: <SRS0=gV3S=CS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A74EC433E2
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 17:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF4A921919
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 17:19:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="HEgSpWm6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730189AbgIIRS7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Sep 2020 13:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730068AbgIIP17 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Sep 2020 11:27:59 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C23AC0619D1
        for <git@vger.kernel.org>; Wed,  9 Sep 2020 08:23:23 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id r8so2174109qtp.13
        for <git@vger.kernel.org>; Wed, 09 Sep 2020 08:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FPOqANpWsbvGcEr6wxQXoaCC/xQdjTeq/HASE97f3aE=;
        b=HEgSpWm6POXRZ61ga2A1Bp0I8MwuvfwP5is+P/y0nibEg6u1KpfsmHFAAbgI9bJ4lB
         Q9WPdyNgQvh1RBidXev+/Hrz8KZXBTG90qy/IgGSwAHlKOj9hueWm2qFjrs4vIUk9dki
         zkW52NCXOAac4mdTmhZA/WQzU2nTbm9hZWTEvGVrb5UKRbkRicHFfN99BppM7kVyU111
         EgDXBWV+8JP3PzhZKgWgB2vbvGzZvgU5cUj2vJN2ReGW6u5hfTyDGaK0KQ14mXBmICaB
         TQPxObyWWuqniiKAhJudNVFzxGW8F8hZ7h9WOGiLR4g71Ui9VSxvhpcQP5MdCKaI7NBt
         DRZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FPOqANpWsbvGcEr6wxQXoaCC/xQdjTeq/HASE97f3aE=;
        b=UR2rGe0jf7N+x1OblzMXbGosWQVu1E6agSAjHLlPcl181uSyK3PO089L9eV2GZ/ZRA
         gEd7ux7gj8po9fvc251UR1vhy6m23fj48BrCCdjGi2BDdxCUiwwMzNPmyeZaWkEwpmtU
         fzmgAugEc42xUqK/I9dRf2PE8Sz0kojAASPmf++5RecoYzZAzIntF/CliGC4wqynJcay
         EZaOAYTdGV1y0FadxRovco9wRwsW9qaC60JK48/oSeLRdoihm/tI/HPIgrlq8/+8WB86
         IiMFHSKOP6qIjG0Xu725xk116XNdZKJzpilv/9WrQVbK/tRD0ATLOvFuIKf3l11JnpvW
         Gv0w==
X-Gm-Message-State: AOAM532K9PSNB9dKUIglSSIvV/5gALtzRKX8TJ1HW+8BmOQCwvysktoH
        zAlf2/rz+QuaDTCi9lHX3nRhqSuXq43A+jYp
X-Google-Smtp-Source: ABdhPJwsVEOJNrCajyawMCOtmRp/nZJOJUbAav9k6lCYik3IsQgKrfJxaNKMwl/FB1cGuKXYChMTmQ==
X-Received: by 2002:ac8:c4e:: with SMTP id l14mr3764994qti.149.1599665002277;
        Wed, 09 Sep 2020 08:23:22 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:10e2:cf5e:922:2af0])
        by smtp.gmail.com with ESMTPSA id p68sm2899973qkd.124.2020.09.09.08.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 08:23:21 -0700 (PDT)
Date:   Wed, 9 Sep 2020 11:23:18 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net,
        szeder.dev@gmail.com
Subject: [PATCH 06/12] commit-graph.c: store maximum changed paths
Message-ID: <9bd699560b5489d64ebc830f0b3cdbba42c373f1.1599664389.git.me@ttaylorr.com>
References: <cover.1599664389.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1599664389.git.me@ttaylorr.com>
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
2.28.0.462.g4ff11cec37

