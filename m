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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77818C433ED
	for <git@archiver.kernel.org>; Wed, 12 May 2021 11:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F66F61376
	for <git@archiver.kernel.org>; Wed, 12 May 2021 11:18:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbhELLTP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 07:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbhELLTO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 07:19:14 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86611C061574
        for <git@vger.kernel.org>; Wed, 12 May 2021 04:18:05 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id x8so925989wrq.9
        for <git@vger.kernel.org>; Wed, 12 May 2021 04:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=bVLGvFaJnUDaYQi1Eg/YZGNfqKiRxOsTDAFoIFXWCxo=;
        b=m5U0/e8rvriLwCHX2yqlGdxfy0pUQdkTbP2TkyGJAdIjjccybkeWc4w4RFKiH9ddfV
         MgK++u0Q0X+YZDn/ik/085xpHw+i9KKex6EoMN2QLR9GgJhSY5abJm0zcxUVm0JbAhVu
         yCH88z2x59I/TyhCF58ITGo4VMCLzjF3N4Qlb643yQpuV03b85Mvw0KPwdtORnrfmwZV
         uOTiX3RpP3p2S7xRjVSxBceMgL5Svrai9jXpr9HvAhSqEJPDeuRM/bZXTcRlzJ3poxL1
         TZU5GLqVWu0Cv9LRoh/prOHhdpFPly3Pj1QDSllY0S8s8HA/dVu3HaUznBb+JzYbNkJV
         xpIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=bVLGvFaJnUDaYQi1Eg/YZGNfqKiRxOsTDAFoIFXWCxo=;
        b=uRIdxS41mXz78hlcw2qESn5cC1lHpIFZZGxszhh28VWl7Gb/QcUEUL5SP9ID6x4vVL
         iVzzVL/cz8sQLUH5Fq0cW+TIp6qrQN/0MzLk36fjoa2BmaxRAgGHAd9vnuTvgNtTWvTI
         MPKt+7A9Zp4EbzSoNPeZeP9Pi9AhIXZBRr0NFoFL3hV23YKuSKQkb8ry3u1r/vCPUMaw
         jxYL5Rcj0H6os2aT9tVOOnCXuliHD0jBnEopJB/YKLRA9G2Ir74mNDQv5rZphtYuaxww
         XTpJv9Ee/ZBNvV8cADA2QTScA5E49TFJL+3zpfk6rZ55O1Hu5Vo1n24VNGBdHhRcxiUG
         t3Cg==
X-Gm-Message-State: AOAM5339VvVD+ZL4okeUyJeGncv92XXHe9M1E5lgcuOzuUu/xxbY/3lB
        e3Xr5eocmMzZYt7Wab8nYK2c5kooPFU=
X-Google-Smtp-Source: ABdhPJygVTo3txDcGnYOLtbzGbiO9AIcAhGkbD+G8v3G3sz2uJTP3JNhsAZryZHJYZbTtf6vXDS7zw==
X-Received: by 2002:a5d:610a:: with SMTP id v10mr43691335wrt.399.1620818284265;
        Wed, 12 May 2021 04:18:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w25sm2814109wmk.25.2021.05.12.04.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 04:18:03 -0700 (PDT)
Message-Id: <pull.1023.git.git.1620818283024.gitgitgadget@gmail.com>
From:   "Louis Sautier via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 12 May 2021 11:18:02 +0000
Subject: [PATCH] pretty: fix a typo in the documentation for %(trailers)
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Louis Sautier <sautier.louis@gmail.com>,
        Louis Sautier <sautier.louis@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Louis Sautier <sautier.louis@gmail.com>

This just changes occurance to occurrence.

Signed-off-by: Louis Sautier <sautier.louis@gmail.com>
---
    pretty: fix a typo in the documentation for %(trailers)
    
    Hi,
    
    Here is a very minor change: occurance → occurrence ?

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1023%2Fsbraz%2Ftypo-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1023/sbraz/typo-v1
Pull-Request: https://github.com/git/git/pull/1023

 Documentation/pretty-formats.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index cd697f508c53..ea9b26c3f734 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -271,7 +271,7 @@ endif::git-rev-list[]
 			  `trailers` string may be followed by a colon
 			  and zero or more comma-separated options.
 			  If any option is provided multiple times the
-			  last occurance wins.
+			  last occurrence wins.
 +
 The boolean options accept an optional value `[=<BOOL>]`. The values
 `true`, `false`, `on`, `off` etc. are all accepted. See the "boolean"

base-commit: a0f521b56c724f4e21eef1cec2d456b1dbd72c10
-- 
gitgitgadget
