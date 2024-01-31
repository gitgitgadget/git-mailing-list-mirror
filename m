Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87E261696
	for <git@vger.kernel.org>; Wed, 31 Jan 2024 08:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706688093; cv=none; b=EdnE4yXuJye2Z3e/H4iT5GfC86ankVUfCCTA6UyP/B2yOVOoQhq+zz9t3ANPos976sONNvsc55CkROVtrOd2PZplFg6qE+UAURLJOphF8w/Dvxgsb16TZHLrnX3C9hAEoGR6thzQMp7a68A7HBCdzQCx0aXOb3yk5L58KctCyFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706688093; c=relaxed/simple;
	bh=HOSxfe73dGqmqAgq0NJD2FgO9lQXECB5cZE1QHuIKkg=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tvCu+R2j2Nm2tDsMIN6Hdqm21REi4FY4kL7NyiOB8ffwWBGz7v4Um1pV/Nv2T7DmZbTBmeh97UR2r1dHknLYF2AEvEyT8kshN61G3rdOF4hH1SV0SAioOO1LRXsjZRnM+Wfd+lIw96pDIS8X0QAAvoLVQIs9fexPuyyUDzDNhao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CqtU06Mh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dBaKiGTk; arc=none smtp.client-ip=66.111.4.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CqtU06Mh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dBaKiGTk"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id BC4605C0077
	for <git@vger.kernel.org>; Wed, 31 Jan 2024 03:01:30 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 31 Jan 2024 03:01:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1706688090; x=1706774490; bh=ep7cVr0apq
	WP9wylJEYLwhu4Ud7E9zYIyCPMRgkeLtM=; b=CqtU06Mh9spEntnehgb44y2ek+
	K8/lUO76ptVC5ASfBSkHrQGEUQd8Sd4jSmDMTRgx2N5VuHU4Coi/iaLDa9Gv2uyN
	Rc9GJ8o3XyENgqw17RuhQ5TqRjUq7VTxnX7mf8n0XlWPwVikDiw+qI9kDkUzjk56
	Ip0qAi2REO+UEULibsOZ49i2lePoR77slDUI5VOZLQhrNoF96an+8MYC2wDrlVeW
	5WuTYiBqu+WTLAPVN3rtpCeVThSrTeCl47uMqLI3qgLVnX2e7ZjfeaaH9P8OVkpr
	KDF8xu5Xeym0jD2IUBg0JhuEJMM1Q2XROciTjpnkqHPvbwlmCaTwP1P6+jTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706688090; x=1706774490; bh=ep7cVr0apqWP9wylJEYLwhu4Ud7E
	9zYIyCPMRgkeLtM=; b=dBaKiGTkjpfGZehz257vlmeFmltsSPF6e4zUS97h0pIs
	TMIJEUpcaNqFB5wCHUZdd9mDgzkFt4fUcXx7RbUW9qAYcL18Gsmw87bFfFevKXHC
	kiJ50aycDb/CMT+A03YYTHYvXLvS00PtX9ggJ4/d2jFNDi4wJu8N33vA2onZgxWu
	rA3NmqaUexIguDv8Tmgv3UUHCXRFQAosn/3ByeL71rcIcn6A0ogtkjlhFBadM/bA
	lvrDXNGDibeE3Z95QkNXUhKu7OmO5t3YZwfvgMzATEe71VE8W6KKg7xyPhrk8Rlh
	w5HvxB+/8PnWedFF7+FLwnwbQYhkOviHs1pIbv1/hQ==
X-ME-Sender: <xms:Wv65ZQ-9xnaeXAlu2ak9vHcjqaI8Cdp0m9OTwbdCba3TEtKORj0Tgg>
    <xme:Wv65ZYsVRLSTKiBqKflrq9UWC0pEGIxTtmJN8gJnLLzH2e3FeCSFYLbl44eCIWJL_
    qZweU77W2YW7cnW2w>
X-ME-Received: <xmr:Wv65ZWBm3EnVszBAubg-T2OYkzI9phYC_p_Ya2we4PwM4JfMWCPqlQHbc8ggHaysq-rzkbdBBaeUrLvhmaf3fySyO2e8pEdG2GWb97YsrI8ub4k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedtkedgudduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtd
    fhvdejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:Wv65ZQdDNVzGrIk9gW9eUwA0hAE9d4ZXGRpaOSC5tm64j-fKTwXCoA>
    <xmx:Wv65ZVOYnTXLPGPE1f_lOnDbFy2qZDbheQ-P7pZOzUK_4leV0dUE9w>
    <xmx:Wv65ZakJX1IPbNG-p41IreoB3JYeStV46Ysv6OuO9gLVCUMWmaBGog>
    <xmx:Wv65ZXXvK_3C-heeoqRWppTQl4PSazid-ZBHlifS_dsqf4r8tWrqow>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 31 Jan 2024 03:01:29 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 937fc14e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 31 Jan 2024 07:58:10 +0000 (UTC)
Date: Wed, 31 Jan 2024 09:01:28 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 7/9] reftable/merged: refactor seeking of records
Message-ID: <00aeaeee63dc1371d3338b72f779c6f165bd14f7.1706687982.git.ps@pks.im>
References: <cover.1706687982.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="x50o7YEh3FA+MERc"
Content-Disposition: inline
In-Reply-To: <cover.1706687982.git.ps@pks.im>


