Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40797C07E97
	for <git@archiver.kernel.org>; Sat,  3 Jul 2021 13:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14DDD61938
	for <git@archiver.kernel.org>; Sat,  3 Jul 2021 13:54:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbhGCN5T (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 3 Jul 2021 09:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbhGCN5T (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Jul 2021 09:57:19 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD87C061762
        for <git@vger.kernel.org>; Sat,  3 Jul 2021 06:54:45 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id o139so21158643ybg.9
        for <git@vger.kernel.org>; Sat, 03 Jul 2021 06:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Nw2CPhpNSpL6T5Y8/FrBFSvifbH+8WI/DmmMOviIAMw=;
        b=UqInX2fR0+ffnzjTUGE4LkVOZTQKPIYLZEBGKTRHZys4xpt45e57b4ejx38rwP0/QQ
         pIw9p80Hy6lScwkuKcdeRnCKvsAmH8+dNCqirDvUcSwiC8LIaAKFKGXUbYoHgYHoaR1J
         TM8xHx7Si0O45fpM/lJf6ZX/SRsaoeSqddPG96MsQExua41ACbCzBNSauAppoBjBAIOF
         JaAc078pXdAsvrUf0vZ+0CBNsCtvyL9AIoNBC8cZGpaqOPLPpXxLhbWiRMyQjQvwBurT
         G7QB0xZThgfYIQaQ+WSqomCYLuEbl9/0m6vWwwrneSvsKsrlDgZTGukU6DokMG1XHwWF
         WiSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Nw2CPhpNSpL6T5Y8/FrBFSvifbH+8WI/DmmMOviIAMw=;
        b=TU4dKLB3Q2J5WNn7rbdPM8qPvmbtn3I5AtXR8WPEMfvEfXCLsDwJmd+WRz4SR0K67U
         sHShqf7mJfE2xTBigGUUK7HM0d6nSHoanlgE/mvk9dzbKrVALVu6ft6NssruC1c9R8JA
         GmYlDxBUCPUsbjZTFdf7Wmt9uYWYkX3V3zUtZteTlQhD2vcGDUV0qYNXNBNFW/Y2KCeI
         b7qCLMWDxMgKtas+kkVw6ktjtChYxw68EHIJH/lptxSGxDk11q1aK2HJQDlqLSDadT+7
         eZ9hRfpv8HjJ0pcg40UJJ0TXa05xTOyvQy646Hla8WbZ/RKmfkT+3MwKBuDiphcHPOGr
         6lBg==
X-Gm-Message-State: AOAM530cOE6SD7fC7/fWAo+e9cWdPtuaQf32KwZHCrB17k/wz+Ups41X
        vbjovtVJ2Hxhv0ZZWmAm0Of9ngk1IRDvVUH73lY=
X-Google-Smtp-Source: ABdhPJylVIvrmMejIjFxu2yRnr7dAOCiqV/9LLYJjv9HjSUWq5D+jCPZ7twwXfBmzby1P6JK1Idk99j4vAEzEBeY1RA=
X-Received: by 2002:a25:1455:: with SMTP id 82mr5786927ybu.403.1625320484453;
 Sat, 03 Jul 2021 06:54:44 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.21.2106212034050.12899@perkele.intern.softwolves.pp.se>
 <20210703111837.14894-1-worldhello.net@gmail.com>
In-Reply-To: <20210703111837.14894-1-worldhello.net@gmail.com>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Sat, 3 Jul 2021 21:54:33 +0800
Message-ID: <CANYiYbHGpy24CYOdqArAZOWsYMUF7SPXEq4Rn-bKN_wP5ne5Sg@mail.gmail.com>
Subject: Re: [L10N] fixed mismatched variable names
To:     Peter Krefting <peter@softwolves.pp.se>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Jordi Mas <jmas@softcatala.org>,
        =?UTF-8?Q?Matthias_R=C3=BCster?= <matthias.ruester@gmail.com>,
        =?UTF-8?Q?Christopher_D=C3=ADaz?= <christopher.diaz.riv@gmail.com>,
        =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Gwan-gyeong Mun <elongbug@gmail.com>,
        Daniel Santos <hello@brighterdan.com>,
        Emir SARI <bitigchi@me.com>,
        =?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
        Yi-Jyun Pan <pan93412@gmail.com>,
        Alexander Shopov <ash@kambanaria.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Jimmy Angelakos <vyruss@hellug.gr>,
        Arusekk <arek_koz@o2.pl>, Dimitriy Ryazantcev <DJm00n@mail.ru>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> =E4=BA=8E2021=E5=B9=B47=E6=9C=883=E6=
=97=A5=E5=91=A8=E5=85=AD =E4=B8=8B=E5=8D=887:19=E5=86=99=E9=81=93=EF=BC=9A
>
> From: Peter Krefting <peter@softwolves.pp.se>
>
> On Tue, Jun 22 2021, Peter Krefting wrote:
>
> > Andrei also pointed out another typo in the Swedish translation, where
> > a configuration option had been copied incorrectly. Could you please
> > amend your patch to contain both these changes?
> >
> > ... ...
> >
> > @@ -2734,7 +2734,7 @@ msgstr "Felaktigt %s: \"%s\""
> >   #: config.c:2512
> >   #, c-format
> >   msgid "splitIndex.maxPercentChange value '%d' should be between 0 and=
 100"
> > -msgstr "v=C3=A4rdet \"%d\" f=C3=B6r splitIndex.maxPercentage borde var=
a mellan 0 och 100"
> > +msgstr "v=C3=A4rdet \"%d\" f=C3=B6r splitIndex.maxPercentChange borde =
vara mellan 0 och 100"
> >
> >   #: config.c:2558
> >   #, c-format
>
> There are definitely more typos like this! In order to find mismatched
> git config variables and other mismatched variable names in the po file,
> I implemented a checker for such typos in the "git-po-helper" in commit:
>
>  * https://github.com/git-l10n/git-po-helper/commit/e44df847abb9122777156=
0aca56719031f280068
>
> To find typos, run:
>
>     git-po-helper check-po XX.po
>
> All easy-to-fix typos can be fixed using the following patch, but there
> are still some typos need to be fixed by l10n team leaders for the
> following languages:
>
>  + bg.po
>  + id.po
>  + tr.po
>

More typos will be fixed in pull request:
https://github.com/git-l10n/git-po/pull/534
