Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 481BB1F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 21:18:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbeJLErd (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 00:47:33 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:35803 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbeJLErd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 00:47:33 -0400
Received: by mail-qt1-f202.google.com with SMTP id s56-v6so10176207qtk.2
        for <git@vger.kernel.org>; Thu, 11 Oct 2018 14:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=j2UQPbnp+o3nIkW55IhRqzszp3nTW+ZIzCMHc5yYDvo=;
        b=ZFgmCy3rcpzrp3QuF+eHzJFSu6yc1NsPeTe9+QpxPJ5o8H/unegJ9Wi8rUC0TQWLUQ
         mM7oSz2jpIOBqdryLHMYh7ynRKQ+bvgKpsojLydpsbpwj1h7bc9PFJp2gs+iDXthzJkj
         GKyVW7XKJwZdfEMaS1aB0gL9XSl9SgsMEiJjdC5f3T4XWT2GRbfuQggQvQD1GbhcwIdG
         3nZD8+3BC5g2QV3acsyNLzPDNdmjaItA1gm6QE+V71trno7alP+g5N7Gc+cl1CC5mXcO
         0KomHB97l0LtIQjeoMZK+2saEJ8nJZvDJI7Oi3XO6CuK4AwzcqpQrZIo47f0/mtzhctz
         D1wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=j2UQPbnp+o3nIkW55IhRqzszp3nTW+ZIzCMHc5yYDvo=;
        b=AxHf0yRoYgcwjfFzd8XcyyTQL5q2wZijo3ont7zo9N3gEhzKTXDcc30GLH8GjWpPD/
         J+sESkLb7Eep1fAZxpvVKJQ4JbK+c94heEdrvOLEtpM0IzY1Y3lmhVNjcETcVukj/zJH
         pp5eN1Nf/XfKCns2VkZ59hKJGrftFGpdi3DvVFVXY3vAB002+O+bc42pYsRxyu4GNcg4
         9dGnKMRtrkRYIsWC4wDU47QwQ8F+58xqjLFizb8ZBYarEbs1GuCWIK4me199hNxm7CT6
         m2AjY8fmOo70AlHNVhmBSyiAI1psIeefmiOR6UDtl1O8SqG191j8bFVc87+wyTrtZq4g
         78QA==
X-Gm-Message-State: ABuFfogqD95YdNmrrwjVfw8jhaQbjDCC5fSq9B98Cms+MwATvPnK6sHU
        umPe5Fh8uJHKUZd3cTOGXGn79XmAfKHw+xzvYV5l81lKs4x1T4ZTUAhO72ENM0NmIqRqTJSfMku
        X1xDt5VlF8kHe/8eIpPL8aNeBbUcW8SN27jxvHhuN+0pii4WVIUx+GUZb0tXF
X-Google-Smtp-Source: ACcGV62gQhP29mo+uYr94Rlfpbf1a3oPockqlAwERW4kwnUT+YA+ZsIxJTGJ/7JAMR1sjfV57h/ZEzfV7Efo
X-Received: by 2002:aed:3906:: with SMTP id l6-v6mr2715105qte.24.1539292707880;
 Thu, 11 Oct 2018 14:18:27 -0700 (PDT)
Date:   Thu, 11 Oct 2018 14:17:48 -0700
In-Reply-To: <20181011211754.31369-1-sbeller@google.com>
Message-Id: <20181011211754.31369-14-sbeller@google.com>
Mime-Version: 1.0
References: <20181011211754.31369-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.0
Subject: [PATCH 13/19] commit: prepare in_merge_bases[_many] to handle
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
 commit.c                                | 15 +++++++++------
 commit.h                                |  8 ++++++--
 contrib/coccinelle/the_repository.cocci | 17 +++++++++++++++++
 3 files changed, 32 insertions(+), 8 deletions(-)

diff --git a/commit.c b/commit.c
index 31f2ca4c78..eca9a475c7 100644
--- a/commit.c
+++ b/commit.c
@@ -1143,16 +1143,17 @@ int is_descendant_of(struct commit *commit, struct commit_list *with_commit)
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
@@ -1161,7 +1162,7 @@ int in_merge_bases_many(struct commit *commit, int nr_reference, struct commit *
 	if (commit->generation > min_generation)
 		return ret;
 
-	bases = paint_down_to_common(the_repository, commit,
+	bases = paint_down_to_common(r, commit,
 				     nr_reference, reference,
 				     commit->generation);
 	if (commit->object.flags & PARENT2)
@@ -1175,9 +1176,11 @@ int in_merge_bases_many(struct commit *commit, int nr_reference, struct commit *
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
diff --git a/commit.h b/commit.h
index 89b245be03..fead381651 100644
--- a/commit.h
+++ b/commit.h
@@ -283,8 +283,12 @@ extern void prune_shallow(int show_only);
 extern struct trace_key trace_shallow;
 
 int is_descendant_of(struct commit *, struct commit_list *);
-int in_merge_bases(struct commit *, struct commit *);
-int in_merge_bases_many(struct commit *, int, struct commit **);
+int repo_in_merge_bases(struct repository *r, struct commit *, struct commit *);
+int repo_in_merge_bases_many(struct repository *r, struct commit *, int, struct commit **);
+#ifndef NO_THE_REPOSITORY_COMPATIBILITY_MACROS
+#define in_merge_bases(c1, c2) repo_in_merge_bases(the_repository, c1, c2)
+#define in_merge_bases_many(c1, n, cs) repo_in_merge_bases_many(the_repository, c1, n, cs)
+#endif
 
 extern int interactive_add(int argc, const char **argv, const char *prefix, int patch);
 extern int run_add_interactive(const char *revision, const char *patch_mode,
diff --git a/contrib/coccinelle/the_repository.cocci b/contrib/coccinelle/the_repository.cocci
index 6dad83f17b..ec579682f6 100644
--- a/contrib/coccinelle/the_repository.cocci
+++ b/contrib/coccinelle/the_repository.cocci
@@ -68,3 +68,20 @@ expression F;
 - get_commit_buffer(
 + repo_get_commit_buffer(the_repository,
   E, F);
+
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

