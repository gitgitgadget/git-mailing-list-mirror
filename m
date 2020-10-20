Return-Path: <SRS0=RnkD=D3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F13A8C4363A
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 20:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71089221FC
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 20:15:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="Inh34vhs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409387AbgJTUPj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Oct 2020 16:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391350AbgJTUPj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Oct 2020 16:15:39 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 195A8C0613CE
        for <git@vger.kernel.org>; Tue, 20 Oct 2020 13:15:39 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id t6so1563366qvz.4
        for <git@vger.kernel.org>; Tue, 20 Oct 2020 13:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tzBoawxfzjYY37fo9ba2i6YkNaxm1eZfEVM6QeKZpCE=;
        b=Inh34vhsmvLyjtPgafVzXNNjyj5j5UTPi3yskWeGBqJGRHek4LcZic+NesmzJKztFX
         xnp1KTiSKWOGvfuuxRExS+6E+NkvZRZayvnKSClqwxEkj+9Tnpz6JystlpUQrh1iIlTY
         K+m4B79dGguO0EC8oEPi1o99xeEOkh9PMiCPe4G2LnpEuwKuLvIAYEfM7CWI3x8KWFD7
         h+lP/ECLffO+4JmwF8f2YQEfOKLpvPGvv5Voe8/aMGc+SaSE0oCHw1mGxhzmROzk/ct1
         kFur11s1bxtDRg8Uq1KeZPINJljwdT2MAnMDVOa7TdVQovtjR8V6wR4wwS6LtWbNhEx4
         ZeEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tzBoawxfzjYY37fo9ba2i6YkNaxm1eZfEVM6QeKZpCE=;
        b=j1A80FOWf3MiZ0UaT/IkHrizjlem0L7ERXjPG0u2E8AuA6ACeaZ80DvPy/Drhb+Yme
         vWb0JI5RRgxrngV4tvhOEGc+Ysvfy7z22ltATDu50MiSFlpL+IpwTyeOER+ypRm4LFiX
         +9T2+oVwjyk261EY9gcXCmVS2UlN4wyOskwstCKMjHD8E8Q7coeJiQAbQPrKANVDEIrR
         GdyJQzTQq8hcrgYwZ78idW6mk7363GVxsevlhkwH03f2pyZMjcnVqpsCF+jmKw16wyOF
         QiCOwH3B695G2qvEwm3HCwkNDAEaqjGfh1EizH5csRmg+yoPogXRV6m63VdHbcclL9pY
         x2QA==
X-Gm-Message-State: AOAM533tpkRof5EfxA0H+G1I6y4lk5aSCBmZuGmAkSSoOgfCoIUMbN4x
        HNcoomGd6FqSa3IE2KHPU8ZWwQ==
X-Google-Smtp-Source: ABdhPJwG9SVpXTe1K2voqMnvmCQGamJ9adJYOLfM5kDXsOGatRMvcHkIdmHQDei9lJ9sBB21mLViWQ==
X-Received: by 2002:ad4:4105:: with SMTP id i5mr5156382qvp.47.1603224938253;
        Tue, 20 Oct 2020 13:15:38 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:943f:d0f4:e8b9:b8f9])
        by smtp.gmail.com with ESMTPSA id z66sm1406536qkb.50.2020.10.20.13.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 13:15:37 -0700 (PDT)
Date:   Tue, 20 Oct 2020 16:15:35 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Charvi Mendiratta <charvi077@gmail.com>, git@vger.kernel.org,
        christian.couder@gmail.com, phillip.wood123@gmail.com,
        congdanhqx@gmail.com, me@ttaylorr.com
Subject: Re: [PATCH v4] t7201: put each command on a separate line
Message-ID: <20201020201535.GB75186@nand.local>
References: <20201017075455.9660-1-charvi077@gmail.com>
 <20201020121152.21645-1-charvi077@gmail.com>
 <xmqqa6wgbqpq.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa6wgbqpq.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 20, 2020 at 01:13:53PM -0700, Junio C Hamano wrote:
> Charvi Mendiratta <charvi077@gmail.com> writes:
>
> > Modern practice is to avoid multiple commands per line,
> > and instead place each command on its own line.
> >
> > Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
> > ---
>
> This looks good, but I am wondering what happened between v3 and
> v4.

When I applied this locally, I used this patch as a replacement for the
last patch of v3 [1]. That kept everything passing after each patch.

> As you've demonstrated through the microproject that you can now
> comfortably be involved in the review discussion, I am tempted to
> suggest that we declare victory at this point and move on, but I
> don't know what the plans are for the other 4 patches (I guess we
> won't miss them that much---the micros are meant to be practice
> targets).

Yup, ditto.

> Thanks.

Thanks,
Taylor

[1]: https://lore.kernel.org/git/20201020114319.18245-6-charvi077@gmail.com/
