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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8589C43333
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 21:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2B1264F91
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 21:17:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233255AbhCPVRc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 17:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233156AbhCPVRW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 17:17:22 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986EDC06174A
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 14:17:21 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id o14so7425328wrm.11
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 14:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=H6engud+FhFZYKQixDARUriNE0HEE07dfYRKSvEbVjc=;
        b=U8W/7T+IahfIGqBAN6Yxuxuw447JGUJXPzc1q1R2pqdN03CixA6kFTVjHsHTBTJQmp
         kWXnBIMNuBb87U3QEyzBKBkmjVb7dlhsVYbchNMRoh/842KQAREUIRcZbs9Vr38BrDUJ
         3bhoHhXiwTViBeVuWpxYGMwknvvCq2Yhsf4CXhXLQxChQbep60qfz/LRxkXvvF6MOHs6
         B+vBBG8TsPH0hxEgs9uVNczuvuPjO4KkbmqMwU3eUGCVbsljcQSM3jaJdSYv/g02EnLs
         NaGcsN70B30YYPRlfGlHcrZ5KkV9qBj21Y8zaLJVYLNwuGJNu4Yjd9/+bfkQkT7VUxFx
         eWXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=H6engud+FhFZYKQixDARUriNE0HEE07dfYRKSvEbVjc=;
        b=ITUiPKZboVTVVOOQi9kszmlq1VMA47hh+ctBAJPLfrOZ5zbrD/7LNHm5ABrGBPeDM6
         tTK7OL0j03DE7LWQ6w4i+ajQF8OtQmlaCtdS5uXMeE5ZtN0xWurI3JdNkSJ/mCPILzNO
         c38CtmuxzC8KQ9iUZBl6s58XKNBUBCxMJ/g12yda1WdSwNY8LmtMV2x2M0Fux8s82m3t
         2IkPi6KxGyZBC2BS+NghgVGl7ERzMCnL8pw+0usaVnFuIm0RURXAGuEUojGzviGu6Z4/
         HVM1fPlTAqvWVoapvU/UHV6OKu1iYsZRPKxOQqV+Bls0kzVlTT/39P4p4w1k8vwpOfxj
         0Ofg==
X-Gm-Message-State: AOAM533dZcW2pGO8Z+8IXZ1K1f9TEafNuxSIpNMobKkne5yiHVjhmXmi
        Gnks1Dc1cqgxrFTgj4a2Ku3ddWLCfRc=
X-Google-Smtp-Source: ABdhPJy6iw2yamXh0FPK15krPaPWlP8gSMOp8fU2tmLe75mEJp+C0ZMqKKOIfTJQVKmzmZtVsbsUhg==
X-Received: by 2002:adf:d217:: with SMTP id j23mr969560wrh.113.1615929440475;
        Tue, 16 Mar 2021 14:17:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u15sm480787wmq.4.2021.03.16.14.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 14:17:20 -0700 (PDT)
Message-Id: <7e4079c48eb2ad06a849eda8f4bd6cb14493ffdb.1615929436.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.906.git.1615929435.gitgitgadget@gmail.com>
References: <pull.906.git.1615929435.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 16 Mar 2021 21:16:52 +0000
Subject: [PATCH 04/27] cache: move ensure_full_index() to cache.h
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Soon we will insert ensure_full_index() calls across the codebase.
Instead of also adding include statements for sparse-index.h, let's just
use the fact that anything that cares about the index already has
cache.h in its includes.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 cache.h        | 1 +
 sparse-index.h | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/cache.h b/cache.h
index f244e6ac90fd..9c6d254e2bae 100644
--- a/cache.h
+++ b/cache.h
@@ -350,6 +350,7 @@ void add_name_hash(struct index_state *istate, struct cache_entry *ce);
 void remove_name_hash(struct index_state *istate, struct cache_entry *ce);
 void free_name_hash(struct index_state *istate);
 
+void ensure_full_index(struct index_state *istate);
 
 /* Cache entry creation and cleanup */
 
diff --git a/sparse-index.h b/sparse-index.h
index 39dcc859735e..0268f38753c0 100644
--- a/sparse-index.h
+++ b/sparse-index.h
@@ -2,7 +2,6 @@
 #define SPARSE_INDEX_H__
 
 struct index_state;
-void ensure_full_index(struct index_state *istate);
 int convert_to_sparse(struct index_state *istate);
 
 struct repository;
-- 
gitgitgadget

