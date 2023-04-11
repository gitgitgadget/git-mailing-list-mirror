Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5EC8C7619A
	for <git@archiver.kernel.org>; Tue, 11 Apr 2023 07:43:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbjDKHnF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Apr 2023 03:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbjDKHmq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2023 03:42:46 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D7FA3C16
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 00:42:26 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id ke16so6982999plb.6
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 00:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681198945; x=1683790945;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3chIDBP8mBk73TYf7xtDDYeIfVdB6+/GccS+KGUuJqE=;
        b=ntV46JYoCK8+mv9ABLvfB1daZonk7S4eULZnethCqB36guczvfmKmYYV4fKEB/YUw+
         danY3K8/EwHBf7QDCNK3WP9+mlFzxyVGK56TTha7QFlJ3di1VwvkTLatub0MNxPrXl32
         57DQ3765VPA+MTp3ZkNcWVaCAZWfCDMSTr2deGycrOv6TSeA+7FFY724XJYF8ca7XV17
         4Pa/Jk5MYNSdn4hXOxt5iXQSeRaNKweh2S8UCQ2KiMOM6swKj6cgSLeH6WWpygjQ/1e8
         pas7yzSCjZf+9UtQbPU8RcARV6ZBBMsoHekDMJOQi9j3P8+XCmCAa3SfLd7qjoQ2XaNK
         Pojg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681198945; x=1683790945;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3chIDBP8mBk73TYf7xtDDYeIfVdB6+/GccS+KGUuJqE=;
        b=tbhoULHiEFVUfxUFTBHIc1XdnzY72ccScxzy2izIQwFnoA57sepe0ehKTwaZtOjSZi
         OeHWXTQFgyjrtaRp6cQssBeR270LHWA0tLEuMGV1mIjGYF4a/oqMkZRZVfdH74FjDVJO
         lezK5gumdd+fCFoNAi/ahwKt7yCvZUFs9Pq7uSf6yAJTvx9kXH8nn/CQsDVCzvTcMcTG
         vWflCGMnlpPV1R9FKLdO+8mxqzhDws/z31P4COE7eTHm6HvBSgpm1eU4g/Y4nlHwy70+
         d0jyVwPLQ8S0OavBDL6eM7mnaAYCBPC6M7/Gy4N9zxacpIArbBInXV8sYYmBFLRwQDuk
         NqaA==
X-Gm-Message-State: AAQBX9eVi8IZa+HuMiBVvh3ccwy84Dj5bz2uWDYcQmjNrxuOHlGVuHhi
        c6fY+RdQNjJ6sFPODaREGBGQD1jecMg=
X-Google-Smtp-Source: AKy350bL/ZFDbm1ZOUPiJS5GXHu42Eik4aXzlq31Qm/LtE73TFBtC/gALX+4GRDpiX0OVTKem2b9VQ==
X-Received: by 2002:a17:902:f254:b0:1a1:460e:6a5d with SMTP id j20-20020a170902f25400b001a1460e6a5dmr2156527plc.49.1681198945363;
        Tue, 11 Apr 2023 00:42:25 -0700 (PDT)
Received: from iron-rod.hsd1.ca.comcast.net ([2601:646:9e80:a0b0::f6a9])
        by smtp.gmail.com with ESMTPSA id az4-20020a170902a58400b001a1deff606fsm8992820plb.125.2023.04.11.00.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 00:42:24 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Calvin Wan <calvinwan@google.com>
Subject: [PATCH v3 15/23] treewide: remove cache.h inclusion due to object.h changes
Date:   Tue, 11 Apr 2023 00:41:56 -0700
Message-Id: <20230411074204.3024420-10-newren@gmail.com>
X-Mailer: git-send-email 2.40.0.172.g72fe1174621
In-Reply-To: <20230411074204.3024420-1-newren@gmail.com>
References: <pull.1509.v3.git.1681182060.gitgitgadget@gmail.com>
 <20230411074204.3024420-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Elijah Newren <newren@gmail.com>
