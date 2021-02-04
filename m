Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B601AC433DB
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 20:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6586464F76
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 20:15:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239397AbhBDUPC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Feb 2021 15:15:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240000AbhBDUIi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Feb 2021 15:08:38 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B8BC061788
        for <git@vger.kernel.org>; Thu,  4 Feb 2021 12:07:58 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id y187so4092914wmd.3
        for <git@vger.kernel.org>; Thu, 04 Feb 2021 12:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=VORLwtUUvBY30GqFiNijFLxV5rRrjyLP+YPskiY9VhE=;
        b=otNsuvERHj+V7SCxAiKic3d4/nR9uFdATW5Nwr1ZeM9Pgic9TITL3sO29DJ3VrxiyG
         RgQGzuflUOnkCOI3ugbcSBDGNdEXpFwRkzfxVrPvJ6CmCIHAJqEK/P1NVgcsto8fh+Am
         Bocp2CFcSlCPZd8+UyD4cgsKjU13R0P72pkYSFSWmJsH8o/KncucjHVT/qyf5NbhuJo0
         JAJt3oQNveGSBmOfK+FTwutuIH9G/WASEN3UvYr670aIK13pNRgjBB3NLmrf6U0xHu7v
         5j3e/wlFvgbWAkQOlsIjPXdMP0nvO16cb/XJySnAKObXc73qHGH+9sxJhrW4Wk3y8kKb
         L9/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=VORLwtUUvBY30GqFiNijFLxV5rRrjyLP+YPskiY9VhE=;
        b=ffsYu5V1mkRJmTlPb1yChhmcK2dEusYPzgFREvOSpqJkaBI4bopm0YYvUCMQvesqCZ
         z28qM0N0RVng4miAubQJGHr2s3QgLkSaB0C0ygaU+D44ggiepZJ0CdVDL39i2d63bGu5
         eXJoDWMatHdCcJvTrw8KWl8t+GnDgo407MoA8zmDAhE1J/okJ1eA/1v5derjWDy8vxDf
         Zm39GTJfMLa2EpZY48J/4Hl7mSv9e9IpcNEm5k022z4C0HuaM59QWi6G9wYq985lzpuB
         4D1duOEftUAkHAMCrwrSsQP9K8QItX2YgVtZIdeq8+znIz6jYqYlKvGgjwiLLZvbN2ZJ
         V0nw==
X-Gm-Message-State: AOAM533H/oSs9ZLYa29JMxj8mvRxoHP1zlsOsyavYZEIHFIZKlo7RHSY
        WLvACQbtHxWhnRcS4gsZ6+qkwyXV3/0=
X-Google-Smtp-Source: ABdhPJxIFrG3wG7ikB6lJ09Mqdo9MWI5HevbkuFm+CL+/6Fqumx523J2sHWmMqaEZmbivsWIMo7f9A==
X-Received: by 2002:a1c:2403:: with SMTP id k3mr727751wmk.130.1612469277092;
        Thu, 04 Feb 2021 12:07:57 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z15sm8975459wrt.8.2021.02.04.12.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 12:07:56 -0800 (PST)
Message-Id: <5f2f06b79e208b68f3c753538f2b081729765b82.1612469275.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.869.git.1612469275.gitgitgadget@gmail.com>
References: <pull.869.git.1612469275.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 04 Feb 2021 20:07:49 +0000
Subject: [PATCH 1/6] range-diff: avoid leaking memory in two error code paths
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

In the code paths in question, we already release a lot of memory, but
the `current_filename` variable was missed. Fix that.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 range-diff.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/range-diff.c b/range-diff.c
index 0c6ac4f954d1..963cdecb4cbb 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -97,6 +97,7 @@ static int read_patches(const char *range, struct string_list *list,
 			if (get_oid(p, &util->oid)) {
 				error(_("could not parse commit '%s'"), p);
 				free(util);
+				free(current_filename);
 				string_list_clear(list, 1);
 				strbuf_release(&buf);
 				strbuf_release(&contents);
@@ -112,6 +113,7 @@ static int read_patches(const char *range, struct string_list *list,
 			error(_("could not parse first line of `log` output: "
 				"did not start with 'commit ': '%s'"),
 			      line);
+			free(current_filename);
 			string_list_clear(list, 1);
 			strbuf_release(&buf);
 			strbuf_release(&contents);
-- 
gitgitgadget

