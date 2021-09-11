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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16DE5C433EF
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 20:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D868561153
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 20:40:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234069AbhIKUlx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Sep 2021 16:41:53 -0400
Received: from mout.web.de ([212.227.15.14]:55559 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229487AbhIKUlw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Sep 2021 16:41:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1631392833;
        bh=1ybyE/TefLvk4oGIRd+lwdl6BRhAhvdxk/TeEKwPKCI=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=hybfs5o3TtqhDFyBHwEBFSUOHHR/a4aSIGAUdVOjaG6tz9XJDe0ze244MqWYnSZP7
         mUj7xK+sSTZkAf6xWhI4u1PZu8gNFmTst5RK5wWHSjwHe5JoH4BrhjkXElQXLZzIw3
         ZK6hKQAU3j6+Lf19iUrI4+k1fulzsTLGHefTGQFg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.20.171]) by smtp.web.de
 (mrweb004 [213.165.67.108]) with ESMTPSA (Nemesis) id
 0LfVe5-1miqVc307V-00p2zZ; Sat, 11 Sep 2021 22:40:33 +0200
Subject: [PATCH 3/5] packfile: convert mark_bad_packed_object() to object_id
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
References: <4a702bfe-afd0-669a-c893-0262289c24b8@web.de>
 <e50c1465-59de-7fe1-de01-800404c7640e@web.de>
Message-ID: <a6d7114f-08c1-567a-d8d4-40becd2384f6@web.de>
Date:   Sat, 11 Sep 2021 22:40:33 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <e50c1465-59de-7fe1-de01-800404c7640e@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+yJWF6BFW5yNjB98ca1D1+Utp85eWIwjA/9JPh+pdj2gphOK3fk
 7paLIwDMIUyhOGkGDXniwo34g7Tx0CbZTJ06K/7X+/D6vRTr4so1JE9r1qJEQMcpfJ/U+KT
 12DuEiEbDgBAO/CGpJcBrg+2JoXI1eFhbcjYjiA1WhT6FGWiHB6/8SeIG48Z78LmW4uCS/F
 BE6ByTXa31xRjfaB1IKyA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HQ82SNxQHsM=:huX4zRSE7CTFMXqstdNXQJ
 N/XG15q0ydPRmQ3QZlx5RNIs0PBOW7MGlyejm16ArjjMIBOSL9e84IJNG0ekGu2/w6xEgFmSz
 5Pe0LODu9z9y9c2sBpl0M9ao8wnXazlhLBhA01ZuKds+hh9XLltOWZA4taCVScIs7HrzIdqj5
 0m3940EAL5vTUbeh9lpfCK0QHTtFJtecwkoadki21xUFjdkwxBZ3l44y43KBsClDuZa5X7WwU
 F7ZqEa7CBX8RvH8ARPsbk4X150Ghr0FDJwYUcK9An4MLEIzqkjBEk5z4oxYvQU598dCtL66eC
 1iKDI+dZPUNctqMMPuoJbmvwnz0dqSr149Sw0oAPAPriGj+LhIagBez4frZKz/8lBYB9Nxp7h
 C5wSfJ0dl2MbbFOO0xmi4mbjsYjX/m1o8AjifdCrxfjUdPMtWLbozrVOX5l8oVoeuumI90jOv
 qlh9H/PprPd6hpaBkSyyZ6AZk8enqm4c9LG5ZdnqzWPwOunh8OWDOthI83GROBsP75i1gH8nv
 bbyREKMT7O0PuKbS4rPKi6G9R/TpsJn0M9PBke7Ycy0xpI8DyAz4PjNwF/Lof0fxuWE0de0/U
 pW1e7crGRFj0Hguvvm53LIhPPFj4AUF4tsd5nWbSFoydTyupmbRN7YsxlMcfjboU45cwXzuAW
 U4oetcGedhz1llsfch8Swp+NGbfAH8llNrupX/ZW+Kfs3B1RhWHvXfXLDCXwy3GCHKqlLGzYm
 RKA3MMropyu0UvTK3smt/+uOznun+lrbORVmXkrKQ7SL6k8xkUB3kCax3uHNPtxMfJj0D7Xi0
 LOZl9pfCXL5+Dh7ppnoak7dQFJ7FvgXY5jTeeumNFcDZFqZ7KmVib/f3/mde+ntGy3LTRrRIQ
 W1JSU6jGLk9XlVCiNSHDv3RQpuXKOcZ0CYckWM9C3rPuSUUglx+sV+1n+O582asipRBO0NBT4
 qY+Ia8+zhAAs2EW2usXp4PshM08tQSfg3ipKz7AUUQGcQM5Y9W+64ilEbMpEcq4UXsVm1/sCe
 qaT6DksKvrCEChvk79GN15DOlFMDdLYJgtQJbOLuntkacJkZt8N6hTJRO1fEMepbJQwo04lt1
 FEQNcXdEOyM+ns=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

