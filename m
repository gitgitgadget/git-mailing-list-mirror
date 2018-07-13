Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F9241F90A
	for <e@80x24.org>; Fri, 13 Jul 2018 16:57:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731982AbeGMRMC (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jul 2018 13:12:02 -0400
Received: from siwi.pair.com ([209.68.5.199]:31819 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731935AbeGMRMB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jul 2018 13:12:01 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id DD2003F414D;
        Fri, 13 Jul 2018 12:56:33 -0400 (EDT)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 73C663F4149;
        Fri, 13 Jul 2018 12:56:33 -0400 (EDT)
From:   git@jeffhostetler.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v1 05/25] structured-logging: set sub_command field for branch command
Date:   Fri, 13 Jul 2018 16:56:01 +0000
Message-Id: <20180713165621.52017-6-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20180713165621.52017-1-git@jeffhostetler.com>
References: <20180713165621.52017-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Set sub-command field for the various forms of the branch command.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 builtin/branch.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/builtin/branch.c b/builtin/branch.c
index 5217ba3..fba516f 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -689,10 +689,12 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		setup_auto_pager("branch", 1);
 
 	if (delete) {
+		slog_set_sub_command_name("delete");
 		if (!argc)
 			die(_("branch name required"));
 		return delete_branches(argc, argv, delete > 1, filter.kind, quiet);
 	} else if (list) {
+		slog_set_sub_command_name("list");
 		/*  git branch --local also shows HEAD when it is detached */
 		if ((filter.kind & FILTER_REFS_BRANCHES) && filter.detached)
 			filter.kind |= FILTER_REFS_DETACHED_HEAD;
@@ -716,6 +718,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		const char *branch_name;
 		struct strbuf branch_ref = STRBUF_INIT;
 
+		slog_set_sub_command_name("edit");
 		if (!argc) {
 			if (filter.detached)
 				die(_("Cannot give description to detached HEAD"));
@@ -741,6 +744,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		if (edit_branch_description(branch_name))
 			return 1;
 	} else if (copy) {
+		slog_set_sub_command_name("copy");
 		if (!argc)
 			die(_("branch name required"));
 		else if (argc == 1)
@@ -750,6 +754,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		else
 			die(_("too many branches for a copy operation"));
 	} else if (rename) {
+		slog_set_sub_command_name("rename");
 		if (!argc)
 			die(_("branch name required"));
 		else if (argc == 1)
@@ -761,6 +766,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	} else if (new_upstream) {
 		struct branch *branch = branch_get(argv[0]);
 
+		slog_set_sub_command_name("new_upstream");
 		if (argc > 1)
 			die(_("too many arguments to set new upstream"));
 
@@ -784,6 +790,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		struct branch *branch = branch_get(argv[0]);
 		struct strbuf buf = STRBUF_INIT;
 
+		slog_set_sub_command_name("unset_upstream");
 		if (argc > 1)
 			die(_("too many arguments to unset upstream"));
 
@@ -806,6 +813,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	} else if (argc > 0 && argc <= 2) {
 		struct branch *branch = branch_get(argv[0]);
 
+		slog_set_sub_command_name("create");
 		if (!branch)
 			die(_("no such branch '%s'"), argv[0]);
 
-- 
2.9.3

