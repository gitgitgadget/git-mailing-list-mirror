From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 06/11] refs.c: move ref parsing code out of resolve_ref()
Date: Wed, 15 Oct 2014 17:06:18 +0200
Message-ID: <1413385583-4872-7-git-send-email-mhagger@alum.mit.edu>
References: <1413385583-4872-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 15 17:07:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XeQAN-0002a7-H7
	for gcvg-git-2@plane.gmane.org; Wed, 15 Oct 2014 17:07:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751750AbaJOPGn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Oct 2014 11:06:43 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:52145 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751645AbaJOPGl (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Oct 2014 11:06:41 -0400
X-AuditID: 12074413-f79bb6d000001e81-6e-543e8d7f6ae9
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 54.DF.07809.F7D8E345; Wed, 15 Oct 2014 11:06:39 -0400 (EDT)
Received: from michael.fritz.box (p4FC96250.dip0.t-ipconnect.de [79.201.98.80])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s9FF6SNY020034
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 15 Oct 2014 11:06:38 -0400
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1413385583-4872-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJKsWRmVeSWpSXmKPExsUixO6iqFvfaxdi8KvV0qLrSjeTRUPvFWaL
	2yvmM1t0T3nLaPFvQo3FmTeNjA5sHn/ff2Dy2DnrLrvHgk2lHhcvKXssfuDl8XmTXABbFLdN
	UmJJWXBmep6+XQJ3xs12nYKldhWTJv9lamCcot/FyMkhIWAisfrNU2YIW0ziwr31bF2MXBxC
	ApcZJR41/2CBcI4zSUxuvwdWxSagK7Gop5kJJCEi0MAocejVQrAWZoFFjBLtq64AVXFwCAv4
	SCxZWQ3SwCKgKtG/pJsVJMwr4CxxcR4bxDY5ib2TV7OA2JwCLhK/Xm5jBLGFgEoWLJ0MFucV
	EJQ4OfMJC0grs4C6xPp5QiBhZgF5ieats5knMArMQlI1C6FqFpKqBYzMqxjlEnNKc3VzEzNz
	ilOTdYuTE/PyUot0zfVyM0v0UlNKNzFCgl14B+Ouk3KHGAU4GJV4eDfstQ0RYk0sK67MPcQo
	ycGkJMqb1GMXIsSXlJ9SmZFYnBFfVJqTWnyIUYKDWUmEd34CUI43JbGyKrUoHyYlzcGiJM6r
	tkTdT0ggPbEkNTs1tSC1CCYrw8GhJMFrDzJUsCg1PbUiLTOnBCHNxMEJMpxLSqQ4NS8ltSix
	tCQjHhSl8cXAOAVJ8QDt9QRp5y0uSMwFikK0nmJUlBLnfdcNlBAASWSU5sGNhaWwV4ziQF8K
	84aBtPMA0x9c9yugwUxAgyeG2oIMLklESEk1MOp4xuzyZ1YTeyWn3ff/49JE5uQzfsbLDY48
	UmEu8uXk1Pt+un/jCqPkmA9t09Wec+2YpHQ0eZpw6GqB1l8aGy2SNc6kOa1Kbp5y 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>

This function will soon have a second caller.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---

I leave parse_ref() a public function for the reason explained by
Duy [1].

[1] http://article.gmane.org/gmane.comp.version-control.git/254274

 cache.h |  11 ++++
 refs.c  | 200 ++++++++++++++++++++++++++++++++++----------------------=
--------
 2 files changed, 118 insertions(+), 93 deletions(-)

diff --git a/cache.h b/cache.h
index e36084d..d2b8399 100644
--- a/cache.h
+++ b/cache.h
@@ -1005,6 +1005,17 @@ extern int read_ref(const char *refname, unsigne=
d char *sha1);
 extern const char *resolve_ref_unsafe(const char *ref, unsigned char *=
sha1, int reading, int *flag);
 extern char *resolve_refdup(const char *ref, unsigned char *sha1, int =
reading, int *flag);
 extern int resolve_ref(const char *refname, struct strbuf *result, uns=
igned char *sha1, int reading, int *flag);
+/*
+ * Given a ref in "ref" and its path, returns
+ *
+ * -2  failed to open with ENOENT, the caller is responsible for
+ *     checking missing loose ref (see resolve_ref for example)
+ * -1  if there's an error, "refname" can no longer be trusted, "flag"=
 may
+ *     be set. errno is valid.
+ *  0  this is a symref, "refname" now contains the linked ref
+ * +1  normal ref, "sha1" is valid
+ */
+extern int parse_ref(const char *path, struct strbuf *refname, unsigne=
d char *sha1, int *flag);
=20
 extern int dwim_ref(const char *str, int len, unsigned char *sha1, cha=
r **ref);
 extern int dwim_log(const char *str, int len, unsigned char *sha1, cha=
r **ref);
diff --git a/refs.c b/refs.c
index 29ea7e0..3acd83e 100644
--- a/refs.c
+++ b/refs.c
@@ -1397,6 +1397,104 @@ static int handle_missing_loose_ref(const char =
*refname,
 	}
 }
