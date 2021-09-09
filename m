Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FD73C433F5
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 10:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FD0B61179
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 10:36:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234061AbhIIKhU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 06:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbhIIKhU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 06:37:20 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2984C061575
        for <git@vger.kernel.org>; Thu,  9 Sep 2021 03:36:10 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id t19so2603282ejr.8
        for <git@vger.kernel.org>; Thu, 09 Sep 2021 03:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=OeMDTc7CV5xW/iS4tf1PHr6wjDZbCAP10ULSCmh9weI=;
        b=iWAS7TDKy4RWg17A1V9qQHXeaBRkYuPL8Ti0OKO6S98OhfkPJ2vaU5VfRu2KAgPAso
         YbtMn1fasWRkDA78UBenOY3hAfoyMmb/jsAqBoHaGf4Rc8EGy/cKFpx0inJsjPASL8jY
         /OMZ5e4HS3qV64OZacapI5IjxuU3JrkRG8wcdAK9QdOS2ZBqytrwZz89+zfhzvwHHPKt
         37jMWo5svY5QyXrm9F7klLxZ49tWTMeedVtMlV2YhPilaVWBhoLn7oUSspM7DKlkq7OS
         yOmNeju5cJuMYMBEegc1G50VKbcDW2g0OmXI/Bkc4U7B9BRLe7xodVkIeWCKLZtVlj1t
         h/mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=OeMDTc7CV5xW/iS4tf1PHr6wjDZbCAP10ULSCmh9weI=;
        b=VLUj0t45F9N2rHMGNCic9H+LwVYOYFo5+I72fGy9f6GECQhGVjemm1Y7i4aLhBKVqj
         ++GEceWhwem3+KO/nDfIJx1petL2zN2Zqp0wGQ+IgJXRw05cX9XZabjFGSoofgt5zb7a
         3a68OfHHUAWKm7wexZn64KFritvqs3lsC/iYIfeulW0+DP2C7gKFXF89AACSrySRcE91
         YxMXmiaGu2+fEwP93zkF2gyAjgNRcjua0/IJAedGK4uMpzSAzHKLr30vhpawt2Y3BKix
         VfTqqC/Oki2R+sscyO28T3kUmGVzoNnorWxflqdeTvigu9UieDpyyx9yxLKoTCu8lWSD
         oIVA==
X-Gm-Message-State: AOAM5325Au0/aAR6m+I9flRWcs18zZW0DIpvdpS72zDAr1udA2VoZsBH
        BWXuCpkKR4UT9nljfDpmpZQ=
X-Google-Smtp-Source: ABdhPJyNxPOpcEJ+JB3zY4OtxVtdRUXWx8ri/+zWKJA9iH69nMPaaVl+z2FWR89W4u7Jrjr1kbEhyg==
X-Received: by 2002:a17:906:56cc:: with SMTP id an12mr2652377ejc.456.1631183769394;
        Thu, 09 Sep 2021 03:36:09 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id m13sm834770edp.53.2021.09.09.03.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 03:36:08 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 08/15] scalar: implement the `clone` subcommand
Date:   Thu, 09 Sep 2021 12:29:44 +0200
References: <pull.1005.git.1630359290.gitgitgadget@gmail.com>
 <2cbf0b611133df5fa7eed1bf38460f9d119d2a6e.1630359290.git.gitgitgadget@gmail.com>
 <xmqqsfyoqm6e.fsf@gitster.g>
 <nycvar.QRO.7.76.6.2109031709190.55@tvgsbejvaqbjf.bet>
 <xmqqwnnxftzn.fsf@gitster.g>
 <nycvar.QRO.7.76.6.2109082049290.55@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <nycvar.QRO.7.76.6.2109082049290.55@tvgsbejvaqbjf.bet>
Message-ID: <87mtomdoiv.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Sep 08 2021, Johannes Schindelin wrote:

> [...]
> Which means that I want to weigh how much effort to put into polishing an
> unlikely code path on one side, and on the other side how much effort to
> put into moving the functionality away from `contrib/` and deleting that
> unlikely code path.
>
> In the same vein, while this patch series contains (mostly) code in
> `contrib/` (and therefore technically does not need to adhere strictly to
> Git's code style), it is probably wise to pay closer attention to the code
> style particularly in those parts that are prone to be moved verbatim (or
> close to verbatim) to Git proper.

I don't think we have any such exception to our usual style & preferred
code patterns in contrib/* or compat/* in general. In the latter case we
have e.g. compat/regex/ and other externally-imported codebases, which
we've tried to stylistically modify as little as possible to make
subsequent imports easier, ditto sha1dc/ etc.

I think the general (but unwritten) rule has been to draw the
distinction on whether or not code is still externally maintained and
expected to be imported, or if it's expected to be maintained in git.git
going forward.

I think that this proposed series falls thoroughly in the latter
category, but maybe I've misunderstood it..

Also re my [1] I had some (still relevant, but unaddressed) points on v1
about how placing this in contrib/* made certain aspects of integrating
it into our build system harder. I was imagining that distinction as
purely an internal implementation detail to git.git (make install
etc. would behave the same), but per the above it seems to come with
deeper connotations than that at least in your mind.

1. https://lore.kernel.org/git/87r1dydp4m.fsf@evledraar.gmail.com

