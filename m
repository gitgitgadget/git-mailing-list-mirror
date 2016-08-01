Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 519FD1F71B
	for <e@80x24.org>; Mon,  1 Aug 2016 11:45:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753357AbcHALpM (ORCPT <rfc822;e@80x24.org>);
	Mon, 1 Aug 2016 07:45:12 -0400
Received: from mout.gmx.net ([212.227.17.22]:56506 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753279AbcHALpI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2016 07:45:08 -0400
Received: from virtualbox ([37.24.142.100]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MJmcS-1bT5B63wLU-00189P; Mon, 01 Aug 2016 13:44:09
 +0200
Date:	Mon, 1 Aug 2016 13:44:08 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: [PATCH v6 05/16] Prepare the builtins for a libified
 merge_recursive()
In-Reply-To: <cover.1470051326.git.johannes.schindelin@gmx.de>
Message-ID: <d3c5678faf46391ce684aa79927a54cf15beea3f.1470051326.git.johannes.schindelin@gmx.de>
References: <cover.1469547160.git.johannes.schindelin@gmx.de> <cover.1470051326.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:hxlvCAYt8ygceH9YtGiKQA1IaXfT24GAaaWV+U5p4oKvWrOzFQu
 NuZ0hmCYo6PcIDXhkgIIUi2Jyu7Qwq2YGyEhxVskCyPPZ0EMIkpMWYriHPX5wubZcGARRdG
 5n8/QD9M1cjMWQAYWZKKImT1GNMc0P2gs7J1acfg4rYya+kBBAinRZqDL3u1TEu9aRhKct/
 tu4BgCvdn6j/4xKFasu2w==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:bZfgvjhORQo=:QZUCdwGbra4G3cmYXddnrh
 35YpmudoCKzAcJFW1wf7TMzprwV5CuqV77cDy9EzwtBIO9iBTEDknjNAP6S5Q+3Dn65XL3g2n
 Ph7dii7cWe3mfxxVMPm9RT3qBT8lDUTTjXd4iXDGP/g2Qn6ewDEG28I2Kk+KmgJ76ohyQNGQc
 9a7GiOx4xI5USxo2ltxuuHthN8HZe04daYzUk63ceta/tPIe2hHow7CggysMfyG+1oycTMWaV
 Xvxf0OaETEk1KJUwchXJmsygpR8Z3kV1o8kYACSLU4CbFFDNeE+kGsKk0E7Z8lTZRk7SbaLQ/
 5YpnYKwDUqxQdMZlBK0UuKAJKSQoE7YXwyfw6bfvAuPbunnU9Ik0pUXIICKM/b67m7tBX+xpY
 dDkXqxtY5eXqsau65Sy1nBODtAQsCz4cOm/qdTVjTNMGweTTQiLnvOuW4hvS0dNQ5L/VddqBI
 8Iz1S44xbN5OnuOF8m20hTErZK2Gm+b4eJ3buLSMKCHu6aWllOnVjRXh7098JVvGMMClpWHRa
 11P63N4iER3PJCaJIFk4Tjfhzt52Fej4EDw06H1LzCDE7SRTPrQEOKWzCBAKZ3iVV+VbRyDck
 LHArCnVd2cnWPF26CfKkA8gwfrYW1P6E1XMNT4eesvKZbjBiAGHbYDmuYFC4xPRdB9+QK8wJE
 hR4pPJ53KWleyNwvgbp12/Qv3SR9AE3Ut9QIPid+aAySDRqJKyrxiegBqtM7/2xM9R2x39s4b
 ksdwmHRiofbXqZa9asyPSTxfAI5ZfA5qiNgvV2XVS6B9hbfdjBayCgguJgWz7aEYGFezs2bHW
 Hhqe0sk
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


