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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D0EBC433ED
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 07:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4F9561440
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 07:46:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239520AbhD2Hqw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Apr 2021 03:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237310AbhD2Hqu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Apr 2021 03:46:50 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CBC6C06138B
        for <git@vger.kernel.org>; Thu, 29 Apr 2021 00:46:04 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id q9so11608100wrs.6
        for <git@vger.kernel.org>; Thu, 29 Apr 2021 00:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=l4Qsi8J5QO1DiUg8QXGmY4dluIEC7/2M+cX4DBm2Or8=;
        b=tORf2xR5IwFTSG79xhBX8lzgfuN69UPtusrjMmxn8g5t2M4wriZTpwozbl1r4boWvy
         vRfudRB+37+fO49JABRJEd+GOBuHPphgmlUJ2qa5lwA2NQqPFDyd1X43ToCzGPZbMiTH
         71Q10DoSWYPYVMv7HcAVCzNGb+ANuwHsvyu5VogdCSQdbD3OIg+HFQtTP292hkmFfySJ
         ptJE3mw0eiRNloOOB68NENbof6riswcJQSKAChHdEl7fS9ZivcfJya/VBNY3eOGGHjW3
         HWBTr1pnhb42kTcFb6FzryABgeMiyFeCSOhCKjGeOgZ0IMxDLicINCl+z7DcPPqDIbXz
         5Odw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=l4Qsi8J5QO1DiUg8QXGmY4dluIEC7/2M+cX4DBm2Or8=;
        b=Xaet2K1GEgL2eaoyoI4gEkSTdBKXH5Sp23Y+JYrMlZrrD0ugvu5NYp2EB9F2epE40t
         ct2e1Sm3h5fcdQyteKYGrwDNNwO4fRZNs4TBWFrUpTgIHyAL5izQuZdku0ftYlGct6t+
         cHzP2pTBqTX+WbUb92HYnQO6nj8TqFA4CvX0YQ4qnSmA6k6v3fYVQlxQBtOO00oRfpp1
         GsI4OCbZy2QxniONwlSaCXUQj5Rfh25Lz2TfS5b5Gptw7x5hw3TRsB+3GbBiBQZAI803
         En/DH2q3SV72xfE0OB+L5aEE8kFY6K0nMLBjoibROzm0EQzoUUpLKI6sTBuxv0XkG/6F
         um7w==
X-Gm-Message-State: AOAM530WWbSMYZ3X4LnUAyF93mYK15C65W7u/vQHnR05jGMaZYwKLI++
        q+AXgFFBHnmbQLkLH0lL3tHNctP9zQ4=
X-Google-Smtp-Source: ABdhPJwKqvpeg5N+eLeqO7L8IAaDhvDyUl0GS05jzm5LmYSLzRDnwjILL0Ni2FfS1cp6WhlbRe/Keg==
X-Received: by 2002:a05:6000:1547:: with SMTP id 7mr9401998wry.388.1619682363204;
        Thu, 29 Apr 2021 00:46:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t12sm3436871wrs.42.2021.04.29.00.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 00:46:02 -0700 (PDT)
Message-Id: <pull.942.git.1619682362363.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 29 Apr 2021 07:46:01 +0000
Subject: [PATCH] fsmonitor: only enable it in non-bare repositories
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
    
    Since I released Git for Windows v2.31.0, with brief interruption of two
    weeks, I enabled the built-in FSMonitor via my user config, and today
    was the first time I did anything in a bare repository. I was somewhat
    surprised that FSMonitor gave me trouble there, as the FSMonitor does
    not even make sense there...
    
    This patch applies on top of jh/rfc-builtin-fsmonitor (not because it
    fixes a problem in the built-in FSMonitor, the bug existed for a long,
    long time before those patches, but because it would otherwise cause
    merge conflicts with that patch series).

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-942%2Fdscho%2Fbare-repositories-need-no-fsmonitor-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-942/dscho/bare-repositories-need-no-fsmonitor-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/942

 config.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/config.c b/config.c
index 53e7dedc60de..fc5e744d81ca 100644
--- a/config.c
+++ b/config.c
@@ -2515,6 +2515,12 @@ int git_config_get_max_percent_split_change(void)
 
 int repo_config_get_fsmonitor(struct repository *r)
 {
+	if (!r->worktree) {
+		/* FSMonitor makes no sense in bare repositories */
+		core_fsmonitor = 0;
+		return 1;
+	}
+
 	if (r->settings.use_builtin_fsmonitor > 0) {
 		core_fsmonitor = "(built-in daemon)";
 		return 1;

base-commit: 14d50074ff19e68e7a8d718b22d138882087bbc9
-- 
gitgitgadget
