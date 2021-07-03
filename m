Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED02BC07E97
	for <git@archiver.kernel.org>; Sat,  3 Jul 2021 12:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0A5961919
	for <git@archiver.kernel.org>; Sat,  3 Jul 2021 12:57:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbhGCNAO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 3 Jul 2021 09:00:14 -0400
Received: from mout.web.de ([217.72.192.78]:34773 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229488AbhGCNAO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Jul 2021 09:00:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1625317052;
        bh=3wFBhGe3XQYuOXq+B+7oZ2vRrSxDfjnEce6jw4gWuh8=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=XD0HEUToGlvfC5qd6197ZEBpGwu8hUIgMQce8J0t9A26bTG9UPi3l9Rlv4HV9DrPx
         FuyvL7+yUQmpF6Ztg18Ch147bU4khozVL+fjeXmBAdCUmWSxjXs3Sf4YtBf2ZSlZxT
         Z0oOh7IjFh3gOzflOXR4OiQt+Hpg3anphnpTLm9Y=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([91.47.158.105]) by smtp.web.de
 (mrweb101 [213.165.67.124]) with ESMTPSA (Nemesis) id
 0M9ojk-1lt5cq0K3U-00B50D; Sat, 03 Jul 2021 14:57:32 +0200
Subject: [PATCH v2] khash: clarify that allocations never fail
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <d13b50fd-5944-0bbe-d28e-8232a2932598@web.de>
Message-ID: <3778fb28-ed19-e90e-216a-d29d72305155@web.de>
Date:   Sat, 3 Jul 2021 14:57:30 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <d13b50fd-5944-0bbe-d28e-8232a2932598@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:R+cHUz3+HPGmciaj6r7kupIt5kiV943uCjREzMdrZee8FNOhNZg
 V+lDUnQVIw1PV+UDluS25mnZo6fxjMdLNR1WKUNpv4DCDuZ6FOxDeBi1UqzadF4f1rXpgvl
 lywvq46AAm6rCvQtX41t0btbqIE7gtz4aTMQrDbCgyduZUyzmMp2JjdvQjozgQA3vEAHXYJ
 a8rsf6VLWUoSCTGCBYRhQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FQrElIZmGZg=:tscZNFdmCU2oT+alT6xPvw
 IF/lDsCdxw+pnzcaTi9lTEGIE+jI6waKAxrVlZ/drkAxm87msjn9xJPvttMbp7xz47mY/1xqE
 5gBibZLgqDwh+XxDRn1RS9usXTLoRv+Q9L3qJ4Uy1lxr48B1MMa8QgJ7GFE3zoVs0EqGSYk7S
 TAh0ea3rMgabCQGeBM6HcysqRrHmBd/Fqf5b1Sph99M1oPeZnOfpyddWk0JIRg8zTfOwJZM/S
 ZT7WbEX87sduLZUSw6i/zg7HVS5J+JrEJapqwOkmQLVwTf3Rnq/pV4EcMK64qhvCIDkRb7zeB
 Y218YZ6lFCvZ+bHwKXTN53Sv0xVN4V1W6pmENjKWeUZKJmxs1SXNqQXz9oik+OyhOTdi0FPBk
 XJkVA/hB7HdoBbc0vA+Ws95V2TSxUiZcMw0rahMGx5GYPTaYiKg1a3rW+74hBNQJoJ0xaxWtu
 PMjRPYz5AhBz6yoY1INYdEzAe4dvM066K3Xbdy2a5+tCVqFMew98PhJA/1gDrda1WhnVSvhjr
 6aWQRwt/CVK1RyaKRiDR9V4HFMQg/w2TsGwhXsg4sZFWE0iGzzJUUakAfBRbzfRkyRCXEmO0f
 JG8EGHNlj93dyXgtBXAncDTsxiOv+H0/yCD3LqtRxohmvf5jeYwJVF3l1OupZ19yRYDHfirLg
 yHk04W3ly5yUC41r2AnK+jJUhg2YG8YykGAY96ABgWwX67v17zX42XpiPZmHgv8y3YFB3Z6ze
 RTtLlJm2isSh9Ci0e7PdjYMuswymKRkVpgzL8WxaAY9kD7ow7lw8BxiuJRGMcN8FgPebl66/J
 V9EAo+jp9mm6jqktvd0M2dWM6iG7LaokKYnhQ+gmuhwpYSz28+pZ+Bn165Kc5PXaGQzEHICbb
 hNrblY7JKHYGoOjTBtpLmd3/bRRTDDCYBUxAt5t4oClSvLENP+OFNBA5lUGAGBr7lquWuPQtS
 yID4AVI//E4DZyeygMR5vobkwz5oLepSacE2neTqIj+PxK5lSOerXi8OIzJ9+oMLyBFdvDtbO
 5qB/Z9y4KGdxtHypKCHFQBznG5zUqRNg4STDG2r6pgWvLSWNnd/YJ2ikkqAW4nGQle3WkHptZ
 e9aY5nZdg4gUcwKvUNs4OyIP3/wjjQnc5qH
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We use our standard allocation functions and macros (xcalloc,
ALLOC_ARRAY, REALLOC_ARRAY) in our version of khash.h.  They terminate
the program on error instead, so code that's using them doesn't have to
handle allocation failures.  Make this behavior explicit by turning
kh_resize_ into a void function and removing the related unreachable
error handling code.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
Changes since v1:
- Removed BUG calls.
- Made kh_resize_ void instead.

 khash.h | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/khash.h b/khash.h
index 21c2095216..cb79bf8856 100644
=2D-- a/khash.h
+++ b/khash.h
@@ -74,7 +74,7 @@ static const double __ac_HASH_UPPER =3D 0.77;
 	void kh_destroy_##name(kh_##name##_t *h);					\
 	void kh_clear_##name(kh_##name##_t *h);						\
 	khint_t kh_get_##name(const kh_##name##_t *h, khkey_t key); \
-	int kh_resize_##name(kh_##name##_t *h, khint_t new_n_buckets); \
+	void kh_resize_##name(kh_##name##_t *h, khint_t new_n_buckets); \
 	khint_t kh_put_##name(kh_##name##_t *h, khkey_t key, int *ret); \
 	void kh_del_##name(kh_##name##_t *h, khint_t x);

@@ -116,7 +116,7 @@ static const double __ac_HASH_UPPER =3D 0.77;
 			return __ac_iseither(h->flags, i)? h->n_buckets : i;		\
 		} else return 0;												\
 	}																	\
