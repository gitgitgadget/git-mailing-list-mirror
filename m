From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v3 2/2] merge-file: ensure that conflict sections match eol
 style
Date: Mon, 25 Jan 2016 09:07:11 +0100 (CET)
Message-ID: <4bae6450eb64461584a9acdefc9a3226c95ef357.1453709205.git.johannes.schindelin@gmx.de>
References: <cover.1453632296.git.johannes.schindelin@gmx.de> <cover.1453709205.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Beat Bolli <dev+git@drbeat.li>,
	Jeff King <peff@peff.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?ISO-8859-15?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 25 09:07:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNcBM-0000YC-W6
	for gcvg-git-2@plane.gmane.org; Mon, 25 Jan 2016 09:07:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755178AbcAYIHY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jan 2016 03:07:24 -0500
Received: from mout.gmx.net ([212.227.17.22]:63909 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753303AbcAYIHW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jan 2016 03:07:22 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0LsgvV-1Zyyc71d5V-012L5G; Mon, 25 Jan 2016 09:07:14
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1453709205.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:1g+LdPuicnb7+JcyvzwQnQ1VLg9f9GIevIqoU8cLWZmqyseLrVA
 cq5Nu1/Kmki/Q4PYDWkikGDw9jyyxCO5Yk1LAroY/cae4BeocMxH1g6nFKpd/o4D6xmeVt2
 I9SQw0x/cUEI4lFavQcolXbkjh7T4tsaimZ/+u/BQrMGxG0YnETg0Ng2AMYpSfshxzj7fsA
 lrMwxrTn8B6/RwRBVq2Eg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:2roiSCqaUYQ=:SaMALuoM3Idk1Edy2MPoqQ
 snAUx9HNGz26Evq9j29NeQmi2WLLnb1Ky1XVlL7ecxyUShtQj3Ipry5mBLvkWXNmafZORuWOQ
 BpMy3g//kUxwcvTeox5ccorIRfv5TMlf4Wgfzvnkl1L53r1QdYNRyMmUUQSwtHknqnJ4JTVbS
 6q8tt++M0lo11CV11VRm9U8EpyLkMGH+OjkcOECEAT22xqXc+zlL8Fp+sYKvrJ6ykyBd095kd
 zUBZiYNCQYLeCwBqY3OBcJd6wOINJNNZSgjibmwdyvMPXMe34pP2TPLYD+4hosMbnkYq1aI2S
 RxyURtCbSY98lqBKVTp/PsRMgLBm4mwa8Gq4trVVgNWR1829Hl2VTNAs6s8FwxUIh8HAL9ymP
 5YhFo8wImjZdcyARLzyfAQgvKzSFXgOoKFymFPnuDsJX5tHwvBrzGQJNSYgEoV8nsHxkj3f97
 KAejBR9r/Is3KtPIaa18DKcj/StfvEbaMh3ls+UHZWpc81R8T2VBUEOZ8gAkJt8MZMZAJaNG1
 HKSAWoJZPOS/U0dDhfBff4V8KRNULF+1Js2qVKPGpXJ5eB2voJTmDXK++ILmRAH9ySRWAMxgw
 IOCyX1Ql9vNz+QfTTVfFe4FgWzwS19MOFLQh9p0kqPtjJGhgreavoiFuOgdxrQltiuSytfOly
 2ywV+TezdYtrf4apLytoMa4QVED+p3v6JV023Pnkj1v7YsbMl4UgXQILIudZ9gSdU0qgtEvV0
 lJQbwscwcNkJxfEmRUwJavjFqtR+k9k/OXqGhD/JDF5rH2413c69PyBc9U8RvnkRHfYE0nie 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284725>

In the previous patch, we made sure that the conflict markers themselves
match the end-of-line style of the input files. However, this still left
out the conflicting text itself: if it lacks a trailing newline, we
add one, and should add a carriage return when appropriate, too.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t6023-merge-file.sh |  3 ++-
 xdiff/xmerge.c        | 61 +++++++++++++++++++++++++++++++--------------------
 2 files changed, 39 insertions(+), 25 deletions(-)

diff --git a/t/t6023-merge-file.sh b/t/t6023-merge-file.sh
index bb20cbc..1390548 100755
--- a/t/t6023-merge-file.sh
+++ b/t/t6023-merge-file.sh
@@ -346,13 +346,14 @@ test_expect_success 'conflict at EOF without LF resolved by --union' \
 	 printf "line1\nline2\nline3x\nline3y" >expect.txt &&
 	 test_cmp expect.txt output.txt'
 
-test_expect_success 'conflict markers match existing line endings' '
+test_expect_success 'conflict sections match existing line endings' '
 	printf "1\\r\\n2\\r\\n3" >crlf-orig.txt &&
 	printf "1\\r\\n2\\r\\n4" >crlf-diff1.txt &&
 	printf "1\\r\\n2\\r\\n5" >crlf-diff2.txt &&
 	test_must_fail git -c core.eol=crlf merge-file -p \
 		crlf-diff1.txt crlf-orig.txt crlf-diff2.txt >crlf.txt &&
 	test $(tr "\015" Q <crlf.txt | grep "\\.txtQ$" | wc -l) = 3 &&
+	test $(tr "\015" Q <crlf.txt | grep "[345]Q$" | wc -l) = 3 &&
 	test_must_fail git -c core.eol=crlf merge-file -p \
 		nolf-diff1.txt nolf-orig.txt nolf-diff2.txt >nolf.txt &&
 	test $(tr "\015" Q <nolf.txt | grep "\\.txtQ$" | wc -l) = 0
diff --git a/xdiff/xmerge.c b/xdiff/xmerge.c
index c852acc..d98f430 100644
--- a/xdiff/xmerge.c
+++ b/xdiff/xmerge.c
@@ -109,7 +109,7 @@ static int xdl_merge_cmp_lines(xdfenv_t *xe1, int i1, xdfenv_t *xe2, int i2,
 	return 0;
 }
 
-static int xdl_recs_copy_0(int use_orig, xdfenv_t *xe, int i, int count, int add_nl, char *dest)
+static int xdl_recs_copy_0(int use_orig, xdfenv_t *xe, int i, int count, int needs_cr, int add_nl, char *dest)
 {
 	xrecord_t **recs;
 	int size = 0;
@@ -125,6 +125,12 @@ static int xdl_recs_copy_0(int use_orig, xdfenv_t *xe, int i, int count, int add
 	if (add_nl) {
 		i = recs[count - 1]->size;
 		if (i == 0 || recs[count - 1]->ptr[i - 1] != '\n') {
+			if (needs_cr) {
+				if (dest)
+					dest[size] = '\r';
+				size++;
+			}
+
 			if (dest)
 				dest[size] = '\n';
 			size++;
@@ -133,14 +139,14 @@ static int xdl_recs_copy_0(int use_orig, xdfenv_t *xe, int i, int count, int add
 	return size;
 }
 
-static int xdl_recs_copy(xdfenv_t *xe, int i, int count, int add_nl, char *dest)
+static int xdl_recs_copy(xdfenv_t *xe, int i, int count, int needs_cr, int add_nl, char *dest)
 {
-	return xdl_recs_copy_0(0, xe, i, count, add_nl, dest);
+	return xdl_recs_copy_0(0, xe, i, count, needs_cr, add_nl, dest);
 }
 
-static int xdl_orig_copy(xdfenv_t *xe, int i, int count, int add_nl, char *dest)
+static int xdl_orig_copy(xdfenv_t *xe, int i, int count, int needs_cr, int add_nl, char *dest)
 {
-	return xdl_recs_copy_0(1, xe, i, count, add_nl, dest);
+	return xdl_recs_copy_0(1, xe, i, count, needs_cr, add_nl, dest);
 }
 
 /*
@@ -172,15 +178,8 @@ static int is_eol_crlf(xdfile_t *file, int i)
 		file->recs[i - 1]->ptr[size - 2] == '\r';
 }
 
-static int fill_conflict_hunk(xdfenv_t *xe1, const char *name1,
-			      xdfenv_t *xe2, const char *name2,
-			      const char *name3,
-			      int size, int i, int style,
-			      xdmerge_t *m, char *dest, int marker_size)
+static int is_cr_needed(xdfenv_t *xe1, xdfenv_t *xe2, xdmerge_t *m)
 {
-	int marker1_size = (name1 ? strlen(name1) + 1 : 0);
-	int marker2_size = (name2 ? strlen(name2) + 1 : 0);
-	int marker3_size = (name3 ? strlen(name3) + 1 : 0);
 	int needs_cr;
 
 	/* Match post-images' preceding, or first, lines' end-of-line style */
@@ -191,14 +190,25 @@ static int fill_conflict_hunk(xdfenv_t *xe1, const char *name1,
 	if (needs_cr)
 		needs_cr = is_eol_crlf(&xe1->xdf1, 0);
 	/* If still undecided, use LF-only */
-	if (needs_cr < 0)
-		needs_cr = 0;
+	return needs_cr < 0 ? 0 : needs_cr;
+}
+
+static int fill_conflict_hunk(xdfenv_t *xe1, const char *name1,
+			      xdfenv_t *xe2, const char *name2,
+			      const char *name3,
+			      int size, int i, int style,
+			      xdmerge_t *m, char *dest, int marker_size)
+{
+	int marker1_size = (name1 ? strlen(name1) + 1 : 0);
+	int marker2_size = (name2 ? strlen(name2) + 1 : 0);
+	int marker3_size = (name3 ? strlen(name3) + 1 : 0);
+	int needs_cr = is_cr_needed(xe1, xe2, m);
 
 	if (marker_size <= 0)
 		marker_size = DEFAULT_CONFLICT_MARKER_SIZE;
 
 	/* Before conflicting part */
-	size += xdl_recs_copy(xe1, i, m->i1 - i, 0,
+	size += xdl_recs_copy(xe1, i, m->i1 - i, 0, 0,
 			      dest ? dest + size : NULL);
 
 	if (!dest) {
@@ -217,7 +227,7 @@ static int fill_conflict_hunk(xdfenv_t *xe1, const char *name1,
 	}
 
 	/* Postimage from side #1 */
-	size += xdl_recs_copy(xe1, m->i1, m->chg1, 1,
+	size += xdl_recs_copy(xe1, m->i1, m->chg1, needs_cr, 1,
 			      dest ? dest + size : NULL);
 
 	if (style == XDL_MERGE_DIFF3) {
@@ -236,7 +246,7 @@ static int fill_conflict_hunk(xdfenv_t *xe1, const char *name1,
 				dest[size++] = '\r';
 			dest[size++] = '\n';
 		}
-		size += xdl_orig_copy(xe1, m->i0, m->chg0, 1,
+		size += xdl_orig_copy(xe1, m->i0, m->chg0, needs_cr, 1,
 				      dest ? dest + size : NULL);
 	}
 
@@ -251,7 +261,7 @@ static int fill_conflict_hunk(xdfenv_t *xe1, const char *name1,
 	}
 
 	/* Postimage from side #2 */
-	size += xdl_recs_copy(xe2, m->i2, m->chg2, 1,
+	size += xdl_recs_copy(xe2, m->i2, m->chg2, needs_cr, 1,
 			      dest ? dest + size : NULL);
 	if (!dest) {
 		size += marker_size + 1 + needs_cr + marker2_size;
@@ -290,21 +300,24 @@ static int xdl_fill_merge_buffer(xdfenv_t *xe1, const char *name1,
 						  marker_size);
 		else if (m->mode & 3) {
 			/* Before conflicting part */
-			size += xdl_recs_copy(xe1, i, m->i1 - i, 0,
+			size += xdl_recs_copy(xe1, i, m->i1 - i, 0, 0,
 					      dest ? dest + size : NULL);
 			/* Postimage from side #1 */
-			if (m->mode & 1)
-				size += xdl_recs_copy(xe1, m->i1, m->chg1, (m->mode & 2),
+			if (m->mode & 1) {
+				int needs_cr = is_cr_needed(xe1, xe2, m);
+
+				size += xdl_recs_copy(xe1, m->i1, m->chg1, needs_cr, (m->mode & 2),
 						      dest ? dest + size : NULL);
+			}
 			/* Postimage from side #2 */
 			if (m->mode & 2)
-				size += xdl_recs_copy(xe2, m->i2, m->chg2, 0,
+				size += xdl_recs_copy(xe2, m->i2, m->chg2, 0, 0,
 						      dest ? dest + size : NULL);
 		} else
 			continue;
 		i = m->i1 + m->chg1;
 	}
-	size += xdl_recs_copy(xe1, i, xe1->xdf2.nrec - i, 0,
+	size += xdl_recs_copy(xe1, i, xe1->xdf2.nrec - i, 0, 0,
 			      dest ? dest + size : NULL);
 	return size;
 }
-- 
2.7.0.windows.1.7.g55a05c8
