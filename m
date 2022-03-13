Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F25C7C433FE
	for <git@archiver.kernel.org>; Sun, 13 Mar 2022 17:22:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232081AbiCMRXR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Mar 2022 13:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231192AbiCMRXQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Mar 2022 13:23:16 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E3D52B16
        for <git@vger.kernel.org>; Sun, 13 Mar 2022 10:22:07 -0700 (PDT)
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id E53715A12D;
        Sun, 13 Mar 2022 17:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1647192126;
        bh=xgM4xA3Gx6Cyaag+D6PiCBdl/v6QAFTFQBKvBOwEH+w=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=rKjGpwNF+F65/HeGsXY+m9BQ4mC6UFvc7QWLPmJWPlEo+x15xbVgh80RRNvaAxdUg
         xlFbL4ChcV49vWdVyKzIDWb2mIEwveOfYM7P9zSGmhnNEqW1DbY7Nstjg73Tfqkkon
         +9TleOWlebYnC7aYw9Mw+eSvw9ysHA5Dg9/GMRBuoxNi7pTAar0rubtjmA2irXg0ev
         gN+/xCR+MEIbs0NJuRVCsEOM8dUbldcctgfJyl/9jmqFVEZnQAcCcL2d6dpN+l2CWL
         r3UNDfSFbkcdmYOyhsexQf3IcmZisO5QmwgzMqCkd6waswTODHL9Eri/hbfldyscAS
         ccgTYBrk4uX4KZMV9h2cDZESUZD1jwHSkghgPlcaOSNGmRwt6RTmYdJ7FJRwC13/MR
         b4o6fP6r7xaRzV3MwiDeVpUZbmZh5/9ALX9DUEmt5FbRwxiI/JK8yHKI6GFtR9HJqv
         iEhTixd600jO4ShLKKnEeg1v2r3DU+vWSWCxy2IE9deg4yeC5L8
Date:   Sun, 13 Mar 2022 17:22:03 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Sean Allred <allred.sean@gmail.com>
Cc:     git@vger.kernel.org, sallred@epic.com, grmason@epic.com,
        sconrad@epic.com
Subject: Re: Dealing with corporate email recycling
Message-ID: <Yi4oO+ifSK8OH0Mt@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Sean Allred <allred.sean@gmail.com>, git@vger.kernel.org,
        sallred@epic.com, grmason@epic.com, sconrad@epic.com
References: <878rtebxk0.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dZWNLKy+8Z/adQ4G"
Content-Disposition: inline
In-Reply-To: <878rtebxk0.fsf@gmail.com>
User-Agent: Mutt/2.1.4 (2021-12-11)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--dZWNLKy+8Z/adQ4G
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-03-12 at 22:38:56, Sean Allred wrote:
> * Proposal: UUIDs
>=20
> To get what we want (i.e., the ability to run `git show HEAD~1`, know
> that Ada wrote it, and report her current contact information), we
> need some way of tracking identity over time.  A naive solution could
> be to extend the mailmap format as recognized by Git:
>=20
>     $ git cat-file blob HEAD~1:.mailmap
>     A. U. Thor <foo@example.com> [uuid A] <ada@example.com>
>=20
>     $ git cat-file blob HEAD:.mailmap
>     A. U. Thor <ada@example.com> [uuid A]
>     Roy G. Biv <foo@example.com> [uuid B] <roy@example.com>
>=20
> Now, when I run `git show HEAD~1`, Git would determine the UUID of the
> email on the commit using the mailmap version in that tree:
>=20
>     $ git -c mailmap.blob=3DHEAD~1:.mailmap check-mailmap --uuid "<foo@ex=
ample.com>"
>     A
>=20
> Then, we can use that UUID to resolve to the current contact information:
>=20
>     $ git check-mailmap --uuid=3DA
>     A. U. Thor <ada@example.com>
>=20
> Mailmap-sensitive commands can use this logic internally -- possibly
> guarded under some new config setting.

It's my intention to implement an approach where people's emails are
identified by a key fingerprint of some sort and then converted into the
proper email address by a mailmap that lives outside of the main
history.  That is, my email address might be
ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad@ssh-sha256=
=2Ens.git-scm.com,
and then we have a mailmap that converts between the two.  If you wanted
to have a UUID-based one, you could do
77c747a3-1599-4c8c-9569-f729c17632e6@uuid.ns.git-scm.com (assuming that
namespace were registered).

The benefit to the key part is that you can essentially prove that you
are who you say you are.  A UUID doesn't have the possibility.

This was discussed briefly at some sort of contributor summit we had at
some point, but I've been busy and haven't gotten to it yet.  It is on
my list of projects, however.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--dZWNLKy+8Z/adQ4G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYi4oOgAKCRB8DEliiIei
gcSsAP9zvlPmImTUWmhbVqVuFQidmsb5PlxMjPQPBFSjmWnhWQEA1a8LV4lt2wxc
9JwfjFSG3cIgjWNX6aRb2GyVSxzy2g4=
=WiMB
-----END PGP SIGNATURE-----

--dZWNLKy+8Z/adQ4G--
