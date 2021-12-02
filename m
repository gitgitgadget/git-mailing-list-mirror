Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF86CC433EF
	for <git@archiver.kernel.org>; Thu,  2 Dec 2021 22:32:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238984AbhLBWf7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Dec 2021 17:35:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbhLBWf6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Dec 2021 17:35:58 -0500
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E97CAC06174A
        for <git@vger.kernel.org>; Thu,  2 Dec 2021 14:32:34 -0800 (PST)
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 1D3AC5D407;
        Thu,  2 Dec 2021 22:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1638484354;
        bh=FZOzAYykLc1WLVForoong5CpEcc7HjP1UJIpMo+ezzQ=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=hZUTs4+aaBe1PGF7xEhRL4S7n+kc7iKcxsuFGvnfR6FASSji3QOUs0P5Ch2F/kH2t
         W+9VHZuB8LAm3vdQMTZ0BVzPWkUP2YMHVMvL3Ops2MrV32DHe5/jslzTm/6JbYhRSQ
         iBHXJgOSbtZ0XcOUhgQYlJw5napdrnS8/JAMpXyfw+9Pkmtw5pezo36H+MQWurXcab
         7Ds7kn1slrKH45jdqgUGWnjD+8YkTGIsXxfqq1BUZN+otFCSWORklr7Z0zoLsaEm3I
         CQia6VRYMTmKLTyHBqSN3UPx9qn1Z4Ud7ryXbZA+uVJKKrv//vGzbIaZw4/RLqZCXd
         5NMsxmtaNaEa95Dkf8CJare9hjSctglvtgFc6kK8of6CK9wo+gzVW4bvzG5owLtoVo
         n4zAwtOcCPzLp/BYQQhEcWMlHxh1bIbS0dGmEd80GTJUQG31nu85S6D9B7nYDHPeo+
         d8GNu9lLuEgZzdW8od3FaLcDgY9LsNSZnp8QWT6VyfNTyh3euuB
Date:   Thu, 2 Dec 2021 22:32:32 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        gitster@pobox.com, larsxschneider@gmail.com, peff@peff.net,
        tytso@mit.edu
Subject: Re: [PATCH 02/17] pack-mtimes: support reading .mtimes files
Message-ID: <YalJgGJFoGGgCazx@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <stolee@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        git@vger.kernel.org, gitster@pobox.com, larsxschneider@gmail.com,
        peff@peff.net, tytso@mit.edu
References: <cover.1638224692.git.me@ttaylorr.com>
 <7d4ae7bd3e28e2ec904abb37b6f26505e37531c5.1638224692.git.me@ttaylorr.com>
 <ef10c824-e2d9-f113-f010-6a1ac307427a@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DtFINUxo8xPA0rEl"
Content-Disposition: inline
In-Reply-To: <ef10c824-e2d9-f113-f010-6a1ac307427a@gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--DtFINUxo8xPA0rEl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-12-02 at 15:06:07, Derrick Stolee wrote:
> On 11/29/2021 5:25 PM, Taylor Blau wrote:
>=20
> > +=3D=3D pack-*.mtimes files have the format:
> > +
> > +  - A 4-byte magic number '0x4d544d45' ('MTME').
> > +
> > +  - A 4-byte version identifier (=3D 1).
> > +
> > +  - A 4-byte hash function identifier (=3D 1 for SHA-1, 2 for SHA-256).
>=20
> I vaguely remember complaints about using a 1-byte identifier in
> the commit-graph and multi-pack-index formats because the "standard"
> way to refer to these hash functions was a magic number that had a
> meaning in ASCII that helped human readers a bit. I cannot find an
> example of such 4-byte identifiers, but perhaps brian (CC'd) could
> remind us.
>=20
> You are using a 4-byte identifier, but using the same values as
> those 1-byte identifiers.

The preferred value is the_hash_algo->format_id.  For SHA-1, that's
"sha1", big-endian (0x73686131) and for SHA-256 it's "s256", big-endian
(0x73323536).

There's also hash_algo_by_id to turn the format ID into an index into
the hash_algos array, but you need to check for GIT_HASH_UNKNOWN (0)
first.

These will be used in index v3, which I haven't sent out patches for
yet.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--DtFINUxo8xPA0rEl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYalJfwAKCRB8DEliiIei
gbZHAQCmjEa4ZfKCFoVjYpV6tS+4dL9vVK7nWCkLcNUD6RVFmgEAnG7kVkLcIySN
mmUQ1b3XHXTjj6rbJOQdSoStZE8Dpwk=
=Q5SH
-----END PGP SIGNATURE-----

--DtFINUxo8xPA0rEl--
