Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C8DC77B6F
	for <git@archiver.kernel.org>; Tue, 11 Apr 2023 07:43:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbjDKHnD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Apr 2023 03:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbjDKHmd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2023 03:42:33 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ABD33C00
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 00:42:25 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id y11-20020a17090a600b00b0024693e96b58so5993434pji.1
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 00:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681198944; x=1683790944;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GpHP27AuIqkHW3RhjU/uAtB6cg/yaPRhdRjMLMB68q8=;
        b=dUBg9pjU0JLA+UVkE9ahOlGBLhHCce1itUcs/XjGSVLgsI8OkF5KwwG/0wQwxumXhY
         hjYqTrYQ+bm5lFQJnzFa/xr1kxqi+LHBaaBwupZCGi6io3VpsNudoBqgWeb0UCpO6VC3
         XPl1uVIl9b9zD0L+HT/QAV0e9jrvP39sp1ZeDSrUGROZrk77AyCY0+ofhVp/5SUB8OPK
         IGCSVrYm98a8oW3vwcsxRrl6KrRF7db6x+fgVwLCdP+vm/4AB91JCNBOx2HSeDj6TfsA
         hlpIoEdu4vWWyOvuoM4LSKLAcjJkJixCFDqOQbaaPf2nJPu8DNl2mqHCh8ct0yuzNlfP
         IrtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681198944; x=1683790944;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GpHP27AuIqkHW3RhjU/uAtB6cg/yaPRhdRjMLMB68q8=;
        b=eMI4kSPL3B30J27q3ZB+NI/2kMJ14P4FrZ6szxT0rNEQKjmoMqaOtDkWNFx2N4r4Xe
         h1Zi4o+bSUKNACgPnkChQ2aws3UBvjLIEcA7GUqkHcX5lrSYrVt7Vc9gZa8jIrAIoDht
         zzci8btvyseAcJe+24pJZfESetRTz+7zEBW5xjXPpINGPYV16JOxLE7jpHqc51JVTuOv
         V3Xj0ROtYvyEOLyt/K/UGagGLRzPxe6R2PiPWimtZdOonWuAxE2CvNYGk3zcm8I8KlMH
         h/Q3cIB601/LSF2PjV9escc1dxvx3L3XdytrZ+amEa7pYwR9vo4vlFH7647YSyt3R7sw
         19mA==
X-Gm-Message-State: AAQBX9dqO8yY/PO+N0Z2fRHRPdyYOm9zmelcarA5hLZLA+1+JXfu7Vwl
        1ywI8pboPj91mXeE9kbZvwlFgfy20I4=
X-Google-Smtp-Source: AKy350Z/rgcUGmJ+ymeN3i3bJcOII8/1PE/KWHn7Yeq5hEMz2m6YEm8W9B0Af5Q5QvKq8e6PmK6GJQ==
X-Received: by 2002:a17:902:ea0d:b0:1a5:34c2:81ca with SMTP id s13-20020a170902ea0d00b001a534c281camr9553166plg.60.1681198943585;
        Tue, 11 Apr 2023 00:42:23 -0700 (PDT)
Received: from iron-rod.hsd1.ca.comcast.net ([2601:646:9e80:a0b0::f6a9])
        by smtp.gmail.com with ESMTPSA id az4-20020a170902a58400b001a1deff606fsm8992820plb.125.2023.04.11.00.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 00:42:22 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Calvin Wan <calvinwan@google.com>
Subject: [PATCH v3 14/23] object.h: move some inline functions and defines from cache.h
Date:   Tue, 11 Apr 2023 00:41:55 -0700
Message-Id: <20230411074204.3024420-9-newren@gmail.com>
X-Mailer: git-send-email 2.40.0.172.g72fe1174621
In-Reply-To: <20230411074204.3024420-1-newren@gmail.com>
References: <pull.1509.v3.git.1681182060.gitgitgadget@gmail.com>
 <20230411074204.3024420-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The object_type() inline function is very tied to the enum object_type
declaration within object.h, and just seemed to make more sense to live
there.  That makes S_ISGITLINK and some other defines make sense to go
with it, as well as the create_ce_mode() and canon_mode() inline
functions.  Move all these inline functions and defines from cache.h to
object.h.

Signed-off-by: Elijah Newren <newren@gmail.com>
Acked-by: Calvin Wan <calvinwan@google.com>
---
 cache.h  | 42 ------------------------------------------
 object.h | 44 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 42 deletions(-)

diff --git a/cache.h b/cache.h
index 89987cca22a..394e8d01254 100644
--- a/cache.h
+++ b/cache.h
@@ -28,18 +28,6 @@
 #define DTYPE(de)	DT_UNKNOWN
 #endif
 
