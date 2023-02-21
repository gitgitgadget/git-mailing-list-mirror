Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D262C6379F
	for <git@archiver.kernel.org>; Tue, 21 Feb 2023 23:03:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbjBUXDF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Feb 2023 18:03:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjBUXCj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Feb 2023 18:02:39 -0500
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61FC0311C2
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 15:02:37 -0800 (PST)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id E55075A460;
        Tue, 21 Feb 2023 23:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1677020555;
        bh=BOyP2AA/wa9QMRC8D6vBWEEEneMjJTGTwVuCsI2JaEc=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=vV7EXyiQrBMr3BaW7zsV94CEwH/NUchhGpXBPQ59/Pbv14vdouUC28fTcA6NpSCB3
         DEI+CsL0iGsqm7T8xMBGIcFR2rtnq99ZJmzacLSt3ho4CNROfLStI4WOrt/xDFgIWe
         MQxfx597igTkyYf8G1E4hBVJgbj5Z0SmtW3CqwsLYojbz6g0u+ZvP0ECIABsGQx16i
         OCNn6sGl4tcaI9OwVDQ+HhEJHhGboJYQihyb+Ao6yYaY/w+a1N/LzRjTFSY0AOmPAR
         WxZkkxQ0qUX9fex2rWxsp5hlyUuqQnLfB7SMQU2dkqnpCsMW5YSZfFHgBdcfcUSw3S
         pLLyAuH+jBQ3SxMuMWRc95o4Far5I4zudNmQ3J+Vx3oLXzpuIQcHLsmDomvk6s86oI
         GY+G4M6nLcqqI7XpZfDdPrcsmS1pB9TIyTtNHrLD4lrjtG3XODdpYHrNu5ZCS6mDsS
         4g/9PPhgPHUWRqcueAkKPklhRQxkK7k+3oAGZW0rpnaihg2KEHB
Date:   Tue, 21 Feb 2023 23:02:34 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Sean Allred <allred.sean@gmail.com>
Cc:     Sean Allred <sallred@epic.com>,
        Kyle VandeWalle <kvandewa@epic.com>, git <git@vger.kernel.org>
Subject: Re: [BUGREPORT] Why is git-push fetching content?
Message-ID: <Y/VNiuI7OZ2YiXx8@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Sean Allred <allred.sean@gmail.com>, Sean Allred <sallred@epic.com>,
        Kyle VandeWalle <kvandewa@epic.com>, git <git@vger.kernel.org>
References: <m0ttze4qzl.fsf@epic96565.epic.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sMUoDbrajXt7yg/f"
Content-Disposition: inline
In-Reply-To: <m0ttze4qzl.fsf@epic96565.epic.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--sMUoDbrajXt7yg/f
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-02-21 at 22:01:04, Sean Allred wrote:
> What did you do before the bug happened? (Steps to reproduce your issue)
>=20
>     # in a new directory,
>     cd $(mktemp -d)
>=20
>     # initialize a new repository
>     git init
>=20
>     # fetch a single commit from a remote
>     git fetch --filter=3Dtree:0 --depth=3D1 $REMOTE $COMMIT_OID
>=20
>     # create a ref on that remote
>     git push --no-verify $REMOTE $COMMIT_OID:$REFNAME
>=20
> What did you expect to happen? (Expected behavior)
>=20
>     I expected this process to complete very, very quickly. We believe
>     the version where it had been doing so was ~2.37.
>=20
> What happened instead? (Actual behavior)
>=20
>     The fetch completes nearly instantly as expected. We receive ~200B
>     from the remote for the commit object itself. What's truly bizarre
>     is what happens during the push. It starts receiving objects from
>     the remote! By the end of this process, the local repository is a
>     whopping ~700MB -- though interestingly only about a tenth of the
>     full repository size.
>=20
>     This result in particular is strange in context. I would expect to
>     either see 'almost all' the repository content, 'about half' (we
>     have two trunks and fetching a single commit would at most fetch one
>     of them), or 'virtual none at all'. There isn't a straightforward
>     explanation for why 'one tenth' would make sense.

It's hard to know for certain what's going on here, but it depends on
your history.  You did a partial clone with no trees, so you've likely
received a single commit object and no trees or blobs.

However, when you push a commit, that necessitates pushing the trees and
blobs as well, and you don't have those.  If the remote said that it
already had the commit, then it might push no objects at all (which I've
seen before) and thus just update the references.  However, if it pushes
even one commit, it may need to walk the history and find common
commits, which will necessitate fetching objects, and it will have to
push any trees and blobs as well, which also will require objects to be
fetched.

My guess is that this is probably made worse by the fact that this is
shallow, and that necessitates certain additional computations, which
means more objects are fetched. However, I'm not super sure how that
code works, so I think it may be helpful for someone else to chime in
who's more familiar with this.

If you want to see what's going on, you can run with
`GIT_TRACE=3D1 GIT_TRACE_PACKET=3D1`, which may show interesting information
about the negotiation.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--sMUoDbrajXt7yg/f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCY/VNigAKCRB8DEliiIei
gQ8CAQDsroafKF1zcpKys+2emy5Wu16kJ2mCP+XGXu8Dabe5sAEAvlKlk2mEaZa5
mjiYO0mmKyr2onVFgVtSrT5PQcgmwgQ=
=npVW
-----END PGP SIGNATURE-----

--sMUoDbrajXt7yg/f--
