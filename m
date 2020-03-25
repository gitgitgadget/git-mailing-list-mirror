Return-Path: <SRS0=ys1m=5K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0659C1975A
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 09:53:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7231220772
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 09:53:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qJMCMlnM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VqzbSWkI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbgCYJxk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Mar 2020 05:53:40 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:51407 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727281AbgCYJxk (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 25 Mar 2020 05:53:40 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 376DA5C01C4;
        Wed, 25 Mar 2020 05:53:39 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 25 Mar 2020 05:53:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=59jjfc3QkaQ7PQeRNXt/0/S/xyi
        6OHnfVPijKbflU4Y=; b=qJMCMlnMl7nGp1x55U8xgAHiRU6NgRSjeGf9tkQcLhG
        G2VTHkrBM3X0dv95OzZyx1ovi6ruqPljlJWUp1g0HCskWJsxHrARQl/aEUoP/MAx
        eyatu5X18gO7E9VJzllu/LbEVnkD8Mfh7opZaL/9vMdk0Bw44aOE/Q+bR1badTJb
        UsLTLPIDKRthnd+MHExXjCem56dA4i2iP4nTaEFWAzz5qokGnTwAfmnEIWlaoRyB
        ey82echyxMrqxs8l3Ya4C1DtFVjIA3Zn5N+SZCpOpnRvIKz/qNRu90CavrIDXQxU
        arXquZoaPCg2gLHe4kLPCcAaQnPOknrU/cZqFtUmHkw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=59jjfc
        3QkaQ7PQeRNXt/0/S/xyi6OHnfVPijKbflU4Y=; b=VqzbSWkIZPDOp1FqohFJHl
        mFQSCIcWd2ihHVZmS7OUw+nRIn89X7ZPSQwho07KcwyLRcpBbGPHME3F9SVaMr+6
        7uzQtUkr8vfLBZkfZBsCOjMZSnbLj8JLwgK9Iu7xi5uif4RhSgeReXrOoGvxg9hx
        BwxCGAzd53x9x/PAomLztAPsZVRRA+7fF/AQIJpMLSl+b7qTKNLwDgE0+pUKRRGT
        ErnZmAxMMM1mHJbkj9iGNXNCxK4Kp7zOxRJdyNsMQq+3uFifDzD+w3Gk8JXqfBNI
        HDe2UhErFTOBweAoU8W489aVBXSlx9TazlgXl+viE3t6vQ1BPakWb2w9zkSP9oYw
        ==
X-ME-Sender: <xms:Iyp7Xp-y3lqZ9M7jUrkmQRaDH8bCck-qFLIqadfg5ZHTyOdJeDrJ1w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrudehfedgtdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucfkphepjeejrddufe
    drudekhedrjedvnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhf
    rhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:Iyp7XuyekTmcTBDqqHij90Xjn61HOCOgKXwkkEPZaQCheOvMxcPG1Q>
    <xmx:Iyp7Xp-H4Lf5J-20YhjjhRyXbPSN3VujQbE9OmpddgTDrGDy466n5g>
    <xmx:Iyp7XrLe4D_R57sW50BOxGp-l4ta-ih5a_CebervnJJ84bB5FqXrUg>
    <xmx:Iyp7XtTBW6sNWQW8ZGL81JpKBOLd-jXW9hkCPn1WhGHPbBHnTcNrNg>
Received: from vm-mail.pks.im (x4d0db948.dyn.telefonica.de [77.13.185.72])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9EFA93280067;
        Wed, 25 Mar 2020 05:53:38 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 353e6bab (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 25 Mar 2020 09:53:37 +0000 (UTC)
Date:   Wed, 25 Mar 2020 10:53:38 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git <git@vger.kernel.org>
Cc:     Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 2/9] git-update-ref.txt: add missing word
Message-ID: <dd7798abb75c91a102022fb5389e2ef961629667.1585129842.git.ps@pks.im>
References: <cover.1585129842.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3V7upXqbjpZ4EhLz"
Content-Disposition: inline
In-Reply-To: <cover.1585129842.git.ps@pks.im>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The description for the "verify" command is lacking a single word "is",
which this commit corrects.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git-update-ref.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-update-ref.txt b/Documentation/git-update-re=
f.txt
index 9671423117..9bd039ce08 100644
--- a/Documentation/git-update-ref.txt
+++ b/Documentation/git-update-ref.txt
@@ -107,7 +107,7 @@ delete::
=20
 verify::
 	Verify <ref> against <oldvalue> but do not change it.  If
-	<oldvalue> zero or missing, the ref must not exist.
+	<oldvalue> is zero or missing, the ref must not exist.
=20
 option::
 	Modify behavior of the next command naming a <ref>.
--=20
2.26.0


--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl57KiAACgkQVbJhu7ck
PpR6oRAAkSAunFcQjalRpi3pRUd2Hr1L12UYBldnUvZhxMEBz5AuXQQAK68ftSu7
sc4zzP6PrATa0quV5oIP037zyU4SjXBHcD+cvsaCN5Vc7zC0w345dKD4vE8IQHGT
XFiDEqP1hYg26JqSmx2jl7UzIG24u5Z60Z+JGjZQBaVq8cfjafkBvnqm4nfV3Xsa
o+IGiHsYLu0QYufIcsNWVLD7B9cgZTlrLnSLhaFKfUUxdQsNatr/Qv17Awo5loo5
pDwMgw/UZrYYv6QU5J0ftASejqcQ2B/3QIuGxakx6l8TB8ac9UmWijL0HmnmSlNO
6axzv82jeTPXL2anxeLjsO9rLBplKo2NIR668sIpvcJyNhJLWZOrnHV1WAOQiZYs
ZLSpB5bbNDgg1GpnTAbn19fQ0K7vmgp8DeTjDdQmrV9c4vdn7K3mnkjzrj90YoxK
roUmKxaDkHH7oaZEth1YvTU4akRE537NW+dJUtTvWBn6hrvwsESzszou+1i01tOL
O3O+zNsRRCnwl7qQgPkqPwOt+rE9W2XzFi5hWkj1IjEGktbwnEZf5Ppn7M1N0p4m
vqF7RO2ODssIbA5nwFl5ZI/EvpS2qebmSFElW3TMdc5S87cVBbh/USIHxYQbdgcE
sJjqlcN6EEONXeZ8J7kMUBxBPaVj452uxzUnxvNjHs8OoJc+5xo=
=8/9v
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--
