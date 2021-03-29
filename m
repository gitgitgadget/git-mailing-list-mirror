Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CFA8C433E8
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 21:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5B066198E
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 21:35:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbhC2Vem (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Mar 2021 17:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231613AbhC2VeY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Mar 2021 17:34:24 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C637C061574
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 14:34:24 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id g8so7206779qvx.1
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 14:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=G7OayzxrfFVbcMN84/1yINFzN49s9Su5Hydbta07fag=;
        b=LdD1TE+oK0UgWNbmuMp5uvGDVlLnTzTeMlyowIoCuU3feXGN2KzIJU1QTpzg9TgRHH
         2PTNyc2bZaTrTo+0EErsHEtkxPTZ3Y2zEZ/6ARvJmhIIZ0gHa9nPsMkvl0JUM0nhLHSI
         G/HkOVpNkKAwTDcCPShireVOtUkfqhTn1zN1oJyIC2RoFrVOlhvLzuusCc9//0NsD8uC
         JR3D/B3UTpESah8sMoqtNPmsnqGW0Bu6i/R/mN/3McuAl7gvfXyaR0ffxCBMr8Oc3hzx
         XKeVdbl9o8uAzODGYSwv8/02peAqPgCj3IcHn9ipfB3d12tLoUB8/XedMrB/M9YA/MIj
         0zwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=G7OayzxrfFVbcMN84/1yINFzN49s9Su5Hydbta07fag=;
        b=rZbYaDlOr//n4UY5U0AUD8DFNEBeOUbbhjLjbQ+F/HtQSfgNP5mPgFg08gmkLTu0KF
         ee6IDXQs1IXaB/HO6i+d9GR0kuQhXTiKeSlkyxLvIs7Zq4gkbCUFyymD3iJt1BDKo2hM
         sqOzpxiQmxYgfmeqQZdPCGNbUa4+5X9xjtYgbqhwRmFqwYeSmsMjqFl62LXoe6bOaXUz
         jySB5imrV3AdA9GAXoYJZCV4bwXreahLK6l7I+xT6yC8kOiCR3BWLo4IqC7ZCvsyaEA2
         XazKcaA+06kpcPFQFwN5zkCjwVuTR7SqMi6+PjBuO7D3Hb3AEGwj0Qs2+1KK9QgcPyOk
         wgGQ==
X-Gm-Message-State: AOAM532zNxCAdEuy02uk/+DuiJc1Sh+LhkxTIHgkQrC3wT7XZaLjIcYx
        RHMpcAz2aQdu5Pl7dtE5x7IRS2kkv6iTfQ==
X-Google-Smtp-Source: ABdhPJy+ngWLIdI0HAKgiLzVfLCV+RzujeHRXzijGP1q3vHBHjOti8KV16t6WPpcvNJSS7+oCjgL3w==
X-Received: by 2002:a0c:c342:: with SMTP id j2mr27093174qvi.41.1617053662589;
        Mon, 29 Mar 2021 14:34:22 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:7b00:4f79:8763:6261])
        by smtp.gmail.com with ESMTPSA id o21sm11769314qtp.72.2021.03.29.14.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 14:34:22 -0700 (PDT)
Date:   Mon, 29 Mar 2021 17:34:21 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, avarab@gmail.com, dstolee@microsoft.com,
        gitster@pobox.com, jonathantanmy@google.com
Subject: Re: [PATCH v3 16/16] midx.c: improve cache locality in
 midx_pack_order_cmp()
Message-ID: <YGJH3fzQXL6TvPK2@nand.local>
References: <cover.1612998106.git.me@ttaylorr.com>
 <cover.1615482270.git.me@ttaylorr.com>
 <550e785f10ba14f166958501c007b75a04052a0d.1615482270.git.me@ttaylorr.com>
 <YGHPINrwIZ1mKK+y@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YGHPINrwIZ1mKK+y@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 29, 2021 at 08:59:12AM -0400, Jeff King wrote:
> On Thu, Mar 11, 2021 at 12:05:42PM -0500, Taylor Blau wrote:
>
> > From: Jeff King <peff@peff.net>
> >
> > There is a lot of pointer dereferencing in the pre-image version of
> > 'midx_pack_order_cmp()', which this patch gets rid of.
> >
> > Instead of comparing the pack preferred-ness and then the pack id, both
> > of these checks are done at the same time by using the high-order bit of
> > the pack id to represent whether it's preferred. Then the pack id and
> > offset are compared as usual.
> >
> > This produces the same result so long as there are less than 2^31 packs,
> > which seems like a likely assumption to make in practice.
>
> Obviously this patch is brilliant. ;)

Obviously.

> Did we record any numbers to show the improvement here? I don't think it
> can be demonstrated with this series (since most of the code is dead),
> but I recall that this was motivated by a noticeable slowdown.

Looking through our messages, you wrote that this seemed to produce a
.8 second speed-up on a large-ish repository that we were testing.
That's not significant overall, the fact that we were spending so long
probably caught our attention when looking at a profiler.

I could go either way on mentioning it. It does feel a little like
cheating to say, "well, if you applied these other patches it would make
it about this much faster". So I'm mostly happy to just keep it vague
and say that it makes things a little faster, unless you feel strongly
otherwise.

> I briefly wondered whether the complicated midx_pack_order_cmp() in
> pack-revindex.c, which is used for the bsearch() there, could benefit
> from the same speedup. It's only log(n), of course, instead of n*log(n),
> but one might imagine making "n" calls to it. I don't think it makes
> sense, though. The pointer dereferencing there is into the midx mmap
> itself. Creating an auxiliary array would defeat the purpose.

Right.

> -Peff

Thanks,
Taylor
