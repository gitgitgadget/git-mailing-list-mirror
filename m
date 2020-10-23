Return-Path: <SRS0=cWhr=D6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33716C388F9
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 17:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFD1B21527
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 17:29:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="w6hwfniz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S464763AbgJWR3P (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Oct 2020 13:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S465904AbgJWR3O (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Oct 2020 13:29:14 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D712C0613CE
        for <git@vger.kernel.org>; Fri, 23 Oct 2020 10:29:14 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id de3so1066168qvb.5
        for <git@vger.kernel.org>; Fri, 23 Oct 2020 10:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hQW++4o/AICdEVu7u8osm8epthW7ZriE3uNiO5TUUGY=;
        b=w6hwfnizddPCtkH1nu5c+UEimnkqHLrBfsjzG2/y2QQnU+oqHYpdb4CQiq/qUT4PjT
         5S4guZ568MK+kb1DSCa5jDiBdioR3OS65W2CnFI+GtKa5HgivaPv1Pjkjnndf+SS1E5h
         96wDSig3YrgiPOJ3tI8geqEHsGLqbqaVbU4tGVJ5QcH27RvMyLD1WkRhIyf9KtGL0lsN
         XFKOQ+5J4HU0Ueyju+fa4UbeW59aVrBCu9IsasvAuxyVIkqhWWqteIN3O6LKaTlaWFGq
         ldBE9XCI8jkie9clzWoue5sp/lham3vLrY/jy2Xk5M5RNZ3kvUe8MeRsuuX0rxD7WCjx
         duOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hQW++4o/AICdEVu7u8osm8epthW7ZriE3uNiO5TUUGY=;
        b=ABZFfqFRtpz+Vjf6cqW+wG/iZSr0fBNVpNhCIV1bdv2Q+dPQSPbmEgFIKEiAZDpAe2
         iPfLoaNfPtV+vJO+QuD9vlZH01NO+lOdfB75u/PkNejIpjTzhFHJwL/mh04Xz5swJ/mJ
         RjgoTTuybjgNGdY2fAfMv5M/eNXEBnXe8bA9MTlSbKJTxFkrGGbiFghJht6OFw35Jv4k
         tI2NboZj5zOxLI/NmbHzSo/wWm3LKNBOLdX4OmFpMyLvtajUlxJVXxmudntGf4OJ+wWF
         OyQymd9L7BheF7LTwTSJL4NNqJhIWLxgg3IelZY1YmTao++k742XSCkKnk87lU/5i9zx
         qNOg==
X-Gm-Message-State: AOAM532QuggWct6GaEh6IZHoP0MMWJM28pp+x7NzBhaEei5s2BnqB2Rs
        J2PDSAV6i9kK1unMxc4sdDyTPYilXI2FUIxw
X-Google-Smtp-Source: ABdhPJwGf9ygiZz6Dis859Q3W6I+vC7Tv2wQLaK/hKTo0POu/jx176ephzsM735DczZiKidPjJZgzg==
X-Received: by 2002:a0c:8644:: with SMTP id p62mr100380qva.30.1603474153704;
        Fri, 23 Oct 2020 10:29:13 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:eda0:8d26:51d2:6e87])
        by smtp.gmail.com with ESMTPSA id h141sm1168536qke.41.2020.10.23.10.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 10:29:13 -0700 (PDT)
Date:   Fri, 23 Oct 2020 13:29:10 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     VenomVendor <info@venomvendor.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>, git@vger.kernel.org
Subject: Re: [PATCH 4/3] am, sequencer: stop parsing our own committer ident
Message-ID: <X5MS5l2bbRczcdgF@nand.local>
References: <20201023070747.GA2198273@coredump.intra.peff.net>
 <20201023070939.GB2913115@coredump.intra.peff.net>
 <20201023072630.GA2918369@coredump.intra.peff.net>
 <20201023074510.GB2918369@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201023074510.GB2918369@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 23, 2020 at 03:45:10AM -0400, Jeff King wrote:
> On Fri, Oct 23, 2020 at 03:26:30AM -0400, Jeff King wrote:
>
> > By the way, I wondered why we needed to do this parsing at all. The
> > patch below does this in a much simpler way. It's a little bit ugly, I
> > think, because we have to call getenv() ourselves. But that's the way
> > fmt_ident() has always worked. We could probably improve that now that
> > it takes a whose_ident flag (before that, it had no idea if we wanted
> > author or committer ident).
>
> I took a brief look at refactoring fmt_ident() to auto-fill from the
> environment variables (patch below). It's mostly sensible for
> name/email, because callers pass either the environment variables or
> some custom-provided value. But for the date, we sometimes pass NULL to
> mean "use the current time, even if $GIT_*_DATE is set". I'm not 100%
> sure that isn't a bug, though.

That seems like an area where further investigation would be helpful.
In the meantime (especially if this is something that Junio wants to
queue and call v2.29.2), I'd be happy with the four patches you posted
(but waiting on this one below).

Thanks for investigating.

Thanks,
Taylor
