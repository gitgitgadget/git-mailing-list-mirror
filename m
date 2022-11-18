Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE20C4332F
	for <git@archiver.kernel.org>; Fri, 18 Nov 2022 11:31:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241264AbiKRLbn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Nov 2022 06:31:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241003AbiKRLbY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Nov 2022 06:31:24 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9DD58B105
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 03:31:19 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id vv4so3012477ejc.2
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 03:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uVO3+nb6Prw1qa0n9IxJipJLKX8D/a5FRScjGUOWryY=;
        b=KjmopkCX3UA0eGrykeGUEkFiaGs7PvwqGX5JyZZJLANaAqiOTwgIL/4dkm/G3FL77R
         ZZhUFqeim6WK7OmP4JwYV1MOsqqwEXBGviP2SA4USCzLi7GnVurCFwEYcOIy3L0GPCv9
         6HMa6nf9/wWAvn8Qj6vkZyl/rUxo5eNVssLKi6eGeqEStZrnkQqZ8OeCc9AG9agieFti
         e8LyH4ScZTooJgodKAb/fOX+AsrYLJUiZ+Bvz6kSP8Q2Pl3fr1sJo6MuHRjbsbFixefL
         4XQ19bdW1c8bJjgmTrvwe1dQsdVUrzK7a7HRoT/KAi2xTHvmwYwmdZQ6MYcpm+jHAvKb
         /8nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uVO3+nb6Prw1qa0n9IxJipJLKX8D/a5FRScjGUOWryY=;
        b=56HzwjMnbLoTDIE2DEUsha+fc3tGlrlzRtPKdKkWveBM5vkYqZOGpQhiWfZrMKmtcW
         JfjwR/j3AF6Xl3cvUU7R3qh9Uz9d6kT/L9PQg3mxo8gj1yQt4R7RStptryzf+ywheTwA
         1vrY+Lif9Ab6gNZyv5f9mlkrjuYRmXTzn6v1AeHVz9c6rSUr62nGR1hdUeZO2G9hZftT
         ILidvuKm+TfEgoBYuEowolrOUj6HMNtHsXT866Deshh/4/cV22w2eGNOZlLwsrJ1MK0K
         TgLIhv/Cdoej0SezeeU2v+yg8Gh2X65Fq6JVtRNdL/wG+dsqshjSjmiQMXk186l5hT8B
         EeBg==
X-Gm-Message-State: ANoB5pmu/7IHcvi5/l2mh3nFTPDVMDODwUOZoEfEWynn34qBwoxihB1s
        RQTEUYbNF4claQ5n2I0opRgCoFUOoOBsPg==
X-Google-Smtp-Source: AA0mqf5esevsaPxAPhq0XDp+u4UXalorUaKNy5KOiudHbJXGx/FbsUq2kRFPJN2s98Lspm9aZYrysQ==
X-Received: by 2002:a17:907:b60f:b0:787:8884:78df with SMTP id vl15-20020a170907b60f00b00787888478dfmr5481830ejc.246.1668771078016;
        Fri, 18 Nov 2022 03:31:18 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id cw24-20020a056402229800b0046730154ccbsm1713302edb.42.2022.11.18.03.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 03:31:17 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 10/12] cache.h & test-tool.h: add & use "USE_THE_INDEX_VARIABLE"
Date:   Fri, 18 Nov 2022 12:31:04 +0100
Message-Id: <patch-10.12-9eda7916e75-20221118T112205Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1511.gcdcff1f1dc2
In-Reply-To: <cover-00.12-00000000000-20221118T112205Z-avarab@gmail.com>
References: <cover-00.12-00000000000-20221118T112205Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a preceding commit we fully applied the
"index-compatibility.pending.cocci" rule to "t/helper/*". Let's now
stop defining "USE_THE_INDEX_COMPATIBILITY_MACROS" in test-tool.h
itself, and instead instead move the define to the individual test
helpers that need it. This mirrors how we do the same thing in the
"builtin/" directory.

We could start using "USE_THE_INDEX_COMPATIBILITY_MACROS", but let's
instead introduce a narrow version of it named
"USE_THE_INDEX_VARIABLE". As the name suggests this doesn't give us
any of the compatibility macros, but only "the_index" variable.

Eventually we'll move other outstanding users of
"USE_THE_INDEX_COMPATIBILITY_MACROS" over to using this more narrow
and descriptive define.

