Return-Path: <SRS0=sJPh=5P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BDE9C43331
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 13:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFF2120771
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 13:46:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="U4RK8Q6X";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fhp/DU67"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728504AbgC3Nq1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Mar 2020 09:46:27 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:60103 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728065AbgC3Nq1 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 30 Mar 2020 09:46:27 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 16EAC6EA;
        Mon, 30 Mar 2020 09:46:26 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 30 Mar 2020 09:46:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=aGdIsIuEkIsBzUW2WZeuoU2T9ED
        WX+IFhO79ANbcgfE=; b=U4RK8Q6Xnn5Xmwmp4/JSTcBhkTAxXXZNE021X+npBin
        cuN2RLoI0nz1qbgDf0sntL93G+kQFIJqUtPEDSPHRQhaPhDOD4iRGKkPTIWVCy/X
        qmMtlMhvf6iAZResLwAI6IbGPWqkqzVsxtXY98KsypbkVHbLXLzRBaFr1f2lIQSP
        H8FeGu6Bg//t1M/y475ZZ6WnHiKjgxr/5zqMUJ4pHrtoLm+Lxh1GxvzrATSA63Qm
        ynMNlbN2qVP5ysHM0HuLeHFW62AwzCnMO6VmdIeTkvDWqbPA+P7SAKadeBPqwFJt
        neG9ZQqRfLH0R5gj1oah9CURoECZfdpphjmoaxDxxLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=aGdIsI
        uEkIsBzUW2WZeuoU2T9EDWX+IFhO79ANbcgfE=; b=fhp/DU67sXvFWxkx5wnAoH
        y16EqDmO3SsHxV/XIpf3NNb3xbJkYiTJtKnhnmkWVwoIC6cw6cemzDQHqSwCtdu6
        F04ZUlk6dDLx6yOljRQK4vQtWGLav4yR17bAsST1dBoObW8Eh6P7NiSLhc0XO4bx
        EWb100l+/lrz7WP38sxb9e+0CK/813AMUyScH+M5yk36gO+JFQpax/5ZmejAjZiK
        snEptuDwp6yRENRTkrIaQr+/LhYBEgLkA93+iaVKj04Z9ViPc462GXlRek8Air3Y
        mygO50TVm7gWLURO8Wf0a1gkg8IGXXZGK/lduhcmBHZ9RRef1yTq0KT96Jkcj6iQ
        ==
X-ME-Sender: <xms:MfiBXsGAxfCyKSEtItS-AdKsC3D47ZRDrplbBR7GWxNsA7HJx0E3Pg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrudeihedgieekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucfkphepjeekrdehge
    drvddvtddruddtvdenucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:MfiBXsX432iua5Z1Oae6q8MBaPDO_wWH4vSZhg33KOkS-mWp-jPPbQ>
    <xmx:MfiBXrL3Y3qkeI-MOT_9XaiznSNMOaAN86jGK8SSBAGSRuDRDDfUFA>
    <xmx:MfiBXs9wUnrOfAyT1PQLCCBU1zYz9OCrkADALsoQ4LJIQakxLseyyg>
    <xmx:MfiBXuVgW-qpbkiP67QhU0p26p2XALThPaamGsD4ry4FY1bOoC0v2g>
Received: from vm-mail.pks.im (x4e36dc66.dyn.telefonica.de [78.54.220.102])
        by mail.messagingengine.com (Postfix) with ESMTPA id 25C343280069;
        Mon, 30 Mar 2020 09:46:25 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 0f18be8f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 30 Mar 2020 13:46:23 +0000 (UTC)
Date:   Mon, 30 Mar 2020 15:46:27 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git <git@vger.kernel.org>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 3/9] strbuf: provide function to append whole lines
Message-ID: <b6546ae44e6a5f7b57d75d59b23a777b363cac1e.1585575749.git.ps@pks.im>
References: <cover.1585129842.git.ps@pks.im>
 <cover.1585575749.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5vNYLRcllDrimb99"
