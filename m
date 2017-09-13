Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6549720286
	for <e@80x24.org>; Wed, 13 Sep 2017 17:17:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751308AbdIMRRq (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Sep 2017 13:17:46 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:58345 "EHLO
        alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751167AbdIMRQu (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 13 Sep 2017 13:16:50 -0400
X-AuditID: 1207440d-86bff70000000f42-30-59b968012c26
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 79.C6.03906.10869B95; Wed, 13 Sep 2017 13:16:49 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCC855.dip0.t-ipconnect.de [87.188.200.85])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v8DHGIib001379
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Wed, 13 Sep 2017 13:16:47 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Brandon Williams <bmwill@google.com>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 13/20] read_packed_refs(): ensure that references are ordered when read
Date:   Wed, 13 Sep 2017 19:16:07 +0200
Message-Id: <ff65c485aef01b35d8ab82fb785923384f4d68ca.1505319366.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1505319366.git.mhagger@alum.mit.edu>
References: <cover.1505319366.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCIsWRmVeSWpSXmKPExsUixO6iqMuYsTPSYMVTQ4u1z+4wWTxff4Ld
        outKN5NFQ+8VZovbK+YzW3RPecto8aOlh9li8+Z2FgcOj7/vPzB57Jx1l91jwaZSj2e9exg9
        Ll5S9vi8SS6ALYrLJiU1J7MstUjfLoEro+/Me5aCxqiK5w/mMDcwznDrYuTkkBAwkVi8ezpz
        FyMXh5DADiaJ33dnQzknmSQ6dj9lA6liE9CVWNTTzARiiwioSUxsO8QCUsQs8JRJYufJu6wg
        CWGBcIkle2+zg9gsAqoSM08vBprEwcErECXx8bccxDZ5iXMPbjOD2JwCFhIbdzxhBLGFBMwl
        GufsZJzAyLOAkWEVo1xiTmmubm5iZk5xarJucXJiXl5qka6RXm5miV5qSukmRkiA8e5g/L9O
        5hCjAAejEg+vhc3OSCHWxLLiytxDjJIcTEqivHt1gUJ8SfkplRmJxRnxRaU5qcWHGCU4mJVE
        eIOigHK8KYmVValF+TApaQ4WJXFetSXqfkIC6YklqdmpqQWpRTBZGQ4OJQnenHSgRsGi1PTU
        irTMnBKENBMHJ8hwHqDhgiA1vMUFibnFmekQ+VOMuhwdN+/+YRJiycvPS5US5/2bClQkAFKU
        UZoHNweWGF4xigO9JczblQZUxQNMKnCTXgEtYQJacub0DpAlJYkIKakGxrYlD9aFv47O+nG2
        nOdRgJHuMRPGiZ9vVEzYktxS/FKw4scjz22rGz/+nRF4+soeYWP/3aF5jYt3K06fbVuy8ZB/
        2er3z+5+Ct8svUR3ZdOVyjdXDu0+47GqWsNBc0bN/QsGC64t/PEi+evkF3dPr2Y72BGrqMf0
        4bXJ0tMfTmS8tpntIHjv40EBJZbijERDLeai4kQAqeMIP+cCAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It doesn't actually matter now, because the references are only
iterated over to fill the associated `ref_cache`, which itself puts
them in the correct order. But we want to get rid of the `ref_cache`,
so we want to be able to iterate directly over the `packed-refs`
buffer, and then the iteration will need to be ordered correctly.

In fact, we already write the `packed-refs` file sorted, but it is
possible that other Git clients don't get it right. So let's not
assume that a `packed-refs` file is sorted unless it is explicitly
declared to be so via a `sorted` trait in its header line.

If it is *not* declared to be sorted, then scan quickly through the
file to check. If it is found to be out of order, then sort the
records into a new memory-only copy rather than using the mmapped file
contents. This checking and sorting is done quickly, without parsing
the full file contents. However, it needs a little bit of care to
avoid reading past the end of the buffer even if the `packed-refs`
file is corrupt.

