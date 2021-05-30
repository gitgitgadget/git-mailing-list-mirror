Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0950C47089
	for <git@archiver.kernel.org>; Sun, 30 May 2021 06:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73F81610A6
	for <git@archiver.kernel.org>; Sun, 30 May 2021 06:40:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbhE3Gln (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 May 2021 02:41:43 -0400
Received: from 82-64-198-250.subs.proxad.net ([82.64.198.250]:50606 "EHLO
        mail.lhuard.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229495AbhE3Glm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 May 2021 02:41:42 -0400
Received: from coruscant.lhuard.fr (unknown [IPv6:2a01:e0a:465:5440:31e0:10c6:a1ef:e5f9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.lhuard.fr (Postfix) with ESMTPSA id 39E2147BB13;
        Sun, 30 May 2021 08:40:01 +0200 (CEST)
Authentication-Results: mail.lhuard.fr; dmarc=fail (p=quarantine dis=none) header.from=lhuard.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lhuard.fr; s=rpi3;
        t=1622356801; bh=PYPbd6E1yP8mCz7dazhM9/IyF/O85C5Mh9NE4yrPstM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=1TH01NfN2mvtNNuLwc52Blq0JEsBhu9+sPx6WQpIGFPpgsgwwDDIrFUTQViFwG/A0
         nksIxYepyBg6C4d2EQm1548KI0qk9mSvL5Y0/V85UJFI/oejtnBy3LPFU+jefjdEi4
         TsoNucVoosEp/SPmCTLrINEumqhUFBoN18oq4d88=
From:   =?ISO-8859-1?Q?L=E9na=EFc?= Huard <lenaic@lhuard.fr>
To:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Martin =?ISO-8859-1?Q?=C5gren?= <martin.agren@gmail.com>,
        =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v4 3/4] maintenance: `git maintenance run` learned `--scheduler=<scheduler>`
Date:   Sun, 30 May 2021 08:39:48 +0200
Message-ID: <2953592.SyOBHIlnlS@coruscant.lhuard.fr>
In-Reply-To: <ce0e096d-cd82-800a-9ef5-5bcc4b25046d@gmail.com>
References: <20210520221359.75615-1-lenaic@lhuard.fr> <20210524071538.46862-4-lenaic@lhuard.fr> <ce0e096d-cd82-800a-9ef5-5bcc4b25046d@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Phillip,

I=E2=80=99m working on the next iteration of this patch, but I would have a=
 question=20
about one comment of the review.

Le lundi 24 mai 2021, 12:12:10 CEST Phillip Wood a =C3=A9crit :
> > -static int maintenance_start(void)
> > +static const char *const builtin_maintenance_start_usage[] =3D {
> > +	N_("git maintenance start [--scheduler=3D<scheduler>]"), NULL
> > +};
>=20
> I'm not sure what the { } and NULL are doing here, it should just be
> assigning a string. You could put it inside maintenance_start() and just
> call the variable "usage"

I did this because `parse_options(=E2=80=A6, usage, =E2=80=A6)` expects a N=
ULL-terminated=20
array of strings and not a single string.

While I agree that this variable doesn=E2=80=99t need to be global as it is=
 used only=20
from inside a single function, I followed the pattern that I saw elsewhere.

=46or ex. `builting_gc_usage` or `builtin_maintenance_run_usage` in `builti=
n/
gc.c`.

In fact, we=E2=80=99re even told to do so in `Documentation/technical/api-p=
arse-
options.txt` which says:

    . define a NULL-terminated
      `static const char * const builtin_foo_usage[]` array
      containing alternative usage strings

In the files that I looked at, the command usage was always defined as a gl=
obal=20
long-named variable even if it was used in a single function.

> > +static int maintenance_start(int argc, const char **argv, const char
> > *prefix)>=20
> >   {
> >=20
> > +	struct maintenance_start_opts opts;
> > +	struct option builtin_maintenance_start_options[] =3D {
>=20
> As this variable is local to the function you could call it something
> shorter like options.

I agree.
I also followed the pattern that I saw elsewhere.
=46or ex., still in `builtin/gc.c`, there are `builtin_gc_options` and=20
`builtin_maintenance_run_options` which are local variables, but still defi=
ned=20
with an explicit and unique long name.

So, I=E2=80=99m wondering if I should follow the existing pattern or if I s=
hould=20
shorten the name of the local variable.
I thought the existing convention could be useful when grepping for option =
or=20
usage of a command in the code=E2=80=AF?


