Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 306E7C433E0
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 22:51:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07F8B64FF3
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 22:51:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232498AbhCDWvg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Mar 2021 17:51:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232308AbhCDWvg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Mar 2021 17:51:36 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74AD0C061574
        for <git@vger.kernel.org>; Thu,  4 Mar 2021 14:51:34 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id a18so21225889wrc.13
        for <git@vger.kernel.org>; Thu, 04 Mar 2021 14:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=gZcXrUoRXW7PQ7dE3CbX1ne++k2BYVgDIeMkV1MIwYM=;
        b=uqBUAKrjeP9yXNXn0e4B46ViEWjRYURQ9M9r44dFuiyG5oIieLzmfydRiB8B9HKwAm
         h1yHvYkfu6087MDpPsBELZ0jFJRBoeNcUiTNn22MwI4a7LmOumfYSxAISZXy0O7y+yiA
         /3DaReWBy4+xIvygkA5YiQzIB40DUu/hDTvzvchn4ROfXY0CqeYTfgZnO7G4YNLYBVGU
         LoKxKF7ctsAWN6UXufX87GXgrAhjmnkRov1rNBX23G4uku9JLSNYHFX+DwaJh+WIZzRm
         sG/cF3yDr74cC66E2nLGbC5FdZBo0IqUSbmNWNaHlECjP0q2G+uS96Ke6dJzmQZO/t7S
         9xMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=gZcXrUoRXW7PQ7dE3CbX1ne++k2BYVgDIeMkV1MIwYM=;
        b=DCJVFdmQSKcvbuMcPACBbCtsFfSwnlEUdRdzQnCluGFioQSyDb+FKvVxuJ9/5atiMG
         yI4soi38VoqWJ0K+J58/Tui4VGf2ocXLiOFGrsNDfqR0dRRUvMlnVG1qYj8YSa0D5r9U
         vfn4WtWHR5+LWNRlvOoAzcE/WO/3OmyeQuShFOdZqHM1I23crH4lLL2h8SV0vpZ0PIqU
         oMzO7mwteZsM8XE6OVkoQ+ZikgqMd74PM2Eq70+fILK2HM8YSsfNb3OnNwf95vt2uFvh
         McyAkhQT5wsH8GYDgCc6ZuiVC1RXFAY4WOzEBT6LD3Xnx7ulxm20alo7m0O1mESXGnH9
         riNw==
X-Gm-Message-State: AOAM532a1BI2RaDkEF/xZk1loHqjGQrasDWQar4xgjB82fX7Eq9GDN2c
        0TKxY533Nm+5fvdcCYgQuZVUDmr5TmM=
X-Google-Smtp-Source: ABdhPJyUST+Lx/wSzCm1u2YEXJbsj5kH3khrbxxQliVtIpGW1VKhyhNt9+/0GgGSlS4TcmAqlHKFEQ==
X-Received: by 2002:a5d:6304:: with SMTP id i4mr6090238wru.155.1614898293295;
        Thu, 04 Mar 2021 14:51:33 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w25sm1276081wmc.42.2021.03.04.14.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 14:51:33 -0800 (PST)
Message-Id: <pull.974.git.git.1614898292503.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 04 Mar 2021 22:51:32 +0000
Subject: [PATCH] Documentation/RelNotes: improve release note for rename
 detection work
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

There were some early changes in the 2.31 cycle to optimize some setup
in diffcore-rename.c[1], some later changes to measure performance[2],
and finally some significant changes to improve rename detection
performance.  The final one was merged with the note

   Performance optimization work on the rename detection continues.

That works for the commit log, but feels misleading as a release note
since all the changes were within one cycle.  Simplify this to just

   Performance improvements for rename detection.

The former wording could be seen as hinting that more performance
improvements will come in 2.32, which is true, but we can just cover
those in the 2.32 release notes when the time comes.

[1] a5ac31b5b1 (Merge branch 'en/diffcore-rename', 2021-01-25)
[2] d3a035b055 (Merge branch 'en/merge-ort-perf', 2021-02-11)
[3] 12bd17521c (Merge branch 'en/diffcore-rename', 2021-03-01)

Signed-off-by: Elijah Newren <newren@gmail.com>
---
    Documentation/RelNotes: improve release note for rename detection work
    
    Just a tiny release note tweak

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-974%2Fnewren%2Frelease-notes-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-974/newren/release-notes-v1
Pull-Request: https://github.com/git/git/pull/974

 Documentation/RelNotes/2.31.0.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/RelNotes/2.31.0.txt b/Documentation/RelNotes/2.31.0.txt
index 04bd5b70a950..56d4643de909 100644
--- a/Documentation/RelNotes/2.31.0.txt
+++ b/Documentation/RelNotes/2.31.0.txt
@@ -199,7 +199,7 @@ Performance, Internal Implementation, Development Support etc.
 
  * Preliminary changes to fsmonitor integration.
 
- * Performance optimization work on the rename detection continues.
+ * Performance improvements for rename detection.
 
  * The common code to deal with "chunked file format" that is shared
    by the multi-pack-index and commit-graph files have been factored

base-commit: f01623b2c9d14207e497b21ebc6b3ec4afaf4b46
-- 
gitgitgadget
