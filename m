Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4142C433F5
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 01:25:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbiCAB0Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 20:26:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiCAB0Y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 20:26:24 -0500
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA52B1E6
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 17:25:43 -0800 (PST)
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 091115A0D2;
        Tue,  1 Mar 2022 01:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1646097943;
        bh=dkb/M03hewlCKOJEqRZmQj8mhTCuSK0Gsx7wqeXSd7Q=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=d/o8OaMZweAenWIKcDa8ZFoynp7QkCmyP+EAT8X7nLnNeeptT2svkl2Aq8ldZ5HZc
         oj5rZyP4XZx7V+Ur6PE+iCQforteRQAYxym5nJ11/xf2UdSL/GNGKzqgZ+Y1AnzBCD
         hQPbRVFREQcUqpyJgWmgVMn0YxUOutDu90f6xlqgrENKw6qGXCtTNqfKTtvwk/BfyZ
         AjaNgzNw3YXlGTnlLrlhK2Yd8a+3KneikdJtxCkUspMGbRCEQHMTTgKsNw73Mv1+Bz
         PCA21cTWjDL/3UPnNbcjSfovA3K5dBJnCm7MQPIx3GhkplO960dZFU7jwK8hyuS6uA
         ytw5Q7JEpcVtoRdjW4MhZoIz0HnIZQaHdUv0v/u0P9Vm0e3uEWu9lHn8vbMcA5/9QX
         agOT78/XUNClTimIO5+2hEGBKjNgLBjeHqsDlpdOtSntj1w8KKvhiAKs9o0gHVDt4V
         Y3/arje4XF9RPFZPKK1rxbvo0qi+W03VG3j7gbJ4BflIvY4lWzL
Date:   Tue, 1 Mar 2022 01:25:40 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elia Pinto <gitter.spiros@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] test-lib.sh: Use GLIBC_TUNABLES instead of MALLOC_CHECK_
 on glibc >= 2.34
Message-ID: <Yh12FNTGuJkRlqBE@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Elia Pinto <gitter.spiros@gmail.com>, git@vger.kernel.org
References: <20220228160827.465488-1-gitter.spiros@gmail.com>
 <xmqq7d9e249n.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Wf7uqRc0lQvly4vt"
Content-Disposition: inline
In-Reply-To: <xmqq7d9e249n.fsf@gitster.g>
User-Agent: Mutt/2.1.4 (2021-12-11)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Wf7uqRc0lQvly4vt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-02-28 at 19:13:40, Junio C Hamano wrote:
> Elia Pinto <gitter.spiros@gmail.com> writes:
>=20
> > In glibc >=3D 2.34 MALLOC_CHECK_ and MALLOC_PERTURB_ environment
> > variables have been replaced by GLIBC_TUNABLES.  Also the new
>=20
> Does it hurt to have these older environment variables?  If not,
> we would prefer to see redundant but less deeply indented code,
> I would imagine.

Setting both sets of environment variables is probably just fine and the
simplest solution, I'd imagine.

> > +	if type -p getconf >/dev/null 2>&1; then
> > +		_GLIBC_VERSION=3D"$(getconf GNU_LIBC_VERSION 2>/dev/null | awk '{ pr=
int $2 }')"
> > +		if [ -n "$_GLIBC_VERSION" -a $(expr "$_GLIBC_VERSION" \>=3D "2.34") =
]; then
> > +			_HAVE_GLIBC_234=3D"yes"
> > +		fi
> > +	fi
>=20
> Style.  We prefer "test ..." over "[ ... ]" and more importantly we
> don't use "test X -a Y".
>=20
> Do we absolutely need "test -p getconf" with an extra indentation?
> I suspect we don't.

getconf is specified by POSIX, but that doesn't mean it's in the default
install or in PATH on all systems.  However, we should write "command -v
getconf" instead if we need to check, since that's the POSIX way to
write it, and "type" is not guaranteed to be present on all systems.

It looks like the code might silently not match if getconf isn't
present, and if so then we can avoid the check, but we should of course
put a comment noting that behavior to help future readers.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--Wf7uqRc0lQvly4vt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYh12EwAKCRB8DEliiIei
gf3KAQD+RTP/cNrHWcPNJ5RG1bAA1+DFVLp9BmvHafVyPrDgbQEA/TnPChmDh4oe
S2sSTskGrULJQi4rc/y1hzPpCLjtZww=
=vm/o
-----END PGP SIGNATURE-----

--Wf7uqRc0lQvly4vt--
