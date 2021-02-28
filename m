Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88FBEC433DB
	for <git@archiver.kernel.org>; Sun, 28 Feb 2021 04:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B77E64E4A
	for <git@archiver.kernel.org>; Sun, 28 Feb 2021 04:00:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbhB1D75 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Feb 2021 22:59:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbhB1D7v (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Feb 2021 22:59:51 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B3FC06178C
        for <git@vger.kernel.org>; Sat, 27 Feb 2021 19:58:32 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id f12so8703670wrx.8
        for <git@vger.kernel.org>; Sat, 27 Feb 2021 19:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=D0Uir+rhhF+WjYNrc7vEgebea/JdT67xx/aFC/0Z1LU=;
        b=Lm791Y0qY9PpERotd4A5ZAzYDJsPPqfsVGa9fDjDHWqjQAyX3EZ2QFFGXeAGQPs/E9
         Et0WdA6Jb57jmNxeIxPNTPYCVpUUvle8upB64uck9s6tzJ/1Rpt+GMGlPrM7Fc2bT8H6
         29eJeNZ6UZeBt5OX1h+/IghYBIdpyS70Rm6Cq3Wqb3gWaDg1iYPFSIUeAZ0SrB6iNMmJ
         OhriNu6/SUlncs+sdFOoC+WImKeb+di8OerYX8PSLXzRHCoRgigIKkO192O9gDtj6/74
         xUQLdoFWcd6IQlSfPtz0G+0o+6spjIoQPUCFbP3X3F2O5MRCwzcHbau9wlq2HVZGqq40
         X7gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=D0Uir+rhhF+WjYNrc7vEgebea/JdT67xx/aFC/0Z1LU=;
        b=PRNSa8LvQZu8+k98RRVFdZ3wA2AvnsxFjxAFDr/Ero9x8TkWGk5UPUO/PyXpdnL8dX
         iViYXnx26lwHk9Z3fhjzLMyaYaF3QmNj+heiv2ojJpAWfVnnwojqvOsZyEUUwWN2o5oi
         oY7jch4N0tSfuJWZbNjeQOi2jQ7b99PmMRGSMHvXIdBkWp8EaUGbmV6DQi0TFqCOkm9V
         lTdysYrlhOHRu26bYZKudNcUW64Atw9FgXU93/2rMGoec0kMkHHA918O/31xnrGKW4qb
         sAaBmzoQSy/q0ME0zNWi735zizyWUzS4jJob7Czu4oHn6IJncaHKZvtBy1VtJTLFpwgW
         ofGQ==
X-Gm-Message-State: AOAM530WRwQR1FLSdoj+Av4NYlfZa3/OZOHoe/t5gBLBkuOckflXo9kH
        WX8/z7BFFL2uHuOcJhfzeSD8pggYalY=
X-Google-Smtp-Source: ABdhPJxnZlYTJ5ax3pbFXY5mrgbCZWZXSwIviAO8zig8jdraztsVnabBvdDhMbFcJBxg+u6VJVFtHg==
X-Received: by 2002:adf:ce0a:: with SMTP id p10mr10319153wrn.255.1614484711340;
        Sat, 27 Feb 2021 19:58:31 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f9sm13408147wro.77.2021.02.27.19.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Feb 2021 19:58:31 -0800 (PST)
Message-Id: <6b20977a5a811e3f3038aec58f615b621139f24b.1614484707.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.845.git.1614484707.gitgitgadget@gmail.com>
References: <pull.845.git.1614484707.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 28 Feb 2021 03:58:24 +0000
Subject: [PATCH 6/8] merge-ort: use relevant_sources to filter possible rename
 sources
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

The past several commits determined conditions when rename sources might
be needed, and filled a relevant_sources strset with those paths.  Pass
these along to diffcore_rename_extended() to use to limit the sources
that we need to detect renames for.

For the testcases mentioned in commit 557ac0350d ("merge-ort: begin
performance work; instrument with trace2_region_* calls", 2020-10-28),
this change improves the performance as follows:

                            Before                  After
    no-renames:       12.596 s ±  0.061 s     6.003 s ±  0.048 s
    mega-renames:    130.465 s ±  0.259 s   114.009 s ±  0.236 s
    just-one-mega:     3.958 s ±  0.010 s     3.489 s ±  0.017 s

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/merge-ort.c b/merge-ort.c
index 27acaa7380be..66892c63cee2 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -2209,7 +2209,7 @@ static void detect_regular_renames(struct merge_options *opt,
 	diff_queued_diff = renames->pairs[side_index];
 	trace2_region_enter("diff", "diffcore_rename", opt->repo);
 	diffcore_rename_extended(&diff_opts,
-				 NULL,
+				 &renames->relevant_sources[side_index],
 				 &renames->dirs_removed[side_index],
 				 &renames->dir_rename_count[side_index]);
 	trace2_region_leave("diff", "diffcore_rename", opt->repo);
-- 
gitgitgadget

