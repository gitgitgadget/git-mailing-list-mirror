Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B1441F6BF
	for <e@80x24.org>; Wed, 31 Aug 2016 08:57:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933824AbcHaIzf (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 04:55:35 -0400
Received: from mout.gmx.net ([212.227.17.20]:59108 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933795AbcHaIza (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 04:55:30 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MdXSC-1bSy3e40Z2-00PN7N; Wed, 31 Aug 2016 10:55:27
 +0200
Date:   Wed, 31 Aug 2016 10:55:26 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 15/34] sequencer (rebase -i): leave a patch upon error
In-Reply-To: <cover.1472633606.git.johannes.schindelin@gmx.de>
Message-ID: <cade51f893ed381ed03718439c7dba3f5dcebba3.1472633606.git.johannes.schindelin@gmx.de>
References: <cover.1472633606.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:AtmbhcScCUHfMFkrEsnRVAAFBy9fjEt8cccJ3GQOtxs0ab/jtrl
 cnV1XhWe3cCCe1fpipaSzXs0+MlmtVa5DaBEIOg2NswFh/Q2rIKUsKGUZyVs9A9Bj3tRJ1X
 T4YhdmWT0WP4Sr5EM0CY2GKqaUL5gMaoffGV7qhbeMpDdBB0JVwtuvPMQEFtTT0oGvhe2dK
 y44QyTdJzgoa6GmHPbKbg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:WiB/zwVwVps=:Cj7/qIEHMlRcqxew25l1yn
 RvPVw7DkQuRPkdfWhLtS7Ywnl5qTbdqWvcBfS4ZEo23xuryfcr7/hHE7ByP1Zqx/uMVrHjUb5
 xQXDLHglKBOPdqL1bvo3QNAbqKQyVeYbOz1cUnuW/g9+tlmRxBQ+g9LK4QNYbXPEik827gtKX
 izjTUSMtLEfRRmAAB9BE8nDXow9/e74b14Y2vMZYPJMAbZDtSIj929v4gznOaMjlo8DKRFvt6
 VKK/6sesGvBhabQ9TyXb6B3ZEX+bnYCqchVg7khj9ODCNR7INrsAwTutXxndQmc8kVOs7sNL+
 6HpgOZ3Axb/iq9I7rMk0lFl7S2rgVBL7RjSwh+HIOPu9eBN828nJte1JnheeMvHRJL1TN+c/2
 ycxPuOp50Q9w4lywnaz98oiQCd0o0hvQq+ui2nLO0SVdzIK/ifE/gBl//JU0NG1MFmGLMpYnU
 T9YiXH5yB7i1uUIcOe10nGfJF6gQw2VMCFQz5tB7PJ9t6NvSYnbl/nGDx+9/WWb1ehPIpB9RI
 egJC/haFQCNEvO9cq4k6dWxexihcB/KkztYPpldZQ2YOWTsG2CL7aD73tD1F6kFyS9+v3TP7F
 Wf8HIKIulKN+X8gk3neKBErmNV9GNJyFMZD5ygZKQB8rgnbVbWLCFql2pttAdRdfj8gopoM/w
 cUL+VyVUAPdfpuFMKQdvViB8c8cNuyNbk771N4HoKjWwI/b+znwBTm8+XXf/VbkB7jU+ojJ45
 V6hjRdhVK/E6OpXRceHr3q4balDYtII8gYVZ0leY7E/VoswJc2FQJCkskY1+uEGHj+G9Qj/KD
 v2vYsut
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Just like the interactive rebase, we want to leave a 'patch' file for
further inspection by the user (even if we never tried to actually apply
that patch, since we're cherry-picking instead).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index 7662222..9a06b40 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1753,6 +1753,9 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 				return error_failed_squash(item->commit, opts,
 					item->arg_len, item->arg);
 			}
+			else if (res && is_rebase_i(opts))
+				return res | error_with_patch(item->commit,
+					item->arg, item->arg_len, opts, res, 0);
 		}
 		else if (item->command == TODO_EXEC) {
 			char *end_of_arg = (char *)(item->arg + item->arg_len);
-- 
2.10.0.rc2.102.g5c102ec


