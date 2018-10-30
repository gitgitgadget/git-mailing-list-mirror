Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DC781F453
	for <e@80x24.org>; Tue, 30 Oct 2018 22:09:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728519AbeJaHEW (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Oct 2018 03:04:22 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:42140 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728510AbeJaHEW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Oct 2018 03:04:22 -0400
Received: by mail-qt1-f201.google.com with SMTP id j17-v6so15084868qtp.9
        for <git@vger.kernel.org>; Tue, 30 Oct 2018 15:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=g0TIQKkG9jM2my7wQxM0fdqysg1lbQu2ZA2GmZvtezg=;
        b=vDSoShlL+Zh/tzUlh5O9MzFZBRGtU6+t/Bdc9pECYW6o35quqzRbi6sEbtXSnasRzu
         gsX3kKArBibgmaIMLdVre3KlGcU0FCp0EDlEK+LUII9F2HufL5Wqr38BpzDZWQe3i4KW
         bGjKt6+QKD9lrc+Ky0yvPZqwa45Y2C2zMC8/bnBJ4vA10pJ15PuS6fIQ8mll3JvbXuaO
         03uv1j3cf7vydUrQ5/JzWmXnPR7nRPm+ujZzQYP6Of7e2RvBeWpEcAjBQjMkbFby/Ayw
         CvID55htyK8iv4bHacgHyU24dWrWrwu1XI76rgTs7E+C2rEMNabm1AJMyHLlQKSL7I6m
         I0fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=g0TIQKkG9jM2my7wQxM0fdqysg1lbQu2ZA2GmZvtezg=;
        b=n/0w8x8ioCaRqamXqh5jc22LmUuixoXFm588cQNCfw1hDQrNRPPOlp+49QdfqRPofA
         n46vG+n8Dg1hql4fZOIwHJ0tJ+h+8ywsVsYN7YhkIpdj3u0SgiyctBbAdebLPcvopR3l
         CVyDceWCXOEXI/HuuyH+l27LpJzy7WzOUETHkdiZRZEM/Me5zvomCLoLbLx3QVoVzcLz
         vL7Ro+TvZL3LfCTle1jkmopI3c8bm0eKa4BhVDlh/Vfvko/EariCXRn8NX1PKs+oC8Yw
         3SuA46oF0shafOrq8nKlQ/C/KN8nglh17rGxBWf0jigEGyThd8+8/n0VQnZobpPRwAsC
         4tRw==
X-Gm-Message-State: AGRZ1gIZdwpysIFu0qwF8Qm9L7E+BcWa/Sstk86nd0ap1j2QTFWrsK4L
        nS6rLh385NzPaSFCwi79GTQ8RBnAa03jLpNRo4+eZrl8cE7+CZfCOUD7AW0mC00VN8ZC11xUl/E
        p0qbbH2lWZvWauEx7FPi6WKwLkZysyOYjaNXmjXfIvJ6zhdqbwrt6l4UB/+cn
X-Google-Smtp-Source: AJdET5fKH6Rn4jpiZppJXf62MsZd1tMs22hOp9BDEv+htl/9IFWwIhJYCEJICv7oSNCxw8RZX/wqXgHAcfeo
X-Received: by 2002:ac8:2bb8:: with SMTP id m53-v6mr432769qtm.58.1540937346625;
 Tue, 30 Oct 2018 15:09:06 -0700 (PDT)
Date:   Tue, 30 Oct 2018 15:08:07 -0700
In-Reply-To: <20181030220817.61691-1-sbeller@google.com>
Message-Id: <20181030220817.61691-15-sbeller@google.com>
Mime-Version: 1.0
References: <20181030220817.61691-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
Subject: [PATCH 14/24] commit-reach: prepare in_merge_bases[_many] to handle
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
 commit-reach.c                                  | 15 +++++++++------
 commit-reach.h                                  | 12 ++++++++++--
 contrib/coccinelle/the_repository.pending.cocci | 16 ++++++++++++++++
 3 files changed, 35 insertions(+), 8 deletions(-)

diff --git a/commit-reach.c b/commit-reach.c
index 3be5526957..88a65f854f 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -312,16 +312,17 @@ int is_descendant_of(struct commit *commit, struct commit_list *with_commit)
 /*
  * Is "commit" an ancestor of one of the "references"?
  */
-int in_merge_bases_many(struct commit *commit, int nr_reference, struct commit **reference)
+int repo_in_merge_bases_many(struct repository *r, struct commit *commit,
+			     int nr_reference, struct commit **reference)
 {
 	struct commit_list *bases;
 	int ret = 0, i;
 	uint32_t min_generation = GENERATION_NUMBER_INFINITY;
 
-	if (parse_commit(commit))
+	if (repo_parse_commit(r, commit))
 		return ret;
 	for (i = 0; i < nr_reference; i++) {
-		if (parse_commit(reference[i]))
+		if (repo_parse_commit(r, reference[i]))
 			return ret;
 		if (reference[i]->generation < min_generation)
 			min_generation = reference[i]->generation;
@@ -330,7 +331,7 @@ int in_merge_bases_many(struct commit *commit, int nr_reference, struct commit *
 	if (commit->generation > min_generation)
 		return ret;
 
-	bases = paint_down_to_common(the_repository, commit,
+	bases = paint_down_to_common(r, commit,
 				     nr_reference, reference,
 				     commit->generation);
 	if (commit->object.flags & PARENT2)
@@ -344,9 +345,11 @@ int in_merge_bases_many(struct commit *commit, int nr_reference, struct commit *
 /*
  * Is "commit" an ancestor of (i.e. reachable from) the "reference"?
  */
-int in_merge_bases(struct commit *commit, struct commit *reference)
+int repo_in_merge_bases(struct repository *r,
+			struct commit *commit,
+			struct commit *reference)
 {
-	return in_merge_bases_many(commit, 1, &reference);
+	return repo_in_merge_bases_many(r, commit, 1, &reference);
 }
 
 struct commit_list *reduce_heads(struct commit_list *heads)
diff --git a/commit-reach.h b/commit-reach.h
index c647447263..6b16f12467 100644
--- a/commit-reach.h
+++ b/commit-reach.h
@@ -27,8 +27,16 @@ struct commit_list *repo_get_merge_bases_many_dirty(struct repository *r,
 struct commit_list *get_octopus_merge_bases(struct commit_list *in);
 
 int is_descendant_of(struct commit *commit, struct commit_list *with_commit);
-int in_merge_bases_many(struct commit *commit, int nr_reference, struct commit **reference);
-int in_merge_bases(struct commit *commit, struct commit *reference);
+int repo_in_merge_bases(struct repository *r,
+			struct commit *commit,
+			struct commit *reference);
+int repo_in_merge_bases_many(struct repository *r,
+			     struct commit *commit,
+			     int nr_reference, struct commit **reference);
+#ifndef NO_THE_REPOSITORY_COMPATIBILITY_MACROS
+#define in_merge_bases(c1, c2) repo_in_merge_bases(the_repository, c1, c2)
+#define in_merge_bases_many(c1, n, cs) repo_in_merge_bases_many(the_repository, c1, n, cs)
+#endif
 
 /*
  * Takes a list of commits and returns a new list where those
diff --git a/contrib/coccinelle/the_repository.pending.cocci b/contrib/coccinelle/the_repository.pending.cocci
index 5e037fe428..8c6a71bf64 100644
--- a/contrib/coccinelle/the_repository.pending.cocci
+++ b/contrib/coccinelle/the_repository.pending.cocci
@@ -91,3 +91,19 @@ expression G;
 + repo_get_merge_bases_many_dirty(the_repository,
   E, F, G);
 
+@@
+expression E;
+expression F;
+@@
+- in_merge_bases(
++ repo_in_merge_bases(the_repository,
+  E, F);
+
+@@
+expression E;
+expression F;
+expression G;
+@@
+- in_merge_bases_many(
++ repo_in_merge_bases_many(the_repository,
+  E, F, G);
-- 
2.19.1.930.g4563a0d9d0-goog

