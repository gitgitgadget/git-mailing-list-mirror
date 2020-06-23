Return-Path: <SRS0=IiYM=AE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE920C433DF
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 21:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9770F20663
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 21:02:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mforney-org.20150623.gappssmtp.com header.i=@mforney-org.20150623.gappssmtp.com header.b="MTxPEeNH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404278AbgFWVCV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 17:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404276AbgFWVCO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jun 2020 17:02:14 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BAF1C061573
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 14:02:14 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id x11so9655381plo.7
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 14:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mforney-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PJadnMLhu9d0L5zl8KO2mj6oLPrNQpCa0342XC5yvyg=;
        b=MTxPEeNHoB8HOJYdJlUDwyyi0M3iiqVR7sKl3qh2Kh6tilSwwi5gMzqtdsGe47HLzg
         xOASDvOmB2qsC2VvfW4tMMTdAxXXsvstoP3iAi4Cz9/0RX1paBUwZNkq62olmGj+QDEI
         zvsy5nLYPY1tZ+tPmkfa5WmbZY4RGM7dbvJW8rX7PPDE/d9x6wk6RHPeq412iJVQrpBT
         jTvL3f1FFDHqQfB6ZHWb541Oc3i15VGY3lpwoqg4ijtoFgmyobPu6aMwWE5SEc14mpQx
         Sscmqg5Ti7zIC7TqVdqL15+9HW/meB9zmFq8to6y187oH+2oqh6rSyCthS3/qJMLAopn
         TZYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PJadnMLhu9d0L5zl8KO2mj6oLPrNQpCa0342XC5yvyg=;
        b=FUevSGZhIoUF9tDnsb5fU1d5WZEgJbUY1Z1M+j/kTg45qgLhiHe15rSd2XveiigsVV
         lGRqKCNMmiJCB5wHpHtkEA87vY/pOtsCHBhbKdxPvgJa55E7Yp9uDxS5tDWvjVjs/WSi
         3z+h8bqHQoM1D0ai0gBIq2Pm/RMxlggQYSOT8BvqOk+pAaNx42uQ9FhvJvDHEbyIA10r
         LKY50bk/xa3vJbjp8MXOc6+MVHjehrVIUCK6UPbXRqfIqFhlLnIplDsYpGxxXuLpHKTl
         zV6AAV2hQDUw/NSsCyIf63bvRkExF5sQ5vL1M/dsROvWB6SbiQSNQMq8pxS49cTYikDq
         UXqw==
X-Gm-Message-State: AOAM530W8AyUBzDSvVHpR8HiFX0xlz1loHDfI5Yruaqc9iCHxJirxr8p
        L0ZrpqkHt0vS0NqRwxrD0YGMDw6YjcJoMA==
X-Google-Smtp-Source: ABdhPJwZ9rkQmwmsRbCxn2An/Vk7EWexl1WOWWek1Jm0YfaIB2gAnrJQXi1FFMuKgfZC1ZzPEaJUjQ==
X-Received: by 2002:a17:90b:714:: with SMTP id s20mr22726822pjz.99.1592946133231;
        Tue, 23 Jun 2020 14:02:13 -0700 (PDT)
Received: from localhost ([2601:647:5180:4570:16dd:a9ff:fee7:6b79])
        by smtp.gmail.com with ESMTPSA id n9sm3439190pjj.23.2020.06.23.14.02.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 23 Jun 2020 14:02:12 -0700 (PDT)
From:   Michael Forney <mforney@mforney.org>
To:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>
Subject: [PATCH 1/2] revision: use repository from rev_info when parsing commits
Date:   Tue, 23 Jun 2020 13:56:58 -0700
Message-Id: <20200623205659.14297-1-mforney@mforney.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is needed when repo_init_revisions() is called with a repository
that is not the_repository to ensure appropriate repository is used
in repo_parse_commit_internal(). If the wrong repository is used,
a fatal error is the commit-graph machinery occurs:

  fatal: invalid commit position. commit-graph is likely corrupt

Since revision.c was the only user of the parse_commit_gently
compatibility define, remove it from commit.h.

Signed-off-by: Michael Forney <mforney@mforney.org>
---
 commit.h   |  1 -
 revision.c | 18 +++++++++---------
 2 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/commit.h b/commit.h
