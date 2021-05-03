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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D6F5C433ED
	for <git@archiver.kernel.org>; Mon,  3 May 2021 09:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31D806105A
	for <git@archiver.kernel.org>; Mon,  3 May 2021 09:11:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233049AbhECJMl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 May 2021 05:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbhECJMk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 May 2021 05:12:40 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 070C3C06174A
        for <git@vger.kernel.org>; Mon,  3 May 2021 02:11:48 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id x7so4725872wrw.10
        for <git@vger.kernel.org>; Mon, 03 May 2021 02:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=CF+fZeS0u1WpuvTK1zdXIQM+XXWhO1BeVGJqO6aHc98=;
        b=RHuGAcIg4uvFw8LRLfoJcCCZzVOu0e3LUiEkWEpZ/4VLphhSc3adqX9YT0JAx8qJfI
         5ZEn1o+C4f8vhTaSIEHIF4E6/D4WcO9TP7E4nAtKVFU6o80YB6NV7/U9jCb9muui2Kj8
         2xm+wJs1XVYoje3TkpX5cI/rKqZgWLeDUmsHMpfqkfBAoIvFSTxo5mr/O0t0H82Lqyow
         mpxRe4h2XfaMI4pqP1KzTJtIC6sfMDUUuFEzWsZ8woPGDqExkfRJ9V24TbnTSoI+KqtQ
         0b0eHxbEgxiBLM343TCAqiRYm0rRBVr6gC6ngx7BLtwl3KB0yfUztUYf67v7fOOnhECE
         77yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=CF+fZeS0u1WpuvTK1zdXIQM+XXWhO1BeVGJqO6aHc98=;
        b=G0X7AjC+QK2lGTt0aO2vCbOaX10nsMCFMD/M+nDrWDj2kA3F0+DImQ6p0yAwZHVpoz
         GyMQtJGOoU6bB0vvsJl5TDPxlzTWWTHeYxJp31wSdlF0RtsnkqpxtlBd4+0sLmv5EuQ2
         0tsof5ONQqy1VAkQDg11gBYp/wbHB7erH4osZLiRvmXOD541ii3PPi3GJ1t/H/juwSbO
         K5HVlhYCd1UplfEMxp9mXK+GtLeh4YRiPwlN9sDL0zPq3JOjyqJ18hQOyGAkixRWLEAp
         nVzrqOADsKkVY2htwPtxHD5qWyyE9KH7L7reWaGKak8mLw/kvON+k8ZzBODMmCZO8mIa
         7b+w==
X-Gm-Message-State: AOAM532rutBCw1R4rCUhYU4DI2MCzGSCFUCYG+RhxZ5bfmGCDjgLy171
        UMEZ2zkkm5QS+eqaCbqwBQsZ29xOA+s=
X-Google-Smtp-Source: ABdhPJytFz3adWCEDCMgqzttgg2XtkLA2VwZvRMH8+sayKd0/33hBTSwMiNxpWB54kANYPeuRss5Sw==
X-Received: by 2002:a5d:4532:: with SMTP id j18mr19876568wra.223.1620033106835;
        Mon, 03 May 2021 02:11:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l66sm6993905wmf.20.2021.05.03.02.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 02:11:46 -0700 (PDT)
Message-Id: <pull.942.v2.git.1620033105872.gitgitgadget@gmail.com>
In-Reply-To: <pull.942.git.1619682362363.gitgitgadget@gmail.com>
References: <pull.942.git.1619682362363.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 03 May 2021 09:11:45 +0000
Subject: [PATCH v2] fsmonitor: only enable it in non-bare repositories
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The entire point of the FSMonitor is to monitor the worktree changes in
a more efficient manner than `lstat()`ing all worktree files every time
we refresh the index.

But if there is no worktree, FSMonitor has nothing to monitor.

So let's ignore if an FSMonitor is configured (e.g. in `~/.gitconfig`)
and we're running in a repository without worktree.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    fsmonitor: only enable it in non-bare repositories
    
    For quite a while now, I run with the built-in FSMonitor via my user
    config. Happily, the only issue I ran into was that FSMonitor tried to
    run in a bare repository the other day. But an FSMonitor makes only
    sense if we have a worktree. So let's disable it automatically in bare
    repositories.
    
    This patch applies near the top of jh/rfc-builtin-fsmonitor. I would
    like to keep it as a separate topic because the built-in FSMonitor did
    not introduce this bug. This bug has been in Git's FSMonitor feature for
    a long, long time.
    
    Changes since v1:
    
     * Using NULL instead of 0 (d'oh!)

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-942%2Fdscho%2Fbare-repositories-need-no-fsmonitor-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-942/dscho/bare-repositories-need-no-fsmonitor-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/942

Range-diff vs v1:

 1:  3a93be538d33 ! 1:  95333bbf45d5 fsmonitor: only enable it in non-bare repositories
     @@ config.c: int git_config_get_max_percent_split_change(void)
       {
      +	if (!r->worktree) {
      +		/* FSMonitor makes no sense in bare repositories */
     -+		core_fsmonitor = 0;
     ++		core_fsmonitor = NULL;
      +		return 1;
      +	}
      +


 config.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/config.c b/config.c
index 53e7dedc60de..90ce4c23d3dc 100644
--- a/config.c
+++ b/config.c
@@ -2515,6 +2515,12 @@ int git_config_get_max_percent_split_change(void)
 
 int repo_config_get_fsmonitor(struct repository *r)
 {
+	if (!r->worktree) {
+		/* FSMonitor makes no sense in bare repositories */
+		core_fsmonitor = NULL;
+		return 1;
+	}
+
 	if (r->settings.use_builtin_fsmonitor > 0) {
 		core_fsmonitor = "(built-in daemon)";
 		return 1;

base-commit: 14d50074ff19e68e7a8d718b22d138882087bbc9
-- 
gitgitgadget
