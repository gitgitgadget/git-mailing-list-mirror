Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC8CDC433EF
	for <git@archiver.kernel.org>; Sat, 16 Jul 2022 16:54:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231613AbiGPQy7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Jul 2022 12:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbiGPQy6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Jul 2022 12:54:58 -0400
Received: from mout.web.de (mout.web.de [212.227.15.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C6DD1E3C7
        for <git@vger.kernel.org>; Sat, 16 Jul 2022 09:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1657990492;
        bh=gtW5zPZpV39jtq0lRx43ddxtGniFDkDAP4D1Ikv14+A=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=jCN+8tis788TdcoXiCQnqik8SOs4XhGa1p4t+ch+OCcGQ43LHOpCYSrZELIYHdqIO
         ZmPmNCXI29e3CsNzA6UdRZ33CKGSwNNrWi4Uom8iyeyk9qxsoh0AV8qeWUIEFmOBQX
         NdjBWuDaEb9aBrUd1l9WHZ1aqpVYzIfa1vg//NGI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.19.130]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MzTPQ-1nHNBU1BVg-00vCzY; Sat, 16
 Jul 2022 18:54:52 +0200
Message-ID: <f127d516-3951-830f-72d4-263557339ec9@web.de>
Date:   Sat, 16 Jul 2022 18:54:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.0.2
Subject: [PATCH 03/10] mergesort: add macros for typed sort of linked lists
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
References: <4d7cd286-398e-215c-f2bd-aa7e8207be4f@web.de>
In-Reply-To: <4d7cd286-398e-215c-f2bd-aa7e8207be4f@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CE2gmwz2kVEhSfnB9zpVwis4gHABdc2LeSYx3B/uAqQGUHR0vN7
 YNUdaBUFDnBKlyL++lbBXvfCLiUx3ZvksaYpthvygNPDRwMfwRS4c3J87M+PeKaKwD4W4aj
 IQAprQhZrB/vErTFs6Tn52LLn4hlxdW4Sovuy+SHKqYqds+ARnNkMbfNdL0JYNJYaPqhebt
 PWCIY43VubsdS98oudR9w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:G+atJlCYoh8=:Z3VKxWUtFgawAqep70MzKy
 Uxqbq87vHG4egsm63pg8UuWY/s5NJOBeYUMx0d0scVF21Y7+87taWN8IMUYNlO1xhsXkcPl57
 tIX8jG9VZrF6SuntzBVhNL87CJf97DnXAzpV72xHfWCim+I9QxAdFzqhaC0lCifwmiyk/pAKb
 XAlwdUXSYLVniaQvGRTKcKbGir4XWKUMgiMLOtQ62oTIDTOsrzxtmrzX4puModW8hRtZvdKS4
 OPA2EGtFQ8Arqvbw8Z3oYJBoNXSd528EQ3xjskeIS+XdeYVIyg2C2kMLPV/yFEQn8o/Hjivln
 0C9m7LL2WfYszDavlsQsE132WacRSPOaK2zLdYYHkmkXQhhlfSMYwvJc8W4sCG3ZG4Bbm6b7P
 BiSVVp/cJ8Gaf1cdTGwdGiLRxQ4h+1Mf/vF9eYNqFRRcPAokaASINCP+NhGq29Tbfankznuum
 mi+Vam/JiKiTUfUjFQFxHOMeaXrHpYvD4bzVuZxPfonTFQyXQjBEdn4AV2Yo5FKL4+NKjm4Ni
 6Q4iJaTIbEO/FGwiIxgR3W3k+3Zmtagdmi180t7caqEVql6KQXFnwBe+PndUY7tpwNHxAHd+l
 68Kf3vjxJG0m7t1dD+UBlbVbbkV+FDH2G30jzJbuurm/ssrYS+rFUajqCQSlSjk6RRO2nCf/R
 HLUuaaZpb/HIdkw/OCWCT8TdtMWVngA2fpNT7wbT5N9OkCPqtT4JtYraiAMeceJE7R/mwsc9F
 8TuF47NRk/JQPdm68MVXSqzBH1nxvmeJFwo2jBZzcPQCiSI8e9h0SISkcHD6PT74BzOpLIejE
 xdNor0WuER1B/GbZbIGOqIL+y3GFlHA9wL1Y7TDB1qkWnbBqeugpg6VVsSEqOvhfa9VtJKN3N
 ihBE8ebzpzlPjCUxidlZmF2yjY3n0v2VudFHHPQhIP0J6UL493Ywcwf68yEHU/9IAF7+SmQ0d
 SZlzR109cIB7Rj4TscEpwJWggNkk9vEntpk7k6Fq1SpBIshcgtIQZzBg0OCY7XRRqW5s/4EBb
 bIFjv+o18QFpBmcfVaDkgpqTy+mGG3UjUsMsE15lH7AAOefNo0d2U2DK5JeG0yQT4XQU/KPPk
 M/QU/H9lqfK2jp9tF45fSNx50MUoBlFKzhv
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add the macros DECLARE_LIST_SORT and DEFINE_LIST_SORT for building
type-specific functions for sorting linked lists.  The generated
function expects a typed comparison function.

The programmer provides full type information (no void pointers).  This
allows the compiler to check whether the comparison function matches the
list type.  It can also inline the "next" pointer accessor functions and
even the comparison function to get rid of the calling overhead.

Also provide a DECLARE_LIST_SORT_DEBUG macro that allows executing
custom code whenever the accessor functions are used.  It's intended to
be used by test-mergesort, which counts these operations.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 mergesort.h | 101 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/mergesort.h b/mergesort.h
index 644cff1f96..7b44355283 100644
=2D-- a/mergesort.h
+++ b/mergesort.h
@@ -14,4 +14,105 @@ void *llist_mergesort(void *list,
 		      void (*set_next_fn)(void *, void *),
 		      int (*compare_fn)(const void *, const void *));

+/* Combine two sorted lists.  Take from `list` on equality. */
+#define DEFINE_LIST_MERGE_INTERNAL(name, type)				\
+static type *name##__merge(type *list, type *other,			\
+			   int (*compare_fn)(const type *, const type *))\
+{									\
+	type *result =3D list, *tail;					\
+	int prefer_list =3D compare_fn(list, other) <=3D 0;			\
+									\
+	if (!prefer_list) {						\
+		result =3D other;						\
+		SWAP(list, other);					\
+	}								\
+	for (;;) {							\
+		do {							\
+			tail =3D list;					\
+			list =3D name##__get_next(list);			\
+			if (!list) {					\
+				name##__set_next(tail, other);		\
+				return result;				\
+			}						\
+		} while (compare_fn(list, other) < prefer_list);	\
+		name##__set_next(tail, other);				\
+		prefer_list ^=3D 1;					\
+		SWAP(list, other);					\
+	}								\
+}
+
+/*
+ * Perform an iterative mergesort using an array of sublists.
+ *
+ * n is the number of items.
+ * ranks[i] is undefined if n & 2^i =3D=3D 0, and assumed empty.
+ * ranks[i] contains a sublist of length 2^i otherwise.
+ *
+ * The number of bits in a void pointer limits the number of objects
+ * that can be created, and thus the number of array elements necessary
+ * to be able to sort any valid list.
+ *
+ * Adding an item to this array is like incrementing a binary number;
+ * positional values for set bits correspond to sublist lengths.
+ */
+#define DEFINE_LIST_SORT_INTERNAL(scope, name, type)			\
+scope void name(type **listp,						\
+		int (*compare_fn)(const type *, const type *))		\
+{									\
+	type *list =3D *listp;						\
+	type *ranks[bitsizeof(type *)];					\
+	size_t n =3D 0;							\
+									\
+	if (!list)							\
+		return;							\
+									\
+	for (;;) {							\
+		int i;							\
+		size_t m;						\
+		type *next =3D name##__get_next(list);			\
+		if (next)						\
+			name##__set_next(list, NULL);			\
+		for (i =3D 0, m =3D n;; i++, m >>=3D 1) {			\
+			if (m & 1) {					\
+				list =3D name##__merge(ranks[i], list,	\
+						    compare_fn);	\
+			} else if (next) {				\
+				break;					\
+			} else if (!m) {				\
+				*listp =3D list;				\
+				return;					\
+			}						\
+		}							\
+		n++;							\
+		ranks[i] =3D list;					\
+		list =3D next;						\
+	}								\
+}
+
+#define DECLARE_LIST_SORT(scope, name, type)			\
+scope void name(type **listp,					\
+		int (*compare_fn)(const type *, const type *))
+
+#define DEFINE_LIST_SORT_DEBUG(scope, name, type, next_member,	\
+			       on_get_next, on_set_next)	\
+								\
+static inline type *name##__get_next(const type *elem)		\
+{								\
+	on_get_next;						\
+	return elem->next_member;				\
+}								\
+								\
+static inline void name##__set_next(type *elem, type *next)	\
+{								\
+	on_set_next;						\
+	elem->next_member =3D next;				\
+}								\
+								\
+DEFINE_LIST_MERGE_INTERNAL(name, type)				\
+DEFINE_LIST_SORT_INTERNAL(scope, name, type)			\
+DECLARE_LIST_SORT(scope, name, type)
+
+#define DEFINE_LIST_SORT(scope, name, type, next_member) \
+DEFINE_LIST_SORT_DEBUG(scope, name, type, next_member, (void)0, (void)0)
+
 #endif
=2D-
2.37.1
