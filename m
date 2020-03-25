Return-Path: <SRS0=ys1m=5K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57CF6C1975A
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 09:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CBAD20772
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 09:53:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IVddYw4+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tT7kNpQO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727432AbgCYJxs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Mar 2020 05:53:48 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:35803 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727281AbgCYJxs (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 25 Mar 2020 05:53:48 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id C3B275C018F;
        Wed, 25 Mar 2020 05:53:46 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 25 Mar 2020 05:53:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=HJiDIAo4mlODyqer/nhRwYhb+/N
        jtjLy9pj6GlFjfR8=; b=IVddYw4+Na4palPNlYieyHaChla7fHpDFyY4Vjfdpuu
        9jNfXvv7q9AYB68L/bh94t0F+Cc97xrzuDgFS4A6qaJSbYmAt1X7Ed4LisFROCrX
        xqrOGPaS9Eswt+GJSGhphsavLKmXN3/LSRjOcUX6FaUDMeUtnCx639GM7ufC3r+q
        sgZgpwYKB9pbWKhg7sfrjHfpz4wB1xDvF7BYcWMZatV7AmnmA/1Wb6qex+RLWlDQ
        ZByOBLMP/V9YL/gRyc52gTP79/V0rwAs/Pp56CN5mgEoqrrq1b8hLOfFE54bNB/B
        sb1OPLdNOBCcFEX/Awc1GmbUZHLA/W5dJJj8K2Z8+5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=HJiDIA
        o4mlODyqer/nhRwYhb+/NjtjLy9pj6GlFjfR8=; b=tT7kNpQOoSCuVIpXjrRJMq
        l7nteyWgqVEDSgWSVmrVPEQx7M0aPuu6YtTnWvBNP9bioxAG5Cg1iWnV45SzZ226
        9PB9CFxBw0x4il5P0j58wkgPUV/bS0q3KvJnnmg02eH/2I9UCLDx0sux1xxPx3Xj
        A8UzDH1attyYMfoMjO71yGsyhNxVxsfzU2DSPsEin0ep41YhHDXXYp+WZwhBGXad
        eNTEUhfD/x8Jfw/s4eUQQu3Uo3sajCNGhlPtx3xJ3U0T72Zcu6B5hXlhFik4BQKC
        hEbMy7C2BR8TITIZrV5ekoD2U+OBc7mLgmSyh7GcFU6w7ZvQNSMtkNXE/XJ0rf+Q
        ==
X-ME-Sender: <xms:Kip7XmuUjzohOIMrCdaH5WlmvOYtq58gVOMjhhsDHeXeyKh7A7PofQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrudehfedgtdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucfkphepjeejrddufe
    drudekhedrjedvnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhf
    rhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:Kip7Xl9qKS1MVJ07TK5wCe4afWNTZHc8GobUen0AMDe-NgiHu1STKA>
    <xmx:Kip7XvBEw4m6Ovk-5MGnMO4i-SIyaqw52C9GLxdDKo-JAokwBgPG1g>
    <xmx:Kip7Xi4LzipgO7R0UWGNZMsXYsbQ4Xp94rZmzC43lWtWPzNP0kQJwQ>
    <xmx:Kip7XtCPWlXWJbepDXf6u9JUbe7LxolKVfDdCbDct3NNcPkfMLbfkg>
Received: from vm-mail.pks.im (x4d0db948.dyn.telefonica.de [77.13.185.72])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4B6263280059;
        Wed, 25 Mar 2020 05:53:46 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 6b0e0e02 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 25 Mar 2020 09:53:45 +0000 (UTC)
Date:   Wed, 25 Mar 2020 10:53:47 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git <git@vger.kernel.org>
Cc:     Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 3/9] strbuf: provide function to append whole lines
Message-ID: <4b0a963ea5c47a951b95aa0a03966315b3e8299d.1585129842.git.ps@pks.im>
References: <cover.1585129842.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline
In-Reply-To: <cover.1585129842.git.ps@pks.im>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--OXfL5xGRrasGEqWY
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


--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl57KigACgkQVbJhu7ck
PpQ1rg/7BSXpylVPWdQ11kpl7H76Vh0bKKZu5VMVUX0PJ8cL2Tlg7noo2eSbit4t
CIPlAwVh02454kY9ieyn5dgeUx19aH+fac+Rnjt8mZNd8byYQZ/pLpPubO+8Nqp4
LlUJuCyH7o+f6rVGxKc/0vdho75Wnprbqb9mwxrw+EcWBIE7bFStp6XnknDCuAS4
zLL+lTyhsMb2wzzJCZ/cjvU4Bc+eKL4zGYtmYKUn/6rXvlmTjjG+njeyubmSYPdF
E3+xSk3lW3rYnueYm0gKGOXI6gwFwcpuRahrERR8l+yc6/Q1tF4AjV3YG8aGH+Sn
Lga/GFlE6mb6D01ydOgNmXEV/DJjpVpVsJ/PorAVug33X1EY9TOLcirGZk6l++W3
jI+O067mV4bB6mA0snAZ791L18AFM/PJlqelLl84bw5xQCtCgn7mipbJU+Eaf4wh
gUDSbdMXDNCfXJJYGlyBiqWDQksC7u5b/5n+CvQtygaf0b5b/5DeRYm+YyS+Ueoh
GcqdBG2QPOFzi2nChgDWeMMKxp3dzqHAsIxEpfDnbcymh407c//UdA5i25VR+shN
6LY7PYuwaHlPHxkJzXhjMTJoyQd4AruGrFUHlAgELT0/0UWRR+hqMezWwH7BUZt8
uTj0lYFIo8HgVeLqsK3CkRzDWFNcyEtW1nli11ZzJ6f6V1i3yQY=
=8jSt
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--
