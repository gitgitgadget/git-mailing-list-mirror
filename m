Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 421ED1F453
	for <e@80x24.org>; Tue, 16 Oct 2018 23:36:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbeJQH3E (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Oct 2018 03:29:04 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:38239 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727208AbeJQH3E (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Oct 2018 03:29:04 -0400
Received: by mail-pg1-f202.google.com with SMTP id e6-v6so18611226pge.5
        for <git@vger.kernel.org>; Tue, 16 Oct 2018 16:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=J4QIGeazp/1Ko/Qmg1P0KNpmHyB7EfDvXKAT6i2oaa8=;
        b=WzZXlJ7ndXRwKEhHLgY819zL1ODACngTQlZO4QJWT34SyDop+DizsP/r8sjlsW4LKN
         kx4kSv1HH+mm/sgniLTjqeLEwCMQgMMbszH2JwRjc9uVLYLCfX1djYaxToTh7Z0CJbY8
         +uq03S98LH1xE1r9AWs73Ga3oHjjV4/5wLyntv33wM0EA7SBnxMkfg9h/o4jCCPmQjJe
         iedukNor2zvPSbLoNvSoswl1OAv37IZq7Cm4ikNEQY9E/+BZ4NfwSDUZpKSFj9oQ8Vqm
         YBSuWedefNEwESKZWMZ252S2Q9pxhAMhz+lCe2yC8pr3QHn/z17qIIilwBgWLlDRkmRn
         kmig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=J4QIGeazp/1Ko/Qmg1P0KNpmHyB7EfDvXKAT6i2oaa8=;
        b=HzyzLYlFMkKZg/yJdn3jTiZ5urFp/rKF7ZMKb/N9hqjaiOhIJu7uLS33amzkCoz0LT
         Wg8DqQg3OaVOvdBJrKoSQzP/JbUC8Yz06Lou83eWWOK32l32A4EovxVu8Vnvi/R8gm5V
         gkTWfWG9GNqgpXnb2gjUy/XNnpEBZdqXIzeKhmEReRnz7McBoMtJgCswXz/lpNhG26/M
         ZYoZ95ppeCi23n62TwHGiHTRx4PhGrn71yNrlUdLufC4B6nrElcIp/FK0h9jArXHInsY
         Y2UeCfZgJt0ecllrrDjN4qryLvwM42T6V6p0Xu2be5p7Z6susULruEZqFNW9zM0mqx/2
         1U0Q==
X-Gm-Message-State: ABuFfoiqpKnqnCnYy5znlUq+gMxRD6Iqh1rQIbFVdxl4Qw06o5T48vXC
        DSRjznDf04jhMcm2DMu7DZNV4B9mWBksokqLfCXeuE8y7rg3EeVkJOcyjXzJ+JpGj1lGs4AUCst
        bp7eJZXvenfNsj974GXPWiyyKjRYI7drH88xQPEKDNjfwB1qPc8FnaqGsoxFA
X-Google-Smtp-Source: ACcGV62NVbHvr8cw7ZucuFqER/4HgNdn37ZjiHLCFjVhMxcuWxPUnZEY6GJFB4GSh5+Mxw/1DkdPsfA0cUNw
X-Received: by 2002:a63:ed47:: with SMTP id m7-v6mr11532335pgk.5.1539732979013;
 Tue, 16 Oct 2018 16:36:19 -0700 (PDT)
Date:   Tue, 16 Oct 2018 16:35:41 -0700
In-Reply-To: <20181016233550.251311-1-sbeller@google.com>
Message-Id: <20181016233550.251311-11-sbeller@google.com>
Mime-Version: 1.0
References: <20181016233550.251311-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.0
Subject: [PATCH 10/19] commit-reach.c: allow remove_redundant to handle
 arbitrary repositories
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, Stefan Beller <sbeller@google.com>
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
index aacd8cdc1e..bce4169f1f 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -153,7 +153,7 @@ struct commit_list *get_octopus_merge_bases(struct commit_list *in)
 	return ret;
 }
 
-static int remove_redundant(struct commit **array, int cnt)
+static int remove_redundant(struct repository *r, struct commit **array, int cnt)
 {
 	/*
 	 * Some commit in the array may be an ancestor of
@@ -171,7 +171,7 @@ static int remove_redundant(struct commit **array, int cnt)
 	ALLOC_ARRAY(filled_index, cnt - 1);
 
 	for (i = 0; i < cnt; i++)
-		parse_commit(array[i]);
+		repo_parse_commit(r, array[i]);
 	for (i = 0; i < cnt; i++) {
 		struct commit_list *common;
 		uint32_t min_generation = array[i]->generation;
@@ -187,7 +187,7 @@ static int remove_redundant(struct commit **array, int cnt)
 			if (array[j]->generation < min_generation)
 				min_generation = array[j]->generation;
 		}
-		common = paint_down_to_common(the_repository, array[i], filled,
+		common = paint_down_to_common(r, array[i], filled,
 					      work, min_generation);
 		if (array[i]->object.flags & PARENT2)
 			redundant[i] = 1;
@@ -246,7 +246,7 @@ static struct commit_list *get_merge_bases_many_0(struct commit *one,
 	clear_commit_marks(one, all_flags);
 	clear_commit_marks_many(n, twos, all_flags);
 
-	cnt = remove_redundant(rslt, cnt);
+	cnt = remove_redundant(the_repository, rslt, cnt);
 	result = NULL;
 	for (i = 0; i < cnt; i++)
 		commit_list_insert_by_date(rslt[i], &result);
@@ -367,7 +367,7 @@ struct commit_list *reduce_heads(struct commit_list *heads)
 			p->item->object.flags &= ~STALE;
 		}
 	}
-	num_head = remove_redundant(array, num_head);
+	num_head = remove_redundant(the_repository, array, num_head);
 	for (i = 0; i < num_head; i++)
 		tail = &commit_list_insert(array[i], tail)->next;
 	free(array);
-- 
2.19.0

