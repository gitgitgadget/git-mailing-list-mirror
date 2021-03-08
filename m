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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3380CC4321A
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 18:37:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2144A6516B
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 18:37:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbhCHSgb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Mar 2021 13:36:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbhCHSgZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Mar 2021 13:36:25 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5279C06174A
        for <git@vger.kernel.org>; Mon,  8 Mar 2021 10:36:24 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id n22so114868wmc.2
        for <git@vger.kernel.org>; Mon, 08 Mar 2021 10:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=KOcaBg4BmDvxnKj5wMf4bq4LqS2Gb9A/nMQwYoBqdwQ=;
        b=cP9BpEO6/yVNM+J/cKsw0YdU0Zgl/yqTZmhZnsPLDRfOxCY2h/FdErwt/qLILJi3K3
         TEr29aA3or5WCzm2ITwPUsbC2Hqx6XR70lLQ7wDyclt8LHzkvtFLVUZHEyJqTymzJGED
         sUnhgFHzQkkQRWDTUyq60rA/DmHxk3nBD71FPPLkgAD9dI+zMU/W7Xw44sPX3KSqDQj8
         UUj6ZWorO8ruExqHvnp5+Mah5uev+8EoxkGpoC/RQyjI2CJZXMgsBLCUcZbgYzeHVt7C
         CRVDRVO8HcNPguvKo++EJUJoquYhLk7IfwSXuNq+U5YArXpAeef1x62++GUXKrlMJnhS
         OLbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=KOcaBg4BmDvxnKj5wMf4bq4LqS2Gb9A/nMQwYoBqdwQ=;
        b=CVm9f+so7qh1bhlqrhAoK7f2jpmhWWKi+C4sbpdH5qERh+8hpS8MSbhWSJ8vuRqtuZ
         3esR1K3KFAzonRC8P5DCRvRR75bwwy3Q6PIxpqpoef0FdIG2hjuCeyFWeWzGoruMqo50
         Xz5Q30Juog4Q3Z+qX2DBH3E5IpXWqFTJ+ZkgTMFgjp9NWlWEYpyfUyGMj4XqOodWTqK7
         +abajKibbJH7Gf01qcYklgKCIRuFfDGypJKip78zGGH/tOjo/MWzPYBOgrU0chtNg1ix
         4QnYpQN7i5Q/nt+B+Ch8kKGVZ1bJN9dNNrfxmfb6y7hLdByiE1WRTxpPVsysZuV8rtEo
         +7WA==
X-Gm-Message-State: AOAM531+zD5PnL8e/wvAMXCyuz7nNRCXh3MKdWgq72gxyC8N054TqsER
        QA0a60D81CHMVHqhhMUP8S8vEi4ZtnE=
X-Google-Smtp-Source: ABdhPJz7AfA1tkS0LAYbhy0Dejg1gdwRcJvBFn6qflZvlfiK3FX4xMCG7LoaSZS0AaezP1K+teUP4g==
X-Received: by 2002:a1c:498b:: with SMTP id w133mr155794wma.134.1615228583570;
        Mon, 08 Mar 2021 10:36:23 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y205sm265379wmc.18.2021.03.08.10.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 10:36:23 -0800 (PST)
Message-Id: <d46a4e701620704ae3fd203c9d9dffb172cb3804.1615228580.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.899.git.1615228580.gitgitgadget@gmail.com>
References: <pull.899.git.1615228580.gitgitgadget@gmail.com>
From:   "Andrzej Hunt via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 08 Mar 2021 18:36:17 +0000
Subject: [PATCH 4/7] worktree: fix leak in dwim_branch()
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

Make sure that we release the temporary strbuf during dwim_branch() for
all codepaths (and not just for the early return).

This leak appears to have been introduced in:
  f60a7b763f (worktree: teach "add" to check out existing branches, 2018-04-24)

Note that UNLEAK(branchname) is still needed: the returned result is
used in add(), and is stored in a pointer which is used to point at one
of:
  - a string literal ("HEAD")
  - member of argv (whatever the user specified in their invocation)
  - or our newly allocated string returned from dwim_branch()
Fixing the branchname leak isn't impossible, but does not seem
worthwhile given that add() is called directly from cmd_main(), and
cmd_main() returns immediately thereafter - UNLEAK is good enough.

This leak was found when running t0001 with LSAN, see also LSAN output
below:

Direct leak of 60 byte(s) in 1 object(s) allocated from:
    #0 0x49a859 in realloc /home/abuild/rpmbuild/BUILD/llvm-11.0.0.src/build/../projects/compiler-rt/lib/asan/asan_malloc_linux.cpp:164:3
    #1 0x9ab076 in xrealloc /home/ahunt/oss-fuzz/git/wrapper.c:126:8
    #2 0x939fcd in strbuf_grow /home/ahunt/oss-fuzz/git/strbuf.c:98:2
    #3 0x93af53 in strbuf_splice /home/ahunt/oss-fuzz/git/strbuf.c:239:3
    #4 0x83559a in strbuf_check_branch_ref /home/ahunt/oss-fuzz/git/object-name.c:1593:2
    #5 0x6988b9 in dwim_branch /home/ahunt/oss-fuzz/git/builtin/worktree.c:454:20
    #6 0x695f8f in add /home/ahunt/oss-fuzz/git/builtin/worktree.c:525:19
    #7 0x694a04 in cmd_worktree /home/ahunt/oss-fuzz/git/builtin/worktree.c:1036:10
    #8 0x4cd60d in run_builtin /home/ahunt/oss-fuzz/git/git.c:453:11
    #9 0x4cb2da in handle_builtin /home/ahunt/oss-fuzz/git/git.c:704:3
    #10 0x4ccc37 in run_argv /home/ahunt/oss-fuzz/git/git.c:771:4
    #11 0x4cac29 in cmd_main /home/ahunt/oss-fuzz/git/git.c:902:19
    #12 0x69caee in main /home/ahunt/oss-fuzz/git/common-main.c:52:11
    #13 0x7f7b7dd10349 in __libc_start_main (/lib64/libc.so.6+0x24349)

Signed-off-by: Andrzej Hunt <ajrhunt@google.com>
---
 builtin/worktree.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 1cd5c2016e3f..44d3f058d065 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -445,17 +445,17 @@ static void print_preparing_worktree_line(int detach,
 
 static const char *dwim_branch(const char *path, const char **new_branch)
 {
-	int n;
+	int n, branch_exists;
 	const char *s = worktree_basename(path, &n);
 	const char *branchname = xstrndup(s, n);
 	struct strbuf ref = STRBUF_INIT;
-
 	UNLEAK(branchname);
-	if (!strbuf_check_branch_ref(&ref, branchname) &&
-	    ref_exists(ref.buf)) {
-		strbuf_release(&ref);
+
+	branch_exists = (!strbuf_check_branch_ref(&ref, branchname) &&
+			 ref_exists(ref.buf));
+	strbuf_release(&ref);
+	if (branch_exists)
 		return branchname;
-	}
 
 	*new_branch = branchname;
 	if (guess_remote) {
-- 
gitgitgadget