index 1b2dea5d85..a2e8ca99a2 100644
--- a/commit.h
+++ b/commit.h
@@ -97,7 +97,6 @@ static inline int parse_commit_no_graph(struct commit *commit)
 
 #ifndef NO_THE_REPOSITORY_COMPATIBILITY_MACROS
 #define parse_commit_internal(item, quiet, use) repo_parse_commit_internal(the_repository, item, quiet, use)
-#define parse_commit_gently(item, quiet) repo_parse_commit_gently(the_repository, item, quiet)
 #define parse_commit(item) repo_parse_commit(the_repository, item)
 #endif
 
diff --git a/revision.c b/revision.c
index ebb4d2a0f2..2b6bf47c81 100644
--- a/revision.c
+++ b/revision.c
@@ -439,7 +439,7 @@ static struct commit *handle_commit(struct rev_info *revs,
 	if (object->type == OBJ_COMMIT) {
 		struct commit *commit = (struct commit *)object;
 
-		if (parse_commit(commit) < 0)
+		if (repo_parse_commit(revs->repo, commit) < 0)
 			die("unable to parse commit %s", name);
 		if (flags & UNINTERESTING) {
 			mark_parents_uninteresting(commit);
@@ -992,7 +992,7 @@ static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
 					ts->treesame[0] = 1;
 			}
 		}
-		if (parse_commit(p) < 0)
+		if (repo_parse_commit(revs->repo, p) < 0)
 			die("cannot simplify commit %s (because of %s)",
 			    oid_to_hex(&commit->object.oid),
 			    oid_to_hex(&p->object.oid));
@@ -1037,7 +1037,7 @@ static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
 				 * IOW, we pretend this parent is a
 				 * "root" commit.
 				 */
-				if (parse_commit(p) < 0)
+				if (repo_parse_commit(revs->repo, p) < 0)
 					die("cannot simplify commit %s (invalid %s)",
 					    oid_to_hex(&commit->object.oid),
 					    oid_to_hex(&p->object.oid));
@@ -1105,7 +1105,7 @@ static int process_parents(struct rev_info *revs, struct commit *commit,
 			parent = parent->next;
 			if (p)
 				p->object.flags |= UNINTERESTING;
-			if (parse_commit_gently(p, 1) < 0)
+			if (repo_parse_commit_gently(revs->repo, p, 1) < 0)
 				continue;
 			if (p->parents)
 				mark_parents_uninteresting(p);
@@ -1136,7 +1136,7 @@ static int process_parents(struct rev_info *revs, struct commit *commit,
 		struct commit *p = parent->item;
 		int gently = revs->ignore_missing_links ||
 			     revs->exclude_promisor_objects;
-		if (parse_commit_gently(p, gently) < 0) {
+		if (repo_parse_commit_gently(revs->repo, p, gently) < 0) {
 			if (revs->exclude_promisor_objects &&
 			    is_promisor_object(&p->object.oid)) {
 				if (revs->first_parent_only)
@@ -3295,7 +3295,7 @@ static void explore_walk_step(struct rev_info *revs)
 	if (!c)
 		return;
 
-	if (parse_commit_gently(c, 1) < 0)
+	if (repo_parse_commit_gently(revs->repo, c, 1) < 0)
 		return;
 
 	if (revs->sort_order == REV_SORT_BY_AUTHOR_DATE)
@@ -3333,7 +3333,7 @@ static void indegree_walk_step(struct rev_info *revs)
 	if (!c)
 		return;
 
-	if (parse_commit_gently(c, 1) < 0)
+	if (repo_parse_commit_gently(revs->repo, c, 1) < 0)
 		return;
 
 	explore_to_depth(revs, c->generation);
@@ -3414,7 +3414,7 @@ static void init_topo_walk(struct rev_info *revs)
 	for (list = revs->commits; list; list = list->next) {
 		struct commit *c = list->item;
 
-		if (parse_commit_gently(c, 1))
+		if (repo_parse_commit_gently(revs->repo, c, 1))
 			continue;
 
 		test_flag_and_insert(&info->explore_queue, c, TOPO_WALK_EXPLORED);
@@ -3476,7 +3476,7 @@ static void expand_topo_walk(struct rev_info *revs, struct commit *commit)
 		if (parent->object.flags & UNINTERESTING)
 			continue;
 
-		if (parse_commit_gently(parent, 1) < 0)
+		if (repo_parse_commit_gently(revs->repo, parent, 1) < 0)
 			continue;
 
 		if (parent->generation < info->min_generation) {
-- 
2.27.0

