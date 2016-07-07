Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B7202070F
	for <e@80x24.org>; Thu,  7 Jul 2016 14:35:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752543AbcGGOfw (ORCPT <rfc822;e@80x24.org>);
	Thu, 7 Jul 2016 10:35:52 -0400
Received: from mout.gmx.net ([212.227.17.21]:54230 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752482AbcGGOft (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2016 10:35:49 -0400
Received: from virtualbox ([37.24.141.253]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0LbPza-1biuYh05u6-00kwHD; Thu, 07 Jul 2016 16:35:41
 +0200
Date:	Thu, 7 Jul 2016 16:35:40 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: [PATCH v3 06/16] merge_recursive: abort properly upon errors
In-Reply-To: <cover.1467902082.git.johannes.schindelin@gmx.de>
Message-ID: <2bb0b37527d05e4220c6c9d2d705c1dac20dd41a.1467902083.git.johannes.schindelin@gmx.de>
References: <cover.1467717729.git.johannes.schindelin@gmx.de> <cover.1467902082.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:vnduO8+ifTk/1PIi/2Shn6kEei+5mw4TYx5NSj6g3w5zhEzsH1M
 K7tT3tYu/RAETgxThF1Y1mMOlqWgD5cojoG3pDqGdWs15bloh3oS+U/acvKKB5Tuz9WIYZT
 /BeJLlrLHHmdKimstwyD3SjbxvxYsxbfPfMlH3ZQTlB1KyZ5e8S6uzEwyM+NOfcoJ9U5gaV
 +CObmh7nayhMjev+0f+8w==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:QIiUCfvhULY=:VJgDnFTw2LYLAMkThLVLuI
 2ZIuFV4gszllABpz20ZxGw2PBbS5rfY7p0ZI2KFzoJuu74AEPeOeBevdqPSXqxeQWHBBpR8cx
 i7bZD0RV3rJwJCBR9yuUDuIZgfce0bjMhdkbPFE5Wxm3+g3DL4eMhN4pfDEFp0OkhKoRHNWeZ
 mAb2wT6MQ95CJXZNkR1PtHpCgzRCRSopTBNIkcXtZ2kQ7oo+OBqne01PRaevQYvjJNm64a64S
 WBuDx2/Y2zUzTlNV7GlwGc8E3IHQmBCh7V2IXMeC6Vhs8CEpjQp0hj2XAyhsvf12RuLmUYPXg
 +YmJGw+3AY2X9jb9hTXLze4fB3ABtcWXd+wb0bV3o+8DDXHYxxq3zCzjHKn42W1HHr2kVE5Pg
 jf4/fmot0Ccq0GxFmpgusms3YUhTt0M0m9zR8f4p8JfPTHa6oH1hkEz1x7s2asrci/sArGCwE
 tQtLTGYpRXIczNe6ZWMz9onE91x8tBUapY3DA0LiyvrVmOwNBxZVWLBDpYjwJJjp5HhlSya8w
 EgzB457QoUAqq82SNh0uvVUh3VANc7lMZUG5rOMWdio3NJnlt247epbkGZNX84/Y4p5+5r99p
 fY/Qc+pd4r0upn4APmlytxeOq7dkrw1YiOBp7ihQCT3kIZnBOsECIMH0x+lMvjvtgDnOhDUeU
 J491xGL75+bbO3lEJPLmFBkTphGm1MMso2GSJQlGxU62PZQjFwmZFw0ShzzpjIGhtIEfxKf+4
 Twgn7RtyE/npiBeSjUPSztce/m9fKuzCmOBqJgg5gQeuLEoQe1lzzRlH/pH10YGr00PQKgTjJ
 3IaIJzW
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
index 469741d..37c181a 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1974,8 +1974,9 @@ int merge_recursive(struct merge_options *o,
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
@@ -1991,6 +1992,8 @@ int merge_recursive(struct merge_options *o,
 	o->ancestor = "merged common ancestors";
 	clean = merge_trees(o, h1->tree, h2->tree, merged_common_ancestors->tree,
 			    &mrtree);
+	if (clean < 0)
+		return clean;
 
 	if (o->call_depth) {
 		*result = make_virtual_commit(mrtree, "merged tree");
@@ -2047,6 +2050,9 @@ int merge_recursive_generic(struct merge_options *o,
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
2.9.0.278.g1caae67


