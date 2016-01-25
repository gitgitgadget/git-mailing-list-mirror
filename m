From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v3 1/2] merge-file: let conflict markers match end-of-line
 style of the context
Date: Mon, 25 Jan 2016 09:07:04 +0100 (CET)
Message-ID: <26c973eb3414a8634d515f3621c0ded77cf030ed.1453709205.git.johannes.schindelin@gmx.de>
References: <cover.1453632296.git.johannes.schindelin@gmx.de> <cover.1453709205.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Beat Bolli <dev+git@drbeat.li>,
	Jeff King <peff@peff.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?ISO-8859-15?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 25 09:07:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNcBD-0000SV-Pd
	for gcvg-git-2@plane.gmane.org; Mon, 25 Jan 2016 09:07:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755172AbcAYIHQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jan 2016 03:07:16 -0500
Received: from mout.gmx.net ([212.227.15.19]:54399 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753303AbcAYIHN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jan 2016 03:07:13 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0LbMmA-1ZiGnp2g8Y-00ktgB; Mon, 25 Jan 2016 09:07:07
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1453709205.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:lVnulteJINMTIFWkD2QIy1wTF+TqrNJMIhxzfgD6vd2ggQggbhp
 A7b8ZH039grd84WRLK9eYUnKlZTT7CtKGgHsmVQR8YmvR/wo5UuLdGWz/1OSjzvnc0/MdEI
 9Yjtxh3PG3yH2XxKOx1dj6G5WNoijX6PfMjG1+sQJeEfHVHQaRM98xQrAkD/0XWw/ajyQjO
 NqPxX/q1nMVf2mCZXrXHA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:uLEc3/oOE3w=:l21zIeYPTJQGimhnDS/HdS
 eUTVebvKWGDgGagiZ8xXuYR9+6o2x50PsdvOmz1EIWwivbKoqUl2qdc8PEZuxEYnb0RvJLl/M
 +9Oka8bZsUAvhXBVLPN4UcJ8DMvI8KfGRMvOt441JZETR+cNk343Hl15IxdMoiWRVxavtzmMs
 MV6ZIQUEd3j0vVLeornF65f7g1xJloHbx8or7AP/lMOlP4nGOcp2KFThX9njMSIfDwrz4g31Y
 JBanU4+5W1470tSsC0ssU0I7qwlD3U/iUzJOcAD5VEiIo0T3IL7eaQaG4V/vZ8lQPCIwTyzir
 OfkmVUxpTerFIj6ObVGE+PXyhvlKVhcaCYJZ6iJrewuB9jrch/SALgTsyLzvs7A3xU/l5NgNp
 GmuPXOu1u3oL59MCdsmqQeSbo8B91zmRmHyO9YQp7otFP8ywl1Hv6iOpG3bnRElgk9mEzS7uM
 ahcMzYYZ3+9uUCSwBfQwpHgjQvqtmujjsJ8FlKbmBzWx0qz+A/D6reHOhFG02kxyRBV5o16oB
 dT7fBMQaTbXG1NxVt4R2OFZULKOH7nHvURoZ1uFHPZxw3O06oce4b//p9EziXgeTFI92y8Uzp
 uScD7PKWF6ldDjBt+4yQWoEqlbiToE9f7hjsKalUfLivF+T3g2qopTHKW7+wExre8sNzxo9Rx
 A3QuqDFiXSkFCidqyTczLCJ+O+Id3dzg49T5ZvYJ+Uce9GtJYAk8tQ2IPuANvOwWRHV5y/a/I
 gbjmxm+ilw0fNm6HoKsjY4dDlRjf3iLyrXfzRM0KylXXrfyd0GFFzXwTuHmvHP+nV65sl4TF 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284723>

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
 t/t6023-merge-file.sh | 12 +++++++++++
 xdiff/xmerge.c        | 57 +++++++++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 65 insertions(+), 4 deletions(-)

diff --git a/t/t6023-merge-file.sh b/t/t6023-merge-file.sh
index 190ee90..bb20cbc 100755
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
+	test $(tr "\015" Q <crlf.txt | grep "\\.txtQ$" | wc -l) = 3 &&
+	test_must_fail git -c core.eol=crlf merge-file -p \
+		nolf-diff1.txt nolf-orig.txt nolf-diff2.txt >nolf.txt &&
+	test $(tr "\015" Q <nolf.txt | grep "\\.txtQ$" | wc -l) = 0
+'
+
 test_done
diff --git a/xdiff/xmerge.c b/xdiff/xmerge.c
index 625198e..c852acc 100644
--- a/xdiff/xmerge.c
+++ b/xdiff/xmerge.c
@@ -143,6 +143,35 @@ static int xdl_orig_copy(xdfenv_t *xe, int i, int count, int add_nl, char *dest)
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
 static int fill_conflict_hunk(xdfenv_t *xe1, const char *name1,
 			      xdfenv_t *xe2, const char *name2,
 			      const char *name3,
@@ -152,6 +181,18 @@ static int fill_conflict_hunk(xdfenv_t *xe1, const char *name1,
 	int marker1_size = (name1 ? strlen(name1) + 1 : 0);
 	int marker2_size = (name2 ? strlen(name2) + 1 : 0);
 	int marker3_size = (name3 ? strlen(name3) + 1 : 0);
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
+	if (needs_cr < 0)
+		needs_cr = 0;
 
 	if (marker_size <= 0)
 		marker_size = DEFAULT_CONFLICT_MARKER_SIZE;
@@ -161,7 +202,7 @@ static int fill_conflict_hunk(xdfenv_t *xe1, const char *name1,
 			      dest ? dest + size : NULL);
 
 	if (!dest) {
-		size += marker_size + 1 + marker1_size;
+		size += marker_size + 1 + needs_cr + marker1_size;
 	} else {
 		memset(dest + size, '<', marker_size);
 		size += marker_size;
@@ -170,6 +211,8 @@ static int fill_conflict_hunk(xdfenv_t *xe1, const char *name1,
 			memcpy(dest + size + 1, name1, marker1_size - 1);
 			size += marker1_size;
 		}
+		if (needs_cr)
+			dest[size++] = '\r';
 		dest[size++] = '\n';
 	}
 
@@ -180,7 +223,7 @@ static int fill_conflict_hunk(xdfenv_t *xe1, const char *name1,
 	if (style == XDL_MERGE_DIFF3) {
 		/* Shared preimage */
 		if (!dest) {
-			size += marker_size + 1 + marker3_size;
+			size += marker_size + 1 + needs_cr + marker3_size;
 		} else {
 			memset(dest + size, '|', marker_size);
 			size += marker_size;
@@ -189,6 +232,8 @@ static int fill_conflict_hunk(xdfenv_t *xe1, const char *name1,
 				memcpy(dest + size + 1, name3, marker3_size - 1);
 				size += marker3_size;
 			}
+			if (needs_cr)
+				dest[size++] = '\r';
 			dest[size++] = '\n';
 		}
 		size += xdl_orig_copy(xe1, m->i0, m->chg0, 1,
@@ -196,10 +241,12 @@ static int fill_conflict_hunk(xdfenv_t *xe1, const char *name1,
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
 
@@ -207,7 +254,7 @@ static int fill_conflict_hunk(xdfenv_t *xe1, const char *name1,
 	size += xdl_recs_copy(xe2, m->i2, m->chg2, 1,
 			      dest ? dest + size : NULL);
 	if (!dest) {
-		size += marker_size + 1 + marker2_size;
+		size += marker_size + 1 + needs_cr + marker2_size;
 	} else {
 		memset(dest + size, '>', marker_size);
 		size += marker_size;
@@ -216,6 +263,8 @@ static int fill_conflict_hunk(xdfenv_t *xe1, const char *name1,
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
