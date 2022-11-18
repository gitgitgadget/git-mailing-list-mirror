Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E76B3C433FE
	for <git@archiver.kernel.org>; Fri, 18 Nov 2022 11:32:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241421AbiKRLb7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Nov 2022 06:31:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241289AbiKRLbZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Nov 2022 06:31:25 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD4C07CBAD
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 03:31:20 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id 21so6748808edv.3
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 03:31:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s7oUFbTPpCmpzbnthtCoPnebCDpAPz4MVBPABkih+cU=;
        b=Bai4jWtyELCLvb3SAtZ3lWMJpu48f/QVL0s6ttHAUIUZSyHfY/lHvIGyAPgPpaqiNv
         wc5Rq8P9BBdv8Wb8WZmg4ZwKfgFSOs2pGKpPmRKRurv4MMrUdVph4A4tDob/cTa9wgiC
         GtjbKozhSgN7Wh0oVEzeLL9fzwCFG3Aw+T8sR7GWvl4ESpISiEyG0nXt47sZa/vjCYLH
         rlMHkMEyG8C9E5Tf44Wd2MuXDX9Cec2MEA2SNEmMS//ChxA6wpI5YJAsrLAXDxTxINht
         FXyqcZF4ZsQY9kuuQcDJRjSPPDuzc5n9IhYOJHAuajHa8eQVhq5j5Lij4+RqoZrSzix6
         kUVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s7oUFbTPpCmpzbnthtCoPnebCDpAPz4MVBPABkih+cU=;
        b=GoZ9xlEgGPbAFJNsGJe3ajk4VBqRLHOZisaA7gkug6LeHydxMsO0HUaDLO7KB/5ZFa
         Jw7Yq85HkqUYD5Oh2kAzOWg5f02Ol0TSFaG+qeUdp4jJATJMZ+TJjqCmDcYHf8lDQIkB
         4OofAgPqyNt4bH1sDKfTZ8DT/VTJlE2fytc1SrcYlpWfqAUMU9ShlaNOxb12y62MSEQj
         Uk1z1MxWr8r/vDW5Iu+1nV7s2F5ojI5g1wAdWc+sMn+U9oI7dOuByqEIcADILvbww15O
         JpqFodkRSIQc7lhwsw0X3IaA/ZZ3KUVhRpmCou38tRkitTYpJ7H8j94+WSlThGEFzb1T
         g7FQ==
X-Gm-Message-State: ANoB5pnCw0khruc1/2Sjdjqo7D0rrIfFB/NtRjVIrCQ4tsgZ9OiQEFux
        IfPOpGRYna1+f7E0lgzIMJfWeJ6TgH7kAA==
X-Google-Smtp-Source: AA0mqf7+F1EDxdg3nfYqWPBa1iJnN7Pks7uVpQ7Qdtk7KMjdMLOl9q8YFFQhKNmeD6mSKbxlHG2t7A==
X-Received: by 2002:a05:6402:707:b0:467:6035:285c with SMTP id w7-20020a056402070700b004676035285cmr5769190edx.386.1668771079886;
        Fri, 18 Nov 2022 03:31:19 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id cw24-20020a056402229800b0046730154ccbsm1713302edb.42.2022.11.18.03.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 03:31:19 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 12/12] builtin/*: remove or amend "USE_THE_INDEX_COMPATIBILITY_MACROS"
Date:   Fri, 18 Nov 2022 12:31:06 +0100
Message-Id: <patch-12.12-b69cf6d7600-20221118T112205Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1511.gcdcff1f1dc2
In-Reply-To: <cover-00.12-00000000000-20221118T112205Z-avarab@gmail.com>
References: <cover-00.12-00000000000-20221118T112205Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Follow-up the preceding commit and change
"USE_THE_INDEX_COMPATIBILITY_MACROS" to the more narrow
"USE_THE_INDEX_VARIABLE" in cases where we still use "the_index".

Then remove "USE_THE_INDEX_VARIABLE" entirely in the few cases where
we don't require any compatibility macros or variables anymore.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/add.c            | 2 +-
 builtin/check-attr.c     | 2 +-
 builtin/check-ignore.c   | 2 +-
 builtin/checkout-index.c | 2 +-
 builtin/clean.c          | 2 +-
 builtin/clone.c          | 2 +-
 builtin/describe.c       | 2 +-
 builtin/diff-files.c     | 1 -
 builtin/diff-index.c     | 1 -
 builtin/diff-tree.c      | 2 +-
 builtin/fsck.c           | 2 +-
 builtin/merge-index.c    | 2 +-
 builtin/merge-ours.c     | 1 -
 builtin/rebase.c         | 2 +-
 builtin/reset.c          | 2 +-
 builtin/rev-parse.c      | 2 +-
 16 files changed, 13 insertions(+), 16 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 566c27e5311..76277df326b 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -3,7 +3,7 @@
  *
  * Copyright (C) 2006 Linus Torvalds
  */
-#define USE_THE_INDEX_COMPATIBILITY_MACROS
+#define USE_THE_INDEX_VARIABLE
 #include "cache.h"
 #include "config.h"
 #include "builtin.h"
diff --git a/builtin/check-attr.c b/builtin/check-attr.c
index 2b9271f816c..0fef10eb6bc 100644
--- a/builtin/check-attr.c
+++ b/builtin/check-attr.c
@@ -1,4 +1,4 @@
-#define USE_THE_INDEX_COMPATIBILITY_MACROS
+#define USE_THE_INDEX_VARIABLE
 #include "builtin.h"
 #include "cache.h"
 #include "config.h"
