From: tboegi@web.de
Subject: [PATCH v2 7/7] convert.c: simplify text_stat
Date: Thu,  4 Feb 2016 18:50:00 +0100
Message-ID: <1454608200-5535-1-git-send-email-tboegi@web.de>
References: <Message-Id=1453558101-6858-1-git-send-email-tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 04 18:49:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRO1n-0001Qh-UN
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 18:49:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758066AbcBDRtI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Feb 2016 12:49:08 -0500
Received: from mout.web.de ([212.227.17.11]:49846 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758005AbcBDRtA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2016 12:49:00 -0500
Received: from tor.lan ([195.252.60.88]) by smtp.web.de (mrweb103) with
 ESMTPSA (Nemesis) id 0MfqEy-1afleQ2mqC-00NEZ1; Thu, 04 Feb 2016 18:48:58
 +0100
X-Mailer: git-send-email 2.7.0.303.g2c4f448.dirty
In-Reply-To: <Message-Id=1453558101-6858-1-git-send-email-tboegi@web.de>
In-Reply-To: <Message-Id=1453558101-6858-1-git-send-email-tboegi@web.de>
References: <Message-Id=1453558101-6858-1-git-send-email-tboegi@web.de>
X-Provags-ID: V03:K0:lp7QT47O/mJ0pup1GdJcranloB091Rc+DzhCLtvvdVJd04cBZxv
 Q5ST5fGYvNvAYz54y9WZjG7wlU+A3AvX6ZISDPPkSzmqiaDtzwieyD7fAcTp6IYFkXCV2mu
 MYXLL/5iCunRzoIKSAZIUYXRx8T32kAjZP84NLs94Okj7iayd0RuZKUH3Iozq1MBGJZsAlc
 CslPrS0AKIZDeQPJmneSQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:dTKVCoRkMUc=:qRdXuzsjhdvV13/XfgTiWQ
 IPajbFnqSctOMbM4abpZJTKIhyG8OVvVlu/LuAnSIV3s9WrwTb2OgqVBXogqMcxyySbgReluc
 4wch4y5+Z+qThVLcCXKszDWXTGnSNSQAnzx0sRinycIKYwMABDNg8WBNdS6hqp/TwA9ZtnH+A
 aYFl0KmWkrcs/h4gHGnoGZA+hlFs6tGfZkV3cuvc4f1ce5BqvzFlgGhsv9EADHHOO8N13CPtg
 ORor3FopCD8cTBTtkYnsgoyYUdgphaVeyytHBf+Fv0u8xhd0BL0gvUUht4G6ldjIMmbl1hbHI
 fM5HpmsBGgHN/LrrasCoF69NkwOlH2oo5Ftuh+c8kRWdaX1sF1H9CA+lc9r/pkzJIM3NOfWSo
 7mGZFjZ0Cd76FXUBsCOJg2OjFuf4/66A8C3IIuHS8UM4KH4Zu7MGqnVhp6ENjSrQxE1TRJtR6
 oULkBkRbqXBqlaIbvvYihritwGWSV16/1oEltuAzf9mLKIWiSMQ1tR7quLe8Y7rynxRe5GeBx
 JGQlqvNSzifyYI/VR9U4HfzeER4rGmx/S9Ypp+SswpI2XI/palS8Bw/DIZlTAK1LcIZLRdGRr
 rIr7UlO9fhpMta+BltRDKAk2y/6CVT5i6cDe8BW10LGUPlySq4zlz16ruNCYWzJ68ltyCDnBV
 qcR72Q4VJSzAKnHA+CFj/rEP1eBG8LqciDPdC7IU5g4UER3NOBs1U5G1BU6d8BkKW/np0qf2x
 DtU7z0JYOLZ41DRfbmG0Dk4xEFV9V/4ipF1/H7Fzfev0VbEa5FFPyx1o9AZDH02yn7LgK0b6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285476>

=46rom: Torsten B=C3=B6gershausen <tboegi@web.de>

Simplify the statistics:
lonecr counts the CR which is not followed by a LF,
lonelf counts the LF which is not preceded by a CR,
crlf counts CRLF combinations.
This simplifies the evaluation of the statistics.

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 convert.c | 58 +++++++++++++++++++++++++++----------------------------=
---
 1 file changed, 27 insertions(+), 31 deletions(-)

diff --git a/convert.c b/convert.c
index dd9646a..ebf4d0e 100644
--- a/convert.c
+++ b/convert.c
@@ -31,7 +31,7 @@ enum crlf_action {
=20
 struct text_stat {
 	/* NUL, CR, LF and CRLF counts */
-	unsigned nul, cr, lf, crlf;
+	unsigned nul, lonecr, lonelf, crlf;
=20
 	/* These are just approximations! */
 	unsigned printable, nonprintable;
@@ -46,13 +46,15 @@ static void gather_stats(const char *buf, unsigned =
long size, struct text_stat *
 	for (i =3D 0; i < size; i++) {
 		unsigned char c =3D buf[i];
 		if (c =3D=3D '\r') {
-			stats->cr++;
-			if (i+1 < size && buf[i+1] =3D=3D '\n')
+			if (i+1 < size && buf[i+1] =3D=3D '\n') {
 				stats->crlf++;
+				i++;
+			} else
+				stats->lonecr++;
 			continue;
 		}
 		if (c =3D=3D '\n') {
-			stats->lf++;
+			stats->lonelf++;
 			continue;
 		}
 		if (c =3D=3D 127)
@@ -86,7 +88,7 @@ static void gather_stats(const char *buf, unsigned lo=
ng size, struct text_stat *
  */
 static int convert_is_binary(unsigned long size, const struct text_sta=
t *stats)
 {
-	if (stats->cr !=3D stats->crlf)
+	if (stats->lonecr)
 		return 1;
 	if (stats->nul)
 		return 1;
@@ -98,19 +100,18 @@ static int convert_is_binary(unsigned long size, c=
onst struct text_stat *stats)
 static unsigned int gather_convert_stats(const char *data, unsigned lo=
ng size)
 {
 	struct text_stat stats;
+	int ret =3D 0;
 	if (!data || !size)
-		return 0;
+		return ret;
 	gather_stats(data, size, &stats);
 	if (convert_is_binary(size, &stats))
-		return CONVERT_STAT_BITS_BIN;
-	else if (stats.crlf && stats.crlf =3D=3D stats.lf)
-		return CONVERT_STAT_BITS_TXT_CRLF;
-	else if (stats.crlf && stats.lf)
-		return CONVERT_STAT_BITS_TXT_CRLF | CONVERT_STAT_BITS_TXT_LF;
-	else if (stats.lf)
-		return CONVERT_STAT_BITS_TXT_LF;
-	else
-		return 0;
+		ret |=3D CONVERT_STAT_BITS_BIN;
+	if (stats.crlf)
+		ret |=3D CONVERT_STAT_BITS_TXT_CRLF;
+	if (stats.lonelf)
+		ret |=3D  CONVERT_STAT_BITS_TXT_LF;
+
+	return ret;
 }
=20
 static const char *gather_convert_stats_ascii(const char *data, unsign=
ed long size)
@@ -207,7 +208,7 @@ static void check_safe_crlf(const char *path, enum =
crlf_action crlf_action,
 		 * CRLFs would be added by checkout:
 		 * check if we have "naked" LFs
 		 */
-		if (stats->lf !=3D stats->crlf) {
+		if (stats->lonelf) {
 			if (checksafe =3D=3D SAFE_CRLF_WARN)
 				warning("LF will be replaced by CRLF in %s.\nThe file will have it=
s original line endings in your working directory.", path);
 			else /* i.e. SAFE_CRLF_FAIL */
@@ -266,8 +267,8 @@ static int crlf_to_git(const char *path, const char=
 *src, size_t len,
=20
 	check_safe_crlf(path, crlf_action, &stats, checksafe);
=20
-	/* Optimization: No CR? Nothing to convert, regardless. */
-	if (!stats.cr)
+	/* Optimization: No CRLF? Nothing to convert, regardless. */
+	if (!stats.crlf)
 		return 0;
=20
 	/*
@@ -315,21 +316,16 @@ static int crlf_to_worktree(const char *path, con=
st char *src, size_t len,
 	gather_stats(src, len, &stats);
=20
 	/* No LF? Nothing to convert, regardless. */
-	if (!stats.lf)
-		return 0;
-
-	/* Was it already in CRLF format? */
-	if (stats.lf =3D=3D stats.crlf)
+	if (!stats.lonelf)
 		return 0;
=20
+	if (crlf_action =3D=3D CRLF_AUTO_INPUT || crlf_action =3D=3D CRLF_AUT=
O_CRLF) {
+		/* If we have any CRLF line endings, we do not touch it */
+		/* This is the new safer autocrlf-handling */
+		if (stats.crlf)
+			return 0;
+	}
 	if (crlf_action =3D=3D CRLF_AUTO || crlf_action =3D=3D CRLF_AUTO_INPU=
T || crlf_action =3D=3D CRLF_AUTO_CRLF) {
-		if (crlf_action =3D=3D CRLF_AUTO_INPUT || crlf_action =3D=3D CRLF_AU=
TO_CRLF) {
-			/* If we have any CR or CRLF line endings, we do not touch it */
-			/* This is the new safer autocrlf-handling */
-			if (stats.cr > 0 || stats.crlf > 0)
-				return 0;
-		}
-
 		if (convert_is_binary(len, &stats))
 			return 0;
 	}
@@ -338,7 +334,7 @@ static int crlf_to_worktree(const char *path, const=
 char *src, size_t len,
 	if (src =3D=3D buf->buf)
 		to_free =3D strbuf_detach(buf, NULL);
=20
-	strbuf_grow(buf, len + stats.lf - stats.crlf);
+	strbuf_grow(buf, len + stats.crlf);
 	for (;;) {
 		const char *nl =3D memchr(src, '\n', len);
 		if (!nl)
--=20
2.7.0.303.g2c4f448.dirty
