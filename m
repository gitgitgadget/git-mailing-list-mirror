Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA1BF207E4
	for <e@80x24.org>; Fri, 28 Apr 2017 14:03:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938497AbdD1ODY (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Apr 2017 10:03:24 -0400
Received: from mout.gmx.net ([212.227.15.18]:52164 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S938012AbdD1ODU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2017 10:03:20 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M6ilI-1e0UQf3ct2-00wY4J; Fri, 28
 Apr 2017 16:03:05 +0200
Date:   Fri, 28 Apr 2017 16:03:05 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>
Subject: [PATCH v2 11/25] checkout: fix memory leak
In-Reply-To: <cover.1493387231.git.johannes.schindelin@gmx.de>
Message-ID: <7743bfd9e0cde54db7161007ea2208016d18bad3.1493387231.git.johannes.schindelin@gmx.de>
References: <cover.1493237937.git.johannes.schindelin@gmx.de> <cover.1493387231.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:hCOe+DNk/R3AYEaIr9kPCBFnIyjIPp8xUWsG7FojFc4MMGXfe2h
 ZVFIKWpWpjDnI6/T8T6dglVgtZPaU2hpO6aAgoogO0YjoKxY4VmMVQ5juZ0QcTLXcu/bBIT
 ZBiGWGZL1jOZOoiKSIJUjgzyHZqETT6am+jTNUU5zUp7TwrN+LdN2Oobnd5CEt1GXj6m/Gc
 YOEtlrds/yHDn5p+I9kzA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:8/myxvfu7tM=:dm9/PLOk3UrbXiICuvm1Yc
 cEMFtHURNArPWBvjjMmr471pmv29NJc33KArUc18on7DZEvtd7+h51DtCbYkXcGr4WVVsL9WT
 F5HLdFCC+MM0t/mrgRnBkMPCiG+UAA/1x9SAhGVxAY7R36Oxb4ruM8OrqzoHhEv6Yvg2EGKeE
 nxpNcULxytNwPUrssgTcqvxWtx+RRtWNHsQrFB5WnxE7wrjjbaphWs/ae8aiabNd10qAHbk6O
 TV1ATe6kbEKVqelrCEKjqgiC0aJrb+m4aPSyLWLa4CZdg6oOBVZ0ah18O7eDr5p3JLlfFzn7f
 NmbP8W2sFW3y3J3/hAsxK9WkflVNMKzkBUSqHEfHjR8MuCL83Vy/++BjE1NQu61xo25xpuVfP
 va+7lkAxvKAxC6MtOSIEbjEuC8UU4cHKaZRwoXli95cLyQaTgmtvWFxZ9gXOmXqwRw00YEBv3
 Y+Z79HJ6VGmpPGczjAZxuU2WRS1td/DLh1lO0HJFRGqg/bdjkb3/k6/WyjsrIoj6eLpPwWrrr
 FZ/EfmfjWZujO0w6scoLFr+qzUJ6rWYqggAvnG3WDd0cS/xqSvVPsYq+F5zxd34vo6OFwlgrP
 prp9RCADdZf+r2Q8xtt9WRTnsWQGdhhHHZpdMgNkUGOrZJmwo37rQjsdD1CJPaWgTT2yCeFbm
 ThrriVMRL9B1uI64Jh/8vfXXh+j3A5EosoiRtuRLB1h7uofKt2jx01PawKBE3hyIdi8huTsuR
 9xFjmKgGyqFgdVMnMLgzYuWuE2/zteRy3QENW/Hof7nD63cHXQqbAyv8TR2wjmdFxDY5hfJs8
 mvKnUns
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This change addresses part of the NEEDSWORK comment above the code,
therefore the comment needs to be adjusted, too.

Discovered via Coverity.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/checkout.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index bfa5419f335..5faea3a05fa 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -235,14 +235,14 @@ static int checkout_merged(int pos, const struct checkout *state)
 	/*
 	 * NEEDSWORK:
 	 * There is absolutely no reason to write this as a blob object
-	 * and create a phony cache entry just to leak.  This hack is
-	 * primarily to get to the write_entry() machinery that massages
-	 * the contents to work-tree format and writes out which only
-	 * allows it for a cache entry.  The code in write_entry() needs
-	 * to be refactored to allow us to feed a <buffer, size, mode>
-	 * instead of a cache entry.  Such a refactoring would help
-	 * merge_recursive as well (it also writes the merge result to the
-	 * object database even when it may contain conflicts).
+	 * and create a phony cache entry.  This hack is primarily to get
+	 * to the write_entry() machinery that massages the contents to
+	 * work-tree format and writes out which only allows it for a
+	 * cache entry.  The code in write_entry() needs to be refactored
+	 * to allow us to feed a <buffer, size, mode> instead of a cache
+	 * entry.  Such a refactoring would help merge_recursive as well
+	 * (it also writes the merge result to the object database even
+	 * when it may contain conflicts).
 	 */
 	if (write_sha1_file(result_buf.ptr, result_buf.size,
 			    blob_type, oid.hash))
@@ -251,6 +251,7 @@ static int checkout_merged(int pos, const struct checkout *state)
 	if (!ce)
 		die(_("make_cache_entry failed for path '%s'"), path);
 	status = checkout_entry(ce, state, NULL);
+	free(ce);
 	return status;
 }
 
-- 
2.12.2.windows.2.800.gede8f145e06


