Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F55FC4332F
	for <git@archiver.kernel.org>; Sat, 19 Nov 2022 13:08:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234050AbiKSNI0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Nov 2022 08:08:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233825AbiKSNH7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Nov 2022 08:07:59 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1ED69153A
        for <git@vger.kernel.org>; Sat, 19 Nov 2022 05:07:57 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id ft34so19058749ejc.12
        for <git@vger.kernel.org>; Sat, 19 Nov 2022 05:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MtvP4qPfs8r+Zht5icBsvyXCpJqLFu6gS7Cjmz0n1yM=;
        b=DMpm1xU6FAgUdsDB4IF+0y9r1EqHA+X9S9Nj6wTiwkRAunrPo34WcKfYj7JPQa2Pxt
         upX6mF37iTideVDbLPWBzZ4SteZl7iGcEbOTUdAJ7KVjZY/J2lfkJMBVLqSi7S0j9trc
         b7SqgUW1ef03whNIkQteEt2zlY7xuyHAUa8gfdV6pNPwzvYJ7LJA87NJpiX02YUo1pY9
         hRBD5+//b/F2fY8U0XPIfwl8v8UObsaPPBKTX6Y50omEblxDO9b15esgNXQzUlgUiChg
         oywbfCdxJYAQDyZPOpojCBaMZov3qluOHs+WbohwX2X0Xqc+VTfS+DYxTpVy9nMCvXeL
         dRwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MtvP4qPfs8r+Zht5icBsvyXCpJqLFu6gS7Cjmz0n1yM=;
        b=cBRp82lvd9ik0FCwEeprKmbmZ6Hf6i1V9/MizX/tjn7b+T7m9fa6txRAgrTAjEptW+
         IxmK7q2OmRw8u8/3JuDPmv7Rbs/XSjwtKVa4yV9XaMCyIhAxiEeu8xilxZHi6Qs/8kG/
         JPYbMn6ISJu5deM/S1Dxn6jhlnmsqcd5/f2q3Kc4s5ddIHe4PMEA9fyuroj0JpY3pQk2
         37Qfe9cvIxGGez1UqWfV82JstElkzn08P1mCN0LWRnyISdfbjeRdUZwc5VXgHq+VZirh
         O7+YPln0Jl7NSPBVFraXgspNKflYwTBQOvraKxbFIEC5/88VvlT3zEsfX/u9MnCYVNyM
         jG1A==
X-Gm-Message-State: ANoB5pn8X4yQKIK+Tmv3wJTG1QA2vbQYYX14/2IZcIt/SsaDexcfhVua
        1zTj5q2h481EavNCedSzA5HX/oWVYrrhzQ==
X-Google-Smtp-Source: AA0mqf4WH+e5me/uMRzMV94SZRC0p8zse5m3m1kzQHXWNnZpGYOn5+ZRLY99gyOykZF6QHI96b9WyA==
X-Received: by 2002:a17:906:b794:b0:7ae:6450:c620 with SMTP id dt20-20020a170906b79400b007ae6450c620mr9387260ejb.270.1668863276202;
        Sat, 19 Nov 2022 05:07:56 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id ch28-20020a0564021bdc00b0045d74aa401fsm2923802edb.60.2022.11.19.05.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Nov 2022 05:07:55 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 10/11] cache.h & test-tool.h: add & use "USE_THE_INDEX_VARIABLE"
Date:   Sat, 19 Nov 2022 14:07:37 +0100
Message-Id: <patch-v2-10.11-5456859b244-20221119T125551Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1509.g9445af83948
In-Reply-To: <cover-v2-00.11-00000000000-20221119T125550Z-avarab@gmail.com>
References: <cover-00.12-00000000000-20221118T112205Z-avarab@gmail.com> <cover-v2-00.11-00000000000-20221119T125550Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a preceding commit we fully applied the
"index-compatibility.pending.cocci" rule to "t/helper/*".

Let's now stop defining "USE_THE_INDEX_COMPATIBILITY_MACROS" in
test-tool.h itself, and instead instead define
"USE_THE_INDEX_VARIABLE" in the individual test helpers that need
it. This mirrors how we do the same thing in the "builtin/" directory.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/helper/test-cache-tree.c           | 1 +
 t/helper/test-dump-cache-tree.c      | 1 +
 t/helper/test-dump-split-index.c     | 1 +
 t/helper/test-dump-untracked-cache.c | 2 +-
 t/helper/test-fast-rebase.c          | 2 +-
 t/helper/test-lazy-init-name-hash.c  | 1 +
 t/helper/test-read-cache.c           | 1 +
 t/helper/test-scrap-cache-tree.c     | 1 +
 t/helper/test-tool.h                 | 1 -
 t/helper/test-write-cache.c          | 1 +
 10 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/t/helper/test-cache-tree.c b/t/helper/test-cache-tree.c
index 5514afdfe7a..9159a173015 100644
--- a/t/helper/test-cache-tree.c
+++ b/t/helper/test-cache-tree.c
@@ -1,3 +1,4 @@
+#define USE_THE_INDEX_VARIABLE
 #include "test-tool.h"
 #include "cache.h"
 #include "tree.h"
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
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index da7cd6351a6..2e20a16eb82 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -1,7 +1,6 @@
 #ifndef TEST_TOOL_H
 #define TEST_TOOL_H
 
-#define USE_THE_INDEX_COMPATIBILITY_MACROS
 #include "git-compat-util.h"
 
 int cmd__advise_if_enabled(int argc, const char **argv);
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
2.38.0.1509.g9445af83948

