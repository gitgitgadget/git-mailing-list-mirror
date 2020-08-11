Return-Path: <SRS0=r8De=BV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E865EC433E0
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 20:51:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C178D20781
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 20:51:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="eQY4gKRE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbgHKUvp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Aug 2020 16:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgHKUvo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Aug 2020 16:51:44 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DBCDC06174A
        for <git@vger.kernel.org>; Tue, 11 Aug 2020 13:51:44 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id w2so20005qvh.12
        for <git@vger.kernel.org>; Tue, 11 Aug 2020 13:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6laf6kKuVSjfW1rY/Bcz72cLLx2hYo5Wjv1pbceIgxc=;
        b=eQY4gKREGS8uFZhv6cDRcqKkj2CtgZ9CrfLFepzjr6MA+O/ct7yNfs1S1AHDh9Iskp
         eh74eRqGCFSza4ysvW359XqP9MMlVoHtGIpBPYL79sqUsRqxMg+Y65Z3L4Br+z8ziUG8
         pnS2PBjJq72QPuqAYWHB3D5ZLFQX18AQ+yPljYnCHjfmCQDO9ab8n6I6vXYMpUe70VOP
         5CWygIO/plTUGM5t1FhFusDmQ91D+/K2kprDaziBzfvnU8/AH6h27Pa8wKPF9dMwKsV5
         6ghtRmeNLYv8UAfZYBhwgr2vE1c0kUgTHkyva43Ju0VbJ/yZrShAH2h69613XSiRR6pD
         Gk8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6laf6kKuVSjfW1rY/Bcz72cLLx2hYo5Wjv1pbceIgxc=;
        b=EOhPVjbC7zu3Dqz2OfZP5fLzW/RUVBtzKRlZ2iNMZbbwhPjvG8xCygem4pjNZgm2fl
         wF8uvXS/wlObiQwKEUOHLONNo99EOrjYXi7h9rCPwhSn1hrgm4RnlRhm+103RADuER+Z
         jm3FpWCnH9zlOblljhi06rHCmtXMMeFAR6fdlnu/qI9DebfQcjBiUBrE6caxsK2aY4mv
         n1tzCvd2gbSNvE/gMJafRZQgGKii3N1qIM8n09egqC16uwfqaG6k3tjNmIW63pldPGgz
         UHNJBVuTBPEgmgx7JZoj0UzXKxW/U6WnIgFYEUCXl2e/enrkWCFI7Vk1ru3cljVWFrCL
         hf2A==
X-Gm-Message-State: AOAM533XRj4Tzf5gbUOsmZkk/3Euwbh8dQZBnWdVjnpVFXxS2XGQ86r8
        5aIUYBDTegif+6KKvlJJjQ+OEzBqc6zTtOYn
X-Google-Smtp-Source: ABdhPJzpG2dFkeyB/HNw/OJoJ6lBJ1yrQUkcl+/iIxV3PJiCGPcQtR4k3XN7z92UawuXe5lrsOvUsA==
X-Received: by 2002:ad4:438f:: with SMTP id s15mr3432989qvr.164.1597179103505;
        Tue, 11 Aug 2020 13:51:43 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:a92f:57be:59a6:7cb2])
        by smtp.gmail.com with ESMTPSA id b23sm20702087qtp.41.2020.08.11.13.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 13:51:42 -0700 (PDT)
Date:   Tue, 11 Aug 2020 16:51:41 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, szeder.dev@gmail.com,
        gitster@pobox.com
Subject: [PATCH v3 06/14] commit-graph.c: store maximum changed paths
Message-ID: <bf498844ef1134a0f762f6df449b9431dc10fc3b.1597178915.git.me@ttaylorr.com>
References: <cover.1596480582.git.me@ttaylorr.com>
 <cover.1597178914.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1597178914.git.me@ttaylorr.com>
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

