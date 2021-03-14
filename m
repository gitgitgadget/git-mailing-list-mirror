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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AF4CC43331
	for <git@archiver.kernel.org>; Sun, 14 Mar 2021 18:48:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C16164EB0
	for <git@archiver.kernel.org>; Sun, 14 Mar 2021 18:48:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234179AbhCNSsY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Mar 2021 14:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233756AbhCNSrr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Mar 2021 14:47:47 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E23C061763
        for <git@vger.kernel.org>; Sun, 14 Mar 2021 11:47:45 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id k8so4590819wrc.3
        for <git@vger.kernel.org>; Sun, 14 Mar 2021 11:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=F0opQpe7BV1fXWQ5HltcF7A+GqCj/k0iJf9Vz5xKxgw=;
        b=BDvTVB79W5uTULEjeu1Sx93QPW+bBs1IEmfsdVFYM+LnJTHleWyZn9KI7pSStRLOjY
         TsyzKytwISCrk9FyQ9QuIGu7CSnHQZ0dP5/0ujjGxS2JMlrcCnpBXpkUa0XyrxXHlEyR
         CnuLB4Ua2Uwoq4yDexnxc29/f8iQgqZLqUQ6BbOucBlHAp5vrMwssafUejRQum6Oy6fM
         FqoAZGcJwqnvkOWps/2eRzPba1UMdcPQzZNOMcHqHsP4+CCI6lE3syyD0UR2QCn5SnYt
         ghBRAVvrONBe/XkGM1H2e1uLNa7hki+XXfPBiUtmtrMFzgHxX/cUvA0dIU189TKLNig3
         GdDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=F0opQpe7BV1fXWQ5HltcF7A+GqCj/k0iJf9Vz5xKxgw=;
        b=bM39pdOwMo65JxuXCRVaMcK7CRW72e7E3o7zPg9W+MCchulUPBrDjwFlu8QYHkssPt
         bGgZCOaHWUvYGnACMYkS6qAj6KYJVggTJkNAJmPH44L2lIAYSHEk1j9gkSgNAaO7P28s
         7Y1uNC/XCF2W8Yv/9r/rOocZuxOCXueAY8rr5dCc0O7nMG6ubIJT3GzRNFsqK7WoCJ1M
         UExK3racq8TR4f6Hb3LrbzQeajSiFZvz+wtcbHY92jhD6qd9LPR8W10zi9pwNq7zNbse
         3bmnUh3lktya+KuiTfK4enJt76kEwL28Yw9+VWqm5mh5KbZA2iuZ5uRiz2TxbM2RWjys
         fvtQ==
X-Gm-Message-State: AOAM53038OSm7q/jFY3SHDa7yZrCpVwzfBu5d0+pumZ07Xx1aiBNUjcM
        s8ORs2ehlpubq0RmFt58FdI88rHnNtM=
X-Google-Smtp-Source: ABdhPJwjiF/evYXiSG1u53hIu/WSOohbaSVJ1Q2+ozXXT/Bx9Fi9UVhrN3QJuFKyLEFX0RI2/7uzag==
X-Received: by 2002:a5d:698e:: with SMTP id g14mr23612077wru.127.1615747664553;
        Sun, 14 Mar 2021 11:47:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l22sm16324996wrb.4.2021.03.14.11.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Mar 2021 11:47:44 -0700 (PDT)
Message-Id: <da05fc72b77a7c5394643ec7e9fc69e9d5c17fa5.1615747662.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.899.v2.git.1615747662.gitgitgadget@gmail.com>
References: <pull.899.git.1615228580.gitgitgadget@gmail.com>
        <pull.899.v2.git.1615747662.gitgitgadget@gmail.com>
From:   "Andrzej Hunt via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 14 Mar 2021 18:47:35 +0000
Subject: [PATCH v2 2/9] reset: free instead of leaking unneeded ref
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

