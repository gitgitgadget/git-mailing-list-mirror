Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2CCDC7EE24
	for <git@archiver.kernel.org>; Tue,  6 Jun 2023 17:10:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238195AbjFFRKx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jun 2023 13:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238491AbjFFRKb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jun 2023 13:10:31 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 206AD1733
        for <git@vger.kernel.org>; Tue,  6 Jun 2023 10:10:17 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1b02cd4b829so38429365ad.1
        for <git@vger.kernel.org>; Tue, 06 Jun 2023 10:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686071417; x=1688663417;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=t+XZ3ARTRdEe/JJMnhQ8N82BvVHRvmFj/HhBYrXr5iw=;
        b=cjMiucaHHVLwpybJtR/8KZV1StAy3v6aEMz9v6GCV2Fdw1hL6OkqO56MOLI6xDUJcB
         0nTXZIV488etn4SV2WWunB9Tt7Gw8o+isZSkzMZrk7kszeAoouClo/nUQLE7oBt1LY05
         Zl4MVLwYr5iGoZKnlNnu/4WzLT2FPY1PTt0O9g+Ko0x9n3iUjasSfOO7n/o9pFc99W42
         IJ++5KgaqoQthVGjZM7MNrdhV1Qp4FKyQFHPAbTsvC/Y/Jonp8/yJayYX+clvlXV5Hd9
         ENdtfIFtInUpJ33zg51UnXDMAMMNkm6V4PBxlQu3BIPlqV9NoqcChqn1HHXHP+fYJIOl
         EDZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686071417; x=1688663417;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t+XZ3ARTRdEe/JJMnhQ8N82BvVHRvmFj/HhBYrXr5iw=;
        b=JDgDbnXzZePfBx8E5Tz6YOp90fdlGBFbuB+aMdZjuR5ttN3MIBcXV1DsS+wGr4XZyV
         NDkh1SX9Q1YYvqfz9Vz5Kyye4EYogvoCG61zHBfencGfUONeXElB+Ra9+L6Z9YST8ma+
         3f6i6vpd18Hr1iZBcN8a4WN825m3ailqO5pE0dS0fw0s4IcZUCNtoP0BjRxy6ZyzzJy5
         guiJvspzVsCIioDWCVPgQXIprVPy/WMeD/jBrBBwV+s1aFRW0v8cN0wPVD3/wo8XVhy2
         adnf2SofHFPQy/LimeKoyAiD89f5XvkHhFngsjd1ILMsy81YIjXUkfoc9IfWM/soqcq9
         x36Q==
X-Gm-Message-State: AC+VfDzBr6eWY/4WF5leGZRf+aFlB0qouD9o38TnPbhy2ykMBFijH+iZ
        4uNh9iCYK74Y3+BKSOiz9OS1ynv4nBvLdO3U5gva6QLJc358u3gge0JzkhaY7rjzlb3VxEJo43E
        GSu1cdIjmv+JGMdFNwMP4APx0UaqT4Tg3Om+qjZZ2KXdX1HptixNRdScoUqhppRJVKQ==
X-Google-Smtp-Source: ACHHUZ7nYddcicGKbxtlNKzMmS6I9+8kQcS3H1or4CTAlDZ+rRKIFoR5YHtpyH0Q9zUsgOd+E3165Pn5TbcP1u0=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a17:902:ea0e:b0:1a8:1f4:2d50 with SMTP
 id s14-20020a170902ea0e00b001a801f42d50mr938423plg.4.1686071417119; Tue, 06
 Jun 2023 10:10:17 -0700 (PDT)
Date:   Tue,  6 Jun 2023 17:10:02 +0000
In-Reply-To: <20230606170711.912972-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230606170711.912972-1-calvinwan@google.com>
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7-goog
Message-ID: <20230606171002.914075-8-calvinwan@google.com>
Subject: [PATCH v3 8/8] common: move alloc macros to common.h
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, phillip.wood123@gmail.com,
        jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

alloc_nr, ALLOC_GROW, and ALLOC_GROW_BY are commonly used macros for
dynamic array allocation. Moving these macros to common.h focuses
alloc.[ch] to allocation for Git objects and additionally allows us to
remove inclusions to alloc.h from files that solely used the above
macros.

