Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C6711FE4E
	for <e@80x24.org>; Wed, 29 Jun 2016 11:37:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752233AbcF2LhA (ORCPT <rfc822;e@80x24.org>);
	Wed, 29 Jun 2016 07:37:00 -0400
Received: from mout.gmx.net ([212.227.17.20]:51946 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751169AbcF2Lg7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2016 07:36:59 -0400
Received: from virtualbox ([37.24.143.100]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MDFB2-1b8He423oa-00GXqW; Wed, 29 Jun 2016 13:36:52
 +0200
Date:	Wed, 29 Jun 2016 13:36:51 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/9] merge_recursive: abort properly upon errors
In-Reply-To: <cover.1467199553.git.johannes.schindelin@gmx.de>
Message-ID: <81a74b02ac714a4fa3734dfb774cff6dea3a3471.1467199553.git.johannes.schindelin@gmx.de>
References: <cover.1467199553.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:GI/pgz0WgNRSWMYwBDQ5a567lg+DSlVWQvZtdTLvhxB+lokleV1
 KD0Aym6kE9/4rwUOUXJWNyQKQIu9FLtNyRKZIGm7PBZEoMWpG1mzSdeIH7GhWfwNuWVs8Nj
 4+am+D17b73JSzSjYh4rkji2G72kGQBNgqrMdIAZ4oT7LLsa3a5xduogFDFxfKpNxCxrYlK
 8qIGmdRLJLMBvXC28OU/A==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:P+zyoEkROh8=:2sEZj3HK7+9qvVPUq/W3gL
 5XUiLPcLGCQE9vd9GPhzgWz2Ulcy3YFB3Clv2I3qlPJueocxWOYscoc2dWh8hDVWPh/yQcJ+T
 OmozOTOnaEZn7PIixot/05tsJpKqFmD9VmKqPIeXPglL2qyvSyrxPkyMP7WWTmO0zUIx7Np5O
 9yg0VNF+RbRlV6S8zZBgBr/lF5asWe5xNAQxuEGNcTIEuLdl99Ko1tzdJQkhbcjogSZfZs1Lh
 4liFEo6KnwG68BlmwQMRJLsmOYi2mvlGvq0aTPxVX0Hh3KlnoK1UoBStmXwaUhQSQkCkyt2LL
 zjoiNKB6TuO8D5T5wJvXbncyuoGHec87LTELUgy6y6AP02hCoMyj2XKEtSitzeJVBg9wXyGhg
 d/TKUalIDkbKkHv7P0WygGdBDuO8Ka24s+QKddOkJ9xPftDbqc8RY+PzlH4USAMO0L+uErhS+
 7uVRx+nl/CXM8kugolXQDrE4IPb59/ZRUcz45M9sKHDalp35+UaeBQTahfp2Wg5fz4xwp5Wy5
 yRmYBkalXjSRCBZu7LS7vtVvS3xHriot4gkvdqawPn+Hak4CLaia475R18TMHtHAYyVey/Zqn
 AzvXvqvMwyTrDqgwyNT+G1eA5Ft2J/wiDJx9GULY9uFyDwMIlepovwBmVZorQP6Z6yCSe00o8
 3ge7QNC4PI6YJt2S0+N2Y897yHJRVQNSN1nAyl2/EmX98HjXMXgNjQ9l2QTKgUyxEtApEwr/8
 +7yd43DxIFwmrBxcnykfl760D2x4xV2/ZJI5fGmWzYblsvHN3Yjdn9aw8srF3sQKta/clgEfV
 +y21/Ta
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

There are a couple of places where return values indicating errors
are ignored. Let's teach them manners.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 merge-recursive.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index bcb53f0..c4ece96 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1944,8 +1944,9 @@ int merge_recursive(struct merge_options *o,
 		saved_b2 = o->branch2;
 		o->branch1 = "Temporary merge branch 1";
 		o->branch2 = "Temporary merge branch 2";
-		merge_recursive(o, merged_common_ancestors, iter->item,
-				NULL, &merged_common_ancestors);
+		if (merge_recursive(o, merged_common_ancestors, iter->item,
+				NULL, &merged_common_ancestors) < 0)
+			return -1;
 		o->branch1 = saved_b1;
 		o->branch2 = saved_b2;
 		o->call_depth--;
@@ -1961,6 +1962,8 @@ int merge_recursive(struct merge_options *o,
 	o->ancestor = "merged common ancestors";
 	clean = merge_trees(o, h1->tree, h2->tree, merged_common_ancestors->tree,
 			    &mrtree);
+	if (clean < 0)
+		return clean;
 
 	if (o->call_depth) {
 		*result = make_virtual_commit(mrtree, "merged tree");
@@ -2017,6 +2020,9 @@ int merge_recursive_generic(struct merge_options *o,
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
2.9.0.268.gcabc8b0


