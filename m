Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39FE11F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:18:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752173AbeBFASf (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:18:35 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33075 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752156AbeBFASa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:18:30 -0500
Received: by mail-pg0-f68.google.com with SMTP id u1so171284pgr.0
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DD0+K17wV3zc3M4I8BpQZlJc8dCyTplh7xOT7aB/QgI=;
        b=ZHffO0JtUp56lelOYYykfx9ieh+RmvQWR725YSOYmL7P0AwAXuWRRxCmo9K8DZkYop
         msXITekhaZfT5EuAbcq3yZlJ3mSHCM7sdBCAb/hWlZ05+zOtO0D2iqvSGVAAShiJZQAP
         qhVNkxQWFpiN62pJa2bQUCnMFS8X5fx9lkE1jzq9W9N7FSfrRDSklrTDoIcFwQt/jQPN
         PntkETfuIMD4JKK8Z3B3xVBpwbQaeOyIulI0MPvKr0UBw5q4dKeb4CX5XZA74wGg3Kp8
         DKKIlLSF+tNFhtDRsgRVu9VFuadxIbak3scQm4MsBomd7FxCwxRZuixVd7c+lJdunzny
         XRzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DD0+K17wV3zc3M4I8BpQZlJc8dCyTplh7xOT7aB/QgI=;
        b=cN+qBANKCWAAltjfDA66RCPAZMm9/2ZtgajKI7bZB50UQgXlF6OqknjZmNpI01HLt1
         cNbBh7AvnLgu8GS0ZYqk2L0mOvKe5QqupiEQBY4b1jnN16LMSdetZR/GGPOyG2RRQKhF
         BSqj3Z+zmOalGYQ43MTzMA7keGpLEykSvVHvqb9y3yyM2zQx3f3fnFB/7wP9YBFyHILb
         g0pJ7G3tzzLtS6e2bstYI96G/EjQIE4S7dcAnDySxqy5R1ktIS+TZXmLbmq5z/v6iLjv
         S/Um++6st+htKKSn/fo52fvEFR2JTfL7ji57r/JO4RCiNd9NtekzOIt/RnY1ynEwxYGJ
         0fdg==
X-Gm-Message-State: APf1xPAAE4P8CjvZ0o8SLYtjovD5WX3DTnKS1oB/rOk8LaPJ0UA8Gl4M
        9IJLaBZrOxhK1WI1BqgcCLVzau1JlKE=
X-Google-Smtp-Source: AH8x224KxOqdbMSdgfpuNxaJllrp5GNLRzGkD84UARU7Tj41kBTWR7ygeBBjdUqE+HsCQt7jqh7vJA==
X-Received: by 10.101.68.66 with SMTP id e2mr423187pgq.289.1517876309302;
        Mon, 05 Feb 2018 16:18:29 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id w9sm19693757pfl.74.2018.02.05.16.18.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:18:28 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 104/194] object: add repository argument to parse_object_buffer
Date:   Mon,  5 Feb 2018 16:16:19 -0800
Message-Id: <20180206001749.218943-6-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180206001749.218943-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180206001749.218943-1-sbeller@google.com>
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

Add the cocci patch that converted the callers.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/fast-export.c                  |  3 ++-
 builtin/fsck.c                         |  6 ++++--
 builtin/index-pack.c                   |  3 ++-
 builtin/unpack-objects.c               |  3 ++-
 contrib/coccinelle/object_parser.cocci | 11 +++++++++++
 object.c                               |  5 +++--
 object.h                               |  3 ++-
 ref-filter.c                           |  3 ++-
 8 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 322adfd408..b0f229351d 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -244,7 +244,8 @@ static void export_blob(const struct object_id *oid)
 			die ("Could not read blob %s", oid_to_hex(oid));
 		if (check_sha1_signature(oid->hash, buf, size, typename(type)) < 0)
 			die("sha1 mismatch in blob %s", oid_to_hex(oid));
