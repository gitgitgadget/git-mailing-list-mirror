Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 519E220281
	for <e@80x24.org>; Tue, 19 Sep 2017 06:23:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751473AbdISGXJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Sep 2017 02:23:09 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:64775 "EHLO
        alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751455AbdISGXI (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 19 Sep 2017 02:23:08 -0400
X-AuditID: 1207440d-853ff70000000f42-42-59c0b7cb7dc6
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id FE.1B.03906.BC7B0C95; Tue, 19 Sep 2017 02:23:07 -0400 (EDT)
Received: from bagpipes.fritz.box (p54AAE885.dip0.t-ipconnect.de [84.170.232.133])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v8J6MV1l002857
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Tue, 19 Sep 2017 02:23:05 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Brandon Williams <bmwill@google.com>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 14/21] read_packed_refs(): ensure that references are ordered when read
Date:   Tue, 19 Sep 2017 08:22:22 +0200
Message-Id: <5bb362d9cb74c7386cd072e3ecd49b22cea1d8d2.1505799700.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1505799700.git.mhagger@alum.mit.edu>
References: <cover.1505799700.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFIsWRmVeSWpSXmKPExsUixO6iqHt6+4FIg4YlQhZrn91hsni+/gS7
        RdeVbiaLht4rzBb9y7vYLG6vmM9s0T3lLaPFj5YeZovNm9tZHDg9/r7/wOSxc9Zddo8PH+M8
        Fmwq9XjWu4fR4+IlZY/Pm+QC2KO4bFJSczLLUov07RK4Mv7umsZYcC++4tUWjgbGn15djBwc
        EgImEscnpXYxcnEICexgkthzeh9jFyMnkHOKSWLvPk4Qm01AV2JRTzMTiC0ioCYxse0QC0gD
        s8BKZolJW6+wgiSEBaIkZl97ygxiswioSkzb/ADM5gWKb/h2gg3ElhCQlzj34DZYnFPAQqJ5
        z3YWkCOEBMwlDhwtnsDIs4CRYRWjXGJOaa5ubmJmTnFqsm5xcmJeXmqRrpFebmaJXmpK6SZG
        SLDx7mD8v07mEKMAB6MSD6/Atf2RQqyJZcWVuYcYJTmYlER5wzYdiBTiS8pPqcxILM6ILyrN
        SS0+xCjBwawkwntoEVCONyWxsiq1KB8mJc3BoiTOq7ZE3U9IID2xJDU7NbUgtQgmK8PBoSTB
        qwiMKiHBotT01Iq0zJwShDQTByfIcB6g4SogNbzFBYm5xZnpEPlTjLocHTfv/mESYsnLz0uV
        Euf9vBWoSACkKKM0D24OLEm8YhQHekuYt2EbUBUPMMHATXoFtIQJaEn2BrAlJYkIKakGxtqN
        r/4e+pdUItWx9ZyWkMCJ7fkM4SZvv/hGnP9XsO7GI+nnS9hY3mUtjLnxNvPC15+tMh1H/xcw
        NJ+xvRW8Lfef6OL113q55c/YbT8iq5Vnu2Fbk1780UNbVoZa2QpMXVe9N2bKJYmd4ltWXtvR
        kq89m9f1kH9n23zWc9vUFaRitKQLmbRv6iqxFGckGmoxFxUnAgDURavo7QIAAA==
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
records into a new memory-only copy. This checking and sorting is done
quickly, without parsing the full file contents. However, it needs a
little bit of care to avoid reading past the end of the buffer even if
the `packed-refs` file is corrupt.

Since *we* always write the file correctly sorted, include that trait
when we write or rewrite a `packed-refs` file. This means that the
scan described in the previous paragraph should only have to be done
for `packed-refs` files that were written by older versions of the Git
command-line client, or by other clients that haven't yet learned to
write the `sorted` trait.

