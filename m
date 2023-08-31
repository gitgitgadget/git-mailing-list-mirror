Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7EE3CA0FE1
	for <git@archiver.kernel.org>; Thu, 31 Aug 2023 23:19:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347840AbjHaXTU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Aug 2023 19:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbjHaXTU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Aug 2023 19:19:20 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D6AE54
        for <git@vger.kernel.org>; Thu, 31 Aug 2023 16:19:17 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 7407A5A2FC;
        Thu, 31 Aug 2023 23:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1693523956;
        bh=mF4pRseAxP4l+/p2hWQynoAvfK7GbQsq2QAqGg4Sqfk=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=QkqyJ6FEu2LbLDiVZn7xoYlAFElluMolctYTidqq0urFbPmUu2rT9kC+qFpJe/VX6
         v3JiFdMAA784fKQEUVK3ktkDrQKTuJqFsHbcByiNYsmjifK2rkp+dCkzGe5PCPOSXw
         QYoWuUibvaoMgafym3aMUSrCDfThoosZ8w9q6mZJprNkwAIkVeya8ef/NwoPsVzLzS
         W9aAKLwYPpFZXv/EVDryISTjxvvNDFgmzYwy551LFTTocYxY6nYWZ2SpTtGdE4r7Cp
         0h1lWh7AJHmrXl+ZTh4Ix0yTaTN8M5DkjTu2xev7wROrZyobsje/DZle/NHmDPY3nU
         eXaA2FpY3Gs/7v9y7Dmk8w4qLwM1xNp7gmCS4sZwEMp2QTIvGgGxBkCthcVDK6ziXv
         CayXGgZmvHlRogkq50XCgp5r2RM5SdLXq91pxCSgRhXCY7O5ZtM4dB+9rblu0z9X2L
         AqFowX0J6miayfzfH0Q078f6+ic4zf3R+mEd+DZSr1mMOXH6dJs
Date:   Thu, 31 Aug 2023 23:19:14 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Eric Wong <e@80x24.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [REGRESSION] Can't clone GitHub repos (fetch-pack error) due to
 avoiding deprecated OpenSSL SHA-1 routines
Message-ID: <ZPEf8kbBUFqLO25W@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Git Mailing List <git@vger.kernel.org>, Eric Wong <e@80x24.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>
References: <ZPCL11k38PXTkFga@debian.me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="T86Rb/gYFuvoakiw"
Content-Disposition: inline
In-Reply-To: <ZPCL11k38PXTkFga@debian.me>
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--T86Rb/gYFuvoakiw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-08-31 at 12:47:19, Bagas Sanjaya wrote:
> Hi,
>=20
> I built Git v2.42.0 on Debian testing, linked with OpenSSL (v3.0.10 from
> distribution) with Makefile knob `OPENSSL_SHA1=3DYesPlease=20
> OPENSSL_SHA256=3DYesPlease`. I tried to shallow clone git.git repository:

I should point out that using OpenSSL's SHA-1 support is insecure
because it doesn't check for collisions.  As a practical matter, no
distro builds that way, and if you distributed that build, it would
probably qualify for a CVE.

However, OPENSSL_SHA256 being set is fine for a local build or a build
where you're not distributing OpenSSL itself.

> ```
> $ git clone https://github.com/git/git --depth=3D1 git-scm
> ```
>=20
> All the necessary objects were fetched but the clone errored instead with:
>=20
> ```
> fatal: fetch-pack: invalid index-pack output
> ```
>=20
> This issue is a regression since v2.41.0 doesn't have it. Bisecting, the
> culprit is commit bda9c12073e7 (avoid SHA-1 functions deprecated in OpenS=
SL 3+,
> 2023-08-01). AFAIK, the culprit doesn't touch `fetch-pack.c` as I hoped.

I also see this with that configuration on Debian sid, and it appears to
affect SHA-256 as well.  The testsuite fails in a variety of spectacular
ways.  For example, t0410 is broken in exactly this way.

A simple git index-pack on Git's codebase shows a segfault in
`EVP_DigestUpdate` after calling `flush`.  It's not clear to me why this
would occur, but I did note that the context is a static variable.  I
wonder if there's something about this configuration that results in
breakage if a context is reused, although looking at the code, nothing
jumps out to me.

I did, however, apply this patch, which I think makes the problem really
clear:

----
diff --git a/sha1/openssl.h b/sha1/openssl.h
index 006c1f4ba5..0390ba9da6 100644
--- a/sha1/openssl.h
+++ b/sha1/openssl.h
@@ -32,6 +32,7 @@ static inline void openssl_SHA1_Final(unsigned char *dige=
st,
 {
 	EVP_DigestFinal_ex(ctx->ectx, digest, NULL);
 	EVP_MD_CTX_free(ctx->ectx);
+	ctx->ectx =3D NULL;
 }
=20
 static inline void openssl_SHA1_Clone(struct openssl_SHA1_CTX *dst,
----

Now we see that when the segfault happens, `input_ctx.sha1.ectx` is
NULL.  I'm not sure why that is, or what needs to be fixed, but I think
it's clear that _someone_ isn't calling the `init_fn` method before
re-using the context, and they definitely should be.

Hopefully this gives someone a good push in the right direction on
solving the problem.

If someone wants to pick up the above patch to help make this problem
more obvious in the future (don't forget to do the same for SHA-256),
please do so with my blessing.  I wouldn't say you need my sign-off
since it's so trivial, but feel free to forge it if it makes you feel
better.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--T86Rb/gYFuvoakiw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZPEf8gAKCRB8DEliiIei
gV6pAP9BU5vR04+/InK6kalqK0N06wqeIXnNqmmwi51vZA9+ZQD/cEIo1LYMhYZI
HHnQz1TjA0BOXm5G86sTnlQ7qubi5QA=
=l12f
-----END PGP SIGNATURE-----

--T86Rb/gYFuvoakiw--
