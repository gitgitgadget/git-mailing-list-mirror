Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7119C77B7A
	for <git@archiver.kernel.org>; Tue, 16 May 2023 17:10:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbjEPRKY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 May 2023 13:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbjEPRKF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2023 13:10:05 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7285D6EA1
        for <git@vger.kernel.org>; Tue, 16 May 2023 10:09:59 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-52c6c5dc988so7459705a12.2
        for <git@vger.kernel.org>; Tue, 16 May 2023 10:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684256999; x=1686848999;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZFu3htZOjlwmZIYuizXxQaqWDzc6s720VzsTlxV9qQo=;
        b=cM4XHxVI24tRjrZ3qOSOPNO+r7+xk7ALDzJpV7UCuIiqeH/cg7DoGpl9WOtFFfLvyc
         fxwF9ArZyJwauXj9lWZMQmRoX7/vbpY2iOyDNJ7phXxRwRvLrPU00uqaN5sgL9dfAMhl
         u3kd+YWKd4fBjf6F+q48nsjJ+u9JxKG9S4XFo8+V5pc5M7SJfjqcCyw0NvK9+trGV7qH
         2fPvE1o4XDsoQWCfl1v1Uf8EDi47/9znRX+TC41Ctweqj7i/qTB829w5yZ7Pnui1v8Rs
         7iTZofNtMjrx0y/gXcNQVSrWGKLo1PlZAeEVG3S5+GboSZ9lepxqkc+1r4ZeGX2hl0LC
         OMew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684256999; x=1686848999;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZFu3htZOjlwmZIYuizXxQaqWDzc6s720VzsTlxV9qQo=;
        b=JUVXBsj3XRrd6/0jvsuxVTMMuT/Xlmyc7vv7PAZ/vHcxWr6s1EmkRqUI7Xk04glcSa
         Bl+gYVIJtbRityPuYR2+rJWQYgIbhv1zfksLE5EsW2JMV1kZrQ4/yPgZk91hdE5TVdBu
         XJ1BFBWNdI6fkUPW706NcenExROOy1y2TrH1ioRMcD1HJTvWROgSzvR4AMDPzRPUxT5E
         kRswtv8Nc4Idz8SId3NpCIaigCRV10918vB4m54ab7VqLbgoa8ggxaaMnuleVX/N6Pe3
         jdhQMDt5TLZIFQuxzoF+oevFUtfV01349TuDgQmyYZDmUZnRcWpp/Zp/CwFKdDrE6EE5
         +wKQ==
X-Gm-Message-State: AC+VfDzGJHa0RwtzZiPkUGNhq5c+bRsL6fMlv0/iv0bhCb1nIyp8mUCa
        bTyhi50rmniSnX5Vcs0ZizBZwRVWkevPguZhfPsvf8l21dcOslB+aqVSC3vUrg+BR2ZpUUyaapx
        +XFN/MZ2XhnaqUEemcMaFdtmyj82Xt6pn3mKKNnUeoQ7UEVo47WiKFF6lN1DeLssc8g==
X-Google-Smtp-Source: ACHHUZ7IbnIT/uxlbfGdHPTf3EsHalRrJC8CsHtTNN1mPC2VZJDCuiBPsM+NlkzuC7SnoacTHsb+7GcIZ+Hsv38=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a63:646:0:b0:530:70cb:6da9 with SMTP id
 67-20020a630646000000b0053070cb6da9mr5124627pgg.10.1684256998868; Tue, 16 May
 2023 10:09:58 -0700 (PDT)
Date:   Tue, 16 May 2023 17:09:31 +0000
In-Reply-To: <20230516170932.1358685-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230516170932.1358685-1-calvinwan@google.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Message-ID: <20230516170932.1358685-7-calvinwan@google.com>
Subject: [PATCH 6/6] common: move alloc macros to common.h
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>
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
index 8d770d203f..b153d4a37d 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -1,7 +1,6 @@
 #include "cache.h"
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
index ef6020b18f..f06eaffa09 100644
--- a/apply.c
+++ b/apply.c
@@ -9,7 +9,6 @@
 
 #include "cache.h"
 #include "abspath.h"
-#include "alloc.h"
 #include "config.h"
 #include "object-store.h"
 #include "blob.h"
