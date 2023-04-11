Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 642A2C77B6F
	for <git@archiver.kernel.org>; Tue, 11 Apr 2023 07:42:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbjDKHm2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Apr 2023 03:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbjDKHmZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2023 03:42:25 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E83335A4
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 00:42:16 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id v9so12494242pjk.0
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 00:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681198935; x=1683790935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1RbE2UzR0ldqu0QbXLLgo+FCyV0D7un6NmVcroZBqEc=;
        b=Lu5udcUHl3npRs6tbNSxQ7bAVzkZNAw4oaYnou0Fiuq58bdJR0WDKg2DxYtp06H2fM
         HdkEBaXl5k1OMx6SsPeNqCCsidsokBhFwTfRTgCz2fQFlHKoQUG69phH+8FYMPZ+kkPP
         B+Qsg0NcSneEv4xDbvWsEl4x/CmnNSzAZFVYRmWGec18DwHxy+ZQgHgVpQj0+O+LapFP
         TYKN5Kz+PugerAmlF1rdEUo5097nKsBV5DvU37nLig8+sIojqCmZQfrFgLU5wOT5OdgM
         8P1ldqRKSMoQPXOaIlTJI2B6CvhjE3ggNvziqfMHXJ7yGUbqgZffwxV4evhjTVso0/e8
         kdtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681198935; x=1683790935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1RbE2UzR0ldqu0QbXLLgo+FCyV0D7un6NmVcroZBqEc=;
        b=SBGEFtLftIy3Qio62Mz4AEJPA3pVlw/KV28e0EIIhmf6Xo0BUhHtnl0zVyGv/M8kEy
         IixtmVPs2KwoJH6kFmb16DyC6nQ3wg7mX3VoxK2+0DqArf3bwj/2/lebJJ1vv025VSMv
         0mE3aUo7QkLysPPqzZpN51FdWdYWDmGlmoqq3ObgpbK0btceP0ZNY6083jTB4V8x/pzv
         XwrB7Jady/WPlK7VWlkKQFKXRG6N5Hjk4GziW3Yfkr+EjwT/hA44xDz2bqsHXX+P8Nj6
         OD/fREw5W8u974pwMI6+u8KG4Bw2zA58G9ccM8Kgu9Kj0PBnaQurmM4E7BH9k4/A95oD
         kq6A==
X-Gm-Message-State: AAQBX9d78Rku29urDQKP+Axzkece3xh89FYCpXATwDc2END+DL7oZv/f
        1yINaXIc1B1Co6xn287YkTVj2pOrQeU=
X-Google-Smtp-Source: AKy350YprZdwKKv+NkCzdoiI+RsEySf4iN78pk+TBvZAsD3rSe1lJko8sgziUrYnvu8p6SoMm6EAqQ==
X-Received: by 2002:a17:902:d481:b0:19e:ab29:1ec2 with SMTP id c1-20020a170902d48100b0019eab291ec2mr18022317plg.65.1681198935266;
        Tue, 11 Apr 2023 00:42:15 -0700 (PDT)
Received: from iron-rod.hsd1.ca.comcast.net ([2601:646:9e80:a0b0::f6a9])
        by smtp.gmail.com with ESMTPSA id az4-20020a170902a58400b001a1deff606fsm8992820plb.125.2023.04.11.00.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 00:42:14 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Calvin Wan <calvinwan@google.com>
Subject: [PATCH v3 09/23] treewide: remove cache.h inclusion due to object-name.h changes
Date:   Tue, 11 Apr 2023 00:41:50 -0700
Message-Id: <20230411074204.3024420-4-newren@gmail.com>
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
 branch.c                         | 1 -
 checkout.c                       | 3 ++-
 fmt-merge-msg.c                  | 2 +-
 mailmap.c                        | 2 +-
 notes.c                          | 2 +-
 refs.c                           | 2 +-
 remote.c                         | 2 +-
 setup.c                          | 2 +-
 strbuf.c                         | 2 +-
 t/helper/test-oidmap.c           | 1 -
 t/helper/test-reach.c            | 1 -
 t/helper/test-submodule-config.c | 1 -
 transport-helper.c               | 2 +-
 13 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/branch.c b/branch.c
