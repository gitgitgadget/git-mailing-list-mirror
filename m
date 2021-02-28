Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F6BAC433DB
	for <git@archiver.kernel.org>; Sun, 28 Feb 2021 12:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DC5864E59
	for <git@archiver.kernel.org>; Sun, 28 Feb 2021 12:23:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbhB1MXY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Feb 2021 07:23:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbhB1MXX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Feb 2021 07:23:23 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CFC1C06174A
        for <git@vger.kernel.org>; Sun, 28 Feb 2021 04:22:43 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id m1so11859838wml.2
        for <git@vger.kernel.org>; Sun, 28 Feb 2021 04:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=LAYS2k1+Y536xb9/Os3wXtbFbZbJ0i4LeF6elZ1GEYI=;
        b=dcKwg/jeArsgNq3WYmmQ3w2G22aMrfJB5PYizXbXjEa0lnuZtliHCAyUZX8pudFYb7
         nBGvMRlPfrZ4FeIpgUJ1tbHierfnqtd+2e3GJ0M2FNTkk1+HBNf7V1kfgRZ3zlk7Pf/a
         DFt0xyTIyogqm5ZeCSZG+uE6XbmtqHWeHHP9t8BYQeFajC8TDQf2aWHN0g+jdKtEy38l
         hfddAlH4NTQ9Gc0gy8N6eXoBrIjhdZd49kBV7oa4VYrVCnT1Zr56fPgYZwxKM4PPYOTy
         xnQQ2zkPmO6Z5ZjIsHFJkelqNAT3JLYDniSBIA6hpiHD6EDSnSWt4uWy7F/Fh2ymVclY
         fkbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=LAYS2k1+Y536xb9/Os3wXtbFbZbJ0i4LeF6elZ1GEYI=;
        b=cZCLHRYv9saiYbg94JF1hVmo76yWFQ98YRmV/40EhWP+hN2QkOhDQt262mJPQcfxuG
         Fps0CLXhnNMBfeJu2ssbrQV98QikwbUNIZTpQqutng9qySvvuz8Vzqh5bQwTtPuKmrRg
         viQGf+Cwvrua+1b1wzZYzuNQ4+OfExSAd5ewvviPxljnzjG4OR/jEg01R5GCLCtj5MOk
         mEVlJTlUJFe8k9RVSRqLq9zWlFaC9YxwmRgKhF1IRdP6OvwsvJfkoABPBTKGRhBjLmAp
         l1Btq6O6GL/tb79e/aFISr0a2d5GTCGxYyeungBj6U0emTmbXyGL3yCn+DEZ660EMA5a
         50ZA==
X-Gm-Message-State: AOAM530Yu5o71WeEahHRgd+UeVMz69zG/g9ReZeslNQJeL394pHbPbin
        DqnzrGXSwlvAxZ0e/7TrrxJVEg4J5L4=
X-Google-Smtp-Source: ABdhPJzTsBs12t1Fwzkddi/Ye2YLd/hOl37zJMEJfVMi2FfYBqDyWww+ddsuLMmQWzjQOdR0MO2Auw==
X-Received: by 2002:a1c:9854:: with SMTP id a81mr10607620wme.19.1614514960163;
        Sun, 28 Feb 2021 04:22:40 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4sm20232232wma.0.2021.02.28.04.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Feb 2021 04:22:39 -0800 (PST)
Message-Id: <pull.889.git.1614514959347.gitgitgadget@gmail.com>
From:   "Andrzej Hunt via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 28 Feb 2021 12:22:38 +0000
Subject: [PATCH] Update 'make fuzz-all' docs to reflect modern clang
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Josh Steadmon <steadmon@google.com>,
        Andrzej Hunt <andrzej@ahunt.org>,
        Andrzej Hunt <ajrhunt@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Andrzej Hunt <ajrhunt@google.com>

Clang no longer produces a libFuzzer.a, instead you can include
libFuzzer by using -fsanitize=fuzzer. Therefore we should use
that in the example command for building fuzzers.

I happen to have tested with LLVM 11 - however -fsanitize=fuzzer appears to
work in a wide range of reasonably modern clangs.

(On my system what used to be libFuzzer.a now lives under the following path,
 which is tricky albeit not impossible for a novice such as myself to find:
/usr/lib64/clang/11.0.0/lib/linux/libclang_rt.fuzzer-x86_64.a )

Signed-off-by: Andrzej Hunt <ajrhunt@google.com>
---
    Update 'make fuzz-all' docs to reflect modern clang
    
    I would like to update the examples for 'make fuzz-all' to make it
    easier to build fuzzers locally.
    
    This change should make it easier for the uninitiated to build fuzzers
    locally without first having to figure out what LIB_FUZZING_ENGINE is
    for.
    
    ATB, Andrzej

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-889%2Fahunt%2Ffuzz-docs-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-889/ahunt/fuzz-docs-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/889

 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 9b1bde2e0e64..9f8f459f87b4 100644
--- a/Makefile
+++ b/Makefile
@@ -3291,11 +3291,11 @@ cover_db_html: cover_db
 # are not necessarily appropriate for general builds, and that vary greatly
 # depending on the compiler version used.
 #
-# An example command to build against libFuzzer from LLVM 4.0.0:
+# An example command to build against libFuzzer from LLVM 11.0.0:
 #
 # make CC=clang CXX=clang++ \
 #      CFLAGS="-fsanitize-coverage=trace-pc-guard -fsanitize=address" \
-#      LIB_FUZZING_ENGINE=/usr/lib/llvm-4.0/lib/libFuzzer.a \
+#      LIB_FUZZING_ENGINE=-fsanitize=fuzzer \
 #      fuzz-all
 #
 FUZZ_CXXFLAGS ?= $(CFLAGS)

base-commit: 225365fb5195e804274ab569ac3cc4919451dc7f
-- 
gitgitgadget
