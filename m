Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E57D0C64E8A
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 09:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E117204FD
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 09:57:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Wnhgca1k";
	dkim=temperror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Xmmq+x9z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387998AbgLAJ45 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Dec 2020 04:56:57 -0500
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:57577 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726099AbgLAJ4y (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 1 Dec 2020 04:56:54 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 7C10B10DC;
        Tue,  1 Dec 2020 04:56:08 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 01 Dec 2020 04:56:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=jQhzEDNugqF5FXpljMDT9A/CU8J
        tSRaxwe3fZ5w/WzY=; b=Wnhgca1kQlsQ09EeVxxDdfObyNTRCl0mPfXYCAL0rb5
        mWJui9j5o4jDAbWXjoxJ/ZeH40x4q1CM4UqIuq77eRNw25XTNJlgYK1tNY084nwZ
        g0ZuyVCmcDrpDd9PudMoHtZ75A9q4OGwfzaVCGjvTljmCxr6cJ/54GuhlVB5COqh
        vJ3DcNyTUXPQpOjj/37axtwl8bsCnBd3gAulwh2Mu4Xim6zcpnhy9p+vpOIzeH0f
        mQ71mcfGOSZciCLhZLMeGBND44iXPfgTxShfhW3S0F2qzsjsnw+LqYqzCiqoRa+S
        /bsEvzr9+BeIA+vp2f8oI8y80+QVwn6ZNWuTv+p+ulw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=jQhzED
        NugqF5FXpljMDT9A/CU8JtSRaxwe3fZ5w/WzY=; b=Xmmq+x9zkLlORSLB0ld0dz
        oqTySfSJ8VuK+MT7s22m96NOHAYZ1FpH8XwbUpOW3KwW8pAZTwvBa4D9kG5A/VyY
        hTHZJICFvU3McCx9hozaAG3Np2ddCS4LiLci+NuBcnvl918QFX9Fz/1mHqK3hZnE
        iDQ/DH5bVNLHNABz40OI+Vxtk/SpM/+4XQv7NhiKG1BYiwcsQmj0bMZulGuyMeJo
        0vH5EdJ1+vBfntYqgrufVkFnn2wm8jXLoGu+LbbGI5So35W1y4lYA96ra2WCXq6r
        u9MsyYZKzUodYZ1JL5opAheaB3pXyYouxzsAzmIovKRNiQglYoWxZGRokvfJh97w
        ==
X-ME-Sender: <xms:OBPGX_KlxhtGGqxaJr1WuhdOdIeDUfhb8U21YSNCszoxlkhxdrMbrg>
    <xme:OBPGXzIwumslgSgSANB4EElQ_HZ7hsUqkSNj6UCfWNa6Gd_U5wzSfV4ZfMALuVMJy
    qRochvNkNz_i40vdg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudeivddgudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucfkphepjeekrdehgedrudegrdehjeenucevlhhushhtvghrufhiiigvpedvnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:OBPGX3vJC-c0imGaFssXidwIMrzSCW726TkvFbL-aRNMAlQnwfICvw>
    <xmx:OBPGX4a3UKOeyxlrAm2RMFFs-9miGFQ5IQ71lomEax48IQovgTKuTA>
    <xmx:OBPGX2ZMDK6SK7EPn0WJayk0v9owhs3K5BbPzCAeHSc7kTZlLeutpw>
    <xmx:OBPGX2FlIFezkdXNfwex6sgNAyOwNGZTpAKPWEe2ei8n8lEEOt54ew>
Received: from vm-mail.pks.im (dynamic-078-054-014-057.78.54.pool.telefonica.de [78.54.14.57])
        by mail.messagingengine.com (Postfix) with ESMTPA id 245F71080064;
        Tue,  1 Dec 2020 04:56:07 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id ded81522 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 1 Dec 2020 09:56:06 +0000 (UTC)
Date:   Tue, 1 Dec 2020 10:56:05 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philip Oakley <philipoakley@iee.email>
Subject: [PATCH v3 3/4] config: refactor parsing of GIT_CONFIG_PARAMETERS
Message-ID: <357084c9dc545331f2b8d2e25bb1d2b104c8c4f4.1606816110.git.ps@pks.im>
References: <cover.1606214397.git.ps@pks.im>
 <cover.1606816110.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XmSXAeY6P9Ne5Qgd"
Content-Disposition: inline
In-Reply-To: <cover.1606816110.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--XmSXAeY6P9Ne5Qgd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We're about to introduce a new way of passing parameters via environment
variables to git, which will require us to change the way we parse
config entries from parameters. Currently, `git_config_from_parameters`
is written in a way which makes it rather hard to extend.

Refactor the function to make it ready for the new logic as a
preparatory step in order to avoid reindenting code and adding new logic
in the same step, which would be much harder to reason about. This
refactoring is not expected to change any behaviour.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 config.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/config.c b/config.c
index 4ae3711d3d..ba67706854 100644
--- a/config.c
+++ b/config.c
@@ -484,35 +484,36 @@ int git_config_parse_parameter(const char *text,
=20
 int git_config_from_parameters(config_fn_t fn, void *data)
 {
-	const char *env =3D getenv(CONFIG_DATA_ENVIRONMENT);
+	const char *env;
 	int ret =3D 0;
-	char *envw;
+	char *envw =3D NULL;
 	const char **argv =3D NULL;
-	int nr =3D 0, alloc =3D 0;
 	int i;
 	struct config_source source;
=20
-	if (!env)
-		return 0;
-
 	memset(&source, 0, sizeof(source));
 	source.prev =3D cf;
 	source.origin_type =3D CONFIG_ORIGIN_CMDLINE;
 	cf =3D &source;
=20
-	/* sq_dequote will write over it */
-	envw =3D xstrdup(env);
+	env =3D getenv(CONFIG_DATA_ENVIRONMENT);
+	if (env) {
+		int nr =3D 0, alloc =3D 0;
=20
-	if (sq_dequote_to_argv(envw, &argv, &nr, &alloc) < 0) {
-		ret =3D error(_("bogus format in %s"), CONFIG_DATA_ENVIRONMENT);
-		goto out;
-	}
+		/* sq_dequote will write over it */
+		envw =3D xstrdup(env);
=20
-	for (i =3D 0; i < nr; i++) {
-		if (git_config_parse_parameter(argv[i], fn, data) < 0) {
-			ret =3D -1;
+		if (sq_dequote_to_argv(envw, &argv, &nr, &alloc) < 0) {
+			ret =3D error(_("bogus format in %s"), CONFIG_DATA_ENVIRONMENT);
 			goto out;
 		}
+
+		for (i =3D 0; i < nr; i++) {
+			if (git_config_parse_parameter(argv[i], fn, data) < 0) {
+				ret =3D -1;
+				goto out;
+			}
+		}
 	}
=20
 out:
--=20
2.29.2


--XmSXAeY6P9Ne5Qgd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl/GEzQACgkQVbJhu7ck
PpTyPxAAiLPnksFyBMkRwSPxFedtP4q8znBlEvo3GRgmqe+ZUi1KHk2a+XxQPV1M
VA0Cry4lpjYHMAMrE6kyuOIUKVtO9du1LIqemVfN1X+71o32W+DC8sRqz7+5O4Kz
jWxid5wyHcu/O7Jz1BGwmRjjBV/aY66/5tjxHO/AI2HQOZqFsTDPGSD2ONpSbheU
5eRmbUD1q3KdEwMDEblXPtDPEO/JGn/EELBKhJTj3cJwaTgrcuQvOv1RURNjMOJ7
kteX9lr3cP3ROylf5goGprbqJ/s/ZUkU6jO16mLpgsW4xuW3lFtOwzfAnJ+Z7REC
DVXRqCUELBSL8Xk8+4qkDzJDCvXbY3rk2wB236TOBuH8qZZmCenb6jwDqsm+qU3v
JraAEVl2+a6v+IdMZtPZzNwVvvAFc+JUf6tTfSJ5oOcgA8lIo4k09hG3Nne9tFQR
ntmpJSQxRwlOPF18CRHe+grF2GI82RarQ5elA2LFzbxLdPpQ3R591K/IrMFdy2Ug
SwB2AgHAkV3N2SUiSaeZcfBjxAYMXJQZt1g2oKKPNtKx4O5C1hoFcDS94SX0jhHZ
r6zTe/if3Gs/C8aPhJsHB8i6ijvFjajLS8cmx/LJQpvSt3LGvALhAz5re03APPgc
1nKb5lF1CeY1Y/6mu+p4ibYJ/IiW3V0WN92balUXqbo4LgUlhb4=
=aLEw
-----END PGP SIGNATURE-----

--XmSXAeY6P9Ne5Qgd--
