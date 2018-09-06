Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9352F1F404
	for <e@80x24.org>; Thu,  6 Sep 2018 15:14:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730279AbeIFTuU (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Sep 2018 15:50:20 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36421 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730178AbeIFTuU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Sep 2018 15:50:20 -0400
Received: by mail-qk1-f196.google.com with SMTP id 93-v6so7552649qks.3
        for <git@vger.kernel.org>; Thu, 06 Sep 2018 08:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Rps47q7jpDbLFad+lkoK5tB79so4PxpboHDkb6BS9BE=;
        b=SbEu4BFvee/C3/eenHHaUlcq94t4e8Nx8bSztj8BBK3pqZCeTvQcgI/qF/90d8iqYn
         guk99avnJvXUQD4fmltmPiajtLc237lYQDmk/VOtejRq1eqATSQVNy+Ku5GgjBAbA4TL
         Y4ATXcVPUeLFtxkAhAoD2ZGSg21wz2yrPZp3MNpdL7HwB7+wXIXa1AvgXFG+5MbEPDjF
         bE/vhx/FrU2GpB3P35lRy2ZT4+06BOqhloygI20U1K0hYnX611zTlezCqtwC1zHe0PZy
         xLbn4e+ux+2iVf1/rVeTBQs/kLar/qx30cQzVcn1/8FzHPga3g+15riSlKp36ya5luHM
         vEZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Rps47q7jpDbLFad+lkoK5tB79so4PxpboHDkb6BS9BE=;
        b=co6RnGHn9nEodMttOT0zTxrZWYETOhABzZ+1g6ms010Jf3TUVtRKFDeAGfMlOROjNQ
         sapMAAQENORPf4omyq+qtve9qZo39T7QS82wM2SVd4H6XqsO5gq+9BPbLV9okbh0ghQ9
         TBBpfr+PFLffi5Im4oAYVfmdGFL5ySkU//6iDBGh9AC24oTm8iB5Qg9sPCeL4n+8D1qb
         iKilChLJhG1Dhg5M/ybhYe0UuRY20ax5bAY+fONB2EtudfY33aCd6kkI28VByZ24vyi8
         6g7DfdQ7IbphxKkfCwfiucCYZaJLThOl0js1ULRNyBqJqUMuTSNpnER7jFADqeg2bPn2
         zGWg==
X-Gm-Message-State: APzg51DpnFtNTyJyIZni9MFKKeBMPYUkN7JwJoz+bxuk28fIeZVgurDe
        JgEorZw6d0LEEt2MYx/0ToL8L9xH
X-Google-Smtp-Source: ANB0VdZUiBvDvt3aeBWjkU6pjgCQTS54JEaElPJE2a3M2JmleGsEVCPXi7J8CcLJBKVqAZl7gGplsQ==
X-Received: by 2002:a37:c34b:: with SMTP id a72-v6mr2410139qkj.73.1536246861119;
        Thu, 06 Sep 2018 08:14:21 -0700 (PDT)
Received: from linux.mshome.net ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id z3-v6sm2752030qkc.55.2018.09.06.08.14.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Sep 2018 08:14:11 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     git@jeffhostetler.com, stolee@gmail.com, gitster@pobox.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [RFC PATCH 6/6] commit-reach: fix first-parent heuristic
Date:   Thu,  6 Sep 2018 15:13:09 +0000
Message-Id: <20180906151309.66712-7-dstolee@microsoft.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180906151309.66712-1-dstolee@microsoft.com>
References: <2ba9d81a-5578-a81c-a7d9-179864cb4277@gmail.com>
 <20180906151309.66712-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The algorithm in can_all_from_reach_with_flags() performs a depth-
first-search, terminated by generation number, intending to use
a hueristic that "important" commits are found in the first-parent
history. This heuristic is valuable in scenarios like fetch
negotiation.

However, there is a problem! After the search finds a target commit,
it should pop all commits off the stack and mark them as "can reach".
This logic is incorrect, so the algorithm instead walks all reachable
commits above the generation-number cutoff.

The existing algorithm is still an improvement over the previous
algorithm, as the worst-case complexity went from quadratic to linear.
The performance measurement at the time was good, but not dramatic.

By fixing this heuristic, we can see in t6600-test-reach.sh that we
reduce the number of walked commits. This test will prevent a future
performance regression.

We can also re-run the performance tests from commit 4fbcca4e
"commit-reach: make can_all_from_reach... linear".

Performance was measured on the Linux repository using
'test-tool reach can_all_from_reach'. The input included rows seeded by
tag values. The "small" case included X-rows as v4.[0-9]* and Y-rows as
v3.[0-9]*. This mimics a (very large) fetch that says "I have all major
v3 releases and want all major v4 releases." The "large" case included
X-rows as "v4.*" and Y-rows as "v3.*". This adds all release-candidate
tags to the set, which does not greatly increase the number of objects
that are considered, but does increase the number of 'from' commits,
demonstrating the quadratic nature of the previous code.

Small Case:

4fbcca4e~1: 0.85 s
  4fbcca4e: 0.26 s (num_walked: 1,011,035)
      HEAD: 0.14 s (num_walked:     8,601)

Large Case:

4fbcca4e~1: 24.0 s
  4fbcca4e:  0.12 s (num_walked:  503,925)
      HEAD:  0.06 s (num_walked:  217,243)

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-reach.c        | 4 +++-
 t/t6600-test-reach.sh | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/commit-reach.c b/commit-reach.c
index 0a75644653..bd009260b0 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -588,8 +588,10 @@ int can_all_from_reach_with_flag(struct object_array *from,
 		while (stack) {
 			struct commit_list *parent;
 
-			if (stack->item->object.flags & with_flag) {
+			if (stack->item->object.flags & (with_flag | RESULT)) {
 				pop_commit(&stack);
+				if (stack)
+					stack->item->object.flags |= RESULT;
 				continue;
 			}
 
diff --git a/t/t6600-test-reach.sh b/t/t6600-test-reach.sh
index 98ad25bb45..5e231a5955 100755
--- a/t/t6600-test-reach.sh
+++ b/t/t6600-test-reach.sh
@@ -185,7 +185,7 @@ test_expect_success 'can_all_from_reach:hit' '
 
 test_expect_success 'can_all_from_reach:perf' '
 	cp commit-graph-full .git/objects/info/commit-graph &&
-	run_and_check_trace2 can_all_from_reach_with_flag num_walked 40 input \
+	run_and_check_trace2 can_all_from_reach_with_flag num_walked 19 input \
 		"test-tool reach can_all_from_reach"
 '
 
-- 
2.19.0.rc2