-	SCOPE int kh_resize_##name(kh_##name##_t *h, khint_t new_n_buckets) \
+	SCOPE void kh_resize_##name(kh_##name##_t *h, khint_t new_n_buckets) \
 	{ /* This function uses 0.25*n_buckets bytes of working space instead of=
 [sizeof(key_t+val_t)+.25]*n_buckets. */ \
 		khint32_t *new_flags =3D NULL;										\
 		khint_t j =3D 1;													\
@@ -126,7 +126,6 @@ static const double __ac_HASH_UPPER =3D 0.77;
 			if (h->size >=3D (khint_t)(new_n_buckets * __ac_HASH_UPPER + 0.5)) j =
=3D 0;	/* requested size is too small */ \
 			else { /* hash table size to be changed (shrink or expand); rehash */ =
\
 				ALLOC_ARRAY(new_flags, __ac_fsize(new_n_buckets)); \
-				if (!new_flags) return -1;								\
 				memset(new_flags, 0xaa, __ac_fsize(new_n_buckets) * sizeof(khint32_t)=
); \
 				if (h->n_buckets < new_n_buckets) {	/* expand */		\
 					REALLOC_ARRAY(h->keys, new_n_buckets); \
@@ -173,18 +172,15 @@ static const double __ac_HASH_UPPER =3D 0.77;
 			h->n_occupied =3D h->size;									\
 			h->upper_bound =3D (khint_t)(h->n_buckets * __ac_HASH_UPPER + 0.5); \
 		}																\
-		return 0;														\
 	}																	\
 	SCOPE khint_t kh_put_##name(kh_##name##_t *h, khkey_t key, int *ret) \
 	{																	\
 		khint_t x;														\
 		if (h->n_occupied >=3D h->upper_bound) { /* update the hash table */ \
 			if (h->n_buckets > (h->size<<1)) {							\
-				if (kh_resize_##name(h, h->n_buckets - 1) < 0) { /* clear "deleted" e=
lements */ \
-					*ret =3D -1; return h->n_buckets;						\
-				}														\
-			} else if (kh_resize_##name(h, h->n_buckets + 1) < 0) { /* expand the =
hash table */ \
-				*ret =3D -1; return h->n_buckets;							\
+				kh_resize_##name(h, h->n_buckets - 1); /* clear "deleted" elements */=
 \
+			} else { \
+				kh_resize_##name(h, h->n_buckets + 1); /* expand the hash table */ \
 			}															\
 		} /* TODO: to implement automatically shrinking; resize() already suppo=
rt shrinking */ \
 		{																\
=2D-
2.32.0
