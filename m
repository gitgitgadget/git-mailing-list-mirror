Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67279C433E6
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 09:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1755565279
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 09:36:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbhCIJfr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Mar 2021 04:35:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbhCIJfg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Mar 2021 04:35:36 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04BD4C06174A
        for <git@vger.kernel.org>; Tue,  9 Mar 2021 01:35:36 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id f33so12160469otf.11
        for <git@vger.kernel.org>; Tue, 09 Mar 2021 01:35:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+VaSZrjzaIrm1J7QSjdlPGuQnQY1XpIDPsUx65j+1hQ=;
        b=rkHDkypcEp8+C2H8pQQfYUZz/n9fl9Lew6A0HbOApT4hry6GwjMjeC7qU9PORyijZh
         E1QgwAU3+qiRDyDHdexDxDBd8wJJ/hgpzlbCyfmdDNV5sSHedD6tUR/rbhEu2gbAnqeM
         v77lnUM/H94hWNQJpXgpa3gMLSkXEErhGQpNmPYu2ecHM76xxEMBooo89krbxHmFNbnS
         eF3eSgWHqi8Iw04TYv15gb6pE6qmhN0P67JCUZ/bY11CZGOL0a9Y+QVXNTysQGBMHFJL
         qIW75RKssMrRpDIdh3yAN9DmfQUY+rGvdtXYLeytvNbQN70eytUNeYgSRWWijckFKOhj
         QWeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+VaSZrjzaIrm1J7QSjdlPGuQnQY1XpIDPsUx65j+1hQ=;
        b=GcNNUj+V1hUsntGsRgDmXL2oyCF0p44EPbfeGusHPG818kuDnaFjtSkHLV9eVsaquu
         RU14MxqO+5ax6BR+c8fOvzE6NgFhC/+ydEUOD1rphftQirvphwsSCfTC+Eshz9jC/QpY
         A5BKHoGMh0dOEfDNpc7S/VWjon6uzlT78eqhi7LIURdc+QisQ3GGhiV+P4PLvMNguKXy
         Cvrz+7it7MDMRqt4TYo5eU5Sy8VowP/u+MdHZ/BOrD31kYpS3jiwCbF+LEgaJVxSz7x4
         72xb3Qx0p7TO1JpwKPfgqGpX92DKGYYwdtkxDx6qYOaMLKiR22+6pqjuNfWcWfDJ19iZ
         QzcQ==
X-Gm-Message-State: AOAM530Vvu7HVxLv5QZzmfzftp2njkKhVJBlDIApcDZnmsoiZtHQn1sd
        t1Loh8uOKjWlBEZkPqMJUn02L9uzPSNrJ0Sk+v4=
X-Google-Smtp-Source: ABdhPJwo32f1ELrPYZHcbEv0EXBxp6W60/B5NFc38u8rxHqYxaox+7/TP4ZldoCX4HIUK133I/iVwDV0K9std3cjUpQ=
X-Received: by 2002:a9d:6308:: with SMTP id q8mr22462904otk.160.1615282535448;
 Tue, 09 Mar 2021 01:35:35 -0800 (PST)
MIME-Version: 1.0
References: <pull.898.git.1615100240295.gitgitgadget@gmail.com>
 <pull.898.v2.git.1615278830804.gitgitgadget@gmail.com> <CAPig+cQ6oS8S1-AmRhM=Gb3EQ+7sdQxExoVPCoHKSRFivZq9Vw@mail.gmail.com>
In-Reply-To: <CAPig+cQ6oS8S1-AmRhM=Gb3EQ+7sdQxExoVPCoHKSRFivZq9Vw@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Tue, 9 Mar 2021 17:35:23 +0800
Message-ID: <CAOLTT8SDs76dCdXi1rn_QVi924V7C5S4sLt8-EA1hFKPrFZKQQ@mail.gmail.com>
Subject: Re: [PATCH v2] [GSOC][RFC] format-patch: pass --left-only to range-diff
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Denton Liu <liu.denton@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Taylor Blau <ttaylorr@github.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> =E4=BA=8E2021=E5=B9=B43=E6=9C=889=
=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=885:00=E5=86=99=E9=81=93=EF=BC=
=9A
>
> On Tue, Mar 9, 2021 at 3:35 AM ZheNing Hu via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> > In https://lore.kernel.org/git/YBx5rmVsg1LJhSKN@nand.local/,
> > Taylor Blau proposing `git format-patch --cover-letter
> > --range-diff` may mistakenly place upstream commit in the
> > range-diff output. Teach `format-patch` pass `--left-only`
> > to range-diff,can avoid this kind of mistake.
> >
> > Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> > ---
> > diff --git a/builtin/log.c b/builtin/log.c
> > @@ -2085,9 +2089,12 @@ int cmd_format_patch(int argc, const char **argv=
, const char *prefix)
> >         if (creation_factor < 0)
> >                 creation_factor =3D RANGE_DIFF_CREATION_FACTOR_DEFAULT;
> > -       else if (!rdiff_prev)
> > -               die(_("--creation-factor requires --range-diff"));
> > -
> > +       else if (!rdiff_prev) {
> > +               if (creation_factor >=3D 0)
> > +                       die(_("--creation-factor requires --range-diff"=
));
> > +               if (left_only)
> > +                       die(_("--left-only requires --range-diff"));
> > +       }
>
> This logic starts getting difficult to reason about. It would be
> easier to understand if written like this:
>
>     if (!rdiff_prev) {
>         if (creation_factor >=3D 0)
>             die(_("--creation-factor requires --range-diff"));
>         if (left_only)
>             die(_("--left-only requires --range-diff"));
>     }
>
>     if (creation_factor < 0)
>         creation_factor =3D RANGE_DIFF_..._DEFAULT;
>
> or this (which reduces the indentation a bit):
>
>     if (creation_factor >=3D 0 && !rdiff_prev)
>         die(_("--creation-factor requires --range-diff"));
>     if (left_only && !rdiff_prev)
>         die(_("--left-only requires --range-diff"));
>
>     if (creation_factor < 0)
>         creation_factor =3D RANGE_DIFF_..._DEFAULT;
>
Emm,I would prefer to use the above.
> Subjective; not necessarily worth a re-roll.
>
> > @@ -2134,7 +2141,8 @@ int cmd_format_patch(int argc, const char **argv,=
 const char *prefix)
> >                 make_cover_letter(&rev, !!output_directory,
> > -                                 origin, nr, list, branch_name, quiet)=
;
> > +                                 origin, nr, list, branch_name, quiet,
> > +                                       left_only);
>
> Nit: This indentation looks odd. One would expect `origin` and
> `left_only` to have the same indentation.
>
> > diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
> > @@ -748,4 +748,32 @@ test_expect_success '--left-only/--right-only' '
> > +test_expect_success 'format-patch --range-diff --left-only' '
> > +       rm -fr repo &&
> > +       git init repo &&
> > +       ...
> > +       ! grep  "> 1: .* feature$"  0000-cover-letter.patch
> > +'
> > +
> > +
> >  test_done
>
> Nit: One blank line before test_done() is typical, not two.

Thanks for the reminder.
I'm going to modify these format errors.
