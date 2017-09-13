Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D52E20286
	for <e@80x24.org>; Wed, 13 Sep 2017 17:16:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751443AbdIMRQy (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Sep 2017 13:16:54 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:59507 "EHLO
        alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751380AbdIMRQs (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 13 Sep 2017 13:16:48 -0400
X-AuditID: 12074412-1fdff7000000748d-90-59b967ff131e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 85.27.29837.FF769B95; Wed, 13 Sep 2017 13:16:47 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCC855.dip0.t-ipconnect.de [87.188.200.85])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v8DHGIia001379
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Wed, 13 Sep 2017 13:16:45 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Brandon Williams <bmwill@google.com>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 12/20] packed_ref_cache: keep the `packed-refs` file open and mmapped
Date:   Wed, 13 Sep 2017 19:16:06 +0200
Message-Id: <c3a96718f2d082b2384b00e869ec00ef364d40bb.1505319366.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1505319366.git.mhagger@alum.mit.edu>
References: <cover.1505319366.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrAIsWRmVeSWpSXmKPExsUixO6iqPs/fWekwbGX/BZrn91hsni+/gS7
        RdeVbiaLht4rzBa3V8xntuie8pbR4kdLD7PF5s3tLA4cHn/ff2Dy2DnrLrvHgk2lHs969zB6
        XLyk7PF5k1wAWxSXTUpqTmZZapG+XQJXxpJVG5kK7tlUrDs1namB8apBFyMnh4SAiUTn6r9s
        XYxcHEICO5gkdn3aygiSEBI4ySTx74EFiM0moCuxqKeZCcQWEVCTmNh2iAWkgVngKZPEzpN3
        WUESwgKhEmtvTgMrYhFQlfjauYkdxOYViJLY17mBHWKbvMS5B7eZQWxOAQuJjTueQC0zl2ic
        s5NxAiPPAkaGVYxyiTmlubq5iZk5xanJusXJiXl5qUW6Znq5mSV6qSmlmxghASa0g3H9SblD
        jAIcjEo8vA8sd0YKsSaWFVfmHmKU5GBSEuXdqwsU4kvKT6nMSCzOiC8qzUktPsQowcGsJMIb
        FAWU401JrKxKLcqHSUlzsCiJ8/5crO4nJJCeWJKanZpakFoEk9Xg4BDoXbP6AqMUS15+XqqS
        BK8TMMKEBItS01Mr0jJzShBKmTg4QRbxAC26kAayqLggMbc4Mx0if4pRl6Pj5t0/TEJgg6TE
        ef+mAhUJgBRllObBzYEljFeM4kAvCvOygKzjASYbuEmvgJYwAS05c3oHyJKSRISUVANjj2CU
        mOJnh7+5PzoqTBa0xXxVc79xP+MDw7Ypmn3qIgsqm3ZHJu9bt+Jzb2mEWNM//dW8goIxKnKL
        I0o2nJu/6E3c0Sssp3nNrkzQUPCclXhFrDpF+DLjNraJHO3b78/uiXyrc2fBD6Wy9VafJmsf
        nT118oL0Dk2xjbeNakyqM3+zvz399j+rEktxRqKhFnNRcSIA1S7fu/MCAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As long as a `packed_ref_cache` object is in use, keep the
corresponding `packed-refs` file open and mmapped.

