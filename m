Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77FD01F404
	for <e@80x24.org>; Thu,  6 Sep 2018 15:13:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730229AbeIFTth (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Sep 2018 15:49:37 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38790 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730032AbeIFTth (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Sep 2018 15:49:37 -0400
Received: by mail-qk1-f193.google.com with SMTP id g197-v6so7560049qke.5
        for <git@vger.kernel.org>; Thu, 06 Sep 2018 08:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4YoK4VugevUek41e67X7BGKfTpKxVe5TUyCIj3iPxEQ=;
        b=OIfCUKrM9f6XXQhfqyR0wci17DhG784nUApArJdYhYg9p+bHTDg3P9lHrQAsCvZ1ao
         uVmWOZO0gGIMg8anSog1GXMDG8UjL58tx1TPKZtStETsU2jbTcMtDmCLjgagd1Js0b0X
         7pXKKrm/6G8fxpcLG6DYM5uG4hWL7wtMMcbLtXR9bIGdagLi9+DJAW1EOGsgAg3rx61D
         7K3J/3jGkX4Cqlh4h6PUrJlA+MtS+FLZ1tHOb4NIhnIJMO8R6Rv+fy1pDB8E/dWaDo9m
         VquB73Fn+UgXmvS7pUaZqKNKi+wjlWo9HI/uGijD+J9vsijuLwcXx3TBhjYtIxCwEF2U
         whOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4YoK4VugevUek41e67X7BGKfTpKxVe5TUyCIj3iPxEQ=;
        b=bsv4T4N+dHxSYa4BWosilXp85cKty13StfxHKfCYRFUS2UE1Uf3h5/D7enP3InpWqh
         4rHlUWgYJNN11AKvJBgxNs4LWOGhSzq+AoUV/0lT+V0YH3pDOdSAkJUUGv1NkzRNLj2q
         PPYLcsLOkZQBNqFhnzvmyM6BSw4e3z4CHY5y/6zPMJT2NrZUtsU3AzwhJ1JXMTbuxij1
         2gROcrtuxv/Yq9XuH0C8bULBwkNxQFOqs/jyi68MOA03RC4ALBnytw4VIH4F9TVSW29J
         XZ/XHBeLmsLAal2mHJeaaniJe75L3cvgXFeuKnLYwyJ1j89+SUkp76qjZmpu8qvjvDsJ
         /F7w==
X-Gm-Message-State: APzg51D90UQiXslIP15i/6uMoHohg4HpCeHWfE/gT0J3gO86wa1NLVvu
        HWcwuszvXH5c1hCALPCW+9NzKPRH
X-Google-Smtp-Source: ANB0VdbLvQaqd/kCEmJpUtpaHsip/vbMBeJ9Kyu9GhH0TX4a40EA0TmEB59zKAJfs44PR1qR5SKc1A==
X-Received: by 2002:a37:ae86:: with SMTP id x128-v6mr2407940qke.25.1536246818044;
        Thu, 06 Sep 2018 08:13:38 -0700 (PDT)
Received: from linux.mshome.net ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id z3-v6sm2752030qkc.55.2018.09.06.08.13.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Sep 2018 08:13:31 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     git@jeffhostetler.com, stolee@gmail.com, gitster@pobox.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [RFC PATCH 2/6] comit-reach: use trace2 for commit_contains_tag_algo
Date:   Thu,  6 Sep 2018 15:13:05 +0000
Message-Id: <20180906151309.66712-3-dstolee@microsoft.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180906151309.66712-1-dstolee@microsoft.com>
References: <2ba9d81a-5578-a81c-a7d9-179864cb4277@gmail.com>
 <20180906151309.66712-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-reach.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/commit-reach.c b/commit-reach.c
index ee374dce20..0fc3b1ac18 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -481,6 +481,7 @@ static enum contains_result contains_tag_algo(struct commit *candidate,
 	enum contains_result result;
 	uint32_t cutoff = GENERATION_NUMBER_INFINITY;
 	const struct commit_list *p;
+	uint32_t num_walked = 0;
 
 	for (p = want; p; p = p->next) {
 		struct commit *c = p->item;
@@ -493,12 +494,15 @@ static enum contains_result contains_tag_algo(struct commit *candidate,
 	if (result != CONTAINS_UNKNOWN)
 		return result;
 
+	trace2_region_enter("contains_tag_algo");
 	push_to_contains_stack(candidate, &contains_stack);
 	while (contains_stack.nr) {
 		struct contains_stack_entry *entry = &contains_stack.contains_stack[contains_stack.nr - 1];
 		struct commit *commit = entry->commit;
 		struct commit_list *parents = entry->parents;
 
+		num_walked++;
+
 		if (!parents) {
 			*contains_cache_at(cache, commit) = CONTAINS_NO;
 			contains_stack.nr--;
@@ -521,7 +525,13 @@ static enum contains_result contains_tag_algo(struct commit *candidate,
 		}
 	}
 	free(contains_stack.contains_stack);
-	return contains_test(candidate, want, cache, cutoff);
+
+	result = contains_test(candidate, want, cache, cutoff);
+
+	trace2_data_intmax("contains_tag_algo", "num_walked", num_walked);
+	trace2_region_leave("contains_tag_algo");
+
+	return result;
 }
 
 int commit_contains(struct ref_filter *filter, struct commit *commit,
-- 
2.19.0.rc2

