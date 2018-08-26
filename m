Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF6D11F428
	for <e@80x24.org>; Sun, 26 Aug 2018 20:56:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbeH0AkJ (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Aug 2018 20:40:09 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34788 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726741AbeH0AkI (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 26 Aug 2018 20:40:08 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:1024:89fd:c4a5:84be])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 7BB7460745;
        Sun, 26 Aug 2018 20:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1535316986;
        bh=HInqav6wXWL1ShU0tialfE/8TnL+DDywj9ZkmnS53as=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=qCYpbi/8CUsijDIdpjlHtpTGGBzjVlkur46vMG2U59xulpzIqjb3fuOwdt1UnS4vy
         q6MQqPutf4dB13SLM5R+9FBx3isGqaeVe2zzPANhynayVewqnLG1kGwmUDtL/FU0DS
         7wKaOKY20LIG0TP2Z3YHqayaoQMnFL0PO6vTR6GyYZAs8zRYelrCFLbBR+e9LZB/ns
         kQv3DeNv0koXezJEBbL8QrsmgC15C/FwKsJqqhSU/xRrWSTMEiAs2Ng44sk/fB1zLs
         TkhMtSKUHqw8AZnlPvla8GZSwG2Ra8TYoOe13Z5yXe4043G0T6wykdRXjG/NBCY0xh
         uPvUO0QyJ25MqBgdzOGdvCBoBmJolv1ghxWiL0R/pDekRU7cXxBLozBbA0bbIi7xrz
         1+shJa1DxrfidM2etJgLNf79PO06efJihunUDlemozhjuC4Rdj1QQMUBke1dUth/jE
         gPPFEpqJO/ypvTCnc+lq2ecJKlFL96jUck/co5G7w9O3XpydnU/
Date:   Sun, 26 Aug 2018 20:56:21 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH 0/9] introducing oideq()
Message-ID: <20180826205620.GC873448@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        Derrick Stolee <stolee@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>
References: <20180825080031.GA32139@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xaMk4Io5JJdpkLEb"
Content-Disposition: inline
In-Reply-To: <20180825080031.GA32139@sigill.intra.peff.net>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.17.0-1-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--xaMk4Io5JJdpkLEb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 25, 2018 at 04:00:31AM -0400, Jeff King wrote:
> This is a follow-up to the discussion in:
>=20
>   https://public-inbox.org/git/20180822030344.GA14684@sigill.intra.peff.n=
et/
>=20
> The general idea is that the majority of callers don't care about actual
> plus/minus ordering from oidcmp() and hashcmp(); they just want to know
> if two oids are equal. The stricter equality check can be optimized
> better by the compiler.
>=20
> Due to the simplicity of the current code and our inlining, the compiler
> can usually figure this out for now. So I wouldn't expect this patch to
> actually improve performance right away. But as that discussion shows,
> we are likely to take a performance hit as we move to more runtime
> determination of the_hash_algo parameters. Having these callers use the
> more strict form will potentially help us recover that.
>=20
> So in that sense we _could_ simply punt on this series until then (and
> it's certainly post-v2.19 material). But I think it's worth doing now,
> simply from a readability/annotation standpoint. IMHO the resulting code
> is more clear (though I've long since taught myself to read !foocmp() as
> equality).

I would quite like to see this series picked up for v2.20.  If we want
to minimize performance regressions with the SHA-256 work, I think it's
important.

Applying the following patch on top of this series causes gcc to inline
both branches, which is pretty much the best we can expect.  I haven't
benchmarked it, though, so I can't say what the actual performance
consequence is.

As for this series itself, other than the typos people have pointed out,
it looks good to me.

diff --git a/cache.h b/cache.h
index 3bb88ac6d0..1c182c6ef6 100644
--- a/cache.h
+++ b/cache.h
@@ -1033,7 +1033,10 @@ static inline int oidcmp(const struct object_id *oid=
1, const struct object_id *o
=20
 static inline int hasheq(const unsigned char *sha1, const unsigned char *s=
ha2)
 {
-	return !hashcmp(sha1, sha2);
+	if (the_hash_algo->rawsz =3D=3D 32) {
+		return !memcmp(sha1, sha2, 32);
+	}
+	return !memcmp(sha1, sha2, 20);
 }
=20
 static inline int oideq(const struct object_id *oid1, const struct object_=
id *oid2)
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--xaMk4Io5JJdpkLEb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.9 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAluDE/QACgkQv1NdgR9S
9osF8BAArxN8dXMPvZ6+yPJhCX0Jme7X6/+j6cnrUbPjK5qQWWoFpiVTONdqJJx0
r3NlW1zdYDjsjP6dMfp62NQYo0wtWUEapG3l4JdB2r3+6+ByPmhDPvB8GdqZSpF/
xImtWBVQGBX0rFGKUOcxLAZPlq5Y6vOA2MmnaPSXVC0T+lOkjrs0iQGZOiVy7Hhx
X1cPGHHbOsfluFIMRjdnqoAi7yo8qbSuVF8MaHF9cu9/I/tKZd8GqYjsrgaK99aP
loi/LI6b0S87QFmbdPlTjmqJtIpMNXQ/ZJ8Ey98yhc12At/csa0bNfXM5AI6eeJ2
mSvFw4edOL65W/6vQgY7heVnKJqDqYea4d0GR+YcoLH4a31reQoFD1YCtKAq7bxP
oUmaJc63g5CXt81Xtrv3GvoEg6x/b0emU+++FwSf4sJREWhhYxr3N081RBW0vuvv
k94wGZsinefSTum6+cYGRzDFLsYpNE7xuAUUN9En3JHodm/dBHw2WsTfra2z9XV/
HkkoEUjgtoXahLOO92d/Di40HPSXzdJKBkAnMhTFQz4cWgdZXfwFScZSrxkRkMaj
uLd7oUMafSVFHd9FhwbZZ2/vRtJXBOGzYgbcRAynmsu51VHn6DlnnHXqczpemYOD
ogX5L4gmVXorbxa+2VYRaHmnOuR9aiFO4d293ebmpOPqzu/wU9o=
=JEtO
-----END PGP SIGNATURE-----

--xaMk4Io5JJdpkLEb--
