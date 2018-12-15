Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE0B920A1E
	for <e@80x24.org>; Sat, 15 Dec 2018 00:10:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730023AbeLOAKG (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Dec 2018 19:10:06 -0500
Received: from mail-yw1-f73.google.com ([209.85.161.73]:40114 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729995AbeLOAKG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Dec 2018 19:10:06 -0500
Received: by mail-yw1-f73.google.com with SMTP id l69so4248340ywb.7
        for <git@vger.kernel.org>; Fri, 14 Dec 2018 16:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Etx73kyqJPXbt8GvWfs4sqwAwR4Jh8mjtb5s5i9ZhcE=;
        b=RrmUl80krKFyswuw1T3B5v+IV67u0WOntMPMJ58cm6kSx44ve36vuxtEH5LEmCGBm9
         Ds2CILJIrpUFDtvv/0NKG7SKD20XXGRABIjP8Dw22zEzsZxC4tsfapJO3IZINhyZGLhJ
         Cy/xKdKQC2DaXvbZ3czlQ6FJDprXrTKtZxsG+Pd92EEhpTBIoT48HCY2KvNgFG2vefjv
         clDq9pXuRZ5dtCDO30O9vB2x0VE8IhhTfSFziqBD9Lvd3NMxALZ3n9kzP5POscEwj0Jh
         3QWStWXSl9UYaX7cEJ5aPdKBREKTX7gjW/ONuAorPktbGzCjCWfwgzRtw0hLv4mCPLel
         Bt5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Etx73kyqJPXbt8GvWfs4sqwAwR4Jh8mjtb5s5i9ZhcE=;
        b=dqZMKx1ZXYuH5oZeNfI4gJwe97dpRA/sR8sCoHDz7DzgQ2BKQND7k/C/FGwBkb/4UW
         gJ1ybfrxD0b+/JE69XuBgmvmtIfz0CX9uwhuhQz1PLJ242IqE2aQro6Bhp77LN15VXpm
         aKf5wEJppWgKcka5GVd1dZtD7BRhdbI0c3e5D4ksxIMgJ1S8vRVQXfXZAR8EWPGN0pyP
         X+tZ2+Ukk574sNGtXdCYghkJVFg5NOv9hhzaR8JqNReUg/QWtkLYkqphnc73tgWKsVSD
         flZAx6BhvCu+h8Tpp4iYmyi3JKo/BpyBXbb/UWlTyL6qoo20uvXrckRYWC+1rUmIaAjC
         9wrQ==
X-Gm-Message-State: AA+aEWZdlcbFnKta0XI9IPHSL39/4ZwKstkCwktA30y4AccobVhkS364
        N19jBbBmO1J6wWoaTbKAEwgb8ky/XPK58mmA683G0//QbGMZ/U2ELFAKzafNQ9OOKSwduBUpnXr
        XwdHJ/Fcv7Rqd6fb4uxqCZznOIiEr4twdBTD2SISua5I61+wpN4Kc67CoX9Kl
X-Google-Smtp-Source: AFSGD/W/dKe1Icb5cqqgl4m6VkrBF02kwpAulBnanFAmBLm79vIU7nkH++gU3LX+za8uo6enq1CfxT4xtSvP
X-Received: by 2002:a25:ac90:: with SMTP id x16-v6mr3324140ybi.3.1544832604840;
 Fri, 14 Dec 2018 16:10:04 -0800 (PST)
Date:   Fri, 14 Dec 2018 16:09:27 -0800
In-Reply-To: <20181215000942.46033-1-sbeller@google.com>
Message-Id: <20181215000942.46033-9-sbeller@google.com>
Mime-Version: 1.0
References: <20181215000942.46033-1-sbeller@google.com>
X-Mailer: git-send-email 2.20.0.405.gbc1bbc6f85-goog
Subject: [PATCH 08/23] commit-reach.c: allow paint_down_to_common to handle
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

As the function is file local and not widely used, migrate it all at once.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 commit-reach.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/commit-reach.c b/commit-reach.c
index 9f79ce0a22..67c2e43d5e 100644
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
@@ -83,7 +84,7 @@ static struct commit_list *paint_down_to_common(struct commit *one, int n,
 			parents = parents->next;
 			if ((p->object.flags & flags) == flags)
 				continue;
-			if (parse_commit(p))
+			if (repo_parse_commit(r, p))
 				return NULL;
 			p->object.flags |= flags;
 			prio_queue_put(&queue, p);
@@ -116,7 +117,7 @@ static struct commit_list *merge_bases_many(struct commit *one, int n, struct co
 			return NULL;
 	}
 
-	list = paint_down_to_common(one, n, twos, 0);
+	list = paint_down_to_common(the_repository, one, n, twos, 0);
 
 	while (list) {
 		struct commit *commit = pop_commit(&list);
@@ -187,8 +188,8 @@ static int remove_redundant(struct commit **array, int cnt)
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
@@ -322,7 +323,9 @@ int in_merge_bases_many(struct commit *commit, int nr_reference, struct commit *
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
2.20.0.405.gbc1bbc6f85-goog

