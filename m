Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0ACBC4332F
	for <git@archiver.kernel.org>; Wed,  2 Nov 2022 00:53:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbiKBAxK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Nov 2022 20:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbiKBAxH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2022 20:53:07 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F22A1C103
        for <git@vger.kernel.org>; Tue,  1 Nov 2022 17:53:06 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id y6so10860544iof.9
        for <git@vger.kernel.org>; Tue, 01 Nov 2022 17:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JOTpi/74G7x+IcZDZAMDzze8GFCb8RkNu3G/S1KCwu0=;
        b=iD5HjAenFFYwfsFAWKdcvCBMHeyPiGbQjbCmJgvNSuG+kP78sPr7g7Ysof9tpUcuBW
         y3gkrxF4LlsTDRzVcmSUmcYi9Yj2owCpy7byhebGL692XnNFTrivTp6AngRTyFLd3f1c
         0ZtrbGfJQ9z7zPwt03b/ZjstBtDbcXUbIHj2BtoNtHyokhRgEIo9Iv2812jTvWKo7TmU
         xX5qv22IxNAXn/0J76ReAHEdcJD3ltoNeFtSBoXe3R1FBIPqkuEUo3qo9gMqWdYpC9aR
         QrttX1EwHDqEV+C8i/xjuGf9jhbsqH5jlFCSAErysTsMcFtzTM5CSJazvECS09t4GUBG
         Y/lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JOTpi/74G7x+IcZDZAMDzze8GFCb8RkNu3G/S1KCwu0=;
        b=LBQpx3lVNn+J/6xc7FkhaD1vvUGcqpmigi67hWUMN8yJUTumQx0zl2UNG0399ivOTg
         B/GjGVdWy1BmnXf8pfiiUOdCqHdRrei8CIiLezT781QYkgTQFiOAofwM6K43Qflo8WYf
         A9OCz5+sptctJtCMjBye844BS+fOgWRS+2T0purNANUi4YQSmtAdrFdqI2sLrYYgaIRt
         1Mo7RbcPyG5wP4wqpumddM0RrHt2QpTwV75johS0M6WHRGYZavA5Q9nE73bj4xbvxGY+
         oEWriYKTzfpxLi7cT5mf/AgIz8xFMbL96SRDgYjpDqTxzNE/rn/kXMoVkvuj3gaA6mXU
         ytNw==
X-Gm-Message-State: ACrzQf354NTaW5tMEW8PfERRWtyCnHzlkXjl92u+OT8Ildt7LK4g1W37
        99iA62sbi1fiuq6bz451TDP2LYFafVabC1S/
X-Google-Smtp-Source: AMsMyM5pmp0y7d97tO1hkdRjIYacLAHY69nuWP/SVY7S6veCsjdX6m3etTAv/sk4GIblQFb/RiOYog==
X-Received: by 2002:a02:b80f:0:b0:363:bad1:26fe with SMTP id o15-20020a02b80f000000b00363bad126femr13616309jam.282.1667350384947;
        Tue, 01 Nov 2022 17:53:04 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id c2-20020a02a602000000b003566ff0eb13sm4180067jam.34.2022.11.01.17.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 17:53:04 -0700 (PDT)
Date:   Tue, 1 Nov 2022 20:53:03 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [RFC PATCH] fetch: stop emitting duplicate
 transfer.credentialsInUrl=warn warnings
Message-ID: <Y2G/b5L65+Kaw/WD@nand.local>
References: <pull.1399.git.1667245638.gitgitgadget@gmail.com>
 <RFC-patch-1.1-0266485bc6c-20221031T204149Z-avarab@gmail.com>
 <Y2CFRJLFRXvGwFBC@coredump.intra.peff.net>
 <221101.86a65b5q9q.gmgdl@evledraar.gmail.com>
 <Y2GHjnuyuwGpY3II@nand.local>
 <221101.86y1su2u2p.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <221101.86y1su2u2p.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 01, 2022 at 11:17:42PM +0100, Ævar Arnfjörð Bjarmason wrote:
> >> The tests aren't just asserting the bad behavior, they're also ensuring
> >> that it doesn't get worse. 1 warning is ideal, 2-3 is bad, but
> >> tolerable, but if we start emitting 500 of these it would be nice to
> >> know.
> >
> > I admit that this kind of argument does not sway me.
> >
> > Is it likely that we would suddenly start spewing 500 such warnings? If
> > we did, are there no other tests that would catch it? And even if *that*
> > were the case, would nobody happen to notice it in the meantime either
> > during development or when we queue an affected topic onto 'next' for
> > wider testing?
> >
> > I guess the answer is that it's possible that we'd miss such a
> > regression in all of those above places, but to me it seems extremely
> > unlikely that we'd let such a regression through without noticing.
>
> Literally 500? Probably not, that was hyperbole to make a point, but
> several, low tens? Yeah, I know of at least a couple in-tree off the top
> of my head.

Still, I find it suspect to assume that a developer working in this area
wouldn't notice even a minor regression (say, adding an additional
warning).

Thanks,
Taylor
