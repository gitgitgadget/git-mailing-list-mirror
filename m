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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8374C433DB
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 16:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C87961947
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 16:59:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbhCUQ7N (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Mar 2021 12:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbhCUQ6l (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Mar 2021 12:58:41 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC9DC061574
        for <git@vger.kernel.org>; Sun, 21 Mar 2021 09:58:41 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id k128so5767648wmk.4
        for <git@vger.kernel.org>; Sun, 21 Mar 2021 09:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=F0opQpe7BV1fXWQ5HltcF7A+GqCj/k0iJf9Vz5xKxgw=;
        b=jgwol8JpYuA+fMGzEzBYEQWwMnROU8a4zGf9PMnH04YI0AFFRptLjgNyFgWyOaIR++
         5kuSDiPgYcd+Qa1q0h+CxnZigTRwx7KPRjJU1XdbSYwsZeW434GBByQ8/hmOOE0pkakZ
         5tt+GBvL/ar3+paRvnzVMBxLjZXryG16BIjwuhU+9gcczgpCK2dvRDvPkgjBYGh4BoRQ
         RYD+fx0qg+3sBSGi6uR4LBeuO2ryALmTht3Po5Xf70zWVS/z1wFelAJBoVI07qI/2lur
         jtxVzNvyGp1/KG5kCSJDVnN++zHNPuPSNFbuJdHu84eDSkbTprP1UY+NZN6WqCY+srOy
         BQjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=F0opQpe7BV1fXWQ5HltcF7A+GqCj/k0iJf9Vz5xKxgw=;
        b=o9/RkaUi57jbj8QrUp1vp5vHkSBCTJtHQ7qzljJ9Dg33edxxokRY/p2MgtoU5wHT0O
         p6g/yXamv7tB6hZmWYobBSKU5F2xtYyFT91tJoxzgOoOEm2aYaPNQ+xthqllyyz6Eyrp
         jftnmhOOeO7ER1KNw61kewhdC2IYYIe51oG9r2HGpGl0qn9vkOfbgPmH9qUQ7Wz1yF7V
         ebp0gKshpk10sALo6yewHC3247qrT/CbqBQkRFWN0rqJ74Ardz02+umrtqa6XL0UTSci
         M0hlLzdH6IPjFGhlpAvBI9VKt0Znwk9LVuLrGypk7f9gMbpP8SwmqJysWy5840qdYD0W
         E5/Q==
X-Gm-Message-State: AOAM5325L+aOG1vy7JQCbwkYaZvIgp1UdU6SRosA7sgAKTj8Fo8PD5v4
        b33SOHpWyzLpZ0b5YfwDxivBeAgw5dw=
X-Google-Smtp-Source: ABdhPJwCyPT6hfr6TOUOfF0lRF7sD+YoZ6u4lRu5TsqZ4RCw0ZRS7EHJRQZhtp1FU6HsjyNxi8RetQ==
X-Received: by 2002:a1c:df8a:: with SMTP id w132mr12440372wmg.53.1616345920218;
        Sun, 21 Mar 2021 09:58:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j13sm16482671wrt.29.2021.03.21.09.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 09:58:39 -0700 (PDT)
Message-Id: <add6931b21383eb8fdf0f1f750a4dfc5d7688466.1616345918.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.899.v3.git.1616345918.gitgitgadget@gmail.com>
References: <pull.899.v2.git.1615747662.gitgitgadget@gmail.com>
        <pull.899.v3.git.1616345918.gitgitgadget@gmail.com>
From:   "Andrzej Hunt via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 21 Mar 2021 16:58:30 +0000
Subject: [PATCH v3 2/9] reset: free instead of leaking unneeded ref
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Martin =?UTF-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <andrzej@ahunt.org>,
        Andrzej Hunt <ajrhunt@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Andrzej Hunt <ajrhunt@google.com>

dwim_ref() allocs a new string into ref. Instead of setting to NULL to
discard it, we can FREE_AND_NULL.

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

