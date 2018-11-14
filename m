Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-12.3 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D4181F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 00:13:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730969AbeKNKO1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 05:14:27 -0500
Received: from mail-qk1-f201.google.com ([209.85.222.201]:46192 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727203AbeKNKO1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 05:14:27 -0500
Received: by mail-qk1-f201.google.com with SMTP id c84so34691295qkb.13
        for <git@vger.kernel.org>; Tue, 13 Nov 2018 16:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+WQ6uWfFasA6UH8oQIvlYUgcW4lXi1IUNpab83BMHnE=;
        b=ICm5l0bRHPyOFayJXqU4e71YWVPnH2IBYPR/oM71qrZ+q1dl5YwQuVKSKgjQjEMYIw
         ZkKbfDWgLg/HTkai8NvXEVaT7CoWlKzMw17DG5KacfwUYZeao6U/zb/dycK4EmGoDZgF
         BTmT5EZNNd/y1ldJO6eE1ap+9CaiZ5vfdy8hA4zATbOZkJa1aXEssOYKAqdHbRu4FfC/
         ANBF8nQwcl5piZGhUL/rlNgPIWj4h+OYazLt9WxjtHtSwnsxNP5lROeYU8h0N7cLgBMY
         VX/dGKy49l4TR5xQ/BgYp+f1S5p8CJyxftkFxDD6SGeBmN3JSL1O+782P7AnTtrV6kgw
         M6fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+WQ6uWfFasA6UH8oQIvlYUgcW4lXi1IUNpab83BMHnE=;
        b=X1QaX8WBt6NJJA1oGPz1zxdE6w8KhXKOr4P6Rru9Rt02OYmPIEOCz9Ad9AQUDkXMXK
         0bQax8EWLw+7YA1lHiEwVl7IrTc5R22SVzv5nB/KvnpdMrNUHkodsj/au8PsCDmjo4AI
         MlcoBtvj0x0qR/RBiCXf1zgZz3bQ7KQfPzfbH5y31JS4+Q2bliNj4gSCBLmjFts3wyGp
         Zl/0TdDnMw4mo/jVwRuIfHlwjmyg3aIFYVNQ0DvEYwZK0AaKydZwCv4ngUPVeoWP1oLd
         07MTkCnL85/ab+vB7eiYmGIoDSGimzZsCBWJWpyHNB+9yT8qrA042cCKh++n7cRYAVAQ
         5FYQ==
X-Gm-Message-State: AGRZ1gI6WdRV8QiLKUPQEdIALM32/ChpC8Erx+TR241oJ7mayopSsOmG
        11LFSkbzYpf8KZfChMV5TvjUzW3Z09jP
X-Google-Smtp-Source: AJdET5fqsizY9bdxrAz9NKQyOkhQwqvws5Ttg0aQASkpWlFt+GSmzQLN/x1tN4BmGi2Jl6H6SaJBKgqtyhoZ
X-Received: by 2002:a37:9042:: with SMTP id s63mr4798414qkd.10.1542154423921;
 Tue, 13 Nov 2018 16:13:43 -0800 (PST)
Date:   Tue, 13 Nov 2018 16:12:48 -0800
In-Reply-To: <20181114001306.138053-1-sbeller@google.com>
Message-Id: <20181114001306.138053-6-sbeller@google.com>
Mime-Version: 1.0
References: <20181114001306.138053-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.1.1215.g8438c0b245-goog
Subject: [PATCH 05/23] object-store: prepare has_{sha1, object}_file to handle
 any repo
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, jonathantanmy@google.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 .../coccinelle/the_repository.pending.cocci   | 30 +++++++++++++++++++
 object-store.h                                | 22 ++++++++++----
 sha1-file.c                                   | 15 ++++++----
 3 files changed, 56 insertions(+), 11 deletions(-)

diff --git a/contrib/coccinelle/the_repository.pending.cocci b/contrib/coccinelle/the_repository.pending.cocci
index a7ac9e0c46..46f3a1b23a 100644
--- a/contrib/coccinelle/the_repository.pending.cocci
+++ b/contrib/coccinelle/the_repository.pending.cocci
@@ -10,3 +10,33 @@ expression G;
 - read_object_file(
 + repo_read_object_file(the_repository,
   E, F, G)
+
+@@
+expression E;
+@@
+- has_sha1_file(
++ repo_has_sha1_file(the_repository,
+  E)
+
+@@
+expression E;
+expression F;
+@@
+- has_sha1_file_with_flags(
++ repo_has_sha1_file_with_flags(the_repository,
+  E)
+
+@@
+expression E;
+@@
+- has_object_file(
++ repo_has_object_file(the_repository,
+  E)
+
+@@
+expression E;
+expression F;
+@@
+- has_object_file_with_flags(
++ repo_has_object_file_with_flags(the_repository,
+  E)
diff --git a/object-store.h b/object-store.h
index 00a64622e6..2b5e6ff1ed 100644
--- a/object-store.h
+++ b/object-store.h
@@ -212,15 +212,27 @@ int read_loose_object(const char *path,
  * object_info. OBJECT_INFO_SKIP_CACHED is automatically set; pass
  * nonzero flags to also set other flags.
  */
-extern int has_sha1_file_with_flags(const unsigned char *sha1, int flags);
-static inline int has_sha1_file(const unsigned char *sha1)
+int repo_has_sha1_file_with_flags(struct repository *r,
+				  const unsigned char *sha1, int flags);
+static inline int repo_has_sha1_file(struct repository *r,
+				     const unsigned char *sha1)
 {
-	return has_sha1_file_with_flags(sha1, 0);
+	return repo_has_sha1_file_with_flags(r, sha1, 0);
 }
 
+#ifndef NO_THE_REPOSITORY_COMPATIBILITY_MACROS
+#define has_sha1_file_with_flags(sha1, flags) repo_has_sha1_file_with_flags(the_repository, sha1, flags)
+#define has_sha1_file(sha1) repo_has_sha1_file(the_repository, sha1)
+#endif
+
 /* Same as the above, except for struct object_id. */
-extern int has_object_file(const struct object_id *oid);
-extern int has_object_file_with_flags(const struct object_id *oid, int flags);
+int repo_has_object_file(struct repository *r, const struct object_id *oid);
+int repo_has_object_file_with_flags(struct repository *r,
+				    const struct object_id *oid, int flags);
+#ifndef NO_THE_REPOSITORY_COMPATIBILITY_MACROS
+#define has_object_file(oid) repo_has_object_file(the_repository, oid)
+#define has_object_file_with_flags(oid, flags) repo_has_object_file_with_flags(the_repository, oid, flags)
+#endif
 
 /*
  * Return true iff an alternate object database has a loose object
diff --git a/sha1-file.c b/sha1-file.c
index c5b704aec5..e77273ccfd 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -1768,24 +1768,27 @@ int force_object_loose(const struct object_id *oid, time_t mtime)
 	return ret;
 }
 
-int has_sha1_file_with_flags(const unsigned char *sha1, int flags)
+int repo_has_sha1_file_with_flags(struct repository *r,
+				  const unsigned char *sha1, int flags)
 {
 	struct object_id oid;
 	if (!startup_info->have_repository)
 		return 0;
 	hashcpy(oid.hash, sha1);
-	return oid_object_info_extended(the_repository, &oid, NULL,
+	return oid_object_info_extended(r, &oid, NULL,
 					flags | OBJECT_INFO_SKIP_CACHED) >= 0;
 }
 
-int has_object_file(const struct object_id *oid)
+int repo_has_object_file(struct repository *r,
+			 const struct object_id *oid)
 {
-	return has_sha1_file(oid->hash);
+	return repo_has_sha1_file(r, oid->hash);
 }
 
-int has_object_file_with_flags(const struct object_id *oid, int flags)
+int repo_has_object_file_with_flags(struct repository *r,
+				    const struct object_id *oid, int flags)
 {
-	return has_sha1_file_with_flags(oid->hash, flags);
+	return repo_has_sha1_file_with_flags(r, oid->hash, flags);
 }
 
 static void check_tree(const void *buf, size_t size)
-- 
2.19.1.1215.g8438c0b245-goog

