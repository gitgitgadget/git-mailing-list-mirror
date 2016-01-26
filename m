From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v4 2/2] merge-file: ensure that conflict sections match eol
 style
Date: Tue, 26 Jan 2016 15:42:18 +0100 (CET)
Message-ID: <fc0bbc768ce5cd868b686fcc6c22519c04a189a8.1453819314.git.johannes.schindelin@gmx.de>
References: <cover.1453709205.git.johannes.schindelin@gmx.de> <cover.1453819314.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Beat Bolli <dev+git@drbeat.li>,
	Jeff King <peff@peff.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?ISO-8859-15?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 26 15:42:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aO4pN-0008My-Ll
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jan 2016 15:42:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966299AbcAZOmf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2016 09:42:35 -0500
Received: from mout.gmx.net ([212.227.15.15]:60173 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966078AbcAZOm3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2016 09:42:29 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MTCDO-1aVKLS2EkQ-00SAnD; Tue, 26 Jan 2016 15:42:20
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1453819314.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:YbqU4+ZnHnLmbz0YH7FpwQhUtTVTX2meYjSSpDME+0PckUMIBTn
 iFH4+s/4ojc6UQraDFzxcN9Jp3WhdctjvNVXqsn5TJ/tjcbJUKTltNu1B+COg7t0AxjARqP
 PzWyq18M9U/OhgdGdXw5xBi7thlS5BGivG60q0jpWxEePS3jVkctIz0yTPQy+a2ZFgV9oMC
 A2vCM+pplJ41ve+Rcp9uA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:HY89IslCOyI=:SaPZGWJ8NHfeJIO/2mWegq
 LYC3a07eNesd7HRosc+FDk2q05uH9O8wurvzk9TPmk2e0D796/majfzTvcDWvVOS6+DOFndkw
 jWOU+6wo4HtxxhBJ3kZqXDH4AQzrBxfdyhJLFcVSzqehfuWN0v3b04TdmhVRHXAbBWOewkkVZ
 CN5S4rLeEee9sDtVLVDNRMaTWv/r8U86Wi5stGuKMcU8OM54UWn3Fq94kwawAtehZQEIJEPU6
 8geRdh9w/fadZItssNzGoIlD36Xk/GgnivjzWrANd8akrMzG8a+p3npoES/LSvDi0cW7TejVk
 hxXrRqQPvsGGcdietlcezYpeNOjK/QaIAC79f7dR4neMFSIsZOj6vAgs1TRP9JssbUuZHyGQt
 39W4WKSC7GD8O/bvOyTDSO54q/eEVGMItLd6Ti2NtWMgdZaOAWQarPDHNlBRa+wz3Knd5pMKU
 Bgi4r+7/uTikHxQRx8yYwXOAiC8jdhqDnvYEs9X8oGBVGTRsRqo3B5KWuDDODnxPhfxswSmvC
 EW4ctdWF9V16NzWjdhPIoXHcjceBlW6IZmQ51BYor8EFvD9BbKNKVliPmDdSVQLr+ATl+g4Pi
 WBPRSzxb+o3ndJCkBsh+n2t9xvZsQAmz4znJqhjTOX+PQRZx6XI571OnrQDZLHSzRcSvqW9+s
 TAkdoqxt/TBXfvgubhkNevhMdhlxFObT+UraUURH84+IfVUVywLV7DCS7SOZ46xUdYmm86G7s
 Sm/Li+YiZ1i0EaHPxCD7/S3Ay1V1PpRb5fjMytq5QRFC8xniF0PW1PQDGgLSRa2sGdS9B8+N 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284838>

In the previous patch, we made sure that the conflict markers themselves
match the end-of-line style of the input files. However, this still left
out the conflicting text itself: if it lacks a trailing newline, we
add one, and should add a carriage return when appropriate, too.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t6023-merge-file.sh |  3 ++-
 xdiff/xmerge.c        | 37 +++++++++++++++++++++++--------------
 2 files changed, 25 insertions(+), 15 deletions(-)

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
index 7b21a6b..d98f430 100644
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
@@ -202,7 +208,7 @@ static int fill_conflict_hunk(xdfenv_t *xe1, const char *name1,
 		marker_size = DEFAULT_CONFLICT_MARKER_SIZE;
 
 	/* Before conflicting part */
-	size += xdl_recs_copy(xe1, i, m->i1 - i, 0,
+	size += xdl_recs_copy(xe1, i, m->i1 - i, 0, 0,
 			      dest ? dest + size : NULL);
 
 	if (!dest) {
@@ -221,7 +227,7 @@ static int fill_conflict_hunk(xdfenv_t *xe1, const char *name1,
 	}
 
 	/* Postimage from side #1 */
-	size += xdl_recs_copy(xe1, m->i1, m->chg1, 1,
+	size += xdl_recs_copy(xe1, m->i1, m->chg1, needs_cr, 1,
 			      dest ? dest + size : NULL);
 
 	if (style == XDL_MERGE_DIFF3) {
@@ -240,7 +246,7 @@ static int fill_conflict_hunk(xdfenv_t *xe1, const char *name1,
 				dest[size++] = '\r';
 			dest[size++] = '\n';
 		}
-		size += xdl_orig_copy(xe1, m->i0, m->chg0, 1,
+		size += xdl_orig_copy(xe1, m->i0, m->chg0, needs_cr, 1,
 				      dest ? dest + size : NULL);
 	}
 
@@ -255,7 +261,7 @@ static int fill_conflict_hunk(xdfenv_t *xe1, const char *name1,
 	}
 
 	/* Postimage from side #2 */
-	size += xdl_recs_copy(xe2, m->i2, m->chg2, 1,
+	size += xdl_recs_copy(xe2, m->i2, m->chg2, needs_cr, 1,
 			      dest ? dest + size : NULL);
 	if (!dest) {
 		size += marker_size + 1 + needs_cr + marker2_size;
@@ -294,21 +300,24 @@ static int xdl_fill_merge_buffer(xdfenv_t *xe1, const char *name1,
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
