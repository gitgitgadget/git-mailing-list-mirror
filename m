Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8883CCE79AC
	for <git@archiver.kernel.org>; Wed, 20 Sep 2023 03:52:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232487AbjITDwj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Sep 2023 23:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232190AbjITDwi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Sep 2023 23:52:38 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8A6AC
        for <git@vger.kernel.org>; Tue, 19 Sep 2023 20:52:32 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-79f292f0ac2so1527439f.1
        for <git@vger.kernel.org>; Tue, 19 Sep 2023 20:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695181951; x=1695786751; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Hf3pDCWbJ+MBtaYdObpvNEZoZ68vTJ3s1Qmkh1lWEQ8=;
        b=XZAcuB1GIE3NbAkr05cRRRtGBxfyfMJqOcflm+jskP0Nc/p5n9wVZyEw8j9yCCLlIq
         u3DZElTv43FJBRuYpsmLyKAct4a+ON2nSjUpkkXtxuJJKQ2OX2HUBzf+4OkGXYLyu0C9
         jJwQfQ49tsZ+6hUFUZGt0XsA4zEz12r47pdngJKIFN1mQDcDiXtaZ51tl8TsmwOCk7sz
         0f239yAkbGTwPkxlOamVk4XjRoeJsvWiuvA1rm8IbCeQYdoFM/uBDpK8A3JblNqJ5xtd
         kbokuPPwbJHQ8KXdQV3bR1n/lVJ3qWfpb8X5Fd0AGOxOADMq0tIXj8MDQY+vTT5r7RbF
         yKbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695181951; x=1695786751;
        h=mime-version:user-agent:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hf3pDCWbJ+MBtaYdObpvNEZoZ68vTJ3s1Qmkh1lWEQ8=;
        b=M1nUutxhv4Ro85olyMlY6DCicl9MNHrCAy7/oxhzZWf1bAqyKwCn9TOXXhD7p19oVx
         VgJhCxy6Bd5QvpWDzNhHR0gnk8lz7n4jApb8cb5Co6AVjKVoZdpfhV+AKzf9ifkyBgJj
         l/OULSbdSJ03/yzmhLs7872jbAWYPF1hIvUz3L+tTeNsEhFIoxQZO5oEwsOVt/PUdox4
         LYXIe+/VomtzvqaRzgwbgMz1Rza5KGYf8LK+uTJmzvBjFyUQ7WyG+zR1z/EIYZepPU6t
         nK7TZ51qS6A92Grl1OHeVJQbAgEmtFoX/n3dirEWXfcsQP/krX6Y+ABG8N5fNchwCaID
         Hdzw==
X-Gm-Message-State: AOJu0YzoWiz55xtHjYHnjl0eBeZKA8QQohkOWPn/xAmMnTJy1KUz5L5+
        Hc7vq0gpqFQKxZvVgSEAo6ldHyc3PfQ=
X-Google-Smtp-Source: AGHT+IFo2k5qEQA8BdPgLhJ/6C4MoDNpQidH52/ONbsaSC1A3TWP6i25IaOZsFf9vI2e7wWjydfJsQ==
X-Received: by 2002:a05:6e02:1bcf:b0:34f:14e5:5c89 with SMTP id x15-20020a056e021bcf00b0034f14e55c89mr4427005ilv.13.1695181951130;
        Tue, 19 Sep 2023 20:52:31 -0700 (PDT)
Received: from gmail.froward.int.ebiederm.org.gmail.com (ip68-227-168-167.om.om.cox.net. [68.227.168.167])
        by smtp.gmail.com with ESMTPSA id fo3-20020a056638648300b0042b39b2289asm3960970jab.102.2023.09.19.20.52.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 20:52:30 -0700 (PDT)
From:   "Eric W. Biederman" <ebiederm@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        <git@vger.kernel.org>
Subject: [PATCH v2] bulk-checkin: only support blobs in index_bulk_checkin
Date:   Tue, 19 Sep 2023 22:52:28 -0500
Message-ID: <878r918ps3.fsf@gmail.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


