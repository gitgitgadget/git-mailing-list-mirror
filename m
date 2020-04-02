Return-Path: <SRS0=dTtN=5S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF8EBC2BA16
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 07:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C76732078B
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 07:09:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dLsraSyD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mROyA6zA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387453AbgDBHJa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Apr 2020 03:09:30 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:53855 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728612AbgDBHJ3 (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 2 Apr 2020 03:09:29 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 62B465C0293;
        Thu,  2 Apr 2020 03:09:28 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 02 Apr 2020 03:09:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=TTGqwR3oq5EKMx2DqlfVM/DTzGx
        jU2VK2vU2N75/Hk4=; b=dLsraSyDLJtCJFXU0W5aRXLV3oZOWg3jDWgG6cy9giA
        UzA7BJBUEpojlsfbAz4l58nstATpuaETC7X6SMN2eE2f+IuL+syzyvLEoXGNwZ5b
        ToRkZCq8ekzn6B/rRaEAfCnit76Ninpi88J9TAdAmd3jB84dR5nUttpoWajuh+pu
        3HqrLjlVPcYW9osSulEMVtfqEEd8piW28XeVdLLx5rTBpxMfNICZftfcTiYm9rFx
        v/38S1NLUHqmRho63KMO9MTg4gE5KJB+mKmMM+2T2gswaAcwOdxAWBG7Y1d1PB8k
        YO06A4iTmd7wObmCG20NiDCviMErSh5Eo/dP2RmmU8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=TTGqwR
        3oq5EKMx2DqlfVM/DTzGxjU2VK2vU2N75/Hk4=; b=mROyA6zAuI7neI3ai2EkEO
        Tiq3SBVgdf6nGo9zsIVFxfv0Ok916bWwE7soKW7rJowXlCXJnAd/PGrYURu8Apzq
        KCyl81LDQl3JsO8aS+mcsYHazUf5vaGkD7iJycG0ixxmOV2/dl2cpZOioklNNGo7
        CCigrt2tN2KLofJXwwAL0W6+pjL7UP8m5Jf3HGKvhtckC1uKpbiiKQAk8yNfp5c7
        HbrXG4BK5IEBc+seQP/PZWuhdJKL+UaGM9TAuAFvyMEbTEY79zSCW9fh8GJwAyME
        KKyPuh6xNLGeQW04ab1E6Lp0MpWa2lJZQDIuADu6C3MEaWgCDbRrlkCkRJYYfTwg
        ==
X-ME-Sender: <xms:qI-FXjqL86iDSG-6HtA9kln3yn3vrP1OmI1ZTFcs9v0JIfK2Bt7ZTA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrtdefgdduudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucfkphepkeelrdduvd
    drleegrddvkeenucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:qI-FXm1t8bOU62GPv6QMdmc-XVxARslNucrLnJF4N_tALBExj6SbRA>
    <xmx:qI-FXqVmRepYPfC14MtsLMJ6yF131UT7FsK_QZD0eJR9B25bgaEIKQ>
    <xmx:qI-FXnxFBA2CpCozmXehbf12LhLIAv3KGVxEfsU806Zh2vqgBmwvUA>
    <xmx:qI-FXlmsbOy-1V1putrPbAinJWzD8GQNlEUlY8AEx0w3kFVIPGfEpg>
Received: from vm-mail.pks.im (x590c5e1c.dyn.telefonica.de [89.12.94.28])
        by mail.messagingengine.com (Postfix) with ESMTPA id C63DF306CD98;
        Thu,  2 Apr 2020 03:09:27 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 8f61b50f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 2 Apr 2020 07:09:26 +0000 (UTC)
Date:   Thu, 2 Apr 2020 09:09:33 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git <git@vger.kernel.org>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 3/9] strbuf: provide function to append whole lines
Message-ID: <b6546ae44e6a5f7b57d75d59b23a777b363cac1e.1585811013.git.ps@pks.im>
References: <cover.1585129842.git.ps@pks.im>
 <cover.1585811013.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fdj2RfSjLxBAspz7"
Content-Disposition: inline
In-Reply-To: <cover.1585811013.git.ps@pks.im>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--fdj2RfSjLxBAspz7
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


--fdj2RfSjLxBAspz7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl6Fj6wACgkQVbJhu7ck
PpT9Xg/+NzG6vWMDBzTntH/7dKVMoDOXnpy1ZK/H9kErICfrGFfZtddS7yETi2Hn
yw0kpC8O5FPc5NG4KpD3p1f6QrgJzDPKS7C14AF1EP6u8glrnnMG24zv4skV2mD7
cGaCnD1SMwnV1oQUAyjeHm6AWAJP+B26mH7jz0Ok0CxdxVzJiwbvTm1tZWEpNJFy
iGzwN5tDfAxP7Q1CUhWfkf8E0Yn9m2V48BStyxYbraeuvr6eVVHq5hZfSuyo+kEo
U6j7RbNFudPyNPE78FGYVR/h4Mshq5TqC2AEbJWn8W5NfV0ZxlsaKaZnFok7rXxl
0LN95QYXlOukqar1EKxlo9inzXnAJpNTVaP8dGH0GY4cfWEfFJ1IE+bEKSRtUoGz
zBRmoMsLM01dWI+ID2lVXSBbllcotDSl9fMZT3wYvV2oaQlxCrxUJPO0g4S6D9n8
on8aTH74jwdibwp+IHDnwD+Z0yd+NrrZPdetnL4COfx8SKz8LH0ylJn1ymiMvRzg
wcFlPUZxKHf2AfRWiqGCZ7xAGreqOhwfkqzAA+1OXFuzfpaZUojyXRz5OeRgAmzT
aOeOZs74C4Syq39hb16s18g6xjyjtmySM9z20dT8JZeqaijkFNBuVtJe6ODStc3J
Kz/mBZJbGVrFEhCHCmCzOen+adfEo5BxIiFvsw+9PY2i0vBEBMM=
=aajn
-----END PGP SIGNATURE-----

--fdj2RfSjLxBAspz7--
