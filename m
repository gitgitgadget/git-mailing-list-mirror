From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v7 30/38] resolve_symlink(): take a strbuf parameter
Date: Wed,  1 Oct 2014 12:28:34 +0200
Message-ID: <1412159322-2622-31-git-send-email-mhagger@alum.mit.edu>
References: <1412159322-2622-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 01 12:29:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZHAN-0002nA-Gi
	for gcvg-git-2@plane.gmane.org; Wed, 01 Oct 2014 12:29:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751751AbaJAK3p convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Oct 2014 06:29:45 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:58239 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751548AbaJAK3l (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Oct 2014 06:29:41 -0400
X-AuditID: 1207440e-f79da6d0000002fc-d4-542bd795919e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 67.F9.00764.597DB245; Wed,  1 Oct 2014 06:29:41 -0400 (EDT)
Received: from michael.fritz.box (p5DDB1FCB.dip0.t-ipconnect.de [93.219.31.203])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s91ASk6T026827
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 1 Oct 2014 06:29:39 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1412159322-2622-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA01SfUgTcRjud3e68+Psdmr7NWXZKi1lVhiySCpQ6OjDkqygQHfOyw23U+5u
	piE0MiqnogVBrvzAhDLFyUBdn+j+KDJCU8vENBITNdQoDP9Ju3P48d/D8/E+vLwvjlLv/dS4
	mRNZnmMsWv9AjFKkbNfdG4pL3zffF6B3DJYhenvFIKqfqBlF9bPDjUA/8qQO1S/eKEf1S1XF
	+tLbC+AoTv+b/4XQz5yjCrrebaO/zzgU9GTFS0B/7N9B/3Fr6JHJDuwMfjEoKYsRC86ac7i9
	hw1BpjeeZiS/S1N4t2lBYQdTKgcIwCF5AA6OjSM+vAX2jbn8ZUyRAwB2u6ADBEr4LQKd400K
	WfAndbChvGQlEEZGwzs3vZhsQslHCKzyulfSoWQKbB/uQWWMkbtg1fNqPxkTEv/t9W/U16aB
	bS+WgYwDJP7xQAnma06Gnq8LiM+vhO+qJyQelwpioKuWkmmU3AZL2h+gVYB0bnA5113ODa56
	gD4FGsZis+qsjNkisEadYGQ4juV1CfFWsxjPZtvcwHeMEA+45Yr0AhIH2mAiyhCXTvkxBUKR
	1Qu24og2nGjol6iQrLzsIhMjmDJ5m4UVvADiqDaMyO2SNCKbKbrK8nmrUgSOaVVEdGNMKkXm
	MCKby7L5LL+qRuK4FhKbPktBJc/msIWXzRZxXUbwAHl4oDpMYLlslmdsoilTvmmmIB1VloKl
	3mQ5Tgj5jFVifdEeoMNbS/9WIhTG5XGsWkWYZRMpm0w2bq1i9QdngEraOJSIkF3B0oeuTZqR
	ShCpxNiyUiIy65LaDqAl3FR5aHTxRLx7j6I2pMHbUZE4nUEBh+FV7FwbFkk1j81d 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257715>

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
index cc9b9cb..5f5bcff 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -109,58 +109,47 @@ static char *last_path_elm(char *p)
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
@@ -175,7 +164,7 @@ static int lock_file(struct lock_file *lk, const ch=
ar *path, int flags)
 		lk->fd =3D -1;
 		lk->active =3D 0;
 		lk->owner =3D 0;
-		strbuf_init(&lk->filename, PATH_MAX);
+		strbuf_init(&lk->filename, pathlen + LOCK_SUFFIX_LEN);
 		lk->next =3D lock_file_list;
 		lock_file_list =3D lk;
 		lk->on_list =3D 1;
@@ -185,11 +174,9 @@ static int lock_file(struct lock_file *lk, const c=
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