If `packed-refs` is sorted (i.e., its file header contains the
`sorted` trait or our check shows that it is), then use the mmapped
file contents directly.

Since we write the file correctly sorted, include that trait when we
write or rewrite a `packed-refs` file.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/packed-backend.c | 222 ++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 206 insertions(+), 16 deletions(-)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index d209c8e5a0..2a36dd9afb 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -25,9 +25,12 @@ struct packed_ref_cache {
 	int fd;
 
 	/*
-	 * The range of memory to which the `packed-refs` file is
-	 * mmapped. If there were no contents (e.g., because the file
-	 * didn't exist), `buf` and `eof` are both NULL.
+	 * The contents of the `packed-refs` file. If the file was
+	 * already sorted, this points at the mmapped contents of the
+	 * file. If not, this points at heap-allocated memory
+	 * containing the contents, sorted. If there were no contents
+	 * (e.g., because the file didn't exist), `buf` and `eof` are
+	 * both NULL.
 	 */
 	char *buf, *eof;
 
@@ -93,22 +96,24 @@ static void acquire_packed_ref_cache(struct packed_ref_cache *packed_refs)
 }
 
 /*
- * If the buffer in `packed_refs` is active, munmap the memory, close the
- * file, and set the buffer pointers to NULL.
+ * If the buffer in `packed_refs` is active, then either munmap the
+ * memory and close the file, or free the memory. Then set the buffer
+ * pointers to NULL.
  */
 static void release_packed_ref_buffer(struct packed_ref_cache *packed_refs)
 {
-	if (packed_refs->buf) {
+	if (packed_refs->fd >= 0) {
 		if (munmap(packed_refs->buf,
 			   packed_refs->eof - packed_refs->buf))
 			die_errno("error ummapping packed-refs file %s",
 				  packed_refs->refs->path);
-		packed_refs->buf = packed_refs->eof = NULL;
-		packed_refs->header_len = 0;
-	}
-
-	if (packed_refs->fd >= 0)
 		close(packed_refs->fd);
+		packed_refs->fd = -1;
+	} else {
+		free(packed_refs->buf);
+	}
+	packed_refs->buf = packed_refs->eof = NULL;
+	packed_refs->header_len = 0;
 }
 
 /*
@@ -329,7 +334,7 @@ struct ref_iterator *mmapped_ref_iterator_begin(
 	if (!packed_refs->buf)
 		return empty_ref_iterator_begin();
 
-	base_ref_iterator_init(ref_iterator, &mmapped_ref_iterator_vtable, 0);
+	base_ref_iterator_init(ref_iterator, &mmapped_ref_iterator_vtable, 1);
 
 	iter->packed_refs = packed_refs;
 	acquire_packed_ref_cache(iter->packed_refs);
@@ -342,6 +347,170 @@ struct ref_iterator *mmapped_ref_iterator_begin(
 	return ref_iterator;
 }
 
+struct packed_ref_entry {
+	const char *start;
+	size_t len;
+};
+
+static int cmp_packed_ref_entries(const void *v1, const void *v2)
+{
+	const struct packed_ref_entry *e1 = v1, *e2 = v2;
+	const char *r1 = e1->start + GIT_SHA1_HEXSZ + 1;
+	const char *r2 = e2->start + GIT_SHA1_HEXSZ + 1;
+
+	while (1) {
+		if (*r1 == '\n')
+			return *r2 == '\n' ? 0 : -1;
+		if (*r1 != *r2) {
+			if (*r2 == '\n')
+				return 1;
+			else
+				return (unsigned char)*r1 < (unsigned char)*r2 ? -1 : +1;
+		}
+		r1++;
+		r2++;
+	}
+}
+
+/*
+ * `packed_refs->buf` is not known to be sorted. Check whether it is,
+ * and if not, sort it into new memory and munmap/free the old
+ * storage.
+ */
+static void sort_packed_refs(struct packed_ref_cache *packed_refs)
+{
+	struct packed_ref_entry *entries = NULL;
+	size_t alloc = 0, nr = 0;
+	int sorted = 1;
+	const char *pos, *eof, *eol;
+	size_t len, i;
+	char *new_buffer, *dst;
+
+	pos = packed_refs->buf + packed_refs->header_len;
+	eof = packed_refs->eof;
+	len = eof - pos;
+
+	if (!len)
+		return;
+
+	/*
+	 * Initialize entries based on a crude estimate of the number
+	 * of references in the file (we'll grow it below if needed):
+	 */
+	ALLOC_GROW(entries, len / 80 + 20, alloc);
+
+	while (pos < eof) {
+		eol = memchr(pos, '\n', eof - pos);
+		if (!eol)
+			/* The safety check should prevent this. */
+			BUG("unterminated line found in packed-refs");
+		if (eol - pos < GIT_SHA1_HEXSZ + 2)
+			die_invalid_line(packed_refs->refs->path,
+					 pos, eof - pos);
+		eol++;
+		if (eol < eof && *eol == '^') {
+			/*
+			 * Keep any peeled line together with its
+			 * reference:
+			 */
+			const char *peeled_start = eol;
+
+			eol = memchr(peeled_start, '\n', eof - peeled_start);
+			if (!eol)
+				/* The safety check should prevent this. */
+				BUG("unterminated peeled line found in packed-refs");
+			eol++;
+		}
+
+		ALLOC_GROW(entries, nr + 1, alloc);
+		entries[nr].start = pos;
+		entries[nr].len = eol - pos;
+		nr++;
+
+		if (sorted &&
+		    nr > 1 &&
+		    cmp_packed_ref_entries(&entries[nr - 2],
+					   &entries[nr - 1]) >= 0)
+			sorted = 0;
+
+		pos = eol;
+	}
+
+	if (sorted)
+		goto cleanup;
+
+	/* We need to sort the memory. First we sort the entries array: */
+	QSORT(entries, nr, cmp_packed_ref_entries);
+
+	/*
+	 * Allocate a new chunk of memory, and copy the old memory to
+	 * the new in the order indicated by `entries` (not bothering
+	 * with the header line):
+	 */
+	new_buffer = xmalloc(len);
+	for (dst = new_buffer, i = 0; i < nr; i++) {
+		memcpy(dst, entries[i].start, entries[i].len);
+		dst += entries[i].len;
+	}
+
+	/*
+	 * Now munmap the old buffer and use the sorted buffer in its
+	 * place:
+	 */
+	release_packed_ref_buffer(packed_refs);
+	packed_refs->buf = new_buffer;
+	packed_refs->eof = new_buffer + len;
+	packed_refs->header_len = 0;
+
+cleanup:
+	free(entries);
+}
+
+/*
+ * Return a pointer to the start of the record that contains the
+ * character `*p` (which must be within the buffer). If no other
+ * record start is found, return `buf`.
+ */
+static const char *find_start_of_record(const char *buf, const char *p)
+{
+	while (p > buf && (p[-1] != '\n' || p[0] == '^'))
+		p--;
+	return p;
+}
+
+/*
+ * We want to be able to compare mmapped reference records quickly,
+ * without totally parsing them. We can do so because the records are
+ * LF-terminated, and the refname should start exactly (GIT_SHA1_HEXSZ
+ * + 1) bytes past the beginning of the record.
+ *
+ * But what if the `packed-refs` file contains garbage? We're willing
+ * to tolerate not detecting the problem, as long as we don't produce
+ * totally garbled output (we can't afford to check the integrity of
+ * the whole file during every Git invocation). But we do want to be
+ * sure that we never read past the end of the buffer in memory and
+ * perform an illegal memory access.
+ *
+ * Guarantee that minimum level of safety by verifying that the last
+ * record in the file is LF-terminated, and that it has at least
+ * (GIT_SHA1_HEXSZ + 1) characters before the LF. Die if either of
+ * these checks fails.
+ */
+static void verify_buffer_safe(struct packed_ref_cache *packed_refs)
+{
+	const char *buf = packed_refs->buf + packed_refs->header_len;
+	const char *eof = packed_refs->eof;
+	const char *last_line;
+
+	if (buf == eof)
+		return;
+
+	last_line = find_start_of_record(buf, eof - 1);
+	if (*(eof - 1) != '\n' || eof - last_line < GIT_SHA1_HEXSZ + 2)
+		die_invalid_line(packed_refs->refs->path,
+				 last_line, eof - last_line);
+}
+
 /*
  * Read from the `packed-refs` file into a newly-allocated
  * `packed_ref_cache` and return it. The return value will already
@@ -350,19 +519,19 @@ struct ref_iterator *mmapped_ref_iterator_begin(
  * A comment line of the form "# pack-refs with: " may contain zero or
  * more traits. We interpret the traits as follows:
  *
- *   No traits:
+ *   Neither `peeled` nor `fully-peeled`:
  *
  *      Probably no references are peeled. But if the file contains a
  *      peeled value for a reference, we will use it.
  *
- *   peeled:
+ *   `peeled`:
  *
  *      References under "refs/tags/", if they *can* be peeled, *are*
  *      peeled in this file. References outside of "refs/tags/" are
  *      probably not peeled even if they could have been, but if we find
  *      a peeled value for such a reference we will use it.
  *
- *   fully-peeled:
+ *   `fully-peeled`:
  *
  *      All references in the file that can be peeled are peeled.
  *      Inversely (and this is more important), any references in the
@@ -370,6 +539,10 @@ struct ref_iterator *mmapped_ref_iterator_begin(
  *      trait should typically be written alongside "peeled" for
  *      compatibility with older clients, but we do not require it
  *      (i.e., "peeled" is a no-op if "fully-peeled" is set).
+ *
+ *   `sorted`:
+ *
+ *      The references in this file are known to be sorted by refname.
  */
 static struct packed_ref_cache *read_packed_refs(struct packed_ref_store *refs)
 {
@@ -378,6 +551,7 @@ static struct packed_ref_cache *read_packed_refs(struct packed_ref_store *refs)
 	size_t size;
 	struct ref_dir *dir;
 	struct ref_iterator *iter;
+	int sorted = 0;
 	int ok;
 
 	packed_refs->refs = refs;
@@ -440,6 +614,9 @@ static struct packed_ref_cache *read_packed_refs(struct packed_ref_store *refs)
 			packed_refs->peeled = PEELED_FULLY;
 		else if (unsorted_string_list_has_string(&traits, "peeled"))
 			packed_refs->peeled = PEELED_TAGS;
+
+		sorted = unsorted_string_list_has_string(&traits, "sorted");
+
 		/* perhaps other traits later as well */
 
 		/* The "+ 1" is for the LF character. */
@@ -449,6 +626,19 @@ static struct packed_ref_cache *read_packed_refs(struct packed_ref_store *refs)
 		strbuf_release(&tmp);
 	}
 
+	verify_buffer_safe(packed_refs);
+
+	if (!sorted) {
+		sort_packed_refs(packed_refs);
+
+		/*
+		 * Reordering the records might have moved a short one
+		 * to the end of the buffer, so verify the buffer's
+		 * safety again:
+		 */
+		verify_buffer_safe(packed_refs);
+	}
+
 	dir = get_ref_dir(packed_refs->cache->root);
 	iter = mmapped_ref_iterator_begin(
 			packed_refs,
@@ -752,7 +942,7 @@ int packed_refs_is_locked(struct ref_store *ref_store)
  * the colon and the trailing space are required.
  */
 static const char PACKED_REFS_HEADER[] =
-	"# pack-refs with: peeled fully-peeled \n";
+	"# pack-refs with: peeled fully-peeled sorted \n";
 
 static int packed_init_db(struct ref_store *ref_store, struct strbuf *err)
 {
-- 
2.14.1

