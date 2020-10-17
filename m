Return-Path: <SRS0=oQO4=DY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18663C433E7
	for <git@archiver.kernel.org>; Sat, 17 Oct 2020 21:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D87F5207BC
	for <git@archiver.kernel.org>; Sat, 17 Oct 2020 21:04:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N8+GRjcn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439464AbgJQVEo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Oct 2020 17:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439457AbgJQVEn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Oct 2020 17:04:43 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20928C0613CE
        for <git@vger.kernel.org>; Sat, 17 Oct 2020 14:04:43 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id p15so6674599wmi.4
        for <git@vger.kernel.org>; Sat, 17 Oct 2020 14:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fiM/7tQv3ckg1OC9FGkO5P4pSEVpKlahFOZem86XI6s=;
        b=N8+GRjcnKI9z8/9/+7spyMjHtSo6L+wwoHhQQCmut8DiMODU8XNmERfbSp3K8N3RAL
         GG0EgTD0syr6IlYQ7nMBLlXSXy8gA4dSQEUhaw1FVeB4mQl9gkI/od/tyDmtwesXreQt
         S7V+0G7ileESrW0iQIwr3wAYYqfp9wwSuvDGD5YR/595QkVPzpy2UM8Z7vgjTMcF8+CF
         MBJ5agO10D30p6b5tvdEGNNJPUmUDf9awMIOJdd5zrA7SAei/OoR6jmnRRXoewMjW97o
         F44Pd+XAzP9AViWUnHC493FDpeky9JskHI+DeXQ9qp+V0DEb2WZFEBd7O7FpPQO96aem
         xO/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=fiM/7tQv3ckg1OC9FGkO5P4pSEVpKlahFOZem86XI6s=;
        b=Te8jaV72vthgJQF2vB/iARFMEp3KZ6fvLd0ss6kqt01YjGSkrcaEe1jDS9MBc2HRLN
         9uNCIeNV8YqBTNa2WuM4JT+grlhshbzI2kc5G/pZWu4ksxRpxG8oC4vdMO9bpDfEmaAU
         x7Nr8S4hTW1p+1o37d6cMQAo4uw8taieQvatymWSQ0Dso0izI+4gjLNKcqEa+y52c1I8
         nhl65jHAyoA7BYzlJwTQWcdVASH9OG6XX5eckZ+qoOZpXtF1xvET3aiJDbP2OSJ8MWkC
         An8aBH1LosahnLYcc0fPAW2l8dxiAMqHJHv0QxdNStIq/3mgf0ZWiBl9AvVjkckJRVa1
         uZrA==
X-Gm-Message-State: AOAM533UDsGf2Lr0IKNit0P97zAHUZqTli0TJ12B0Hq+XVY/wGSjRRHs
        aYvbI9v7nn8zgiINHkAWrh3cvTV7KPo=
X-Google-Smtp-Source: ABdhPJw6/Vb+I2cL9jiarqk2uTBu9AN3JiNb4xgyib9s8tDEQRWtaCR4O0NentJhYJMbKNnTYYflKQ==
X-Received: by 2002:a1c:2905:: with SMTP id p5mr10174937wmp.187.1602968681708;
        Sat, 17 Oct 2020 14:04:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o194sm9016001wme.24.2020.10.17.14.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2020 14:04:41 -0700 (PDT)
Message-Id: <0613b07676e8abd0b4f342784b94d11174981537.1602968677.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.756.git.1602968677.gitgitgadget@gmail.com>
References: <pull.756.git.1602968677.gitgitgadget@gmail.com>
From:   "Nipunn Koorapati via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 17 Oct 2020 21:04:36 +0000
Subject: [PATCH 4/4] t/perf: add fsmonitor perf test for git diff
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>, Utsav Shah <utsav@dropbox.com>,
        Nipunn Koorapati <nipunn1313@gmail.com>,
        Nipunn Koorapati <nipunn@dropbox.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Nipunn Koorapati <nipunn@dropbox.com>

Results for the git-diff fsmonitor optimization
in patch in the parent-rev (using a 400k file repo to test)

As you can see here - git diff with fsmonitor running is
significantly better with this patch series (80% faster on my
workload)!

On master (2.29)

Test                                                             this tree
--------------------------------------------------------------------------------
7519.2: status (fsmonitor=.git/hooks/fsmonitor-watchman)         0.39(0.33+0.06)
7519.3: status -uno (fsmonitor=.git/hooks/fsmonitor-watchman)    0.17(0.13+0.05)
7519.4: status -uall (fsmonitor=.git/hooks/fsmonitor-watchman)   1.34(0.77+0.56)
7519.5: diff (fsmonitor=.git/hooks/fsmonitor-watchman)           0.82(0.24+0.58)
7519.7: status (fsmonitor=)                                      0.70(0.53+0.90)
7519.8: status -uno (fsmonitor=)                                 0.37(0.32+0.78)
7519.9: status -uall (fsmonitor=)                                1.55(1.01+1.25)
7519.10: diff (fsmonitor=)                                       0.34(0.35+0.72)

With this patch series

Test                                                             this tree
--------------------------------------------------------------------------------
7519.2: status (fsmonitor=.git/hooks/fsmonitor-watchman)         0.39(0.33+0.07)
7519.3: status -uno (fsmonitor=.git/hooks/fsmonitor-watchman)    0.17(0.12+0.05)
7519.4: status -uall (fsmonitor=.git/hooks/fsmonitor-watchman)   1.35(0.73+0.61)
7519.5: diff (fsmonitor=.git/hooks/fsmonitor-watchman)           0.14(0.10+0.05)
7519.7: status (fsmonitor=)                                      0.70(0.56+0.87)
7519.8: status -uno (fsmonitor=)                                 0.37(0.31+0.79)
7519.9: status -uall (fsmonitor=)                                1.54(0.97+1.29)
7519.10: diff (fsmonitor=)                                       0.34(0.28+0.79)

Signed-off-by: Nipunn Koorapati <nipunn@dropbox.com>
---
 t/perf/p7519-fsmonitor.sh | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/t/perf/p7519-fsmonitor.sh b/t/perf/p7519-fsmonitor.sh
index 9313d4a51d..80d0148557 100755
--- a/t/perf/p7519-fsmonitor.sh
+++ b/t/perf/p7519-fsmonitor.sh
@@ -142,6 +142,14 @@ test_perf "status -uall (fsmonitor=$INTEGRATION_SCRIPT)" '
 	git status -uall
 '
 
+if test -n "$GIT_PERF_7519_DROP_CACHE"; then
+	test-tool drop-caches
+fi
+
+test_perf "diff (fsmonitor=$INTEGRATION_SCRIPT)" '
+	git diff
+'
+
 test_expect_success "setup without fsmonitor" '
 	unset INTEGRATION_SCRIPT &&
 	git config --unset core.fsmonitor &&
@@ -172,6 +180,14 @@ test_perf "status -uall (fsmonitor=$INTEGRATION_SCRIPT)" '
 	git status -uall
 '
 
+if test -n "$GIT_PERF_7519_DROP_CACHE"; then
+	test-tool drop-caches
+fi
+
+test_perf "diff (fsmonitor=$INTEGRATION_SCRIPT)" '
+	git diff
+'
+
 if test_have_prereq WATCHMAN
 then
 	watchman watch-del "$GIT_WORK_TREE" >/dev/null 2>&1 &&
-- 
gitgitgadget