Acked-by: Calvin Wan <calvinwan@google.com>
---
 bisect.c              | 2 +-
 bundle.c              | 2 +-
 commit.c              | 2 +-
 delta-islands.c       | 2 +-
 diff-no-index.c       | 2 +-
 fsck.c                | 2 +-
 http-push.c           | 2 +-
 list-objects-filter.c | 2 +-
 list-objects.c        | 2 +-
 log-tree.c            | 2 +-
 pack-bitmap-write.c   | 2 +-
 parse-options-cb.c    | 1 -
 rebase-interactive.c  | 2 +-
 submodule-config.c    | 2 +-
 tag.c                 | 2 +-
 transport.c           | 2 +-
 walker.c              | 2 +-
 17 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/bisect.c b/bisect.c
index e708e8b6aa1..8d5f8e58851 100644
--- a/bisect.c
+++ b/bisect.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "config.h"
 #include "commit.h"
 #include "diff.h"
diff --git a/bundle.c b/bundle.c
index 6471489975a..a5505368de5 100644
--- a/bundle.c
+++ b/bundle.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "lockfile.h"
 #include "bundle.h"
 #include "environment.h"
diff --git a/commit.c b/commit.c
index bad31c423a4..878b4473e4c 100644
--- a/commit.c
+++ b/commit.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "tag.h"
 #include "commit.h"
 #include "commit-graph.h"
diff --git a/delta-islands.c b/delta-islands.c
index 40f2ccfb550..c824a5f6a42 100644
--- a/delta-islands.c
+++ b/delta-islands.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "alloc.h"
 #include "attr.h"
 #include "object.h"
diff --git a/diff-no-index.c b/diff-no-index.c
index 934a24bee58..4296940f907 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -4,7 +4,7 @@
  * Copyright (c) 2008 by Junio C Hamano
  */
 
-#include "cache.h"
+#include "git-compat-util.h"
 #include "abspath.h"
 #include "color.h"
 #include "commit.h"
diff --git a/fsck.c b/fsck.c
index 8ef1b022346..adbe8bf59e7 100644
--- a/fsck.c
+++ b/fsck.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "alloc.h"
 #include "hex.h"
 #include "object-store.h"
diff --git a/http-push.c b/http-push.c
index a8af6c0f690..637a4e91f7a 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "environment.h"
 #include "hex.h"
 #include "repository.h"
diff --git a/list-objects-filter.c b/list-objects-filter.c
index 8b2a45e507d..5d270ce5987 100644
--- a/list-objects-filter.c
+++ b/list-objects-filter.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "alloc.h"
 #include "dir.h"
 #include "gettext.h"
diff --git a/list-objects.c b/list-objects.c
index df18d103063..eecca721ac0 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "tag.h"
 #include "commit.h"
 #include "gettext.h"
diff --git a/log-tree.c b/log-tree.c
index f0e885635e0..b5cf3d8439c 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "commit-reach.h"
 #include "config.h"
 #include "diff.h"
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 7f5f489beb0..faf67c94d37 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "alloc.h"
 #include "environment.h"
 #include "gettext.h"
diff --git a/parse-options-cb.c b/parse-options-cb.c
index b4df4bcebed..26a4c7d08a9 100644
--- a/parse-options-cb.c
+++ b/parse-options-cb.c
@@ -1,7 +1,6 @@
 #include "git-compat-util.h"
 #include "parse-options.h"
 #include "branch.h"
-#include "cache.h"
 #include "commit.h"
 #include "color.h"
 #include "environment.h"
diff --git a/rebase-interactive.c b/rebase-interactive.c
index 48467a7bc4a..6ff12d7be2d 100644
--- a/rebase-interactive.c
+++ b/rebase-interactive.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "commit.h"
 #include "environment.h"
 #include "gettext.h"
diff --git a/submodule-config.c b/submodule-config.c
index 252b90aa439..7fc0812b644 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "alloc.h"
 #include "dir.h"
 #include "environment.h"
diff --git a/tag.c b/tag.c
index b9fc2fc9929..96dbd5b2d55 100644
--- a/tag.c
+++ b/tag.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "environment.h"
 #include "tag.h"
 #include "object-name.h"
diff --git a/transport.c b/transport.c
index 7374cfd1fa9..8d3ad8022a4 100644
--- a/transport.c
+++ b/transport.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "advice.h"
 #include "alloc.h"
 #include "config.h"
diff --git a/walker.c b/walker.c
index cfbd257fdba..24ff7dfdc28 100644
--- a/walker.c
+++ b/walker.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "gettext.h"
 #include "hex.h"
 #include "walker.h"
-- 
2.40.0.172.g72fe1174621

