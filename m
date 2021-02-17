Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4638DC433DB
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 19:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B8E264E6C
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 19:57:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233776AbhBQT5O (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 14:57:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232970AbhBQT5K (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 14:57:10 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70609C061756
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 11:56:30 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id a22so17871897ljp.10
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 11:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dOM6r+p38e0kweIUjGJOqXCNXTeUYMF94LKVfRKPshI=;
        b=kJxQBvPo/JUuB9I/YwhWX/d5ERt1fr1DtBne32MC3pAKSPdz9/xwFVNHu+lp5q/OBy
         bRfAWDVf3lwx1/MoRoLJ9HpHpQJ7uizoVdFkN2ZjJFvHLrDHt3K4ynTklLOBF0GUCT7m
         /t03kGPgJFU7iRzykH7UyXMOGf+3uDmBkX+lHHsh/l9m35Yh7oFOABfl0sSCQCVnJrny
         UZ0zJguubpqdsHU9c6pQ9veeH52zLF9ack0Dlt7Pmg3YRI5Ukle4HYjRRF+P68YBI6qz
         FvJcEMZ9xULmeJgDGTBoAingyaVWjmrn7zpUGgk4Tal3ygbKjssVWEIOQEPfS6DW6rrV
         pQVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dOM6r+p38e0kweIUjGJOqXCNXTeUYMF94LKVfRKPshI=;
        b=fnGl+NmHuylGsNMIk2Z8fn6VWCr2i9doQ5cTIKn9Lfcmv/owX1S08vF33tchzoq+C5
         cmzgyrjTiMxr7qdjpKGsyY6Oa1hu64Zbza2M7deiX9HXFBHPVm0nrcmVQDqjq8Iftjrh
         P9LS7WW+37lhAXiiZ79VcQ2K//PUyT5+F6m6XP4a+PABaa65Ck9wvxgfnGYPG7nz8ez2
         pd+Iic0/a0/AjeLDKtskVRpc2yXwdztXipWiMNF2Xb1qClk+MbCd+f0mhrwZ67+EOYnX
         epOuX9eU7fQvfaSMlW/NOw+wvD3VcO8elmNHLnz91nfGO8P+9gmpMaljcgQZoSVntenf
         y1qQ==
X-Gm-Message-State: AOAM533pHmR7KfVz8Mv3dIoR9OVO59JGsaaZd5qsGzDpGgdogPPsnLB+
        A0xjgjwNrJcwXskoUStW1RYirUOJrFw=
X-Google-Smtp-Source: ABdhPJxDzPxqXuiYSKlAQPtLVjCgvDlSkFTxtomkCetFpoZHu1cbAabRaAP1M7jJHixJckIXphoH+w==
X-Received: by 2002:a2e:85c2:: with SMTP id h2mr544896ljj.78.1613591788630;
        Wed, 17 Feb 2021 11:56:28 -0800 (PST)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id o19sm347495lfu.182.2021.02.17.11.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 11:56:28 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Sergey Organov <sorganov@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/3] rev-list-options.txt: fix rendering of bonus paragraph
Date:   Wed, 17 Feb 2021 20:56:04 +0100
Message-Id: <888eca4c3544864fbe222de43b50d4fa25700fea.1613590761.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5ea
In-Reply-To: <cover.1613590761.git.martin.agren@gmail.com>
References: <cover.1613590761.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In git-log(1) -- but not in git-shortlog(1) or git-rev-list(1) -- we
include a bonus paragraph in the description of `--first-parent`. But
we forgot to add a lone "+" for a list continuation, and we shouldn't
be indenting this second paragraph. As a result, we get a different
indentation and the `backticks` render literally.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 doc-diff:
 --- a/.../man/man1/git-log.1
 +++ b/.../man/man1/git-log.1
 @@ -264,8 +264,8 @@ OPTIONS
             time, and this option allows you to ignore the individual commits
             brought in to your history by such a merge.

 -               This option also changes default diff format for merge commits
 -               to `first-parent`, see `--diff-merges=first-parent` for details.
 +           This option also changes default diff format for merge commits to
 +           first-parent, see --diff-merges=first-parent for details.

         --not
             Reverses the meaning of the ^ prefix (or lack thereof) for all

 Documentation/rev-list-options.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 96cc89d157..2fa1629f1e 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -129,10 +129,10 @@ parents) and `--max-parents=-1` (negative numbers denote no upper limit).
 	adjusting to updated upstream from time to time, and
 	this option allows you to ignore the individual commits
 	brought in to your history by such a merge.
-
 ifdef::git-log[]
-	This option also changes default diff format for merge commits
-	to `first-parent`, see `--diff-merges=first-parent` for details.
++
+This option also changes default diff format for merge commits
+to `first-parent`, see `--diff-merges=first-parent` for details.
 endif::git-log[]
 
 --not::
-- 
2.30.0.284.gd98b1dd5ea

