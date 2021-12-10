Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4854DC433FE
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 15:13:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239443AbhLJPQi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Dec 2021 10:16:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235073AbhLJPQh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Dec 2021 10:16:37 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 059C0C061746
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 07:13:02 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id e3so31542214edu.4
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 07:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=7zIwDu7nE+pN3DkvbDz37IczEKLhIEiipEsniHrdWi8=;
        b=i6KD30zqwerAMLjBDCq1kEjvvxxQeu/H/r4ty60WMTXhHFpNZlp6wFuitW2kbkcn0T
         BGBF0DUIS0Rhg7Id+h+ydx028j1+maKokHsK7clCY9vO/fTnR6wEPrki1utEegSqx5gp
         TUIx9n92Mdb0Y2U6DBCg2yHmfTxFdzZqyF1MiXGcyg6CdHnLzbq3N4zRQy8IJ5EC0HV1
         f0lzCnwv/CYTv08bhsOf/tYfUic5F6BxLfdKFQ3/Paskrj0ziybqgmsdCvcZGSDfLHpP
         mEFtYWjOG+q8sWiO9sK4dPc0KaMXAFZGLmz8iw4F/xiEW0D0q+c/YMHUXh3j6kNjH3R4
         VdjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=7zIwDu7nE+pN3DkvbDz37IczEKLhIEiipEsniHrdWi8=;
        b=QNKbgZpIBhwBLEgApgZP0DeW8mx7Pjgmen7zdUfMus87prylK6AoG/Q4Qa14l95xCn
         phu2plA5aT1HK4QRdTG7IOt+G6/h5VV5Lp4b0BY0mwFE4GaxmmyS1HWlMuUtlTfxYRQU
         HO6xsOUbjKlkkQEMsuSxnZXlt4bXypAKDATX8Yde1j42ZEWhxGVNaH1JagjE2+0NiAAk
         PLpY31VgDwOUCUyfmNrKcdtAfgi03H+ZMSLhSLbZpZbJwrHBxPPZ0/p5KYfgW8edRTd8
         c3FR02+PHab+oMS1lbUtRo8bS+vdakTrY2liYuGPdOlUM0j/Tou89h6T7mIvo44zNvDH
         v8Rw==
X-Gm-Message-State: AOAM532H1v3HtSj2m80DJQ+Jozpb/aCx+R+pW5SjtQ+7DaVgwTp41mUJ
        yoB9Z4PRKNz0K2NJmLwMvvDp/Ril2c4poA==
X-Google-Smtp-Source: ABdhPJzLdp5141WkObF3VfX9oRf4GtbmN0FRk7EyJE9IWuUOYQNHBBq4A9amCrcFjp0mNdN4wmZzzg==
X-Received: by 2002:aa7:cf0a:: with SMTP id a10mr39748509edy.194.1639149162022;
        Fri, 10 Dec 2021 07:12:42 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id em21sm1577730ejc.103.2021.12.10.07.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 07:12:40 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mvhZg-000MWN-2A;
        Fri, 10 Dec 2021 16:12:40 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Erik Faye-Lund <kusmabite@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC PATCH 00/10] range-diff: fix segfault due to integer overflow
Date:   Fri, 10 Dec 2021 16:07:15 +0100
References: <RFC-cover-00.10-00000000000-20211209T191653Z-avarab@gmail.com>
 <nycvar.QRO.7.76.6.2112101528200.90@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <nycvar.QRO.7.76.6.2112101528200.90@tvgsbejvaqbjf.bet>
Message-ID: <211210.864k7gcx3r.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Dec 10 2021, Johannes Schindelin wrote:

> Hi =C3=86var,
>
> On Thu, 9 Dec 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> The difference between "master" and "git-for-windows/main" is large
>> enough that comparing the two will segfault on my system. This is
>> because the range-diff code does some expensive calculations and will
>> overflow the "int" type.
>
> You are holding this thing wrong.
>
> The `main` branch of Git for Windows uses merging rebases, therefore you
> need to use a commit range like
> `git-for-windows/main^{/^Start.the.merging}..git-for-windows/main` and
> compare it to `git-for-windows/main..master`.
>
> Failing that, you will receive only bogus results.

Indeed. FWIW I got this segfault on an actual local range-diff that's
useful for a very large range & started digging.

I then tried to come up with some arbitrary command someone with a
git.git clone might be able to run that would reproduce it without
having to tell them to clone chromium.git or <other very large repo>.

> As to the patch series, it likely does the wrong thing. Just like we error
> out on insanely large input in libxdiff, `range-diff` should do the same.

I haven't come up with an actual use-case for diffing something large
(maybe someone storing DNA sequences as text would?), but have run into
practical cases where range-diff would be useful on range where it
currently segfaults. E.g. repos that get 500-1000 commits/day someone
cherry-picks commits between branches & rewords/adjusts, and you're
trying to range-diff it 2 months later looking for differences...
