Return-Path: <SRS0=Hc2o=CM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DDCDC43461
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 22:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE77120716
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 22:46:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="d7DPBuzF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729620AbgICWqx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Sep 2020 18:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729583AbgICWqw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Sep 2020 18:46:52 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C944DC061244
        for <git@vger.kernel.org>; Thu,  3 Sep 2020 15:46:51 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id o5so4652610qke.12
        for <git@vger.kernel.org>; Thu, 03 Sep 2020 15:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RGaZagxN7aJ5DUTKsYEDT6jF/oHXp9qe7iVjJytpYFY=;
        b=d7DPBuzFFqbAg7ULl+0ii6ePR4BduZpoqRsheXz2I1raprCpLidZ2LInVw3Lhze1gy
         FUfRx2dYUs3dM9rQTczhchqZxbl8cyPhbnxxgTfF7djtuXvTFqz/uncjsNDVGUMi3Pua
         GmTU7RYMd350tOk5FAAiK1IyQ/ooajCJQah3Mv4lHML2JE9NibrkZuzbAtD3K5v8hecl
         GLc3dNlx9JyLefwbmGGbb47aAmtM/emAL7RRpnMClqRXVNAiNi8XI3fe1EBLeilPgoqA
         ETS9/BaYo5eug50hycST8Iv45n1jmBjJJaOUeVeUZNnxuZXq+7ffDbkIaJ2kbvF4p3xD
         AUAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RGaZagxN7aJ5DUTKsYEDT6jF/oHXp9qe7iVjJytpYFY=;
        b=f3Erb85MPO3q76KHi7ej9wAK2xVFGrKYJ7bF2LXZEfwDadQ5NBhwdli9oY1agwtQP+
         he929cp9du55R2Gfybc8nAvZw6NwyxFGtxY1Aje7do0StCbKki1AiW5tuE+61WViUdBW
         jfQNetHKjcsuRTsiZBv0S+aRldqFLd3G6Jg31r4iV8eyHMerTPU+s2kf8DvbPKK7UjNC
         KwB8tq7sCbN7N7oSlX98Wkdct6I4xy2xkCYvcHmbzKanCn7yotciiAI+KVjOocCag+ny
         nYnP6fNnZ1uMBIvU+MRmq/57nLCff9NXMwh1ddlzvW5zOTLZCmDrdtDHXKFPx2iPQY4S
         +1Fw==
X-Gm-Message-State: AOAM533nrZ9BH+HZFTqYbAAKnvl6UWtSvN+6K2dvf0c0+n/xbiUFXGQJ
        rqfw7qALgnONE9ExDtLcl4gPWwMJ6aJ88lZ8
X-Google-Smtp-Source: ABdhPJxn5Qg+7TIUMdCMdVpAMqCDNUfqLSHzzEFPoqB/q0CLQZcXqgDd++0m+9p+iw52hgYNM/3ulQ==
X-Received: by 2002:a05:620a:2014:: with SMTP id c20mr3239616qka.89.1599173210748;
        Thu, 03 Sep 2020 15:46:50 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:a97c:6dae:76a4:c715])
        by smtp.gmail.com with ESMTPSA id 7sm3095016qkh.60.2020.09.03.15.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 15:46:50 -0700 (PDT)
Date:   Thu, 3 Sep 2020 18:46:48 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net,
        szeder.dev@gmail.com
Subject: [PATCH v4 11/14] csum-file.h: introduce 'hashwrite_be64()'
Message-ID: <d7cbd4ca1a5dd63fb1d19ef97fac9765daa5ae03.1599172908.git.me@ttaylorr.com>
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

A small handful of writers who wish to encode 64-bit values in network
order have worked around the lack of such a helper by calling the 32-bit
variant twice.

The subsequent commit will add another caller who wants to write a
64-bit value. To ease their (and the existing caller's) pain, introduce
a helper to do just that, and convert existing call-sites.

Suggested-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 commit-graph.c | 8 ++------
 csum-file.h    | 6 ++++++
 midx.c         | 3 +--
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 35535f4192..01d791343a 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1791,12 +1791,8 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 
 	chunk_offset = 8 + (num_chunks + 1) * GRAPH_CHUNKLOOKUP_WIDTH;
 	for (i = 0; i <= num_chunks; i++) {
-		uint32_t chunk_write[3];
-
-		chunk_write[0] = htonl(chunks[i].id);
-		chunk_write[1] = htonl(chunk_offset >> 32);
-		chunk_write[2] = htonl(chunk_offset & 0xffffffff);
-		hashwrite(f, chunk_write, 12);
+		hashwrite_be32(f, chunks[i].id);
+		hashwrite_be64(f, chunk_offset);
 
 		chunk_offset += chunks[i].size;
 	}
diff --git a/csum-file.h b/csum-file.h
index f9cbd317fb..b026ec7766 100644
--- a/csum-file.h
+++ b/csum-file.h
@@ -62,4 +62,10 @@ static inline void hashwrite_be32(struct hashfile *f, uint32_t data)
 	hashwrite(f, &data, sizeof(data));
 }
 
+static inline void hashwrite_be64(struct hashfile *f, uint64_t data)
+{
+	hashwrite_be32(f, data >> 32);
+	hashwrite_be32(f, data & 0xffffffffUL);
+}
+
 #endif
diff --git a/midx.c b/midx.c
index e9b2e1253a..32cc5fdc22 100644
--- a/midx.c
+++ b/midx.c
@@ -789,8 +789,7 @@ static size_t write_midx_large_offsets(struct hashfile *f, uint32_t nr_large_off
 		if (!(offset >> 31))
 			continue;
 
-		hashwrite_be32(f, offset >> 32);
-		hashwrite_be32(f, offset & 0xffffffffUL);
+		hashwrite_be64(f, offset);
 		written += 2 * sizeof(uint32_t);
 
 		nr_large_offset--;
-- 
2.27.0.2918.gc99a27ff8f

