Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04F4E1F42D
	for <e@80x24.org>; Wed, 30 May 2018 00:48:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968252AbeE3Ash (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 May 2018 20:48:37 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:33140 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965529AbeE3As0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 May 2018 20:48:26 -0400
Received: by mail-pl0-f68.google.com with SMTP id n10-v6so9959163plp.0
        for <git@vger.kernel.org>; Tue, 29 May 2018 17:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=R6sFfkAsggIodF5/XPe16o9/q0pfG2wCQCx/jGIGpBI=;
        b=fAYELo5NwT0gKPVj0tJORFkGi0ab/lNyd1ju7XSXMelKUSrIKuRkTAyl4jLUqyfntt
         li22mnHesPxgXZUh1HG10eDI3ADiKtq1y8ahjExti8SxhAeAtKfY0GTeeerYGEFtMQW7
         JhSZpB2TrwqvW7mYCT5Tcstbr4KsRqZT3gRNaIYPI5BNNaq0NXsTA3baZoX2msD15+Jq
         jKYbP+TsNgkj5XFpvTGzhTr//POsk9F4TAfJNg4PM3brdr+Mx6rJYHE++uJ/iz/Q4OCK
         28qkyZcbXKCcwrtix3ak+NnX4WIUop26QC1zNpqoiAas210gC0uPe/UmXP9S0YFXWesh
         3urg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=R6sFfkAsggIodF5/XPe16o9/q0pfG2wCQCx/jGIGpBI=;
        b=KaOcCqGOOKgKLMRs3btTbi6RYCWMs1wPzwxE4FAY2Ly3n3uZury2dRQzXVt9sERALP
         bJbjZvzWCPc2wmZEMT35zJnj4ZWiAPKD221sACEPV8m8GMv2uHhbLrZf6O0+OArijs1B
         OVpZGaXg9PKTHaOjjxJVsSLfU1SaLoyCfkZEgTDcmua4rElJc0ddmkrRWcN6ycnKzA30
         vzezHT4ADtrOeUHUwQOjX8Kti4nTJvPw96+91eKn5jMbXEMvU987awvd2RCWxMYTeJJh
         wPmAfmdHS6A4wN0BWy6hKwP3IquFCIK/LUH94lU7F8jf4ozOKTz5mL2bzI6L58JgxR0w
         uzHg==
X-Gm-Message-State: ALKqPwdz4d5REZHsQY09odiwt45CtGFvGFqfGnae1/QUDMO3VXKMSuER
        0G5hJYQ6fLl0TZwYPcF3zNg5loDU6T4=
X-Google-Smtp-Source: ADUXVKJrVZ6zTLqNEfyBAd71vDlzzGPVJJOO7c6oz/aiXqK/+ozSWJ0P29O2GUub7YMPUgt4JFknFQ==
X-Received: by 2002:a17:902:76c3:: with SMTP id j3-v6mr607485plt.15.1527641305668;
        Tue, 29 May 2018 17:48:25 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id p16-v6sm12950281pfd.47.2018.05.29.17.48.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 May 2018 17:48:24 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 04/35] object: add repository argument to parse_object_buffer
Date:   Tue, 29 May 2018 17:47:39 -0700
Message-Id: <20180530004810.30076-5-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c44.dirty
In-Reply-To: <20180530004810.30076-1-sbeller@google.com>
References: <20180530004810.30076-1-sbeller@google.com>
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
index 700739804fc..e6d6eb266eb 100644
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
index def3c71cac2..4250ddd3f7f 100644
--- a/object.c
+++ b/object.c
@@ -186,7 +186,7 @@ struct object *lookup_unknown_object_the_repository(const unsigned char *sha1)
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
index 778f83bf0f7..c6386d7b6b1 100644
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
 #define lookup_unknown_object(r, s) lookup_unknown_object_##r(s)
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
2.17.0.582.gccdcbd54c44.dirty

