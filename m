Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1603C43334
	for <git@archiver.kernel.org>; Fri,  3 Jun 2022 22:23:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349541AbiFCWXG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jun 2022 18:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231882AbiFCWXF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jun 2022 18:23:05 -0400
Received: from mout.web.de (mout.web.de [212.227.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C70C0326E9
        for <git@vger.kernel.org>; Fri,  3 Jun 2022 15:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1654294955;
        bh=yRxvusE/vIZxx2SqIYsPqqU4C9CVNJ8vopwFRCnOf84=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=lAOcoRrpdihbJxD4zaQhIo6au4HEt580VFZy8lFcFu4ix1plLZAAawT/lrPqEko5T
         OLiuSHwq8bVmXqeaiLGdrdyCMgWc/RWy9mSZknP+RkCpX6M/A01aoapJDUlV3+eaaP
         So2yA0IgggIfa6kqL4892DSQCC5q4Y6ifZePLi60=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.31.99]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MTOli-1oMeJz031Y-00TnpF; Sat, 04
 Jun 2022 00:22:35 +0200
Message-ID: <693ed3c3-535e-9eae-9fd7-ca612ebf6943@web.de>
Date:   Sat, 4 Jun 2022 00:22:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [RFC PATCH 03/15] reftable: don't memset() a NULL from failed
 malloc()
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jinoh Kang <luke1337@theori.io>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Glen Choo <chooglen@google.com>, Paul Tan <pyokagan@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        Jeff Smith <whydoubt@gmail.com>, Taylor Blau <me@ttaylorr.com>
References: <RFC-cover-00.15-00000000000-20220603T183608Z-avarab@gmail.com>
 <RFC-patch-03.15-0b570d112fc-20220603T183608Z-avarab@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <RFC-patch-03.15-0b570d112fc-20220603T183608Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kS/1igJLM7HyjJcVyKVKjiujFtnX5V+o/Wh7vwoqE45TfbAU5Jq
 EquV+byXKDMMGp5CD+K0ebXvkaFawkUhOo5EbQcBtYA2z0bPbqH+OcCvKy79PhZGbdX5wRS
 bjFkhMz8LOzLEqeEbC2lpmHlQs/BOJRCcSzukv6JEPlCRVnLJUmF7rSfEUuahxAQ/qD/m5F
 Y6By1qwfqHdpVhrqv7HyA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:27E2tttR8IM=:dROE4hsq6+02XM4ONP6lIq
 8ytnFNMOrfgBJ2pHwWAk31lOOjxZQndKXm3XaTnz6VxqP/qWqkvefuma+25QQkeGCk07IG+Gq
 iaq2NhnZmsy+E5zVy0EFMmvSqTb08/eeCUBEtVzobkNv+xBdrDi2PidBfZ3ZrqQGRC7qjLW1k
 lj9Du2+l9NL37HjYE5g1Pw9KuRElE6NxHzc6hP6MdLh9nqtmc5YR6c6BGMQ3LRBg2SnCzLQOP
 aRkQeITeFhmkFAfgsbw+k4FD4LQr0ZW4jBmgcrXDEasoGM1Q4hgkchVvfRYkXBqTPaETZ3iX3
 c18t5zm3jpQ2J8ypXBe8MPtfjfBithYu+fDCZ1P8wH0jcmVu+pgyfn8JyEIGzPhyUW2iVh/b9
 TTSVTii1U1C9VcbtFNf7YdgCqH5vkXJBB5U/URTNl710dGnq2GfPAzcjov3jZgMo+E2hStdny
 hsoU5hfs7iiCE1nfHzesBk+YaM8sxRkStZ9IelbkoVhmr2BSivMZbGXHxGNvrorFOOIaCF2p6
 QD8d4/9PeNFpJ0dN9Rq9yguxU6S4U4z/5lItr8t2YOCAD+gBckB8MkHDxuMHvxLF0LDcXJDHp
 2PEPM3XDz8Udapt+DG/H+xkjuDQkQMgR3VGmG6volI8R/Xe8TjcIILWMhp5vPO3N3XVcKtSbU
 3OL05mgHNF9TCqlyhkFgn07nVt8WCMZzSMQunhrRs9XI1jALopBeowAPfE+Haq8BOeeozSsqq
 ys2Uy9WN1eI7tnjjdAT9gJCpdeJ/ReQT0mX1qkdkKCLEq9HUHKdMqeYjGiIR33jQQSbt+KN/A
 A5WJNToeNWIwrB7NcR5mgB0JlrX+1mTRdHlPA9SEcBlnR0P+CqwcytMW9FZ8MQy9fVHssJxGb
 QlyjOotN3LLIjwKDtcmtapSS3CZV2xut+zgQYHvry8kVCZzjfY2l8NB1JKWhYTFtHIHd0SCIj
 b1Lvzvia5y+ZRtCdZ0pqFSa7NFrSLZemlQhKZeyMAFEyeZ1rtBw+qWB1MgxhL1XXuZNgoKTSx
 tMPXvEqAFRjCjCcIVCCfJVSWJPiuAFbB5i7yjGaItykTHBOB4M1M3rf2lK3MNzP6GbREyA6Kk
 bAl6/3fdn547k8j2lLYxNQHgbGytG8szF6/
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 03.06.22 um 20:37 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
> Return NULL instead of possibly feeding a NULL to memset() in
> reftable_calloc(). This issue was noted by GCC 12's -fanalyzer:
>
> 	reftable/publicbasics.c: In function =E2=80=98reftable_calloc=E2=80=99:
> 	reftable/publicbasics.c:43:9: error: use of possibly-NULL =E2=80=98p=E2=
=80=99 where non-null expected [CWE-690] [-Werror=3Danalyzer-possible-null=
-argument]
> 	   43 |         memset(p, 0, sz);
> 	      |         ^~~~~~~~~~~~~~~~
> 	[...]
>
> This bug has been with us ever since this code was added in
> ef8a6c62687 (reftable: utility functions, 2021-10-07).
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  reftable/publicbasics.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/reftable/publicbasics.c b/reftable/publicbasics.c
> index 0ad7d5c0ff2..a18167f5ab7 100644
> --- a/reftable/publicbasics.c
> +++ b/reftable/publicbasics.c
> @@ -40,6 +40,8 @@ void reftable_free(void *p)
>  void *reftable_calloc(size_t sz)
>  {
>  	void *p =3D reftable_malloc(sz);
> +	if (!p)
> +		return NULL;
>  	memset(p, 0, sz);
>  	return p;
>  }

We discussed this before, in
https://lore.kernel.org/git/RFC-patch-2.2-364d1194a95-20220415T101740Z-ava=
rab@gmail.com/

If this code was actually used by Git and still not handling allocation
failures then I'd propose something like the below instead.

Next I'd probably try to convert reftable_calloc() calls to a variant
that takes size and count separately -- like calloc(3) does -- to avoid
unchecked multiplication.

=2D-- >8 ---
Subject: [PATCH] reftable: remove reftable_set_alloc()

Use our native allocation functions for the reftable code to provide
consistent handling of allocation failures.  Remove the ability to
change the allocator, as we don't need it anymore after this change.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 reftable/basics.h          |  7 -------
 reftable/publicbasics.c    | 43 --------------------------------------
 reftable/reftable-malloc.h | 18 ----------------
 reftable/system.h          |  5 +++++
 4 files changed, 5 insertions(+), 68 deletions(-)
 delete mode 100644 reftable/reftable-malloc.h

diff --git a/reftable/basics.h b/reftable/basics.h
index 096b36862b..3386ff6484 100644
=2D-- a/reftable/basics.h
+++ b/reftable/basics.h
@@ -46,13 +46,6 @@ int names_equal(char **a, char **b);
 /* returns the array size of a NULL-terminated array of strings. */
 int names_length(char **names);

-/* Allocation routines; they invoke the functions set through
- * reftable_set_alloc() */
-void *reftable_malloc(size_t sz);
-void *reftable_realloc(void *p, size_t sz);
-void reftable_free(void *p);
-void *reftable_calloc(size_t sz);
-
 /* Find the longest shared prefix size of `a` and `b` */
 struct strbuf;
 int common_prefix_size(struct strbuf *a, struct strbuf *b);
diff --git a/reftable/publicbasics.c b/reftable/publicbasics.c
index 0ad7d5c0ff..4dd4204ce6 100644
=2D-- a/reftable/publicbasics.c
+++ b/reftable/publicbasics.c
@@ -6,52 +6,9 @@ license that can be found in the LICENSE file or at
 https://developers.google.com/open-source/licenses/bsd
 */

-#include "reftable-malloc.h"
-
 #include "basics.h"
 #include "system.h"

-static void *(*reftable_malloc_ptr)(size_t sz);
-static void *(*reftable_realloc_ptr)(void *, size_t);
-static void (*reftable_free_ptr)(void *);
-
-void *reftable_malloc(size_t sz)
-{
-	if (reftable_malloc_ptr)
-		return (*reftable_malloc_ptr)(sz);
-	return malloc(sz);
-}
-
-void *reftable_realloc(void *p, size_t sz)
-{
-	if (reftable_realloc_ptr)
-		return (*reftable_realloc_ptr)(p, sz);
-	return realloc(p, sz);
-}
-
-void reftable_free(void *p)
-{
-	if (reftable_free_ptr)
-		reftable_free_ptr(p);
-	else
-		free(p);
-}
-
-void *reftable_calloc(size_t sz)
-{
-	void *p =3D reftable_malloc(sz);
-	memset(p, 0, sz);
-	return p;
-}
-
-void reftable_set_alloc(void *(*malloc)(size_t),
-			void *(*realloc)(void *, size_t), void (*free)(void *))
-{
-	reftable_malloc_ptr =3D malloc;
-	reftable_realloc_ptr =3D realloc;
-	reftable_free_ptr =3D free;
-}
-
 int hash_size(uint32_t id)
 {
 	switch (id) {
diff --git a/reftable/reftable-malloc.h b/reftable/reftable-malloc.h
deleted file mode 100644
index 5f2185f1f3..0000000000
=2D-- a/reftable/reftable-malloc.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/*
-Copyright 2020 Google LLC
-
-Use of this source code is governed by a BSD-style
-license that can be found in the LICENSE file or at
-https://developers.google.com/open-source/licenses/bsd
-*/
-
-#ifndef REFTABLE_H
-#define REFTABLE_H
-
-#include <stddef.h>
-
-/* Overrides the functions to use for memory management. */
-void reftable_set_alloc(void *(*malloc)(size_t),
-			void *(*realloc)(void *, size_t), void (*free)(void *));
-
-#endif
diff --git a/reftable/system.h b/reftable/system.h
index 18f9207dfe..d7c7c20115 100644
=2D-- a/reftable/system.h
+++ b/reftable/system.h
@@ -16,6 +16,11 @@ license that can be found in the LICENSE file or at
 #include "hash.h" /* hash ID, sizes.*/
 #include "dir.h" /* remove_dir_recursively, for tests.*/

+#define reftable_malloc(x) xmalloc(x)
+#define reftable_realloc(x, y) xrealloc((x), (y))
+#define reftable_free(x) free(x)
+#define reftable_calloc(x) xcalloc(1, (x))
+
 int hash_size(uint32_t id);

 #endif
=2D-
2.35.3
