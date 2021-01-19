Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D036C433E0
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 23:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55CF823104
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 23:27:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbhASX12 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jan 2021 18:27:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728512AbhASXZV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jan 2021 18:25:21 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D27C061786
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 15:24:20 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id z11so23702053qkj.7
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 15:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BVJqOWVbGvk12BQKPDzrUPxc1mTw9s/UzkBZ9JlrWrI=;
        b=MVRZNk+2gSfk1BH/2JUVqDpFbs4TyaPSCJiEHMTZ5y0VXFd0xhtIeJQJv8tB+6J6ri
         JZ2rnaybrF4+9BvnUSjV31c6Eq2X0H+gQjCrPvw21b9GY5dBcpYwLiDTOKZeKQXHI6rn
         OlmuD+aTddxVjM+aJ721P4uoPPX3pL6k8dQzGf9r/lESVNqT3+8mJCcfKquh6dAVFTyK
         0J4adf+p1WroK1TwQmx6M+NaPz4VvVHprsjKukrrpaaboNJ9meJ0VgPHNGhm6PDJ6+FR
         fPLVmm3B2lMIcFVRIQHcdyCk2RhR4k7s/FLGfEIkTLlG7+mJ/amFzVzPuC0NCjt3swuR
         XrpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BVJqOWVbGvk12BQKPDzrUPxc1mTw9s/UzkBZ9JlrWrI=;
        b=rUvQ+Se7Ht5t94dHmtzUhqo2VkZnnjYLRoCUKH1+AeDqegLpEJkrxJG5gJLT7kL2U0
         wpVEa2K8MRDSfrv2bawZHmsptU+km+lFI45zUKA1RMFwaXIVOXJtf6wllXUXg9KFO2uq
         D21meRANejZ93lkdcx6x96UDQmqnhUUfwDCLktc+z/Rq1f2ntrp74gzB7t42JsevaEYv
         8xYCzBbBlQBYoFiffFN2fx2dPdRNimIy+8/TDUm5X5L8yaLPCzIUjTBczCcMhX2PF6w8
         cFuuCygQ6tIrPG6MshJ3A/u7JV/WAY8K1pzqwsj1CxLA+ALgkOsp3yOrMUQacytuoVxY
         AlHA==
X-Gm-Message-State: AOAM531DlU1SepZCgR7XXQs7QoSOcWFEs68C+IPCYEsY3uWriHLjvQJU
        GJ8V6EupKRhSQioansi55KmKR6rC81KIWA==
X-Google-Smtp-Source: ABdhPJy3PnXyVrf50RE08diOYc1fRfkGIe7B4Yd5I4jfBhJPs8pC/ILJObo91f5MX3/OuGHonHBjxQ==
X-Received: by 2002:ae9:e10d:: with SMTP id g13mr6985823qkm.444.1611098659404;
        Tue, 19 Jan 2021 15:24:19 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:ed38:94a5:e78e:2d58])
        by smtp.gmail.com with ESMTPSA id x134sm203047qka.1.2021.01.19.15.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 15:24:18 -0800 (PST)
Date:   Tue, 19 Jan 2021 18:24:16 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com
Subject: [PATCH 05/10] p5303: measure time to repack with keep
Message-ID: <b3b2574d4d9d10f226b52d81fe0e6bf1f761504e.1611098616.git.me@ttaylorr.com>
References: <cover.1611098616.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1611098616.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

This is the same as the regular repack test, except that we mark the
single base pack as "kept" and use --assume-kept-packs-closed. The
theory is that this should be faster than the normal repack, because
we'll have fewer objects to traverse and process.

And indeed, it is much faster in the single-pack case (all timings
measured on the kernel):

  5303.5: repack (1)                 57.29(54.88+10.39)
  5303.6: repack with keep (1)       1.25(1.19+0.05)

and in the 50-pack case:

  5303.10: repack (50)               89.71(132.78+6.14)
  5303.11: repack with keep (50)     6.92(26.93+0.58)

but our improvements vanish as we approach 1000 packs.

  5303.15: repack (1000)             217.14(493.76+15.29)
  5303.16: repack with keep (1000)   209.46(387.83+8.42)

That's because the code paths around handling .keep files are known to
scale badly; they look in every single pack file to find each object.
Our solution to that was to notice that most repos don't have keep
files, and to make that case a fast path. But as soon as you add a
single .keep, that part of pack-objects slows down again (even if we
have fewer objects total to look at).

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/perf/p5303-many-packs.sh | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/t/perf/p5303-many-packs.sh b/t/perf/p5303-many-packs.sh
index 277d22ec4b..85b077b72b 100755
--- a/t/perf/p5303-many-packs.sh
+++ b/t/perf/p5303-many-packs.sh
@@ -27,8 +27,11 @@ repack_into_n () {
 	>pushes &&
 
 	# create base packfile
-	head -n 1 pushes |
-	git pack-objects --delta-base-offset --revs staging/pack &&
+	base_pack=$(
+		head -n 1 pushes |
+		git pack-objects --delta-base-offset --revs staging/pack
+	) &&
+	test_export base_pack &&
 
 	# and then incrementals between each pair of commits
 	last= &&
@@ -87,6 +90,15 @@ do
 		  --reflog --indexed-objects --delta-base-offset \
 		  --stdout </dev/null >/dev/null
 	'
+
+	test_perf "repack with keep ($nr_packs)" '
+		git pack-objects --keep-true-parents \
+		  --honor-pack-keep --assume-kept-packs-closed \
+		  --keep-pack=pack-$base_pack.pack \
+		  --non-empty --all \
+		  --reflog --indexed-objects --delta-base-offset \
+		  --stdout </dev/null >/dev/null
+	'
 done
 
 # Measure pack loading with 10,000 packs.
-- 
2.30.0.138.g6d7191ea01

