Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 456A2C4338F
	for <git@archiver.kernel.org>; Wed, 18 Aug 2021 06:08:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2ECAE6108F
	for <git@archiver.kernel.org>; Wed, 18 Aug 2021 06:08:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238013AbhHRGIt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Aug 2021 02:08:49 -0400
Received: from 82-64-198-250.subs.proxad.net ([82.64.198.250]:37842 "EHLO
        mail.lhuard.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238923AbhHRGHr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Aug 2021 02:07:47 -0400
X-Greylist: delayed 613 seconds by postgrey-1.27 at vger.kernel.org; Wed, 18 Aug 2021 02:07:46 EDT
Received: from coruscant.lhuard.fr (unknown [IPv6:2a01:e0a:465:5440:65a7:ebe4:f40e:e0b])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.lhuard.fr (Postfix) with ESMTPSA id CA2EE4DF2FD;
        Wed, 18 Aug 2021 07:56:45 +0200 (CEST)
Authentication-Results: mail.lhuard.fr; dmarc=fail (p=quarantine dis=none) header.from=lhuard.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lhuard.fr; s=rpi3;
        t=1629266205; bh=dhEXjIHE1jn9HYa1ITfMK8WBhw+1Mc7ceF0YzCGVB1I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=1D/vGiWtmgi3zdQ4oEBsyrMYC14FO58iA+589h3coV898s38zrDQefbnCYt4zcGgs
         N+6663HIun986YpukYQO0PwhjqEvaJQnTUXCUhlgkk7BbBvAdgVUIVITiShN8tdKcC
         auWFei7elRCE/YC+FZQDMKGpswADAOZW5sX6nfk4=
From:   =?ISO-8859-1?Q?L=E9na=EFc?= Huard <lenaic@lhuard.fr>
To:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Martin =?ISO-8859-1?Q?=C5gren?= <martin.agren@gmail.com>,
        =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v5 0/3] add support for systemd timers on Linux
Date:   Wed, 18 Aug 2021 07:56:35 +0200
Message-ID: <1931213.f5cRXtTDAC@coruscant.lhuard.fr>
In-Reply-To: <8eb18679-f6d5-b97e-f417-3747bb8309c3@gmail.com>
References: <20210524071538.46862-1-lenaic@lhuard.fr> <20210608134000.663398-1-lenaic@lhuard.fr> <8eb18679-f6d5-b97e-f417-3747bb8309c3@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Le mardi 17 ao=C3=BBt 2021, 19:22:05 CEST Derrick Stolee a =C3=A9crit :
> On 6/8/2021 9:39 AM, L=C3=A9na=C3=AFc Huard wrote:
> > Hello,
> >=20
> > I=E2=80=99ve reworked this submission based on the valuable feedback I=
=E2=80=99ve
> > received.
> > Thanks again for it!
>=20
> Hi L=C3=A9na=C3=AFc!
>=20
> I'm replying to your series because it appears you did not see our
> discussion of this topic in the What's Cooking thread a couple weeks ago
> [1] and might miss the discussion that began today [2].
>=20
> [1]
> https://lore.kernel.org/git/4aed0293-6a48-d370-3b72-496b7c631cb5@gmail.co=
m/
> [2]
> https://lore.kernel.org/git/7a4b1238-5c3b-4c08-0e9d-511f857f9c38@gmail.co=
m/
>=20
> The proposal I give in [2] is that I can forward-fix the remaining commen=
ts
> OR re-submit the patches with a new patch and some edits to your current
> patches. (You would remain author of the patches you wrote.)
>=20
> None of that is important if you plan to submit a v6 that responds to the
> remaining feedback (summarized in [1]).
>=20
> I'll hold off for a couple days to give you a chance to read and respond.
>=20
> Thanks,
> -Stolee

Hello,

Sorry for the silence. I just happened to be in holiday for the past few we=
eks=20
and did not have access to my mails.
I can catch up the discussions I missed and try to address the remaining=20
concerns in a new re-roll.

Cheers,
L=C3=A9na=C3=AFc.



