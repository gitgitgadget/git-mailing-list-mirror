Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A406FC433EF
	for <git@archiver.kernel.org>; Mon, 28 Mar 2022 19:57:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343918AbiC1T7B (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Mar 2022 15:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344353AbiC1T6l (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Mar 2022 15:58:41 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7346466CA5
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 12:56:59 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id t25so26638737lfg.7
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 12:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VqyAGZPF9OZVvRDwjstHQwCSONilLWNZyQVrlEU+iKE=;
        b=cwN4xYoYlIJrIl9xjiLEtx2Gd2xeZtXdPDLSCF5ME1WdXnkWR3UI4grjeu+KlTxgDF
         YczIFvdgL1IpAcKMANvean25SaQ2Pwm5byNrVsU7qUezZwv2AHmVJkraaTRX/HpIkl+u
         eIXPiC54DcZIblynysbsv92SAxDrvsCXNYdx4yyJOncT/4IpKL2upefUP4RX+7iRN0eB
         TkGoK4+EDZU6v0Rg0eI7fGxVOtx7/J9aGKLFeILNnWWp3h1kn1/4YERqXDnWlom7HKO1
         7aoUSUlaE1JHl+H55U4Og/aGvZcx8EnLs8m1r/3YEyZiyLfkA+Ts057zv1V2Y7S0Vx7g
         Z6vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VqyAGZPF9OZVvRDwjstHQwCSONilLWNZyQVrlEU+iKE=;
        b=RHFZkHxcu78yplYZVuy1T+VrQMVRo7a0JsVTCXno4cQPWUTG5+9qXn3T8iwBAQG/kT
         2AbaNASgD4jcIeIyOdNRsQfMfYPSqNzzJ3TDQ8NEcrZOG+SN3AxTEtIfN4mI2VCMFdfw
         m0/YIrHAP93O26nMTefO4c6ZBvlDWhO64Zj8qbXFAWkVifdZtOt1ftgNlcWuI3+zKOKG
         5BBuXKR9LWkMJySdzXjhimeP3vVo1lofhNvlvNRhq3KL4BL+DS5fz6XNy+scYp70K2hL
         n74y3gtuSRr8S7Lcaxt5PyeHp9wNZtQzhJ4kyxN8TCkfECMWCTbRQgKCSoVI0JHjRzwJ
         jsCQ==
X-Gm-Message-State: AOAM531AXDnYSitKhylQXQA2oIInX5z7JimUgsiS8WCBE1ExZnn5flcf
        fiXWnHB0onYd1BDO7m7XrVSyFoRpwtuws0ruXBo=
X-Google-Smtp-Source: ABdhPJwfe7Ke55DUTO46EclKc8ufnzyN3Is9Lipnymqt0WL4CD8fEwZtEu25v1ycyJ/GtaiAHyWqn9wUV1LGyAxwD4U=
X-Received: by 2002:a05:6512:322f:b0:44a:57a0:6950 with SMTP id
 f15-20020a056512322f00b0044a57a06950mr21792585lfe.74.1648497417216; Mon, 28
 Mar 2022 12:56:57 -0700 (PDT)
MIME-Version: 1.0
References: <7e4cc6e10a5d88f4c6c44efaa68f2325007fd935.1646952205.git.gitgitgadget@gmail.com>
 <20220315191245.17990-1-neerajsi@microsoft.com> <220323.86fsn8ohg8.gmgdl@evledraar.gmail.com>
 <CANQDOdeeP8opTQj-j_j3=KnU99nYTnNYhyQmAojj=FZtZEkCZQ@mail.gmail.com>
 <220326.86ils1lfho.gmgdl@evledraar.gmail.com> <CANQDOdeduc8bFA_=R-kXmkM+nb__oTxVhjBfFYj70vCFew1EyA@mail.gmail.com>
 <220326.86sfr4k9rm.gmgdl@evledraar.gmail.com> <CANQDOdfWh5aO9cuJVuUccKyD9Cj+NndisokiewBH9Sq4oSUp5A@mail.gmail.com>
 <220327.86y20veeua.gmgdl@evledraar.gmail.com> <YkGUeQH4y1KIAdCc@ncase> <220328.86pmm6e0i0.gmgdl@evledraar.gmail.com>
In-Reply-To: <220328.86pmm6e0i0.gmgdl@evledraar.gmail.com>
From:   Neeraj Singh <nksingh85@gmail.com>
Date:   Mon, 28 Mar 2022 12:56:46 -0700
Message-ID: <CANQDOddSnSByqMrU+b11zywwWjOS+A5W0BSXa0rZURWn5zi2Tg@mail.gmail.com>
Subject: Re: do we have too much fsync() configuration in 'next'? (was: [PATCH
 v7] core.fsync: documentation and user-friendly aggregate options)
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Patrick Steinhardt <ps@pks.im>,
        "Neeraj K. Singh via GitGitGadget" <gitgitgadget@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Git List <git@vger.kernel.org>,
        Neeraj Singh <neerajsi@microsoft.com>,
        Elijah Newren <newren@gmail.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Wong <e@80x24.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 28, 2022 at 5:15 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> I hope we can work something out :)
>
> Overall: I think you've left one of the the main things I brought up[1]
> unaddressed, i.e. that the core.fsync config schema in its current form
> assumes that we can sync A or B, and configure those separately.
>
> Which AFAIKT is because Neeraj's initial implementation & the discussion
> was focused on finishing A or B with a per-"group" "cookie" to flush the
> files.
>
> But as [2] shows it's more performant for us to simply defer the fsync
> of A until the committing of B.
>
> Which is the main reason I think we should be re-visiting this. Sure, if
> we were just syncing A, B or C having per-[ABC] config options might be
> a bit overdoing it, but would be relatively simple.
>
> But once we start using a more optimized version of the "bulk" mode the
> config schema will be making promises about individual steps in a
> transaction that I think we'll want to leave opaque, and only promise
> that when git returns it will have synced all the relevant assets as
> efficiently as possible.
>
> 1. https://lore.kernel.org/git/220323.86fsn8ohg8.gmgdl@evledraar.gmail.co=
m/
> 2. https://lore.kernel.org/git/RFC-patch-v2-4.7-61f4f3d7ef4-20220323T1407=
53Z-avarab@gmail.com/

I think the current documentation is fine (obviously since I wrote
it).  Let's reproduce the first part again:
---
core.fsync::
A comma-separated list of components of the repository that
should be hardened via the core.fsyncMethod when created or
modified.  You can disable hardening of any component by
prefixing it with a '-'.  Items that are not hardened may be
lost in the event of an unclean system shutdown. Unless you
have special requirements, it is recommended that you leave
this option empty or pick one of `committed`, `added`,
or `all`.
+
When this configuration is encountered, the set of components starts with
the platform default value, disabled components are removed, and additional
components are added. `none` resets the state so that the platform default
is ignored.
+
The empty string resets the fsync configuration to the platform
default. The default on most platforms is equivalent to
`core.fsync=3Dcommitted,-loose-object`, which has good performance,
but risks losing recent work in the event of an unclean system shutdown.
+
---

We're only talking about "hardening" parts of the repository, and we
say we'll do it using the "fsyncMethod".  If you don't harden
something, you could lose it if the system dies.  All of these
statements are true and don't say so much about the implementation of
how the hardening happens. It's perfectly valid to not force any
component out of the disk cache, and a straightforward implementation
of repo transactions can put the sync point anywhere. We also
explicitly point the user at a "porcelain" setting in the first
paragraph.

So I think you're alone in thinking that anything needs to change here.

Thanks,
Neeraj
