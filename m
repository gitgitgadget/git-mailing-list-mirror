Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07FFDC76196
	for <git@archiver.kernel.org>; Tue, 11 Apr 2023 07:42:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbjDKHmT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Apr 2023 03:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbjDKHmR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2023 03:42:17 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CEE9273D
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 00:42:11 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id o2so7039806plg.4
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 00:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681198930; x=1683790930;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mmEixFEbuFKg9g3y20MSsLUyDC88nhcrDNyrneW0yhM=;
        b=Qc8n0euejN+DeQjK5f+LpDhJdrvL4ylFr7jZ8wv11bIRhcr8nxw2g3P/bUOWuD0RRR
         VfRSsRirKbR7DRNM7RCUcDjMzfaQODQB3qRadRZPov+2BBrU6Pzjsbzyf9LfXW1Y74T2
         +ueq02kQzD31N4mEfz2IUCDlM9/o3692Fdek8m0DlymyVICT6O4dG8F/ulrOJLmJb942
         9i2BPmMow7Bnueuj7OneKvFmaQV/pVKqSG4S51ib/YRLCuz+aV6fULz+j1S4G9+YftUi
         mtperHC6hxY6EDAZmMvK5y6Uc+jg/6bM9OHecGxh7YkEN+Fu7DWtJO3yb6ChkxzDn1Ep
         rIZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681198930; x=1683790930;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mmEixFEbuFKg9g3y20MSsLUyDC88nhcrDNyrneW0yhM=;
        b=rCQk5vdByeoTIjU0Fxe6iFKl9KLRmJG3XjS8ovFP9li0du9MoUX6wvgvrGzIirHOWd
         S6OsJfU3ngfRNZMllp7JqdVxJdWjmRGAPY99Gh2DKsy7s/Vhu560m4Tv3NR/M5yzeo+f
         HYSgpZ/eooKhClD1GZAewAmeXJ+tROQoiW0byQA6U1SghwZBcbpaaUemOF1TqguBDE6K
         D/nCS9fVE0Lh1xJIKrB6hmJxyhrK4fUXFwKH4uJ0wtL+RqLmu8SRxx+RuKYrDv6qiccQ
         Sb3XqD/T15IVyT2AQR+k6bF7XyLjFqrHJXHohRyeHY77mxvoW5CYDqobzwP2oZUXsx6h
         z7SA==
X-Gm-Message-State: AAQBX9cSw2npnWHLlonOdHWPTHBWwchvpe/tAcfTUe4PsEUfWVPIv5jS
        K5RYJ8ry40Yk3EJDx1NjOhk9Nv7Ze4Y=
X-Google-Smtp-Source: AKy350ZItZpble1fDgNC9oP7AQQ4QhY8fEFoFpdUsVyXfCLtG+oiDK2fTh7re0PfCCJZqTslMBRSow==
X-Received: by 2002:a17:903:22ce:b0:1a0:f8ba:ae55 with SMTP id y14-20020a17090322ce00b001a0f8baae55mr20073990plg.7.1681198930366;
        Tue, 11 Apr 2023 00:42:10 -0700 (PDT)
Received: from iron-rod.hsd1.ca.comcast.net ([2601:646:9e80:a0b0::f6a9])
        by smtp.gmail.com with ESMTPSA id az4-20020a170902a58400b001a1deff606fsm8992820plb.125.2023.04.11.00.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 00:42:08 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Calvin Wan <calvinwan@google.com>
Subject: [PATCH v3 06/23] treewide: be explicit about dependence on mem-pool.h
Date:   Tue, 11 Apr 2023 00:41:47 -0700
Message-Id: <20230411074204.3024420-1-newren@gmail.com>
X-Mailer: git-send-email 2.40.0.172.g72fe1174621
In-Reply-To: <pull.1509.v3.git.1681182060.gitgitgadget@gmail.com>
References: <pull.1509.v3.git.1681182060.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Elijah Newren <newren@gmail.com>
Acked-by: Calvin Wan <calvinwan@google.com>
---
 builtin/checkout.c        | 1 +
 cache.h                   | 1 -
 merge-ort.c               | 1 +
 read-cache.c              | 1 +
 split-index.c             | 1 +
 t/helper/test-mergesort.c | 1 +
 6 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 422ea768404..65988fd8a3b 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -15,6 +15,7 @@
 #include "hook.h"
 #include "ll-merge.h"
 #include "lockfile.h"
+#include "mem-pool.h"
 #include "merge-recursive.h"
 #include "object-store.h"
 #include "parse-options.h"
diff --git a/cache.h b/cache.h
index 6eac3134a22..66705dd469e 100644
--- a/cache.h
+++ b/cache.h
@@ -13,7 +13,6 @@
 #include "object.h"
 #include "repository.h"
 #include "statinfo.h"
-#include "mem-pool.h"
 
 typedef struct git_zstream {
 	z_stream z;
diff --git a/merge-ort.c b/merge-ort.c
index 9b0b184b130..1008684fbbc 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -31,6 +31,7 @@
 #include "hex.h"
 #include "entry.h"
 #include "ll-merge.h"
+#include "mem-pool.h"
 #include "object-store.h"
 #include "oid-array.h"
 #include "promisor-remote.h"
diff --git a/read-cache.c b/read-cache.c
index 1b585ce8424..4ada6d62b90 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -21,6 +21,7 @@
 #include "blob.h"
 #include "environment.h"
 #include "gettext.h"
+#include "mem-pool.h"
 #include "resolve-undo.h"
 #include "run-command.h"
 #include "strbuf.h"
diff --git a/split-index.c b/split-index.c
index c98807c655b..5602b74994b 100644
--- a/split-index.c
+++ b/split-index.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "alloc.h"
 #include "gettext.h"
+#include "mem-pool.h"
 #include "split-index.h"
 #include "ewah/ewok.h"
 
diff --git a/t/helper/test-mergesort.c b/t/helper/test-mergesort.c
index 335e5bb3a90..737e0c52358 100644
--- a/t/helper/test-mergesort.c
+++ b/t/helper/test-mergesort.c
@@ -1,5 +1,6 @@
 #include "test-tool.h"
 #include "cache.h"
+#include "mem-pool.h"
 #include "mergesort.h"
 
 static uint32_t minstd_rand(uint32_t *state)
-- 
2.40.0.172.g72fe1174621