diff --git a/archive-tar.c b/archive-tar.c
index 4cd81d8161..8d41c4c581 100644
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
index 8570cf37ff..835f9765f1 100644
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
index 2d8aeb8b58..56d7c89392 100644
--- a/attr.c
+++ b/attr.c
@@ -7,7 +7,6 @@
  */
 
 #include "cache.h"
-#include "alloc.h"
 #include "config.h"
 #include "environment.h"
 #include "exec-cmd.h"
diff --git a/builtin/blame.c b/builtin/blame.c
index 2df6039a6e..421a2ed4ca 100644
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
index 0bafc14e6c..83178a24b3 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -5,7 +5,6 @@
  */
 #define USE_THE_INDEX_VARIABLE
 #include "cache.h"
-#include "alloc.h"
 #include "config.h"
 #include "convert.h"
 #include "builtin.h"
diff --git a/builtin/checkout--worker.c b/builtin/checkout--worker.c
index 2120dd1d30..bad7c29eb3 100644
--- a/builtin/checkout--worker.c
+++ b/builtin/checkout--worker.c
@@ -1,5 +1,4 @@
 #include "builtin.h"
-#include "alloc.h"
 #include "config.h"
 #include "entry.h"
 #include "gettext.h"
diff --git a/builtin/config.c b/builtin/config.c
index 71bb376fb3..04e2bb0dc7 100644
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
index 4e571d9951..2122571827 100644
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
index f6dd9a784c..d4b666bf9c 100644
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
index b86c754def..3e7a485927 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -4,7 +4,6 @@
  * Copyright (c) 2006 Junio C Hamano
  */
 #include "cache.h"
-#include "alloc.h"
 #include "gettext.h"
 #include "hex.h"
 #include "repository.h"
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 1e065e9ce3..c05d8a70e0 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1,5 +1,4 @@
 #include "builtin.h"
-#include "alloc.h"
 #include "config.h"
 #include "delta.h"
 #include "environment.h"
diff --git a/builtin/log.c b/builtin/log.c
index 4f162ff4d0..6ac4081d4c 100644
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
index b800d4e189..82b832fcf9 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -10,7 +10,6 @@
 #include "cache.h"
 #include "abspath.h"
 #include "advice.h"
-#include "alloc.h"
 #include "config.h"
 #include "editor.h"
 #include "environment.h"
diff --git a/builtin/mktree.c b/builtin/mktree.c
index 09a7bd5c5c..aa00c70feb 100644
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
index 32935af48e..54f0df021b 100644
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
index 593f0506a1..dba4a3aa07 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -1,5 +1,4 @@
 #include "builtin.h"
-#include "alloc.h"
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 79f3a2f300..a82eb04fee 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1,5 +1,4 @@
 #include "builtin.h"
-#include "alloc.h"
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
diff --git a/builtin/repack.c b/builtin/repack.c
index bb7bf60e7c..4e0943a543 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -1,5 +1,4 @@
 #include "builtin.h"
-#include "alloc.h"
 #include "config.h"
 #include "dir.h"
 #include "environment.h"
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 852e49e340..9a3783597f 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -6,7 +6,6 @@
 #define USE_THE_INDEX_VARIABLE
 #include "cache.h"
 #include "abspath.h"
-#include "alloc.h"
 #include "config.h"
 #include "commit.h"
 #include "environment.h"
diff --git a/builtin/revert.c b/builtin/revert.c
index 0240ec8593..8247e6592e 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -1,5 +1,4 @@
 #include "git-compat-util.h"
-#include "alloc.h"
 #include "config.h"
 #include "builtin.h"
 #include "parse-options.h"
diff --git a/builtin/rm.c b/builtin/rm.c
index d36072252e..1a1e409262 100644
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
index 6bf8d666ce..2e478104ab 100644
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
index 9192298db6..68a881a233 100644
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
index ebfe649b33..2a2c5ad498 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -1,5 +1,4 @@
 #include "cache.h"
-#include "alloc.h"
 #include "environment.h"
 #include "hex.h"
 #include "lockfile.h"
diff --git a/chunk-format.c b/chunk-format.c
index 60a73c1b14..0cb125eb38 100644
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
index 4aa99bc98b..a4a985474d 100644
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
index b7cccbe245..2672be0888 100644
--- a/config.c
+++ b/config.c
@@ -8,7 +8,6 @@
 #include "cache.h"
 #include "abspath.h"
 #include "advice.h"
-#include "alloc.h"
 #include "date.h"
 #include "branch.h"
 #include "config.h"
