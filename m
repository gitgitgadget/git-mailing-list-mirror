Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E812ECAAA1
	for <git@archiver.kernel.org>; Fri, 16 Sep 2022 19:03:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbiIPTDf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Sep 2022 15:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiIPTDe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Sep 2022 15:03:34 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7665A27FCF
        for <git@vger.kernel.org>; Fri, 16 Sep 2022 12:03:32 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id d12-20020a05600c3acc00b003b4c12e47f3so361351wms.4
        for <git@vger.kernel.org>; Fri, 16 Sep 2022 12:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date;
        bh=hbWClwNeuxl8gtJ9smVhLrTNIknG4c3RFaqF5gNbT0s=;
        b=kc+Xm0nNLdHm02UhxMIIcGTuvivcKgwz4CEHRUsGH9WSHFxLSil23A+1ZwgXXHn3CO
         vLBJFZ4yHMXD01OOqJaZ2djVlqCpZaoT0wpPswjrUEuMNv+tXFxHs6etJPb3oJXg0ZT5
         yLddVuNvVA4/lQ3PTYBfPYmsiCo3tMlyC55kswihujDOoYZtL2KNSxhUnMnMXftR+2Gq
         FrGqfkeBU9p7Jh8+7fvRf2B6NUHdAkSwoznQSy7pdOklHWspFlWq0+uK9tHh7hA3tFUG
         ZXjYZwJCWxQBgEwwsqd1Tl1N5AOoXHGt+LKuykYi2KFJF8B4KSb13L1hPqrE7klh+Cbm
         X3Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=hbWClwNeuxl8gtJ9smVhLrTNIknG4c3RFaqF5gNbT0s=;
        b=ZBXE3cRBy1sGTO8qCMA7zv3zEVOyxcXtblT6u8Sbz+UD5bjrGhJMVO2nw/5dD5HAHK
         QwbzXeA2V4CygOJLztnKO855YwfYvCT64GhMqVIvZtwJqVbQfbqUvFQSbVuS/llf6924
         QdhJPzALzVS8MMSwhdbyqFhFqK+q7XTL92caB3oF6Dc1SJflLWp/NoBaGqmBC4XrFLvB
         ZGza95ZTzOC0bhunGP3DSjarEtTANsb1V8O9IdydTK2I7OSItRwsi7eLci7L4+F9N3le
         3NOxozDAB4o2172pEHkak/iABO07T3Fam95qahUFhMUhtNhNqQGyKurzMoj4vXHxHQJE
         yTww==
X-Gm-Message-State: ACrzQf22MkRHG1E3+pR4BWXiCMtlBg7BIMzgcqa8iaYc78z2IYl6Q7Zo
        /zynYBUP2jhaa7f/l/rxGDxG7fpe3m4=
X-Google-Smtp-Source: AMsMyM5MTeyVMezMi7TwhyEbaJ5R59SBZ7iij5V/3Wocn4h//094LmrxYdEdlNHLsqdrQMZ6BlTKrQ==
X-Received: by 2002:a1c:4c18:0:b0:3b4:9b1d:5501 with SMTP id z24-20020a1c4c18000000b003b49b1d5501mr4327576wmf.13.1663355010552;
        Fri, 16 Sep 2022 12:03:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j16-20020a05600c191000b003a8434530bbsm3070197wmq.13.2022.09.16.12.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 12:03:30 -0700 (PDT)
Message-Id: <pull.1353.git.1663355009333.gitgitgadget@gmail.com>
From:   "Arthur Chan via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 16 Sep 2022 19:03:29 +0000
Subject: [PATCH] fuzz: reorganise the path for existing oss-fuzz fuzzers
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Arthur Chan <arthur.chan@adalogics.com>,
        Arthur Chan <arthur.chan@adalogics.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Arthur Chan <arthur.chan@adalogics.com>

This patch is aimed to provide a better organisation for oss-fuzz
fuzzers, allowing more fuzzers for the git project to be added
in a later development.

A new folder oss-fuzz has been created and existing fuzzers are
moved into the new folders. Makefile has been fixed accordingly.

CC: Josh Steadmon <steadmon@google.com>
CC: David Korczynski <david@adalogics.com>
Signed-off-by: Arthur Chan <arthur.chan@adalogics.com>
---
    fuzz: reorganise the path for existing oss-fuzz fuzzers
    
    This patch is aimed to provide a better organisation for oss-fuzz
    fuzzers, allowing more fuzzers for the git project to be added in a
    later development.
    
    A new folder oss-fuzz has been created and existing fuzzers are moved
    into the new folders. Makefile has been fixed accordingly.
    
    CC: Josh Steadmon steadmon@google.com CC: David Korczynski
    david@adalogics.com Signed-off-by: Arthur Chan arthur.chan@adalogics.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1353%2Farthurscchan%2Frelocate-fuzzer-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1353/arthurscchan/relocate-fuzzer-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1353

 Makefile                                            | 6 +++---
 fuzz-commit-graph.c => oss-fuzz/fuzz-commit-graph.c | 0
 fuzz-pack-headers.c => oss-fuzz/fuzz-pack-headers.c | 0
 fuzz-pack-idx.c => oss-fuzz/fuzz-pack-idx.c         | 0
 4 files changed, 3 insertions(+), 3 deletions(-)
 rename fuzz-commit-graph.c => oss-fuzz/fuzz-commit-graph.c (100%)
 rename fuzz-pack-headers.c => oss-fuzz/fuzz-pack-headers.c (100%)
 rename fuzz-pack-idx.c => oss-fuzz/fuzz-pack-idx.c (100%)

diff --git a/Makefile b/Makefile
index d9247ead45b..2d56aae7a1d 100644
--- a/Makefile
+++ b/Makefile
@@ -686,9 +686,9 @@ SCRIPTS = $(SCRIPT_SH_GEN) \
 
 ETAGS_TARGET = TAGS
 
-FUZZ_OBJS += fuzz-commit-graph.o
-FUZZ_OBJS += fuzz-pack-headers.o
-FUZZ_OBJS += fuzz-pack-idx.o
+FUZZ_OBJS += oss-fuzz/fuzz-commit-graph.o
+FUZZ_OBJS += oss-fuzz/fuzz-pack-headers.o
+FUZZ_OBJS += oss-fuzz/fuzz-pack-idx.o
 .PHONY: fuzz-objs
 fuzz-objs: $(FUZZ_OBJS)
 
diff --git a/fuzz-commit-graph.c b/oss-fuzz/fuzz-commit-graph.c
similarity index 100%
rename from fuzz-commit-graph.c
rename to oss-fuzz/fuzz-commit-graph.c
diff --git a/fuzz-pack-headers.c b/oss-fuzz/fuzz-pack-headers.c
similarity index 100%
rename from fuzz-pack-headers.c
rename to oss-fuzz/fuzz-pack-headers.c
diff --git a/fuzz-pack-idx.c b/oss-fuzz/fuzz-pack-idx.c
similarity index 100%
rename from fuzz-pack-idx.c
rename to oss-fuzz/fuzz-pack-idx.c

base-commit: d3fa443f97e3a8d75b51341e2d5bac380b7422df
-- 
gitgitgadget
