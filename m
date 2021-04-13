Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC54FC433B4
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 14:02:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1C4A613B7
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 14:02:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344932AbhDMODE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Apr 2021 10:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237585AbhDMOCI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Apr 2021 10:02:08 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 035CCC06138D
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 07:01:46 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id k128so8803214wmk.4
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 07:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=UWeNrfEJxLnaBSFF3+fKnKM+OImF8teOvdm3wXKtY7w=;
        b=QNPpsVaoLfvHllg9FVSyHitDqfDVP23voZfOzR2RRoPMA8B7oiekaWJC0JAkwraGYZ
         C/cuLb9oFHJanEpmHJ2yccdEKyU7Zy1xBarifge1mhKSG0kalq9hAm+YtB55AjM4i/aw
         ze750qWFh/KlSMUt16L3X7nOTlpdfLhaDRsAHqEvGan3/9YfDny7zkyAJ9M43VHb1nQa
         pjKThle6QS+iwBro2xl6i9mHkRN4DAhPQrhPEdETIJUmAgyht5bJvgqMU7LT4MgQjh0f
         uRK8jKPGPh+RdEPXmCNDQruFu/KR8QFAUlQcwr4b2Y+K8GAyFqy9zrXdUKMm2litLfXI
         W1uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=UWeNrfEJxLnaBSFF3+fKnKM+OImF8teOvdm3wXKtY7w=;
        b=gGdZrUe+TD+7TQiFRwUZ73lwr8X8FEXfCjwq6xa94NX6djhX4diocRQYTBFF58fQEG
         5lrs3H8BpQTXERVj9mjGhh48YmQvGcfJTpzT4HNfirn4nSgXFiJ5QNiW4msPiFjf0oKS
         JT/7nqJKiehBnBwUbsi+MMd35X+PTthWuAbcPym84XosTgSijUTjSpKmdyuGU6xXajzG
         DShJ3nJB4LX39a/IEJN2tNqHCkXRK5SraHpBypZmftuPMoi+hDT101lpv+r/M5gQdbHG
         /W2OqQzGyhyTrO88Q0Moh0Rr6mvnHYRDhyJeCE/lP74gId1WzKU4bU40oBmntrJsXBTf
         +mqg==
X-Gm-Message-State: AOAM530Wa+G1L7yzf9s0CQUp31TQljzzGKK4HgRbtDnowSfr/ofcbNOL
        x2wDrj/n5RfnCFraf3m1t/6o1EbeW4g=
X-Google-Smtp-Source: ABdhPJyR5s9ZdKG8yHD9Elf34SLvzz0WbAN/L29zes6GmYCJFOUtyVZ93UBjnlZKC0V/vgt14fE04Q==
X-Received: by 2002:a1c:f407:: with SMTP id z7mr181090wma.20.1618322503555;
        Tue, 13 Apr 2021 07:01:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q18sm17489030wrs.25.2021.04.13.07.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 07:01:43 -0700 (PDT)
Message-Id: <434306541613cbd0b9bb4ebb3102d97e3df9eb94.1618322497.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.932.git.1618322497.gitgitgadget@gmail.com>
References: <pull.932.git.1618322497.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 13 Apr 2021 14:01:33 +0000
Subject: [PATCH 06/10] dir: use expand_to_path() for sparse directories
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The recently-implemented expand_to_path() method can supply position
queries a faster response if they are specifically asking for a path
within the sparse cone. Since this is the most-common scenario, this
provides a significant speedup.

Update t1092-sparse-checkout-compatibility.sh to fully ensure that 'git
status' does not expand a sparse index to a full one, even when there
exist untracked files.

The performance test script p2000-sparse-operations.sh demonstrates
that this is the final hole to fill to allow 'git status' to speed up
when using a sparse index:

Test                                  HEAD~1            HEAD
------------------------------------------------------------------------------
2000.4: git status (sparse-index-v3)  1.50(1.43+0.10)   0.04(0.04+0.03) -97.3%
2000.5: git status (sparse-index-v4)  1.50(1.43+0.10)   0.04(0.03+0.04) -97.3%

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t1092-sparse-checkout-compatibility.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 380a085f8ec4..b937d7096afd 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -456,8 +456,9 @@ test_expect_success 'sparse-index is not expanded' '
 	init_repos &&
 
 	rm -f trace2.txt &&
+	echo >>sparse-index/untracked.txt &&
 	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" GIT_TRACE2_EVENT_NESTING=10 \
-		git -C sparse-index status -uno &&
+		git -C sparse-index status &&
 	test_region ! index ensure_full_index trace2.txt
 '
 
-- 
gitgitgadget

