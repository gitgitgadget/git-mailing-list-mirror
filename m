Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5209E20281
	for <e@80x24.org>; Tue, 19 Sep 2017 06:23:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751465AbdISGXH (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Sep 2017 02:23:07 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:62431 "EHLO
        alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751455AbdISGXF (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 19 Sep 2017 02:23:05 -0400
X-AuditID: 1207440f-a5bff70000007960-39-59c0b7c8be81
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 3E.36.31072.8C7B0C95; Tue, 19 Sep 2017 02:23:04 -0400 (EDT)
Received: from bagpipes.fritz.box (p54AAE885.dip0.t-ipconnect.de [84.170.232.133])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v8J6MV1k002857
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Tue, 19 Sep 2017 02:23:02 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Brandon Williams <bmwill@google.com>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 13/21] packed_ref_cache: keep the `packed-refs` file mmapped if possible
Date:   Tue, 19 Sep 2017 08:22:21 +0200
Message-Id: <b32234e07a1bd1e60442a13d97d7c4e51edf3336.1505799700.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1505799700.git.mhagger@alum.mit.edu>
References: <cover.1505799700.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBIsWRmVeSWpSXmKPExsUixO6iqHti+4FIgxXrjCzWPrvDZPF8/Ql2
        i64r3UwWDb1XmC36l3exWdxeMZ/ZonvKW0aLHy09zBabN7ezOHB6/H3/gclj56y77B4fPsZ5
        LNhU6vGsdw+jx8VLyh6fN8kFsEdx2aSk5mSWpRbp2yVwZXR0XGcpOBJXcXrDRsYGxhafLkZO
        DgkBE4n5f/oZuxi5OIQEdjBJXD//hQnCOcUk8aD/NCNIFZuArsSinmYmEFtEQE1iYtshFpAi
        ZoGVzBKTtl5h7WLk4BAWiJbY128MUsMioCrRs/gOM4jNKxAlcWDdDHaIbfIS5x7cBotzClhI
        NO/ZzgLSKiRgLnHgaPEERp4FjAyrGOUSc0pzdXMTM3OKU5N1i5MT8/JSi3RN9HIzS/RSU0o3
        MUICjn8HY9d6mUOMAhyMSjy8Atf2RwqxJpYVV+YeYpTkYFIS5Q3bdCBSiC8pP6UyI7E4I76o
        NCe1+BCjBAezkgjvoUVAOd6UxMqq1KJ8mJQ0B4uSOK/6EnU/IYH0xJLU7NTUgtQimKwGB4dA
        75rVFxilWPLy81KVJHgVgREnJFiUmp5akZaZU4JQysTBCbKIB2iRCkgNb3FBYm5xZjpE/hSj
        LkfHzbt/mITABkmJ897fBlQkAFKUUZoHNweWQF4xigO9KMy7B6SKB5h84Ca9AlrCBLQkewPY
        kpJEhJRUA6NtdgXzab6/q5r6Tsb9YVxSJRXVeO3ZG70putztKYKnXq89JCVynP1Uxd/W7z8P
        l68OenH4jtOi2C3LX1Qv1vybsk0pPL//mInh+91v/1zapfim7oRn0gbpBaLS1bE6V/pCaiov
        NfQ8+2dfoZFxYuJT++iTLN+OVyWEPWhJs4lcJnylbz1T9iwlluKMREMt5qLiRADe2Xt/+wIA
        AA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Keep a copy of the `packed-refs` file contents in memory for as long
as a `packed_ref_cache` object is in use:

* If the system allows it, keep the `packed-refs` file mmapped.

* If not (either because the system doesn't support `mmap()` at all,
  or because a file that is currently mmapped cannot be replaced via
  `rename()`), then make a copy of the file's contents in
  heap-allocated space, and keep that around instead.

We base the choice of behavior on a new build-time switch,
`MMAP_PREVENTS_DELETE`. By default, this switch is set for Windows
variants.

This whole change is still pointless, because we only read the
`packed-refs` file contents immediately after instantiating the
`packed_ref_cache`. But that will soon change.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 Makefile              |  10 +++
 config.mak.uname      |   3 +
 refs/packed-backend.c | 184 ++++++++++++++++++++++++++++++++++++++------------
 3 files changed, 155 insertions(+), 42 deletions(-)

diff --git a/Makefile b/Makefile
index f2bb7f2f63..7a49f99c4f 100644
--- a/Makefile
+++ b/Makefile
@@ -200,6 +200,9 @@ all::
 #
 # Define NO_MMAP if you want to avoid mmap.
 #
+# Define MMAP_PREVENTS_DELETE if a file that is currently mmapped cannot be
+# deleted or cannot be replaced using rename().
+#
 # Define NO_SYS_POLL_H if you don't have sys/poll.h.
 #
 # Define NO_POLL if you do not have or don't want to use poll().
@@ -1383,6 +1386,13 @@ else
 		COMPAT_OBJS += compat/win32mmap.o
 	endif
 endif
+ifdef MMAP_PREVENTS_DELETE
+	BASIC_CFLAGS += -DMMAP_PREVENTS_DELETE
+else
+	ifdef USE_WIN32_MMAP
+		BASIC_CFLAGS += -DMMAP_PREVENTS_DELETE
+	endif
+endif
 ifdef OBJECT_CREATION_USES_RENAMES
 	COMPAT_CFLAGS += -DOBJECT_CREATION_MODE=1
 endif
diff --git a/config.mak.uname b/config.mak.uname
index 6604b130f8..685a80d138 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -184,6 +184,7 @@ ifeq ($(uname_O),Cygwin)
 	UNRELIABLE_FSTAT = UnfortunatelyYes
 	SPARSE_FLAGS = -isystem /usr/include/w32api -Wno-one-bit-signed-bitfield
 	OBJECT_CREATION_USES_RENAMES = UnfortunatelyNeedsTo
+	MMAP_PREVENTS_DELETE = UnfortunatelyYes
 	COMPAT_OBJS += compat/cygwin.o
 	FREAD_READS_DIRECTORIES = UnfortunatelyYes
 endif
@@ -353,6 +354,7 @@ ifeq ($(uname_S),Windows)
 	NO_ST_BLOCKS_IN_STRUCT_STAT = YesPlease
 	NO_NSEC = YesPlease
 	USE_WIN32_MMAP = YesPlease
+	MMAP_PREVENTS_DELETE = UnfortunatelyYes
 	# USE_NED_ALLOCATOR = YesPlease
 	UNRELIABLE_FSTAT = UnfortunatelyYes
 	OBJECT_CREATION_USES_RENAMES = UnfortunatelyNeedsTo
@@ -501,6 +503,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	NO_ST_BLOCKS_IN_STRUCT_STAT = YesPlease
 	NO_NSEC = YesPlease
 	USE_WIN32_MMAP = YesPlease
+	MMAP_PREVENTS_DELETE = UnfortunatelyYes
 	USE_NED_ALLOCATOR = YesPlease
 	UNRELIABLE_FSTAT = UnfortunatelyYes
 	OBJECT_CREATION_USES_RENAMES = UnfortunatelyNeedsTo
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 0fe41a7203..4981516f1e 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -7,6 +7,35 @@
 #include "../iterator.h"
 #include "../lockfile.h"
 
+enum mmap_strategy {
+	/*
+	 * Don't use mmap() at all for reading `packed-refs`.
+	 */
+	MMAP_NONE,
+
+	/*
+	 * Can use mmap() for reading `packed-refs`, but the file must
+	 * not remain mmapped. This is the usual option on Windows,
+	 * where you cannot rename a new version of a file onto a file
+	 * that is currently mmapped.
+	 */
+	MMAP_TEMPORARY,
+
+	/*
+	 * It is OK to leave the `packed-refs` file mmapped while
+	 * arbitrary other code is running.
+	 */
+	MMAP_OK
+};
+
+#if defined(NO_MMAP)
+static enum mmap_strategy mmap_strategy = MMAP_NONE;
+#elif defined(MMAP_PREVENTS_DELETE)
+static enum mmap_strategy mmap_strategy = MMAP_TEMPORARY;
+#else
+static enum mmap_strategy mmap_strategy = MMAP_OK;
+#endif
+
 struct packed_ref_store;
 
 struct packed_ref_cache {
@@ -18,6 +47,21 @@ struct packed_ref_cache {
 
 	struct ref_cache *cache;
 
+	/* Is the `packed-refs` file currently mmapped? */
+	int mmapped;
+
+	/*
+	 * The contents of the `packed-refs` file. If the file is
+	 * mmapped, this points at the mmapped contents of the file.
+	 * If not, this points at heap-allocated memory containing the
+	 * contents. If there were no contents (e.g., because the file
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
@@ -76,6 +120,26 @@ static void acquire_packed_ref_cache(struct packed_ref_cache *packed_refs)
 	packed_refs->referrers++;
 }
 
+/*
+ * If the buffer in `packed_refs` is active, then either munmap the
+ * memory and close the file, or free the memory. Then set the buffer
+ * pointers to NULL.
+ */
+static void release_packed_ref_buffer(struct packed_ref_cache *packed_refs)
+{
+	if (packed_refs->mmapped) {
+		if (munmap(packed_refs->buf,
+			   packed_refs->eof - packed_refs->buf))
+			die_errno("error ummapping packed-refs file %s",
+				  packed_refs->refs->path);
+		packed_refs->mmapped = 0;
+	} else {
+		free(packed_refs->buf);
+	}
+	packed_refs->buf = packed_refs->eof = NULL;
+	packed_refs->header_len = 0;
+}
+
 /*
  * Decrease the reference count of *packed_refs.  If it goes to zero,
  * free *packed_refs and return true; otherwise return false.
@@ -85,6 +149,7 @@ static int release_packed_ref_cache(struct packed_ref_cache *packed_refs)
 	if (!--packed_refs->referrers) {
 		free_ref_cache(packed_refs->cache);
 		stat_validity_clear(&packed_refs->validity);
+		release_packed_ref_buffer(packed_refs);
 		free(packed_refs);
 		return 1;
 	} else {
@@ -284,13 +349,15 @@ static struct ref_iterator_vtable mmapped_ref_iterator_vtable = {
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
@@ -304,6 +371,61 @@ struct ref_iterator *mmapped_ref_iterator_begin(
 	return ref_iterator;
 }
 
+/*
+ * Depending on `mmap_strategy`, either mmap or read the contents of
+ * the `packed-refs` file into the `packed_refs` instance. Return 1 if
+ * the file existed and was read, or 0 if the file was absent. Die on
+ * errors.
+ */
+static int load_contents(struct packed_ref_cache *packed_refs)
+{
+	int fd;
+	struct stat st;
+	size_t size, bytes_read;
+
+	fd = open(packed_refs->refs->path, O_RDONLY);
+	if (fd < 0) {
+		if (errno == ENOENT) {
+			/*
+			 * This is OK; it just means that no
+			 * "packed-refs" file has been written yet,
+			 * which is equivalent to it being empty,
+			 * which is its state when initialized with
+			 * zeros.
+			 */
+			return 0;
+		} else {
+			die_errno("couldn't read %s", packed_refs->refs->path);
+		}
+	}
+
+	stat_validity_update(&packed_refs->validity, fd);
+
+	if (fstat(fd, &st) < 0)
+		die_errno("couldn't stat %s", packed_refs->refs->path);
+	size = xsize_t(st.st_size);
+
+	switch (mmap_strategy) {
+	case MMAP_NONE:
+	case MMAP_TEMPORARY:
+		packed_refs->buf = xmalloc(size);
+		bytes_read = read_in_full(fd, packed_refs->buf, size);
+		if (bytes_read < 0 || bytes_read != size)
+			die_errno("couldn't read %s", packed_refs->refs->path);
+		packed_refs->eof = packed_refs->buf + size;
+		packed_refs->mmapped = 0;
+		break;
+	case MMAP_OK:
+		packed_refs->buf = xmmap(NULL, size, PROT_READ, MAP_PRIVATE, fd, 0);
+		packed_refs->eof = packed_refs->buf + size;
+		packed_refs->mmapped = 1;
+		break;
+	}
+	close(fd);
+
+	return 1;
+}
+
 /*
  * Read from the `packed-refs` file into a newly-allocated
  * `packed_ref_cache` and return it. The return value will already
@@ -336,11 +458,6 @@ struct ref_iterator *mmapped_ref_iterator_begin(
 static struct packed_ref_cache *read_packed_refs(struct packed_ref_store *refs)
 {
 	struct packed_ref_cache *packed_refs = xcalloc(1, sizeof(*packed_refs));
-	int fd;
-	struct stat st;
-	size_t size;
-	char *buf;
-	const char *pos, *eof;
 	struct ref_dir *dir;
 	struct ref_iterator *iter;
 	int ok;
@@ -351,45 +468,29 @@ static struct packed_ref_cache *read_packed_refs(struct packed_ref_store *refs)
 	packed_refs->cache->root->flag &= ~REF_INCOMPLETE;
 	packed_refs->peeled = PEELED_NONE;
 
-	fd = open(refs->path, O_RDONLY);
-	if (fd < 0) {
-		if (errno == ENOENT) {
-			/*
-			 * This is OK; it just means that no
-			 * "packed-refs" file has been written yet,
-			 * which is equivalent to it being empty.
-			 */
-			return packed_refs;
-		} else {
-			die_errno("couldn't read %s", refs->path);
-		}
-	}
-
-	stat_validity_update(&packed_refs->validity, fd);
-
-	if (fstat(fd, &st) < 0)
-		die_errno("couldn't stat %s", refs->path);
-
-	size = xsize_t(st.st_size);
-	buf = xmmap(NULL, size, PROT_READ, MAP_PRIVATE, fd, 0);
-	pos = buf;
-	eof = buf + size;
+	if (!load_contents(packed_refs))
+		return packed_refs;
 
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
 
@@ -400,14 +501,17 @@ static struct packed_ref_cache *read_packed_refs(struct packed_ref_store *refs)
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
@@ -420,11 +524,6 @@ static struct packed_ref_cache *read_packed_refs(struct packed_ref_store *refs)
 	if (ok != ITER_DONE)
 		die("error reading packed-refs file %s", refs->path);
 
-	if (munmap(buf, size))
-		die_errno("error ummapping packed-refs file %s", refs->path);
-
-	close(fd);
-
 	return packed_refs;
 }
 
@@ -1031,6 +1130,8 @@ static int packed_transaction_finish(struct ref_store *ref_store,
 	int ret = TRANSACTION_GENERIC_ERROR;
 	char *packed_refs_path;
 
+	clear_packed_ref_cache(refs);
+
 	packed_refs_path = get_locked_file_path(&refs->lock);
 	if (rename_tempfile(&refs->tempfile, packed_refs_path)) {
 		strbuf_addf(err, "error replacing %s: %s",
@@ -1038,7 +1139,6 @@ static int packed_transaction_finish(struct ref_store *ref_store,
 		goto cleanup;
 	}
 
-	clear_packed_ref_cache(refs);
 	ret = 0;
 
 cleanup:
-- 
2.14.1

