From: tboegi@web.de
Subject: [PATCH/RFC v1 1/1] No duplicate CRLF rewrite warnings on commit
Date: Sun, 15 May 2016 08:08:23 +0200
Message-ID: <1463292503-12559-1-git-send-email-tboegi@web.de>
References: <20160513134953.GE2345@dinwoodie.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: adam@dinwoodie.org,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 15 08:03:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1p90-00046i-MN
	for gcvg-git-2@plane.gmane.org; Sun, 15 May 2016 08:03:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752074AbcEOGDG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 May 2016 02:03:06 -0400
Received: from mout.web.de ([212.227.15.14]:63686 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750988AbcEOGDF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2016 02:03:05 -0400
Received: from tor.lan ([195.252.60.88]) by smtp.web.de (mrweb001) with
 ESMTPSA (Nemesis) id 0LwZA7-1bfNuM03jD-018KY8; Sun, 15 May 2016 08:03:01
 +0200
X-Mailer: git-send-email 2.0.0.rc1.6318.g0c2c796
In-Reply-To: <20160513134953.GE2345@dinwoodie.org>
X-Provags-ID: V03:K0:EG2YZ8C9KeJkIN2oBDE3tRv8meu38b3+Iga7dLCzJMx4Bob9WHH
 l06+0J2w3FyqZ3+2TDxr5kQcGVlbk+5DIFN/LQ5+SGEvSauj03gvSAMGV8rKe6IgN4d/6tM
 hEgQ2FRTgbnBpEUUsY0txli9tu7YfI9G3sydNV8pGyircb7/r5nzWGgVS719jWSdBVNwV/a
 B9TjOEoLR2xe1KD6NCi/g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:mYs47O+FWpM=:ZjpG6L/2sDd+GJMGOdXzcE
 JXDYpG38XnVJiFHcbGMq/bbnPPROyXuXbCTDX6okweJRct0YyE/pQS84pvb1RqFATQudbi+Kg
 9t24+z1WZl8ZVL6EtzMMlNbmTTLdhBBE9brju+AHqwl2MYzmosmlhNI+8DZdzWi9k7nH1zOXd
 LsosQrdBrTbfa7xuTx54i0CHx26YzF+DIdxC9Z/DO5fMdT6OoaOH5k6M9D8CPmhzTjCpdzzTD
 zz+vTGkSlCrOAg+CBiR7F0nt/ps2V/0rwIPXGRWkex9YVPeweLPKCiKIkWPmU69c8ynH/GjGE
 HNQJFw0les2boWeM1Mugtl+H3gHumdWDB4QxX+fMDa31GDQQ6gmUt7OjD6FL+XRpxXSPewns7
 sMS4iOagtjhwRMl4K8nQHSL+8If3l/np4pd4gT+MhvWb8kEibkkOugNOq8ESYTqX1d2F5hWIK
 Go/GOiWVq6iN2EPyl9uWskaD1n/eCzNK/D3JH9VyPOvdFtSyy5xSQrs4YaL6WiQAaFsUo0+5f
 2ndc0fEKf6UMOT7CoQndUgIkYzXLJvd5lMOOssa9afkM9hkyUV1p3c9660bvbCqd3ae8gRmmj
 bwsglSZ4DEdlM159VKPe/E2yQ4lC+DxQFpgHaN+StWuH6pofeExC+UOajRakjgwptcK1DR1IO
 BCqxtlzRGyR7mNwXUu7z/R78gVPL3MxsoQCBB7lRLUu9wo7MBBsceolFfIbpiqQX+x1R61riM
 7J2MtN595DF8QLx3cXvF71dUme10cYxCMfDOhgRs8qXOR3lHQSg56vvoY5oUzH8wCnXR0+BK 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294634>

=46rom: Torsten B=C3=B6gershausen <tboegi@web.de>

If .gitattributes are used to enable CRLF->LF rewriting,
then commiting a file that would have its line endings rewritten,
the "CRLF will be replaced by LF" warning is printed 2 times.
A user expects it to be printed only once.
The automatic rename detection by Git runs the conversion twice,
suppress the warning in the second run.

Reported-By: Adam Dinwoodie <adam@dinwoodie.org>
Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 diff.c           |  2 ++
 diffcore-break.c |  6 ++++--
 diffcore.h       |  1 +
 t/t0020-crlf.sh  | 14 ++++++++++++++
 4 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index d3734d3..c965afc 100644
--- a/diff.c
+++ b/diff.c
@@ -2749,6 +2749,8 @@ int diff_populate_filespec(struct diff_filespec *=
s, unsigned int flags)
 	enum safe_crlf crlf_warn =3D (safe_crlf =3D=3D SAFE_CRLF_FAIL
 				    ? SAFE_CRLF_WARN
 				    : safe_crlf);
+	if (flags & CHECK_IGNORE_CRLF_WARNING)
+		crlf_warn =3D SAFE_CRLF_FALSE;
=20
 	if (!DIFF_FILE_VALID(s))
 		die("internal error: asking to populate invalid file.");
diff --git a/diffcore-break.c b/diffcore-break.c
index 5473493..4a75681 100644
--- a/diffcore-break.c
+++ b/diffcore-break.c
@@ -47,6 +47,7 @@ static int should_break(struct diff_filespec *src,
 	 */
 	unsigned long delta_size, max_size;
 	unsigned long src_copied, literal_added, src_removed;
+	unsigned flags2 =3D 0;
=20
 	*merge_score_p =3D 0; /* assume no deletion --- "do not break"
 			     * is the default.
@@ -61,9 +62,10 @@ static int should_break(struct diff_filespec *src,
 	    !hashcmp(src->sha1, dst->sha1))
 		return 0; /* they are the same */
=20
-	if (diff_populate_filespec(src, 0) || diff_populate_filespec(dst, 0))
+	if (!strcmp(src->path, dst->path))
+		flags2 =3D CHECK_IGNORE_CRLF_WARNING;
+	if (diff_populate_filespec(src, 0) || diff_populate_filespec(dst, fla=
gs2))
 		return 0; /* error but caught downstream */
-
 	max_size =3D ((src->size > dst->size) ? src->size : dst->size);
 	if (max_size < MINIMUM_BREAK_SIZE)
 		return 0; /* we do not break too small filepair */
diff --git a/diffcore.h b/diffcore.h
index 33ea2de..91464aa 100644
--- a/diffcore.h
+++ b/diffcore.h
@@ -57,6 +57,7 @@ extern void fill_filespec(struct diff_filespec *, con=
st unsigned char *,
=20
 #define CHECK_SIZE_ONLY 1
 #define CHECK_BINARY    2
+#define CHECK_IGNORE_CRLF_WARNING    4
 extern int diff_populate_filespec(struct diff_filespec *, unsigned int=
);
 extern void diff_free_filespec_data(struct diff_filespec *);
 extern void diff_free_filespec_blob(struct diff_filespec *);
diff --git a/t/t0020-crlf.sh b/t/t0020-crlf.sh
index f94120a..f7d2f74 100755
--- a/t/t0020-crlf.sh
+++ b/t/t0020-crlf.sh
@@ -86,6 +86,20 @@ test_expect_success 'safecrlf: print warning only on=
ce' '
 	test $(git add doublewarn 2>&1 | grep "CRLF will be replaced by LF" |=
 wc -l) =3D 1
 '
=20
+test_expect_success 'safecrlf: print warning only once on commit' '
+
+	git config core.autocrlf input &&
+	git config core.safecrlf warn &&
+
+	for w in I am all LF; do echo $w; done >doublewarn2 &&
+	git add doublewarn2 &&
+	git commit -m "nowarn" &&
+	for w in Oh here is CRLFQ in text; do echo $w; done | q_to_cr >double=
warn2 &&
+	git add doublewarn2 2>&1 &&
+	git commit -m Message 2>&1 | grep "CRLF will be replaced by LF" >actu=
al &&
+	echo "warning: CRLF will be replaced by LF in doublewarn2." >expected=
 &&
+	test_cmp expected actual
+'
=20
 test_expect_success 'safecrlf: git diff demotes safecrlf=3Dtrue to war=
n' '
 	git config core.autocrlf input &&
--=20
2.0.0.rc1.6318.g0c2c796
