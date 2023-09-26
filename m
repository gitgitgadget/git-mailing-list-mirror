Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 774B9E7E649
	for <git@archiver.kernel.org>; Tue, 26 Sep 2023 15:58:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233541AbjIZP67 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Sep 2023 11:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbjIZP67 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Sep 2023 11:58:59 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7586D11F
        for <git@vger.kernel.org>; Tue, 26 Sep 2023 08:58:51 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id e9e14a558f8ab-3512740906dso21239135ab.0
        for <git@vger.kernel.org>; Tue, 26 Sep 2023 08:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695743930; x=1696348730; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F4zqjSRzfW2hStKKlQncXPbhjfPMT+jHTy4LxlnFulk=;
        b=b8hmoADYSEJv5uQn5rvyRWyj58ZuSg0fuJl6qVxVx0QFdpewhR++tcX2HXbQd7UFuP
         +OtheEK2kG3nCAs4DzLSh9oarrQUZx3xBY1RYEWZdiJjRJphZ5Nn+dqqKznLrMldmxt8
         qIVMOCVUV0urLeHS8rhMlRiC7KvQ/SkDJc83K53pZbhl+rUBCXD3vtGAWajyStPpPN0V
         n46mtBwHnboA8pgkt2aMensH+wC9Lkkv78zPrcRjQxuNnP8BqdMnzpAKiLcQ0VhL5qOw
         duoM6+OYFp+iJfUjQvMGhfR9pqHG2Jz6zGmeHhJk0q6sZjA6M8RHN/CwazFPwKL7zkum
         rTKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695743930; x=1696348730;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F4zqjSRzfW2hStKKlQncXPbhjfPMT+jHTy4LxlnFulk=;
        b=UrBhaFzcLvYLnK83RFw44BUp1w0ymk9AqGtJ4GKjgx/qLfpTo5QrPH3XaUSxU9cJjG
         JBD6t8dTcnMIiJDGwjGtPl+xMRThTsysYkvGUfcLUNfDBVQS0r2iDxGVwqyio8/vI7tZ
         gFJ5cryiN/hyshJJ9E0w4Zmfd28xHIm21uOldgTKD3k3ECUPHw8FJJUD5TG1b0FyNlEo
         b9XbqCoqhhUxgtdmqn3FK1RX6fanePe3M2WkEaufitcX89oab2v5iAvqiufpfVMfC9zk
         FJ8BBOger7eBP2n1WHUooOfyCiIAP2Tf4CZ4XZq2UrY7ZwJQNoN9nYyXL9gAudnxjbow
         uqyg==
X-Gm-Message-State: AOJu0YyEDIhO6ochnpxEg92NW/M44WWjPFMqlDKx9/R0AlQDohdPp6m3
        wn4y60C/8QJDoIvHrjYySVkANxm5q08=
X-Google-Smtp-Source: AGHT+IEb/2AElCCm3ue+72h4IEYS1S4xzb9RCyNf9TO4q+3zp+gOHskvP/xLugP/Vh6Ki4sqckquSA==
X-Received: by 2002:a05:6e02:1549:b0:351:4b68:ec3a with SMTP id j9-20020a056e02154900b003514b68ec3amr4425939ilu.9.1695743930542;
        Tue, 26 Sep 2023 08:58:50 -0700 (PDT)
Received: from gmail.froward.int.ebiederm.org.gmail.com (ip68-227-168-167.om.om.cox.net. [68.227.168.167])
        by smtp.gmail.com with ESMTPSA id s1-20020a056e02216100b003513438a524sm1962836ilv.11.2023.09.26.08.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 08:58:49 -0700 (PDT)
From:   "Eric W. Biederman" <ebiederm@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        <git@vger.kernel.org>
Subject: [PATCH v3] bulk-checkin: only support blobs in index_bulk_checkin
References: <878r918ps3.fsf@gmail.froward.int.ebiederm.org>
        <xmqqr0mtcosy.fsf@gitster.g>
        <87zg1h58xa.fsf@gmail.froward.int.ebiederm.org>
Date:   Tue, 26 Sep 2023 10:58:43 -0500
In-Reply-To: <87zg1h58xa.fsf@gmail.froward.int.ebiederm.org> (Eric
        W. Biederman's message of "Wed, 20 Sep 2023 07:24:49 -0500")
Message-ID: <87msx99b9o.fsf_-_@gmail.froward.int.ebiederm.org>
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
stream_blob_to_pack, to make this explicit.

Not supporting commits, tags, or trees has no downside as it is not
currently supported now, and commits, tags, and trees being smaller by
design do not have the problem that the problem that index_bulk_checkin
was built to solve.

Before we start adding code to support the hash function transition
supporting additional objects types in index_bulk_checkin has no real
additional cost, just an extra function parameter to know what the
object type is.  Once we begin the hash function transition this is not
the case.

The hash function transition document specifies that a repository with
compatObjectFormat enabled will compute and store both the SHA-1 and
SHA-256 hash of every object in the repository.

What makes this a challenge is that it is not just an additional hash
over the same object.  Instead the hash function transition document
specifies that the compatibility hash (specified with
compatObjectFormat) be computed over the equivalent object that another
git repository whose storage hash (specified with objectFormat) would
store.  When comparing equivalent repositories built with different
storage hash functions, the oids embedded in objects used to refer to
other objects differ and the location of signatures within objects
differ.

As blob objects have neither oids referring to other objects nor stored
signatures their storage hash and their compatibility hash are computed
over the same object.

The other kinds of objects: trees, commits, and tags, all store oids
referring to other objects.  Signatures are stored in commit and tag
objects.  As oids and the tags to store signatures are not the same size
in repositories built with different storage hashes the size of the
equivalent objects are also different.

A version of index_bulk_checkin that supports more than just blobs when
computing both the SHA-1 and the SHA-256 of every object added would
need a different, and more expensive structure.  The structure is more
expensive because it would be required to temporarily buffering the
equivalent object the compatibility hash needs to be computed over.

A temporary object is needed, because before a hash over an object can
computed it's object header needs to be computed.  One of the members of
the object header is the entire size of the object.  To know the size of
an equivalent object an entire pass over the original object needs to be
made, as trees, commits, and tags are composed of a variable number of
variable sized pieces.  Unfortunately there is no formula to compute the
size of an equivalent object from just the size of the original object.

Avoid all of those future complications by limiting index_bulk_checkin
to only work on blobs.

Inspired-by: brian m. carlson <sandals@crustytoothpaste.net>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 bulk-checkin.c | 35 +++++++++++++++++------------------
 bulk-checkin.h |  6 +++---
 object-file.c  | 12 ++++++------
 3 files changed, 26 insertions(+), 27 deletions(-)

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

