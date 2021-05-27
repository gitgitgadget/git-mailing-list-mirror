Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4334BC4707F
	for <git@archiver.kernel.org>; Thu, 27 May 2021 03:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B96B6100C
	for <git@archiver.kernel.org>; Thu, 27 May 2021 03:11:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234448AbhE0DNO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 May 2021 23:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232725AbhE0DNN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 May 2021 23:13:13 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A8EC061574
        for <git@vger.kernel.org>; Wed, 26 May 2021 20:11:40 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id e10so3486286ybb.7
        for <git@vger.kernel.org>; Wed, 26 May 2021 20:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vCddBsBVdRXYrG8NnhSBXbezLqJp1F8W7kz4rIGplj0=;
        b=XF//XDdb3gJunf9G5IRYGy9rnsRXGR3f6WFKgEXAJs+LCtlQDJIgIS113ZV8GIrQwI
         6j6SCu2chTENpJNcY2IHQ3LzUqw7ItmcuOb7q9/cRP1BoEHqjnf8sPUc5gZf5JsF9AZC
         ynvchwNS5dft/cc1feTmKOTdAWeOC+V+bZSx2hCrdCCWr0RCcqPtA6USU8Jxr1Nesvo9
         6bts9xpdjGL+QsASDIP2+rEVeXSOlP5pFQeys2UhMgzpTR1sz+9KyqlDYxOgyxApRsiJ
         ghnYAdvV/ZZlBcaZxu84bSpq3A4QrzQbHdKYPPm/NJUERjTMjPwO+tkljF4h+cj544uq
         l4BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vCddBsBVdRXYrG8NnhSBXbezLqJp1F8W7kz4rIGplj0=;
        b=j+L/1LIWxs3ZWM4xIKaFVYbBJ4TpLHb9JxjBRmlhXveCNeLl73JQsIFfBfO8dDo7jy
         InKwyTjxX9Ab+uzMG0a95BqWoRqS0Qy3bDNm90/ajqon0M/I+Jr0SYT2W/PgS0KGJ9eu
         tOlUIBhuhwLZqDRsU5yEpv7faLljU6PoMb8P/+hjLIJ3UxPt+pNwlTgMB3p1LROeOADG
         h7sf2HmrDiXXZsMNwcwryHUULtBVBM4znGke8btFJvJAVDEOrX13NmoGbVbt1XAkdWa+
         ArdqxbfoYnhbYnfLIjIEZkR0rg8+DC46nhYp3IMT47kEy/LgmzmvXt70H1F5+WA/XN1V
         U5Xg==
X-Gm-Message-State: AOAM532kD8LD2TDtYYQCpmhkldzmI/HoRRz0cKcGLdqjj9OIxSHiXh+u
        gFNYZbbQciuNiZ1hLLAZG2lGhq7L5tjmeEB+Ib0=
X-Google-Smtp-Source: ABdhPJyAnvpodDLYlVTTfdPdnuw/mDHew86KXqVn6niN4a+7rbUpte2sMhNmEL+m3Zrr3fXuAjEWWem+i36e88EeUdU=
X-Received: by 2002:a25:c012:: with SMTP id c18mr1665007ybf.41.1622085099480;
 Wed, 26 May 2021 20:11:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210311125511.51152-1-bagasdotme@gmail.com> <20210311125511.51152-2-bagasdotme@gmail.com>
 <CANYiYbH_U=3gN+LH7e-LBdRdcE0geAuUzoBX4O09qego0xKX-Q@mail.gmail.com>
 <xmqqa6r8c3i0.fsf@gitster.g> <2600d078-9ba0-2ebc-4611-c414ef8b12dd@gmail.com> <CANYiYbEVyUc6gsjb4=+8x8m64zpkTo4vYSLAB+au-Rz5xsEVaA@mail.gmail.com>
In-Reply-To: <CANYiYbEVyUc6gsjb4=+8x8m64zpkTo4vYSLAB+au-Rz5xsEVaA@mail.gmail.com>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Thu, 27 May 2021 11:11:28 +0800
Message-ID: <CANYiYbE5re95ovud4-37QVp+cmBnS0kYksM0TeCcuAX0wv+qbA@mail.gmail.com>
Subject: Re: [PATCH 1/3] po/README: document PO helper
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        =?UTF-8?Q?Matthias_R=C3=BCster?= <matthias.ruester@gmail.com>,
        Jimmy Angelakos <vyruss@hellug.gr>,
        =?UTF-8?Q?Christopher_D=C3=ADaz?= <christopher.diaz.riv@gmail.com>,
        =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Gwan-gyeong Mun <elongbug@gmail.com>, Arusekk <arek_koz@o2.pl>,
        Daniel Santos <hello@brighterdan.com>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        Emir SARI <bitigchi@me.com>,
        =?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
        Yi-Jyun Pan <pan93412@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> =E4=BA=8E2021=E5=B9=B45=E6=9C=8813=E6=
