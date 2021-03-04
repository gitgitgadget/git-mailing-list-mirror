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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C5DC433E6
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 15:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A0DC64FCB
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 15:29:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234895AbhCDP3Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Mar 2021 10:29:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235060AbhCDP3K (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Mar 2021 10:29:10 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1BD5C061756
        for <git@vger.kernel.org>; Thu,  4 Mar 2021 07:28:29 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id k66so10102317wmf.1
        for <git@vger.kernel.org>; Thu, 04 Mar 2021 07:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=NVSf2LZtXYxYfCF8ZxQ4K2+ZMsHLCDy/reu3l9Vvlsk=;
        b=bW0RAzCsrbl4fcPD3rd05ok3NlDkkaSzQfrQt/55jyg1bxExsluuKx0p4DPMvR6FMt
         3+Gs9wJAQ092W607fpeN38u4wWNTrbKLlK4DDKxFWVxHWYvPYq709FOsyqL+PRpLHtkN
         68tDpnRcCZhjrbKHBj00cQnsQ7qsPT4+At6/+EG7Q8wsOq3czIjNVgZeXBYDe17QilY+
         I2qwf9jj2YWpYbwhgjVl6RrXqe3wQwBSCeiQ1tIStTrPzWaQIYyO5eJ+oR4B7YSTiJl+
         lV/NoChyrc8TEESyzxILLazUuh/m40bahdJMuAqtpzGgNl912zUvmHq5dwJAO4pGAEcu
         HD1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=NVSf2LZtXYxYfCF8ZxQ4K2+ZMsHLCDy/reu3l9Vvlsk=;
        b=U9mikL/dKFoJDMTPUye8ABof1ZNowgX7wkXTYCzsVMpkZbn0mOkeAQfEt1GbH/jJCG
         oKa3v+gyXrsrhHh2WWBXArn0QDtC3Ep7IB4+LwzQ/1UeJUdWi+IMu2OQFQp+uCFyyp/v
         bf7ZcT/NnM8X9iz7EhBuimdh/uzrJ06vCgCEZoU2kUzGE48tQ1YAsuuuC24ebnZ2seF7
         /3P6YIL3WSbp3b0F3HE0MkxLK7bmHSnDslnGZNMIXqaumWZRhsElellTrawC3BhVe4WA
         L53moEF+n3/uPVlFMR3ullboQGG3bbyJna4Js3ojOroXGz3edXIVcEefXpJbLnfsCrd3
         mDlw==
X-Gm-Message-State: AOAM5323GtjKOBdKzeYYbbWj+X58K1bSkEKGCDYW+Bowabj99VtUOBSx
        aT3jvDGTnbj7KuD9cI67/cAhPIhazIY=
X-Google-Smtp-Source: ABdhPJzXsqz3E1HCsQKc+yuJA+rLAlo+B5DjHebKJ4tQ1K1QLzhQZ03IfdD+neRYFC30V199+utWGA==
X-Received: by 2002:a05:600c:3581:: with SMTP id p1mr4491180wmq.91.1614871708628;
        Thu, 04 Mar 2021 07:28:28 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m14sm10127406wmi.27.2021.03.04.07.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 07:28:28 -0800 (PST)
Message-Id: <pull.889.v2.git.1614871707845.gitgitgadget@gmail.com>
In-Reply-To: <pull.889.git.1614514959347.gitgitgadget@gmail.com>
References: <pull.889.git.1614514959347.gitgitgadget@gmail.com>
From:   "Andrzej Hunt via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 04 Mar 2021 15:28:27 +0000
Subject: [PATCH v2] Update 'make fuzz-all' docs to reflect modern clang
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

We also add -fsanitize=fuzzer-no-link to ensure that all the required
instrumentation is added when compiling git [1], and remove
 -fsanitize-coverage=trace-pc-guard as it is deprecated.

I happen to have tested with LLVM 11 - however -fsanitize=fuzzer appears to
work in a wide range of reasonably modern clangs.

(On my system: what used to be libFuzzer.a now lives under the following path,
 which is tricky albeit not impossible for a novice such as myself to find:
/usr/lib64/clang/11.0.0/lib/linux/libclang_rt.fuzzer-x86_64.a )

[1] https://releases.llvm.org/11.0.0/docs/LibFuzzer.html#fuzzer-usage

Signed-off-by: Andrzej Hunt <ajrhunt@google.com>
---
    Update 'make fuzz-all' docs to reflect modern clang
    
    I have updated my patch to:
    
     * Remove -fsanitize-coverage=trace-pc-guard as it is deprecated.
     * Add -fsanitize=fuzzer-no-link as per Josh's suggestion.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-889%2Fahunt%2Ffuzz-docs-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-889/ahunt/fuzz-docs-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/889

Range-diff vs v1:

 1:  d804b24907fd ! 1:  f5b5a11966ca Update 'make fuzz-all' docs to reflect modern clang
     @@ Commit message
          libFuzzer by using -fsanitize=fuzzer. Therefore we should use
          that in the example command for building fuzzers.
      
     +    We also add -fsanitize=fuzzer-no-link to ensure that all the required
     +    instrumentation is added when compiling git [1], and remove
     +     -fsanitize-coverage=trace-pc-guard as it is deprecated.
     +
          I happen to have tested with LLVM 11 - however -fsanitize=fuzzer appears to
          work in a wide range of reasonably modern clangs.
      
     -    (On my system what used to be libFuzzer.a now lives under the following path,
     +    (On my system: what used to be libFuzzer.a now lives under the following path,
           which is tricky albeit not impossible for a novice such as myself to find:
          /usr/lib64/clang/11.0.0/lib/linux/libclang_rt.fuzzer-x86_64.a )
      
     +    [1] https://releases.llvm.org/11.0.0/docs/LibFuzzer.html#fuzzer-usage
     +
          Signed-off-by: Andrzej Hunt <ajrhunt@google.com>
      
       ## Makefile ##
     @@ Makefile: cover_db_html: cover_db
      +# An example command to build against libFuzzer from LLVM 11.0.0:
       #
       # make CC=clang CXX=clang++ \
     - #      CFLAGS="-fsanitize-coverage=trace-pc-guard -fsanitize=address" \
     +-#      CFLAGS="-fsanitize-coverage=trace-pc-guard -fsanitize=address" \
      -#      LIB_FUZZING_ENGINE=/usr/lib/llvm-4.0/lib/libFuzzer.a \
     -+#      LIB_FUZZING_ENGINE=-fsanitize=fuzzer \
     ++#      CFLAGS="-fsanitize=fuzzer-no-link,address" \
     ++#      LIB_FUZZING_ENGINE="-fsanitize=fuzzer" \
       #      fuzz-all
       #
       FUZZ_CXXFLAGS ?= $(CFLAGS)


 Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index dd08b4ced01c..c7248ac6057b 100644
--- a/Makefile
+++ b/Makefile
@@ -3292,11 +3292,11 @@ cover_db_html: cover_db
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

base-commit: f01623b2c9d14207e497b21ebc6b3ec4afaf4b46
-- 
gitgitgadget
