Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4EFFC352A1
	for <git@archiver.kernel.org>; Wed,  7 Dec 2022 02:38:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiLGCiK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Dec 2022 21:38:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiLGCiF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2022 21:38:05 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F4433D904
        for <git@vger.kernel.org>; Tue,  6 Dec 2022 18:38:04 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id h15so7323437ilh.12
        for <git@vger.kernel.org>; Tue, 06 Dec 2022 18:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xK/HMjpxrLZLKlGYByW/LmQK9EIBBZVG5BE83p9ietA=;
        b=L3DlbuCwG4gj8Y8m6ny5YApUOev6YTnNqx4jrTex2jVIhCGt1acXvsQj54zfHx6ECf
         1L0eAQrDjLxQ0Y7EQfqydfN+awPR5Vsya/gIu805ncGPV+lUP5PGXkwUaW7GGnQn38ce
         SKMik6C4QjPwnc++yi/tkYO4mdIOuB5tEsggMMMQeMnLeaC98QBI+grQKDgZ1G2z50PX
         MJoRIgyixCMnatSX3kDPoKrdQEPqWCJ8v7WBQEO2kPP94+taJXhPIDsDH6sVsa8Hgtnk
         gWUa8zGMvOd31LUYW+ym2cHtQ93ReLkNB4i1/MgSpU5tWr/yW09g+Ykh+MSZV9pPFgDQ
         +o7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xK/HMjpxrLZLKlGYByW/LmQK9EIBBZVG5BE83p9ietA=;
        b=Y238QRwihNEHSr9piOc4ADYkVY6zfciYzAMJILQ//sTboeEhSrjY0c9RFBewODWUUR
         GAGYOq88X/vO5LAhTB2Ma8dfSVTyFBB8R2sePijrABuIjlA9OFLtnY+pLLYwYQYMOgwh
         OdB3hHGBGk+khuaEN1dbrJ2+/bliRj0UXO7d4w/wDrAFOJwPsEZx8MGvc2OoTmNgAaXQ
         dZBSCgsNi+xrfSD+Eq3zvOLN6+9Obo8pwxxmpGUBkvVfYERFx9ezo5TTr0Q60o+Vyxhg
         IDCqblk+EMrjzdhFdCqFficNv72ZoVb4OmDAjGjWAfK2Y886MhQmxbVEL4nQF78TXJvR
         16Qw==
X-Gm-Message-State: ANoB5pnPnF554AAZfzjz/37TFL/PHr1bBFRYtgDX6lSdO9txnURNJdQc
        +G8IKPjh8YKHwLzEYELjNGcO0EEa3xilgv72
X-Google-Smtp-Source: AA0mqf4s1pqA5sjiv2Mnqi6uR5aOjBZ7w9gwR2IS5jz6JNVtOu2jeOyKLHkmnHaChGqy1cwxCwoQXg==
X-Received: by 2002:a05:6e02:c0d:b0:300:b1ee:c196 with SMTP id d13-20020a056e020c0d00b00300b1eec196mr34635922ile.237.1670380683529;
        Tue, 06 Dec 2022 18:38:03 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id f19-20020a5d8793000000b006cf3a1c02e6sm7388656ion.15.2022.12.06.18.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 18:38:03 -0800 (PST)
Date:   Tue, 6 Dec 2022 21:38:02 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH] git-compat-util.h: introduce CALLOC(x)
Message-ID: <Y4/8ilFBfGApR8YR@nand.local>
References: <6694c52b38674859eb0390c7f62da1209a8d8ec3.1670266373.git.me@ttaylorr.com>
 <xmqqedtdpfoe.fsf@gitster.g>
 <Y46M4oksPQkqwmTC@nand.local>
 <Y46ZJUsyp8UW5rFW@coredump.intra.peff.net>
 <xmqqv8mpnwjp.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqv8mpnwjp.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 06, 2022 at 10:35:54AM +0900, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
>
> > So you can think of "allocate this one element and zero it" as "calloc,
> > but don't multiply" or as "malloc, but zero". Naming it CALLOC() is
> > thinking of it as the former. If we think of it as the latter it could
> > perhaps be MALLOCZ() or something. I don't know if that name is too
> > subtle or not. We have xmemdupz(), which is basically the same thing;
> > it's only a zero-terminator, but that is because we are writing non-zero
> > bytes in the rest of it. Mostly I'd worry that it is easy to glance past
> > the "Z".
>
> I think the name for the former would be CALLOC_ONE(), as I would
> rephrase it as "calloc, but just one element".  I agree MALLOCZ()
> would be fine for the other interpretation, and I do not have much
> problem as much problem with the name as calling it CALLOC().

Between CALLOC_ONE() and MALLOCZ(), I prefer the latter for brevity. But
between that and CALLOC(), I prefer the latter, since "CALLOC()" reminds
me of the zero-initialization of calloc()-proper, and the "Z" in
"MALLOCZ()" feels easy-ish to miss.

Thanks,
Taylor