Signed-off-by: Calvin Wan <calvinwan@google.com>
---
 add-patch.c                        |  1 -
 alias.c                            |  1 -
 alloc.h                            | 75 ------------------------------
 apply.c                            |  1 -
 archive-tar.c                      |  1 -
 archive.c                          |  1 -
 attr.c                             |  1 -
 builtin/blame.c                    |  1 -
 builtin/cat-file.c                 |  1 -
 builtin/checkout--worker.c         |  1 -
 builtin/config.c                   |  1 -
 builtin/credential-cache--daemon.c |  1 -
 builtin/fetch-pack.c               |  1 -
 builtin/fsmonitor--daemon.c        |  1 -
 builtin/grep.c                     |  1 -
 builtin/index-pack.c               |  1 -
 builtin/log.c                      |  1 -
 builtin/merge.c                    |  1 -
 builtin/mktree.c                   |  1 -
 builtin/mv.c                       |  1 -
 builtin/name-rev.c                 |  1 -
 builtin/pack-objects.c             |  1 -
 builtin/repack.c                   |  1 -
 builtin/rev-parse.c                |  1 -
 builtin/revert.c                   |  1 -
 builtin/rm.c                       |  1 -
 builtin/submodule--helper.c        |  1 -
 bulk-checkin.c                     |  1 -
 cache-tree.c                       |  1 -
 chunk-format.c                     |  1 -
 commit-reach.c                     |  1 -
 common.h                           | 75 ++++++++++++++++++++++++++++++
 config.c                           |  1 -
 daemon.c                           |  1 -
 delta-islands.c                    |  1 -
 diff.c                             |  1 -
 diffcore-rename.c                  |  1 -
 dir-iterator.c                     |  1 -
 dir.c                              |  1 -
 ewah/bitmap.c                      |  1 -
 ewah/ewah_bitmap.c                 |  1 -
 fetch-pack.c                       |  1 -
 fmt-merge-msg.c                    |  1 -
 fsck.c                             |  1 -
 help.c                             |  1 -
 http-backend.c                     |  1 -
 line-log.c                         |  1 -
 list-objects-filter-options.c      |  1 -
 list-objects-filter.c              |  1 -
 midx.c                             |  1 -
 object-file.c                      |  1 -
 oid-array.c                        |  1 -
 oidtree.c                          |  1 -
 pack-bitmap-write.c                |  1 -
 pack-bitmap.c                      |  1 -
 pack-objects.c                     |  1 -
 packfile.c                         |  1 -
 parallel-checkout.c                |  1 -
 pretty.c                           |  1 -
 prio-queue.c                       |  1 -
 quote.c                            |  1 -
 read-cache.c                       |  1 -
 ref-filter.c                       |  1 -
 reflog-walk.c                      |  1 -
 refs.c                             |  1 -
 refspec.c                          |  1 -
 remote-curl.c                      |  1 -
 remote.c                           |  1 -
 rerere.c                           |  1 -
 revision.c                         |  1 -
 sequencer.c                        |  1 -
 server-info.c                      |  1 -
 shallow.c                          |  1 -
 sigchain.c                         |  1 -
 sparse-index.c                     |  1 -
 split-index.c                      |  1 -
 strbuf.c                           |  1 -
 string-list.c                      |  1 -
 strvec.c                           |  1 -
 submodule-config.c                 |  1 -
 submodule.c                        |  1 -
 t/helper/test-reach.c              |  1 -
 trace2/tr2_tls.c                   |  1 -
 trailer.c                          |  1 -
 transport.c                        |  1 -
 tree-walk.c                        |  1 -
 userdiff.c                         |  1 -
 worktree.c                         |  1 -
 88 files changed, 75 insertions(+), 161 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index ba629add62..bfe19876cd 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -1,7 +1,6 @@
 #include "git-compat-util.h"
 #include "add-interactive.h"
 #include "advice.h"
-#include "alloc.h"
 #include "editor.h"
 #include "environment.h"
 #include "gettext.h"
diff --git a/alias.c b/alias.c
index 54a1a23d2c..38e1339936 100644
--- a/alias.c
+++ b/alias.c
@@ -1,6 +1,5 @@
 #include "git-compat-util.h"
 #include "alias.h"
-#include "alloc.h"
 #include "config.h"
 #include "gettext.h"
 #include "strbuf.h"
diff --git a/alloc.h b/alloc.h
index 4312db4bd0..3f4a0ad310 100644
--- a/alloc.h
+++ b/alloc.h
@@ -17,79 +17,4 @@ void *alloc_object_node(struct repository *r);
 struct alloc_state *allocate_alloc_state(void);
 void clear_alloc_state(struct alloc_state *s);
 
-#define alloc_nr(x) (((x)+16)*3/2)
-
-/**
- * Dynamically growing an array using realloc() is error prone and boring.
- *
- * Define your array with:
- *
- * - a pointer (`item`) that points at the array, initialized to `NULL`
- *   (although please name the variable based on its contents, not on its
- *   type);
- *
- * - an integer variable (`alloc`) that keeps track of how big the current
- *   allocation is, initialized to `0`;
- *
- * - another integer variable (`nr`) to keep track of how many elements the
- *   array currently has, initialized to `0`.
- *
- * Then before adding `n`th element to the item, call `ALLOC_GROW(item, n,
- * alloc)`.  This ensures that the array can hold at least `n` elements by
- * calling `realloc(3)` and adjusting `alloc` variable.
- *
- * ------------
- * sometype *item;
- * size_t nr;
- * size_t alloc
- *
- * for (i = 0; i < nr; i++)
- * 	if (we like item[i] already)
- * 		return;
- *
- * // we did not like any existing one, so add one
- * ALLOC_GROW(item, nr + 1, alloc);
- * item[nr++] = value you like;
- * ------------
- *
- * You are responsible for updating the `nr` variable.
- *
- * If you need to specify the number of elements to allocate explicitly
- * then use the macro `REALLOC_ARRAY(item, alloc)` instead of `ALLOC_GROW`.
- *
- * Consider using ALLOC_GROW_BY instead of ALLOC_GROW as it has some
- * added niceties.
- *
- * DO NOT USE any expression with side-effect for 'x', 'nr', or 'alloc'.
- */
-#define ALLOC_GROW(x, nr, alloc) \
-	do { \
-		if ((nr) > alloc) { \
-			if (alloc_nr(alloc) < (nr)) \
-				alloc = (nr); \
-			else \
-				alloc = alloc_nr(alloc); \
-			REALLOC_ARRAY(x, alloc); \
-		} \
-	} while (0)
-
-/*
- * Similar to ALLOC_GROW but handles updating of the nr value and
- * zeroing the bytes of the newly-grown array elements.
- *
- * DO NOT USE any expression with side-effect for any of the
- * arguments.
- */
-#define ALLOC_GROW_BY(x, nr, increase, alloc) \
-	do { \
-		if (increase) { \
-			size_t new_nr = nr + (increase); \
-			if (new_nr < nr) \
-				BUG("negative growth in ALLOC_GROW_BY"); \
-			ALLOC_GROW(x, new_nr, alloc); \
-			memset((x) + nr, 0, sizeof(*(x)) * (increase)); \
-			nr = new_nr; \
-		} \
-	} while (0)
-
 #endif
