Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD48C43334
	for <git@archiver.kernel.org>; Fri, 22 Jul 2022 11:18:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbiGVLSm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jul 2022 07:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiGVLSl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jul 2022 07:18:41 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BDAF4C625
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 04:18:39 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id t3so5490072edd.0
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 04:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=njtSrl6cBjaOtV224kKTRJfS2G5IGu2B2VvdfB3kWKg=;
        b=Wah/fkOIQI3ofQhcvQxvNebRPe6bP2I/VtbzcmXjRcg0g/tXxKkj+ZDJEpZBbl7Hsv
         B6oa2Nya72Yz3L9PNIuUeXMDayuxCHpeCYzl+JJfFbj9kUiWe67vjaU7U7j0L/4nDvWE
         TQC5NiKemyWalAI4uPH4+chzHxZYkwWCYUAdYF3lVNSRH+uKmALOqr/1kK6l7kgkm1E2
         HgAqUtcc8wrwSQ4WpJJ+EPA2DGaBSbhfKMQgGbYMFitoJd843maok2o6zU0q0zkMYtwZ
         4fGCsuKHLZskN90Pvqr7g4LPA7A0tRjqKQ0crlpxEM+1qewydqYCRd4jFmv7E/4v+qHC
         N8GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=njtSrl6cBjaOtV224kKTRJfS2G5IGu2B2VvdfB3kWKg=;
        b=ywB7np8jxfFpbWp0tGH4wEqFHkzu8zayMf10OkL6C0kdqH8al61DKZruXXEJWmQa0u
         orHRMzGcnnoWgSNd6UhAabuZraBN4FuM2eg8GcogzIcmxMuwbQanC9RmzoZOmVu2gyvg
         wx72cMBsDCVQrWaalJLLPIRW2Zfvvj2i/CBtIC7cceWXq06BqE3YMIgLQJ1E7YjLQpHv
         UZ9hT+YigPoE2fX7t22I5xzyhLyir/05GuNpU88OA4BuJ8DLy0RDUVsXSd6vK/syM9AE
         fdcoI+W57yvN8HIOm0N2mmPzBWMtxrvoGqABvduGcZE5GZmCCKKkWw+xvzgV3q4R62xz
         Y72w==
X-Gm-Message-State: AJIora8HPll0jtyRaWWrU6YBFb06LS+F5Ceg9181WMBTSxiMwR5HmU3R
        vKHnBKzsWGileIES57M1m2A=
X-Google-Smtp-Source: AGRyM1tErysh5t1lS5dy4+Pva5bRCOzRrEKp9AuO/WsUCfuzxVwEVEO2fd3Xlr9hSr2uSxo5K8/CwA==
X-Received: by 2002:aa7:c0d0:0:b0:43b:b6d5:2977 with SMTP id j16-20020aa7c0d0000000b0043bb6d52977mr59112edp.199.1658488717862;
        Fri, 22 Jul 2022 04:18:37 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id l10-20020a170906938a00b006f3ef214daesm1929725ejx.20.2022.07.22.04.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 04:18:36 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oEqg0-005ISm-AF;
        Fri, 22 Jul 2022 13:18:36 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        git <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: Can I use CRoaring library in Git?
Date:   Fri, 22 Jul 2022 13:07:47 +0200
References: <CAPOJW5x4McofC5fxBvsRAzum28wmeDJCMTMRmY_0oy=32JjKqQ@mail.gmail.com>
        <CAPOJW5yJDq046nhq0V-syAg4ttoy++rBtq_RHSXPAKhtDDw6jQ@mail.gmail.com>
        <xmqq7d47m1t2.fsf@gitster.g>
        <304fd857-db62-7a1a-a9a9-cbfa93c2a00c@github.com>
        <220721.86r12etvly.gmgdl@evledraar.gmail.com>
        <CAPOJW5zA1FnLDWXgRza3WLCHK0ER7ZUkdyq-kcPm4-TsW9U2nA@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <CAPOJW5zA1FnLDWXgRza3WLCHK0ER7ZUkdyq-kcPm4-TsW9U2nA@mail.gmail.com>
Message-ID: <220722.86bkths8dv.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jul 21 2022, Abhradeep Chakraborty wrote:

> On Thu, Jul 21, 2022 at 7:29 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>>
>> It's great that the primary author of the library wants to release it
>> under a compatible license.
>>
>> But I feel like I'm missing something here, don't we still need the
>> other contributors to that code to sign off on such a license change,
>> and for us to be comfortable with integrating such code?
>
> As far as I see their commits, they don't use sign-off in any of their co=
mmits.

That's unrelated, that's just a convention linux.git & git.git (and
maybe some others) use to mean "I pinky promise this is my work, or can
be licensed under the project terms".

It doesn't impact how copyright or software licencing works in general.

> I know what you want to mean but the license text uses "The CRoaring
> authors" rather than "Daniel Lemire". Below is the text -
>
>     /*
>     * MIT License
>     *
>     * Copyright 2016-2022 The CRoaring authors
>    *
>    * Permission is hereby granted, free of charge, to any
>    * person obtaining a copy of this software and associated
>      ...
>    */
>
> So, isn't it enough for us?

That's a commonly used shorthand for not having to exhaustively list all
authors everywhere, but it's unrelated to the process by which
dual-licencing can happen after the fact.

If you and I come up with a 1000 line file together (each contributing
500 lines) and it says "copyright <this file's authors> and we license
it under the GPLv3" that doesn't give either of us permission to then
re-license the work later without the other copyright holder's approval.

>> My understanding (again, not a lawyer and all that) is that such
>> transitions happen one of a few ways:
>>
>>  A. One entity had been assigned copyright in the first place, and can
>>     re-license the work. E.g. the FSF requiring copyright assignments
>>     for anything non-trivial.
>>
>>  B. The license itself has an "upgrade" clause (e.g. GPLv2 "or later"
>>     projects being GPLv3 compatible).
>>
>>  C. All copyright holders (or near enough) agree to
>>     relicense. E.g. OpenStreetMap went through this process at some
>>     point.
>
> I got your point here. I am sure that "All copyright holders" have no
> problem with this relicensing.

Yes, that seems unlikely in practice. But I'm asking because it's not
obvious from the linked-to discussion that anyone except the primary
author decided this.

So if we integrate it into git.git and one of those people /would/ have
a problem with it we'd be the ones in trouble.

> Daniel already said in his comment[1] that they do not have any problem w=
ith it.
>
> [1] https://groups.google.com/g/roaring-bitmaps/c/0d7KoA79k3A/m/t8e09-wPA=
gAJ

Anyway, I don't see much of a point in two non-lawyers continuing this
discussion, I just asked in case there was something obvious I was
missing. E.g. the primary author is a professor, perhaps all (or
substantial amount of) the contributors were students at the same
university, and some copyright assignment etc. happened behind the
scenes.

I think it would be prudent if/when we decide to integrate this code to
ask our contacts at the SFC to give this a once-over, luckily we do have
actual laywers to call on if needed :)

