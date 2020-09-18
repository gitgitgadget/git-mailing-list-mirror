Return-Path: <SRS0=7xvA=C3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4158C43464
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 02:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF5D72083B
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 02:59:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="X7vjOAB5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbgIRC7t (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Sep 2020 22:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728308AbgIRC7U (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Sep 2020 22:59:20 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A2EFC06174A
        for <git@vger.kernel.org>; Thu, 17 Sep 2020 19:59:20 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id v123so4628917qkd.9
        for <git@vger.kernel.org>; Thu, 17 Sep 2020 19:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=S/caCahzOERINWyeDEBrKaHPGxpGcwvhloX1Sw8Xgjg=;
        b=X7vjOAB5yUHCETU412LmeXynnlmSkyw51DDRLK8VWAhb10lTNcosdMGEw8nqQnUEYZ
         F8N2gyT8Io7G521Rkhc5TZ3GcwF0DnsoXyaIla0VvZDxjls8RFush1I3uER3LFwSRktY
         oQOhOON81R+KbwKTlkLKTLcTTAUu50QlC65uBqxMtFfvv8VsrFioccuK4/oCMIzBdUOt
         d/+GOBiannal6bHhqBInU/hWYQEu4/aKmExc+6lo+ho6HMLdl0fIDOhlrJATlHuFTHyM
         9zkIlDlpJJSAYoXk9wh5GWYYhFzm0zqYyKUacg42ci5hjcXU7NFAjxjL4M5xvE0oTDcR
         5mKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=S/caCahzOERINWyeDEBrKaHPGxpGcwvhloX1Sw8Xgjg=;
        b=q1PT6gDeK66DaMGA++rsTmS29MBvw+z+SvylcRorL3VkEe318lZi75/em4PZQbIbYw
         050qxK4eh9oTPjeOXmSj5kKd9L2Y7gfDYC+Fm2mYCSnqMxa6G36qvGOdAVhoqIfLauDA
         JkoeFMJ8DRhBsx0smaQeuoxor64dmLmCnp75GNKI42OzazCKoYMW2M4o+kYTHR8pZsrk
         xwLigvROfFVdfW7Ww57UtPRb+OAVqAvvVpP4n64O3nd4T8g32duKSTI6QkZeBOXROK5N
         d72xMB8MjkYoXcuykfaYskgrGcJqyymnNltW1xhIrA8NkEBb0CWEkbqj/FostST56E7H
         4x4A==
X-Gm-Message-State: AOAM531Uj7NnB2+RJIyAsfJx/UoE1zQmdcOtiw00diwH2hPyPMQvzefb
        CyklCQ/PajHNoemFk2AiKEkzzuXChqy5CQiL
X-Google-Smtp-Source: ABdhPJyxPvlxTtY0qi7NF2dAZBk8WhtwMXn54RkfyUDlgT/5dHfia80xGAEfE6ZMPXUbawH2oGFI4w==
X-Received: by 2002:a37:6352:: with SMTP id x79mr30560468qkb.267.1600397959109;
        Thu, 17 Sep 2020 19:59:19 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:2003:d617:ca70:4fd1])
        by smtp.gmail.com with ESMTPSA id h199sm1197162qke.112.2020.09.17.19.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 19:59:18 -0700 (PDT)
Date:   Thu, 17 Sep 2020 22:59:16 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net,
        szeder.dev@gmail.com
Subject: [PATCH v3 06/13] commit-graph.c: store maximum changed paths
Message-ID: <d4e9714c167117882488bf179343ec1652e1cd27.1600397826.git.me@ttaylorr.com>
References: <cover.1599664389.git.me@ttaylorr.com>
 <cover.1600397826.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1600397826.git.me@ttaylorr.com>
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
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 bloom.h              | 11 ++++++++++-
 commit-graph.c       |  4 ++++
 t/t4216-log-bloom.sh |  4 ++--
 3 files changed, 16 insertions(+), 3 deletions(-)

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
index ea54d108b9..ba6d4a4c6c 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -424,6 +424,7 @@ struct commit_graph *parse_commit_graph(struct repository *r,
 				graph->bloom_filter_settings->hash_version = hash_version;
 				graph->bloom_filter_settings->num_hashes = get_be32(data + chunk_offset + 4);
 				graph->bloom_filter_settings->bits_per_entry = get_be32(data + chunk_offset + 8);
+				graph->bloom_filter_settings->max_changed_paths = DEFAULT_BLOOM_MAX_CHANGES;
 			}
 			break;
 		}
@@ -1201,6 +1202,7 @@ static void trace2_bloom_filter_settings(struct write_commit_graph_context *ctx)
 	jw_object_intmax(&jw, "hash_version", ctx->bloom_settings->hash_version);
 	jw_object_intmax(&jw, "num_hashes", ctx->bloom_settings->num_hashes);
 	jw_object_intmax(&jw, "bits_per_entry", ctx->bloom_settings->bits_per_entry);
+	jw_object_intmax(&jw, "max_changed_paths", ctx->bloom_settings->max_changed_paths);
 	jw_end(&jw);
 
 	trace2_data_json("bloom", ctx->r, "settings", &jw);
@@ -1669,6 +1671,8 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 							      bloom_settings.bits_per_entry);
 		bloom_settings.num_hashes = git_env_ulong("GIT_TEST_BLOOM_SETTINGS_NUM_HASHES",
 							  bloom_settings.num_hashes);
+		bloom_settings.max_changed_paths = git_env_ulong("GIT_TEST_BLOOM_SETTINGS_MAX_CHANGED_PATHS",
+							  bloom_settings.max_changed_paths);
 		ctx->bloom_settings = &bloom_settings;
 	}
 
diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
index fc7693806c..593571358d 100755
--- a/t/t4216-log-bloom.sh
+++ b/t/t4216-log-bloom.sh
@@ -174,11 +174,11 @@ test_expect_success 'persist filter settings' '
 		GIT_TEST_BLOOM_SETTINGS_NUM_HASHES=9 \
 		GIT_TEST_BLOOM_SETTINGS_BITS_PER_ENTRY=15 \
 		git commit-graph write --reachable --changed-paths &&
-	grep "{\"hash_version\":1,\"num_hashes\":9,\"bits_per_entry\":15}" trace2.txt &&
+	grep "{\"hash_version\":1,\"num_hashes\":9,\"bits_per_entry\":15,\"max_changed_paths\":512" trace2.txt &&
 	GIT_TRACE2_EVENT="$(pwd)/trace2-auto.txt" \
 		GIT_TRACE2_EVENT_NESTING=5 \
 		git commit-graph write --reachable --changed-paths &&
-	grep "{\"hash_version\":1,\"num_hashes\":9,\"bits_per_entry\":15}" trace2-auto.txt
+	grep "{\"hash_version\":1,\"num_hashes\":9,\"bits_per_entry\":15,\"max_changed_paths\":512" trace2-auto.txt
 '
 
 test_expect_success 'correctly report changes over limit' '
-- 
2.28.0.510.g375ecf1f36

