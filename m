Return-Path: <SRS0=jQhj=D2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80154C433DF
	for <git@archiver.kernel.org>; Mon, 19 Oct 2020 22:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15EBA21D7F
	for <git@archiver.kernel.org>; Mon, 19 Oct 2020 22:47:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oof8SNT0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388630AbgJSWrn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Oct 2020 18:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388615AbgJSWrm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Oct 2020 18:47:42 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7131BC0613D1
        for <git@vger.kernel.org>; Mon, 19 Oct 2020 15:47:42 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id x7so1506849wrl.3
        for <git@vger.kernel.org>; Mon, 19 Oct 2020 15:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Djf3TWO3UFcf03qpN2acJDVn06wf04grB536pabMBck=;
        b=Oof8SNT0aRcUjUl+MfN0CRXQQUhSWNqOJbr36sM+mqgCOJgvCVLBKWh+H297JLRRL/
         LYKOItQbj7NpMRKJfeB07TuHGy2mtR2kK9gUChb7IVZewB4tOmmpxVcY3WgcHFUgrepv
         5Z2QYtsMErmF2Bwdbp98AK08SxSwIpZg/rwNv3PJyatECFdZMOdC74jHnLa72pbfvA6e
         ouqGve3QiJk5aa4A1xPgAXlFn2bZfcFdCqLQmxv525WFUQY7ZjVWLj1EKt+iKg3pv0gs
         8soSrKjDQQMegufMeMVvPio+lJx7atXLKDLcmSyYgSmZsNDTfgLQf541UsKBZCOJHE4M
         B2Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Djf3TWO3UFcf03qpN2acJDVn06wf04grB536pabMBck=;
        b=brnIuI954RtYJXpTf6ZuZ8TbjFbQ1uca08w3Anddauhmqhs910kRv8Iq2+CVbBM9wN
         CXHqqXT6G8o2s9IMOYI+D2JSTNLPQx/7mA1EA6nsGKrIOhKM6MoKYb2wyK7sh5vBdmNr
         kJTwu7b+h1s1me3/0zrkIgP+p5ZDQBUezQ//W3Mubg1ynL8KHC6v/ZPYOfXrdfPtB7Zh
         mh8lxMQhegMbgaQnFCHqaoY9nU3D9dizUhxne+J6H/g0m6IIsnYEuBuwnLGeltxXRYHZ
         UIA87/wvXlUW7oSPbPzR1bxN8I7vD7wzpeJCifK1ppelcvF1aIQpHSZCm0j01MNdK42y
         QaNA==
X-Gm-Message-State: AOAM532p294qnWY1uTO/8CgpmZJpHMa7DTqLZh9byxZOhjiXXuPn9AJM
        mFmU7QuPTlFS6kw++n/xLYFtm5eTokY=
X-Google-Smtp-Source: ABdhPJzqTk5Od5KURV3eNG3atIb61FxzEp0VKRY/wjGzOS0+w7HViS1bmM4IDlFExdPbTMqnqlzGPA==
X-Received: by 2002:a05:6000:108:: with SMTP id o8mr1591166wrx.256.1603147661112;
        Mon, 19 Oct 2020 15:47:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g14sm1386188wrx.22.2020.10.19.15.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 15:47:40 -0700 (PDT)
Message-Id: <401f696c8156acafd1bf91511fde7ae099ff9052.1603147657.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.756.v3.git.1603147657.gitgitgadget@gmail.com>
References: <pull.756.v2.git.1603143316.gitgitgadget@gmail.com>
        <pull.756.v3.git.1603147657.gitgitgadget@gmail.com>
From:   "Nipunn Koorapati via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 19 Oct 2020 22:47:33 +0000
Subject: [PATCH v3 3/7] t/perf/p7519-fsmonitor.sh: warm cache on first git
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

