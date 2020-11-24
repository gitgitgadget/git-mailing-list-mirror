Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C36D1C63798
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 10:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 577F42076E
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 10:51:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EbvclokJ";
	dkim=temperror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NFp/PKo3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731939AbgKXKu4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Nov 2020 05:50:56 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:55561 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731718AbgKXKuz (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 24 Nov 2020 05:50:55 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 51B0B1387;
        Tue, 24 Nov 2020 05:50:54 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 24 Nov 2020 05:50:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=ypWiN8aY5T/SeNDcRJU6nJf/IvY
        q5odHmdMOToGt14Q=; b=EbvclokJo2vZrj8IYA66YJwLRgD+UNVEQ6spbpqWr42
        ZE4E0q7v6cLXEdq6e2VP4RwH50x00bTPX3dA950snLs0M+bdOFK3/ayF57yhS9OP
        BSAdj6TV7xY3BpfeMsDZOJowSCR5W7lx9AgNNB9SUoCk4RoHAMuSPrN5/jc7bpF7
        IHtFWHHiOca/XCLtm1vNWOUZijucTJWt77O/SzkMF0L8a/qjw5FuF3DGw7jQ31sM
        PzrJPf8v6rp/SuI7wDai/7bq5dcDMrc0ctM24n4XIG4CBtboMdK88Hb0mudOAnVK
        omocAOJBrBwd+TPLO7323SjsUZP36AGyeD3M8Ygw8jQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=ypWiN8
        aY5T/SeNDcRJU6nJf/IvYq5odHmdMOToGt14Q=; b=NFp/PKo3c4GGByjRYwfJw7
        amaoQl3P+RE+Kdz1ItLThOJsvD5UA6hiapv+tBHAyUIu1/4rO/cZwPy/k4qfwPhO
        WFs4Sfwp9vdS7Htdrow/PJLhPDwBu5QITMkuCvWPAQW0Ls4YBy2l/4lPyDB8eYRN
        rrP4Feo8P21iXNyy1TZ+0iqRFteY03lJGE6fLju3pm+fL3Lya80XRQ1VECxvGrHJ
        sjGHD+siKU7MyL4xsNGepvo49jXi/fmUcgyCJDCIHBeIrOe6sunCEeZ4dpSbbwIj
        UVxS+QEFewWi10WZhsBBh2EI67GigSFqIW/hoEr+4tkWeQpIKYLkyB3t+FyznnCg
        ==
X-ME-Sender: <xms:jeW8X6bf201AX3ChkL_PYGZK4AkApBZfrzqnbZHGxmxEX8wq9q9A8A>
    <xme:jeW8X9Z5ixoI9afE1Q9VknivjZwKqdLhrfooSs4c_Akse15j5F-k9xHJd16rkjCUB
    bdRadFK1uHMykFMqA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudegkedgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucfkphepkeelrddugedrheegrdeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:jeW8X098gXkCrKc4bdGM2JmrAGLV5vDsVx1gJ25ku7fhnhpoGZ2H5w>
    <xmx:jeW8X8pTiHHY_w_dRiXliV7XTudAV0BJDbkY16QAq2wMmzJpf4UDfg>
    <xmx:jeW8X1rtznjXtMcNS7Y_K4B4IbWB1LjUqikRELcxxL6uEMMSYiSLeQ>
    <xmx:jeW8X8W95NS7kkS3A0NnqWAko9obKUGaLvyHJ2lzBjr9pf5-rgvXBw>
Received: from vm-mail.pks.im (dynamic-089-014-054-008.89.14.pool.telefonica.de [89.14.54.8])
        by mail.messagingengine.com (Postfix) with ESMTPA id ED98F328005D;
        Tue, 24 Nov 2020 05:50:52 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id d75c7281 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 24 Nov 2020 10:50:52 +0000 (UTC)
Date:   Tue, 24 Nov 2020 11:50:50 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philip Oakley <philipoakley@iee.email>
Subject: [PATCH v2 1/2] config: extract function to parse config pairs
Message-ID: <fa54f13a917cf2843fb7902f79d38cf55699fa07.1606214397.git.ps@pks.im>
References: <cover.1606214397.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jWtrPC7Qi8AHwHLP"
Content-Disposition: inline
In-Reply-To: <cover.1606214397.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--jWtrPC7Qi8AHwHLP
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
index 2bdff4457b..3281b1374e 100644
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


--jWtrPC7Qi8AHwHLP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl+85YoACgkQVbJhu7ck
PpSn/Q/8DqFdcCMrVg4kNzmiKCY51uT9CMy3DfVrklctoohjUTINOBCEYzU0KHEo
D/MbnD+Rn+e3VRWUornRo8EROcK2nVF/3XAHo26RxZIobf382AJ2Hx1yhrd36qSW
KVUh0iF7eXipOT6aB3Qo8tBSmIGUvTMyu8IUchAMiWjDL0alUqDuD//qBTWVgVXA
yGGy13IZWQfS3UgD3Zu3a4HMI5V9h4cPy+YGlvzLbqziKKlr08smxgmF87JprTgi
w2X7Vp0FWvH8kwS2mLj33dn+VH7iVMf6OxHOUOKEm62DGcG21Sn6gCc4o5S9sHHl
/vH3TmRctqYbwMm2OBDgU9pSVgz5RC7sihrZ1Hg/XsKqFZi1Z/7wHBvwYWnPDIEu
PcHIyVQfFtGgLnfAucwIyq/ds/zAnIHYuGrdcdrju7L1lJA14LUvsq8AQ+BZS/x2
1FXTOW34lRyDu3cokTd0cjCE7vFPBQjpTJFwp7cRFDmLHzpyHKwQfR0T8aLzhCe7
p2s4D1diVURKFlTQb27v8zBO9jmbHBA1T/xVpdgAabQyID8Q2c76hfR+iIr9Oq20
C1ULxeyVQDV+NTBAFLT4LqcaoEJ93LrpkJc25oIH9F/2nm6ahoz+oeFg9O4IqjOT
/BuWbBnsk7CSj4WebtjIDPApe2ceEQntNvu0t/sxm3pywRb9pmE=
=3+7D
-----END PGP SIGNATURE-----

--jWtrPC7Qi8AHwHLP--
