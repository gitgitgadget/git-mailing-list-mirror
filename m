Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E74BDC3A5A9
	for <git@archiver.kernel.org>; Mon,  4 May 2020 23:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C142F20735
	for <git@archiver.kernel.org>; Mon,  4 May 2020 23:12:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="RDpDieQC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728338AbgEDXMb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 19:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728258AbgEDXMa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 May 2020 19:12:30 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 996EFC061A0E
        for <git@vger.kernel.org>; Mon,  4 May 2020 16:12:29 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id x10so24424plr.4
        for <git@vger.kernel.org>; Mon, 04 May 2020 16:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lMOBVZeN7SxKVnX5EL34f+UKEgcMo4vQNn6FNQCDqQ0=;
        b=RDpDieQC3Rz9D0qJ8Z91sZvDs6/gRtAKPr63HCJv49tGlqXGiEAC9C9CUt+90Q/+em
         zXR4ZC7dM9la+kfdeBox0FYIIvAZAHbuo+tYLdHGEDVfn47yyuZaGnCJm8SE4WhbTCTr
         9dYZmyP+j+XTZlJ8WKcMbJGT3l6kaxz77lytwShk4nwxsCGTjJ91u32YhKxfI2GoSsao
         sOsYG7HZ7bfzygxdv624m7EYQ0xuE2+FkrsdCDEmGFkMGaVBDMjotyQ268zZq8dkcJPi
         Jsrr0qyabPv19JS+cDCXLamQHxUrMBSf5J3VAFMLWtuhm4Eb5mFwJ4Tm+kvCVOBRakCn
         nrgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lMOBVZeN7SxKVnX5EL34f+UKEgcMo4vQNn6FNQCDqQ0=;
        b=AkzK8ELhNQKFgaYhqgog+VT+ZgsaGjSYSm5O3lT3w/Z+QM1wehYO2mKH4jVF1U5PnM
         t2wCLqazDqqSgIoaUw3C3052QvnjiLgKqfqSrOSLwiFS/PGG8NP+tPZ1BHgNfBEVaSAr
         j697jibsNtETQJAd1T8O2aM0UVqPkkT5Lbm/xsuShmStH63zOn+NnpmHXuEyKilRYnAv
         a0OQk+uLpbATy194L4aH5TbOgSy2BTe+trY2fjteaH/VJKzCSarT1WRArKb7d+KwUL0m
         SnquVK/rX2N8yU3Wzo/Sl34ELhTVe8Y1MlljvldsJXlLfp9MP4cUJwiSpcAx5ZtVHC7B
         JVGg==
X-Gm-Message-State: AGi0PubbXhQTJvMNBWIlkeehTiDM918RSCULYn8mscnbv41mN3TIjLsJ
        3x1mCnkvNPp462cpl2NA+S7JxzURKNPamQ==
X-Google-Smtp-Source: APiQypK07hQ4A85MmZLp2im0+HBe1i4V8EM9GpdEA7CtjbPPFsX2wPK9O90jOXhR5HWcTo1Rj3LrdQ==
X-Received: by 2002:a17:902:bd81:: with SMTP id q1mr340443pls.46.1588633948795;
        Mon, 04 May 2020 16:12:28 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id mj4sm76016pjb.0.2020.05.04.16.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 16:12:28 -0700 (PDT)
Date:   Mon, 4 May 2020 17:12:27 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, chriscool@tuxfamily.org
Subject: [PATCH 1/4] list-objects-filter: treat NULL filter_options as
 "disabled"
Message-ID: <bb7d99ee2582d60e2413df56cb2c3fb06c18de8e.1588633810.git.me@ttaylorr.com>
References: <cover.1588633810.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1588633810.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

In most callers, we have an actual list_objects_filter_options struct,
and if no filtering is desired its "choice" element will be
LOFC_DISABLED. However, some code may have only a pointer to such a
struct which may be NULL (because _their_ callers didn't care about
filtering, either). Rather than forcing them to handle this explicitly
like:

  if (filter_options)
          traverse_commit_list_filtered(filter_options, revs,
	                                show_commit, show_object,
					show_data, NULL);
  else
          traverse_commit_list(revs, show_commit, show_object,
	                             show_data);

let's just treat a NULL filter_options the same as LOFC_DISABLED. We
only need a small change, since that option struct is converted into a
real filter only in the "init" function.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 list-objects-filter.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/list-objects-filter.c b/list-objects-filter.c
index 1e8d4e763d..0a3ef3cab3 100644
--- a/list-objects-filter.c
+++ b/list-objects-filter.c
@@ -663,6 +663,9 @@ struct filter *list_objects_filter__init(
 
 	assert((sizeof(s_filters) / sizeof(s_filters[0])) == LOFC__COUNT);
 
+	if (!filter_options)
+		return NULL;
+
 	if (filter_options->choice >= LOFC__COUNT)
 		BUG("invalid list-objects filter choice: %d",
 		    filter_options->choice);
-- 
2.26.0.113.ge9739cdccc

