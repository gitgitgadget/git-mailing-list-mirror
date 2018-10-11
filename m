Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A8D71F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 21:18:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbeJLErT (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 00:47:19 -0400
Received: from mail-io1-f73.google.com ([209.85.166.73]:50531 "EHLO
        mail-io1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbeJLErT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 00:47:19 -0400
Received: by mail-io1-f73.google.com with SMTP id f5-v6so9020542ioq.17
        for <git@vger.kernel.org>; Thu, 11 Oct 2018 14:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=pVgUHI2uKlC/a+Ea8m1gk0SMIcfQSxo1rEe+FM4vawU=;
        b=b7mELdsDBhZ8uFde8FYFSY8my1v7d02zXYJVAxsYTWb5/ZyTxiX9YD9LybZY+vIVFN
         G04TjyUpuI/FHVVMJdBTTdT2kKf/9QG+UEbTnkDxOWsNHPgLZjL54fHskhus/smYynR8
         +x59rG4OvRV1lhrw1ZH+3NaN/BedkwRubH0tNyoMqGGTfBa09KDZL4xdBRl80VKVaUh+
         SzfaLdkXFfbg5SW3jUnsZ4iOX2LrwKT5tYl9v/H1GwIkY6JxbzkccfJRQ4S0fLKYb1iR
         yvb6mBrWRcj+PJgZ6NKPtyW8vZQvqU73Ko+NYaadLL+SrwcEe5EfmUX4mC9q9LAnQvX4
         VMYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=pVgUHI2uKlC/a+Ea8m1gk0SMIcfQSxo1rEe+FM4vawU=;
        b=Ma9kyAl3686+ZbRNGCAL6HjBptS/kISAxYuo7AKo3CTNnE7lLvr/UvvFSJsifS+Cvo
         okNrBYsfiestqNljkTP72yCSTZBqa4/BgxjoJ/p89cwAatnoke7uzROke6TnSL9zDiPI
         TfbomUDLRgqTxhabOf+hMKekzYsS85bTQ0n+Je1G1cM/7aNgguMTIr6jLUebcNA57q1x
         jATV8lB0yIu6y9BKlLffUmduPk4MZN+nBl3Jyiu+RijK3FIFUarWvzx+PJksTTxCvUmZ
         548lHjY9RojITYoYg0Gq7khL96/fqXtqaBzOrqabbBhIxpZXMc8JJuIra5c73fn2BhnI
         syow==
X-Gm-Message-State: ABuFfohBppFjTz7QmSG78lWzesyUUPwuyYAsVnsQVl4uAylTAnuHHjeT
        rsDNKl6jf0ZlYBaRF8EYwumuc1Rn7QBEHvRwzT2r47p9K4EVNxvKXOTKJw3Tt/EN91Pte9SXs4/
        A+Z0qupcNscFQ6nuwmjfsizJ7jPAk7D2S1fMl5WLcc2eO1TMflcr05ClZgt2R
X-Google-Smtp-Source: ACcGV61V/gS/jzbJj8beCQZe+fSbHTgRVUkttC14ZoNcGuZEnB2fYDUhADZMghg1Glso7UoMzsselxDnmy2i
X-Received: by 2002:a24:c7:: with SMTP id 190-v6mr5912770ita.2.1539292694649;
 Thu, 11 Oct 2018 14:18:14 -0700 (PDT)
Date:   Thu, 11 Oct 2018 14:17:42 -0700
In-Reply-To: <20181011211754.31369-1-sbeller@google.com>
Message-Id: <20181011211754.31369-8-sbeller@google.com>
Mime-Version: 1.0
References: <20181011211754.31369-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.0
Subject: [PATCH 07/19] commit.c: allow paint_down_to_common to handle
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
 commit.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/commit.c b/commit.c
index c6aeedc3d8..f493a82f72 100644
--- a/commit.c
+++ b/commit.c
@@ -869,7 +869,8 @@ static int queue_has_nonstale(struct prio_queue *queue)
 }
 
 /* all input commits in one and twos[] must have been parsed! */
-static struct commit_list *paint_down_to_common(struct commit *one, int n,
+static struct commit_list *paint_down_to_common(struct repository *r,
+						struct commit *one, int n,
 						struct commit **twos,
 						int min_generation)
 {
@@ -922,7 +923,7 @@ static struct commit_list *paint_down_to_common(struct commit *one, int n,
 			parents = parents->next;
 			if ((p->object.flags & flags) == flags)
 				continue;
-			if (parse_commit(p))
+			if (repo_parse_commit(r, p))
 				return NULL;
 			p->object.flags |= flags;
 			prio_queue_put(&queue, p);
@@ -955,7 +956,7 @@ static struct commit_list *merge_bases_many(struct commit *one, int n, struct co
 			return NULL;
 	}
 
-	list = paint_down_to_common(one, n, twos, 0);
+	list = paint_down_to_common(the_repository, one, n, twos, 0);
 
 	while (list) {
 		struct commit *commit = pop_commit(&list);
@@ -1026,8 +1027,8 @@ static int remove_redundant(struct commit **array, int cnt)
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
@@ -1151,7 +1152,9 @@ int in_merge_bases_many(struct commit *commit, int nr_reference, struct commit *
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

