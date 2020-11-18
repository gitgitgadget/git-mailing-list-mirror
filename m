Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0632C56202
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 06:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 761302468F
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 06:22:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vVa8H/8/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgKRGWX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Nov 2020 01:22:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbgKRGWW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Nov 2020 01:22:22 -0500
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64CB8C0613D4
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 22:22:22 -0800 (PST)
Received: by mail-vs1-xe42.google.com with SMTP id f7so376078vsh.10
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 22:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=plJ4pHbnHTGofhlgcCvOQTBbA7gYJAFM30G6s4zOj8o=;
        b=vVa8H/8/lp4py/mKa4WmONfIHfShLKudPtHFLoFjVFQvC4EymI21Ync0tRE3o1DN8X
         kZvtwR6vDAY9YACiZEpkcmSb0C+jR2jqiCULRswu6fUBhNVVpiH/NK4D715pUsCKDt83
         JH9kUxuY3xeLN3u39uFFzemNDCZboIiTmLv5WqBal7cE3N7EaD1Vk1G642j9O7lAL547
         CLJU99iGBXwS/m13+vRMng4vq0Awi9jmbiLKOt/eq9LJOQfy8BRbEpByA4L/MV4Gva1J
         NmR7fdGAU1Nq3bLRFhgQUpbf8d63eyBquvJ3RNN/xc3QpgMroN5SOqHDQWExYNkzF57x
         /vWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=plJ4pHbnHTGofhlgcCvOQTBbA7gYJAFM30G6s4zOj8o=;
        b=b4zcXqi3tqL9uh75Sec0bb3j6nitYwdEP/kDI2CZf7iZoMXdsum+CENOoXXU9OMGih
         /LQos84T0pvMfAo44mOjrFtLkDcGS/ijz73B+2mTyugasTPAT8gJ/6zMmtNFoCbAdLUd
         k6OyW7T7Bnkh2Y+z+BOaVC/Qbj5QopoQmm/JHCU0N1WskhJs+5erQJkBaRG60/XoMlpU
         cQbK+emp6D5L/cSzN4WA6ji9r1DlDLBL0bd8aroDGotliS7LZGGrUgo07rz+WER/zcAD
         3RSExvoiOglaoQ0x4lBxOK+RrCMx0tjF3r3ilu7OAmxPAXrdP8qTxcvvL38VLguQuPxI
         MG2w==
X-Gm-Message-State: AOAM5325En9cELHb63uJitcIr9u8viEj5fs6TLiXLjfX36lTS5OnjvVL
        M0ISTdQhYU6+VmcOmVWgQ7n8uiKoUr5pR/FNCPuOZigVRoyXVA==
X-Google-Smtp-Source: ABdhPJw8U8szJbjWx9qctvzGUMQI64hIEZWSRRe12hDEJBi6Ikm5oG06cSmEUUl1nIqqtOLyRiQb98v3sA1aJ0yzSoQ=
X-Received: by 2002:a05:6102:22fb:: with SMTP id b27mr2197362vsh.49.1605680541612;
 Tue, 17 Nov 2020 22:22:21 -0800 (PST)
MIME-Version: 1.0
References: <20201114084327.14891-1-martin.agren@gmail.com>
 <20201117021318.GA30463@coredump.intra.peff.net> <CAN0heSoGnAKjTz2tiHpe2==Y-w7M03eiEpW2hU67FRbv=G+H8w@mail.gmail.com>
 <20201117225401.GA642410@coredump.intra.peff.net>
In-Reply-To: <20201117225401.GA642410@coredump.intra.peff.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Wed, 18 Nov 2020 07:22:08 +0100
Message-ID: <CAN0heSoyQY9H7FtK29KwXj+OkuFPfJSHw388P4Js1NTib=w-8Q@mail.gmail.com>
Subject: Re: [PATCH] list-objects-filter-options: fix function name in BUG
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 17 Nov 2020 at 23:54, Jeff King <peff@peff.net> wrote:
>
> I actually wonder if it is time to drop HAVE_VARIADIC_MACROS completely.
> They are in C99, and we have been introducing many other C99-isms. It
> would be a minor cleanup to a few bits of code, which perhaps isn't
> worth the risk. But I also have a vague memory of not being able to
> implement some interfaces because we couldn't count on them.
>
> Poking around, 3689539127 (add helpers for allocating flex-array
> structs, 2016-02-22) points out one such case. I think discussion of
> BUG_ON() got blocked by that, too. Looks like we also discussed them in
> the big "C99 weather balloon" thread:
>
>   https://lore.kernel.org/git/20170710070342.txmlwwq6gvjkwtw7@sigill.intra.peff.net/

Ok, that all makes sense.

> Maybe it's time for something like this as a test:

I had a vague memory that for some weather balloons, we would add a
comment like "please let us know if you trip on this; for your own sake,
don't just patch it locally." But maybe that was just for, e.g.,
01d3a526ad ("t0000: check whether the shell supports the "local"
keyword", 2017-10-26), where we add a test, and a single failing test
might otherwise be easy to ignore.

Which is different to what would happen if every file including
git-compat-util.h and/or each invocation of BUG() would make the
compiler complain.

All in all, this diff makes sense.

Martin
