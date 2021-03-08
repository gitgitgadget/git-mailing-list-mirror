Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF4CC433E0
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 17:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C26865220
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 17:15:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbhCHROs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Mar 2021 12:14:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbhCHROp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Mar 2021 12:14:45 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE42EC06174A
        for <git@vger.kernel.org>; Mon,  8 Mar 2021 09:14:44 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id h98so12226552wrh.11
        for <git@vger.kernel.org>; Mon, 08 Mar 2021 09:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=I+APhyCj1VP95HNEOB+/IWsxV58xqAGlYkH4G++ghmk=;
        b=H3z/LKg5rdan7ILvwvhBbDBdVyhfzS7Lm30KqDBL5lDgsB0Ie2DhgVuSET0W4L+1jV
         tvZPpKvVGaCZbVuEqDmv7rU/KNUqdYV5P/JEtcd1R8bojLNc/7SE81R4/0SBVkDbb5lx
         SioBwywkcUNjN+4rNOGLd5XNw/c89pfnzTT2bdC8J3zdlIzqlvLKGgI+N7GOn4Q5h+k/
         PG9C1O33uHpFXpKa/uEcrN2lTgb8I0pjOekFlw8UtUmEG7FQRO4sHKzSLB1pOLg3Pc0a
         Mtxpd+N9cTfddFBcdl8rZw8vWC2S0ubUlqExRHyR5w54oM3GVSpHl6jTiiteMjOzHmNa
         pvPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=I+APhyCj1VP95HNEOB+/IWsxV58xqAGlYkH4G++ghmk=;
        b=OXGeTvyd2vNGT8TFNdTjBjDHaDlAPJt/onoPnoEIyWu4pEx7lCTP7lHRUQ97Rbs+VA
         jSDZSbycLI6bJ8KgyXcSxr8wK+qZnkU0BbxGXH60ePbe+/jB3StAAco72K/mhRwci3ue
         8JK02GIHIRtryOplKA+iY6hR0BJWG6E8ucyo6q+mhaOLNudLLM9fM2y/XIWPr72MKanc
         MJh5CSRldzFOi+dTbT7AHwgxbWZ3+dnakrGiTSM+6sZ8G8MYmVLmrp5CEUq1yJephtac
         hlJbIPYhExdtcn4+QtKFOmMWE1GYLtHhIkTp+FDAXZhSBuD8LARk8qbQMmzbrrskM+rD
         pnEQ==
X-Gm-Message-State: AOAM531V1IUB2FyeQOaRUWIPb5I34zlh0JI9iD9Q0Zzualor4io57mzh
        CLr9qJeH2TZ4CdQsudW+cNo8GqkXmCY=
X-Google-Smtp-Source: ABdhPJxG5H3D8Wq26qKPKHaJkH4mrskcRDBIugaZQmeshHyZ+fW4xPBk61/6jdIIcgkt71mKVKfQQA==
X-Received: by 2002:adf:8b5c:: with SMTP id v28mr23260148wra.272.1615223683637;
        Mon, 08 Mar 2021 09:14:43 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n186sm19015120wmn.22.2021.03.08.09.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 09:14:43 -0800 (PST)
Message-Id: <pull.889.v3.git.1615223682911.gitgitgadget@gmail.com>
In-Reply-To: <pull.889.v2.git.1614871707845.gitgitgadget@gmail.com>
References: <pull.889.v2.git.1614871707845.gitgitgadget@gmail.com>
From:   "Andrzej Hunt via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 08 Mar 2021 17:14:42 +0000
Subject: [PATCH v3] Makefile: update 'make fuzz-all' docs to reflect modern
 clang
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

Clang no longer produces a libFuzzer.a. Instead, you can include
libFuzzer by using -fsanitize=fuzzer. Therefore we should use that in
the example command for building fuzzers.

We also add -fsanitize=fuzzer-no-link to the CFLAGS to ensure that all
the required instrumentation is added when compiling git [1], and remove
 -fsanitize-coverage=trace-pc-guard as it is deprecated.

