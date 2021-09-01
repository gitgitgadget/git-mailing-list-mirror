Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00367C4320A
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 02:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D03DD61075
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 02:06:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241209AbhIACH2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 22:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241020AbhIACH0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 22:07:26 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDBB8C061575
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 19:06:30 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id a15so2149800iot.2
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 19:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1VxA8eA24M/VaCbj2GyZd23biCP9gqVmYOjFWdRdvVM=;
        b=RIr2O5NmWbMxzvG9HxYrtJSrEyVOwJS0NMmsSqfNVKbrIZQzElpFF4WEIHJijwq97p
         j7xISuFnaERoe9RVFxtMLUB3CCmCQgxbIh9seEsaCMp4aF7Jm845gwyuZvIre+hQEnz7
         w/G2wz0rPr2x7ukK4v+x2hQDvxO3Td6dffIQHSM5HdNf8aNTrHcJOBn/q8QroM8JSjXv
         DkX64Rn9i8LlFvhDhGEj7a44rElKPxBzQvJad09IczDDn7MFW52yh2n1z5YlVvOEXZj1
         /Vc+VVHx1bvI7/xzpWa3NFP+ksaPI/a9QO+JQuePLD27aVFuXiCQ0jr4GkADSsbQIKKJ
         nhIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1VxA8eA24M/VaCbj2GyZd23biCP9gqVmYOjFWdRdvVM=;
        b=rytuB6rKOyo+gPXDHtnN+wTE1qnlHK6SwYMzXU8Ti+HodGN2LcbiJIUxJNBvQ35LXI
         RtBbT6zBj0mCmI8RVAJz6APXOOh6EJR068QtOrFGI2Gjg1Rp90Z9L06s14KgT/tDpioa
         vXiTFcO9dQ2bOKLvh398l2wodHxRZT+92DpfzRT3iKsSITK9WyrUxYo9BzENtvH1PuGn
         9kGVOTIamkaCu6sFvJwjX4wjEtxiZn7b4gAOLzBGewecFYBgrhSIp2D+srsRUibvRcGF
         V4Wa6Kd4SF62f+BoBA3uXIg+y349ZCIAGYo9Dd1JJp/L3QuP6qrZZvPgxn9Zl+tfiWrk
         CxTg==
X-Gm-Message-State: AOAM530ZloHcybCGael7UCcjwsLWSDgN27dDnYnIvxOmmSqfp3wflZNW
        GVB1EgtDmkEJgHl3nGtwKrUbsOwrD9iKcHOW
X-Google-Smtp-Source: ABdhPJzz7z7QsXtLR9AIJVAail3jckj+g9TC1GTbEAJLpmF3yFm/fS26GbtbcW+f+jqvo2vZ9trNng==
X-Received: by 2002:a05:6602:3c5:: with SMTP id g5mr24886264iov.42.1630461990271;
        Tue, 31 Aug 2021 19:06:30 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id t15sm10971509ilq.88.2021.08.31.19.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 19:06:30 -0700 (PDT)
Date:   Tue, 31 Aug 2021 22:06:29 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net
Subject: [PATCH 2/2] builtin/repack.c: move `.idx` files into place last
Message-ID: <a6a4d2154e83d41c10986c5f455279ab249a910c.1630461918.git.me@ttaylorr.com>
References: <cover.1630461918.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1630461918.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a similar spirit as the previous patch, fix the identical problem
from `git repack` (which invokes `pack-objects` with a temporary
location for output, and then moves the files into their final locations
itself).

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 5f9bc74adc..c3e4771609 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -208,10 +208,10 @@ static struct {
 	unsigned optional:1;
 } exts[] = {
 	{".pack"},
-	{".idx"},
 	{".rev", 1},
 	{".bitmap", 1},
 	{".promisor", 1},
+	{".idx"},
 };
 
 static unsigned populate_pack_exts(char *name)
-- 
2.33.0.96.g73915697e6
