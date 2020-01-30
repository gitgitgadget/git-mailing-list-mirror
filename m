Return-Path: <SRS0=gonI=3T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC6BEC2D0DB
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 20:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BCD820708
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 20:33:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="LFU75hdn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbgA3Udv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jan 2020 15:33:51 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:35666 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727319AbgA3Udv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jan 2020 15:33:51 -0500
Received: by mail-qk1-f195.google.com with SMTP id q15so4353466qki.2
        for <git@vger.kernel.org>; Thu, 30 Jan 2020 12:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xVwAtYWKTNwBR38RUA1pX5i62XBJJ8+8wAULJdqv8Js=;
        b=LFU75hdn0hrtzAuK5qavw9B7ouTQWJ6EqN0GrUe9B2QDasaGlA88r/nPUZiC3Gpomc
         VPKWM8JDs+gj3g54rLCTx7cX9E7a1AFSrmZpE0xD8/J2Jr+PpCAyieQjkp0fgjp1fW1y
         ZuX5Jk0Or8w/ynqTCrB7PFW+l4xK+O/tpRvSFXkdW2b1es1Ot9ZzaMhgNtHtPT74h3Ts
         EqjHvucfCDGQC04z0Hc6lECfrXZHxe586qpfjoN+a1gSDbVR9xUALhWHcFMR+ECX7xnB
         I7oQ61tAsVI58BkF2laoVsAC46rcpcYk8hL9GYg4He3KL4MiA92/av82YniQ5x7t1UZy
         Tz7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xVwAtYWKTNwBR38RUA1pX5i62XBJJ8+8wAULJdqv8Js=;
        b=gWAJlecf7gOlWW8hSrN0x4cXSRT75ezY8dA3NxexTfJUQMDGv1P2VzQMGPcasTTAcU
         diwMG90Jy6jifygIU1e0YFx/tpj2KVSXjSkM32kGLxlqTTGZbDJ6vn85+SO4IKDv/zhM
         rhkLqGJSk8ixmj47r3nrut7rVVkROfDExepJlKrFwaInFCGer8282fXO27VYWiFgwABg
         qPaNlI7ugmI5rKApvcSOCQA8VTjBqbZg3O1wvSSr5Wo8ZSUogpq0HHkdahSEUAVx7xVK
         EkvpK8x02t0x+dlQswOLuY5GJ3TIMCEWkwNktXk2UPU5Bo0iYcMlH60FGn8W46kGIdQL
         QT7g==
X-Gm-Message-State: APjAAAUE7UiPpqsPZl8llgD0Y3dPX8Io4H1kC0LipaS7cAdj8dyWC8Gm
        1jJ4AvHaTs9nhvKkyUUMsXw6e4JBT2E=
X-Google-Smtp-Source: APXvYqzjOqX+Eok2IMK5VLlVTGaNie+BSna5Adt/Wd85DAPdENHL5ld+CVoGrwXM9m+OA2/VMbHSfQ==
X-Received: by 2002:a05:620a:1108:: with SMTP id o8mr6885743qkk.118.1580416429075;
        Thu, 30 Jan 2020 12:33:49 -0800 (PST)
Received: from mango.semfio.usp.br ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id o12sm3436514qke.79.2020.01.30.12.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 12:33:48 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     Stefan Beller <stefanbeller@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/7] streaming: allow open_istream() to handle any repo
Date:   Thu, 30 Jan 2020 17:32:20 -0300
Message-Id: <b76b189efb6d3b6e4d345fd1876a676ed27d1653.1580413221.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1580413221.git.matheus.bernardino@usp.br>
References: <cover.1580413221.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some callers of open_istream() at archive-tar.c and archive-zip.c are
capable of working on arbitrary repositories but the repo struct is not
passed down to open_istream(), which uses the_repository internally. For
now, that's not a problem since the said callers are only being called
with the_repository. But to be consistent and avoid future problems,
let's allow open_istream() to receive a struct repository and use that
instead of the_repository. This parameter addition will also be used in
a future patch to make sha1-file.c:check_object_signature() be able to
work on arbitrary repos.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 archive-tar.c          |  6 +++---
 archive-zip.c          |  3 ++-
 builtin/index-pack.c   |  3 ++-
 builtin/pack-objects.c |  3 ++-
 sha1-file.c            |  2 +-
 streaming.c            | 28 +++++++++++++++-------------
 streaming.h            |  4 +++-
 7 files changed, 28 insertions(+), 21 deletions(-)

