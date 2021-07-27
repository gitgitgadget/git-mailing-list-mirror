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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94152C4338F
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 08:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D18260F59
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 08:12:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235837AbhG0IMp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jul 2021 04:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235629AbhG0IMo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jul 2021 04:12:44 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD355C061757
        for <git@vger.kernel.org>; Tue, 27 Jul 2021 01:12:43 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id a192-20020a1c7fc90000b0290253b32e8796so889605wmd.0
        for <git@vger.kernel.org>; Tue, 27 Jul 2021 01:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2y/Q83ggfUFJ54rwoxh8+qoHBj4YuVNPLs4IgaATFAM=;
        b=jFN45gXfCF1Ge+ToLAte2Y651bq2FhTEXRoNZUCZxPcagZJ9DY0btzY60OuRbu7QBy
         rRdSn3W6r3vxJ1gbLCRtc2WWwzN0szdZvTpqSZWe2vMASfaMaLQLblbm+C3tBOGf5jVr
         H8P24RTMY/LF2pRoplWsKPlg3erJ8uf3pCcvSdyLi9V+cnbETRl50aSLkIzu4lzrb7wk
         O4xE9zlG8n3C6xJF7tjr8gRKkblZk2e/JYPbw4D1WqzzFEdaocsi4F11acz+K+UwiidA
         2IU6UD/XhOpwAYAtP2mkyYNMEGTcG5wKUOQ6ZsaFERjKIT6WruJJcG/cla0yAA3Km+rT
         aMrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=2y/Q83ggfUFJ54rwoxh8+qoHBj4YuVNPLs4IgaATFAM=;
        b=GG4/s/m1GhCcVtxRDlhcEb+FWziGWWVlGZeMZSe5l42l7u4YK47I0mQ7a2IpTWuHMy
         HQuYVTdeR1S8OT0EiaMLI4xxw+YdSn2AGXH+zGLuRXlm4+YaWuMWuP3piXAvD49DP82F
         R9VWEkfzRd0oUU4vEi+QKNyFHuQMWcYbcjT6m9U/t4uzZwV88DI2o8QJB8vQ9apZ4l2+
         hqUkKaZhR7WOADGxy9sxF5tIN/HdbRzpJaaZw5CCM2gCLzgMskaBMa4uOx+lWqNBfdnT
         +W9AZ9QoQBetnfMeszQsfyBsW2YsMIUlJDRMLAv/fMHNKqbxkxJ7jUC+xr4ULirX8KXt
         0FnQ==
X-Gm-Message-State: AOAM533D1D8Y1DBDxQ0efOEA3KX3AmQz7bAnmqbVWbNafy5p48Sz112/
        iEk6dX89GJPIgckoWdDLXGF6ztlbegE=
X-Google-Smtp-Source: ABdhPJy40LJSpSwqKd3ZUfFUm1uoAPM4NooUx+PYyP6qdg/JDL66LcTEn9WGhb84PI2MJnIt+6HLeQ==
X-Received: by 2002:a1c:3505:: with SMTP id c5mr2720367wma.53.1627373562411;
        Tue, 27 Jul 2021 01:12:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o17sm2079699wmp.31.2021.07.27.01.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 01:12:41 -0700 (PDT)
Message-Id: <pull.1003.v2.git.1627373560881.gitgitgadget@gmail.com>
In-Reply-To: <pull.1003.git.1627311659384.gitgitgadget@gmail.com>
References: <pull.1003.git.1627311659384.gitgitgadget@gmail.com>
From:   "Oded S via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 27 Jul 2021 08:12:40 +0000
Subject: [PATCH v2] bisect: disable pager while invoking show-branch
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>,
        Oded S <oded@istraresearch.com>,
        Oded Shimon <oded@istraresearch.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Oded Shimon <oded@istraresearch.com>

git-bisect uses show-branch for logging during the bisect process. If the user
sets an interactive pager for show-branch, this makes bisect hang (wait for
user input) unexpectedly - so we disable pager with -P.

It's possible that the user would set a pager for git-checkout as well, but an
interactive pager there would break many more scripts.

Signed-off-by: Oded Shimon <oded@istraresearch.com>
---
    Fix git-bisect when show-branch is configured to run with pager
    
    Signed-off-by: Oded Shimon oded@istraresearch.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1003%2Foded-ist%2Fmaster-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1003/oded-ist/master-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1003

Range-diff vs v1:

 1:  52eff18191b ! 1:  c193f3a556f Fix git-bisect when show-branch is configured to run with pager
     @@ Metadata
      Author: Oded Shimon <oded@istraresearch.com>
      
       ## Commit message ##
     -    Fix git-bisect when show-branch is configured to run with pager
     +    bisect: disable pager while invoking show-branch
     +
     +    git-bisect uses show-branch for logging during the bisect process. If the user
     +    sets an interactive pager for show-branch, this makes bisect hang (wait for
     +    user input) unexpectedly - so we disable pager with -P.
     +
     +    It's possible that the user would set a pager for git-checkout as well, but an
     +    interactive pager there would break many more scripts.
      
          Signed-off-by: Oded Shimon <oded@istraresearch.com>
      


 bisect.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/bisect.c b/bisect.c
index af2863d044b..c02bcc3359f 100644
--- a/bisect.c
+++ b/bisect.c
@@ -23,7 +23,7 @@ static struct oid_array skipped_revs;
 static struct object_id *current_bad_oid;
 
 static const char *argv_checkout[] = {"checkout", "-q", NULL, "--", NULL};
-static const char *argv_show_branch[] = {"show-branch", NULL, NULL};
+static const char *argv_show_branch[] = {"-P", "show-branch", NULL, NULL};
 
 static const char *term_bad;
 static const char *term_good;
@@ -748,7 +748,7 @@ static enum bisect_error bisect_checkout(const struct object_id *bisect_rev, int
 			return -abs(res);
 	}
 
-	argv_show_branch[1] = bisect_rev_hex;
+	argv_show_branch[2] = bisect_rev_hex;
 	res = run_command_v_opt(argv_show_branch, RUN_GIT_CMD);
 	/*
 	 * Errors in `run_command()` itself, signaled by res < 0,

base-commit: eb27b338a3e71c7c4079fbac8aeae3f8fbb5c687
-- 
gitgitgadget
