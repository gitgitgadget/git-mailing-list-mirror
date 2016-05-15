From: tboegi@web.de
Subject: [PATCH v1 3/3] convert: ce_compare_data() checks for a sha1 of a path
Date: Sun, 15 May 2016 08:38:19 +0200
Message-ID: <1463294299-20256-1-git-send-email-tboegi@web.de>
References: <20160513134953.GE2345@dinwoodie.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 15 08:33:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1pc0-0006Pf-MQ
	for gcvg-git-2@plane.gmane.org; Sun, 15 May 2016 08:33:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752753AbcEOGdF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 May 2016 02:33:05 -0400
Received: from mout.web.de ([212.227.17.11]:55937 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752389AbcEOGdA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2016 02:33:00 -0400
Received: from tor.lan ([195.252.60.88]) by smtp.web.de (mrweb103) with
 ESMTPSA (Nemesis) id 0M4I2R-1btfBK3NIZ-00rqWe; Sun, 15 May 2016 08:32:57
 +0200
X-Mailer: git-send-email 2.0.0.rc1.6318.g0c2c796
In-Reply-To: <20160513134953.GE2345@dinwoodie.org>
X-Provags-ID: V03:K0:Akt46+gt0ylFVIQy2agBJqs1d+wIWMeyvcolIikkSA3WxGWqbvn
 765NYCZF2Jgbg3PM+wyfQUugyneG3aaUJwt9ylHXxIaVOoFuyPqP9qLt+EF/avxf6iYtVBE
 g5PuItkoBuLOdgx/2HAhFtkOe7waPXsnSnGT7bSJawEZX1CGda/eXDDOV7jIlko5B4ZMMh7
 H01IPyRRl3iL+0UPC1MoA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:UhlAB7KR5w0=:kK0Nl+qi1NRo63VOWmQDqc
 8WcFWM+W+o6lBlCsjiBINrHjMZOGn/UbsmQaC8Opaioz1a7dR5veY+hNMDAcQXUN2oZwRCbTw
 iFiHnz9i4BkWKKXdOsVHI+thZHYmBTNCTGonUuHq22LwgaxcSHeE8HURIwqYXQNpUXWZjklQ1
 PcibhwsWmpoYzjX0+9RwgAQTAYMABSwLIASMUmwA8ibnTqyj9jye5Fb5sq28qJkCWYHMcHPqX
 PnCNCf4n1yzjT+8JSqEySqMbx12T7nmQu7QUg+7NRQDAnsRZcPf+A5vWXktNkh8rpa9G6p2m/
 PYrYx6gUivHITCpfSkIFepIfbAMMJ290ADLxon9xYlLEDizjqrYFfV5/2k5+I9ORKZnB13aKI
 BDwRaAKwGOU5sK9DwpS3Jj419U2tegUBmUfAdr9ChMXmpwqsVlAaSoIe3V1t5C/2y+s6GHj8t
 QLIOb9CB7cwpzIVDhGdWYW1T+AWpUMCuZ0dy6Ec8R1G8AIxL++uOFp++qSZTYXavW11WJYM9u
 7dCW8g23C09pv6277MsPWgLfzcyVWBcLvZHLKzBv27JRQbdi6ez75LNDMqk9e1AywlSfIktU/
 mFeWPx6FyRT72nGWXG6QudOSmLwGYs0ljpflnsHZVudKNhZW7XCKpaRnaXAKq4fN1YKKD2cGI
 EokgLqReeAOuMlDW1053EyFs3hElh2u7GtXt2+trm25mKXml66+rEgzwbhM/iC0YJtApzI5iJ
 CfOD9fSl6/R2zY9erurPVP1OZPINYKan5fVais5FCg+ljgPBGV7iXWkB3NP8XcPeYI+ySdjA 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294639>

=46rom: Torsten B=C3=B6gershausen <tboegi@web.de>

To compare a file in working tree with the index, convert_to_git() is u=
sed,
the the result is hashed and the hash value compared with ce->sha1.

Deep down would_convert_crlf_at_commit() is invoked, to check if CRLF
are converted or not: When a CRLF had been in the index before, CRLF in
the working tree are not converted.

While in a merge, a file name in the working tree has different blobs
in the index with different hash values.
=46orwarding ce->sha1 from ce_compare_data() into crlf_to_git() makes s=
ure
the would_convert_crlf_at_commit() looks at the appropriate blob.

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 cache.h      |  1 +
 convert.c    | 33 ++++++++++++++++++++++-----------
 convert.h    | 23 +++++++++++++++++++----
 read-cache.c |  4 +++-
 sha1_file.c  | 17 +++++++++++++----
 5 files changed, 58 insertions(+), 20 deletions(-)

diff --git a/cache.h b/cache.h
index 15a2a10..a5136c0 100644
--- a/cache.h
+++ b/cache.h
@@ -605,6 +605,7 @@ extern int ie_modified(const struct index_state *, =
const struct cache_entry *, s
=20
 #define HASH_WRITE_OBJECT 1
 #define HASH_FORMAT_CHECK 2
+#define HASH_CE_HAS_SHA1  4
 extern int index_fd(unsigned char *sha1, int fd, struct stat *st, enum=
 object_type type, const char *path, unsigned flags);
 extern int index_path(unsigned char *sha1, const char *path, struct st=
at *st, unsigned flags);
=20
diff --git a/convert.c b/convert.c
index f524b8d..5a0cd03 100644
--- a/convert.c
+++ b/convert.c
@@ -217,21 +217,29 @@ static void check_safe_crlf(const char *path, enu=
m crlf_action crlf_action,
 	}
 }
=20
-static int has_cr_in_index(const char *path)
+static int has_cr_in_index(const char *path, const unsigned char *sha1=
)
 {
 	unsigned long sz;
 	void *data;
 	int has_cr;
-
-	data =3D read_blob_data_from_cache(path, &sz);
-	if (!data)
+	enum object_type type;
+	if (!sha1)
+		sha1 =3D get_sha1_from_cache(path);
+	if (!sha1)
+		return 0;
+	data =3D read_sha1_file(sha1, &type, &sz);
+	if (!data || type !=3D OBJ_BLOB) {
+		free(data);
 		return 0;
+	}
+
 	has_cr =3D memchr(data, '\r', sz) !=3D NULL;
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
@@ -260,7 +268,7 @@ static int crlf_to_git(const char *path, const char=
 *src, size_t len,
 			 * If the file in the index has any CR in it, do not convert.
 			 * This is the new safer autocrlf handling.
 			 */
-			if (has_cr_in_index(path))
+			if (has_cr_in_index(path, sha1))
 				return 0;
 		}
 	}
@@ -852,8 +860,9 @@ const char *get_convert_attr_ascii(const char *path=
)
 	return "";
 }
