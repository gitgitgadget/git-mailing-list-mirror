Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0668CC636CD
	for <git@archiver.kernel.org>; Fri, 10 Feb 2023 10:29:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232035AbjBJK3O (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Feb 2023 05:29:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232029AbjBJK25 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2023 05:28:57 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD2F6C7F8
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 02:28:56 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id ba1so4583971wrb.5
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 02:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lM73e8G/KhlpJi9V3ECMrJg5XNhSBzWE/I6Aeue8Mzw=;
        b=d8ssDvHwc67GaZMoe2VxK9Si5b0S+/NNKC9k6yNWtdUGmI0PKhd/e6ZdCXjjMtZUf4
         mo3ZGKaVAqO6WnQiIkdHsTVLBjUobhb/odIsdxV+Z3QjDjJdwy83nFPoYlXMmk36RS5c
         N+hoKbrQEJGqjn9GXC9ADtmt5YDuMXlPftXAvfzXTzp7jPj+5/Ye0u74dqjKQXl8qZuG
         c8H3v9mN9VB5nRjSQ7Wx39yEVlHjC3mdIMnN/snFibd/C9/5nLjS2DkKX0SBtn58nbtP
         ws/kbXLC0M2Nl3pkW+IkiRwkiBddunmpMM8IOHoAtoLsdAT9beIzkUW0E9tebrGrlcUf
         ey+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lM73e8G/KhlpJi9V3ECMrJg5XNhSBzWE/I6Aeue8Mzw=;
        b=vPx1Y9at8eXAa5OuPqtOGCIqAgFpTVbqFsfd8IkRm5kgT938iOsWS24XKVvYcgayY1
         vP+zlIMMlcyfwPJ9/qvqadVNdwhkgbUCrmMW7lTLkzKFEKOqjIQH0ckQSd1rWjrDNcGZ
         OQAXtoizTn1aXYDOHm0J4o8uXfgAYrgWLYa065u0SWo0bVFyhKqkNji172s9aeFnXIYW
         NKIxoGmJzLTgkmI1sxJyXwJR7RPZocLOdcrtdB5iZYpw9JPGlIGKVt5l/oaslydUi9Wi
         5Ne/z0X+0Gr+Visn9LCGl2Vq1A5TtXNKnfYjIdhkVUW/NNP2m7SWiF/O3LVaQBUgi3JS
         Gaag==
X-Gm-Message-State: AO0yUKUgF1kQpTwpMeskR5sJgVmEKCWLT7x/dPoLjlvRp11ovr9zk7HX
        zwAY6/KrN+GAG3wB/UAhASQTMdn+Vs1nN8+S
X-Google-Smtp-Source: AK7set9eyjrg68U1Iux/yFS1EMkFzZHu11uHpivkFjnOk8GeIm4TgCr+8zDDYrQeRLNUk8MHfIm2rQ==
X-Received: by 2002:adf:e88b:0:b0:2c4:4dd:b9ee with SMTP id d11-20020adfe88b000000b002c404ddb9eemr9011905wrm.71.1676024935508;
        Fri, 10 Feb 2023 02:28:55 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u13-20020a5d514d000000b002c3f50228afsm3244792wrt.3.2023.02.10.02.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 02:28:54 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 6/6] cocci & cache.h: remove "USE_THE_INDEX_COMPATIBILITY_MACROS"
Date:   Fri, 10 Feb 2023 11:28:39 +0100
Message-Id: <patch-v2-6.6-77c30cfe455-20230210T102114Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.1.1475.gc2542cdc5ef
In-Reply-To: <cover-v2-0.6-00000000000-20230210T102114Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20221215T095335Z-avarab@gmail.com> <cover-v2-0.6-00000000000-20230210T102114Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Have the last users of "USE_THE_INDEX_COMPATIBILITY_MACROS" use the
underlying *_index() variants instead. Now all previous users of
"USE_THE_INDEX_COMPATIBILITY_MACROS" have been migrated away from the
wrapper macros, and if applicable to use the "USE_THE_INDEX_VARIABLE"
added in [1].

Let's leave the "index-compatibility.cocci" in place, even though it
won't be doing anything on "master". It will benefit any out-of-tree
code that need to use these compatibility macros. We can eventually
remove it.

