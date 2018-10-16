Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17C021F453
	for <e@80x24.org>; Tue, 16 Oct 2018 23:36:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbeJQH2x (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Oct 2018 03:28:53 -0400
Received: from mail-yb1-f201.google.com ([209.85.219.201]:57045 "EHLO
        mail-yb1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727208AbeJQH2x (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Oct 2018 03:28:53 -0400
Received: by mail-yb1-f201.google.com with SMTP id y12-v6so13663509ybg.23
        for <git@vger.kernel.org>; Tue, 16 Oct 2018 16:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=rE9ojvZfm4LkwguVwggNmT/vpPJFWZRosJNFnkQh9i8=;
        b=gsXiWxdfwbzgExSaw7TIHLBUfCw0QTYGcwziw6ex0hkH0vR9RQcWmf/0+XwPHgMN61
         MR5rJ9WPjnNfolQmjL19D+rSLL7NG4sQeghHB7QvlT53tc3e6f1qtSllGd5AwZZ0gkG+
         q23lE5c3tXRkYfeubCqCh4p0CV63d2IImtbf+hx11mJIqcw3AyP5mlyD47LIIrsKuTqu
         V1bp+VlfsDH3SAO9Fi6/xfK8fkf1NrU+YEgRMUJzz9YM2jjygaBclebhjWesI7hzSmwm
         KtFhD49pH9ebAxOukBvYr94o42bDF/v3SW08641qv2cw9HSqoevsqRpD2mpxUSf8u/hk
         w5NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=rE9ojvZfm4LkwguVwggNmT/vpPJFWZRosJNFnkQh9i8=;
        b=jWYnTdVmTL7m9eKQCOBtE3fEGg3oAbJj4VqNZD43cGspwfrP8PJp6PpBu6rYiUj5Ub
         C7RtlsHMIxhW5hf/Kdk5O0av3LtSJ6NR1LRy+bz5bY+dGFug1WCOwl8aNtIsuauYRc3X
         yO/2i3sVCall17GU3gzWpUcRrmnieXpQ+yU42+XlFdGzcgw/9ztyshFdAARHfyBXeulA
         CInv8itxaME2a5ERHHh0EekppUPkkzF0aEymAGibTycbWToHkLx79TigDMJvFE87SeTN
         6E7RSyYMzH+7kxMFnSun2ZykD1KJ4r5p55VvW2L72WS6gPND8vEY+FWy1qJbOeWcgUip
         lkYQ==
X-Gm-Message-State: ABuFfohmViCRCsoQ0dK5P7uJI3WfACoTcdPfUSy41uNPAnJRkKMVrLPd
        oiwN1lePtztKFiGU8WLl4N9szpxp3sQNXqGDo5WzG8JtNVZH/n/bmgnfrcurKI77LSNFsbuu6Q0
        GeO/p9XuIat3BsxirzF4oGITWx3MtDntqJF82vdir0CHWr9gdR7KfQWQ7F2Pa
X-Google-Smtp-Source: ACcGV63bXdMsHIZ+WPA39Vug+0eZ2dJutfMWMgPLG1g8WZz0qhDxXLPdFtpodPnEAP+KlRsuGHmJTKV50E37
X-Received: by 2002:a25:be85:: with SMTP id i5-v6mr14248846ybk.19.1539732967653;
 Tue, 16 Oct 2018 16:36:07 -0700 (PDT)
Date:   Tue, 16 Oct 2018 16:35:36 -0700
In-Reply-To: <20181016233550.251311-1-sbeller@google.com>
Message-Id: <20181016233550.251311-6-sbeller@google.com>
Mime-Version: 1.0
References: <20181016233550.251311-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.0
Subject: [PATCH 05/19] object-store: prepare has_{sha1, object}_file[_with_flags]
 to handle arbitrary repositories
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 contrib/coccinelle/the_repository.cocci | 29 +++++++++++++++++++++++++
 object-store.h                          | 22 ++++++++++++++-----
 sha1-file.c                             | 15 ++++++++-----
 3 files changed, 55 insertions(+), 11 deletions(-)

diff --git a/contrib/coccinelle/the_repository.cocci b/contrib/coccinelle/the_repository.cocci
index 3c7fa70502..46f3a1b23a 100644
--- a/contrib/coccinelle/the_repository.cocci
+++ b/contrib/coccinelle/the_repository.cocci
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
index 41ceebca48..e1c68d0774 100644
--- a/object-store.h
+++ b/object-store.h
@@ -197,15 +197,27 @@ int read_loose_object(const char *path,
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
index ce47524679..6153cedcf3 100644
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
2.19.0

