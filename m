Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4043DC433FE
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 08:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A11061154
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 08:29:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348163AbhIHIao (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 04:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348098AbhIHIam (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 04:30:42 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17488C06175F
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 01:29:35 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id q26so1971960wrc.7
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 01:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=p+x9BvFGhU04iV74kIWz4YoTMzxuqJHJw5UUhuR/gc4=;
        b=ZyoustQLLtSv1J7lDBz6cj17GEjBnsmTSzBcFum8To2s+AEjFMv1iU0KWz+OiJSE+Q
         YrhQWOhKRU445vMDrKst4S+wmbs9sPfiV8e0HSNJ2fmRo1xnOaGV/rnbQidoFLyPi+rM
         2oV0ksH0Y3AxLzOOQzPb6gFENfuYFZ4MySJ8N6hjKKVRQwNrBo8BCGIj4vI7B31ZNkk/
         UXu7IflH2xH9gKVHZN8SPXS8dRgs8OorB+iOSYMJ5IA25JV2WSMKKsKhT946CV2jwRi1
         OgB9BUOkRZTlirmHl2UqmHARurk3k4Qi7xq/JJ957QXQ2Rgf0i8CbEO2YMRsdOz0JlXJ
         owjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=p+x9BvFGhU04iV74kIWz4YoTMzxuqJHJw5UUhuR/gc4=;
        b=OZyITNxFmXbRDpcV7iYStOiZLW7ZlPGHpbJSebb6namuOHj1uZJGk3oyXw3CpbHmVw
         WTBbs1iS0vxrflpS2J7LCdXwP+RsGP2OYXrMGYMMzjAdMSyLUypwhSdBkx2ZJzEp69it
         +b3aOEiJkVluWtOf5JNVwZ/teQQWhfSMUq5nH+E4OWa2mg8PHquJkH32el5sQr5Vs6hy
         Tzyu/R4yKpW+iTiNlApCuU4ytxw2eesqzS/AeWQPJlIgAdH9ieXTqgoXSR9xP1fnZauq
         tv47eiml3m12oo0FsmRmi/spiDkdRsCrQEG9858rJiDFoBfwdPNYISvi1TrxvFH1g9+a
         08qg==
X-Gm-Message-State: AOAM532q4bK2J4tUIm4nJI82NquH9Tixf7bUnPUseSaYnfdAziBGT6ls
        Ztz2ONPt/wCzcUw2M35cXbuA0E0I5OE=
X-Google-Smtp-Source: ABdhPJwGxZgT0R44LJM6ogEpSrSO93L2gB+c23YgCQ8MuTetOymgF9AyU0YhM2L3POOw8mK+xfoQFQ==
X-Received: by 2002:a5d:4e47:: with SMTP id r7mr1193448wrt.417.1631089773671;
        Wed, 08 Sep 2021 01:29:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t14sm1326174wmi.12.2021.09.08.01.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 01:29:33 -0700 (PDT)
Message-Id: <0e956ae7bba906277c77103ae329bce6d6da4cfe.1631089771.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1032.git.1631089771.gitgitgadget@gmail.com>
References: <pull.1032.git.1631089771.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 08 Sep 2021 08:29:31 +0000
Subject: [PATCH 2/2] pull: release packs before fetching
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

On Windows, files cannot be removed nor renamed if there are still
handles held by a process. To remedy that, we try to release all open
handles to any `.pack` file before e.g. repacking (which would want to
remove the original `.pack` file(s) after it is done).

Since the `read_cache_unmerged()` and/or the `get_oid()` call in `git
pull` can cause `.pack` files to be opened, we need to release the open
handles before calling `git fetch`: the latter process might want to
spawn an auto-gc, which in turn might want to repack the objects.

This commit is similar in spirit to 5bdece0d705 (gc/repack: release
packs when needed, 2018-12-15).

This fixes https://github.com/git-for-windows/git/issues/3336.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/pull.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/pull.c b/builtin/pull.c
index 3e13f810843..d9f0156d969 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -26,6 +26,7 @@
 #include "wt-status.h"
 #include "commit-reach.h"
 #include "sequencer.h"
+#include "packfile.h"
 
 /**
  * Parses the value of --rebase. If value is a false value, returns
@@ -998,6 +999,7 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 			oidclr(&rebase_fork_point);
 	}
 
+	close_object_store(the_repository->objects);
 	if (run_fetch(repo, refspecs))
 		return 1;
 
-- 
gitgitgadget