index f29743b1619..7df982693af 100644
--- a/branch.c
+++ b/branch.c
@@ -1,5 +1,4 @@
 #include "git-compat-util.h"
-#include "cache.h"
 #include "advice.h"
 #include "config.h"
 #include "branch.h"
diff --git a/checkout.c b/checkout.c
index 9235073fc0d..04238b27133 100644
--- a/checkout.c
+++ b/checkout.c
@@ -1,9 +1,10 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "object-name.h"
 #include "remote.h"
 #include "refspec.h"
 #include "checkout.h"
 #include "config.h"
+#include "strbuf.h"
 
 struct tracking_name_data {
 	/* const */ char *src_ref;
diff --git a/fmt-merge-msg.c b/fmt-merge-msg.c
index 21019c932b3..5af0d4715ba 100644
--- a/fmt-merge-msg.c
+++ b/fmt-merge-msg.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "alloc.h"
 #include "config.h"
 #include "environment.h"
diff --git a/mailmap.c b/mailmap.c
index d62d7bf0e7f..28d389c1f94 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "environment.h"
 #include "string-list.h"
 #include "mailmap.h"
diff --git a/notes.c b/notes.c
index c07bcbe3486..02f1aa39ae1 100644
--- a/notes.c
+++ b/notes.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "config.h"
 #include "environment.h"
 #include "hex.h"
diff --git a/refs.c b/refs.c
index 979ed3fbedc..d2a98e1c21f 100644
--- a/refs.c
+++ b/refs.c
@@ -2,7 +2,7 @@
  * The backend-independent part of the reference module.
  */
 
-#include "cache.h"
+#include "git-compat-util.h"
 #include "advice.h"
 #include "alloc.h"
 #include "config.h"
diff --git a/remote.c b/remote.c
index 3afedce593e..2947743d60a 100644
--- a/remote.c
+++ b/remote.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "abspath.h"
 #include "alloc.h"
 #include "config.h"
diff --git a/setup.c b/setup.c
index 8a297b3cb5c..a546da755f1 100644
--- a/setup.c
+++ b/setup.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "abspath.h"
 #include "environment.h"
 #include "gettext.h"
diff --git a/strbuf.c b/strbuf.c
index 1b93d9d3c47..b2e3735ba8a 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "abspath.h"
 #include "alloc.h"
 #include "environment.h"
diff --git a/t/helper/test-oidmap.c b/t/helper/test-oidmap.c
index bf4fcfe6efb..de6ab77fdaa 100644
--- a/t/helper/test-oidmap.c
+++ b/t/helper/test-oidmap.c
@@ -1,5 +1,4 @@
 #include "test-tool.h"
-#include "cache.h"
 #include "hex.h"
 #include "object-name.h"
 #include "oidmap.h"
diff --git a/t/helper/test-reach.c b/t/helper/test-reach.c
index d4fa33ae751..5b6f2174418 100644
--- a/t/helper/test-reach.c
+++ b/t/helper/test-reach.c
@@ -1,5 +1,4 @@
 #include "test-tool.h"
-#include "cache.h"
 #include "alloc.h"
 #include "commit.h"
 #include "commit-reach.h"
diff --git a/t/helper/test-submodule-config.c b/t/helper/test-submodule-config.c
index 4758c8654e0..c7c7fdbea98 100644
--- a/t/helper/test-submodule-config.c
+++ b/t/helper/test-submodule-config.c
@@ -1,5 +1,4 @@
 #include "test-tool.h"
-#include "cache.h"
 #include "config.h"
 #include "object-name.h"
 #include "setup.h"
diff --git a/transport-helper.c b/transport-helper.c
index ca8bec04bb3..6b816940dc6 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "transport.h"
 #include "quote.h"
 #include "run-command.h"
-- 
2.40.0.172.g72fe1174621

