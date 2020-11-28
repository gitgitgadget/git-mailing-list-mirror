Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F00A2C83017
	for <git@archiver.kernel.org>; Sat, 28 Nov 2020 22:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE437221FD
	for <git@archiver.kernel.org>; Sat, 28 Nov 2020 22:16:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389113AbgK1Vtu convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sat, 28 Nov 2020 16:49:50 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39714 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387489AbgK1TNu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Nov 2020 14:13:50 -0500
Received: by mail-lj1-f193.google.com with SMTP id o24so10071880ljj.6
        for <git@vger.kernel.org>; Sat, 28 Nov 2020 11:13:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TDaeUaqgt2AfF1hHKS/kmCKR/fXVTK7Rdg3TINsJhac=;
        b=al92gZVAPkurYqvRXhymVCvEGWBO7l8vSm/Xh3msw1fmRJUdSkQIc81G6fgQCMp8O+
         XWY/95IHkYxuLJOClG8P/DaWH/oRu0HuqGBbbsal1PL1AdEcLMLOM7PsPJCQaX6LSXuA
         KBTppqH9nOrvLzmrCuJ0hv+jYYRM8rpdH02cuTuzqRm8v+t3TSo2cV15BTuP3mGJq8OD
         mdgCzelahcAQb5jvKuiufcr/F2+pogQv/H3X8SQIBG8ZxJmU4NYscXai23FHJOzZn1eq
         cVBVllSPGeatGMzGwGefiLzD8cgNpqpMqyIy8SQOEyQM4rpgOmU6Y3vEVtqemZ8zTEDt
         gVtA==
X-Gm-Message-State: AOAM531ZBfIpO2nQG+munMh/K67QISIk0cJCIKozgMcPrv5+4Rhl6UKs
        DwTah58h7Ol3CK4eZSVvueeZuXOwuP1ad/C2msc7/ucx
X-Google-Smtp-Source: ABdhPJxgDTZtOwgujSUtV9xxB6Xf7sIT5X5tjWE+IMf/Er+u48WMw0PxR0CmRqJwAwbb08KFaiDd+k16VKfcxtAUzG8=
X-Received: by 2002:a17:906:c357:: with SMTP id ci23mr11051810ejb.311.1606542945645;
 Fri, 27 Nov 2020 21:55:45 -0800 (PST)
MIME-Version: 1.0
References: <20201127075054.31174-1-sunshine@sunshineco.com>
 <20201127075054.31174-4-sunshine@sunshineco.com> <87o8jikfh7.fsf@evledraar.gmail.com>
In-Reply-To: <87o8jikfh7.fsf@evledraar.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 28 Nov 2020 00:55:34 -0500
Message-ID: <CAPig+cRbga9ksi0JedU=U1zbLMY26xLtB7sBDJ5M5=TT1HsX1A@mail.gmail.com>
Subject: Re: [PATCH 3/3] t7900: make macOS-specific test work on Windows
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 27, 2020 at 10:05 AM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> On Fri, Nov 27 2020, Eric Sunshine wrote:
> > +test_expect_success 'start and stop macOS maintenance' '
> > +     uid=$(test-tool getuid) &&
>
> This seems equally portable, and means your 2/3 isn't needed, no?
>     +   uid=FAKE_UID &&
>     +   echo \$* | perl -pe "s[(?<= gui/)-?[0-9]+][$uid]g" >>args
> I.e. the context here is that the test is already hardcoding an
> assumption about "gui/%d" (per code in gc.c). It seems more robust & to
> the point of the test to not care about the specific UID number that
> comes back, since we're really testing whether we invoke our own code,
> not platform getuid() sanity.

Good idea. That's a reasonable viewpoint to take, and makes the series simpler.
