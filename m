Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89EEDC77B72
	for <git@archiver.kernel.org>; Fri, 14 Apr 2023 17:39:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbjDNRjJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Apr 2023 13:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjDNRjI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2023 13:39:08 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E861BE1
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 10:39:07 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id k1-20020a4ab281000000b0053e8b5524abso338189ooo.2
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 10:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681493946; x=1684085946;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FEtyHXbaeYN7p9rMNr19LNVLXt/CBGXY8oh/4sLfipw=;
        b=UIZm9cPtxsG/GsDde5fQz+O+//aNvs8xb9o2S99iyHY2jGDrt9ti4uo41K2iOJJwBI
         Iu4RgaZVMfsP7isNGfq7lm4qRhRJHX4JntLmipVyC5RpofBh54GyPY+Wp78eW/SV2ez8
         9MZ0zPuRU10atzl6WieIGtbXNye8s7wMMqpwctZcyOTi5REXRIoqKqhG9aJmnetH4apc
         2091425yGCog0OqBGvoTeYmYisG/TZ8v6VUgLAbwc8Zzvbj/C8qDYVepfxFZmrM194wC
         oH+bstTsuQrtky+UqmvWNLH0n7WjhH2flnN0HS4/WE1CjHwbXUuwR7VW6x15hHfEx4el
         3qdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681493946; x=1684085946;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FEtyHXbaeYN7p9rMNr19LNVLXt/CBGXY8oh/4sLfipw=;
        b=Iziat/hNtH3lYBFqsWIBT3BxF7Nu81hAXKw3I5GhJi2Hw/MGDIYwzDQo9zA9zCbRhr
         wOUB7ZlKdg7RpUyPjng16spslaPc1aJ82RAkM1Z7/jcLO6uhu2CiGZIgiwF/j2+QsWyh
         //Cc8dV1LzjNNNVd7Vz3keeXS0EjMWpsR2KtQ3BACSDgJpxzLeuaAhlnEh9sbIiApofp
         Zg7CRml7DKazzdxoaDo7YshSKwSGns/5hhZYqXnWs7933ICQFadb5J9BHYjTwPvQNimj
         DcU5CUvOhgPScFca2D5ltZ/OoxZXRbTjuJ0GYxdhZzjUNPocr08vwwYtg3q2vjEn1d7c
         rO8w==
X-Gm-Message-State: AAQBX9fYrVe6K2ThV+826pdzRF6pNVLdW64FaS6BjGov3fAlXSKlgtZL
        VhrAfwkOo2Sp4Z/HRaDkaoA=
X-Google-Smtp-Source: AKy350bQp0yYUwxxDxVdpJXaFt4Jxf+tGLpJclqyFvzgqbAwS198FZCwr+dk9cTPxEwPEqKNJuPWPA==
X-Received: by 2002:a4a:49d8:0:b0:541:fd7a:5f64 with SMTP id z207-20020a4a49d8000000b00541fd7a5f64mr2841598ooa.8.1681493946156;
        Fri, 14 Apr 2023 10:39:06 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id p14-20020a4a95ce000000b0053e8336f5dcsm1925788ooi.7.2023.04.14.10.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 10:39:05 -0700 (PDT)
Date:   Fri, 14 Apr 2023 11:39:04 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Message-ID: <64398fb87548d_5d9f72942d@chronos.notmuch>
In-Reply-To: <20230407072415.1360068-1-christian.couder@gmail.com>
References: <20230407072415.1360068-1-christian.couder@gmail.com>
Subject: Re: [PATCH 00/14] Introduce new `git replay` command
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder wrote:
> # Quick Overview (from Elijah)
> =

> `git replay`, at a basic level, can perhaps be thought of as a
> "default-to-dry-run rebase" -- meaning no updates to the working tree,
> or to the index, or to any references.

Interesting, I just ran into this problem trying to cleanup my personal g=
it
branches.

Simply checking which branches can be cleanly rebased on top of master ta=
kes a
significant amount of time without any tricks, and using `git merge-tree`=
 still
takes some time.

But the biggest offender is checking which patches have not yet been merg=
ed
into master, which takes 52 seconds on my machine which is by no means ol=
d.

> # Reasons for diverging from cherry-pick & rebase (from Elijah)
> =

> * Server side needs

I personally don't care about the server side, but...

>   * Both cherry-pick and rebase, via the sequencer, are heavily tied
>     to updating the working tree, index, some refs, and a lot of
>     control files with every commit replayed, and invoke a mess of
>     hooks[1] that might be hard to avoid for backward compatibility
>     reasons (at least, that's been brought up a few times on the
>     list).

This is important as an end user as well.

Since day 1 one of the important selling points of git was that operation=
s that
could be done in milliseconds did take milliseconds.

If it can be done faster, why wouldn't I want it to be done faster?

> * Decapitate HEAD-centric assumptions

That's good, but not particularly important at the moment IMO.

> * Performance
> =

>   * jj is slaughtering us on rebase speed[2].  I would like us to becom=
e
>     competitive.  (I dropped a few comments in the link at [2] about wh=
y
>     git is currently so bad.)

Indeed.

>   * From [3], there was a simple 4-patch series in linux.git that took
>     53 seconds to rebase.

I did participate in that discussion, but Uwe Kleine-K=C3=B6nig never res=
ponded back.

In [1] he clearly noticed the problem was *before* attempting to apply an=
y
patch. Other people mentioned the fork-point detection, but I don't think=
 that
was the issue, my guess was that checking for the possibility of a fast-f=
orward
was the issue.

The code was clearly doing the wrong thing for that case, but I believe i=
t
should have been fixed by d42c9ffa0f (rebase: factor out branch_base
calculation, 2022-10-17).

It would be interesting to see if this issue can be reproduced somehow.

>     Switching to ort dropped it to 16 seconds.

No, it dropped to 16 seconds it for Elijah, not Uwe. Uwe (who had the rea=
l
repository) noticed a big reduction of around 70%, but the discrepancy of=
 using
--onto versus not always remained.

>     While that sounds great, only 11 *milliseconds* were needed to do
>     the actual merges.  That means almost *all* the time (>99%) was
>     overhead!  Big offenders:
> =

>     * --reapply-cherry-picks should be the default
> =

>     * can_fast_forward() should be ripped out, and perhaps other extran=
eous
>       revision walks

Doesn't d42c9ffa0f (rebase: factor out branch_base calculation, 2022-10-1=
7)
deal with that?

---

I think something like this is defeinitely needed, when I rewrote `git re=
base`
to use `git cherry-pick` I noticed many areas of improvement, and I'm of =
the
opinion that `git rebase` should be rewritten from scratch.

But precisely because git focuses too much on backwards compatibility (an=
d
often in the wrong areas), I think `git replay` should be thoroughly disc=
ussed
before accepting something we could quickly realize can be substantially
improved.

Cheers.

[1] https://lore.kernel.org/git/20210528214024.vw4huojcklrm6d27@pengutron=
ix.de/

-- =

Felipe Contreras=
