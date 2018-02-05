Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CA261F404
	for <e@80x24.org>; Mon,  5 Feb 2018 23:59:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752323AbeBEX7W (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 18:59:22 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35936 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752132AbeBEX6L (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 18:58:11 -0500
Received: by mail-pg0-f66.google.com with SMTP id x25so123558pge.3
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 15:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4ao9hGMpPl/4/MNp7po5bKgOpYwBOLWk+KE9y+yBNtM=;
        b=Yg+2FmQdaAiMnv6NbHRXSnkYKJK1wD/mXGk0+oeqeuMZ0g5V7vScRgJ6ZiRCsRUkhf
         MZxgirLwZlgMkAqYIERZoNpcNBmTHv8FLR2gXYdcSrMeJhEWQv/pE30ACYfaoI5UMptI
         KfOXXty4d0tb1wEwZoMlmub0nddpXOAtq3lmsKjxpQ8IysI+qhIY6p1U7EqVtDER7XY+
         3gad1cg/+1thAACIJZpPQeP5PYkzAwTdqITmXZakmVjGMaPybhG+w6G33snuenYMXBs0
         265hIIXay88dZsVxM+m0EEeGdLaX0a7gRnYRO1GIOeQ+9wm5jJuHMRFeeV6EyRGnQqA6
         ZHyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4ao9hGMpPl/4/MNp7po5bKgOpYwBOLWk+KE9y+yBNtM=;
        b=aRsxqNox26BrQn4SJBuMmZbHlQmLqL5Z9L0tJqQA8xAN0Cal7GaYlTpbv2chxVWsLw
         EGN5gBAs81bdiuFNj2a6ypmUI689EIOp37H3eNhYXh+vm2nmbZw8+iRuglxXGBJGAERn
         R5G1vTVZB6NYqNvLZxLnDbluaCvsyjkhxVo0Dp8WdVNyb6mxFeyvyolR3o49kfLHj1ZY
         VvVIradN8vLaamV4ikgZvx/4EwLzEIz2VLESEdtVHlyrV8VJapfIQ41iycMi1ZTFh9Kv
         u+cQi9SXHB6JsSKlf0CRdbcYwtsVB9YBvNKtG9SyBUxuYK7GxAQrIqrfof16mC87ud2h
         HKWA==
X-Gm-Message-State: APf1xPAPqrNgFZb8iP0anWdCl0HWkXnlmE/6moydOJ9twdZu8TRZJKU1
        VofwdW9W++hkunbJmw65NGzM4P/+Lu0=
X-Google-Smtp-Source: AH8x225l4fGa9FdNm/GsClc+Va2UGDeySG/t5O8Ew5i9lwEnpH9c11nd6fTLC/7ufroUy4uDTaCg7w==
X-Received: by 10.98.207.6 with SMTP id b6mr481593pfg.187.1517875090812;
        Mon, 05 Feb 2018 15:58:10 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id w16sm19454650pfk.18.2018.02.05.15.58.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 15:58:10 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 023/194] pack: add repository argument to map_sha1_file
Date:   Mon,  5 Feb 2018 15:54:44 -0800
Message-Id: <20180205235735.216710-3-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180205235735.216710-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180205235735.216710-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jonathan Nieder <jrnieder@gmail.com>

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
 object-store.h | 2 ++
 sha1_file.c    | 4 ++--
 streaming.c    | 5 ++++-
 4 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/cache.h b/cache.h
index 63ed5ccf0a..051a77c49a 100644
--- a/cache.h
+++ b/cache.h
@@ -1237,7 +1237,6 @@ extern int pretend_sha1_file(void *, unsigned long, enum object_type, unsigned c
 extern int force_object_loose(const unsigned char *sha1, time_t mtime);
 extern int git_open_cloexec(const char *name, int flags);
 #define git_open(name) git_open_cloexec(name, O_RDONLY)
-extern void *map_sha1_file(const unsigned char *sha1, unsigned long *size);
 extern int unpack_sha1_header(git_zstream *stream, unsigned char *map, unsigned long mapsize, void *buffer, unsigned long bufsiz);
 extern int parse_sha1_header(const char *hdr, unsigned long *sizep);
 
diff --git a/object-store.h b/object-store.h
index 228c2ce8ae..92fbf4a9ca 100644
--- a/object-store.h
+++ b/object-store.h
@@ -62,6 +62,8 @@ struct packed_git {
  */
 #define sha1_file_name(r, s) sha1_file_name_##r(s)
 extern const char *sha1_file_name_the_repository(const unsigned char *sha1);
+#define map_sha1_file(r, s, sz) map_sha1_file_##r(s, sz)
+extern void *map_sha1_file_the_repository(const unsigned char *sha1, unsigned long *size);
 
 #define prepare_alt_odb(r) prepare_alt_odb_##r()
 extern void prepare_alt_odb_the_repository(void);
diff --git a/sha1_file.c b/sha1_file.c
index caad178b14..af0bf57e07 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -963,7 +963,7 @@ static void *map_sha1_file_1_the_repository(const char *path,
 	return map;
 }
 
-void *map_sha1_file(const unsigned char *sha1, unsigned long *size)
+void *map_sha1_file_the_repository(const unsigned char *sha1, unsigned long *size)
 {
 	return map_sha1_file_1(the_repository, NULL, sha1, size);
 }
@@ -1188,7 +1188,7 @@ static int sha1_loose_object_info_the_repository(const unsigned char *sha1,
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
2.15.1.433.g936d1b9894.dirty