diff --git a/apply.c b/apply.c
index 99c2a91de7..6b9ce54f7d 100644
--- a/apply.c
+++ b/apply.c
@@ -9,7 +9,6 @@
 
 #include "git-compat-util.h"
 #include "abspath.h"
-#include "alloc.h"
 #include "base85.h"
 #include "config.h"
 #include "object-store-ll.h"
diff --git a/archive-tar.c b/archive-tar.c
index fc06ff4c5d..704bf0612e 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -2,7 +2,6 @@
  * Copyright (c) 2005, 2006 Rene Scharfe
  */
 #include "git-compat-util.h"
-#include "alloc.h"
 #include "config.h"
 #include "gettext.h"
 #include "git-zlib.h"
diff --git a/archive.c b/archive.c
index 1817cca9f4..ca11db185b 100644
--- a/archive.c
+++ b/archive.c
@@ -1,6 +1,5 @@
 #include "git-compat-util.h"
 #include "abspath.h"
-#include "alloc.h"
 #include "config.h"
 #include "convert.h"
 #include "environment.h"
diff --git a/attr.c b/attr.c
index 7d39ac4a29..e9c81b6e07 100644
--- a/attr.c
+++ b/attr.c
@@ -7,7 +7,6 @@
  */
 
 #include "git-compat-util.h"
-#include "alloc.h"
 #include "config.h"
 #include "environment.h"
 #include "exec-cmd.h"
diff --git a/builtin/blame.c b/builtin/blame.c
index e811e7fbfb..9a3f9facea 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -6,7 +6,6 @@
  */
 
 #include "git-compat-util.h"
-#include "alloc.h"
 #include "config.h"
 #include "color.h"
 #include "builtin.h"
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 48ccca95a1..4b786adbe4 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -5,7 +5,6 @@
  */
 #define USE_THE_INDEX_VARIABLE
 #include "builtin.h"
-#include "alloc.h"
 #include "config.h"
 #include "convert.h"
 #include "diff.h"
diff --git a/builtin/checkout--worker.c b/builtin/checkout--worker.c
index c655dc4b13..6b62b5375b 100644
--- a/builtin/checkout--worker.c
+++ b/builtin/checkout--worker.c
@@ -1,5 +1,4 @@
 #include "builtin.h"
-#include "alloc.h"
 #include "config.h"
 #include "entry.h"
 #include "gettext.h"
diff --git a/builtin/config.c b/builtin/config.c
index c01f136a2b..49b82b5323 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -1,6 +1,5 @@
 #include "builtin.h"
 #include "abspath.h"
-#include "alloc.h"
 #include "config.h"
 #include "color.h"
 #include "editor.h"
diff --git a/builtin/credential-cache--daemon.c b/builtin/credential-cache--daemon.c
index 756c5f02ae..db8c49605c 100644
--- a/builtin/credential-cache--daemon.c
+++ b/builtin/credential-cache--daemon.c
@@ -1,6 +1,5 @@
 #include "builtin.h"
 #include "abspath.h"
-#include "alloc.h"
 #include "gettext.h"
 #include "object-file.h"
 #include "parse-options.h"
diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 3ba0fe5a39..44c05ee86c 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -1,5 +1,4 @@
 #include "builtin.h"
-#include "alloc.h"
 #include "gettext.h"
 #include "hex.h"
 #include "object-file.h"
diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index 74d1d6a585..0194f1e263 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -1,6 +1,5 @@
 #include "builtin.h"
 #include "abspath.h"
-#include "alloc.h"
 #include "config.h"
 #include "environment.h"
 #include "gettext.h"
diff --git a/builtin/grep.c b/builtin/grep.c
index 72e70b3a48..c60cf2007f 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -4,7 +4,6 @@
  * Copyright (c) 2006 Junio C Hamano
  */
 #include "builtin.h"
-#include "alloc.h"
 #include "gettext.h"
 #include "hex.h"
 #include "repository.h"
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index f58f9db69d..57812a276a 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1,5 +1,4 @@
 #include "builtin.h"
-#include "alloc.h"
 #include "config.h"
 #include "delta.h"
 #include "environment.h"