If `packed-refs` was already sorted, then (if the system allows it) we
can use the mmapped file contents directly. But if the system doesn't
allow a file that is currently mmapped to be replaced using
`rename()`, then it would be bad for us to keep the file mmapped for
any longer than necessary. So, on such systems, always make a copy of
the file contents, either as part of the sorting process, or
afterwards.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/packed-backend.c | 223 +++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 212 insertions(+), 11 deletions(-)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 4981516f1e..f336690f16 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -51,11 +51,12 @@ struct packed_ref_cache {
 	int mmapped;
 
 	/*
-	 * The contents of the `packed-refs` file. If the file is
-	 * mmapped, this points at the mmapped contents of the file.
-	 * If not, this points at heap-allocated memory containing the
-	 * contents. If there were no contents (e.g., because the file
-	 * didn't exist), `buf` and `eof` are both NULL.
+	 * The contents of the `packed-refs` file. If the file was
+	 * already sorted, this points at the mmapped contents of the
+	 * file. If not, this points at heap-allocated memory
+	 * containing the contents, sorted. If there were no contents
+	 * (e.g., because the file didn't exist), `buf` and `eof` are
+	 * both NULL.
 	 */
 	char *buf, *eof;
 
@@ -358,7 +359,7 @@ struct ref_iterator *mmapped_ref_iterator_begin(
 	if (!packed_refs->buf)
 		return empty_ref_iterator_begin();
 
-	base_ref_iterator_init(ref_iterator, &mmapped_ref_iterator_vtable, 0);
+	base_ref_iterator_init(ref_iterator, &mmapped_ref_iterator_vtable, 1);
 
 	iter->packed_refs = packed_refs;
 	acquire_packed_ref_cache(iter->packed_refs);
@@ -371,6 +372,170 @@ struct ref_iterator *mmapped_ref_iterator_begin(
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
  * Depending on `mmap_strategy`, either mmap or read the contents of
  * the `packed-refs` file into the `packed_refs` instance. Return 1 if
@@ -407,7 +572,6 @@ static int load_contents(struct packed_ref_cache *packed_refs)
 
 	switch (mmap_strategy) {
 	case MMAP_NONE:
-	case MMAP_TEMPORARY:
 		packed_refs->buf = xmalloc(size);
 		bytes_read = read_in_full(fd, packed_refs->buf, size);
 		if (bytes_read < 0 || bytes_read != size)
@@ -415,6 +579,7 @@ static int load_contents(struct packed_ref_cache *packed_refs)
 		packed_refs->eof = packed_refs->buf + size;
 		packed_refs->mmapped = 0;
 		break;
+	case MMAP_TEMPORARY:
 	case MMAP_OK:
 		packed_refs->buf = xmmap(NULL, size, PROT_READ, MAP_PRIVATE, fd, 0);
 		packed_refs->eof = packed_refs->buf + size;
@@ -434,19 +599,19 @@ static int load_contents(struct packed_ref_cache *packed_refs)
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
@@ -454,12 +619,17 @@ static int load_contents(struct packed_ref_cache *packed_refs)
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
 	struct packed_ref_cache *packed_refs = xcalloc(1, sizeof(*packed_refs));
 	struct ref_dir *dir;
 	struct ref_iterator *iter;
+	int sorted = 0;
 	int ok;
 
 	packed_refs->refs = refs;
@@ -498,6 +668,9 @@ static struct packed_ref_cache *read_packed_refs(struct packed_ref_store *refs)
 			packed_refs->peeled = PEELED_FULLY;
 		else if (unsorted_string_list_has_string(&traits, "peeled"))
 			packed_refs->peeled = PEELED_TAGS;
+
+		sorted = unsorted_string_list_has_string(&traits, "sorted");
+
 		/* perhaps other traits later as well */
 
 		/* The "+ 1" is for the LF character. */
@@ -507,6 +680,34 @@ static struct packed_ref_cache *read_packed_refs(struct packed_ref_store *refs)
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
+	if (mmap_strategy != MMAP_OK && packed_refs->mmapped) {
+		/*
+		 * We don't want to leave the file mmapped, so we are
+		 * forced to make a copy now:
+		 */
+		size_t size = packed_refs->eof -
+			(packed_refs->buf + packed_refs->header_len);
+		char *buf_copy = xmalloc(size);
+
+		memcpy(buf_copy, packed_refs->buf + packed_refs->header_len, size);
+		release_packed_ref_buffer(packed_refs);
+		packed_refs->buf = buf_copy;
+		packed_refs->eof = buf_copy + size;
+	}
+
 	dir = get_ref_dir(packed_refs->cache->root);
 	iter = mmapped_ref_iterator_begin(
 			packed_refs,
@@ -810,7 +1011,7 @@ int packed_refs_is_locked(struct ref_store *ref_store)
  * the colon and the trailing space are required.
  */
 static const char PACKED_REFS_HEADER[] =
-	"# pack-refs with: peeled fully-peeled \n";
+	"# pack-refs with: peeled fully-peeled sorted \n";
 
 static int packed_init_db(struct ref_store *ref_store, struct strbuf *err)
 {
-- 
2.14.1

