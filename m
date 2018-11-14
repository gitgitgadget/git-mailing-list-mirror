Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-12.3 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C988D1F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 00:14:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731260AbeKNKOs (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 05:14:48 -0500
Received: from mail-io1-f73.google.com ([209.85.166.73]:56932 "EHLO
        mail-io1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731191AbeKNKOr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 05:14:47 -0500
Received: by mail-io1-f73.google.com with SMTP id m1so1791176ioh.23
        for <git@vger.kernel.org>; Tue, 13 Nov 2018 16:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=9o9YDsgGUmPN52/oPMXRqdZNvbgLfyrW9jXywrxCI+o=;
        b=ud1ybqWzCOTZlOlfpOCOQI9oXsAa2rOZ9uk4wOox6vMAwx9K2BYAlmMZDseGs/LWpz
         AA6A4UoWo3Tv2OklCQiLPYlxT2R0vmUuvPZCI7EMKLVLIO+qP+2NhAem3PAVUpzH3Mj1
         2p8AmsTXBm9KedS9+yIdTHCiWpLV+/kQzlh+vvdi5PdhuewBfMKVmqOShknF9q0TbVZV
         lhEVmI9XXqjJfKVx2sXeVPwIwrDWVY2Mrt4WcP7VuOK3EcxjSSoh8Vz8/ol8d8xiDFY5
         6nPjCcGfyj50x0pQoviHTBnwLBsjETR+qUgn/LvLZBw69/YZ1YADdt8VqNUhte7oVntz
         6KLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=9o9YDsgGUmPN52/oPMXRqdZNvbgLfyrW9jXywrxCI+o=;
        b=OV30149SBKrh8jxRGLI9BYwUKo6BED9lVJtcaRcwvAH/O3FX21K5KwIyruj+f2T5c+
         meqIV2yeDjSk3EYIBmsTbgRD2dnze316NOBuLA1Ec2OvEckM2UEjzU7wIq3KYRp4BynK
         9XK4hv8Ms0uoMW+DwQAb+ogMc17vUXeln1ZFtEgZvlVXuRDQgQi7Yr9kO+4p+qO3ksYr
         Nq6wdbxPzYNdWV7DkMumfyMN8m+VZUQFLU8wRe7zn9Mx/I4tvYvkKSHEX4HvBulwk1dA
         sKp9CHqULJbani8O4VjjnvN1MXvihUiJjOIMT162gQRLHpbF3eQMasQyh05Htxbk6exQ
         9CUw==
X-Gm-Message-State: AGRZ1gIXKrqJdpRGLqpOmUXnEuZVIScs8dhGkvpIsG/+PjkfsyPWg9Hb
        yCyj3uDKou/cPGhVfVA4K9lnEc34WTi1
X-Google-Smtp-Source: AJdET5eb14m6AudoQRKUFMxsk+cnVfxuTAgCGy5GxpWU8bx/RdxF8T812r/8NvKB6xh1/0sl1CQ3QSF75HIR
X-Received: by 2002:a24:1644:: with SMTP id a65mr72806ita.40.1542154444226;
 Tue, 13 Nov 2018 16:14:04 -0800 (PST)
Date:   Tue, 13 Nov 2018 16:12:56 -0800
In-Reply-To: <20181114001306.138053-1-sbeller@google.com>
Message-Id: <20181114001306.138053-14-sbeller@google.com>
Mime-Version: 1.0
References: <20181114001306.138053-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.1.1215.g8438c0b245-goog
Subject: [PATCH 13/23] commit-reach: prepare in_merge_bases[_many] to handle
 any repo
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, jonathantanmy@google.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 commit-reach.c                                  | 15 +++++++++------
 commit-reach.h                                  | 12 ++++++++++--
 contrib/coccinelle/the_repository.pending.cocci | 17 +++++++++++++++++
 3 files changed, 36 insertions(+), 8 deletions(-)

diff --git a/commit-reach.c b/commit-reach.c
index 657a4e9b5a..8715008fef 100644
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
diff --git a/contrib/coccinelle/the_repository.pending.cocci b/contrib/coccinelle/the_repository.pending.cocci
index f6c2915a4e..8c6a71bf64 100644
--- a/contrib/coccinelle/the_repository.pending.cocci
+++ b/contrib/coccinelle/the_repository.pending.cocci
@@ -90,3 +90,20 @@ expression G;
 - get_merge_bases_many_dirty(
 + repo_get_merge_bases_many_dirty(the_repository,
   E, F, G);
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
2.19.1.1215.g8438c0b245-goog

