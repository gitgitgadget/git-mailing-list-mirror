Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 811F21F453
	for <e@80x24.org>; Thu,  1 Nov 2018 13:46:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728676AbeKAWtf (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Nov 2018 18:49:35 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:37806 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728520AbeKAWte (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Nov 2018 18:49:34 -0400
Received: by mail-qk1-f195.google.com with SMTP id 131so12273472qkd.4
        for <git@vger.kernel.org>; Thu, 01 Nov 2018 06:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bNWMo2rE6LEt7eMpPhweIKa8rWyxVykawgFSDTBrghA=;
        b=XHjNQXCpf4bZ2dzS4THsML0lhS0DD/AQlSurFLqkGMVW4L+B4NIEUptALLkRIkzrGL
         ZXTn6H9wS6uekN4DnPC8jhzWE4EH0caxcmzoeBl8CbbsX2nFNTpP4p1iP+skNIEWGTK8
         XnJqZTAUxfX4Jkjem/14U2ukx5bC/W3DsT6nIfyYJR2TQoJggHqA0WIkbvZxWMg8SctC
         WqPGbSdLSfA3qZ8Fn8soX8c+xmwZ/NNAiwvP5gFFutciz8N+vMTTh3iWGb0+9E5LeiXd
         +pTNedEHnWr8GekORCeZxKCa6KuGALG9xg44BcgIoq5zrNoOY0K1a3ejnvKLws5s6VWo
         U6FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bNWMo2rE6LEt7eMpPhweIKa8rWyxVykawgFSDTBrghA=;
        b=R+R8MrLhVNGKhBjbTIxaAmIjiL4TevAZ60C0kJ0Hik1l8+3cLS6hhdMTg9s6GDe1es
         Lz3xDKJyDwMmKPds0i/DxokbaQSSHDR5Dk1z80iAOPW9drmCpIrPu8EeA9TCyZCEWLmB
         231MbnZWhAWMH0EGm1mMdY9kwwzisAUkP0ZfB+PnmhEEWah2wEY/ocER44b4AP3bY634
         lVNqDxh3kvwRSrP7/9uHTvyNinbVc6SvETzyYAdQ1yZnZRdLTiwQPltMrTkBLOZwMN0N
         OmhruVxUaZbo0ks3otKvuJLi2yusdn2ER2aVfRhlM/oLwz8ONiPgW66fQBPedcMkFeND
         Wn4A==
X-Gm-Message-State: AGRZ1gIMOZI4Hm40a/wzwzgSM8/4g33AXPzNwgVz41lXdw6xlm3V+/9r
        TYTSJp+rB53dUADYlyh+sAYPVzcK
X-Google-Smtp-Source: AJdET5cow79h4AiZ7qqWtz7JIQeVu45C8S9lSWUB1BB1cSFeW/LwGKghdHBcN4RKQlLfKbnzWDnl8w==
X-Received: by 2002:a37:a5d1:: with SMTP id o200mr6434591qke.328.1541079991130;
        Thu, 01 Nov 2018 06:46:31 -0700 (PDT)
Received: from stolee-linux.mshome.net ([167.220.148.125])
        by smtp.gmail.com with ESMTPSA id f75sm7347357qkf.96.2018.11.01.06.46.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 06:46:30 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, avarab@gmail.com, szeder.dev@gmail.com,
        peff@peff.net, jnareb@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v5 4/7] revision.c: begin refactoring --topo-order logic
Date:   Thu,  1 Nov 2018 13:46:20 +0000
Message-Id: <20181101134623.84055-5-dstolee@microsoft.com>
X-Mailer: git-send-email 2.19.1.542.gc4df23f792
In-Reply-To: <20181101134623.84055-1-dstolee@microsoft.com>
References: <pull.25.v4.git.gitgitgadget@gmail.com>
 <20181101134623.84055-1-dstolee@microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When running 'git rev-list --topo-order' and its kin, the topo_order
setting in struct rev_info implies the limited setting. This means
that the following things happen during prepare_revision_walk():

* revs->limited implies we run limit_list() to walk the entire
  reachable set. There are some short-cuts here, such as if we
  perform a range query like 'git rev-list COMPARE..HEAD' and we
  can stop limit_list() when all queued commits are uninteresting.

* revs->topo_order implies we run sort_in_topological_order(). See
  the implementation of that method in commit.c. It implies that
  the full set of commits to order is in the given commit_list.

These two methods imply that a 'git rev-list --topo-order HEAD'
command must walk the entire reachable set of commits _twice_ before
returning a single result.

If we have a commit-graph file with generation numbers computed, then
there is a better way. This patch introduces some necessary logic
redirection when we are in this situation.

In v2.18.0, the commit-graph file contains zero-valued bytes in the
positions where the generation number is stored in v2.19.0 and later.
Thus, we use generation_numbers_enabled() to check if the commit-graph
is available and has non-zero generation numbers.

When setting revs->limited only because revs->topo_order is true,
only do so if generation numbers are not available. There is no
reason to use the new logic as it will behave similarly when all
generation numbers are INFINITY or ZERO.

In prepare_revision_walk(), if we have revs->topo_order but not
revs->limited, then we trigger the new logic. It breaks the logic
into three pieces, to fit with the existing framework:

1. init_topo_walk() fills a new struct topo_walk_info in the rev_info
   struct. We use the presence of this struct as a signal to use the
   new methods during our walk. In this patch, this method simply
   calls limit_list() and sort_in_topological_order(). In the future,
   this method will set up a new data structure to perform that logic
   in-line.

2. next_topo_commit() provides get_revision_1() with the next topo-
   ordered commit in the list. Currently, this simply pops the commit
   from revs->commits.

3. expand_topo_walk() provides get_revision_1() with a way to signal
   walking beyond the latest commit. Currently, this calls
   add_parents_to_list() exactly like the old logic.

While this commit presents method redirection for performing the
exact same logic as before, it allows the next commit to focus only
on the new logic.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 revision.c | 42 ++++++++++++++++++++++++++++++++++++++----
 revision.h |  4 ++++
 2 files changed, 42 insertions(+), 4 deletions(-)

diff --git a/revision.c b/revision.c
index e18bd530e4..2dcde8a8ac 100644
--- a/revision.c
+++ b/revision.c
@@ -25,6 +25,7 @@
 #include "worktree.h"
 #include "argv-array.h"
 #include "commit-reach.h"
+#include "commit-graph.h"
 
 volatile show_early_output_fn_t show_early_output;
 
@@ -2454,7 +2455,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 	if (revs->diffopt.objfind)
 		revs->simplify_history = 0;
 
-	if (revs->topo_order)
+	if (revs->topo_order && !generation_numbers_enabled(the_repository))
 		revs->limited = 1;
 
 	if (revs->prune_data.nr) {
@@ -2892,6 +2893,33 @@ static int mark_uninteresting(const struct object_id *oid,
 	return 0;
 }
 
+struct topo_walk_info {};
+
+static void init_topo_walk(struct rev_info *revs)
+{
+	struct topo_walk_info *info;
+	revs->topo_walk_info = xmalloc(sizeof(struct topo_walk_info));
+	info = revs->topo_walk_info;
+	memset(info, 0, sizeof(struct topo_walk_info));
+
+	limit_list(revs);
+	sort_in_topological_order(&revs->commits, revs->sort_order);
+}
+
+static struct commit *next_topo_commit(struct rev_info *revs)
+{
+	return pop_commit(&revs->commits);
+}
+
+static void expand_topo_walk(struct rev_info *revs, struct commit *commit)
+{
+	if (add_parents_to_list(revs, commit, &revs->commits, NULL) < 0) {
+		if (!revs->ignore_missing_links)
+			die("Failed to traverse parents of commit %s",
+			    oid_to_hex(&commit->object.oid));
+	}
+}
+
 int prepare_revision_walk(struct rev_info *revs)
 {
 	int i;
@@ -2928,11 +2956,13 @@ int prepare_revision_walk(struct rev_info *revs)
 		commit_list_sort_by_date(&revs->commits);
 	if (revs->no_walk)
 		return 0;
-	if (revs->limited)
+	if (revs->limited) {
 		if (limit_list(revs) < 0)
 			return -1;
-	if (revs->topo_order)
-		sort_in_topological_order(&revs->commits, revs->sort_order);
+		if (revs->topo_order)
+			sort_in_topological_order(&revs->commits, revs->sort_order);
+	} else if (revs->topo_order)
+		init_topo_walk(revs);
 	if (revs->line_level_traverse)
 		line_log_filter(revs);
 	if (revs->simplify_merges)
@@ -3257,6 +3287,8 @@ static struct commit *get_revision_1(struct rev_info *revs)
 
 		if (revs->reflog_info)
 			commit = next_reflog_entry(revs->reflog_info);
+		else if (revs->topo_walk_info)
+			commit = next_topo_commit(revs);
 		else
 			commit = pop_commit(&revs->commits);
 
@@ -3278,6 +3310,8 @@ static struct commit *get_revision_1(struct rev_info *revs)
 
 			if (revs->reflog_info)
 				try_to_simplify_commit(revs, commit);
+			else if (revs->topo_walk_info)
+				expand_topo_walk(revs, commit);
 			else if (add_parents_to_list(revs, commit, &revs->commits, NULL) < 0) {
 				if (!revs->ignore_missing_links)
 					die("Failed to traverse parents of commit %s",
diff --git a/revision.h b/revision.h
index 2b30ac270d..fd4154ff75 100644
--- a/revision.h
+++ b/revision.h
@@ -56,6 +56,8 @@ struct rev_cmdline_info {
 #define REVISION_WALK_NO_WALK_SORTED 1
 #define REVISION_WALK_NO_WALK_UNSORTED 2
 
+struct topo_walk_info;
+
 struct rev_info {
 	/* Starting list */
 	struct commit_list *commits;
@@ -245,6 +247,8 @@ struct rev_info {
 	const char *break_bar;
 
 	struct revision_sources *sources;
+
+	struct topo_walk_info *topo_walk_info;
 };
 
 int ref_excluded(struct string_list *, const char *path);
-- 
2.19.1.542.gc4df23f792

