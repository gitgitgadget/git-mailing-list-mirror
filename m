Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB4501F576
	for <e@80x24.org>; Wed, 24 Jan 2018 11:13:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933271AbeAXLNB (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 06:13:01 -0500
Received: from mail-lf0-f65.google.com ([209.85.215.65]:33835 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933104AbeAXLMO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 06:12:14 -0500
Received: by mail-lf0-f65.google.com with SMTP id k19so4733786lfj.1
        for <git@vger.kernel.org>; Wed, 24 Jan 2018 03:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:in-reply-to
         :references;
        bh=NCwH7PFBP7cLZVKGZ4yeDdmYWg8o5l0lARduKpkpQ5o=;
        b=MWg612O79ssbbl/2Lj4Ueh1l8Ef6hPEwqd6X54lQ9gWpU7KpHBWEdBmHARVx0mut2G
         pBV3CLMkkHBEIXmPPCmBN7yrNAl4NoiGcrraj4rIMWgJllookgCmwp/1slx8PX0A6QZ8
         kOQtmLA48S7/IzRjhquj6nvp2BjwKbPe6dCZgvSw2Oz60YjF5uJwzRINQPBKrkSEKWk4
         IEWQL3kjIR7GGiA6Q3bwOIuZU/LSzkiUkTlLnB2u+zh4Altq2iQiuyHm/i5golJNhH1R
         KH/6M5U204+ulMVjL5Ra10R/fdA/kJvQ0YtgOsl478A6YNaQAzmXHEvnGdL2mlRTVnF/
         zF2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=NCwH7PFBP7cLZVKGZ4yeDdmYWg8o5l0lARduKpkpQ5o=;
        b=gI7PqTqyrVOz8JO8Wkk/US/E/htvXXQ3urhJWpkA3w6aLVo+lzjtoN5YPsVUH38W8M
         dgZSmK7ZhKHXxjoCnSAmkd3jgyfw/agjRuzBSFqFxMX0sh53iqTALi/yg6Y8nLyl/T/Q
         cKMf8/0RCqIpJtqdbc3GRuQ+vK0HdD9LGOJQhdyvQ/xDNPghGlvAfvATUGAZfrRfGN2x
         XldlmepbHuWIH++rdlcn07SH1eJ1He4I5/Cz7UwpoKJbyaadwZPoPNnmZtlZm3ZmQcj6
         7kUcuoudVCXVhkh7A+duXBfUejVidUpSSWUdB8PMZeNjjFcK4twZga3AAO3toCQ1bCXP
         EPew==
X-Gm-Message-State: AKwxytcl8ZhGult3RJQWlf5iO+mwslkTLEGih0k9zVlckOZaeJHGsXnV
        axQxUHidtRYKMS4CHMJ87ccau8CF
X-Google-Smtp-Source: AH8x224EdHilO0JYQKaSUgL/2us2N+c9BsGSHUGREJX8sSdle9Z1fEqfmgB8JYmXPn+/2LYRfALtIg==
X-Received: by 10.46.87.19 with SMTP id l19mr3266067ljb.138.1516792332268;
        Wed, 24 Jan 2018 03:12:12 -0800 (PST)
Received: from localhost.localdomain ([188.121.16.104])
        by smtp.gmail.com with ESMTPSA id i18sm14426ljd.27.2018.01.24.03.12.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Jan 2018 03:12:11 -0800 (PST)
From:   Patryk Obara <patryk.obara@gmail.com>
To:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH v3 03/14] sha1_file: convert pretend_sha1_file to object_id
Date:   Wed, 24 Jan 2018 12:11:55 +0100
Message-Id: <8f4ce3ddeac7eefd4c9de1b6919235d3f99f5639.1516790478.git.patryk.obara@gmail.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <cover.1516790478.git.patryk.obara@gmail.com>
References: <cover.1516617960.git.patryk.obara@gmail.com>
 <cover.1516790478.git.patryk.obara@gmail.com>
In-Reply-To: <cover.1516790478.git.patryk.obara@gmail.com>
References: <cover.1516790478.git.patryk.obara@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert the declaration and definition of pretend_sha1_file to use
struct object_id and adjust all usages of this function.  Rename it to
pretend_object_file.

Signed-off-by: Patryk Obara <patryk.obara@gmail.com>
---
 Documentation/technical/api-object-access.txt |  2 +-
 blame.c                                       |  2 +-
 cache.h                                       |  5 ++++-
 sha1_file.c                                   | 10 +++++-----
 4 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/Documentation/technical/api-object-access.txt b/Documentation/technical/api-object-access.txt
index 03bb0e950d..a1162e5bcd 100644
--- a/Documentation/technical/api-object-access.txt
+++ b/Documentation/technical/api-object-access.txt
@@ -7,7 +7,7 @@ Talk about <sha1_file.c> and <object.h> family, things like
 * read_object_with_reference()
 * has_sha1_file()
 * write_sha1_file()
-* pretend_sha1_file()
+* pretend_object_file()
 * lookup_{object,commit,tag,blob,tree}
 * parse_{object,commit,tag,blob,tree}
 * Use of object flags
diff --git a/blame.c b/blame.c
index 2893f3c103..1fc22b304b 100644
--- a/blame.c
+++ b/blame.c
@@ -232,7 +232,7 @@ static struct commit *fake_working_tree_commit(struct diff_options *opt,
 	convert_to_git(&the_index, path, buf.buf, buf.len, &buf, 0);
 	origin->file.ptr = buf.buf;
 	origin->file.size = buf.len;
-	pretend_sha1_file(buf.buf, buf.len, OBJ_BLOB, origin->blob_oid.hash);
+	pretend_object_file(buf.buf, buf.len, OBJ_BLOB, &origin->blob_oid);
 
 	/*
 	 * Read the current index, replace the path entry with
diff --git a/cache.h b/cache.h
index d8b975a571..e4e03ac51d 100644
--- a/cache.h
+++ b/cache.h
@@ -1241,7 +1241,10 @@ extern int sha1_object_info(const unsigned char *, unsigned long *);
 extern int hash_sha1_file(const void *buf, unsigned long len, const char *type, unsigned char *sha1);
 extern int write_sha1_file(const void *buf, unsigned long len, const char *type, unsigned char *return_sha1);
 extern int hash_sha1_file_literally(const void *buf, unsigned long len, const char *type, struct object_id *oid, unsigned flags);
-extern int pretend_sha1_file(void *, unsigned long, enum object_type, unsigned char *);
+
+extern int pretend_object_file(void *, unsigned long, enum object_type,
+			       struct object_id *oid);
+
 extern int force_object_loose(const unsigned char *sha1, time_t mtime);
 extern int git_open_cloexec(const char *name, int flags);
 #define git_open(name) git_open_cloexec(name, O_RDONLY)
diff --git a/sha1_file.c b/sha1_file.c
index 3da70ac650..830b93b428 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1312,13 +1312,13 @@ static void *read_object(const unsigned char *sha1, enum object_type *type,
 	return content;
 }
 
-int pretend_sha1_file(void *buf, unsigned long len, enum object_type type,
-		      unsigned char *sha1)
+int pretend_object_file(void *buf, unsigned long len, enum object_type type,
+			struct object_id *oid)
 {
 	struct cached_object *co;
 
-	hash_sha1_file(buf, len, typename(type), sha1);
-	if (has_sha1_file(sha1) || find_cached_object(sha1))
+	hash_sha1_file(buf, len, typename(type), oid->hash);
+	if (has_sha1_file(oid->hash) || find_cached_object(oid->hash))
 		return 0;
 	ALLOC_GROW(cached_objects, cached_object_nr + 1, cached_object_alloc);
 	co = &cached_objects[cached_object_nr++];
@@ -1326,7 +1326,7 @@ int pretend_sha1_file(void *buf, unsigned long len, enum object_type type,
 	co->type = type;
 	co->buf = xmalloc(len);
 	memcpy(co->buf, buf, len);
-	hashcpy(co->sha1, sha1);
+	hashcpy(co->sha1, oid->hash);
 	return 0;
 }
 
-- 
2.14.3

