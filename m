Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8DDB02082F
	for <e@80x24.org>; Sat, 15 Jul 2017 19:36:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751180AbdGOTgq (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Jul 2017 15:36:46 -0400
Received: from mout.web.de ([217.72.192.78]:60579 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751152AbdGOTgp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Jul 2017 15:36:45 -0400
Received: from [192.168.178.36] ([79.237.60.227]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LzKIP-1djzUa32GX-014RpN; Sat, 15
 Jul 2017 21:36:21 +0200
X-Mozilla-News-Host: news://news.public-inbox.org:119
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH 1/2] add MOVE_ARRAY
Message-ID: <ec78a849-36e4-4b1d-1ad6-46dcc39a1396@web.de>
Date:   Sat, 15 Jul 2017 21:36:20 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:niqLh4G7Ctr65pKIFuUZXguo3d2D+MxyiunGPIoYcYoSugz9wqu
 be7ZXcTgBXgyZPBNPpa7HFs5ZM22TCW76SzTV8jeACDSFSSmDzhHzMNdE7eKnBaYiny5yFN
 P11yGllammGNuDnt70D2rTQcxkFCHlUrQ5xAvNQRVQgvbrKJk6Kdmv5Zua6l7y47WEwh1EJ
 1WGztuJVT/yQqoold3i1Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:RSUc/x0BD60=:O2NMriYpPTgXxFKBVVZb4K
 M26hHXVtNk3ceUiHekVF34OaYRid4or68c05cGmL0TVv22Xu6ea6wcWvn7FacIHKh53jfvdWr
 I1rMRyPsKFEKOLGpQlhiWJwzmUfewjXmP9hvvWBEQMMRyugiqs9a3Bl2BeK/53OC7llPPLFre
 so94s4aGO459jwMtyz8G7pAPYdn/L7xSuqwJ3IfghHIGsNCdoJWwTXyUMmGrS/iv05T5fpaCo
 jme7oQ+PUXQ901l0qdc7jrqYfD8E0/RmTKOqU1CBt1oYtC1QRpCedkSrcm2UTq+iQdZJmPW5w
 NX4fngYI+Fo++cWflDKgdbbuvpa45H/4t7JgfD+WPrdONmDv8wpRH/nen83hTtzAieV46wGk/
 zZECRfA0AKTbNb7/g2Jzuu1KUYGID1tQqNC5MOXJVaRxeUh9gX/v+l6sHJx8GxvSwT6AOn/Wl
 9ePUaA9wTgcxtMbeCO8VpjS0DhYpqVURYyH2nTOnOYIHb985F+D6IHh/JTp4sIR0JFdP9+E3q
 e3n3cbnvM63PlMZNJNQdqfuYkvoq1VSV5/FUCleIPGl6grKdSrsBPb3OUx/pC93h6DCMeXYJm
 rUz8Vy/K1t1LuilBOpdiiNnY8U5lF+QwGTBUmYYbYeU33z1l8WEloXTpMC2JIPiui/uFxuxdF
 +31uK7WWyP3D674/oI5pwN5RTbx1hsJL1ryGCgkjCK2wAvkWdp8DPxywIvGEJJC1rfArwy3zS
 st7XPpek3Csu1oQ5GQWu2z9/3tudhCzVuXBQuCg6WzIPCutKFOh0qcG93ymYMOzueqoslFewz
 qVh4VRn+airIUL/6DGGM290ezYBGX2OKeyX0oj9lMS3kKidFmE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Similar to COPY_ARRAY (introduced in 60566cbb58), add a safe and
convenient helper for moving potentially overlapping ranges of array
entries.  It infers the element size, multiplies automatically and
safely to get the size in bytes, does a basic type safety check by
comparing element sizes and unlike memmove(3) it supports NULL
pointers iff 0 elements are to be moved.

Also add a semantic patch to demonstrate the helper's intended usage.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 contrib/coccinelle/array.cocci | 17 +++++++++++++++++
 git-compat-util.h              |  8 ++++++++
 2 files changed, 25 insertions(+)

diff --git a/contrib/coccinelle/array.cocci b/contrib/coccinelle/array.cocci
index 4ba98b7eaf..c61d1ca8dc 100644
--- a/contrib/coccinelle/array.cocci
+++ b/contrib/coccinelle/array.cocci
@@ -27,6 +27,23 @@ expression n;
 
 @@
 type T;
+T *dst;
+T *src;
+expression n;
+@@
+(
+- memmove(dst, src, (n) * sizeof(*dst));
++ MOVE_ARRAY(dst, src, n);
+|
+- memmove(dst, src, (n) * sizeof(*src));
++ MOVE_ARRAY(dst, src, n);
+|
+- memmove(dst, src, (n) * sizeof(T));
++ MOVE_ARRAY(dst, src, n);
+)
+
+@@
+type T;
 T *ptr;
 expression n;
 @@
diff --git a/git-compat-util.h b/git-compat-util.h
index 047172d173..159f82154a 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -825,6 +825,14 @@ static inline void copy_array(void *dst, const void *src, size_t n, size_t size)
 		memcpy(dst, src, st_mult(size, n));
 }
 
+#define MOVE_ARRAY(dst, src, n) move_array((dst), (src), (n), sizeof(*(dst)) + \
+	BUILD_ASSERT_OR_ZERO(sizeof(*(dst)) == sizeof(*(src))))
+static inline void move_array(void *dst, const void *src, size_t n, size_t size)
+{
+	if (n)
+		memmove(dst, src, st_mult(size, n));
+}
+
 /*
  * These functions help you allocate structs with flex arrays, and copy
  * the data directly into the array. For example, if you had:
-- 
2.13.3
