Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BF77C32771
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 02:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C694720728
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 02:40:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="gc9FJx5q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729787AbgAPCky (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jan 2020 21:40:54 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39237 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729662AbgAPCky (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jan 2020 21:40:54 -0500
Received: by mail-qk1-f193.google.com with SMTP id c16so17816571qko.6
        for <git@vger.kernel.org>; Wed, 15 Jan 2020 18:40:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z0p+SfkaIcu8spKoUlr1MYNKKdzGJoymajXgvnrlfQM=;
        b=gc9FJx5qFdmzByxYaHmmeU3zUnCJFCyZr01j975Ay4VCqjcOcbuxAT7QEzyOPlZHly
         Jnk5mR5MJ1GOTURLwPg7pmnee3wzKwn86wIEVpnBVP3yn6b/+rYqpB9P2GgzuiDSePtB
         rxsngh8yxOoF0yT1wfY0w0EHuvKOv859J4ugO5BD+yj+ufxZ+RWWGhA7dlTtPHC/1cnX
         67LlIqwSUm4nDsc0ok+G7vNdGPNNkOBnhTJt8czE/yzlrQJvXxAFt5eHk6F2BBuc72ep
         kUUQtPNOdms/hYAnIqIEhhrAnFm6Lvq0mEyISVyncOh8Ztjup0RuabYg/ar8l8iZoM0b
         HBVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z0p+SfkaIcu8spKoUlr1MYNKKdzGJoymajXgvnrlfQM=;
        b=pEOLRQpgl7kICsdciqmhHZDHgs927XTqzTNYXonC51N3/7CY9MWDSIkFO/2lazBt2D
         hBoxTj6VUt1d0843N5adJIG9HP8Py4fKD1u7UzzxFu0CGRz4jjmgWMVrLOJuObnJxSK1
         1FcAc0n/EUQxdKbtcUalJLyVZmtuD0dWsdPHLXF1AcSGxlKrqweFP5VbNZC/tVmPDH2U
         K2n8o3gauQiC3EAO1qesYxwyr4cLk2OYbWM2CaEirb3Mxl5h6/ml6k6ftuZA+s0esSV9
         KoREtWRFkooqZDaccUHLjKl6VnXJrKikYOAaoB6XYKhh9oVyFBRgTUcUsatHzB6csin0
         j5YQ==
X-Gm-Message-State: APjAAAVmGJSiAxdQxdLH6HD3mGvpz2Emuv2ZR6J7Rw4wJelnS2UtYCYt
        4NBHKbqRrjCBXRpAp78DBYZM7faAIlo=
X-Google-Smtp-Source: APXvYqw8UkejcLtoTPXwwIeplcZ3czSsnL8CvZTNxDRfu1LXTiLqo1Ch3VaX7JJXM9G1dEsJjfhqCg==
X-Received: by 2002:a37:c24c:: with SMTP id j12mr31261899qkm.401.1579142452787;
        Wed, 15 Jan 2020 18:40:52 -0800 (PST)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::1])
        by smtp.gmail.com with ESMTPSA id u24sm9381289qkm.40.2020.01.15.18.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 18:40:52 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, gitster@pobox.com, jrnieder@gmail.com,
        olyatelezhnaya@gmail.com, pclouds@gmail.com,
        jonathantanmy@google.com, peff@peff.net,
        Stefan Beller <stefanbeller@gmail.com>
Subject: [PATCH v3 05/12] object-store: allow threaded access to object reading
Date:   Wed, 15 Jan 2020 23:39:53 -0300
Message-Id: <b72e90f229dbf7d5be016fd6251a9b3ef76f2431.1579141989.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1579141989.git.matheus.bernardino@usp.br>
References: <cover.1579141989.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Allow object reading to be performed by multiple threads protecting it
with an internal lock, the obj_read_mutex. The lock usage can be toggled
with enable_obj_read_lock() and disable_obj_read_lock(). Currently, the
functions which can be safely called in parallel are:
read_object_file_extended(), repo_read_object_file(),
read_object_file(), read_object_with_reference(), read_object(),
oid_object_info() and oid_object_info_extended(). It's also possible
to use obj_read_lock() and obj_read_unlock() to protect other sections
that cannot execute in parallel with object reading.

