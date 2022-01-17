Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 128DFC433F5
	for <git@archiver.kernel.org>; Mon, 17 Jan 2022 22:55:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243669AbiAQWzP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Jan 2022 17:55:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234402AbiAQWzO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jan 2022 17:55:14 -0500
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A7BFC061574
        for <git@vger.kernel.org>; Mon, 17 Jan 2022 14:55:14 -0800 (PST)
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id D10895B236;
        Mon, 17 Jan 2022 22:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1642460113;
        bh=6yRdbexgA5MIB50x5D4vFuIa7YuTIOShqUa2f8huBcY=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=ESfPRXHIB+8geZcOmwi+8hyvxuvd1DGTOxJRlLIs2PtCuem9KrH56LN/E9epCSWAR
         ZnNhTQSD7DVAUShk01g6bfYZPeZoMgf17c6tVcNnjVuozXw28ZWxMljFzASeLj7woI
         /7eWPkl8KKPtD6e6/IkV3fA0+0m6l/eweXZ8Fq50vx9BBupSQcB8Bi7Mbrch5AGzcb
         RUgI4kQks80AWQoRIOgBCGK7qIFpk++qKI91usTEWzqv7z5Sk1q1l2bkPxq/ZY4WLi
         exxYXdclUIVtuzQTLAz7x2a9ncq2Uu6NC3+cmPPWTqC+24lM85QfsC8Gugi/0H3OaS
         dSqPt0YYHEIlTVtCxmnWQLYtXmYYUHEfpRc+Ue+SV2hIKurcnNcTGrTQHEs50jwbjd
         KZHhBYFsi2wBtUZI307RPMW+epaSj+KBiLhNccb6iNii0W1/OowaT7SKOr8d2Pvd7H
         esdR51pB2ONrzn4Q/G+e80JaIuoucZW+vVJI+et7CEYeiDNbC2g
Date:   Mon, 17 Jan 2022 22:55:12 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     "John A. Leuenhagen" <john@zlima12.com>
Cc:     git@vger.kernel.org
Subject: Re: Behavior of core.sharedRepository on non-bare Repositories
Message-ID: <YeXz0MYd8wduM9W+@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        "John A. Leuenhagen" <john@zlima12.com>, git@vger.kernel.org
References: <20220117223912.fwsydwpkwfbcdlcq@Zulu-1>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YWQa3j2Roz3oynvd"
Content-Disposition: inline
In-Reply-To: <20220117223912.fwsydwpkwfbcdlcq@Zulu-1>
User-Agent: Mutt/2.1.4 (2021-12-11)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--YWQa3j2Roz3oynvd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-01-17 at 22:39:12, John A. Leuenhagen wrote:
> I've been trying to work with the core.sharedRepository option today.
>=20
> Based on the wording in the man page, I was under the impression that
> this would affect all files in any type of repository (bare or not), but
> it seems as though this is not the case. It affects bare repositories as
> one would expect, but it only affects the .git directory on non-bare
> repositories. The working tree is not affected by the option at all.
>=20
> I doubt that I'm the first person to encounter this issue, and I'm not
> sure why this behavior would be desirable. If for some reason it is
> discouraged to share a working tree between users in a group, I don't
> believe this option should affect non-bare repositories at all; there
> should be a warning about any dangers associated with this kind of
> setup instead.

I can't speak to how this feature is supposed to work on the working
tree, but it is generally the case that users should not share a working
tree. Any user who can modify the configuration can cause arbitrary code
to be executed by every other user of the repository when they run
almost any Git command.

The only safe thing to do with an untrusted repository is perform a
clone or fetch from it.

It may be in your case that all the users are trusted (e.g., all system
administrators), but in general it's strongly recommended that users not
share a working tree.  There'll be an entry in the FAQ describing this
in the future.

That doesn't mean that this feature couldn't be extended to handle the
working tree, but I did want to provide some context on why working
trees aren't intended to be shared.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--YWQa3j2Roz3oynvd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYeXzzQAKCRB8DEliiIei
gQBDAP0b7vRD+5DwD1EMcMAZSr9q8ac+IbC2RF9OHUrE7kXdAwEA0Y72ZZObqBAR
6xiqtJieWqOByF/nXawCMQGCF0175Ak=
=OLpL
-----END PGP SIGNATURE-----

--YWQa3j2Roz3oynvd--
