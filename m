Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8170BC7619A
	for <git@archiver.kernel.org>; Wed, 12 Apr 2023 00:54:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbjDLAyF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Apr 2023 20:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjDLAyD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2023 20:54:03 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F5FF359D
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 17:54:02 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 503BF5A569;
        Wed, 12 Apr 2023 00:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1681260841;
        bh=tPmKWtalccWfg1oPzCgME8Aoujojh38VEskbwbafobk=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=oTyWfznXDj2VK+7N23cUOdJiNRVKcLfpsbykvATncwsnsdcMm77qcYA7rAJ1pVeux
         f9GXk54DGBjkILl7FeLmw0vtbgUB5xxM5gXPhULxQEk80c4EG/d8+EAr3ztinfSfV6
         meFuw1brFSm0S1pOYf4cQ5Qw3QPuZtbzZvDlHbo9C5PV9o0YotR33i9nSFO/9u5eas
         dhOPVqQvJiGGwNtT7CB0sk3QdaNDV4uvvZoyczewa4QypFzJG1rHTyQm7iIgCwjgqi
         WxfGxPLUmb1Eq8eiJyZQIWxxq/jTp+FqFRnStUc61v/uUG9EOtBealbDp3B+VSCTnB
         h0shzM3uuEG/CtUX+rwj4uRxsGlBSZdH9lCnUxQ+jUdRGYftxNm29IpPgX7wzXFyhH
         h31MVu8GABRjk4Hf55X8Ac/2nigAXtj/excd4vvFOLqpRgrUShdYDQoiXuhdV55aZR
         WixPsL/XNXaqAxtAsFX5nNikRO4+yGaFRA6nbQ5dnv1rDff1R2f
Date:   Wed, 12 Apr 2023 00:53:59 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Jonas Haag <jonas@lophus.org>, git@vger.kernel.org
Subject: Re: Infinite loop + memory leak in annotate_refs_with_symref_info
Message-ID: <ZDYBJwCuXD6UCI5p@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Taylor Blau <me@ttaylorr.com>, Jonas Haag <jonas@lophus.org>,
        git@vger.kernel.org
References: <39035D34-8548-44B0-BBBB-5C36B3876C4A@lophus.org>
 <ZDXCKecwxo36fALm@nand.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EdlknW2atkLZQk08"
Content-Disposition: inline
In-Reply-To: <ZDXCKecwxo36fALm@nand.local>
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--EdlknW2atkLZQk08
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-04-11 at 20:25:13, Taylor Blau wrote:
> Hi Jonas,
>=20
> On Tue, Apr 11, 2023 at 10:53:59PM +0300, Jonas Haag wrote:
> > Hello!
> >
> > There is an infinite loop with an accompanying memory leak in
> > annotate_refs_with_symref_info that was introduced in Git 2.28 (I
> > think in commit 2c6a403: =E2=80=9Cconnect: add function to parse multip=
le v1
> > capability values=E2=80=9D).
>=20
> I'm not familiar with Klaus and don't have it installed, but a couple of
> questions: were you able to reproduce this result with any other forges
> or tools, and were you able to confirm that 2c6a403 is the culprit via a
> bisection?
>=20
> In case the answer to the latter question is "yes", I cc'd brian carlson
> on this thread, since they are the original author of that patch.

I may be the author of the patch, but I honestly don't remember much
about that code except that it was a bear to write, and I am honestly
not terribly surprised that it came out less than perfect.  I do
apologize for the buggy code, though.

It looks like Peff has come up with a patch downthread, and a test even,
which I think will probably fix the problem, so I'll refrain from
sending one myself for now.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--EdlknW2atkLZQk08
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZDYBJwAKCRB8DEliiIei
gVMbAPsHhfYgNl6KpyTVwCn+yBaNfrzSJ/hfEqIser/RqvxytgD8C2JmsYDymVKh
kZBjmfg0EIDg3zD3uTJVOq3J7pSEQQw=
=EksE
-----END PGP SIGNATURE-----

--EdlknW2atkLZQk08--
