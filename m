Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 225851FA7B
	for <e@80x24.org>; Tue, 20 Jun 2017 01:03:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752815AbdFTBDl (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Jun 2017 21:03:41 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:34022 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752774AbdFTBDf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 21:03:35 -0400
Received: by mail-pg0-f41.google.com with SMTP id e187so3195537pgc.1
        for <git@vger.kernel.org>; Mon, 19 Jun 2017 18:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=Ao9JAWeFIT5efLUCCk8wE/BT9dgncE5tILpIQFr96vw=;
        b=hC0qjmzwcAarOyaNls5rWr9T+vLaMBA5fAboOmSUIrpvRwiioyS7ZUp0S4Vlox9uSe
         tWAP6EAQ1WtR1VyUfCf97pSsOqOXpTiJJjbcjauHVXGPC41J4pOY2F9As0mOgpL5cVPU
         ZEeNjWXk9mvbTQaUQK4SVOVnjdgL7YiK7GDCrsZEzTnMdhnza7ghseQV0BbU4Lz6CyIW
         Eb/LILWJoyuWtugP+kv4dc1UvLbQshYFjt/HbjLIlL2P25RbH0a+hdWyv+DJ+p8TrqGn
         XTCYbJKCpcXiJwbWQKxVrbX1SuQp4B0hhtdjpIrT9A6eRgQJNN47Sb1FDidx50667/ci
         Xe9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=Ao9JAWeFIT5efLUCCk8wE/BT9dgncE5tILpIQFr96vw=;
        b=tmMZ3T0UJ6EBcw1m1FuSPwwURsHSMYc5//q/kBNyidhmr/SMrnZ6NUVwjS7JJT46ck
         4q8aKOQjFNlAcf/lCxCHjpsZj0NmK4BDp8rDQAVRsVA+7OKAMv3Yy7qMepNgQOwyCS+X
         DLFvRCyxUwl1csEGtB9BC+Klm2I8+s2wqvPVunC0gdX02fcVZmLAA7bSVrYrj3Hbw8Ky
         xGm1p5FhJMcDSbo+3NMQ2ivmzd0BJU/ojZSDkUzms+Mzyrhz0jXdCvC3Plyc0o9e3b3x
         4h9eWYRj4CBmA9ST22M+D0Zb0cUvnRoULW+u/RlprnXfPM4M8xUVWJmxH4bSdeydN4wk
         6EPw==
X-Gm-Message-State: AKS2vOwSr8v7nCdPH5MpfW2y7bNNrNgRM61NCwwO6KzksFJPQwzOdQeb
        eRKujgb+b4rND6K3RqdE5w==
X-Received: by 10.98.163.221 with SMTP id q90mr27517226pfl.64.1497920613899;
        Mon, 19 Jun 2017 18:03:33 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id l63sm22249819pfc.132.2017.06.19.18.03.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 19 Jun 2017 18:03:32 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        peff@peff.net
Subject: [PATCH v4 8/8] sha1_file: refactor has_sha1_file_with_flags
Date:   Mon, 19 Jun 2017 18:03:15 -0700
Message-Id: <024f4b122c7c1c105e9d5e0ff2c98b4b8b93feb2.1497920092.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.13.1.611.g7e3b11ae1-goog
In-Reply-To: <cover.1497920092.git.jonathantanmy@google.com>
References: <cover.1497920092.git.jonathantanmy@google.com>
In-Reply-To: <cover.1497920092.git.jonathantanmy@google.com>
References: <cover.1497035376.git.jonathantanmy@google.com> <cover.1497920092.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

has_sha1_file_with_flags() implements many mechanisms in common with
sha1_object_info_extended(). Make has_sha1_file_with_flags() a
convenience function for sha1_object_info_extended() instead.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 builtin/fetch.c      | 10 ++++++----
 builtin/index-pack.c |  3 ++-
 cache.h              | 11 +++--------
 sha1_file.c          | 13 +++----------
 4 files changed, 14 insertions(+), 23 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 47708451b..96d5146c4 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -242,9 +242,11 @@ static void find_non_local_tags(struct transport *transport,
 		 */
 		if (ends_with(ref->name, "^{}")) {
 			if (item &&
-			    !has_object_file_with_flags(&ref->old_oid, HAS_SHA1_QUICK) &&
+			    !has_object_file_with_flags(&ref->old_oid,
+							OBJECT_INFO_QUICK) &&
 			    !will_fetch(head, ref->old_oid.hash) &&
-			    !has_sha1_file_with_flags(item->util, HAS_SHA1_QUICK) &&
+			    !has_sha1_file_with_flags(item->util,
+						      OBJECT_INFO_QUICK) &&
 			    !will_fetch(head, item->util))
 				item->util = NULL;
 			item = NULL;
@@ -258,7 +260,7 @@ static void find_non_local_tags(struct transport *transport,
 		 * fetch.
 		 */
 		if (item &&
-		    !has_sha1_file_with_flags(item->util, HAS_SHA1_QUICK) &&
+		    !has_sha1_file_with_flags(item->util, OBJECT_INFO_QUICK) &&
 		    !will_fetch(head, item->util))
 			item->util = NULL;
 
@@ -279,7 +281,7 @@ static void find_non_local_tags(struct transport *transport,
 	 * checked to see if it needs fetching.
 	 */
 	if (item &&
-	    !has_sha1_file_with_flags(item->util, HAS_SHA1_QUICK) &&
+	    !has_sha1_file_with_flags(item->util, OBJECT_INFO_QUICK) &&
 	    !will_fetch(head, item->util))
 		item->util = NULL;
 
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 04b9dcaf0..587bc80c9 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -794,7 +794,8 @@ static void sha1_object(const void *data, struct object_entry *obj_entry,
 
 	if (startup_info->have_repository) {
 		read_lock();
-		collision_test_needed = has_sha1_file_with_flags(oid->hash, HAS_SHA1_QUICK);
+		collision_test_needed =
+			has_sha1_file_with_flags(oid->hash, OBJECT_INFO_QUICK);
 		read_unlock();
 	}
 
diff --git a/cache.h b/cache.h
index 2e1cc3fe2..387694b25 100644
--- a/cache.h
+++ b/cache.h
@@ -1268,15 +1268,10 @@ int read_loose_object(const char *path,
 		      void **contents);
 
 /*
- * Return true iff we have an object named sha1, whether local or in
- * an alternate object database, and whether packed or loose.  This
- * function does not respect replace references.
- *
- * If the QUICK flag is set, do not re-check the pack directory
- * when we cannot find the object (this means we may give a false
- * negative answer if another process is simultaneously repacking).
+ * Convenience for sha1_object_info_extended() with a blank struct
+ * object_info. OBJECT_INFO_SKIP_CACHED is automatically set; pass
+ * nonzero flags to also set other flags.
  */
-#define HAS_SHA1_QUICK 0x1
 extern int has_sha1_file_with_flags(const unsigned char *sha1, int flags);
 static inline int has_sha1_file(const unsigned char *sha1)
 {
diff --git a/sha1_file.c b/sha1_file.c
index 68e3a3400..20db9b510 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -3491,18 +3491,11 @@ int has_sha1_pack(const unsigned char *sha1)
 
 int has_sha1_file_with_flags(const unsigned char *sha1, int flags)
 {
-	struct pack_entry e;
-
+	static struct object_info blank;
 	if (!startup_info->have_repository)
 		return 0;
-	if (find_pack_entry(sha1, &e))
-		return 1;
-	if (has_loose_object(sha1))
-		return 1;
-	if (flags & HAS_SHA1_QUICK)
-		return 0;
-	reprepare_packed_git();
-	return find_pack_entry(sha1, &e);
+	return !sha1_object_info_extended(sha1, &blank,
+					  flags | OBJECT_INFO_SKIP_CACHED);
 }
 
 int has_object_file(const struct object_id *oid)
-- 
2.13.1.611.g7e3b11ae1-goog

