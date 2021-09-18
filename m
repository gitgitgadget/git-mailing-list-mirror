Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C1EC433F5
	for <git@archiver.kernel.org>; Sat, 18 Sep 2021 07:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 428ED610E9
	for <git@archiver.kernel.org>; Sat, 18 Sep 2021 07:49:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243263AbhIRHvL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Sep 2021 03:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236714AbhIRHvI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Sep 2021 03:51:08 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72363C061574
        for <git@vger.kernel.org>; Sat, 18 Sep 2021 00:49:45 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id z94so38589731ede.8
        for <git@vger.kernel.org>; Sat, 18 Sep 2021 00:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=t+4pdkk2aPgDJmnb3cicrI0jenOqCsgKjMkAW7u/LJA=;
        b=elSd6R7H7vuL8QijlYMzg5+ox3sl50CXUz+45U+gg76WOXWQKahSFn3igrUBaxvMUZ
         WFyyoWe5/2UdtQ4Zw3Mw5xoyo6xz7RFm+H6l8/rlZ9MheteRnrlSzzw/urppCw+zwzEt
         DiY87qsuLQGktJOaBNpXY/LiyuUi31c1scpw8sKQnuP6mC6c5zUCGVq2YYH6XghnI/wJ
         jG6fBz6M55ugtdY5XB/ks/hiGnc9gUQCp6L0PUeWKS9ZiamQd6YNN3qotvQnQALxcqKH
         AH9et5ATtkSKm8EYbf9s5LVLqVusUCzsqdbqu37hDnmd9G+R0YBUvL2gYsTWNeKn/J8H
         fH5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=t+4pdkk2aPgDJmnb3cicrI0jenOqCsgKjMkAW7u/LJA=;
        b=NX/yRBUU5hnFOeO9vN6AibhthesE651bFzWtOzaMTyo/ltgHo67zN3vTc+4PtjsCJc
         xSjISk3CXFpX5bkumfmScoJN5DK6YjGi06eVmGpZX19bOUUFZO57u7qeb3T2Rc47P+mQ
         d4vAojxUip6utL14Di4oPLhYtMbTodHdsWs92mnjTaDd/dc4+5JSN4Zlt4FqnCDlaHJH
         wnHwByb+oNX1owixcgjQtbB20pwO6GrQVcvYnMHY/BMJ+lP4OU4BuThsCi+GaVgEeYeG
         uGsvx/X23LfI2Qik5JRwNiicPTGd3dGBsn638T+zrk9/fiuunVvGRBv3wqD8qxyYG9bR
         epKA==
X-Gm-Message-State: AOAM533NN2NTsOXxVY3zwUqn2/hY3fPZi/uYS7WcvcpG6Yq/WrhjBeQ5
        Qyn1/JrR+DQ9eVDp1DiTxTBlKcyQm0c=
X-Google-Smtp-Source: ABdhPJyzuviGVZjA8ijR7f2fJahjhlmnYR2tSOEP6mPdIzTm2PBM/0ZWTU+MQI++YQUyfZ+6wk2Diw==
X-Received: by 2002:a17:906:7a09:: with SMTP id d9mr16787568ejo.116.1631951383032;
        Sat, 18 Sep 2021 00:49:43 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id w13sm4076393ede.24.2021.09.18.00.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Sep 2021 00:49:42 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Carlo Arenas <carenas@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, felipe.contreras@gmail.com,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <git@jeffhostetler.com>
Subject: Re: [PATCH v3] make: add INSTALL_STRIP option variable
Date:   Sat, 18 Sep 2021 09:46:44 +0200
References: <20210902121104.14778-1-bagasdotme@gmail.com>
 <87a6kchlqc.fsf@evledraar.gmail.com>
 <e5e9848b-4378-8478-6ade-8e5f97295181@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <e5e9848b-4378-8478-6ade-8e5f97295181@gmail.com>
Message-ID: <87mtoacoh6.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Sep 16 2021, Bagas Sanjaya wrote:

> On 16/09/21 16.50, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> ...this really is not an INSTALL_STRIP but (using some combination of
>> your own naming) a "INSTALL_XPROGRAMS_OPTS" or "INSTALL_XOPTS". I.e. you
>> can supply arbitrary options to "install" with this, but only for
>> binaries.
>>=20
>
> I think it should have been "INSTALL_STRIP_OPTS". This could haven't
> been issue if we add global (applicable tobinaries and scripts)=20
> "INSTALL_OPTS".

Isn't the reason to have that split-up because it would break if you try
to strip(1) a Perl or shellscript?

>> Also doesn't this misbehave under MSVC when combined with *.pdb files?
>> See dce7d295514 (msvc: support building Git using MS Visual C++,
>> 2019-06-25) and a8b5355d808 (msvc: copy the correct `.pdb` files in the
>> Makefile target `install`, 2020-09-21) , i.e. the code at the start of
>> your diff context.
>> Does stripping the main binary while having a *.pdb file error or
>> MSCV,
>> or make the *.pdb file useless, or is *.pdb an unconditional equivalent
>> of INSTALL_STRIP=3D-s on MSCV that we should disable if this
>> hopefully-then-boolean INSTALL_STRIP option is enabled?
>>=20
>
> I'm not familiar with MSVC, so I can't tell further except you can
> pass null ("") to INSTALL_STRIP.

Yes, to be clear I'm not asking for practical assistance in building git
with MSVC.

I'm pointing out that it seems that the option you added introduces an
edge case in how we combine with an existing option/ifdef that may not
be desirable, and that you might be interested in looking at
it/submitting a follow-up patch if it does turn out that the interaction
is undesirable.
