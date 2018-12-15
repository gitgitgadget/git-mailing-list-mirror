Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8EFA120A1E
	for <e@80x24.org>; Sat, 15 Dec 2018 00:10:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730037AbeLOAKM (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Dec 2018 19:10:12 -0500
Received: from mail-pl1-f202.google.com ([209.85.214.202]:54628 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729985AbeLOAKM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Dec 2018 19:10:12 -0500
Received: by mail-pl1-f202.google.com with SMTP id c14so4686402pls.21
        for <git@vger.kernel.org>; Fri, 14 Dec 2018 16:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Qq36AbhTu2/y1VVQ5FAITMobyo+rHzjZ8TZA73x4h6M=;
        b=qkOnJv2C4dGlbngqAROmUA9GCHDxnWNpxkGHwJ346uhifzzO7fKXTNqY6DIWfPHzCL
         9XMO35W0uXtoitlW0sYvPa3bGC0c4tO+++IiHaDXWq/rxdFve2SNwUILUdCHcRP1X6cO
         TPULeGHb6VzJu+r3f7dusbUUotKMAkFcNI5siblFCsNzz7QyvPvE4bIubIfLJeO7GEaO
         EZpXonwj6QGA5sx9DgoqbI+k8dSpNaJ0dr+VWxD6+OpLvd+T3oNhqNqFPcdoWr13/pHp
         Rt7KQZipr5xCqtiYknlKGbEr7m8fpopIW+un+2FYqxIDckKyavGK1MiwR3TCNqgDkyBF
         HExQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Qq36AbhTu2/y1VVQ5FAITMobyo+rHzjZ8TZA73x4h6M=;
        b=GHHaXpIVhthgIZw4kt150f2frGGek7eC8eqr8Aoj1oP/+KGUOY3U1q3eF5NZpAxZpY
         JVuW4nnhiQ6XNa00tv23Le41/Izd2Mj0EfFHQVnv01hrmVUGGyyS8X6Qc1ziRDHPAh2c
         aD3nh2lX0DIYo1rDeYKxuRg440rm/dgGWYDJnTgu82Fuz33S+wb+Mri/P4XV3zQ13NfN
         sbGB5sqjpeRqc0i8Wyvw5WZ+QcDyU0B1e0UOGdtzgHSLdkQ6YSzc4jeI1n8X0FFIaNOM
         hN6I6VkXBYUJAWNuk0YkcMi6cUJkhlX4PN12e+LIfNT9qKQ9+gIA37Tgj1h21fpSnrZ8
         Hw1w==
X-Gm-Message-State: AA+aEWbNaJabQxSe1m5+A+0gS3ASu/EAAv6MRlz3MaU49qqMVlBzqmvX
        kGFk69BFS8pTvdHue0AkWxn47kazSoloi8fzuA7oOWZnWI6BMmn1zwCeVNPiQ5QqzKN0AjzGcU5
        CbCOo16izRj8kKsS5SL+Kl7kdOJH5MFrFXPPdJny8mQw52Ai6UY5vlSzGYBc6
X-Google-Smtp-Source: AFSGD/VNdON2BpF+pmMa+jadzie8v3bYa48zJDpBYDo3OYkexZ/Y3fwqbI7ALlPUmV512sv3XitGv34p4MgW
X-Received: by 2002:a62:d5c2:: with SMTP id d185mr2782711pfg.123.1544832611777;
 Fri, 14 Dec 2018 16:10:11 -0800 (PST)
Date:   Fri, 14 Dec 2018 16:09:30 -0800
In-Reply-To: <20181215000942.46033-1-sbeller@google.com>
Message-Id: <20181215000942.46033-12-sbeller@google.com>
Mime-Version: 1.0
References: <20181215000942.46033-1-sbeller@google.com>
X-Mailer: git-send-email 2.20.0.405.gbc1bbc6f85-goog
Subject: [PATCH 11/23] commit-reach.c: allow get_merge_bases_many_0 to handle
 any repo
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
 commit-reach.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/commit-reach.c b/commit-reach.c
index 81015830cb..b3b1f62aba 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -216,7 +216,8 @@ static int remove_redundant(struct repository *r, struct commit **array, int cnt
 	return filled;
 }
 
-static struct commit_list *get_merge_bases_many_0(struct commit *one,
+static struct commit_list *get_merge_bases_many_0(struct repository *r,
+						  struct commit *one,
 						  int n,
 						  struct commit **twos,
 						  int cleanup)
@@ -226,7 +227,7 @@ static struct commit_list *get_merge_bases_many_0(struct commit *one,
 	struct commit_list *result;
 	int cnt, i;
 
-	result = merge_bases_many(the_repository, one, n, twos);
+	result = merge_bases_many(r, one, n, twos);
 	for (i = 0; i < n; i++) {
 		if (one == twos[i])
 			return result;
@@ -249,7 +250,7 @@ static struct commit_list *get_merge_bases_many_0(struct commit *one,
 	clear_commit_marks(one, all_flags);
 	clear_commit_marks_many(n, twos, all_flags);
 
-	cnt = remove_redundant(the_repository, rslt, cnt);
+	cnt = remove_redundant(r, rslt, cnt);
 	result = NULL;
 	for (i = 0; i < cnt; i++)
 		commit_list_insert_by_date(rslt[i], &result);
@@ -261,19 +262,19 @@ struct commit_list *get_merge_bases_many(struct commit *one,
 					 int n,
 					 struct commit **twos)
 {
-	return get_merge_bases_many_0(one, n, twos, 1);
+	return get_merge_bases_many_0(the_repository, one, n, twos, 1);
 }
 
 struct commit_list *get_merge_bases_many_dirty(struct commit *one,
 					       int n,
 					       struct commit **twos)
 {
-	return get_merge_bases_many_0(one, n, twos, 0);
+	return get_merge_bases_many_0(the_repository, one, n, twos, 0);
 }
 
 struct commit_list *get_merge_bases(struct commit *one, struct commit *two)
 {
-	return get_merge_bases_many_0(one, 1, &two, 1);
+	return get_merge_bases_many_0(the_repository, one, 1, &two, 1);
 }
 
 /*
-- 
2.20.0.405.gbc1bbc6f85-goog

