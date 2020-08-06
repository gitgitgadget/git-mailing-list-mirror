Return-Path: <SRS0=sa20=BQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7954C433E3
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 16:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E24732311A
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 16:53:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tktImup2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729686AbgHFQxe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Aug 2020 12:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729436AbgHFQu5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Aug 2020 12:50:57 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB4E1C002148
        for <git@vger.kernel.org>; Thu,  6 Aug 2020 08:48:53 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id c80so9281572wme.0
        for <git@vger.kernel.org>; Thu, 06 Aug 2020 08:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=LVcw63hOu0h+rjT/ZXCO/mP9lk9UyKpe3tfyE2hUF/A=;
        b=tktImup2KX4BwFGvvdAugUWDxNMzkRoyhzlRuU9Dv//nMYoIZDf0JE4RLUta7Wfs+G
         WC26FJeZn9i+RR9THwmlaXYB6QodzzRJClYUHbiRma1BCOvc8z7hS039UwohqcJlSdj1
         CvmKNwC71Z8PQXS5oBvfdIcAfN0QSBRnoSCbURSk5cRp/03EseOJMv+Y7n5IXfAgSMO+
         tJwN1cNhK/QdQnCsHlyWNNJj3ujO6+4EeW7V+HqguRVxGlVg2OyUPiSywiCX810k+jJi
         aFkplL2dNJyLVRxGwx4XLPHMgrne9hm+ACnUqccbRg/K0VgjOG4T6P47AK6mzsQw3YCG
         6E1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=LVcw63hOu0h+rjT/ZXCO/mP9lk9UyKpe3tfyE2hUF/A=;
        b=Krq1a+ZKa0lw/RlxMq00h5bUd/5Pk5PYtzSa6ideLZ4vrXXy5ps4LMUMTdKcfDpLLI
         kE2+EHzMKlF3/alymo9jQQrir5Mb15JMoVp7+3rfrhD6Bg2YtJBxabEqaDA0Yc6Pgi5B
         9I2RE/QIR1CyizTkl6sP+kkgO8CczPZQza+CZOW4/hRdHxbqFT63v/NWphHOYhf7SrbR
         qW8dKADLZRz7kBxpOEmQhy3MPTD9kBVk8TOq2uO2zkuWOBXmi+RKs4vyTn5h2puQp2Vt
         bEAyKw8HlCnM4ZrN/XxCEpCOUA+v4MdMdUC+lHkoE8g9yaXpuPB8i9+RrKnyopjuqSlW
         BTxw==
X-Gm-Message-State: AOAM530nIzcGLeJJTaXuOT5APRGIqUow4Pn6ZtZ9a/ZgADK7IzBq7wDo
        px0gHwSMgVFz9AASfTE2LyHUX7UK
X-Google-Smtp-Source: ABdhPJzqXQINtXvEvAzIuIpkPgtPVhlIGNgnmGGYgS8eKUahezjCLl1bnhf6rrTNCkLgFZFy3WDDWg==
X-Received: by 2002:a05:600c:25cc:: with SMTP id 12mr8444617wml.120.1596728932433;
        Thu, 06 Aug 2020 08:48:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p14sm7536081wrx.90.2020.08.06.08.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 08:48:51 -0700 (PDT)
Message-Id: <e67e259aefddab76503be0963b5833ff2aa5cb43.1596728921.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.695.git.1596728921.gitgitgadget@gmail.com>
References: <pull.695.git.1596728921.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 06 Aug 2020 15:48:40 +0000
Subject: [PATCH 10/11] maintenance: add auto condition for commit-graph task
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     sandals@crustytoothpaste.net, steadmon@google.com,
        jrnieder@gmail.com, peff@peff.net, congdanhqx@gmail.com,
        phillip.wood123@gmail.com, emilyshaffer@google.com,
        sluongng@gmail.com, jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Instead of writing a new commit-graph in every 'git maintenance run
--auto' process (when maintenance.commit-graph.enalbed is configured to
be true), only write when there are "enough" commits not in a
commit-graph file.

This count is controlled by the maintenance.commit-graph.auto config
option.

To compute the count, use a depth-first search starting at each ref, and
leaving markers using the PARENT1 flag. If this count reaches the limit,
then terminate early and start the task. Otherwise, this operation will
peel every ref and parse the commit it points to. If these are all in
the commit-graph, then this is typically a very fast operation. Users
with many refs might feel a slow-down, and hence could consider updating
their limit to be very small. A negative value will force the step to
run every time.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/config/maintenance.txt | 10 ++++
 builtin/gc.c                         | 76 ++++++++++++++++++++++++++++
 object.h                             |  1 +
 3 files changed, 87 insertions(+)

