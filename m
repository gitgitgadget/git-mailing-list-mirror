Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 894D6C433EF
	for <git@archiver.kernel.org>; Sat, 16 Jul 2022 17:02:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbiGPRCr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Jul 2022 13:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiGPRCq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Jul 2022 13:02:46 -0400
Received: from mout.web.de (mout.web.de [212.227.15.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279951F62E
        for <git@vger.kernel.org>; Sat, 16 Jul 2022 10:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1657990958;
        bh=buZGKpC0RpNv9sOGu9nmHwy8/TYE97mnrVNiOTjp/S4=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=SPXH9wtgVF2N4POx45Ovj3bzrwBIyRt20GEheOc0TBuVUlN5Vqn9KAAaXw8emsRLE
         0qjRpVhGz+Hbgjal0COZK4nObsW1ouk9joRo7g1aSl4bYn3QpyB6vH1vwzWTaXE0IZ
         a5qFrQ5mi869H4//iMpj9k21T+KJn+C/Wf0oNP18=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.19.130]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mx0N5-1nJHxF2ikN-00yJ8L; Sat, 16
 Jul 2022 19:02:38 +0200
Message-ID: <2fd427e6-2f3c-66d1-bcc5-6bb1e0f59f08@web.de>
Date:   Sat, 16 Jul 2022 19:02:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.0.2
Subject: [PATCH 10/10] mergesort: remove llist_mergesort()
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
References: <4d7cd286-398e-215c-f2bd-aa7e8207be4f@web.de>
In-Reply-To: <4d7cd286-398e-215c-f2bd-aa7e8207be4f@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:n6Zaf3h+uHXPe6GyZwxNh2pxegFOKkL1TKnsc43Tzzu29CMT53L
 +9s7v+hxLYuXWXzEF9BeKhJcyq82ih+tFiapi1NgIy5Vs5Vy2bCklXWgh6Ek9mQsKIWeU3z
 anvbWqWp4HsPbcEOVGi9rIoZMajHBfxacC7frdhJDBRM2tXwfB3oW9Tu0SH/n4vc12b9Hl5
 vHc3dLjfIqLdOIGDxArBA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bHZ9ifs8JIQ=:rQ4q6jxVIlQmZZTK02FS8d
 TQqzgzceUZOkmOL1JgYJVoSNf356U5qya9mdatEuhghW8E/Kvk5KiTaGuBDeP7X57GBHK37Tf
 repCgL/o5MINL85inak919pvt7iisZ6qoQBSM31cyRx8VC5L0JZzo+bgzp4f+ynnz6/F6LLme
 fMkPPXW3a55CDn6RmqpHy6EdoehkNIMMsp+iLepNLpioF28T+Tygjzr019qCHrLpCG/biU543
 Vtk3CF191RE/Zru9yC6msikS/yKZIIlVW1EM1ivuhRtnUPD/0t8emzNR9XDyJYO7namLrEM4b
 cW+XlmL+9UQlhEsbZVE2fKwDJbP9WNWJZIMLUVIVwBleUGNmB60PWsw6IDvM+6mrHeGpd6xEu
 M6sgJ2ZPyBQ/VQhPLbRCF9efNY6lRjA6pG584WyEuA3Bdjt2kGx/3PNZo4R3Djsjs6fST3LWe
 H56axXVdcdAY/g5DYGYfveEOuNdlfxGd7YzgWcoJpfgHpLxl2TEf/UU4O/KxRygOdsjhNCtM7
 ESzEUUlmVD6fpa4md1ZmhyqSQFRLxGQKmbcLp0pJzlKa/rXkIB+EwoctfHHA95J8/TFJBdSlv
 P241mDEzdwV4Ju/PxM9q3sxjRmEKJZkyqVP+yVd9uSOSL3y68ZWZ4SmNDRLgnCr3lzIYffhwG
 TQsczMI05BL9RER9zeNGuHvpBWIotDFPyH05Jqc8BGJ6MeGB26BO8DBiMWNsaskgNN46XsM3j
 pq9ophdOIfugE3TV8ZLI3NQAQPMtLWp0+P5hvqrzEFDKPq6YTdb60ZOMWAt4RrmfgGWI5vBCZ
 1fHd+cqRkCMY7CqLixzIQsBXX8yJjh+czsCpHABV7FDUlOJy/684MIUg5FlplYsOF0dGaTtBM
 7pJTxllEC7HJlC0EdIMR10U3sSV1+I9qL/KzdvXe7Gi4CX6w2bBQw7xK9C9XLu4lxJGHO6Eea
 z+bhkmXuXdr64cfSGZzDcTSF/rQfp+komN7EmCCkF5QMYVWhkHlJ6dyZLqccIR5FkO++5eGQx
 MSlmNR0JU5ncb5iR9iaT/n/l4MoG63PAZ+Jk2r2g8AjLcWEFThkI7WrxGnpcsEkVjX3Foczsa
 OYRjFDAwL8FAk/zvexMpCbAiyDwrSo9mFk+adHdTf6sFsFG5KUSupFABQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that all of its callers are gone, remove llist_mergesort().

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 Makefile    |  1 -
 mergesort.c | 76 -----------------------------------------------------
 mergesort.h | 13 ---------
 3 files changed, 90 deletions(-)
 delete mode 100644 mergesort.c

diff --git a/Makefile b/Makefile
index 04d0fd1fe6..d41705dc31 100644
=2D-- a/Makefile
+++ b/Makefile
@@ -984,7 +984,6 @@ LIB_OBJS +=3D merge-ort.o
 LIB_OBJS +=3D merge-ort-wrappers.o
 LIB_OBJS +=3D merge-recursive.o
 LIB_OBJS +=3D merge.o
-LIB_OBJS +=3D mergesort.o
 LIB_OBJS +=3D midx.o
 LIB_OBJS +=3D name-hash.o
 LIB_OBJS +=3D negotiator/default.o
diff --git a/mergesort.c b/mergesort.c
deleted file mode 100644
index 6bda3a1c0e..0000000000
=2D-- a/mergesort.c
+++ /dev/null
@@ -1,76 +0,0 @@
-#include "cache.h"
-#include "mergesort.h"
-
-/* Combine two sorted lists.  Take from `list` on equality. */
-static void *llist_merge(void *list, void *other,
-			 void *(*get_next_fn)(const void *),
-			 void (*set_next_fn)(void *, void *),
-			 int (*compare_fn)(const void *, const void *))
-{
-	void *result =3D list, *tail;
-	int prefer_list =3D compare_fn(list, other) <=3D 0;
-
-	if (!prefer_list) {
-		result =3D other;
-		SWAP(list, other);
-	}
-	for (;;) {
-		do {
-			tail =3D list;
-			list =3D get_next_fn(list);
-			if (!list) {
-				set_next_fn(tail, other);
-				return result;
-			}
-		} while (compare_fn(list, other) < prefer_list);
-		set_next_fn(tail, other);
-		prefer_list ^=3D 1;
-		SWAP(list, other);
-	}
-}
-
-/*
- * Perform an iterative mergesort using an array of sublists.
- *
- * n is the number of items.
- * ranks[i] is undefined if n & 2^i =3D=3D 0, and assumed empty.
- * ranks[i] contains a sublist of length 2^i otherwise.
- *
- * The number of bits in a void pointer limits the number of objects
- * that can be created, and thus the number of array elements necessary
- * to be able to sort any valid list.
- *
- * Adding an item to this array is like incrementing a binary number;
- * positional values for set bits correspond to sublist lengths.
- */
-void *llist_mergesort(void *list,
-		      void *(*get_next_fn)(const void *),
-		      void (*set_next_fn)(void *, void *),
-		      int (*compare_fn)(const void *, const void *))
-{
-	void *ranks[bitsizeof(void *)];
-	size_t n =3D 0;
-
-	if (!list)
-		return NULL;
-
-	for (;;) {
-		int i;
-		size_t m;
-		void *next =3D get_next_fn(list);
-		if (next)
-			set_next_fn(list, NULL);
-		for (i =3D 0, m =3D n;; i++, m >>=3D 1) {
-			if (m & 1)
-				list =3D llist_merge(ranks[i], list, get_next_fn,
-						   set_next_fn, compare_fn);
-			else if (next)
-				break;
-			else if (!m)
-				return list;
-		}
-		n++;
-		ranks[i] =3D list;
-		list =3D next;
-	}
-}
diff --git a/mergesort.h b/mergesort.h
index 7b44355283..7c36f08bd5 100644
=2D-- a/mergesort.h
+++ b/mergesort.h
@@ -1,19 +1,6 @@
 #ifndef MERGESORT_H
 #define MERGESORT_H

-/*
- * Sort linked list in place.
- * - get_next_fn() returns the next element given an element of a linked =
list.
- * - set_next_fn() takes two elements A and B, and makes B the "next" ele=
ment
- *   of A on the list.
- * - compare_fn() takes two elements A and B, and returns negative, 0, po=
sitive
- *   as the same sign as "subtracting" B from A.
- */
-void *llist_mergesort(void *list,
-		      void *(*get_next_fn)(const void *),
-		      void (*set_next_fn)(void *, void *),
-		      int (*compare_fn)(const void *, const void *));
-
 /* Combine two sorted lists.  Take from `list` on equality. */
 #define DEFINE_LIST_MERGE_INTERNAL(name, type)				\
 static type *name##__merge(type *list, type *other,			\
=2D-
2.37.1