diff --git a/builtin/log.c b/builtin/log.c
index d6543ba1f6..03954fb749 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -6,7 +6,6 @@
  */
 #include "git-compat-util.h"
 #include "abspath.h"
-#include "alloc.h"
 #include "config.h"
 #include "environment.h"
 #include "gettext.h"
diff --git a/builtin/merge.c b/builtin/merge.c
index 2f2f0a0b4c..059f3ecb84 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -10,7 +10,6 @@
 #include "builtin.h"
 #include "abspath.h"
 #include "advice.h"
-#include "alloc.h"
 #include "config.h"
 #include "editor.h"
 #include "environment.h"
diff --git a/builtin/mktree.c b/builtin/mktree.c
index 0eea810c7e..9a22d4e277 100644
--- a/builtin/mktree.c
+++ b/builtin/mktree.c
@@ -4,7 +4,6 @@
  * Copyright (c) Junio C Hamano, 2006, 2009
  */
 #include "builtin.h"
-#include "alloc.h"
 #include "gettext.h"
 #include "hex.h"
 #include "quote.h"
diff --git a/builtin/mv.c b/builtin/mv.c
index ae462bd7d4..fa84fcb20d 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -7,7 +7,6 @@
 #include "builtin.h"
 #include "abspath.h"
 #include "advice.h"
-#include "alloc.h"
 #include "config.h"
 #include "environment.h"
 #include "gettext.h"
diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index c3b722b36f..c706fa3720 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -1,5 +1,4 @@
 #include "builtin.h"
-#include "alloc.h"
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 6409c07c7d..869a21b38f 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1,5 +1,4 @@
 #include "builtin.h"
-#include "alloc.h"
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
diff --git a/builtin/repack.c b/builtin/repack.c
index 6c896c9c80..60ae514fd5 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -1,5 +1,4 @@
 #include "builtin.h"
-#include "alloc.h"
 #include "config.h"
 #include "dir.h"
 #include "environment.h"
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 4a219ea93b..161077aa79 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -6,7 +6,6 @@
 #define USE_THE_INDEX_VARIABLE
 #include "builtin.h"
 #include "abspath.h"
-#include "alloc.h"
 #include "config.h"
 #include "commit.h"
 #include "environment.h"
diff --git a/builtin/revert.c b/builtin/revert.c
index f6f07d9b53..e6f9a1ad26 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -1,5 +1,4 @@
 #include "git-compat-util.h"
-#include "alloc.h"
 #include "config.h"
 #include "builtin.h"
 #include "parse-options.h"
diff --git a/builtin/rm.c b/builtin/rm.c
index 463eeabcea..dff819ae50 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -5,7 +5,6 @@
  */
 #define USE_THE_INDEX_VARIABLE
 #include "builtin.h"
-#include "alloc.h"
 #include "advice.h"
 #include "config.h"
 #include "lockfile.h"
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index baf6ff88c3..e22cf4e4ee 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1,7 +1,6 @@
 #define USE_THE_INDEX_VARIABLE
 #include "builtin.h"
 #include "abspath.h"
-#include "alloc.h"
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
diff --git a/bulk-checkin.c b/bulk-checkin.c
index fec6816259..73bff3a23d 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -2,7 +2,6 @@
  * Copyright (c) 2011, Google Inc.
  */
 #include "git-compat-util.h"
-#include "alloc.h"
 #include "bulk-checkin.h"
 #include "environment.h"
 #include "gettext.h"
diff --git a/cache-tree.c b/cache-tree.c
index 84d7491420..641427ed41 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -1,5 +1,4 @@
 #include "git-compat-util.h"
-#include "alloc.h"
 #include "environment.h"
 #include "hex.h"
 #include "lockfile.h"
diff --git a/chunk-format.c b/chunk-format.c
index e7d613c907..140dfa0dcc 100644
--- a/chunk-format.c
+++ b/chunk-format.c
@@ -1,5 +1,4 @@
 #include "git-compat-util.h"
-#include "alloc.h"
 #include "chunk-format.h"
 #include "csum-file.h"
 #include "gettext.h"
diff --git a/commit-reach.c b/commit-reach.c
index 70bde8af05..812bc6bf92 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -1,5 +1,4 @@
 #include "git-compat-util.h"
-#include "alloc.h"
 #include "commit.h"
 #include "commit-graph.h"
 #include "decorate.h"
diff --git a/common.h b/common.h
index e3b673847d..b0c68eb2a2 100644
--- a/common.h
+++ b/common.h
@@ -199,6 +199,81 @@ static inline int cast_size_t_to_int(size_t a)
  */
 #define FREE_AND_NULL(p) do { free(p); (p) = NULL; } while (0)
 
