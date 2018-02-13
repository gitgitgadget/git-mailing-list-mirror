Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 363B11F404
	for <e@80x24.org>; Tue, 13 Feb 2018 01:23:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933245AbeBMBXU (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Feb 2018 20:23:20 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36834 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933237AbeBMBXS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Feb 2018 20:23:18 -0500
Received: by mail-pg0-f66.google.com with SMTP id j9so7668092pgv.3
        for <git@vger.kernel.org>; Mon, 12 Feb 2018 17:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7m7xflHhhxEmAET86gfO7l/LyJnxhkPHYzqiDL2d9oA=;
        b=MIZtyaEmW3w3V1WNDZo7Kc4axa0O5YFfe2PgEe4rxhB4mT1dp33ED/8PkS1xUmBWXi
         x9xvsRJBYkEGqYVfuPOO9hfVkPhrNXKwOVMOLDHe0cyb3Ngiix+vTKRk9CRjA8zfkdI3
         24LlJjXYB34wU8tEcST3GYqIIVVfLfjuCwWXhzHr95H3/pDfI3vdnegTf+rFLjFLjeEJ
         fvX0p7dwLo9fBtuNv/Wx3rXGeKkwqB11zgb9bWuuNcGhWYER4IsPcuhr7EQFmAT82/Qc
         kNBOHbaW+t51mjj6jrdXyirH0QVNORaU/GHZJuHkZfvJE+cwNl7lkCr72nP9zEUN7746
         cHcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7m7xflHhhxEmAET86gfO7l/LyJnxhkPHYzqiDL2d9oA=;
        b=OpBgCtCY++gmTFTfJig03H83O9ctaYo8cDfItxSRjM0vVbwLf6MAccyuSILcOgBziO
         SZoORMl052PEEy2Te+/yX9w2+UuekJuL9XFKpua5aWcMMmqn4Q0zy4KzIJoJdWyy4HV4
         evcNIUpKi9GVyMWS4yd5JD5xyabCv391DzeBo1AiGUHdCfjxJjowe265ogiqNlcRgu9v
         dHQPxTwaZnfQCPph6tPo84g+3Z3kz6ySBF986/pxGbQrUr9BxLRzSrxm1ZZjR1YxfL12
         Q3O7Db7qLUFJ1sw3VXWtdt9by8UXi2SDYGAFwoSNdT5bW2NMCVmdYQZmRpPD+euD19fh
         t2Vw==
X-Gm-Message-State: APf1xPC4G0m4EGSuRiKxDmKTiS3UAT1pnRUqU8gb5Btil/GLAAfuG+sx
        jzhhR4CCP++YpeoHXuqDBdTZ/w==
X-Google-Smtp-Source: AH8x227jAw/8W+2ZKAUHSwCBSR0RjM4j+Bc4q4kuGazioa/Iw/MthH63BQvvEzX71xSAwkfyB1OUEA==
X-Received: by 10.99.56.7 with SMTP id f7mr10857981pga.114.1518484997526;
        Mon, 12 Feb 2018 17:23:17 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id 125sm25148742pff.19.2018.02.12.17.23.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Feb 2018 17:23:16 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, pclouds@gmail.com, sunshine@sunshineco.com,
        jonathantanmy@google.com, Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 19/26] sha1_file: add repository argument to map_sha1_file
Date:   Mon, 12 Feb 2018 17:22:34 -0800
Message-Id: <20180213012241.187007-20-sbeller@google.com>
X-Mailer: git-send-email 2.16.1.73.ga2c3e9663f.dirty
In-Reply-To: <20180213012241.187007-1-sbeller@google.com>
References: <20180213012241.187007-1-sbeller@google.com>
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
index 4b01c0de10..d0a1236dac 100644
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
index 5422e80c08..0a4561f476 100644
--- a/object-store.h
+++ b/object-store.h
@@ -69,6 +69,8 @@ struct packed_git {
  */
 #define sha1_file_name(r, s) sha1_file_name_##r(s)
 const char *sha1_file_name_the_repository(const unsigned char *sha1);
+#define map_sha1_file(r, s, sz) map_sha1_file_##r(s, sz)
+void *map_sha1_file_the_repository(const unsigned char *sha1, unsigned long *size);
 
 void prepare_alt_odb(struct repository *r);
 
diff --git a/sha1_file.c b/sha1_file.c
index f706526bc2..1ce4058644 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -960,7 +960,7 @@ static void *map_sha1_file_1_the_repository(const char *path,
 	return map;
 }
 
-void *map_sha1_file(const unsigned char *sha1, unsigned long *size)
+void *map_sha1_file_the_repository(const unsigned char *sha1, unsigned long *size)
 {
 	return map_sha1_file_1(the_repository, NULL, sha1, size);
 }
@@ -1184,7 +1184,7 @@ static int sha1_loose_object_info(const unsigned char *sha1,
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
2.16.1.73.ga2c3e9663f.dirty

