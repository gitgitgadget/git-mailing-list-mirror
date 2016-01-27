From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v5 2/2] merge-file: ensure that conflict sections match eol
 style
Date: Wed, 27 Jan 2016 17:37:40 +0100 (CET)
Message-ID: <758de0ea18bad0e830ca298440e67002171251d6.1453912583.git.johannes.schindelin@gmx.de>
References: <cover.1453819314.git.johannes.schindelin@gmx.de> <cover.1453912583.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Beat Bolli <dev+git@drbeat.li>,
	Jeff King <peff@peff.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 27 17:37:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOT6T-0008Em-0z
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jan 2016 17:37:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933740AbcA0Qhy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2016 11:37:54 -0500
Received: from mout.gmx.net ([212.227.17.20]:62352 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932256AbcA0Qhw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2016 11:37:52 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0Lo2EO-1ZrKCk0ILw-00g1qu; Wed, 27 Jan 2016 17:37:42
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1453912583.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:U/Kx3iR/m0TY1CQvWmxG3fSSJhRMld+VFF9/7ugykSMM0wU0Usa
 PSHwzFWByuvmFE473ayscVyB7+suuCDXeD12c9jU9lFrpIVkB7lSfvgM+t3iOuu5XH8OCM+
 ZznscxZKKHOy+dpehwh6GR/XD1/9qsE1HzStcXdEadJcvdr+oYUhZpnOhHUi2rtJXKI5VaP
 1/jXpJ8uAQNQNIbPdF4hg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:P4fRxYqLGYI=:QPpsgJ+XSrUrLovhFG9DcS
 F6NKJM0tFSC6iTBPbEzPrZQDlfD2RvWsHhgioQOy4grICdzictc1D07KP4pp0eCuIcGLIk+VJ
 r4gDcSB7XkJY28gHp77I9SSxtO3vZsPVeIDendzO39qaT7qRurUyGn7+DJ/q9+VoWd26o2+YJ
 dfYkRsvXRMfGL5mWw9QLvYxv/t2i+emaa7DBLPvJb2JVvbL/MRiThv+3tWSUqxFHxGBA6yN3l
 3SORkW9zUXDxop7sKCxwLZNBau6qgxWdjqJpjK/CKQRmDi22B3kasBYriWNraqznRbP5vAbK5
 Ip6HZ5CClcC8aAv0iQUPXqd6yWfjuIqOO3+OEptdXRQGKa5F1JWR0M6gFYDqR337zwGtflPDP
 fzWb+Av/L/YaZiUtJ+rLqgc7iABV2OHczVqnqUkmMTcaTcfG+UrkdPis9GdFTmdY0BwcgMNO5
 aRYdARaqimiK+CdGKjBwmiAoF675NlLBHo9bx4GG+d+J8h4BGG2zMk2QCe5N65rsJxmL+DPg5
 P3I7jK3dTrHR8TJ2Yhl0T6YOc46/9cj4p1WuU8pdjaKrgl/il+0T/wjqq6ytpDF0HO5nsM7zH
 IAmyLU9kNrbBU+0LztRPPrWtOAKzqAgyifKIQZp6FaQNbIylkLTiCtMeNGA0iHjaHTKcjM1bc
 ePoTQXirR3+0EG0BknYrmXirvhOSFDdoJBnFAdvx8YJWMgmvtSf6W6xDixUvOG7MTtesl6/55
 HIK/HVRsv7v7Js3KSXH+vepYclm6xIDm0OUk1stZPFibW1Tk0l8TCol6Xgr9QFilcug5G8P4 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284942>

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
index a082116..20aee43 100755
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
 	test $(tr "\015" Q <crlf.txt | grep "^[<=>].*Q$" | wc -l) = 3 &&
+	test $(tr "\015" Q <crlf.txt | grep "[345]Q$" | wc -l) = 3 &&
 	test_must_fail git -c core.eol=crlf merge-file -p \
 		nolf-diff1.txt nolf-orig.txt nolf-diff2.txt >nolf.txt &&
 	test $(tr "\015" Q <nolf.txt | grep "^[<=>].*Q$" | wc -l) = 0
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
