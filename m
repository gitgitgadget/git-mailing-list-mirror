Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 050111F454
	for <e@80x24.org>; Tue, 30 Oct 2018 22:08:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728470AbeJaHEC (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Oct 2018 03:04:02 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:34972 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728460AbeJaHEC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Oct 2018 03:04:02 -0400
Received: by mail-qk1-f202.google.com with SMTP id k203so11023885qke.2
        for <git@vger.kernel.org>; Tue, 30 Oct 2018 15:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=HKzBptzwt/8MxGuMdHeqHyu9K3obRPLmxcelYb3iMzU=;
        b=NUHGqmN90+QGHNZQEyNgEujJYQjlJ+XNdKTQnY03CTUkZJTCfYgAzda6xAuNlGo6il
         dJczAxEfIctqRU+MViCHShlYnGb3umwDW79zVEzL9xjLghlyHmfr2An1CRVKGLcG/kQR
         8qDqybKIwOtSWRb4w/aAp1lau0BBe/mTJRhkvNcCWkDAOwTdiPDvPkJzMfVp7FQJxAWD
         K4b9t6PixFc8EB/dMrFaYyrc0Kx7uM1+8BtJRoefvmpemL8lsCWfPTMZ2Kb+7G8dqNkG
         utUANsEPkOQN6wA/85WVEZAXXnJXvxD61EyCDPjJDmtJrAqJvX8q9xRa44TrZ/Ib+vFf
         OFng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=HKzBptzwt/8MxGuMdHeqHyu9K3obRPLmxcelYb3iMzU=;
        b=YLViGkOcIZoKOuV7d2SbwTDB4vEWBg9McE0ZjZXZqEO3KmQksIN7Wmq9ieJX/xq5It
         kraic23CLAEQVixEdcw/0/sxoFiKhyOpbCat5nzhYvdbpW1v5Bf4/9Y2iWctuSUeCC3y
         EBA512VbyOepjXzGEGC452oypEk1ORHJaRYlz5XJ4TPmeC9dV6xdIFI+JBme5V9zYkSu
         rjQeWXnybC74H9o5sOwfR7SqctptKVlYG/W65TSoTBcIb2zkgALS128/Tay7R26CcoCV
         092ufQQtmFop2BGrEdU6vSIODdzZm8CWC4AKUx7IF6Tq6N/6S9GWcQV+grcCV//dkBSw
         gUMw==
X-Gm-Message-State: AGRZ1gKEbz8SHU1ZUsAI0OEUxMDlW4hPPkvBUMaVWdHEYOr84BOtSc+O
        GfwzYb59Z/HL0JYT2KFG09orOOjZKLWZSmTKrBjg6cDToUbnvwZb7qFw176ul0++Mx0TlfKqvuB
        jAy2vzmIHR02yKxrNVZTR3AMIb/Ib804qZ7xnRc7rz43FYUQ+UE8Olnp1xlDU
X-Google-Smtp-Source: AJdET5dfFC37UbfVlgAav6bQn+2RMqiKBxqu31iKJy7g7cZlVHDhTszOgpURrDCFO1NP1h7VqXKgwftQIf4d
X-Received: by 2002:a37:110d:: with SMTP id b13mr445493qkh.15.1540937326571;
 Tue, 30 Oct 2018 15:08:46 -0700 (PDT)
Date:   Tue, 30 Oct 2018 15:07:59 -0700
In-Reply-To: <20181030220817.61691-1-sbeller@google.com>
Message-Id: <20181030220817.61691-7-sbeller@google.com>
Mime-Version: 1.0
References: <20181030220817.61691-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
Subject: [PATCH 06/24] object-store: prepare has_{sha1, object}_file[_with_flags]
 to handle arbitrary repositories
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     szeder.dev@gmail.com, jonathantanmy@google.com,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 .../coccinelle/the_repository.pending.cocci   | 29 +++++++++++++++++++
 object-store.h                                | 22 ++++++++++----
 sha1-file.c                                   | 15 ++++++----
 3 files changed, 55 insertions(+), 11 deletions(-)

diff --git a/contrib/coccinelle/the_repository.pending.cocci b/contrib/coccinelle/the_repository.pending.cocci
index 3c7fa70502..46f3a1b23a 100644
--- a/contrib/coccinelle/the_repository.pending.cocci
+++ b/contrib/coccinelle/the_repository.pending.cocci
@@ -11,3 +11,32 @@ expression G;
 + repo_read_object_file(the_repository,
   E, F, G)
 
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
2.19.1.930.g4563a0d9d0-goog

