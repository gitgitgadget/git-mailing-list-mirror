Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 513C3C433EF
	for <git@archiver.kernel.org>; Sat, 16 Jul 2022 17:00:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231903AbiGPRAK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Jul 2022 13:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbiGPRAK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Jul 2022 13:00:10 -0400
Received: from mout.web.de (mout.web.de [212.227.15.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF5D1F609
        for <git@vger.kernel.org>; Sat, 16 Jul 2022 10:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1657990800;
        bh=5N9DghwnJ7g7FzOLCtIxw1O4NxjWPkP5czoq8DwncWE=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=V1ZzmUji/OMPtlaokrxh/qmFS3AUp9j20LWhRswvsNxjelzN4FQ0tT04SQecfSV3M
         zI2eJxA86HsAVI6l+/im6X/s8n8lyJ/Q1KcXwAOCgM0ThXxHQ4eUna7Q3UqJlOXuCA
         skAK75ZqTPlRg2eQ/RO66K9UyHQVbRBCZ/m8tpq4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.19.130]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MUlDJ-1o48KP03ov-00QvFU; Sat, 16
 Jul 2022 19:00:00 +0200
Message-ID: <fcae44af-19c9-b289-9c2a-db726dbc586a@web.de>
Date:   Sat, 16 Jul 2022 18:59:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.0.2
Subject: [PATCH 08/10] fetch-pack: use DEFINE_LIST_SORT
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
References: <4d7cd286-398e-215c-f2bd-aa7e8207be4f@web.de>
In-Reply-To: <4d7cd286-398e-215c-f2bd-aa7e8207be4f@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:P9eEwJkC+r1dtoT+JFbrAx4rtYT4dIkhhwo1d1oyOXwiNDcXujN
 UmThJAQey+gTq9Sf/svHEirtfGvxU8y6ltbFPTONmZXZdM6PDhkrNGxwSmVdOC1MY5Lo2ko
 CwQf2iYFpNdmudRqQiRhv+t6yNUPD3/dLOdzwd52knhWATa3log40JZXwI8/Q3smIhZLLhu
 bXhfitu83JGc1goamtiNQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QI9FNULLqaQ=:TYUlQom5dZu+hubP+cENXc
 /AZQGM5WuHVmDePEG4blKjoGjcjutQVi7iZ0GdUF6RbzNHJjQRYq6xX4+arpWG1kpxA6a4w6W
 jThyc5vvV1InJd50f8K2OvPHvfPr0HL88W9+BD9xY8S5BdK7a2DJteT5Va45ixoPKQFztXUdp
 pRZqQtOopKmfqmCRbTTMv9vp5II3ea7r2VQdnQt/M3/0Z+rJbQjIMIZEbkitdUHCPAEreklr9
 kNZh7xiPq2t1UG2Utc7WugrZE0SwI/iqNQNiv7ocf6rCwWd2fHr2L2lUwMKAKh59fNQ7Qau/O
 uSMidm8SnPon9Kzx9C9jlvdoum/XBge6MjISQFPUEKuDaItKlje4VLJOneaogZBGBERjkUGkP
 JKpPdH0Nxp5FFzQyjH6TxkHHwPvg4/lBD/PVVuS8FVhl6liNjjT5Fz9+BTRpGGwC4/FmExWhn
 2VaiJDCmx5WeOPGK1CYzmEJj5mOxIc9oivLWxmSmhk7GAXOwHeFWk3e0D1l5ni0d7JaVPilfb
 CtpdveXG/16kKSpS/dZ9pu3GmT+3a8eVWOmK4S+8OJlAuanBOJJTsh4eWVSL8lNXDSDciE/hJ
 N3TiWbVMxrOISwPBox1aVDh0f5ZXu9fY/979Tjj4hk2Ht/n5u1Wis/m60Zp2AIu4JFPjoC0Lh
 eby2Jf2qHOFFX/QqSSx2Yjtl8rKbw93GJ6rA5lbeQeuTYJniZSifBLyqqn9EN8CxOyc9PIhyX
 /2F8hhBwx85P02hB5UIlhWDnRw+iI4h+aPxMfvvAoqBKp60ANeRJlz3PEvHwA7Tj0Nug9HCM1
 Gub5NWYCyc6hCAQU8B605WVSDxqD0adTYXs4EQmQTDzrLokWmXWU4ZFKVFVFGXvDwMWVMs1vj
 bBlFcw1fvq7AnAsSCECGRpz/bBSh16ZwTNT3GXTUAOShjD7xmkb8pR9xHPPpQRJkiUJSoukEM
 /754MnvRTIOyk9++6s0+0EM2Qt/1WXUpeNxoSiUKlDr7s7x2lYBa6cX67+ll1c4jtrMVfR8uU
 mv7l2jOy5dPv+DPuDL8tGXVYvPAM3aaFABYUM+SaHMtRxH1h+hnjlmTk2eDTustoeSK0hPU0g
 KncMuQQxg9ysIwUnqlTNfFekvcWy9yJlr89LAeCHUGDqYTeF6puwrS2MQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Build a static typed ref sorting function using DEFINE_LIST_SORT along
with a typed comparison function near its only two callers instead of
having an exported version that calls llist_mergesort().  This gets rid
of the next pointer accessor functions and their calling overhead at the
cost of a slightly increased object text size.

Before:
__TEXT	__DATA	__OBJC	others	dec	hex
23231	389	0	113689	137309	2185d	fetch-pack.o
29158	80	0	146864	176102	2afe6	remote.o

With this patch:
__TEXT	__DATA	__OBJC	others	dec	hex
23591	389	0	117759	141739	229ab	fetch-pack.o
29070	80	0	145718	174868	2ab14	remote.o

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 fetch-pack.c |  8 ++++++++
 remote.c     | 22 ----------------------
 remote.h     |  2 --
 3 files changed, 8 insertions(+), 24 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index cb6647d657..e4503774b5 100644
=2D-- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -26,6 +26,7 @@
 #include "commit-reach.h"
 #include "commit-graph.h"
 #include "sigchain.h"
+#include "mergesort.h"

 static int transfer_unpack_limit =3D -1;
 static int fetch_unpack_limit =3D -1;
@@ -1025,6 +1026,13 @@ static int get_pack(struct fetch_pack_args *args,
 	return 0;
 }

+static int ref_compare_name(const struct ref *a, const struct ref *b)
+{
+	return strcmp(a->name, b->name);
+}
+
+DEFINE_LIST_SORT(static, sort_ref_list, struct ref, next);
+
 static int cmp_ref_by_name(const void *a_, const void *b_)
 {
 	const struct ref *a =3D *((const struct ref **)a_);
diff --git a/remote.c b/remote.c
index 1ee2b145d0..e90dca1d56 100644
=2D-- a/remote.c
+++ b/remote.c
@@ -11,7 +11,6 @@
 #include "dir.h"
 #include "tag.h"
 #include "string-list.h"
-#include "mergesort.h"
 #include "strvec.h"
 #include "commit-reach.h"
 #include "advice.h"
@@ -1082,27 +1081,6 @@ void free_refs(struct ref *ref)
 	}
 }

