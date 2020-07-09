Return-Path: <SRS0=1oE7=AU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F4F3C433DF
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 17:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78A7C2078B
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 17:00:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DsWfehCP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728065AbgGIRAM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jul 2020 13:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbgGIRAM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jul 2020 13:00:12 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2697C08C5CE
        for <git@vger.kernel.org>; Thu,  9 Jul 2020 10:00:11 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id l17so2687259wmj.0
        for <git@vger.kernel.org>; Thu, 09 Jul 2020 10:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=53J7zjNg8pk6L9Llomyt2LDev4kwCfMUeEmaXs4E+f4=;
        b=DsWfehCPc+DYhzmRvgGZXDsMNNMeQKhuIBUPCZRgXIamxTav/7cC5W0pnYcqFCS4wu
         TcWaqc1OX1b2tz7dYYVzBYDvaVEGWouG09wERkdxMMqwEh6BDqZnnhmY3hOEtKzw24uU
         NArhPpV5TXAQddVleb0q5hKO+94rZ8YoNeo3sPt/Diu1bvhmCBMfSyj5R2Hgw6eju7Qa
         dLp0ffpV07fh8gtECZA6vlrZNWowu76RcCCt7e2EmTQqLHtXEApYCMfrnRh4BPoTQYJ/
         v0C8XSFLgcXVVDfXn4RinxdkJKNp+lboV+91zUfotMyhxV7AC/FZ3cZz+cGkD5rkdBiF
         vY4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=53J7zjNg8pk6L9Llomyt2LDev4kwCfMUeEmaXs4E+f4=;
        b=nROMKs/eJy/OpBYBp7uHGMGsAyMbdxzeIASW0AdXvVp1Zsw2nfp+R0/58U0kZT4fUO
         5XUspYGFh3EzrPlC5vs7YucjNovTIZ8j8zF2Z0pLBXDUGOFpTwHtKLjFTI05wrs8+tUR
         dZxVnmuTV4680CwkITWV3G8x5pQ8sEAfLgX9ZUrojkxNjayp+bCmDg6aqFwoDMw3hjW7
         6iRLnDyAKgbMvysGeMzGrnn6+o2MKmbFIJRiPVRXNZk7yfyola8lHlR0t9UwimZCxLk+
         SVs3DQ5PihRhKhNCFb1Tv9FL97qJlShOBbK8T4f/Z3c1RvteDeXcHVaVurEueWz2UUu8
         Cjeg==
X-Gm-Message-State: AOAM531QN/dnLk/YP1/PzlkbeMtXEK/0anFP6o8U0pEAcG4cfYTCwTP8
        KdIm7ZAZN6QkxU4ILSjTX7A=
X-Google-Smtp-Source: ABdhPJznWihI5zB6Kodu7UZmimzhCLiG9V7YQlXhc9OtIAmheeLWjBlp2ya3HJ1hmJ5ExSCIvaOvyQ==
X-Received: by 2002:a1c:4303:: with SMTP id q3mr1003144wma.134.1594314009450;
        Thu, 09 Jul 2020 10:00:09 -0700 (PDT)
Received: from localhost.localdomain (78-131-17-27.pool.digikabel.hu. [78.131.17.27])
        by smtp.gmail.com with ESMTPSA id v11sm19610189wmb.3.2020.07.09.10.00.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Jul 2020 10:00:08 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Garima Singh via GitGitGadget <gitgitgadget@gmail.com>,
        stolee@gmail.com, jonathantanmy@google.com,
        Garima Singh <garima.singh@microsoft.com>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH] commit-graph: fix "Writing out commit graph" progress counter
Date:   Thu,  9 Jul 2020 19:00:03 +0200
Message-Id: <20200709170003.3020-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.27.0.547.g4ba2d26563
In-Reply-To: <ff6b96aad1e2317d3ed36c2c8b419905dea84a83.1586192395.git.gitgitgadget@gmail.com>
References: <ff6b96aad1e2317d3ed36c2c8b419905dea84a83.1586192395.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

76ffbca71a (commit-graph: write Bloom filters to commit graph file,
2020-04-06) added two delayed progress lines to writing the Bloom
filter index and data chunk.  This is wrong, because a single common
progress is used while writing all chunks, which is not updated while
writing these two new chunks, resulting in incomplete-looking "done"
lines:

  Expanding reachable commits in commit graph: 888679, done.
  Computing commit changed paths Bloom filters: 100% (888678/888678), done.
  Writing out commit graph in 6 passes:  66% (3554712/5332068), done.

Use the common 'struct progress' instance while writing the Bloom
filter chunks as well.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 commit-graph.c | 22 ++--------------------
 1 file changed, 2 insertions(+), 20 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index aaf3327ede..65cf32637c 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1086,23 +1086,14 @@ static void write_graph_chunk_bloom_indexes(struct hashfile *f,
 	struct commit **list = ctx->commits.list;
 	struct commit **last = ctx->commits.list + ctx->commits.nr;
 	uint32_t cur_pos = 0;
-	struct progress *progress = NULL;
-	int i = 0;
-
-	if (ctx->report_progress)
-		progress = start_delayed_progress(
-			_("Writing changed paths Bloom filters index"),
-			ctx->commits.nr);
 
 	while (list < last) {
 		struct bloom_filter *filter = get_bloom_filter(ctx->r, *list, 0);
 		cur_pos += filter->len;
-		display_progress(progress, ++i);
+		display_progress(ctx->progress, ++ctx->progress_cnt);
 		hashwrite_be32(f, cur_pos);
 		list++;
 	}
-
-	stop_progress(&progress);
 }
 
 static void write_graph_chunk_bloom_data(struct hashfile *f,
@@ -1111,13 +1102,6 @@ static void write_graph_chunk_bloom_data(struct hashfile *f,
 {
 	struct commit **list = ctx->commits.list;
 	struct commit **last = ctx->commits.list + ctx->commits.nr;
-	struct progress *progress = NULL;
-	int i = 0;
-
-	if (ctx->report_progress)
-		progress = start_delayed_progress(
-			_("Writing changed paths Bloom filters data"),
-			ctx->commits.nr);
 
 	hashwrite_be32(f, settings->hash_version);
 	hashwrite_be32(f, settings->num_hashes);
@@ -1125,12 +1109,10 @@ static void write_graph_chunk_bloom_data(struct hashfile *f,
 
 	while (list < last) {
 		struct bloom_filter *filter = get_bloom_filter(ctx->r, *list, 0);
-		display_progress(progress, ++i);
+		display_progress(ctx->progress, ++ctx->progress_cnt);
 		hashwrite(f, filter->data, filter->len * sizeof(unsigned char));
 		list++;
 	}
-
-	stop_progress(&progress);
 }
 
 static int oid_compare(const void *_a, const void *_b)
-- 
2.27.0.547.g4ba2d26563

