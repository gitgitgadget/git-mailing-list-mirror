Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBAE5C76196
	for <git@archiver.kernel.org>; Tue, 11 Apr 2023 07:43:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbjDKHnZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Apr 2023 03:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjDKHnC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2023 03:43:02 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F601FE2
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 00:42:33 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id q15-20020a17090a2dcf00b0023efab0e3bfso10048460pjm.3
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 00:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681198952; x=1683790952;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ulH8F8vA7uDqqi0915vQN9uQ9O/mXdJ+1O1ALPi678k=;
        b=Mr8ORIUrLspmxiRSaKG3FlYIKcL4/ZqGRtThYYP/1TS5kUa1aAb16f8anCkZVPMNFw
         oaI/ucl5GiIxhjTQGWR2E31ZvVKNru3/49KVvDbgrQrfUbQ1jr478qo+jsqy7s3DFpO2
         G09SqQzvlEyarisW8VMaVXA/1PQ040QY4KvwGY5v4+oVzMjYNaKAHV5PY2Tf5X8MiElF
         l9nYDL3YUkUiS9yibwPaMJVUgE1hQHmvt0lwMsf8LxQBkMr1LRy5/8mrqmha0FKPaIZU
         BqhstMwi9P+fqTMB3aXjA/fNdoiaaAORL1fJqmkSudmUB+z257an3mmNUfeGHXkXjZED
         VGXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681198952; x=1683790952;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ulH8F8vA7uDqqi0915vQN9uQ9O/mXdJ+1O1ALPi678k=;
        b=yD++QklUVbojLhChhttAzv98ptWIUipkExNVsM7VnSOC8xJ1m/MF+uH4iGdvFSydIy
         TwFoy6cluwInp5BvuDX8e5YL6WYq13s+qfu6iwd1/rlnTDg80jQ0jEnqrR8tuL06hUYl
         STZ5tlm27NGaVZ0ewzACkbKpvI8/75ePQTTMFMMmD8d3u0BbLyWSLdJ32NM0o01VlLqD
         JkTNTnk0CDGzKuAJ+9VY5PlOTrrMEVIm8Xc12WYJYp5Q8Yi3ZwUZLseMTgWt47tWYZs7
         rzxvJn/SLUFle9rm26DbMXPMkraNxinKWUn1sngm0xf5G5jKLL7YNB7+V4P0nWaPC+zK
         8eaQ==
X-Gm-Message-State: AAQBX9ewqb7dHfv9WKT9/HIpGs4ZATuwS1/uJxCRZje22lHTBI7DM8Ub
        CCnNUQ+zV2eMcv0/rM9R0t0OKUhDcTI=
X-Google-Smtp-Source: AKy350azhLK0snrxoSkc/bG8YL0+8UE1hOplYkEt99TuerOmpR4GcN/sEs3Gh6PizYKu676VS4TLiw==
X-Received: by 2002:a17:90a:5201:b0:23f:2486:5b53 with SMTP id v1-20020a17090a520100b0023f24865b53mr22853482pjh.17.1681198952084;
        Tue, 11 Apr 2023 00:42:32 -0700 (PDT)
Received: from iron-rod.hsd1.ca.comcast.net ([2601:646:9e80:a0b0::f6a9])
        by smtp.gmail.com with ESMTPSA id az4-20020a170902a58400b001a1deff606fsm8992820plb.125.2023.04.11.00.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 00:42:31 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Calvin Wan <calvinwan@google.com>
Subject: [PATCH v3 19/23] treewide: remove cache.h inclusion due to pager.h changes
Date:   Tue, 11 Apr 2023 00:42:00 -0700
Message-Id: <20230411074204.3024420-14-newren@gmail.com>
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
 column.c   | 2 +-
 editor.c   | 2 +-
 pager.c    | 2 +-
 pretty.c   | 2 +-
 progress.c | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/column.c b/column.c
index c89c90328a6..ff2f0abf399 100644
--- a/column.c
+++ b/column.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "config.h"
 #include "column.h"
 #include "string-list.h"
diff --git a/editor.c b/editor.c
index 7c796385493..b34e10606d2 100644
--- a/editor.c
+++ b/editor.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "abspath.h"
 #include "advice.h"
 #include "config.h"
diff --git a/pager.c b/pager.c
index be78c706644..63055d0873f 100644
--- a/pager.c
+++ b/pager.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "config.h"
 #include "editor.h"
 #include "pager.h"
diff --git a/pretty.c b/pretty.c
index c4671603b56..0bb938021ba 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "alloc.h"
 #include "config.h"
 #include "commit.h"
diff --git a/progress.c b/progress.c
index 96a8e36a52f..72d5e0c73c1 100644
--- a/progress.c
+++ b/progress.c
@@ -9,7 +9,7 @@
  */
 
 #define GIT_TEST_PROGRESS_ONLY
-#include "cache.h"
+#include "git-compat-util.h"
 #include "pager.h"
 #include "progress.h"
 #include "strbuf.h"
-- 
2.40.0.172.g72fe1174621

