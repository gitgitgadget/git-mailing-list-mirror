Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 142FBEB64DD
	for <git@archiver.kernel.org>; Mon, 24 Jul 2023 21:22:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbjGXVW4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jul 2023 17:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231185AbjGXVWw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2023 17:22:52 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB772171F
        for <git@vger.kernel.org>; Mon, 24 Jul 2023 14:22:42 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 830BC5A35F;
        Mon, 24 Jul 2023 21:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1690233761;
        bh=TISMZHbusTKtagRlVFv8c4ve2pQ6byFSFdhro8Qm8oo=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=yomCjcf+o/oTCfJbVvDv1cEV10WNMusWvum2bmmffpAU/VGhj3WSSIYONhcLKY4by
         uWqwAh/pKk2qjaCe48fTuEqzpqSVmbhso3DP8LdYBEftn+/01Th+0VjU3i0biIGUzr
         +3rtvI2J5EhoBaNYw2NjUUGKeqgihjDxxU2FO6xXL7J1WVSafdWZ+gDvGXaZombMmd
         g6GV8Tl4bQ9CpVhZ8qW66hQHMLaK6zzx2txTSVIwmMkg7ojRMGAu8Tp+m1KtK0anbw
         W1jBSc1UN4BWEix3Jx8hJ5aH9khdWO6UPk0bTgLlzr8fduAMAj6Gf8aIgwJ3+l7LC1
         t56oyQWBrfU3mNSarLWl3RINvBF0LKYeL05WbsbVCiXQvW3i0VJvldUM3ERRN2yMn0
         EK8CSeDYJC5/PCK6IzUE6myF56H0+cEAJG08L77KpG9tn34dNAf7A1WF9mpLJ7UWus
         nXAiqpdHcKVyeVhO4KESpquWoGf0D0UlX7+AK9Deu46/s6N4IJZ
Date:   Mon, 24 Jul 2023 21:22:39 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, "brian m. carlson" <bk2204@github.com>
Subject: Re: [PATCH] rerere: match the hash algorithm with its length
Message-ID: <ZL7rn+LTVjSFzrI8@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        "brian m. carlson" <bk2204@github.com>
References: <xmqqa5vou9ar.fsf@gitster.g>
 <ZL1BNxVWKGx0Gi1b@tapette.crustytoothpaste.net>
 <xmqqr0oyr3y0.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nwNRhzFJKQoo3gs0"
Content-Disposition: inline
In-Reply-To: <xmqqr0oyr3y0.fsf@gitster.g>
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--nwNRhzFJKQoo3gs0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-07-23 at 16:24:39, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > I agree consistency here is a good idea.  However, I should point out
> > the definition of `get_sha1_hex`:
> >
> > int get_sha1_hex(const char *hex, unsigned char *sha1)
> > {
> > 	return get_hash_hex_algop(hex, sha1, the_hash_algo);
> > }
>=20
> Yeah, I think I lifted the inlining from there, and you are
> absolutely right.  I think the main source of the confusion is that
> get_sha1_hex(), while it was a perfectly good name before the
> "struct object_id" world, has now become a misnomer.
>=20
> I'd retract the patch you reviewed, but now I wonder if the
> following is a good idea.

Yeah, I think that's a great idea, especially since now there are only a
handful of those calls left.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--nwNRhzFJKQoo3gs0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZL7rnwAKCRB8DEliiIei
gU9MAQCQPCwFbZS9LX+p5WmQpXp4m57BLA/bQF9VBqHKh6YTEwD9FfTBqEMBbXKN
CQslWDtOOcbuAP/pomLkNNWv/rTLrAc=
=1t9Q
-----END PGP SIGNATURE-----

--nwNRhzFJKQoo3gs0--
