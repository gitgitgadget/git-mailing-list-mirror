From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/2] index-pack: rename the field "type" to "in_pack_type"
Date: Wed,  8 Jul 2015 18:56:30 +0700
Message-ID: <1436356591-8148-1-git-send-email-pclouds@gmail.com>
References: <20150707160630.GA4456@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 08 13:56:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCnxi-0004HD-Bq
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jul 2015 13:56:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932753AbbGHL4W convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Jul 2015 07:56:22 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:34915 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933152AbbGHL4C (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jul 2015 07:56:02 -0400
Received: by pdrg1 with SMTP id g1so13227068pdr.2
        for <git@vger.kernel.org>; Wed, 08 Jul 2015 04:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=vOGNqplV+/eCV6Jcec8OQLF7MerNfpbBGIJY554qxtE=;
        b=0keNnJcS5jPyQYDClKsq6Bn7etotebETdWk7/qjmiqkmlnbppzvj62kjg6yDPx8J9g
         I93NgBvJkEmimE4Sy2lEU9oKs9+uVOxy+JC0lXosBOPWSWYfjsNBzERUbnc4f7r72IO8
         29LOpW1sU9uKZnTcsHLAFsJANWOlZAyTRDGbQkWLnEDJDY+OrMdEShJKVCsf15UAAV+j
         HxHCRf7K4NbfKbi8FhbJctDU63c2GQQoZZJIOLo26nzBYYQsJONswmHJhToZ87UCHGyW
         TTtPu/7OvYbJy7TeoUsOsRicbN0SHzoSadza3t6Zzv2Ap68qxS1fNoY5zjVtx8yzJKRs
         fU+g==
X-Received: by 10.70.20.5 with SMTP id j5mr19932482pde.40.1436356561435;
        Wed, 08 Jul 2015 04:56:01 -0700 (PDT)
Received: from lanh ([115.73.45.219])
        by smtp.gmail.com with ESMTPSA id fe10sm2309650pdb.59.2015.07.08.04.55.58
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jul 2015 04:56:00 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 08 Jul 2015 18:56:46 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <20150707160630.GA4456@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273675>

We have two types in this code: in-pack and canonical. "in_pack_type"
makes it clearer than plain "type".

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/index-pack.c | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 48fa472..797e571 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -19,7 +19,7 @@ struct object_entry {
 	struct pack_idx_entry idx;
 	unsigned long size;
 	unsigned char hdr_size;
-	signed char type;
+	signed char in_pack_type;
 	signed char real_type;
 };
=20
@@ -493,7 +493,7 @@ static void *unpack_raw_entry(struct object_entry *=
obj,
 	p =3D fill(1);
 	c =3D *p;
 	use(1);
-	obj->type =3D (c >> 4) & 7;
+	obj->in_pack_type =3D (c >> 4) & 7;
 	size =3D (c & 15);
 	shift =3D 4;
 	while (c & 0x80) {
@@ -505,7 +505,7 @@ static void *unpack_raw_entry(struct object_entry *=
obj,
 	}
 	obj->size =3D size;
=20
-	switch (obj->type) {
+	switch (obj->in_pack_type) {
 	case OBJ_REF_DELTA:
 		hashcpy(ref_sha1, fill(20));
 		use(20);
@@ -534,11 +534,11 @@ static void *unpack_raw_entry(struct object_entry=
 *obj,
 	case OBJ_TAG:
 		break;
 	default:
-		bad_object(obj->idx.offset, _("unknown object type %d"), obj->type);
+		bad_object(obj->idx.offset, _("unknown object type %d"), obj->in_pac=
k_type);
 	}
 	obj->hdr_size =3D consumed_bytes - obj->idx.offset;
=20
-	data =3D unpack_entry_data(obj->idx.offset, obj->size, obj->type, sha=
1);
+	data =3D unpack_entry_data(obj->idx.offset, obj->size, obj->in_pack_t=
ype, sha1);
 	obj->idx.crc32 =3D input_crc32;
 	return data;
 }
@@ -631,7 +631,7 @@ static int find_ofs_delta(const off_t offset, enum =
object_type type)
 		int cmp;
=20
 		cmp =3D compare_ofs_delta_bases(offset, delta->offset,
-					      type, objects[delta->obj_no].type);
+					      type, objects[delta->obj_no].in_pack_type);
 		if (!cmp)
 			return next;
 		if (cmp < 0) {
@@ -685,7 +685,7 @@ static int find_ref_delta(const unsigned char *sha1=
, enum object_type type)
 		int cmp;
=20
 		cmp =3D compare_ref_delta_bases(sha1, delta->sha1,
-					      type, objects[delta->obj_no].type);
+					      type, objects[delta->obj_no].in_pack_type);
 		if (!cmp)
 			return next;
 		if (cmp < 0) {
@@ -759,7 +759,7 @@ static int check_collison(struct object_entry *entr=
y)
 	enum object_type type;
 	unsigned long size;
=20
-	if (entry->size <=3D big_file_threshold || entry->type !=3D OBJ_BLOB)
+	if (entry->size <=3D big_file_threshold || entry->in_pack_type !=3D O=
BJ_BLOB)
 		return -1;
=20
 	memset(&data, 0, sizeof(data));
@@ -767,7 +767,7 @@ static int check_collison(struct object_entry *entr=
y)
 	data.st =3D open_istream(entry->idx.sha1, &type, &size, NULL);
 	if (!data.st)
 		return -1;
-	if (size !=3D entry->size || type !=3D entry->type)
+	if (size !=3D entry->size || type !=3D entry->in_pack_type)
 		die(_("SHA1 COLLISION FOUND WITH %s !"),
 		    sha1_to_hex(entry->idx.sha1));
 	unpack_data(entry, compare_objects, &data);
@@ -891,7 +891,7 @@ static void *get_base_data(struct base_data *c)
 		struct base_data **delta =3D NULL;
 		int delta_nr =3D 0, delta_alloc =3D 0;
=20
-		while (is_delta_type(c->obj->type) && !c->data) {
+		while (is_delta_type(c->obj->in_pack_type) && !c->data) {
 			ALLOC_GROW(delta, delta_nr + 1, delta_alloc);
 			delta[delta_nr++] =3D c;
 			c =3D c->base;
@@ -1085,7 +1085,7 @@ static void *threaded_second_pass(void *data)
 		counter_unlock();
 		work_lock();
 		while (nr_dispatched < nr_objects &&
-		       is_delta_type(objects[nr_dispatched].type))
+		       is_delta_type(objects[nr_dispatched].in_pack_type))
 			nr_dispatched++;
 		if (nr_dispatched >=3D nr_objects) {
 			work_unlock();
@@ -1121,12 +1121,12 @@ static void parse_pack_objects(unsigned char *s=
ha1)
 		struct object_entry *obj =3D &objects[i];
 		void *data =3D unpack_raw_entry(obj, &ofs_delta->offset,
 					      ref_delta_sha1, obj->idx.sha1);
-		obj->real_type =3D obj->type;
-		if (obj->type =3D=3D OBJ_OFS_DELTA) {
+		obj->real_type =3D obj->in_pack_type;
+		if (obj->in_pack_type =3D=3D OBJ_OFS_DELTA) {
 			nr_ofs_deltas++;
 			ofs_delta->obj_no =3D i;
 			ofs_delta++;
-		} else if (obj->type =3D=3D OBJ_REF_DELTA) {
+		} else if (obj->in_pack_type =3D=3D OBJ_REF_DELTA) {
 			ALLOC_GROW(ref_deltas, nr_ref_deltas + 1, ref_deltas_alloc);
 			hashcpy(ref_deltas[nr_ref_deltas].sha1, ref_delta_sha1);
 			ref_deltas[nr_ref_deltas].obj_no =3D i;
@@ -1136,7 +1136,7 @@ static void parse_pack_objects(unsigned char *sha=
1)
 			obj->real_type =3D OBJ_BAD;
 			nr_delays++;
 		} else
-			sha1_object(data, NULL, obj->size, obj->type, obj->idx.sha1);
+			sha1_object(data, NULL, obj->size, obj->in_pack_type, obj->idx.sha1=
);
 		free(data);
 		display_progress(progress, i+1);
 	}
@@ -1161,8 +1161,8 @@ static void parse_pack_objects(unsigned char *sha=
1)
 		struct object_entry *obj =3D &objects[i];
 		if (obj->real_type !=3D OBJ_BAD)
 			continue;
-		obj->real_type =3D obj->type;
-		sha1_object(NULL, obj, obj->size, obj->type, obj->idx.sha1);
+		obj->real_type =3D obj->in_pack_type;
+		sha1_object(NULL, obj, obj->size, obj->in_pack_type, obj->idx.sha1);
 		nr_delays--;
 	}
 	if (nr_delays)
@@ -1215,7 +1215,7 @@ static void resolve_deltas(void)
 	for (i =3D 0; i < nr_objects; i++) {
 		struct object_entry *obj =3D &objects[i];
=20
-		if (is_delta_type(obj->type))
+		if (is_delta_type(obj->in_pack_type))
 			continue;
 		resolve_base(obj);
 		display_progress(progress, nr_resolved_deltas);
@@ -1314,7 +1314,7 @@ static struct object_entry *append_obj_to_pack(st=
ruct sha1file *f,
 	sha1write(f, header, n);
 	obj[0].size =3D size;
 	obj[0].hdr_size =3D n;
-	obj[0].type =3D type;
+	obj[0].in_pack_type =3D type;
 	obj[0].real_type =3D type;
 	obj[1].idx.offset =3D obj[0].idx.offset + n;
 	obj[1].idx.offset +=3D write_compressed(f, buf, size);
@@ -1566,7 +1566,7 @@ static void show_pack_info(int stat_only)
 	for (i =3D 0; i < nr_objects; i++) {
 		struct object_entry *obj =3D &objects[i];
=20
-		if (is_delta_type(obj->type))
+		if (is_delta_type(obj->in_pack_type))
 			chain_histogram[obj_stat[i].delta_depth - 1]++;
 		if (stat_only)
 			continue;
@@ -1575,7 +1575,7 @@ static void show_pack_info(int stat_only)
 		       typename(obj->real_type), obj->size,
 		       (unsigned long)(obj[1].idx.offset - obj->idx.offset),
 		       (uintmax_t)obj->idx.offset);
-		if (is_delta_type(obj->type)) {
+		if (is_delta_type(obj->in_pack_type)) {
 			struct object_entry *bobj =3D &objects[obj_stat[i].base_object_no];
 			printf(" %u %s", obj_stat[i].delta_depth, sha1_to_hex(bobj->idx.sha=
1));
 		}
--=20
2.3.0.rc1.137.g477eb31
