Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-12.3 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB0CD1F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 00:13:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731066AbeKNKOg (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 05:14:36 -0500
Received: from mail-vk1-f202.google.com ([209.85.221.202]:43852 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727203AbeKNKOf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 05:14:35 -0500
Received: by mail-vk1-f202.google.com with SMTP id 62-v6so2360725vkl.10
        for <git@vger.kernel.org>; Tue, 13 Nov 2018 16:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=zGDdMPSddeFULDcISmWptCyX0A+0rR5eFWVgQhXPVTY=;
        b=MGNMONqvdBbMjLJWXYSMVhg9G0c+lnDCfpIt+DczVKWsJsq2TVNa8GlJsooYjg5jXi
         xseBzCt8kC/Fp/9gey5kEDfcu9KAasMZ3c2I46cqSPZNCyEP+7cWxZjbm/tZS66thHgz
         j4dv50flDd8EXZTb/5iBceM7hduAsKx2CG95uUW+OOvc54Owg1YddOMKvpx3SpW7lkow
         DfuUs+Z/tKFQ8h/2py8CEDVX+dP6nk0bdEIiN4w261qpGxOEXDfcsxDnvTBqkEGweBd2
         W1EQMKO4QYdjbPtguN0VSYkWJYCUQG4FiAmPXi7mxOaJaqeXyviWu74fpUJMrMCbLdBx
         53ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zGDdMPSddeFULDcISmWptCyX0A+0rR5eFWVgQhXPVTY=;
        b=XcQT50BsybGcA0FfCMF3oATjGmCPkV4fUMssTDjpMh336q8SPkHPLzuDw7ieRQIrVQ
         qvwON6/YYP3ZNKsBdPuKt9J1fgpEpg2bfqSLM5AmmNskg0QxiSIhjGP+5pcMqHF7BBlT
         wOhqW8vLws1DwLdx5Sdmlu4jdXP9Kjc1QDGVwJ/AM8iWCOx90OvzpQtaRDBWEIjsGMuI
         SDAqLztorqSBPbgL+WzebZXQfDB9rrDhOsccW7BSNvx2SxOc3VXo0sDOOZPPgx66kyiy
         tvcSkdKF1D6Igfwi0ObbOqAezgusC7shxy22Ay5ac23TsOwDLi/aSQUJbyGjBXe3JT6p
         4FuQ==
X-Gm-Message-State: AGRZ1gKBrUz/fhcCmeLq//mo7JCtvFhv/bozQqjv1xLv1YpAkW2bUV4I
        Ez+A0vC6cU7yQt1s0HaVTU4SQH++GIuT
X-Google-Smtp-Source: AJdET5dfrKub9KpUSpc7HfPXDLrHjZTDSHWqqoKXF98AhrLmfcApNezLVUIq2Wsl9xXD1O0I5Ee6gYGN6IyJ
X-Received: by 2002:a1f:2c4c:: with SMTP id s73mr6042848vks.7.1542154432211;
 Tue, 13 Nov 2018 16:13:52 -0800 (PST)
Date:   Tue, 13 Nov 2018 16:12:51 -0800
In-Reply-To: <20181114001306.138053-1-sbeller@google.com>
Message-Id: <20181114001306.138053-9-sbeller@google.com>
Mime-Version: 1.0
References: <20181114001306.138053-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.1.1215.g8438c0b245-goog
Subject: [PATCH 08/23] commit-reach.c: allow paint_down_to_common to handle
 any repo
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, jonathantanmy@google.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
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
2.19.1.1215.g8438c0b245-goog

