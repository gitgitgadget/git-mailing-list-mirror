Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E1BB1F404
	for <e@80x24.org>; Thu,  1 Feb 2018 02:19:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932237AbeBACTV (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jan 2018 21:19:21 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58614 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932212AbeBACTM (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 31 Jan 2018 21:19:12 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 0A92F60FBC;
        Thu,  1 Feb 2018 02:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1517451550;
        bh=HTqtbI2rMOsJ7U5zTTdxqx8rC6aNS/+HQMwlk3HuhRM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=rN5Rey7geHq+7262My3OFZmIJMDmYZjkGwzCNbf+np3msdd+FtLxv2rDGwfLfrt+U
         NtukL8fDeJc6leZqQ4onLKT42zvIKm5RP/P0KmdGHBur5pywtlrmKU7knLiSs2R87m
         fsTi5rxtWY58iQx9+64ipE80mofhcxm/X1oauuv6JnsCsKDTE51pKEbLx+lDfr56uC
         668AFWoINOh+1WLxLnQVHN6cWHNrKlJMNt25oLlqeAmQwwKy4ITECIk9rKBK6iY9A6
         ZBovkrXQqjnS0aQ/fKdygYctfQElg9xQDeGUu8xzXMYccHSjNsWCDqwORPoLaifJW5
         cshh+esyZ7/NYmzFrjGNQJihSDQAtpGeS2E8BI8cWCX7QqvGvkDZcfmSRIu5OYpX0K
         lSmfWotaJkOXf1HhYNowARbcKgzvS3B+OPVtB88gSo+idqNJl1N6SGdMFZlLg6CCao
         LbNNgOrCVF+RZC6UEbjWHDv4yWR2eQH0ubtjpDbHKkVroLst97v
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Patryk Obara <patryk.obara@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 10/12] csum-file: rename sha1file to hashfile
Date:   Thu,  1 Feb 2018 02:18:46 +0000
Message-Id: <20180201021848.533188-11-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.16.1.315.g94e5d3ead4
In-Reply-To: <20180201021848.533188-1-sandals@crustytoothpaste.net>
References: <20180201021848.533188-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename struct sha1file to struct hashfile, along with all of its related
functions.

The transformation in this commit was made by global search-and-replace.
---
 builtin/index-pack.c   | 20 +++++++++----------
 builtin/pack-objects.c | 52 +++++++++++++++++++++++++-------------------------
 bulk-checkin.c         | 16 ++++++++--------
 csum-file.c            | 36 +++++++++++++++++-----------------
 csum-file.h            | 34 ++++++++++++++++-----------------
 fast-import.c          | 28 +++++++++++++--------------
 pack-bitmap-write.c    | 30 ++++++++++++++---------------
 pack-write.c           | 32 +++++++++++++++----------------
 pack.h                 |  4 ++--
 9 files changed, 126 insertions(+), 126 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 40c000aca8..0bb520c731 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1241,7 +1241,7 @@ static void resolve_deltas(void)
  * - append objects to convert thin pack to full pack if required
  * - write the final pack hash
  */
-static void fix_unresolved_deltas(struct sha1file *f);
+static void fix_unresolved_deltas(struct hashfile *f);
 static void conclude_pack(int fix_thin_pack, const char *curr_pack, unsigned char *pack_hash)
 {
 	if (nr_ref_deltas + nr_ofs_deltas == nr_resolved_deltas) {
@@ -1252,7 +1252,7 @@ static void conclude_pack(int fix_thin_pack, const char *curr_pack, unsigned cha
 	}
 
 	if (fix_thin_pack) {
-		struct sha1file *f;
+		struct hashfile *f;
 		unsigned char read_hash[GIT_MAX_RAWSZ], tail_hash[GIT_MAX_RAWSZ];
 		struct strbuf msg = STRBUF_INIT;
 		int nr_unresolved = nr_ofs_deltas + nr_ref_deltas - nr_resolved_deltas;
@@ -1262,7 +1262,7 @@ static void conclude_pack(int fix_thin_pack, const char *curr_pack, unsigned cha
 		REALLOC_ARRAY(objects, nr_objects + nr_unresolved + 1);
 		memset(objects + nr_objects + 1, 0,
 		       nr_unresolved * sizeof(*objects));
-		f = sha1fd(output_fd, curr_pack);
+		f = hashfd(output_fd, curr_pack);
 		fix_unresolved_deltas(f);
 		strbuf_addf(&msg, Q_("completed with %d local object",
 				     "completed with %d local objects",
@@ -1270,7 +1270,7 @@ static void conclude_pack(int fix_thin_pack, const char *curr_pack, unsigned cha
 			    nr_objects - nr_objects_initial);
 		stop_progress_msg(&progress, msg.buf);
 		strbuf_release(&msg);
-		sha1close(f, tail_hash, 0);
+		hashclose(f, tail_hash, 0);
 		hashcpy(read_hash, pack_hash);
 		fixup_pack_header_footer(output_fd, pack_hash,
 					 curr_pack, nr_objects,
@@ -1286,7 +1286,7 @@ static void conclude_pack(int fix_thin_pack, const char *curr_pack, unsigned cha
 		    nr_ofs_deltas + nr_ref_deltas - nr_resolved_deltas);
 }
 
-static int write_compressed(struct sha1file *f, void *in, unsigned int size)
+static int write_compressed(struct hashfile *f, void *in, unsigned int size)
 {
 	git_zstream stream;
 	int status;
@@ -1300,7 +1300,7 @@ static int write_compressed(struct sha1file *f, void *in, unsigned int size)
 		stream.next_out = outbuf;
 		stream.avail_out = sizeof(outbuf);
 		status = git_deflate(&stream, Z_FINISH);
-		sha1write(f, outbuf, sizeof(outbuf) - stream.avail_out);
+		hashwrite(f, outbuf, sizeof(outbuf) - stream.avail_out);
 	} while (status == Z_OK);
 
 	if (status != Z_STREAM_END)
@@ -1310,7 +1310,7 @@ static int write_compressed(struct sha1file *f, void *in, unsigned int size)
 	return size;
 }
 
-static struct object_entry *append_obj_to_pack(struct sha1file *f,
+static struct object_entry *append_obj_to_pack(struct hashfile *f,
 			       const unsigned char *sha1, void *buf,
 			       unsigned long size, enum object_type type)
 {
@@ -1327,7 +1327,7 @@ static struct object_entry *append_obj_to_pack(struct sha1file *f,
 	}
 	header[n++] = c;
 	crc32_begin(f);
-	sha1write(f, header, n);
+	hashwrite(f, header, n);
 	obj[0].size = size;
 	obj[0].hdr_size = n;
 	obj[0].type = type;
@@ -1335,7 +1335,7 @@ static struct object_entry *append_obj_to_pack(struct sha1file *f,
 	obj[1].idx.offset = obj[0].idx.offset + n;
 	obj[1].idx.offset += write_compressed(f, buf, size);
 	obj[0].idx.crc32 = crc32_end(f);
-	sha1flush(f);
+	hashflush(f);
 	hashcpy(obj->idx.oid.hash, sha1);
 	return obj;
 }
@@ -1347,7 +1347,7 @@ static int delta_pos_compare(const void *_a, const void *_b)
 	return a->obj_no - b->obj_no;
 }
 
-static void fix_unresolved_deltas(struct sha1file *f)
+static void fix_unresolved_deltas(struct hashfile *f)
 {
 	struct ref_delta_entry **sorted_by_pos;
 	int i;
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 6b9cfc289d..d91cbd460e 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -161,7 +161,7 @@ static unsigned long do_compress(void **pptr, unsigned long size)
 	return stream.total_out;
 }
 
-static unsigned long write_large_blob_data(struct git_istream *st, struct sha1file *f,
+static unsigned long write_large_blob_data(struct git_istream *st, struct hashfile *f,
 					   const struct object_id *oid)
 {
 	git_zstream stream;
@@ -185,7 +185,7 @@ static unsigned long write_large_blob_data(struct git_istream *st, struct sha1fi
 			stream.next_out = obuf;
 			stream.avail_out = sizeof(obuf);
 			zret = git_deflate(&stream, readlen ? 0 : Z_FINISH);
-			sha1write(f, obuf, stream.next_out - obuf);
+			hashwrite(f, obuf, stream.next_out - obuf);
 			olen += stream.next_out - obuf;
 		}
 		if (stream.avail_in)
@@ -230,7 +230,7 @@ static int check_pack_inflate(struct packed_git *p,
 		stream.total_in == len) ? 0 : -1;
 }
 
-static void copy_pack_data(struct sha1file *f,
+static void copy_pack_data(struct hashfile *f,
 		struct packed_git *p,
 		struct pack_window **w_curs,
 		off_t offset,
@@ -243,14 +243,14 @@ static void copy_pack_data(struct sha1file *f,
 		in = use_pack(p, w_curs, offset, &avail);
 		if (avail > len)
 			avail = (unsigned long)len;
-		sha1write(f, in, avail);
+		hashwrite(f, in, avail);
 		offset += avail;
 		len -= avail;
 	}
 }
 
 /* Return 0 if we will bust the pack-size limit */
-static unsigned long write_no_reuse_object(struct sha1file *f, struct object_entry *entry,
+static unsigned long write_no_reuse_object(struct hashfile *f, struct object_entry *entry,
 					   unsigned long limit, int usable_delta)
 {
 	unsigned long size, datalen;
@@ -323,8 +323,8 @@ static unsigned long write_no_reuse_object(struct sha1file *f, struct object_ent
 			free(buf);
 			return 0;
 		}
-		sha1write(f, header, hdrlen);
-		sha1write(f, dheader + pos, sizeof(dheader) - pos);
+		hashwrite(f, header, hdrlen);
+		hashwrite(f, dheader + pos, sizeof(dheader) - pos);
 		hdrlen += sizeof(dheader) - pos;
 	} else if (type == OBJ_REF_DELTA) {
 		/*
@@ -337,8 +337,8 @@ static unsigned long write_no_reuse_object(struct sha1file *f, struct object_ent
 			free(buf);
 			return 0;
 		}
-		sha1write(f, header, hdrlen);
-		sha1write(f, entry->delta->idx.oid.hash, 20);
+		hashwrite(f, header, hdrlen);
+		hashwrite(f, entry->delta->idx.oid.hash, 20);
 		hdrlen += 20;
 	} else {
 		if (limit && hdrlen + datalen + 20 >= limit) {
@@ -347,13 +347,13 @@ static unsigned long write_no_reuse_object(struct sha1file *f, struct object_ent
 			free(buf);
 			return 0;
 		}
-		sha1write(f, header, hdrlen);
+		hashwrite(f, header, hdrlen);
 	}
 	if (st) {
 		datalen = write_large_blob_data(st, f, &entry->idx.oid);
 		close_istream(st);
 	} else {
-		sha1write(f, buf, datalen);
+		hashwrite(f, buf, datalen);
 		free(buf);
 	}
 
@@ -361,7 +361,7 @@ static unsigned long write_no_reuse_object(struct sha1file *f, struct object_ent
 }
 
 /* Return 0 if we will bust the pack-size limit */
-static off_t write_reuse_object(struct sha1file *f, struct object_entry *entry,
+static off_t write_reuse_object(struct hashfile *f, struct object_entry *entry,
 				unsigned long limit, int usable_delta)
 {
 	struct packed_git *p = entry->in_pack;
@@ -412,8 +412,8 @@ static off_t write_reuse_object(struct sha1file *f, struct object_entry *entry,
 			unuse_pack(&w_curs);
 			return 0;
 		}
-		sha1write(f, header, hdrlen);
-		sha1write(f, dheader + pos, sizeof(dheader) - pos);
+		hashwrite(f, header, hdrlen);
+		hashwrite(f, dheader + pos, sizeof(dheader) - pos);
 		hdrlen += sizeof(dheader) - pos;
 		reused_delta++;
 	} else if (type == OBJ_REF_DELTA) {
@@ -421,8 +421,8 @@ static off_t write_reuse_object(struct sha1file *f, struct object_entry *entry,
 			unuse_pack(&w_curs);
 			return 0;
 		}
-		sha1write(f, header, hdrlen);
-		sha1write(f, entry->delta->idx.oid.hash, 20);
+		hashwrite(f, header, hdrlen);
+		hashwrite(f, entry->delta->idx.oid.hash, 20);
 		hdrlen += 20;
 		reused_delta++;
 	} else {
@@ -430,7 +430,7 @@ static off_t write_reuse_object(struct sha1file *f, struct object_entry *entry,
 			unuse_pack(&w_curs);
 			return 0;
 		}
-		sha1write(f, header, hdrlen);
+		hashwrite(f, header, hdrlen);
 	}
 	copy_pack_data(f, p, &w_curs, offset, datalen);
 	unuse_pack(&w_curs);
@@ -439,7 +439,7 @@ static off_t write_reuse_object(struct sha1file *f, struct object_entry *entry,
 }
 
 /* Return 0 if we will bust the pack-size limit */
-static off_t write_object(struct sha1file *f,
+static off_t write_object(struct hashfile *f,
 			  struct object_entry *entry,
 			  off_t write_offset)
 {
@@ -512,7 +512,7 @@ enum write_one_status {
 	WRITE_ONE_RECURSIVE = 2 /* already scheduled to be written */
 };
 
-static enum write_one_status write_one(struct sha1file *f,
+static enum write_one_status write_one(struct hashfile *f,
 				       struct object_entry *e,
 				       off_t *offset)
 {
@@ -731,7 +731,7 @@ static struct object_entry **compute_write_order(void)
 	return wo;
 }
 
-static off_t write_reused_pack(struct sha1file *f)
+static off_t write_reused_pack(struct hashfile *f)
 {
 	unsigned char buffer[8192];
 	off_t to_write, total;
@@ -762,7 +762,7 @@ static off_t write_reused_pack(struct sha1file *f)
 		if (read_pack > to_write)
 			read_pack = to_write;
 
-		sha1write(f, buffer, read_pack);
+		hashwrite(f, buffer, read_pack);
 		to_write -= read_pack;
 
 		/*
@@ -791,7 +791,7 @@ static const char no_split_warning[] = N_(
 static void write_pack_file(void)
 {
 	uint32_t i = 0, j;
-	struct sha1file *f;
+	struct hashfile *f;
 	off_t offset;
 	uint32_t nr_remaining = nr_result;
 	time_t last_mtime = 0;
@@ -807,7 +807,7 @@ static void write_pack_file(void)
 		char *pack_tmp_name = NULL;
 
 		if (pack_to_stdout)
-			f = sha1fd_throughput(1, "<stdout>", progress_state);
+			f = hashfd_throughput(1, "<stdout>", progress_state);
 		else
 			f = create_tmp_packfile(&pack_tmp_name);
 
@@ -834,11 +834,11 @@ static void write_pack_file(void)
 		 * If so, rewrite it like in fast-import
 		 */
 		if (pack_to_stdout) {
-			sha1close(f, oid.hash, CSUM_CLOSE);
+			hashclose(f, oid.hash, CSUM_CLOSE);
 		} else if (nr_written == nr_remaining) {
-			sha1close(f, oid.hash, CSUM_FSYNC);
+			hashclose(f, oid.hash, CSUM_FSYNC);
 		} else {
-			int fd = sha1close(f, oid.hash, 0);
+			int fd = hashclose(f, oid.hash, 0);
 			fixup_pack_header_footer(fd, oid.hash, pack_tmp_name,
 						 nr_written, oid.hash, offset);
 			close(fd);
diff --git a/bulk-checkin.c b/bulk-checkin.c
index 3310fd210a..5f79ed6ea3 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -12,7 +12,7 @@ static struct bulk_checkin_state {
 	unsigned plugged:1;
 
 	char *pack_tmp_name;
-	struct sha1file *f;
+	struct hashfile *f;
 	off_t offset;
 	struct pack_idx_option pack_idx_opts;
 
@@ -35,9 +35,9 @@ static void finish_bulk_checkin(struct bulk_checkin_state *state)
 		unlink(state->pack_tmp_name);
 		goto clear_exit;
 	} else if (state->nr_written == 1) {
-		sha1close(state->f, oid.hash, CSUM_FSYNC);
+		hashclose(state->f, oid.hash, CSUM_FSYNC);
 	} else {
-		int fd = sha1close(state->f, oid.hash, 0);
+		int fd = hashclose(state->f, oid.hash, 0);
 		fixup_pack_header_footer(fd, oid.hash, state->pack_tmp_name,
 					 state->nr_written, oid.hash,
 					 state->offset);
@@ -149,7 +149,7 @@ static int stream_to_pack(struct bulk_checkin_state *state,
 					return -1;
 				}
 
-				sha1write(state->f, obuf, written);
+				hashwrite(state->f, obuf, written);
 				state->offset += written;
 			}
 			s.next_out = obuf;
@@ -195,7 +195,7 @@ static int deflate_to_pack(struct bulk_checkin_state *state,
 	git_SHA_CTX ctx;
 	unsigned char obuf[16384];
 	unsigned header_len;
-	struct sha1file_checkpoint checkpoint;
+	struct hashfile_checkpoint checkpoint;
 	struct pack_idx_entry *idx = NULL;
 
 	seekback = lseek(fd, 0, SEEK_CUR);
@@ -216,7 +216,7 @@ static int deflate_to_pack(struct bulk_checkin_state *state,
 	while (1) {
 		prepare_to_stream(state, flags);
 		if (idx) {
-			sha1file_checkpoint(state->f, &checkpoint);
+			hashfile_checkpoint(state->f, &checkpoint);
 			idx->offset = state->offset;
 			crc32_begin(state->f);
 		}
@@ -230,7 +230,7 @@ static int deflate_to_pack(struct bulk_checkin_state *state,
 		 */
 		if (!idx)
 			die("BUG: should not happen");
-		sha1file_truncate(state->f, &checkpoint);
+		hashfile_truncate(state->f, &checkpoint);
 		state->offset = checkpoint.offset;
 		finish_bulk_checkin(state);
 		if (lseek(fd, seekback, SEEK_SET) == (off_t) -1)
@@ -242,7 +242,7 @@ static int deflate_to_pack(struct bulk_checkin_state *state,
 
 	idx->crc32 = crc32_end(state->f);
 	if (already_written(state, result_sha1)) {
-		sha1file_truncate(state->f, &checkpoint);
+		hashfile_truncate(state->f, &checkpoint);
 		state->offset = checkpoint.offset;
 		free(idx);
 	} else {
diff --git a/csum-file.c b/csum-file.c
index 2adae04073..e4ad6337dc 100644
--- a/csum-file.c
+++ b/csum-file.c
@@ -11,7 +11,7 @@
 #include "progress.h"
 #include "csum-file.h"
 
-static void flush(struct sha1file *f, const void *buf, unsigned int count)
+static void flush(struct hashfile *f, const void *buf, unsigned int count)
 {
 	if (0 <= f->check_fd && count)  {
 		unsigned char check_buffer[8192];
@@ -42,7 +42,7 @@ static void flush(struct sha1file *f, const void *buf, unsigned int count)
 	}
 }
 
-void sha1flush(struct sha1file *f)
+void hashflush(struct hashfile *f)
 {
 	unsigned offset = f->offset;
 
@@ -53,11 +53,11 @@ void sha1flush(struct sha1file *f)
 	}
 }
 
-int sha1close(struct sha1file *f, unsigned char *result, unsigned int flags)
+int hashclose(struct hashfile *f, unsigned char *result, unsigned int flags)
 {
 	int fd;
 
-	sha1flush(f);
+	hashflush(f);
 	git_SHA1_Final(f->buffer, &f->ctx);
 	if (result)
 		hashcpy(result, f->buffer);
@@ -86,7 +86,7 @@ int sha1close(struct sha1file *f, unsigned char *result, unsigned int flags)
 	return fd;
 }
 
-void sha1write(struct sha1file *f, const void *buf, unsigned int count)
+void hashwrite(struct hashfile *f, const void *buf, unsigned int count)
 {
 	while (count) {
 		unsigned offset = f->offset;
@@ -118,15 +118,15 @@ void sha1write(struct sha1file *f, const void *buf, unsigned int count)
 	}
 }
 
-struct sha1file *sha1fd(int fd, const char *name)
+struct hashfile *hashfd(int fd, const char *name)
 {
-	return sha1fd_throughput(fd, name, NULL);
+	return hashfd_throughput(fd, name, NULL);
 }
 
-struct sha1file *sha1fd_check(const char *name)
+struct hashfile *hashfd_check(const char *name)
 {
 	int sink, check;
-	struct sha1file *f;
+	struct hashfile *f;
 
 	sink = open("/dev/null", O_WRONLY);
 	if (sink < 0)
@@ -134,14 +134,14 @@ struct sha1file *sha1fd_check(const char *name)
 	check = open(name, O_RDONLY);
 	if (check < 0)
 		die_errno("unable to open '%s'", name);
-	f = sha1fd(sink, name);
+	f = hashfd(sink, name);
 	f->check_fd = check;
 	return f;
 }
 
-struct sha1file *sha1fd_throughput(int fd, const char *name, struct progress *tp)
+struct hashfile *hashfd_throughput(int fd, const char *name, struct progress *tp)
 {
-	struct sha1file *f = xmalloc(sizeof(*f));
+	struct hashfile *f = xmalloc(sizeof(*f));
 	f->fd = fd;
 	f->check_fd = -1;
 	f->offset = 0;
@@ -153,14 +153,14 @@ struct sha1file *sha1fd_throughput(int fd, const char *name, struct progress *tp
 	return f;
 }
 
-void sha1file_checkpoint(struct sha1file *f, struct sha1file_checkpoint *checkpoint)
+void hashfile_checkpoint(struct hashfile *f, struct hashfile_checkpoint *checkpoint)
 {
-	sha1flush(f);
+	hashflush(f);
 	checkpoint->offset = f->total;
 	checkpoint->ctx = f->ctx;
 }
 
-int sha1file_truncate(struct sha1file *f, struct sha1file_checkpoint *checkpoint)
+int hashfile_truncate(struct hashfile *f, struct hashfile_checkpoint *checkpoint)
 {
 	off_t offset = checkpoint->offset;
 
@@ -169,17 +169,17 @@ int sha1file_truncate(struct sha1file *f, struct sha1file_checkpoint *checkpoint
 		return -1;
 	f->total = offset;
 	f->ctx = checkpoint->ctx;
-	f->offset = 0; /* sha1flush() was called in checkpoint */
+	f->offset = 0; /* hashflush() was called in checkpoint */
 	return 0;
 }
 
-void crc32_begin(struct sha1file *f)
+void crc32_begin(struct hashfile *f)
 {
 	f->crc32 = crc32(0, NULL, 0);
 	f->do_crc = 1;
 }
 
-uint32_t crc32_end(struct sha1file *f)
+uint32_t crc32_end(struct hashfile *f)
 {
 	f->do_crc = 0;
 	return f->crc32;
diff --git a/csum-file.h b/csum-file.h
index 7530927d77..ceb3e5712d 100644
--- a/csum-file.h
+++ b/csum-file.h
@@ -4,7 +4,7 @@
 struct progress;
 
 /* A SHA1-protected file */
-struct sha1file {
+struct hashfile {
 	int fd;
 	int check_fd;
 	unsigned int offset;
@@ -18,36 +18,36 @@ struct sha1file {
 };
 
 /* Checkpoint */
-struct sha1file_checkpoint {
+struct hashfile_checkpoint {
 	off_t offset;
 	git_SHA_CTX ctx;
 };
 
-extern void sha1file_checkpoint(struct sha1file *, struct sha1file_checkpoint *);
-extern int sha1file_truncate(struct sha1file *, struct sha1file_checkpoint *);
+extern void hashfile_checkpoint(struct hashfile *, struct hashfile_checkpoint *);
+extern int hashfile_truncate(struct hashfile *, struct hashfile_checkpoint *);
 
-/* sha1close flags */
+/* hashclose flags */
 #define CSUM_CLOSE	1
 #define CSUM_FSYNC	2
 
-extern struct sha1file *sha1fd(int fd, const char *name);
-extern struct sha1file *sha1fd_check(const char *name);
-extern struct sha1file *sha1fd_throughput(int fd, const char *name, struct progress *tp);
-extern int sha1close(struct sha1file *, unsigned char *, unsigned int);
-extern void sha1write(struct sha1file *, const void *, unsigned int);
-extern void sha1flush(struct sha1file *f);
-extern void crc32_begin(struct sha1file *);
-extern uint32_t crc32_end(struct sha1file *);
+extern struct hashfile *hashfd(int fd, const char *name);
+extern struct hashfile *hashfd_check(const char *name);
+extern struct hashfile *hashfd_throughput(int fd, const char *name, struct progress *tp);
+extern int hashclose(struct hashfile *, unsigned char *, unsigned int);
+extern void hashwrite(struct hashfile *, const void *, unsigned int);
+extern void hashflush(struct hashfile *f);
+extern void crc32_begin(struct hashfile *);
+extern uint32_t crc32_end(struct hashfile *);
 
-static inline void sha1write_u8(struct sha1file *f, uint8_t data)
+static inline void hashwrite_u8(struct hashfile *f, uint8_t data)
 {
-	sha1write(f, &data, sizeof(data));
+	hashwrite(f, &data, sizeof(data));
 }
 
-static inline void sha1write_be32(struct sha1file *f, uint32_t data)
+static inline void hashwrite_be32(struct hashfile *f, uint32_t data)
 {
 	data = htonl(data);
-	sha1write(f, &data, sizeof(data));
+	hashwrite(f, &data, sizeof(data));
 }
 
 #endif
diff --git a/fast-import.c b/fast-import.c
index f20f30ab62..0f818cd932 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -316,7 +316,7 @@ static struct atom_str **atom_table;
 /* The .pack file being generated */
 static struct pack_idx_option pack_idx_opts;
 static unsigned int pack_id;
-static struct sha1file *pack_file;
+static struct hashfile *pack_file;
 static struct packed_git *pack_data;
 static struct packed_git **all_packs;
 static off_t pack_size;
@@ -905,12 +905,12 @@ static void start_packfile(void)
 
 	p->pack_fd = pack_fd;
 	p->do_not_close = 1;
-	pack_file = sha1fd(pack_fd, p->pack_name);
+	pack_file = hashfd(pack_fd, p->pack_name);
 
 	hdr.hdr_signature = htonl(PACK_SIGNATURE);
 	hdr.hdr_version = htonl(2);
 	hdr.hdr_entries = 0;
-	sha1write(pack_file, &hdr, sizeof(hdr));
+	hashwrite(pack_file, &hdr, sizeof(hdr));
 
 	pack_data = p;
 	pack_size = sizeof(hdr);
@@ -1016,7 +1016,7 @@ static void end_packfile(void)
 		struct tag *t;
 
 		close_pack_windows(pack_data);
-		sha1close(pack_file, cur_pack_oid.hash, 0);
+		hashclose(pack_file, cur_pack_oid.hash, 0);
 		fixup_pack_header_footer(pack_data->pack_fd, pack_data->sha1,
 				    pack_data->pack_name, object_count,
 				    cur_pack_oid.hash, pack_size);
@@ -1182,23 +1182,23 @@ static int store_object(
 
 		hdrlen = encode_in_pack_object_header(hdr, sizeof(hdr),
 						      OBJ_OFS_DELTA, deltalen);
-		sha1write(pack_file, hdr, hdrlen);
+		hashwrite(pack_file, hdr, hdrlen);
 		pack_size += hdrlen;
 
 		hdr[pos] = ofs & 127;
 		while (ofs >>= 7)
 			hdr[--pos] = 128 | (--ofs & 127);
-		sha1write(pack_file, hdr + pos, sizeof(hdr) - pos);
+		hashwrite(pack_file, hdr + pos, sizeof(hdr) - pos);
 		pack_size += sizeof(hdr) - pos;
 	} else {
 		e->depth = 0;
 		hdrlen = encode_in_pack_object_header(hdr, sizeof(hdr),
 						      type, dat->len);
-		sha1write(pack_file, hdr, hdrlen);
+		hashwrite(pack_file, hdr, hdrlen);
 		pack_size += hdrlen;
 	}
 
-	sha1write(pack_file, out, s.total_out);
+	hashwrite(pack_file, out, s.total_out);
 	pack_size += s.total_out;
 
 	e->idx.crc32 = crc32_end(pack_file);
@@ -1217,9 +1217,9 @@ static int store_object(
 	return 0;
 }
 
-static void truncate_pack(struct sha1file_checkpoint *checkpoint)
+static void truncate_pack(struct hashfile_checkpoint *checkpoint)
 {
-	if (sha1file_truncate(pack_file, checkpoint))
+	if (hashfile_truncate(pack_file, checkpoint))
 		die_errno("cannot truncate pack to skip duplicate");
 	pack_size = checkpoint->offset;
 }
@@ -1235,7 +1235,7 @@ static void stream_blob(uintmax_t len, struct object_id *oidout, uintmax_t mark)
 	off_t offset;
 	git_hash_ctx c;
 	git_zstream s;
-	struct sha1file_checkpoint checkpoint;
+	struct hashfile_checkpoint checkpoint;
 	int status = Z_OK;
 
 	/* Determine if we should auto-checkpoint. */
@@ -1243,7 +1243,7 @@ static void stream_blob(uintmax_t len, struct object_id *oidout, uintmax_t mark)
 		|| (pack_size + 60 + len) < pack_size)
 		cycle_packfile();
 
-	sha1file_checkpoint(pack_file, &checkpoint);
+	hashfile_checkpoint(pack_file, &checkpoint);
 	offset = checkpoint.offset;
 
 	hdrlen = xsnprintf((char *)out_buf, out_sz, "blob %" PRIuMAX, len) + 1;
@@ -1277,7 +1277,7 @@ static void stream_blob(uintmax_t len, struct object_id *oidout, uintmax_t mark)
 
 		if (!s.avail_out || status == Z_STREAM_END) {
 			size_t n = s.next_out - out_buf;
-			sha1write(pack_file, out_buf, n);
+			hashwrite(pack_file, out_buf, n);
 			pack_size += n;
 			s.next_out = out_buf;
 			s.avail_out = out_sz;
@@ -1362,7 +1362,7 @@ static void *gfi_unpack_entry(
 		 * the newly written data.
 		 */
 		close_pack_windows(p);
-		sha1flush(pack_file);
+		hashflush(pack_file);
 
 		/* We have to offer rawsz bytes additional on the end of
 		 * the packfile as the core unpacker code assumes the
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index a8df5ce2ab..e01f992884 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -440,19 +440,19 @@ void bitmap_writer_select_commits(struct commit **indexed_commits,
 }
 
 
-static int sha1write_ewah_helper(void *f, const void *buf, size_t len)
+static int hashwrite_ewah_helper(void *f, const void *buf, size_t len)
 {
-	/* sha1write will die on error */
-	sha1write(f, buf, len);
+	/* hashwrite will die on error */
+	hashwrite(f, buf, len);
 	return len;
 }
 
 /**
  * Write the bitmap index to disk
  */
-static inline void dump_bitmap(struct sha1file *f, struct ewah_bitmap *bitmap)
+static inline void dump_bitmap(struct hashfile *f, struct ewah_bitmap *bitmap)
 {
-	if (ewah_serialize_to(bitmap, sha1write_ewah_helper, f) < 0)
+	if (ewah_serialize_to(bitmap, hashwrite_ewah_helper, f) < 0)
 		die("Failed to write bitmap index");
 }
 
@@ -462,7 +462,7 @@ static const unsigned char *sha1_access(size_t pos, void *table)
 	return index[pos]->oid.hash;
 }
 
-static void write_selected_commits_v1(struct sha1file *f,
+static void write_selected_commits_v1(struct hashfile *f,
 				      struct pack_idx_entry **index,
 				      uint32_t index_nr)
 {
@@ -477,15 +477,15 @@ static void write_selected_commits_v1(struct sha1file *f,
 		if (commit_pos < 0)
 			die("BUG: trying to write commit not in index");
 
-		sha1write_be32(f, commit_pos);
-		sha1write_u8(f, stored->xor_offset);
-		sha1write_u8(f, stored->flags);
+		hashwrite_be32(f, commit_pos);
+		hashwrite_u8(f, stored->xor_offset);
+		hashwrite_u8(f, stored->flags);
 
 		dump_bitmap(f, stored->write_as);
 	}
 }
 
-static void write_hash_cache(struct sha1file *f,
+static void write_hash_cache(struct hashfile *f,
 			     struct pack_idx_entry **index,
 			     uint32_t index_nr)
 {
@@ -494,7 +494,7 @@ static void write_hash_cache(struct sha1file *f,
 	for (i = 0; i < index_nr; ++i) {
 		struct object_entry *entry = (struct object_entry *)index[i];
 		uint32_t hash_value = htonl(entry->hash);
-		sha1write(f, &hash_value, sizeof(hash_value));
+		hashwrite(f, &hash_value, sizeof(hash_value));
 	}
 }
 
@@ -511,13 +511,13 @@ void bitmap_writer_finish(struct pack_idx_entry **index,
 	static uint16_t default_version = 1;
 	static uint16_t flags = BITMAP_OPT_FULL_DAG;
 	struct strbuf tmp_file = STRBUF_INIT;
-	struct sha1file *f;
+	struct hashfile *f;
 
 	struct bitmap_disk_header header;
 
 	int fd = odb_mkstemp(&tmp_file, "pack/tmp_bitmap_XXXXXX");
 
-	f = sha1fd(fd, tmp_file.buf);
+	f = hashfd(fd, tmp_file.buf);
 
 	memcpy(header.magic, BITMAP_IDX_SIGNATURE, sizeof(BITMAP_IDX_SIGNATURE));
 	header.version = htons(default_version);
@@ -525,7 +525,7 @@ void bitmap_writer_finish(struct pack_idx_entry **index,
 	header.entry_count = htonl(writer.selected_nr);
 	hashcpy(header.checksum, writer.pack_checksum);
 
-	sha1write(f, &header, sizeof(header));
+	hashwrite(f, &header, sizeof(header));
 	dump_bitmap(f, writer.commits);
 	dump_bitmap(f, writer.trees);
 	dump_bitmap(f, writer.blobs);
@@ -535,7 +535,7 @@ void bitmap_writer_finish(struct pack_idx_entry **index,
 	if (options & BITMAP_OPT_HASH_CACHE)
 		write_hash_cache(f, index, index_nr);
 
-	sha1close(f, NULL, CSUM_FSYNC);
+	hashclose(f, NULL, CSUM_FSYNC);
 
 	if (adjust_shared_perm(tmp_file.buf))
 		die_errno("unable to make temporary bitmap file readable");
diff --git a/pack-write.c b/pack-write.c
index 5317678c29..d775c7406d 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -46,7 +46,7 @@ const char *write_idx_file(const char *index_name, struct pack_idx_entry **objec
 			   int nr_objects, const struct pack_idx_option *opts,
 			   const unsigned char *sha1)
 {
-	struct sha1file *f;
+	struct hashfile *f;
 	struct pack_idx_entry **sorted_by_sha, **list, **last;
 	off_t last_obj_offset = 0;
 	uint32_t array[256];
@@ -68,7 +68,7 @@ const char *write_idx_file(const char *index_name, struct pack_idx_entry **objec
 
 	if (opts->flags & WRITE_IDX_VERIFY) {
 		assert(index_name);
-		f = sha1fd_check(index_name);
+		f = hashfd_check(index_name);
 	} else {
 		if (!index_name) {
 			struct strbuf tmp_file = STRBUF_INIT;
@@ -80,7 +80,7 @@ const char *write_idx_file(const char *index_name, struct pack_idx_entry **objec
 			if (fd < 0)
 				die_errno("unable to create '%s'", index_name);
 		}
-		f = sha1fd(fd, index_name);
+		f = hashfd(fd, index_name);
 	}
 
 	/* if last object's offset is >= 2^31 we should use index V2 */
@@ -91,7 +91,7 @@ const char *write_idx_file(const char *index_name, struct pack_idx_entry **objec
 		struct pack_idx_header hdr;
 		hdr.idx_signature = htonl(PACK_IDX_SIGNATURE);
 		hdr.idx_version = htonl(index_version);
-		sha1write(f, &hdr, sizeof(hdr));
+		hashwrite(f, &hdr, sizeof(hdr));
 	}
 
 	/*
@@ -110,7 +110,7 @@ const char *write_idx_file(const char *index_name, struct pack_idx_entry **objec
 		array[i] = htonl(next - sorted_by_sha);
 		list = next;
 	}
-	sha1write(f, array, 256 * 4);
+	hashwrite(f, array, 256 * 4);
 
 	/*
 	 * Write the actual SHA1 entries..
@@ -120,9 +120,9 @@ const char *write_idx_file(const char *index_name, struct pack_idx_entry **objec
 		struct pack_idx_entry *obj = *list++;
 		if (index_version < 2) {
 			uint32_t offset = htonl(obj->offset);
-			sha1write(f, &offset, 4);
+			hashwrite(f, &offset, 4);
 		}
-		sha1write(f, obj->oid.hash, the_hash_algo->rawsz);
+		hashwrite(f, obj->oid.hash, the_hash_algo->rawsz);
 		if ((opts->flags & WRITE_IDX_STRICT) &&
 		    (i && !oidcmp(&list[-2]->oid, &obj->oid)))
 			die("The same object %s appears twice in the pack",
@@ -137,7 +137,7 @@ const char *write_idx_file(const char *index_name, struct pack_idx_entry **objec
 		for (i = 0; i < nr_objects; i++) {
 			struct pack_idx_entry *obj = *list++;
 			uint32_t crc32_val = htonl(obj->crc32);
-			sha1write(f, &crc32_val, 4);
+			hashwrite(f, &crc32_val, 4);
 		}
 
 		/* write the 32-bit offset table */
@@ -150,7 +150,7 @@ const char *write_idx_file(const char *index_name, struct pack_idx_entry **objec
 				  ? (0x80000000 | nr_large_offset++)
 				  : obj->offset);
 			offset = htonl(offset);
-			sha1write(f, &offset, 4);
+			hashwrite(f, &offset, 4);
 		}
 
 		/* write the large offset table */
@@ -164,25 +164,25 @@ const char *write_idx_file(const char *index_name, struct pack_idx_entry **objec
 				continue;
 			split[0] = htonl(offset >> 32);
 			split[1] = htonl(offset & 0xffffffff);
-			sha1write(f, split, 8);
+			hashwrite(f, split, 8);
 			nr_large_offset--;
 		}
 	}
 
-	sha1write(f, sha1, the_hash_algo->rawsz);
-	sha1close(f, NULL, ((opts->flags & WRITE_IDX_VERIFY)
+	hashwrite(f, sha1, the_hash_algo->rawsz);
+	hashclose(f, NULL, ((opts->flags & WRITE_IDX_VERIFY)
 			    ? CSUM_CLOSE : CSUM_FSYNC));
 	return index_name;
 }
 
-off_t write_pack_header(struct sha1file *f, uint32_t nr_entries)
+off_t write_pack_header(struct hashfile *f, uint32_t nr_entries)
 {
 	struct pack_header hdr;
 
 	hdr.hdr_signature = htonl(PACK_SIGNATURE);
 	hdr.hdr_version = htonl(PACK_VERSION);
 	hdr.hdr_entries = htonl(nr_entries);
-	sha1write(f, &hdr, sizeof(hdr));
+	hashwrite(f, &hdr, sizeof(hdr));
 	return sizeof(hdr);
 }
 
@@ -333,14 +333,14 @@ int encode_in_pack_object_header(unsigned char *hdr, int hdr_len,
 	return n;
 }
 
-struct sha1file *create_tmp_packfile(char **pack_tmp_name)
+struct hashfile *create_tmp_packfile(char **pack_tmp_name)
 {
 	struct strbuf tmpname = STRBUF_INIT;
 	int fd;
 
 	fd = odb_mkstemp(&tmpname, "pack/tmp_pack_XXXXXX");
 	*pack_tmp_name = strbuf_detach(&tmpname, NULL);
-	return sha1fd(fd, *pack_tmp_name);
+	return hashfd(fd, *pack_tmp_name);
 }
 
 void finish_tmp_packfile(struct strbuf *name_buffer,
diff --git a/pack.h b/pack.h
index 8294341af1..34a9d458b4 100644
--- a/pack.h
+++ b/pack.h
@@ -81,7 +81,7 @@ extern const char *write_idx_file(const char *index_name, struct pack_idx_entry
 extern int check_pack_crc(struct packed_git *p, struct pack_window **w_curs, off_t offset, off_t len, unsigned int nr);
 extern int verify_pack_index(struct packed_git *);
 extern int verify_pack(struct packed_git *, verify_fn fn, struct progress *, uint32_t);
-extern off_t write_pack_header(struct sha1file *f, uint32_t);
+extern off_t write_pack_header(struct hashfile *f, uint32_t);
 extern void fixup_pack_header_footer(int, unsigned char *, const char *, uint32_t, unsigned char *, off_t);
 extern char *index_pack_lockfile(int fd);
 
@@ -98,7 +98,7 @@ extern int encode_in_pack_object_header(unsigned char *hdr, int hdr_len,
 #define PH_ERROR_PROTOCOL	(-3)
 extern int read_pack_header(int fd, struct pack_header *);
 
-extern struct sha1file *create_tmp_packfile(char **pack_tmp_name);
+extern struct hashfile *create_tmp_packfile(char **pack_tmp_name);
 extern void finish_tmp_packfile(struct strbuf *name_buffer, const char *pack_tmp_name, struct pack_idx_entry **written_list, uint32_t nr_written, struct pack_idx_option *pack_idx_opts, unsigned char sha1[]);
 
 #endif
