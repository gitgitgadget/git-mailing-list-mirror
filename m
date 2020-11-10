Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49914C388F7
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 16:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1BFD205CB
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 16:44:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C9/d0qWB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728999AbgKJQof (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Nov 2020 11:44:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbgKJQof (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Nov 2020 11:44:35 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C3DC0613CF
        for <git@vger.kernel.org>; Tue, 10 Nov 2020 08:44:34 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id b17so2834560ljf.12
        for <git@vger.kernel.org>; Tue, 10 Nov 2020 08:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r/GEe/T3xd0oQQfHyojNE9lPUIDNMVjmn8Izx14cZW0=;
        b=C9/d0qWBBlj0BpYKiWnXN3qCKAIJWaUsQTj9Z4lM3wHvZYwdCnu74FeW7jAuaBWiSb
         /2qpaLR+Ott50VB4Pfd+YTxa2YZgpT7VMZif5nSjtyu/mPM9EEhjhzUv2uL1kYoZcsfg
         bxik3Bu9cerQJyZc/RetUQaXjm9IqI9hdQRQVjKumLLEHSYNPucwZNnSQoJcgHBLB+xA
         CEBU5ekGi4cfNR7qTZSK/OOUVUzcCaNcbvgOalaxZgedyGzhDYwgm0VRV5JDOL3lmMQa
         SNtu5g8PXkzDj5HXdqRJLAa+7di1j5J/HdiZLkZIJFC81ZaqtZ7ZrHOgI/Yb6fZhfNt5
         F6Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r/GEe/T3xd0oQQfHyojNE9lPUIDNMVjmn8Izx14cZW0=;
        b=DLWeQosEE2opEldFQW3D/LoGqYkY/8fovQi5dwA+kWgOqxJDJCD6GlOTsvz06PP9wq
         Pvrs//BpLB7Fb72lsS/3wNJxGGNfEaVQr08+ylHq+pCErnYQFJzMzJEGRJExxWONMT6s
         0fzW9IuwDHf2hDltd4jZSmT+0f5qVh8Hxfv1FDZhKT+Jfykscgg+UTg49Y2q63LaVwgp
         NFzozmsG19sI43cTnQu/21zL7/g6C5YQIVTcglW8GjJTsSPzio6e+IgJCqP8OtgOKItI
         dt8P8VX7mmmRQ1t+MZ1jJtJrrhc91RsuJ1CWZT++QBLmP7zI7AJU+HYjWDr4FI7Ov+L2
         pZlg==
X-Gm-Message-State: AOAM533EJqfBXHoAmif2OP5sluYSf9LD8fBEDwoD7KDakk9n8SzDNkI8
        trWQXnnBSWjkk832Dxjg9eteafaoCkhWOR1GTzA=
X-Google-Smtp-Source: ABdhPJwwxPom0Et91w8cm7LEVyq23333GAh4w7a0MO2LuM4/5qj77oWozhKqXJxlytsAyFm7AdToyB/HhsdExUf1+CA=
X-Received: by 2002:a2e:584e:: with SMTP id x14mr8000198ljd.335.1605026673260;
 Tue, 10 Nov 2020 08:44:33 -0800 (PST)
MIME-Version: 1.0
References: <20201107221916.1428757-1-dgurney99@gmail.com> <20201107224747.GF6252@camp.crustytoothpaste.net>
 <nycvar.QRO.7.76.6.2011101418550.18437@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2011101418550.18437@tvgsbejvaqbjf.bet>
From:   Sebastian Schuberth <sschuberth@gmail.com>
Date:   Tue, 10 Nov 2020 17:44:21 +0100
Message-ID: <CAHGBnuM3JeffB73coQhVOC03tiWhg2VY=teSr-Jmnx5-aX48BA@mail.gmail.com>
Subject: Re: [PATCH] compat/bswap.h: detect ARM64 when using MSVC
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Daniel Gurney <dgurney99@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 10, 2020 at 2:58 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:

> > -#elif defined(_MSC_VER) && (defined(_M_IX86) || defined(_M_X64))
> > +#elif defined(_MSC_VER) && (defined(_M_IX86) || defined(_M_X64) || defined(_M_ARM64))

> I Cc:ed Sebastian, to confirm my hunch: Looking a bit above that hunk, I
> see that this merely imitates the way things are done for GCC:
>
>     #if defined(__GNUC__) && (defined(__i386__) || defined(__x86_64__))

I believe my intention was not necessarily to imitate the way things
are done for GCC, but to independently be on the safe side by checking
that this code is only used on x86-style / little-endian architecture.

> > As far as I know, Windows has always run on little-endian hardware.
>
> I think that depends on your point of view... IIRC an early version of
> Windows NT (or was it still VMS Plus?) ran on DEC Alpha, which I seem to
> _vaguely_ remember was big-endian.

IMO, strictly speaking, from a semantic point of view this is not
about which OS we are running on, but about which compiler is being
used. So the question here is: Can MSVC compile for a non-little
endian target platform (incl. things like cross-compilation)? And
AFAIK the answer is yes, it could in the past / still can nowadays.

> Short version: while I managed to convince myself that _currently_ there
> are no big-endian platforms that we can support via MSVC, I would like to
> stay within the boundaries of caution and _not_ drop those `defined(_M_*)`
> parts.

Same here, I'd prefer to keep these for explicitness, and for
consistency with the GCC check.

-- 
Sebastian Schuberth
