Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 504A01F85E
	for <e@80x24.org>; Fri, 13 Jul 2018 16:56:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387849AbeGMRMJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jul 2018 13:12:09 -0400
Received: from siwi.pair.com ([209.68.5.199]:31833 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387769AbeGMRMI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jul 2018 13:12:08 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 461663F4801;
        Fri, 13 Jul 2018 12:56:41 -0400 (EDT)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id D2B213F481C;
        Fri, 13 Jul 2018 12:56:40 -0400 (EDT)
From:   git@jeffhostetler.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v1 18/25] structured-logging: add aux-data for size of sparse-checkout file
Date:   Fri, 13 Jul 2018 16:56:14 +0000
Message-Id: <20180713165621.52017-19-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20180713165621.52017-1-git@jeffhostetler.com>
References: <20180713165621.52017-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Teach unpack_trees() to record the number of entries in the sparse-checkout
file in the aux-data.  This will be reported in the "cmd_exit" event.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 unpack-trees.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 3a85a02..71b1b93 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1285,8 +1285,10 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 		char *sparse = git_pathdup("info/sparse-checkout");
 		if (add_excludes_from_file_to_list(sparse, "", 0, &el, NULL) < 0)
 			o->skip_sparse_checkout = 1;
-		else
+		else {
 			o->el = &el;
+			slog_aux_intmax("index", "sparse_checkout_count", el.nr);
+		}
 		free(sparse);
 	}
 
-- 
2.9.3

