Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6453C20195
	for <e@80x24.org>; Fri, 22 Jul 2016 12:25:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754017AbcGVMZY (ORCPT <rfc822;e@80x24.org>);
	Fri, 22 Jul 2016 08:25:24 -0400
Received: from mout.gmx.net ([212.227.15.19]:49685 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753981AbcGVMZW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2016 08:25:22 -0400
Received: from virtualbox ([37.24.142.100]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0Lxgt9-1bFX4U0fcZ-017DJ5; Fri, 22 Jul 2016 14:25:13
 +0200
Date:	Fri, 22 Jul 2016 14:25:11 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: [PATCH v4 05/16] Prepare the builtins for a libified
 merge_recursive()
In-Reply-To: <cover.1469187652.git.johannes.schindelin@gmx.de>
Message-ID: <9f3ff7ff08496247b86791f2087ea447b0e110aa.1469187653.git.johannes.schindelin@gmx.de>
References: <cover.1467902082.git.johannes.schindelin@gmx.de> <cover.1469187652.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Jx8mxx5fhU8WETo+OwzHL9KQ9S/Nus1Uj3odxrW4fr3SHEhZ4bL
 ZOFYnwYYzjpIsKnv3a4LTIMZxnj2RGe2yJAm0cHjoBXpdWusWolEtcYn42jl+cX6vE/gCgx
 A+bq4WKRLYD8PHy4utDu2Bu3ip3CeD1/NyDlFqT5s6Owb7IHFXh8ytx4/Mo3khEYpDl6/JS
 kMuKBUYx5XfVb42ag+5jQ==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:WRG2a29C/9o=:CfA0J/t5eveLZVuPznUC8t
 PD2rC6Ub+ZOMEceYVzIUU71dJz+uNV9LOWLWHv1Cd/kzbdAqdgr3/SJP5WKMNGwEsmFztaGnx
 WGhvNtdjpIhNQUpZIc4ZNXKUsJLi2+a1CDTRYleV4lgagXQojzZIDTApn+Vac0VFcjaTZJD6w
 vnrRF+tbgpnd5WvAn529NuKyv963BrfJzgbtyrbv3O0KYv+WAwz71kz2VDWJ+TCeq6psd4yEh
 p2cxNHW2mo5hnF95fSbNvp7w/r4qA7+ZbashiISg09H15chK1hCi7F7Yi5t3IUcnlX+tI+wt+
 T3Sn1e1+T7vFmGEMSFRL0EOwnn44Qm47TFhPuGNc+Y63Ze8GLVEtaRWvl/nEsVGdfl2kvF/3G
 Wb1hfIgxDvbn5P5c6cdXhMnkLWGRrxpwRiezdNmujBT5VnMC3fC+ohxRw4L126VbJiwpWUN/F
 Y7G2BkjuQk02pKRE5wlzgUVYD3uEIir08nA9O0iFLuCxr8TccrRSNyVcXpFwOdbTS9GlzxyHF
 rwgYg8JiTemJ8w94woZ29ks46+5w3ax1XIL4f4LyKxaqOPuWy80wZC5DbYa/3AivkanKv4gTP
 NPrfqEQFPH2cx+9QhrXLXNQFJjhS5XYt7FB2gQly4gdMhmjaTl6xsD4v08BSWqG7F1iv86CGq
 CNYo84Kr8rw2KmXOfGqCb40xfuoC8TOk2JMSkJdnvD57UPSMg97ZHtxd2luwDh2EcvUh5l9Vs
 4VMVv+7bd76iMCo/MNkh8E5KG5ewgfVGj3szyy4lKl0aSqOuZTONsacd+APl0gXXV4+OZY7nV
 ECWxD9I
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
index 19b3bc2..148a9a5 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -673,6 +673,8 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
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
2.9.0.281.g286a8d9


