Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A727CC433B4
	for <git@archiver.kernel.org>; Sun, 16 May 2021 21:58:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F65161159
	for <git@archiver.kernel.org>; Sun, 16 May 2021 21:58:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbhEPV7X (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 May 2021 17:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbhEPV7V (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 May 2021 17:59:21 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E938C061573
        for <git@vger.kernel.org>; Sun, 16 May 2021 14:58:05 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id o17-20020a17090a9f91b029015cef5b3c50so4476654pjp.4
        for <git@vger.kernel.org>; Sun, 16 May 2021 14:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RMnWZ9Ep+2le7KCoWE0TFnyd3Vhz+RBXeeWqCdyXm5U=;
        b=MLJx41FehRJXaoRbra3EY+keG/UEoUlknddKYJPAOvfzA7UfDXKrJADKGa+fVxiBd7
         f2XAS5/9/iSU77cByG99Zrh5KeBgiG973oIozl4L6conAFjcAy7cy0MHLy5ESiDYlHi4
         YaB27NTj6Vlzdqc4RYB+IN/dqKryB+Z04aHCRhxkrgQxchAjG7xerjirdYxxuHGSHCbs
         v3YKOocvULebnK/RzHwyZH2hKBDeSAUUm62pWG0s9yenPrLitqreBGf5CERnhthYL6QN
         plUWOea4dOx+mAIRJ5DHRAsWMXle68mF3dEYeLwYFHsapvZ+XKEYlOCFmzZvpTtkYP/w
         NpQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RMnWZ9Ep+2le7KCoWE0TFnyd3Vhz+RBXeeWqCdyXm5U=;
        b=TzDvZSBzV3wyKUwuXnpOVLr/LFYcLWGliNtBcX9u/r5CEpXmxU9uAlZiaywDvNbKGP
         gzbeSZJGEs+gHZpvzoTVndChpcSHqXGGFbSFPpZKg8uyysHBu6SP6Z5PyX6+nRtkOvN1
         h9lxKF5EFzHcajcJHkcHKfU/+zypg+2OUYWql1jX4Bn9nwkjJyyWSUAaUZ3lc/M8jeiG
         5fRMFcxQOWrM0/Z0yjZNthlEqf6SMXH5oI0rDIU/BZot0NOOwOEXdmZD958E4hThJZX5
         s6XM1shh0b8MiAAXWUWfuKsrPtEJ7yZPgFbQ1TM1G2o+nFDVJFCIifxqONIIJw5Bn2in
         CXtg==
X-Gm-Message-State: AOAM530X0Mg3CcbwU8Z1eFt4GqX+1V+hLtx6WVMdKbGvI77OIKt4o0rL
        fwfCNWLN2veopnZ77AhCJHdPSFEuZI8=
X-Google-Smtp-Source: ABdhPJwSQ66YIUp9ViCHTkHRMbn8t7HK+cpcc732zj4yomKyeSi5Ze/Mbu0ReGgT0J2jbby24jYkJg==
X-Received: by 2002:a17:90a:d30b:: with SMTP id p11mr25949287pju.49.1621202284167;
        Sun, 16 May 2021 14:58:04 -0700 (PDT)
Received: from xavier.bn-i.net ([2001:470:b:65c:3ff0:7a20:2df8:dfc8])
        by smtp.gmail.com with ESMTPSA id g89sm10776572pjg.30.2021.05.16.14.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 May 2021 14:58:03 -0700 (PDT)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, ungureanupaulsebastian@gmail.com,
        t.gummerer@gmail.com, gitster@pobox.com
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH] stash: don't translate literal commands
Date:   Sun, 16 May 2021 15:57:04 -0600
Message-Id: <20210516215704.32440-1-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 builtin/stash.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index d68ed784d2..075bcf6ee5 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -26,7 +26,7 @@ static const char * const git_stash_usage[] = {
 	N_("git stash drop [-q|--quiet] [<stash>]"),
 	N_("git stash ( pop | apply ) [--index] [-q|--quiet] [<stash>]"),
 	N_("git stash branch <branchname> [<stash>]"),
-	N_("git stash clear"),
+	"git stash clear",
 	N_("git stash [push [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]\n"
 	   "          [-u|--include-untracked] [-a|--all] [-m|--message <message>]\n"
 	   "          [--pathspec-from-file=<file> [--pathspec-file-nul]]\n"
@@ -67,7 +67,7 @@ static const char * const git_stash_branch_usage[] = {
 };
 
 static const char * const git_stash_clear_usage[] = {
-	N_("git stash clear"),
+	"git stash clear",
 	NULL
 };
 
-- 
2.31.1

