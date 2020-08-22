Return-Path: <SRS0=iV/m=CA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA72C433E1
	for <git@archiver.kernel.org>; Sat, 22 Aug 2020 18:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B31C920714
	for <git@archiver.kernel.org>; Sat, 22 Aug 2020 18:53:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="TqcFkVSh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728551AbgHVSxr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Aug 2020 14:53:47 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:45508 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727856AbgHVSxq (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 22 Aug 2020 14:53:46 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id D290660456;
        Sat, 22 Aug 2020 18:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1598122395;
        bh=SIgyQ1gp2dW08jQp1eS6jhp3U/JJyHo/jzAYv0JOvSQ=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=TqcFkVShp5nXIHifb7qwew2kUqJBRMhTg8YpbmjUAKaXhkfLgs0J1o3CMa27hnAMu
         LaU2OQ1lxgOqwYo4ZutArnndzse8jB4bJ15ENpluM6kpR+uA99h3CCF2o3DdSX8o5/
         /ecSFgMMmwKIkVb9TgUKkN0O1DIGqqm0AFCrQFLu1L66WRwGr/43jl2sT4KTEgN6pi
         GqSPioW5oPuzY3+ijbt7rB8Nkc007QDu3w8bg/MTibWBHKtG0ekUKh1j3woECOBT2W
         HIAnMVjJVMwH+3uW/vnIqMjSoxbvonuF7VBVFWZfDCedUIODQrATFXgxZRV16ZkyH7
         qvLBP6+iQ/JG9OUlwS0Wu/pbLJ6MmXJXbiJ/t6VTvhBmNALODaxYb5mFwM9vcp8Lfv
         TqZrPp4s9sv3v4xXWAe8QFtrakncxD5TWMhFq+fQ5OZE5tng4sSi9CgJf9s0oJqWOw
         Ax8YebIKwXymLlKYRFW+PNvG1uDfju1qHqQkB9OW3kA5czfNefm
Date:   Sat, 22 Aug 2020 18:53:07 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Lukas Straub <lukasstraub2@web.de>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        'git' <git@vger.kernel.org>, 'Elijah Newren' <newren@gmail.com>,
        'Brandon Williams' <bwilliams.eng@gmail.com>,
        'Johannes Schindelin' <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH 0/2] Allow adding .git files and directories
Message-ID: <20200822185307.GZ8085@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Lukas Straub <lukasstraub2@web.de>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        'git' <git@vger.kernel.org>, 'Elijah Newren' <newren@gmail.com>,
        'Brandon Williams' <bwilliams.eng@gmail.com>,
        'Johannes Schindelin' <Johannes.Schindelin@gmx.de>
References: <04aa01d67659$2dc217b0$89464710$@nexbridge.com>
 <xmqqimdetpuw.fsf@gitster.c.googlers.com>
 <20200819201736.GA2511157@coredump.intra.peff.net>
 <xmqqa6yqtm03.fsf@gitster.c.googlers.com>
 <20200819203825.GA2511902@coredump.intra.peff.net>
 <20200820133445.2bd162a3@luklap>
 <20200820130125.GB2522289@coredump.intra.peff.net>
 <20200821143941.28f71287@luklap>
 <20200821225237.GW8085@camp.crustytoothpaste.net>
 <20200822162152.2be1d024@luklap>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rYRijwbmzeJBcrGE"
Content-Disposition: inline
In-Reply-To: <20200822162152.2be1d024@luklap>
User-Agent: Mutt/1.14.6 (2020-07-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--rYRijwbmzeJBcrGE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-08-22 at 14:21:52, Lukas Straub wrote:
> On Fri, 21 Aug 2020 22:52:37 +0000
> "brian m. carlson" <sandals@crustytoothpaste.net> wrote:
>=20
> > On 2020-08-21 at 12:39:41, Lukas Straub wrote:
> > > The downsides we discussed don't apply in this usecase. These are mos=
tly
> > > personal files, so I wont upload them to any hosting site (not even p=
rivate
> > > ones). There is no security impact as I only sync with trusted device=
s. =20
> >=20
> > I realize this works for you, but in general Git's security model does
> > not permit untrusted configuration files or hooks.  Configuration can
> > have numerous different commands that Git may execute and it is not, in
> > general, safe to share across users.  This is why Git does not provide a
> > way to sync whole repositories, only the objects within them.
> >=20
> > Adding the ability to transport configuration through a repository is a
> > security problem because it allows an attacker to potentially execute
> > arbitrary code on the user's machine, and I can tell you that many, many
> > people do clone untrusted repositories.  Just because you are aware of
> > the risks, are comfortable with them, and are the only user in this
> > scenario does not mean that this feature is a prudent one to add to Git.
> > It violates our own security model, and as such, isn't a feature we're
> > going to want to add.
>=20
> I don't understand. If the attacker gets the user to set git config optio=
ns,
> then all hope is lost anyways, no?

When you can embed repositories in other repositories like you're
proposing, those embedded repositories can have configuration files in
them (e.g., .git/config), which leads to the security problem.
--=20
brian m. carlson: Houston, Texas, US

--rYRijwbmzeJBcrGE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCX0FpkgAKCRB8DEliiIei
gT+yAPwJzDFTQTS7MbOkDsUXuQivCdnQTTA6qkYl1y1ZedvkGQD9Easr8so/wlty
mpI/T7Bjy5Od44zzVgpeouKiSE6P8gE=
=u8na
-----END PGP SIGNATURE-----

--rYRijwbmzeJBcrGE--
