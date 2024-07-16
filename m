Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4FA1DDCE
	for <git@vger.kernel.org>; Tue, 16 Jul 2024 16:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721146497; cv=none; b=SnYPgGo23Ji8fdiVHO1b4EDU+uO7nFRzxaHB63oBILtJ5ZNfrqEV1vB/wZoQzohkiV/jA5A/z3IaVIvwbaV1iMvZgEkPrr6k/MWqO9A0ZTc1NvPjpFuGWnX3/KDI1YDG5RqfM+7EQSOgbgMRMswdOosN4YRbQMl0pBy96kouN7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721146497; c=relaxed/simple;
	bh=hxw6XukNWAxWC1XpF4uWkfPTZ6fsdD1wTD0n60CYjKs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m0Fc2admXuVG2XELmUMoybEnzLb8mNYUvMswsjhjjfVg5amAP/yj3GMSlITxVNdNQHJEmaPNTinGs6QYveTVad/GR2yuXIxi6QnVILin+cL+LIp3Kl7BQSpJSOh+9VgIWU5+eCtVCGgfLOPXCMn5ypiGzoaun2VNZqQVWt3DusE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=Ez+DlH8t; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="Ez+DlH8t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1721146476; x=1721751276; i=l.s.r@web.de;
	bh=h8nbo7S4POTjndh96lN9eKvO53BJ2mCJgCHjURkGE5c=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Ez+DlH8tumBLx/aT0TVGvFA7SRYPYQ/L7i67jaTQ3jYwAjVoeLBb58ho1pnPdzeM
	 0FOcYojI2bL5u7Ese36+Ams05FSiUnnd8hupe7vArbPgKaCs4hOKG+HIoCVkJ0Vqn
	 d3Mcz/zHmZGKCUDpy7D31ZbdQrTYKnlw1l+FRcs64Vk/hBK4LcM2oVdbCbuKWOqv5
	 2iBBionu6rPH5+jeMtx4WVepONE25lHdHo/oT2h5V1OsOSYyFPOApwjwAh+QYLxPg
	 ypL4F5UmF7Jk/fgt7gMjxUGaKxGa4bApRzDpq0E9hqkZJGiEbnErHHE1RBs5c9+/0
	 DBl89KpLFixD0Vudtw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.153.221]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MtPrY-1sCcsM0Nd0-00v9lt; Tue, 16
 Jul 2024 18:14:36 +0200
Message-ID: <1521ed89-989e-452b-b7fc-9e73672e0764@web.de>
Date: Tue, 16 Jul 2024 18:14:35 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH] t-strvec: fix type mismatch in check_strvec
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Cc: Git List <git@vger.kernel.org>, Patrick Steinhardt <ps@pks.im>,
 Phillip Wood <phillip.wood@dunelm.org.uk>
References: <35b0ba6b-d485-44f2-a19f-3ce816f8b435@web.de>
 <5bbef273-382e-4096-9ca6-d74781223e55@web.de>
 <20240716043727.GA1429885@coredump.intra.peff.net>
 <xmqq4j8pcqji.fsf@gitster.g>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqq4j8pcqji.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xnReFJNs49cMhswBD3urBFrHVw554c8Cw8duhPya8tErQViKmBc
 6bVP4glzFY+gEnruRJMWQdIWck5p9bezvKKbP+Jkn/iq8ycilNq+m+lQGDTx4xXB8i2aM7G
 PprMdGN9bUyFwwDG2PAMoe41bvvlK2xa2viX725tmqQAZDwjM6QLVfkU9NMncuCQPspPOgo
 cXzUVLnB7qU83mriBm96Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:7zaGYgNq67M=;GUjMPhCRWXnSz81wIkOgfsxpQA7
 b2z+a4z5c7A/izEJQU5M64x5NN+FJiZfJrCBbc0uWxX0Ow73s0YbaVOWRRRCf2LiwjEZBqxRb
 ACeKr1+K6KEuASjVccK6gAH4Jwow3ScRL6cA0Y26tpN6PBrHunwUZO4rdBKpUbSZcQ7hcCHvm
 3ivdbakNb5ihMGjZXYxW2fIh0V2/eIr6sStuqBw/EFUIMKQgLVE8ivhBbtSfT+6/rXQ/lhuvE
 mW1aCs2IIbNeCumq95ljpEEf8hBThrvy5LCYR+c7HtKvHRzkMrg7pNTEefPgy+isXsC0YXttO
 DYEWcB45e16xkIuXpXBVAvj24YT5iBfpYzH0TBbovz8trcLxAldjaRSUgWC9GmPLLnEJdQF/F
 vLqgbw3C96OPoZ2Ao/id7p4w5294XQMMTBX1XBjL1WGYpGXYwscEG9PBKL7XVz8moywZrRtFk
 i1Pofk67+k/kU7Ih5mVXzLPfikjQwunwtgoFmd2tSZ8e5KusLf9epcmUKjmUjf9ljahzs9bcX
 Tt7+XTOC7kGbBxc5XX9zfz7cFJ2N8FbA5SI0rpWpwsEqWBti86jWsal3EXNaVkE5miONiyjvj
 KZetMx6cf54zKdAoHfuej9VgHNGUxdNfKSiqOMVsJsSHyoc7boA/2dPCWwS7YpwTbDybTcU/I
 M2cAgSwSHIPKtj0IH7zsduoRnYEIA1hgaEMmJXNrneHKHRhFexN0x1Ky+/xXJ+f5F6EKxM0d7
 TBC6ht7ldvyJU2ksbfhYNZrrMbw2YRsR9UQwhrQPz/mDyIEzkaeWhu29zqylDcop+U8qLvnEh
 APpjTT/S8Ct1qU5cL3SUJy3Q==

Cast i from size_t to uintmax_t to match the format string.

Reported-by: Jeff King <peff@peff.net>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
Oops, sorry about that. :-(

PRIuMAX is "lu" on my system, so the compiler didn't flag the mistake.

 t/unit-tests/t-strvec.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/unit-tests/t-strvec.c b/t/unit-tests/t-strvec.c
index fdb28ba220..fa1a041469 100644
=2D-- a/t/unit-tests/t-strvec.c
+++ b/t/unit-tests/t-strvec.c
@@ -11,7 +11,8 @@
 		    check_uint((vec)->nr, <=3D, (vec)->alloc)) { \
 			for (size_t i =3D 0; i < ARRAY_SIZE(expect); i++) { \
 				if (!check_str((vec)->v[i], expect[i])) { \
-					test_msg("      i: %"PRIuMAX, i); \
+					test_msg("      i: %"PRIuMAX, \
+						 (uintmax_t)i); \
 					break; \
 				} \
 			} \
=2D-
2.45.2