-/* unknown mode (impossible combination S_IFIFO|S_IFCHR) */
-#define S_IFINVALID     0030000
-
-/*
- * A "directory link" is a link to another git directory.
- *
- * The value 0160000 is not normally a valid mode, and
- * also just happens to be S_IFDIR + S_IFLNK
- */
-#define S_IFGITLINK	0160000
-#define S_ISGITLINK(m)	(((m) & S_IFMT) == S_IFGITLINK)
-
 /*
  * Some mode bits are also used internally for computations.
  *
@@ -155,8 +143,6 @@ struct cache_entry {
 #error "CE_EXTENDED_FLAGS out of range"
 #endif
 
-#define S_ISSPARSEDIR(m) ((m) == S_IFDIR)
-
 /* Forward structure decls */
 struct pathspec;
 struct child_process;
@@ -197,17 +183,6 @@ static inline unsigned create_ce_flags(unsigned stage)
 #define ce_mark_uptodate(ce) ((ce)->ce_flags |= CE_UPTODATE)
 #define ce_intent_to_add(ce) ((ce)->ce_flags & CE_INTENT_TO_ADD)
 
-#define ce_permissions(mode) (((mode) & 0100) ? 0755 : 0644)
-static inline unsigned int create_ce_mode(unsigned int mode)
-{
-	if (S_ISLNK(mode))
-		return S_IFLNK;
-	if (S_ISSPARSEDIR(mode))
-		return S_IFDIR;
-	if (S_ISDIR(mode) || S_ISGITLINK(mode))
-		return S_IFGITLINK;
-	return S_IFREG | ce_permissions(mode);
-}
 static inline unsigned int ce_mode_from_stat(const struct cache_entry *ce,
 					     unsigned int mode)
 {
@@ -234,16 +209,6 @@ static inline int ce_to_dtype(const struct cache_entry *ce)
 	else
 		return DT_UNKNOWN;
 }
-static inline unsigned int canon_mode(unsigned int mode)
-{
-	if (S_ISREG(mode))
-		return S_IFREG | ce_permissions(mode);
-	if (S_ISLNK(mode))
-		return S_IFLNK;
-	if (S_ISDIR(mode))
-		return S_IFDIR;
-	return S_IFGITLINK;
-}
 
 static inline int ce_path_match(struct index_state *istate,
 				const struct cache_entry *ce,
@@ -414,13 +379,6 @@ void prefetch_cache_entries(const struct index_state *istate,
 extern struct index_state the_index;
 #endif
 
-static inline enum object_type object_type(unsigned int mode)
-{
-	return S_ISDIR(mode) ? OBJ_TREE :
-		S_ISGITLINK(mode) ? OBJ_COMMIT :
-		OBJ_BLOB;
-}
-
 #define INIT_DB_QUIET 0x0001
 #define INIT_DB_EXIST_OK 0x0002
 
diff --git a/object.h b/object.h
index fc45b158da0..96e52e24fb1 100644
--- a/object.h
+++ b/object.h
@@ -101,6 +101,50 @@ enum object_type {
 	OBJ_MAX
 };
 
+/* unknown mode (impossible combination S_IFIFO|S_IFCHR) */
+#define S_IFINVALID     0030000
+
+/*
+ * A "directory link" is a link to another git directory.
+ *
+ * The value 0160000 is not normally a valid mode, and
+ * also just happens to be S_IFDIR + S_IFLNK
+ */
+#define S_IFGITLINK	0160000
+#define S_ISGITLINK(m)	(((m) & S_IFMT) == S_IFGITLINK)
+
+#define S_ISSPARSEDIR(m) ((m) == S_IFDIR)
+
+static inline enum object_type object_type(unsigned int mode)
+{
+	return S_ISDIR(mode) ? OBJ_TREE :
+		S_ISGITLINK(mode) ? OBJ_COMMIT :
+		OBJ_BLOB;
+}
+
+#define ce_permissions(mode) (((mode) & 0100) ? 0755 : 0644)
+static inline unsigned int create_ce_mode(unsigned int mode)
+{
+	if (S_ISLNK(mode))
+		return S_IFLNK;
+	if (S_ISSPARSEDIR(mode))
+		return S_IFDIR;
+	if (S_ISDIR(mode) || S_ISGITLINK(mode))
+		return S_IFGITLINK;
+	return S_IFREG | ce_permissions(mode);
+}
+
+static inline unsigned int canon_mode(unsigned int mode)
+{
+	if (S_ISREG(mode))
+		return S_IFREG | ce_permissions(mode);
+	if (S_ISLNK(mode))
+		return S_IFLNK;
+	if (S_ISDIR(mode))
+		return S_IFDIR;
+	return S_IFGITLINK;
+}
+
 /*
  * The object type is stored in 3 bits.
  */
-- 
2.40.0.172.g72fe1174621

