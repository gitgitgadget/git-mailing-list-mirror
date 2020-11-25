Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A34C64E7D
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 17:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEC0821534
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 17:55:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732126AbgKYRzX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Nov 2020 12:55:23 -0500
Received: from mail-ej1-f66.google.com ([209.85.218.66]:40832 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732075AbgKYRzX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Nov 2020 12:55:23 -0500
Received: by mail-ej1-f66.google.com with SMTP id oq3so4220219ejb.7
        for <git@vger.kernel.org>; Wed, 25 Nov 2020 09:55:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yO1PuS5wjLbT2bUeLqBh/6+jh3wEEMt+w9mt04+iNXA=;
        b=lfT2JnIjAhB3c3iZZ4uF167PYRKbJT9y9tM7BclY0HAdBigb8dD8bSGf6h6V1+KhzG
         hc9DkdSoD9LR/OD8Y4IgBW3+j+GWhsHXsKdPi6Uksci8V4J8qD9Vpfyz/AWcMvZ0N3pl
         aOgONVCxhIGjRRRJH2ctBBzwv6PgPbyp/EAcZLfr/Dk61mZSEZ6AbahuPy9LFC3U/uh2
         yTm7ussj7pNJ4V1rvB833QG0TQXWlcFXZla/DzL0n87/nO8ehK7oD2xeh3sUBk/Ppzdk
         i557+UfIbg5K12vUp1qGWG3wR0G4OFuI5psTKsOtDL/ZJF6K1PYf4T2azgRDs4sVOIvU
         B2lg==
X-Gm-Message-State: AOAM530CSx11MwMuJSeJrcs6nFIl+Vm9ifXVNuM0p3WMoZqx/jN0RFkB
        bVMDFLh7JzkfEHvKvSsz5mtqJhwr1oKg9r1WFto=
X-Google-Smtp-Source: ABdhPJz3AyqnXR1mut7aTashBRdyCVvNB5KB+cKZEiQQ9GnGPIFA8nhxQw+jGwMrtCH/LAunHfVUScwvKfNCG2l0864=
X-Received: by 2002:a17:906:3617:: with SMTP id q23mr4155882ejb.371.1606326921650;
 Wed, 25 Nov 2020 09:55:21 -0800 (PST)
MIME-Version: 1.0
References: <pull.796.git.1605801143.gitgitgadget@gmail.com>
 <pull.796.v2.git.1606147507.gitgitgadget@gmail.com> <39718048cd8f5be053a13ff73f531e3400b80b25.1606147507.git.gitgitgadget@gmail.com>
 <20201123222123.GE499823@google.com> <d18a2f7f-67e9-05eb-95d1-ce0b4bd0b187@gmail.com>
In-Reply-To: <d18a2f7f-67e9-05eb-95d1-ce0b4bd0b187@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 25 Nov 2020 12:55:10 -0500
Message-ID: <CAPig+cQ+GPUoddGXP47bJVMLCdpozoC752M6bmc=jpmhe33J8g@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] config: plumb --fixed-value into config API
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 25, 2020 at 10:49 AM Derrick Stolee <stolee@gmail.com> wrote:
> On 11/23/2020 5:21 PM, Emily Shaffer wrote:
> > On Mon, Nov 23, 2020 at 04:05:05PM +0000, Derrick Stolee via GitGitGadget wrote:
> >> +    printf "fixed.test=bogus\n" >expect &&
> > It is jarring to me to see a printf here when everywhere else we use
> > heredocs. 'git grep' tells me it's not unheard of, but it looks like
> > those are cases where the whole file doesn't use heredocs.
>
> I can use a heredoc just to be consistent.
>
> (To also respond to Eric's message, I tend to use printf instead
> of echo because echo starts a process while printf does not.)

`echo` is a builtin[1] in many or most shells (just as `printf` also
often is), thus is unlikely to start a process.

[1] Aside: You can use `type <cmd>` or `command -V <cmd>` to see if
<cmd> is a builtin in your shell.
