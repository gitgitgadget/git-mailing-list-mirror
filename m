Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8703F1F453
	for <e@80x24.org>; Tue, 30 Oct 2018 22:08:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728481AbeJaHEJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Oct 2018 03:04:09 -0400
Received: from mail-yw1-f74.google.com ([209.85.161.74]:46092 "EHLO
        mail-yw1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728393AbeJaHEJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Oct 2018 03:04:09 -0400
Received: by mail-yw1-f74.google.com with SMTP id i82-v6so4683485ywb.13
        for <git@vger.kernel.org>; Tue, 30 Oct 2018 15:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Ex0Go0raPxBYi3w2kEg8nl/ESMviQ+YVucF1o3Zjrng=;
        b=kL+Xmi1jOlIGDhUqO6OL7EnALioYa/SoidfmAXZKnnVk7PGRHdAL8Ca5RFZR41qfyI
         Lv6WJ6xHZvLurjTDR8aUTKTajHJOAwRMoUL+ZURrV0HiiPHTF9EwMAi7DiAFHRQKM3eh
         gV/HXrFtvg/c5kfR+QHZXdVPtB614lUE35D6C45+rHgVoJqR9vV+VWghVGzgqS4wJrzU
         9d60A5Epci2JYduR75K/8jM7KGa/zkcIXe6cDugB2D8ttlet8MzUmwkEq49hzLP3Giry
         858ZhcCTagSZeU//G+rOHJjQ315pQ1AnsXRvQPu6+vF0N9Pj9Ujt0Rl4NUyoQY7Jhoqy
         PFkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Ex0Go0raPxBYi3w2kEg8nl/ESMviQ+YVucF1o3Zjrng=;
        b=LVfYlFOjgXuKOwTOnhDu9nM+O4Ysa6SmyCkRyMXtHfIFVqdYCams3JMlmd55duhTSL
         BT/FhMcDJnZ/bB8UZ02PjBz2kNFmxzYniXPtAjAQN3ZH+m/DsvzDMLQe9rv7okXNTqQs
         A8hgtZBk6B3ZBlC4z/TbB7RPr88HnTlExlePN3O/zOqLyKA+OK5x0RQ4jzMSKTUteeCf
         y+1stlGRZOxmtBQ1PNCIzCIe8iMRgr9OwWh2mGoTO3cHcnChlUamSaPSpK7BlvnjUcvH
         322iQKb4IhWhQ8RySehFRhZuko8uSP7ek5IlRiakcG/yDxLrvtkU06LIKxCC7MFVpunw
         IPNA==
X-Gm-Message-State: AGRZ1gL7USDHhqZiYi/4rrlhBNVRIs3KcV8+yiJiyt2JAzq9J0lJsMgC
        Ke7bCV/vwJAhsn0273kdMDGse/hr1efm4ufYgZLpB1PcbFXOvAHpkFdA3u57melfsrINeliOsLg
        IDohnLXAg88KXlC40BK5injgy92Uxv8o8rHJmoGr9fSWq3x1hbmIU4n17NG5y
X-Google-Smtp-Source: AJdET5dl46RvyJb4RT+3KJNkfVzDz9I7PuhEuoZj7U86+Alwj0KSAlecF9zBDsNq1lkqQsZZUpon6SKTxmlV
X-Received: by 2002:a5b:3c8:: with SMTP id t8-v6mr367606ybp.55.1540937334471;
 Tue, 30 Oct 2018 15:08:54 -0700 (PDT)
Date:   Tue, 30 Oct 2018 15:08:02 -0700
In-Reply-To: <20181030220817.61691-1-sbeller@google.com>
Message-Id: <20181030220817.61691-10-sbeller@google.com>
Mime-Version: 1.0
References: <20181030220817.61691-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
Subject: [PATCH 09/24] commit-reach.c: allow paint_down_to_common to handle
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

As the function is file local and not widely used, migrate it all at once.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 commit-reach.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/commit-reach.c b/commit-reach.c
index a9da65c462..080ae0a758 100644
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
2.19.1.930.g4563a0d9d0-goog

