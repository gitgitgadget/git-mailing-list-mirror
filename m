Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D5C4C433FE
	for <git@archiver.kernel.org>; Sat, 19 Nov 2022 13:08:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233591AbiKSNIW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Nov 2022 08:08:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233572AbiKSNH6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Nov 2022 08:07:58 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44BA592B52
        for <git@vger.kernel.org>; Sat, 19 Nov 2022 05:07:57 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id vv4so9851035ejc.2
        for <git@vger.kernel.org>; Sat, 19 Nov 2022 05:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xSrSF+ZjUQhMVcUVGUUOQ4Sf/4LCZa0L3/c0+tNxobU=;
        b=kb0cZ/lLbKelxK3cdYryAnIyEj9VxXMGY/LKbkPaBC5AmrqgG6JBBUyImShDVz3P2t
         xVoi8xgUDVhNPPg7jHA+wu/kIQmB6zaTJ/a1flT4enRQUqxDwmhAU4/NbzgJfRbsjM11
         AdFs/WBi/P05+sBtEVJIFvq8xmnjId2QOohJqy2+ac5vkzdIwArjJ+L5NpbWTNbT3wgH
         zsk5cG0BbtB8A/qR7ykO3JfwEfjYStT2Mjv/ou0Og+jCtxWLceqXKt6l7wIOoArX7gJO
         2kElDPwokUmulpbIO+V/ZbFfXR7CFfnkZ/fiZkLiwwgMdJH88KfLNlRvIhDAUvJgUe+C
         gKnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xSrSF+ZjUQhMVcUVGUUOQ4Sf/4LCZa0L3/c0+tNxobU=;
        b=G6CVreMTA7Sic2U6RvlltIIEvoPc3XpF9/gs8gv9ynZXQsBzOd/P/1V8WsNdcfVth5
         3loOAMWZzYKyi3SGMGPEGfwaG8M0uk9Q8dyQDPJaRB+g1D5t7ldtvdCPq9SeomxLeZsq
         8fGv0yze5rjnkcPn4YLLzXpFxOqsJ0ACtQg6VzdLPe6lXo25bNf4W1KMCba5uNdS+KaB
         +awxQhZzEZMiwuVsFWB7nDoVicf9apHj0k80v5Ot+XS3NCyPTc0uyDR995/tq4aoe/dk
         vai7/qtSlWxOngZQQNS1+2fUWl/Ebeo0XPghYOwSriTtYxuGsy0iWc+gY6onHIMbkXsj
         pFYg==
X-Gm-Message-State: ANoB5pmV+OuxknS4rxU9JQqzX6IgTgS+Nyekdlee2O0ui4yN7//Bsiru
        iRrdsK2N5QvQfm14zeWixCWKWBxhCrVsIw==
