From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v5 1/2] merge-file: let conflict markers match end-of-line
 style of the context
Date: Wed, 27 Jan 2016 17:37:36 +0100 (CET)
Message-ID: <8bd9298f9a5b6a6b027625478c9dfcb9188dfb39.1453912583.git.johannes.schindelin@gmx.de>
References: <cover.1453819314.git.johannes.schindelin@gmx.de> <cover.1453912583.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Beat Bolli <dev+git@drbeat.li>,
	Jeff King <peff@peff.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 27 17:37:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOT6O-0008CU-SM
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jan 2016 17:37:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933696AbcA0Qht (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2016 11:37:49 -0500
Received: from mout.gmx.net ([212.227.17.22]:64914 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932256AbcA0Qhr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2016 11:37:47 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MLelb-1aPIB80z8V-000qKN; Wed, 27 Jan 2016 17:37:37
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1453912583.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:nYZR8ZxGX+DUf9ktuUO5lyVS641/xJDtdtW9PsXAhYgMWbocpCF
 mOSIJfnUT64JTISFLsn5JYntvOqmM0NW5u2CdYCRR3RbcSORLr6f/IobvlZ1hvflq0exAhO
 zgUiGwg80RI7xuOPpQlWfY3GCJgbP++RZ9x6qQNXH6jEFo5FKGZDubOWVPsyP3T9Lo1c6QQ
 dc0MGF6sXmyPyenok6uew==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Hdv+IkpRzx0=:blKi33R86nr2o0w9DGuicD
 UVmNAMdFssxI0uBUnbIruSec9TgKzdtLgfoLkzxv3Xwx1yltGhdm6GmR8Ypg5XWhkKaqhdxwg
 nwGjImBpyRYFthsnyQI/g44zNQPRH5uVej4fHhFe7ecMW3h0O9byuev63mfyFxkfDTgrZJtsW
 sFjhxOziutuhW9BIC9ZiOhnB9kwqytoettQMH/d8cpg4aR3Etmikg3NuRZUd5TXJUtuFYIURd
 IhMFYyv94SxcsoZqMpETXFDLRLbCOzvqzauNxtCozv4NUEzwBYDGFQfhJse7f7AI3cU6QGObR
 5mx5TungsFRiMwEhwhKO4lo/9E4leLGEnwaVrKvx/OhpoR1NToq2L+a2Rkw3F9iCPqT3GDBzM
 HYOpFmJNuR3JdNf8fxCL8XyfNmDTnW2YK7WDCXtggXf65D3Ld92MVxLMRCOCDW4z8Gs5S6obq
 pZ9bU8/4bawQZs+KU/7zYu0IF5Pj9D91IfT1FCaAsc/n9U2ZYyvXgHoCs5+q9uB495j3apGq6
 gK1uWwPPj/SbAsBLvdFArfnWxHNUzlu9KCe1G0HO2ctPuP1oRZ1goaw8dXs0rIYKe9fn5Jc+Z
 n74sBYS/2Z8mFsez9z1nil9TdIkfxFYani63JfTkO93bZKfupe/lkmlTOFSuA6oz9XKow+sEf
 KCegwtP9zXmoIZwrj8o/7kpPdcRy+v0Xq5YM9FQm18ZV502RWsBeLPYUKE6pIKK4qHm7wXf0v
 +QrAT3h1PcgfJM0nwe5OK29YiHWXICaY9T1MM8AUqDe1rCjDeeZTU9QA+VgUz/0kO0KODtnG 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284943>

When merging files with CR/LF line endings, the conflict markers should
match those, lest the output file has mixed line endings.

This is particularly of interest on Windows, where some editors get
*really* confused by mixed line endings.

The original version of this patch by Beat Bolli respected core.eol, and
a subsequent improvement by this developer also respected gitattributes.
This approach was suboptimal, though: `git merge-file` was invented as a
drop-in replacement for GNU merge and as such has no problem operating
outside of any repository at all!

Another problem with the original approach was pointed out by Junio
Hamano: legacy repositories might have their text files committed using
CR/LF line endings (and core.eol and the gitattributes would give us a
false impression there). Therefore, the much superior approach is to
simply match the context's line endings, if any.

We actually do not have to look at the *entire* context at all: if the
files are all LF-only, or if they all have CR/LF line endings, it is
sufficient to look at just a *single* line to match that style. And if
the line endings are mixed anyway, it is *still* okay to imitate just a
single line's eol: we will just add to the pile of mixed line endings,
and there is nothing we can do about that.

So what we do is: we look at the line preceding the conflict, falling
back to the line preceding that in case it was the last line and had no
line ending, falling back to the first line, first in the first
post-image, then the second post-image, and finally the pre-image.
If we find consistent CR/LF (or undecided) end-of-line style, we match
that, otherwise we use LF-only line endings for the conflict markers.

Note that while it is true that there have to be at least two lines we
can look at (otherwise there would be no conflict), the same is not true
for line *endings*: the three files in question could all consist of a
single line without any line ending, each. In this case we fall back to
using LF-only.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t6023-merge-file.sh | 12 ++++++++++
 xdiff/xmerge.c        | 61 +++++++++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 69 insertions(+), 4 deletions(-)

diff --git a/t/t6023-merge-file.sh b/t/t6023-merge-file.sh
index 190ee90..a082116 100755
--- a/t/t6023-merge-file.sh
+++ b/t/t6023-merge-file.sh
@@ -346,4 +346,16 @@ test_expect_success 'conflict at EOF without LF resolved by --union' \
 	 printf "line1\nline2\nline3x\nline3y" >expect.txt &&
 	 test_cmp expect.txt output.txt'
 
+test_expect_success 'conflict markers match existing line endings' '
+	printf "1\\r\\n2\\r\\n3" >crlf-orig.txt &&
+	printf "1\\r\\n2\\r\\n4" >crlf-diff1.txt &&
+	printf "1\\r\\n2\\r\\n5" >crlf-diff2.txt &&
+	test_must_fail git -c core.eol=crlf merge-file -p \
+		crlf-diff1.txt crlf-orig.txt crlf-diff2.txt >crlf.txt &&
+	test $(tr "\015" Q <crlf.txt | grep "^[<=>].*Q$" | wc -l) = 3 &&
+	test_must_fail git -c core.eol=crlf merge-file -p \
+		nolf-diff1.txt nolf-orig.txt nolf-diff2.txt >nolf.txt &&
+	test $(tr "\015" Q <nolf.txt | grep "^[<=>].*Q$" | wc -l) = 0
+'
+
 test_done
diff --git a/xdiff/xmerge.c b/xdiff/xmerge.c
index 625198e..7b21a6b 100644
--- a/xdiff/xmerge.c
+++ b/xdiff/xmerge.c
@@ -143,6 +143,50 @@ static int xdl_orig_copy(xdfenv_t *xe, int i, int count, int add_nl, char *dest)
 	return xdl_recs_copy_0(1, xe, i, count, add_nl, dest);
 }
 
+/*
+ * Returns 1 if the i'th line ends in CR/LF (if it is the last line and
+ * has no eol, the preceding line, if any), 0 if it ends in LF-only, and
+ * -1 if the line ending cannot be determined.
+ */
+static int is_eol_crlf(xdfile_t *file, int i)
+{
+	long size;
+
+	if (i < file->nrec - 1)
+		/* All lines before the last *must* end in LF */
+		return (size = file->recs[i]->size) > 1 &&
+			file->recs[i]->ptr[size - 2] == '\r';
+	if (!file->nrec)
+		/* Cannot determine eol style from empty file */
+		return -1;
+	if ((size = file->recs[i]->size) &&
+			file->recs[i]->ptr[size - 1] == '\n')
+		/* Last line; ends in LF; Is it CR/LF? */
+		return size > 1 &&
+			file->recs[i]->ptr[size - 2] == '\r';
+	if (!i)
+		/* The only line has no eol */
+		return -1;
+	/* Determine eol from second-to-last line */
+	return (size = file->recs[i - 1]->size) > 1 &&
+		file->recs[i - 1]->ptr[size - 2] == '\r';
+}
+
+static int is_cr_needed(xdfenv_t *xe1, xdfenv_t *xe2, xdmerge_t *m)
+{
+	int needs_cr;
+
+	/* Match post-images' preceding, or first, lines' end-of-line style */
+	needs_cr = is_eol_crlf(&xe1->xdf2, m->i1 ? m->i1 - 1 : 0);
+	if (needs_cr)
+		needs_cr = is_eol_crlf(&xe2->xdf2, m->i2 ? m->i2 - 1 : 0);
+	/* Look at pre-image's first line, unless we already settled on LF */
+	if (needs_cr)
+		needs_cr = is_eol_crlf(&xe1->xdf1, 0);
+	/* If still undecided, use LF-only */
+	return needs_cr < 0 ? 0 : needs_cr;
+}
+
 static int fill_conflict_hunk(xdfenv_t *xe1, const char *name1,
 			      xdfenv_t *xe2, const char *name2,
 			      const char *name3,
@@ -152,6 +196,7 @@ static int fill_conflict_hunk(xdfenv_t *xe1, const char *name1,
 	int marker1_size = (name1 ? strlen(name1) + 1 : 0);
 	int marker2_size = (name2 ? strlen(name2) + 1 : 0);
 	int marker3_size = (name3 ? strlen(name3) + 1 : 0);
+	int needs_cr = is_cr_needed(xe1, xe2, m);
 
 	if (marker_size <= 0)
 		marker_size = DEFAULT_CONFLICT_MARKER_SIZE;
@@ -161,7 +206,7 @@ static int fill_conflict_hunk(xdfenv_t *xe1, const char *name1,
 			      dest ? dest + size : NULL);
 
 	if (!dest) {
-		size += marker_size + 1 + marker1_size;
+		size += marker_size + 1 + needs_cr + marker1_size;
 	} else {
 		memset(dest + size, '<', marker_size);
 		size += marker_size;
@@ -170,6 +215,8 @@ static int fill_conflict_hunk(xdfenv_t *xe1, const char *name1,
 			memcpy(dest + size + 1, name1, marker1_size - 1);
 			size += marker1_size;
 		}
+		if (needs_cr)
+			dest[size++] = '\r';
 		dest[size++] = '\n';
 	}
 
@@ -180,7 +227,7 @@ static int fill_conflict_hunk(xdfenv_t *xe1, const char *name1,
 	if (style == XDL_MERGE_DIFF3) {
 		/* Shared preimage */
 		if (!dest) {
-			size += marker_size + 1 + marker3_size;
+			size += marker_size + 1 + needs_cr + marker3_size;
 		} else {
 			memset(dest + size, '|', marker_size);
 			size += marker_size;
@@ -189,6 +236,8 @@ static int fill_conflict_hunk(xdfenv_t *xe1, const char *name1,
 				memcpy(dest + size + 1, name3, marker3_size - 1);
 				size += marker3_size;
 			}
+			if (needs_cr)
+				dest[size++] = '\r';
 			dest[size++] = '\n';
 		}
 		size += xdl_orig_copy(xe1, m->i0, m->chg0, 1,
@@ -196,10 +245,12 @@ static int fill_conflict_hunk(xdfenv_t *xe1, const char *name1,
 	}
 
 	if (!dest) {
-		size += marker_size + 1;
+		size += marker_size + 1 + needs_cr;
 	} else {
 		memset(dest + size, '=', marker_size);
 		size += marker_size;
+		if (needs_cr)
+			dest[size++] = '\r';
 		dest[size++] = '\n';
 	}
 
@@ -207,7 +258,7 @@ static int fill_conflict_hunk(xdfenv_t *xe1, const char *name1,
 	size += xdl_recs_copy(xe2, m->i2, m->chg2, 1,
 			      dest ? dest + size : NULL);
 	if (!dest) {
-		size += marker_size + 1 + marker2_size;
+		size += marker_size + 1 + needs_cr + marker2_size;
 	} else {
 		memset(dest + size, '>', marker_size);
 		size += marker_size;
@@ -216,6 +267,8 @@ static int fill_conflict_hunk(xdfenv_t *xe1, const char *name1,
 			memcpy(dest + size + 1, name2, marker2_size - 1);
 			size += marker2_size;
 		}
+		if (needs_cr)
+			dest[size++] = '\r';
 		dest[size++] = '\n';
 	}
 	return size;
-- 
2.7.0.windows.1.7.g55a05c8
