From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v5 30/35] resolve_symlink(): take a strbuf parameter
Date: Tue, 16 Sep 2014 21:33:51 +0200
Message-ID: <1410896036-12750-31-git-send-email-mhagger@alum.mit.edu>
References: <1410896036-12750-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Ronnie Sahlberg <sahlberg@google.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Sep 16 21:42:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTye4-0003pZ-RB
	for gcvg-git-2@plane.gmane.org; Tue, 16 Sep 2014 21:42:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755230AbaIPTmd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Sep 2014 15:42:33 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:47050 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755150AbaIPTmb (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Sep 2014 15:42:31 -0400
X-AuditID: 1207440c-f79036d000005e77-6d-541890e525c1
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 80.9C.24183.5E098145; Tue, 16 Sep 2014 15:35:01 -0400 (EDT)
Received: from michael.fritz.box (p5DDB27D9.dip0.t-ipconnect.de [93.219.39.217])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s8GJYBcY001163
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 16 Sep 2014 15:35:00 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1410896036-12750-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIKsWRmVeSWpSXmKPExsUixO6iqPt0gkSIQf9dK4uuK91MFg29V5gt
	nsy9y2xxe8V8ZosfLT3MFv8m1Fh0dnxldGD3+Pv+A5PHgk2lHg9fdbF7POvdw+hx8ZKyx+dN
	ch63n21jCWCP4rZJSiwpC85Mz9O3S+DOWN40nbXgolzFotOzWRsYf4h3MXJySAiYSEzaf50N
	whaTuHBvPZDNxSEkcJlRYt6uu6wQzgkmiZlP21lAqtgEdCUW9TQzgSREBNoYJXZd3AxWxSzQ
	zSjx/sRpJpAqYQEXiRf7l7OD2CwCqhJPnrwH6+YVcJV43t7EDLFPTmLD7v+MXYwcHJxA8a/7
	CkBMIaDWg3f9IKoFJU7OfMICEmYWUJdYP08IJMwsIC/RvHU28wRGgVlIqmYhVM1CUrWAkXkV
	o1xiTmmubm5iZk5xarJucXJiXl5qka6hXm5miV5qSukmRkgU8Oxg/LZO5hCjAAejEg/vh/vi
	IUKsiWXFlbmHGCU5mJREef91S4QI8SXlp1RmJBZnxBeV5qQWH2KU4GBWEuH94QuU401JrKxK
	LcqHSUlzsCiJ86ouUfcTEkhPLEnNTk0tSC2CycpwcChJ8PIBo11IsCg1PbUiLTOnBCHNxMEJ
	MpxLSqQ4NS8ltSixtCQjHhSn8cXASAVJ8QDt/dgPsre4IDEXKArReopRl2Nd57d+JiGWvPy8
	VClxXhuQIgGQoozSPLgVsJT3ilEc6GNh3ncgVTzAdAk36RXQEiagJWd7xECWlCQipKQaGNk8
	3Vhdp/N8Xqlzl+XSjlX9bXrtf7QeLbdz2/rPU8U+Vz9WTeLsWTaFyXWSbkvXtrVd 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257178>

Change resolve_symlink() to take a strbuf rather than a string as
parameter.  This simplifies the code and removes an arbitrary pathname
length restriction.  It also means that lock_file's filename field no
longer needs to be initialized to a large size.

Helped-by: Torsten B=C3=B6gershausen <tboegi@web.de>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 lockfile.c | 57 ++++++++++++++++++++++--------------------------------=
---
 1 file changed, 22 insertions(+), 35 deletions(-)

diff --git a/lockfile.c b/lockfile.c
index ae55f33..e689a84 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -124,58 +124,47 @@ static char *last_path_elm(char *p)
 #define MAXDEPTH 5
=20
 /*
- * p =3D path that may be a symlink
- * s =3D full size of p
+ * path contains a path that might be a symlink.
  *
- * If p is a symlink, attempt to overwrite p with a path to the real
- * file or directory (which may or may not exist), following a chain o=
f
- * symlinks if necessary.  Otherwise, leave p unmodified.
+ * If path is a symlink, attempt to overwrite it with a path to the
+ * real file or directory (which may or may not exist), following a
+ * chain of symlinks if necessary.  Otherwise, leave path unmodified.
  *
- * This is a best-effort routine.  If an error occurs, p will either b=
e
- * left unmodified or will name a different symlink in a symlink chain
- * that started with p's initial contents.
- *
- * Always returns p.
+ * This is a best-effort routine.  If an error occurs, path will
+ * either be left unmodified or will name a different symlink in a
+ * symlink chain that started with the original path.
  */
-
-static char *resolve_symlink(char *p, size_t s)
+static void resolve_symlink(struct strbuf *path)
 {
 	int depth =3D MAXDEPTH;
 	static struct strbuf link =3D STRBUF_INIT;
=20
 	while (depth--) {
-		if (strbuf_readlink(&link, p, strlen(p)) < 0)
+		if (strbuf_readlink(&link, path->buf, path->len) < 0)
 			break;
=20
-		if (is_absolute_path(link.buf)) {
+		if (is_absolute_path(link.buf))
 			/* absolute path simply replaces p */
-			if (link.len < s)
-				strcpy(p, link.buf);
-			else {
-				warning("%s: symlink too long", p);
-				break;
-			}
-		} else {
+			strbuf_reset(path);
+		else {
 			/*
 			 * link is a relative path, so replace the
 			 * last element of p with it.
 			 */
-			char *r =3D (char *)last_path_elm(p);
-			if (r - p + link.len < s)
-				strcpy(r, link.buf);
-			else {
-				warning("%s: symlink too long", p);
-				break;
-			}
+			char *r =3D last_path_elm(path->buf);
+			strbuf_setlen(path, r - path->buf);
 		}
+
+		strbuf_addbuf(path, &link);
 	}
 	strbuf_reset(&link);
-	return p;
 }
=20
 /* Make sure errno contains a meaningful value on error */
 static int lock_file(struct lock_file *lk, const char *path, int flags=
)
 {
+	size_t pathlen =3D strlen(path);
+
 	if (!lock_file_list) {
 		/* One-time initialization */
 		sigchain_push_common(remove_lock_file_on_signal);
@@ -192,7 +181,7 @@ static int lock_file(struct lock_file *lk, const ch=
ar *path, int flags)
 		lk->active =3D 0;
 		lk->owner =3D 0;
 		lk->on_list =3D 1;
-		strbuf_init(&lk->filename, PATH_MAX);
+		strbuf_init(&lk->filename, pathlen + LOCK_SUFFIX_LEN);
 		lk->next =3D lock_file_list;
 		lock_file_list =3D lk;
 	} else if (lk->filename.len) {
@@ -201,11 +190,9 @@ static int lock_file(struct lock_file *lk, const c=
har *path, int flags)
 		    path);
 	}
=20
-	strbuf_addstr(&lk->filename, path);
-	if (!(flags & LOCK_NODEREF)) {
-		resolve_symlink(lk->filename.buf, lk->filename.alloc);
-		strbuf_setlen(&lk->filename, strlen(lk->filename.buf));
-	}
+	strbuf_add(&lk->filename, path, pathlen);
+	if (!(flags & LOCK_NODEREF))
+		resolve_symlink(&lk->filename);
 	strbuf_addstr(&lk->filename, LOCK_SUFFIX);
 	lk->fd =3D open(lk->filename.buf, O_RDWR | O_CREAT | O_EXCL, 0666);
 	if (lk->fd < 0) {
--=20
2.1.0
