Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3626EC433F5
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 03:48:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241696AbiCWDte (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Mar 2022 23:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240425AbiCWDtc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Mar 2022 23:49:32 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDCAB250
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 20:48:02 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id w4so296886wrg.12
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 20:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HX+pri0YLyNpLy1eDddYxYPU4ZrSzLUF0rtsjlElF/w=;
        b=DQO2McV1YpDw6Gx+9AUDhEkeeMujpzOlnTTfvvNRu4yAGfu/l4mhQfLKczJYJgPoRj
         YR2xpA4E6L6iPFUnF7fjz0bPd/ldoYwTQiAJALZnLMCseEUuK1k+QgnIOmpS146/eboV
         N/Qz4Ls0xlBLXy+yAft/jmyXP3ZxTb4At6K/N5MVXiJgVedL7Wr5Qr7F14iom2Yvybet
         Ry8vfbYO73ZP2ejGSvu4f0pd0/6aKmZf7m6iFVo/JJ49TCpucVwMrloOBucoKFjxDK1M
         CXNsn/L7otuC3x4PWnDQd5tih19e86F+eoyB/b5pKLynMtVDn8MDC2vdYTePDSOfcB6z
         eQsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HX+pri0YLyNpLy1eDddYxYPU4ZrSzLUF0rtsjlElF/w=;
        b=vngp+fQz6IHElcjtYvKlCMttJu1kpPAUbIol1LNaFtHN2eHQAakUQty6GFaEOBjubG
         xap2xfG2Rj8Os1nrgD4pAXC+LnJHfQhNj6mQq/YUEVqwBEBaEhgtiThHDkGq7lvO2Egw
         lWt3QAJ6I0yVYmJVZZwf7GU6oz3j10yMsx6mYuusakkh+qbc2M71mpjSUfVO3OaqLYs9
         Z8RQOT83NqnsynSMhhXrS+vfQ1jXg+WGEPmuLKthT3SHNx2kyGo0HvsP1vJDty9kQtrl
         FajHCsswsZWVEdgxWRWrl2nFU5NYzE7YkepSa1LqhE1gYDer1OSThfFwQ9qHYlWnHdyV
         qA8A==
X-Gm-Message-State: AOAM532FDdN3TbCjQFOIjnF3tEP5spjHGcTdTQplVN9iAH/eM2yS4ykM
        x/Utg9W2ycvV8EmXoD0wJlEfIWYZB2Cvjw==
X-Google-Smtp-Source: ABdhPJyRyvlpUVlNLq3jMp00gIexIqb1mq7W6BHvRHqCbZm1VP82bDN2yru5N9+2p1D4RiLldFhbXw==
X-Received: by 2002:a5d:598a:0:b0:204:6fb:6461 with SMTP id n10-20020a5d598a000000b0020406fb6461mr13583676wri.132.1648007281222;
        Tue, 22 Mar 2022 20:48:01 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o16-20020a05600c511000b0038c6d836935sm3028830wms.16.2022.03.22.20.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 20:48:00 -0700 (PDT)
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
Subject: [RFC PATCH 2/7] unpack-objects: add skeleton HASH_N_OBJECTS{,_{FIRST,LAST}} flags
Date:   Wed, 23 Mar 2022 04:47:31 +0100
Message-Id: <RFC-patch-2.7-00dbffc2331-20220323T033928Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1428.g1c1a0152d61
In-Reply-To: <RFC-cover-0.7-00000000000-20220323T033928Z-avarab@gmail.com>
References: <CANQDOde2OG8fVSM1hQE3FBmzWy5FkgQCWAUYhFztB8UGFyJELg@mail.gmail.com> <RFC-cover-0.7-00000000000-20220323T033928Z-avarab@gmail.com>
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
index 5d863f8c5e8..320248a54e0 100644
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

