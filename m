Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1668C7618E
	for <git@archiver.kernel.org>; Wed, 26 Apr 2023 21:28:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236285AbjDZV2g (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Apr 2023 17:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239673AbjDZV2e (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2023 17:28:34 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D7163C14
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 14:28:33 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 782525A2B2;
        Wed, 26 Apr 2023 21:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1682544512;
        bh=+MRFemOB7cZX+apNsCau4Eb49VRQYwq2B+Q8PtAF4AQ=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Ywr6wW2loPmyGspYGa0nUbzHKtWN7QO8upgve0hJf+Xuu6XlwKrsAjne5ma7ucjcs
         kFK3Uqu0DKGPnThZJ0KRcx7V2xOLFV4odX2tzqcK4jwXaPNp9Nj/D2eQuFRKMgKaVf
         OYVW50pyTn5QtNjYz4volWDND4+CiDaCuMNk/ovSSCz3h2dkjB69G5tE9smVFut+VQ
         5ZppwcMMLBVmdwW7iS97OO6iITwC3uWwlboiG3eMSW2qhUI35SSsTK6jq+adevq6qX
         7Fwcw7ILXD+r12EXeegQCMu/8FPIIpzGFRXaQB4h1BY8kFV6vF2wGmOCMXXceGeRIy
         FQawA8nPFWCl9pdFmDGLPmaRBKh+z5R2DLAbP8qA0cc1YY7E+V/y2kPoywXWTR61RT
         zInGiRst7VuKYr4tVQNNEecusCN7rrhXMks0VMSdsoGmLXwGbgqWwkkhYfbQQP5N8U
         ggLsyi7lLsY+G//lk8/9vAYZFZOkV8uiwln+i+6SMva6vJ1YWr1
Date:   Wed, 26 Apr 2023 21:28:31 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Adam Majer <adamm@zombino.com>
Subject: Re: [PATCH 1/2] http: advertise capabilities when cloning empty repos
Message-ID: <ZEmXf4m8Hoz0KyOX@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, Adam Majer <adamm@zombino.com>
References: <ZEmMUFR7AJn+v7jV@tapette.crustytoothpaste.net>
 <20230426205324.326501-1-sandals@crustytoothpaste.net>
 <20230426205324.326501-2-sandals@crustytoothpaste.net>
 <xmqqo7naqrb6.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="w0pYyV2pg0zMglHu"
Content-Disposition: inline
In-Reply-To: <xmqqo7naqrb6.fsf@gitster.g>
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--w0pYyV2pg0zMglHu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-04-26 at 21:14:37, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > From: "brian m. carlson" <bk2204@github.com>
> >
> > When cloning an empty repository, the HTTP protocol version 0 currently
> > offers nothing but the header and flush packets for the /info/refs
> > endpoint. This means that no capabilities are provided, so the client
> > side doesn't know what capabilities are present.
> >
> > However, this does pose a problem when working with SHA-256
> > repositories, since we use the capabilities to know the remote side's
> > object format (hash algorithm).  It used to be possible to set the
> > correct algorithm with `GIT_DEFAULT_HASH` (which is what the Git LFS
> > testsuite did), but this no longer works as of 8b214c2e9d ("clone:
>=20
> "this no longer works as of" -> "this was a mistake and was fixed by".

I tend to disagree.  While I agree that change is valuable because it
fixes v2, which we want, it does cause a change in user-visible
behaviour, which broke the Git LFS testsuite.  Whether we like things
working that way or not, clearly there were people relying on it.

Fortunately, in that case, Git LFS can just enable protocol v2 and
things work again, but I think "this no longer works" is accurate and
more neutral, and addresses the issue.  We wouldn't have to deal with
that issue if we could gracefully handle git clone --local with older
versions of the protocol, but one of the tests fails when we do that.
I'll take some more time to see if I can come up with a nice way to
gracefully handle that, and if so, I'll send a v2.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--w0pYyV2pg0zMglHu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZEmXfwAKCRB8DEliiIei
gZppAQChmqfvZds28Dk3JoWwNrkYdgv369g2eCgppAB69TpWXAEAtEJ7kLwBsE48
vVUQ6Yp4Jn65lBNnsIA7sJHB6QzTFQU=
=y1Lw
-----END PGP SIGNATURE-----

--w0pYyV2pg0zMglHu--