+#define alloc_nr(x) (((x)+16)*3/2)
+
+/**
+ * Dynamically growing an array using realloc() is error prone and boring.
+ *
+ * Define your array with:
+ *
+ * - a pointer (`item`) that points at the array, initialized to `NULL`
+ *   (although please name the variable based on its contents, not on its
+ *   type);
+ *
+ * - an integer variable (`alloc`) that keeps track of how big the current
+ *   allocation is, initialized to `0`;
+ *
+ * - another integer variable (`nr`) to keep track of how many elements the
+ *   array currently has, initialized to `0`.
+ *
+ * Then before adding `n`th element to the item, call `ALLOC_GROW(item, n,
+ * alloc)`.  This ensures that the array can hold at least `n` elements by
+ * calling `realloc(3)` and adjusting `alloc` variable.
+ *
+ * ------------
+ * sometype *item;
+ * size_t nr;
+ * size_t alloc
+ *
+ * for (i = 0; i < nr; i++)
+ * 	if (we like item[i] already)
+ * 		return;
+ *
+ * // we did not like any existing one, so add one
+ * ALLOC_GROW(item, nr + 1, alloc);
+ * item[nr++] = value you like;
+ * ------------
+ *
+ * You are responsible for updating the `nr` variable.
+ *
+ * If you need to specify the number of elements to allocate explicitly
+ * then use the macro `REALLOC_ARRAY(item, alloc)` instead of `ALLOC_GROW`.
+ *
+ * Consider using ALLOC_GROW_BY instead of ALLOC_GROW as it has some
+ * added niceties.
+ *
+ * DO NOT USE any expression with side-effect for 'x', 'nr', or 'alloc'.
+ */
+#define ALLOC_GROW(x, nr, alloc) \
+	do { \
+		if ((nr) > alloc) { \
+			if (alloc_nr(alloc) < (nr)) \
+				alloc = (nr); \
+			else \
+				alloc = alloc_nr(alloc); \
+			REALLOC_ARRAY(x, alloc); \
+		} \
+	} while (0)
+
+/*
+ * Similar to ALLOC_GROW but handles updating of the nr value and
+ * zeroing the bytes of the newly-grown array elements.
+ *
+ * DO NOT USE any expression with side-effect for any of the
+ * arguments.
+ */
+#define ALLOC_GROW_BY(x, nr, increase, alloc) \
+	do { \
+		if (increase) { \
+			size_t new_nr = nr + (increase); \
+			if (new_nr < nr) \
+				BUG("negative growth in ALLOC_GROW_BY"); \
+			ALLOC_GROW(x, new_nr, alloc); \
+			memset((x) + nr, 0, sizeof(*(x)) * (increase)); \
+			nr = new_nr; \
+		} \
+	} while (0)
+
 #define ALLOC_ARRAY(x, alloc) (x) = xmalloc(st_mult(sizeof(*(x)), (alloc)))
 #define CALLOC_ARRAY(x, alloc) (x) = xcalloc((alloc), sizeof(*(x)))
 #define REALLOC_ARRAY(x, alloc) (x) = xrealloc((x), st_mult(sizeof(*(x)), (alloc)))
diff --git a/config.c b/config.c
index cc97c18141..09851a6909 100644
--- a/config.c
+++ b/config.c
@@ -8,7 +8,6 @@
 #include "git-compat-util.h"
 #include "abspath.h"
 #include "advice.h"
-#include "alloc.h"
 #include "date.h"
 #include "branch.h"
 #include "config.h"
diff --git a/daemon.c b/daemon.c
index 3722edf46c..1edc9a8510 100644
--- a/daemon.c
+++ b/daemon.c
@@ -1,6 +1,5 @@
 #include "git-compat-util.h"
 #include "abspath.h"
-#include "alloc.h"
 #include "config.h"
 #include "environment.h"
 #include "path.h"
diff --git a/delta-islands.c b/delta-islands.c
index c824a5f6a4..332f0f7c45 100644
--- a/delta-islands.c
+++ b/delta-islands.c
@@ -1,5 +1,4 @@
 #include "git-compat-util.h"
-#include "alloc.h"
 #include "attr.h"
 #include "object.h"
 #include "blob.h"
diff --git a/diff.c b/diff.c
index bdc4b07dde..b48438c1e1 100644
--- a/diff.c
+++ b/diff.c
@@ -3,7 +3,6 @@
  */
 #include "git-compat-util.h"
 #include "abspath.h"
-#include "alloc.h"
 #include "base85.h"
 #include "config.h"
 #include "convert.h"
diff --git a/diffcore-rename.c b/diffcore-rename.c
index 926b554bd5..5a6e2bcac7 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2005 Junio C Hamano
  */
 #include "git-compat-util.h"
-#include "alloc.h"
 #include "diff.h"
 #include "diffcore.h"
 #include "object-store-ll.h"
diff --git a/dir-iterator.c b/dir-iterator.c
index fb7c47f0e8..278b04243a 100644
--- a/dir-iterator.c
+++ b/dir-iterator.c
@@ -1,5 +1,4 @@
 #include "git-compat-util.h"
-#include "alloc.h"
 #include "dir.h"
 #include "iterator.h"
 #include "dir-iterator.h"
diff --git a/dir.c b/dir.c
index d270a1be36..c9dc69fc24 100644
--- a/dir.c
+++ b/dir.c
@@ -7,7 +7,6 @@
  */
 #include "git-compat-util.h"
 #include "abspath.h"
-#include "alloc.h"
 #include "config.h"
 #include "convert.h"
 #include "dir.h"
