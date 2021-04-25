Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 097CDC433ED
	for <git@archiver.kernel.org>; Sun, 25 Apr 2021 14:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E06B461369
	for <git@archiver.kernel.org>; Sun, 25 Apr 2021 14:16:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbhDYORM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Apr 2021 10:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbhDYORI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Apr 2021 10:17:08 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC86C06138B
        for <git@vger.kernel.org>; Sun, 25 Apr 2021 07:16:27 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id f195-20020a1c1fcc0000b029012eb88126d7so3670045wmf.3
        for <git@vger.kernel.org>; Sun, 25 Apr 2021 07:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=xBQHDAQkmLXliEEpOaUXRyoJMpH3nXNNFwi39q0+Dhw=;
        b=VFao026D/Qa2wipdrTNrsyFT4CG1kIaipccvxA3fEcn9ebxnf3BxkhZNFEnJ1zleVw
         da9IjSUwwO8pI5/H+AkjSvjVgFxRRz75IFTUq+lrTxZzdy6BhutKERHWvvUa9Eb6xUm4
         hY4mbXo1V1GThOOlmQGWAYs6gXrpfzezhBp1s4ROxbFqLUcP6x4yCptk0PKEFnGakgi3
         34u8KFgjDFMs8hY9VK4VkVMhWg5SHj07+KHZ7gdHHg/srnLVqAuecjYX7b6VSpEPNAzx
         YGP53Ktr5viAKGqBOGhXg93fqWOq383I50oqGobwrypjMAId2znRonckrlQT3FtpZlzW
         ZzDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=xBQHDAQkmLXliEEpOaUXRyoJMpH3nXNNFwi39q0+Dhw=;
        b=ABn4ZsI5nMnP24s9eny7jF3v1XasvzVkNssY6uVatvSy3a23VKLSFAXjQvpUUrbPIy
         rKPBoBsociLrSFNuWvx3R3zNowzaSEGVwG6yfAMhzREdUWMyfuZl++zU3S30sXkQZuR9
         tG7YDCeY0zVbQk5CVLqGL6pkcdJ2d7D357HBSRJpQkEtOb+xsxg7+UNwfqXU+up+ZTqt
         lYBLR7vi1eaLfgUhqwSZ8dtLUk8fwzNNW2QcbeQALnhn4UfM00Y+w1o4bklaKPlKuymQ
         ZduUshzK+BFW4RCDAmpdvvI9cEzapSVmk+hv3RZXEpDdD4FISzeIzJRbSL30TKhyJlr0
         pPmA==
X-Gm-Message-State: AOAM531x3Dfz7nrx0Ka/kFGQood9D6pREPpBYKw7bf4kZ5oE4gmHTJhk
        x+wvse7Lf24R51/mWU4PJN/7QJY2ysc=
X-Google-Smtp-Source: ABdhPJwRuPxQ7aZsiPaiuCfZ6EDKyr0HlxAwG1etJH+24FjOgc0tob6olbKIt6VTsGL5XchdydJJUA==
X-Received: by 2002:a7b:c4d9:: with SMTP id g25mr16071271wmk.182.1619360186266;
        Sun, 25 Apr 2021 07:16:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c77sm13376042wme.37.2021.04.25.07.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Apr 2021 07:16:26 -0700 (PDT)
Message-Id: <20c5f2e68c54bdd7d07acdc256f8895cabbca6c2.1619360180.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.929.v2.git.1619360180.gitgitgadget@gmail.com>
References: <pull.929.git.1617994052.gitgitgadget@gmail.com>
        <pull.929.v2.git.1619360180.gitgitgadget@gmail.com>
From:   "Andrzej Hunt via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 25 Apr 2021 14:16:15 +0000
Subject: [PATCH v2 08/12] builtin/checkout: clear pending objects after
 diffing
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Andrzej Hunt <andrzej@ahunt.org>,
        Andrzej Hunt <ajrhunt@google.com>
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

