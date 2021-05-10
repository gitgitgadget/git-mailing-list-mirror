Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A86C3C433ED
	for <git@archiver.kernel.org>; Mon, 10 May 2021 09:44:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F755613CA
	for <git@archiver.kernel.org>; Mon, 10 May 2021 09:44:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbhEJJpi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 May 2021 05:45:38 -0400
Received: from smtp505.hk.chengmail.me ([113.10.190.62]:54276 "EHLO
        smtp505.hk.chengmail.me" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbhEJJph (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 May 2021 05:45:37 -0400
X-CHENGMAILHOST: 113.10.190.62
X-CHENGMAIL-INSTANCEID: 59a4.60990079.c6c1f.0
From:   lilinchao@oschina.cn
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com,
        Li Linchao <lilinchao@oschina.cn>
Subject: [PATCH] builtin/gc: warn when core.commitGraph is disabled
Date:   Mon, 10 May 2021 17:43:43 +0800
X-source-message-id: <20210510094343.28340-1-lilinchao@oschina.cn>
X-Mailer: git-send-email 2.31.1.442.g7e39198978
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <510425b8b17411eb93770026b95c99cc@oschina.cn>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Li Linchao <lilinchao@oschina.cn>

Throw warning message when core.commitGraph is disabled in commit-graph
maintenance task.

Signed-off-by: Li Linchao <lilinchao@oschina.cn>
---
 builtin/gc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 98a803196b..90684ca3b3 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -861,8 +861,10 @@ static int run_write_commit_graph(struct maintenance_run_opts *opts)
 static int maintenance_task_commit_graph(struct maintenance_run_opts *opts)
 {
 	prepare_repo_settings(the_repository);
-	if (!the_repository->settings.core_commit_graph)
+	if (!the_repository->settings.core_commit_graph) {
+		warning(_("skipping commit-graph task because core.commitGraph is disabled"));
 		return 0;
+	}
 
 	close_object_store(the_repository->objects);
 	if (run_write_commit_graph(opts)) {
-- 
2.31.1.442.g7e39198978