--x50o7YEh3FA+MERc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The code to seek reftable records in the merged table code is quite hard
to read and does not conform to our coding style in multiple ways:

  - We have multiple exit paths where we release resources even though
    that is not really necessary

  - We use a scoped error variable `e` which is hard to reason about.
    This variable is not required at all.

  - We allocate memory in the variable declarations, which is easy to
    miss.

Refactor the function so that it becomes more maintainable in the
future.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/merged.c | 54 ++++++++++++++++++-----------------------------
 1 file changed, 21 insertions(+), 33 deletions(-)

diff --git a/reftable/merged.c b/reftable/merged.c
index e2c6253324..0abcda26e8 100644
--- a/reftable/merged.c
+++ b/reftable/merged.c
@@ -238,50 +238,38 @@ static int merged_table_seek_record(struct reftable_m=
erged_table *mt,
 				    struct reftable_iterator *it,
 				    struct reftable_record *rec)
 {
-	struct reftable_iterator *iters =3D reftable_calloc(
-		mt->stack_len, sizeof(*iters));
 	struct merged_iter merged =3D {
-		.stack =3D iters,
 		.typ =3D reftable_record_type(rec),
 		.hash_id =3D mt->hash_id,
 		.suppress_deletions =3D mt->suppress_deletions,
 		.key =3D STRBUF_INIT,
 		.entry_key =3D STRBUF_INIT,
 	};
-	int n =3D 0;
-	int err =3D 0;
-	int i =3D 0;
-	for (i =3D 0; i < mt->stack_len && err =3D=3D 0; i++) {
-		int e =3D reftable_table_seek_record(&mt->stack[i], &iters[n],
-						   rec);
-		if (e < 0) {
-			err =3D e;
-		}
-		if (e =3D=3D 0) {
-			n++;
-		}
-	}
-	if (err < 0) {
-		int i =3D 0;
-		for (i =3D 0; i < n; i++) {
-			reftable_iterator_destroy(&iters[i]);
-		}
-		reftable_free(iters);
-		return err;
+	struct merged_iter *p;
+	int err;
+
+	REFTABLE_CALLOC_ARRAY(merged.stack, mt->stack_len);
+	for (size_t i =3D 0; i < mt->stack_len; i++) {
+		err =3D reftable_table_seek_record(&mt->stack[i],
+						 &merged.stack[merged.stack_len], rec);
+		if (err < 0)
+			goto out;
+		if (!err)
+			merged.stack_len++;
 	}
=20
-	merged.stack_len =3D n;
 	err =3D merged_iter_init(&merged);
-	if (err < 0) {
+	if (err < 0)
+		goto out;
+
+	p =3D reftable_malloc(sizeof(struct merged_iter));
+	*p =3D merged;
+	iterator_from_merged_iter(it, p);
+
+out:
+	if (err < 0)
 		merged_iter_close(&merged);
-		return err;
-	} else {
-		struct merged_iter *p =3D
-			reftable_malloc(sizeof(struct merged_iter));
-		*p =3D merged;
-		iterator_from_merged_iter(it, p);
-	}
-	return 0;
+	return err;
 }
=20
 int reftable_merged_table_seek_ref(struct reftable_merged_table *mt,
--=20
2.43.GIT


--x50o7YEh3FA+MERc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmW5/lcACgkQVbJhu7ck
PpQC3Q//ZAey7P+N1FG5zsg7NndX+b4s4hqhidNhTBdfu/4AfkjjllrvnoCMOctS
YKhGeN1rLOURiuKwtOjgLWr4oRReXXxMVPzUOL0OjdIzRRlcm8E5HIfh1C3qOzgt
fBTpOTMzh83WMZWHs2YeBFZDg7L8Ye2yoS5fn8xIBxUqGuLXS8SIka9l8Tw4n1ds
Of4SYKVNEwuQeRMYWD5MvzpUrjFXkLxa74Jiy2zpLoJV7Bp4B34NlZJpUzoKFCBK
Sr5YNGeodxCrplSkzflAaQdKHa1msZlkEBU3tYzwDvpSJp58NiUYE1QRhrRadORa
NdhyjvQmmUMIQkO6GODO9tfyYaeQjWNaUvYKSorniXiBA9henaDNbR8RJtEXBIdD
Ynl1MKkUFm/DKN2BOVtzlBX/RtI5Yhm83nJfnX9/czy03sQ3Zwt993v8ozZdMxNP
2DpXRXk86ivnmK4W6SnY275fPJSarvHg7eAvMyZC/vGft53grmccmmIFF4+CS4gT
Xn6GQMdziozmnGX63nN3LXAFD20WrQxpK2OEatJk6pGfrp8+lRQxwxL1YdaHgsAP
E5syfqQ939rsHuD1yKMSInFsV7RhbzFVpETc82BAIilTvzCB+6Q7xuAYfuAAkuSR
/NHLAWI4IsOjhhgyxFTcYwliopggmqaRIzSS9xvOgoA+CufqSc8=
=Ud22
-----END PGP SIGNATURE-----

--x50o7YEh3FA+MERc--
