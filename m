Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75A36C433EF
	for <git@archiver.kernel.org>; Thu,  9 Jun 2022 07:33:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238680AbiFIHdT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jun 2022 03:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbiFIHdR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jun 2022 03:33:17 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B402F1A07A
        for <git@vger.kernel.org>; Thu,  9 Jun 2022 00:33:15 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id o7so12441894eja.1
        for <git@vger.kernel.org>; Thu, 09 Jun 2022 00:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=bz2Jv7m0SEUEmxQZYPOTBHmJf4uj9r07kICk1Fn201s=;
        b=FD1PM6VOQmMrEjY4CAw4EaeZP4uTz6EoCktO0OEWesy/m7sh2tzYlQ1kLKyS+HeIu+
         1Y98IMlG2rxJr9DSs24oRTeCND+6EP0VfcH1dR4+Apcdl114F4t0/kIZYAQQI8YY/hyz
         DilLC8QrlCu3S0Uv9YXXgV8SpByj/qTbf66YCORK7wjcW3GPzga7uaqymj/ZTKfdlWKr
         UIuhzP6kJyHL9MPlT8MsAyO9stVGQp+XOodKTQyUcsdFfm/Sp71iZfu8eehCTMD2qNlg
         fq8VMiVrjacy/TjhUDi43uC9nUpzZOaO6ZX3Piy8v9NTi/4UZmG44Qp/IvUSw4fFiDai
         dsYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=bz2Jv7m0SEUEmxQZYPOTBHmJf4uj9r07kICk1Fn201s=;
        b=NSJdsc14KS+KM7D+73gg3/mfVuCmco7ejb+ScGeMqu4wrGqcV2I8c1ik7tS5y+/MyE
         LZTm0n9UgGrAhGNcYV+Ax+5hEcSH6D2f4lw9s+BbcDo2U/42f5eU8l+qob6r3VcMSfDh
         74o3EfbZpH3GMl8pOcaJB8j3JJZTIM9RWbAy4eM96V2MS8EkggH6PhcjusZBi7oAntRF
         5xkOnZ4wxVmrKHs9021IHb4SPOakTyCKUyAMN0VylKKReu6WD1dyttePewPsIXe5SpE4
         nYYwgzMhHQvUuGvMmVZpGTSolcosZetcAcpAyled3UGvO6nFZt4ykZrBPy6GXAgFSfHd
         oYPA==
X-Gm-Message-State: AOAM533A12h+l4jSFSePOtMLKt9QogHgGHtoWmiJ0DjyhFxqkK5bQtIJ
        4x/hvRTVgSyt4gMdXz929ko=
X-Google-Smtp-Source: ABdhPJxAu85g1M9P6wAxOF4LYB7dToOOlTWRzOnnOTzIvdlCBu3ijauobCN4SUlKKkJjwUxR+FLbFA==
X-Received: by 2002:a17:907:60d3:b0:711:cef0:f880 with SMTP id hv19-20020a17090760d300b00711cef0f880mr18606279ejc.499.1654759993979;
        Thu, 09 Jun 2022 00:33:13 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id 4-20020a170906310400b00705976bcd01sm10329388ejx.206.2022.06.09.00.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 00:33:13 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nzCfI-002kYC-8Z;
        Thu, 09 Jun 2022 09:33:12 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Li Linchao via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Cactusinhand <lilinchao@oschina.cn>
Subject: Re: [PATCH] remote-curl: send Accept-Language header to server
Date:   Thu, 09 Jun 2022 09:30:35 +0200
References: <pull.1251.git.1654678407365.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <pull.1251.git.1654678407365.gitgitgadget@gmail.com>
Message-ID: <220609.86leu6thon.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jun 08 2022, Li Linchao via GitGitGadget wrote:

> From: Cactusinhand <lilinchao@oschina.cn>
>
> Git server end's ability to accept Accept-Language header was introduced
> in f18604bbf2(http: add Accept-Language header if possible), but this is
> only used by very early phase of the transfer, that's HTTP GET request to
> discover references. For other phases, like POST request in the smart HTTP
> the server side don't know what language client speak.
>
> This patch teaches git client to learn end-user's preferred language and
> throw accept-language header to server side. Once server get this header
> it have ability to talk to end-user with language they understand, this
> would be very helpful for many non-English speakers.

I may be missing something, but this is just the "Accept-Language" part
of this change, i.e. there is no "round-tripping" here of actually doing
the work on the server of doing setlocale(), no?

I think the end-goal of having the "remote: " messages translated, if
possible, is very worthwhile, but I'd always imagined we'd do that with
a protocol extension, because even if we do this with HTTP headers we
won't get the same over ssh/git transports.

But then again we don't have protocol v2 push yet :(

So perfect certainly shouldn't be the enemy of the good here, I just
wonder what the end-goal is and if there's a plan to get there.