diff --git a/daemon.c b/daemon.c
index 4047b0cf27..2a9ea57a41 100644
--- a/daemon.c
+++ b/daemon.c
@@ -1,6 +1,5 @@
 #include "cache.h"
 #include "abspath.h"
-#include "alloc.h"
 #include "config.h"
 #include "environment.h"
 #include "pkt-line.h"
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
index 4033358cf4..9c3d89dd07 100644
--- a/diff.c
+++ b/diff.c
@@ -3,7 +3,6 @@
  */
 #include "cache.h"
 #include "abspath.h"
-#include "alloc.h"
 #include "config.h"
 #include "convert.h"
 #include "environment.h"
diff --git a/diffcore-rename.c b/diffcore-rename.c
index 8e2e7a3ad7..29979b4162 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2005 Junio C Hamano
  */
 #include "git-compat-util.h"
-#include "alloc.h"
 #include "diff.h"
 #include "diffcore.h"
 #include "object-store.h"
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
index f235df015e..d2b1fa20e2 100644
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
index 5e3e875670..48438c7d86 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1,5 +1,4 @@
 #include "git-compat-util.h"
-#include "alloc.h"
 #include "repository.h"
 #include "config.h"
 #include "environment.h"
diff --git a/fmt-merge-msg.c b/fmt-merge-msg.c
index 5af0d4715b..9939bf2703 100644
--- a/fmt-merge-msg.c
+++ b/fmt-merge-msg.c
@@ -1,5 +1,4 @@
 #include "git-compat-util.h"
-#include "alloc.h"
 #include "config.h"
 #include "environment.h"
 #include "refs.h"
diff --git a/fsck.c b/fsck.c
index adbe8bf59e..3864af088e 100644
--- a/fsck.c
+++ b/fsck.c
@@ -1,5 +1,4 @@
 #include "git-compat-util.h"
-#include "alloc.h"
 #include "hex.h"
 #include "object-store.h"
 #include "repository.h"
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
index 4491cdee39..de5b72658e 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -1,5 +1,4 @@
 #include "git-compat-util.h"
-#include "alloc.h"
 #include "config.h"
 #include "environment.h"
 #include "git-zlib.h"
diff --git a/line-log.c b/line-log.c
index 10c19daec4..5cb82d731f 100644
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
index 5d270ce598..2742e4a87d 100644
--- a/list-objects-filter.c
+++ b/list-objects-filter.c
@@ -1,5 +1,4 @@
 #include "git-compat-util.h"
-#include "alloc.h"
 #include "dir.h"
 #include "gettext.h"
 #include "hex.h"
diff --git a/midx.c b/midx.c
index 281a1406a8..59dd343275 100644
--- a/midx.c
+++ b/midx.c
@@ -1,6 +1,5 @@
 #include "cache.h"
 #include "abspath.h"
-#include "alloc.h"
 #include "config.h"
 #include "csum-file.h"
 #include "dir.h"
diff --git a/object-file.c b/object-file.c
index 43c1585aa7..f565070be3 100644
--- a/object-file.c
+++ b/object-file.c
@@ -8,7 +8,6 @@
  */
 #include "cache.h"
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
index faf67c94d3..335cc3c781 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -1,5 +1,4 @@
 #include "git-compat-util.h"
-#include "alloc.h"
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
diff --git a/pack-bitmap.c b/pack-bitmap.c
index e0fad723bf..133c1a6556 100644
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
index 96727e63a8..57d6b57107 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1,5 +1,4 @@
 #include "cache.h"
-#include "alloc.h"
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
diff --git a/parallel-checkout.c b/parallel-checkout.c
index 38c4dc665d..906e1ced61 100644
--- a/parallel-checkout.c
+++ b/parallel-checkout.c
@@ -1,5 +1,4 @@
 #include "cache.h"
-#include "alloc.h"
 #include "config.h"
 #include "entry.h"
 #include "gettext.h"
diff --git a/pretty.c b/pretty.c
index 0bb938021b..c162466ec8 100644
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
index 7fa89c684d..ddcd613ff3 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -4,7 +4,6 @@
  * Copyright (C) Linus Torvalds, 2005
  */
 #include "cache.h"
-#include "alloc.h"
 #include "config.h"
 #include "diff.h"
 #include "diffcore.h"
diff --git a/ref-filter.c b/ref-filter.c
index 10aab14f03..2961cd6b20 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1,5 +1,4 @@
 #include "cache.h"
