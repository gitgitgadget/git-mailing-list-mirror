Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ACE2520A1E
	for <e@80x24.org>; Sat, 15 Dec 2018 00:10:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729670AbeLOAKK (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Dec 2018 19:10:10 -0500
Received: from mail-qk1-f201.google.com ([209.85.222.201]:37735 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbeLOAKK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Dec 2018 19:10:10 -0500
Received: by mail-qk1-f201.google.com with SMTP id s70so6779074qks.4
        for <git@vger.kernel.org>; Fri, 14 Dec 2018 16:10:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=edud6D32Xl3o0Vv2Yxc7tIJStc03SwPsoabEfx6VPpg=;
        b=vUiRW8amEYRm15Qivet48OPKUMgjEVPVG9rXvDgifQTlOIZsjN5Tl65MyEkWntOF8O
         Pq8FczlvYxVraTQqOIiKprkcComxKxtoemorDHwoyutV2nLmRfnJrHZw9AiJwWjhN4FR
         dH8nlOCO4blR5ooneTdCXiuN5Vm6tbqjlOSxwHO1+ueZ88nXf7LULxSQG8xLKykAdx3w
         V4u1wILIVBP8Ys1EGqyYJ0DqfqcAWKM5n/RfcfdtTQ6A5hIkyEMsHanbhuAKxgKlGBLl
         AJ+svpgP/lEJ+EM53Sl8bjN4jQrEiegOoF3HHftOy9TwWqUeUhor/bbW6DZ+W5ZuI68R
         NV8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=edud6D32Xl3o0Vv2Yxc7tIJStc03SwPsoabEfx6VPpg=;
        b=pVQzwc9YHlR0fAeqnWnBhozjw95KFJsEK/d0aq0ZPkAJ+mrzPdd2+oA8C3NubFUxhJ
         ziLgocehMRgIVGB8iIxAF4vAzndO8MGyUsjQj6+F495Wpw3uyGt4lhGxnLOfH2LwIVJY
         36Jx/uEKzqdbDZe3HmlWD3DSs75JoBCclBgMkJKAmxGzOirtZyqMPcRn81UC3er/n1bO
         rnn/JXCHmCcrFDoqNBWh7tchMLezl1cmH+C7ck7sXn1v/yhRvCwgtCjHnZa+Pd73OP+G
         gsp2dfF4SWC88FMhDhtqs4Pv4pkYagjERavbnMBj2Oq37Q9OJNY/VFxo+HEfMBfJrkeo
         LbFA==
X-Gm-Message-State: AA+aEWbkUb6RKY6vr89rrRYJTUJwnV0Ptz2Hr8nCFJJhHmR9iFXIzA4a
        SeduP38ZAaDn90WbY3imOwU9MaSOG301uvi31k1Mf+hv3szjz2c6p3qy7J0g2Qx4xeBwfhR5+bs
        5nbH+MiVva0P+F/OAXMgfk3xdBwuyDcAB0/BJXL5fmwu7W8IQgIbx5L2IIS+h
X-Google-Smtp-Source: AFSGD/Ve/3Ats5HXNS7nUQr80baTG23lDv5C4EoWgnZIJlvkDEJm+iILunD6fYtQWf5ftMOy9M72svEsomWZ
X-Received: by 2002:a0c:8709:: with SMTP id 9mr4814334qvh.6.1544832609493;
 Fri, 14 Dec 2018 16:10:09 -0800 (PST)
Date:   Fri, 14 Dec 2018 16:09:29 -0800
In-Reply-To: <20181215000942.46033-1-sbeller@google.com>
Message-Id: <20181215000942.46033-11-sbeller@google.com>
Mime-Version: 1.0
References: <20181215000942.46033-1-sbeller@google.com>
X-Mailer: git-send-email 2.20.0.405.gbc1bbc6f85-goog
Subject: [PATCH 10/23] commit-reach.c: allow remove_redundant to handle any repo
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 commit-reach.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/commit-reach.c b/commit-reach.c
index a53b31e6a2..81015830cb 100644
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
2.20.0.405.gbc1bbc6f85-goog

