Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C594AC48BDF
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 12:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2A3B61462
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 12:30:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbhFOMc6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 08:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbhFOMc5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 08:32:57 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1379C061574
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 05:30:52 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id h5so6509358iok.5
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 05:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=L/zgIZuFYQpC/fhlR64MMV3sn41JpKTXaF0F8oHKTng=;
        b=W2pPmgMc1VQmGnwZr3INPEq6PNbbfbhUEhy4ifVKH5Za29nWb4yK3SEOtBYkkJVF9j
         oQ5X3mpOeKNRozLfNEUdI5XY7ASDt4rBbR41YJ3W+6NzR/iAHqwRGUhS4mLXoc4tNY8d
         8z8v1WAQOs/KVkr0bmurIFgioZ0aGBGkyNfYCXR2PZG9b9/TfZNjCwn7tMkyHJ26szek
         9wJ9YNGObZMPZXoJQIlUQ/YXrGnXrBRK83uHd+F7oxTCyt7kqX6r6M97zyNUiWqGTEYw
         2CJj6ZNUFwYhYCd12B2gwjLxlKNKpCJctTzS9kruh8Wazhv3XXaOw6/DpmOXfrR+dlg3
         ANWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=L/zgIZuFYQpC/fhlR64MMV3sn41JpKTXaF0F8oHKTng=;
        b=b/HYug5grYCdWlP6+o0GtLEUDLLPTQjL7+sDmtDEhXWMRrqRtSAEVjUSj6/i4IuFda
         XoBnWb3aLDISGlPuirbZLFf5qgz85lhKgklvv0z0if5hGV6LrkKL0DZgIzcS+F7EwuUm
         /DxSIBlsRL2mXY7gQSUwHw+7ZxiFSutSZT4e1iLuXY4q8r9dylvU6l/ZCw4apwJJGzD5
         2DxuYjL1SFWadcKDPNq/xibXPiw+7sZ4pKUnzNG68VFe2t1iMST3SEQhfenymcdMnkba
         znlVayPty2/MMaHO8D+NxHEiQKUEZuFaQeMvpeSI3kLxC1xlqCnlChi41p/mrB/nkwg8
         UsIA==
X-Gm-Message-State: AOAM5304s/N2RLqZ9IZFnVWixmk8BKZeqzJXp9hIK4dqfCe/TsaR0ynK
        BP07svcgKVX9Cp1yZOim0/1/4pK8Jrka9PonnpE=
X-Google-Smtp-Source: ABdhPJyJEX2FWdHS16uCu8cwEySTFcvvAfikBRQHPxrURiPtSs/Ih0DBjLVizAuFjvOahEPfXO6IjeRkMC1f8+2NAiQ=
X-Received: by 2002:a02:647:: with SMTP id 68mr21247780jav.29.1623760252133;
 Tue, 15 Jun 2021 05:30:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLTT8QHL-6-DxoRKtx5cVp_DePxtWYU4CuBweYfCG1hGZZhaA@mail.gmail.com>
 <CAP8UFD0jiZuPvO-oYXw9PmVQ56tpYc9nxUxAjPQrc2f1qwEqUQ@mail.gmail.com> <CAOLTT8QS7bG5M2Ro+vApUDtOgjxgrpUg5Mgp+tOQgyqwpENN1Q@mail.gmail.com>
In-Reply-To: <CAOLTT8QS7bG5M2Ro+vApUDtOgjxgrpUg5Mgp+tOQgyqwpENN1Q@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Tue, 15 Jun 2021 20:30:41 +0800
Message-ID: <CAOLTT8Sph8MbzH_LR_QV77TAAYP3fbxLsSp_fLvHknJ3f73xrQ@mail.gmail.com>
Subject: Re: [GSoC] Git Blog 4
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Hariom verma <hariom18599@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ZheNing Hu <adlternative@gmail.com> =E4=BA=8E2021=E5=B9=B46=E6=9C=8815=E6=
=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=884:59=E5=86=99=E9=81=93=EF=BC=9A
>
> >
> > In the cover letter of your patch series you say:
> >
> > "There is still an unresolved issue: performance overhead is very large=
, so
> > that when we use:
> >
> > git cat-file --batch --batch-all-objects >/dev/null
> >
> > on git.git, it may fail."
> >
> > Is this the same issue? Is it only a memory issue, or is your patch
> > series also making things slower?
> >
>
> Yes, they are talking about the same thing, the memory usage is too large=
.
> Of course I should check for memory leaks first. However, this is mainly
> caused by changes in the strategy of cat-file printing object data.
>

In fact, it is indeed a problem caused by a memory leak: batch_object_write=
()
forget to free the ref_array_item->value. After solving the problem, althou=
gh
the performance of `git cat-file --batch-all-objects --batch` is still poor=
, at
least there will be no triggering the oom killer.

--
ZheNing Hu
