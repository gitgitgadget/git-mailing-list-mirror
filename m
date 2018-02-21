Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DB541F404
	for <e@80x24.org>; Wed, 21 Feb 2018 01:55:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751502AbeBUBzP (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Feb 2018 20:55:15 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:41323 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751499AbeBUBzN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Feb 2018 20:55:13 -0500
Received: by mail-pf0-f194.google.com with SMTP id a17so56050pff.8
        for <git@vger.kernel.org>; Tue, 20 Feb 2018 17:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dxFHaS/6rGfhWzUvRc9nYyNb8VLOSJZGm6ff5t0sUro=;
        b=SDTeLMOYhGZT9MB1HFrkglFeweXsjxXQIA+XWTwVNfqSwOAuaOlaysRquqBLsoJecD
         Y19gXAjh8erF2lQGkv02M3S0eObUXNOkFUAIjn8yZt1jXNgMZZiIqOceYmJF3lTy3601
         Zx+J/UY/a4Lxjv1Jv9n9PZ15QSaxPrNBsezCa4oW4Z+KPho9ExlJHP+/Lcha1DQbf7og
         4qkRlNvDwLcessz7zNJNJ2PDYXx+6vS3+EmcxMjUb+nzQvglz6Ugn/eSeZrcBitZ94LR
         3nRJU3n8vm32+vKIbpvhqnIPBY7jW6FhKaEAJtvW3tYTgTVLLhcd1VJt+BFbTlNJv5Wo
         8/zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dxFHaS/6rGfhWzUvRc9nYyNb8VLOSJZGm6ff5t0sUro=;
        b=TFCEmsXiU1TAU9xKg44Rzno0Yi2igMcKgWgLNxJ7GN8za/s1C5zOU5/mxjOAYmoaqM
         Io75V5mI6CA6J4AXl4E4h/FFmQMLlPQiTITkxuTDDQGKrLR4hbguCGgukZGteKX+BWYS
         x/TbZVHdoXca6WsPrvCaIlMaeIA41bh0a1XRx9gIroNEWlOacVLEDO3iZDQWPO9Tu9Yr
         lqP3FkeTacnRc34ZkVMNBkcf5EDw8KDKORnmtP8LTXQ5okugbBqDzPOkgUUhLfGLbBgA
         HLogstMA/WN8bKhhxzj0mmvXCyg6qgkd8ONocpc3zrTrO99g/wo//1k6A9qUquah6m2P
         sNjA==
X-Gm-Message-State: APf1xPBr5uiu+BmmJwHG7HCause5nF0sC3QyJECyukouK/OexRw42xda
        RmkpqJOS0jdUNfYoSxSdtTKQ8g==
X-Google-Smtp-Source: AH8x224v69GCOKdi1hOQ7aOoCzZtAq6wZSUBRVCAh76D0/79xnDm/SzSG4CBptCER5ABQMeMg310/Q==
X-Received: by 10.98.247.9 with SMTP id h9mr1600037pfi.212.1519178112616;
        Tue, 20 Feb 2018 17:55:12 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id n79sm40350189pfa.55.2018.02.20.17.55.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Feb 2018 17:55:11 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com,
        pclouds@gmail.com, sunshine@sunshineco.com,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 20/27] sha1_file: add repository argument to map_sha1_file
Date:   Tue, 20 Feb 2018 17:54:23 -0800
Message-Id: <20180221015430.96054-21-sbeller@google.com>
X-Mailer: git-send-email 2.16.1.291.g4437f3f132-goog
In-Reply-To: <20180221015430.96054-1-sbeller@google.com>
References: <20180216174626.24677-1-sbeller@google.com>
 <20180221015430.96054-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a repository argument to allow map_sha1_file callers to be more
specific about which repository to handle. This is a small mechanical
change; it doesn't change the implementation to handle repositories
other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

While at it, move the declaration to object-store.h, where it should
be easier to find.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 cache.h        | 1 -
 object-store.h | 3 +++
 sha1_file.c    | 4 ++--
 streaming.c    | 5 ++++-
 4 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/cache.h b/cache.h
index e641c23b0a..d338b65d75 100644
--- a/cache.h
+++ b/cache.h
@@ -1242,7 +1242,6 @@ extern int pretend_sha1_file(void *, unsigned long, enum object_type, unsigned c
 extern int force_object_loose(const unsigned char *sha1, time_t mtime);
 extern int git_open_cloexec(const char *name, int flags);
 #define git_open(name) git_open_cloexec(name, O_RDONLY)
-extern void *map_sha1_file(const unsigned char *sha1, unsigned long *size);
 extern int unpack_sha1_header(git_zstream *stream, unsigned char *map, unsigned long mapsize, void *buffer, unsigned long bufsiz);
 extern int parse_sha1_header(const char *hdr, unsigned long *sizep);
 
diff --git a/object-store.h b/object-store.h
index 4f5060e768..a37d74a0c5 100644
--- a/object-store.h
+++ b/object-store.h
@@ -130,4 +130,7 @@ void raw_object_store_clear(struct raw_object_store *o);
 #define sha1_file_name(r, b, s) sha1_file_name_##r(b, s)
 void sha1_file_name_the_repository(struct strbuf *buf, const unsigned char *sha1);
 
+#define map_sha1_file(r, s, sz) map_sha1_file_##r(s, sz)
+void *map_sha1_file_the_repository(const unsigned char *sha1, unsigned long *size);
+
 #endif /* OBJECT_STORE_H */
diff --git a/sha1_file.c b/sha1_file.c
index 7fa9ed2f25..0d3ff99cf2 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -968,7 +968,7 @@ static void *map_sha1_file_1_the_repository(const char *path,
 	return map;
 }
 
-void *map_sha1_file(const unsigned char *sha1, unsigned long *size)
+void *map_sha1_file_the_repository(const unsigned char *sha1, unsigned long *size)
 {
 	return map_sha1_file_1(the_repository, NULL, sha1, size);
 }
@@ -1192,7 +1192,7 @@ static int sha1_loose_object_info(const unsigned char *sha1,
 		return 0;
 	}
 
-	map = map_sha1_file(sha1, &mapsize);
+	map = map_sha1_file(the_repository, sha1, &mapsize);
 	if (!map)
 		return -1;
 
diff --git a/streaming.c b/streaming.c
index 5892b50bd8..22d27df55e 100644
--- a/streaming.c
+++ b/streaming.c
@@ -3,6 +3,8 @@
  */
 #include "cache.h"
 #include "streaming.h"
+#include "repository.h"
+#include "object-store.h"
 #include "packfile.h"
 
 enum input_source {
@@ -335,7 +337,8 @@ static struct stream_vtbl loose_vtbl = {
 
 static open_method_decl(loose)
 {
-	st->u.loose.mapped = map_sha1_file(sha1, &st->u.loose.mapsize);
+	st->u.loose.mapped = map_sha1_file(the_repository,
+					   sha1, &st->u.loose.mapsize);
 	if (!st->u.loose.mapped)
 		return -1;
 	if ((unpack_sha1_header(&st->z,
-- 
2.16.1.291.g4437f3f132-goog

