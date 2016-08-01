Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A9C81F71B
	for <e@80x24.org>; Mon,  1 Aug 2016 11:45:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753386AbcHALpg (ORCPT <rfc822;e@80x24.org>);
	Mon, 1 Aug 2016 07:45:36 -0400
Received: from mout.gmx.net ([212.227.17.22]:56250 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753351AbcHALpJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2016 07:45:09 -0400
Received: from virtualbox ([37.24.142.100]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MLS74-1bTdQ40MVe-000fjT; Mon, 01 Aug 2016 13:44:54
 +0200
Date:	Mon, 1 Aug 2016 13:44:53 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: [PATCH v6 15/16] Ensure that the output buffer is released after
 calling merge_trees()
In-Reply-To: <cover.1470051326.git.johannes.schindelin@gmx.de>
Message-ID: <0fa117f8ae42e2f7c9b1cc803261b236d5cd6b17.1470051326.git.johannes.schindelin@gmx.de>
References: <cover.1469547160.git.johannes.schindelin@gmx.de> <cover.1470051326.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:qNlJmqjpWPvK5JoJkln+BT8U3CGDtg1N2eTtfDTP3JSJZeq/HMB
 8kYRkBUyb9JntNwzCGCQ7zidLix3uiMo0E+K5CodBXZJ1TJ85/Cl6IP/7fl6Y0auLyD04GN
 N8U3Wu8piaO5bSsqAHDqPkd/rcrwjMX2YhYMdqR0X7kOlouLkOsyMksPQl/26/AwVUvynu9
 VhIQ/jCwQwqlTGW+C0P7g==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:Yn7HirIcQN0=:OolRgM++WXzomhXq+FH8sT
 jF5G+iIE/BdRmirYojyJa+vtX4zqSSlfDjZKOdvn17rFWgv8H0WSJSFUUIEqtCUa3kU1H5cXZ
 5YkZubb6NPJ6VNq9dY4pniQpk3pXS+7SAB6266Je8aerEGKTM6v/HX6HdSqGiunTgXmcLkovc
 SBN4OXPzSFl3e7An8WX69jq2AlUYctA7n6+cATuHpQgRMwzG5jtk3N+4IpULAtoliODpL6y7Y
 DnQ39d/Axo1X/A+kAY8t/bDKBA+FEdK2jE0SNxmqhrYNRvU+gybBo/yIaZSCzx9VknIg+7JCR
 BDjAdCgXLCfXVpWtBJ8y8K/HVWkLYYg2edoef7w5j+mgcY1vrJxAPkkopUQJo+YOYKRT76zjl
 2TfVTMAuCCh35DQz0I/L4CtcYfTgfHQkJ1eTc8BOleNpNfc/PNdnoNYc34Mi0DSlIh6H4l41G
 VRtYkAPBTZPtIkv/gEUNgnzZ3RRGyuq7Lo+v4/aPukeRmnAZrNaPdoXT39bKDIOEOUsiI7MTJ
 ocZP6Z6a9ydabGfVl3kKzT2qonUbxs/+XpNyepinT0vOV7YpRPvBOplMe9P9eFRG6MLkLFi67
 zyaKbhuDLBP1YXUlaR5Q8ULbSXaVxow17YlDJonBaa/2W0DqZ4fwL3z2dy3JDiActaFE7IFhm
 IpdVMqej5YOqI5VnxCs8eQtDuSNPzOPu/cVJORzSyjSy6gYDceL3wIlrUZRfgXs2TsjAOtVC8
 66bv9dOgRKoydUcN0jehcf3QyAHTDImDqIxQ25Y1e0zrEFrk85NslcXIZusB3PuJ5m6JlyNHW
 Cg2MM+x
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

The recursive merge machinery accumulates its output in an output
buffer, to be flushed at the end of merge_recursive(). At this point,
we forgot to release the output buffer.

When calling merge_trees() (i.e. the non-recursive part of the recursive
merge) directly, the output buffer is never flushed because the caller
may be merge_recursive() which wants to flush the output itself.

For the same reason, merge_trees() cannot release the output buffer: it
may still be needed.

Forgetting to release the output buffer did not matter much when running
git-checkout, or git-merge-recursive, because we exited after the
operation anyway. Ever since cherry-pick learned to pick a commit range,
however, this memory leak had the potential of becoming a problem.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/checkout.c | 1 +
 merge-recursive.c  | 2 ++
 sequencer.c        | 1 +
 3 files changed, 4 insertions(+)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 07dea3b..8d852d4 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -573,6 +573,7 @@ static int merge_working_tree(const struct checkout_opts *opts,
 				exit(128);
 			ret = reset_tree(new->commit->tree, opts, 0,
 					 writeout_error);
+			strbuf_release(&o.obuf);
 			if (ret)
 				return ret;
 		}
diff --git a/merge-recursive.c b/merge-recursive.c
index ec50932..9e527de 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -2078,6 +2078,8 @@ int merge_recursive(struct merge_options *o,
 		commit_list_insert(h2, &(*result)->parents->next);
 	}
 	flush_output(o);
+	if (!o->call_depth && o->buffer_output < 2)
+		strbuf_release(&o->obuf);
 	if (show(o, 2))
 		diff_warn_rename_limit("merge.renamelimit",
 				       o->needed_rename_limit, 0);
diff --git a/sequencer.c b/sequencer.c
index 286a435..ec50519 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -293,6 +293,7 @@ static int do_recursive_merge(struct commit *base, struct commit *next,
 	clean = merge_trees(&o,
 			    head_tree,
 			    next_tree, base_tree, &result);
+	strbuf_release(&o.obuf);
 	if (clean < 0)
 		return clean;
 
-- 
2.9.0.281.g286a8d9


