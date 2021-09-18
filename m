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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AE63C433EF
	for <git@archiver.kernel.org>; Sat, 18 Sep 2021 13:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E674E61050
	for <git@archiver.kernel.org>; Sat, 18 Sep 2021 13:49:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238215AbhIRNvH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Sep 2021 09:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237617AbhIRNvF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Sep 2021 09:51:05 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2088FC061574
        for <git@vger.kernel.org>; Sat, 18 Sep 2021 06:49:42 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id d6so19844077wrc.11
        for <git@vger.kernel.org>; Sat, 18 Sep 2021 06:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=SjrbHt7eGrvXHaiVQoc9XYQRsVwlQl3vizI1S/fC2LI=;
        b=d3zPHqAm+5WyrJ3INYDQ6TUyRbxLgOiLTZ5FIKZbpvP1FEmucXJSpRT9qESEtmwPVI
         g77omFKBVfshKiOhIi2NsXiK0ASHPaKiwy0WcBzNUZaaAb/Mjau3ZEWzT1scE1w9CJlO
         g2Hz70TG5l+sxSo/sGFVb54LkncxnXYHLfMjt9Dk+P0ssj8htCmzBaSMmzK93rUY6X9z
         2dA3Z+Eys+rZaBAKwu4PhzBYlcN4aThoo1uzFUuNGVJbomOCtvxD5ilhjqDpn2iDog1h
         zbGWf3Q53Gj6bdgL6pAGSJBKId24ZZyCjQIINXrdg7WFVpWWvI0F7aDT3X0mEturfhjv
         MS6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=SjrbHt7eGrvXHaiVQoc9XYQRsVwlQl3vizI1S/fC2LI=;
        b=edhwmt2irhkvfZY8uX3hI+/ZRQYDxTWnrWS1utNPcJRsR7JtZ5A/Kx3vuRgV7g7T5C
         L9BWpIOF8xDuenaAeHzC+9uPw6Z6i2uiYm3u6ok1nWqiVLXrayQ1GYcjrvJtgXP2Gq9c
         z26tRlFfOKF1vrL9iSZnDAENNQQg9bRNwINTFxvV4kmHWKqQtAWMeiIkqBlSZiwEPyzN
         lPKCXxnqy3HfYlq/cZvjYCqKzZ/D77s5GzzF/3ZZgyjsiXcBlOSJOiz02+Xn5a3qRg89
         3rlJoxoRqTHseEhqr3Z84o8D6V3UO5gYtLJkMdkcRlo/GT9yGVv5VCFfu++PDhMui0Mm
         LwaQ==
X-Gm-Message-State: AOAM533fg2qEnlstfnCBJkNma8DTw2fxhkgk70B33UPxSj/fFCZtEc+V
        6NIUJhmlSEV8EEhYKtxXMebgdzL3xoo=
X-Google-Smtp-Source: ABdhPJwk+8YR5IwIcESGPdDVM4d5ct2/t5ACupGHI76mwuyGGUYiI0TJNWtEdrBErKnqcIs/Fz1nZA==
X-Received: by 2002:a5d:6741:: with SMTP id l1mr18208110wrw.289.1631972980677;
        Sat, 18 Sep 2021 06:49:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z17sm9102518wml.24.2021.09.18.06.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Sep 2021 06:49:40 -0700 (PDT)
Message-Id: <aad3fe7381ced5eeff9c8d57ce90911bc59e3923.1631972978.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1092.git.git.1631972978.gitgitgadget@gmail.com>
References: <pull.1092.git.git.1631972978.gitgitgadget@gmail.com>
From:   "Andrzej Hunt via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 18 Sep 2021 13:49:38 +0000
Subject: [PATCH 2/2] log: UNLEAK original pending objects
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Carlo Arenas <carenas@gmail.com>, Andrzej Hunt <andrzej@ahunt.org>,
        Andrzej Hunt <ajrhunt@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Andrzej Hunt <ajrhunt@google.com>

cmd_show() uses objects to point to rev.pending's objects. Later, it might
detach rev.pending's objects: when handling an OBJ_COMMIT it will reset
rev.pending (without freeing its objects). Detaching (as opposed to freeing)
is necessary because cmd_show() continues iterating over the original objects
array.

We choose to UNLEAK because there's no real advantage to cleaning up
properly (cmd_show() exits immediately after looping over these
objects). A number of alternatives exist, but are all significantly more
complex for no gain:

Alternative 1:
  Convert objects into an object_array, and memcpy rev.pending into it
  (followed by detaching rev.pending immediately - making objects the
  owner of what used to be rev.pending). Then we could safely
  objects_array_clear() at the end of cmd_show(). And we can rely on
  a preexisting UNLEAK(rev) to avoid having to clean up rev.pending.
  This is a more complex and riskier approach vs a simple UNLEAK,
  and doesn't add any user-visible value.

Alternative 2:
  A variation on alternative 1. We make objects own the object_array as
  before. Once we're done, we free the new rev.pending array (which
  might be empty), and we memcpy objects back into rev.pending, relying
  on the existin UNLEAK(rev) to avoid having to free rev.pending.

ASAN output from t0000:

Direct leak of 41 byte(s) in 1 object(s) allocated from:
    #0 0x487504 in strdup ../projects/compiler-rt/lib/asan/asan_interceptors.cpp:437:3
    #1 0x9e4ef8 in xstrdup wrapper.c:29:14
    #2 0x86395d in add_object_array_with_path object.c:366:17
    #3 0x9264fc in add_pending_object_with_path revision.c:330:2
    #4 0x91c4e0 in handle_revision_arg_1 revision.c:2086:2
    #5 0x91bfcd in handle_revision_arg revision.c:2093:12
    #6 0x91ff5a in setup_revisions revision.c:2780:7
    #7 0x5a7678 in cmd_log_init_finish builtin/log.c:206:9
    #8 0x5a4f18 in cmd_log_init builtin/log.c:278:2
    #9 0x5a55d1 in cmd_show builtin/log.c:646:2
    #10 0x4cff30 in run_builtin git.c:461:11
    #11 0x4cdb00 in handle_builtin git.c:713:3
    #12 0x4cf527 in run_argv git.c:780:4
    #13 0x4cd426 in cmd_main git.c:911:19
    #14 0x6b2eb5 in main common-main.c:52:11
    #15 0x7f74fc9bd349 in __libc_start_main (/lib64/libc.so.6+0x24349)

SUMMARY: AddressSanitizer: 41 byte(s) leaked in 1 allocation(s).

Signed-off-by: Andrzej Hunt <andrzej@ahunt.org>
---
 builtin/log.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/log.c b/builtin/log.c
index 6faaddf17a6..769ee6a9258 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -702,7 +702,8 @@ int cmd_show(int argc, const char **argv, const char *prefix)
 			ret = error(_("unknown type: %d"), o->type);
 		}
 	}
-	free(objects);
+	UNLEAK(objects);
+
 	return ret;
 }
 
-- 
gitgitgadget
