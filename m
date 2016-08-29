Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF0C31F6C1
	for <e@80x24.org>; Mon, 29 Aug 2016 08:06:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756755AbcH2IGk (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 04:06:40 -0400
Received: from mout.gmx.net ([212.227.15.15]:61676 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756656AbcH2IGi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2016 04:06:38 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MRo6b-1bXIOY2HXt-00Sv0t; Mon, 29 Aug 2016 10:06:35
 +0200
Date:   Mon, 29 Aug 2016 10:06:35 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 20/22] sequencer: remember do_recursive_merge()'s return
 value
In-Reply-To: <cover.1472457609.git.johannes.schindelin@gmx.de>
Message-ID: <1f79d41e3417a0b1f0cffccc40e97f1a2c5ef987.1472457609.git.johannes.schindelin@gmx.de>
References: <cover.1472457609.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:/RCGT8s0gzArQeA7ZMNNDlRShxeqfDtkgLp57RuHEOC782wfuYO
 eq+me8VL7uSkwqdTc5/9Nuaxn1eTnc4mWWUkDQtNPeXtnfhaMCmwQ851VJY5FqYHlQgPKxu
 xGeuv8evPs4GTi3vlB0uwpmV4KCAaGQYzxpW3BmuqRP45omDUXOA2vLJV6eIm13RBqrDkh9
 /DOwQ1l/HUSTwyai1J9gw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6UHtXhzkWuY=:ZirqRR971CJx7q5G250cGm
 qCCjJ5+u0nr2jnXmy1KmhcHnEXxQgNKS8GfUjI5bASZpWjzDvikmyakteMpPpZ0IZ50MmR29f
 2n6t08KCnG1DXDEK38UetHIBl22G6H5R9YKJTskoljcLRvb9M5gr8ikZHsuEs/PKrobrnSrx8
 HyWBharcy4gFEvcNuEVIpjbk92otmLqen+9Nwd1TxYbrHrRqAFUZIzGk6eYrRee7GjmJGZD7B
 B5puvmHq8Gxg6OJTejmv50tfMgTJC79DTuQsyHD8kUX02xTjUMJxhF95DPyEJFNH0CbwV1lat
 jXsfSESTQysFhKVUGDUpDhGyF/IvB/JtPSNERPmCi5FVm18DvUZUgkbemfR8SWO7WGW6QyQzX
 OdceTuCsmnyG0r8J0D+V8MxEdwZZphiTzQw3oS96CFBuDrHzYqnbmh8Nmss1pFdWXzt81STWA
 rYQoHsACJNiZ6EydNhJR6lNxr1SMTSOr8QNh8h43OUZ05MrJtN6nKQEhEE1c1J73/frud88S4
 elev/W9hDbIKHQjeM3e2YVtsu/cgzYMCpOaL8Vtow6eQiqdlIjtMcbLPluMdJeUu//ylVvZTD
 uRlg0O9PCnoyhMaHAG4s/mis2r8yOGQCnwzyjJGBX+9d+32KRVyTZh9944V3pRUmb1N7xv0qR
 Nolipd4HPGbKBpci+6QqZd4f8vr10D9tFA6gVFNNW2yegzGoXuK/3cwFm4ix+QWAWIVTjqjUr
 mKRsY+4ykMJX9V5+6vEsLfySAvsuDXasTMZRhhkQ53JwDCoZDx/Bz4oyRx5j/ohDSZotSVVDk
 45rYJL6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The return value of do_recursive_merge() may be positive (indicating merge
conflicts), se let's OR later error conditions so as not to overwrite them
with 0.

This is not yet a problem, but preparing for the patches to come: we will
teach the sequencer to do rebase -i's job.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 5ec956f..0614b90 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -623,7 +623,7 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 	const char *base_label, *next_label;
 	struct commit_message msg = { NULL, NULL, NULL, NULL };
 	struct strbuf msgbuf = STRBUF_INIT;
-	int res, unborn = 0, allow;
+	int res = 0, unborn = 0, allow;
 
 	if (opts->no_commit) {
 		/*
@@ -734,7 +734,7 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 	}
 
 	if (!opts->strategy || !strcmp(opts->strategy, "recursive") || command == TODO_REVERT) {
-		res = do_recursive_merge(base, next, base_label, next_label,
+		res |= do_recursive_merge(base, next, base_label, next_label,
 					 head, &msgbuf, opts);
 		if (res < 0)
 			return res;
@@ -743,7 +743,7 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 		struct commit_list *common = NULL;
 		struct commit_list *remotes = NULL;
 
-		res = write_message(&msgbuf, git_path_merge_msg());
+		res |= write_message(&msgbuf, git_path_merge_msg());
 
 		commit_list_insert(base, &common);
 		commit_list_insert(next, &remotes);
@@ -780,11 +780,12 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 
 	allow = allow_empty(opts, commit);
 	if (allow < 0) {
-		res = allow;
+		res |= allow;
 		goto leave;
 	}
 	if (!opts->no_commit)
-		res = sequencer_commit(opts->edit ? NULL : git_path_merge_msg(),
+		res |= sequencer_commit(opts->edit ?
+				NULL : git_path_merge_msg(),
 			opts, allow, opts->edit, 0, 0);
 
 leave:
-- 
2.10.0.rc1.114.g2bd6b38


