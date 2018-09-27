Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2EFFE1F453
	for <e@80x24.org>; Thu, 27 Sep 2018 23:19:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbeI1FkQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Sep 2018 01:40:16 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:42364 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbeI1FkQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Sep 2018 01:40:16 -0400
Received: by mail-pf1-f202.google.com with SMTP id i68-v6so4767620pfb.9
        for <git@vger.kernel.org>; Thu, 27 Sep 2018 16:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=++1IYAYsDVOVSN7yAN0y+irgnK18n0FpHvM79h7hWDE=;
        b=kxjQS21qKQ2U9EmkjuRP3LlsdeuJ8bMn4gJjZhCw6vHpPgC5pPwJk0X5k+DygCxAtH
         Fa6VDGeDb+Rykf7vuBHoE19JBDcw5vmZCaVA07vFT50b4h04UAxWENtJe9RyDOOd16s9
         Bdn0MWDK6yShjtKszzOjJxxvl+wnzQoWPHtqsp77+N2m3l89d5uRu2ydtHugw+XH4h51
         wU+oMk0MUhJetnRicIKa05QzgAYTpB/PU7zFO2rq1pD5Tc6qWYOQg8RlDIsZI7ZH8ERk
         4JSP3jC9kCZjjNBKxTEsX2NRE3Mjx6SUDRVdChMn3IhcmBj03EQvL5nVyeH+yxUrNgP2
         V3VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=++1IYAYsDVOVSN7yAN0y+irgnK18n0FpHvM79h7hWDE=;
        b=KkmEoGHGYY4KNWgLCVHJUdNSs19k8AC31XQFieCv3MzluNVojA33eBxKzoObyh+iwj
         p5CVs6ChXABxJRo86HW6epH8sDoJAhYC01EyYdS6HfWrsDl7V3YQqmHJIBUOyRHnleqC
         Yk5gj2Gij/Hs+OHuiIVue5xb7FYujzdm4tJCCq61t16LDzZyPD8oE/+4yLxS8fwe+60V
         LzZDjam4Bn8fbxuHbavsK6DRzusAMvRbkJodwa+PBAF6i8dIc4bL8sLMh/p3kxRNF/q/
         DJYMRzTTkEm5O0oRRFos54b2IDd0tZh1hhxY8WIXxfCY1zK1ad5aaULCi7+TNnVuUHMi
         OVSg==
X-Gm-Message-State: ABuFfojf/AAy4UOY0FbhKs5fpVh5etNr+s9eqnZLvYMpzFzGSFUCKpOK
        /cmwimDptv2lNN7t8j/arcD4FlR6q957FEwFX2BoCFtngbjeqn5PwSa200XAWuBA2fmrYKdL9WC
        YFx1eYdy4d5qEwWkiayZtZTdOmGo9Am12+1PVzQpYp65tLQfIf370P09O2siRnTeD/VH17iSGmg
        hj
X-Google-Smtp-Source: ACcGV63KP1nKQT0wNEe/DUi0Z63Vuq0BFmrzZXmgHzfNse6oBAEsauBjEiOEM2vv+gaAx6o/4p9NemGyAop4BxrkWU1E
X-Received: by 2002:a63:89c6:: with SMTP id v189-v6mr2499777pgd.25.1538090372322;
 Thu, 27 Sep 2018 16:19:32 -0700 (PDT)
Date:   Thu, 27 Sep 2018 16:19:29 -0700
Message-Id: <20180927231929.180599-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
Subject: [PATCH] negotiator/skipping: parse commit before queueing
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, avarab@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The skipping negotiator pushes entries onto the priority queue without
ensuring that the commit is parsed, resulting in the entry ending up in
the wrong position due to a lack of commit time. Fix this by parsing the
commit whenever we push an entry onto the priority queue.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
This was noticed by Aevar in [1]. With this fix, 163 "have" lines are
produced instead of the 14002 reported in [1].

I have included a test to demonstrate the issue, but I'm not sure if
it's worth including it in the source tree.

[1] https://public-inbox.org/git/87o9ciisg6.fsf@evledraar.gmail.com/
---
 negotiator/skipping.c                |  2 +-
 t/t5552-skipping-fetch-negotiator.sh | 22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/negotiator/skipping.c b/negotiator/skipping.c
index dffbc76c49..9ce0555840 100644
--- a/negotiator/skipping.c
+++ b/negotiator/skipping.c
@@ -64,6 +64,7 @@ static struct entry *rev_list_push(struct data *data, struct commit *commit, int
 
 	entry = xcalloc(1, sizeof(*entry));
 	entry->commit = commit;
+	parse_commit(commit);
 	prio_queue_put(&data->rev_list, entry);
 
 	if (!(mark & COMMON))
@@ -177,7 +178,6 @@ static const struct object_id *get_rev(struct data *data)
 		if (!(commit->object.flags & COMMON) && !entry->ttl)
 			to_send = commit;
 
-		parse_commit(commit);
 		for (p = commit->parents; p; p = p->next)
 			parent_pushed |= push_parent(data, entry, p->item);
 
diff --git a/t/t5552-skipping-fetch-negotiator.sh b/t/t5552-skipping-fetch-negotiator.sh
index 30857b84a8..f2f938e54e 100755
--- a/t/t5552-skipping-fetch-negotiator.sh
+++ b/t/t5552-skipping-fetch-negotiator.sh
@@ -83,6 +83,28 @@ test_expect_success 'unknown fetch.negotiationAlgorithm values error out' '
 	test_i18ngrep ! "unknown fetch negotiation algorithm" err
 '
 
+test_expect_success 'works in absence of tags' '
+	rm -rf server client trace &&
+	git init server &&
+	test_commit -C server to_fetch &&
+
+	git init client &&
+	for i in $(test_seq 11)
+	do
+		test_commit -C client c$i
+	done &&
+	git -C client tag middle c6 &&
+	for i in $(test_seq 11)
+	do
+		git -C client tag -d c$i
+	done &&
+
+	test_config -C client fetch.negotiationalgorithm skipping &&
+	trace_fetch client "$(pwd)/server" &&
+	have_sent HEAD HEAD~2 HEAD~5 HEAD~10 &&
+	have_not_sent HEAD~1 HEAD~3 HEAD~4 HEAD~6 HEAD~7 HEAD~8 HEAD~9
+'
+
 test_expect_success 'when two skips collide, favor the larger one' '
 	rm -rf server client trace &&
 	git init server &&
-- 
2.19.0.605.g01d371f741-goog

