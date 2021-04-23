Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0DF4C433B4
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 10:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 764DF6113D
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 10:22:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbhDWKWx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Apr 2021 06:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbhDWKWx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Apr 2021 06:22:53 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14648C061574
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 03:22:17 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id d25so17751579vsp.1
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 03:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JYEVt70hZo5/h+6y5d1l/1ySnx0W1k8E9KJ0R48NzZA=;
        b=hWnqP8euSvyJ3ibT0+bSizt2bbXLUQpfKFJBLq5lffNxRy42HeLRt1V2EmVXegxcYV
         p7cXoC8y3YDe+W6DEuAV8ee/fO7yN3SjJv1uBuZJeaGP0ohLD+GWva/7RltBq6CLa2m2
         Tn58fasHtxu1qxNDRwOtIsB0TIfDEdXKntUTT83qjT/9D1wXJY1oRTLDnno842uXPyep
         bGQtqpN/Pi6qqOjrzGkp8TUgp8vUloME5ccLZXXR+6ENLl3H4FR0OW0dmfWfO/hotQpR
         UrPoH6hShX1p+4TQi0EjE3neD7MVs245YCsrnOoP0woeYL6mYOFZdLNe1M1GPrwcNJZX
         fGbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JYEVt70hZo5/h+6y5d1l/1ySnx0W1k8E9KJ0R48NzZA=;
        b=AukcpO03EzP6oVZ8BEd71lEzyaVrtUC428Yp9LVdNc0wMTGnsGSlMe8wmJgk0H5MlF
         vHrMjClyTseTEGTkBoOztPu9laPEXgCOnnAthEPDuw+D7EO6z+7K8vdgBDx4v95bumdI
         VRsaSofMBLWHPkNYmmgJKsFT6W9RvZAtUUi16MCFN3N/LNsb69D31oqx7KwaQmKb0Y7t
         0elN0/ooiRpvfbTuzPt5Qgv3r+mAMk3/o2v03WV2IRu1EV5CvxGeNXDrCusERMOiwX+E
         zRio4b+HVQsvGpKcR2TaQbh33f8X8URrETVptGMUzESz88PN8tnKl+QXvRrNwbT50GbJ
         nCag==
X-Gm-Message-State: AOAM533UPuNH0swY1ZAmv+br18WVggCuwkrmSVZwWDhm5Gm2i5FQCU0K
        H8OTJW5r7NiunX2BkUQDCNt/JTgC5gSv0nHf0iw+Rg==
X-Google-Smtp-Source: ABdhPJxpSheOetnadv/tkZOQgAoS0f2QTlaytAct8kiYO4yRTFoFPc7oyjBiL1mpVTdI9/FTYOJ3CyNge9FIPIiMCI0=
X-Received: by 2002:a67:eb45:: with SMTP id x5mr2734890vso.28.1619173335946;
 Fri, 23 Apr 2021 03:22:15 -0700 (PDT)
MIME-Version: 1.0
References: <pull.847.v3.git.git.1606419752.gitgitgadget@gmail.com>
 <pull.847.v4.git.git.1607522429.gitgitgadget@gmail.com> <d57023d9f13d178dc95d7a74751923b80d1a5939.1607522429.git.gitgitgadget@gmail.com>
 <871ree8eto.fsf@evledraar.gmail.com>
In-Reply-To: <871ree8eto.fsf@evledraar.gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Fri, 23 Apr 2021 12:22:04 +0200
Message-ID: <CAFQ2z_Pco4KhhE7S_8zBZ7hCwOH=DnxHoKE8zus7REdQaXCZiQ@mail.gmail.com>
Subject: Re: [PATCH v4 13/15] Reftable support for git-core
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Patrick Steinhardt <ps@pks.im>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 21, 2021 at 4:55 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> I've been chasing down some edge cases in refs.c as part of another WIP
> series I have and found that for this particular "errno" stuff we don't
> have any test coverage. And with master & hanwen/reftable if I apply:
>
>     -                       errno =3D EINVAL;
..
> All tests pass on both.
..
> That I can remove error checking/handling from this place means existing
> general logic was faithfully copied without checking that we have a test
> for it, or adding one.

I think that is an unfair characterization. The API documentation of
read_raw_ref_fn says that implementations should return EINVAL for
certain cases, so that's what I did. The point of having a documented
internal API is that one doesn't have to double check what is behind
the API.

--
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
