Return-Path: <SRS0=r8De=BV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B221EC433DF
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 09:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 302202078E
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 09:33:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AQf3sohX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JmUywk/n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728448AbgHKJdt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Aug 2020 05:33:49 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:36365 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728377AbgHKJds (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 11 Aug 2020 05:33:48 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 11B41678;
        Tue, 11 Aug 2020 05:33:47 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 11 Aug 2020 05:33:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=/NWi8AfeET7C+P/TktTJXWs0QG5
        JOQHlssOkudQFqiM=; b=AQf3sohXyfkL/Mail1F2noggsOUnUbWM3HoF4VEd7+2
        Akcr+tmwgzW0g8NJ7QW2y1TfZBCP5Hum03n5BPPPQFsTj4+2FnAN38E70NViXUce
        SoxzTRwjYJH6cAFG+REV3XyEy3rrFihg52ofa3s4Bv4sY6kGzBQlVyXwuaEeqbwz
        Moqeen/Z9g+w9OA4Fy+0BxI4wcp++aRSw5inwnLkkkRacQWjefPpmqfVoSpb2WDc
        Wnw2KXBgnmaFRkxEKDRrqavE5q5erKeHwBKt9qKk1Jv1CnuItf/bP/pvfVr0ucjV
        6lG+SHdXzxHkoqAnM55Yjc/CBDThf7SwC1D9DJXNFAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=/NWi8A
        feET7C+P/TktTJXWs0QG5JOQHlssOkudQFqiM=; b=JmUywk/nbMOsUsU1S63P9K
        zNDOwKmq3R2vWB6t3o9A3RNc2ipDmhcZnDAmgPrnjuaPWaVcgVmAleHi8PxXZsxk
        Po6PXOJ5mvQKHbPIbYvc+Ezuan25YNOycZJNkDfRA0IUkcjm3ePh/gNpy/H8fgFm
        xApGekOGXSYXUotGDVqM0xp6lCQJMngGWifM2NpfLxXy4DB2xSO3fKctQBYlCbpj
        e6xuimNByj8lpJHQHLrP16zOhwzefc5MfO27HAj0cwlO4CF0jeRzcFVHmk9rlT1q
        C5OGvd5aTwAmMdpbx7yfFPtT8P8TNF+rtFwUMguDs9nyXlMdJd5HeSoTaLJ/peEA
        ==
X-ME-Sender: <xms:-mUyXy-dhL1w_XABfBlg1qWdcGrhdSXFsT0uSy0_ccdzRzVFtbyvxQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrledtgddujecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtdfhvd
    ejkedthfehvdelgfetgfdvtedthfenucfkphepjeekrdehgedrheeirddukeeknecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himh
X-ME-Proxy: <xmx:-mUyXytD-cfgJiqDmdcNqvCbFqL9_IEZHwucBkioLt2et9CPSkVrng>
    <xmx:-mUyX4CTfkQpVT5eVaDEOV2VOWLaCf9fmn1iXa0uofR13uVwmA0UEQ>
    <xmx:-mUyX6c5TSH9vNJRQRB1YLho0O_1zxorW3hmApgCSQey8TgAyE35aw>
    <xmx:-mUyX5WgumsyWL3TzAXZhVAEnCaYgkF4dHMF8bjL28PQxlnw4paEvw>
Received: from vm-mail.pks.im (x4e3638bc.dyn.telefonica.de [78.54.56.188])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8A9813280064;
        Tue, 11 Aug 2020 05:33:45 -0400 (EDT)
Received: from localhost (tanuki [10.192.0.23])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id dbaf88d6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 11 Aug 2020 09:33:41 +0000 (UTC)
Date:   Tue, 11 Aug 2020 11:33:46 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2020, #02; Mon, 10)
Message-ID: <20200811093346.GA33378@tanuki.pks.im>
References: <xmqqsgcub811.fsf@gitster.c.googlers.com>
 <20200811065347.GA1486938@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="M9NhX3UHpAaciwkO"
Content-Disposition: inline
In-Reply-To: <20200811065347.GA1486938@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2020 at 02:53:47AM -0400, Jeff King wrote:
> On Mon, Aug 10, 2020 at 12:44:26PM -0700, Junio C Hamano wrote:
>=20
> > * ps/ref-transaction-hook (2020-08-07) 1 commit
> >   (merged to 'next' on 2020-08-10 at d8ad7cc8f6)
> >  + refs: fix interleaving hook calls with reference-transaction hook
> >=20
> >  The logic to find the ref transaction hook script attempted to
> >  cache the path to the found hook without realizing that it needed
> >  to keep a copied value, as the API it used returned a transitory
> >  buffer space.  This has been corrected.
> >=20
> >  Will merge to 'master'.
> >  to be followed by a removal of the caching feature, which does not
> >  seem to help even as a negative cache.
>=20
> I noticed this had a CI problem. Fix is below.
>=20
> -- >8 --
> Subject: [PATCH] t1416: avoid hard-coded sha1 ids
>=20
> The test added by e5256c82e5 (refs: fix interleaving hook calls with
> reference-transaction hook, 2020-08-07) uses hard-coded sha1 object ids
> in its expected output. This causes it to fail when run with
> GIT_TEST_DEFAULT_HASH=3Dsha256.
>=20
> Let's make use of the oid variables we define earlier, as the rest of
> the nearby tests do.
>=20
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  t/t1416-ref-transaction-hooks.sh | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/t/t1416-ref-transaction-hooks.sh b/t/t1416-ref-transaction-h=
ooks.sh
> index d4d19194bf..f6e741c6c0 100755
> --- a/t/t1416-ref-transaction-hooks.sh
> +++ b/t/t1416-ref-transaction-hooks.sh
> @@ -7,6 +7,7 @@ test_description=3D'reference transaction hooks'
>  test_expect_success setup '
>  	mkdir -p .git/hooks &&
>  	test_commit PRE &&
> +	PRE_OID=3D$(git rev-parse PRE) &&
>  	test_commit POST &&
>  	POST_OID=3D$(git rev-parse POST)
>  '
> @@ -120,10 +121,10 @@ test_expect_success 'interleaving hook calls succee=
d' '
>  	EOF
> =20
>  	cat >expect <<-EOF &&
> -		hooks/update refs/tags/PRE 0000000000000000000000000000000000000000 63=
ac8e7bcdb882293465435909f54a96de17d4f7
> +		hooks/update refs/tags/PRE $ZERO_OID $PRE_OID
>  		hooks/reference-transaction prepared
>  		hooks/reference-transaction committed
> -		hooks/update refs/tags/POST 0000000000000000000000000000000000000000 9=
9d53161c3a0a903b6561b9f6c0c665b3a476401
> +		hooks/update refs/tags/POST $ZERO_OID $POST_OID
>  		hooks/reference-transaction prepared
>  		hooks/reference-transaction committed
>  	EOF
> --=20
> 2.28.0.532.g36127779a4

Reviewed-by: Patrick Steinhardt <ps@pks.im>

Thanks for cleaning up after me!

Patrick

--M9NhX3UHpAaciwkO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl8yZfkACgkQVbJhu7ck
PpTFOg//VEk5oNd1xVR/qrias2tyjp60SyAoUzc7lNmpiMK+7Y85UafS4QNMDupV
Bxta8hlqLzNBlG4TorYc2MQPGS90RSeNaaABTDFxVMP2PVqy6AYQyXnGBlxNXqe1
ARfRmDRnKS2UsU+gELWrpPuphEBVmjmC0pFOR2mzKtV48o7J4Xf5xuatonsR2lzN
zjndEPSv+b+2y/w3zK/lZrnNQ9hfeIRTyKaiJ+cMo7Zw6IKtJa6Iwok4Mtv3uwFA
MHDRjmQUQF9nGTtbsOSALbfUVE0SEGxp6bYtJ2O+DB9sRBlh9jRBxugMcW7pHYZk
UKJ+584zQFz7vFJSEniptKFTtLnJEiJt94E0K5E+YJG6rA/h75jmwFapRYyGjrE3
OK2qqWrtpIYs6COQ3P1hErkePy+WLmoST3PnijSH8XpLPoWPqNHBtbv5IYHobYhU
WrUGxYi6ugaC76xkgw+lK0lxEEX0BtybKZsLqJ6aGzLj1wH1P47PN2UveeCUq1FF
nxjkIh93+wP8A8h+sCK5D3YktPaCHd7eRg5vhai8oPe77KyUlf66wSKQPxol9Oww
sIcc4iTvi/ZBpvCkS7imL7+POlN6r3zizn6VUYLnWOxQ8gUVVrCwkB0AfunQAvRx
hg1h2xCG3sA9NmMHLwdZucGq1EJz0refPZot5oP3E7ORUNJ6zHI=
=CE2q
-----END PGP SIGNATURE-----

--M9NhX3UHpAaciwkO--
