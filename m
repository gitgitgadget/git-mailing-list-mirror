Return-Path: <SRS0=rdad=ID=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F96FC433E0
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 19:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC68E650A8
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 19:41:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbhCETlS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Mar 2021 14:41:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbhCETlF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Mar 2021 14:41:05 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E8EAC06175F
        for <git@vger.kernel.org>; Fri,  5 Mar 2021 11:41:05 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id g27so3252818iox.2
        for <git@vger.kernel.org>; Fri, 05 Mar 2021 11:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0eGGxPFaQesUv0LKPPcxOSuV/1JaxLJNrf7sgtuqg3w=;
        b=lFfCJc9W8pS+Xez9uwh+UyxTHWzgC1V0WlXVS8bGMxrGp6Cg+yx+5KLeQ/ArvbW0Rt
         HAVc/N83uEg/0HMj0/V60PycHq72HlHjoncCpGrI9j73g8anqN8iPKIcEWon3EfyIpIu
         MmgQNEJQ9UpaBMQnlFphAuLlYuus20nUAmrSJOKhkMqODECeSAwVnr0yQxVDMBdwJVFk
         +PxCwyjTeTAR9GZ21kuZf0cUXvwMI94Aoq96Bm30TyFdWd6JceE7CU3ElNmWa772g77m
         TKFbeSAeS+N61lGGuCsCIE3czqEEvGFkn4QFQ9+MPuZgyBpqW7aANn8A1iUgvuPcOdI4
         iYLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0eGGxPFaQesUv0LKPPcxOSuV/1JaxLJNrf7sgtuqg3w=;
        b=NfLBB4MzxXACCn/GB4FbAUHc+mcXa3E+MRvyPtuHLNhg9xdNgaEr27stgZbU5jmsZ2
         Klznev5u0d8dGkkcXH7K1vIe/1fGO9R9xd6z0Hy5EyyfEC8h04J+czzn9Gdago56h2gb
         4G26zz2DvEBUGlFKSLekBZ0L5Ggml842N1IfGrzFAMHZoxux7OvztmJl3ARIPmwliRAm
         yu8UYQn2weZ6TaamINcF1w+sv3D4d1ialw2mSECC03wKpywWt3uL14IPGSvBglsplfqH
         qCvhkz8At+LUmHHlg8bctCZoPv4Q3YNiFkAHrJHNgeEXRRBXjhfpgSkIPaNrs48o+LuW
         dkmg==
X-Gm-Message-State: AOAM530lpt5Q4eO1J224a/q6Ge+z2AfKfjUyftPp8YiDaohM5Sys10Bc
        2Cb50taie28vCdf5vTGv3UKyBA==
X-Google-Smtp-Source: ABdhPJx4aKNJ2alvSWfDFMu/Pgf82nP0OOyySngTGtx7ZCgkwuqxbzNbM2ZBOuRgcZJQ3QFHT6pSAQ==
X-Received: by 2002:a05:6602:cc:: with SMTP id z12mr9034981ioe.190.1614973264949;
        Fri, 05 Mar 2021 11:41:04 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:4ce8:219:f731:dbf5])
        by smtp.gmail.com with ESMTPSA id x3sm1612038iof.21.2021.03.05.11.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 11:41:04 -0800 (PST)
Date:   Fri, 5 Mar 2021 14:41:02 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH 4/5] builtin/repack.c: be more conservative with unsigned
 overflows
Message-ID: <YEKJTmbdZqdMx2j0@nand.local>
References: <cover.1614957681.git.me@ttaylorr.com>
 <d55324f7a256fce491a29a1debf142f817eb01d3.1614957681.git.me@ttaylorr.com>
 <xmqqr1kt9z12.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr1kt9z12.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 05, 2021 at 11:32:57AM -0800, Junio C Hamano wrote:
> > Suggested-by: Junio C Hamano <gitster@pobox.com>
>
> I do not deserve this for my idle thinking-out-aloud speculation.
> You did all the thinking and work.

You're selling yourself short ;-).

> I do not offhand know what a sensible and gentler fallback position
> would be for the factor multiplication, but presumably, if the right
> hand side of this ...
>
> >  		if (geometry_pack_weight(ours) < factor * total_size) {
>
> ... overflows, we can say it would definitely be larger than our
> weight and continue, instead of "no, we cannot multiply total with
> factor, as that would give us too big a number", I guess.

To answer your question about whether or not dying is sensible, I think
that there are a couple of options. You could say, "I can no longer
multiply total_size by factor without overflowing, so I'm not even going
to bother considering additional packs". I guess that makes some
progress in condensing packs, but that's as good as it would get, since
the subsequent repack would also overflow instead of making further
progress, so it would just get stuck.

Which makes me think that the other option, dying, is more sensible. But
I think that this is all a moot point as you seem to indicate anyway,
because having a large enough pack that we are verging on overflowing is
likely not a real-world problem that we are going to deal with (at least
right away).

> I am OK to either (1) leave the code as-is without this patch, because
> the overflow would only affect the largest of packs and would be rare,
> and people who would notice when they hit it would probably are the ones
> with enough resource to diagnose, report and even give us a fix ;-)
> or (2) apply this patch as-is, because the only people who will see
> the die() would be the same ones affected by (1) above anyway.
>
> And applying this patch as-is would give better chance than (1) for
> the overflow to be noticed.
>
> So, let's queue the patch as-is.

Great, I'm fine with that. Thanks.

> Thanks.

Taylor
