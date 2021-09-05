Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75EA5C433F5
	for <git@archiver.kernel.org>; Sun,  5 Sep 2021 08:20:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F53F60F51
	for <git@archiver.kernel.org>; Sun,  5 Sep 2021 08:20:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235061AbhIEIVJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Sep 2021 04:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbhIEIVI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Sep 2021 04:21:08 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70CC1C061575
        for <git@vger.kernel.org>; Sun,  5 Sep 2021 01:20:05 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id f6so4570854iox.0
        for <git@vger.kernel.org>; Sun, 05 Sep 2021 01:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gyHmwXpkxgPR8Y1S39b1bQM3xSHHOuueRq0JCzQoZ04=;
        b=L50XaskuPsTRdHiJ3qOoVKv6m8+iwJpY2uheasOHxH1+aLzo1JMXx0OLWPPg94d/YX
         1fEonVAESRce9i8eg91nqU74BDsP1C7Gyaw/iawjpkFcKirL5gC+HG7Ns86aqXmHkrJv
         QP9c4O2vygCAfl5sbnI+OT4LN2fH7IGrUofy/2XFkJ3N/BhoTes3hVU26i0d0SsXIFOB
         Nt3JVqMTmhbNuMREjAA7PLVHRGR+qZiGiI3E8SELUXLsFQdkZ85gQN5ro7ujO8fQEBLz
         FfplA5QlGKcB62hjbJoLhpDaysRRpHm3i+A2qq5eGIb/9jo1iHhhj/LE5h/5ED/bUSKo
         hQuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gyHmwXpkxgPR8Y1S39b1bQM3xSHHOuueRq0JCzQoZ04=;
        b=tbXNX9JbyJxR8quP5rIUIfVKK/p8jKLYV4RwrTkCM2CMPYRiQXGgtd7G/UH4QLeWWY
         7AvfQEbEVhZaRWpgNdGsEReNLU3YHgm+fgbNGehlihQbKhnJJ1hpkIB3wy9/kqEXKpWI
         zhsOhJaVi1J28S/8oNrG4emhVCdG/Pp9QlzKAz0WIuP1beilm9zDXz+BJEFL40OjGvBH
         pkKS6wmydrTHn/JqvD2rkIVrPNAPSBYGPWXl8lgGwDa0z8u4p4LMUwJDRqnskqrsvobW
         1oVrMov/i+ZwLGMvqGpYOPFuThumAKJ4Q8lbPsFCd+0UbhIQ9UWh8htgovtQMTmXCRHI
         NCQg==
X-Gm-Message-State: AOAM530LvPAOGD4kfGgUFtOz7vE4VJ1Y/6D35bpOcXLfJnBNVI88AcuD
        R1hkITqoPiFpiPbQiLS2AIe8JdI5YNeQxJA49MOV2tQdkB3ys3F7
X-Google-Smtp-Source: ABdhPJw/WkGEM5EppywdlMvA+gwk0dlotRV4ksw6RuMNazovqEUTc9Afk02CBEh5Y6k3WhR0WiVfQPCnF7C4xhI16/A=
X-Received: by 2002:a05:6638:2641:: with SMTP id n1mr5954497jat.117.1630830004836;
 Sun, 05 Sep 2021 01:20:04 -0700 (PDT)
MIME-Version: 1.0
References: <YTNpQ7Od1U/5i0R7@coredump.intra.peff.net>
In-Reply-To: <YTNpQ7Od1U/5i0R7@coredump.intra.peff.net>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sun, 5 Sep 2021 16:19:53 +0800
Message-ID: <CAOLTT8RzHb5zWUm1psZRTP=iST-jP4DBmG2Zh1UPdo6z+QyHcg@mail.gmail.com>
Subject: Re: [hacky PATCH 0/2] speeding up trivial for-each-ref invocations
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> =E4=BA=8E2021=E5=B9=B49=E6=9C=884=E6=97=A5=E5=91=
=A8=E5=85=AD =E4=B8=8B=E5=8D=888:40=E5=86=99=E9=81=93=EF=BC=9A
>
> Somebody complained to me off-list recently that for-each-ref was slow
> when doing a trivial listing (like refname + objectname) of a large
> number of refs, even though you could get mostly the same output by
> just dumping the packed-refs file.
>
> So I was nerd-sniped into making this horrible series, which does speed
> up some cases. It was a combination of "how fast can we easily get it",
> plus I was curious _which_ parts of for-each-ref were actually slow.
>
> In this version there are 2 patches, tested against 'git for-each-ref
> --format=3D"%(objectname) %(refname)"' on a fully packed repo with 500k
> refs:
>

Regarding this 500k refs, is there any way I can reproduce it?

>   - directly outputting items rather than building up a ref_array yields
>     about a 1.5x speedup
>
>   - avoiding the whole atom-formatting system yields a 2.5x speedup on
>     top of that
>
> I had originally written it against a slightly older version of Git,
> before show_ref_array_item() was inlined. In that version, there was a
> middle ground where we still created a ref_array_item for each ref, and
> then fed it to the "quick" formatter (so we could see the cost of
> having to malloc/free a bunch of ref_array_item structs). The numbers
> there wre:
>
>   - streaming out items gave a 1.5x speedup
>
>   - using the "quick" formatter gave a 1.8x speedup
>
>   - avoiding the extra malloc/free for each item gave a 1.4x
>
> which makes sense; 1.8 * 1.4 is ~2.5, so it's the same speedup just
> broken down further.
>
> I'm not sure I'm really advocating that we should do something like
> this, though it is tempting because it does make some common queries
> much faster. But I wanted to share it here to give some insight on where
> the time may be going in ref-filter / for-each-ref.
>

Well, this acceleration looks gratifying. But so far I haven't seen
its effect on
git cat-file --batch | --batch-check.


>   [1/2]: ref-filter: hacky "streaming" mode
>   [2/2]: ref-filter: implement "quick" formats
>
>  builtin/for-each-ref.c |   7 +++
>  ref-filter.c           | 113 +++++++++++++++++++++++++++++++++++++----
>  ref-filter.h           |  21 ++++++++
>  3 files changed, 132 insertions(+), 9 deletions(-)
>
> -Peff
