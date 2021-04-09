Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46170C433ED
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 18:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDE2A61056
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 18:47:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234662AbhDISsE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 14:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234572AbhDISrw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 14:47:52 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F8F5C061763
        for <git@vger.kernel.org>; Fri,  9 Apr 2021 11:47:39 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id x15so6588140wrq.3
        for <git@vger.kernel.org>; Fri, 09 Apr 2021 11:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=xBQHDAQkmLXliEEpOaUXRyoJMpH3nXNNFwi39q0+Dhw=;
        b=FWlKZNryYYgT2t4VJ9Jr3mJZhXOf8mlRrQBgW5YCnD9YywF1bN7VPuf5RfOH4h+FdU
         3e7JOhWhnBs09xN1oZ8wE+K31D7rmTwjK0vzqzCbPA9BlU0usNggNYvkIgdnS6gPQS/J
         HEcS06mxt5zjqBz7DrTPQwsHv9krKZ3htZZSUKn0aBJva9DNLQo1WUsIFvmovgL2Iggm
         baS6BJsh5ptIBF8oi72xMfbszJSEbpJDq05eDLpSs+7orVQyPRLznl6Ji9MgFIEHd8cR
         ZC+i2m+FH8RHnOwHeAQGZFQXTSomnxPXIkL7yw0RGsKmMochGzq5xlciDa8ri94aV2vg
         JMjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=xBQHDAQkmLXliEEpOaUXRyoJMpH3nXNNFwi39q0+Dhw=;
        b=qkIFtydKiJoxQl0UebGxn0FgMJp5YkzOKKE77MFKjY9AiXQjdJlh2zBalbTEAqWEYR
         X63pc3z47dEfxPNOTrpzqjoalsYAeTG+MOS6mjNxI/6OBg6IsVTBMy5uvly4EfyKLsgr
         12oZcIH/dahfQIQBqW9uyWBhktTOi1zH4D5q5YANvA5DbRU2bh9kKuHMJ9SY5LO9/nFQ
         FkidNsdPIK1XUh/+wNzKKnYw+HMweIgTka1C4x2+4QZu8xkgjldizHPfcTrRif1VZEeZ
         4mTJiwHNdarMpkF1V5Ra9BsMMTbvo9KYtnokJg/hvRKefeOUkGNMBQLVl5/LsI5ncC62
         bOTg==
X-Gm-Message-State: AOAM533m3j7lhroSQC36KWcw69zJGb53t4L2/0mSxHmiNweowkai9d53
        l1QAEbch1ZSo0Q1z+O/wtK1IifAWLG0=
X-Google-Smtp-Source: ABdhPJwnVjZEvTwWFQiEtMLbTeGkgFF4HUC56k55k1Qu1fNN5ugl5/9ANCeEhSxL4GVEfzbQQL7uBA==
X-Received: by 2002:adf:d211:: with SMTP id j17mr19444801wrh.311.1617994058052;
        Fri, 09 Apr 2021 11:47:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j6sm6477162wru.18.2021.04.09.11.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 11:47:37 -0700 (PDT)
Message-Id: <cdeb4b7875e3bf66bf2b492841118bab0e8f047e.1617994052.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.929.git.1617994052.gitgitgadget@gmail.com>
References: <pull.929.git.1617994052.gitgitgadget@gmail.com>
From:   "Andrzej Hunt via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 09 Apr 2021 18:47:27 +0000
Subject: [PATCH 08/12] builtin/checkout: clear pending objects after diffing
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Andrzej Hunt <andrzej@ahunt.org>, Andrzej Hunt <ajrhunt@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Andrzej Hunt <ajrhunt@google.com>

add_pending_object() populates rev.pending, we need to take care of
clearing it once we're done.

This code is run close to the end of a checkout, therefore this leak
seems like it would have very little impact. See also LSAN output
from t0020 below:

Direct leak of 2048 byte(s) in 1 object(s) allocated from:
    #0 0x49ab79 in realloc ../projects/compiler-rt/lib/asan/asan_malloc_linux.cpp:164:3
    #1 0x9acc46 in xrealloc wrapper.c:126:8
    #2 0x83e3a3 in add_object_array_with_path object.c:337:3
    #3 0x8f672a in add_pending_object_with_path revision.c:329:2
    #4 0x8eaeab in add_pending_object_with_mode revision.c:336:2
    #5 0x8eae9d in add_pending_object revision.c:342:2
    #6 0x5154a0 in show_local_changes builtin/checkout.c:602:2
    #7 0x513b00 in merge_working_tree builtin/checkout.c:979:3
    #8 0x512cb3 in switch_branches builtin/checkout.c:1242:9
    #9 0x50f8de in checkout_branch builtin/checkout.c:1646:9
    #10 0x50ba12 in checkout_main builtin/checkout.c:2003:9
    #11 0x5086c0 in cmd_checkout builtin/checkout.c:2055:8
    #12 0x4cd91d in run_builtin git.c:467:11
    #13 0x4cb5f3 in handle_builtin git.c:719:3
    #14 0x4ccf47 in run_argv git.c:808:4
    #15 0x4caf49 in cmd_main git.c:939:19
    #16 0x69e43e in main common-main.c:52:11
    #17 0x7f5dd1d50349 in __libc_start_main (/lib64/libc.so.6+0x24349)

SUMMARY: AddressSanitizer: 2048 byte(s) leaked in 1 allocation(s).
Signed-off-by: Andrzej Hunt <ajrhunt@google.com>
---
 builtin/checkout.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 4c696ef4805b..190153c81571 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -602,6 +602,7 @@ static void show_local_changes(struct object *head,
 	diff_setup_done(&rev.diffopt);
 	add_pending_object(&rev, head, NULL);
 	run_diff_index(&rev, 0);
+	object_array_clear(&rev.pending);
 }
 
 static void describe_detached_head(const char *msg, struct commit *commit)
-- 
gitgitgadget