X-Google-Smtp-Source: AA0mqf6HUMhLKB0MhazkU4rvXWGYUeggP5S28+rIoJMSMuTgLeTaRKxyAiGpUz18o1k2Hm9cnQaVoA==
X-Received: by 2002:a17:906:2e82:b0:7ae:44b2:cb7f with SMTP id o2-20020a1709062e8200b007ae44b2cb7fmr9152253eji.437.1668863275261;
        Sat, 19 Nov 2022 05:07:55 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id ch28-20020a0564021bdc00b0045d74aa401fsm2923802edb.60.2022.11.19.05.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Nov 2022 05:07:54 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 09/11] {builtin/*,repository}.c: add & use "USE_THE_INDEX_VARIABLE"
Date:   Sat, 19 Nov 2022 14:07:36 +0100
Message-Id: <patch-v2-09.11-429eecc78ec-20221119T125551Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1509.g9445af83948
In-Reply-To: <cover-v2-00.11-00000000000-20221119T125550Z-avarab@gmail.com>
References: <cover-00.12-00000000000-20221118T112205Z-avarab@gmail.com> <cover-v2-00.11-00000000000-20221119T125550Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Split up the "USE_THE_INDEX_COMPATIBILITY_MACROS" into that setting
and a more narrow "USE_THE_INDEX_VARIABLE". In the case of these
built-ins we only need "the_index" variable, but not the compatibility
wrapper for functions we're not using.

Let's then have some users of "USE_THE_INDEX_COMPATIBILITY_MACROS" use
this more narrow and descriptive define.

For context: The USE_THE_INDEX_COMPATIBILITY_MACROS macro was added to
test-tool.h in f8adbec9fea (cache.h: flip
NO_THE_INDEX_COMPATIBILITY_MACROS switch, 2019-01-24).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/cat-file.c   | 2 +-
 builtin/difftool.c   | 2 +-
 builtin/merge-tree.c | 2 +-
 builtin/pull.c       | 2 +-
 cache.h              | 6 +++++-
 repository.c         | 2 +-
 6 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index fa7bd891692..b3be58b1fb0 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -3,7 +3,7 @@
  *
  * Copyright (C) Linus Torvalds, 2005
  */
-#define USE_THE_INDEX_COMPATIBILITY_MACROS
+#define USE_THE_INDEX_VARIABLE
 #include "cache.h"
 #include "config.h"
 #include "builtin.h"
diff --git a/builtin/difftool.c b/builtin/difftool.c
index d7f08c8a7fa..d9b76226f6a 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -11,7 +11,7 @@
  *
  * Copyright (C) 2016 Johannes Schindelin
  */
-#define USE_THE_INDEX_COMPATIBILITY_MACROS
+#define USE_THE_INDEX_VARIABLE
 #include "cache.h"
 #include "config.h"
 #include "builtin.h"
diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index fe853aa8f91..e3767087bbf 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -1,4 +1,4 @@
-#define USE_THE_INDEX_COMPATIBILITY_MACROS
+#define USE_THE_INDEX_VARIABLE
 #include "builtin.h"
 #include "tree-walk.h"
 #include "xdiff-interface.h"
diff --git a/builtin/pull.c b/builtin/pull.c
index 4a2a6db2dce..1ab4de0005d 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -5,7 +5,7 @@
  *
  * Fetch one or more remote refs and merge it/them into the current HEAD.
  */
-#define USE_THE_INDEX_COMPATIBILITY_MACROS
+#define USE_THE_INDEX_VARIABLE
 #include "cache.h"
 #include "config.h"
 #include "builtin.h"
diff --git a/cache.h b/cache.h
index 805e25f9a67..707806d2125 100644
--- a/cache.h
+++ b/cache.h
@@ -433,9 +433,11 @@ typedef int (*must_prefetch_predicate)(const struct cache_entry *);
 void prefetch_cache_entries(const struct index_state *istate,
 			    must_prefetch_predicate must_prefetch);
 
-#ifdef USE_THE_INDEX_COMPATIBILITY_MACROS
+#if defined(USE_THE_INDEX_COMPATIBILITY_MACROS) || defined(USE_THE_INDEX_VARIABLE)
 extern struct index_state the_index;
 
+#ifndef USE_THE_INDEX_VARIABLE
+#ifdef USE_THE_INDEX_COMPATIBILITY_MACROS
 #define active_nr (the_index.cache_nr)
 
 #define read_cache() repo_read_index(the_repository)
@@ -447,6 +449,8 @@ extern struct index_state the_index;
 #define refresh_and_write_cache(refresh_flags, write_flags, gentle) repo_refresh_and_write_index(the_repository, (refresh_flags), (write_flags), (gentle), NULL, NULL, NULL)
 #define hold_locked_index(lock_file, flags) repo_hold_locked_index(the_repository, (lock_file), (flags))
 #endif
+#endif
+#endif
 
 #define TYPE_BITS 3
 
diff --git a/repository.c b/repository.c
index 5d166b692c8..3427085fd6d 100644
--- a/repository.c
+++ b/repository.c
@@ -2,7 +2,7 @@
  * not really _using_ the compat macros, just make sure the_index
  * declaration matches the definition in this file.
  */
-#define USE_THE_INDEX_COMPATIBILITY_MACROS
+#define USE_THE_INDEX_VARIABLE
 #include "cache.h"
 #include "repository.h"
 #include "object-store.h"
-- 
2.38.0.1509.g9445af83948

