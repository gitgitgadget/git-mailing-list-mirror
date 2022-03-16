Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5949BC433F5
	for <git@archiver.kernel.org>; Wed, 16 Mar 2022 21:50:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350518AbiCPVwD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Mar 2022 17:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241215AbiCPVv7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Mar 2022 17:51:59 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2964FD2C
        for <git@vger.kernel.org>; Wed, 16 Mar 2022 14:50:44 -0700 (PDT)
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 11C225A0CA;
        Wed, 16 Mar 2022 21:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1647467444;
        bh=gbLUmXnZBtNr7U7j0w4tYlCa6cEM7UjjbI46zXPNcC4=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=tkNP/wHfSiNB0OUuU3+OdjnrkVYnZHP8XVl6LEXmbDUM5b7Cp+WH8cvvn9Yx8ArMW
         2DYdCdUbTqUOo9TZjMQAK2PZqUaXZja1CDI0OZLPJ20tS8e4hRdyv+BltK7t65w42y
         V7kWBw/z5TgCkcug12mfLxmLgjJpUZtOZGJpbsALma7cmZRY6Rl1hSGtPIzru7EocQ
         +NcBFn/Ed/qoeW7qv7F6IM2eI0pa4GOkfN3iijU342I4YCfvv7lmcBmjN3a4BggtxD
         Hn3vMK73kboEEyudZ0DE0jcgZD87+TYubbjLfpIGWXCppqd6/BoOKGOoTHwwWCKzmc
         ZK6WqCIHa/xKHF7ZL6b9gohRCprYgiLiaVMB8trslmyf+si3tnwwtysAK0ahZUJ6Vh
         bWdo3HXETVulmituYCbkSPMCMsVrwJADMKxGu3qFY1IamV7aG9sq4f5ecKGsv/0aSC
         2NPnPkHJeoCEQvXZf9Ttvsn1H/9ZAp3FuRxx21BMcJXYJMH+P4n
Date:   Wed, 16 Mar 2022 21:50:42 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH 5/6] builtin/stash: provide a way to import stashes from
 a ref
Message-ID: <YjJbsowcAqMhIgDr@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Derrick Stolee <dstolee@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
References: <20220310173236.4165310-1-sandals@crustytoothpaste.net>
 <20220310173236.4165310-6-sandals@crustytoothpaste.net>
 <xmqqa6dpn70b.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WLId4s3vUifveXiD"
Content-Disposition: inline
In-Reply-To: <xmqqa6dpn70b.fsf@gitster.g>
User-Agent: Mutt/2.1.4 (2021-12-11)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--WLId4s3vUifveXiD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-03-16 at 17:26:28, Junio C Hamano wrote:
> > +static int do_import_stash(const char *rev)
> > +{
> > +	struct object_id oid;
> > +	size_t nitems =3D 0, nalloc =3D 0;
> > +	struct stash_info *items =3D NULL;
> > +	int res =3D 0;
> > +
> > +	if (get_oid(rev, &oid))
> > +		return error(_("not a valid revision: %s"), rev);
> > +
> > +	/*
> > +	 * Walk the commit history, finding each stash entry, and load data i=
nto
> > +	 * the array.
> > +	 */
> > +	for (size_t i =3D 0;; i++, nitems++) {
> > +		int ret;
> > +
> > +		if (nalloc <=3D i) {
> > +			size_t new =3D nalloc * 3 / 2 + 5;
> > +			items =3D xrealloc(items, new * sizeof(*items));
> > +			nalloc =3D new;
> > +		}
> > +		memset(&items[i], 0, sizeof(*items));
> > +		/* We want this to be quiet because it might not exist. */
> > +		ret =3D get_stash_info_for_import(&items[i], &oid);
>=20
> The new helper function is not necessary; we can use vanilla
> get_stash_info() on the second parent to get the same information,
> and we do not really need to keep it in core.  We can sanity check
> the shape of the imported stash entry right away and discard
> everything except for the commit object name.

Yes, in the new approach, I think we can do that.  We may still need the
behavior which doesn't die on error, but I think we can centralize it.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--WLId4s3vUifveXiD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYjJbsgAKCRB8DEliiIei
gQ4kAP48rGVUcwpa/NyK1qN6huIHN0HWkOMhjI0m9n8e6dKv0gD8DlvXTUhHFKyU
uRuCkJQOv8SdcaNjuTgc8AScMGzySgs=
=cYc/
-----END PGP SIGNATURE-----

--WLId4s3vUifveXiD--