1. bdafeae0b9c (cache.h & test-tool.h: add & use
   "USE_THE_INDEX_VARIABLE", 2022-11-19)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/commit.c                              |  6 +++---
 builtin/merge.c                               |  6 +++---
 cache.h                                       |  9 +-------
 contrib/coccinelle/index-compatibility.cocci  |  6 ++++++
 .../index-compatibility.pending.cocci         | 21 -------------------
 5 files changed, 13 insertions(+), 35 deletions(-)
 delete mode 100644 contrib/coccinelle/index-compatibility.pending.cocci

diff --git a/builtin/commit.c b/builtin/commit.c
index 31fbbd73d16..985a0445b78 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -5,7 +5,7 @@
  * Based on git-commit.sh by Junio C Hamano and Linus Torvalds
  */
 
-#define USE_THE_INDEX_COMPATIBILITY_MACROS
+#define USE_THE_INDEX_VARIABLE
 #include "cache.h"
 #include "config.h"
 #include "lockfile.h"
@@ -992,8 +992,8 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		const char *parent = "HEAD";
 
 		if (!the_index.cache_nr) {
-			discard_cache();
-			if (read_cache() < 0)
+			discard_index(&the_index);
+			if (repo_read_index(the_repository) < 0)
 				die(_("Cannot read index"));
 		}
 
diff --git a/builtin/merge.c b/builtin/merge.c
index d7cc8dc8aed..2aafbf67450 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -6,7 +6,7 @@
  * Based on git-merge.sh by Junio C Hamano.
  */
 
-#define USE_THE_INDEX_COMPATIBILITY_MACROS
+#define USE_THE_INDEX_VARIABLE
 #include "cache.h"
 #include "config.h"
 #include "parse-options.h"
@@ -390,8 +390,8 @@ static void restore_state(const struct object_id *head,
 	run_command(&cmd);
 
 refresh_cache:
-	discard_cache();
-	if (read_cache() < 0)
+	discard_index(&the_index);
+	if (repo_read_index(the_repository) < 0)
 		die(_("could not read index"));
 }
 
diff --git a/cache.h b/cache.h
index c44aef1af7c..2f643cf5309 100644
--- a/cache.h
+++ b/cache.h
@@ -449,15 +449,8 @@ typedef int (*must_prefetch_predicate)(const struct cache_entry *);
 void prefetch_cache_entries(const struct index_state *istate,
 			    must_prefetch_predicate must_prefetch);
 
-#if defined(USE_THE_INDEX_COMPATIBILITY_MACROS) || defined(USE_THE_INDEX_VARIABLE)
+#ifdef USE_THE_INDEX_VARIABLE
 extern struct index_state the_index;
-
-#ifndef USE_THE_INDEX_VARIABLE
-#ifdef USE_THE_INDEX_COMPATIBILITY_MACROS
-#define read_cache() repo_read_index(the_repository)
-#define discard_cache() discard_index(&the_index)
-#endif
-#endif
 #endif
 
 #define TYPE_BITS 3
diff --git a/contrib/coccinelle/index-compatibility.cocci b/contrib/coccinelle/index-compatibility.cocci
index 9fca870162d..31e36cf3c41 100644
--- a/contrib/coccinelle/index-compatibility.cocci
+++ b/contrib/coccinelle/index-compatibility.cocci
@@ -23,6 +23,9 @@ identifier ACT = active_cache_tree;
 @@
 @@
 (
+- read_cache
++ repo_read_index
+|
 - read_cache_unmerged
 + repo_read_index_unmerged
 |
@@ -97,6 +100,9 @@ identifier ACT = active_cache_tree;
 |
 - update_main_cache_tree
 + cache_tree_update
+|
+- discard_cache
++ discard_index
 )
   (
 + &the_index,
diff --git a/contrib/coccinelle/index-compatibility.pending.cocci b/contrib/coccinelle/index-compatibility.pending.cocci
deleted file mode 100644
index ecf3b45deca..00000000000
--- a/contrib/coccinelle/index-compatibility.pending.cocci
+++ /dev/null
@@ -1,21 +0,0 @@
-// "the_repository" simple cases
-@@
-@@
-(
-- read_cache
-+ repo_read_index
-)
-  (
-+ the_repository,
-  ...)
-
-// "the_index" simple cases
-@@
-@@
-(
-- discard_cache
-+ discard_index
-)
-  (
-+ &the_index,
-  ...)
-- 
2.39.1.1475.gc2542cdc5ef

