Return-Path: <SRS0=6g9E=62=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B12A1C54E4A
	for <git@archiver.kernel.org>; Tue, 12 May 2020 13:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A6A1206DD
	for <git@archiver.kernel.org>; Tue, 12 May 2020 13:16:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gcOcSoDa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729900AbgELNQC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 May 2020 09:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726891AbgELNQC (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 12 May 2020 09:16:02 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17173C061A0C
        for <git@vger.kernel.org>; Tue, 12 May 2020 06:16:02 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id d207so6421051wmd.0
        for <git@vger.kernel.org>; Tue, 12 May 2020 06:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Gr4bv7MAwLQJvHPspllB/d0EOsAw06fMdNZhoXoaZ78=;
        b=gcOcSoDa5E30dNbGWeGccr4vgVhkf0JanXgESb4WKdsgutoG0A6jrNZgKW9Jba78oV
         vxyxbHsgNT/cxYASKoe6QOSG5yrtn/jmLwY2qe75LTbMpBqYUFqx7v7PWMWYyohl8Y4p
         YtqzIE+6ZO7HqjHbbERsrqOW1XInuvMG4QtjtUVGlA66COT4ShCge1VQ6S9pOLyhCZTO
         VjupXlCIvtC+B1uyCs2QFK+owVTs97X0uCre7u7dCCSHbR8KtyDZ9Uz75NydvDl6dSvG
         yyL29l1HEJKBYsAJqxbBKg3umi7lXtCQwuITjHYlsGFWs/bGt6nz9G2NqESfXIh0TNX7
         hbuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Gr4bv7MAwLQJvHPspllB/d0EOsAw06fMdNZhoXoaZ78=;
        b=S0vqIU2hnLGd1qx3q5emGjA896wNH+fBeff5iQlgWUvlnDlB0brYaYsSo4YZzWjkD6
         tVZO9OePTzfL4my4/s888Fuq2BGCgsSE5N9ZpGkg6WdAi7jr+LVHHg5Shlmh3enJcT2K
         kGQxMLXpB3MvuUFk1RhXC835YPFdzNklHN0L72s9MCuvO/OGr4XGa7joTCCMx8awTr9a
         It4dhz9Aviy38EdbdslWEjH86OpVNCl3EyTv7FlmnqL+nq6bpDhnO11MxnLtXG+NqGaV
         WzD4E2mFPL9Jkipt372X5ebjBwmUi6ubIthfnZQIZo+mIzPFFZF882bzXlx2aNBhnj2L
         cwuQ==
X-Gm-Message-State: AGi0PuYlaXx7H6qyBmew4rFIRYqSVuqbvasnPvHcmyxF5I39/t1nF8c8
        gbGBPruoT99WIi+o4KBLNh7RoSds
X-Google-Smtp-Source: APiQypKLEQIwMncEIUAeU2kohRpQl3c3Nmrq45aUGZwSUbZ2Lm1WHIMDiZzcu8dg527xVNpx+X5TSg==
X-Received: by 2002:a05:600c:2197:: with SMTP id e23mr13050301wme.162.1589289360672;
        Tue, 12 May 2020 06:16:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t6sm7126090wma.4.2020.05.12.06.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 06:15:59 -0700 (PDT)
Message-Id: <pull.775.v2.git.git.1589289359302.gitgitgadget@gmail.com>
In-Reply-To: <pull.775.git.git.1588352952840.gitgitgadget@gmail.com>
References: <pull.775.git.git.1588352952840.gitgitgadget@gmail.com>
From:   "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 12 May 2020 13:15:59 +0000
Subject: [PATCH v2] git-p4.py: fix --prepare-p4-only error with multiple
 commits
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Ben Keene <seraphire@gmail.com>, Ben Keene <seraphire@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ben Keene <seraphire@gmail.com>

When using git p4 submit with the --prepare-p4-only option, the program
should prepare a single p4 changelist and notify the user that more
commits are pending and then stop processing.

A bug has been introduced by the p4-changelist hook feature that
causes the program to continue to try and process all pending
changelists at the same time.

The function applyCommit returns True when applying the commit
was successful and the program should continue. However, when the
optional flag --prepare-p4-only is set, the program should stop
after the first application.

Change the logic in the run method for P4Submit to check for the
flag --prepare-p4-only after successfully completing the applyCommit
method.

Be aware - this change will fix the existing test error in t9807.23
for --prepare-p4-only. However there is insufficent coverage for
this flag.  If more than 1 commit is pending submission to P4, the
method will properly prepare the P4 changelist, however it will
still exit the application with an exitcode of 1.

The current documentation does not define what the exit code should be
in this condition.
(See: https://git-scm.com/docs/git-p4#Documentation/git-p4.txt---prepare-p4-only)

Signed-off-by: Ben Keene <seraphire@gmail.com>
---
    git-p4.py: fix --prepare-p4-only error with multiple commits
    
    When using git p4 submit with the --prepare-p4-only option, the program
    should prepare a single p4 changelist and notify the user that more
    commits are pending and then stop processing.
    
    A bug has been introduced by the p4-changelist hook feature that causes
    the program to continue to try and process all pending changelists at
    the same time.
    
    The function applyCommit should return True when applying the commit was
    successful and the program should continue. In the case of the
    --prepare-p4-only flag, the function should return False, alerting the
    caller that the program should not proceed with additional commits.
    
    Change the return value from True to False in the applyCommit function
    when git-p4 is executed with --prepare-p4-only flag.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-775%2Fseraphire%2Fseraphire%2Fp4-hook-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-775/seraphire/seraphire/p4-hook-v2
Pull-Request: https://github.com/git/git/pull/775

Range-diff vs v1:

 1:  57a34af2b86 < -:  ----------- git-p4.py: fix --prepare-p4-only error with multiple commits
 -:  ----------- > 1:  a554a65503e git-p4.py: fix --prepare-p4-only error with multiple commits


 git-p4.py | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index b8b2a1679e7..c4a4012bcc1 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -2537,11 +2537,12 @@ def run(self, args):
                 ok = self.applyCommit(commit)
             if ok:
                 applied.append(commit)
-            else:
-                if self.prepare_p4_only and i < last:
-                    print("Processing only the first commit due to option" \
-                          " --prepare-p4-only")
+                if self.prepare_p4_only:
+                    if i < last:
+                        print("Processing only the first commit due to option" \
+                                " --prepare-p4-only")
                     break
+            else:
                 if i < last:
                     # prompt for what to do, or use the option/variable
                     if self.conflict_behavior == "ask":

base-commit: 07d8ea56f2ecb64b75b92264770c0a664231ce17
-- 
gitgitgadget