I happen to have tested with LLVM 11 - however -fsanitize=fuzzer appears
to work in a wide range of reasonably modern clangs.

(On my system: what used to be libFuzzer.a now lives under the following
 path, which is tricky albeit not impossible for a novice such as myself
 to find:
/usr/lib64/clang/11.0.0/lib/linux/libclang_rt.fuzzer-x86_64.a )

[1] https://releases.llvm.org/11.0.0/docs/LibFuzzer.html#fuzzer-usage

Signed-off-by: Andrzej Hunt <ajrhunt@google.com>
---
    Update 'make fuzz-all' docs to reflect modern clang
    
    This version of the patch fixes the commit message as per Junio's
    feedback. Thank you!

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-889%2Fahunt%2Ffuzz-docs-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-889/ahunt/fuzz-docs-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/889

Range-diff vs v2:

 1:  f5b5a11966ca ! 1:  bc0d8b615410 Update 'make fuzz-all' docs to reflect modern clang
     @@ Metadata
      Author: Andrzej Hunt <ajrhunt@google.com>
      
       ## Commit message ##
     -    Update 'make fuzz-all' docs to reflect modern clang
     +    Makefile: update 'make fuzz-all' docs to reflect modern clang
      
     -    Clang no longer produces a libFuzzer.a, instead you can include
     -    libFuzzer by using -fsanitize=fuzzer. Therefore we should use
     -    that in the example command for building fuzzers.
     +    Clang no longer produces a libFuzzer.a. Instead, you can include
     +    libFuzzer by using -fsanitize=fuzzer. Therefore we should use that in
     +    the example command for building fuzzers.
      
     -    We also add -fsanitize=fuzzer-no-link to ensure that all the required
     -    instrumentation is added when compiling git [1], and remove
     +    We also add -fsanitize=fuzzer-no-link to the CFLAGS to ensure that all
     +    the required instrumentation is added when compiling git [1], and remove
           -fsanitize-coverage=trace-pc-guard as it is deprecated.
      
     -    I happen to have tested with LLVM 11 - however -fsanitize=fuzzer appears to
     -    work in a wide range of reasonably modern clangs.
     +    I happen to have tested with LLVM 11 - however -fsanitize=fuzzer appears
     +    to work in a wide range of reasonably modern clangs.
      
     -    (On my system: what used to be libFuzzer.a now lives under the following path,
     -     which is tricky albeit not impossible for a novice such as myself to find:
     +    (On my system: what used to be libFuzzer.a now lives under the following
     +     path, which is tricky albeit not impossible for a novice such as myself
     +     to find:
          /usr/lib64/clang/11.0.0/lib/linux/libclang_rt.fuzzer-x86_64.a )
      
          [1] https://releases.llvm.org/11.0.0/docs/LibFuzzer.html#fuzzer-usage


 Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index dfb0f1000fa3..f3dc2178324e 100644
--- a/Makefile
+++ b/Makefile
@@ -3299,11 +3299,11 @@ cover_db_html: cover_db
 # are not necessarily appropriate for general builds, and that vary greatly
 # depending on the compiler version used.
 #
-# An example command to build against libFuzzer from LLVM 4.0.0:
+# An example command to build against libFuzzer from LLVM 11.0.0:
 #
 # make CC=clang CXX=clang++ \
-#      CFLAGS="-fsanitize-coverage=trace-pc-guard -fsanitize=address" \
-#      LIB_FUZZING_ENGINE=/usr/lib/llvm-4.0/lib/libFuzzer.a \
+#      CFLAGS="-fsanitize=fuzzer-no-link,address" \
+#      LIB_FUZZING_ENGINE="-fsanitize=fuzzer" \
 #      fuzz-all
 #
 FUZZ_CXXFLAGS ?= $(CFLAGS)

base-commit: be7935ed8bff19f481b033d0d242c5d5f239ed50
-- 
gitgitgadget
