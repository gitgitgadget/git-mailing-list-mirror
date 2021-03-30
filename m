Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50AD3C433C1
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 15:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2593861996
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 15:50:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232038AbhC3PuL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Mar 2021 11:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbhC3PuE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Mar 2021 11:50:04 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57521C061574
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 08:50:01 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id z3so16902791ioc.8
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 08:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5oWiY1PQycFAQlokdocUbBBA2TpGGSICy/uqS2XEGxc=;
        b=KStfvPDXIU8l69qno58t0zUlsD2/zZ5MA5rWUQKybT7acCnQYy7vPYdMzpYVFHHMwf
         Ntzm72DwOi5/a5m12uoIyuDM6s+ZtqSA+DqdOcXZ0XdnK7/zvvEGsN+N0uEtCcpYLBHT
         7WZkf6VO3U32R+00/mqzA6KSQYjb0hf+DKoA88DpGs5wq5G0z629s+tc9CUdTW7MprCg
         GsMY31dwWq35HifqqiMoCiGKOFdniKduDQfpE3wT3jB7OWTz23rIzAHvRbQejWTI6cEX
         wSKqNbR5AmAniJMjoN4sdozSc+5W9p8gOAa0K+hB8uPwIghktSqpdwxSW0vELQAfdN2J
         DH4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5oWiY1PQycFAQlokdocUbBBA2TpGGSICy/uqS2XEGxc=;
        b=K31jFmuaVSLUY4hl/VL3L70LKgGeSdjfeDVEzm/MjnQY5mRkPr8/tNHR+6nsfrb8yd
         bwTN4Dvk+yE2NiIWo/dNlTFdRURJtkQ2Fsz+0XzeUPNDhFE4YRKoZOudLgzi2Mfr3e2H
         CBUmK37+P+ptNcSasxp+V+piT5CGehGC+VRz/E7RK6v7V5Gt6KllpaCEYVI+u2wT8sCE
         EJ2wzoKjDf5OkIxsnsDzGrJZ9ddJYHhGV6kdvWjWgd6ZG+7xG6dtXlzuWs/WxnHIihU4
         G8eUyheizAyAE3FUJIqJcLz6DeuerbKoBI5O1o0Ili1qLgItR3bbhBCm3SDAEKkzgWBV
         EvCw==
X-Gm-Message-State: AOAM532PpU6p3gaht/7nSzczDvCpPKjFom9x6anJPiA9zemlI8crLv2e
        3jo7UaP37tsiyFN0+kyoQ4TA+M3BXm2/gQ==
X-Google-Smtp-Source: ABdhPJzfCd6EWVJbz5OpIYAK+acuEcFY+Gmr8VQV5zVanzutk1wh7HAYKGVth16jzBwpAjs2WlrFTQ==
X-Received: by 2002:a5d:8707:: with SMTP id u7mr24344210iom.18.1617119400765;
        Tue, 30 Mar 2021 08:50:00 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:7b00:4f79:8763:6261])
        by smtp.gmail.com with ESMTPSA id i67sm11541161ioa.3.2021.03.30.08.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 08:50:00 -0700 (PDT)
Date:   Tue, 30 Mar 2021 11:49:59 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        gitster@pobox.com, dstolee@microsoft.com, jonathantanmy@google.com
Subject: Re: [PATCH v4 00/16] midx: implement a multi-pack reverse index
Message-ID: <YGNIp4AHcdaHHHUc@nand.local>
References: <cover.1612998106.git.me@ttaylorr.com>
 <cover.1617116623.git.me@ttaylorr.com>
 <YGNHj6iRlCOjjCL8@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YGNHj6iRlCOjjCL8@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 30, 2021 at 11:45:19AM -0400, Jeff King wrote:
> > This reroll differs only in the feedback I incorporated from Peff's review. They
> > are mostly cosmetic; the most substantial change being that the --preferred-pack
> > code now uses bsearch() to locate the name of the preferred pack (instead of
> > implementing a binary search itself).
>
> Yeah, I read over this part carefully, since it's actual new code (that
> isn't run yet!), but I think it is correct.

Thankfully this does have coverage via any test that passes
`--preferred-pack` (like the one below).

> One minor observation:
>
> >     @@ t/t5319-multi-pack-index.sh: test_expect_success 'warn on improper hash version'
> >      +			write --preferred-pack=test-BC-$bc.idx 2>err &&
> >      +		test_must_be_empty err &&
> >      +
> >     ++		echo hi &&
> >     ++		test-tool read-midx --show-objects objects >out &&
> >     ++
> >      +		ofs=$(git show-index <objects/pack/test-BC-$bc.idx | grep $b |
> >      +			cut -d" " -f1) &&
> >     -+		midx_expect_object_offset $b $ofs objects
> >     ++		printf "%s %s\tobjects/pack/test-BC-%s.pack\n" \
> >     ++			"$b" "$ofs" "$bc" >expect &&
> >     ++		grep ^$b out >actual &&
> >     ++
> >     ++		test_cmp expect actual
> >      +	)
> >      +'
>
> I'd probably have just skipped show-index entirely, and done:
>
>   grep "^$b .* objects/pack/test-BC" actual
>
> which expresses the intent ($b came from that pack). But I don't mind
> the more exacting version (and certainly it is not worth a re-roll even
> if you prefer mine).

I originally wrote it that way, but decided to write both expect and
actual to make debugging easier if this ever regresses. Not like it's
that hard to run the test-tool yourself in the trash directory, but
having a snapshot of that object from the MIDX's perspective might make
things a little easier.

Anyway, I agree with you that it doesn't probably matter a ton either
way.

> -Peff

Thanks,
Taylor
