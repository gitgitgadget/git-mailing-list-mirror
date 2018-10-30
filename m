Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D8921F453
	for <e@80x24.org>; Tue, 30 Oct 2018 22:09:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728489AbeJaHEO (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Oct 2018 03:04:14 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:57156 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728482AbeJaHEO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Oct 2018 03:04:14 -0400
Received: by mail-pl1-f201.google.com with SMTP id v7-v6so10752532plo.23
        for <git@vger.kernel.org>; Tue, 30 Oct 2018 15:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=sKk2u9G+3MWGs877csYKraZaKSP2qAvAYU+zayAuQvY=;
        b=t1wh39eCcEAzkIkVifqBmLeT1J+OY+eS/JApWXvVeTnYDgI07Wz5S9U6XOzooKjH1m
         DnjsxvZhes4jtU6eoXXnmhhiYDv4vDmuIe2vdnyhcQ9w7Apm7fovzfSKPGRwqcT9uwVc
         ShuA8c6rJsDWY9dMmlMe5QB6ujj8rywNTXzOEtVBTV11/s5G/0f2s+5scxudjotS4I9W
         EX4g1ToyGLHg1JGS6EMkxumc1c3InG0hjjI+uj6bTzfXguUxmyJSn9AghDER5EMxUQnR
         l9Tg88qmKT3T8gESHyDh++8b+Bh/TPZ+925fiM//0MITvjphUJeL6MvD4JPMqqR5H69c
         7tzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=sKk2u9G+3MWGs877csYKraZaKSP2qAvAYU+zayAuQvY=;
        b=JqdT9kf4f2gV7l2iKkY2l9ZApB7Gj3LShsldlZvs10XKOQhXxzHR9sWCRgDeVDbrXZ
         YcAf6MUg4O4/OYnb9GhrAFqfx583ePnxo1AFu/t9LnwUplr/y2h5R2LjHEAQGh6edpYB
         pD5dVkr8w3TjAIT8vin6rzEExqFyykacgJnhDvPwKXN9urVQVCkJV2xiLO9cRtHU3rJB
         mUocj44XouKavx8dFlhqvfn8juGEvVZ91kppVpFJLFqzoZqcU9AYrZAVKwoIHZTg+U1V
         cVfipIdhJtyZX8Gtjih4oGiuH4HU/RCaCeYLZre1nEzhE4xecKq1iQy6hR271MaP9cp8
         4D/w==
X-Gm-Message-State: AGRZ1gL4Al3+sOW21S5lxNFqPi1D8dzXxnsarjPLxW/dP+pKHqNHpWyZ
        34X88J6bfKGQOo5NdzfZe4seJ6HugPobSXFyDyuLsgNNYGImQE9Mp/7WXJqsROG89bfw+uHLWI+
        i5euSIITAcnUK07jThV+VyzOwQ6DY6ZUGQ0FkQbT63wh0WcrioyxQi9EyWNZ3
X-Google-Smtp-Source: AJdET5dURuUQonRRDWiIihRGOUduzAGOARru5S6cnUYZ/Km4hCwaRAaWhiTtdqGUW0dXoz0kdKOlsDiHGbcM
X-Received: by 2002:a17:902:8605:: with SMTP id f5-v6mr213320plo.106.1540937339347;
 Tue, 30 Oct 2018 15:08:59 -0700 (PDT)
Date:   Tue, 30 Oct 2018 15:08:04 -0700
In-Reply-To: <20181030220817.61691-1-sbeller@google.com>
Message-Id: <20181030220817.61691-12-sbeller@google.com>
Mime-Version: 1.0
References: <20181030220817.61691-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
Subject: [PATCH 11/24] commit-reach.c: allow remove_redundant to handle
 arbitrary repositories
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     szeder.dev@gmail.com, jonathantanmy@google.com,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 commit-reach.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/commit-reach.c b/commit-reach.c
index 4cf471bfaf..ab2bb1e5d5 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -156,7 +156,7 @@ struct commit_list *get_octopus_merge_bases(struct commit_list *in)
 	return ret;
 }
 
-static int remove_redundant(struct commit **array, int cnt)
+static int remove_redundant(struct repository *r, struct commit **array, int cnt)
 {
 	/*
 	 * Some commit in the array may be an ancestor of
@@ -174,7 +174,7 @@ static int remove_redundant(struct commit **array, int cnt)
 	ALLOC_ARRAY(filled_index, cnt - 1);
 
 	for (i = 0; i < cnt; i++)
-		parse_commit(array[i]);
+		repo_parse_commit(r, array[i]);
 	for (i = 0; i < cnt; i++) {
 		struct commit_list *common;
 		uint32_t min_generation = array[i]->generation;
@@ -190,7 +190,7 @@ static int remove_redundant(struct commit **array, int cnt)
 			if (array[j]->generation < min_generation)
 				min_generation = array[j]->generation;
 		}
-		common = paint_down_to_common(the_repository, array[i], filled,
+		common = paint_down_to_common(r, array[i], filled,
 					      work, min_generation);
 		if (array[i]->object.flags & PARENT2)
 			redundant[i] = 1;
@@ -249,7 +249,7 @@ static struct commit_list *get_merge_bases_many_0(struct commit *one,
 	clear_commit_marks(one, all_flags);
 	clear_commit_marks_many(n, twos, all_flags);
 
-	cnt = remove_redundant(rslt, cnt);
+	cnt = remove_redundant(the_repository, rslt, cnt);
 	result = NULL;
 	for (i = 0; i < cnt; i++)
 		commit_list_insert_by_date(rslt[i], &result);
@@ -370,7 +370,7 @@ struct commit_list *reduce_heads(struct commit_list *heads)
 			p->item->object.flags &= ~STALE;
 		}
 	}
-	num_head = remove_redundant(array, num_head);
+	num_head = remove_redundant(the_repository, array, num_head);
 	for (i = 0; i < num_head; i++)
 		tail = &commit_list_insert(array[i], tail)->next;
 	free(array);
-- 
2.19.1.930.g4563a0d9d0-goog