Probably there are many spots in the functions listed above that could
be executed unlocked (and thus, in parallel). But, for now, we are most
interested in allowing parallel access to zlib inflation. This is one of
the sections where object reading spends most of the time in (e.g. up to
one-third of git-grep's execution time in the chromium repo corresponds
to inflation) and it's already thread-safe. So, to take advantage of
that, the obj_read_mutex is released when calling git_inflate() and
re-acquired right after, for every calling spot in
oid_object_info_extended()'s call chain. We may refine this lock to also
exploit other possible parallel spots in the future, but for now,
threaded zlib inflation should already give great speedups for threaded
object reading callers.

Note that add_delta_base_cache() was also modified to skip adding
already present entries to the cache. This wasn't possible before, but
it would be now, with the parallel inflation. Take for example the
following situation, where two threads - A and B - are executing the
code at unpack_entry():

1. Thread A is performing the decompression of a base O (which is not
   yet in the cache) at PHASE II. Thread B is simultaneously trying to
   unpack O, but just starting at PHASE I.
2. Since O is not yet in the cache, B will go to PHASE II to also
   perform the decompression.
3. When they finish decompressing, one of them will get the object
   reading mutex and go to PHASE III while the other waits for the
   mutex. Let’s say A got the mutex first.
4. Thread A will add O to the cache, go throughout the rest of PHASE III
   and return.
5. Thread B gets the mutex, also add O to the cache (if the check wasn't
   there) and returns.

Finally, it is also important to highlight that the object reading lock
can only ensure thread-safety in the mentioned functions thanks to two
complementary mechanisms: the use of 'struct raw_object_store's
replace_mutex, which guards sections in the object reading machinery
that would otherwise be thread-unsafe; and the 'struct pack_window's
inuse_cnt, which protects window reading operations (such as the one
performed during the inflation of a packed object), allowing them to
execute without the acquisition of the obj_read_mutex.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 object-store.h | 35 +++++++++++++++++++++++++++++++
 packfile.c     | 32 ++++++++++++++++++++++++++++
 sha1-file.c    | 57 +++++++++++++++++++++++++++++++++++++++++++++-----
 3 files changed, 119 insertions(+), 5 deletions(-)

diff --git a/object-store.h b/object-store.h
index 33739c9dee..7c80e0d64c 100644
--- a/object-store.h
+++ b/object-store.h
@@ -6,6 +6,7 @@
 #include "list.h"
 #include "sha1-array.h"
 #include "strbuf.h"
