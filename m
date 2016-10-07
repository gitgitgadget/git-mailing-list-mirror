Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 29B1A20986
	for <e@80x24.org>; Fri,  7 Oct 2016 16:08:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938922AbcJGQIj (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Oct 2016 12:08:39 -0400
Received: from mout.gmx.net ([212.227.15.15]:61694 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753234AbcJGQIh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2016 12:08:37 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0LbdE3-1bBoPc2yeR-00lFqI; Fri, 07 Oct 2016 18:08:31
 +0200
Date:   Fri, 7 Oct 2016 18:08:30 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 1/6] pull: drop confusing prefix parameter of
 die_on_unclean_work_tree()
In-Reply-To: <cover.1475856491.git.johannes.schindelin@gmx.de>
Message-ID: <72a2d6318a16230e6bd6a1d13c52ddc42be1cbe7.1475856491.git.johannes.schindelin@gmx.de>
References: <cover.1475586229.git.johannes.schindelin@gmx.de> <cover.1475856491.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:kV6HIVs2peLDO9e3IxO1cT0NeNMNEq/StxkFmSBoBT1nzqdkZpp
 6Vxy/LfOWDeBQXproFlzFMZvEQ21wqrslmSZYMFVjxYgjjwFMaPDUg4gw4Koweb8zKGSMrn
 8b8qP372zq/T7n0wjiOgW0l0sLgTFfxOJOYU57nOrvQkACTQSYFyiqFJAu5ZvY68r2BsFuJ
 YG8v+RlMrHtSfaMUiSfGQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:lnpxMDPPCnI=:6lSfQSvKzDJel9DXcflgD4
 CtnCPGiUnZdFXcl+F1Z2BfiyWerH+EJy69Vl9xZ9WqWoFWa7+C32d1bA2EDmhrV9G4iliXbAg
 ESJfjtIaqmt2IPCcyQTYXQxseCHqK8pd6l5L5wtCR2BRJP0LaSVdC9bIectpdjsQXU7BbFuAI
 0vCobg9YbLzODQVcsp9nsRzT+auPxIbI8F1Zrssu2+IvC6nACc3EHfuvQ7xj0D5KCX7MWNVgD
 zhqHi0Kgs7f5SZpH8cVoGXF9cPNkBF4YQXJzOpYmpPKr7veduwjENC1IcnHZ2a4ZWmP1hl79n
 3QWPbbwnM24TralWyUjRAt6tka6/lFd412gGdn8J+arvLtEwtaBcZyMsN+8yGnGLkJ9d1EZh7
 //3+uld/zY4HObzoaYbO0SWfOfm/Y/hxRe3tgzClfIutBIPiCENqIkVrF9g9d/AYXWolagFaB
 cbN0/dEkMYwTvl0KrwrugF90991sk80H/qXhtoiGUVsj3Pzxs7bJEzT/p29LeY54feuQzo5eN
 m0PN7TkON8mp2RVDfO4RFCg3PRIu9gRll/E81zTMcaLHVCA+FuSVmxykUUbedAvsa6Pehhhct
 wYDphKH7x48c9ReYoLfrkXeuM1PZRhyeEw6dWL2OrGzfeordpzjQqEQbhIxGxj5FTaFF1tq9H
 L9XXU0PYiTuqGKTJJAvLgCk4EktzFHeozJjVIn8GvKsV1J6QTHQOXmeRf18TAV6Uf8SFdkfut
 e7CEhUPiHQ+TjpssB5DIqFDZbCAiHHu645bwviw7JMg629oiY5CgGV51kwwXnnvB6cgXdPV4h
 cJLEnw8
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
2.10.0.windows.1.325.ge6089c1


