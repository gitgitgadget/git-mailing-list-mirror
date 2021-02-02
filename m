Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1872C433DB
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 14:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FBAD64EC5
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 14:31:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234353AbhBBOao (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 09:30:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234455AbhBBO3F (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 09:29:05 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52AB9C061573
        for <git@vger.kernel.org>; Tue,  2 Feb 2021 06:28:24 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id u4so22656612ljh.6
        for <git@vger.kernel.org>; Tue, 02 Feb 2021 06:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RTxC28/CR7s5avCb/S7yckUjaO5Q8bWaGcTWzjflVQA=;
        b=BqWJNNXmeB/KuVphGTrfCFoY3oFco1yklbHLPvhhtBaJDlVIT8tX2YVWoAXqGZbbFq
         +YOfTSFkvr6IuCNlMd84ktREwCEcnOVQig2dttFDMF+oVC7vekK//0KyN59RXRKKrHJW
         FzzoqkHCSCNvyPNwGo4LYdOSBVvGnX/DAUKEKtGA29CIbgyR3TonQ28LFo8fabDXVzOo
         HbCRGgGN0klis2HvAeLVvdh84UOUVeMxfzJjvWXXmeW/r/kSKrw4mDPPA0GSF4fbNeMr
         HFDQWum2l7ut2PWpkfketHoJCY1niAr/p75h86oF5sC09rpy9xpulA0TFHhOMYRIvhpF
         pC4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RTxC28/CR7s5avCb/S7yckUjaO5Q8bWaGcTWzjflVQA=;
        b=lSw5r/5E0LF1eZg6z95hoOxZojyq151tB0l0bUIso5FNoSHSBbGJCQtnlf2JD2WZ8e
         DyMGSJFG20DS/6Ety36xvg6SvK4j5aaOwALOqqDRc+dNz3vN4IZUwSy8h/0Ra+bVkfLn
         Dyi2Eb1eSiizAgWh1mcsbsWtkt7ka9QZxiFMLfpxRGSeDBfnCtYHUDjuHARybz06vjPr
         TJyAaSi3AZxIXoW8q4jACamNL57bj+46smfIst2dZ3NhFivRKZY/hYG++bIpAeZxVFps
         IoYwZxFXIDWs9peD77YGANz+NPJcGYvfOaI5xi9Og6dmKrmypnikDjF5BzLeVS3Epyod
         0pcA==
X-Gm-Message-State: AOAM533fdjBVuhBbYW1wNzAb2a1wcvW313eBAY5xEvnGarBcmh/IgY2w
        5wGdSkLzvzTWmqMXLvT0++nr4yq2GxDxqQYAyW57bQ==
X-Google-Smtp-Source: ABdhPJzEIjc3qWa+GFAZmH2BPLzO1oKtL9przJE9ecicncCLOGJkq/tSe8+FFWrwRKsE2CZxJ6EdwzWwOgXhed8bes4=
X-Received: by 2002:a2e:b522:: with SMTP id z2mr12550841ljm.137.1612276101873;
 Tue, 02 Feb 2021 06:28:21 -0800 (PST)
MIME-Version: 1.0
References: <CAGP6POK1s5fdzY74HyE9=0CV_B+HpbM9gU2qKuYtQAaPuc7XgQ@mail.gmail.com>
 <CAPc5daUtOMQB9YqOTQL4mrHpfyATe=FM01cW9Ngd1iy8aWwMmg@mail.gmail.com> <CAGP6POJeg4EB1Lx8NN0+PP-nxystKtLT_FH2UdQhoF13TjWvXg@mail.gmail.com>
In-Reply-To: <CAGP6POJeg4EB1Lx8NN0+PP-nxystKtLT_FH2UdQhoF13TjWvXg@mail.gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Tue, 2 Feb 2021 11:28:10 -0300
Message-ID: <CAHd-oW5KmK1JgaMmDBWA87oxG=U7MdA3GBpzA9P5NYbBOfZqCA@mail.gmail.com>
Subject: Re: Only receive the topics I participated in or initiated on this
 mailing list.
To:     Hongyi Zhao <hongyi.zhao@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 2, 2021 at 6:02 AM Hongyi Zhao <hongyi.zhao@gmail.com> wrote:
>
> On Tue, Feb 2, 2021 at 1:41 PM Junio C Hamano <gitster@pobox.com> wrote:
> >
> > You can,  on _your_ end, filter incoming messages that are sent via
> > vger.kernel.org and do not have your address on To or Cc.
>
> Thank you very much for your comment. It seems that the following
> Gmail filter will do the trick:
>
> From: *@vger.kernel.org
> To or Cc: -hongyi.zhao@gmail.com
>
> But I can't find the Cc field on the filter panel.

Maybe you can use the "Doesn't have" filter field. (It doesn't have
the same meaning, but perhaps it is close enough for your needs.) I
have this set on my Gmail account:
https://matheustavares.gitlab.io/posts/first-steps-contributing-to-git#filters