For context: The USE_THE_INDEX_COMPATIBILITY_MACROS macro was added to
test-tool.h in f8adbec9fea (cache.h: flip
NO_THE_INDEX_COMPATIBILITY_MACROS switch, 2019-01-24).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/helper/test-dump-cache-tree.c      | 1 +
 t/helper/test-dump-split-index.c     | 1 +
 t/helper/test-dump-untracked-cache.c | 2 +-
 t/helper/test-fast-rebase.c          | 2 +-
 t/helper/test-lazy-init-name-hash.c  | 1 +
 t/helper/test-read-cache.c           | 1 +
 t/helper/test-scrap-cache-tree.c     | 1 +
 t/helper/test-write-cache.c          | 1 +
 8 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/t/helper/test-dump-cache-tree.c b/t/helper/test-dump-cache-tree.c
index 4bf8bc3df6e..454f17b1a0c 100644
--- a/t/helper/test-dump-cache-tree.c
+++ b/t/helper/test-dump-cache-tree.c
@@ -1,3 +1,4 @@
+#define USE_THE_INDEX_VARIABLE
 #include "test-tool.h"
 #include "cache.h"
 #include "tree.h"
diff --git a/t/helper/test-dump-split-index.c b/t/helper/test-dump-split-index.c
index a209880eb37..0ea97b84072 100644
--- a/t/helper/test-dump-split-index.c
+++ b/t/helper/test-dump-split-index.c
@@ -1,3 +1,4 @@
+#define USE_THE_INDEX_VARIABLE
 #include "test-tool.h"
 #include "cache.h"
 #include "split-index.h"
diff --git a/t/helper/test-dump-untracked-cache.c b/t/helper/test-dump-untracked-cache.c
index ffe34736e53..6d53683f13b 100644
--- a/t/helper/test-dump-untracked-cache.c
+++ b/t/helper/test-dump-untracked-cache.c
@@ -1,4 +1,4 @@
-#define USE_THE_INDEX_COMPATIBILITY_MACROS
+#define USE_THE_INDEX_VARIABLE
 #include "test-tool.h"
 #include "cache.h"
 #include "dir.h"
diff --git a/t/helper/test-fast-rebase.c b/t/helper/test-fast-rebase.c
index 9def2ba6889..efc82dd80c5 100644
--- a/t/helper/test-fast-rebase.c
+++ b/t/helper/test-fast-rebase.c
@@ -10,7 +10,7 @@
  * refactoring is the better route).
  */
 
-#define USE_THE_INDEX_COMPATIBILITY_MACROS
+#define USE_THE_INDEX_VARIABLE
 #include "test-tool.h"
 
 #include "cache-tree.h"
diff --git a/t/helper/test-lazy-init-name-hash.c b/t/helper/test-lazy-init-name-hash.c
index 7e8723a1900..ab86c14c8ba 100644
--- a/t/helper/test-lazy-init-name-hash.c
+++ b/t/helper/test-lazy-init-name-hash.c
@@ -1,3 +1,4 @@
+#define USE_THE_INDEX_VARIABLE
 #include "test-tool.h"
 #include "cache.h"
 #include "parse-options.h"
diff --git a/t/helper/test-read-cache.c b/t/helper/test-read-cache.c
index a089be9104c..23e9e27109f 100644
--- a/t/helper/test-read-cache.c
+++ b/t/helper/test-read-cache.c
@@ -1,3 +1,4 @@
+#define USE_THE_INDEX_VARIABLE
 #include "test-tool.h"
 #include "cache.h"
 #include "config.h"
diff --git a/t/helper/test-scrap-cache-tree.c b/t/helper/test-scrap-cache-tree.c
index 9206dee1fd2..a26107ed70a 100644
--- a/t/helper/test-scrap-cache-tree.c
+++ b/t/helper/test-scrap-cache-tree.c
@@ -1,3 +1,4 @@
+#define USE_THE_INDEX_VARIABLE
 #include "test-tool.h"
 #include "cache.h"
 #include "lockfile.h"
diff --git a/t/helper/test-write-cache.c b/t/helper/test-write-cache.c
index 66287d6d47d..7d45cd61e82 100644
--- a/t/helper/test-write-cache.c
+++ b/t/helper/test-write-cache.c
@@ -1,3 +1,4 @@
+#define USE_THE_INDEX_VARIABLE
 #include "test-tool.h"
 #include "cache.h"
 #include "lockfile.h"
-- 
2.38.0.1511.gcdcff1f1dc2

