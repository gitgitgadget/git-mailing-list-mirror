Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E29C47095
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 19:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BD6F60FF4
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 19:54:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbhFGT4q (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 15:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231342AbhFGT4p (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 15:56:45 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506E1C061789
        for <git@vger.kernel.org>; Mon,  7 Jun 2021 12:54:53 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id k7so28588646ejv.12
        for <git@vger.kernel.org>; Mon, 07 Jun 2021 12:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=c9DEsXK0pLvKYbL9akw7l4FR9qzHPuM4fw0eyBfwwwA=;
        b=PSKs1QiPP7glgK1gnLXeyyg7kxECPXh4OD8trsRPzeyDG7zY0M2KfecfpQOHJKo0vr
         jiE6RC7CwRQvsCZb+LwTmIF4oSEypEk6WwTDg2CobkxQEtQt+JdfWmCnJuHUbWKE8Vo4
         Nnrk4bywcQvW7D1jM/fjZbtuwamMaZlRDz0iXtjRPMbsK0bsUgkXxn4DzvppBGc6yBiC
         6kq0xm3Oom5BXQEBMai6Uk1XoQ/bbpeg9op5aF097+LbRyXQrw+ReUn3UUnMcmHWMowW
         GoqWLd3yTCR9GBe5mXw7e0qgFY0BI/BKrTYft0pppAfC5woDsJqvammTnkXDUcfUc4a7
         oa6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=c9DEsXK0pLvKYbL9akw7l4FR9qzHPuM4fw0eyBfwwwA=;
        b=bXSM2j4Wr4LrDyyTbhQAorv8b5MygG2cryuJ2L15cG3bOddl1rup7VTrlBR68rO2KS
         kQJpD2+uETHr2garU8cJmUbexxMGnYKYO3fyz7YUu6TLLrAMxjQ7ICMhkK8n9S+Sq0le
         Bq3Wr6OzBY1+zg5mUsXU8LVGKp7X4w61q4h8QGXFm27PDpSXotNpTZKGcsHVU2KcY9VD
         fmfFgeMVO+RbeVHHapwEwUi37YqkF/ar8xHGWprTImS0gWwEPaS5FM6FT49SdfpaSE00
         Ch4zUsy0DMVku9gW4K2Yt1YGDe9rSf1i2NRIutIVeKEEaN4PtjL60zxcthBolNWWPj0O
         1Aww==
X-Gm-Message-State: AOAM532J0PKjSHJ2wIYq/bAjdEJTM5xlkGF+Rl/0SmFdx4K6MSGw96nW
        /AQIvD8Fe8osIVNIgi/q/X4=
X-Google-Smtp-Source: ABdhPJwaiHCbv/EIXaZJNYiXMjlBfZCUGTJq7YXM5MC5q4he27ibqn3zxMcGBgVAHyXPXBjunCbvZQ==
X-Received: by 2002:a17:906:9713:: with SMTP id k19mr19785351ejx.516.1623095691726;
        Mon, 07 Jun 2021 12:54:51 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id r12sm7997068edv.82.2021.06.07.12.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 12:54:51 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 2/2] read-cache: fix incorrect count and progress bar
 stalling
Date:   Mon, 07 Jun 2021 21:49:32 +0200
References: <cover-0.2-0000000000-20210607T144206Z-avarab@gmail.com>
 <patch-2.2-042f598826-20210607T144206Z-avarab@gmail.com>
 <8f336b1b-6cb7-8277-79d5-0f331159b00c@gmail.com>
 <87k0n54qb6.fsf@evledraar.gmail.com>
 <eaf2b6b0-4202-d5ea-87a2-b828fdbc60a1@web.de>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <eaf2b6b0-4202-d5ea-87a2-b828fdbc60a1@web.de>
Message-ID: <8735tt4fhx.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jun 07 2021, Ren=C3=A9 Scharfe wrote:

> Am 07.06.21 um 17:58 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>>
>> On Mon, Jun 07 2021, Derrick Stolee wrote:
>>
>>> On 6/7/2021 10:43 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>>> Fix a potential incorrect display of the number of items (off by one)
>>>> and stalling of the progress bar in refresh_index().
>>>>
>>>> The off-by-one error is minor, we should say we're processing the 1st
>>>> item, not the 0th. This along with the next change also allows us to
>>>> remove the last display_progress() call outside the loop, as we'll
>>>> always have reached 100% now.
>>>
>>> This "pre-announce the progress" seems correct and is unlikely
>>> to have a user sitting at "100%" while the loop is actually doing
>>> work on that last cache entry.
>>
>> I guess pre-announce v.s. post-announce is a matter of some philosophy,
>> for O(n) when can we be said to be doing work on n[0]? We entered the
>> for-loop and are doing work on that istate->cache[i] item, so I'd like
>> to think of it more as post-announce :)
>
> Say you have a single item to process and it takes a minute.  The
> original code shows 0% for a minute, then 100% at the end.  With your
> change you'd get 100% for a minute.  Both would be annoying, but the
> latter would have me raging.  "If you're done", I'd yell at the uncaring
> machine, "what are you still doing!?".

Perhaps if we said "100% and Reticulating splines[...]" :)

> Showing only the completed items makes sense.  That the next one is
> being processed is self-understood.  Once all of them are done, 100% is
> shown and the progress line is finished.
>
> So I think this pattern works:
>
> 	for (i =3D 0; i < nr; i++) {
> 		display_progress(p, i);
> 		/* work work work */
> 	}
> 	display_progress(p, nr);
>
> Alternatively, if the work part doesn't contain continue statements:
>
> 	for (i =3D 0; i < nr; i++) {
> 		/* work work work */
> 		display_progress(p, i + 1);
> 	}

But yes, I agree with the issue in theory, but I think in practice we
don't need to worry about these 100% cases.

We usually only display this anyway with a really big O(n), or (if we
correctly use the API) one where each item isn't that expensive, we just
do a lot of work in the aggregate.

So having a display_progress() at the top of the for-loop with "i + 1"
avoids needing two of them, or worrying about "continue" statements etc,
or (as in this case) where the data we're processing can be 10k items
with the first 8k being items we skip, so we'd be seen to hang, or
"jump" from 10% to 50%, then smoothly update 50%..60%, and jump again
etc.
