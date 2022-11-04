Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1A9BC433FE
	for <git@archiver.kernel.org>; Sat,  5 Nov 2022 11:07:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbiKELHC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Nov 2022 07:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiKELHA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Nov 2022 07:07:00 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD30CFCF1
        for <git@vger.kernel.org>; Sat,  5 Nov 2022 04:06:56 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id k2so19214377ejr.2
        for <git@vger.kernel.org>; Sat, 05 Nov 2022 04:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=61nNBJ/Ax2YdGleAtYr6RHpxGhLODzMO2Bxn5ui4XNU=;
        b=MAh0KtxhU5N23+p1tLvM5DRTQpbp4Rs+fWokuNW7THqkhCcFoaImUF7Dkq37T38lCE
         giqHcOaNd4mNVUh3Ajk+a2KO6Ir2ul6+T9aeTRtGEEIZ2d7GcwUz7iss1sUVv6O7YH63
         ROTxIk6cVE3auh5wwpCe2l3kcktjDUA9qzD6ypVx7RMWTkrqSIqbp7hIx0xrQPNyjqAz
         xQZgd+VYurvHVat9vjG1m4WCjwvFJ2+EDWr6/+ReHCvC9l59rWosUFzCnNzAsb99m3P5
         Z/T5sOpP23fEb9tmcdnqO/qeUyXNltWurajWokcUOv3pRKf5FluuJNzKPYy6X2za32aU
         YQtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=61nNBJ/Ax2YdGleAtYr6RHpxGhLODzMO2Bxn5ui4XNU=;
        b=oVevDUB81szniaGRrFx0aJgrMD3UDCO5MBW/0EiUGhOA5QvK+FCIGUnHHXLRkZe6wA
         o/grnycCYQ5N/TD+tKB6W1vtmGCcWxpFAKWNAwY7mlNwmgHsEUdoOa9dw6EV0JXvW4uT
         RMio1Vj8BmF6HZbQlqLbsUbhZNiCJWm2C4cQgZoi4V1JAfDd4IzrYNVJdVcdEl+Xik5J
         4FhB4pqvOhcOirdiD9OPXn6OS2zMqBp755NCn5d5u5RL+h1be1P1KrO8N4wTwSZzMGiI
         jMLeztS3MjoTGqcTQ6q4e+ZQc5vFpkMKF9SXukb+VjH3lkAQbx7UiTPfx7p5586xngKf
         8luQ==
X-Gm-Message-State: ACrzQf2mKg4Q9UYxjJIT471K9ukpNbTAsKs9hZ0/PHmfZWnyS9xoQFDF
        ZXyaZxDbAsBH303sSNaxsHs=
X-Google-Smtp-Source: AMsMyM4gPqAlyHNj223g89btQwZB+oMQiIXDD9L5/AQAh5aBwuqKG7mkPObtF5kIp8BMZD3qSBBpRQ==
X-Received: by 2002:a17:907:e93:b0:7ad:9ada:a675 with SMTP id ho19-20020a1709070e9300b007ad9adaa675mr39469715ejc.743.1667646415153;
        Sat, 05 Nov 2022 04:06:55 -0700 (PDT)
Received: from gmgdl (31-151-3-230.dynamic.upc.nl. [31.151.3.230])
        by smtp.gmail.com with ESMTPSA id ca21-20020aa7cd75000000b004580862ffdbsm1010480edb.59.2022.11.05.04.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Nov 2022 04:06:54 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oqxcG-000GVw-1A;
        Fri, 04 Nov 2022 15:24:16 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 0/3] Convert git-bisect--helper to OPT_SUBCOMMAND
Date:   Fri, 04 Nov 2022 14:55:29 +0100
References: <1cb1c033-0525-7e62-8c09-81019bf26060@redhat.com>
 <cover.1667561761.git.congdanhqx@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <cover.1667561761.git.congdanhqx@gmail.com>
Message-ID: <221104.86iljuyf0e.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Nov 04 2022, =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh wrote:

> This series aims to fix the problem that bisect--helper incorrectly consu=
mes
> "--log" when running:
>
> 	git bisect run cmd --log

I looked this over, and even though I'm obviously biased towards my own
shiny toy I really like where the progression & end state here is going.

> This also clears a way for turning git-bisect into a built-in in a later =
day.

Yes, but it would be much appreciated if you could take mine and/or
Johannes's conversion series, locally rebase it on what you have, and
check that any assumptions you've made here check out once we get to
that end goal.
