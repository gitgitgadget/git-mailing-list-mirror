Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B7CBE82CCC
	for <git@archiver.kernel.org>; Wed, 27 Sep 2023 19:56:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjI0T4H (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Sep 2023 15:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjI0Tz6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2023 15:55:58 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE502114
        for <git@vger.kernel.org>; Wed, 27 Sep 2023 12:55:56 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-79f9acc857cso368627139f.2
        for <git@vger.kernel.org>; Wed, 27 Sep 2023 12:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695844556; x=1696449356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4i2Jw7pqjoHrhMzhVxMpNs0CcVLc0Uwjk9WWF7/oAwE=;
        b=nqEH8majcXvaZO61oXChHpDvaeyMVb3q1ClZwwLhxP/ygkn4PDwOzMo9laEQFIgOW9
         vRCyeuE9euaiSEix3dAH4st4JnwWgZoMFd69c4oAfhDmLHx/jtdH2kLxdCZWjZEW9xMV
         KGY51EIj9W7gOp85fgb3nADMfO91+ecwhU/ujAchUw57aa50zm2pGNLQO5UDMRpij3yT
         L5fL4UHrG4zKXxjmmg4IkLach/Of/HJtu6qlq95ZnCCBEqpXkRx7tVot9jJNEeVRvIEl
         yjOL6mnm2MIQy2QCsSWxEjBI124ka0MgN+wUFH/xngKYuC1AX1FqCtlCoQW97fODpJWB
         B7Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695844556; x=1696449356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4i2Jw7pqjoHrhMzhVxMpNs0CcVLc0Uwjk9WWF7/oAwE=;
        b=trWO4R7KXudYLwGVGbvlHb2cKfv7rq0sj+7keAHz9P0rEyoXmbyp52RYDrDifE7mtk
         1zqsXYByMI2zSQ7hB4vd/4+j7GJoJSqOWjB9b/r6Zcm8HebFHlfaqXmpc6uaBpRUe7qG
         BwJOoR7GsQqL/25JwzeN0XVaDHppiraFrAzqtiWjcx09wafXf0GKXKqXyQH/PtS1HIch
         ZJ70qy2gj0BXfATkocVLeB43GIKClXjaITKJVhg1fjRzkDRcz4aPSXFf20Wk2LRQEXKZ
         bVDndguD96QEUiYvBxVS14cukB/RdX8tHlygqOOP6MFSkQBfGpemSBA37teWdTtwybvL
         +DGg==
X-Gm-Message-State: AOJu0YzbR/A2jkEY4p/CEIOBVUdyngEv1APgyj8skl2wU5qRKJDe1IHj
        bdpU0EGgCSo3uqApSc6iY7w=
X-Google-Smtp-Source: AGHT+IHZvDkNj7emj5Nys30kIQ8rkf7cpmcwXbIt4Pm2uhQZAsOA70WBHBHAgFyjff8/ZM6k2AZLWg==
X-Received: by 2002:a5e:dd48:0:b0:79a:bbd2:8f5a with SMTP id u8-20020a5edd48000000b0079abbd28f5amr3542773iop.12.1695844556076;
        Wed, 27 Sep 2023 12:55:56 -0700 (PDT)
Received: from localhost.localdomain (ip68-227-168-167.om.om.cox.net. [68.227.168.167])
        by smtp.gmail.com with ESMTPSA id o23-20020a6b5a17000000b007836c7e8dccsm2935628iob.17.2023.09.27.12.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 12:55:55 -0700 (PDT)
From:   "Eric W. Biederman" <ebiederm@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 07/30] object-file: Update the loose object map when writing loose objects
Date:   Wed, 27 Sep 2023 14:55:14 -0500
Message-Id: <20230927195537.1682-7-ebiederm@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <87jzsbjt0a.fsf@gmail.froward.int.ebiederm.org>
References: <87jzsbjt0a.fsf@gmail.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Eric W. Biederman" <ebiederm@xmission.com>

To implement SHA1 compatibility on SHA256 repositories the loose
object map needs to be updated whenver a loose object is written.
Updating the loose object map this way allows git to support
the old hash algorithm in constant time.

The functions write_loose_object, and stream_loose_object are
the only two functions that write to the loose object store.

Update stream_loose_object to compute the compatibiilty hash, update
the loose object, and then call repo_add_loose_object_map to update
the loose object map.

Update write_object_file_flags to convert the object into
it's compatibility encoding, hash the compatibility encoding,
write the object, and then update the loose object map.

