Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F7B3C47083
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 09:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 168DC613B1
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 09:40:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232075AbhFBJly (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Jun 2021 05:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231998AbhFBJlx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jun 2021 05:41:53 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65481C061574
        for <git@vger.kernel.org>; Wed,  2 Jun 2021 02:40:10 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id l1so2889347ejb.6
        for <git@vger.kernel.org>; Wed, 02 Jun 2021 02:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=m2bVtiA6OHQR1PTco25x7OHin+AC9jrqUmjYYv937dU=;
        b=UaxDrRQVRevQIZqKpApqC26wbYBBKVqjv3Zb9M89o6VglYs78PPdBTXoU0RI9NiuGw
         VRji0QHAgg1qVW3HYlJVYQIvyD0/wEup3Bcyof0Ib7a2GRkV9UggoaLZR9XMxecECJrP
         YPALExVkSxERYppwUE+XBde6+FivLxC81vyXr2HDW8AUP/dte4sqwA2yMcDM7wSP07I6
         qUn/C4C1aw5qAtrL6xUjJvrlnHyyEmtxu2Hg1hpEQm1DktPrQIuJU8yXgn+/Lhs2Rrzx
         IrQd1mZMcmjPcPAOUpw3kaJejeqfSE4IwddgQzFFCYic3W+lo9Pt+/laMPUomLfkyRUH
         ZJ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=m2bVtiA6OHQR1PTco25x7OHin+AC9jrqUmjYYv937dU=;
        b=aOfQptOH7u5rsNis/v9o6PMk3DfbbUvhrX3fAoALKoMJZtiWetWiDIHf+4QG8ym/ho
         0PMO2nvpE/HaoL0tGM64ReFI8bqEZoavCs0ds7sQBW8eirSGNl7IOzZBEP607bfNeIU/
         9W2vzCCYfZPIxgFNDlH97+VSd6qdbpaPuGAbrCYDu/TJPYpgatnR5C9X5SvVXXQCKx4T
         64DArvAUvOBVpxY+5Mw8XxU5gY1dmae1ISbs3jGLVMJ2F5h2akIV09zZANzafpxpc+qg
         Tf0w/lLsk/IxiKthuatkgQLkosKMReY9qOb4XE52b4gZRUHhubdfvaPlYgX2jF0fjmPM
         XBAg==
X-Gm-Message-State: AOAM533Y7KNNvI99CdfikBlPZm8sd7dn4IVSBSdtxG3mmhhmWE+5p5dr
        suYDbp6IvWJdIcGRQQTuXFVlzP6GQsA=
X-Google-Smtp-Source: ABdhPJzQ54XwDI7LhwiK6Zzq0b0RTqr0t7isn2OKdJOToT4sNiRzKwUOBC2xmyYQumIKEAE9MXOj7A==
X-Received: by 2002:a17:906:2c52:: with SMTP id f18mr19562116ejh.258.1622626808541;
        Wed, 02 Jun 2021 02:40:08 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id x9sm8625143eje.64.2021.06.02.02.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 02:40:07 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 00/31] minimal restart of "config-based-hooks"
Date:   Wed, 02 Jun 2021 11:39:07 +0200
References: <87lf80l1m6.fsf@evledraar.gmail.com>
 <cover-00.31-00000000000-20210528T110515Z-avarab@gmail.com>
 <YLZ5H2Muh39Q4M5T@google.com> <87y2bs7gyc.fsf@evledraar.gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <87y2bs7gyc.fsf@evledraar.gmail.com>
Message-ID: <87v96w7gg9.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jun 02 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> [...]
> If anything I don't see how it doesn't make things much easier for you,
> if you do get around to replying to my outstanding feedback in [=C3=86.1]

Hopefully obvious from context, but I meant [=C3=86.2] here.

> [...]
> =C3=86.1. https://lore.kernel.org/git/60b71788c0e6d_67d0208d4@natae.notmu=
ch/
> =C3=86.2. https://lore.kernel.org/git/87mtv8fww3.fsf@evledraar.gmail.com/

i.e. this.

> =C3=86.3. https://lore.kernel.org/git/YJBdbi50Hz+ekOtt@google.com/
> =C3=86.4. https://lore.kernel.org/git/87pn04g0r1.fsf@evledraar.gmail.com/

