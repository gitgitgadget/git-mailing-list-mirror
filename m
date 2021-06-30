Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD38FC11F65
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 08:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9322461D07
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 08:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233258AbhF3Ikc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Jun 2021 04:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232831AbhF3Ikb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jun 2021 04:40:31 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D82C061756
        for <git@vger.kernel.org>; Wed, 30 Jun 2021 01:38:02 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id t3so2028437edt.12
        for <git@vger.kernel.org>; Wed, 30 Jun 2021 01:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=gilQEN1L3B88K0JPWiCD4HQvGS4uhUNLlAWXkGEq40A=;
        b=A3j04y5c89s4Acojkpupu3snPJdjCTQcGa3/JyA5LjiXt7zpuLDSzlGXOEpFdk/26j
         2EGh3OHCpZzs4D04sLebKA2hUn8TVUSDxu8IM6LtOQlwM3Fp6jtNzea4qMn4HfviSte0
         lwpskzzq/Wnt4MjjZIHrNiSwMHrAxlGvrFk7k4lpR75gpHaWfMPoypqKV+lUrO89jR9P
         4W2v3m2YIQ44BuSBQgTJeaTrd08hjXtf12blmtGglThY5G7GnB35VRkWHwfJ22U44qMU
         rCGqMWxHneIfjJn5RZf3TWbDtgirp1hmmMYiQzPsBKK6ptNNoRfnXGFhrO3tBwyI6NMO
         1U2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=gilQEN1L3B88K0JPWiCD4HQvGS4uhUNLlAWXkGEq40A=;
        b=ZSq3e8yLKoR9RyvJ83mbuPfmJPzvtSx452nsQ+td7jO6YqfXY90EkUVy/LyPmjkfJf
         MwkU+DaiJv/OCM+lge/T4RFZIWxWkvpmJNvUoi8zhmZIuKOAcwzoSaz43R0ZGKcjNYfP
         8I8x0pa/K5xG1dN+Au4FdjSx0Wxf/IGXdfYqT/CwN8Bi+zE8u0BY/apHDkJXAVKrSww6
         ZGZl2quhb8vJxUwVhVGkl7GZG463Al0OVXoC726XRV+ZGKQ05/QyKw2tSJ445L70zgiW
         tf3A33uYM+pknkoNnZEjqUSV2IoCFyQwYJnnChv5EcQdF1guoJIjQRSB4ORj9QApRK1M
         tGeA==
X-Gm-Message-State: AOAM530SfrYKy+nb8pbZ+IZ2ZQ3LgjxAEXNyp46L4EhJIevZoQLJOiv/
        SDAHn/hq+XxWZuF3/c2rjmNzmZ8LzXsEWA==
X-Google-Smtp-Source: ABdhPJyQgG3wdk2s8W+dANBdHLZJVkuGBTKGiLPNmPSxMxk4JiO1HnbRP6gBx8P2qi7FrKiYXGU7qg==
X-Received: by 2002:a05:6402:42cb:: with SMTP id i11mr39706894edc.56.1625042281300;
        Wed, 30 Jun 2021 01:38:01 -0700 (PDT)
Received: from evledraar (ip52-163-211-87.adsl2.static.versatel.nl. [87.211.163.52])
        by smtp.gmail.com with ESMTPSA id c18sm12258119edt.18.2021.06.30.01.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 01:38:00 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: Antw: [EXT] Re: git add --interactive patch improvement for
 split hunks
Date:   Wed, 30 Jun 2021 10:27:16 +0200
References: <60D45FE4020000A100041FCE@gwsmtp.uni-regensburg.de>
 <YNSnlhbE30xDfVMY@coredump.intra.peff.net>
 <60D9A01C020000A100042099@gwsmtp.uni-regensburg.de>
 <87eecmgrnx.fsf@evledraar.gmail.com>
 <YNvT+tUlW98dQY3B@coredump.intra.peff.net> <xmqq5yxvvq7k.fsf@gitster.g>
 <YNwd6wmt4FTyySgH@coredump.intra.peff.net>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <YNwd6wmt4FTyySgH@coredump.intra.peff.net>
Message-ID: <874kdfg32w.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jun 30 2021, Jeff King wrote:

> On Tue, Jun 29, 2021 at 11:09:19PM -0700, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>>=20
>> >     It looks like Junio carried it in "What's Cooking" for almost a
>> >     year, marked as "waiting for re-roll" to handle the squash, but th=
en
>> >     eventually discarded it as stale. :(
>>=20
>> Heh, thanks for digging.
>>=20
>> Is the moral of the story that we should merge down unfinished
>> topics more aggressively (hoping that the untied loose ends would be
>> tied after they hit released version), we should prod owners of
>> stalled topics with sharper stick more often, or something else?
>
> I'm not sure. I think the topic would have graduated if either you had
> just applied the squash and merged it down, or if the original author
> had checked back in over the intervening year to say "hey, what happened
> to my patch" (either by reading "what's cooking" or manually).
>
> I suspect drive-by contributors might not realize they need to do the
> latter in some cases, but I wouldn't have counted 2014-era =C3=86var in t=
hat
> boat. So I dunno.

Or maybe the moral of the story that it's a net addition of complexity
to git-add--interactive.perl. If I didn't care enough to remember or
notice the issue again maybe it wasn't all that important to begin with.

Likewise when it got ejected nobody else seemed to notice/care enough to
say "hey I liked that feature" & to pick it up.

I'd entirely forgotten I wrote that. Now that I'm reminded of it I don't
care enough myself to rebase it, test it again, and especially not to
figure out if/how it's going to interact with the new C implementation /
add and adjust a test for the two.

But maybe someone else will, it would be neat if someone has more of an
itch from the lack of that feature & wants to pick it up.
