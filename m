Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 512CCC433DF
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 17:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 208C222D00
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 17:07:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="s+PET7tU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728498AbgHERHM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Aug 2020 13:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728018AbgHERCj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Aug 2020 13:02:39 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB4DC0617A0
        for <git@vger.kernel.org>; Wed,  5 Aug 2020 10:02:38 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id b14so40619874qkn.4
        for <git@vger.kernel.org>; Wed, 05 Aug 2020 10:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6laf6kKuVSjfW1rY/Bcz72cLLx2hYo5Wjv1pbceIgxc=;
        b=s+PET7tU0V/gdAaE1BJgYK0l+pqPniAOOfnPeAeMUXT+iLPnPPFrm/mTx2uj1cbXjU
         HOiPGsZ8lO0IMo0it1+H38I4q3Z9Meu/bxGNM+oKA+6cfrz+g36ZqFQ/I0C9/kaBKgsP
         8By91qMHkcQY0wNhtBUmwhv91v/2hqYZyiUzLwA5+7s9kzV59W3PbaU5gkJfDjEe4zCV
         6t32vljVZaAWaG//E338E3oMbNqeG37Qg99jJTofB+TbzzlOeJxRztOhN31Al4OmOhbk
         0a7lixbc1wZtU5cncG3P7sg52FFt1EBM8ZsiJS4NURRwXS68WtHuAU+OozTDSgWtLGF+
         T94w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6laf6kKuVSjfW1rY/Bcz72cLLx2hYo5Wjv1pbceIgxc=;
        b=Dwrplm99uFR8IWzhIadsmkAHg6PuMDQpExFEDRluxzvtwmSifrMggQ9YxpuV0UQ+Qk
         +wIFaUqeTM6dXeHqUyOME1bK7rnS5PN1csl8btrA8/C1xE5xDg7Gdc75KDKwLlWNrrVm
         fbolf+NDu6g+K7A4IhFybZJzY0uZ4b30i+lRSOW2p3VU372gMpoDRbNqNJS3Mc/cbuyw
         dNvtOtOAKdvQubB3UE+SDxnkGH6F3C5TxRomOc4jJO0Mxwxd1BKUWCloiQ3okma4hoky
         +ec/44XeD+fddEKnUt84OPgngrBHSIPbwAUe2RL5xO4zoJs/GVe7ZedUeMkwfife2ybu
         /s5A==
X-Gm-Message-State: AOAM531jX0+4VnF6FAqDAdg7Esa34oY99eRL6rK2guv1J084S9obL6+2
        qVCiOTGlNdG9qaMNCH1Oqu1NN4hZ26a14A==
X-Google-Smtp-Source: ABdhPJzT5r2qX3W6GC0DgSmU/3yxYgTV3tTlHds8BElLCD70v/NXfHAKuaounjx9DDIg0fTQlD/2xA==
X-Received: by 2002:a37:6556:: with SMTP id z83mr4038991qkb.406.1596646957499;
        Wed, 05 Aug 2020 10:02:37 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:d118:9acc:fdba:dee7])
        by smtp.gmail.com with ESMTPSA id f14sm1046872qkl.52.2020.08.05.10.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 10:02:36 -0700 (PDT)
Date:   Wed, 5 Aug 2020 13:02:35 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, szeder.dev@gmail.com
Subject: [PATCH v2 06/14] commit-graph.c: store maximum changed paths
Message-ID: <053991f0482b248c3c5fbaf604edfab796ac2540.1596646576.git.me@ttaylorr.com>
References: <cover.1596480582.git.me@ttaylorr.com>
 <cover.1596646576.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1596646576.git.me@ttaylorr.com>
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
index a516e93d71..86dd4b979e 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1194,6 +1194,7 @@ static void trace2_bloom_filter_settings(struct write_commit_graph_context *ctx)
 	jw_object_intmax(&jw, "hash_version", ctx->bloom_settings->hash_version);
 	jw_object_intmax(&jw, "num_hashes", ctx->bloom_settings->num_hashes);
 	jw_object_intmax(&jw, "bits_per_entry", ctx->bloom_settings->bits_per_entry);
+	jw_object_intmax(&jw, "max_changed_paths", ctx->bloom_settings->max_changed_paths);
 	jw_end(&jw);
 
 	trace2_data_json("bloom", ctx->r, "settings", &jw);
@@ -1662,6 +1663,8 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 							      bloom_settings.bits_per_entry);
 		bloom_settings.num_hashes = git_env_ulong("GIT_TEST_BLOOM_SETTINGS_NUM_HASHES",
 							  bloom_settings.num_hashes);
+		bloom_settings.max_changed_paths = git_env_ulong("GIT_TEST_BLOOM_SETTINGS_MAX_CHANGED_PATHS",
+							  bloom_settings.max_changed_paths);
 		ctx->bloom_settings = &bloom_settings;
 	}
 
diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
index b3d1f596f8..eb2bcc51f0 100755
--- a/t/t4216-log-bloom.sh
+++ b/t/t4216-log-bloom.sh
@@ -169,11 +169,11 @@ test_expect_success 'persist filter settings' '
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
2.28.0.rc1.13.ge78abce653

