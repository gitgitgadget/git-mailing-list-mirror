Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64CDFC2B9F8
	for <git@archiver.kernel.org>; Tue, 25 May 2021 07:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C49761417
	for <git@archiver.kernel.org>; Tue, 25 May 2021 07:18:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbhEYHUF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 May 2021 03:20:05 -0400
Received: from 82-64-198-250.subs.proxad.net ([82.64.198.250]:48682 "EHLO
        mail.lhuard.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229503AbhEYHT7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 May 2021 03:19:59 -0400
Received: from coruscant.lhuard.fr (unknown [IPv6:2a0d:e487:13f:f64e:30d2:2626:3a2b:662e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.lhuard.fr (Postfix) with ESMTPSA id 12C6A4756B3;
        Tue, 25 May 2021 09:18:22 +0200 (CEST)
Authentication-Results: mail.lhuard.fr; dmarc=fail (p=quarantine dis=none) header.from=lhuard.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lhuard.fr; s=rpi3;
        t=1621927104; bh=SicinUOuE1/jNBKvGa4UWg3NUVzf8k40U9GJPklng20=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=p4b3crb3SziSHBeCM5pTUh0it5MH4uTSK+43xrwpvb0shNI2aKDSpiRmfigm5hXya
         w+eg/MlZGIC7NTvH6mqfwTCmjvVtBEsxAjTttQXOp/FJtTvmzqxBNGcoBt15vNHIQQ
         4mww3Tj/VllTXWA2XfyiWa/l1B9ywVmN0CnLJqwo=
From:   =?ISO-8859-1?Q?L=E9na=EFc?= Huard <lenaic@lhuard.fr>
To:     Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Martin =?ISO-8859-1?Q?=C5gren?= <martin.agren@gmail.com>,
        =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v4 2/4] maintenance: introduce ENABLE/DISABLE for code clarity
Date:   Tue, 25 May 2021 09:18:09 +0200
Message-ID: <9164987.SKD4A0viWJ@coruscant.lhuard.fr>
In-Reply-To: <YKudvp0m3m+Yi1+m@danh.dev>
References: <20210520221359.75615-1-lenaic@lhuard.fr> <8e013441-08dc-fbb5-f9b9-649b2ffd78db@gmail.com> <YKudvp0m3m+Yi1+m@danh.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Le lundi 24 mai 2021, 14:36:14 CEST =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng D=
anh a =C3=A9crit :
> On 2021-05-24 10:41:18+0100, Phillip Wood <phillip.wood123@gmail.com> wro=
te:
> > Hi L=C3=A9na=C3=AFc
> >=20
> > On 24/05/2021 08:15, L=C3=A9na=C3=AFc Huard wrote:
> > > The first parameter of `XXX_update_schedule` and alike functions is a
> > > boolean specifying if the tasks should be scheduled or unscheduled.
> > >=20
> > > Using an `enum` with `ENABLE` and `DISABLE` values can make the code
> > > clearer.
> >=20
> > I'm sorry to say that I'm not sure this does make the code clearer over=
all
> > - I wish I'd spoken up when Danh suggested it.
> > While
> >=20
> > 	launchctl_boot_plist(DISABLE, filename, cmd)
> >=20
> > is arguably clearer than
> >=20
> > 	launchctl_boot_plist(0, filename, cmd)
> >=20
> > we end up with bizarre tests like
> >=20
> >  	if (enabled =3D=3D ENABLED)
> >=20
> > rather than
> >=20
> > 	if (enabled)
> >=20
> > and in the next patch we have
> >=20
> > 	(enable =3D=3D ENABLE && (opts->scheduler =3D=3D i)) ?
> > =09
> > 			ENABLE : DISABLE;
> >=20
> > rather than
> >=20
> > 	enable && opts->scheduler =3D=3D i
> >=20
> > Also looking at the next patch it seems as this one is missing some
> > conversions in maintenance_start() as it is still calling
> > update_background_schedule() with an integer rather than the new enum.
>=20
> Yes, in this form, I also think the change looks bizarre.
> And, it's entirely my fault.
>=20
> I also agree with =C3=86var that 0 and 1 is meant well for off/on.
>=20
> However, I still think
>=20
>  	launchctl_boot_plist(0, filename, cmd)
>=20
> would require some degree on code navigation to figure out what would
> that LoC does.
>=20
> I'm thinking about rename the function. But, it would trigger a forever
> bikeshedding, which shouldn't be a blocker for this series.
>=20
> > I'd be happy to see this being dropped I'm afraid
>=20
> So, let's drop this patch and start a new conversation when the dust
> settled.

Hi,

I think the reason why the code looks worse is because I used an enum and I=
=20
didn=E2=80=99t want to make any assumption about how the enum members would=
 be=20
evaluated in a boolean context.

Do you think it would make sense to drop the enum type, to revert all logic=
=20
changes (Use `if (enabled)` back instead of `switch`, etc.), and to define =
the=20
following constants=E2=80=AF:

static const int DISABLE =3D 0;
static const int ENABLE =3D 1;

so that we can keep function invocation in the form of=20
`launchctl_boot_plist(DISABLE, filename, cmd)` ?


