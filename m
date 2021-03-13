Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4331C433E0
	for <git@archiver.kernel.org>; Sat, 13 Mar 2021 17:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9726E64D92
	for <git@archiver.kernel.org>; Sat, 13 Mar 2021 17:04:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234010AbhCMRDa (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Mar 2021 12:03:30 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39772 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234104AbhCMRD1 (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 13 Mar 2021 12:03:27 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:7d4e:cde:7c41:71c2])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id E7BB96049C;
        Sat, 13 Mar 2021 17:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1615654977;
        bh=YcchPq3/ctCF3q+AZ7lws+M9X/t/o2GPQSISfI6+VOc=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=AhiPOKwLhps5iiowyaCDRDseIhjwvhwYQmeF66il1h5EYp4RrC2odKGCyy0IDpxi4
         Ui6OyQjr7SSshC+26QRNf7I/t5m7/iXhQEMxSZvjE9j9k1ycAsnYmmE+8dm/R9l08B
         nQj+iJPILg9JSCxB2gO7WgQEmAHECbIBj3+O2POboHyJJtsqU4nNXHOHh8L+HOV7Of
         cWZ2B5IOs6rtdMljVJghoaN1pkP39VZo766s1uzVeXV9I11/cOWrgN6UBqSKRkiwZO
         1rN7hI00k6xN8VKAXkFUoS5aBDDLg+qhaTY0Afau6sqe61SXZE3G9DqKrCip+Vmw7r
         frw1gRrrKMKcIDPU/Eibh8RU7E/wzJDMdVn43QkBH/tUjJKVyCFVTuZesKT8K6Jvbo
         BOv4O/B4Ux+jc3HNjTYiKnim481J64vGXP+6odeC7AcpwQT1lbKNJAwT7ky0HVrI/C
         vnSNhN1FEsFCIZCZO4WEK3X98K6R1qdwSnkaYNjXw8GVRBFOVEv
Date:   Sat, 13 Mar 2021 17:02:50 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Arun Sharma <arun@sharma-home.net>
Cc:     git@vger.kernel.org
Subject: Re: bug report: mutual recursion in the git-subtree shell script
Message-ID: <YEzwOqgFcva4fmoV@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Arun Sharma <arun@sharma-home.net>, git@vger.kernel.org
References: <CAN7rbOve-EFOGPjr1wrD77r-3RQ+3+qso82_oV5Qud-skobL7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FL6w/+Gv4X60pSWu"
Content-Disposition: inline
In-Reply-To: <CAN7rbOve-EFOGPjr1wrD77r-3RQ+3+qso82_oV5Qud-skobL7w@mail.gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--FL6w/+Gv4X60pSWu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-03-13 at 16:06:18, Arun Sharma wrote:
> [ resending bug report from git-users since there weren't any responses ]
>=20
> So I'm trying to split out a directory from postgres source code
> (which has 52k commits). I was able to split a directory into a
> separate subtree (with 1685 commits). All good so far.
>=20
> Now I do a pull from upstream and want to push the directory to my
> subtree. The command fails with:
>=20
> $ git subtree push --prefix=3Dsrc/interfaces/libpq libpq master
> /usr/lib/git-core/git-subtree: 647: Maximum function recursion depth
> (1000) reached
>=20
> As far as I can see, it seems to be a mutual recursion between
>=20
> process_split_commit() and check_parents()
>=20
> If this diagnosis is correct, are there any known workarounds? I've
> tried increasing ulimit -s and FUNCNEST=3D10000, but it didn't fix the
> problem.
>=20
> Can this flow be coded without using recursion? Are there
> implementations of git-subtree in another language which doesn't have
> this problem?

I don't use git-subtree, but there's some additional information which
would probably be helpful here to someone who does.  What OS are you
using, what version of Git, and what shell is the shell you have as
/bin/sh (or, if you've compiled using a custom shell, the shell you're
using for that)?
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--FL6w/+Gv4X60pSWu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.27 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYEzwOQAKCRB8DEliiIei
gXgdAQC5NOstRkLY1xXkNsrV65/1qolibe8sl2Ad/GgJXrA+BQD/eDpJ6Zx6Akqy
V8czzoRghClTpFv+81BQa0y9Sbkg7AY=
=wy0j
-----END PGP SIGNATURE-----

--FL6w/+Gv4X60pSWu--
