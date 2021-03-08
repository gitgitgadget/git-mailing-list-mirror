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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC7DFC4332D
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 18:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8E646516B
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 18:37:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbhCHSg3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Mar 2021 13:36:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbhCHSgX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Mar 2021 13:36:23 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E3EEC06174A
        for <git@vger.kernel.org>; Mon,  8 Mar 2021 10:36:23 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id r15-20020a05600c35cfb029010e639ca09eso4419550wmq.1
        for <git@vger.kernel.org>; Mon, 08 Mar 2021 10:36:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ZL3niIdol6v9ZjtiXD9kEyou44Z1prtgJfV79ewWOyU=;
        b=uXMmny7o9z9Qqw/cYsyvzafXHEBxYwDD+/mH/EsQbjLAs1Vt+h4aqf34eSNqMvDdsq
         yxUlb9Uju5DNdQCT4qtXdbYLDoEBwXax+RFBtnRW/iucQFoKex/7cdweDE0J4CEpXgjC
         9AKi7y15uXeZoAQO9LzTHfavmoSKSb/hPCklwhdqhsFihK0CWKX9Qbd4E5ejTbWnbyaI
         RCbJwyUnqta2K2LBpVA5N20J7BNM/nbm+pbtW3gkgOHP6jCVW/B2N82BSXoqkfJaiXt5
         rxYq/D3KbUYMI+GMoZ3Lhr7pIiBMwXOFZvOiLmaM7Cu3+8hj2w6HdbUM4/CVGE5AbUy1
         g9EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ZL3niIdol6v9ZjtiXD9kEyou44Z1prtgJfV79ewWOyU=;
        b=tJcrNeSQrRslQOfmoQskObJei1cWCNpSabZ8TozoxTIU6ZiS1mHh2to5JbiVEe2x6Z
         iMkyICM8jdqBTBxHNWXO9FTEtCHu2oQDYu4gN7GZpUSPRhWh9TU2SstRuuL+6mHYDtH5
         FCfowWTQr8CUjBWg624b9wexnJakcgz065Y5b+rNs5xS8CD0gizTzsi/YNk6hPJBq6+O
         5V6GvtwS8+MeEH4tVTzQ8W8PTV2DkeuT0LAzZ2T9HIOn91h8QQcK/gGEgBfnW6uDsSds
         Mxn0YrscmJ//wlxCmowmL6uoMJbUGWmJhBI/GfPCPhnRNF+PHYsaWl7EwzgSE0QfQByk
         hRSg==
X-Gm-Message-State: AOAM533wtyYdK01ijkMzZyTiCGtbCKlwqzuaSSGtJYb2fgJV2ZgMXJrY
        1989bGt4ctOdMgSHmkpQchKcjzZhWcc=
X-Google-Smtp-Source: ABdhPJzXZdMueL083pjlQQKX3tEm0tOY4QxCsbzfDQr7dAMHxuhBxPh5H3fgd27+jPAZjSIYThIy0g==
X-Received: by 2002:a1c:7209:: with SMTP id n9mr153672wmc.132.1615228582338;
        Mon, 08 Mar 2021 10:36:22 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o13sm21893608wro.15.2021.03.08.10.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 10:36:22 -0800 (PST)
Message-Id: <a7b6b873460fe096a3441c3a8d4d766b7221f14d.1615228580.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.899.git.1615228580.gitgitgadget@gmail.com>
References: <pull.899.git.1615228580.gitgitgadget@gmail.com>
From:   "Andrzej Hunt via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 08 Mar 2021 18:36:15 +0000
Subject: [PATCH 2/7] reset: free instead of leaking unneeded ref
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

dwim_ref() allocs a new string into ref. Instead of setting to NULL to discard
it, we can FREE_AND_NULL.

This leak appears to have been introduced in:
4cf76f6bbf (builtin/reset: compute checkout metadata for reset, 2020-03-16)

This leak was found when running t0001 with LSAN, see also LSAN output below:

Direct leak of 5 byte(s) in 1 object(s) allocated from:
    #0 0x486514 in strdup /home/abuild/rpmbuild/BUILD/llvm-11.0.0.src/build/../projects/compiler-rt/lib/asan/asan_interceptors.cpp:452:3
    #1 0x9a7108 in xstrdup /home/ahunt/oss-fuzz/git/wrapper.c:29:14
    #2 0x8add6b in expand_ref /home/ahunt/oss-fuzz/git/refs.c:670:12
    #3 0x8ad777 in repo_dwim_ref /home/ahunt/oss-fuzz/git/refs.c:644:22
    #4 0x6394af in dwim_ref /home/ahunt/oss-fuzz/git/./refs.h:162:9
    #5 0x637e5c in cmd_reset /home/ahunt/oss-fuzz/git/builtin/reset.c:426:4
    #6 0x4cd60d in run_builtin /home/ahunt/oss-fuzz/git/git.c:453:11
    #7 0x4cb2da in handle_builtin /home/ahunt/oss-fuzz/git/git.c:704:3
    #8 0x4ccc37 in run_argv /home/ahunt/oss-fuzz/git/git.c:771:4
    #9 0x4cac29 in cmd_main /home/ahunt/oss-fuzz/git/git.c:902:19
    #10 0x69c5ce in main /home/ahunt/oss-fuzz/git/common-main.c:52:11
    #11 0x7f57ebb9d349 in __libc_start_main (/lib64/libc.so.6+0x24349)

Signed-off-by: Andrzej Hunt <ajrhunt@google.com>
---
 builtin/reset.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index c635b062c3a7..43e855cb8876 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -425,7 +425,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 
 			dwim_ref(rev, strlen(rev), &dummy, &ref, 0);
 			if (ref && !starts_with(ref, "refs/"))
-				ref = NULL;
+				FREE_AND_NULL(ref);
 
 			err = reset_index(ref, &oid, reset_type, quiet);
 			if (reset_type == KEEP && !err)
-- 
gitgitgadget

