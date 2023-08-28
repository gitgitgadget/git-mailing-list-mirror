Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEDCCC83F12
	for <git@archiver.kernel.org>; Mon, 28 Aug 2023 23:33:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234349AbjH1XdR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Aug 2023 19:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233029AbjH1XdE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Aug 2023 19:33:04 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F1FFC2
        for <git@vger.kernel.org>; Mon, 28 Aug 2023 16:33:01 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-d77f97a0e72so3734717276.0
        for <git@vger.kernel.org>; Mon, 28 Aug 2023 16:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1693265580; x=1693870380;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=osXABX6HWVl2QSpKBj6u6+23KxmzMg+vKUL9yACub/E=;
        b=Q1CUKMolAh3IYW+24A8CpMs1fWTad/BXjGSIXRFVBXO5S73tYHeB2tOYRfcn34fYDb
         7hyBU5v8mo/lLVqRn3+7CYv68XNxOnG5n0RSZEDT8nzyq+0B7pF2ZZf+7DspKi3vrUfZ
         7qBMCuuNRMk8SAmo8UvumoR+uZn2y0HqZoa0enz1TSRl2kGJSZBEhhJwH+LKEehfQqr/
         DPqCHcP9KUVzG8yQ+sj7mXraQ2fZ68izu8AWTZdxm20v/QG9zRQaSwDj0ccLfnCut6qa
         gQhCV/5cQPFWxI8J911akEcHXEdXt7GA8zIey0MWWpAvu2beGl4TK+CH9SZgI4KXdtV3
         /VSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693265580; x=1693870380;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=osXABX6HWVl2QSpKBj6u6+23KxmzMg+vKUL9yACub/E=;
        b=fBBBfylsS4x7/r+yd+t7XCnuIUnFGpmPRGGcZ52Fyjx8te01Ho+ZxDnTghSgztUXnV
         5yls/CXL3T77AXQS2xhQckqjGNBem/wcZudX3ZcJDlunKgxtypJAFnE/uQAGN2UP6Q1y
         mMDKvQ1CXBYemLjkCzzTbBADNEIkEPAnKYQrg1H+E12nQT8g2sc36F9xex3U8tVsV7FJ
         ZXNKP76AQV/N1IKrOFuDAoMmGaAlpPvVPBFwnp7LCogCvUP/y6nGZ3ETDQhVZbGtJBKo
         inM2ES0/k7cUNQyFovJkNCe45PKR/7hVo7ZOjbHhH9oP464Bg6S08cqVLurHWmW2r0wP
         bdwQ==
X-Gm-Message-State: AOJu0Yy7ryIejRsY8exyXT6AC1WMFBEFfaW5Z03OnbRDcnK0ApJt5gl8
        PhQ3NwmvJp3n1/UgacgDXJ+8blNIZvtLg8SUDSGdhw==
X-Google-Smtp-Source: AGHT+IG1V590WwsaIhhB2LOglJL/oiCiQiUdmS34lTW8/4F4Un4MJd1L+U00WxupOmoBr4vtLQsqQQ==
X-Received: by 2002:a25:bc8a:0:b0:d11:97d5:e8a8 with SMTP id e10-20020a25bc8a000000b00d1197d5e8a8mr26050032ybk.49.1693265580588;
        Mon, 28 Aug 2023 16:33:00 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 198-20020a250dcf000000b00d0d2c7dbfecsm1938188ybn.7.2023.08.28.16.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 16:33:00 -0700 (PDT)
Date:   Mon, 28 Aug 2023 19:32:59 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 06/22] commit-graph: mark unused data parameters in
 generation callbacks
Message-ID: <ZO0uq25DV6MIvG6q@nand.local>
References: <20230828214604.GA3830831@coredump.intra.peff.net>
 <20230828214739.GF3831137@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230828214739.GF3831137@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 28, 2023 at 05:47:39PM -0400, Jeff King wrote:
> The compute_generation_info code uses function pointers to abstract the
> get/set generation operations. Some callers don't need the extra void
> data pointer, which should be annotated to appease -Wunused-parameter.

I think just the callbacks initialized by compute_topological_levels()
(i.e, get_topo_level() and set_topo_level()) care about the ctx
parameter.

I think that we can go a bit further, though. The other caller in
compute_generation_numbers() assigns data to the argument ctx it takes
in, but neither of its callbacks get_generation_from_graph_data() and
set_generation_v2() use the data parameter, as is implied by the the
existence of this patch.

So I think that we could drop the assignment to data entirely like so,
applied on top of this patch:

--- 8< ---
diff --git a/commit-graph.c b/commit-graph.c
index 0aa1640d15..eb3e27b720 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1587,7 +1587,6 @@ static void compute_generation_numbers(struct write_commit_graph_context *ctx)
 		.commits = &ctx->commits,
 		.get_generation = get_generation_from_graph_data,
 		.set_generation = set_generation_v2,
-		.data = ctx,
 	};

 	if (ctx->report_progress)
--- >8 ---

> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  commit-graph.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

The rest looks obviously correct to me, thanks.

Thanks,
Taylor
