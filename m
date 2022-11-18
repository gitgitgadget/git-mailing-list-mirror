Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96ACAC4332F
	for <git@archiver.kernel.org>; Fri, 18 Nov 2022 11:31:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241351AbiKRLbk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Nov 2022 06:31:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241264AbiKRLbY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Nov 2022 06:31:24 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F81898FE
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 03:31:18 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id 21so6748626edv.3
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 03:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ISurFPd/+eeJrwXcabcnUe52+cLlWCZcsCmx7Dl9Zkc=;
        b=JB49R8m2kzHjxULIdbK5iKVR0ffYofcZyIzETWwEYdgtlxoAN8UqH4qcmXJrbwDeWU
         nY0/8hntvcflW1Wb+XkWbaVS/Uc8By3miNts0fQea2Obpi6cXUv2bvp4zbSPAWPDW9wr
         6Kmr9PBCs9jFGLQ0SzkQ9lOiD+vVfi/knXrVmJaJeaoN5P0wTe/Kl0WuFNrZj7+MOcep
         5kfEEB3xf1v0TEYGC/j/H/9F60O2+uY48eXlQTDYAZUApJ8QmbBIoTJJpjZt9aKJ8tkc
         3MnGa2+okrvjuiHQLL8EjnHLNdUY6B7ub5d2ZtuOjBo7EPki0iONNGwzmQGCW/z7MziX
         /8fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ISurFPd/+eeJrwXcabcnUe52+cLlWCZcsCmx7Dl9Zkc=;
        b=tXUgYRHFvngsfHzCzVb/WS52ai1ITK/Evx3YFuqfkAXQvGqZpV9p8G4GKWWXoAe3WW
         ofj0LGUvYH8GGYuujNPIa40hJGZkR3XGErrmd7+mFJIZO/nKYeo8Cq5j8KEqy140bv+/
         DjyCgxVMr1Tz2GiayNQZyLsJSMkguBgiUwaRPf2Y20kAJpKDC/GDouSVdXsTy6FHZ9jp
         TWSbgTGNFi1Jq3e6ZoO1sig3iCLvkYw265NLDj98KikFLpFQxYYvIbVVv3WKslgp83TB
         0lo+ObPdERK4VuZIqgS0pLKPok2EAOAUFlbLG5/zl/i8wyM6Tl29N/FnIOTjsSGqd9se
         vN7Q==
X-Gm-Message-State: ANoB5plzzOIm3gUmtSVqPJ9iTuTcV8jdIhPcGTb1vmFyQUZP+Y7jekEn
        LZRZg2rR3UphmLXslwFwi42nL10nzXeAGQ==
X-Google-Smtp-Source: AA0mqf6Gv5b0Y7gMzeRLY/ahJsCoGQyBbAB3KtJGx0qdqmluUhmQ7s7v6OEhft4yAW4/RkQPGzYzWA==
X-Received: by 2002:a05:6402:43cd:b0:467:c68b:b06c with SMTP id p13-20020a05640243cd00b00467c68bb06cmr5608469edc.428.1668771076791;
        Fri, 18 Nov 2022 03:31:16 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id cw24-20020a056402229800b0046730154ccbsm1713302edb.42.2022.11.18.03.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 03:31:16 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 09/12] {builtin/*,repository}.c: add & use "USE_THE_INDEX_VARIABLE"
Date:   Fri, 18 Nov 2022 12:31:03 +0100
Message-Id: <patch-09.12-5b69cfa17ad-20221118T112205Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1511.gcdcff1f1dc2
In-Reply-To: <cover-00.12-00000000000-20221118T112205Z-avarab@gmail.com>
References: <cover-00.12-00000000000-20221118T112205Z-avarab@gmail.com>
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
index 8b54b627459..72c3d4e2ef5 100644
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
 #define active_cache_tree (the_index.cache_tree)
 
@@ -448,6 +450,8 @@ extern struct index_state the_index;
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
2.38.0.1511.gcdcff1f1dc2

