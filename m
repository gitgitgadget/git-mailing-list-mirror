Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF22DC47082
	for <git@archiver.kernel.org>; Mon, 31 May 2021 15:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA6DE60FDA
	for <git@archiver.kernel.org>; Mon, 31 May 2021 15:11:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234030AbhEaPMq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 11:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234594AbhEaPKl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 11:10:41 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02CDBC08C5F9
        for <git@vger.kernel.org>; Mon, 31 May 2021 07:09:01 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id u188so6074541vsu.8
        for <git@vger.kernel.org>; Mon, 31 May 2021 07:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=w1L7h2JQlWQ5XmYJuzogTVgcQjFkOTBxzhcfPhxRDAM=;
        b=SK/pkkLb6kg8UuDN6SRxEsXMMQ+CqoAO3OzaETq4ydEeQBdUV3CQ7y0ZWt9bmsv+Zg
         X9nDN94i8wdAIA58nlxnle/ZI3FnolhLhBiUqjlkNdgJFxLffEe1DFEvvBa1Skug+udf
         q9wHpe1v2mjLdL8P0g/HwhxcwPVHl756DU7X0eMS82wPIuvBcuR0AKHbBsDgHKW57ygy
         3nWuu0yNeoHCuRAjxM7UlEZdkzI3An5a+aU6FFGJOZS8uRw1u7rRDe+wO6MPDxNWxF1J
         ralYb5dqw3om2L8NjKQqKmC3OTW6i7Ev9ip43xPYfNeGUu5ZxBuDwnE5XJkjuEi6tXiL
         k7+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=w1L7h2JQlWQ5XmYJuzogTVgcQjFkOTBxzhcfPhxRDAM=;
        b=Wa7KDpNVGTZZejo4X9pUCusGx9jq7xRRwHptVLTjTw2sUyokROaqnhEEFjF+FFF6T7
         w4jIZI4Xyn6N5lHeIh/X4WKPldE7UBgefRY5S3cjbmENXvnYN/w/HToYRxaBiGXhAslP
         fuUB2wgI3ND7OGigjTenSRcFj0TLOsJwHautb7Lv0Zs3cy8AD3PCBLkKoWlFcTvylYkH
         4pNYMr7jphrC3p0AZtcZ3oXO7yEqKsPHuk+RwIK9vAfUVrAoKXB5TbZXcz7yKSSeURZs
         f/fpSxw9c/Y8I9+PzVhZ8ccJaj7AeQjWVIMpEjiOqmwLlwWFPVJMoS6IcYH9mljtvfbT
         FRig==
X-Gm-Message-State: AOAM5325bMTsEVEfl5XhoQq3dkkQcZsoC3mELnYf5w64ecqijIwNtEgW
        LGlTQwc90++vVvDuq6DEJIKiiAqbQF0IcoTc7MCAYg==
X-Google-Smtp-Source: ABdhPJyvcyDX3hNHv5WpVMKl3sKzQgCIE6s9lkvFdnQ/MAD+Bu5rOmyyGsj3m2np+Dz5YGOEspxemEx7N1qUEkQfU3Y=
X-Received: by 2002:a67:62c6:: with SMTP id w189mr13851010vsb.12.1622470140026;
 Mon, 31 May 2021 07:09:00 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
 <pull.1008.v2.git.git.1619519903.gitgitgadget@gmail.com> <ff3b67c84c412dafaa506355e83427a731b47623.1619519903.git.gitgitgadget@gmail.com>
 <87k0ntpg48.fsf@evledraar.gmail.com>
In-Reply-To: <87k0ntpg48.fsf@evledraar.gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Mon, 31 May 2021 16:08:49 +0200
Message-ID: <CAFQ2z_N05LyFkpURwyEe1b-ju09zEzZL=kx-kfbPCgqEDL2tkg@mail.gmail.com>
Subject: Re: [PATCH v2 18/21] t7900: mark pack-refs tests as REFFILES
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 20, 2021 at 5:41 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> > -test_expect_success 'pack-refs task' '
> > +test_expect_success REFFILES 'pack-refs task' '
> >       for n in $(test_seq 1 5)
> >       do
> >               git branch -f to-pack/$n HEAD || return 1
>
> I don't think it's superfluous to test what "git maintenance" does
> anyway, i.e. the test ends with:
>
>     test_subcommand git pack-refs --all --prune
>
> Shouldn't we test that we .. don't run that, abort, warn, whatever?

Sure. I've removed the check on the side effect for pack-refs instead.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
