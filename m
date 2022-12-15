Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24753C4332F
	for <git@archiver.kernel.org>; Thu, 15 Dec 2022 09:59:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbiLOJ7e (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Dec 2022 04:59:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbiLOJ7Q (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2022 04:59:16 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F6C72C10C
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 01:59:15 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id m14so2459131wrh.7
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 01:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3gpJRb6RvovGVlU0vuffMsaczaAyW8HumArCfl1H5lo=;
        b=lzaBNBrYxlsxVg+FovBYA4sMUxcBln8bcPq62iVyUt6qXsHwMjX9EGEPYaOqG+Adav
         6dbgHA/rzDmU9VK8nTHhODFSfJuQ4zqGS41D6lOeg1mIfliUxHCHzJ30ieiHQiWsapl1
         HYz+D3QMWS6gPtevTPZvTbTb4uT5BK06jXovuXqRLABA6L6pWLVHTi4R8e1kETZInM4A
         dYxDFvFyMvok4q+5hUvzogpqG8z+sASyT1yi/5CbSXmvFbQ1YMzBIpjbD2YcCeckU1sT
         LPpiQMVuaXCk3UOWun+Q2D+oaH9p2Zz0Nm5bREQm3J8XVhUtyIA8XRicpoJKWTj9k7TH
         zjEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3gpJRb6RvovGVlU0vuffMsaczaAyW8HumArCfl1H5lo=;
        b=2UhyblDuUb1lUb4Gh9k6YVYuOqmfzan3DlAtWUDIFOT99x5ww+OZM21QEX3O6BLZs3
         IHVhYgyWqJ4PwNnvvQRFhvK6FJoChvgZd5EybdORyNwiGCJ0wGdNWnt16Jnl6/pLb0FC
         I2csy9aWyVSpsqL0W5y2vG+5T2GcAbuPA88QKTAJ8rEfb6+e4XrJAlpV2Se+xKbYAKRk
         gXps3jNbMmnMF1JNG8fckcNLi4nVWO7niai5tWadmGXx6MkPvmrpD3TtZm49pW8ve37A
         RBtbDCa+egAVVJzHWXOWCayprzP2H0BIYIw56sMAfV0A0bL3rPM0WQDTSDhI1FKHdAP2
         aMIA==
X-Gm-Message-State: ANoB5pmwgC71DYte50KRX4OEUw/91T4nrXjrjBoQrffYzP1dPlK4n7a+
        MWaUgDL33CJfPnONzuVRvdBVX4DqNg4U2A==
X-Google-Smtp-Source: AA0mqf7w1ntPrrd5YJMyu9x6KAqHmHojlxq5BX9grFygSxuyob52H49FrF0AZaqH8Cara25gJJF49w==
X-Received: by 2002:a05:6000:1e02:b0:242:6aad:879e with SMTP id bj2-20020a0560001e0200b002426aad879emr18977061wrb.7.1671098354319;
        Thu, 15 Dec 2022 01:59:14 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a13-20020adfe5cd000000b00228cbac7a25sm5495948wrn.64.2022.12.15.01.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 01:59:13 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 6/6] cocci & cache.h: remove "USE_THE_INDEX_COMPATIBILITY_MACROS"
Date:   Thu, 15 Dec 2022 10:59:05 +0100
Message-Id: <patch-6.6-4807a3fe8ff-20221215T095335Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.rc2.1048.g0e5493b8d5b
In-Reply-To: <cover-0.6-00000000000-20221215T095335Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20221215T095335Z-avarab@gmail.com>
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
index ad2e4114617..659fa10481e 100644
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
index 4c79e732e45..36bd5667334 100644
--- a/cache.h
+++ b/cache.h
@@ -433,15 +433,8 @@ typedef int (*must_prefetch_predicate)(const struct cache_entry *);
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
2.39.0.rc2.1048.g0e5493b8d5b

