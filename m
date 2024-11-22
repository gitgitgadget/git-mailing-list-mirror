Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B61176FD2
	for <git@vger.kernel.org>; Fri, 22 Nov 2024 08:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732263935; cv=none; b=oab6C5zNq0DZzqEdyBMgSVZeNIZGny+ucaS/Qfwxv1Z+8Qg9cifTpt9wkE0yk5+L2kfpQ9aYT6aM8Op6blkwiBb8/RVt/T5fXzmdPt19XgRrA4cIgDcLYWrENC7KUz78wcCTKUIjhyiQPx8VwiAEza8Wm/4eCtuvpxRA70vIqDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732263935; c=relaxed/simple;
	bh=sFklhKZdnvUe7/U9OHrsivot9tuFe2zYXT0UJUBWc1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GXnRYmvJ1ol6HmDS2jW3TZWzfTFKFvjxuR4gngGYWNZ8MauCNGkYBnBoP/Vvn/70MITvcQOPIdRgHwGE84wI7YVXIWytsxNJ9526RDsQQo8p2WTpe2DY5TE99GIQv75RG4p1hjm+1TzoqAXm8EX7hP+2rbrZgiNIznXakSNWuSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=MFKeoh3z; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="MFKeoh3z"
Received: (qmail 10068 invoked by uid 109); 22 Nov 2024 08:25:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=sFklhKZdnvUe7/U9OHrsivot9tuFe2zYXT0UJUBWc1w=; b=MFKeoh3z2uO45hYdzOCyuD/VYZkmdAmdxaWco8NrEWKcYByiVR29eJledMc3ha2DspmHwq2Vtn+jbDkEqvZrMsrVTajrs0lZwamhPvjF6wImZfR+/PIBNGqMAIJP8HGsTvC2H1euky68j7r28VhxeeinDXmGojCMhQ7NfGW+++VsQWLhOOMJ4iRGI5+cSHQ6sTM8nQL3G8DtVlIHdeLORE+xsrpRFI6i2vFfymC7tJFBcPQkvX9DH1yMfrkA9qFd8bQ8DdkjS3uZ+0o1j2D6lDjSx+Ma2hyGLsLuzlb42gryLUF9GPxOe5eerBdNxMbMcvXQFY2/SqZo0HTDahR1+Q==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 22 Nov 2024 08:25:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1715 invoked by uid 111); 22 Nov 2024 08:25:28 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 22 Nov 2024 03:25:28 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 22 Nov 2024 03:25:23 -0500
From: Jeff King <peff@peff.net>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
	Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/6] hash.h: introduce `unsafe_hash_algo()`
Message-ID: <20241122082523.GB1179306@coredump.intra.peff.net>
References: <cover.1732130001.git.me@ttaylorr.com>
 <17f92dba34bee235177c8100daab49068fe37254.1732130001.git.me@ttaylorr.com>
 <20241121093731.GD602681@coredump.intra.peff.net>
 <Zz_SwuEw-KYM9xJl@tapette.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zz_SwuEw-KYM9xJl@tapette.crustytoothpaste.net>

On Fri, Nov 22, 2024 at 12:39:30AM +0000, brian m. carlson wrote:

> Yeah, I'm also a little nervous about this change with hash_algo_by_ptr.
> I think we had discussed in the other thread about doing something like
> this:
> 
> struct git_hash_algo_fns {
> [...]
>
> I'm not a hard no on the current approach, but I think the above would
> probably be a little safer and harder to misuse.  It would require extra
> patches to convert existing callers, though, but they aren't hugely
> numerous, and the conversion could probably be mostly automated.

Yeah, I was worried about the fallout to callers. But it might be worth
seeing how extensive it is.

...

OK, here's a quick and dirty conversion that applies on top of Taylor's
patches 1 and 2 (and then patches 3 and on would need to adjust to the
new world order).

There are quite a lot of spots that needed to be adjusted, but the most
part it was just s/->\([a-z]\)_fn/->fn.\1/.  (I'll leave adjusting the
unsafe_ variants as an exercise for the reader).

The naming convention was just what I made up, but one nice effect is
that it replaces "_fn" with "fn.", so the line lengths remain the same.
:) It does mean there's a function called "final", which is a keyword in
C++. I don't know if that matters to us or not (I feel like we were
trying to avoid those, but it appears as a function elsewhere, too).

So I dunno. It is a one-time pain, but I think the result harmonizes the
type system with the concept better.

---
 builtin/fast-import.c      |  18 +++---
 builtin/index-pack.c       |  18 +++---
 builtin/patch-id.c         |  10 ++--
 builtin/receive-pack.c     |  22 +++----
 builtin/unpack-objects.c   |  12 ++--
 bulk-checkin.c             |  10 ++--
 csum-file.c                |  18 +++---
 diff.c                     |  28 ++++-----
 hash.h                     |  37 ++++--------
 http-push.c                |   6 +-
 http.c                     |   8 +--
 object-file.c              | 112 +++++++++++++++++++----------------
 pack-check.c               |   6 +-
 pack-write.c               |  20 +++----
 read-cache.c               |  20 +++----
 rerere.c                   |   8 +--
 t/helper/test-hash-speed.c |   6 +-
 t/helper/test-hash.c       |   6 +-
 t/unit-tests/t-hash.c      |   6 +-
 trace2/tr2_sid.c           |   6 +-
 20 files changed, 189 insertions(+), 188 deletions(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 76d5c20f14..b7870d1f1e 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -953,10 +953,10 @@ static int store_object(
 
 	hdrlen = format_object_header((char *)hdr, sizeof(hdr), type,
 				      dat->len);
-	the_hash_algo->init_fn(&c);
-	the_hash_algo->update_fn(&c, hdr, hdrlen);
-	the_hash_algo->update_fn(&c, dat->buf, dat->len);
-	the_hash_algo->final_oid_fn(&oid, &c);
+	the_hash_algo->fn.init(&c);
+	the_hash_algo->fn.update(&c, hdr, hdrlen);
+	the_hash_algo->fn.update(&c, dat->buf, dat->len);
+	the_hash_algo->fn.final_oid(&oid, &c);
 	if (oidout)
 		oidcpy(oidout, &oid);
 
@@ -1101,14 +1101,14 @@ static void stream_blob(uintmax_t len, struct object_id *oidout, uintmax_t mark)
 		|| (pack_size + PACK_SIZE_THRESHOLD + len) < pack_size)
 		cycle_packfile();
 
-	the_hash_algo->init_fn(&checkpoint.ctx);
+	the_hash_algo->fn.init(&checkpoint.ctx);
 	hashfile_checkpoint(pack_file, &checkpoint);
 	offset = checkpoint.offset;
 
 	hdrlen = format_object_header((char *)out_buf, out_sz, OBJ_BLOB, len);
 
-	the_hash_algo->init_fn(&c);
-	the_hash_algo->update_fn(&c, out_buf, hdrlen);
+	the_hash_algo->fn.init(&c);
+	the_hash_algo->fn.update(&c, out_buf, hdrlen);
 
 	crc32_begin(pack_file);
 
@@ -1126,7 +1126,7 @@ static void stream_blob(uintmax_t len, struct object_id *oidout, uintmax_t mark)
 			if (!n && feof(stdin))
 				die("EOF in data (%" PRIuMAX " bytes remaining)", len);
 
-			the_hash_algo->update_fn(&c, in_buf, n);
+			the_hash_algo->fn.update(&c, in_buf, n);
 			s.next_in = in_buf;
 			s.avail_in = n;
 			len -= n;
@@ -1152,7 +1152,7 @@ static void stream_blob(uintmax_t len, struct object_id *oidout, uintmax_t mark)
 		}
 	}
 	git_deflate_end(&s);
