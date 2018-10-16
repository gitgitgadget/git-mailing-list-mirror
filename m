Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0647D1F453
	for <e@80x24.org>; Tue, 16 Oct 2018 23:36:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbeJQH3L (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Oct 2018 03:29:11 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:41139 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727208AbeJQH3L (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Oct 2018 03:29:11 -0400
Received: by mail-qt1-f201.google.com with SMTP id j60-v6so26161135qtb.8
        for <git@vger.kernel.org>; Tue, 16 Oct 2018 16:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=lJ5XnWmMwZgP2dNtMbW8UO/ykc24nZuOEeoq/IQXo6U=;
        b=jKPPDtJ+gDybqw6SaM908zJXt8TE/o85ziZl1ATOSlx+xGh3JewcoJ+ClgYzv6I+Ap
         2mDvfEVNWm9WD4VOEs+FB48h37jjOxgxvS9K0qT3s+bngjJ4PTlxK64mZgpVtXm+CKJl
         minyD5FSK/hjE3XmNs9nETr4h8Y834+A2HVNt26zvMKUrSeCw/OG3snuCmJLNl3lGWf0
         elKidj1IqY0fWBNE27sQzyE7Z3bUWkz8WiPzSVKZ94KmPKdkKyS8qJQUgoZfTwmerwGd
         zzcqy17baQKdnc2y+TjzFislO9wAOqrbvSPfxiB1kpwmmArZLaocEuwMFaXRj9X4v3qP
         NSPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=lJ5XnWmMwZgP2dNtMbW8UO/ykc24nZuOEeoq/IQXo6U=;
        b=jhk2L3VXMd0Ry8a8wO0YgyM8WKBnW7dp8u9suUjlzIPrSaIuNCEuCmX/GyIeD1a2wb
         afqYFWxl/45sTX6yyReIpNkBeEKt4o3YKkkVV9EBYWwqB0dhaChAarZ/kopGOAZZX8VP
         3kKynW2OKYR9qsZVGuCAHUhG3pGu9vj5MUaQT5yEzj8Kqat0eInKIMXCoJx+4aW8hdEo
         0YerSm+6h/WE1VQuYMLXC51hrmrvKnekxz2gyIg2Acpg7IQYksWmAbU+iYpeqW/MTvyx
         12SpHFTF/Xa08VBAy9ZFLIlHgcKfIYKO/WnHbr1d5lDZhzoGqakfDCyhNohau8GUnurp
         3gHA==
X-Gm-Message-State: ABuFfogj4ojLMmiU9sHHF7JxzsdqwgeJd9/VBWsobW+J5lA5HwyJIoF6
        pr82gx6QCy4YPvYprlcnvR4xzpKsmXa4icxp5cRL+8UO4qh4MpN+PR0l50P5sGJuL9BoE8EQw7O
        PChmUHAPAlHppTl9/CWNmIZhJyuIlxgoZz9shhAzIpYv9iTIRH/8oz7aksLBz
X-Google-Smtp-Source: ACcGV62JmhhwUF+lhpskG5mjni36G3Hy1Ksyof9v8ADfGq7o9wc1MnO4dWsbBmufKoQN+LfznNMSD/P5y8sU
X-Received: by 2002:a0c:88b2:: with SMTP id 47mr19355242qvn.58.1539732985803;
 Tue, 16 Oct 2018 16:36:25 -0700 (PDT)
Date:   Tue, 16 Oct 2018 16:35:44 -0700
In-Reply-To: <20181016233550.251311-1-sbeller@google.com>
Message-Id: <20181016233550.251311-14-sbeller@google.com>
Mime-Version: 1.0
References: <20181016233550.251311-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.0
Subject: [PATCH 13/19] commit-reach: prepare in_merge_bases[_many] to handle
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
 commit-reach.c                          | 15 +++++++++------
 commit-reach.h                          | 12 ++++++++++--
 contrib/coccinelle/the_repository.cocci | 16 ++++++++++++++++
 3 files changed, 35 insertions(+), 8 deletions(-)

diff --git a/commit-reach.c b/commit-reach.c
index aa3cde5c8a..1877f356e3 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -309,16 +309,17 @@ int is_descendant_of(struct commit *commit, struct commit_list *with_commit)
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
@@ -327,7 +328,7 @@ int in_merge_bases_many(struct commit *commit, int nr_reference, struct commit *
 	if (commit->generation > min_generation)
 		return ret;
 
-	bases = paint_down_to_common(the_repository, commit,
+	bases = paint_down_to_common(r, commit,
 				     nr_reference, reference,
 				     commit->generation);
 	if (commit->object.flags & PARENT2)
@@ -341,9 +342,11 @@ int in_merge_bases_many(struct commit *commit, int nr_reference, struct commit *
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
index 52667d64ac..a0d4a29d25 100644
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
diff --git a/contrib/coccinelle/the_repository.cocci b/contrib/coccinelle/the_repository.cocci
index 5e037fe428..8c6a71bf64 100644
--- a/contrib/coccinelle/the_repository.cocci
+++ b/contrib/coccinelle/the_repository.cocci
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
2.19.0

