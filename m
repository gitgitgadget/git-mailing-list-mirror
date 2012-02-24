From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] index-pack: remove real_type from struct object_entry
Date: Fri, 24 Feb 2012 09:42:00 +0700
Message-ID: <1330051320-19043-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 24 03:43:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0l7m-0003eL-10
	for gcvg-git-2@plane.gmane.org; Fri, 24 Feb 2012 03:43:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754295Ab2BXCmj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 Feb 2012 21:42:39 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:41251 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754204Ab2BXCmX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Feb 2012 21:42:23 -0500
Received: by pbcun15 with SMTP id un15so2104713pbc.19
        for <git@vger.kernel.org>; Thu, 23 Feb 2012 18:42:22 -0800 (PST)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 10.68.216.225 as permitted sender) client-ip=10.68.216.225;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of pclouds@gmail.com designates 10.68.216.225 as permitted sender) smtp.mail=pclouds@gmail.com; dkim=pass header.i=pclouds@gmail.com
Received: from mr.google.com ([10.68.216.225])
        by 10.68.216.225 with SMTP id ot1mr1926228pbc.25.1330051342862 (num_hops = 1);
        Thu, 23 Feb 2012 18:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=V0tvYkZLf5AAoBM2BZ18STYF/P+5H+yJPKvuSOsirE8=;
        b=amLGVDklJCWU+Lvdmp8n4p9dLxpxqX1MAIW+e71JmgbPtrrdcJlg0ur17zrya28BeO
         s/UppaSawV6+5JZcogD6K5FFkgBc5jybnYUXfy/0dYBbvgwG/anfD7qxxXzbhzS1PXge
         0zDa9f5m+W0/XSohkgZU8/70Il7hI0C1tElyc=
Received: by 10.68.216.225 with SMTP id ot1mr1561602pbc.25.1330051342809;
        Thu, 23 Feb 2012 18:42:22 -0800 (PST)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id a1sm3012901pbj.72.2012.02.23.18.42.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 23 Feb 2012 18:42:21 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 24 Feb 2012 09:42:02 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191410>

Since ce3f6dc (fix multiple issues in index-pack), real_type is
identical to type, there's no reason to keep it.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 I'm pretty sure I read it right (i.e. type =3D=3D real_type), but I ma=
y
 have overlooked something. Not so sure why real_type was introduced
 in the first place..

 builtin/index-pack.c |   16 ++++++----------
 1 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index dd1c5c9..2db9a35 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -18,7 +18,6 @@ struct object_entry {
 	unsigned long size;
 	unsigned int hdr_size;
 	enum object_type type;
-	enum object_type real_type;
 	unsigned delta_depth;
 	int base_object_no;
 };
@@ -581,7 +580,6 @@ static void resolve_delta(struct object_entry *delt=
a_obj,
 {
 	void *base_data, *delta_data;
=20
-	delta_obj->real_type =3D base->obj->real_type;
 	delta_obj->delta_depth =3D base->obj->delta_depth + 1;
 	if (deepest_delta < delta_obj->delta_depth)
 		deepest_delta =3D delta_obj->delta_depth;
@@ -594,7 +592,7 @@ static void resolve_delta(struct object_entry *delt=
a_obj,
 	free(delta_data);
 	if (!result->data)
 		bad_object(delta_obj->idx.offset, "failed to apply delta");
-	sha1_object(result->data, result->size, delta_obj->real_type,
+	sha1_object(result->data, result->size, delta_obj->type,
 		    delta_obj->idx.sha1);
 	nr_resolved_deltas++;
 }
@@ -626,7 +624,7 @@ static struct base_data *find_unresolved_deltas_1(s=
truct base_data *base,
 		struct object_entry *child =3D objects + deltas[base->ref_first].obj=
_no;
 		struct base_data *result =3D alloc_base_data();
=20
-		assert(child->real_type =3D=3D OBJ_REF_DELTA);
+		assert(child->type =3D=3D OBJ_REF_DELTA);
 		resolve_delta(child, base, result);
 		if (base->ref_first =3D=3D base->ref_last && base->ofs_last =3D=3D -=
1)
 			free_base_data(base);
@@ -639,7 +637,7 @@ static struct base_data *find_unresolved_deltas_1(s=
truct base_data *base,
 		struct object_entry *child =3D objects + deltas[base->ofs_first].obj=
_no;
 		struct base_data *result =3D alloc_base_data();
=20
-		assert(child->real_type =3D=3D OBJ_OFS_DELTA);
+		assert(child->type =3D=3D OBJ_OFS_DELTA);
 		resolve_delta(child, base, result);
 		if (base->ofs_first =3D=3D base->ofs_last)
 			free_base_data(base);
@@ -702,7 +700,6 @@ static void parse_pack_objects(unsigned char *sha1)
 	for (i =3D 0; i < nr_objects; i++) {
 		struct object_entry *obj =3D &objects[i];
 		void *data =3D unpack_raw_entry(obj, &delta->base);
-		obj->real_type =3D obj->type;
 		if (is_delta_type(obj->type)) {
 			nr_deltas++;
 			delta->obj_no =3D i;
@@ -805,7 +802,6 @@ static struct object_entry *append_obj_to_pack(stru=
ct sha1file *f,
 	obj[0].size =3D size;
 	obj[0].hdr_size =3D n;
 	obj[0].type =3D type;
-	obj[0].real_type =3D type;
 	obj[1].idx.offset =3D obj[0].idx.offset + n;
 	obj[1].idx.offset +=3D write_compressed(f, buf, size);
 	obj[0].idx.crc32 =3D crc32_end(f);
@@ -838,7 +834,7 @@ static void fix_unresolved_deltas(struct sha1file *=
f, int nr_unresolved)
 	 */
 	sorted_by_pos =3D xmalloc(nr_unresolved * sizeof(*sorted_by_pos));
 	for (i =3D 0; i < nr_deltas; i++) {
-		if (objects[deltas[i].obj_no].real_type !=3D OBJ_REF_DELTA)
+		if (objects[deltas[i].obj_no].type !=3D OBJ_REF_DELTA)
 			continue;
 		sorted_by_pos[n++] =3D &deltas[i];
 	}
@@ -849,7 +845,7 @@ static void fix_unresolved_deltas(struct sha1file *=
f, int nr_unresolved)
 		enum object_type type;
 		struct base_data *base_obj =3D alloc_base_data();
=20
-		if (objects[d->obj_no].real_type !=3D OBJ_REF_DELTA)
+		if (objects[d->obj_no].type !=3D OBJ_REF_DELTA)
 			continue;
 		base_obj->data =3D read_sha1_file(d->base.sha1, &type, &base_obj->si=
ze);
 		if (!base_obj->data)
@@ -1053,7 +1049,7 @@ static void show_pack_info(int stat_only)
 			continue;
 		printf("%s %-6s %lu %lu %"PRIuMAX,
 		       sha1_to_hex(obj->idx.sha1),
-		       typename(obj->real_type), obj->size,
+		       typename(obj->type), obj->size,
 		       (unsigned long)(obj[1].idx.offset - obj->idx.offset),
 		       (uintmax_t)obj->idx.offset);
 		if (is_delta_type(obj->type)) {
--=20
1.7.3.1.256.g2539c.dirty
