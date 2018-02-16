Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15EA31F404
	for <e@80x24.org>; Fri, 16 Feb 2018 17:47:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162423AbeBPRrA (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Feb 2018 12:47:00 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:44006 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162393AbeBPRq5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Feb 2018 12:46:57 -0500
Received: by mail-pl0-f67.google.com with SMTP id f4so2044806plr.10
        for <git@vger.kernel.org>; Fri, 16 Feb 2018 09:46:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=913vh9+jjN+h6JFzvw811wkrTw15zLDgC/PSJVm75EA=;
        b=NBfeEYESu9uj8J+IY99U78aYVqTz4kskeSt3cZqSuoD0tkeZKQevmZWH/ZkzzGcQNc
         90q3Q2TKN/BOwNJlNt5LVLmQJmvxgO11yS8aWrsDm3dezeo2krI75Q3uM0jiMTeOjewZ
         w5iXMzkY8tQ1TWyIt2GDxUqbwhAGMD5y/7SLLzZaaRogQdfcj2pU2GTaJR/oubmnjSj0
         yP+av74l2uSRoOKHVT3Odv1AG+1MCJ7upAJuNreS8yobUfJnH3izyWtxf7cuRvZ4PGwD
         BKAWqrPlDyxZAtOxyS7fDQxPAgHCge9e3BSZ5F3DQ/kz/r4nfu+8/eEQE0DtO3k90aBx
         Ts3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=913vh9+jjN+h6JFzvw811wkrTw15zLDgC/PSJVm75EA=;
        b=IE8l7kAAMq1dgpowvdQEwZY3y+4areS2qmkSBRiCzUptHJt0M+BhqdfbK5SRjxegQQ
         aznrE3M71kSpMXJpr+Y+Yz4at9+8srJCr3G6uqZKeJ42gQV4y+3t4lOxpR+L9762+L9j
         FdC6YIJJZgsdkhcpddeUnY/zty2NFo3/7RrcmSLolyCjWZA9EP+xsIP3s8cOraXHG3Q9
         rJv1Pk7l4VYD5RuFR1wp6Pwz9z0bowVXS6r3hvCdCDSooqDwuimE9pvFvE5t34gqYh6B
         wbuqwohismtwP8QFCZjsA/k5q7RJSZEB1XxOSbAklcXYXUMn5fJHGT5CUnXeCou0dm8f
         MPOA==
X-Gm-Message-State: APf1xPBqXgRyOZelQ21G2AltUVtcu931r/OOlUmV/CACDfXOpVaBg9bM
        27mlzdeyTaREN4bB0vkP0XvKGQ7ZwME=
X-Google-Smtp-Source: AH8x224QKy3mtg3V1ZF3iPketpVVWS780LAQRdoqCUGUliyhMI+DCL/1+4wv9gDaRlv8DJ2QPW78cA==
X-Received: by 2002:a17:902:6b81:: with SMTP id p1-v6mr4921322plk.348.1518803216885;
        Fri, 16 Feb 2018 09:46:56 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id l19sm30439221pgc.47.2018.02.16.09.46.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Feb 2018 09:46:56 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, jonathantanmy@google.com, pclouds@gmail.com,
        sbeller@google.com, sunshine@sunshineco.com,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 15/16] sha1_file: allow map_sha1_file to handle arbitrary object stores
Date:   Fri, 16 Feb 2018 09:46:25 -0800
Message-Id: <20180216174626.24677-16-sbeller@google.com>
X-Mailer: git-send-email 2.16.1.291.g4437f3f132-goog
In-Reply-To: <20180216174626.24677-1-sbeller@google.com>
References: <xmqqlgfu7zn5.fsf@gitster-ct.c.googlers.com>
 <20180216174626.24677-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 cache.h        | 1 -
 object-store.h | 2 ++
 sha1_file.c    | 7 ++++---
 streaming.c    | 5 ++++-
 4 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/cache.h b/cache.h
index 2495c7081d..df29ee72e9 100644
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
index 5f6beb9d91..30b4cfdbf5 100644
--- a/object-store.h
+++ b/object-store.h
@@ -73,6 +73,8 @@ extern struct packed_git {
  */
 void sha1_file_name(struct raw_object_store *o, struct strbuf *buf, const unsigned char *sha1);
 
+void *map_sha1_file(struct raw_object_store *o, const unsigned char *sha1, unsigned long *size);
+
 void prepare_alt_odb(struct raw_object_store *o);
 
 #endif /* OBJECT_STORE_H */
diff --git a/sha1_file.c b/sha1_file.c
index aeb925a895..4cbff471a2 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -962,9 +962,10 @@ static void *map_sha1_file_1(struct raw_object_store *o, const char *path,
 	return map;
 }
 
-void *map_sha1_file(const unsigned char *sha1, unsigned long *size)
+void *map_sha1_file(struct raw_object_store *o,
+		    const unsigned char *sha1, unsigned long *size)
 {
-	return map_sha1_file_1(&the_repository->objects, NULL, sha1, size);
+	return map_sha1_file_1(o, NULL, sha1, size);
 }
 
 static int unpack_sha1_short_header(git_zstream *stream,
@@ -1186,7 +1187,7 @@ static int sha1_loose_object_info(const unsigned char *sha1,
 		return 0;
 	}
 
-	map = map_sha1_file(sha1, &mapsize);
+	map = map_sha1_file(&the_repository->objects, sha1, &mapsize);
 	if (!map)
 		return -1;
 
diff --git a/streaming.c b/streaming.c
index 5892b50bd8..6888448b12 100644
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
+	st->u.loose.mapped = map_sha1_file(&the_repository->objects,
+					   sha1, &st->u.loose.mapsize);
 	if (!st->u.loose.mapped)
 		return -1;
 	if ((unpack_sha1_header(&st->z,
-- 
2.16.1.291.g4437f3f132-goog