-	the_hash_algo->final_oid_fn(&oid, &c);
+	the_hash_algo->fn.final_oid(&oid, &c);
 
 	if (oidout)
 		oidcpy(oidout, &oid);
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 08b340552f..c5b5573edf 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -298,7 +298,7 @@ static void flush(void)
 	if (input_offset) {
 		if (output_fd >= 0)
 			write_or_die(output_fd, input_buffer, input_offset);
-		the_hash_algo->update_fn(&input_ctx, input_buffer, input_offset);
+		the_hash_algo->fn.update(&input_ctx, input_buffer, input_offset);
 		memmove(input_buffer, input_buffer + input_offset, input_len);
 		input_offset = 0;
 	}
@@ -371,7 +371,7 @@ static const char *open_pack_file(const char *pack_name)
 		output_fd = -1;
 		nothread_data.pack_fd = input_fd;
 	}
-	the_hash_algo->init_fn(&input_ctx);
+	the_hash_algo->fn.init(&input_ctx);
 	return pack_name;
 }
 
@@ -476,8 +476,8 @@ static void *unpack_entry_data(off_t offset, unsigned long size,
 
 	if (!is_delta_type(type)) {
 		hdrlen = format_object_header(hdr, sizeof(hdr), type, size);
-		the_hash_algo->init_fn(&c);
-		the_hash_algo->update_fn(&c, hdr, hdrlen);
+		the_hash_algo->fn.init(&c);
+		the_hash_algo->fn.update(&c, hdr, hdrlen);
 	} else
 		oid = NULL;
 	if (type == OBJ_BLOB && size > big_file_threshold)
@@ -497,7 +497,7 @@ static void *unpack_entry_data(off_t offset, unsigned long size,
 		status = git_inflate(&stream, 0);
 		use(input_len - stream.avail_in);
 		if (oid)
-			the_hash_algo->update_fn(&c, last_out, stream.next_out - last_out);
+			the_hash_algo->fn.update(&c, last_out, stream.next_out - last_out);
 		if (buf == fixed_buf) {
 			stream.next_out = buf;
 			stream.avail_out = sizeof(fixed_buf);
@@ -507,7 +507,7 @@ static void *unpack_entry_data(off_t offset, unsigned long size,
 		bad_object(offset, _("inflate returned %d"), status);
 	git_inflate_end(&stream);
 	if (oid)
-		the_hash_algo->final_oid_fn(oid, &c);
+		the_hash_algo->fn.final_oid(oid, &c);
 	return buf == fixed_buf ? NULL : buf;
 }
 
@@ -1256,9 +1256,9 @@ static void parse_pack_objects(unsigned char *hash)
 
 	/* Check pack integrity */
 	flush();
-	the_hash_algo->init_fn(&tmp_ctx);
-	the_hash_algo->clone_fn(&tmp_ctx, &input_ctx);
-	the_hash_algo->final_fn(hash, &tmp_ctx);
+	the_hash_algo->fn.init(&tmp_ctx);
+	the_hash_algo->fn.clone(&tmp_ctx, &input_ctx);
+	the_hash_algo->fn.final(hash, &tmp_ctx);
 	if (!hasheq(fill(the_hash_algo->rawsz), hash, the_repository->hash_algo))
 		die(_("pack is corrupted (SHA1 mismatch)"));
 	use(the_hash_algo->rawsz);
diff --git a/builtin/patch-id.c b/builtin/patch-id.c
index 93b398e391..3bf1367341 100644
--- a/builtin/patch-id.c
+++ b/builtin/patch-id.c
@@ -70,7 +70,7 @@ static int get_one_patchid(struct object_id *next_oid, struct object_id *result,
 	char pre_oid_str[GIT_MAX_HEXSZ + 1], post_oid_str[GIT_MAX_HEXSZ + 1];
 	git_hash_ctx ctx;
 
-	the_hash_algo->init_fn(&ctx);
+	the_hash_algo->fn.init(&ctx);
 	oidclr(result, the_repository->hash_algo);
 
 	while (strbuf_getwholeline(line_buf, stdin, '\n') != EOF) {
@@ -83,7 +83,7 @@ static int get_one_patchid(struct object_id *next_oid, struct object_id *result,
 		    !skip_prefix(line, "From ", &p) &&
 		    starts_with(line, "\\ ") && 12 < strlen(line)) {
 			if (verbatim)
-				the_hash_algo->update_fn(&ctx, line, strlen(line));
+				the_hash_algo->fn.update(&ctx, line, strlen(line));
 			continue;
 		}
 
@@ -102,9 +102,9 @@ static int get_one_patchid(struct object_id *next_oid, struct object_id *result,
 			    starts_with(line, "Binary files")) {
 				diff_is_binary = 1;
 				before = 0;
-				the_hash_algo->update_fn(&ctx, pre_oid_str,
+				the_hash_algo->fn.update(&ctx, pre_oid_str,
 							 strlen(pre_oid_str));
-				the_hash_algo->update_fn(&ctx, post_oid_str,
+				the_hash_algo->fn.update(&ctx, post_oid_str,
 							 strlen(post_oid_str));
 				if (stable)
 					flush_one_hunk(result, &ctx);
@@ -163,7 +163,7 @@ static int get_one_patchid(struct object_id *next_oid, struct object_id *result,
 		/* Add line to hash algo (possibly removing whitespace) */
 		len = verbatim ? strlen(line) : remove_space(line);
 		patchlen += len;
-		the_hash_algo->update_fn(&ctx, line, len);
+		the_hash_algo->fn.update(&ctx, line, len);
 	}
 
 	if (!found_next)
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index ab5b20e39c..b7aa6cc556 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -569,9 +569,9 @@ static void hmac_hash(unsigned char *out,
 	/* RFC 2104 2. (1) */
 	memset(key, '\0', GIT_MAX_BLKSZ);
 	if (the_hash_algo->blksz < key_len) {
-		the_hash_algo->init_fn(&ctx);
-		the_hash_algo->update_fn(&ctx, key_in, key_len);
-		the_hash_algo->final_fn(key, &ctx);
+		the_hash_algo->fn.init(&ctx);
+		the_hash_algo->fn.update(&ctx, key_in, key_len);
+		the_hash_algo->fn.final(key, &ctx);
 	} else {
 		memcpy(key, key_in, key_len);
 	}
@@ -583,16 +583,16 @@ static void hmac_hash(unsigned char *out,
 	}
 
 	/* RFC 2104 2. (3) & (4) */
-	the_hash_algo->init_fn(&ctx);
-	the_hash_algo->update_fn(&ctx, k_ipad, sizeof(k_ipad));
-	the_hash_algo->update_fn(&ctx, text, text_len);
-	the_hash_algo->final_fn(out, &ctx);
+	the_hash_algo->fn.init(&ctx);
+	the_hash_algo->fn.update(&ctx, k_ipad, sizeof(k_ipad));
+	the_hash_algo->fn.update(&ctx, text, text_len);
+	the_hash_algo->fn.final(out, &ctx);
 
 	/* RFC 2104 2. (6) & (7) */
-	the_hash_algo->init_fn(&ctx);
-	the_hash_algo->update_fn(&ctx, k_opad, sizeof(k_opad));
-	the_hash_algo->update_fn(&ctx, out, the_hash_algo->rawsz);
-	the_hash_algo->final_fn(out, &ctx);
+	the_hash_algo->fn.init(&ctx);
+	the_hash_algo->fn.update(&ctx, k_opad, sizeof(k_opad));
+	the_hash_algo->fn.update(&ctx, out, the_hash_algo->rawsz);
+	the_hash_algo->fn.final(out, &ctx);
 }
 
 static char *prepare_push_cert_nonce(const char *path, timestamp_t stamp)
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 02b8d02f63..c263343531 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -67,7 +67,7 @@ static void *fill(int min)
 	if (min > sizeof(buffer))
 		die("cannot fill %d bytes", min);
 	if (offset) {
-		the_hash_algo->update_fn(&ctx, buffer, offset);
+		the_hash_algo->fn.update(&ctx, buffer, offset);
 		memmove(buffer, buffer + offset, len);
 		offset = 0;
 	}
@@ -667,12 +667,12 @@ int cmd_unpack_objects(int argc,
 		/* We don't take any non-flag arguments now.. Maybe some day */
 		usage(unpack_usage);
 	}
-	the_hash_algo->init_fn(&ctx);
+	the_hash_algo->fn.init(&ctx);
 	unpack_all();
-	the_hash_algo->update_fn(&ctx, buffer, offset);
-	the_hash_algo->init_fn(&tmp_ctx);
-	the_hash_algo->clone_fn(&tmp_ctx, &ctx);
-	the_hash_algo->final_oid_fn(&oid, &tmp_ctx);
+	the_hash_algo->fn.update(&ctx, buffer, offset);
+	the_hash_algo->fn.init(&tmp_ctx);
+	the_hash_algo->fn.clone(&tmp_ctx, &ctx);
+	the_hash_algo->fn.final_oid(&oid, &tmp_ctx);
 	if (strict) {
 		write_rest();
 		if (fsck_finish(&fsck_options))
diff --git a/bulk-checkin.c b/bulk-checkin.c
index 2753d5bbe4..7fc545703a 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -193,7 +193,7 @@ static int stream_blob_to_pack(struct bulk_checkin_packfile *state,
 				if (rsize < hsize)
 					hsize = rsize;
 				if (hsize)
-					the_hash_algo->update_fn(ctx, ibuf, hsize);
+					the_hash_algo->fn.update(ctx, ibuf, hsize);
 				*already_hashed_to = offset;
 			}
 			s.next_in = ibuf;
@@ -269,9 +269,9 @@ static int deflate_blob_to_pack(struct bulk_checkin_packfile *state,
 
 	header_len = format_object_header((char *)obuf, sizeof(obuf),
 					  OBJ_BLOB, size);
-	the_hash_algo->init_fn(&ctx);
-	the_hash_algo->update_fn(&ctx, obuf, header_len);
-	the_hash_algo->init_fn(&checkpoint.ctx);
+	the_hash_algo->fn.init(&ctx);
+	the_hash_algo->fn.update(&ctx, obuf, header_len);
+	the_hash_algo->fn.init(&checkpoint.ctx);
 
 	/* Note: idx is non-NULL when we are writing */
 	if ((flags & HASH_WRITE_OBJECT) != 0)
@@ -302,7 +302,7 @@ static int deflate_blob_to_pack(struct bulk_checkin_packfile *state,
 		if (lseek(fd, seekback, SEEK_SET) == (off_t) -1)
 			return error("cannot seek back");
 	}
-	the_hash_algo->final_oid_fn(result_oid, &ctx);
+	the_hash_algo->fn.final_oid(result_oid, &ctx);
 	if (!idx)
 		return 0;
 
diff --git a/csum-file.c b/csum-file.c
index 107bc4c96f..05e20de441 100644
--- a/csum-file.c
+++ b/csum-file.c
@@ -50,7 +50,7 @@ void hashflush(struct hashfile *f)
 
 	if (offset) {
 		if (!f->skip_hash)
-			f->algop->unsafe_update_fn(&f->ctx, f->buffer, offset);
+			f->algop->unsafe_fn.update(&f->ctx, f->buffer, offset);
 		flush(f, f->buffer, offset);
 		f->offset = 0;
 	}
@@ -73,7 +73,7 @@ int finalize_hashfile(struct hashfile *f, unsigned char *result,
 	if (f->skip_hash)
 		hashclr(f->buffer, f->algop);
 	else
-		f->algop->unsafe_final_fn(f->buffer, &f->ctx);
+		f->algop->unsafe_fn.final(f->buffer, &f->ctx);
 
 	if (result)
 		hashcpy(result, f->buffer, f->algop);
@@ -128,7 +128,7 @@ void hashwrite(struct hashfile *f, const void *buf, unsigned int count)
 			 * f->offset is necessarily zero.
 			 */
 			if (!f->skip_hash)
-				f->algop->unsafe_update_fn(&f->ctx, buf, nr);
+				f->algop->unsafe_fn.update(&f->ctx, buf, nr);
 			flush(f, buf, nr);
 		} else {
 			/*
@@ -176,7 +176,7 @@ static struct hashfile *hashfd_internal(int fd, const char *name,
 	f->skip_hash = 0;
 
 	f->algop = the_hash_algo;
-	f->algop->unsafe_init_fn(&f->ctx);
+	f->algop->unsafe_fn.init(&f->ctx);
 
 	f->buffer_len = buffer_len;
 	f->buffer = xmalloc(buffer_len);
@@ -210,7 +210,7 @@ void hashfile_checkpoint(struct hashfile *f, struct hashfile_checkpoint *checkpo
 {
 	hashflush(f);
 	checkpoint->offset = f->total;
-	f->algop->unsafe_clone_fn(&checkpoint->ctx, &f->ctx);
+	f->algop->unsafe_fn.clone(&checkpoint->ctx, &f->ctx);
 }
 
 int hashfile_truncate(struct hashfile *f, struct hashfile_checkpoint *checkpoint)
@@ -221,7 +221,7 @@ int hashfile_truncate(struct hashfile *f, struct hashfile_checkpoint *checkpoint
 	    lseek(f->fd, offset, SEEK_SET) != offset)
 		return -1;
 	f->total = offset;
-	f->algop->unsafe_clone_fn(&f->ctx, &checkpoint->ctx);
+	f->algop->unsafe_fn.clone(&f->ctx, &checkpoint->ctx);
 	f->offset = 0; /* hashflush() was called in checkpoint */
 	return 0;
 }
@@ -248,9 +248,9 @@ int hashfile_checksum_valid(const unsigned char *data, size_t total_len)
 	if (total_len < algop->rawsz)
 		return 0; /* say "too short"? */
 
-	algop->unsafe_init_fn(&ctx);
-	algop->unsafe_update_fn(&ctx, data, data_len);
-	algop->unsafe_final_fn(got, &ctx);
+	algop->unsafe_fn.init(&ctx);
+	algop->unsafe_fn.update(&ctx, data, data_len);
+	algop->unsafe_fn.final(got, &ctx);
 
 	return hasheq(got, data + data_len, algop);
 }
diff --git a/diff.c b/diff.c
index dceac20d18..85d776fa37 100644
--- a/diff.c
+++ b/diff.c
@@ -6413,8 +6413,8 @@ void flush_one_hunk(struct object_id *result, git_hash_ctx *ctx)
 	unsigned short carry = 0;
 	int i;
 
-	the_hash_algo->final_fn(hash, ctx);
-	the_hash_algo->init_fn(ctx);
+	the_hash_algo->fn.final(hash, ctx);
+	the_hash_algo->fn.init(ctx);
 	/* 20-byte sum, with carry */
 	for (i = 0; i < the_hash_algo->rawsz; ++i) {
 		carry += result->hash[i] + hash[i];
@@ -6432,22 +6432,22 @@ static int patch_id_consume(void *priv, char *line, unsigned long len)
 		return 0;
 	new_len = remove_space(line, len);
 
-	the_hash_algo->update_fn(data->ctx, line, new_len);
+	the_hash_algo->fn.update(data->ctx, line, new_len);
 	data->patchlen += new_len;
 	return 0;
 }
 
 static void patch_id_add_string(git_hash_ctx *ctx, const char *str)
 {
-	the_hash_algo->update_fn(ctx, str, strlen(str));
+	the_hash_algo->fn.update(ctx, str, strlen(str));
 }
 
 static void patch_id_add_mode(git_hash_ctx *ctx, unsigned mode)
 {
 	/* large enough for 2^32 in octal */
 	char buf[12];
 	int len = xsnprintf(buf, sizeof(buf), "%06o", mode);
-	the_hash_algo->update_fn(ctx, buf, len);
+	the_hash_algo->fn.update(ctx, buf, len);
 }
 
 /* returns 0 upon success, and writes result into oid */
@@ -6458,7 +6458,7 @@ static int diff_get_patch_id(struct diff_options *options, struct object_id *oid
 	git_hash_ctx ctx;
 	struct patch_id_t data;
 
-	the_hash_algo->init_fn(&ctx);
+	the_hash_algo->fn.init(&ctx);
 	memset(&data, 0, sizeof(struct patch_id_t));
 	data.ctx = &ctx;
 	oidclr(oid, the_repository->hash_algo);
@@ -6491,9 +6491,9 @@ static int diff_get_patch_id(struct diff_options *options, struct object_id *oid
 		len2 = remove_space(p->two->path, strlen(p->two->path));
 		patch_id_add_string(&ctx, "diff--git");
 		patch_id_add_string(&ctx, "a/");
-		the_hash_algo->update_fn(&ctx, p->one->path, len1);
+		the_hash_algo->fn.update(&ctx, p->one->path, len1);
 		patch_id_add_string(&ctx, "b/");
-		the_hash_algo->update_fn(&ctx, p->two->path, len2);
+		the_hash_algo->fn.update(&ctx, p->two->path, len2);
 
 		if (p->one->mode == 0) {
 			patch_id_add_string(&ctx, "newfilemode");
@@ -6512,24 +6512,24 @@ static int diff_get_patch_id(struct diff_options *options, struct object_id *oid
 			/* don't do anything since we're only populating header info */
 		} else if (diff_filespec_is_binary(options->repo, p->one) ||
 		    diff_filespec_is_binary(options->repo, p->two)) {
-			the_hash_algo->update_fn(&ctx, oid_to_hex(&p->one->oid),
+			the_hash_algo->fn.update(&ctx, oid_to_hex(&p->one->oid),
 					the_hash_algo->hexsz);
-			the_hash_algo->update_fn(&ctx, oid_to_hex(&p->two->oid),
+			the_hash_algo->fn.update(&ctx, oid_to_hex(&p->two->oid),
 					the_hash_algo->hexsz);
 		} else {
 			if (p->one->mode == 0) {
 				patch_id_add_string(&ctx, "---/dev/null");
 				patch_id_add_string(&ctx, "+++b/");
-				the_hash_algo->update_fn(&ctx, p->two->path, len2);
+				the_hash_algo->fn.update(&ctx, p->two->path, len2);
 			} else if (p->two->mode == 0) {
 				patch_id_add_string(&ctx, "---a/");
-				the_hash_algo->update_fn(&ctx, p->one->path, len1);
+				the_hash_algo->fn.update(&ctx, p->one->path, len1);
 				patch_id_add_string(&ctx, "+++/dev/null");
 			} else {
 				patch_id_add_string(&ctx, "---a/");
-				the_hash_algo->update_fn(&ctx, p->one->path, len1);
+				the_hash_algo->fn.update(&ctx, p->one->path, len1);
 				patch_id_add_string(&ctx, "+++b/");
-				the_hash_algo->update_fn(&ctx, p->two->path, len2);
+				the_hash_algo->fn.update(&ctx, p->two->path, len2);
 			}
 
 			if (fill_mmfile(options->repo, &mf1, p->one) < 0 ||
diff --git a/hash.h b/hash.h
index 756166ce5e..6107d5b47a 100644
--- a/hash.h
+++ b/hash.h
@@ -267,35 +267,24 @@ struct git_hash_algo {
 	/* The block size of the hash. */
 	size_t blksz;
 
-	/* The hash initialization function. */
-	git_hash_init_fn init_fn;
+	struct git_hash_algo_fns {
+		/* The hash initialization function. */
+		git_hash_init_fn init;
 
-	/* The hash context cloning function. */
-	git_hash_clone_fn clone_fn;
+		/* The hash context cloning function. */
+		git_hash_clone_fn clone;
 
-	/* The hash update function. */
-	git_hash_update_fn update_fn;
+		/* The hash update function. */
+		git_hash_update_fn update;
 
-	/* The hash finalization function. */
-	git_hash_final_fn final_fn;
+		/* The hash finalization function. */
+		git_hash_final_fn final;
 
-	/* The hash finalization function for object IDs. */
-	git_hash_final_oid_fn final_oid_fn;
+		/* The hash finalization function for object IDs. */
+		git_hash_final_oid_fn final_oid;
+	} fn;
 
-	/* The non-cryptographic hash initialization function. */
-	git_hash_init_fn unsafe_init_fn;
-
-	/* The non-cryptographic hash context cloning function. */
-	git_hash_clone_fn unsafe_clone_fn;
-
-	/* The non-cryptographic hash update function. */
-	git_hash_update_fn unsafe_update_fn;
-
-	/* The non-cryptographic hash finalization function. */
-	git_hash_final_fn unsafe_final_fn;
-
-	/* The non-cryptographic hash finalization function. */
-	git_hash_final_oid_fn unsafe_final_oid_fn;
+	struct git_hash_algo_fns unsafe_fn;
 
 	/* The OID of the empty tree. */
 	const struct object_id *empty_tree;
diff --git a/http-push.c b/http-push.c
index 4d24e6b8d4..9659e777d1 100644
--- a/http-push.c
+++ b/http-push.c
@@ -773,9 +773,9 @@ static void handle_new_lock_ctx(struct xml_ctx *ctx, int tag_closed)
 		} else if (!strcmp(ctx->name, DAV_ACTIVELOCK_TOKEN)) {
 			lock->token = xstrdup(ctx->cdata);
 
-			the_hash_algo->init_fn(&hash_ctx);
-			the_hash_algo->update_fn(&hash_ctx, lock->token, strlen(lock->token));
-			the_hash_algo->final_fn(lock_token_hash, &hash_ctx);
+			the_hash_algo->fn.init(&hash_ctx);
+			the_hash_algo->fn.update(&hash_ctx, lock->token, strlen(lock->token));
+			the_hash_algo->fn.final(lock_token_hash, &hash_ctx);
 
 			lock->tmpfile_suffix[0] = '_';
 			memcpy(lock->tmpfile_suffix + 1, hash_to_hex(lock_token_hash), the_hash_algo->hexsz);
diff --git a/http.c b/http.c
index 58242b9d2d..b3f31b52e6 100644
--- a/http.c
+++ b/http.c
@@ -2654,7 +2654,7 @@ static size_t fwrite_sha1_file(char *ptr, size_t eltsize, size_t nmemb,
 		freq->stream.next_out = expn;
 		freq->stream.avail_out = sizeof(expn);
 		freq->zret = git_inflate(&freq->stream, Z_SYNC_FLUSH);
-		the_hash_algo->update_fn(&freq->c, expn,
+		the_hash_algo->fn.update(&freq->c, expn,
 					 sizeof(expn) - freq->stream.avail_out);
 	} while (freq->stream.avail_in && freq->zret == Z_OK);
 	return nmemb;
@@ -2713,7 +2713,7 @@ struct http_object_request *new_http_object_request(const char *base_url,
 
 	git_inflate_init(&freq->stream);
 
-	the_hash_algo->init_fn(&freq->c);
+	the_hash_algo->fn.init(&freq->c);
 
 	freq->url = get_remote_object_url(base_url, hex, 0);
 
@@ -2749,7 +2749,7 @@ struct http_object_request *new_http_object_request(const char *base_url,
 		git_inflate_end(&freq->stream);
 		memset(&freq->stream, 0, sizeof(freq->stream));
 		git_inflate_init(&freq->stream);
-		the_hash_algo->init_fn(&freq->c);
+		the_hash_algo->fn.init(&freq->c);
 		if (prev_posn>0) {
 			prev_posn = 0;
 			lseek(freq->localfile, 0, SEEK_SET);
@@ -2820,7 +2820,7 @@ int finish_http_object_request(struct http_object_request *freq)
 		return -1;
 	}
 
-	the_hash_algo->final_oid_fn(&freq->real_oid, &freq->c);
+	the_hash_algo->fn.final_oid(&freq->real_oid, &freq->c);
 	if (freq->zret != Z_STREAM_END) {
 		unlink_or_warn(freq->tmpfile.buf);
 		return -1;
diff --git a/object-file.c b/object-file.c
index b1a3463852..c8399745d8 100644
--- a/object-file.c
+++ b/object-file.c
@@ -211,16 +211,20 @@ const struct git_hash_algo hash_algos[GIT_HASH_NALGOS] = {
 		.rawsz = 0,
 		.hexsz = 0,
 		.blksz = 0,
-		.init_fn = git_hash_unknown_init,
-		.clone_fn = git_hash_unknown_clone,
-		.update_fn = git_hash_unknown_update,
-		.final_fn = git_hash_unknown_final,
-		.final_oid_fn = git_hash_unknown_final_oid,
-		.unsafe_init_fn = git_hash_unknown_init,
-		.unsafe_clone_fn = git_hash_unknown_clone,
-		.unsafe_update_fn = git_hash_unknown_update,
-		.unsafe_final_fn = git_hash_unknown_final,
-		.unsafe_final_oid_fn = git_hash_unknown_final_oid,
+		.fn = {
+			.init = git_hash_unknown_init,
+			.clone = git_hash_unknown_clone,
+			.update = git_hash_unknown_update,
+			.final = git_hash_unknown_final,
+			.final_oid = git_hash_unknown_final_oid,
+		},
+		.unsafe_fn = {
+			.init = git_hash_unknown_init,
+			.clone = git_hash_unknown_clone,
+			.update = git_hash_unknown_update,
+			.final = git_hash_unknown_final,
+			.final_oid = git_hash_unknown_final_oid,
+		},
 		.empty_tree = NULL,
 		.empty_blob = NULL,
 		.null_oid = NULL,
@@ -231,16 +235,20 @@ const struct git_hash_algo hash_algos[GIT_HASH_NALGOS] = {
 		.rawsz = GIT_SHA1_RAWSZ,
 		.hexsz = GIT_SHA1_HEXSZ,
 		.blksz = GIT_SHA1_BLKSZ,
-		.init_fn = git_hash_sha1_init,
-		.clone_fn = git_hash_sha1_clone,
-		.update_fn = git_hash_sha1_update,
-		.final_fn = git_hash_sha1_final,
-		.final_oid_fn = git_hash_sha1_final_oid,
-		.unsafe_init_fn = git_hash_sha1_init_unsafe,
-		.unsafe_clone_fn = git_hash_sha1_clone_unsafe,
-		.unsafe_update_fn = git_hash_sha1_update_unsafe,
-		.unsafe_final_fn = git_hash_sha1_final_unsafe,
-		.unsafe_final_oid_fn = git_hash_sha1_final_oid_unsafe,
+		.fn = {
+			.init = git_hash_sha1_init,
+			.clone = git_hash_sha1_clone,
+			.update = git_hash_sha1_update,
+			.final = git_hash_sha1_final,
+			.final_oid = git_hash_sha1_final_oid,
+		},
+		.unsafe_fn = {
+			.init = git_hash_sha1_init_unsafe,
+			.clone = git_hash_sha1_clone_unsafe,
+			.update = git_hash_sha1_update_unsafe,
+			.final = git_hash_sha1_final_unsafe,
+			.final_oid = git_hash_sha1_final_oid_unsafe,
+		},
 		.empty_tree = &empty_tree_oid,
 		.empty_blob = &empty_blob_oid,
 		.null_oid = &null_oid_sha1,
@@ -251,16 +259,20 @@ const struct git_hash_algo hash_algos[GIT_HASH_NALGOS] = {
 		.rawsz = GIT_SHA256_RAWSZ,
 		.hexsz = GIT_SHA256_HEXSZ,
 		.blksz = GIT_SHA256_BLKSZ,
-		.init_fn = git_hash_sha256_init,
-		.clone_fn = git_hash_sha256_clone,
-		.update_fn = git_hash_sha256_update,
-		.final_fn = git_hash_sha256_final,
-		.final_oid_fn = git_hash_sha256_final_oid,
-		.unsafe_init_fn = git_hash_sha256_init,
-		.unsafe_clone_fn = git_hash_sha256_clone,
-		.unsafe_update_fn = git_hash_sha256_update,
-		.unsafe_final_fn = git_hash_sha256_final,
-		.unsafe_final_oid_fn = git_hash_sha256_final_oid,
+		.fn = {
+			.init = git_hash_sha256_init,
+			.clone = git_hash_sha256_clone,
+			.update = git_hash_sha256_update,
+			.final = git_hash_sha256_final,
+			.final_oid = git_hash_sha256_final_oid,
+		},
+		.unsafe_fn = {
+			.init = git_hash_sha256_init,
+			.clone = git_hash_sha256_clone,
+			.update = git_hash_sha256_update,
+			.final = git_hash_sha256_final,
+			.final_oid = git_hash_sha256_final_oid,
+		},
 		.empty_tree = &empty_tree_oid_sha256,
 		.empty_blob = &empty_blob_oid_sha256,
 		.null_oid = &null_oid_sha256,
@@ -1185,8 +1197,8 @@ int stream_object_signature(struct repository *r, const struct object_id *oid)
 	hdrlen = format_object_header(hdr, sizeof(hdr), obj_type, size);
 
 	/* Sha1.. */
-	r->hash_algo->init_fn(&c);
-	r->hash_algo->update_fn(&c, hdr, hdrlen);
+	r->hash_algo->fn.init(&c);
+	r->hash_algo->fn.update(&c, hdr, hdrlen);
 	for (;;) {
 		char buf[1024 * 16];
 		ssize_t readlen = read_istream(st, buf, sizeof(buf));
@@ -1197,9 +1209,9 @@ int stream_object_signature(struct repository *r, const struct object_id *oid)
 		}
 		if (!readlen)
 			break;
-		r->hash_algo->update_fn(&c, buf, readlen);
+		r->hash_algo->fn.update(&c, buf, readlen);
 	}
-	r->hash_algo->final_oid_fn(&real_oid, &c);
+	r->hash_algo->fn.final_oid(&real_oid, &c);
 	close_istream(st);
 	return !oideq(oid, &real_oid) ? -1 : 0;
 }
@@ -1943,10 +1955,10 @@ static void hash_object_body(const struct git_hash_algo *algo, git_hash_ctx *c,
 			     struct object_id *oid,
 			     char *hdr, int *hdrlen)
 {
-	algo->init_fn(c);
-	algo->update_fn(c, hdr, *hdrlen);
-	algo->update_fn(c, buf, len);
-	algo->final_oid_fn(oid, c);
+	algo->fn.init(c);
+	algo->fn.update(c, hdr, *hdrlen);
+	algo->fn.update(c, buf, len);
+	algo->fn.final_oid(oid, c);
 }
 
 static void write_object_file_prepare(const struct git_hash_algo *algo,
@@ -2206,18 +2218,18 @@ static int start_loose_object_common(struct strbuf *tmp_file,
 	git_deflate_init(stream, zlib_compression_level);
 	stream->next_out = buf;
 	stream->avail_out = buflen;
-	algo->init_fn(c);
+	algo->fn.init(c);
 	if (compat && compat_c)
-		compat->init_fn(compat_c);
+		compat->fn.init(compat_c);
 
 	/*  Start to feed header to zlib stream */
 	stream->next_in = (unsigned char *)hdr;
 	stream->avail_in = hdrlen;
 	while (git_deflate(stream, 0) == Z_OK)
 		; /* nothing */
-	algo->update_fn(c, hdr, hdrlen);
+	algo->fn.update(c, hdr, hdrlen);
 	if (compat && compat_c)
-		compat->update_fn(compat_c, hdr, hdrlen);
+		compat->fn.update(compat_c, hdr, hdrlen);
 
 	return fd;
 }
@@ -2238,9 +2250,9 @@ static int write_loose_object_common(git_hash_ctx *c, git_hash_ctx *compat_c,
 	int ret;
 
 	ret = git_deflate(stream, flush ? Z_FINISH : 0);
-	algo->update_fn(c, in0, stream->next_in - in0);
+	algo->fn.update(c, in0, stream->next_in - in0);
 	if (compat && compat_c)
-		compat->update_fn(compat_c, in0, stream->next_in - in0);
+		compat->fn.update(compat_c, in0, stream->next_in - in0);
 	if (write_in_full(fd, compressed, stream->next_out - compressed) < 0)
 		die_errno(_("unable to write loose object file"));
 	stream->next_out = compressed;
@@ -2267,9 +2279,9 @@ static int end_loose_object_common(git_hash_ctx *c, git_hash_ctx *compat_c,
 	ret = git_deflate_end_gently(stream);
 	if (ret != Z_OK)
 		return ret;
-	algo->final_oid_fn(oid, c);
+	algo->fn.final_oid(oid, c);
 	if (compat && compat_c)
-		compat->final_oid_fn(compat_oid, compat_c);
+		compat->fn.final_oid(compat_oid, compat_c);
 
 	return Z_OK;
 }
@@ -3027,8 +3039,8 @@ static int check_stream_oid(git_zstream *stream,
 	unsigned long total_read;
 	int status = Z_OK;
 
-	the_hash_algo->init_fn(&c);
-	the_hash_algo->update_fn(&c, hdr, stream->total_out);
+	the_hash_algo->fn.init(&c);
+	the_hash_algo->fn.update(&c, hdr, stream->total_out);
 
 	/*
 	 * We already read some bytes into hdr, but the ones up to the NUL
@@ -3048,7 +3060,7 @@ static int check_stream_oid(git_zstream *stream,
 		if (size - total_read < stream->avail_out)
 			stream->avail_out = size - total_read;
 		status = git_inflate(stream, Z_FINISH);
-		the_hash_algo->update_fn(&c, buf, stream->next_out - buf);
+		the_hash_algo->fn.update(&c, buf, stream->next_out - buf);
 		total_read += stream->next_out - buf;
 	}
 	git_inflate_end(stream);
@@ -3063,7 +3075,7 @@ static int check_stream_oid(git_zstream *stream,
 		return -1;
 	}
 
-	the_hash_algo->final_oid_fn(&real_oid, &c);
+	the_hash_algo->fn.final_oid(&real_oid, &c);
 	if (!oideq(expected_oid, &real_oid)) {
 		error(_("hash mismatch for %s (expected %s)"), path,
 		      oid_to_hex(expected_oid));
diff --git a/pack-check.c b/pack-check.c
index e883dae3f2..2c1c2c54fa 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -67,7 +67,7 @@ static int verify_packfile(struct repository *r,
 	if (!is_pack_valid(p))
 		return error("packfile %s cannot be accessed", p->pack_name);
 
-	r->hash_algo->init_fn(&ctx);
+	r->hash_algo->fn.init(&ctx);
 	do {
 		unsigned long remaining;
 		unsigned char *in = use_pack(p, w_curs, offset, &remaining);
@@ -76,9 +76,9 @@ static int verify_packfile(struct repository *r,
 			pack_sig_ofs = p->pack_size - r->hash_algo->rawsz;
 		if (offset > pack_sig_ofs)
 			remaining -= (unsigned int)(offset - pack_sig_ofs);
-		r->hash_algo->update_fn(&ctx, in, remaining);
+		r->hash_algo->fn.update(&ctx, in, remaining);
 	} while (offset < pack_sig_ofs);
-	r->hash_algo->final_fn(hash, &ctx);
+	r->hash_algo->fn.final(hash, &ctx);
 	pack_sig = use_pack(p, w_curs, pack_sig_ofs, NULL);
 	if (!hasheq(hash, pack_sig, the_repository->hash_algo))
 		err = error("%s pack checksum mismatch",
diff --git a/pack-write.c b/pack-write.c
index 8c7dfddc5a..d202c6c9a4 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -392,8 +392,8 @@ void fixup_pack_header_footer(int pack_fd,
 	char *buf;
 	ssize_t read_result;
 
-	the_hash_algo->init_fn(&old_hash_ctx);
-	the_hash_algo->init_fn(&new_hash_ctx);
+	the_hash_algo->fn.init(&old_hash_ctx);
+	the_hash_algo->fn.init(&new_hash_ctx);
 
 	if (lseek(pack_fd, 0, SEEK_SET) != 0)
 		die_errno("Failed seeking to start of '%s'", pack_name);
@@ -405,9 +405,9 @@ void fixup_pack_header_footer(int pack_fd,
 			  pack_name);
 	if (lseek(pack_fd, 0, SEEK_SET) != 0)
 		die_errno("Failed seeking to start of '%s'", pack_name);
-	the_hash_algo->update_fn(&old_hash_ctx, &hdr, sizeof(hdr));
+	the_hash_algo->fn.update(&old_hash_ctx, &hdr, sizeof(hdr));
 	hdr.hdr_entries = htonl(object_count);
-	the_hash_algo->update_fn(&new_hash_ctx, &hdr, sizeof(hdr));
+	the_hash_algo->fn.update(&new_hash_ctx, &hdr, sizeof(hdr));
 	write_or_die(pack_fd, &hdr, sizeof(hdr));
 	partial_pack_offset -= sizeof(hdr);
 
@@ -422,7 +422,7 @@ void fixup_pack_header_footer(int pack_fd,
 			break;
 		if (n < 0)
 			die_errno("Failed to checksum '%s'", pack_name);
-		the_hash_algo->update_fn(&new_hash_ctx, buf, n);
+		the_hash_algo->fn.update(&new_hash_ctx, buf, n);
 
 		aligned_sz -= n;
 		if (!aligned_sz)
@@ -431,11 +431,11 @@ void fixup_pack_header_footer(int pack_fd,
 		if (!partial_pack_hash)
 			continue;
 
-		the_hash_algo->update_fn(&old_hash_ctx, buf, n);
+		the_hash_algo->fn.update(&old_hash_ctx, buf, n);
 		partial_pack_offset -= n;
 		if (partial_pack_offset == 0) {
 			unsigned char hash[GIT_MAX_RAWSZ];
-			the_hash_algo->final_fn(hash, &old_hash_ctx);
+			the_hash_algo->fn.final(hash, &old_hash_ctx);
 			if (!hasheq(hash, partial_pack_hash,
 				    the_repository->hash_algo))
 				die("Unexpected checksum for %s "
@@ -445,16 +445,16 @@ void fixup_pack_header_footer(int pack_fd,
 			 * pack, which also means making partial_pack_offset
 			 * big enough not to matter anymore.
 			 */
-			the_hash_algo->init_fn(&old_hash_ctx);
+			the_hash_algo->fn.init(&old_hash_ctx);
 			partial_pack_offset = ~partial_pack_offset;
 			partial_pack_offset -= MSB(partial_pack_offset, 1);
 		}
 	}
 	free(buf);
 
 	if (partial_pack_hash)
-		the_hash_algo->final_fn(partial_pack_hash, &old_hash_ctx);
-	the_hash_algo->final_fn(new_pack_hash, &new_hash_ctx);
+		the_hash_algo->fn.final(partial_pack_hash, &old_hash_ctx);
+	the_hash_algo->fn.final(new_pack_hash, &new_hash_ctx);
 	write_or_die(pack_fd, new_pack_hash, the_hash_algo->rawsz);
 	fsync_component_or_die(FSYNC_COMPONENT_PACK, pack_fd, pack_name);
 }
diff --git a/read-cache.c b/read-cache.c
index 01d0b3ad22..5170b07a33 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1736,9 +1736,9 @@ static int verify_hdr(const struct cache_header *hdr, unsigned long size)
 	if (oideq(&oid, null_oid()))
 		return 0;
 
-	the_hash_algo->init_fn(&c);
-	the_hash_algo->update_fn(&c, hdr, size - the_hash_algo->rawsz);
-	the_hash_algo->final_fn(hash, &c);
+	the_hash_algo->fn.init(&c);
+	the_hash_algo->fn.update(&c, hdr, size - the_hash_algo->rawsz);
+	the_hash_algo->fn.final(hash, &c);
 	if (!hasheq(hash, start, the_repository->hash_algo))
 		return error(_("bad index file sha1 signature"));
 	return 0;
@@ -2574,8 +2574,8 @@ static int write_index_ext_header(struct hashfile *f,
 	if (eoie_f) {
 		ext = htonl(ext);
 		sz = htonl(sz);
-		the_hash_algo->update_fn(eoie_f, &ext, sizeof(ext));
-		the_hash_algo->update_fn(eoie_f, &sz, sizeof(sz));
+		the_hash_algo->fn.update(eoie_f, &ext, sizeof(ext));
+		the_hash_algo->fn.update(eoie_f, &sz, sizeof(sz));
 	}
 	return 0;
 }
@@ -2977,7 +2977,7 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 	 */
 	if (offset && record_eoie()) {
 		CALLOC_ARRAY(eoie_c, 1);
-		the_hash_algo->init_fn(eoie_c);
+		the_hash_algo->fn.init(eoie_c);
 	}
 
 	/*
@@ -3616,7 +3616,7 @@ static size_t read_eoie_extension(const char *mmap, size_t mmap_size)
 	 *	 "REUC" + <binary representation of M>)
 	 */
 	src_offset = offset;
-	the_hash_algo->init_fn(&c);
+	the_hash_algo->fn.init(&c);
 	while (src_offset < mmap_size - the_hash_algo->rawsz - EOIE_SIZE_WITH_HEADER) {
 		/* After an array of active_nr index entries,
 		 * there can be arbitrary number of extended
@@ -3632,12 +3632,12 @@ static size_t read_eoie_extension(const char *mmap, size_t mmap_size)
 		if (src_offset + 8 + extsize < src_offset)
 			return 0;
 
-		the_hash_algo->update_fn(&c, mmap + src_offset, 8);
+		the_hash_algo->fn.update(&c, mmap + src_offset, 8);
 
 		src_offset += 8;
 		src_offset += extsize;
 	}
-	the_hash_algo->final_fn(hash, &c);
+	the_hash_algo->fn.final(hash, &c);
 	if (!hasheq(hash, (const unsigned char *)index, the_repository->hash_algo))
 		return 0;
 
@@ -3658,7 +3658,7 @@ static void write_eoie_extension(struct strbuf *sb, git_hash_ctx *eoie_context,
 	strbuf_add(sb, &buffer, sizeof(uint32_t));
 
 	/* hash */
-	the_hash_algo->final_fn(hash, eoie_context);
+	the_hash_algo->fn.final(hash, eoie_context);
 	strbuf_add(sb, hash, the_hash_algo->rawsz);
 }
 
diff --git a/rerere.c b/rerere.c
index d01e98bf65..ef3b58b5c7 100644
--- a/rerere.c
+++ b/rerere.c
@@ -395,10 +395,10 @@ static int handle_conflict(struct strbuf *out, struct rerere_io *io,
 			strbuf_addbuf(out, &two);
 			rerere_strbuf_putconflict(out, '>', marker_size);
 			if (ctx) {
-				the_hash_algo->update_fn(ctx, one.buf ?
+				the_hash_algo->fn.update(ctx, one.buf ?
 							 one.buf : "",
 							 one.len + 1);
-				the_hash_algo->update_fn(ctx, two.buf ?
+				the_hash_algo->fn.update(ctx, two.buf ?
 							 two.buf : "",
 							 two.len + 1);
 			}
@@ -435,7 +435,7 @@ static int handle_path(unsigned char *hash, struct rerere_io *io, int marker_siz
 	struct strbuf buf = STRBUF_INIT, out = STRBUF_INIT;
 	int has_conflicts = 0;
 	if (hash)
-		the_hash_algo->init_fn(&ctx);
+		the_hash_algo->fn.init(&ctx);
 
 	while (!io->getline(&buf, io)) {
 		if (is_cmarker(buf.buf, '<', marker_size)) {
@@ -452,7 +452,7 @@ static int handle_path(unsigned char *hash, struct rerere_io *io, int marker_siz
 	strbuf_release(&out);
 
 	if (hash)
-		the_hash_algo->final_fn(hash, &ctx);
+		the_hash_algo->fn.final(hash, &ctx);
 
 	return has_conflicts;
 }
diff --git a/t/helper/test-hash-speed.c b/t/helper/test-hash-speed.c
index 7de822af51..1fd8cdac79 100644
--- a/t/helper/test-hash-speed.c
+++ b/t/helper/test-hash-speed.c
@@ -5,9 +5,9 @@
 
 static inline void compute_hash(const struct git_hash_algo *algo, git_hash_ctx *ctx, uint8_t *final, const void *p, size_t len)
 {
-	algo->init_fn(ctx);
-	algo->update_fn(ctx, p, len);
-	algo->final_fn(final, ctx);
+	algo->fn.init(ctx);
+	algo->fn.update(ctx, p, len);
+	algo->fn.final(final, ctx);
 }
 
 int cmd__hash_speed(int ac, const char **av)
diff --git a/t/helper/test-hash.c b/t/helper/test-hash.c
index 45d829c908..3e740bc4fb 100644
--- a/t/helper/test-hash.c
+++ b/t/helper/test-hash.c
@@ -27,7 +27,7 @@ int cmd_hash_impl(int ac, const char **av, int algo)
 			die("OOPS");
 	}
 
-	algop->init_fn(&ctx);
+	algop->fn.init(&ctx);
 
 	while (1) {
 		ssize_t sz, this_sz;
@@ -46,9 +46,9 @@ int cmd_hash_impl(int ac, const char **av, int algo)
 		}
 		if (this_sz == 0)
 			break;
-		algop->update_fn(&ctx, buffer, this_sz);
+		algop->fn.update(&ctx, buffer, this_sz);
 	}
-	algop->final_fn(hash, &ctx);
+	algop->fn.final(hash, &ctx);
 
 	if (binary)
 		fwrite(hash, 1, algop->rawsz, stdout);
diff --git a/t/unit-tests/t-hash.c b/t/unit-tests/t-hash.c
index e62647019b..9c1c9bf70b 100644
--- a/t/unit-tests/t-hash.c
+++ b/t/unit-tests/t-hash.c
@@ -15,9 +15,9 @@ static void check_hash_data(const void *data, size_t data_length,
 		unsigned char hash[GIT_MAX_HEXSZ];
 		const struct git_hash_algo *algop = &hash_algos[i];
 
-		algop->init_fn(&ctx);
-		algop->update_fn(&ctx, data, data_length);
-		algop->final_fn(hash, &ctx);
+		algop->fn.init(&ctx);
+		algop->fn.update(&ctx, data, data_length);
+		algop->fn.final(hash, &ctx);
 
 		if (!check_str(hash_to_hex_algop(hash, algop), expected_hashes[i - 1]))
 			test_msg("result does not match with the expected for %s\n", hash_algos[i].name);
diff --git a/trace2/tr2_sid.c b/trace2/tr2_sid.c
index 09c4ef0d17..a7b17abe2b 100644
--- a/trace2/tr2_sid.c
+++ b/trace2/tr2_sid.c
@@ -45,9 +45,9 @@ static void tr2_sid_append_my_sid_component(void)
 	if (xgethostname(hostname, sizeof(hostname)))
 		strbuf_add(&tr2sid_buf, "Localhost", 9);
 	else {
-		algo->init_fn(&ctx);
-		algo->update_fn(&ctx, hostname, strlen(hostname));
-		algo->final_fn(hash, &ctx);
+		algo->fn.init(&ctx);
+		algo->fn.update(&ctx, hostname, strlen(hostname));
+		algo->fn.final(hash, &ctx);
 		hash_to_hex_algop_r(hex, hash, algo);
 		strbuf_addch(&tr2sid_buf, 'H');
 		strbuf_add(&tr2sid_buf, hex, 8);
