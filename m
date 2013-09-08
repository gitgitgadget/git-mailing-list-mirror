From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 03/11] pack v4: move packv4-create.c to libgit.a
Date: Sun,  8 Sep 2013 22:04:12 +0700
Message-ID: <1378652660-6731-4-git-send-email-pclouds@gmail.com>
References: <1378362001-1738-1-git-send-email-nico@fluxnic.net>
 <1378652660-6731-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Sun Sep 08 17:01:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIgUn-0003F0-4o
	for gcvg-git-2@plane.gmane.org; Sun, 08 Sep 2013 17:01:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752753Ab3IHPBm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Sep 2013 11:01:42 -0400
Received: from mail-pb0-f51.google.com ([209.85.160.51]:65059 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752719Ab3IHPBl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Sep 2013 11:01:41 -0400
Received: by mail-pb0-f51.google.com with SMTP id jt11so5155264pbb.10
        for <git@vger.kernel.org>; Sun, 08 Sep 2013 08:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=JRadP0vypRVzPVi+fiJeQiCAwcuzVUpmeT1k3YBHmb4=;
        b=Pinyb2oLRaYap0TPFMOXSdikvPrnMZ3VuaCHYLYMJv/2rFaBFI+QfIlkAGAGjF4F+0
         LUORhbSJHPjxC2+HvlD1RDHruaeYRrEc7cEAxLOD0ceHbnVN2xPV+lDVUyT6F4cbXMwQ
         SH4CJkMk+iUii5EHqNArP2t0v5rl0FJVo/FTmVCtG6zCmx55Pb8LoBfjdz6NSlX8/RaP
         JD+0xPfRcRkuIAwnh5lRv0aKhoitWmNePlRPj0FdxvBdcm9D2FCcxKQF/2uuS9Xgc9tl
         G/3s6O9nbhrG1jNp2WkUH+MN+A1h5poJSGGjTI9hdDvkMag6n9jkCsKXWtnSUJaDHAWt
         +EJA==
X-Received: by 10.66.159.132 with SMTP id xc4mr15226706pab.27.1378652500532;
        Sun, 08 Sep 2013 08:01:40 -0700 (PDT)
Received: from lanh ([115.73.228.17])
        by mx.google.com with ESMTPSA id pu5sm11431847pac.21.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 08 Sep 2013 08:01:40 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 08 Sep 2013 22:04:48 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1378652660-6731-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234242>

git-packv4-create now becomes test-packv4. Code that will not be used
by pack-objects.c is moved to test-packv4.c. It may be removed when
the code transition to pack-objects completes.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Makefile            |   4 +-
 packv4-create.c     | 491 +-------------------------------------------=
--------
 packv4-create.h     |  39 +++++
 test-packv4.c (new) | 476 ++++++++++++++++++++++++++++++++++++++++++++=
++++++
 4 files changed, 525 insertions(+), 485 deletions(-)
 create mode 100644 test-packv4.c

diff --git a/Makefile b/Makefile
index 22fc276..af2e3e3 100644
--- a/Makefile
+++ b/Makefile
@@ -550,7 +550,6 @@ PROGRAM_OBJS +=3D shell.o
 PROGRAM_OBJS +=3D show-index.o
 PROGRAM_OBJS +=3D upload-pack.o
 PROGRAM_OBJS +=3D remote-testsvn.o
-PROGRAM_OBJS +=3D packv4-create.o
=20
 # Binary suffix, set to .exe for Windows builds
 X =3D
@@ -568,6 +567,7 @@ TEST_PROGRAMS_NEED_X +=3D test-line-buffer
 TEST_PROGRAMS_NEED_X +=3D test-match-trees
 TEST_PROGRAMS_NEED_X +=3D test-mergesort
 TEST_PROGRAMS_NEED_X +=3D test-mktemp
+TEST_PROGRAMS_NEED_X +=3D test-packv4
 TEST_PROGRAMS_NEED_X +=3D test-parse-options
 TEST_PROGRAMS_NEED_X +=3D test-path-utils
 TEST_PROGRAMS_NEED_X +=3D test-prio-queue
@@ -702,6 +702,7 @@ LIB_H +=3D notes.h
 LIB_H +=3D object.h
 LIB_H +=3D pack-revindex.h
 LIB_H +=3D pack.h
+LIB_H +=3D packv4-create.h
 LIB_H +=3D packv4-parse.h
 LIB_H +=3D parse-options.h
 LIB_H +=3D patch-ids.h
@@ -839,6 +840,7 @@ LIB_OBJS +=3D object.o
 LIB_OBJS +=3D pack-check.o
 LIB_OBJS +=3D pack-revindex.o
 LIB_OBJS +=3D pack-write.o
+LIB_OBJS +=3D packv4-create.o
 LIB_OBJS +=3D packv4-parse.o
 LIB_OBJS +=3D pager.o
 LIB_OBJS +=3D parse-options.o
diff --git a/packv4-create.c b/packv4-create.c
index 920a0b4..cdf82c0 100644
--- a/packv4-create.c
+++ b/packv4-create.c
@@ -18,9 +18,9 @@
 #include "packv4-create.h"
=20
=20
-static int pack_compression_seen;
-static int pack_compression_level =3D Z_DEFAULT_COMPRESSION;
-static int min_tree_copy =3D 1;
+int pack_compression_seen;
+int pack_compression_level =3D Z_DEFAULT_COMPRESSION;
+int min_tree_copy =3D 1;
=20
 struct data_entry {
 	unsigned offset;
@@ -28,17 +28,6 @@ struct data_entry {
 	unsigned hits;
 };
=20
-struct dict_table {
-	unsigned char *data;
-	unsigned cur_offset;
-	unsigned size;
-	struct data_entry *entry;
-	unsigned nb_entries;
-	unsigned max_entries;
-	unsigned *hash;
-	unsigned hash_size;
-};
-
 struct dict_table *create_dict_table(void)
 {
 	return xcalloc(sizeof(struct dict_table), 1);
@@ -139,7 +128,7 @@ static int cmp_dict_entries(const void *a_, const v=
oid *b_)
 	return diff;
 }
=20
-static void sort_dict_entries_by_hits(struct dict_table *t)
+void sort_dict_entries_by_hits(struct dict_table *t)
 {
 	qsort(t->entry, t->nb_entries, sizeof(*t->entry), cmp_dict_entries);
 	t->hash_size =3D (t->nb_entries * 4 / 3) / 2;
@@ -208,7 +197,7 @@ int add_commit_dict_entries(struct dict_table *comm=
it_ident_table,
 	return 0;
 }
=20
-static int add_tree_dict_entries(struct dict_table *tree_path_table,
+int add_tree_dict_entries(struct dict_table *tree_path_table,
 				 void *buf, unsigned long size)
 {
 	struct tree_desc desc;
@@ -224,7 +213,7 @@ static int add_tree_dict_entries(struct dict_table =
*tree_path_table,
 	return 0;
 }
=20
-void dump_dict_table(struct dict_table *t)
+static void dump_dict_table(struct dict_table *t)
 {
 	int i;
=20
@@ -241,7 +230,7 @@ void dump_dict_table(struct dict_table *t)
 	}
 }
=20
-static void dict_dump(struct packv4_tables *v4)
+void dict_dump(struct packv4_tables *v4)
 {
 	dump_dict_table(v4->commit_ident_table);
 	dump_dict_table(v4->tree_path_table);
@@ -611,103 +600,6 @@ void *pv4_encode_tree(const struct packv4_tables =
*v4,
 	return buffer;
 }
=20
-static struct pack_idx_entry *get_packed_object_list(struct packed_git=
 *p)
-{
-	unsigned i, nr_objects =3D p->num_objects;
-	struct pack_idx_entry *objects;
-
-	objects =3D xmalloc((nr_objects + 1) * sizeof(*objects));
-	objects[nr_objects].offset =3D p->pack_size - 20;
-	for (i =3D 0; i < nr_objects; i++) {
-		hashcpy(objects[i].sha1, nth_packed_object_sha1(p, i));
-		objects[i].offset =3D nth_packed_object_offset(p, i);
-	}
-
-	return objects;
-}
-
-static int sort_by_offset(const void *e1, const void *e2)
-{
-	const struct pack_idx_entry * const *entry1 =3D e1;
-	const struct pack_idx_entry * const *entry2 =3D e2;
-	if ((*entry1)->offset < (*entry2)->offset)
-		return -1;
-	if ((*entry1)->offset > (*entry2)->offset)
-		return 1;
-	return 0;
-}
-
-static struct pack_idx_entry **sort_objs_by_offset(struct pack_idx_ent=
ry *list,
-						    unsigned nr_objects)
-{
-	unsigned i;
-	struct pack_idx_entry **sorted;
-
-	sorted =3D xmalloc((nr_objects + 1) * sizeof(*sorted));
-	for (i =3D 0; i < nr_objects + 1; i++)
-		sorted[i] =3D &list[i];
-	qsort(sorted, nr_objects + 1, sizeof(*sorted), sort_by_offset);
-
-	return sorted;
-}
-
-static int create_pack_dictionaries(struct packv4_tables *v4,
-				    struct packed_git *p,
-				    struct pack_idx_entry **obj_list)
-{
-	struct progress *progress_state;
-	unsigned int i;
-
-	v4->commit_ident_table =3D create_dict_table();
-	v4->tree_path_table =3D create_dict_table();
-
-	progress_state =3D start_progress("Scanning objects", p->num_objects)=
;
-	for (i =3D 0; i < p->num_objects; i++) {
-		struct pack_idx_entry *obj =3D obj_list[i];
-		void *data;
-		enum object_type type;
-		unsigned long size;
-		struct object_info oi =3D {};
-		int (*add_dict_entries)(struct dict_table *, void *, unsigned long);
-		struct dict_table *dict;
-
-		display_progress(progress_state, i+1);
-
-		oi.typep =3D &type;
-		oi.sizep =3D &size;
-		if (packed_object_info(p, obj->offset, &oi) < 0)
-			die("cannot get type of %s from %s",
-			    sha1_to_hex(obj->sha1), p->pack_name);
-
-		switch (type) {
-		case OBJ_COMMIT:
-			add_dict_entries =3D add_commit_dict_entries;
-			dict =3D v4->commit_ident_table;
-			break;
-		case OBJ_TREE:
-			add_dict_entries =3D add_tree_dict_entries;
-			dict =3D v4->tree_path_table;
-			break;
-		default:
-			continue;
-		}
-		data =3D unpack_entry(p, obj->offset, &type, &size);
-		if (!data)
-			die("cannot unpack %s from %s",
-			    sha1_to_hex(obj->sha1), p->pack_name);
-		if (check_sha1_signature(obj->sha1, data, size, typename(type)))
-			die("packed %s from %s is corrupt",
-			    sha1_to_hex(obj->sha1), p->pack_name);
-		if (add_dict_entries(dict, data, size) < 0)
-			die("can't process %s object %s",
-				typename(type), sha1_to_hex(obj->sha1));
-		free(data);
-	}
-
-	stop_progress(&progress_state);
-	return 0;
-}
-
 static unsigned long write_dict_table(struct sha1file *f, struct dict_=
table *t)
 {
 	unsigned char buffer[1024];
@@ -757,28 +649,6 @@ static unsigned long write_dict_table(struct sha1f=
ile *f, struct dict_table *t)
 	return hdrlen + datalen;
 }
=20
-static struct sha1file * packv4_open(char *path)
-{
-	int fd;
-
-	fd =3D open(path, O_CREAT|O_EXCL|O_WRONLY, 0600);
-	if (fd < 0)
-		die_errno("unable to create '%s'", path);
-	return sha1fd(fd, path);
-}
-
-static unsigned int packv4_write_header(struct sha1file *f, unsigned n=
r_objects)
-{
-	struct pack_header hdr;
-
-	hdr.hdr_signature =3D htonl(PACK_SIGNATURE);
-	hdr.hdr_version =3D htonl(4);
-	hdr.hdr_entries =3D htonl(nr_objects);
-	sha1write(f, &hdr, sizeof(hdr));
-
-	return sizeof(hdr);
-}
-
 unsigned long packv4_write_tables(struct sha1file *f,
 				  const struct packv4_tables *v4)
 {
@@ -802,350 +672,3 @@ unsigned long packv4_write_tables(struct sha1file=
 *f,
=20
 	return written;
 }
-
-static int write_object_header(struct sha1file *f, enum object_type ty=
pe, unsigned long size)
-{
-	unsigned char buf[16];
-	uint64_t val;
-	int len;
-
-	/*
-	 * We really have only one kind of delta object.
-	 */
-	if (type =3D=3D OBJ_OFS_DELTA)
-		type =3D OBJ_REF_DELTA;
-
-	/*
-	 * We allocate 4 bits in the LSB for the object type which should
-	 * be good for quite a while, given that we effectively encodes
-	 * only 5 object types: commit, tree, blob, delta, tag.
-	 */
-	val =3D size;
-	if (MSB(val, 4))
-		die("fixme: the code doesn't currently cope with big sizes");
-	val <<=3D 4;
-	val |=3D type;
-	len =3D encode_varint(val, buf);
-	sha1write(f, buf, len);
-	return len;
-}
-
-static unsigned long copy_object_data(struct packv4_tables *v4,
-				      struct sha1file *f, struct packed_git *p,
-				      off_t offset)
-{
-	struct pack_window *w_curs =3D NULL;
-	struct revindex_entry *revidx;
-	enum object_type type;
-	unsigned long avail, size, datalen, written;
-	int hdrlen, reflen, idx_nr;
-	unsigned char *src, buf[24];
-
-	revidx =3D find_pack_revindex(p, offset);
-	idx_nr =3D revidx->nr;
-	datalen =3D revidx[1].offset - offset;
-
-	src =3D use_pack(p, &w_curs, offset, &avail);
-	hdrlen =3D unpack_object_header_buffer(src, avail, &type, &size);
-
-	written =3D write_object_header(f, type, size);
-
-	if (type =3D=3D OBJ_OFS_DELTA) {
-		const unsigned char *cp =3D src + hdrlen;
-		off_t base_offset =3D decode_varint(&cp);
-		hdrlen =3D cp - src;
-		base_offset =3D offset - base_offset;
-		if (base_offset <=3D 0 || base_offset >=3D offset)
-			die("delta offset out of bound");
-		revidx =3D find_pack_revindex(p, base_offset);
-		reflen =3D encode_sha1ref(v4,
-					nth_packed_object_sha1(p, revidx->nr),
-					buf);
-		sha1write(f, buf, reflen);
-		written +=3D reflen;
-	} else if (type =3D=3D OBJ_REF_DELTA) {
-		reflen =3D encode_sha1ref(v4, src + hdrlen, buf);
-		hdrlen +=3D 20;
-		sha1write(f, buf, reflen);
-		written +=3D reflen;
-	}
-
-	if (p->index_version > 1 &&
-	    check_pack_crc(p, &w_curs, offset, datalen, idx_nr))
-		die("bad CRC for object at offset %"PRIuMAX" in %s",
-		    (uintmax_t)offset, p->pack_name);
-
-	offset +=3D hdrlen;
-	datalen -=3D hdrlen;
-
-	while (datalen) {
-		src =3D use_pack(p, &w_curs, offset, &avail);
-		if (avail > datalen)
-			avail =3D datalen;
-		sha1write(f, src, avail);
-		written +=3D avail;
-		offset +=3D avail;
-		datalen -=3D avail;
-	}
-	unuse_pack(&w_curs);
-
-	return written;
-}
-
-static unsigned char *get_delta_base(struct packed_git *p, off_t offse=
t,
-				     unsigned char *sha1_buf)
-{
-	struct pack_window *w_curs =3D NULL;
-	enum object_type type;
-	unsigned long avail, size;
-	int hdrlen;
-	unsigned char *src;
-	const unsigned char *base_sha1 =3D NULL; ;
-
-	src =3D use_pack(p, &w_curs, offset, &avail);
-	hdrlen =3D unpack_object_header_buffer(src, avail, &type, &size);
-
-	if (type =3D=3D OBJ_OFS_DELTA) {
-		const unsigned char *cp =3D src + hdrlen;
-		off_t base_offset =3D decode_varint(&cp);
-		base_offset =3D offset - base_offset;
-		if (base_offset <=3D 0 || base_offset >=3D offset) {
-			error("delta offset out of bound");
-		} else {
-			struct revindex_entry *revidx;
-			revidx =3D find_pack_revindex(p, base_offset);
-			base_sha1 =3D nth_packed_object_sha1(p, revidx->nr);
-		}
-	} else if (type =3D=3D OBJ_REF_DELTA) {
-		base_sha1 =3D src + hdrlen;
-	} else
-		error("expected to get a delta but got a %s", typename(type));
-
-	unuse_pack(&w_curs);
-
-	if (!base_sha1)
-		return NULL;
-	hashcpy(sha1_buf, base_sha1);
-	return sha1_buf;
-}
-
-static off_t packv4_write_object(struct packv4_tables *v4,
-				 struct sha1file *f, struct packed_git *p,
-				 struct pack_idx_entry *obj)
-{
-	void *src, *result;
-	struct object_info oi =3D {};
-	enum object_type type, packed_type;
-	unsigned long obj_size, buf_size;
-	unsigned int hdrlen;
-
-	oi.typep =3D &type;
-	oi.sizep =3D &obj_size;
-	packed_type =3D packed_object_info(p, obj->offset, &oi);
-	if (packed_type < 0)
-		die("cannot get type of %s from %s",
-		    sha1_to_hex(obj->sha1), p->pack_name);
-
-	/* Some objects are copied without decompression */
-	switch (type) {
-	case OBJ_COMMIT:
-	case OBJ_TREE:
-		break;
-	default:
-		return copy_object_data(v4, f, p, obj->offset);
-	}
-
-	/* The rest is converted into their new format */
-	src =3D unpack_entry(p, obj->offset, &type, &buf_size);
-	if (!src || obj_size !=3D buf_size)
-		die("cannot unpack %s from %s",
-		    sha1_to_hex(obj->sha1), p->pack_name);
-	if (check_sha1_signature(obj->sha1, src, buf_size, typename(type)))
-		die("packed %s from %s is corrupt",
-		    sha1_to_hex(obj->sha1), p->pack_name);
-
-	switch (type) {
-	case OBJ_COMMIT:
-		result =3D pv4_encode_commit(v4, src, &buf_size);
-		break;
-	case OBJ_TREE:
-		if (packed_type !=3D OBJ_TREE) {
-			unsigned char sha1_buf[20], *ref_sha1;
-			void *ref;
-			enum object_type ref_type;
-			unsigned long ref_size;
-
-			ref_sha1 =3D get_delta_base(p, obj->offset, sha1_buf);
-			if (!ref_sha1)
-				die("unable to get delta base sha1 for %s",
-						sha1_to_hex(obj->sha1));
-			ref =3D read_sha1_file(ref_sha1, &ref_type, &ref_size);
-			if (!ref || ref_type !=3D OBJ_TREE)
-				die("cannot obtain delta base for %s",
-						sha1_to_hex(obj->sha1));
-			result =3D pv4_encode_tree(v4, src, &buf_size,
-						 ref, ref_size, ref_sha1);
-			free(ref);
-		} else {
-			result =3D pv4_encode_tree(v4, src, &buf_size,
-						 NULL, 0, NULL);
-		}
-		break;
-	default:
-		die("unexpected object type %d", type);
-	}
-	free(src);
-	if (!result) {
-		warning("can't convert %s object %s",
-			typename(type), sha1_to_hex(obj->sha1));
-		/* fall back to copy the object in its original form */
-		return copy_object_data(v4, f, p, obj->offset);
-	}
-
-	/* Use bit 3 to indicate a special type encoding */
-	type +=3D 8;
-	hdrlen =3D write_object_header(f, type, obj_size);
-	sha1write(f, result, buf_size);
-	free(result);
-	return hdrlen + buf_size;
-}
-
-static char *normalize_pack_name(const char *path)
-{
-	char buf[PATH_MAX];
-	int len;
-
-	len =3D strlcpy(buf, path, PATH_MAX);
-	if (len >=3D PATH_MAX - 6)
-		die("name too long: %s", path);
-
-	/*
-	 * In addition to "foo.idx" we accept "foo.pack" and "foo";
-	 * normalize these forms to "foo.pack".
-	 */
-	if (has_extension(buf, ".idx")) {
-		strcpy(buf + len - 4, ".pack");
-		len++;
-	} else if (!has_extension(buf, ".pack")) {
-		strcpy(buf + len, ".pack");
-		len +=3D 5;
-	}
-
-	return xstrdup(buf);
-}
-
-static struct packed_git *open_pack(const char *path)
-{
-	char *packname =3D normalize_pack_name(path);
-	int len =3D strlen(packname);
-	struct packed_git *p;
-
-	strcpy(packname + len - 5, ".idx");
-	p =3D add_packed_git(packname, len - 1, 1);
-	if (!p)
-		die("packfile %s not found.", packname);
-
-	install_packed_git(p);
-	if (open_pack_index(p))
-		die("packfile %s index not opened", p->pack_name);
-
-	free(packname);
-	return p;
-}
-
-static void process_one_pack(struct packv4_tables *v4, char *src_pack,=
 char *dst_pack)
-{
-	struct packed_git *p;
-	struct sha1file *f;
-	struct pack_idx_entry *objs, **p_objs;
-	struct pack_idx_option idx_opts;
-	unsigned i, nr_objects;
-	off_t written =3D 0;
-	char *packname;
-	unsigned char pack_sha1[20];
-	struct progress *progress_state;
-
-	p =3D open_pack(src_pack);
-	if (!p)
-		die("unable to open source pack");
-
-	nr_objects =3D p->num_objects;
-	objs =3D get_packed_object_list(p);
-	p_objs =3D sort_objs_by_offset(objs, nr_objects);
-
-	create_pack_dictionaries(v4, p, p_objs);
-	sort_dict_entries_by_hits(v4->commit_ident_table);
-	sort_dict_entries_by_hits(v4->tree_path_table);
-
-	packname =3D normalize_pack_name(dst_pack);
-	f =3D packv4_open(packname);
-	if (!f)
-		die("unable to open destination pack");
-	written +=3D packv4_write_header(f, nr_objects);
-	written +=3D packv4_write_tables(f, v4);
-
-	/* Let's write objects out, updating the object index list in place *=
/
-	progress_state =3D start_progress("Writing objects", nr_objects);
-	v4->all_objs =3D objs;
-	v4->all_objs_nr =3D nr_objects;
-	for (i =3D 0; i < nr_objects; i++) {
-		off_t obj_pos =3D written;
-		struct pack_idx_entry *obj =3D p_objs[i];
-		crc32_begin(f);
-		written +=3D packv4_write_object(v4, f, p, obj);
-		obj->offset =3D obj_pos;
-		obj->crc32 =3D crc32_end(f);
-		display_progress(progress_state, i+1);
-	}
-	stop_progress(&progress_state);
-
-	sha1close(f, pack_sha1, CSUM_CLOSE | CSUM_FSYNC);
-
-	reset_pack_idx_option(&idx_opts);
-	idx_opts.version =3D 3;
-	strcpy(packname + strlen(packname) - 5, ".idx");
-	write_idx_file(packname, p_objs, nr_objects, &idx_opts, pack_sha1);
-
-	free(packname);
-}
-
-static int git_pack_config(const char *k, const char *v, void *cb)
-{
-	if (!strcmp(k, "pack.compression")) {
-		int level =3D git_config_int(k, v);
-		if (level =3D=3D -1)
-			level =3D Z_DEFAULT_COMPRESSION;
-		else if (level < 0 || level > Z_BEST_COMPRESSION)
-			die("bad pack compression level %d", level);
-		pack_compression_level =3D level;
-		pack_compression_seen =3D 1;
-		return 0;
-	}
-	return git_default_config(k, v, cb);
-}
-
-int main(int argc, char *argv[])
-{
-	struct packv4_tables v4;
-	char *src_pack, *dst_pack;
-
-	if (argc =3D=3D 3) {
-		src_pack =3D argv[1];
-		dst_pack =3D argv[2];
-	} else if (argc =3D=3D 4 && !prefixcmp(argv[1], "--min-tree-copy=3D")=
) {
-		min_tree_copy =3D atoi(argv[1] + strlen("--min-tree-copy=3D"));
-		src_pack =3D argv[2];
-		dst_pack =3D argv[3];
-	} else {
-		fprintf(stderr, "Usage: %s [--min-tree-copy=3D<n>] <src_packfile> <d=
st_packfile>\n", argv[0]);
-		exit(1);
-	}
-
-	git_config(git_pack_config, NULL);
-	if (!pack_compression_seen && core_compression_seen)
-		pack_compression_level =3D core_compression_level;
-	process_one_pack(&v4, src_pack, dst_pack);
-	if (0)
-		dict_dump(&v4);
-	return 0;
-}
diff --git a/packv4-create.h b/packv4-create.h
index 0c8c77b..c1f32fd 100644
--- a/packv4-create.h
+++ b/packv4-create.h
@@ -8,4 +8,43 @@ struct packv4_tables {
 	struct dict_table *tree_path_table;
 };
=20
+struct dict_table {
+	unsigned char *data;
+	unsigned cur_offset;
+	unsigned size;
+	struct data_entry *entry;
+	unsigned nb_entries;
+	unsigned max_entries;
+	unsigned *hash;
+	unsigned hash_size;
+};
+
+
+struct sha1file;
+
+struct dict_table *create_dict_table(void);
+int dict_add_entry(struct dict_table *t, int val, const char *str, int=
 str_len);
+void destroy_dict_table(struct dict_table *t);
+void dict_dump(struct packv4_tables *v4);
+
+int add_commit_dict_entries(struct dict_table *commit_ident_table,
+			    void *buf, unsigned long size);
+int add_tree_dict_entries(struct dict_table *tree_path_table,
+			  void *buf, unsigned long size);
+void sort_dict_entries_by_hits(struct dict_table *t);
+
+int encode_sha1ref(const struct packv4_tables *v4,
+		   const unsigned char *sha1, unsigned char *buf);
+unsigned long packv4_write_tables(struct sha1file *f,
+				  const struct packv4_tables *v4);
+void *pv4_encode_commit(const struct packv4_tables *v4,
+			void *buffer, unsigned long *sizep);
+void *pv4_encode_tree(const struct packv4_tables *v4,
+		      void *_buffer, unsigned long *sizep,
+		      void *delta, unsigned long delta_size,
+		      const unsigned char *delta_sha1);
+
+void process_one_pack(struct packv4_tables *v4,
+		      char *src_pack, char *dst_pack);
+
 #endif
diff --git a/test-packv4.c b/test-packv4.c
new file mode 100644
index 0000000..3b0d7a2
--- /dev/null
+++ b/test-packv4.c
@@ -0,0 +1,476 @@
+#include "cache.h"
+#include "pack.h"
+#include "pack-revindex.h"
+#include "progress.h"
+#include "varint.h"
+#include "packv4-create.h"
+
+extern int pack_compression_seen;
+extern int pack_compression_level;
+extern int min_tree_copy;
+
+static struct pack_idx_entry *get_packed_object_list(struct packed_git=
 *p)
+{
+	unsigned i, nr_objects =3D p->num_objects;
+	struct pack_idx_entry *objects;
+
+	objects =3D xmalloc((nr_objects + 1) * sizeof(*objects));
+	objects[nr_objects].offset =3D p->pack_size - 20;
+	for (i =3D 0; i < nr_objects; i++) {
+		hashcpy(objects[i].sha1, nth_packed_object_sha1(p, i));
+		objects[i].offset =3D nth_packed_object_offset(p, i);
+	}
+
+	return objects;
+}
+
+static int sort_by_offset(const void *e1, const void *e2)
+{
+	const struct pack_idx_entry * const *entry1 =3D e1;
+	const struct pack_idx_entry * const *entry2 =3D e2;
+	if ((*entry1)->offset < (*entry2)->offset)
+		return -1;
+	if ((*entry1)->offset > (*entry2)->offset)
+		return 1;
+	return 0;
+}
+
+static struct pack_idx_entry **sort_objs_by_offset(struct pack_idx_ent=
ry *list,
+						    unsigned nr_objects)
+{
+	unsigned i;
+	struct pack_idx_entry **sorted;
+
+	sorted =3D xmalloc((nr_objects + 1) * sizeof(*sorted));
+	for (i =3D 0; i < nr_objects + 1; i++)
+		sorted[i] =3D &list[i];
+	qsort(sorted, nr_objects + 1, sizeof(*sorted), sort_by_offset);
+
+	return sorted;
+}
+
+static int create_pack_dictionaries(struct packv4_tables *v4,
+				    struct packed_git *p,
+				    struct pack_idx_entry **obj_list)
+{
+	struct progress *progress_state;
+	unsigned int i;
+
+	v4->commit_ident_table =3D create_dict_table();
+	v4->tree_path_table =3D create_dict_table();
+
+	progress_state =3D start_progress("Scanning objects", p->num_objects)=
;
+	for (i =3D 0; i < p->num_objects; i++) {
+		struct pack_idx_entry *obj =3D obj_list[i];
+		void *data;
+		enum object_type type;
+		unsigned long size;
+		struct object_info oi =3D {};
+		int (*add_dict_entries)(struct dict_table *, void *, unsigned long);
+		struct dict_table *dict;
+
+		display_progress(progress_state, i+1);
+
+		oi.typep =3D &type;
+		oi.sizep =3D &size;
+		if (packed_object_info(p, obj->offset, &oi) < 0)
+			die("cannot get type of %s from %s",
+			    sha1_to_hex(obj->sha1), p->pack_name);
+
+		switch (type) {
+		case OBJ_COMMIT:
+			add_dict_entries =3D add_commit_dict_entries;
+			dict =3D v4->commit_ident_table;
+			break;
+		case OBJ_TREE:
+			add_dict_entries =3D add_tree_dict_entries;
+			dict =3D v4->tree_path_table;
+			break;
+		default:
+			continue;
+		}
+		data =3D unpack_entry(p, obj->offset, &type, &size);
+		if (!data)
+			die("cannot unpack %s from %s",
+			    sha1_to_hex(obj->sha1), p->pack_name);
+		if (check_sha1_signature(obj->sha1, data, size, typename(type)))
+			die("packed %s from %s is corrupt",
+			    sha1_to_hex(obj->sha1), p->pack_name);
+		if (add_dict_entries(dict, data, size) < 0)
+			die("can't process %s object %s",
+				typename(type), sha1_to_hex(obj->sha1));
+		free(data);
+	}
+
+	stop_progress(&progress_state);
+	return 0;
+}
+
+static struct sha1file * packv4_open(char *path)
+{
+	int fd;
+
+	fd =3D open(path, O_CREAT|O_EXCL|O_WRONLY, 0600);
+	if (fd < 0)
+		die_errno("unable to create '%s'", path);
+	return sha1fd(fd, path);
+}
+
+static unsigned int packv4_write_header(struct sha1file *f, unsigned n=
r_objects)
+{
+	struct pack_header hdr;
+
+	hdr.hdr_signature =3D htonl(PACK_SIGNATURE);
+	hdr.hdr_version =3D htonl(4);
+	hdr.hdr_entries =3D htonl(nr_objects);
+	sha1write(f, &hdr, sizeof(hdr));
+
+	return sizeof(hdr);
+}
+
+static int write_object_header(struct sha1file *f, enum object_type ty=
pe, unsigned long size)
+{
+	unsigned char buf[16];
+	uint64_t val;
+	int len;
+
+	/*
+	 * We really have only one kind of delta object.
+	 */
+	if (type =3D=3D OBJ_OFS_DELTA)
+		type =3D OBJ_REF_DELTA;
+
+	/*
+	 * We allocate 4 bits in the LSB for the object type which should
+	 * be good for quite a while, given that we effectively encodes
+	 * only 5 object types: commit, tree, blob, delta, tag.
+	 */
+	val =3D size;
+	if (MSB(val, 4))
+		die("fixme: the code doesn't currently cope with big sizes");
+	val <<=3D 4;
+	val |=3D type;
+	len =3D encode_varint(val, buf);
+	sha1write(f, buf, len);
+	return len;
+}
+
+static unsigned long copy_object_data(struct packv4_tables *v4,
+				      struct sha1file *f, struct packed_git *p,
+				      off_t offset)
+{
+	struct pack_window *w_curs =3D NULL;
+	struct revindex_entry *revidx;
+	enum object_type type;
+	unsigned long avail, size, datalen, written;
+	int hdrlen, reflen, idx_nr;
+	unsigned char *src, buf[24];
+
+	revidx =3D find_pack_revindex(p, offset);
+	idx_nr =3D revidx->nr;
+	datalen =3D revidx[1].offset - offset;
+
+	src =3D use_pack(p, &w_curs, offset, &avail);
+	hdrlen =3D unpack_object_header_buffer(src, avail, &type, &size);
+
+	written =3D write_object_header(f, type, size);
+
+	if (type =3D=3D OBJ_OFS_DELTA) {
+		const unsigned char *cp =3D src + hdrlen;
+		off_t base_offset =3D decode_varint(&cp);
+		hdrlen =3D cp - src;
+		base_offset =3D offset - base_offset;
+		if (base_offset <=3D 0 || base_offset >=3D offset)
+			die("delta offset out of bound");
+		revidx =3D find_pack_revindex(p, base_offset);
+		reflen =3D encode_sha1ref(v4,
+					nth_packed_object_sha1(p, revidx->nr),
+					buf);
+		sha1write(f, buf, reflen);
+		written +=3D reflen;
+	} else if (type =3D=3D OBJ_REF_DELTA) {
+		reflen =3D encode_sha1ref(v4, src + hdrlen, buf);
+		hdrlen +=3D 20;
+		sha1write(f, buf, reflen);
+		written +=3D reflen;
+	}
+
+	if (p->index_version > 1 &&
+	    check_pack_crc(p, &w_curs, offset, datalen, idx_nr))
+		die("bad CRC for object at offset %"PRIuMAX" in %s",
+		    (uintmax_t)offset, p->pack_name);
+
+	offset +=3D hdrlen;
+	datalen -=3D hdrlen;
+
+	while (datalen) {
+		src =3D use_pack(p, &w_curs, offset, &avail);
+		if (avail > datalen)
+			avail =3D datalen;
+		sha1write(f, src, avail);
+		written +=3D avail;
+		offset +=3D avail;
+		datalen -=3D avail;
+	}
+	unuse_pack(&w_curs);
+
+	return written;
+}
+
+static unsigned char *get_delta_base(struct packed_git *p, off_t offse=
t,
+				     unsigned char *sha1_buf)
+{
+	struct pack_window *w_curs =3D NULL;
+	enum object_type type;
+	unsigned long avail, size;
+	int hdrlen;
+	unsigned char *src;
+	const unsigned char *base_sha1 =3D NULL; ;
+
+	src =3D use_pack(p, &w_curs, offset, &avail);
+	hdrlen =3D unpack_object_header_buffer(src, avail, &type, &size);
+
+	if (type =3D=3D OBJ_OFS_DELTA) {
+		const unsigned char *cp =3D src + hdrlen;
+		off_t base_offset =3D decode_varint(&cp);
+		base_offset =3D offset - base_offset;
+		if (base_offset <=3D 0 || base_offset >=3D offset) {
+			error("delta offset out of bound");
+		} else {
+			struct revindex_entry *revidx;
+			revidx =3D find_pack_revindex(p, base_offset);
+			base_sha1 =3D nth_packed_object_sha1(p, revidx->nr);
+		}
+	} else if (type =3D=3D OBJ_REF_DELTA) {
+		base_sha1 =3D src + hdrlen;
+	} else
+		error("expected to get a delta but got a %s", typename(type));
+
+	unuse_pack(&w_curs);
+
+	if (!base_sha1)
+		return NULL;
+	hashcpy(sha1_buf, base_sha1);
+	return sha1_buf;
+}
+
+static off_t packv4_write_object(struct packv4_tables *v4,
+				 struct sha1file *f, struct packed_git *p,
+				 struct pack_idx_entry *obj)
+{
+	void *src, *result;
+	struct object_info oi =3D {};
+	enum object_type type, packed_type;
+	unsigned long obj_size, buf_size;
+	unsigned int hdrlen;
+
+	oi.typep =3D &type;
+	oi.sizep =3D &obj_size;
+	packed_type =3D packed_object_info(p, obj->offset, &oi);
+	if (packed_type < 0)
+		die("cannot get type of %s from %s",
+		    sha1_to_hex(obj->sha1), p->pack_name);
+
+	/* Some objects are copied without decompression */
+	switch (type) {
+	case OBJ_COMMIT:
+	case OBJ_TREE:
+		break;
+	default:
+		return copy_object_data(v4, f, p, obj->offset);
+	}
+
+	/* The rest is converted into their new format */
+	src =3D unpack_entry(p, obj->offset, &type, &buf_size);
+	if (!src || obj_size !=3D buf_size)
+		die("cannot unpack %s from %s",
+		    sha1_to_hex(obj->sha1), p->pack_name);
+	if (check_sha1_signature(obj->sha1, src, buf_size, typename(type)))
+		die("packed %s from %s is corrupt",
+		    sha1_to_hex(obj->sha1), p->pack_name);
+
+	switch (type) {
+	case OBJ_COMMIT:
+		result =3D pv4_encode_commit(v4, src, &buf_size);
+		break;
+	case OBJ_TREE:
+		if (packed_type !=3D OBJ_TREE) {
+			unsigned char sha1_buf[20], *ref_sha1;
+			void *ref;
+			enum object_type ref_type;
+			unsigned long ref_size;
+
+			ref_sha1 =3D get_delta_base(p, obj->offset, sha1_buf);
+			if (!ref_sha1)
+				die("unable to get delta base sha1 for %s",
+						sha1_to_hex(obj->sha1));
+			ref =3D read_sha1_file(ref_sha1, &ref_type, &ref_size);
+			if (!ref || ref_type !=3D OBJ_TREE)
+				die("cannot obtain delta base for %s",
+						sha1_to_hex(obj->sha1));
+			result =3D pv4_encode_tree(v4, src, &buf_size,
+						 ref, ref_size, ref_sha1);
+			free(ref);
+		} else {
+			result =3D pv4_encode_tree(v4, src, &buf_size,
+						 NULL, 0, NULL);
+		}
+		break;
+	default:
+		die("unexpected object type %d", type);
+	}
+	free(src);
+	if (!result) {
+		warning("can't convert %s object %s",
+			typename(type), sha1_to_hex(obj->sha1));
+		/* fall back to copy the object in its original form */
+		return copy_object_data(v4, f, p, obj->offset);
+	}
+
+	/* Use bit 3 to indicate a special type encoding */
+	type +=3D 8;
+	hdrlen =3D write_object_header(f, type, obj_size);
+	sha1write(f, result, buf_size);
+	free(result);
+	return hdrlen + buf_size;
+}
+
+static char *normalize_pack_name(const char *path)
+{
+	char buf[PATH_MAX];
+	int len;
+
+	len =3D strlcpy(buf, path, PATH_MAX);
+	if (len >=3D PATH_MAX - 6)
+		die("name too long: %s", path);
+
+	/*
+	 * In addition to "foo.idx" we accept "foo.pack" and "foo";
+	 * normalize these forms to "foo.pack".
+	 */
+	if (has_extension(buf, ".idx")) {
+		strcpy(buf + len - 4, ".pack");
+		len++;
+	} else if (!has_extension(buf, ".pack")) {
+		strcpy(buf + len, ".pack");
+		len +=3D 5;
+	}
+
+	return xstrdup(buf);
+}
+
+static struct packed_git *open_pack(const char *path)
+{
+	char *packname =3D normalize_pack_name(path);
+	int len =3D strlen(packname);
+	struct packed_git *p;
+
+	strcpy(packname + len - 5, ".idx");
+	p =3D add_packed_git(packname, len - 1, 1);
+	if (!p)
+		die("packfile %s not found.", packname);
+
+	install_packed_git(p);
+	if (open_pack_index(p))
+		die("packfile %s index not opened", p->pack_name);
+
+	free(packname);
+	return p;
+}
+
+void process_one_pack(struct packv4_tables *v4, char *src_pack, char *=
dst_pack)
+{
+	struct packed_git *p;
+	struct sha1file *f;
+	struct pack_idx_entry *objs, **p_objs;
+	struct pack_idx_option idx_opts;
+	unsigned i, nr_objects;
+	off_t written =3D 0;
+	char *packname;
+	unsigned char pack_sha1[20];
+	struct progress *progress_state;
+
+	p =3D open_pack(src_pack);
+	if (!p)
+		die("unable to open source pack");
+
+	nr_objects =3D p->num_objects;
+	objs =3D get_packed_object_list(p);
+	p_objs =3D sort_objs_by_offset(objs, nr_objects);
+
+	create_pack_dictionaries(v4, p, p_objs);
+	sort_dict_entries_by_hits(v4->commit_ident_table);
+	sort_dict_entries_by_hits(v4->tree_path_table);
+
+	packname =3D normalize_pack_name(dst_pack);
+	f =3D packv4_open(packname);
+	if (!f)
+		die("unable to open destination pack");
+	written +=3D packv4_write_header(f, nr_objects);
+	written +=3D packv4_write_tables(f, v4);
+
+	/* Let's write objects out, updating the object index list in place *=
/
+	progress_state =3D start_progress("Writing objects", nr_objects);
+	v4->all_objs =3D objs;
+	v4->all_objs_nr =3D nr_objects;
+	for (i =3D 0; i < nr_objects; i++) {
+		off_t obj_pos =3D written;
+		struct pack_idx_entry *obj =3D p_objs[i];
+		crc32_begin(f);
+		written +=3D packv4_write_object(v4, f, p, obj);
+		obj->offset =3D obj_pos;
+		obj->crc32 =3D crc32_end(f);
+		display_progress(progress_state, i+1);
+	}
+	stop_progress(&progress_state);
+
+	sha1close(f, pack_sha1, CSUM_CLOSE | CSUM_FSYNC);
+
+	reset_pack_idx_option(&idx_opts);
+	idx_opts.version =3D 3;
+	strcpy(packname + strlen(packname) - 5, ".idx");
+	write_idx_file(packname, p_objs, nr_objects, &idx_opts, pack_sha1);
+
+	free(packname);
+}
+
+static int git_pack_config(const char *k, const char *v, void *cb)
+{
+	if (!strcmp(k, "pack.compression")) {
+		int level =3D git_config_int(k, v);
+		if (level =3D=3D -1)
+			level =3D Z_DEFAULT_COMPRESSION;
+		else if (level < 0 || level > Z_BEST_COMPRESSION)
+			die("bad pack compression level %d", level);
+		pack_compression_level =3D level;
+		pack_compression_seen =3D 1;
+		return 0;
+	}
+	return git_default_config(k, v, cb);
+}
+
+int main(int argc, char *argv[])
+{
+	struct packv4_tables v4;
+	char *src_pack, *dst_pack;
+
+	if (argc =3D=3D 3) {
+		src_pack =3D argv[1];
+		dst_pack =3D argv[2];
+	} else if (argc =3D=3D 4 && !prefixcmp(argv[1], "--min-tree-copy=3D")=
) {
+		min_tree_copy =3D atoi(argv[1] + strlen("--min-tree-copy=3D"));
+		src_pack =3D argv[2];
+		dst_pack =3D argv[3];
+	} else {
+		fprintf(stderr, "Usage: %s [--min-tree-copy=3D<n>] <src_packfile> <d=
st_packfile>\n", argv[0]);
+		exit(1);
+	}
+
+	git_config(git_pack_config, NULL);
+	if (!pack_compression_seen && core_compression_seen)
+		pack_compression_level =3D core_compression_level;
+	process_one_pack(&v4, src_pack, dst_pack);
+	if (0)
+		dict_dump(&v4);
+	return 0;
+}
--=20
1.8.2.83.gc99314b
