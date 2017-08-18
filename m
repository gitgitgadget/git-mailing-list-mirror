Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BD90208CD
	for <e@80x24.org>; Fri, 18 Aug 2017 22:21:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751888AbdHRWVU (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Aug 2017 18:21:20 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:36473 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751594AbdHRWVK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Aug 2017 18:21:10 -0400
Received: by mail-pg0-f53.google.com with SMTP id i12so72237054pgr.3
        for <git@vger.kernel.org>; Fri, 18 Aug 2017 15:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=4pAJ06he4xVOoY/UIAzkBfJLES+9/B2Lk6hgs3YPuY4=;
        b=XvmE/001PYSarX3HLIkFE/ZbMtwhIk6IwNjH468ossyTSsSSjbwA3TssLzvL7y8u+R
         zcPgNhZhrdyDexxy39/mY/fnBvrwHGgMI65xXDCxsmEA2A0CxRKT8mm1T8jh5wN2JpWs
         FCXMm/3oP0IOirH56QyzB1vykah48LEfwCIRTwcgovhhK5IwxG27xXLE5K+aI594ihto
         pjARN4cngSvNyQKN3Lpas7CLuh1mOiezqVExTvJ+73nQUiVUU6Y5BQjMNmLKc6KZDS7a
         esvWjog2SN5PkUkzGUEKV8LQBFnltN/eqwRS5jZwZ4EXi/8FcjmjQEqzDqMaltr6X22B
         cJiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=4pAJ06he4xVOoY/UIAzkBfJLES+9/B2Lk6hgs3YPuY4=;
        b=W9tAA/SNiREa+QVcRwBV0RfzOKpBly3kyizE/cDG7sxo18nYwShrrW+WxWa0LUzPVH
         6UuuCTIIqHneSoRhrBNCZJhCu/hv3F64oOWrzCIv6+E7ll4elK2OPMVM8lg1pzuij/tp
         odmg6Q8UBWklAuo+P0K4qL+IePEoea0hHspV/ST/GuChHn8z87V+kYEMQTL3FJge+ntw
         8Q3kRKJf97CGDWjqAyuBcOEeujcyL5H6h7A4KJPLZjGG/5+wl+kqGlHh+DCPRCegt6o/
         eDyE6SppWrf8HSqdrtZSo6eXtATrgXf70IVfJ3bLiAcrfX8VosCyIwxuj7DOMLQLW+7C
         AHYw==
X-Gm-Message-State: AHYfb5jfsZmE2patQPYWs/kK3m4psZ0bzY393Lb82MpehgJozf9w04hp
        zxl0XHh7xA5IYVQw4nnvkA==
X-Received: by 10.99.131.67 with SMTP id h64mr9697419pge.310.1503094869811;
        Fri, 18 Aug 2017 15:21:09 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id w123sm12544006pfb.60.2017.08.18.15.21.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 18 Aug 2017 15:21:09 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
Subject: [PATCH v3 22/23] pack: move has_pack_index()
Date:   Fri, 18 Aug 2017 15:20:37 -0700
Message-Id: <226bb9f72592df0146bb878ff4d0062e8ede876f.1503094448.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.14.1.480.gb18f417b89-goog
In-Reply-To: <cover.1503094448.git.jonathantanmy@google.com>
References: <cover.1503094448.git.jonathantanmy@google.com>
In-Reply-To: <cover.1503094448.git.jonathantanmy@google.com>
References: <cover.1502220307.git.jonathantanmy@google.com> <cover.1503094448.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 cache.h     | 2 --
 packfile.c  | 8 ++++++++
 packfile.h  | 2 ++
 sha1_file.c | 8 --------
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/cache.h b/cache.h
index 286891df4..dcbe37a3f 100644
--- a/cache.h
+++ b/cache.h
@@ -1233,8 +1233,6 @@ extern int has_object_file_with_flags(const struct object_id *oid, int flags);
  */
 extern int has_loose_object_nonlocal(const unsigned char *sha1);
 
-extern int has_pack_index(const unsigned char *sha1);
-
 extern void assert_sha1_type(const unsigned char *sha1, enum object_type expect);
 
 /* Helper to check and "touch" a file */
diff --git a/packfile.c b/packfile.c
index 7472ab816..7e293761b 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1846,3 +1846,11 @@ int has_sha1_pack(const unsigned char *sha1)
 	struct pack_entry e;
 	return find_pack_entry(sha1, &e);
 }
+
+int has_pack_index(const unsigned char *sha1)
+{
+	struct stat st;
+	if (stat(sha1_pack_index_name(sha1), &st))
+		return 0;
+	return 1;
+}
diff --git a/packfile.h b/packfile.h
index 4945a1505..1b6ea832c 100644
--- a/packfile.h
+++ b/packfile.h
@@ -122,4 +122,6 @@ extern int find_pack_entry(const unsigned char *sha1, struct pack_entry *e);
 
 extern int has_sha1_pack(const unsigned char *sha1);
 
+extern int has_pack_index(const unsigned char *sha1);
+
 #endif
diff --git a/sha1_file.c b/sha1_file.c
index e4975e0ae..fa422435f 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1622,14 +1622,6 @@ int force_object_loose(const unsigned char *sha1, time_t mtime)
 	return ret;
 }
 
-int has_pack_index(const unsigned char *sha1)
-{
-	struct stat st;
-	if (stat(sha1_pack_index_name(sha1), &st))
-		return 0;
-	return 1;
-}
-
 int has_sha1_file_with_flags(const unsigned char *sha1, int flags)
 {
 	if (!startup_info->have_repository)
-- 
2.14.1.480.gb18f417b89-goog

