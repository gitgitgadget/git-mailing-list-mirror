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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C929EC4361B
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 16:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DC4F207A5
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 16:01:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731138AbgLCQAu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Dec 2020 11:00:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731069AbgLCQAt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Dec 2020 11:00:49 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC913C061A55
        for <git@vger.kernel.org>; Thu,  3 Dec 2020 07:59:57 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id a3so4397215wmb.5
        for <git@vger.kernel.org>; Thu, 03 Dec 2020 07:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=pWC3snMc2nAfv9p5VhZzmW6O2DlfW8pA+/Acchs/81U=;
        b=o2bnVWfbWBvIpXextcMnisq/ZKPbYxAewAUcfkRiMQKWU98dQWb16JRyE+Ma4sJX5k
         SVu4qbLbC089nWNNnYrT8WMHJq1W1ltkKnOPgs6x9LxAG6D+6QM7wrwwwTxAdZ0MqOry
         0SV7xjXo+benSgq359P5F2LSQXrJ+XzZZMW4QyQiiYVpMhbnXEjQ/XsXKaB2EU7Tg7G/
         MnlK+loPGwwaehxNH9TM9VcF052kqnG51H+U8zQu1YL2cvINxEviTPWhYjY/dygUxm+q
         weazXWc1rrAH1BEk67YIEJPeTaTfMoWNLTwlfgrNyxLJjAAVPGv22qRKmd9gWQpiUSSD
         u+Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=pWC3snMc2nAfv9p5VhZzmW6O2DlfW8pA+/Acchs/81U=;
        b=JQiUTlXN+MFuPgElsv5Bi7VSxHhjAakLe05u1z/I3L9OlgqaIWbrisghBzkM0U4web
         1EOtYy7rrKJO33y/MEp5rrdCBXS2Pb38L2mcv5JN7MVCyRDDxFxgw5wFEOSZWcWg7pZR
         gFLV8+iXWHQ9kg5k+EhPanooZNqDw6o20azDI2bGzrUnURImmrWdKRSWoeDw2ywAdQaN
         gl+nvUv3BGNyiXDcoOl0QypgPDKhENTL2x6cIBO2gI+l2KTH27Bafdv0RB7cvR90mgUg
         2K0JS9Jo+YKP8Nkgzh0HLP3+dqEdsbQQWoe5cY9Wu05TDN78WVOVMrsUTrslM2ywk/oT
         NpAw==
X-Gm-Message-State: AOAM5327LduWV9lhGWBxTddgQ+VHBu6NUMA2pCnCxFwUhac1q/1FDw7h
        ahPQT3Yw6vnGv4oJFp9oOge5HJkt0rY=
X-Google-Smtp-Source: ABdhPJxxjJskmURQHJOWJ2WDl8fhWHPBF4LTl99E4m9CQa/F94kXz+tcc3nFPfP0KmJLe58J34d2lQ==
X-Received: by 2002:a1c:3d86:: with SMTP id k128mr4008538wma.66.1607011189495;
        Thu, 03 Dec 2020 07:59:49 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e1sm2716362wra.22.2020.12.03.07.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 07:59:49 -0800 (PST)
Message-Id: <6cd8ee01c7107f54bdba177f27089321df047eac.1607011187.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.803.git.1607011187.gitgitgadget@gmail.com>
References: <pull.803.git.1607011187.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 03 Dec 2020 15:59:40 +0000
Subject: [PATCH 1/7] merge-ort: add a few includes
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Include blob.h for definition of blob_type, and commit-reach.h for
declarations of get_merge_bases() and in_merge_bases().  While none of
these are used yet, we want to avoid cross-dependencies in the next
three series of patches for merge-ort and merge them at the end; adding
these "#include"s now avoids textual conflicts.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/merge-ort.c b/merge-ort.c
index ea6a9d7348..b556897bc0 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -17,7 +17,9 @@
 #include "cache.h"
 #include "merge-ort.h"
 
+#include "blob.h"
 #include "cache-tree.h"
+#include "commit-reach.h"
 #include "diff.h"
 #include "diffcore.h"
 #include "dir.h"
-- 
gitgitgadget

