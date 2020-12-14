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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01AD9C4361B
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 13:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9AEC225AC
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 13:35:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437505AbgLNNej (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Dec 2020 08:34:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439830AbgLNNe0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Dec 2020 08:34:26 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17DDC0613D6
        for <git@vger.kernel.org>; Mon, 14 Dec 2020 05:33:45 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id e25so15276908wme.0
        for <git@vger.kernel.org>; Mon, 14 Dec 2020 05:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=aKtgIfODIJsDeCysGo/NnQK/4VzUArW8A+kCnIoZcXc=;
        b=Ei8IOp788jEytWXLSoEO5jwSif+yATEYPPpM6Of8FL5nYOGGTJesxu4/HrY4kei9jQ
         7DuRX+rlB1J2OHOm6qsB2MPwsHSROUuUIlPr/nXIGS0DJFgz5Wr3RuZHFZDuOXyIX8jl
         PoQj01FKtS1jMZsbEiNxQcg+x9cheumZ6y5KaJIMGsqNHgt/kfM+0bFEf6DSxNeX3+y3
         RFk5a02oCu/Lfspqt5tMF8tX+WkRLzBwN2g2u7QxGX4oA5y1+EeuSgWCilhMMS3xL2FI
         pnX2Q7wSOD+4F693Idku6UAnDYodcH0uaU7rbhYdtn1VHaBvBvAHdwlm00NCDl9G9xuA
         mZZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=aKtgIfODIJsDeCysGo/NnQK/4VzUArW8A+kCnIoZcXc=;
        b=niqap+lFZXLdUnI4zq3Ou2Ff6bw2ZKNet+gkQt8Dl35ASfRVaf8O0IoRExExb671po
         knfGbKaZVGCTgiFEA4U2t4v4CRO49LfMHtIdHqtb/sO8Pq5F3LPDrOZnq8lGyuEHb45U
         F4aWImlH0mKXKs8FLB+NTBQLB5REzAeRgyhwXG6pY2kBCCwG2BNlYSLraqIsdy5gT/ji
         6QDFZwPlUXKeVwg77e8l1Lx7TffT7bsDovIQmBjnDt0GRgVAd2OLc+0nU5blxDTE6t0f
         vCyzexgVI5eKjAIYdL3iycfXFdy6RBVc1/PizNK0eLyG9ZY3mMNro0WcLfuFZKf7zcig
         NdPw==
X-Gm-Message-State: AOAM530g3kc6yTvMcOL0IpgZQmnwfJ7+i38pvlR2HEwnwtxVUUukz/No
        Jd8VlCpOWUR2JqhHy8EC2yvImR4blSc=
X-Google-Smtp-Source: ABdhPJxP79ua89I7qC08ya3cDx4L8ezVHC+3YjBTtmfi52lpYm4IZfJ8XpNADtMN9hNPgg/A4TC27Q==
X-Received: by 2002:a1c:7201:: with SMTP id n1mr27459411wmc.139.1607952824538;
        Mon, 14 Dec 2020 05:33:44 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h98sm34869856wrh.69.2020.12.14.05.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 05:33:43 -0800 (PST)
Message-Id: <pull.813.git.1607952822848.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 14 Dec 2020 13:33:42 +0000
Subject: [PATCH] index-format.txt: document v2 format of file system monitor
 extension
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Update the documentation of the file system monitor extension to
describe version 2.

The format was extended to support opaque tokens in:
56c6910028 fsmonitor: change last update timestamp on the index_state to opaque token

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
    index-format.txt: document v2 format of file system monitor extension
    
    While studying the FSMonitor code I noticed that the documentation for
    the FSMN index extension did not get updated for V2 format.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-813%2Fjeffhostetler%2Ffix-fsmonitor-v2-documentation-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-813/jeffhostetler/fix-fsmonitor-v2-documentation-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/813

 Documentation/technical/index-format.txt | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/technical/index-format.txt b/Documentation/technical/index-format.txt
index f9a3644711b..69edf46c031 100644
--- a/Documentation/technical/index-format.txt
+++ b/Documentation/technical/index-format.txt
@@ -306,12 +306,18 @@ The remaining data of each directory block is grouped by type:
 
   The extension starts with
 
-  - 32-bit version number: the current supported version is 1.
+  - 32-bit version number: the current supported versions are 1 and 2.
 
-  - 64-bit time: the extension data reflects all changes through the given
+  - (Version 1)
+    64-bit time: the extension data reflects all changes through the given
 	time which is stored as the nanoseconds elapsed since midnight,
 	January 1, 1970.
 
+  - (Version 2)
+    A null terminated string: an opaque token defined by the file system
+    monitor application.  The extension data reflects all changes relative
+    to that token.
+
   - 32-bit bitmap size: the size of the CE_FSMONITOR_VALID bitmap.
 
   - An ewah bitmap, the n-th bit indicates whether the n-th index entry

base-commit: 3cf59784d42c4152a0b3de7bb7a75d0071e5f878
-- 
gitgitgadget
