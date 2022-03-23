Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F40A5C433EF
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 14:18:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244690AbiCWOUS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 10:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237118AbiCWOUQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 10:20:16 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 670C77C174
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 07:18:46 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id r64so1031063wmr.4
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 07:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NEl2TPXkGJPZMUlcZArsK9LrVbvSSsRHbbQiCADWqYg=;
        b=WkIJFB6eu+NzCCqGlsga4QQY3ZUhaBf3OyQBoh9kDI0VgvLrQVucAgcSKnADy/iGTb
         8YWL2B7/cq+jJGKcTtfsYR+rrA2r35pndEF8915+o0l520RvC80TY7/aBvWcRD5v9riM
         CLEqhwXwv8a+wpJWC0kEjtH0fyEEfHGpsiMieGzvmaDqN7BO4MPpvlOZXQi+CsipgSaX
         PenoFg9rMiLGVhKvfIdnLIOtOxsV2Pot6MbgocPJobigEKv57kaQGlKGYy0LxTKoES25
         GW5fu3kcC1eHc65ununu5Elvr28tmXx/VsH6xODrMN6NjfLvAtmbHCGopGrVfst9Xhwv
         eGkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NEl2TPXkGJPZMUlcZArsK9LrVbvSSsRHbbQiCADWqYg=;
        b=tW8YXJKhMlFf0y1xTdWxwBFzH3wu5lxxbvAgVIZsfE0SuVwxOPz4dabKP89E/UHPQv
         z2VTBwju1KXztehK3JQDtTwqphVuYQczhgnKNVHkJKnDnoMEYXmpDBF2N/rUuLhCs2QK
         6yty39sah2CF22XBcRztDWs5pMVe4MHQqEzMrOKJfCb6nrg4I2s8wWGh1vvwzfLMnT6v
         hAv3njoLc4/YqYMkOBL80vd/xL2feKbqNuxmSPofRBpLhbFeNzYn/PUz+qS98gCUv2P0
         J598iehkC3Sbz71ULaYvil+m1XOWv5biIn/UUBcBQMFCKQTs5Gi/UBbej4KAGVPY7i8D
         c04Q==
X-Gm-Message-State: AOAM530tSKzBwckIiQIMvlMMaer1eYKgE7qRxM/lAVCrANLKdX+yUy12
        FPOu/eyt9GMYHG3sCEFKfZJoULcTHJbNvw==
X-Google-Smtp-Source: ABdhPJxXLnLAmVEEa/V9pUk6CMivCRpHyPRYGg7ajEtrnTwP1jJlueY9tXoqsoL/DRgR3bjFnH6x6w==
X-Received: by 2002:a7b:cd88:0:b0:38c:9d04:d794 with SMTP id y8-20020a7bcd88000000b0038c9d04d794mr87118wmj.140.1648045124535;
        Wed, 23 Mar 2022 07:18:44 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q14-20020a1cf30e000000b0038986a18ec8sm30592wmq.46.2022.03.23.07.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 07:18:44 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Neeraj Singh <nksingh85@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Patrick Steinhardt <ps@pks.im>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Neeraj Singh <neerajsi@microsoft.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH v2 1/7] unpack-objects: add skeleton HASH_N_OBJECTS{,_{FIRST,LAST}} flags
Date:   Wed, 23 Mar 2022 15:18:25 +0100
Message-Id: <RFC-patch-v2-1.7-98921aa2052-20220323T140753Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1428.g1c1a0152d61
In-Reply-To: <RFC-cover-v2-0.7-00000000000-20220323T140753Z-avarab@gmail.com>
References: <RFC-cover-0.7-00000000000-20220323T033928Z-avarab@gmail.com> <RFC-cover-v2-0.7-00000000000-20220323T140753Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In preparation for making the bulk-checkin.c logic operate from
object-file.c itself in some common cases let's add
HASH_N_OBJECTS{,_{FIRST,LAST}} flags.

This will allow us to adjust for-loops that add N objects to just pass
down whether they have >1 objects (HASH_N_OBJECTS), as well as passing
down flags for whether we have the first or last object.

We'll thus be able to drive any sort of batch-object mechanism from
write_object_file_flags() directly, which until now didn't know if it
was doing one object, or some arbitrary N.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/unpack-objects.c | 60 +++++++++++++++++++++++-----------------
 cache.h                  |  3 ++
 2 files changed, 37 insertions(+), 26 deletions(-)

diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index c55b6616aed..ec40c6fd966 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -233,7 +233,8 @@ static void write_rest(void)
 }
 
 static void added_object(unsigned nr, enum object_type type,
-			 void *data, unsigned long size);
+			 void *data, unsigned long size,
+			 unsigned oflags);
 
 /*
  * Write out nr-th object from the list, now we know the contents
@@ -241,21 +242,21 @@ static void added_object(unsigned nr, enum object_type type,
  * to be checked at the end.
  */
 static void write_object(unsigned nr, enum object_type type,
-			 void *buf, unsigned long size)
+			 void *buf, unsigned long size, unsigned oflags)
 {
 	if (!strict) {
-		if (write_object_file(buf, size, type,
-				      &obj_list[nr].oid) < 0)
+		if (write_object_file_flags(buf, size, type,
+				      &obj_list[nr].oid, oflags) < 0)
 			die("failed to write object");
-		added_object(nr, type, buf, size);
+		added_object(nr, type, buf, size, oflags);
 		free(buf);
 		obj_list[nr].obj = NULL;
 	} else if (type == OBJ_BLOB) {
 		struct blob *blob;
-		if (write_object_file(buf, size, type,
-				      &obj_list[nr].oid) < 0)
+		if (write_object_file_flags(buf, size, type,
+					    &obj_list[nr].oid, oflags) < 0)
 			die("failed to write object");
-		added_object(nr, type, buf, size);
+		added_object(nr, type, buf, size, oflags);
 		free(buf);
 
 		blob = lookup_blob(the_repository, &obj_list[nr].oid);
@@ -269,7 +270,7 @@ static void write_object(unsigned nr, enum object_type type,
 		int eaten;
 		hash_object_file(the_hash_algo, buf, size, type,
 				 &obj_list[nr].oid);
-		added_object(nr, type, buf, size);
+		added_object(nr, type, buf, size, oflags);
 		obj = parse_object_buffer(the_repository, &obj_list[nr].oid,
 					  type, size, buf,
 					  &eaten);
@@ -283,7 +284,7 @@ static void write_object(unsigned nr, enum object_type type,
 
 static void resolve_delta(unsigned nr, enum object_type type,
 			  void *base, unsigned long base_size,
-			  void *delta, unsigned long delta_size)
+			  void *delta, unsigned long delta_size, unsigned oflags)
 {
 	void *result;
 	unsigned long result_size;
@@ -294,7 +295,7 @@ static void resolve_delta(unsigned nr, enum object_type type,
 	if (!result)
 		die("failed to apply delta");
 	free(delta);
-	write_object(nr, type, result, result_size);
+	write_object(nr, type, result, result_size, oflags);
 }
 
 /*
@@ -302,7 +303,7 @@ static void resolve_delta(unsigned nr, enum object_type type,
  * resolve all the deltified objects that are based on it.
  */
 static void added_object(unsigned nr, enum object_type type,
-			 void *data, unsigned long size)
+			 void *data, unsigned long size, unsigned oflags)
 {
 	struct delta_info **p = &delta_list;
 	struct delta_info *info;
@@ -313,7 +314,7 @@ static void added_object(unsigned nr, enum object_type type,
 			*p = info->next;
 			p = &delta_list;
 			resolve_delta(info->nr, type, data, size,
-				      info->delta, info->size);
+				      info->delta, info->size, oflags);
 			free(info);
 			continue;
 		}
@@ -322,18 +323,19 @@ static void added_object(unsigned nr, enum object_type type,
 }
 
 static void unpack_non_delta_entry(enum object_type type, unsigned long size,
-				   unsigned nr)
+				   unsigned nr, unsigned oflags)
 {
 	void *buf = get_data(size);
 
 	if (!dry_run && buf)
-		write_object(nr, type, buf, size);
+		write_object(nr, type, buf, size, oflags);
 	else
 		free(buf);
 }
 
 static int resolve_against_held(unsigned nr, const struct object_id *base,
-				void *delta_data, unsigned long delta_size)
+				void *delta_data, unsigned long delta_size,
+				unsigned oflags)
 {
 	struct object *obj;
 	struct obj_buffer *obj_buffer;
@@ -344,12 +346,12 @@ static int resolve_against_held(unsigned nr, const struct object_id *base,
 	if (!obj_buffer)
 		return 0;
 	resolve_delta(nr, obj->type, obj_buffer->buffer,
-		      obj_buffer->size, delta_data, delta_size);
+		      obj_buffer->size, delta_data, delta_size, oflags);
 	return 1;
 }
 
 static void unpack_delta_entry(enum object_type type, unsigned long delta_size,
-			       unsigned nr)
+			       unsigned nr, unsigned oflags)
 {
 	void *delta_data, *base;
 	unsigned long base_size;
@@ -366,7 +368,7 @@ static void unpack_delta_entry(enum object_type type, unsigned long delta_size,
 		if (has_object_file(&base_oid))
 			; /* Ok we have this one */
 		else if (resolve_against_held(nr, &base_oid,
-					      delta_data, delta_size))
+					      delta_data, delta_size, oflags))
 			return; /* we are done */
 		else {
 			/* cannot resolve yet --- queue it */
@@ -428,7 +430,7 @@ static void unpack_delta_entry(enum object_type type, unsigned long delta_size,
 		}
 	}
 
