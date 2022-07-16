Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA36DC433EF
	for <git@archiver.kernel.org>; Sat, 16 Jul 2022 16:52:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231528AbiGPQwn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Jul 2022 12:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbiGPQwl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Jul 2022 12:52:41 -0400
Received: from mout.web.de (mout.web.de [212.227.15.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F211DA5D
        for <git@vger.kernel.org>; Sat, 16 Jul 2022 09:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1657990352;
        bh=uOOvUnAVEgBBF3N5MP00f109ngKuXeeXmyNwxLUZc2c=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=DipfK4Uc7H7wiOpPC77CcEy1Gp44+vdS0m2A0Bri1XyVrTcKOIEGmRhCAglbsNW7A
         XwBlvGj+woI6ziWv3YLdHbWtigSjxHYPfbE7QJO7TIoyNz3oRnSMxQHuqz2oELj3zv
         ClTUbYWbLlwMKCOYRYive+pNuBv8/FT2XAi+HsCU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.19.130]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MdO9E-1ndQDA222C-00ZIPe; Sat, 16
 Jul 2022 18:52:32 +0200
Message-ID: <50b229e9-46b7-fdd1-3f68-de8dd4acf811@web.de>
Date:   Sat, 16 Jul 2022 18:52:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.0.2
Subject: [PATCH 01/10] mergesort: unify ranks loops
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
References: <4d7cd286-398e-215c-f2bd-aa7e8207be4f@web.de>
In-Reply-To: <4d7cd286-398e-215c-f2bd-aa7e8207be4f@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Q4jYaXuZuAE3ooDURVH/AoydeeoPCL+9DxSerN0GR0tFMQ1kJIG
 uKaOPdfc3eygpPC+dYAjcWnLF8x7ckSnCc4HsNwiVqYRmOEOtXEF0q8GIsr6ExFxo1LYab5
 VXdOxb1x4L29KVLI/bwyYZU6dcKhqyDm7CGBFZU4Qrs3OJrmYUVZFJDGQo1yjiIzxUBYnEh
 gxM3gVHi9SuBL6W+dCM0g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:u6rzjNYKl7U=:FT+T6BlMXColhTctB3CBf1
 qQBONrco3CJeq8t6N2XOjrqFLopHEtVdwgmZNa9Qvz9bxSNxYFQ0mpLc9+aJS8HYXm6x3O+ff
 bu2kKlw1gyCWGgjIDhp56Ks6aWNLAj2XK+zOj3vef43R5190qmuDD4X4yT1S5dIKegWtH+VZ6
 Ll7ywUaW36nqyS0iznbBKmACcg8CdNE0Df3DCIOqkQFh1Z8rybqJAjkDUyhNI750fKrYupSa9
 fJ/Hig9YN4eKb67b+avveo3EJuxFcAdY2HiAkr/3DPdJd1K3GwFNhk63gzEWWiry7cXnMIweu
 Oy0geJI89H5p91fOAk4vjJy6H4mbgT34+3cLWdFDaXgSdkpmhgUAXUJFfwSV7ID8XcmR+rH4q
 c0J7AeVexHzwZXMi5x//4Afx0xg1Je9dv8SiQc2y5Tzo53p3RAWXuVgSJRCT9KlxeJHVdEkOx
 HEcE1+Qn8yaiMOgV+sqUtQnhkHoNOQL+rCA7Azxef40gsdQXCDCQ5d2m3TBhsMMpyErR03Nxl
 xbgwLchq250ItQXW79Zaj5BOyy9bhfR0FuLzD+wboi9BikHe9nVA5YgtpLOcVGA3w3B/1xSsj
 9XZ8B177BOfvPldPbOP+tAUzj+eUpZYunxbjwfLiVnuTcqoxXtSkI0CJbSn1xQl+RW+kaXSyF
 A5vgKX1ZfAcKVK5WXsLeI0sDdtS+eaN1ep1UY6vKNnKLfiF/ex4LqrXHTSOqr83rKnQNwRoBr
 Xs293bcSG/9rDQQ0PCYDBU6kH7pP2gPSHeGYLaNuGovCM/7+K2oTb4N+wA3q/lBpqfVqy1t3U
 WeKkkA0P7uArC5yMvdazKy2xBOE9HDAIeCCH40c8VSIup1BH5nbXV6ZE5jSZoxZD+VxOvoSlu
 RKOcx+Eohrdx0jj6lK9dveBg5/vJ+DlWKEte7gEXu05QI21hXtBZhCJ8hRM0t4OO7vt0PdBPb
 ajykZOOlbnrPUlGIVcBVszvPwjyUK/smpBnETqj1y56SzfFFeLBzyj88V4J2Nborn07mnn23S
 nV+lyNSEzAIl1CzFRyZZEZgRrUiK9BneBY6RYHkOZMoTxcU9YvQYaBweNGLMT9LDXVeukOq+F
 s7nWtZLM1IfZwcsCYc23Xs0m4izBy2fAzr3
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

llist_mergesort() has a loop for adding a new element to the ranks array
and another one for rolling up said array into a single sorted list at
the end.  We can merge them, so that adding the last element rolls up
the whole array.  Handle the empty list before the main loop now because
list can't be NULL anymore inside the loop.

The result is shorter code and significantly less object text:

main:
__TEXT	__DATA	__OBJC	others	dec	hex
652	0	0	4651	5303	14b7	mergesort.o

With this patch:
__TEXT	__DATA	__OBJC	others	dec	hex
412	0	0	3441	3853	f0d	mergesort.o

Why is the change so big?  The reduction is amplified by llist_merge()
being inlined both before and after.

Performance stays basically the same:

main:
0071.12: llist_mergesort() unsorted    0.24(0.22+0.01)
0071.14: llist_mergesort() sorted      0.12(0.10+0.01)
0071.16: llist_mergesort() reversed    0.12(0.10+0.01)

Benchmark 1: t/helper/test-tool mergesort test
  Time (mean =C2=B1 =CF=83):     109.0 ms =C2=B1   0.3 ms    [User: 107.4 =
ms, System: 1.1 ms]
  Range (min =E2=80=A6 max):   108.7 ms =E2=80=A6 109.6 ms    27 runs

With this patch:
0071.12: llist_mergesort() unsorted    0.24(0.22+0.01)
0071.14: llist_mergesort() sorted      0.12(0.10+0.01)
0071.16: llist_mergesort() reversed    0.12(0.10+0.01)

Benchmark 1: t/helper/test-tool mergesort test
  Time (mean =C2=B1 =CF=83):     109.2 ms =C2=B1   0.2 ms    [User: 107.5 =
ms, System: 1.1 ms]
  Range (min =E2=80=A6 max):   108.9 ms =E2=80=A6 109.6 ms    27 runs

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 mergesort.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/mergesort.c b/mergesort.c
index bd9c6ef8ee..92150c4101 100644
=2D-- a/mergesort.c
+++ b/mergesort.c
@@ -57,28 +57,27 @@ void *llist_mergesort(void *list,
 {
 	void *ranks[bitsizeof(void *)];
 	size_t n =3D 0;
-	int i;

-	while (list) {
+	if (!list)
+		return NULL;
+
+	for (;;) {
+		int i;
+		size_t m;
 		void *next =3D get_next_fn(list);
 		if (next)
 			set_next_fn(list, NULL);
-		for (i =3D 0; n & ((size_t)1 << i); i++)
-			list =3D llist_merge(ranks[i], list, get_next_fn,
-					   set_next_fn, compare_fn);
+		for (i =3D 0, m =3D n;; i++, m >>=3D 1) {
+			if (m & 1)
+				list =3D llist_merge(ranks[i], list, get_next_fn,
+						   set_next_fn, compare_fn);
+			else if (next)
+				break;
+			else if (!m)
+				return list;
+		}
 		n++;
 		ranks[i] =3D list;
 		list =3D next;
 	}
-
-	for (i =3D 0; n; i++, n >>=3D 1) {
-		if (!(n & 1))
-			continue;
-		if (list)
-			list =3D llist_merge(ranks[i], list, get_next_fn,
-					   set_next_fn, compare_fn);
-		else
-			list =3D ranks[i];
-	}
-	return list;
 }
=2D-
2.37.1
