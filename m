Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C93320985
	for <e@80x24.org>; Sun, 11 Sep 2016 08:02:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753680AbcIKICc (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Sep 2016 04:02:32 -0400
Received: from mout.gmx.net ([212.227.17.20]:58091 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752499AbcIKICZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Sep 2016 04:02:25 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MDR21-1boFzK2V7V-00GtlZ; Sun, 11 Sep 2016 10:02:20
 +0200
Date:   Sun, 11 Sep 2016 10:02:18 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/5] pull: drop confusing prefix parameter of
 die_on_unclean_work_tree()
In-Reply-To: <cover.1473580914.git.johannes.schindelin@gmx.de>
Message-ID: <e987803dcf4c0af74aa22a9e4903e88241c8b823.1473580914.git.johannes.schindelin@gmx.de>
References: <cover.1472137582.git.johannes.schindelin@gmx.de> <cover.1473580914.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:6D/ARy+QdmXcCzGkPR6ZIi6Mi6lzwr06B+aSD2bhZdhLnblb7h5
 SKZIozJzZv73SBfgtMVjXn/L6U8J1/SqUOww9CHuXe7Lu77RdpZH2UNtLXybZqSBsOD7Lhc
 HAHEkdyJvfzPZAzO5DOoPbserHCcuVcQMqWe1kkbUOpbHe2k04XENyG6Hcb4iFj8kw8p/t7
 RKCsdMVWxBgIK9PkJYksg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:BWSifBz/3Hw=:WscpIMtiAn2NJn9RiD4EbX
 SyHN0WDX7fzmRIX3D3NLTuvQ8bvsZfYq3HCHzmYt96wjLPzS+auSXwwMxl1q2MFZAoIt8TGV2
 UkbT+ULPcEW0JmRLamQhLfA4k22mcistBA27PKoKAGJNKsP4o1LFNQZX/NVqnRnJG+ypvxD/M
 rRJ+lfApvGSFuMY7AzTPOtfm0/Ktkf+9TiZ9RvancL1daTu6Cf5O5rc52qpZraDSR5bV/5z26
 gu4om/OP0RX6XP1YmkpSLMWpUr8EezLVHofpUqpX7j8t1+OcsW35KWMkH8asQvlU7xCevl1Ev
 fPo+veFGFiAVc0HsCmFRN6PJmo3gXIMnfb+hNsGPezx5keueFFlrvyvns12Cnsr79aA87Bfq/
 pOU3I1HzkFb9Eo6BKZ0+T237ok7SpLUNkhzJcP+1oc5099GTKCVtB0iW2pytH2zh8NCgS8ggG
 ATHGil++eHkiwTecvKXfiUpSHf/2eap5L40MFUjAdQQ5bU9QVe/0CIuH+lT0jIPfGNA8ODwwf
 9iUAh5qp8Lcj3lqTyE9f3mz6qAjfBXVDeP/+8DWDDIJA8J9Dg3AkkugFGFSvQnsz7Ebpnuhc1
 WWzdgQZtRW49iYMtZih4T6kMKEMK3j+mQueZ/TlkEsKAZ6bMGsyKuOSRJ+xinxzjXQU/bn6UH
 FgzJhh5YjlKJxB2YKpvVyu5DGyDLRfln/ausn1H0CrNMjb4SUtEozfvojeZ8lsYJbrRs5ezXv
 7bkF8byNuuICmqqgfpuvPhL5pwcazcQ/BrAbzeYV+oWou77Bau/qhx5h7w5YrrORtvW9oEZQn
 I6DklnK
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In cmd_pull(), when verifying that there are no changes preventing a
rebasing pull, we diligently pass the prefix parameter to the
die_on_unclean_work_tree() function which in turn diligently passes it
to the has_unstaged_changes() and has_uncommitted_changes() functions.

The casual reader might now be curious (as this developer was) whether
that means that calling `git pull --rebase` in a subdirectory will
ignore unstaged changes in other parts of the working directory. And be
puzzled that `git pull --rebase` (correctly) complains about those
changes outside of the current directory.

The puzzle is easily resolved: while we take pains to pass around the
prefix and even pass it to init_revisions(), the fact that no paths are
passed to init_revisions() ensures that the prefix is simply ignored.

That, combined with the fact that we will *always* want a *full* working
directory check before running a rebasing pull, is reason enough to
simply do away with the actual prefix parameter and to pass NULL
instead, as if we were running this from the top-level working directory
anyway.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/pull.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index 398aae1..d4bd635 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -328,12 +328,12 @@ static int git_pull_config(const char *var, const char *value, void *cb)
 /**
  * Returns 1 if there are unstaged changes, 0 otherwise.
  */
-static int has_unstaged_changes(const char *prefix)
+static int has_unstaged_changes(void)
 {
 	struct rev_info rev_info;
 	int result;
 
-	init_revisions(&rev_info, prefix);
+	init_revisions(&rev_info, NULL);
 	DIFF_OPT_SET(&rev_info.diffopt, IGNORE_SUBMODULES);
 	DIFF_OPT_SET(&rev_info.diffopt, QUICK);
 	diff_setup_done(&rev_info.diffopt);
@@ -344,7 +344,7 @@ static int has_unstaged_changes(const char *prefix)
 /**
  * Returns 1 if there are uncommitted changes, 0 otherwise.
  */
-static int has_uncommitted_changes(const char *prefix)
+static int has_uncommitted_changes(void)
 {
 	struct rev_info rev_info;
 	int result;
@@ -352,7 +352,7 @@ static int has_uncommitted_changes(const char *prefix)
 	if (is_cache_unborn())
 		return 0;
 
-	init_revisions(&rev_info, prefix);
+	init_revisions(&rev_info, NULL);
 	DIFF_OPT_SET(&rev_info.diffopt, IGNORE_SUBMODULES);
 	DIFF_OPT_SET(&rev_info.diffopt, QUICK);
 	add_head_to_pending(&rev_info);
@@ -365,7 +365,7 @@ static int has_uncommitted_changes(const char *prefix)
  * If the work tree has unstaged or uncommitted changes, dies with the
  * appropriate message.
  */
-static void die_on_unclean_work_tree(const char *prefix)
+static void die_on_unclean_work_tree(void)
 {
 	struct lock_file *lock_file = xcalloc(1, sizeof(*lock_file));
 	int do_die = 0;
@@ -375,12 +375,12 @@ static void die_on_unclean_work_tree(const char *prefix)
 	update_index_if_able(&the_index, lock_file);
 	rollback_lock_file(lock_file);
 
-	if (has_unstaged_changes(prefix)) {
+	if (has_unstaged_changes()) {
 		error(_("Cannot pull with rebase: You have unstaged changes."));
 		do_die = 1;
 	}
 
-	if (has_uncommitted_changes(prefix)) {
+	if (has_uncommitted_changes()) {
 		if (do_die)
 			error(_("Additionally, your index contains uncommitted changes."));
 		else
@@ -875,7 +875,7 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 			die(_("Updating an unborn branch with changes added to the index."));
 
 		if (!autostash)
-			die_on_unclean_work_tree(prefix);
+			die_on_unclean_work_tree();
 
 		if (get_rebase_fork_point(rebase_fork_point, repo, *refspecs))
 			hashclr(rebase_fork_point);
-- 
2.10.0.windows.1.10.g803177d


