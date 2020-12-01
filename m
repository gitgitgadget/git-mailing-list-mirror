Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D78C83013
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 09:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B20320657
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 09:57:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="sq+bMr3D";
	dkim=temperror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L5V9uSvl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391013AbgLAJ5K (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Dec 2020 04:57:10 -0500
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:47593 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390891AbgLAJ5K (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 1 Dec 2020 04:57:10 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 6CE24FC2;
        Tue,  1 Dec 2020 04:56:04 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 01 Dec 2020 04:56:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=tK5qa14bFMWh76V5qRtOI6Q1pqZ
        mhqkim8WMqrFmIIQ=; b=sq+bMr3DXWiSENHhwfmi5MVNx9zHLRkojMyQ9W8eBR6
        ICwKK3HJjnoh9rCl8FgWB2spcJ3voqhtHJjWPao5QyQFAsh4lrVgq7Ic47FWJBPW
        WdQ3gXsOlIP7S0xuZjCP2XtXtrRYWsTwB7urtZHoMF18hvPj88xzMe2iNJ/ih9Hv
        k1yOAvNz/kULvQkX/EpMhPw5g2fSFd4b0CePToQMV4VFJnSg5pDnrc0wDUeiNT4h
        GbcVcBgAbxwblOZVu3gBigBNT8REsWfmPpDJ4M5uJZ2pTURZb1y0HkYJNpHzQwew
        o9MTu0rPf8govdxm4u/2Ijt25OIhL7G8QpGrgcMUh7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=tK5qa1
        4bFMWh76V5qRtOI6Q1pqZmhqkim8WMqrFmIIQ=; b=L5V9uSvlOfgtuEG+WHAyqq
        0fiDvRB7tX6UU0QKn6RFRVV/t13w0rnh7/gm+kYdakpMZzbdpKU8SxcFmjCvun52
        jdp8p5X6RahXidDvq7RCbV+BE2pMgCyFYa2fRMcvz1FTjq2GzFBHUN2bbnZqWDBE
        IK+f932k5HaNBWbircK4kA34qaRLLy0kyAXJWH73CCvGAuvpxD5PAL0G/4GTVRWP
        CbwIbWhLNy3sUN4HSnwl/U4PPYMpj+5db73Gw0jnYRbXA7AYp1jnAa12wXznAQQ3
        MbjpuIh5hculbQF57/mn9uaUoq52CE/c8ZVIlVopJ14W6iw8Cq5H3MZfXzum2nEg
        ==
X-ME-Sender: <xms:MxPGXwJFAp6lNI_uQ0sdTkeCRSIq2kFjol7HsH9WW8Bly_Jtlh2lBw>
    <xme:MxPGXwJKxfJb1BvNnMRc0wfkP9mXE2lSti4WgXr8IMfDP5zBSVFcmMd8FxHR-5v2E
    OqwT3JWsyjefofVJQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudeivddgudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucfkphepjeekrdehgedrudegrdehjeenucevlhhushhtvghrufhiiigvpedunecurfgrrh
    grmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:MxPGXwuntoul_vXJah4Z8vlonApIeCZ-1iEzQ7pNSQcg-ObkqIUSOg>
    <xmx:MxPGX9Zt4GOEzmG5a0KMjcO3gvoWBtSzM3r-ZuA2RFQpDQg5di2yQA>
    <xmx:MxPGX3bMyDrERT2Zk5h1kalZzQzBOp6k4q5cht2C4HU2f5ZZ6eeDtA>
    <xmx:NBPGXzFWuVqI4pWLfmYcyeGdd2jJmCqYb34YsmYt-z_QHv4celSrPg>
Received: from vm-mail.pks.im (dynamic-078-054-014-057.78.54.pool.telefonica.de [78.54.14.57])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1BED4108005B;
        Tue,  1 Dec 2020 04:56:03 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 96ea7146 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 1 Dec 2020 09:56:02 +0000 (UTC)
Date:   Tue, 1 Dec 2020 10:56:00 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philip Oakley <philipoakley@iee.email>
Subject: [PATCH v3 2/4] config: extract function to parse config pairs
Message-ID: <808c311925b650339b8a1494554df0b1a0bfa30f.1606816110.git.ps@pks.im>
References: <cover.1606214397.git.ps@pks.im>
 <cover.1606816110.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ex722sY3MG//vbKN"
Content-Disposition: inline
In-Reply-To: <cover.1606816110.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--ex722sY3MG//vbKN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The function `git_config_parse_parameter` is responsible for parsing a
`foo.bar=3Dbaz`-formatted configuration key, sanitizing the key and then
processing it via the given callback function. Given that we're about to
add a second user which is going to process keys in such which already
has keys and values separated, this commit extracts a function
`config_parse_pair` which only does the sanitization and processing
part.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 config.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/config.c b/config.c
index 8f324ed3a6..4ae3711d3d 100644
--- a/config.c
+++ b/config.c
@@ -437,11 +437,26 @@ int git_config_key_is_valid(const char *key)
 	return !git_config_parse_key_1(key, NULL, NULL, 1);
 }
=20
+static int config_parse_pair(const char *key, const char *value,
+			  config_fn_t fn, void *data)
+{
+	char *canonical_name;
+	int ret;
+
+	if (!strlen(key))
+		return error(_("empty config key"));
+	if (git_config_parse_key(key, &canonical_name, NULL))
+		return -1;
+
+	ret =3D (fn(canonical_name, value, data) < 0) ? -1 : 0;
+	free(canonical_name);
+	return ret;
+}
+
 int git_config_parse_parameter(const char *text,
 			       config_fn_t fn, void *data)
 {
 	const char *value;
-	char *canonical_name;
 	struct strbuf **pair;
 	int ret;
=20
@@ -462,12 +477,7 @@ int git_config_parse_parameter(const char *text,
 		return error(_("bogus config parameter: %s"), text);
 	}
=20
-	if (git_config_parse_key(pair[0]->buf, &canonical_name, NULL)) {
-		ret =3D -1;
-	} else {
-		ret =3D (fn(canonical_name, value, data) < 0) ? -1 : 0;
-		free(canonical_name);
-	}
+	ret =3D config_parse_pair(pair[0]->buf, value, fn, data);
 	strbuf_list_free(pair);
 	return ret;
 }
--=20
2.29.2


--ex722sY3MG//vbKN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl/GEzAACgkQVbJhu7ck
PpQaOA/9GbN0CEZhYJfWw0optbfwD1sGqC+xdTxncCJgUzncZ3qAmp1+jeTmUCXA
ahmUP3QmKnsiUMaWc3hYxM00JTETnWjYulu0iqo5+XabsoesxBCO8FwS0eRi4o8p
5KCe9oXHSnpCSh7dc1bARLM/qJYUvxiFxeAfipX0Bii/saUTusObo/2hNrYv1CPD
DQSKFVdpfq+de71fdZ8XiH3HC6n1t5AsVXLWxpC5l6oBI0oQRaftKpfi9NUrd44O
vyXVCbmk11Gca8OtEDsFPtziiZ+JZC/84lcp3D2H2QaERwdlEmG+gaOVhBdOXcLc
nrYdWbATU6m8Vpv0zD/CkHsYYjJErH3pQKhcJmlMUJGtJWXr84CjY7BSPShjSzoI
bl3aWIxx9nUfkOG9oQ9lszSqVYuJDLrZVa+i0NZaIt7bdVAQdaQalbjmDJ+okO0V
gXSJUyBH0GPjZzve9Ig/Zc12DVAf7EJFBbhlU+kPh+6sNZ+Lbob11xc62FzJkY67
bAjvwBqryvcCfVhSRfmdCGB2mfsYl4Gkeqqh9LQOyC40BUN6yR0bfbXcL9ziVexb
sSl4ON2qhEQQdigOMIn6FQrer6KCpE7ia5575SX70jeafrhWBmi8UAiCDPYsGvNH
Jia4DxCSImWqKHvRWM1j2BkoRLXPPSExgwRJJ6xMjsk6vGWmUfQ=
=SsuC
-----END PGP SIGNATURE-----

--ex722sY3MG//vbKN--