diff --git a/archive-tar.c b/archive-tar.c
index e16d3f756d..5a77701a15 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -112,7 +112,7 @@ static void write_trailer(void)
  * queues up writes, so that all our write(2) calls write exactly one
  * full block; pads writes to RECORDSIZE
  */
-static int stream_blocked(const struct object_id *oid)
+static int stream_blocked(struct repository *r, const struct object_id *oid)
 {
 	struct git_istream *st;
 	enum object_type type;
@@ -120,7 +120,7 @@ static int stream_blocked(const struct object_id *oid)
 	char buf[BLOCKSIZE];
 	ssize_t readlen;
 
-	st = open_istream(oid, &type, &sz, NULL);
+	st = open_istream(r, oid, &type, &sz, NULL);
 	if (!st)
 		return error(_("cannot stream blob %s"), oid_to_hex(oid));
 	for (;;) {
@@ -324,7 +324,7 @@ static int write_tar_entry(struct archiver_args *args,
 		if (buffer)
 			write_blocked(buffer, size);
 		else
-			err = stream_blocked(oid);
+			err = stream_blocked(args->repo, oid);
 	}
 	free(buffer);
 	return err;
diff --git a/archive-zip.c b/archive-zip.c
index 11f5b1974b..e9f426298b 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -345,7 +345,8 @@ static int write_zip_entry(struct archiver_args *args,
 
 		if (S_ISREG(mode) && type == OBJ_BLOB && !args->convert &&
 		    size > big_file_threshold) {
-			stream = open_istream(oid, &type, &size, NULL);
+			stream = open_istream(args->repo, oid, &type, &size,
+					      NULL);
 			if (!stream)
 				return error(_("cannot stream blob %s"),
 					     oid_to_hex(oid));
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 60a5591039..7a08da8401 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -757,7 +757,8 @@ static int check_collison(struct object_entry *entry)
 
 	memset(&data, 0, sizeof(data));
 	data.entry = entry;
-	data.st = open_istream(&entry->idx.oid, &type, &size, NULL);
+	data.st = open_istream(the_repository, &entry->idx.oid, &type, &size,
+			       NULL);
 	if (!data.st)
 		return -1;
 	if (size != entry->size || type != entry->type)
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 393c20a2d7..ef17efd94e 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -303,7 +303,8 @@ static unsigned long write_no_reuse_object(struct hashfile *f, struct object_ent
 	if (!usable_delta) {
 		if (oe_type(entry) == OBJ_BLOB &&
 		    oe_size_greater_than(&to_pack, entry, big_file_threshold) &&
-		    (st = open_istream(&entry->idx.oid, &type, &size, NULL)) != NULL)
+		    (st = open_istream(the_repository, &entry->idx.oid, &type,
+				       &size, NULL)) != NULL)
 			buf = NULL;
 		else {
 			buf = read_object_file(&entry->idx.oid, &type, &size);
diff --git a/sha1-file.c b/sha1-file.c
index 03ae9ae93a..13b90b1cb1 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -986,7 +986,7 @@ int check_object_signature(const struct object_id *oid, void *map,
 		return !oideq(oid, &real_oid) ? -1 : 0;
 	}
 
-	st = open_istream(oid, &obj_type, &size, NULL);
+	st = open_istream(the_repository, oid, &obj_type, &size, NULL);
 	if (!st)
 		return -1;
 
diff --git a/streaming.c b/streaming.c
index fcd6303219..800f07a52c 100644
--- a/streaming.c
+++ b/streaming.c
@@ -16,6 +16,7 @@ enum input_source {
 };
 
 typedef int (*open_istream_fn)(struct git_istream *,
+			       struct repository *,
 			       struct object_info *,
 			       const struct object_id *,
 			       enum object_type *);
@@ -29,8 +30,8 @@ struct stream_vtbl {
 
 #define open_method_decl(name) \
 	int open_istream_ ##name \
-	(struct git_istream *st, struct object_info *oi, \
-	 const struct object_id *oid, \
+	(struct git_istream *st, struct repository *r, \
+	 struct object_info *oi, const struct object_id *oid, \
 	 enum object_type *type)
 
 #define close_method_decl(name) \
@@ -108,7 +109,8 @@ ssize_t read_istream(struct git_istream *st, void *buf, size_t sz)
 	return st->vtbl->read(st, buf, sz);
 }
 
-static enum input_source istream_source(const struct object_id *oid,
+static enum input_source istream_source(struct repository *r,
+					const struct object_id *oid,
 					enum object_type *type,
 					struct object_info *oi)
 {
@@ -117,7 +119,7 @@ static enum input_source istream_source(const struct object_id *oid,
 
 	oi->typep = type;
 	oi->sizep = &size;
-	status = oid_object_info_extended(the_repository, oid, oi, 0);
+	status = oid_object_info_extended(r, oid, oi, 0);
 	if (status < 0)
 		return stream_error;
 
@@ -133,22 +135,23 @@ static enum input_source istream_source(const struct object_id *oid,
 	}
 }
 
-struct git_istream *open_istream(const struct object_id *oid,
+struct git_istream *open_istream(struct repository *r,
+				 const struct object_id *oid,
 				 enum object_type *type,
 				 unsigned long *size,
 				 struct stream_filter *filter)
 {
 	struct git_istream *st;
 	struct object_info oi = OBJECT_INFO_INIT;
-	const struct object_id *real = lookup_replace_object(the_repository, oid);
-	enum input_source src = istream_source(real, type, &oi);
+	const struct object_id *real = lookup_replace_object(r, oid);
+	enum input_source src = istream_source(r, real, type, &oi);
 
 	if (src < 0)
 		return NULL;
 
 	st = xmalloc(sizeof(*st));
-	if (open_istream_tbl[src](st, &oi, real, type)) {
-		if (open_istream_incore(st, &oi, real, type)) {
+	if (open_istream_tbl[src](st, r, &oi, real, type)) {
+		if (open_istream_incore(st, r, &oi, real, type)) {
 			free(st);
 			return NULL;
 		}
@@ -338,8 +341,7 @@ static struct stream_vtbl loose_vtbl = {
 
 static open_method_decl(loose)
 {
-	st->u.loose.mapped = map_loose_object(the_repository,
-					      oid, &st->u.loose.mapsize);
+	st->u.loose.mapped = map_loose_object(r, oid, &st->u.loose.mapsize);
 	if (!st->u.loose.mapped)
 		return -1;
 	if ((unpack_loose_header(&st->z,
@@ -499,7 +501,7 @@ static struct stream_vtbl incore_vtbl = {
 
 static open_method_decl(incore)
 {
-	st->u.incore.buf = read_object_file_extended(the_repository, oid, type, &st->size, 0);
+	st->u.incore.buf = read_object_file_extended(r, oid, type, &st->size, 0);
 	st->u.incore.read_ptr = 0;
 	st->vtbl = &incore_vtbl;
 
@@ -520,7 +522,7 @@ int stream_blob_to_fd(int fd, const struct object_id *oid, struct stream_filter
 	ssize_t kept = 0;
 	int result = -1;
 
-	st = open_istream(oid, &type, &sz, filter);
+	st = open_istream(the_repository, oid, &type, &sz, filter);
 	if (!st) {
 		if (filter)
 			free_stream_filter(filter);
diff --git a/streaming.h b/streaming.h
index f465a3cd31..5e4e6acfd0 100644
--- a/streaming.h
+++ b/streaming.h
@@ -8,7 +8,9 @@
 /* opaque */
 struct git_istream;
 
-struct git_istream *open_istream(const struct object_id *, enum object_type *, unsigned long *, struct stream_filter *);
+struct git_istream *open_istream(struct repository *, const struct object_id *,
+				 enum object_type *, unsigned long *,
+				 struct stream_filter *);
 int close_istream(struct git_istream *);
 ssize_t read_istream(struct git_istream *, void *, size_t);
 
-- 
2.25.0

