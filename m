Return-Path: <SRS0=RnkD=D3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C49F0C4363A
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 13:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7468321D7B
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 13:41:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dYj2FBhZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407569AbgJTNlT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Oct 2020 09:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407562AbgJTNlN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Oct 2020 09:41:13 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 526AAC0613CE
        for <git@vger.kernel.org>; Tue, 20 Oct 2020 06:41:10 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id k18so1929860wmj.5
        for <git@vger.kernel.org>; Tue, 20 Oct 2020 06:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Djf3TWO3UFcf03qpN2acJDVn06wf04grB536pabMBck=;
        b=dYj2FBhZdpaG67OBBRXvoFm29ZcBgDHN5ih9bBERrrFeXbFxAf2gvOkF23qDsMchAj
         vgKbjOYOLnUuqCHRceZQCG9kxhMuaqCRnCgldhFUb0gTxsxFljyuKkgYNWi7uUXyDDPR
         8vUX6B8q6GQ284At8MfXLlfV9SwjZT+lIUk6DUYXv6tAMRDhtwfyVCJHxpdFKvfTgC04
         g9YsdQNC29KUWrvIarphWMLsk/NjMVOW5LobnRBzhmFeuWDt8lbXC9vdRTCC76T61Y0W
         nxa2MbQhHJD6l4e2GWeQ1Igj1YqH3F/WTcdV7bodUqaAyo42xKzWzfumAsPwHB7bX9Qn
         ZpIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Djf3TWO3UFcf03qpN2acJDVn06wf04grB536pabMBck=;
        b=lTCnW0byGJPxqHZ1v4vZ87Zabjx0VgVXkJ83rYtxAgZY1G9sPYNHNO8J6VuHTVNjAz
         zYXLuyu8X4QlkVCmEkUGbBS0LXuBgCo7gg3U6lkduGpDha8LBshwF+m7t6Rt+VwkAa2o
         v5o3/uOp2Y2iSZHCYuG4omhMAWthOUG3Od1t2LLP4+Fjf/kpz2zfPRIHuOfq1kK6prPD
         +zQDpe+N3m2ccZvU7+3TtPcy9tsiOYoktmdtaoT5y0Y8m7GXFaN+YQXw3Zc65xSvrQsY
         KvTR3LBmWFFfHMnAhdB93v4/HTq/hrCy3mYhun6152xmbjJUwLHGp9W8u7Ae4cq/nipp
         mDGA==
X-Gm-Message-State: AOAM533CVf8/iS4VQW1bnpvr3YBWiSlYzsWcOAeS0HapnKctD70IgYHt
        SZbw+qLAyS7M5HBa3GB7R7JuY6/WGU0=
X-Google-Smtp-Source: ABdhPJwyNbllWuCfHqlNntqkCSZNz2qoQSLTr+UXUqu3JJZcbRIuUXqNm1B0RitvhYEeSvYh0mfwHw==
X-Received: by 2002:a05:600c:255:: with SMTP id 21mr3060417wmj.69.1603201268844;
        Tue, 20 Oct 2020 06:41:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b5sm3084777wrs.97.2020.10.20.06.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 06:41:08 -0700 (PDT)
Message-Id: <401f696c8156acafd1bf91511fde7ae099ff9052.1603201264.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.756.v4.git.1603201264.gitgitgadget@gmail.com>
References: <pull.756.v3.git.1603147657.gitgitgadget@gmail.com>
        <pull.756.v4.git.1603201264.gitgitgadget@gmail.com>
From:   "Nipunn Koorapati via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 20 Oct 2020 13:41:00 +0000
Subject: [PATCH v4 3/7] t/perf/p7519-fsmonitor.sh: warm cache on first git
 status
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>, Utsav Shah <utsav@dropbox.com>,
        Nipunn Koorapati <nipunn1313@gmail.com>,
        Nipunn Koorapati <nipunn@dropbox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Nipunn Koorapati <nipunn1313@gmail.com>,
        Nipunn Koorapati <nipunn@dropbox.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Nipunn Koorapati <nipunn@dropbox.com>

The first git status would be inflated due to warming of
filesystem cache. This makes the results comparable.

Before
Test                                                             this tree
--------------------------------------------------------------------------------
7519.2: status (fsmonitor=.git/hooks/fsmonitor-watchman)         2.52(1.59+1.56)
7519.3: status -uno (fsmonitor=.git/hooks/fsmonitor-watchman)    0.18(0.12+0.06)
7519.4: status -uall (fsmonitor=.git/hooks/fsmonitor-watchman)   1.36(0.73+0.62)
7519.7: status (fsmonitor=)                                      0.69(0.52+0.90)
7519.8: status -uno (fsmonitor=)                                 0.37(0.28+0.81)
7519.9: status -uall (fsmonitor=)                                1.53(0.93+1.32)

After
Test                                                             this tree
--------------------------------------------------------------------------------
7519.2: status (fsmonitor=.git/hooks/fsmonitor-watchman)         0.39(0.33+0.06)
7519.3: status -uno (fsmonitor=.git/hooks/fsmonitor-watchman)    0.17(0.13+0.05)
7519.4: status -uall (fsmonitor=.git/hooks/fsmonitor-watchman)   1.34(0.77+0.56)
7519.7: status (fsmonitor=)                                      0.70(0.53+0.90)
7519.8: status -uno (fsmonitor=)                                 0.37(0.32+0.78)
7519.9: status -uall (fsmonitor=)                                1.55(1.01+1.25)

Signed-off-by: Nipunn Koorapati <nipunn@dropbox.com>
---
 t/perf/p7519-fsmonitor.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/perf/p7519-fsmonitor.sh b/t/perf/p7519-fsmonitor.sh
index def7ecdbc7..9313d4a51d 100755
--- a/t/perf/p7519-fsmonitor.sh
+++ b/t/perf/p7519-fsmonitor.sh
@@ -114,7 +114,8 @@ test_expect_success "setup for fsmonitor" '
 	fi &&
 
 	git config core.fsmonitor "$INTEGRATION_SCRIPT" &&
-	git update-index --fsmonitor
+	git update-index --fsmonitor &&
+	git status  # Warm caches
 '
 
 if test -n "$GIT_PERF_7519_DROP_CACHE"; then
-- 
gitgitgadget

