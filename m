Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51923C4708E
	for <git@archiver.kernel.org>; Tue,  6 Dec 2022 22:17:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbiLFWRM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Dec 2022 17:17:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiLFWRJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2022 17:17:09 -0500
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C785549B5C
        for <git@vger.kernel.org>; Tue,  6 Dec 2022 14:16:56 -0800 (PST)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id F3FF55A59F;
        Tue,  6 Dec 2022 22:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1670365016;
        bh=HDga6TJ0z5I/pcYQNPac1AjxJ5RetlcNvwnVVZQ+2UM=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=IqWddD8vF7V6RuRaC3e4R41GSewIYUxEuspTPXWMzgrPdqZhSmP+s3hG+TfUfk1K7
         RkeBqD1PkZR3HjAg5S1qK6pZs+K6H4+HnckDbejAuVxVZpJQ+5XBkB0QL9Gs4mEIzv
         1dYqetmfrP/RBJOwMlf98oFMCmzX8DU193c7WSmxFzQm/OenL3sPEO8KESfbuwc3Ka
         EgNn3c7XZ9zCmZ+U2dSRbM2riD9xYYVg0vWfNNAn7RcXON7CNLKteUi8/fFopV/1yf
         esWdagYAH1tJO32ZGtu6inP/OlTDkNCW1aqwSHnE/3a1OzPOZ1skIFehUOny831npu
         cs/WXSfFpzHMwXaar35XZ2Ydh0OidZgP2l1o3p3GzVGs9kZBLcOSiJRsl7BsNad/yi
         ESH0HJUQYTKbjlrS+x+m+jrVydSbQeOIRMi47A7D3V2gwtrNruQJU4u9Kb++8bE+l4
         ca1l4tDfz87uW6hLzM98+Wk3tU/rxjwfc+SnPweoJml0/prXK6a
Date:   Tue, 6 Dec 2022 22:16:53 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Gennady Uraltsev <gennady.uraltsev@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Git credential store conflicting configuration leads to
 unexpected behavior
Message-ID: <Y4+/VQly2NKnMrFY@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Gennady Uraltsev <gennady.uraltsev@gmail.com>, git@vger.kernel.org
References: <CACH4KQSutGnoyFGP2RmkwQT3yhnEg1RcvedXVSMOVVDAnz_aFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vKfO0KHua6vTYLMe"
Content-Disposition: inline
In-Reply-To: <CACH4KQSutGnoyFGP2RmkwQT3yhnEg1RcvedXVSMOVVDAnz_aFg@mail.gmail.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--vKfO0KHua6vTYLMe
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-12-06 at 22:05:22, Gennady Uraltsev wrote:
> Hello everyone,
>=20
> I have an issue with git credential-store. In my global configuration
> dir  (.config/git/config) I had the line
>=20
> [credential]
> helper =3D store
>=20
> while ini a repository's .git/config while I have
>=20
> [credential]
> helper =3D "store --file=3D./.git/git-credentials"
>=20
> to store credentials "locally".
>=20
> I thought the latter would overrule the former However what happens is
> the following:
>=20
> 1) On first run the file repo-local file ./.git/git-credentials gets
> created and the credentials are saved there after the user is queried
> for a password
> 2) On subsequent runs the credentials get recovered from
> ./.git/git-credentials and the user is NOT asked for credentials
> 2b) **Here is the weird behavior** git ALSO creates the
> .git-credentials file in the home directory and saves a copy of
> credentials there.
>=20
> The behavior 2b leads to exfiltration of passwords to a location a
> user might not expect.
>=20
> Workaround: Remove the line
>=20
> [credential]
> helper =3D store
>=20
> in the global config.
>=20
> It seems that the global config somehow does not get shadowed by the loca=
l one!

This behaviour is by design.  The reason is that sometimes the user may
have two sets of credential helpers, one for one set of domains, and
another for another.  For example, I believe AWS has its own custom
credential helper.  Git calls credential helpers until it finds a
credential, and then it sends store commands to all of them.  A
credential helper which has no credentials for a domain will generally
respond with no credentials.

If you want to override the credential helpers in the `.git/config`
file, you can do so by first writing an empty value, like so:

[credential]
helper =3D
helper =3D "store --file=3D./.git/git-credentials"
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--vKfO0KHua6vTYLMe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCY4+/VQAKCRB8DEliiIei
gbS9AP41NzORxbR3MISb1ufTesEG1U0Px+jRZBMwhL0IzZ+q3wD/Z4rUAW5reBEu
EyFloIoXQzoP6tyerU+gvixuJP45sQw=
=u+RF
-----END PGP SIGNATURE-----

--vKfO0KHua6vTYLMe--