-		object = parse_object_buffer(oid, type, size, buf, &eaten);
+		object = parse_object_buffer(the_repository, oid, type,
+					     size, buf, &eaten);
 	}
 
 	if (!object)
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 78cd8cdc69..527c03eb39 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -377,7 +377,8 @@ static int fsck_obj_buffer(const struct object_id *oid, enum object_type type,
 	 * verify_packfile(), data_valid variable for details.
 	 */
 	struct object *obj;
-	obj = parse_object_buffer(oid, type, size, buffer, eaten);
+	obj = parse_object_buffer(the_repository, oid, type, size, buffer,
+				  eaten);
 	if (!obj) {
 		errors_found |= ERROR_OBJECT;
 		return error("%s: object corrupt or missing", oid_to_hex(oid));
@@ -499,7 +500,8 @@ static struct object *parse_loose_object(const struct object_id *oid,
 	if (!contents && type != OBJ_BLOB)
 		die("BUG: read_loose_object streamed a non-blob");
 
-	obj = parse_object_buffer(oid, type, size, contents, &eaten);
+	obj = parse_object_buffer(the_repository, oid, type, size,
+				  contents, &eaten);
 
 	if (!eaten)
 		free(contents);
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 67db12fc43..f570e16bb6 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -850,7 +850,8 @@ static void sha1_object(const void *data, struct object_entry *obj_entry,
 			 * we do not need to free the memory here, as the
 			 * buf is deleted by the caller.
 			 */
-			obj = parse_object_buffer(oid, type, size, buf,
+			obj = parse_object_buffer(the_repository, oid, type,
+						  size, buf,
 						  &eaten);
 			if (!obj)
 				die(_("invalid %s"), typename(type));
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 8d13c5145c..6b8fb918b6 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -263,7 +263,8 @@ static void write_object(unsigned nr, enum object_type type,
 		int eaten;
 		hash_sha1_file(buf, size, typename(type), obj_list[nr].oid.hash);
 		added_object(nr, type, buf, size);
-		obj = parse_object_buffer(&obj_list[nr].oid, type, size, buf,
+		obj = parse_object_buffer(the_repository, &obj_list[nr].oid,
+					  type, size, buf,
 					  &eaten);
 		if (!obj)
 			die("invalid %s", typename(type));
diff --git a/contrib/coccinelle/object_parser.cocci b/contrib/coccinelle/object_parser.cocci
index 43a312480f..c2886c5e50 100644
--- a/contrib/coccinelle/object_parser.cocci
+++ b/contrib/coccinelle/object_parser.cocci
@@ -45,6 +45,17 @@ expression E;
 + the_repository,
  E)
 
+@@
+expression E;
+expression F;
+expression G;
+expression H;
+expression I;
+@@
+parse_object_buffer(
++ the_repository,
+ E, F, G, H, I)
+
 @@
 expression E;
 expression F;
diff --git a/object.c b/object.c
index 9edddbe1d4..a10983755c 100644
--- a/object.c
+++ b/object.c
@@ -184,7 +184,7 @@ struct object *lookup_unknown_object(struct repository *r,
 	return obj;
 }
 
-struct object *parse_object_buffer(const struct object_id *oid, enum object_type type, unsigned long size, void *buffer, int *eaten_p)
+struct object *parse_object_buffer_the_repository(const struct object_id *oid, enum object_type type, unsigned long size, void *buffer, int *eaten_p)
 {
 	struct object *obj;
 	*eaten_p = 0;
@@ -276,7 +276,8 @@ struct object *parse_object_the_repository(const struct object_id *oid)
 			return NULL;
 		}
 
-		obj = parse_object_buffer(oid, type, size, buffer, &eaten);
+		obj = parse_object_buffer(the_repository, oid, type, size,
+					  buffer, &eaten);
 		if (!eaten)
 			free(buffer);
 		return obj;
diff --git a/object.h b/object.h
index dd009a03ec..c9ea2285e8 100644
--- a/object.h
+++ b/object.h
@@ -127,7 +127,8 @@ struct object *parse_object_or_die(const struct object_id *oid, const char *name
  * parsing it.  eaten_p indicates if the object has a borrowed copy
  * of buffer and the caller should not free() it.
  */
-struct object *parse_object_buffer(const struct object_id *oid, enum object_type type, unsigned long size, void *buffer, int *eaten_p);
+#define parse_object_buffer(r, o, t, s, b, e) parse_object_buffer_##r(o, t, s, b, e)
+struct object *parse_object_buffer_the_repository(const struct object_id *oid, enum object_type type, unsigned long size, void *buffer, int *eaten_p);
 
 /** Returns the object, with potentially excess memory allocated. **/
 struct object *lookup_unknown_object(struct repository *r, const unsigned char *sha1);
diff --git a/ref-filter.c b/ref-filter.c
index b4b6f8801c..256887b585 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -733,7 +733,8 @@ static void *get_obj(const struct object_id *oid, struct object **obj, unsigned
 	void *buf = read_sha1_file(oid->hash, &type, sz);
 
 	if (buf)
-		*obj = parse_object_buffer(oid, type, *sz, buf, eaten);
+		*obj = parse_object_buffer(the_repository, oid, type, *sz,
+					   buf, eaten);
 	else
 		*obj = NULL;
 	return buf;
-- 
2.15.1.433.g936d1b9894.dirty