diff --git a/ewah/bitmap.c b/ewah/bitmap.c
index 12d6aa398e..7b525b1ecd 100644
--- a/ewah/bitmap.c
+++ b/ewah/bitmap.c
@@ -17,7 +17,6 @@
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 #include "git-compat-util.h"
-#include "alloc.h"
 #include "ewok.h"
 
 #define EWAH_MASK(x) ((eword_t)1 << (x % BITS_IN_EWORD))
diff --git a/ewah/ewah_bitmap.c b/ewah/ewah_bitmap.c
index c6d4ffc87c..8785cbc54a 100644
--- a/ewah/ewah_bitmap.c
+++ b/ewah/ewah_bitmap.c
@@ -17,7 +17,6 @@
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 #include "git-compat-util.h"
-#include "alloc.h"
 #include "ewok.h"
 #include "ewok_rlw.h"
 
diff --git a/fetch-pack.c b/fetch-pack.c
index 84a24ff9b1..6198f3adaf 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1,5 +1,4 @@
 #include "git-compat-util.h"
-#include "alloc.h"
 #include "repository.h"
 #include "config.h"
 #include "date.h"
diff --git a/fmt-merge-msg.c b/fmt-merge-msg.c
index ac9c1b9c6c..ff8884eecd 100644
--- a/fmt-merge-msg.c
+++ b/fmt-merge-msg.c
@@ -1,5 +1,4 @@
 #include "git-compat-util.h"
-#include "alloc.h"
 #include "config.h"
 #include "environment.h"
 #include "refs.h"
diff --git a/fsck.c b/fsck.c
index a219d6f2c0..2035c4e00b 100644
--- a/fsck.c
+++ b/fsck.c
@@ -1,5 +1,4 @@
 #include "git-compat-util.h"
-#include "alloc.h"
 #include "date.h"
 #include "dir.h"
 #include "hex.h"
diff --git a/help.c b/help.c
index 5d7637dce9..c81d43a5fa 100644
--- a/help.c
+++ b/help.c
@@ -1,5 +1,4 @@
 #include "git-compat-util.h"
-#include "alloc.h"
 #include "config.h"
 #include "builtin.h"
 #include "exec-cmd.h"
diff --git a/http-backend.c b/http-backend.c
index 25a19c21b9..e24399ed10 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -1,5 +1,4 @@
 #include "git-compat-util.h"
-#include "alloc.h"
 #include "config.h"
 #include "environment.h"
 #include "git-zlib.h"
diff --git a/line-log.c b/line-log.c
index 2eff914bf3..790ab73212 100644
--- a/line-log.c
+++ b/line-log.c
@@ -1,5 +1,4 @@
 #include "git-compat-util.h"
-#include "alloc.h"
 #include "line-range.h"
 #include "hex.h"
 #include "tag.h"
diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index 2a3b7881af..8a08b7af49 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -1,5 +1,4 @@
 #include "git-compat-util.h"
-#include "alloc.h"
 #include "commit.h"
 #include "config.h"
 #include "gettext.h"
diff --git a/list-objects-filter.c b/list-objects-filter.c
index e075a66c99..9327ccd505 100644
--- a/list-objects-filter.c
+++ b/list-objects-filter.c
@@ -1,5 +1,4 @@
 #include "git-compat-util.h"
-#include "alloc.h"
 #include "dir.h"
 #include "gettext.h"
 #include "hex.h"
diff --git a/midx.c b/midx.c
index db459e448b..3a16acabbc 100644
--- a/midx.c
+++ b/midx.c
@@ -1,6 +1,5 @@
 #include "git-compat-util.h"
 #include "abspath.h"
-#include "alloc.h"
 #include "config.h"
 #include "csum-file.h"
 #include "dir.h"
diff --git a/object-file.c b/object-file.c
index 527b740018..5ebe1b00c5 100644
--- a/object-file.c
+++ b/object-file.c
@@ -8,7 +8,6 @@
  */
 #include "git-compat-util.h"
 #include "abspath.h"
-#include "alloc.h"
 #include "config.h"
 #include "convert.h"
 #include "environment.h"
diff --git a/oid-array.c b/oid-array.c
index e8228c777b..8e4717746c 100644
--- a/oid-array.c
+++ b/oid-array.c
@@ -1,5 +1,4 @@
 #include "git-compat-util.h"
-#include "alloc.h"
 #include "oid-array.h"
 #include "hash-lookup.h"
 
diff --git a/oidtree.c b/oidtree.c
index 7d57b7b19e..daef175dc7 100644
--- a/oidtree.c
+++ b/oidtree.c
@@ -4,7 +4,6 @@
  */
 #include "git-compat-util.h"
 #include "oidtree.h"
