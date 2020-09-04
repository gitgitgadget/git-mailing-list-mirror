Return-Path: <SRS0=BZy3=CN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0084C433E2
	for <git@archiver.kernel.org>; Fri,  4 Sep 2020 13:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8435E2073B
	for <git@archiver.kernel.org>; Fri,  4 Sep 2020 13:11:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="goxmNeNr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730406AbgIDNKf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Sep 2020 09:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730360AbgIDNJo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Sep 2020 09:09:44 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69618C06125C
        for <git@vger.kernel.org>; Fri,  4 Sep 2020 06:09:27 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id m6so6738253wrn.0
        for <git@vger.kernel.org>; Fri, 04 Sep 2020 06:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=IqlsW4gQipo4j4B7Cy/KcruVIvhTi311pawh+Do+0uA=;
        b=goxmNeNr19Sy1271h7Ts3no9g6Kj3uCbVRqtZdDanUPo5Ay9rkHC1UqNTDIe5HbiKv
         Jw+Bit7tHJMkvxCYT4c3c6V76lE9wg8A24O29pxN+6SDOJMrcTkzXygNGFY+YFlhAn7Q
         KSC5XSooa0LESQWX2rTEGrl8nmDO7U/7QAD9yqJs1hhtgYJ9cK0euVQVYo1HuMKvjxe9
         uDVEKmoswLUmmteaSL9LSUiPFD37F6dvT1+ttutT2BM5zx5rapzlG653wM9rXOcMoGb8
         z16UzLoaptvUYmslcTpQI5yAZh9dj0T9UKPDNGR3uofTQ9rkJdkpQ0cC70zvNJzVOSNI
         wckA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=IqlsW4gQipo4j4B7Cy/KcruVIvhTi311pawh+Do+0uA=;
        b=mRwFH1YO/GOeQIZlcLJjHGGyOGrcY4YZiHfaliOxD0mGWtYX4DbA4J4TyfLD1SNwEg
         qv0Qn6JstYmvTY7uuWVC+Hniwk4g/MsaZcw41oGQgxuQoZfHRLi7B86UV5sdZ1NXVVBn
         lwxgD2c732CfYcWw3ahHxm1dYnN+qlybFd7IJDC8OLkl1wMfxXiIExFM7JZHZayL84Lz
         Wb7HPZR7r3BY1t9dHSY433/ui7TdU5Zd+ghES7IJziymofQFia6/w2GLqlfkq2LjiGVs
         91hdUct4yeiDXnmqugQ5WtJtmv0jBwOXZV65K3xFXuZqDX5oURi602ZRY2TXNxEo6zxt
         aQSg==
X-Gm-Message-State: AOAM532fYDCMBHs+3dVJjYqXRt96DucKat6Wznf6xCuiWLu9kKM6LacM
        UF5MMN0UBNTHKKht6+5K9uN+3dJRuxg=
X-Google-Smtp-Source: ABdhPJzxmxJ+NCZHw47KveIwmuaeJQ/9A4cAbiygBWU2NjIhJtEGaYLNflKj8KkkKyJ5mwrMfXs5tQ==
X-Received: by 2002:adf:f0c7:: with SMTP id x7mr7417141wro.315.1599224965898;
        Fri, 04 Sep 2020 06:09:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f126sm10492123wmf.13.2020.09.04.06.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 06:09:25 -0700 (PDT)
Message-Id: <8f84b03c4651681af1eb3512bd7c062c3a4c6d95.1599224956.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.695.v4.git.1599224956.gitgitgadget@gmail.com>
References: <pull.695.v3.git.1598380426.gitgitgadget@gmail.com>
        <pull.695.v4.git.1599224956.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 04 Sep 2020 13:09:14 +0000
Subject: [PATCH v4 10/11] maintenance: add auto condition for commit-graph
 task
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
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
leaving markers using the SEEN flag. If this count reaches the limit,
then terminate early and start the task. Otherwise, this operation will
peel every ref and parse the commit it points to. If these are all in
the commit-graph, then this is typically a very fast operation. Users
with many refs might feel a slow-down, and hence could consider updating
their limit to be very small. A negative value will force the step to
run every time.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/config/maintenance.txt | 10 ++++
 builtin/gc.c                         | 82 ++++++++++++++++++++++++++++
 object.h                             |  1 +
 3 files changed, 93 insertions(+)

diff --git a/Documentation/config/maintenance.txt b/Documentation/config/maintenance.txt
index 4402b8b49f..7cc6700d57 100644
--- a/Documentation/config/maintenance.txt
+++ b/Documentation/config/maintenance.txt
@@ -4,3 +4,13 @@ maintenance.<task>.enabled::
 	`git maintenance run`. These config values are ignored if a
 	`--task` option exists. By default, only `maintenance.gc.enabled`
 	is true.
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
index 709d13553b..8c4edf19ba 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -28,6 +28,7 @@
 #include "blob.h"
 #include "tree.h"
 #include "promisor-remote.h"
+#include "refs.h"
 
 #define FAILED_RUN "failed to run %s"
 
@@ -710,6 +711,86 @@ struct maintenance_run_opts {
 	int quiet;
 };
 
+/* Remember to update object flag allocation in object.h */
+#define SEEN		(1u<<0)
+
+struct cg_auto_data {
+	int num_not_in_graph;
+	int limit;
+};
+
+static int dfs_on_ref(const char *refname,
+		      const struct object_id *oid, int flags,
+		      void *cb_data)
+{
+	struct cg_auto_data *data = (struct cg_auto_data *)cb_data;
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
+			    parent->item->object.flags & SEEN)
+				continue;
+
+			parent->item->object.flags |= SEEN;
+			data->num_not_in_graph++;
+
+			if (data->num_not_in_graph >= data->limit) {
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
+	struct cg_auto_data data;
+
+	data.num_not_in_graph = 0;
+	data.limit = 100;
+	git_config_get_int("maintenance.commit-graph.auto",
+			   &data.limit);
+
+	if (!data.limit)
+		return 0;
+	if (data.limit < 0)
+		return 1;
+
+	result = for_each_ref(dfs_on_ref, &data);
+
+	clear_commit_marks_all(SEEN);
+
+	return result;
+}
+
 static int run_write_commit_graph(struct maintenance_run_opts *opts)
 {
 	struct child_process child = CHILD_PROCESS_INIT;
@@ -790,6 +871,7 @@ static struct maintenance_task tasks[] = {
 	[TASK_COMMIT_GRAPH] = {
 		"commit-graph",
 		maintenance_task_commit_graph,
+		should_write_commit_graph,
 	},
 };
 
diff --git a/object.h b/object.h
index 96a2105859..20b18805f0 100644
--- a/object.h
+++ b/object.h
@@ -73,6 +73,7 @@ struct object_array {
  * sha1-name.c:                                              20
  * list-objects-filter.c:                                      21
  * builtin/fsck.c:           0--3
+ * builtin/gc.c:             0
  * builtin/index-pack.c:                                     2021
  * builtin/pack-objects.c:                                   20
  * builtin/reflog.c:                   10--12
-- 
gitgitgadget