Content-Disposition: inline
In-Reply-To: <cover.1585575749.git.ps@pks.im>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

While the strbuf interface already provides functions to read a line
into it that completely replaces its current contents, we do not have an
interface that allows for appending lines without discarding current
contents.

Add a new function `strbuf_appendwholeline` that reads a line including
its terminating character into a strbuf non-destructively. This is a
preparatory step for git-update-ref(1) reading standard input line-wise
instead of as a block.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 strbuf.c | 10 ++++++++++
 strbuf.h |  6 ++++++
 2 files changed, 16 insertions(+)

diff --git a/strbuf.c b/strbuf.c
index bb0065ccaf..6e74901bfa 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -690,6 +690,16 @@ int strbuf_getwholeline(struct strbuf *sb, FILE *fp, i=
nt term)
 }
 #endif
=20
+int strbuf_appendwholeline(struct strbuf *sb, FILE *fp, int term)
+{
+	struct strbuf line =3D STRBUF_INIT;
+	if (strbuf_getwholeline(&line, fp, term))
+		return EOF;
+	strbuf_addbuf(sb, &line);
+	strbuf_release(&line);
+	return 0;
+}
+
 static int strbuf_getdelim(struct strbuf *sb, FILE *fp, int term)
 {
 	if (strbuf_getwholeline(sb, fp, term))
diff --git a/strbuf.h b/strbuf.h
index ce8e49c0b2..411063ca76 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -502,6 +502,12 @@ int strbuf_getline(struct strbuf *sb, FILE *file);
  */
 int strbuf_getwholeline(struct strbuf *sb, FILE *file, int term);
=20
+/**
+ * Like `strbuf_getwholeline`, but appends the line instead of
+ * resetting the buffer first.
+ */
+int strbuf_appendwholeline(struct strbuf *sb, FILE *file, int term);
+
 /**
  * Like `strbuf_getwholeline`, but operates on a file descriptor.
  * It reads one character at a time, so it is very slow.  Do not
--=20
2.26.0


--5vNYLRcllDrimb99
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl6B+DEACgkQVbJhu7ck
PpQ1Yw//XVHFvWyw9vdYfF/6Mr5DKFac7Ehzjx4tiEIcfR8sTqJO91D8ckezSwCC
W/OZ6Ml/GPsJ6P+UdPDoG9Al5JTNT2JcVOOQxwmYu5TMiNgnS7o9RGYApUop37qh
kzQFza+ykrAEVRxcHtfXu1PqTI32L0BlxqeCbCxxuHmjYhSub14M5ux03Pv50leT
eRjy+iyqbLexwnF39+Zr8d38EnEHv9vCxN1gv5wqFpO5tYKi0tujjn8JPMNsG8U3
5469O+kdkiNkzptuyn9c/+W/mMotxVrp3299cF2R4ZsFzdP2NIFTVoOzXw8n22X4
RIqt3DCTKJy2mVivtjhMUtKYCEwGI3tg/1eXk5TX7StCUJTn3W8fv0/5aZTz4G+H
cnj2WXxrtpYnfGNLOgGkDDTgNWN0KVUbjVZnjMWXBdQYQ5QanKlKhBXfBbPNn1IM
Gg60c/dOZF/tatxMsCbQJblotOBMcrP+kz4FItX8eITqLooqBKhhRMsJDvK+WGtz
i1Gty5rOpyxUT1aKrfUaErOUv03jhGZSfubDU6x3e+hODHJ15sK8/WKP1o3ZaEVZ
H6Kbhge8Lb5W/cqEiq3tQu/GxXn2Iea6DuoTi3D0itHviZjrsHFHS5D1kvuy5iFn
7KXPFYFwzXAIhXcm6aB7xvJzzP7vcBf41xlD/sqTl42L0aby3qE=
=BeL5
-----END PGP SIGNATURE-----

--5vNYLRcllDrimb99--
