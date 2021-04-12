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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D281C433B4
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 21:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74E8660C3E
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 21:08:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244563AbhDLVJD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 17:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231750AbhDLVIs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 17:08:48 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78ABEC06138C
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 14:08:29 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id 12so14339390wrz.7
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 14:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=bdB5os8ysADiA9ihl7DyMq1Tj0074xySPTMD9uYQI04=;
        b=JZPM0thnn7fpC0l9tBUA2eDMks7vPtOVvsguX+ffijobfw22vEqDMJ1qPmaKd/h6gl
         ZsgMLDgYRuVKKXNiBFoDcOn2HKldwgR4n7DBiU0Df2XM+CkpwJBmw6HEEVPd4Y4B5NFY
         rTVISP5TqSDTBcCrIEcdLiBhFbmE+3fGbVFZUnajpM3Y8GuuTr7bqyR5ycaH0nAWEZo7
         ZKXtn0/lgj3aeiOLi/Xjx5PxNUwv2Ob+Mcoa7yAlyjgfhMOy9NQTd0LqBArsBekilQaa
         jDkFWaBOu/9Ln16NiJMGrN91pCH3xATopka+TBs/v1hMvXioYH0CDbokO0IPWqXtVfzh
         Q6AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=bdB5os8ysADiA9ihl7DyMq1Tj0074xySPTMD9uYQI04=;
        b=LDWdt0OWfhVUEp3Sy6fssIlN+Ebatot6Hhf84VWMTLjgayDKuNTgSvjCR89V48YP+Z
         uN/eZOQxIqSGo2S+psHeQNZTyAf5DPpcxfZao82HE/kvDYNTwidflfNQs43nGKHrk55y
         8OWTW34jXIpeLjWCrt1bI1EmDRCpJwrUWj/tRKAZIryVjust97ox6/ynoUpqHaV/RUH9
         sbQPw/wHawOc2rSyG/r3P7a33f8zhJrJWf5hZhEqU1T7RYYFhtmuXScip+I5YWwxZgLo
         ja3d+xOnw3WO06GhMhvmt4sv7Z+nw5pFVx51Wnp3ugWkuN8yXf4W/Sp4bioWNxi3SgDH
         kGsg==
X-Gm-Message-State: AOAM5320fTRwwgq/JimUjTeQ6KtDy/LRHurwsObp3SLVFdlHxnEQC1u9
        gCfEoVttgRpvT1ZLHf7nytAg/V6nfZU=
X-Google-Smtp-Source: ABdhPJynbXdsCBVV65ml7OWnx5QZtstTl8K7PSihVxGiuFf6ynzxNTxGZVpRNHefapnbB5gJjgF1QQ==
X-Received: by 2002:a5d:50c5:: with SMTP id f5mr1127445wrt.136.1618261708330;
        Mon, 12 Apr 2021 14:08:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o38sm452999wmp.37.2021.04.12.14.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 14:08:27 -0700 (PDT)
Message-Id: <175f3bc6b336539700d50b1906fd2a33c0bed906.1618261698.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.906.v3.git.1618261697.gitgitgadget@gmail.com>
References: <pull.906.v2.git.1617241802.gitgitgadget@gmail.com>
        <pull.906.v3.git.1618261697.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 12 Apr 2021 21:08:05 +0000
Subject: [PATCH v3 14/26] rm: ensure full index
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com,
        Derrick Stolee <stolee@gmail.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Before iterating over all cache entries, ensure that a sparse index is
expanded to a full index to avoid unexpected behavior.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/rm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/rm.c b/builtin/rm.c
index 4858631e0f02..5559a0b453a3 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -293,6 +293,8 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 
 	seen = xcalloc(pathspec.nr, 1);
 
+	/* TODO: audit for interaction with sparse-index. */
+	ensure_full_index(&the_index);
 	for (i = 0; i < active_nr; i++) {
 		const struct cache_entry *ce = active_cache[i];
 		if (!ce_path_match(&the_index, ce, &pathspec, seen))
-- 
gitgitgadget

