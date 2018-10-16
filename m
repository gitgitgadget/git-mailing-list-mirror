Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B984E1F453
	for <e@80x24.org>; Tue, 16 Oct 2018 23:36:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbeJQH3A (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Oct 2018 03:29:00 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:38238 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727208AbeJQH27 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Oct 2018 03:28:59 -0400
Received: by mail-pg1-f201.google.com with SMTP id e6-v6so18611164pge.5
        for <git@vger.kernel.org>; Tue, 16 Oct 2018 16:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=lwChrbuEGJgYppzD2Ie5ZpCjtPrl0112xaB9bQtvhhc=;
        b=MUOuoOxbTZl1SBlLojhYH7Btd6ot0o0TSR2edAxp4bHGjm3aDuwqk8RMCQVapYG8K1
         dak893kAfaLvYUyFggGhKW47OqYGuDjfyhvjr2kVTnYrYTDuj+7zITTI57diImdRKOd+
         4m/5Rs5XNNyx6nJoaUft32cp6Q+slYRF9h+EGvwyWoa9Py/PoNDvzH65cDZUjcZNBdUO
         WhCiv58JjTdfgJdM/ZUdEr2P/9Wyclvmxzn3ZlB8wHFl986zBurrkKe0h6BHleQa4qKV
         8QpZb0Sgpda3vTI9Xnq88OdjKXDQJ1qSSey8I30px18yhEkt7ga6PTv0NPPF3Hj8s5pj
         WXoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=lwChrbuEGJgYppzD2Ie5ZpCjtPrl0112xaB9bQtvhhc=;
        b=hHSUKt2cO207Lh18KgLJ70LR/n8rVraOqLcCADXys9S5l5tdlqMrhmLjcIvGxUT2V/
         efUGNgdGlFNbzXO8A688Q4PM8qoRMjJk0lCVtwMh8v/CTMhoM4GYLdee/mBVE3AiPBkm
         b9Ccmf8BYdZ+4x0oHn2/ueyoouNQBUimRRWpBoWmdYN8H8Sqhx9yPIq4FelpkkYwL1+G
         y9qvOO5davs6XCyPYAQwarVtAyF8qFl8V6EIzeScJgEEsWOdvVzS+Ep2joF8VxCQ9s5h
         SGLlX97/jZtAsvS0n2pPSGvFHSSKzZLOJDntR3YoyhwAWFHTvvoc3hWIz//Gwx+DO8Bc
         NfxA==
X-Gm-Message-State: ABuFfohwplX5drIB9FKytgeOvYY470tI+EPJQUgBTSpnu0E8BFvk4ocL
        LE7Nud8GYHiO0iRChG3Enk/fX0ScSOhV5RD4qGlZ16drhxijK5Fb33DmEShJgu5tJ4kuCm8dOeC
        HTDCp6eJ765ZGmK545Jb+lQ1JVwhhgYm0vrBrPulhUckS74/ZuSVXZye46rOM
X-Google-Smtp-Source: ACcGV63aaD/EkdUjUB2QrPKgJNRBEzxMH6XVY0J3oAxcCYhQ/KyRTOYTTZG4vR8u8HnW5pYN/KJpSl39OXB2
X-Received: by 2002:a62:1f41:: with SMTP id f62-v6mr12052529pff.59.1539732974576;
 Tue, 16 Oct 2018 16:36:14 -0700 (PDT)
Date:   Tue, 16 Oct 2018 16:35:39 -0700
In-Reply-To: <20181016233550.251311-1-sbeller@google.com>
Message-Id: <20181016233550.251311-9-sbeller@google.com>
Mime-Version: 1.0
References: <20181016233550.251311-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.0
Subject: [PATCH 08/19] commit-reach.c: allow paint_down_to_common to handle
 arbitrary repositories
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As the function is file local and not widely used, migrate it all at once.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 commit-reach.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/commit-reach.c b/commit-reach.c
index 5a845440a9..2f7ae20bd4 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -30,7 +30,8 @@ static int queue_has_nonstale(struct prio_queue *queue)
 }
 
 /* all input commits in one and twos[] must have been parsed! */
-static struct commit_list *paint_down_to_common(struct commit *one, int n,
+static struct commit_list *paint_down_to_common(struct repository *r,
+						struct commit *one, int n,
 						struct commit **twos,
 						int min_generation)
 {
@@ -80,7 +81,7 @@ static struct commit_list *paint_down_to_common(struct commit *one, int n,
 			parents = parents->next;
 			if ((p->object.flags & flags) == flags)
 				continue;
-			if (parse_commit(p))
+			if (repo_parse_commit(r, p))
 				return NULL;
 			p->object.flags |= flags;
 			prio_queue_put(&queue, p);
@@ -113,7 +114,7 @@ static struct commit_list *merge_bases_many(struct commit *one, int n, struct co
 			return NULL;
 	}
 
-	list = paint_down_to_common(one, n, twos, 0);
+	list = paint_down_to_common(the_repository, one, n, twos, 0);
 
 	while (list) {
 		struct commit *commit = pop_commit(&list);
@@ -184,8 +185,8 @@ static int remove_redundant(struct commit **array, int cnt)
 			if (array[j]->generation < min_generation)
 				min_generation = array[j]->generation;
 		}
-		common = paint_down_to_common(array[i], filled, work,
-					      min_generation);
+		common = paint_down_to_common(the_repository, array[i], filled,
+					      work, min_generation);
 		if (array[i]->object.flags & PARENT2)
 			redundant[i] = 1;
 		for (j = 0; j < filled; j++)
@@ -319,7 +320,9 @@ int in_merge_bases_many(struct commit *commit, int nr_reference, struct commit *
 	if (commit->generation > min_generation)
 		return ret;
 
-	bases = paint_down_to_common(commit, nr_reference, reference, commit->generation);
+	bases = paint_down_to_common(the_repository, commit,
+				     nr_reference, reference,
+				     commit->generation);
 	if (commit->object.flags & PARENT2)
 		ret = 1;
 	clear_commit_marks(commit, all_flags);
-- 
2.19.0

