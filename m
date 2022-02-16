Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44FD5C433EF
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 16:55:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236740AbiBPQzN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Feb 2022 11:55:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234159AbiBPQzM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Feb 2022 11:55:12 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC7B293B7A
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 08:54:59 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id k25so668441ejp.5
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 08:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=L0OXXJ2cDgGTOiZf2s4VZ8ZnZgtJ/DQXvyJvPlgFqK4=;
        b=Zg3rXn+w/o4XhUMgRtYfXUgBTLvi0EtliQs5q0dADZelGRpik1MnVobNnRz4m74oxC
         MEUGj19D1FUh9pMs2od3UAkd9A64HmWZpvkFKwXqs8ZMOLp0xVgd+DzifMHTMV4bM7EI
         MAGzjy/UDEFir7yVp4cYz8jjcKcmuRVl4v2sgy3gsriPk3QvyQslJqlw6GqwsbUt18ug
         2UJmgRgfXGsJx9XSNCfMr5QBNM3R7oANID9vD589Vk8mqc9rnFWxtxm9Ko91oqtb1y2f
         dDQkmu3msoHztiX2AzvKRYaed9KhBNJ+vw5xmtuC24JveHk2BBpMaXAOfDrVrAATuuXn
         CN6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=L0OXXJ2cDgGTOiZf2s4VZ8ZnZgtJ/DQXvyJvPlgFqK4=;
        b=lXI3Gjsb5tpnZZYX7QrLP8Qw4Ysfs78wjfge9Yu16ARB1AgBILfMlcp7SYnG+kJfQD
         /wOQEnpVjd0sqxFVFYDOgKDt8S6/HQ3pnVs7lkEsPdFdH3Et3LtnYIt6m3cvrEyRfzSo
         qjeknSkpN+trd3n5cswaLrMbjeaymQR69xvQCyq02H+3rKPk+1T3O2PRWKSOv5Cz0OsT
         n7G3E0mpWY3TrglGcNAJ9XKsotMaNwf8c9oDNGQtzu96v0Fgfs5IZFRlVl1AwFoz9D4o
         CA4dktmBUq7xrdeHbyr0YHI1ksnyfnYYAp5bb4n1vbUUyzclzpnzRwgIXKAqP3NffR/Z
         tubg==
X-Gm-Message-State: AOAM532LgJS15zARyCByn2PepRuyyDLyTRep3n4hQgrivFH8cGeEV3RE
        xqgnVM9UqsSaga8hhW5fY7m5S0N5vQzOft9iNaQ=
X-Google-Smtp-Source: ABdhPJwHvBzcaPJhri5dN5soqIzsRSm7jP/bpnaPjkTACHrFM9DYCi9Bz4zxCdcoZNOfMfRLPFeIkeSWTo4tp0uIP/8=
X-Received: by 2002:a17:906:64e:b0:6ce:36ae:7ab5 with SMTP id
 t14-20020a170906064e00b006ce36ae7ab5mr3085694ejb.192.1645030498196; Wed, 16
 Feb 2022 08:54:58 -0800 (PST)
MIME-Version: 1.0
References: <pull.1118.v2.git.1644913943.gitgitgadget@gmail.com>
 <pull.1118.v3.git.1644985283.gitgitgadget@gmail.com> <2008542d0c718bbe43388297307a791f94bc73e1.1644985283.git.gitgitgadget@gmail.com>
 <220216.8635kjuob0.gmgdl@evledraar.gmail.com>
In-Reply-To: <220216.8635kjuob0.gmgdl@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 16 Feb 2022 08:54:46 -0800
Message-ID: <CABPp-BEBX4tWwqkG=7+rcZa_EJzOC2+Rg214av_+-yymHTQGQw@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] sparse-checkout: reject arguments in cone-mode
 that look like patterns
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Victoria Dye <vdye@github.com>,
        Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 16, 2022 at 1:57 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Wed, Feb 16 2022, Elijah Newren via GitGitGadget wrote:
>
> > From: Elijah Newren <newren@gmail.com>
> >
> > In sparse-checkout add/set under cone mode, the arguments passed are
> > supposed to be directories rather than gitignore-style patterns.
> > However, given the amount of effort spent in the manual discussing
> > patterns, it is easy for users to assume they need to pass patterns suc=
h
> > as
> >    /foo/*
> > or
> >    !/bar/*/
> > or perhaps they really do ignore the directory rule and specify a
> > random gitignore-style pattern like
> >    *.c
> >
> > To help catch such mistakes, throw an error if any of the positional
> > arguments:
> >   * starts with any of '/!'
> >   * contains any of '*\?[]'
>
> But not "\" itself, we're just escaping the "?" here?...

Nah, I just missed that one.  I should add it below.

> > +     if (core_sparse_checkout_cone) {
> > +             for (i =3D 0; i < argc; i++) {
> > +                     if (argv[i][0] =3D=3D '/')
> > +                             die(_("specify directories rather than pa=
tterns (no leading slash)"));
> > +                     if (argv[i][0] =3D=3D '!')
> > +                             die(_("specify directories rather than pa=
tterns.  If your directory starts with a '!', pass --skip-checks"));
> > +                     if (strchr(argv[i], '*') ||
> > +                         strchr(argv[i], '?') ||
> > +                         strchr(argv[i], '[') ||
> > +                         strchr(argv[i], ']'))
> > +                             die(_("specify directories rather than pa=
tterns.  If your directory really has any of '*?[]' in it, pass --skip-chec=
ks"));
>
> Isn't this nested || a reinvention of a simpler strtok() or strtok_r()
> call? I.e. (untested):
>
>         const char *p;
>         const char *wildcards =3D "*?[]";
>         if (strtok_r(argv[i], wildcards, &p))
>                 die(_("specify... has ony of '%s' in it...", wildcards));
>
> That would also allow parameterizing the set of characters for
> translators.

I considered strtok, but strtok & strtok_r are documented as modifying
their argument.  Perhaps they don't modify the argument if they don't
find any of the listed tokens, but I didn't want to rely on that since
I found no guarantees in the documentation.
