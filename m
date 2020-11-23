Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF76C2D0E4
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 16:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF6722080A
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 16:52:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="PmthsNdX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732092AbgKWQwN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Nov 2020 11:52:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729815AbgKWQwM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Nov 2020 11:52:12 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD3C4C0613CF
        for <git@vger.kernel.org>; Mon, 23 Nov 2020 08:52:12 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id b6so4990131pfp.7
        for <git@vger.kernel.org>; Mon, 23 Nov 2020 08:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wCHP+CiX43RbXU7uRH2/j12PxpVIzT36ebk+dyCQpEw=;
        b=PmthsNdXTFp+57MGgulzaxSOybMjDwwUJdQKvypX9Jxj1YXKYLyi4Yp8sZznWkE8JA
         CKR3Ewj+wfzMR2nAFgedq7h7XoamjRO3e8vXAf97SiEAFSsPjuE+S4kPfrNcajg3vvgK
         mQTe9H6Q0tn7Weulhl+ikJa5fNXSl9AEDQooqS+MeMcHOSRL2djxutWFtt0UcwBm7Qtz
         P6CeI39i5St5nD6OpvIZHx8/L1NYgzpRi4vLufppwbTOl4e1sGi1Dx9e4sQgaGmO1DnS
         unH0AZwEtbxUwk4SllW155LxzdISK9siomiOLJ6Kln0mnvSLItWxswG8FjSgkbB7TI2B
         8mmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wCHP+CiX43RbXU7uRH2/j12PxpVIzT36ebk+dyCQpEw=;
        b=HJijboCeHTOblqSVrfmGHJ81x/eoO1qJPMks+jmDLej3XrhLEXtIioQQTuEjwvFAs1
         moYqPIYRhzMs5TVPmXm+/NQ0WLwhO9kYToqWt5NOY9eMyNj1SBVm1XucCwp9IxOVjqFe
         XJd3LI6FQdq9FVAVCoHIURBYOYqQMWsF3wYYYUyJBzJqGUrlrY+kF6tPqZAyGfEPEQQN
         mWSe/8l3c218c+aX8pE4SU4EOAaXhZB5rZru6Q4SDI/nPkmUmByx5eZa/i25JZqXMdwv
         2j99WdMxOtFp8DO1iRSaoPToN4exd6BbTejWs3oAKXUeb4V9JFTjl/FB81esKEUFy9qE
         QecQ==
X-Gm-Message-State: AOAM530w6vLb3pWvXop+bHsVCGdE3n2bwmEaAIRqeFgCbS2wK7N2t5a+
        4XkTbYZ8jxK/jvIXXJrW3ObPhr+apR23FuYX
X-Google-Smtp-Source: ABdhPJyLAvZ6grKt95o6GWwxk8e8hnwS7twTHOdqKhjCz4fKcq4xpYuwXojkJ/Hpt0vxGelZQkdKYg==
X-Received: by 2002:a17:90a:4410:: with SMTP id s16mr18147pjg.159.1606150332141;
        Mon, 23 Nov 2020 08:52:12 -0800 (PST)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id z9sm15084992pji.48.2020.11.23.08.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 08:52:11 -0800 (PST)
Date:   Mon, 23 Nov 2020 11:52:09 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, peff@peff.net
Subject: Re: [PATCH 08/23] ewah: implement bitmap_or()
Message-ID: <X7vouTlBlT62H7A4@nand.local>
References: <cover.1605123652.git.me@ttaylorr.com>
 <dce9b6da0ad38da0a92b39d780d7b56f83d52950.1605123652.git.me@ttaylorr.com>
 <xmqq3611qgg4.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq3611qgg4.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 22, 2020 at 12:34:03PM -0800, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > From: Jeff King <peff@peff.net>
> >
> > We have a function to bitwise-OR an ewah into an uncompressed bitmap,
> > but not to OR two uncompressed bitmaps. Let's add it.
> >
> > Interestingly, we have a public header declaration going back to
> > e1273106f6 (ewah: compressed bitmap implementation, 2013-11-14), but the
> > function was never implemented.
>
> So we have had decl, no impl, but it did not matter because there
> was no user?  Presumably we will see a real user soon in the series
> ;-)

Indeed :-). I added a note to this patch's log message to indicate that
a new/first caller would be appearing in a couple of patches after this
one.

Thanks,
Taylor
