From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 09/11] refs.c: rewrite resolve_gitlink_ref() to use parse_ref()
Date: Wed, 15 Oct 2014 17:06:21 +0200
Message-ID: <1413385583-4872-10-git-send-email-mhagger@alum.mit.edu>
References: <1413385583-4872-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 15 17:06:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XeQAA-0002Oj-VA
	for gcvg-git-2@plane.gmane.org; Wed, 15 Oct 2014 17:06:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751845AbaJOPGt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Oct 2014 11:06:49 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:53747 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751824AbaJOPGs (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Oct 2014 11:06:48 -0400
X-AuditID: 1207440c-f79036d000002d32-62-543e8d83496a
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 88.FA.11570.38D8E345; Wed, 15 Oct 2014 11:06:44 -0400 (EDT)
Received: from michael.fritz.box (p4FC96250.dip0.t-ipconnect.de [79.201.98.80])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s9FF6SNb020034
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 15 Oct 2014 11:06:42 -0400
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1413385583-4872-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFKsWRmVeSWpSXmKPExsUixO6iqNvSaxdi0H+TxaLrSjeTRUPvFWaL
	2yvmM1t0T3nLaPFvQo3FmTeNjA5sHn/ff2Dy2DnrLrvHgk2lHhcvKXssfuDl8XmTXABbFLdN
	UmJJWXBmep6+XQJ3xsV7iQXnRCu6Hjxnb2CcKdjFyMkhIWAicfLdPzYIW0ziwr31QDYXh5DA
	ZUaJWy8fsEI4x5kkHiz4zQJSxSagK7Gop5kJJCEi0MAocejVQrAWZoFFjBLtq64wdzFycAgL
	BEm8O6EO0sAioCox/fxTdhCbV8BF4srJ24wQ6+Qk9k5eDTaUEyj+6+U2sLiQgLPEgqWTWSDq
	BSVOznzCAjKSWUBdYv08IZAws4C8RPPW2cwTGAVmIamahVA1C0nVAkbmVYxyiTmlubq5iZk5
	xanJusXJiXl5qUW6hnq5mSV6qSmlmxgh4c6zg/HbOplDjAIcjEo8vBv22oYIsSaWFVfmHmKU
	5GBSEuVd0GMXIsSXlJ9SmZFYnBFfVJqTWnyIUYKDWUmEd34CUI43JbGyKrUoHyYlzcGiJM6r
	ukTdT0ggPbEkNTs1tSC1CCYrw8GhJMFbCzJUsCg1PbUiLTOnBCHNxMEJMpxLSqQ4NS8ltSix
	tCQjHhSn8cXASAVJ8QDtbQJp5y0uSMwFikK0nmJUlBLnzQJJCIAkMkrz4MbCktgrRnGgL4V5
	e0CqeIAJEK77FdBgJqDBE0NtQQaXJCKkpBoYi47Pf3DLWuXuTGb+u7u6VouFJfy3E/7h4D5r
	1Y5dC//Of6izWGVhxFSzTWprkjz8Tr9nPd34mN/Y6i/HOWlxtWOOS+o2npo+8UTs 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>

resolve_gitlink_ref_recursive() did about the same thing as
parse_ref(), but didn't know as many tricks. It also had another
random limit of 128 bytes for symrefs. So base resolve_gitlink_ref()
on parse_ref() instead.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 69 ++++++++++++++++++++++++++--------------------------------=
--------
 1 file changed, 27 insertions(+), 42 deletions(-)

diff --git a/refs.c b/refs.c
index e1aa6a4..a7c8abd 100644
--- a/refs.c
+++ b/refs.c
@@ -1299,48 +1299,11 @@ static int resolve_gitlink_packed_ref(struct re=
f_cache *refs,
 	return 0;
 }
=20
-static int resolve_gitlink_ref_recursive(struct ref_cache *refs,
-					 const char *refname, unsigned char *sha1,
-					 int recursion)
-{
-	int fd, len;
-	char buffer[128], *p;
-	char *path;
-
-	if (recursion > MAXDEPTH)
-		return -1;
-	path =3D *refs->name
-		? git_path_submodule(refs->name, "%s", refname)
-		: git_path("%s", refname);
-	fd =3D open(path, O_RDONLY);
-	if (fd < 0)
-		return resolve_gitlink_packed_ref(refs, refname, sha1);
-
-	len =3D read(fd, buffer, sizeof(buffer)-1);
-	close(fd);
-	if (len < 0)
-		return -1;
-	while (len && isspace(buffer[len-1]))
-		len--;
-	buffer[len] =3D 0;
-
-	/* Was it a detached head or an old-fashioned symlink? */
-	if (!get_sha1_hex(buffer, sha1))
-		return 0;
-
-	/* Symref? */
-	if (strncmp(buffer, "ref:", 4))
-		return -1;
-	p =3D buffer + 4;
-	while (isspace(*p))
-		p++;
-
-	return resolve_gitlink_ref_recursive(refs, p, sha1, recursion+1);
-}
-
 int resolve_gitlink_ref(const char *path, const char *refname, unsigne=
d char *sha1)
 {
-	int len =3D strlen(path), retval;
+	struct strbuf result =3D STRBUF_INIT;
+	int len =3D strlen(path), parseval, ret;
+	int depth =3D MAXDEPTH;
 	char *submodule;
 	struct ref_cache *refs;
=20
@@ -1352,8 +1315,30 @@ int resolve_gitlink_ref(const char *path, const =
char *refname, unsigned char *sh
 	refs =3D get_ref_cache(submodule);
 	free(submodule);
=20
-	retval =3D resolve_gitlink_ref_recursive(refs, refname, sha1, 0);
-	return retval;
+	strbuf_addstr(&result, refname);
+	do {
+		if (--depth < 0) {
+			errno =3D ELOOP;
+			ret =3D -1;
+			goto out;
+		}
+		path =3D *refs->name
+			? git_path_submodule(refs->name, "%s", result.buf)
+			: git_path("%s", result.buf);
+		parseval =3D parse_ref(path, &result, sha1, NULL);
+	} while (!parseval);
+
+	if (parseval =3D=3D 1) {
+		ret =3D 0;
+	} else if (parseval =3D=3D -2) {
+		ret =3D resolve_gitlink_packed_ref(refs, result.buf, sha1) ? -1 : 0;
+	} else {
+		ret =3D -1;
+	}
+
+out:
+	strbuf_release(&result);
+	return ret;
 }
=20
 /*
--=20
2.1.1