As the code is written today index_bulk_checkin only accepts blobs.
Remove the enum object_type parameter and rename index_bulk_checkin to
index_blob_bulk_checkin, index_stream to index_blob_stream,
deflate_to_pack to deflate_blob_to_pack, stream_to_pack to
stream_blobk_to_pack, to make this explicit.

Not supporting commits, tags, or trees has no downside as it is not
currently supported now, and commits, tags, and trees being smaller by
design do not have the problem that the problem that index_bulk_checkin
was built to solve.

What is more this is very desiable from the context of the hash function
transition.

For blob objects it is straight forward to compute multiple hash
functions during index_bulk_checkin as the object header and content of
a blob is the same no matter which hash function is being used to
compute the oid of a blob.

For commits, tress, and tags the object header and content that need to
be hashed ard different for different hashes.  Even worse the object
header can not be known until the size of the content that needs to be
hashed is known.  The size of the content that needs to be hashed can
not be known until a complete pass is made through all of the variable
length entries of the original object.

As far as I can tell this extra pass defeats most of the purpose of
streaming, and it is much easier to implement with in memory buffers.

So if it is needed to write commits, trees, and tags directly to pack
files writing a separate function to do the would be needed.

So let's just simplify the code base for now, simplify the development
needed for the hash function transition and only support blobs with the
existing bulk_checkin code.

Inspired-by: brian m. carlson <sandals@crustytoothpaste.net>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 bulk-checkin.c | 35 +++++++++++++++++------------------
 bulk-checkin.h |  6 +++---
 object-file.c  | 12 ++++++------
 3 files changed, 26 insertions(+), 27 deletions(-)

This is just a v2 of the description, that addresses Junio's
capitalization concern, and hopefully makes the justification clear to
other people.

I am sending it now mostly because the original version did not
land on the mailing list for some reason.  So I have switched
which email account I am using for now.

