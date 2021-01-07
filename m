Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D936C433E6
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 16:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4012623433
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 16:33:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728793AbhAGQdi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 11:33:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728672AbhAGQdg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jan 2021 11:33:36 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5226AC0612FD
        for <git@vger.kernel.org>; Thu,  7 Jan 2021 08:32:22 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id m5so6228677wrx.9
        for <git@vger.kernel.org>; Thu, 07 Jan 2021 08:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=J0quDYQmAimfPiktYyMvKlXlNzw88Ny8gDuLOVi5x64=;
        b=h4DLMc2q9Ba6QOCNKe390hoTbfoTru/9GbprwngEh1Yk+LVtOLg3NgqYCHbH+aD6eP
         oouJzlDsKuF4aVXUS5PmshkITQtJItw7piXNfAVVV69UJmBsKL4D/RIwoB3EHvX+uFsb
         OQ+wWY6t1v4pPhvdvpJRj2BjXZJB5djApBY94L3pVCMl1e3zjfQ5vMSESP6fhmnHYj1c
         UijpyPebJSGLz4lwjq0bFBivFBTcfNVc54IUyFt1w34JXGyLyrHqYgjOxD5Ft+DVs3O/
         LqkdZHDNIOp33lQxyGGnhZSHbMYlfm3Vc81jXVWB+jSHg00g52fUfuHFjMp3VIcvgo2Q
         ryuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=J0quDYQmAimfPiktYyMvKlXlNzw88Ny8gDuLOVi5x64=;
        b=iIAP6y+NH+FgMc/LAiEtkYepcv0O58+InKjlCWoTtW8sP9RxBd+jGoFi/T8cZZ4TdF
         cRxP/UaojShFZBAzUrNRKtPoieGKxitPRrp3ZG9J/hqh1CIqXAL1yc1juMFKH9Mcx+O1
         VxDj91/xOzlC/MVVsYkUuIvyZ/7F3V7oopbxkqQ01wlS0ZXneM2sdeV872TD4Cy5dAJs
         CcT2468nx4Ed6aHeMMhzo/0o35m6Zem/alS1cmgJYVOmw86UHBeDT34JNHhFojTD0F/V
         w/XGwFDmS8v2kAI6NUVjo3Yj8H6K8e2BYkTVHi4xaOmza0ta6241RHZP80NhJ5Irh2Gi
         u8dg==
X-Gm-Message-State: AOAM532TDtDLBhKiJWZ6zIRhBgT2xq0KJlNK//+qs+EZtJ8RC+A/zWB8
        BK4pdyi4mSGxRDFEqKK2ViZ/7KFvg/U=
X-Google-Smtp-Source: ABdhPJxUZoO4HPTcK+7SK/hTgydNpZDhNWz4QDTAK53xcF2Sw3qP6eC2d0KLtrFsN6Lw3777DFk0bA==
X-Received: by 2002:adf:84c1:: with SMTP id 59mr10129536wrg.409.1610037140933;
        Thu, 07 Jan 2021 08:32:20 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p15sm8671229wrt.15.2021.01.07.08.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 08:32:20 -0800 (PST)
Message-Id: <97c06c80a8543d29bf9390fc8ae5b73ae140c057.1610037132.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.829.v3.git.1610037131.gitgitgadget@gmail.com>
References: <pull.829.v2.git.1609729758.gitgitgadget@gmail.com>
        <pull.829.v3.git.1610037131.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Jan 2021 16:32:09 +0000
Subject: [PATCH v3 08/10] index-format: discuss recursion of cached-tree
 better
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The end of the cached tree index extension format trails off with
ellipses ever since 23fcc98 (doc: technical details about the index
file format, 2011-03-01). While an intuitive reader could gather what
this means, it could be better to use "and so on" instead.

Really, this is only justified because I also wanted to point out that
the number of subtrees in the index format is used to determine when the
recursive depth-first-search stack should be "popped." This should help
to add clarity to the format.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/technical/index-format.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/technical/index-format.txt b/Documentation/technical/index-format.txt
index 65dcfa570df..b633482b1bd 100644
--- a/Documentation/technical/index-format.txt
+++ b/Documentation/technical/index-format.txt
@@ -195,7 +195,8 @@ Git index format
   first entry represents the root level of the repository, followed by the
   first subtree--let's call this A--of the root level (with its name
   relative to the root level), followed by the first subtree of A (with
-  its name relative to A), ...
+  its name relative to A), and so on. The specified number of subtrees
+  indicates when the current level of the recursive stack is complete.
 
 === Resolve undo
 
-- 
gitgitgadget

