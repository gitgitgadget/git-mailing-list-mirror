Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA52C48BE5
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 22:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4BEE6124B
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 22:25:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232172AbhFUW1f (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 18:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232197AbhFUW1d (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 18:27:33 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42087C061768
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 15:25:17 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id s19so11153833ioc.3
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 15:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7xGIEvzSdDRc4IQvzEVwXEoIEHv61yRPVPsvgvyowXQ=;
        b=Smpi3LBdAb+obLYctuvDe5LbMFAgQfcLL3xcLDGdXKnbMsHp7TnFg4K98shYkl6FtW
         DvBLVEz7wYs+RJvXQvL0JqjeqNaDe/rzCkH9Yf0zPpLtGCq5tNTT5m8pDCFt8dIh4eac
         kKA6Hg73M2O0D3/2tGy4Agc0bIbda2jYonAwE51Zw/fojYFHEYiLYirtcacfbBGHfzK5
         xRbOHYtLlQFpfUEU1IH2vxM2eD+I3cJR34qbC/DTCbmqDwJ/4hHIEciPi0CbkGOgTXZ9
         5blrcg6ldNZY78sEgyCvBnw+TWgw+ba3vWADht+V/MM25wolFA1wlhsGPSy7Rcd4A8lz
         fwuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7xGIEvzSdDRc4IQvzEVwXEoIEHv61yRPVPsvgvyowXQ=;
        b=WYF1JuQE06dTIEm1vi8VsW5K/+hguLR0qP0la/5w4gc7YGS+og4p2toonVXhJQB/kx
         IySQ/Vb1FYRI2ju3TXy32Qxw5UDtH+u0I9V6Slx27KevW7S/nzLnXAhRY6iBPnLjy/pA
         VsEK3VthDOv3/obWAjbkBYLsDVRUivf4k4mvYD+Bav4zt+tQVp0UVf3Jy0/clLoSY5cN
         4Hg7ew7cJKKE77fjYB1oR6n03N/BWZMDNGq9E3K9qbHUs6Aabj8exCV6UQal2AbwyFrH
         wwkl0eRvMc/G+9ZFL0lk5AxW1Fp7Vm5ZH0K7EzBzS6dIYeqU09TCqNDCnTq5x6fELWWp
         saZw==
X-Gm-Message-State: AOAM530S53LN5+mXS23VVYzHoshQUdVpeIfbSvt0PDCAliIc0r6X4ngH
        mnAZ/+t5A96F06QerA/Y3VSwQMaZyU8qlhF6
X-Google-Smtp-Source: ABdhPJwsQrwVvUBxOvEyJB7YOjPhPXC54KszqG7tUU8Vmh/DXBkXKmd4FQX2UDihz310qvK435Ybiw==
X-Received: by 2002:a6b:f81a:: with SMTP id o26mr250755ioh.56.1624314316554;
        Mon, 21 Jun 2021 15:25:16 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:f6bb:34fc:22a7:6a3])
        by smtp.gmail.com with ESMTPSA id e14sm6659660ilc.47.2021.06.21.15.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 15:25:16 -0700 (PDT)
Date:   Mon, 21 Jun 2021 18:25:15 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: [PATCH v2 07/24] midx: clear auxiliary .rev after replacing the MIDX
Message-ID: <1448ca0d2ba265db2dce414a7f7d6b1f4bcb5a08.1624314293.git.me@ttaylorr.com>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1624314293.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1624314293.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When writing a new multi-pack index, write_midx_internal() attempts to
clean up any auxiliary files (currently just the MIDX's `.rev` file, but
soon to include a `.bitmap`, too) corresponding to the MIDX it's
replacing.

This step should happen after the new MIDX is written into place, since
doing so beforehand means that the old MIDX could be read without its
corresponding .rev file.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/midx.c b/midx.c
index fa23d57a24..40eb7974ba 100644
--- a/midx.c
+++ b/midx.c
@@ -1076,10 +1076,11 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 
 	if (flags & MIDX_WRITE_REV_INDEX)
 		write_midx_reverse_index(midx_name, midx_hash, &ctx);
-	clear_midx_files_ext(the_repository, ".rev", midx_hash);
 
 	commit_lock_file(&lk);
 
+	clear_midx_files_ext(the_repository, ".rev", midx_hash);
+
 cleanup:
 	for (i = 0; i < ctx.nr; i++) {
 		if (ctx.info[i].p) {
-- 
2.31.1.163.ga65ce7f831