=20
-int convert_to_git(const char *path, const char *src, size_t len,
-                   struct strbuf *dst, enum safe_crlf checksafe)
+int convert_to_git_ce_sha1(const char *path, const unsigned char *sha1=
,
+			   const char *src, size_t len,
+			   struct strbuf *dst, enum safe_crlf checksafe)
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
diff --git a/convert.h b/convert.h
index ccf436b..1634d37 100644
--- a/convert.h
+++ b/convert.h
@@ -37,8 +37,16 @@ extern const char *get_wt_convert_stats_ascii(const =
char *path);
 extern const char *get_convert_attr_ascii(const char *path);
=20
 /* returns 1 if *dst was used */
-extern int convert_to_git(const char *path, const char *src, size_t le=
n,
-			  struct strbuf *dst, enum safe_crlf checksafe);
+extern int convert_to_git_ce_sha1(const char *path, const unsigned cha=
r *sha1,
+				  const char *src, size_t len,
+				  struct strbuf *dst, enum safe_crlf checksafe);
+
+static inline int convert_to_git(const char *path, const char *src, si=
ze_t len,
+				 struct strbuf *dst, enum safe_crlf checksafe)
+{
+	return convert_to_git_ce_sha1(path, NULL, src, len, dst, checksafe);
+}
+
 extern int convert_to_working_tree(const char *path, const char *src,
 				   size_t len, struct strbuf *dst);
 extern int renormalize_buffer(const char *path, const char *src, size_=
t len,
@@ -47,9 +55,16 @@ static inline int would_convert_to_git(const char *p=
ath)
 {
 	return convert_to_git(path, NULL, 0, NULL, 0);
 }
+static inline int would_convert_to_git_ce_sha1(const char *path,
+					       const unsigned char *sha1)
+{
+	return convert_to_git_ce_sha1(path, sha1, NULL, 0, NULL, 0);
+}
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
diff --git a/read-cache.c b/read-cache.c
index a3ef967..0ebc237 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -163,7 +163,9 @@ static int ce_compare_data(const struct cache_entry=
 *ce, struct stat *st)
=20
 	if (fd >=3D 0) {
 		unsigned char sha1[20];
-		if (!index_fd(sha1, fd, st, OBJ_BLOB, ce->name, 0))
+		unsigned flags =3D HASH_CE_HAS_SHA1;
+		memcpy(sha1, ce->sha1, sizeof(sha1));
+		if (!index_fd(sha1, fd, st, OBJ_BLOB, ce->name, flags))
 			match =3D hashcmp(sha1, ce->sha1);
 		/* index_fd() closed the file descriptor already */
 	}
diff --git a/sha1_file.c b/sha1_file.c
index d0f2aa0..dd013d5 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -3275,6 +3275,7 @@ static int index_mem(unsigned char *sha1, void *b=
uf, size_t size,
 {
 	int ret, re_allocated =3D 0;
 	int write_object =3D flags & HASH_WRITE_OBJECT;
+	const int valid_sha1 =3D flags & HASH_CE_HAS_SHA1;
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
+		if (convert_to_git_ce_sha1(path,
+					   valid_sha1 ? sha1 : NULL,
+					   buf, size, &nbuf,
+					   write_object ? safe_crlf : SAFE_CRLF_FALSE)){
+
 			buf =3D strbuf_detach(&nbuf, &size);
 			re_allocated =3D 1;
 		}
@@ -3313,12 +3317,15 @@ static int index_stream_convert_blob(unsigned c=
har *sha1, int fd,
 {
 	int ret;
 	const int write_object =3D flags & HASH_WRITE_OBJECT;
+	const int valid_sha1 =3D flags & HASH_CE_HAS_SHA1;
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
+	sha1_ce =3D flags & HASH_CE_HAS_SHA1 ? sha1 : NULL;
=20
 	/*
 	 * Call xsize_t() only when needed to avoid potentially unnecessary
@@ -3406,7 +3415,7 @@ int index_fd(unsigned char *sha1, int fd, struct =
stat *st,
 	else if (!S_ISREG(st->st_mode))
 		ret =3D index_pipe(sha1, fd, type, path, flags);
 	else if (st->st_size <=3D big_file_threshold || type !=3D OBJ_BLOB ||
-		 (path && would_convert_to_git(path)))
+		 (path && would_convert_to_git_ce_sha1(path,sha1_ce)))
 		ret =3D index_core(sha1, fd, xsize_t(st->st_size), type, path,
 				 flags);
 	else
--=20
2.0.0.rc1.6318.g0c2c796