diff --git a/bulk-checkin.c b/bulk-checkin.c
index 73bff3a23d27..223562b4e748 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -155,10 +155,10 @@ static int already_written(struct bulk_checkin_packfile *state, struct object_id
  * status before calling us just in case we ask it to call us again
  * with a new pack.
  */
-static int stream_to_pack(struct bulk_checkin_packfile *state,
-			  git_hash_ctx *ctx, off_t *already_hashed_to,
-			  int fd, size_t size, enum object_type type,
-			  const char *path, unsigned flags)
+static int stream_blob_to_pack(struct bulk_checkin_packfile *state,
+			       git_hash_ctx *ctx, off_t *already_hashed_to,
+			       int fd, size_t size, const char *path,
+			       unsigned flags)
 {
 	git_zstream s;
 	unsigned char ibuf[16384];
@@ -170,7 +170,7 @@ static int stream_to_pack(struct bulk_checkin_packfile *state,
 
 	git_deflate_init(&s, pack_compression_level);
 
-	hdrlen = encode_in_pack_object_header(obuf, sizeof(obuf), type, size);
+	hdrlen = encode_in_pack_object_header(obuf, sizeof(obuf), OBJ_BLOB, size);
 	s.next_out = obuf + hdrlen;
 	s.avail_out = sizeof(obuf) - hdrlen;
 
@@ -247,11 +247,10 @@ static void prepare_to_stream(struct bulk_checkin_packfile *state,
 		die_errno("unable to write pack header");
 }
 
-static int deflate_to_pack(struct bulk_checkin_packfile *state,
-			   struct object_id *result_oid,
-			   int fd, size_t size,
-			   enum object_type type, const char *path,
-			   unsigned flags)
+static int deflate_blob_to_pack(struct bulk_checkin_packfile *state,
+				struct object_id *result_oid,
+				int fd, size_t size,
+				const char *path, unsigned flags)
 {
 	off_t seekback, already_hashed_to;
 	git_hash_ctx ctx;
@@ -265,7 +264,7 @@ static int deflate_to_pack(struct bulk_checkin_packfile *state,
 		return error("cannot find the current offset");
 
 	header_len = format_object_header((char *)obuf, sizeof(obuf),
-					  type, size);
+					  OBJ_BLOB, size);
 	the_hash_algo->init_fn(&ctx);
 	the_hash_algo->update_fn(&ctx, obuf, header_len);
 
@@ -282,8 +281,8 @@ static int deflate_to_pack(struct bulk_checkin_packfile *state,
 			idx->offset = state->offset;
 			crc32_begin(state->f);
 		}
-		if (!stream_to_pack(state, &ctx, &already_hashed_to,
-				    fd, size, type, path, flags))
+		if (!stream_blob_to_pack(state, &ctx, &already_hashed_to,
+					 fd, size, path, flags))
 			break;
 		/*
 		 * Writing this object to the current pack will make
@@ -350,12 +349,12 @@ void fsync_loose_object_bulk_checkin(int fd, const char *filename)
 	}
 }
 
-int index_bulk_checkin(struct object_id *oid,
-		       int fd, size_t size, enum object_type type,
-		       const char *path, unsigned flags)
+int index_blob_bulk_checkin(struct object_id *oid,
+			    int fd, size_t size,
+			    const char *path, unsigned flags)
 {
-	int status = deflate_to_pack(&bulk_checkin_packfile, oid, fd, size, type,
-				     path, flags);
+	int status = deflate_blob_to_pack(&bulk_checkin_packfile, oid, fd, size,
+					  path, flags);
 	if (!odb_transaction_nesting)
 		flush_bulk_checkin_packfile(&bulk_checkin_packfile);
 	return status;
diff --git a/bulk-checkin.h b/bulk-checkin.h
index 48fe9a6e9171..aa7286a7b3e1 100644
--- a/bulk-checkin.h
+++ b/bulk-checkin.h
@@ -9,9 +9,9 @@
 void prepare_loose_object_bulk_checkin(void);
 void fsync_loose_object_bulk_checkin(int fd, const char *filename);
 
-int index_bulk_checkin(struct object_id *oid,
-		       int fd, size_t size, enum object_type type,
-		       const char *path, unsigned flags);
+int index_blob_bulk_checkin(struct object_id *oid,
+			    int fd, size_t size,
+			    const char *path, unsigned flags);
 
 /*
  * Tell the object database to optimize for adding
diff --git a/object-file.c b/object-file.c
index 7dc0c4bfbba8..7c7afe579364 100644
--- a/object-file.c
+++ b/object-file.c
@@ -2446,11 +2446,11 @@ static int index_core(struct index_state *istate,
  * binary blobs, they generally do not want to get any conversion, and
  * callers should avoid this code path when filters are requested.
  */
-static int index_stream(struct object_id *oid, int fd, size_t size,
-			enum object_type type, const char *path,
-			unsigned flags)
+static int index_blob_stream(struct object_id *oid, int fd, size_t size,
+			     const char *path,
+			     unsigned flags)
 {
-	return index_bulk_checkin(oid, fd, size, type, path, flags);
+	return index_blob_bulk_checkin(oid, fd, size, path, flags);
 }
 
 int index_fd(struct index_state *istate, struct object_id *oid,
@@ -2472,8 +2472,8 @@ int index_fd(struct index_state *istate, struct object_id *oid,
 		ret = index_core(istate, oid, fd, xsize_t(st->st_size),
 				 type, path, flags);
 	else
-		ret = index_stream(oid, fd, xsize_t(st->st_size), type, path,
-				   flags);
+		ret = index_blob_stream(oid, fd, xsize_t(st->st_size), path,
+					flags);
 	close(fd);
 	return ret;
 }
-- 
2.41.0

Eric