=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=8811:40=E5=86=99=E9=81=93=EF=BC=9A
>
> Bagas Sanjaya <bagasdotme@gmail.com> =E4=BA=8E2021=E5=B9=B43=E6=9C=8812=
=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=887:57=E5=86=99=E9=81=93=EF=BC=
=9A
> >
> >
> > On 12/03/21 13.03, Junio C Hamano wrote:
> > > Jiang Xin <worldhello.net@gmail.com> writes:
> > >
> > >> Bagas Sanjaya <bagasdotme@gmail.com> =E4=BA=8E2021=E5=B9=B43=E6=9C=
=8811=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=888:56=E5=86=99=E9=81=93=
=EF=BC=9A
> > >>>
> > >>> Document about PO helper script (po-helper.sh). It covers about
> > >>> installing the script and short usage examples.
> > >>>
> > >>> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> > >>> ---
> > >>>   po/README | 22 ++++++++++++++++++++++
> > >>>   1 file changed, 22 insertions(+)
> > >>>
> > >>> diff --git a/po/README b/po/README
> > >>> index efd5baaf1d..9beffc2954 100644
> > >>> --- a/po/README
> > >>> +++ b/po/README
> > >>> @@ -286,3 +286,25 @@ Testing marked strings
> > >>>
> > >>>   Git's tests are run under LANG=3DC LC_ALL=3DC. So the tests do no=
t need be
> > >>>   changed to account for translations as they're added.
> > >>> +
> > >>> +
> > >>> +PO Helper
> > >>> +---------
> > >>> +
> > >>> +To make maintaining XX.po file easier, the l10n coordinator create=
d
> > >>> +po-helper.sh script. It is wrapper to gettext suite, specifically
> > >>
> > >> It's better to rename the script to other name without the suffix
> > >> ".sh", so we can reimplement it in other programming language. Maybe
> > >> we can rename it to `git-po-helper`, and host this helper in a
> > >> separate project on GitHub.
> > >
> > > It might be a good move in the longer term, but if the po-helper.sh
> > > is working well enough to fill the need of i18n/l10n team right now,
> > > I think documenting the status quo would be a good way to help the
> > > contributors immediately.
> > >
> > > And when we reimplement it (if that is desirable---I have no opinion
> > > myself), we certainly would want to update this part of the doc to
> > > use the name of the rewritten tool.
> > >
> > > In any case, I expect that you to be the main reviewer on this topic
> > > and you will feed me the final commits, just like any other change
> > > in the po/* area via a pull request.  In other words, I may have
> > > input to the discussion on list, but I won't be applying the result
> > > myself---I'll be pulling from git://github.com/git-l10n/git-po.git
> > > repository instead.
> > >
> > > Thanks.
> > >
> >
> > Grazie Junio. However, I'm more of writing documentation rather than
> > contributing code, so I will help for the documentation and usage
> > testing. But anyways, we can ask for help from other l10n contributors
> > who are more proficient at coding.
> >
> Hi Bagas,
>
> I created a new repository at
> https://github.com/git-l10n/git-po-helper that contains a new helper
> program `git-po-helper` to replace the obsolete `po-helper.sh` script.
>
> The new `git-po-helper` program can check character encoding of the
> commit log, check author/committer datetime, and check format of
> `po/TEAMS`, etc., in addition to the conventions listed in README of
> the new project "git-l10n/git-po-helper".
>
> You can update your patches according to this change.
>
> All l10n contributors can use this new helper to check their l10n contrib=
utions.
>
> BTW, with the help of Daniel, a google group named git-l10n is created
> for discussion on git-l10n. This mail is also cc to this email
> address: git-l10n@googlegroups.com .

Based on pull request form Bagas, that made some nice changes for
"po/README", I recreated a new pull request #525 on GitHub:

    https://github.com/git-l10n/git-po/pull/525

Please help to review.  This pull request contains the following commits:

 + 826abe532f l10n: README: note on fuzzy translations
 + 93f2050952 l10n: README: document l10n conventions
 + 1466dc3b86 l10n: README: document "core translation"
 + 06d662e594 l10n: README: document git-po-helper
 + a5724c83a2 l10n: README: add file extention ".md"

You can download the commits using command:

    git fetch https://github.com/git-l10n/git-po refs/pull/525/head

--
Jiang Xin
