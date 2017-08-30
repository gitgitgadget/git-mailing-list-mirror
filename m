Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 772A4208CD
	for <e@80x24.org>; Wed, 30 Aug 2017 07:07:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751284AbdH3HHN (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Aug 2017 03:07:13 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36149 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751100AbdH3HHM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2017 03:07:12 -0400
Received: by mail-pg0-f67.google.com with SMTP id 83so4481592pgb.3
        for <git@vger.kernel.org>; Wed, 30 Aug 2017 00:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tYbkfgY+OhQ/2/ptUBTeUqEolh/6yRAm1Pu1Spr3jdk=;
        b=nf66k3LrGa1CtsyzZV6P90feXT0V4iEiQo20/uk4TFYQ/v3EhEXZufK1z3u+QfI7au
         rh6oFnmNBFWgpz6YTs2NNttqAdFiuLZkJwjzkmScZyGKrG/N7yXXygADCC0RY6rJPB7T
         hH58JA9RDBiJ7DyPRcQrkeCPVp5Z/4TIJNq+1HDLbZwUlr4/Oj/FTZgaL26qtZ/YMIEy
         N/H2neNJMlEchKnwXvRCuKjLsojq7ENo95t3D/+puQos+fzAHEU+w43btX8z/qY/DoWx
         QjqhNHesZgtOutIJeNcvHWSmwrvUvpmn5fFPQjSnjx5L5CmXQXGMh67dZg19MiSI8sa2
         XLdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tYbkfgY+OhQ/2/ptUBTeUqEolh/6yRAm1Pu1Spr3jdk=;
        b=R3p6Hv7ClUqgvbZ2U+9SkmRdx15yFQ19DMMD9ewItd32i8uoPcpXjvWjj3RFzbaYE0
         hcBbsT4hKnJvOgB5KN8pauB/e//emkCNhx6Ch8ce1GoB9JqxBuqW1lXw7YFaef8hnvrv
         GQ6PQnXKpm7veQWagLvX4a5X/pYWtiqwPhQVK04/BpVeoWMxhBoYJl9E2PkhECbugcJh
         WBtCJqp95V5BFOxrm16nGoy1sz5/E22UNFcyNjq4VQR5yCXjGlY8rndZFKOuc/Yo9KS0
         kLylgG9jXFWC9iKV/6wG01IRj0YGq+q0y8LRXqQWQoTL5l35shVIy5igqMbsQM2Bv0Mm
         85mg==
X-Gm-Message-State: AHYfb5hKv9sFUd8RaHl1jJPk/0qstfseTer3zLOCUUvXY4g0gFxTpdFV
        6EZTUjB2SYQnsl7D6A4=
X-Received: by 10.98.192.20 with SMTP id x20mr645680pff.146.1504076832030;
        Wed, 30 Aug 2017 00:07:12 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:5042:50b1:56af:6f3d])
        by smtp.gmail.com with ESMTPSA id o64sm8766192pfk.84.2017.08.30.00.07.11
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 30 Aug 2017 00:07:11 -0700 (PDT)
Date:   Wed, 30 Aug 2017 00:07:09 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 24/39] pack: add repository argument to map_sha1_file
Message-ID: <20170830070709.GY153983@aiede.mtv.corp.google.com>
References: <20170830064634.GA153983@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170830064634.GA153983@aiede.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
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
 object-store.h | 2 ++
 sha1_file.c    | 4 ++--
 streaming.c    | 5 ++++-
 4 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/cache.h b/cache.h
index 0d120b9327..454cfb50c4 100644
--- a/cache.h
+++ b/cache.h
@@ -1176,7 +1176,6 @@ extern int pretend_sha1_file(void *, unsigned long, enum object_type, unsigned c
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
index 8ab26fb3b3..e7c86e5363 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -903,7 +903,7 @@ static void *map_sha1_file_1_the_repository(const char *path,
 	return map;
 }
 
-void *map_sha1_file(const unsigned char *sha1, unsigned long *size)
+void *map_sha1_file_the_repository(const unsigned char *sha1, unsigned long *size)
 {
 	return map_sha1_file_1(the_repository, NULL, sha1, size);
 }
@@ -1128,7 +1128,7 @@ static int sha1_loose_object_info_the_repository(const unsigned char *sha1,
 		return 0;
 	}
 
-	map = map_sha1_file(sha1, &mapsize);
+	map = map_sha1_file(the_repository, sha1, &mapsize);
 	if (!map)
 		return -1;
 
diff --git a/streaming.c b/streaming.c
index 6f1c60f12b..86808a6d99 100644
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
2.14.1.581.gf28d330327

