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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2357C4338F
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 15:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABC8860F51
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 15:01:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234780AbhGZOVC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jul 2021 10:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234868AbhGZOUe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jul 2021 10:20:34 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2097BC061757
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 08:01:02 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id e2so11461641wrq.6
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 08:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=jUNdogEKLPG5m5Lj0U7xKNd51OK3bO41nSwe9gTxsOA=;
        b=iSrY1hC2doAQupu6MfJXUNB237KXiw1HlPnkyapL+9Ar/ZRtS+fwk3V4gcFxJn4enW
         yqgyCVWgq0Iyzr2qKPr9+3+lqCk3mGor9xXB8nwi8XGAHFt+tdEQkfihl0bQx7jWYgCN
         NEaI0iiz5pWZOBhEsLg88sfSzyyWlcX8/gEwvGNW82LGRrsD9jF13Une/ZXbP0Zz9BHB
         znAQsuO+xAn2FRyYbcES1aco67GDEZkS2pXl/ITVVyMFAhIQnF04NhgO5lCysm/1DDAg
         MOtPAq/jnR8V7rTest0dMR3gPqDhXox3+Q5wxN3cNX26k1EodfEJ/0hIsX//EVN30pnn
         L5DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jUNdogEKLPG5m5Lj0U7xKNd51OK3bO41nSwe9gTxsOA=;
        b=mBbcX02UIeW+LY9t8JGur5+rtP0CzAcJ8FMsQDl1rByWsCvXdnWh9g/muY0mkMN6np
         X9+VqcdlzjDNr9Kwjj44CUzmOYbQqMNw7fMzXu0JkZb0f4XanRovQ8dkuzuo66lME7RZ
         5muAwdXSkBT6m56Jz0DqR0xp7hE4llKLlpqjkX9kNqVWlOaXIKQbPyZE/GsE9mEyBxma
         ZdZ968xcUhgUJq2v/hh0ZWHh4GioaGkHdRBqmCKIlWK2mL5IdP8ZjBr7YzKtVTZuA6jg
         eiiUoIL7mNVlPukDd3PZgx8BrMJJ+N7ulPIAxy3SBZil+5NOmWaP8/0Js0+88VarxgQw
         qCCg==
X-Gm-Message-State: AOAM532pAJaWcoF7xRGlMLbLgeaYR/YZU6dft6NhKFuzJ89YAqP93LSA
        hBlCq0DxZWWJbBgOl73wLEwq2MAfJZc=
X-Google-Smtp-Source: ABdhPJxEn/vjG77Ah2QZIIm0oAnbFfwwkZy5AHO1xTcoG7vcRvnCNfG60jUA4aGBNKSER7OiHFSIvA==
X-Received: by 2002:a05:6000:108c:: with SMTP id y12mr459875wrw.293.1627311660751;
        Mon, 26 Jul 2021 08:01:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r4sm20439wre.84.2021.07.26.08.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 08:01:00 -0700 (PDT)
Message-Id: <pull.1003.git.1627311659384.gitgitgadget@gmail.com>
From:   "Oded S via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 26 Jul 2021 15:00:59 +0000
Subject: [PATCH] Fix git-bisect when show-branch is configured to run with
 pager
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Oded S <oded@istraresearch.com>,
        Oded Shimon <oded@istraresearch.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Oded Shimon <oded@istraresearch.com>

Signed-off-by: Oded Shimon <oded@istraresearch.com>
---
    Fix git-bisect when show-branch is configured to run with pager
    
    Signed-off-by: Oded Shimon oded@istraresearch.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1003%2Foded-ist%2Fmaster-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1003/oded-ist/master-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1003

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
