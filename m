Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02FB0C4743C
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 20:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF0B060230
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 20:34:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbhFUUgv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 16:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbhFUUgv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 16:36:51 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD09BC061574
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 13:34:35 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id b7so984684ioq.12
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 13:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=BDjgb82WAnWDGHb+gf6tfA5GSywf91Qc+/Lsj94UHOw=;
        b=i5lRZRWaKpYLBgPU/yGXwnjnIuamstoougrVwEEl5bC+ThXsiXZCuIuoAzs9gI3gEh
         UlbPK75qu1hlfMuQrclEqVgWX8howxd/SDJjLib5ou/EVsotY1DpiGFazCnY9gRaDd13
         tffd88Pt0r2CSgvABGLZK9GvhqyVWIy0BVTDNuie1Jpe9poLz6HBV3UtlgvDzP5FqUzj
         LWWuZ+nGVV8KQxw8kuSVrUdiF+GIh7RGTkuaU46+g/06r7Oqwgh2wV/dfrPJGMHXqmEp
         lzIFUgP3VFOdkm6xdzWvmmzdzkHKzZXQUnM08fH5D/p2UBTExfDaHVFPiIa6JJT0ICLa
         3XcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=BDjgb82WAnWDGHb+gf6tfA5GSywf91Qc+/Lsj94UHOw=;
        b=NMoici0dq4sNzxSJElJODPrb2ak/omJ6xAy4z5hI0SI0V40xMvXtbAnFCAiu2i6Nq8
         uv4ZTEuUGPQRWvXQAYbPhsM5oBsfM4zBBJ/DLXmqY+4j+0lXlWA6bMRT6fCspPkvo29u
         LWrHoxAgFL7a4+iCeATNAzNy/YwVDKFFnkkrGI3a72jxfZ6aEExyHDBFqR7TXFtAOc+6
         ldwU8sqaJRB1Oov4k9TV8wKVjW/34yez/4bAUFSy6zL7WQasJvJOj4LjJr3xBdBWQDBT
         Yhm1LyBTrRdMJ+LpbV2+yNOH+VDpM5WuQ9auyc34HLT/rr/j8P+fydy8+iBswMkfknEz
         1iGQ==
X-Gm-Message-State: AOAM531c9noj2IB908yRX8OqhhJlpgQm3nrKrqCa7TtUw1KMhN7TfuLw
        P7FLSeK8ZbIdDtEDmGtb4YKU0Q==
X-Google-Smtp-Source: ABdhPJzwFNa7oNX1xTceUak8VlG3T6MiIJRTMFhuyPz9u6mq2uXQDusnxa2qSFIaTYe/5L6dCnPc2w==
X-Received: by 2002:a02:4b46:: with SMTP id q67mr282000jaa.84.1624307675257;
        Mon, 21 Jun 2021 13:34:35 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:f6bb:34fc:22a7:6a3])
        by smtp.gmail.com with ESMTPSA id z2sm8716033iol.45.2021.06.21.13.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 13:34:34 -0700 (PDT)
Date:   Mon, 21 Jun 2021 16:34:34 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 0/2] pack-objects: missing tests & --stdin-packs segfault
 fix
Message-ID: <YND32s96yDkM51qZ@nand.local>
References: <cover-0.2-00000000000-20210621T145819Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover-0.2-00000000000-20210621T145819Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 21, 2021 at 05:03:36PM +0200, Ævar Arnfjörð Bjarmason wrote:
> When re-rolling an unrelated series[1] dealing with pack-objects.c and
> revision.c I discovered that we have some test blindspots, and that
> the newly added --stdin-packs option in v2.32.0 will segfault if fed
> garbage data.
>
> This fixes the test blindspots, and 2/2 fixes the segfault.

Thanks. I took a close look at the second patch, and it looks good to me
with a few minor comments. The first patch looks good as well, although
I didn't look as closely.

> As discussed in its commit message I'm being lazy about emitting the
> error message. If you supply N bogus lines on stdin we'll error on the
> first one, since the input is first sorted by the string-list.c
> API. The test case for the error message relies on which of two SHA
> lines sorts first, and I picked input that happens to sort the same
> way under both SHA-1 and SHA-256.
>
> Lazy, but I figured for this use-case it wasn't worth keeping track of
> what line we saw when, or to refactor the parsing check on pack names
> as we get input lines.

Yeah. I think what you wrote is entirely reasonable, too. I suggested
some alternatives if you are feeling motivated to make the error
reporting nicer, but as you say, I think the vast majority of use-cases
don't care about the output.

Thanks,
Taylor
