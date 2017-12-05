Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7623C20A40
	for <e@80x24.org>; Tue,  5 Dec 2017 17:03:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752851AbdLERDn (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Dec 2017 12:03:43 -0500
Received: from siwi.pair.com ([209.68.5.199]:15291 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752860AbdLERDQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Dec 2017 12:03:16 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 9F15A844E6;
        Tue,  5 Dec 2017 12:03:15 -0500 (EST)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 24FA1844DE;
        Tue,  5 Dec 2017 12:03:15 -0500 (EST)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, jonathantanmy@google.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v6 09/14] fixup: connected: conditionally pass --exclude-promisor-objects to rev-list
Date:   Tue,  5 Dec 2017 17:02:49 +0000
Message-Id: <20171205170254.65293-10-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20171205170254.65293-1-git@jeffhostetler.com>
References: <20171205170254.65293-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Teach connected.c to only pass --exclude-promisor-objects to rev-list when
partial clone is enabled.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 connected.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/connected.c b/connected.c
index a51c01d..3a5bd67 100644
--- a/connected.c
+++ b/connected.c
@@ -56,7 +56,8 @@ int check_connected(sha1_iterate_fn fn, void *cb_data,
 	argv_array_push(&rev_list.args,"rev-list");
 	argv_array_push(&rev_list.args, "--objects");
 	argv_array_push(&rev_list.args, "--stdin");
-	argv_array_push(&rev_list.args, "--exclude-promisor-objects");
+	if (repository_format_partial_clone)
+		argv_array_push(&rev_list.args, "--exclude-promisor-objects");
 	argv_array_push(&rev_list.args, "--not");
 	argv_array_push(&rev_list.args, "--all");
 	argv_array_push(&rev_list.args, "--quiet");
-- 
2.9.3