-	if (resolve_against_held(nr, &base_oid, delta_data, delta_size))
+	if (resolve_against_held(nr, &base_oid, delta_data, delta_size, oflags))
 		return;
 
 	base = read_object_file(&base_oid, &type, &base_size);
@@ -440,11 +442,11 @@ static void unpack_delta_entry(enum object_type type, unsigned long delta_size,
 		has_errors = 1;
 		return;
 	}
-	resolve_delta(nr, type, base, base_size, delta_data, delta_size);
+	resolve_delta(nr, type, base, base_size, delta_data, delta_size, oflags);
 	free(base);
 }
 
-static void unpack_one(unsigned nr)
+static void unpack_one(unsigned nr, unsigned oflags)
 {
 	unsigned shift;
 	unsigned char *pack;
@@ -472,11 +474,11 @@ static void unpack_one(unsigned nr)
 	case OBJ_TREE:
 	case OBJ_BLOB:
 	case OBJ_TAG:
-		unpack_non_delta_entry(type, size, nr);
+		unpack_non_delta_entry(type, size, nr, oflags);
 		return;
 	case OBJ_REF_DELTA:
 	case OBJ_OFS_DELTA:
-		unpack_delta_entry(type, size, nr);
+		unpack_delta_entry(type, size, nr, oflags);
 		return;
 	default:
 		error("bad object type %d", type);
@@ -491,6 +493,7 @@ static void unpack_all(void)
 {
 	int i;
 	struct pack_header *hdr = fill(sizeof(struct pack_header));
+	unsigned oflags;
 
 	nr_objects = ntohl(hdr->hdr_entries);
 
@@ -505,9 +508,14 @@ static void unpack_all(void)
 		progress = start_progress(_("Unpacking objects"), nr_objects);
 	CALLOC_ARRAY(obj_list, nr_objects);
 	plug_bulk_checkin();
+	oflags = nr_objects > 1 ? HASH_N_OBJECTS : 0;
 	for (i = 0; i < nr_objects; i++) {
-		unpack_one(i);
-		display_progress(progress, i + 1);
+		int nth = i + 1;
+		unsigned f = i == 0 ? HASH_N_OBJECTS_FIRST :
+			nr_objects == nth ? HASH_N_OBJECTS_LAST : 0;
+
+		unpack_one(i, oflags | f);
+		display_progress(progress, nth);
 	}
 	unplug_bulk_checkin();
 	stop_progress(&progress);
diff --git a/cache.h b/cache.h
index 84fafe2ed71..72c91c91286 100644
--- a/cache.h
+++ b/cache.h
@@ -896,6 +896,9 @@ int ie_modified(struct index_state *, const struct cache_entry *, struct stat *,
 #define HASH_FORMAT_CHECK 2
 #define HASH_RENORMALIZE  4
 #define HASH_SILENT 8
+#define HASH_N_OBJECTS 1<<4
+#define HASH_N_OBJECTS_FIRST 1<<5
+#define HASH_N_OBJECTS_LAST 1<<6
 int index_fd(struct index_state *istate, struct object_id *oid, int fd, struct stat *st, enum object_type type, const char *path, unsigned flags);
 int index_path(struct index_state *istate, struct object_id *oid, const char *path, struct stat *st, unsigned flags);
 
-- 
2.35.1.1428.g1c1a0152d61

