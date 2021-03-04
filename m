Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4DA6C432C3
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 21:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BFAE65018
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 21:41:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240270AbhCDVla (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Mar 2021 16:41:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240165AbhCDVlY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Mar 2021 16:41:24 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0191AC061762
        for <git@vger.kernel.org>; Thu,  4 Mar 2021 13:40:44 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id o1so106161qta.13
        for <git@vger.kernel.org>; Thu, 04 Mar 2021 13:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dJS/MF3OoS+ZMkL4mLll7f4WvyrFC0MB2l1LT790maU=;
        b=O07uWsrqJ0a2tdbpeIkY6xDKPTWU0qU0iuBu1SSKuBGKPtZWCn56eg8n5QuQwzMk0+
         k9LZfNJNKqeQRJ+kl5EpCZrfInLzHag8O+UqtoJAIEe1pq3me/TTVQuvBp1vfLFIbWhG
         UmUb3CAa0ktpsax4y9v77oGY7sFWhSAdaEpiiXH4p0ojFgoBfKa+5gpD0dtqQpO6/uL0
         JeGOpKa7SM7hWM+UGB0aQDN8NNZlMyG6yYLqO/8AVJ1bI1oy8ms6jx79TgMkvlEvbodd
         1kPQtQVnRMsKQ/aoE1caq+FSbhCsvHhIiT7usEcCNgw5i2nh7o2SfKP9xBu2e/0T2rXm
         mYSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dJS/MF3OoS+ZMkL4mLll7f4WvyrFC0MB2l1LT790maU=;
        b=aMeDwYrY9SBw/d3oTpWjZdoZnRlXmvm4jlM+rrFgjsZMta0APvlliCm4G9G5FIThFn
         1aRjMcI21bmX41eoNgFU4miUiY0V0aOOf/+qkFNVZioLLWc/n1QTw+kse917ECa3pXxs
         cP6uS+xoYI4AysDmY9MuyiseRyEY9cnXBd9RpwQvKdU0FH+LeHHjsIY6F+W7AASZ8QP7
         QsbpBZiH5CxDjX5ua6T2ScxSGu/4UU/bYb44jpeK+1zTWsF8mO1ChVGQrLiGNh1DCpZt
         ERbedj0NYZ1WA73jRCm5nRYULUxrwLdskjslbsIiWJLWcvXRv1G2S4h81ykBGYI57ra5
         UObA==
X-Gm-Message-State: AOAM530u3W0ZGvgU9D1N+gC6kERGBf9FxTUuvEFqOUT+1TQzSkeO+l2w
        OXbs7D553r4bRgbYD4qc+eMDGQ==
X-Google-Smtp-Source: ABdhPJwa06oQpCItARthDsFqLeavogWMbAqFMqevlLdcYXcfBdki0GXJDp0Nf+tccNSAoU1KfduHdw==
X-Received: by 2002:a05:622a:210:: with SMTP id b16mr5899172qtx.69.1614894043168;
        Thu, 04 Mar 2021 13:40:43 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:4ce8:219:f731:dbf5])
        by smtp.gmail.com with ESMTPSA id z11sm457141qkg.52.2021.03.04.13.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 13:40:42 -0800 (PST)
Date:   Thu, 4 Mar 2021 16:40:40 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com
Subject: Re: [PATCH v4 8/8] builtin/repack.c: add '--geometric' option
Message-ID: <YEFT2P2DxzlT3/+t@nand.local>
References: <cover.1611098616.git.me@ttaylorr.com>
 <cover.1614047097.git.me@ttaylorr.com>
 <51f57d5da23244ebde27ad6c14cbf4b63da3317d.1614047097.git.me@ttaylorr.com>
 <xmqqv9ahxddp.fsf@gitster.g>
 <xmqqo8g9xc9l.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo8g9xc9l.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 24, 2021 at 03:43:34PM -0800, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
> > Let me try to follow aloud to see if I got this right.
> >
> > If we start from 1+1+1+2+4+32+... (similarly to the example given to
> > explain 2 above, but with more larger packs---but the assumption
> > here is that everything larger than 32 is already in good
> > progression), depending on how many loose objects we have, the
> > result of packing 1+1+1+2+4+loose might not necessarily be 9 but 100
> > (collecting too many loose objects), and the set of packs would be
> > 32+... (from before the "repack -g") plus a 100-object pack, not
> > 9+32+... as the above explanation for 2 suggested.  Starting from
> > that state, re-running "repack -g" again would then have to repack
> > the packs existed before the first repack (i.e. 32+...) into one.
> > In other words, the second "git repack -g" in back-to-back "git
> > repack -g && git repack -g" may necessarily be a no-op.
>
> "... may not necessarily be a no-op" is what I should have typed here.

Exactly.

> > Is that what you meant by non-idempotent?
>
> And I think it makes sense for the repack to be non-idempotent.
> Once we have packs in good progression, it is the only way to make
> progress by keep rolling loose objects up into the smallest pack
> until it grows larger than the geometry factor allows it to be
> relative to the next smallest pack.

Right again. It *would* be idempotent if we didn't push any new objects
into the repository (and repacked it with the same geometric factor once
more to clean up any inconsistencies after creating a pack with loose
objects), which is what you'd expect.

Of course, pushing new objects into the repository means that the
progression will either grow (i.e., because the smallest pack in an
existing progression was quite large, and so we have some space to grow
smaller packs before rolling up the larger one), or it will get rolled
up.

Thanks,
Taylor
