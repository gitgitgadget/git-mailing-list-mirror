From: tboegi@web.de
Subject: [PATCH v3 7/7] convert.c: simplify text_stat
Date: Fri,  5 Feb 2016 17:13:30 +0100
Message-ID: <1454688810-20949-1-git-send-email-tboegi@web.de>
References: <Message-Id=1453558101-6858-1-git-send-email-tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 05 17:12:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRizs-00029f-Tw
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 17:12:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755585AbcBEQM3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Feb 2016 11:12:29 -0500
Received: from mout.web.de ([212.227.17.12]:59302 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755579AbcBEQM1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2016 11:12:27 -0500
Received: from tor.lan ([195.252.60.88]) by smtp.web.de (mrweb102) with
 ESMTPSA (Nemesis) id 0LZvgf-1Zkze03D2L-00liNq; Fri, 05 Feb 2016 17:12:25
 +0100
X-Mailer: git-send-email 2.7.0.303.g2c4f448.dirty
In-Reply-To: <Message-Id=1453558101-6858-1-git-send-email-tboegi@web.de>
In-Reply-To: <Message-Id=1453558101-6858-1-git-send-email-tboegi@web.de>
References: <Message-Id=1453558101-6858-1-git-send-email-tboegi@web.de>
X-Provags-ID: V03:K0:vqRB3bH8i+1vlSm+wbsWlHyiUaDxWk7WAwgNcM+aJZix4F0Hdve
 9sK21nBE0kqXm7EcnaraJKmk0tYSKMrb26I6WYkp6DC4ZAbzHcM6D1SR5jTemFooHI5gpYr
 Po+pfnPoc5dFF+caDb6ws8J26826gLROCdzCg5+a5TZRJ+2BFr47Z2pSFFvUcSK1683lcIA
 rx+PUXaxfXqKIY0NrmGag==
X-UI-Out-Filterresults: notjunk:1;V01:K0:aNK2YDsFHdo=:P/llCzybKd7ogvxzlHkd88
 gBnIdfSCnzQp3Vx4h1l2t7YZ2Gd5RjHuqhOR9v1Qi3VcC2iNAwWDYr0kmaWfYbVCH1at7PmF+
 7uq800JVUkXRAKXcPPvGvZ9PDreiw2Aw+hhg3NxuceRpSa0Ulg4SJpxg/3TMm9KbMR4N/mO+x
 J8VjeswV6s4/c0i1Khi5tWB4gY4eE8zBxLhT7qEQ4xVTUBHLxfjVJWyYAw73xXm1HLj8FMu0m
 lwofhUcuLfiEX2O99S/fEILUJvp38YVOB4XofhgJ/NQEY0WxSbjILU4Rai++eexCoMvDod2nJ
 ODrLqRZ9gqSVgzFfw1jD6GTIgf/f4770ArLALPGBwA7ATjW6TS0+sG2xP6od61AHvswv6Po9r
 5ZI4BNiF1mLFWhbFT0H62qZW6pRMtxIGH3qB6WIR0Hbrt+hJnE/OCW7o9/HZce5PHK4vr91Cw
 Lun7l/cs7HnxFpBxZHyawCCoSyxZhzcIn4Y1ap+xeHznkDl3Ap85EJquhAHglHgcBNXP4aEwL
 WXL/cImh0v1PaPpmyEauBPYsq2Nkq37DZIqjMzJftgp+SglrP3DDNf19SeBXiviq10a+5cC7D
 C8clW7i2tIMgmvCXJwc4g/U9j7XgGDeNmhYII7g16whyYAsHzZKVfAeT8ndYohFGOYFMdKCTO
 d1QNkB5OgArBgq9gRUOT++6776C4AjWVZv3zbrcgLdxpw2ZBXLHvrMbOrT7/EHZA8XGiavDEt
 Q9yUb78nIP7iWEzjB6CUql6QlTSmR+9sZs+0qq9UE8hB6c/rZfNmARbstsw4lDDW/VTSFsfb 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285584>

=46rom: Torsten B=C3=B6gershausen <tboegi@web.de>

Simplify the statistics:
lonecr counts the CR which is not followed by a LF,
lonelf counts the LF which is not preceded by a CR,
crlf counts CRLF combinations.
This simplifies the evaluation of the statistics.

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 convert.c | 47 ++++++++++++++++++++++-------------------------
 1 file changed, 22 insertions(+), 25 deletions(-)

diff --git a/convert.c b/convert.c
index e4e2877..18af685 100644
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
 		return 0;
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
@@ -314,19 +315,15 @@ static int crlf_to_worktree(const char *path, con=
st char *src, size_t len,
=20
 	gather_stats(src, len, &stats);
=20
-	/* No LF? Nothing to convert, regardless. */
-	if (!stats.lf)
-		return 0;
-
-	/* Was it already in CRLF format? */
-	if (stats.lf =3D=3D stats.crlf)
+	/* No "naked" LF? Nothing to convert, regardless. */
+	if (!stats.lonelf)
 		return 0;
=20
 	if (crlf_action =3D=3D CRLF_AUTO || crlf_action =3D=3D CRLF_AUTO_INPU=
T || crlf_action =3D=3D CRLF_AUTO_CRLF) {
 		if (crlf_action =3D=3D CRLF_AUTO_INPUT || crlf_action =3D=3D CRLF_AU=
TO_CRLF) {
 			/* If we have any CR or CRLF line endings, we do not touch it */
 			/* This is the new safer autocrlf-handling */
-			if (stats.cr > 0 || stats.crlf > 0)
+			if (stats.lonecr || stats.crlf )
 				return 0;
 		}
=20
@@ -338,7 +335,7 @@ static int crlf_to_worktree(const char *path, const=
 char *src, size_t len,
 	if (src =3D=3D buf->buf)
 		to_free =3D strbuf_detach(buf, NULL);
=20
-	strbuf_grow(buf, len + stats.lf - stats.crlf);
+	strbuf_grow(buf, len + stats.lonelf);
 	for (;;) {
 		const char *nl =3D memchr(src, '\n', len);
 		if (!nl)
--=20
2.7.0.303.g2c4f448.dirty
