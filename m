Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E733F1F42D
	for <e@80x24.org>; Wed, 30 May 2018 23:28:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932536AbeE3X2r (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 May 2018 19:28:47 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58324 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753734AbeE3X2p (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 30 May 2018 19:28:45 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:cc62:bd61:abbd:bc4b])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id AC04D60732;
        Wed, 30 May 2018 23:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1527722923;
        bh=xlXTFsShdqjWgZC+bPfWtEv3VAfMb+UWsPRalUoQGo4=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=sBobBqf6YDCc50dhiDgg3kqkgWiV4aJIuqaEdHhQ68sCUTda3hSqVElhzBsEtVE8t
         vDQs/Imv6OJckjQWp3ZqbMt1VoF4bGG/38QN4+pLYwqGIGu5ftOElav+NIfzKSm8eM
         hI0hk70/duF/DC0jV1VevnUVdVBCKvgxHBgrdcdtI9AHDd11+gaNYQAGzUMnUoYCrJ
         +8KJfrDPwAd/jg67RUEAnNxo1/cw12VxOsybzHcnVzIao3ZbTGup548tTu+K+ULs91
         ZbIEKgnEhIhZ7nbkzYtmxY03StKdURdGqMZkMVMv9sdqHC1DwsiOHWrOA+uRAEcK5r
         44Mi4QPpV80rEyWX68SqFZ+D5NQ7VP0uWtOF0y7w4/a7onlnDxhRPzSUt09PDpkn+Z
         ClO5StfbFE9xvSnae03qfRGwT/INUkS9Y/LkEDT+c2VZ28u6KOsAT2PJZUbMUct3Ao
         DTIVB7IJHI/xmDOl4UZ0kcQ42oKfc0ZwRT4k00IhITkKOhMt+BL
Date:   Wed, 30 May 2018 23:28:38 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 01/18] Add a function to solve least-cost assignment
 problems
Message-ID: <20180530232837.GD671367@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Stefan Beller <sbeller@google.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <cover.1525361419.git.johannes.schindelin@gmx.de>
 <cover.1525448066.git.johannes.schindelin@gmx.de>
 <3f51970cbc44bfe34133c48c0844ed3723e83808.1525448066.git.johannes.schindelin@gmx.de>
 <20180530135505.9569-1-szeder.dev@gmail.com>
 <CAGZ79kZ77qBuSDGBJa5b1AvKLBSOOnTad_UXm9EP0aJSrmEohw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SFyWQ0h3ruR435lw"
Content-Disposition: inline
In-Reply-To: <CAGZ79kZ77qBuSDGBJa5b1AvKLBSOOnTad_UXm9EP0aJSrmEohw@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.15.0-3-amd64)
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--SFyWQ0h3ruR435lw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 30, 2018 at 09:14:06AM -0700, Stefan Beller wrote:
> Good point. I remember my initial reaction to the file names was expecting
> some hungarian notation, which totally didn't make sense, so I refrained =
=66rom
> commenting. Searching the web for the algorithm, maybe 'lapjv.c' is adequ=
ate?
> (short for "Linear Assignment Problem Jonker Volgenant") Matlab has a fun=
ction
> named lapjv solving the same problem, so it would fall in line with the o=
utside
> world.
>=20
> Out of interest, why is it called hungarian in the first place? (I presum=
e that
> comes from some background of DScho in image processing or such, so the
> the answer will be interesting for sure:)

I think it's because tbdiff uses the hungarian Python module, which
implements the Hungarian method, also known as the Kuhn-Munkres
algorithm, for solving the linear assignment problem.  This is the
Jonker-Volgenant algorithm, which solves the same problem.  It's faster,
but less tolerant.

At least this is what I just learned after about ten minutes of
searching.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--SFyWQ0h3ruR435lw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.7 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlsPM6UACgkQv1NdgR9S
9ovgthAAiY3ZRKlXTjOFHOScNcQOj8eZA/WL42BYESErkz0ZwgA4Y/h1Dj3lk/lb
evJNFV1x2Zg6erXxmJsg+Q3ovY1FvuGfMo97ixrMM59HUOYnH63wbmhgxQYf4wYS
ieSR6/3ZyfSNxLbcE9vhEldcGpF1AMBrpIHxxf9pL3bQJU/PFbA/Ys/BGYVkVcgg
mAuYWLG925iS0k8sJw7aZ/zgdQRxoE01eIn6q1YF5Tu65xQ7tFqZ9agXoM9vCSDV
xet0NKvXU1uF29dU/jn3z/lx2dAzaDODKM5/YHxAd0FqGy1RXtzGbdeCfHC4sp9/
QaV+GDsLgPJmyBA+QceYCP1ZN60qgOMmochjxREcjGTdMIUYCKNCd+qiMNIlgpYh
ki51KWvfCTasj6qbg0dOWnRt/sFZ2PKxC8JSbVQuXtTZQp7i4rjpYFEqRZaB3kZo
BaNvgGjNfXidPu5ZENtnJyztkwo3hgvm5/5UzXgYZ/ubaqSV2sRwv35zU5y6VnxY
72gtY26KKwrHK4I45WnI4N/2vbPbZKHWyqv4InZLHyVHIfZ2yIQH4RL9S9RGC6dS
DG29MxCcKgqQOcCMEfwsfAg73BENSU3VitlgBiLapc4QugL+GtFP3YGMmSqYjYbZ
IDtp/btcSUaMyDGHncK/kgAfqEd5fEiGj8gFu4y4bnryKoYqwgk=
=iEAX
-----END PGP SIGNATURE-----

--SFyWQ0h3ruR435lw--
