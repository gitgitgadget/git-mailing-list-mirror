Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9378202AC
	for <e@80x24.org>; Thu, 13 Jul 2017 17:36:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752691AbdGMRf5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 13:35:57 -0400
Received: from siwi.pair.com ([209.68.5.199]:11117 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752627AbdGMRfn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 13:35:43 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id DC643844E9;
        Thu, 13 Jul 2017 13:35:42 -0400 (EDT)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 3A043844E3;
        Thu, 13 Jul 2017 13:35:42 -0400 (EDT)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, ethomson@edwardthomson.com,
        jonathantanmy@google.com, jrnieder@gmail.com,
        jeffhost@microsoft.com
Subject: [PATCH v2 16/19] connected: add filter_allow_omitted option to API
Date:   Thu, 13 Jul 2017 17:34:56 +0000
Message-Id: <20170713173459.3559-17-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170713173459.3559-1-git@jeffhostetler.com>
References: <20170713173459.3559-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 connected.c | 3 +++
 connected.h | 6 ++++++
 2 files changed, 9 insertions(+)

diff --git a/connected.c b/connected.c
index 136c2ac..c25b816 100644
--- a/connected.c
+++ b/connected.c
@@ -62,6 +62,9 @@ int check_connected(sha1_iterate_fn fn, void *cb_data,
 		argv_array_pushf(&rev_list.args, "--progress=%s",
 				 _("Checking connectivity"));
 
+	if (opt->filter_relax)
+		argv_array_push(&rev_list.args, ("--" CL_ARG_FILTER_RELAX));
+
 	rev_list.git_cmd = 1;
 	rev_list.env = opt->env;
 	rev_list.in = -1;
diff --git a/connected.h b/connected.h
index 4ca325f..370710e 100644
--- a/connected.h
+++ b/connected.h
@@ -35,6 +35,12 @@ struct check_connected_options {
 	int progress;
 
 	/*
+	 * Relax consistency checks for missing blobs (presumably
+	 * due to the use 'filter-objects' feature).
+	 */
+	int filter_relax;
+
+	/*
 	 * Insert these variables into the environment of the child process.
 	 */
 	const char **env;
-- 
2.9.3

