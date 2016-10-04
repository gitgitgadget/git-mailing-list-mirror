Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D310A20986
	for <e@80x24.org>; Tue,  4 Oct 2016 13:05:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752780AbcJDNFT (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 09:05:19 -0400
Received: from mout.gmx.net ([212.227.17.22]:57833 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752074AbcJDNFS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 09:05:18 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0Lwarz-1apndv0twN-018JTw; Tue, 04 Oct 2016 15:05:12
 +0200
Date:   Tue, 4 Oct 2016 15:05:06 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 1/6] pull: drop confusing prefix parameter of
 die_on_unclean_work_tree()
In-Reply-To: <cover.1475586229.git.johannes.schindelin@gmx.de>
Message-ID: <e444e6aea30201738fbd0524425969d446709dca.1475586229.git.johannes.schindelin@gmx.de>
References: <cover.1473580914.git.johannes.schindelin@gmx.de> <cover.1475586229.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:KEUqE4Q8Vq6yecD8SjSlgaexZw6h6nRY12a5vT2viSaSOEfxnyY
 qxaW5TV62x0hIyurcU+/jz4sy7fho1QIYAiBql4UcTqxf6etECGtHHFd/N0mSqSThynvHpp
 tfteC6SmtoTQkW86KoOwCZdwTagUhXczBgathfr/pgru924HDpVr0cl9tvqgJx+qXIVYKnp
 /SaOTjnGaHfpXr+0GVhkw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:mM4eDoEGScQ=:Hi5aPScEWAcoy4qirknGNl
 Q8wOQx5zg8oyuSZDs+8IoAfYYPqRRgmdHFI0AWOXxtyJXZOOXZq3lHTKY4ylIplF7m0dwSo+r
 DJBsnag5xgZX1+Opr/MGIsjwkWf0XgUNBgpVbdYMjuMzqruzmEeuJrnaXBpIiJv9e3ouwlzE1
 kJUtElNUOV6b62X/9xfpiebglFWUjmN3Yz4KQ6lPh89GpwpnCJyxNPPxP5GEBELlvvegomrzO
 zaPDGu5EJC40mo2B166rzrm4CzRaojBGEcIeH5wFBC0R6WNvFAFMgkqsyn6E1iNBERCVDpI2r
 PZsn87sqhBT+XkJkzZ6uMaTpU1K9P41HNviIuaLLwqPBxx2cETf+qtppxL20ORqJGoa06muE4
 rq7aZQ4BsB7g6V4XbVFNjgFhmmMOoEyXJCrPxgg6nrMnbbsVmzcjLg3HV3aiAfNhUeaIWf3yl
 +yJCpdC9D4ugXGwJ8PR+BbcF+2/xqFMstSi7/cYsMi3dcE8RtdXQyPD8OwEFL1bHyl0sRBEGo
 OXxh4/YWJWpRYQ3LvK2pXR9rgUbEMa+YXgDxs1m/mMx/QfbiUXNNhTEHwFxT9Z8M3JaBsvfbk
 /NgVwbN8Uh/2tiOL8zTiDoi/HkwKXb9vO5HFEwyhtlS7JukmWE7H11FTz+040blM6Y667oRcZ
 zDh5aTRFt7Vmt1EuT1UEqSi4vbiGfuIoDVSbQF37ublbWU68hTHwqRKVJIPld+77xdSj0AKBa
 L3R+MQRxnKP3dT6MLoxX5TrDXAoFaXqcUAfksBXOjhd3Yz66lUAXrqSOWY4Om6i94+wJ6NsKy
 J8U9l1n
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


