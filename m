Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B08E6C4332F
	for <git@archiver.kernel.org>; Fri,  2 Dec 2022 00:14:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232053AbiLBAOZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Dec 2022 19:14:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbiLBAOY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2022 19:14:24 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E711ACEF95
        for <git@vger.kernel.org>; Thu,  1 Dec 2022 16:14:23 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id fy37so8005201ejc.11
        for <git@vger.kernel.org>; Thu, 01 Dec 2022 16:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mZn5keViHUIfNnm1a8TOKKqxGfNel95n664wek+BMl0=;
        b=Bg4KcVQS1kjlnJrlL7w01G+Sh623mEXpA5aRthww00RpiyTLpUoyxxZ31jsh6sNd5L
         LkQRkVhPO1iqRyS13abxb7MbFGbbsTO6mXIroCv0jDPd/O2Wg7C1d9hKFzhvWrW7WoHp
         zuWxBnXwjMGje98avfX2JnO+na1RynCEWBcZCR7k+MJU+zGE6NtNJxk3AqXlc55uTn4c
         Ww2WnJVmsBZbIvVemihfDs0cU/8ZBIqc37+jZL1X1WksXhMPgjQwbA+vxvHRl5EHDYDT
         K6VkVS6+S9Q10Ep0JA/aoW3l+ZSHZRhNE149BhFWIBTGYBmE8LQvUGxoJo6JnQ0Vr5Pu
         5oSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mZn5keViHUIfNnm1a8TOKKqxGfNel95n664wek+BMl0=;
        b=Iph/HD72+XTSZFV/HPEM2VOkg4W9qwvX3k9jgC8PqQ1OCnPfA9050GeTchdzzOo1Dx
         gbjEh2uA/TQNhOVLMn7De66OUNiXHn3Os5bkdzO3elQUpiO60uy9xwg0lwLVR+2pTU1C
         igHduJd6lU4FI8kY1Mlmo23Di51lnsjjvnxjnNw46oebX3YaxxoN9fUZ93EYX97ZKK28
         Rc7BcHQg1NRU+SWj85Fuj+jQ+7dmEP4Svjs/vaQ5auaEGrU2G6tVGlsa4herAMROwbkp
         SQ9Kw1w1lhdktdmkCfbllyi55bjffZtvTwlNbHMtNBFt3+Bc2WsYtLalJUIVJqmzElbA
         +zzA==
X-Gm-Message-State: ANoB5pnoMvH8E6Tg/msfdtgYJo3BYmbieFSd6ApUvVv4+eltSM5t/3Pe
        LTGgd6xXs42Og+XA3BnLUQaZIONdJiTfbA==
X-Google-Smtp-Source: AA0mqf5c7Z0Ef65XCvef8A27Dm3NUS8ZUjTgAQLDON75WoaYW7QHeYVOFjoyjyJwQBcp3Ai4dB/fQw==
X-Received: by 2002:a17:907:cb83:b0:7ad:f43a:cb0a with SMTP id un3-20020a170907cb8300b007adf43acb0amr43791736ejc.560.1669940062329;
        Thu, 01 Dec 2022 16:14:22 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id kj22-20020a170907765600b007c090da9eb4sm2385878ejc.82.2022.12.01.16.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 16:14:21 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p0th7-002Nhi-0T;
        Fri, 02 Dec 2022 01:14:21 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] t4205: don't exit test script on failure
Date:   Fri, 02 Dec 2022 01:07:56 +0100
References: <c5b4d091-23c1-5a75-a255-99ec83973d8d@web.de>
 <221202.86edtihgga.gmgdl@evledraar.gmail.com> <xmqqr0xir9lk.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <xmqqr0xir9lk.fsf@gitster.g>
Message-ID: <221202.86a646hdb6.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Dec 02 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> This is also 6/6 in this series to submit a bunch of these sorts of
>> issues, which I submitted back in July:
>> https://lore.kernel.org/git/cover-0.6-00000000000-20220721T064349Z-avara=
b@gmail.com/
>
> Such a comment is the least productive, I am afraid.
>
> When the series originally did not get any traction would have been
> a good time to ask others for reviews to push it forward, but not in
> a thread of other people.

I think it's a productive comment on a patch to point out that it's the
exact same change someone else has submitted independently before.

In my mind that's better than a "LGTM" or "Reviewed-by". Those are both
versions of "I looked over your work", but if you independently come up
with the same thing that's usually a stronger sign that the proposed
solution is a good one.

If you read it as complaining that my series didn't get picked up that
wasn't the intent. I don't care either if Ren=C3=A9's commit ends up on
master, or mine. Just as long as the issue gets fixed.

I did just re-submit that series just now, re-rolled to get past a minor
conflict, and with a few other changes.

It's still just the tip of the iceberg in terms of these issues in the
test suite, but hopefully it can get picked up this time around, and
perhaps get some reviewer interest...

1. https://lore.kernel.org/git/cover-v2-0.8-00000000000-20221202T000227Z-av=
arab@gmail.com/
