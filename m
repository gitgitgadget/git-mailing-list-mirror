Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B36681F516
	for <e@80x24.org>; Fri, 29 Jun 2018 01:22:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936447AbeF2BWo (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 21:22:44 -0400
Received: from mail-qk0-f201.google.com ([209.85.220.201]:52433 "EHLO
        mail-qk0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936441AbeF2BWj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 21:22:39 -0400
Received: by mail-qk0-f201.google.com with SMTP id b185-v6so8002641qkg.19
        for <git@vger.kernel.org>; Thu, 28 Jun 2018 18:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=RIIlnsoDHHkm/vySu4VJ1osDfYlTdrqmsvOgeJ+sHy4=;
        b=TzJ1+qnseh9wdLEsikkQDYe0CRlyHBGVqrD5GiLLowcZz77HzAzRhVIjFEbRtJLvYT
         a3B6JOJXOxiEKXikPOvOCA48vd2lHcYpTLEE9f50vBaIMMrlU3tTf2zKnmoLeZC3y7eQ
         1Zmdf77HMXIlI+U48ISRgcXw5YmRB+sIAx+SIkqvW+hQSFxeN+9IsjvUxFBSD8o5gyX9
         o7Si7INKg0OjeAHvn+WcBt9+lJBEKvozkz5oppAmLdrk2VWq78PDzEmgvBZzRcJp9DKe
         AGpeqzO9mWVOhbiW96+yGts+9fluqDd1rs0VlYGip+1Veewrm+v3WaAo6faiuGaNIHo9
         xB9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=RIIlnsoDHHkm/vySu4VJ1osDfYlTdrqmsvOgeJ+sHy4=;
        b=oEUy76R7F2KNUFmntsVEq5NbFWc5IWa2dgEFCtZ5Ft4amqKo9weRNRm5gJuOtsk1z0
         IS0bo1zzaMlvO/TMSdmTSLb7YA++rp6E4iLTavv3lbm5swU+m75GzdIMympuUXcZnVar
         cMobgTeBiEAyCV8F5QAuEu45WPKta4AXN/TKdJnXdzxj4Yk4lF5ElY+CT11og0ceKvBV
         jrMoq85j2Evg9+RKCVPHmebJR3zyakx1Q3tu3ZuAW4+WkqRtcB6/qw00aIoaqBygxa6i
         SHyQEvitsI0KYfFmvDTo57mJQK6FAeVRKa83Tt5FVUp8g5sy4tsgI3aG4RI9wyxTVenQ
         0GDA==
X-Gm-Message-State: APt69E1Qbf3JOy588b+Ih445w3TjC7aWjjyaktuusRUlVbs6gl21tFbo
        TJTJZ7ym2dWdVclCfERkJd9r9Cnbw7cm6R4e93O4okCk0N6IXATSrgGJG3mXPm+6UspCFSVwEbD
        ML9BT4K5OqTQPViUDo66DNCQqPmkLxhjwjnTbxCBkDkRmh/TcG4mwcdrPlbsT
X-Google-Smtp-Source: AAOMgpfvfNWNRHFGkaj5zoojq0gfIfszVHPViVZ+HKsMmP7UxB/gUwGZnHbl6wfdNwqsDzkaaEUpZJ5Hhrop
MIME-Version: 1.0
X-Received: by 2002:a0c:98ac:: with SMTP id f41-v6mr6523119qvd.45.1530235359036;
 Thu, 28 Jun 2018 18:22:39 -0700 (PDT)
Date:   Thu, 28 Jun 2018 18:21:53 -0700
In-Reply-To: <20180629012222.167426-1-sbeller@google.com>
Message-Id: <20180629012222.167426-4-sbeller@google.com>
References: <20180629012222.167426-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.399.gad0ab374a1-goog
Subject: [PATCH v3 03/32] object: add repository argument to parse_object_buffer
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a repository argument to allow the callers of parse_object_buffer
to be more specific about which repository to act on. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/fast-export.c    | 3 ++-
 builtin/fsck.c           | 7 +++++--
 builtin/index-pack.c     | 3 ++-
 builtin/unpack-objects.c | 3 ++-
 object.c                 | 5 +++--
 object.h                 | 3 ++-
 ref-filter.c             | 3 ++-
 7 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index e39c4e2c1d0..03a2e4b79e6 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -244,7 +244,8 @@ static void export_blob(const struct object_id *oid)
 			die ("Could not read blob %s", oid_to_hex(oid));
 		if (check_object_signature(oid, buf, size, type_name(type)) < 0)
 			die("sha1 mismatch in blob %s", oid_to_hex(oid));
-		object = parse_object_buffer(oid, type, size, buf, &eaten);
+		object = parse_object_buffer(the_repository, oid, type,
+					     size, buf, &eaten);
 	}
 
 	if (!object)
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 12d01e91747..09cf5333444 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -392,7 +392,8 @@ static int fsck_obj_buffer(const struct object_id *oid, enum object_type type,
 	 * verify_packfile(), data_valid variable for details.
 	 */
 	struct object *obj;
-	obj = parse_object_buffer(oid, type, size, buffer, eaten);
+	obj = parse_object_buffer(the_repository, oid, type, size, buffer,
+				  eaten);
 	if (!obj) {
 		errors_found |= ERROR_OBJECT;
 		return error("%s: object corrupt or missing", oid_to_hex(oid));
@@ -525,7 +526,9 @@ static int fsck_loose(const struct object_id *oid, const char *path, void *data)
 	if (!contents && type != OBJ_BLOB)
 		BUG("read_loose_object streamed a non-blob");
 
-	obj = parse_object_buffer(oid, type, size, contents, &eaten);
+	obj = parse_object_buffer(the_repository, oid, type, size,
+				  contents, &eaten);
+
 	if (!obj) {
 		errors_found |= ERROR_OBJECT;
 		error("%s: object could not be parsed: %s",
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 74fe2973e12..9c08cf3cead 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -851,7 +851,8 @@ static void sha1_object(const void *data, struct object_entry *obj_entry,
 			 * we do not need to free the memory here, as the
 			 * buf is deleted by the caller.
 			 */
-			obj = parse_object_buffer(oid, type, size, buf,
+			obj = parse_object_buffer(the_repository, oid, type,
+						  size, buf,
 						  &eaten);
 			if (!obj)
 				die(_("invalid %s"), type_name(type));
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 335b5ed9a0f..75d1d5ea0b8 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -265,7 +265,8 @@ static void write_object(unsigned nr, enum object_type type,
 		int eaten;
 		hash_object_file(buf, size, type_name(type), &obj_list[nr].oid);
 		added_object(nr, type, buf, size);
-		obj = parse_object_buffer(&obj_list[nr].oid, type, size, buf,
+		obj = parse_object_buffer(the_repository, &obj_list[nr].oid,
+					  type, size, buf,
 					  &eaten);
 		if (!obj)
 			die("invalid %s", type_name(type));
diff --git a/object.c b/object.c
index 002ebb69e3b..49719694c14 100644
--- a/object.c
+++ b/object.c
@@ -186,7 +186,7 @@ struct object *lookup_unknown_object(const unsigned char *sha1)
 	return obj;
 }
 
-struct object *parse_object_buffer(const struct object_id *oid, enum object_type type, unsigned long size, void *buffer, int *eaten_p)
+struct object *parse_object_buffer_the_repository(const struct object_id *oid, enum object_type type, unsigned long size, void *buffer, int *eaten_p)
 {
 	struct object *obj;
 	*eaten_p = 0;
@@ -278,7 +278,8 @@ struct object *parse_object_the_repository(const struct object_id *oid)
 			return NULL;
 		}
 
-		obj = parse_object_buffer(oid, type, size, buffer, &eaten);
+		obj = parse_object_buffer(the_repository, oid, type, size,
+					  buffer, &eaten);
 		if (!eaten)
 			free(buffer);
 		return obj;
diff --git a/object.h b/object.h
index f840a428859..2ba23c07a72 100644
--- a/object.h
+++ b/object.h
@@ -135,7 +135,8 @@ struct object *parse_object_or_die(const struct object_id *oid, const char *name
  * parsing it.  eaten_p indicates if the object has a borrowed copy
  * of buffer and the caller should not free() it.
  */
-struct object *parse_object_buffer(const struct object_id *oid, enum object_type type, unsigned long size, void *buffer, int *eaten_p);
+#define parse_object_buffer(r, o, t, s, b, e) parse_object_buffer_##r(o, t, s, b, e)
+struct object *parse_object_buffer_the_repository(const struct object_id *oid, enum object_type type, unsigned long size, void *buffer, int *eaten_p);
 
 /** Returns the object, with potentially excess memory allocated. **/
 struct object *lookup_unknown_object(const unsigned  char *sha1);
diff --git a/ref-filter.c b/ref-filter.c
index 044c28c5154..ec9479af1f8 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -807,7 +807,8 @@ static void *get_obj(const struct object_id *oid, struct object **obj, unsigned
 	void *buf = read_object_file(oid, &type, sz);
 
 	if (buf)
-		*obj = parse_object_buffer(oid, type, *sz, buf, eaten);
+		*obj = parse_object_buffer(the_repository, oid, type, *sz,
+					   buf, eaten);
 	else
 		*obj = NULL;
 	return buf;
-- 
2.18.0.399.gad0ab374a1-goog