+#include "thread-utils.h"
 
 struct object_directory {
 	struct object_directory *next;
@@ -251,6 +252,40 @@ int has_loose_object_nonlocal(const struct object_id *);
 
 void assert_oid_type(const struct object_id *oid, enum object_type expect);
 
+/*
+ * Enabling the object read lock allows multiple threads to safely call the
+ * following functions in parallel: repo_read_object_file(), read_object_file(),
+ * read_object_file_extended(), read_object_with_reference(), read_object(),
+ * oid_object_info() and oid_object_info_extended().
+ *
+ * obj_read_lock() and obj_read_unlock() may also be used to protect other
+ * section which cannot execute in parallel with object reading. Since the used
+ * lock is a recursive mutex, these sections can even contain calls to object
+ * reading functions. However, beware that in these cases zlib inflation won't
+ * be performed in parallel, losing performance.
+ *
+ * TODO: oid_object_info_extended()'s call stack has a recursive behavior. If
+ * any of its callees end up calling it, this recursive call won't benefit from
+ * parallel inflation.
+ */
+void enable_obj_read_lock(void);
+void disable_obj_read_lock(void);
+
+extern int obj_read_use_lock;
+extern pthread_mutex_t obj_read_mutex;
+
+static inline void obj_read_lock(void)
+{
+	if(obj_read_use_lock)
+		pthread_mutex_lock(&obj_read_mutex);
+}
+
+static inline void obj_read_unlock(void)
+{
+	if(obj_read_use_lock)
+		pthread_mutex_unlock(&obj_read_mutex);
+}
+
 struct object_info {
 	/* Request */
 	enum object_type *typep;
diff --git a/packfile.c b/packfile.c
index 7e7c04e4d8..24a73fc33a 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1086,7 +1086,23 @@ unsigned long get_size_from_delta(struct packed_git *p,
 	do {
 		in = use_pack(p, w_curs, curpos, &stream.avail_in);
 		stream.next_in = in;
+		/*
+		 * Note: the window section returned by use_pack() must be
+		 * available throughout git_inflate()'s unlocked execution. To
+		 * ensure no other thread will modify the window in the
+		 * meantime, we rely on the packed_window.inuse_cnt. This
+		 * counter is incremented before window reading and checked
+		 * before window disposal.
+		 *
+		 * Other worrying sections could be the call to close_pack_fd(),
+		 * which can close packs even with in-use windows, and to
+		 * reprepare_packed_git(). Regarding the former, mmap doc says:
+		 * "closing the file descriptor does not unmap the region". And
+		 * for the latter, it won't re-open already available packs.
+		 */
+		obj_read_unlock();
 		st = git_inflate(&stream, Z_FINISH);
+		obj_read_lock();
 		curpos += stream.next_in - in;
 	} while ((st == Z_OK || st == Z_BUF_ERROR) &&
 		 stream.total_out < sizeof(delta_head));
@@ -1445,6 +1461,14 @@ static void add_delta_base_cache(struct packed_git *p, off_t base_offset,
 	struct delta_base_cache_entry *ent = xmalloc(sizeof(*ent));
 	struct list_head *lru, *tmp;
 
+	/*
+	 * Check required to avoid redundant entries when more than one thread
+	 * is unpacking the same object, in unpack_entry() (since its phases I
+	 * and III might run concurrently across multiple threads).
+	 */
+	if (in_delta_base_cache(p, base_offset))
+		return;
+
 	delta_base_cached += base_size;
 
 	list_for_each_safe(lru, tmp, &delta_base_cache_lru) {
@@ -1574,7 +1598,15 @@ static void *unpack_compressed_entry(struct packed_git *p,
 	do {
 		in = use_pack(p, w_curs, curpos, &stream.avail_in);
 		stream.next_in = in;
+		/*
+		 * Note: we must ensure the window section returned by
+		 * use_pack() will be available throughout git_inflate()'s
+		 * unlocked execution. Please refer to the comment at
+		 * get_size_from_delta() to see how this is done.
+		 */
+		obj_read_unlock();
 		st = git_inflate(&stream, Z_FINISH);
+		obj_read_lock();
 		if (!stream.avail_out)
 			break; /* the payload is larger than it should be */
 		curpos += stream.next_in - in;
diff --git a/sha1-file.c b/sha1-file.c
index 188de57634..9dc0649748 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -1147,6 +1147,8 @@ static int unpack_loose_short_header(git_zstream *stream,
 				     unsigned char *map, unsigned long mapsize,
 				     void *buffer, unsigned long bufsiz)
 {
+	int ret;
+
 	/* Get the data stream */
 	memset(stream, 0, sizeof(*stream));
 	stream->next_in = map;
@@ -1155,7 +1157,11 @@ static int unpack_loose_short_header(git_zstream *stream,
 	stream->avail_out = bufsiz;
 
 	git_inflate_init(stream);
-	return git_inflate(stream, 0);
+	obj_read_unlock();
+	ret = git_inflate(stream, 0);
+	obj_read_lock();
+
+	return ret;
 }
 
 int unpack_loose_header(git_zstream *stream,
@@ -1200,7 +1206,9 @@ static int unpack_loose_header_to_strbuf(git_zstream *stream, unsigned char *map
 	stream->avail_out = bufsiz;
 
 	do {
+		obj_read_unlock();
 		status = git_inflate(stream, 0);
+		obj_read_lock();
 		strbuf_add(header, buffer, stream->next_out - (unsigned char *)buffer);
 		if (memchr(buffer, '\0', stream->next_out - (unsigned char *)buffer))
 			return 0;
@@ -1240,8 +1248,11 @@ static void *unpack_loose_rest(git_zstream *stream,
 		 */
 		stream->next_out = buf + bytes;
 		stream->avail_out = size - bytes;
-		while (status == Z_OK)
+		while (status == Z_OK) {
+			obj_read_unlock();
 			status = git_inflate(stream, Z_FINISH);
+			obj_read_lock();
+		}
 	}
 	if (status == Z_STREAM_END && !stream->avail_in) {
 		git_inflate_end(stream);
@@ -1411,10 +1422,32 @@ static int loose_object_info(struct repository *r,
 	return (status < 0) ? status : 0;
 }
 
+int obj_read_use_lock = 0;
+pthread_mutex_t obj_read_mutex;
+
+void enable_obj_read_lock(void)
+{
+	if (obj_read_use_lock)
+		return;
+
+	obj_read_use_lock = 1;
+	init_recursive_mutex(&obj_read_mutex);
+}
+
+void disable_obj_read_lock(void)
+{
+	if (!obj_read_use_lock)
+		return;
+
+	obj_read_use_lock = 0;
+	pthread_mutex_destroy(&obj_read_mutex);
+}
+
 int fetch_if_missing = 1;
 
-int oid_object_info_extended(struct repository *r, const struct object_id *oid,
-			     struct object_info *oi, unsigned flags)
+static int do_oid_object_info_extended(struct repository *r,
+				       const struct object_id *oid,
+				       struct object_info *oi, unsigned flags)
 {
 	static struct object_info blank_oi = OBJECT_INFO_INIT;
 	struct pack_entry e;
@@ -1422,6 +1455,7 @@ int oid_object_info_extended(struct repository *r, const struct object_id *oid,
 	const struct object_id *real = oid;
 	int already_retried = 0;
 
+
 	if (flags & OBJECT_INFO_LOOKUP_REPLACE)
 		real = lookup_replace_object(r, oid);
 
@@ -1497,7 +1531,7 @@ int oid_object_info_extended(struct repository *r, const struct object_id *oid,
 	rtype = packed_object_info(r, e.p, e.offset, oi);
 	if (rtype < 0) {
 		mark_bad_packed_object(e.p, real->hash);
-		return oid_object_info_extended(r, real, oi, 0);
+		return do_oid_object_info_extended(r, real, oi, 0);
 	} else if (oi->whence == OI_PACKED) {
 		oi->u.packed.offset = e.offset;
 		oi->u.packed.pack = e.p;
@@ -1508,6 +1542,17 @@ int oid_object_info_extended(struct repository *r, const struct object_id *oid,
 	return 0;
 }
 
+int oid_object_info_extended(struct repository *r, const struct object_id *oid,
+			     struct object_info *oi, unsigned flags)
+{
+	int ret;
+	obj_read_lock();
+	ret = do_oid_object_info_extended(r, oid, oi, flags);
+	obj_read_unlock();
+	return ret;
+}
+
+
 /* returns enum object_type or negative */
 int oid_object_info(struct repository *r,
 		    const struct object_id *oid,
@@ -1580,6 +1625,7 @@ void *read_object_file_extended(struct repository *r,
 	if (data)
 		return data;
 
+	obj_read_lock();
 	if (errno && errno != ENOENT)
 		die_errno(_("failed to read object %s"), oid_to_hex(oid));
 
@@ -1595,6 +1641,7 @@ void *read_object_file_extended(struct repository *r,
 	if ((p = has_packed_and_bad(r, repl->hash)) != NULL)
 		die(_("packed object %s (stored in %s) is corrupt"),
 		    oid_to_hex(repl), p->pack_name);
+	obj_read_unlock();
 
 	return NULL;
 }
-- 
2.24.1

