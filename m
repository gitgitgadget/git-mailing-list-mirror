Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 914DF1F85E
	for <e@80x24.org>; Fri, 13 Jul 2018 16:56:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732688AbeGMRMC (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jul 2018 13:12:02 -0400
Received: from siwi.pair.com ([209.68.5.199]:31827 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731651AbeGMRMC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jul 2018 13:12:02 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 7358C3F4146;
        Fri, 13 Jul 2018 12:56:34 -0400 (EDT)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 0B8E63F4151;
        Fri, 13 Jul 2018 12:56:33 -0400 (EDT)
From:   git@jeffhostetler.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v1 06/25] structured-logging: set sub_command field for checkout command
Date:   Fri, 13 Jul 2018 16:56:02 +0000
Message-Id: <20180713165621.52017-7-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20180713165621.52017-1-git@jeffhostetler.com>
References: <20180713165621.52017-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 builtin/checkout.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 2e1d237..d05890b 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -249,6 +249,8 @@ static int checkout_paths(const struct checkout_opts *opts,
 	int errs = 0;
 	struct lock_file lock_file = LOCK_INIT;
 
+	slog_set_sub_command_name(opts->patch_mode ? "patch" : "path");
+
 	if (opts->track != BRANCH_TRACK_UNSPECIFIED)
 		die(_("'%s' cannot be used with updating paths"), "--track");
 
@@ -826,6 +828,9 @@ static int switch_branches(const struct checkout_opts *opts,
 	void *path_to_free;
 	struct object_id rev;
 	int flag, writeout_error = 0;
+
+	slog_set_sub_command_name("switch_branch");
+
 	memset(&old_branch_info, 0, sizeof(old_branch_info));
 	old_branch_info.path = path_to_free = resolve_refdup("HEAD", 0, &rev, &flag);
 	if (old_branch_info.path)
@@ -1037,6 +1042,8 @@ static int switch_unborn_to_new_branch(const struct checkout_opts *opts)
 	int status;
 	struct strbuf branch_ref = STRBUF_INIT;
 
+	slog_set_sub_command_name("switch_unborn_to_new_branch");
+
 	if (!opts->new_branch)
 		die(_("You are on a branch yet to be born"));
 	strbuf_addf(&branch_ref, "refs/heads/%s", opts->new_branch);
-- 
2.9.3