-int ref_compare_name(const void *va, const void *vb)
-{
-	const struct ref *a =3D va, *b =3D vb;
-	return strcmp(a->name, b->name);
-}
-
-static void *ref_list_get_next(const void *a)
-{
-	return ((const struct ref *)a)->next;
-}
-
-static void ref_list_set_next(void *a, void *next)
-{
-	((struct ref *)a)->next =3D next;
-}
-
-void sort_ref_list(struct ref **l, int (*cmp)(const void *, const void *)=
)
-{
-	*l =3D llist_mergesort(*l, ref_list_get_next, ref_list_set_next, cmp);
-}
-
 int count_refspec_match(const char *pattern,
 			struct ref *refs,
 			struct ref **matched_ref)
diff --git a/remote.h b/remote.h
index 448675e112..1c4621b414 100644
=2D-- a/remote.h
+++ b/remote.h
@@ -207,9 +207,7 @@ struct ref *find_ref_by_name(const struct ref *list, c=
onst char *name);
 struct ref *alloc_ref(const char *name);
 struct ref *copy_ref(const struct ref *ref);
 struct ref *copy_ref_list(const struct ref *ref);
-void sort_ref_list(struct ref **, int (*cmp)(const void *, const void *))=
;
 int count_refspec_match(const char *, struct ref *refs, struct ref **matc=
hed_ref);
-int ref_compare_name(const void *, const void *);

 int check_ref_type(const struct ref *ref, int flags);

=2D-
2.37.1
