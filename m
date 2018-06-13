Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A90401F403
	for <e@80x24.org>; Wed, 13 Jun 2018 23:05:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935528AbeFMXFl (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Jun 2018 19:05:41 -0400
Received: from mail-qk0-f201.google.com ([209.85.220.201]:55868 "EHLO
        mail-qk0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935432AbeFMXFj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jun 2018 19:05:39 -0400
Received: by mail-qk0-f201.google.com with SMTP id f207-v6so3315518qke.22
        for <git@vger.kernel.org>; Wed, 13 Jun 2018 16:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=3KkFNkdm4A7ljiWFR444k80J++uWazTJ7AsDUmSwIlg=;
        b=gB/hCfCFNfQ46uG+BU21U3GUfA3ptI+8v/E6FsuLu5kBFs9FcHN1lKn7JtFDEvwFbD
         Wt8Pgb7Sr4SHaFwiwiaPONoH2qOYwzsLZardcomRsT/BQc124CRZHsuOUFd59qFylB/L
         uGUdeWudvZ6ts2rkbnYLXhv8EctxBEoNTnosahEmHLCOzp9YRMUE6psmi0JVFJrBo+Fm
         r3WJ1/8kP8iNHnJj0V966rF5qHeL6P+BwC9IPYvCDrHftUUWfTY6iml2EbltVqMdbMVI
         UVgTxp6ddwkLbUWzoPtgDkVLBYUxT9K8FZIpUOZplP76g42cIwJtQwwpy1mWGngf0SMz
         vnUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=3KkFNkdm4A7ljiWFR444k80J++uWazTJ7AsDUmSwIlg=;
        b=EpWsJd8N31PMWzFC+r0pjn5ch33k+lvZ7DPpDXeEeTIBhE9UDOu2Jp1xqiyUEN4DYR
         CS6wvdTeZ0bi6MlOXhwy5JdyCQ9eG9K0CHr0qLnMn0s2/7IyMEvfNsqzWmmP0pM7OtxB
         jL5Lvuto1QUB43OaA5rdgvUT65zDQYUmdLrmmde7JR35FipIZrw88bcP6TU4C4pSAU1U
         4cDK3P19b8KuzHIXTHgoOPCZKMwRHoVjXStEFJdJJ8pasdQ3BTkffR5R7Kr+YUOF1ANs
         b4/28pwIR632J677RLdS/QGH24ODSpnm8DR1g3zi6DlEe6fp93OLMUj2dArUxeVVltMD
         VB8w==
X-Gm-Message-State: APt69E3/gryO1q0UZretrE+dPy/bhUatlRQzEe3Q8yEfuO0bA1k9SFXq
        hQ+6qkfCKgNADaWYOoXPa2SX37kshw4/ds0q0jolIKpbiUBc9E97HKOdra7T2eAJWQyyAJYRxwT
        ToBPD2lGZUxnqwJdDKbLq3XxDzDbhcNoIOo1MBkpOIVax7j0msuEWX5bHibbN
X-Google-Smtp-Source: ADUXVKJLBBsbU8JA9Kqffx5im97RKJcmFCwyTix9oEKAjEFjlD1dpk/+nZaUc1FKUjeAMF4wWbCGVEpnUC2Z
MIME-Version: 1.0
X-Received: by 2002:a0c:b58b:: with SMTP id g11-v6mr91658qve.46.1528931138696;
 Wed, 13 Jun 2018 16:05:38 -0700 (PDT)
Date:   Wed, 13 Jun 2018 16:04:53 -0700
In-Reply-To: <20180613230522.55335-1-sbeller@google.com>
Message-Id: <20180613230522.55335-3-sbeller@google.com>
References: <20180530004810.30076-1-sbeller@google.com> <20180613230522.55335-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
Subject: [PATCH v2 02/31] object: add repository argument to parse_object_buffer
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
 builtin/fsck.c           | 6 ++++--
 builtin/index-pack.c     | 3 ++-
 builtin/unpack-objects.c | 3 ++-
 object.c                 | 5 +++--
 object.h                 | 3 ++-
 ref-filter.c             | 3 ++-
 7 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 24d42842f9d..a34ab9768f4 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -245,7 +245,8 @@ static void export_blob(const struct object_id *oid)
 			die ("Could not read blob %s", oid_to_hex(oid));
 		if (check_object_signature(oid, buf, size, type_name(type)) < 0)
 			die("sha1 mismatch in blob %s", oid_to_hex(oid));
-		object = parse_object_buffer(oid, type, size, buf, &eaten);
+		object = parse_object_buffer(the_repository, oid, type,
+					     size, buf, &eaten);
 	}
 
 	if (!object)
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 98fdeef5407..6b8c9074920 100644
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
@@ -522,7 +523,8 @@ static struct object *parse_loose_object(const struct object_id *oid,
 	if (!contents && type != OBJ_BLOB)
 		die("BUG: read_loose_object streamed a non-blob");
 
-	obj = parse_object_buffer(oid, type, size, contents, &eaten);
+	obj = parse_object_buffer(the_repository, oid, type, size,
+				  contents, &eaten);
 
 	if (!eaten)
 		free(contents);
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index e2f670bef9e..0dd10693597 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -848,7 +848,8 @@ static void sha1_object(const void *data, struct object_entry *obj_entry,
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
index 9a4d2708123..8e454c48649 100644
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
index 4de4fa58d59..0ffcf619cef 100644
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
index fa41d711f44..7526ee151f5 100644
--- a/object.h
+++ b/object.h
@@ -136,7 +136,8 @@ struct object *parse_object_or_die(const struct object_id *oid, const char *name
  * parsing it.  eaten_p indicates if the object has a borrowed copy
  * of buffer and the caller should not free() it.
  */
-struct object *parse_object_buffer(const struct object_id *oid, enum object_type type, unsigned long size, void *buffer, int *eaten_p);
+#define parse_object_buffer(r, o, t, s, b, e) parse_object_buffer_##r(o, t, s, b, e)
+struct object *parse_object_buffer_the_repository(const struct object_id *oid, enum object_type type, unsigned long size, void *buffer, int *eaten_p);
 
 /** Returns the object, with potentially excess memory allocated. **/
 struct object *lookup_unknown_object(const unsigned  char *sha1);
diff --git a/ref-filter.c b/ref-filter.c
index 6ebb4630f9c..7e57c07bf54 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -806,7 +806,8 @@ static void *get_obj(const struct object_id *oid, struct object **obj, unsigned
 	void *buf = read_object_file(oid, &type, sz);
 
 	if (buf)
-		*obj = parse_object_buffer(oid, type, *sz, buf, eaten);
+		*obj = parse_object_buffer(the_repository, oid, type, *sz,
+					   buf, eaten);
 	else
 		*obj = NULL;
 	return buf;
-- 
2.18.0.rc1.244.gcf134e6275-goog

