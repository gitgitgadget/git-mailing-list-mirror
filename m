Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB9CC83012
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 09:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8DAD20705
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 09:56:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fxiDPSk8";
	dkim=temperror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S47Yv3ak"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728722AbgLAJ4r (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Dec 2020 04:56:47 -0500
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:50409 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726099AbgLAJ4q (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 1 Dec 2020 04:56:46 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 5A6B2E05;
        Tue,  1 Dec 2020 04:56:00 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 01 Dec 2020 04:56:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=hXzw1sSsyfXPkT47t5UxcSaY3HM
        EswR4D6ezcBva9A4=; b=fxiDPSk8oZFNUWw40+mSueMzVX8AILTwmjBUy5hsrxw
        eGVTlI1+oCafOGKM0xZk2N3oRTEV0p8D2YsHaPT9ZS/fTJIaDW0f6g8aJxyzAsTq
        DVdyCSBUWGNNykw/H4RqTB922W20pYyJh85X+RGRwCysyyNlEb18HVROIVNGfRo2
        gD9Dn9vqpYLHmCe9MrmWSaoiUxjxboJJvgJE+I5PagKAyPIbQEGnPSNxTbTyINZ6
        LixEZ7TFTLfPb8+Ymvc6Asl87tZQBZcl/tvikxcg/jdoHj9ZQrPC95U/PA1wFw3j
        WUlmiNbSbIrJGKkblWMMo6Qsfll23KPuyqtg0yYJW0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=hXzw1s
        SsyfXPkT47t5UxcSaY3HMEswR4D6ezcBva9A4=; b=S47Yv3akivpR1MjxivJlr3
        9afYKT1628wjXnT9pmTGR7ghWNa5Gf8ATRVbmDvz/PRXYH2bgCyFXMNUI11AG/IU
        w04INXVb8q/dmtxcgBV7+2RP8Z3ZptQuX+6J7CAN6sXlNZpkKJS34JqgZ5VRLwcm
        peuaTf9xe3GFJducacR1tuHkRGtqpRZQMGaY7YxtaDeKFE5Pu1qk6sv7QQq3zZ3Y
        2i/0ZmcQzFc0o6IiwAVJoGTM2kXClnriyHgax/XXM7HxORmZIZgiLAo9okS9g5tf
        n8v0N7n1ZYUlAA1y4RK2Zs06RbOHEK9lU9gS1RSU9vXV0DiOjvjtUdZSjyFQ08WQ
        ==
X-ME-Sender: <xms:LhPGX_1toCJhb7FiCR4EjYeYIDh3QrIS-38fq7osgyeAOtqUiNHtYw>
    <xme:LhPGX48sLxq8umR3f_QcUPqaBFxe64cPEMCSs-Xd9nMYzamfpINwz5rP1Nt8q84eg
    Kr0UGerlViCBjPlnA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudeivddguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucfkphepjeekrdehgedrudegrdehjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:LhPGX3szIQED2HNso_I78_wWvJcnRcmWn45g_FneJuTrr0AzdipxYA>
    <xmx:LhPGXzB7sdw3loTV6iS68jkPcPgL7QG2XlF4yHXfxpDs8BWvq12f1w>
    <xmx:LhPGX3WhnnUje2eovAV0pTYHm_Sd3lH5CpH7TvZwkmkLFYv0TP98fA>
    <xmx:LxPGX9NDpF3BMTBzqYDLLaEjPyoHCIG61plZUqD0doviSkX8t5x_6g>
Received: from vm-mail.pks.im (dynamic-078-054-014-057.78.54.pool.telefonica.de [78.54.14.57])
        by mail.messagingengine.com (Postfix) with ESMTPA id 10EEE1080067;
        Tue,  1 Dec 2020 04:55:57 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 32b374bf (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 1 Dec 2020 09:55:57 +0000 (UTC)
Date:   Tue, 1 Dec 2020 10:55:56 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philip Oakley <philipoakley@iee.email>
Subject: [PATCH v3 1/4] environment: make `getenv_safe()` non-static
Message-ID: <87653893b7c80cde158dfb39acb54aa91d4e54f4.1606816110.git.ps@pks.im>
References: <cover.1606214397.git.ps@pks.im>
 <cover.1606816110.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZLXexyvIovfZwaIS"
Content-Disposition: inline
In-Reply-To: <cover.1606816110.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--ZLXexyvIovfZwaIS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `getenv_safe()` helper function helps to safely retrieve multiple
environment values without the need to depend on platform-specific
behaviour for the return value's lifetime. We'll make use of this
function in a following patch, so let's make it available by making it
non-static and adding a declaration.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 environment.c |  7 ++-----
 environment.h | 12 ++++++++++++
 2 files changed, 14 insertions(+), 5 deletions(-)
 create mode 100644 environment.h

diff --git a/environment.c b/environment.c
index bb518c61cd..2234af462c 100644
--- a/environment.c
+++ b/environment.c
@@ -9,6 +9,7 @@
  */
 #include "cache.h"
 #include "branch.h"
+#include "environment.h"
 #include "repository.h"
 #include "config.h"
 #include "refs.h"
@@ -152,11 +153,7 @@ static char *expand_namespace(const char *raw_namespac=
e)
 	return strbuf_detach(&buf, NULL);
 }
=20
-/*
- * Wrapper of getenv() that returns a strdup value. This value is kept
- * in argv to be freed later.
- */
-static const char *getenv_safe(struct strvec *argv, const char *name)
+const char *getenv_safe(struct strvec *argv, const char *name)
 {
 	const char *value =3D getenv(name);
=20
diff --git a/environment.h b/environment.h
new file mode 100644
index 0000000000..d438b5c8f3
--- /dev/null
+++ b/environment.h
@@ -0,0 +1,12 @@
+#ifndef ENVIRONMENT_H
+#define ENVIRONMENT_H
+
+#include "strvec.h"
+
+/*
+ * Wrapper of getenv() that returns a strdup value. This value is kept
+ * in argv to be freed later.
+ */
+const char *getenv_safe(struct strvec *argv, const char *name);
+
+#endif
--=20
2.29.2


--ZLXexyvIovfZwaIS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl/GEysACgkQVbJhu7ck
PpSk7w/9H0jZEFeVeO1ynoElL0lv4lvOb/mOjD94K5DNgioXY6aFMyUIGq8PYSHK
JWBNrLKYNlkyI5+JluTkQRG+gVvXqt+bs8rY8m8IXf+uRMIPRUU0QoEwE7CYpMR1
yuI5fBYsUW/gq0x5GXVpUYqhEhjqpBSV6m0yXwOFN5wFbce1fkg1CYA1OVBGGsaH
whOzjB/HJmVISC0jeT2I71h47q54/OMez4Ah32zK+ZCL6yUdmSLTDHalDKCkHKQf
Lyh5hc9hIlMHkvBIsCE3/KmOewV4vOieQpsgYrEvPywyQWsJhuyK8LVhADEEcIbH
Pa16+xaMS/hQKxdZiMEfTnAEygEcx+PybjmHDXvIa/itW2Ict/cQb4RUZthzHfH6
YW+rjMrxef4sX76omWgJ2mvJi2aa4WYaoKz3iOpZSIFps4Yl1RnwI4pVTEHaPqY1
d1lMV0l9mCKYSeQJdty7XZVNuXLboLjQxQTFnkIPKN0fIQXuVWIcm+1rHUPsamx3
i3d4FkttmtCgE9LRpSTsKGn9H3AkVNC8487lCc0rob4c4efx1DxUUK9yAcPnIlqC
UVtIhpVMOktCf9W1c/rt0//+rIWaofFRzqRwsRcHRQA4SDXtXr5oUlf5liy2HHIK
sjTDF+Z7blX9aK1AuDciMhcjTO/iKHQLb06RcKQfiulh7z35iEE=
=6mDk
-----END PGP SIGNATURE-----

--ZLXexyvIovfZwaIS--
