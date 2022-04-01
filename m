Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96397C4332F
	for <git@archiver.kernel.org>; Fri,  1 Apr 2022 10:36:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344902AbiDAKij (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Apr 2022 06:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345001AbiDAKiQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Apr 2022 06:38:16 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39D5A266B6C
        for <git@vger.kernel.org>; Fri,  1 Apr 2022 03:36:27 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id z128so2108359pgz.2
        for <git@vger.kernel.org>; Fri, 01 Apr 2022 03:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=coup.net.nz; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PAU8qgu8ou6env01pX8W0JE9orawb7Vvg9zmsJIvxK8=;
        b=ba5r6mG46vaa/fbEHr8arsHSfrSbIGQIUKtQfOVgPPVpuODikRqt3yZkKZ82ujIpVF
         +NIbuMS46tdBbO0sne1NPD4Kv7SuN5Qbh6lsRsuCzDNWOw9uXZ79ZgkxTT9u8vnvy54v
         Nv5UP3SW7ZXPN4cXUf90Diqp85e4rCFfSUfG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PAU8qgu8ou6env01pX8W0JE9orawb7Vvg9zmsJIvxK8=;
        b=WeJ0nxpVwp8YPt2J2aGC4XRgSbnDvNvQtJb4Ea0mlnM4I1r0bK4BsG7q69VR5gfb65
         akimiZaV7Ppw7eMUwDwxwdINQyMKR16SOyItAkWpffTfA0/kv9i9YN46vZxGnuYV6K0G
         qTF/mAZXhCbg4ZIRDC0RQ6vMwwZ/uuyEmhDSrSbqCT/KVm3+f/mTLn97r1iegG9bKVuT
         39vIBHqPoaFb7SvKkAbQJYbGDEnAGyKEO1H0SPrByNwS2F5qUfss9r+S3ybKe4kYI0P9
         rOxscIJHtBQ3BEAlkd2m+v4eBkkn0mqM52bWkes9Oo0gewH0wx9XFEsBHRlkS4Jyqghy
         JC1w==
X-Gm-Message-State: AOAM532rr26MpvkjRtUACNe6SARoZYAbijvUx4I/EdN81to2tCOd++dx
        RALRKwGYEna/hoW1sJmuayLmzryTwj63Gdx7iwuuxg==
X-Google-Smtp-Source: ABdhPJwaaoXMEZQ7EETAkM4Ma2RhWGOgdcmi0TVAn9KfAJFLIqPMpmSJdmE13b+hSpYbPg69yY5iWXTYbkEHZSxJdbU=
X-Received: by 2002:aa7:92c8:0:b0:4fd:c1aa:3e11 with SMTP id
 k8-20020aa792c8000000b004fdc1aa3e11mr5277553pfa.29.1648809386462; Fri, 01 Apr
 2022 03:36:26 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1138.v3.git.1646406274.gitgitgadget@gmail.com>
 <pull.1138.v4.git.1648476131.gitgitgadget@gmail.com> <6c17167ac1edbeea5f6d375a989aa49f5748d099.1648476132.git.gitgitgadget@gmail.com>
 <220331.86fsmyp2o0.gmgdl@evledraar.gmail.com>
In-Reply-To: <220331.86fsmyp2o0.gmgdl@evledraar.gmail.com>
From:   Robert Coup <robert@coup.net.nz>
Date:   Fri, 1 Apr 2022 11:36:15 +0100
Message-ID: <CACf-nVcor-0hbnW-bbRTgXVYJ+Fjd5HkJam7Hh3C=47QwwO6xQ@mail.gmail.com>
Subject: Re: [PATCH v4 5/7] t5615-partial-clone: add test for fetch --refetch
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Robert Coup via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        John Cai <johncai86@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, 31 Mar 2022 at 16:22, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avara=
b@gmail.com> wrote:
>
>

> > +
> > +     git -C pc1 fetch --filter=3Dblob:limit=3D19999 --refetch origin &=
&
>
> Is 19999 just "arbitrary big number" here?

A selected big number so we can change it and have different objects match.

>
> > +     git -C pc1 rev-list --quiet --objects --missing=3Dprint \
> > +             main..origin/main >observed &&
> > +     test_line_count =3D 2 observed &&
> > +
> > +     git -c protocol.version=3D0 -C pc1 fetch --filter=3Dblob:limit=3D=
29999 \
> > +             --refetch origin &&
> > +     git -C pc1 rev-list --quiet --objects --missing=3Dprint \
> > +             main..origin/main >observed &&
> > +     test_line_count =3D 0 observed
>
> Does this test_line_count *really* want to be =3D 0, or does this mean
> test_must_be_empty?
>
> I.e. are we expecting content here, just not ending in a \n, or nothing
> at all?

I'm expecting no missing objects after a refetch with a new filter
that matches all the objects in the repo.

> > +     GIT_TRACE=3D1 git -C pc1s fetch --filter=3Dblob:limit=3D999 --ref=
etch origin &&
>
> Why the GIT_TRACE=3D1? Seems to not be used.

Ah, extraneous debugging on my part.

Thanks, Rob :)