diff --git a/Documentation/config/maintenance.txt b/Documentation/config/maintenance.txt
index 370cbfb42f..9bd69b9df3 100644
--- a/Documentation/config/maintenance.txt
+++ b/Documentation/config/maintenance.txt
@@ -2,3 +2,13 @@ maintenance.<task>.enabled::
 	This boolean config option controls whether the maintenance task
 	with name `<task>` is run when no `--task` option is specified.
 	By default, only `maintenance.gc.enabled` is true.
+
+maintenance.commit-graph.auto::
+	This integer config option controls how often the `commit-graph` task
+	should be run as part of `git maintenance run --auto`. If zero, then
+	the `commit-graph` task will not run with the `--auto` option. A
+	negative value will force the task to run every time. Otherwise, a
+	positive value implies the command should run when the number of
+	reachable commits that are not in the commit-graph file is at least
+	the value of `maintenance.commit-graph.auto`. The default value is
+	100.
diff --git a/builtin/gc.c b/builtin/gc.c
index 2b3e45eb71..20d85f6f4e 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -28,6 +28,7 @@
 #include "blob.h"
 #include "tree.h"
 #include "promisor-remote.h"
+#include "refs.h"
 
 #define FAILED_RUN "failed to run %s"
 
@@ -710,6 +711,80 @@ struct maintenance_opts {
 	int quiet;
 };
 
+/* Remember to update object flag allocation in object.h */
+#define PARENT1		(1u<<16)
+
+static int num_commits_not_in_graph = 0;
+static int limit_commits_not_in_graph = 100;
+
+static int dfs_on_ref(const char *refname,
+		      const struct object_id *oid, int flags,
+		      void *cb_data)
+{
+	int result = 0;
+	struct object_id peeled;
+	struct commit_list *stack = NULL;
+	struct commit *commit;
+
+	if (!peel_ref(refname, &peeled))
+		oid = &peeled;
+	if (oid_object_info(the_repository, oid, NULL) != OBJ_COMMIT)
+		return 0;
+
+	commit = lookup_commit(the_repository, oid);
+	if (!commit)
+		return 0;
+	if (parse_commit(commit))
+		return 0;
+
+	commit_list_append(commit, &stack);
+
+	while (!result && stack) {
+		struct commit_list *parent;
+
+		commit = pop_commit(&stack);
+
+		for (parent = commit->parents; parent; parent = parent->next) {
+			if (parse_commit(parent->item) ||
+			    commit_graph_position(parent->item) != COMMIT_NOT_FROM_GRAPH ||
+			    parent->item->object.flags & PARENT1)
+				continue;
+
+			parent->item->object.flags |= PARENT1;
+			num_commits_not_in_graph++;
+
+			if (num_commits_not_in_graph >= limit_commits_not_in_graph) {
+				result = 1;
+				break;
+			}
+
+			commit_list_append(parent->item, &stack);
+		}
+	}
+
+	free_commit_list(stack);
+	return result;
+}
+
+static int should_write_commit_graph(void)
+{
+	int result;
+
+	git_config_get_int("maintenance.commit-graph.auto",
+			   &limit_commits_not_in_graph);
+
+	if (!limit_commits_not_in_graph)
+		return 0;
+	if (limit_commits_not_in_graph < 0)
+		return 1;
+
+	result = for_each_ref(dfs_on_ref, NULL);
+
+	clear_commit_marks_all(PARENT1);
+
+	return result;
+}
+
 static int run_write_commit_graph(struct maintenance_opts *opts)
 {
 	struct child_process child = CHILD_PROCESS_INIT;
@@ -822,6 +897,7 @@ static struct maintenance_task tasks[] = {
 	[TASK_COMMIT_GRAPH] = {
 		"commit-graph",
 		maintenance_task_commit_graph,
+		should_write_commit_graph,
 	},
 };
 
diff --git a/object.h b/object.h
index 96a2105859..30d4e0f6a0 100644
--- a/object.h
+++ b/object.h
@@ -74,6 +74,7 @@ struct object_array {
  * list-objects-filter.c:                                      21
  * builtin/fsck.c:           0--3
  * builtin/index-pack.c:                                     2021
+ * builtin/maintenance.c:                           16
  * builtin/pack-objects.c:                                   20
  * builtin/reflog.c:                   10--12
  * builtin/show-branch.c:    0-------------------------------------------26
-- 
gitgitgadget

