Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A67E20710
	for <e@80x24.org>; Thu,  7 Jul 2016 14:35:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752524AbcGGOfs (ORCPT <rfc822;e@80x24.org>);
	Thu, 7 Jul 2016 10:35:48 -0400
Received: from mout.gmx.net ([212.227.17.21]:60672 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752284AbcGGOfq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2016 10:35:46 -0400
Received: from virtualbox ([37.24.141.253]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0Lpgew-1boTXT3Kkw-00fOqM; Thu, 07 Jul 2016 16:35:37
 +0200
Date:	Thu, 7 Jul 2016 16:35:35 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: [PATCH v3 05/16] Prepare the builtins for a libified
 merge_recursive()
In-Reply-To: <cover.1467902082.git.johannes.schindelin@gmx.de>
Message-ID: <61992e3afb8b9073bc78410c95c6c21a5abfd02b.1467902083.git.johannes.schindelin@gmx.de>
References: <cover.1467717729.git.johannes.schindelin@gmx.de> <cover.1467902082.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:181mzckEdXrm1qd8oNDrF07NhIWXTQRg7Yd98iWo99zJh1biGqk
 k0N/WKtNLD962Zmd/0HFB0eBrFV0vx2tDWX6jCMby6TgOaAZKEJpvIdtXkhTLh/iIxhy9VO
 GhOX9lhYz6oKV35jh+AbCtwLUtqtHFs8O+Gt8bWkpqo0fkWZ40+4Cd6zJs5GCkINIqfSNi3
 zd8veQOlhldyVDH1K4JGA==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:/ensSc+JFos=:vyathSjP+i+bO93jdgJBww
 PZNqkQ1R75EGPZVywXmyE8Aqj0EmzQ5TtPlS/9SN0CYVS2SO8A7OtWXyscRXt5jPkt37IOrt5
 7Oyrn8hBQKe4IiV94pqV4a8Ol1g3HLXX9vix1bD6/mihVldYH7ZL5X3iKOZ46c8LfcvL43s8g
 pM0E8ucmGjSUrZRR6ZLzTLlGoaZRxCSmLWQ2NNmK5b1qxnxWCfi2+n7gQ8W9KnRr9xCiSsmM0
 WWg4J5Krv1yUrRezdDlXZBPjr5454/FpbluDIILk+uQvKn6kVKQQZjZA7wwqHMT0soshVQ2SF
 C2Ihk6l/kLyHmVaDyyVy0Gw2YL/DwlzuqdEWbJ4ObKKYUM/6CdeLkKUC1aaBwS0e/J/zoi7pJ
 mYCMKUL47zeieZqWd52zePg9zYVvs1RXxqxkef2LXvEHMw23eGoTTX90uxAxWX7oJSRKUlyoh
 BUj3BXeAy4DftCD9SwJzbgFZmCIVXqqCO0mLkDJLPBieoYbcbYKAjoa4HWUb++OMN2nQ2dz9f
 YaA+M6LDwGM8SeQwagGtEm/b+oIJrxXGfXx/KiG1xmx7ntmeO4+df1TGebgvrIwUPH/6eyCkO
 Axyr1GPwyhKVYs+gX9Jc0Iys8NWuzYmMk2Hdcn1nxoAzHx59X7MjgJ6fZ4kf0iGSw9eXi0rOC
 DmGlAyQWPOkfg102V/ZGz9PAw9aNfziA/fggGqvG5KbFDG+tg024nRxHG4rEaN9F7uE8mCAdJ
 mdVppRU5vHh30wne4IgUu9xIJzHeQm1Bl/iXr7uF28JUJdBhSKDVna3W/UhKn/+Ih3iqJuz9t
 JjtIr+E
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Previously, callers of merge_trees() or merge_recursive() expected that
code to die() with an error message. This used to be okay because we
called those commands from scripts, and had a chance to print out a
message in case the command failed fatally (read: with exit code 128).

As scripting incurs its own set of problems (portability, speed,
idiosynchracies of different shells, limited data structures leading to
inefficient code), we are converting more and more of these scripts into
builtins, using library functions directly.

We already tried to use merge_recursive() directly in the builtin
git-am, for example. Unfortunately, we had to roll it back temporarily
because some of the code in merge-recursive.c still deemed it okay to
call die(), when the builtin am code really wanted to print out a useful
advice after the merge failed fatally. In the next commits, we want to
fix that.

The code touched by this commit expected merge_trees() to die() with
some useful message when there is an error condition, but merge_trees()
is going to be improved by converting all die() calls to return error()
instead (i.e. return value -1 after printing out the message as before),
so that the caller can react more flexibly.

This is a step to prepare for the version of merge_trees() that no
longer dies,  even if we just imitate the previous behavior by calling
exit(128): this is what callers of e.g. `git merge` have come to expect.

Note that the callers of the sequencer (revert and cherry-pick) already
fail fast even for the return value -1; The only difference is that they
now get a chance to say "<command> failed".

A caller of merge_trees() might want handle error messages themselves
(or even suppress them). As this patch is already complex enough, we
leave that change for a later patch.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/checkout.c | 4 +++-
 builtin/merge.c    | 2 ++
 sequencer.c        | 4 ++++
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 27c1a05..07dea3b 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -567,8 +567,10 @@ static int merge_working_tree(const struct checkout_opts *opts,
 			o.ancestor = old->name;
 			o.branch1 = new->name;
 			o.branch2 = "local";
-			merge_trees(&o, new->commit->tree, work,
+			ret = merge_trees(&o, new->commit->tree, work,
 				old->commit->tree, &result);
+			if (ret < 0)
+				exit(128);
 			ret = reset_tree(new->commit->tree, opts, 0,
 					 writeout_error);
 			if (ret)
diff --git a/builtin/merge.c b/builtin/merge.c
index 46b88ad..6837e15 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -682,6 +682,8 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 		hold_locked_index(&lock, 1);
 		clean = merge_recursive(&o, head,
 				remoteheads->item, reversed, &result);
+		if (clean < 0)
+			exit(128);
 		if (active_cache_changed &&
 		    write_locked_index(&the_index, &lock, COMMIT_LOCK))
 			die (_("unable to write %s"), get_index_file());
diff --git a/sequencer.c b/sequencer.c
index cdfac82..286a435 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -293,6 +293,8 @@ static int do_recursive_merge(struct commit *base, struct commit *next,
 	clean = merge_trees(&o,
 			    head_tree,
 			    next_tree, base_tree, &result);
+	if (clean < 0)
+		return clean;
 
 	if (active_cache_changed &&
 	    write_locked_index(&the_index, &index_lock, COMMIT_LOCK))
@@ -559,6 +561,8 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 	if (!opts->strategy || !strcmp(opts->strategy, "recursive") || opts->action == REPLAY_REVERT) {
 		res = do_recursive_merge(base, next, base_label, next_label,
 					 head, &msgbuf, opts);
+		if (res < 0)
+			return res;
 		write_message(&msgbuf, git_path_merge_msg());
 	} else {
 		struct commit_list *common = NULL;
-- 
2.9.0.278.g1caae67