All callers have full object IDs, so pass them on instead of just their
hash member.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 object-file.c |  2 +-
 packfile.c    | 12 ++++++------
 packfile.h    |  2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/object-file.c b/object-file.c
index a8be899481..fb5a385a06 100644
=2D-- a/object-file.c
+++ b/object-file.c
@@ -1616,7 +1616,7 @@ static int do_oid_object_info_extended(struct reposi=
tory *r,
 		return 0;
 	rtype =3D packed_object_info(r, e.p, e.offset, oi);
 	if (rtype < 0) {
-		mark_bad_packed_object(e.p, real->hash);
+		mark_bad_packed_object(e.p, real);
 		return do_oid_object_info_extended(r, real, oi, 0);
 	} else if (oi->whence =3D=3D OI_PACKED) {
 		oi->u.packed.offset =3D e.offset;
diff --git a/packfile.c b/packfile.c
index 4d0d625238..fb15fc5b49 100644
=2D-- a/packfile.c
+++ b/packfile.c
@@ -1161,17 +1161,17 @@ int unpack_object_header(struct packed_git *p,
 	return type;
 }

-void mark_bad_packed_object(struct packed_git *p, const unsigned char *sh=
a1)
+void mark_bad_packed_object(struct packed_git *p, const struct object_id =
*oid)
 {
 	unsigned i;
 	const unsigned hashsz =3D the_hash_algo->rawsz;
 	for (i =3D 0; i < p->num_bad_objects; i++)
-		if (hasheq(sha1, p->bad_object_sha1 + hashsz * i))
+		if (hasheq(oid->hash, p->bad_object_sha1 + hashsz * i))
 			return;
 	p->bad_object_sha1 =3D xrealloc(p->bad_object_sha1,
 				      st_mult(GIT_MAX_RAWSZ,
 					      st_add(p->num_bad_objects, 1)));
-	hashcpy(p->bad_object_sha1 + hashsz * p->num_bad_objects, sha1);
+	hashcpy(p->bad_object_sha1 + hashsz * p->num_bad_objects, oid->hash);
 	p->num_bad_objects++;
 }

@@ -1272,7 +1272,7 @@ static int retry_bad_packed_offset(struct repository=
 *r,
 	if (offset_to_pack_pos(p, obj_offset, &pos) < 0)
 		return OBJ_BAD;
 	nth_packed_object_id(&oid, p, pack_pos_to_index(p, pos));
-	mark_bad_packed_object(p, oid.hash);
+	mark_bad_packed_object(p, &oid);
 	type =3D oid_object_info(r, &oid, NULL);
 	if (type <=3D OBJ_NONE)
 		return OBJ_BAD;
@@ -1722,7 +1722,7 @@ void *unpack_entry(struct repository *r, struct pack=
ed_git *p, off_t obj_offset,
 				nth_packed_object_id(&oid, p, index_pos);
 				error("bad packed object CRC for %s",
 				      oid_to_hex(&oid));
-				mark_bad_packed_object(p, oid.hash);
+				mark_bad_packed_object(p, &oid);
 				data =3D NULL;
 				goto out;
 			}
@@ -1811,7 +1811,7 @@ void *unpack_entry(struct repository *r, struct pack=
ed_git *p, off_t obj_offset,
 				      " at offset %"PRIuMAX" from %s",
 				      oid_to_hex(&base_oid), (uintmax_t)obj_offset,
 				      p->pack_name);
-				mark_bad_packed_object(p, base_oid.hash);
+				mark_bad_packed_object(p, &base_oid);
 				base =3D read_object(r, &base_oid, &type, &base_size);
 				external_base =3D base;
 			}
diff --git a/packfile.h b/packfile.h
index 3ae117a8ae..a982ed9994 100644
=2D-- a/packfile.h
+++ b/packfile.h
@@ -159,7 +159,7 @@ int packed_object_info(struct repository *r,
 		       struct packed_git *pack,
 		       off_t offset, struct object_info *);

-void mark_bad_packed_object(struct packed_git *p, const unsigned char *sh=
a1);
+void mark_bad_packed_object(struct packed_git *, const struct object_id *=
);
 const struct packed_git *has_packed_and_bad(struct repository *r, const u=
nsigned char *sha1);

 #define ON_DISK_KEEP_PACKS 1
=2D-
2.33.0
