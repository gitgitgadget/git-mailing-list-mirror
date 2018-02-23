Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C89011F404
	for <e@80x24.org>; Fri, 23 Feb 2018 12:38:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751444AbeBWMiF (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 07:38:05 -0500
Received: from mout.gmx.net ([212.227.15.15]:48305 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750805AbeBWMiF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 07:38:05 -0500
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LhfZR-1eKrrg2Jd3-00mpE9; Fri, 23
 Feb 2018 13:37:57 +0100
Date:   Fri, 23 Feb 2018 13:37:42 +0100 (STD)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v4 06/12] sequencer: fast-forward merge commits, if
 possible
In-Reply-To: <cover.1519389319.git.johannes.schindelin@gmx.de>
Message-ID: <6f05185df94d07db847b4bdad0297af31b798bfd.1519389319.git.johannes.schindelin@gmx.de>
References: <cover.1518307771.git.johannes.schindelin@gmx.de> <cover.1519389319.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Bny8Crs+csCLHZmJ6wTtgyEhirhnqBVxlFRgdqeQ4B1H1Iqrw1d
 kBK8GNETxURdiU4vL4zqiwp95F7eHyuslc6gas5LyOjbHBPZ0E0AXyTPDu2OaIYCJA5ZxZC
 4dUCdE+iSAh+5VW+atvdosu3XM2ckxpRSVtYs+BaE9hxp87LL72mgh+2rMWr+zy9fH+VkXa
 WCByQMmeY9llKU2DRfMCQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:GI41hm44PKE=:t+FdrZ/9LQoPS1/hQno4U7
 K0XnAVaDWTe9g0BodpQB3b+2Wi5n1aNPKzw/H84JIbak9XXa/Gqx+5bmL4AFsu0WgbZk59N5E
 iGgoQK1a7SBykMqoCnAhu7WFDixS//PAI5HpmTjDn2qHrh0iJ2YHdlG3YGs0vLBBukxtciY3G
 yMx+ObqdPeVkd3OdgbOPl6tjQphlOxL4tLryv8pHC7g5PTQP1tbagOTI6mAyz9VJJ89TfU4MH
 VB9yvdHo89YUNto866pEwhe/8N/3sMluZKHDJfdcjSF3hIO1N7BQkI7qQHPXSUpdlUeCIPx9c
 Kpv7/0ma6SdlPtd6hud6zJt8xHIhTuCHMwM9RMi77QFU6Z8KcLw9d4cyixlVcpKQPGQUxTd/j
 4BDpHOzKDqIOnOJDXSW1xlJGE0NAJcZU8d4Dp5RKZZrHBFVotKdIQ7GV/Atd0tgoE8LZmAN/J
 yO4tFk9rKCiq64LAX3Og2EGNE+WXDnQRbvhVMEeCL2VOm7NIFxBGRJnyXIZe77hBt6Rq0aISH
 +Bnd4nOUxvmDeDQMJHTJnVRcUiyJwgdfPBBmlrBRG2hoPzBL2qlyyZnwB1udxpuEM2xGI8O0n
 Y+uDsB6SJh8B95+CWcjEoBni/Zd5M2VNFt0tRNucf4diVxZhFf/WaaETW6sWQTqeYBF5wf6Ex
 SFT8dlzWx2UrlezSAiju6FlS7iA7hMaqEyl02TrL+ojLi+0V4nWh1JIwBjBHb1KO+8Atbqsf6
 nF5eBdxB8Ef5URiX663fOvgGTUQq7hfEdWv2vtkw8VX/f1bwuqzPKBfDN090GOliVfJjrwN0m
 mrny64tf/heUMdsq+Gwc2+oKF9uxj6Fud6998bk0i6qYkx9j8w=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Just like with regular `pick` commands, if we are trying to recreate a
merge commit, we now test whether the parents of said commit match HEAD
and the commits to be merged, and fast-forward if possible.

This is not only faster, but also avoids unnecessary proliferation of
new objects.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index 64dbd1d3e2e..361ec98f764 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2651,7 +2651,7 @@ static int do_merge(struct commit *commit, const char *arg, int arg_len,
 	struct commit *head_commit, *merge_commit, *i;
 	struct commit_list *common, *j, *reversed = NULL;
 	struct merge_options o;
-	int ret;
+	int can_fast_forward, ret;
 	static struct lock_file lock;
 
 	for (merge_arg_len = 0; merge_arg_len < arg_len; merge_arg_len++)
@@ -2719,6 +2719,14 @@ static int do_merge(struct commit *commit, const char *arg, int arg_len,
 		strbuf_release(&buf);
 	}
 
+	/*
+	 * If HEAD is not identical to the parent of the original merge commit,
+	 * we cannot fast-forward.
+	 */
+	can_fast_forward = opts->allow_ff && commit && commit->parents &&
+		!oidcmp(&commit->parents->item->object.oid,
+			&head_commit->object.oid);
+
 	strbuf_addf(&ref_name, "refs/rewritten/%.*s", merge_arg_len, arg);
 	merge_commit = lookup_commit_reference_by_name(ref_name.buf);
 	if (!merge_commit) {
@@ -2732,6 +2740,17 @@ static int do_merge(struct commit *commit, const char *arg, int arg_len,
 		rollback_lock_file(&lock);
 		return -1;
 	}
+
+	if (can_fast_forward && commit->parents->next &&
+	    !commit->parents->next->next &&
+	    !oidcmp(&commit->parents->next->item->object.oid,
+		    &merge_commit->object.oid)) {
+		strbuf_release(&ref_name);
+		rollback_lock_file(&lock);
+		return fast_forward_to(&commit->object.oid,
+				       &head_commit->object.oid, 0, opts);
+	}
+
 	write_message(oid_to_hex(&merge_commit->object.oid), GIT_SHA1_HEXSZ,
 		      git_path_merge_head(), 0);
 	write_message("no-ff", 5, git_path_merge_mode(), 0);
-- 
2.16.1.windows.4