diff --git a/builtin/check-ignore.c b/builtin/check-ignore.c
index 6ebd0169fc8..ab776061c7c 100644
--- a/builtin/check-ignore.c
+++ b/builtin/check-ignore.c
@@ -1,4 +1,4 @@
-#define USE_THE_INDEX_COMPATIBILITY_MACROS
+#define USE_THE_INDEX_VARIABLE
 #include "builtin.h"
 #include "cache.h"
 #include "config.h"
diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
index 9087005b4fb..cf6fba97ba7 100644
--- a/builtin/checkout-index.c
+++ b/builtin/checkout-index.c
@@ -4,7 +4,7 @@
  * Copyright (C) 2005 Linus Torvalds
  *
  */
-#define USE_THE_INDEX_COMPATIBILITY_MACROS
+#define USE_THE_INDEX_VARIABLE
 #include "builtin.h"
 #include "config.h"
 #include "dir.h"
diff --git a/builtin/clean.c b/builtin/clean.c
index 7bdeb01d30e..b2701a28158 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -6,7 +6,7 @@
  * Based on git-clean.sh by Pavel Roskin
  */
 
-#define USE_THE_INDEX_COMPATIBILITY_MACROS
+#define USE_THE_INDEX_VARIABLE
 #include "builtin.h"
 #include "cache.h"
 #include "config.h"
diff --git a/builtin/clone.c b/builtin/clone.c
index 8ab0453a292..f518bb2dc1f 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -8,7 +8,7 @@
  * Clone a repository into a different directory that does not yet exist.
  */
 
-#define USE_THE_INDEX_COMPATIBILITY_MACROS
+#define USE_THE_INDEX_VARIABLE
 #include "builtin.h"
 #include "config.h"
 #include "lockfile.h"
diff --git a/builtin/describe.c b/builtin/describe.c
index 4f4a58eef2b..eea1e330c00 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -1,4 +1,4 @@
-#define USE_THE_INDEX_COMPATIBILITY_MACROS
+#define USE_THE_INDEX_VARIABLE
 #include "cache.h"
 #include "config.h"
 #include "lockfile.h"
diff --git a/builtin/diff-files.c b/builtin/diff-files.c
index 1f3deb13c28..b1e1cef7a76 100644
--- a/builtin/diff-files.c
+++ b/builtin/diff-files.c
@@ -3,7 +3,6 @@
  *
  * Copyright (C) Linus Torvalds, 2005
  */
-#define USE_THE_INDEX_COMPATIBILITY_MACROS
 #include "cache.h"
 #include "config.h"
 #include "diff.h"
diff --git a/builtin/diff-index.c b/builtin/diff-index.c
index a178e774a5a..91ad56af177 100644
--- a/builtin/diff-index.c
+++ b/builtin/diff-index.c
@@ -1,4 +1,3 @@
-#define USE_THE_INDEX_COMPATIBILITY_MACROS
 #include "cache.h"
 #include "config.h"
 #include "diff.h"
diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
index a724087261d..25b853b85ca 100644
--- a/builtin/diff-tree.c
+++ b/builtin/diff-tree.c
@@ -1,4 +1,4 @@
-#define USE_THE_INDEX_COMPATIBILITY_MACROS
+#define USE_THE_INDEX_VARIABLE
 #include "cache.h"
 #include "config.h"
 #include "diff.h"
diff --git a/builtin/fsck.c b/builtin/fsck.c
index d6f9a31e216..d207bd909b4 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -1,4 +1,4 @@
-#define USE_THE_INDEX_COMPATIBILITY_MACROS
+#define USE_THE_INDEX_VARIABLE
 #include "builtin.h"
 #include "cache.h"
 #include "repository.h"
diff --git a/builtin/merge-index.c b/builtin/merge-index.c
index b1d98294cdd..452f833ac46 100644
--- a/builtin/merge-index.c
+++ b/builtin/merge-index.c
@@ -1,4 +1,4 @@
-#define USE_THE_INDEX_COMPATIBILITY_MACROS
+#define USE_THE_INDEX_VARIABLE
 #include "builtin.h"
 #include "run-command.h"
 
diff --git a/builtin/merge-ours.c b/builtin/merge-ours.c
index 5d95acf52a6..284eb486098 100644
--- a/builtin/merge-ours.c
+++ b/builtin/merge-ours.c
@@ -7,7 +7,6 @@
  *
  * Pretend we resolved the heads, but declare our tree trumps everybody else.
  */
-#define USE_THE_INDEX_COMPATIBILITY_MACROS
 #include "git-compat-util.h"
 #include "builtin.h"
 #include "diff.h"
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 345a55755a3..1384008fe09 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -4,7 +4,7 @@
  * Copyright (c) 2018 Pratik Karki
  */
 
-#define USE_THE_INDEX_COMPATIBILITY_MACROS
+#define USE_THE_INDEX_VARIABLE
 #include "builtin.h"
 #include "run-command.h"
 #include "exec-cmd.h"
diff --git a/builtin/reset.c b/builtin/reset.c
index 5ab03e9616a..52a1a9bd513 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -7,7 +7,7 @@
  *
  * Copyright (c) 2005, 2006 Linus Torvalds and Junio C Hamano
  */
-#define USE_THE_INDEX_COMPATIBILITY_MACROS
+#define USE_THE_INDEX_VARIABLE
 #include "builtin.h"
 #include "config.h"
 #include "lockfile.h"
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index bffdd27bd7e..d4c81352a65 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -3,7 +3,7 @@
  *
  * Copyright (C) Linus Torvalds, 2005
  */
-#define USE_THE_INDEX_COMPATIBILITY_MACROS
+#define USE_THE_INDEX_VARIABLE
 #include "cache.h"
 #include "config.h"
 #include "commit.h"
-- 
2.38.0.1511.gcdcff1f1dc2

