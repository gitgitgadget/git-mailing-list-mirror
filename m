Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 213D71F71B
	for <e@80x24.org>; Mon,  1 Aug 2016 11:45:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753397AbcHALpn (ORCPT <rfc822;e@80x24.org>);
	Mon, 1 Aug 2016 07:45:43 -0400
Received: from mout.gmx.net ([212.227.17.20]:55906 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753282AbcHALpJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2016 07:45:09 -0400
Received: from virtualbox ([37.24.142.100]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0M34eJ-1bArfd1xOJ-00swco; Mon, 01 Aug 2016 13:44:14
 +0200
Date:	Mon, 1 Aug 2016 13:44:13 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: [PATCH v6 06/16] merge_recursive: abort properly upon errors
In-Reply-To: <cover.1470051326.git.johannes.schindelin@gmx.de>
Message-ID: <8ff71aba37be979f05abf88f467ec932aa522bdd.1470051326.git.johannes.schindelin@gmx.de>
References: <cover.1469547160.git.johannes.schindelin@gmx.de> <cover.1470051326.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:o66zOxMg8ewUz+yqtJZiMFLvEUiFml7nR/J7BFOozA3kXlw17xP
 /7oTqJwV8SwMtyn/hOHa3Gm11fRHsz6qT1+48epPv7XDaEJvmAQubXMjXVmW+zpLBZP0J42
 oUH/KiOBZPxu75CWk/rtFvoMTGMpFbbLl7QZJxYrFr8FQ+9/8mR/7BMFWPOHp7lYC1v8rKy
 g5bIMgrQCM4uUOzcwzDuQ==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:HaoWLGXO7hg=:UX2ae7xkjtAyhwflKw9i58
 4geryApdJvD4YKo0p8e3ku65mXoBVEx2/hpT7lIkFDK3sUijVMEDAyYME0TpVJLZ8UitEVXD8
 PRgZE6oFgP/bAnMrEIyLPoPcAoDWIqKKYMEZuAOSZHtwo+2RGmpxG0/QHpprS6JnVOcEWB6z4
 vRaNLGrGkLISqSBv6dqhEAUm2IYsQMBkb1As9F0wr3v4juEhjan0TtCm5quPhL6Ejs9yXBvIY
 Ug54ZcwYSwXPLqbVWTOxInfZtYeU1/+lEAm1DuF6IBIi+v+rerCPj/EleKlSdJn5CXJ5SaoZx
 EpvsONBQ8wmTLLexOEJ+e1VfyOwb/Nw1MmQx7EaGKeQa2fwAafUAIZbM1wxYBYwPO0AiaJ8uD
 PwdFmuwRPC1Oc19IvV3BOmYIrp9TkKLPULavMXME4+fqLZU3wCxtgi9DwwNkRY58qJaRqxBm+
 GPJjl838QhzQC49bnjRodQ6QigfbWus4iis6AEXjZo+lBI2LrT/FaJ4vQ6JSqktZFm1WEqnR1
 brYeJ/R7jJF7VLI0+AEQ0V7Zyh/18BYetp7OLGEbGVh6v8f1v6ZBfje8qmqj+bwtDrq0Rnt2I
 8gRCgpdufEDd2tNwQEtPaHFZ0Mwu0GE2rva/Gm73tTmPag9YTIzu6MVQqTacer0/Wt4daa1Rj
 3Mrib4yaKG7CZ5vuZYjczPnMbB6tSE/6zRhSaS4Pu9MsBADHvwmxKDL/WHoKGRiN0xQXQhAGX
 2VpBy64xvhOy56FxvAAJB6GlUPIxXTN2PFpZcwwUKOVtsxH45N0WK+s+//3i95f14JaIVAplE
 kd6BhB8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

There are a couple of places where return values never indicated errors
before, as wie simply died instead of returning.

But now negative return values mean that there was an error and we have to
abort the operation. Let's do exactly that.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 merge-recursive.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 3a652b7..58ced25 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1949,17 +1949,19 @@ int merge_recursive(struct merge_options *o,
 		/*
 		 * When the merge fails, the result contains files
 		 * with conflict markers. The cleanness flag is
-		 * ignored, it was never actually used, as result of
-		 * merge_trees has always overwritten it: the committed
-		 * "conflicts" were already resolved.
+		 * ignored (unless indicating an error), it was never
+		 * actually used, as result of merge_trees has always
+		 * overwritten it: the committed "conflicts" were
+		 * already resolved.
 		 */
 		discard_cache();
 		saved_b1 = o->branch1;
 		saved_b2 = o->branch2;
 		o->branch1 = "Temporary merge branch 1";
 		o->branch2 = "Temporary merge branch 2";
-		merge_recursive(o, merged_common_ancestors, iter->item,
-				NULL, &merged_common_ancestors);
+		if (merge_recursive(o, merged_common_ancestors, iter->item,
+				    NULL, &merged_common_ancestors) < 0)
+			return -1;
 		o->branch1 = saved_b1;
 		o->branch2 = saved_b2;
 		o->call_depth--;
@@ -1975,6 +1977,8 @@ int merge_recursive(struct merge_options *o,
 	o->ancestor = "merged common ancestors";
 	clean = merge_trees(o, h1->tree, h2->tree, merged_common_ancestors->tree,
 			    &mrtree);
+	if (clean < 0)
+		return clean;
 
 	if (o->call_depth) {
 		*result = make_virtual_commit(mrtree, "merged tree");
@@ -2031,6 +2035,9 @@ int merge_recursive_generic(struct merge_options *o,
 	hold_locked_index(lock, 1);
 	clean = merge_recursive(o, head_commit, next_commit, ca,
 			result);
+	if (clean < 0)
+		return clean;
+
 	if (active_cache_changed &&
 	    write_locked_index(&the_index, lock, COMMIT_LOCK))
 		return error(_("Unable to write index."));
-- 
2.9.0.281.g286a8d9


