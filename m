Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 06C231F404
	for <e@80x24.org>; Thu, 19 Apr 2018 12:21:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752514AbeDSMVj (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Apr 2018 08:21:39 -0400
Received: from mout.gmx.net ([212.227.15.18]:49387 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751379AbeDSMVi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Apr 2018 08:21:38 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MN1j6-1f2XvW0v96-006heI; Thu, 19
 Apr 2018 14:21:30 +0200
Date:   Thu, 19 Apr 2018 14:21:13 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Sergey Organov <sorganov@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v7 08/17] sequencer: fast-forward `merge` commands, if
 possible
In-Reply-To: <cover.1524139900.git.johannes.schindelin@gmx.de>
Message-ID: <93eaf4f01ce471a08150113a0e690d2ce2cdec74.1524139900.git.johannes.schindelin@gmx.de>
References: <cover.1523362469.git.johannes.schindelin@gmx.de> <cover.1524139900.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:UqRqUzqebnrxdbT8DQFcJEcVZsrceN9SN/+h65b1TW9hFO6AeO9
 dQyPMxs1p/rUXW2ZG7qgKDddAMC0gjARi8MeWikNVQGhpImhXNvKtUmbNtyx4lvGjQmKGH9
 N9O0cFz1mgVfAab09VdYvkfUZUDrJfEu7D0FquuqIms67w3xzqRziuFGq3Df/4n23UVeEtF
 6M4f/lOQRMt2j8XxK8aTQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:hO40UEw7S/A=:ppJZJH0oFeekuG/ckQ2Sst
 +KfLtZnY+UxRIL/uhEE9W+0/LBoC4iPt1+HJ7cefYeaT/G8JZnZMq17ERpd4T33nhvZPYkrlO
 5tVSTkgftbSBUSZLXUEeD821LKFudUxxEnOvTlGcdGZTkbhQPAOL4gUCt/kNweBYkSkT1XTq4
 EGXU8Iq12nzzPOkZ50fV5wGoYenSleTg/YBFiol+MKkiRPcTAowusXSYtKBdwzrEfjnzEr771
 ho0kR1v7p2r98X8AyDzbXrjwOyRRRybLHjwI94olADLuNLZrXkf5/XKaUpUstg8qH66IIaeUM
 aDjFPWxjJW+vikRXdgm7yXkxFI0Ai6s2CcT+0MClI49A7S3bGLXIzsvTcbVQaJ0EsSkt9OPE7
 QqaXLESV4IayMzuU3ntzSQqCVN9nEXL42KV2BwGwu0pHvtE4MWYTVFYOwLBcJww79EwyrrU7Q
 0SdfMaTRznthoX/Cf1cZt+WY58fL80wLnpF1SPjLI5Jco4dWcjEzMsepiTWByqdfrtWiIIjFC
 D5xWAORhabavoSwCUY+g802E74Q0VC+L9Jfsq5839vv0wnJUJ/hjuEPiHQXxzBNXpWv4EUvDf
 V/9FEMO/eUm6zUhFG6wHpmlNPj8/3gPjQSEJumo/UODoCWqxvWGHd4cMb1c+VhNDPsPmUZA5v
 mTSWqXtZPgO9SnmkGvEBehBtTkBzq64w26dtQqKpbeZLChUFB5xouoYA3giMXBibb3feDlXF1
 N7JvCxtwuYdcazJ+oB02NVfv7282SU7A4XJEsgm5Av+yg9YYnGM9J6vUEsSixnfsUsZetcdpm
 Muf6YMxDg3/2KNTSV6JnWpN911GXbvgKgWWk63oLjGeQWs+fjo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Just like with regular `pick` commands, if we are trying to rebase a
merge commit, we now test whether the parents of said commit match HEAD
and the commits to be merged, and fast-forward if possible.

This is not only faster, but also avoids unnecessary proliferation of
new objects.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index 90b2fac96b1..2ae2294272b 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2679,7 +2679,7 @@ static int do_merge(struct commit *commit, const char *arg, int arg_len,
 	struct commit *head_commit, *merge_commit, *i;
 	struct commit_list *bases, *j, *reversed = NULL;
 	struct merge_options o;
-	int merge_arg_len, oneline_offset, ret;
+	int merge_arg_len, oneline_offset, can_fast_forward, ret;
 	static struct lock_file lock;
 	const char *p;
 
@@ -2764,6 +2764,37 @@ static int do_merge(struct commit *commit, const char *arg, int arg_len,
 		}
 	}
 
+	/*
+	 * If HEAD is not identical to the first parent of the original merge
+	 * commit, we cannot fast-forward.
+	 */
+	can_fast_forward = opts->allow_ff && commit && commit->parents &&
+		!oidcmp(&commit->parents->item->object.oid,
+			&head_commit->object.oid);
+
+	/*
+	 * If the merge head is different from the original one, we cannot
+	 * fast-forward.
+	 */
+	if (can_fast_forward) {
+		struct commit_list *second_parent = commit->parents->next;
+
+		if (second_parent && !second_parent->next &&
+		    oidcmp(&merge_commit->object.oid,
+			   &second_parent->item->object.oid))
+			can_fast_forward = 0;
+	}
+
+	if (can_fast_forward && commit->parents->next &&
+	    !commit->parents->next->next &&
+	    !oidcmp(&commit->parents->next->item->object.oid,
+		    &merge_commit->object.oid)) {
+		rollback_lock_file(&lock);
+		ret = fast_forward_to(&commit->object.oid,
+				      &head_commit->object.oid, 0, opts);
+		goto leave_merge;
+	}
+
 	write_message(oid_to_hex(&merge_commit->object.oid), GIT_SHA1_HEXSZ,
 		      git_path_merge_head(), 0);
 	write_message("no-ff", 5, git_path_merge_mode(), 0);
-- 
2.17.0.windows.1.4.g7e4058d72e3