=20
+int parse_ref(const char *path, struct strbuf *refname,
+	      unsigned char *sha1, int *flag)
+{
+	struct strbuf buffer =3D STRBUF_INIT;
+	struct stat st;
+	const char *buf;
+	int ret;
+
+	/*
+	 * We might have to loop back here to avoid a race condition:
+	 * first we lstat() the file, then we try to read it as a link
+	 * or as a file.  But if somebody changes the type of the file
+	 * (file <-> directory <-> symlink) between the lstat() and
+	 * reading, then we don't want to report that as an error but
+	 * rather try again starting with the lstat().
+	 */
+stat_ref:
+	if (lstat(path, &st) < 0)
+		return errno =3D=3D ENOENT ? -2 : -1;
+
+	/* Follow "normalized" - ie "refs/.." symlinks by hand */
+	if (S_ISLNK(st.st_mode)) {
+		struct strbuf new_path =3D STRBUF_INIT;
+		if (strbuf_readlink(&new_path, path, 256) < 0) {
+			strbuf_release(&new_path);
+			if (errno =3D=3D ENOENT || errno =3D=3D EINVAL)
+				/* inconsistent with lstat; retry */
+				goto stat_ref;
+			else
+				return -1;
+		}
+		if (starts_with(new_path.buf, "refs/") &&
+		    !check_refname_format(new_path.buf, 0)) {
+			strbuf_reset(refname);
+			strbuf_addbuf(refname, &new_path);
+			if (flag)
+				*flag |=3D REF_ISSYMREF;
+			strbuf_release(&new_path);
+			return 0;
+		}
+		strbuf_release(&new_path);
+	}
+
+	/* Is it a directory? */
+	if (S_ISDIR(st.st_mode)) {
+		errno =3D EISDIR;
+		return -1;
+	}
+
+	/*
+	 * Anything else, just open it and try to use it as
+	 * a ref
+	 */
+	if (strbuf_read_file(&buffer, path, 256) < 0) {
+		strbuf_release(&buffer);
+		if (errno =3D=3D ENOENT)
+			/* inconsistent with lstat; retry */
+			goto stat_ref;
+		else
+			return -1;
+	}
+	strbuf_rtrim(&buffer);
+
+	if (skip_prefix(buffer.buf, "ref:", &buf)) {
+		/* It is a symbolic ref */
+		if (flag)
+			*flag |=3D REF_ISSYMREF;
+		while (isspace(*buf))
+			buf++;
+		if (check_refname_format(buf, REFNAME_ALLOW_ONELEVEL)) {
+			if (flag)
+				*flag |=3D REF_ISBROKEN;
+			strbuf_release(&buffer);
+			errno =3D EINVAL;
+			return -1;
+		}
+		strbuf_reset(refname);
+		strbuf_add(refname, buf, buffer.buf + buffer.len - buf);
+		strbuf_release(&buffer);
+		return 0;
+	}
+
+	/*
+	 * Please note that FETCH_HEAD has a second line
+	 * containing other data.
+	 */
+	if (get_sha1_hex(buffer.buf, sha1) ||
+	    (buffer.buf[40] !=3D '\0' && !isspace(buffer.buf[40]))) {
+		if (flag)
+			*flag |=3D REF_ISBROKEN;
+		errno =3D EINVAL;
+		ret =3D -1;
+	} else
+		ret =3D 1;
+	strbuf_release(&buffer);
+	return ret;
+}
+
 /*
  * 'result' content will be destroyed. Its value may be undefined if
  * resolve_ref returns -1.
@@ -1406,9 +1504,8 @@ static int handle_missing_loose_ref(const char *r=
efname,
 int resolve_ref(const char *refname, struct strbuf *result,
 		unsigned char *sha1, int reading, int *flag)
 {
-	struct strbuf buffer =3D STRBUF_INIT;
 	int depth =3D MAXDEPTH;
-	int ret =3D -1;
+	int ret =3D 0;
=20
 	if (flag)
 		*flag =3D 0;
@@ -1421,107 +1518,24 @@ int resolve_ref(const char *refname, struct st=
rbuf *result,
 	strbuf_reset(result);
 	strbuf_addstr(result, refname);
=20
-	for (;;) {
+	while (!ret) {
 		char path[PATH_MAX];
-		struct stat st;
-		const char *buf;
=20
 		if (--depth < 0) {
 			errno =3D ELOOP;
+			ret =3D -1;
 			break;
 		}
=20
 		git_snpath(path, sizeof(path), "%s", result->buf);
-
-		/*
-		 * We might have to loop back here to avoid a race
-		 * condition: first we lstat() the file, then we try
-		 * to read it as a link or as a file.  But if somebody
-		 * changes the type of the file (file <-> directory
-		 * <-> symlink) between the lstat() and reading, then
-		 * we don't want to report that as an error but rather
-		 * try again starting with the lstat().
-		 */
-	stat_ref:
-		if (lstat(path, &st) < 0) {
-			if (errno =3D=3D ENOENT)
-				ret =3D handle_missing_loose_ref(result->buf, sha1,
-							       reading, flag);
-			break;
+		ret =3D parse_ref(path, result, sha1, flag);
+		if (ret =3D=3D -2) {
+			ret =3D handle_missing_loose_ref(result->buf, sha1,
+						       reading, flag);
+			ret =3D ret ? -1 : 1;
 		}
-
-		/* Follow "normalized" - ie "refs/.." symlinks by hand */
-		if (S_ISLNK(st.st_mode)) {
-			/* no need to reset buffer, strbuf_readlink does that */
-			if (strbuf_readlink(&buffer, path, 256) < 0) {
-				if (errno =3D=3D ENOENT || errno =3D=3D EINVAL)
-					/* inconsistent with lstat; retry */
-					goto stat_ref;
-				else
-					break;
-			}
-			if (starts_with(buffer.buf, "refs/") &&
-			    !check_refname_format(buffer.buf, 0)) {
-				strbuf_reset(result);
-				strbuf_addbuf(result, &buffer);
-				if (flag)
-					*flag |=3D REF_ISSYMREF;
-				continue;
-			}
-		}
-
-		/* Is it a directory? */
-		if (S_ISDIR(st.st_mode)) {
-			errno =3D EISDIR;
-			break;
-		}
-
-		/*
-		 * Anything else, just open it and try to use it as
-		 * a ref
-		 */
-		strbuf_reset(&buffer);
-		if (strbuf_read_file(&buffer, path, 256) < 0) {
-			if (errno =3D=3D ENOENT)
-				/* inconsistent with lstat; retry */
-				goto stat_ref;
-			else
-				break;
-		}
-		strbuf_rtrim(&buffer);
-
-		if (skip_prefix(buffer.buf, "ref:", &buf)) {
-			/* It is a symbolic ref */
-			if (flag)
-				*flag |=3D REF_ISSYMREF;
-			while (isspace(*buf))
-				buf++;
-			if (check_refname_format(buf, REFNAME_ALLOW_ONELEVEL)) {
-				if (flag)
-					*flag |=3D REF_ISBROKEN;
-				errno =3D EINVAL;
-				break;
-			}
-			strbuf_reset(result);
-			strbuf_add(result, buf, buffer.buf + buffer.len - buf);
-			continue;
-		}
-
-		/*
-		 * It must be a normal ref. Please note that
-		 * FETCH_HEAD has a second line containing other data.
-		 */
-		if (get_sha1_hex(buffer.buf, sha1) ||
-		    (buffer.buf[40] !=3D '\0' && !isspace(buffer.buf[40]))) {
-			if (flag)
-				*flag |=3D REF_ISBROKEN;
-			errno =3D EINVAL;
-		} else
-			ret =3D 0;
-		break;
 	}
-	strbuf_release(&buffer);
-	return ret;
+	return ret > 0 ? 0 : -1;
 }
=20
 const char *resolve_ref_unsafe(const char *refname, unsigned char *sha=
1, int reading, int *flag)
--=20
2.1.1
