Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63E37C4338F
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 04:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D79060F92
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 04:42:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbhHIEm4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Aug 2021 00:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbhHIEm4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Aug 2021 00:42:56 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04ADBC06175F
        for <git@vger.kernel.org>; Sun,  8 Aug 2021 21:42:33 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id j77so27241663ybj.3
        for <git@vger.kernel.org>; Sun, 08 Aug 2021 21:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8oyyTbmY6dCX8YSUEARMNVTEm/t4q57CEJyJPRQRk/o=;
        b=YUttS3G561mBDdUJcH3kpmvpQIb0w2dVTXi95egJ9lVdtieYzKWMA8gBba2ubSCuZc
         aPbCsd0enYne5+0dp3Bxh/3AtYHgBfsSJLN04oh/I8Ir+Z505vw1csUheEuDMqnYUztq
         rx8J+x6kqIdqDz/qZ2a09jmmlJRanUWwgeKONh1ZKs8eqZTjMq1da0JGrmvG6yP69wBB
         DxPlJQyvPzZgjSW3XHCjUmR5+MTb9rsIjgkedPccZ+oFdLH28QvpCitwMsG9JVjYsm6V
         odC2MXm+LISFisI9YBjHZfk1/MNwPVTAs3zdOeALKFEv2vOgN/jeDat7Acj9OuoqnwOy
         C0xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8oyyTbmY6dCX8YSUEARMNVTEm/t4q57CEJyJPRQRk/o=;
        b=tyvNxAElz2cL4WvcJqF7PQXt8wy4iiCMVidTkWsFiGNtNq1vX+rzY1CoouV4WiDWCu
         Jr45c4WnQjcCiKI1VAxoLm7Um5aRVvVhmC3fpfGY2FuslGlqnj3FtjMGo6W3lXygiRS2
         LAzMY3Wi2Dy6jtLLWE6u/Qgmh17xgCKzq2v/dqWjI4hJyvyzxPzYpkYsCOsxHwKjBfyn
         IVWMPSZ/0660JRcQAerYgTcPQnH5H5dNk46oWvuVrPkwU6pEelugkW7+tX0MaWSR2KZW
         yD8C58f/OiuZ19WPr7LbcncQ6dvB31lrt3/DBFmP8Hja0vrPGwkG/cjmBzCVNcnQCiVO
         RKfw==
X-Gm-Message-State: AOAM530t+u5P9LtGEcEJmpYKhCdqRj/HQmn4+wlyvMg7izR33bFwC9Gi
        N4/6HiQvyMySbxVmir22O0asXWPe988RTmN1Z5c=
X-Google-Smtp-Source: ABdhPJw7G64ASHKGegzYx/MHP+/e2T0gLjB4awD5sCxV5LeG+M4LnaicDhNNh1/h1dMQ4+wIJQjz+a/FPR8jOUHrEvw=
X-Received: by 2002:a25:a20a:: with SMTP id b10mr28943170ybi.478.1628484151946;
 Sun, 08 Aug 2021 21:42:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAMMLpeR8C_gjZ0CE8-nEo7syt=t0MwMGVKw8BL0k_BTpsk2D5Q@mail.gmail.com>
 <CAPUEspik6iGd2X5tOCwvo+FNmcoipy1KGvfgNJd2KLu9-XS7Yw@mail.gmail.com>
 <CAMMLpeRDLxRfskKV0+S2CHTNVTnFgfO1K_sGQy_v6DXrA5JGcQ@mail.gmail.com>
 <CAHCo6sqi0WmxxKMU=Nx=z_3PDx84YmUOa+ACRcBbM=R_nr4nrg@mail.gmail.com> <CAMMLpeQmbT-YmK3RrhPwe1bs8KNkEztony0QtbzoSbgNYjH3zA@mail.gmail.com>
In-Reply-To: <CAMMLpeQmbT-YmK3RrhPwe1bs8KNkEztony0QtbzoSbgNYjH3zA@mail.gmail.com>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Mon, 9 Aug 2021 12:42:20 +0800
Message-ID: <CANYiYbGWc7_e+9FLX0_JnLfp2652TrK12gg6hQXc2eyB7KEnpg@mail.gmail.com>
Subject: Re: Problems with Git's Spanish translation
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     =?UTF-8?Q?Christopher_D=C3=ADaz_Riveros?= 
        <christopher.diaz.riv@gmail.com>, Carlo Arenas <carenas@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Git l10n discussion group <git-l10n@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Henrie <alexhenrie24@gmail.com> =E4=BA=8E2021=E5=B9=B48=E6=9C=888=E6=
=97=A5=E5=91=A8=E6=97=A5 =E4=B8=8A=E5=8D=8812:00=E5=86=99=E9=81=93=EF=BC=9A
>
> You can reduce the displayed diff on GitHub in an instant by
> fast-forwarding <https://github.com/ChrisADR/git-po> to
> <https://github.com/git-l10n/git-po>.

By using a specific diff driver, diff of your patch may be reduced
from 5k to 1k lines. You can define custom diff driver by adding new
git config and setting attributes for ".po" files.  See files in:

    https://github.com/git-l10n/git-po-helper/tree/master/contrib/diff-dirv=
er

> > Sometimes the commiter adds extra changes trying to fix "Spanish correc=
tness" according to their country... Which makes the diffs bigger and harde=
r to read... And those same correctness changes are then "fixed" in another=
 commit by another person...
>
> In my opinion, the "generic" Spanish translation (which is the only
> Spanish translation we have at the moment) should avoid using words
> that can have different meanings in different countries. If I've made
> changes that seem to just change from one dialect to another, this is
> why. And if you want me to drop any of the changes, just note them on
> GitHub and I will. Right now I'm just trying to fix things that are
> not controversial.

Some languages have variants, such as "po/zh_CN.po" and "po/zh_TW.po"
for Chinese language.  I wonder "po/es.po" should be rename as
"po/es_ES.po" like "po/pt_PT.po", so that language variants for Latin
American can use their own po files.

--
Jiang Xin
