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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09EEFC433F5
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 07:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD1B9611C0
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 07:59:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235372AbhIKIAd (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Sep 2021 04:00:33 -0400
Received: from mout.web.de ([212.227.15.3]:57443 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235331AbhIKIAc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Sep 2021 04:00:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1631347156;
        bh=1ybyE/TefLvk4oGIRd+lwdl6BRhAhvdxk/TeEKwPKCI=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=qSlWuXNesm9sWn16p6HtFkFe6eg4NVyKlasKgnHFBJ7fcZcP9gu3jmWJHd172zqtZ
         qSxOtbKyr0TllUXSgv2RTaT28C8EIj6YyPoWWQEbvOhOWqAlLBX1MqEoQX3kuaZj39
         9LgUUUamf/m1nv7GSuK8XhCmvdTLhy3K4B2vbBNs=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.20.171]) by smtp.web.de
 (mrweb002 [213.165.67.108]) with ESMTPSA (Nemesis) id
 0LkyTl-1mxTij2Yrt-00als6; Sat, 11 Sep 2021 09:59:16 +0200
Subject: [PATCH 1/3] packfile: convert mark_bad_packed_object() to object_id
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
References: <4a702bfe-afd0-669a-c893-0262289c24b8@web.de>
Message-ID: <a5918f78-48c2-e68c-af28-06d1e30375a0@web.de>
Date:   Sat, 11 Sep 2021 09:59:16 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <4a702bfe-afd0-669a-c893-0262289c24b8@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MV5HI08Ukn+mNF2zaiyylLep/WQ+yDMya4babxOhLVGcydAZOts
 LijpjWPpmegad/MfNSVW6RKsfCPIbB5pw+9vkeYBWU2/0Yj3T7fFFgwlgznC/+l2i/8iPae
 n+wYhPq6V6n4wqFMM3RoGG2qdHaBPCNDAFUK4IRzv6Hc6/OtNMeXvf5HgyzCWnFbGJCi2+D
 qWjbiLcuMoKiyXRKW1piA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3QD4rIegpps=:3NZrSYdLTVpwbkiaxmV2On
 n3NA03j3cm2jmuk+whKySiJ1bCXdiSnOlAqoak4gQG+8msLUija9Imqvi16oVZGoJcNEjG5Us
 P7UgvJP9WJfqsej3mOmFG1WX8pdTr6OVa6+nlRfzL5bO9ND5IshoQKs7mYOmPlspIy5qNGNhI
 Y14IBpjo0mWRhu2n7Zuc/wwfs9IdzUZtDX3S8LlYysjT8bXSZr3ro9zwJ8iXEK6wfHfw4g8CJ
 1mBXd/5WClU4K1AyQ9NNAoVjxcHik1/wkH5INxf0uwUWp3EoYl5UYrto67FOxsiE5qsqoxGl4
 86ARG3c3CiP4KFhFCZPmsIEYtLTxdcQnhnOUG9a1TCVTYVZlOyDT+dDvdGXLarifmNk0uzyPX
 7gFj0BmKGK3K5f/kJXTaLWdi93MiMmHz0IItQi9Ixoi73tjs7Tor9KMEXOEP21EIeLtjrrPDp
 ts567BfcgHM1s3r9JZslrg34kBaGO09wUt/KNdZyPEjPsznEPE8wfMqqqnscG8vFDgQ2zflic
 aT7SkARSWPNOTBxFIGHg4jqYUXEhVtvMhMyUMbX8KH2lceVJjf2507L4hxIiNxlxFHI0xRIof
 X6s6C85XWAK3rzmql02rL/Lfgz6RT5bhDFFbR+SR7lNLarh5uViGt612zy50JclaIxoMApAYO
 4kQNLf5H77b0E7ebteAAXVA8e7uLo0u+T3uUEtL9ITw94pyk/eWT0pJD0EMJ8mCYqtx3ewh+n
 B4m6RbWMM8qiC1FeBpEUQmBkDn4zknm/jzlPN77M5eDguNkBVBDiL1RXI3YdPP5uxERLJupa9
 5fuHM2W22sr+AFD4OUyVwVp6Xlbse36JD1PWBpxOVrF6h0D2cIddi7zi+5ENbPI9VERI8+y/z
 Rm6PypEurWfMeYeiEyaqx55d268VMAKZp7Y5W4PclIXT15j7sHbKkjmJJosIP5ibuhsE73adb
 Qec7rWvCFCcVd4EgzJhpTo8AvPS32xVWj4cwe+8XQixacB7j9TKNENHTmRXLHbFaVsrWN7b8X
 lb9RSxt7yWtFr4v35kx2gGMPt7OwZIPdmV7UZbryWqfPpq4Sr1I2VM5GJEbUPPd1wA==
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