-#include "alloc.h"
 #include "hash.h"
 
 struct oidtree_iter_data {
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index d86f4e739a..f6757c3cbf 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -1,5 +1,4 @@
 #include "git-compat-util.h"
-#include "alloc.h"
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 576e613837..a69b80320f 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1,5 +1,4 @@
 #include "git-compat-util.h"
-#include "alloc.h"
 #include "commit.h"
 #include "gettext.h"
 #include "hex.h"
diff --git a/pack-objects.c b/pack-objects.c
index ccab09fe65..1b8052bece 100644
--- a/pack-objects.c
+++ b/pack-objects.c
@@ -1,5 +1,4 @@
 #include "git-compat-util.h"
-#include "alloc.h"
 #include "object.h"
 #include "pack.h"
 #include "pack-objects.h"
diff --git a/packfile.c b/packfile.c
index 7683a6dbea..0f80c8ba1f 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1,5 +1,4 @@
 #include "git-compat-util.h"
-#include "alloc.h"
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
diff --git a/parallel-checkout.c b/parallel-checkout.c
index 8637723461..b5a714c711 100644
--- a/parallel-checkout.c
+++ b/parallel-checkout.c
@@ -1,5 +1,4 @@
 #include "git-compat-util.h"
-#include "alloc.h"
 #include "config.h"
 #include "entry.h"
 #include "gettext.h"
diff --git a/pretty.c b/pretty.c
index d4bc4b0286..c417dcbf72 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1,5 +1,4 @@
 #include "git-compat-util.h"
-#include "alloc.h"
 #include "config.h"
 #include "commit.h"
 #include "environment.h"
diff --git a/prio-queue.c b/prio-queue.c
index dc2476be53..450775a374 100644
--- a/prio-queue.c
+++ b/prio-queue.c
@@ -1,5 +1,4 @@
 #include "git-compat-util.h"
-#include "alloc.h"
 #include "prio-queue.h"
 
 static inline int compare(struct prio_queue *queue, int i, int j)
diff --git a/quote.c b/quote.c
index 43c739671e..3c05194496 100644
--- a/quote.c
+++ b/quote.c
@@ -1,5 +1,4 @@
 #include "git-compat-util.h"
-#include "alloc.h"
 #include "path.h"
 #include "quote.h"
 #include "strbuf.h"
diff --git a/read-cache.c b/read-cache.c
index 140b4f96a0..53d71134e2 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -4,7 +4,6 @@
  * Copyright (C) Linus Torvalds, 2005
  */
 #include "git-compat-util.h"
-#include "alloc.h"
 #include "bulk-checkin.h"
 #include "config.h"
 #include "date.h"
diff --git a/ref-filter.c b/ref-filter.c
index e0d03a9f8e..2ed0ecf260 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1,5 +1,4 @@
 #include "git-compat-util.h"
-#include "alloc.h"
 #include "environment.h"
 #include "gettext.h"
 #include "gpg-interface.h"
diff --git a/reflog-walk.c b/reflog-walk.c
index d337e64431..d216f6f966 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -1,5 +1,4 @@
 #include "git-compat-util.h"
-#include "alloc.h"
 #include "commit.h"
 #include "refs.h"
 #include "diff.h"
diff --git a/refs.c b/refs.c
index ad27ba12af..039799af45 100644
--- a/refs.c
+++ b/refs.c
@@ -4,7 +4,6 @@
 
 #include "git-compat-util.h"
 #include "advice.h"
-#include "alloc.h"
 #include "config.h"
 #include "environment.h"
 #include "hashmap.h"
diff --git a/refspec.c b/refspec.c
index 57f6c2aaf9..d60932f4de 100644
--- a/refspec.c
+++ b/refspec.c
@@ -1,5 +1,4 @@
 #include "git-compat-util.h"
-#include "alloc.h"
 #include "gettext.h"
 #include "hash.h"
 #include "hex.h"
diff --git a/remote-curl.c b/remote-curl.c
index acf7b2bb40..8a976a0253 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -1,5 +1,4 @@
 #include "git-compat-util.h"
-#include "alloc.h"
 #include "config.h"
 #include "environment.h"
 #include "gettext.h"
diff --git a/remote.c b/remote.c
index 6538b6037d..e5e165de1c 100644
--- a/remote.c
+++ b/remote.c
@@ -1,6 +1,5 @@
 #include "git-compat-util.h"
 #include "abspath.h"
-#include "alloc.h"
 #include "config.h"
 #include "environment.h"
 #include "gettext.h"
diff --git a/rerere.c b/rerere.c
index 4227c9612a..7070f75014 100644
--- a/rerere.c
+++ b/rerere.c
@@ -1,6 +1,5 @@
 #include "git-compat-util.h"
 #include "abspath.h"
-#include "alloc.h"
 #include "config.h"
 #include "copy.h"
 #include "gettext.h"
diff --git a/revision.c b/revision.c
index 84768565ce..985b8b2f51 100644
--- a/revision.c
+++ b/revision.c
@@ -1,5 +1,4 @@
 #include "git-compat-util.h"
-#include "alloc.h"
 #include "config.h"
 #include "environment.h"
 #include "gettext.h"
diff --git a/sequencer.c b/sequencer.c
index de5a89ca66..f343954999 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1,7 +1,6 @@
 #include "git-compat-util.h"
 #include "abspath.h"
 #include "advice.h"
-#include "alloc.h"
 #include "config.h"
 #include "copy.h"
 #include "environment.h"
diff --git a/server-info.c b/server-info.c
index f350713ecf..e2fe0f9143 100644
--- a/server-info.c
+++ b/server-info.c
@@ -1,5 +1,4 @@
 #include "git-compat-util.h"
-#include "alloc.h"
 #include "dir.h"
 #include "environment.h"
 #include "hex.h"
diff --git a/shallow.c b/shallow.c
index 2fad3504b7..5413719fd4 100644
--- a/shallow.c
+++ b/shallow.c
@@ -1,5 +1,4 @@
 #include "git-compat-util.h"
-#include "alloc.h"
 #include "hex.h"
 #include "repository.h"
 #include "tempfile.h"
diff --git a/sigchain.c b/sigchain.c
index ee778c0580..66123bdbab 100644
--- a/sigchain.c
+++ b/sigchain.c
@@ -1,5 +1,4 @@
 #include "git-compat-util.h"
-#include "alloc.h"
 #include "sigchain.h"
 
 #define SIGCHAIN_MAX_SIGNALS 32
diff --git a/sparse-index.c b/sparse-index.c
index 90d0462256..1fdb07a9e6 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -1,5 +1,4 @@
 #include "git-compat-util.h"
-#include "alloc.h"
 #include "environment.h"
 #include "gettext.h"
 #include "name-hash.h"
diff --git a/split-index.c b/split-index.c
index 0ee3865a55..8c38687c04 100644
--- a/split-index.c
+++ b/split-index.c
@@ -1,5 +1,4 @@
 #include "git-compat-util.h"
-#include "alloc.h"
 #include "gettext.h"
 #include "hash.h"
 #include "mem-pool.h"
diff --git a/strbuf.c b/strbuf.c
index c86aa0e802..4901d28875 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -1,5 +1,4 @@
 #include "git-compat-util.h"
-#include "alloc.h"
 #include "gettext.h"
 #include "hex.h"
 #include "strbuf.h"
diff --git a/string-list.c b/string-list.c
index 0f8ac117fd..954569f381 100644
--- a/string-list.c
+++ b/string-list.c
@@ -1,6 +1,5 @@
 #include "git-compat-util.h"
 #include "string-list.h"
-#include "alloc.h"
 
 void string_list_init_nodup(struct string_list *list)
 {
diff --git a/strvec.c b/strvec.c
index 17d54b6c3b..89dc9e7e75 100644
--- a/strvec.c
+++ b/strvec.c
@@ -1,6 +1,5 @@
 #include "git-compat-util.h"
 #include "strvec.h"
-#include "alloc.h"
 #include "hex.h"
 #include "strbuf.h"
 
diff --git a/submodule-config.c b/submodule-config.c
index 1efd547169..69cbe49278 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -1,5 +1,4 @@
 #include "git-compat-util.h"
-#include "alloc.h"
 #include "dir.h"
 #include "environment.h"
 #include "gettext.h"
diff --git a/submodule.c b/submodule.c
index f0f8788d2e..e603a19a87 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1,6 +1,5 @@
 #include "git-compat-util.h"
 #include "abspath.h"
-#include "alloc.h"
 #include "repository.h"
 #include "config.h"
 #include "submodule-config.h"
diff --git a/t/helper/test-reach.c b/t/helper/test-reach.c
index 5b6f217441..119f4908cf 100644
--- a/t/helper/test-reach.c
+++ b/t/helper/test-reach.c
@@ -1,5 +1,4 @@
 #include "test-tool.h"
-#include "alloc.h"
 #include "commit.h"
 #include "commit-reach.h"
 #include "config.h"
diff --git a/trace2/tr2_tls.c b/trace2/tr2_tls.c
index 9f46ae12f5..601c9e5036 100644
--- a/trace2/tr2_tls.c
+++ b/trace2/tr2_tls.c
@@ -1,5 +1,4 @@
 #include "git-compat-util.h"
-#include "alloc.h"
 #include "thread-utils.h"
 #include "trace.h"
 #include "trace2/tr2_tls.h"
diff --git a/trailer.c b/trailer.c
index a2c3ed6f28..2170e01f6a 100644
--- a/trailer.c
+++ b/trailer.c
@@ -1,5 +1,4 @@
 #include "git-compat-util.h"
-#include "alloc.h"
 #include "config.h"
 #include "environment.h"
 #include "gettext.h"
diff --git a/transport.c b/transport.c
index 0a5794a944..219af8fd50 100644
--- a/transport.c
+++ b/transport.c
@@ -1,6 +1,5 @@
 #include "git-compat-util.h"
 #include "advice.h"
-#include "alloc.h"
 #include "config.h"
 #include "environment.h"
 #include "hex.h"
diff --git a/tree-walk.c b/tree-walk.c
index 42ed86ef58..6c07913f3f 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -1,6 +1,5 @@
 #include "git-compat-util.h"
 #include "tree-walk.h"
-#include "alloc.h"
 #include "dir.h"
 #include "gettext.h"
 #include "hex.h"
diff --git a/userdiff.c b/userdiff.c
index 664c7c1402..e399543823 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -1,5 +1,4 @@
 #include "git-compat-util.h"
-#include "alloc.h"
 #include "config.h"
 #include "userdiff.h"
 #include "attr.h"
diff --git a/worktree.c b/worktree.c
index 2018c127ca..7410dce811 100644
--- a/worktree.c
+++ b/worktree.c
@@ -1,6 +1,5 @@
 #include "git-compat-util.h"
 #include "abspath.h"
-#include "alloc.h"
 #include "environment.h"
 #include "gettext.h"
 #include "path.h"
-- 
2.41.0.rc2.161.g9c6817b8e7-goog