Update force_object_loose to lookup the hash of the compatibility
encoding, write the loose object, and then update the loose object
map.

Update write_object_file_literally to convert the object into it's
compatibility hash encoding, hash the compatibility enconding, write
the object, and then update the loose object map, when the type string
is a known type.  For objects with an unknown type this results in a
partially broken repository, as the objects are not mapped.

The point of write_object_file_literally is to generate a partially
broken repository for testing.  For testing skipping writing the loose
object map is much more useful than refusing to write the broken
object at all.

Except that the loose objects are updated before the loose object map
I have not done any analysis to see how robust this scheme is in the
event of failure.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 object-file.c | 113 ++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 95 insertions(+), 18 deletions(-)

diff --git a/object-file.c b/object-file.c
index 7c7afe579364..4ad31f25c555 100644
--- a/object-file.c
+++ b/object-file.c
@@ -43,6 +43,8 @@
 #include "setup.h"
 #include "submodule.h"
 #include "fsck.h"
+#include "loose.h"
+#include "object-file-convert.h"
 
 /* The maximum size for an object header. */
 #define MAX_HEADER_LEN 32
@@ -1952,9 +1954,12 @@ static int start_loose_object_common(struct strbuf *tmp_file,
 				     const char *filename, unsigned flags,
 				     git_zstream *stream,
 				     unsigned char *buf, size_t buflen,
-				     git_hash_ctx *c,
+				     git_hash_ctx *c, git_hash_ctx *compat_c,
 				     char *hdr, int hdrlen)
 {
+	struct repository *repo = the_repository;
+	const struct git_hash_algo *algo = repo->hash_algo;
+	const struct git_hash_algo *compat = repo->compat_hash_algo;
 	int fd;
 
 	fd = create_tmpfile(tmp_file, filename);
@@ -1974,14 +1979,18 @@ static int start_loose_object_common(struct strbuf *tmp_file,
 	git_deflate_init(stream, zlib_compression_level);
 	stream->next_out = buf;
 	stream->avail_out = buflen;
-	the_hash_algo->init_fn(c);
+	algo->init_fn(c);
+	if (compat && compat_c)
+		compat->init_fn(compat_c);
 
 	/*  Start to feed header to zlib stream */
 	stream->next_in = (unsigned char *)hdr;
 	stream->avail_in = hdrlen;
 	while (git_deflate(stream, 0) == Z_OK)
 		; /* nothing */
-	the_hash_algo->update_fn(c, hdr, hdrlen);
+	algo->update_fn(c, hdr, hdrlen);
+	if (compat && compat_c)
+		compat->update_fn(compat_c, hdr, hdrlen);
 
 	return fd;
 }
@@ -1990,16 +1999,21 @@ static int start_loose_object_common(struct strbuf *tmp_file,
  * Common steps for the inner git_deflate() loop for writing loose
  * objects. Returns what git_deflate() returns.
  */
-static int write_loose_object_common(git_hash_ctx *c,
+static int write_loose_object_common(git_hash_ctx *c, git_hash_ctx *compat_c,
 				     git_zstream *stream, const int flush,
 				     unsigned char *in0, const int fd,
 				     unsigned char *compressed,
 				     const size_t compressed_len)
 {
+	struct repository *repo = the_repository;
+	const struct git_hash_algo *algo = repo->hash_algo;
+	const struct git_hash_algo *compat = repo->compat_hash_algo;
 	int ret;
 
 	ret = git_deflate(stream, flush ? Z_FINISH : 0);
-	the_hash_algo->update_fn(c, in0, stream->next_in - in0);
+	algo->update_fn(c, in0, stream->next_in - in0);
+	if (compat && compat_c)
+		compat->update_fn(compat_c, in0, stream->next_in - in0);
 	if (write_in_full(fd, compressed, stream->next_out - compressed) < 0)
 		die_errno(_("unable to write loose object file"));
 	stream->next_out = compressed;
@@ -2014,15 +2028,21 @@ static int write_loose_object_common(git_hash_ctx *c,
  * - End the compression of zlib stream.
  * - Get the calculated oid to "oid".
  */
-static int end_loose_object_common(git_hash_ctx *c, git_zstream *stream,
-				   struct object_id *oid)
+static int end_loose_object_common(git_hash_ctx *c, git_hash_ctx *compat_c,
+				   git_zstream *stream, struct object_id *oid,
+				   struct object_id *compat_oid)
 {
+	struct repository *repo = the_repository;
+	const struct git_hash_algo *algo = repo->hash_algo;
+	const struct git_hash_algo *compat = repo->compat_hash_algo;
 	int ret;
 
 	ret = git_deflate_end_gently(stream);
 	if (ret != Z_OK)
 		return ret;
-	the_hash_algo->final_oid_fn(oid, c);
+	algo->final_oid_fn(oid, c);
+	if (compat && compat_c)
+		compat->final_oid_fn(compat_oid, compat_c);
 
 	return Z_OK;
 }
@@ -2046,7 +2066,7 @@ static int write_loose_object(const struct object_id *oid, char *hdr,
 
 	fd = start_loose_object_common(&tmp_file, filename.buf, flags,
 				       &stream, compressed, sizeof(compressed),
-				       &c, hdr, hdrlen);
+				       &c, NULL, hdr, hdrlen);
 	if (fd < 0)
 		return -1;
 
@@ -2056,14 +2076,14 @@ static int write_loose_object(const struct object_id *oid, char *hdr,
 	do {
 		unsigned char *in0 = stream.next_in;
 
-		ret = write_loose_object_common(&c, &stream, 1, in0, fd,
+		ret = write_loose_object_common(&c, NULL, &stream, 1, in0, fd,
 						compressed, sizeof(compressed));
 	} while (ret == Z_OK);
 
 	if (ret != Z_STREAM_END)
 		die(_("unable to deflate new object %s (%d)"), oid_to_hex(oid),
 		    ret);
-	ret = end_loose_object_common(&c, &stream, &parano_oid);
+	ret = end_loose_object_common(&c, NULL, &stream, &parano_oid, NULL);
 	if (ret != Z_OK)
 		die(_("deflateEnd on object %s failed (%d)"), oid_to_hex(oid),
 		    ret);
@@ -2108,10 +2128,12 @@ static int freshen_packed_object(const struct object_id *oid)
 int stream_loose_object(struct input_stream *in_stream, size_t len,
 			struct object_id *oid)
 {
+	const struct git_hash_algo *compat = the_repository->compat_hash_algo;
+	struct object_id compat_oid;
 	int fd, ret, err = 0, flush = 0;
 	unsigned char compressed[4096];
 	git_zstream stream;
-	git_hash_ctx c;
+	git_hash_ctx c, compat_c;
 	struct strbuf tmp_file = STRBUF_INIT;
 	struct strbuf filename = STRBUF_INIT;
 	int dirlen;
@@ -2135,7 +2157,7 @@ int stream_loose_object(struct input_stream *in_stream, size_t len,
 	 */
 	fd = start_loose_object_common(&tmp_file, filename.buf, 0,
 				       &stream, compressed, sizeof(compressed),
-				       &c, hdr, hdrlen);
+				       &c, &compat_c, hdr, hdrlen);
 	if (fd < 0) {
 		err = -1;
 		goto cleanup;
@@ -2153,7 +2175,7 @@ int stream_loose_object(struct input_stream *in_stream, size_t len,
 			if (in_stream->is_finished)
 				flush = 1;
 		}
-		ret = write_loose_object_common(&c, &stream, flush, in0, fd,
+		ret = write_loose_object_common(&c, &compat_c, &stream, flush, in0, fd,
 						compressed, sizeof(compressed));
 		/*
 		 * Unlike write_loose_object(), we do not have the entire
@@ -2176,7 +2198,7 @@ int stream_loose_object(struct input_stream *in_stream, size_t len,
 	 */
 	if (ret != Z_STREAM_END)
 		die(_("unable to stream deflate new object (%d)"), ret);
-	ret = end_loose_object_common(&c, &stream, oid);
+	ret = end_loose_object_common(&c, &compat_c, &stream, oid, &compat_oid);
 	if (ret != Z_OK)
 		die(_("deflateEnd on stream object failed (%d)"), ret);
 	close_loose_object(fd, tmp_file.buf);
@@ -2203,6 +2225,8 @@ int stream_loose_object(struct input_stream *in_stream, size_t len,
 	}
 
 	err = finalize_object_file(tmp_file.buf, filename.buf);
+	if (!err && compat)
+		err = repo_add_loose_object_map(the_repository, oid, &compat_oid);
 cleanup:
 	strbuf_release(&tmp_file);
 	strbuf_release(&filename);
@@ -2213,17 +2237,38 @@ int write_object_file_flags(const void *buf, unsigned long len,
 			    enum object_type type, struct object_id *oid,
 			    unsigned flags)
 {
+	struct repository *repo = the_repository;
+	const struct git_hash_algo *algo = repo->hash_algo;
+	const struct git_hash_algo *compat = repo->compat_hash_algo;
+	struct object_id compat_oid;
 	char hdr[MAX_HEADER_LEN];
 	int hdrlen = sizeof(hdr);
 
+	/* Generate compat_oid */
+	if (compat) {
+		if (type == OBJ_BLOB)
+			hash_object_file(compat, buf, len, type, &compat_oid);
+		else {
+			struct strbuf converted = STRBUF_INIT;
+			convert_object_file(&converted, algo, compat,
+					    buf, len, type, 0);
+			hash_object_file(compat, converted.buf, converted.len,
+					 type, &compat_oid);
+			strbuf_release(&converted);
+		}
+	}
+
 	/* Normally if we have it in the pack then we do not bother writing
 	 * it out into .git/objects/??/?{38} file.
 	 */
-	write_object_file_prepare(the_hash_algo, buf, len, type, oid, hdr,
-				  &hdrlen);
+	write_object_file_prepare(algo, buf, len, type, oid, hdr, &hdrlen);
 	if (freshen_packed_object(oid) || freshen_loose_object(oid))
 		return 0;
-	return write_loose_object(oid, hdr, hdrlen, buf, len, 0, flags);
+	if (write_loose_object(oid, hdr, hdrlen, buf, len, 0, flags))
+		return -1;
+	if (compat)
+		return repo_add_loose_object_map(repo, oid, &compat_oid);
+	return 0;
 }
 
 int write_object_file_literally(const void *buf, unsigned long len,
@@ -2231,7 +2276,27 @@ int write_object_file_literally(const void *buf, unsigned long len,
 				unsigned flags)
 {
 	char *header;
+	struct repository *repo = the_repository;
+	const struct git_hash_algo *algo = repo->hash_algo;
+	const struct git_hash_algo *compat = repo->compat_hash_algo;
+	struct object_id compat_oid;
 	int hdrlen, status = 0;
+	int compat_type = -1;
+
+	if (compat) {
+		compat_type = type_from_string_gently(type, -1, 1);
+		if (compat_type == OBJ_BLOB)
+			hash_object_file(compat, buf, len, compat_type,
+					 &compat_oid);
+		else if (compat_type != -1) {
+			struct strbuf converted = STRBUF_INIT;
+			convert_object_file(&converted, algo, compat,
+					    buf, len, compat_type, 0);
+			hash_object_file(compat, converted.buf, converted.len,
+					 compat_type, &compat_oid);
+			strbuf_release(&converted);
+		}
+	}
 
 	/* type string, SP, %lu of the length plus NUL must fit this */
 	hdrlen = strlen(type) + MAX_HEADER_LEN;
@@ -2244,6 +2309,8 @@ int write_object_file_literally(const void *buf, unsigned long len,
 	if (freshen_packed_object(oid) || freshen_loose_object(oid))
 		goto cleanup;
 	status = write_loose_object(oid, header, hdrlen, buf, len, 0, 0);
+	if (compat_type != -1)
+		return repo_add_loose_object_map(repo, oid, &compat_oid);
 
 cleanup:
 	free(header);
@@ -2252,9 +2319,12 @@ int write_object_file_literally(const void *buf, unsigned long len,
 
 int force_object_loose(const struct object_id *oid, time_t mtime)
 {
+	struct repository *repo = the_repository;
+	const struct git_hash_algo *compat = repo->compat_hash_algo;
 	void *buf;
 	unsigned long len;
 	struct object_info oi = OBJECT_INFO_INIT;
+	struct object_id compat_oid;
 	enum object_type type;
 	char hdr[MAX_HEADER_LEN];
 	int hdrlen;
@@ -2267,8 +2337,15 @@ int force_object_loose(const struct object_id *oid, time_t mtime)
 	oi.contentp = &buf;
 	if (oid_object_info_extended(the_repository, oid, &oi, 0))
 		return error(_("cannot read object for %s"), oid_to_hex(oid));
+	if (compat) {
+		if (repo_oid_to_algop(repo, oid, compat, &compat_oid))
+			return error(_("cannot map object %s to %s"),
+				     oid_to_hex(oid), compat->name);
+	}
 	hdrlen = format_object_header(hdr, sizeof(hdr), type, len);
 	ret = write_loose_object(oid, hdr, hdrlen, buf, len, mtime, 0);
+	if (!ret && compat)
+		ret = repo_add_loose_object_map(the_repository, oid, &compat_oid);
 	free(buf);
 
 	return ret;
-- 
2.41.0

