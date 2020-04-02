Return-Path: <SRS0=dTtN=5S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A79C2BA15
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 07:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9215E20784
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 07:09:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BesSw1Ws";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Zy009x9c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387444AbgDBHJZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Apr 2020 03:09:25 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:52571 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387403AbgDBHJZ (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 2 Apr 2020 03:09:25 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id C08555C0281;
        Thu,  2 Apr 2020 03:09:23 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 02 Apr 2020 03:09:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=9nyYQw0I6X7TuKb5N1BpfD/eCx0
        47AyTZ8RmD30iCmk=; b=BesSw1Ws2xjln+4HeHzZ887NOyRqYU+T+pZR3sPpxYA
        XX7NvBzWv7JKyBlA5fQLFr39+s/p31QUZynXEyQR2iR8x4OlqKLMQkvmLIsqVym+
        wk7JM5EpMuonlRs9q1rtoYijt4HWiGmHYN3KYRoKQLCaq80uJlAV7S4DQBHRpmvm
        kLFYCxKFqAqujxM8OvsgLgufZSxYRTO2uGWwADYqnRJKyb/JsP4NEK7tvQ7apmOu
        Itxu28sjUCqQLjNYLE+qQwUlr0FyDchaADQgNNHwBP8Jwv9eM6FViAoCeUhlaxBw
        qC8WVoZjsY1EwxMXhF9qgRJ4L2ulwa92WQtYGF2SJsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=9nyYQw
        0I6X7TuKb5N1BpfD/eCx047AyTZ8RmD30iCmk=; b=Zy009x9cezG7x24K2dgN8M
        KtkFsoNoVmqsYCIaoqzShzwq7etE6eStLRU6e87RBHwDADRailgRq056UbDNm7rE
        Y8tWWHd1R+7zhi6uPQ5Gt8AQS9C86uHVrAQtE642LrIB994jMa22R1/Gmz8VCqoh
        8wpelRvGKRAxh5Iz8EZ6oxn/b62hf3KIG+4pSDFZ3FR6sHb9JTWy5H/OMGyLCzHQ
        Gk9gVVVGr88v5Zp99p5EYsFOYgjo0jK+8c6m45/oymlHgaOliWFYtZ2SkrrNJQ6R
        TOkrRrkvv678o08dLmgc3TYfnqlPuIhBgeSH5fY2cH5qXMQZJDxOib1OtHJdXm7g
        ==
X-ME-Sender: <xms:o4-FXgqOyJeACD0QzCngTxhizL3o4s9R51mC538BxhCuQ9E8ayCvaw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrtdefgdduudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucfkphepkeelrdduvd
    drleegrddvkeenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:o4-FXq5rXg6ZMeR59MJYvP2SseAxAWvt9KNPtT4mUvpX4tj55ImcTg>
    <xmx:o4-FXgMaBd2gpCD4pcS2MF2QHWQkZ98Z4OcWFtc5UQPZddLCzZPDeA>
    <xmx:o4-FXsPOTVSpNssJpnhomWb4JSCY3ZXxPyEPQEhI94Qol8-OMj36Vw>
    <xmx:o4-FXhs0l5oWG3_eFdFYKZg52QplVAFJLVeqYUN2UDutFf41ZbXbwA>
Received: from vm-mail.pks.im (x590c5e1c.dyn.telefonica.de [89.12.94.28])
        by mail.messagingengine.com (Postfix) with ESMTPA id 14D23306CDA9;
        Thu,  2 Apr 2020 03:09:22 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 847ad378 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 2 Apr 2020 07:09:20 +0000 (UTC)
Date:   Thu, 2 Apr 2020 09:09:27 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git <git@vger.kernel.org>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 2/9] git-update-ref.txt: add missing word
Message-ID: <15857e1b8ca800a92fa96fee818a54456bfbd330.1585811013.git.ps@pks.im>
References: <cover.1585129842.git.ps@pks.im>
 <cover.1585811013.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YiEDa0DAkWCtVeE4"
Content-Disposition: inline
In-Reply-To: <cover.1585811013.git.ps@pks.im>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--YiEDa0DAkWCtVeE4
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


--YiEDa0DAkWCtVeE4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl6Fj6cACgkQVbJhu7ck
PpRC9g/8Ct9Nv3gWDKmirQqcqwOcYSuCy84gEWHtiMSBpKVdOqm+CnbAaJfXtgy5
gCk4V9jRmWH6SLUiEqPpWvjNqIjdb2iHcGupvlbDdLth/3MM7kWnPBaXHEFbaeTv
/p1ZmxF/G0xO4kMvYEqM4tJviuAnHFj6tuOuX087JUJfDcSHaLoEPekAuJ4pv6H+
RnZR2iNg0qWf6qnYRIVbqJy7ppXC1R84HdhTO4fv13eqKHUCrj7OMUsikYP0jUwx
jWW3bHH8M/9mE09wIQCAljr9SQ7HkEkkhxyOjp2NYtpHjUm1oziyQnVuPmPRB0bo
5q09GDO1eNDSgVYfLnbZi9Qh3zx0GQ8i+drw3uPVLA2LdjRkj2CTxkWwL/ucmqGH
7WE7UXSuep19ksSgif/FBu2gjTzieK74KBS6T0UTrtDM83dITfAJqzFi479kSDwQ
ilHY3P+qv3seCrMCUUEAVq6dT7ycnO671TNCsx1o4OVFLigfRogCi+dxRSGuBy2e
GcscA4qjvHGo4domik788eEu6U0Xg/d0cwo4Of9oNG3Y43l/6uKnVbTxzh2fttVJ
GBs05dBbJxoMkqyMMe1RATfcj+fJymFrrVSTs0MN4J+46IsqU3cMZ57XTWrY8JG+
as3D2mOXXN/HIMO/EBwE4bfNxQd71SezFPvu+3bFsiSWkNvhuCI=
=oeew
-----END PGP SIGNATURE-----

--YiEDa0DAkWCtVeE4--