This is still pointless, because we only read the file immediately
after instantiating the `packed_ref_cache`. But that will soon change.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/packed-backend.c | 137 ++++++++++++++++++++++++++++++++------------------
 1 file changed, 89 insertions(+), 48 deletions(-)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 724c88631d..d209c8e5a0 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -18,6 +18,22 @@ struct packed_ref_cache {
 
 	struct ref_cache *cache;
 
+	/*
+	 * The file descriptor of the `packed-refs` file (open in
+	 * read-only mode), or -1 if it is not open.
+	 */
+	int fd;
+
+	/*
+	 * The range of memory to which the `packed-refs` file is
+	 * mmapped. If there were no contents (e.g., because the file
+	 * didn't exist), `buf` and `eof` are both NULL.
+	 */
+	char *buf, *eof;
+
+	/* The size of the header line, if any; otherwise, 0: */
+	size_t header_len;
+
 	/*
 	 * What is the peeled state of this cache? (This is usually
 	 * determined from the header of the "packed-refs" file.)
@@ -36,30 +52,6 @@ struct packed_ref_cache {
 	struct stat_validity validity;
 };
 
-/*
- * Increment the reference count of *packed_refs.
- */
-static void acquire_packed_ref_cache(struct packed_ref_cache *packed_refs)
-{
-	packed_refs->referrers++;
-}
-
-/*
- * Decrease the reference count of *packed_refs.  If it goes to zero,
- * free *packed_refs and return true; otherwise return false.
- */
-static int release_packed_ref_cache(struct packed_ref_cache *packed_refs)
-{
-	if (!--packed_refs->referrers) {
-		free_ref_cache(packed_refs->cache);
-		stat_validity_clear(&packed_refs->validity);
-		free(packed_refs);
-		return 1;
-	} else {
-		return 0;
-	}
-}
-
 /*
  * A container for `packed-refs`-related data. It is not (yet) a
  * `ref_store`.
@@ -92,6 +84,50 @@ struct packed_ref_store {
 	struct tempfile tempfile;
 };
 
+/*
+ * Increment the reference count of *packed_refs.
+ */
+static void acquire_packed_ref_cache(struct packed_ref_cache *packed_refs)
+{
+	packed_refs->referrers++;
+}
+
+/*
+ * If the buffer in `packed_refs` is active, munmap the memory, close the
+ * file, and set the buffer pointers to NULL.
+ */
+static void release_packed_ref_buffer(struct packed_ref_cache *packed_refs)
+{
+	if (packed_refs->buf) {
+		if (munmap(packed_refs->buf,
+			   packed_refs->eof - packed_refs->buf))
+			die_errno("error ummapping packed-refs file %s",
+				  packed_refs->refs->path);
+		packed_refs->buf = packed_refs->eof = NULL;
+		packed_refs->header_len = 0;
+	}
+
+	if (packed_refs->fd >= 0)
+		close(packed_refs->fd);
+}
+
+/*
+ * Decrease the reference count of *packed_refs.  If it goes to zero,
+ * free *packed_refs and return true; otherwise return false.
+ */
+static int release_packed_ref_cache(struct packed_ref_cache *packed_refs)
+{
+	if (!--packed_refs->referrers) {
+		free_ref_cache(packed_refs->cache);
+		stat_validity_clear(&packed_refs->validity);
+		release_packed_ref_buffer(packed_refs);
+		free(packed_refs);
+		return 1;
+	} else {
+		return 0;
+	}
+}
+
 struct ref_store *packed_ref_store_create(const char *path,
 					  unsigned int store_flags)
 {
@@ -284,13 +320,15 @@ static struct ref_iterator_vtable mmapped_ref_iterator_vtable = {
 };
 
 struct ref_iterator *mmapped_ref_iterator_begin(
-		const char *packed_refs_file,
 		struct packed_ref_cache *packed_refs,
 		const char *pos, const char *eof)
 {
 	struct mmapped_ref_iterator *iter = xcalloc(1, sizeof(*iter));
 	struct ref_iterator *ref_iterator = &iter->base;
 
+	if (!packed_refs->buf)
+		return empty_ref_iterator_begin();
+
 	base_ref_iterator_init(ref_iterator, &mmapped_ref_iterator_vtable, 0);
 
 	iter->packed_refs = packed_refs;
@@ -336,11 +374,8 @@ struct ref_iterator *mmapped_ref_iterator_begin(
 static struct packed_ref_cache *read_packed_refs(struct packed_ref_store *refs)
 {
 	struct packed_ref_cache *packed_refs = xcalloc(1, sizeof(*packed_refs));
-	int fd;
 	struct stat st;
 	size_t size;
-	char *buf;
-	const char *pos, *eof;
 	struct ref_dir *dir;
 	struct ref_iterator *iter;
 	int ok;
@@ -351,13 +386,15 @@ static struct packed_ref_cache *read_packed_refs(struct packed_ref_store *refs)
 	packed_refs->cache->root->flag &= ~REF_INCOMPLETE;
 	packed_refs->peeled = PEELED_NONE;
 
-	fd = open(refs->path, O_RDONLY);
-	if (fd < 0) {
+	packed_refs->fd = open(refs->path, O_RDONLY);
+	if (packed_refs->fd < 0) {
 		if (errno == ENOENT) {
 			/*
 			 * This is OK; it just means that no
 			 * "packed-refs" file has been written yet,
-			 * which is equivalent to it being empty.
+			 * which is equivalent to it being empty,
+			 * which is its state when initialized with
+			 * zeros.
 			 */
 			return packed_refs;
 		} else {
@@ -365,31 +402,37 @@ static struct packed_ref_cache *read_packed_refs(struct packed_ref_store *refs)
 		}
 	}
 
-	stat_validity_update(&packed_refs->validity, fd);
+	stat_validity_update(&packed_refs->validity, packed_refs->fd);
 
-	if (fstat(fd, &st) < 0)
+	if (fstat(packed_refs->fd, &st) < 0)
 		die_errno("couldn't stat %s", refs->path);
 
 	size = xsize_t(st.st_size);
-	buf = xmmap(NULL, size, PROT_READ, MAP_PRIVATE, fd, 0);
-	pos = buf;
-	eof = buf + size;
+	packed_refs->buf = xmmap(NULL, size,
+				 PROT_READ, MAP_PRIVATE,
+				 packed_refs->fd, 0);
+	packed_refs->eof = packed_refs->buf + size;
 
 	/* If the file has a header line, process it: */
-	if (pos < eof && *pos == '#') {
+	if (packed_refs->buf < packed_refs->eof && *packed_refs->buf == '#') {
 		struct strbuf tmp = STRBUF_INIT;
 		char *p;
 		const char *eol;
 		struct string_list traits = STRING_LIST_INIT_NODUP;
 
-		eol = memchr(pos, '\n', eof - pos);
+		eol = memchr(packed_refs->buf, '\n',
+			     packed_refs->eof - packed_refs->buf);
 		if (!eol)
-			die_unterminated_line(refs->path, pos, eof - pos);
+			die_unterminated_line(refs->path,
+					      packed_refs->buf,
+					      packed_refs->eof - packed_refs->buf);
 
-		strbuf_add(&tmp, pos, eol - pos);
+		strbuf_add(&tmp, packed_refs->buf, eol - packed_refs->buf);
 
 		if (!skip_prefix(tmp.buf, "# pack-refs with:", (const char **)&p))
-			die_invalid_line(refs->path, pos, eof - pos);
+			die_invalid_line(refs->path,
+					 packed_refs->buf,
+					 packed_refs->eof - packed_refs->buf);
 
 		string_list_split_in_place(&traits, p, ' ', -1);
 
@@ -400,14 +443,17 @@ static struct packed_ref_cache *read_packed_refs(struct packed_ref_store *refs)
 		/* perhaps other traits later as well */
 
 		/* The "+ 1" is for the LF character. */
-		pos = eol + 1;
+		packed_refs->header_len = eol + 1 - packed_refs->buf;
 
 		string_list_clear(&traits, 0);
 		strbuf_release(&tmp);
 	}
 
 	dir = get_ref_dir(packed_refs->cache->root);
-	iter = mmapped_ref_iterator_begin(refs->path, packed_refs, pos, eof);
+	iter = mmapped_ref_iterator_begin(
+			packed_refs,
+			packed_refs->buf + packed_refs->header_len,
+			packed_refs->eof);
 	while ((ok = ref_iterator_advance(iter)) == ITER_OK) {
 		struct ref_entry *entry =
 			create_ref_entry(iter->refname, iter->oid, iter->flags);
@@ -420,11 +466,6 @@ static struct packed_ref_cache *read_packed_refs(struct packed_ref_store *refs)
 	if (ok != ITER_DONE)
 		die("error reading packed-refs file %s", refs->path);
 
-	if (munmap(buf, size))
-		die_errno("error ummapping packed-refs file %s", refs->path);
-
-	close(fd);
-
 	return packed_refs;
 }
 
-- 
2.14.1

