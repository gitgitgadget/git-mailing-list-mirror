Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 530392018E
	for <e@80x24.org>; Thu, 25 Aug 2016 15:08:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934285AbcHYPIl (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Aug 2016 11:08:41 -0400
Received: from mout.gmx.net ([212.227.17.22]:51129 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933653AbcHYPIa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2016 11:08:30 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0LmfKJ-1b33OR1Vnn-00aHUC; Thu, 25 Aug 2016 17:06:52
 +0200
Date:   Thu, 25 Aug 2016 17:06:48 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/6] pull: make code more similar to the shell script again
In-Reply-To: <cover.1472137582.git.johannes.schindelin@gmx.de>
Message-ID: <9a7cc36eee651fe8be280920587e1f83538caf77.1472137582.git.johannes.schindelin@gmx.de>
References: <cover.1472137582.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:F6gIpTgXS1d3HJIZFH4SjAbckUEe+O2rwEy4YnNTka6J5YyhIy2
 OBTDhG5a3Pvx+q4x8DdxZbD2kUepsTCFOIuFu/LRV79LVjD5QWISrw9KvL2IZylWex2AfIv
 x+PqVhKwpzuP2vykNjt0j/ejlbHxykfODen3nKdAYao2zqCaddo7Ba6vEiTKVVzhR8RTb6M
 EfYElaqeO2lTDE6n7xWqQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:G9kv3qn8btc=:p2cNqk34WTmOcxMIZFS8M5
 cAbyNOgbFuqRwqjwiY3dbQj/C2QJk4Cfww8eidXhyS8a4IjE/RcOLswLQEz5BIdu4kJkR43M8
 qUgRzbwK4MY2BKeZ9MvfPjRhaxCD+VVWGRSz8d+V3RHQGV/u78+MotKi115rcLQKSry1UJWi6
 i0d9ctwMl5nxb4fwZ6LWLKXaW/nPaFuD+heH6T//fyfA0DNCYMtgeLE8/2Q0le9Q+gEYKSSR0
 n15d94MVVDIfyYnUUq0xPQX3VavswHbyML7FX1y66ZofaiUoUyW8T/XEyYkKqmNkjgT1mHJ4C
 rKI3c+C0NrNZm1nAQZ/RzH5hdlu1OPL0U/CqGIpzfX9tn6ykaNAYRBbStp7yuRyBChROV9B8Q
 Y5rppUyYBfaSIjy1DLyYiswpL2vaZl1NFkZFQDPujlBSQwCid7lDN87q91OpnxrqrRa3lohPS
 wVQVfQ9T4yDg4mlu1YRchdHaxpfLEjItAtGWG01VcYwPVA+0kJacUtglJOT4y6u8uLnIKS/re
 eJeB+83gWysL3WrxYMWepLwGjkg0gsC02TgGCAEdlqyDzHHdgZVuzbQJts5AvZ1nQZJoUhNRJ
 aeFEH7u68leFaw0+Ifc8wGYxPzr0s6Sec7IsCXbn63WCdMez6GtDl9tIYC/2/TLSYsTTnlPJM
 mJHO2AtAAMorlk63terN91GEKC2Y38+26hDQtnHq3LgVheen9gze6gjcEpK6rXwZd1t9iR4e2
 vP2Qqn888PPlC1zbUw6w3g/S6/JYKCC3XN6eOg4zelfyqRHBMRzIPjQiLh9XNY93R5LThvpwP
 cwfVylB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When converting the pull command to a builtin, the
require_clean_work_tree() function was renamed and the pull-specific
parts hard-coded.

This makes it impossible to reuse the code, so let's modify the code to
make it more similar to the original shell script again.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/pull.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index d4bd635..4d1f9c8 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -365,10 +365,11 @@ static int has_uncommitted_changes(void)
  * If the work tree has unstaged or uncommitted changes, dies with the
  * appropriate message.
  */
-static void die_on_unclean_work_tree(void)
+static int require_clean_work_tree(const char *action, const char *hint,
+		int gently)
 {
 	struct lock_file *lock_file = xcalloc(1, sizeof(*lock_file));
-	int do_die = 0;
+	int err = 0;
 
 	hold_locked_index(lock_file, 0);
 	refresh_cache(REFRESH_QUIET);
@@ -376,20 +377,26 @@ static void die_on_unclean_work_tree(void)
 	rollback_lock_file(lock_file);
 
 	if (has_unstaged_changes()) {
-		error(_("Cannot pull with rebase: You have unstaged changes."));
-		do_die = 1;
+		error(_("Cannot %s: You have unstaged changes."), action);
+		err = 1;
 	}
 
 	if (has_uncommitted_changes()) {
-		if (do_die)
+		if (err)
 			error(_("Additionally, your index contains uncommitted changes."));
 		else
-			error(_("Cannot pull with rebase: Your index contains uncommitted changes."));
-		do_die = 1;
+			error(_("Cannot %s: Your index contains uncommitted changes."), action);
+		err = 1;
 	}
 
-	if (do_die)
-		exit(1);
+	if (err) {
+		if (hint)
+			error("%s", hint);
+		if (!gently)
+			exit(err);
+	}
+
+	return err;
 }
 
 /**
@@ -875,7 +882,8 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 			die(_("Updating an unborn branch with changes added to the index."));
 
 		if (!autostash)
-			die_on_unclean_work_tree();
+			require_clean_work_tree("pull with rebase",
+				"Please commit or stash them.", 0);
 
 		if (get_rebase_fork_point(rebase_fork_point, repo, *refspecs))
 			hashclr(rebase_fork_point);
-- 
2.10.0.rc1.99.gcd66998


