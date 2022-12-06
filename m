Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BDA4C4708C
	for <git@archiver.kernel.org>; Tue,  6 Dec 2022 00:29:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbiLFA3g (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Dec 2022 19:29:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232037AbiLFA32 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2022 19:29:28 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36331E3CA
        for <git@vger.kernel.org>; Mon,  5 Dec 2022 16:29:24 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id n63so4308555iod.7
        for <git@vger.kernel.org>; Mon, 05 Dec 2022 16:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZmhhQW/g4MrfgnCxX9JAxSCu1zRlk2bjUWA689GQoqU=;
        b=GbVtaLRaun4HCcRq9858FwAgs4arXvWS85YgJcOR68fINQ+lA+Os0Xge6KetwduOtK
         5b27Hcxzrzo9b11i9T/aIbfoe2KZyvXjp9N/uBB6QT54b2vYfUG3Z2TqPIcqmDt2Qw7b
         3allrZ6QHzY/A8GvjbyiBylXrmRYGYMzHHvcRYFjgq8K8aoKPhddxSq4N0d1GChNYYXb
         1P3JFMr+yn+A/MxoxhmAXCEwCUJ5/HuYhOpk2O5mI8ZAIXPiS9Sba+cs67TVIzHEPEv0
         l5pbdJbQH11XPAAx6Km069dIpxEysG0Qwmqm3GJCGf3OGrtJOMX+fI7HEPeqofV0f1YV
         6BAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZmhhQW/g4MrfgnCxX9JAxSCu1zRlk2bjUWA689GQoqU=;
        b=vs6V0Wy2tTRzFsK4KvCsr6g++U/aA/22ds2Ch038HhIcAHNfoXh4hwueWFeI2A/Ng9
         hesb+upjZ4jduOPQ0ECdl7VDpuX9P2Z4r6F47Mi0fuqtf3NNfMi85xrL9S7+Li6LyPWG
         7BKAnasEWVM26RGGbqUe0eZ00r/hBRZ2fYLaZshG5FT2hYJUjm0OsGh85U/EUs6ooExw
         U86VrYmAy0hs/fJ5tAU80yX63V72wxjLech63mfRofqIR8YuuxsGyrhFaxWuJ0aMqpDT
         jVjt4j9nziuA/oRuaQVRgAv9cOIH2Vt104++M4zTiZ+ut4uEJ++OLSr6xcp7RhArMPpl
         wzpA==
X-Gm-Message-State: ANoB5pmMgOcntNdNJjHg40xvGxWrtumEEcgqirp4dpYdmVJ6uNDd2dcX
        VfKmhBX/bSQXTAd/nxMT0gMV5w==
X-Google-Smtp-Source: AA0mqf7L8DBw47lzOACLyQE7er0IxywFxSqK/S0KttOYuZVjhRCVqP3BarPEgZU21bAH3iJB6+IkLg==
X-Received: by 2002:a6b:fb06:0:b0:6e0:c4d:65e2 with SMTP id h6-20020a6bfb06000000b006e00c4d65e2mr3376401iog.30.1670286563950;
        Mon, 05 Dec 2022 16:29:23 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id y6-20020a027306000000b00389d6a02740sm6104808jab.157.2022.12.05.16.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 16:29:23 -0800 (PST)
Date:   Mon, 5 Dec 2022 19:29:22 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-compat-util.h: introduce CALLOC(x)
Message-ID: <Y46M4oksPQkqwmTC@nand.local>
References: <6694c52b38674859eb0390c7f62da1209a8d8ec3.1670266373.git.me@ttaylorr.com>
 <xmqqedtdpfoe.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqedtdpfoe.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 06, 2022 at 08:57:21AM +0900, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > In git.git, it is sometimes common to write something like:
> >
> >     T *ptr;
> >     CALLOC_ARRAY(ptr, 1);
> >
> > ...but that is confusing, since we're not initializing an array.
>
> Given that "man calloc" tells us that calloc takes two parameters,
>
>     void *calloc(size_t nmemb, size_t size);
>
> I personally find CALLOC() that takes only a single parameter and is
> capable only to allocate a single element array very much confusing.

Hmm. I have always considered "calloc" a mental shorthand for "zero
initialize some bytes on the heap". It seemed like you were in favor of
such a change in:

    https://lore.kernel.org/git/xmqq8rl8ivlb.fsf@gitster.g/

...but it's entirely possible that I misread your message, in which case
I would not be sad if you dropped this patch on the floor since I don't
feel that strongly about it.

I'd be fine to call it CALLOC_ONE() or something, but I'm not sure at
that point if it's significantly better to write "CALLOC_ONE(x)" versus
"CALLOC_ARRAY(foo, 1)"

> It _might_ be arguable that the order of the parameters CALLOC_ARRAY
> takes should have been reversed in that the number of elements in
> the array should come first just like in calloc(), while the pointer
> that is used to infer the size of an array element should come next,
> but that is water under the bridge.

Yes, I agree that that would be better. But it would be frustrating to
make a tree-wide change of that magnitude at this point. So I agree it's
water under the bridge ;-).


Thanks,
Taylor