-#include "alloc.h"
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
diff --git a/reflog-walk.c b/reflog-walk.c
index 4ba1a10c82..d8dd6e7cdf 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -1,5 +1,4 @@
 #include "git-compat-util.h"
-#include "alloc.h"
 #include "commit.h"
 #include "refs.h"
 #include "diff.h"
diff --git a/refs.c b/refs.c
index 379217b03e..75171b46b2 100644
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
index 7b5c305514..80119bb0e5 100644
--- a/refspec.c
+++ b/refspec.c
@@ -1,5 +1,4 @@
 #include "git-compat-util.h"
-#include "alloc.h"
 #include "gettext.h"
 #include "hex.h"
 #include "strvec.h"
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
index 0764fca0db..cae782c86f 100644
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
index 7ed2493891..66a0d55ead 100644
--- a/rerere.c
+++ b/rerere.c
@@ -1,6 +1,5 @@
 #include "cache.h"
 #include "abspath.h"
-#include "alloc.h"
 #include "config.h"
 #include "gettext.h"
 #include "hex.h"
diff --git a/revision.c b/revision.c
index b33cc1d106..f0554d9352 100644
--- a/revision.c
+++ b/revision.c
@@ -1,5 +1,4 @@
 #include "cache.h"
-#include "alloc.h"
 #include "config.h"
 #include "environment.h"
 #include "gettext.h"
diff --git a/sequencer.c b/sequencer.c
index e773b4999b..23ea4aff4d 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1,7 +1,6 @@
 #include "cache.h"
 #include "abspath.h"
 #include "advice.h"
-#include "alloc.h"
 #include "config.h"
 #include "environment.h"
 #include "gettext.h"
diff --git a/server-info.c b/server-info.c
index 67ce4ad529..5f216449bc 100644
--- a/server-info.c
+++ b/server-info.c
@@ -1,5 +1,4 @@
 #include "cache.h"
-#include "alloc.h"
 #include "dir.h"
 #include "environment.h"
 #include "hex.h"
diff --git a/shallow.c b/shallow.c
index 9ff8923ccf..c168764d13 100644
--- a/shallow.c
+++ b/shallow.c
@@ -1,5 +1,4 @@
 #include "cache.h"
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
index 886054729e..8f6fcd8250 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -1,5 +1,4 @@
 #include "cache.h"
-#include "alloc.h"
 #include "environment.h"
 #include "gettext.h"
 #include "repository.h"
diff --git a/split-index.c b/split-index.c
index 5602b74994..6467dc9e23 100644
--- a/split-index.c
+++ b/split-index.c
@@ -1,5 +1,4 @@
 #include "cache.h"
-#include "alloc.h"
 #include "gettext.h"
 #include "mem-pool.h"
 #include "split-index.h"
diff --git a/strbuf.c b/strbuf.c
index d486189303..5700eb86d4 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -1,6 +1,5 @@
 #include "git-compat-util.h"
 #include "abspath.h"
-#include "alloc.h"
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
diff --git a/string-list.c b/string-list.c
index db473f273e..ccc105da04 100644
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
index 7fc0812b64..30c8508a79 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -1,5 +1,4 @@
 #include "git-compat-util.h"
-#include "alloc.h"
 #include "dir.h"
 #include "environment.h"
 #include "gettext.h"
diff --git a/submodule.c b/submodule.c
index 2e78f51349..4da39e0ede 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1,6 +1,5 @@
 #include "cache.h"
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
index cd4b7f5528..370b18a4ee 100644
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
index 2993c48c2f..e8f24c8b3f 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -1,6 +1,5 @@
 #include "cache.h"
 #include "tree-walk.h"
-#include "alloc.h"
 #include "dir.h"
 #include "gettext.h"
 #include "hex.h"
diff --git a/userdiff.c b/userdiff.c
index eaec6ebb5e..a9f078ade0 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -1,5 +1,4 @@
 #include "git-compat-util.h"
-#include "alloc.h"
 #include "config.h"
 #include "userdiff.h"
 #include "attr.h"
diff --git a/worktree.c b/worktree.c
index 7afeaf49fe..0e464241b6 100644
--- a/worktree.c
+++ b/worktree.c
@@ -1,6 +1,5 @@
 #include "git-compat-util.h"
 #include "abspath.h"
-#include "alloc.h"
 #include "environment.h"
 #include "gettext.h"
 #include "repository.h"
-- 
2.40.1.606.ga4b1b128d6-goog

