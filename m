From: tboegi@web.de
Subject: [PATCH v6 2/2] convert: ce_compare_data() checks for a sha1 of a path
Date: Fri, 20 May 2016 19:12:46 +0200
Message-ID: <1463764366-21683-1-git-send-email-tboegi@web.de>
References: <xmqqk2iphcqe.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 20 19:14:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3ntY-0003FJ-F0
	for gcvg-git-2@plane.gmane.org; Fri, 20 May 2016 19:07:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756138AbcETRHM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 May 2016 13:07:12 -0400
Received: from mout.web.de ([212.227.17.11]:54037 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755260AbcETRHI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2016 13:07:08 -0400
Received: from tor.lan ([195.252.60.88]) by smtp.web.de (mrweb101) with
 ESMTPSA (Nemesis) id 0MGRVU-1aqej33h6e-00DH0f; Fri, 20 May 2016 19:07:05
 +0200
X-Mailer: git-send-email 2.0.0.rc1.6318.g0c2c796
In-Reply-To: <xmqqk2iphcqe.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:wid79p4lXVQbQqd215HqA+Xz6sqg34GKz2E9NQR/YL+L8Fx4Cfk
 JG5gsLhYoKhHhsZXfq9KQYxhlB1FtaAroerbHqHx0karEjnbRSzdFqlry3RNWQLzkOVJExl
 f397jBI7kMVo5UTPZUcL1a4r5oJq43K+5Y3ydPR2uIeSVcq05bbjQKMYeH8/J9GXLEjoNqs
 0E5VXSROU/TYVb3/nsMlQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Q0aWO0NTQMY=:T0tz+Ggu6fOkQHMwncmPc+
 Ntlu2Ucc3WizSe8IFRbjHHa4TJzs7JXBCrJoneA1Af5O6dNslyBC46wEIF/5UBkvSzaxfKl6L
 hhHQgBOz6WeaDG7z9b1lbRdD+V2Ueq39GPHoqo5Hrar/C+yfEcfhsgw4avnPNxjCSaDVZiloN
 ZCv58NBm5sztrh94KN8MmDSr8FrpvWCspo1UWLA0cruvOGtnbzvjI3UgsmfVrjpeUSvlx4A0J
 HEr4zWDyKMKKOkYT0akMbHdDJwMpq/U4lUNQXxoqG56pwCyb8g7UZ+huNbswTAwJMM87YNJd1
 jbmMPuMgUHLG93EBww/gMofI6RPvK9+gCEfOovsKLs/A8l/6gL1mXqHFr2+K0RtrdmPd2K9s2
 2B9yw6UyYsjfoQykJzIzT6Ud83DMEYrgkOfO6+93A3Jg2Gyg9iuVgZMVH80kHdF5zisq5qaxM
 xIBk+DgS5FOSjv6bop5FV/J9UZHzfSvzKpKLdjYfEwDA4SGgonCYCse4HbSrwWbIdGthMWX1K
 juo9+TltuKJ9GC711OTcc/HX/pqRLfOqjn1RyRFmfY7DjSQ/m7wMZml1ZWcZdwLpbd2XKIY32
 3E2zowblQlMn7tx/h4ej/qxcpVlmxKXTMsnBc38Fy7rhdGMqs7oDg3slJb+ST+ULw2LzH73mK
 TBEUeCH4g7P2SSm7i4QQNWdSTJufU5Ci1UUoDVfQXAm9MopaMr2OrBkk0EcjgVAe7klJc14vS
 5jJp+hZ6xx96N76vPDldvAjiRvF0q90rV5VySaw/X0/MjNH6o5CeSPQ3bllbq8RBOWlRN3/k 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295188>

=46rom: Torsten B=C3=B6gershausen <tboegi@web.de>

To compare a file in working tree with the index, convert_to_git() is u=
sed,
the result is hashed and the hash value compared with ce->sha1.

Deep down would_convert_crlf_at_commit() is invoked, to check if CRLF
are converted or not: When a CRLF had been in the index before, CRLF in
the working tree are not converted.

While in a merge, a file name in the working tree has different blobs
in the index with different hash values.
=46orwarding ce->sha1 from ce_compare_data() into crlf_to_git() makes s=
ure
the would_convert_crlf_at_commit() looks at the appropriate blob.

=46orward sha1 from ce_compare_data() into convert_to_git().
All other callers use NULL, and the sha1 it is determined from path usi=
ng
get_sha1_from_cache(path), this is the same handling as before.

Re-order the arguments for convert_to_git() according to their importan=
ce:
  `src`, `len` and `dst` are the place in memory, where the conversion =
is done
  `path` is the file name to look up the attributes.
  `sha1` is needed by the "new safer autocrlf handling".
  `checksafe` determines, if a warning is printed or an error is raised=
=2E

In the same spirit, forward the sha1 into would_convert_to_git().

While at it, rename has_cr_in_index() into blob_has_cr()

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
Changes sinve v6:
 decrease the messiness with 12 %
 convert_to_git() has a re-ordered parameter list.
 Describe whats going on better in the commit msg.
 Cleanup: 0 -> SAFE_CRLF_FALSE at some places
---
 builtin/apply.c |  3 ++-
 builtin/blame.c |  2 +-
 cache.h         |  1 +
 combine-diff.c  |  4 +++-
 convert.c       | 38 +++++++++++++++++++++++++-------------
 convert.h       | 20 ++++++++++++++------
 diff.c          |  3 ++-
 dir.c           |  2 +-
 read-cache.c    |  4 +++-
 sha1_file.c     | 17 +++++++++++++----
 10 files changed, 65 insertions(+), 29 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 8e4da2e..c01654a 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -2140,7 +2140,8 @@ static int read_old_data(struct stat *st, const c=
har *path, struct strbuf *buf)
 	case S_IFREG:
 		if (strbuf_read_file(buf, path, st->st_size) !=3D st->st_size)
 			return error(_("unable to open or read %s"), path);
-		convert_to_git(path, buf->buf, buf->len, buf, 0);
+		convert_to_git(buf->buf, buf->len, buf,
+			       path, NULL, SAFE_CRLF_FALSE);
 		return 0;
 	default:
 		return -1;
diff --git a/builtin/blame.c b/builtin/blame.c
index 21f42b0..4a01e20 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2377,7 +2377,7 @@ static struct commit *fake_working_tree_commit(st=
ruct diff_options *opt,
 		if (strbuf_read(&buf, 0, 0) < 0)
 			die_errno("failed to read from stdin");
 	}
-	convert_to_git(path, buf.buf, buf.len, &buf, 0);
+	convert_to_git(buf.buf, buf.len, &buf, path, NULL, SAFE_CRLF_FALSE);
 	origin->file.ptr =3D buf.buf;
 	origin->file.size =3D buf.len;
 	pretend_sha1_file(buf.buf, buf.len, OBJ_BLOB, origin->blob_sha1);
diff --git a/cache.h b/cache.h
index 15a2a10..868599e 100644
--- a/cache.h
+++ b/cache.h
@@ -605,6 +605,7 @@ extern int ie_modified(const struct index_state *, =
const struct cache_entry *, s
=20
 #define HASH_WRITE_OBJECT 1
 #define HASH_FORMAT_CHECK 2
+#define HASH_USE_SHA_NOT_PATH 4
 extern int index_fd(unsigned char *sha1, int fd, struct stat *st, enum=
 object_type type, const char *path, unsigned flags);
 extern int index_path(unsigned char *sha1, const char *path, struct st=
at *st, unsigned flags);
=20
diff --git a/combine-diff.c b/combine-diff.c
index 0e1d4b0..cac4c81 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -1053,7 +1053,9 @@ static void show_patch_diff(struct combine_diff_p=
ath *elem, int num_parent,
 			if (is_file) {
 				struct strbuf buf =3D STRBUF_INIT;
=20
-				if (convert_to_git(elem->path, result, len, &buf, safe_crlf)) {
+				if (convert_to_git(result, len, &buf,
+						   elem->path, NULL,
+						   safe_crlf)) {
 					free(result);
 					result =3D strbuf_detach(&buf, &len);
 					result_size =3D len;
diff --git a/convert.c b/convert.c
index f524b8d..a58bb26 100644
--- a/convert.c
+++ b/convert.c
@@ -217,21 +217,26 @@ static void check_safe_crlf(const char *path, enu=
m crlf_action crlf_action,
 	}
 }
=20
-static int has_cr_in_index(const char *path)
+static int blob_has_cr(const unsigned char *sha1)
 {
 	unsigned long sz;
 	void *data;
-	int has_cr;
-
-	data =3D read_blob_data_from_cache(path, &sz);
+	int has_cr =3D 0;
+	enum object_type type;
+	if (!sha1)
+		return 0;
+	data =3D read_sha1_file(sha1, &type, &sz);
 	if (!data)
 		return 0;
-	has_cr =3D memchr(data, '\r', sz) !=3D NULL;
+	if (type =3D=3D OBJ_BLOB)
+		has_cr =3D memchr(data, '\r', sz) !=3D NULL;
+
 	free(data);
 	return has_cr;
 }
=20
-static int crlf_to_git(const char *path, const char *src, size_t len,
+static int crlf_to_git(const char *path, const unsigned char *sha1,
+		       const char *src, size_t len,
 		       struct strbuf *buf,
 		       enum crlf_action crlf_action, enum safe_crlf checksafe)
 {
@@ -260,7 +265,9 @@ static int crlf_to_git(const char *path, const char=
 *src, size_t len,
 			 * If the file in the index has any CR in it, do not convert.
 			 * This is the new safer autocrlf handling.
 			 */
-			if (has_cr_in_index(path))
+			if (!sha1)
+				sha1 =3D get_sha1_from_cache(path);
+			if (blob_has_cr(sha1))
 				return 0;
 		}
 	}
@@ -852,8 +859,10 @@ const char *get_convert_attr_ascii(const char *pat=
h)
 	return "";
 }
=20
-int convert_to_git(const char *path, const char *src, size_t len,
-                   struct strbuf *dst, enum safe_crlf checksafe)
+int convert_to_git(const char *src, size_t len,
+		   struct strbuf *dst,
+		   const char *path, const unsigned char *sha1,
+		   enum safe_crlf checksafe)
 {
 	int ret =3D 0;
 	const char *filter =3D NULL;
@@ -874,7 +883,7 @@ int convert_to_git(const char *path, const char *sr=
c, size_t len,
 		src =3D dst->buf;
 		len =3D dst->len;
 	}
-	ret |=3D crlf_to_git(path, src, len, dst, ca.crlf_action, checksafe);
+	ret |=3D crlf_to_git(path, sha1, src, len, dst, ca.crlf_action, check=
safe);
 	if (ret && dst) {
 		src =3D dst->buf;
 		len =3D dst->len;
@@ -882,7 +891,9 @@ int convert_to_git(const char *path, const char *sr=
c, size_t len,
 	return ret | ident_to_git(path, src, len, dst, ca.ident);
 }
=20
-void convert_to_git_filter_fd(const char *path, int fd, struct strbuf =
*dst,
+void convert_to_git_filter_fd(const char *path,
+			      const unsigned char *sha1,
+			      int fd, struct strbuf *dst,
 			      enum safe_crlf checksafe)
 {
 	struct conv_attrs ca;
@@ -894,7 +905,7 @@ void convert_to_git_filter_fd(const char *path, int=
 fd, struct strbuf *dst,
 	if (!apply_filter(path, NULL, 0, fd, dst, ca.drv->clean))
 		die("%s: clean filter '%s' failed", path, ca.drv->name);
=20
-	crlf_to_git(path, dst->buf, dst->len, dst, ca.crlf_action, checksafe)=
;
+	crlf_to_git(path, sha1, dst->buf, dst->len, dst, ca.crlf_action, chec=
ksafe);
 	ident_to_git(path, dst->buf, dst->len, dst, ca.ident);
 }
=20
@@ -949,7 +960,8 @@ int renormalize_buffer(const char *path, const char=
 *src, size_t len, struct str
 		src =3D dst->buf;
 		len =3D dst->len;
 	}
-	return ret | convert_to_git(path, src, len, dst, SAFE_CRLF_FALSE);
+	ret |=3D convert_to_git(src, len, dst, path, NULL, SAFE_CRLF_FALSE);
+	return ret;
 }
=20
 /*****************************************************************
diff --git a/convert.h b/convert.h
index ccf436b..12fe767 100644
--- a/convert.h
+++ b/convert.h
@@ -37,19 +37,27 @@ extern const char *get_wt_convert_stats_ascii(const=
 char *path);
 extern const char *get_convert_attr_ascii(const char *path);
=20
 /* returns 1 if *dst was used */
-extern int convert_to_git(const char *path, const char *src, size_t le=
n,
-			  struct strbuf *dst, enum safe_crlf checksafe);
+extern int convert_to_git(const char *src, size_t len,
+			  struct strbuf *dst,
+			  const char *path, const unsigned char *sha1,
+			  enum safe_crlf checksafe);
+
 extern int convert_to_working_tree(const char *path, const char *src,
 				   size_t len, struct strbuf *dst);
 extern int renormalize_buffer(const char *path, const char *src, size_=
t len,
 			      struct strbuf *dst);
-static inline int would_convert_to_git(const char *path)
+
+static inline int would_convert_to_git(const char *path,
+				       const unsigned char *sha1)
 {
-	return convert_to_git(path, NULL, 0, NULL, 0);
+	return convert_to_git(NULL, 0, NULL, path, sha1, SAFE_CRLF_FALSE);
 }
+
+
 /* Precondition: would_convert_to_git_filter_fd(path) =3D=3D true */
-extern void convert_to_git_filter_fd(const char *path, int fd,
-				     struct strbuf *dst,
+extern void convert_to_git_filter_fd(const char *path,
+				     const unsigned char *sha1,
+				     int fd, struct strbuf *dst,
 				     enum safe_crlf checksafe);
 extern int would_convert_to_git_filter_fd(const char *path);
=20
diff --git a/diff.c b/diff.c
index d3734d3..9c00973 100644
--- a/diff.c
+++ b/diff.c
@@ -2810,7 +2810,8 @@ int diff_populate_filespec(struct diff_filespec *=
s, unsigned int flags)
 		/*
 		 * Convert from working tree format to canonical git format
 		 */
-		if (convert_to_git(s->path, s->data, s->size, &buf, crlf_warn)) {
+		if (convert_to_git(s->data, s->size, &buf, s->path, NULL,
+				   crlf_warn)) {
 			size_t size =3D 0;
 			munmap(s->data, s->size);
 			s->should_munmap =3D 0;
diff --git a/dir.c b/dir.c
index 656f272..5ac379d 100644
--- a/dir.c
+++ b/dir.c
@@ -713,7 +713,7 @@ static int add_excludes(const char *fname, const ch=
ar *base, int baselen,
 				 (pos =3D cache_name_pos(fname, strlen(fname))) >=3D 0 &&
 				 !ce_stage(active_cache[pos]) &&
 				 ce_uptodate(active_cache[pos]) &&
-				 !would_convert_to_git(fname))
+				 !would_convert_to_git(fname, NULL))
 				hashcpy(sha1_stat->sha1, active_cache[pos]->sha1);
 			else
 				hash_sha1_file(buf, size, "blob", sha1_stat->sha1);
diff --git a/read-cache.c b/read-cache.c
index a3ef967..c109b6d 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -163,7 +163,9 @@ static int ce_compare_data(const struct cache_entry=
 *ce, struct stat *st)
=20
 	if (fd >=3D 0) {
 		unsigned char sha1[20];
-		if (!index_fd(sha1, fd, st, OBJ_BLOB, ce->name, 0))
+		unsigned flags =3D HASH_USE_SHA_NOT_PATH;
+		memcpy(sha1, ce->sha1, sizeof(sha1));
+		if (!index_fd(sha1, fd, st, OBJ_BLOB, ce->name, flags))
 			match =3D hashcmp(sha1, ce->sha1);
 		/* index_fd() closed the file descriptor already */
 	}
diff --git a/sha1_file.c b/sha1_file.c
index d0f2aa0..48906b0 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -3275,6 +3275,7 @@ static int index_mem(unsigned char *sha1, void *b=
uf, size_t size,
 {
 	int ret, re_allocated =3D 0;
 	int write_object =3D flags & HASH_WRITE_OBJECT;
+	const int valid_sha1 =3D flags & HASH_USE_SHA_NOT_PATH;
=20
 	if (!type)
 		type =3D OBJ_BLOB;
@@ -3284,8 +3285,11 @@ static int index_mem(unsigned char *sha1, void *=
buf, size_t size,
 	 */
 	if ((type =3D=3D OBJ_BLOB) && path) {
 		struct strbuf nbuf =3D STRBUF_INIT;
-		if (convert_to_git(path, buf, size, &nbuf,
-				   write_object ? safe_crlf : SAFE_CRLF_FALSE)) {
+		if (convert_to_git(
+			    buf, size, &nbuf,path,
+			    valid_sha1 ? sha1 : NULL,
+			    write_object ? safe_crlf : SAFE_CRLF_FALSE)){
+
 			buf =3D strbuf_detach(&nbuf, &size);
 			re_allocated =3D 1;
 		}
@@ -3313,12 +3317,15 @@ static int index_stream_convert_blob(unsigned c=
har *sha1, int fd,
 {
 	int ret;
 	const int write_object =3D flags & HASH_WRITE_OBJECT;
+	const int valid_sha1 =3D flags & HASH_USE_SHA_NOT_PATH;
 	struct strbuf sbuf =3D STRBUF_INIT;
=20
 	assert(path);
 	assert(would_convert_to_git_filter_fd(path));
=20
-	convert_to_git_filter_fd(path, fd, &sbuf,
+	convert_to_git_filter_fd(path,
+				 valid_sha1 ? sha1 : NULL,
+				 fd, &sbuf,
 				 write_object ? safe_crlf : SAFE_CRLF_FALSE);
=20
 	if (write_object)
@@ -3396,6 +3403,8 @@ int index_fd(unsigned char *sha1, int fd, struct =
stat *st,
 	     enum object_type type, const char *path, unsigned flags)
 {
 	int ret;
+	const unsigned char *sha1_ce;
+	sha1_ce =3D flags & HASH_USE_SHA_NOT_PATH ? sha1 : NULL;
=20
 	/*
 	 * Call xsize_t() only when needed to avoid potentially unnecessary
@@ -3406,7 +3415,7 @@ int index_fd(unsigned char *sha1, int fd, struct =
stat *st,
 	else if (!S_ISREG(st->st_mode))
 		ret =3D index_pipe(sha1, fd, type, path, flags);
 	else if (st->st_size <=3D big_file_threshold || type !=3D OBJ_BLOB ||
-		 (path && would_convert_to_git(path)))
+		 (path && would_convert_to_git(path,sha1_ce)))
 		ret =3D index_core(sha1, fd, xsize_t(st->st_size), type, path,
 				 flags);
 	else
--=20
2.0.0.rc1.6318.g0c2c796
