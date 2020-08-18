Return-Path: <SRS0=LSsm=B4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BBB7C433E3
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 14:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57A4E207D3
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 14:24:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N0o09gjO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726972AbgHROX5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Aug 2020 10:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726727AbgHROXY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Aug 2020 10:23:24 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A4BC06134A
        for <git@vger.kernel.org>; Tue, 18 Aug 2020 07:23:21 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id x5so16399693wmi.2
        for <git@vger.kernel.org>; Tue, 18 Aug 2020 07:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=065lcNmEdoUu44wwh69X/sCzMfLXKMLC1F0QAzASnbs=;
        b=N0o09gjOFh/cXgJm/aLAC5oPL6DAzdkmKY7c36gqG9x8Ajgle9lRPh2snxkX6JCrC7
         PGU7G0myLzEWYBimJzRBFyc5WFUcHz1MP+8geCPtd56+StwJGLX0ctAhW2TDrmLQzFKZ
         A7zKUCcV9WV/J258VnluuitbgfWedNADBcgTcBOhGUkz0RWAxxMxnMmMhMRlhEzFB1sX
         /9MhgmmOBoN8zdpW4MAdIEVMkCZF5hLzSyihmOAQHaYF1FsbAIQDOpnyuUeimxL7K/sY
         UEOrUzyXlfLopidUAFo4WB9uFuyMifKAW0cppLVwuLD5zZdfsYqiJcehJAx0Tts6EEqg
         wxxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=065lcNmEdoUu44wwh69X/sCzMfLXKMLC1F0QAzASnbs=;
        b=Z0I7F1gsybpZlTXfQTfU59wbIsq+vDnFQc+Z2l0ZYKEXzGCKF6LOE2fBi0r/nWvk0t
         UPWwcdeVc79YnBfQtmMf3R6tw2419HyBV4xlaj0BxMGsQISRjpv2Lhq9YHMxSxl5qKym
         L4mJcT76Uwr98KpvQ4kLH/Rrh8z1lxiCnyuigMfLS3NwfMUvhFSCYYxw3TWa70o67t3F
         Ev8mz7Vakl+KzK5sWqpVgJhRIchCvvi+toR5cs9Yv4BhTu//L0eesPqElO/ANUUIx1jg
         ZXNBdk06QX0cMZz24IDgqhOvA/a2x4VydRaqpaUaU+5L3BUCTNbzED46vQo1HnrlKqhU
         kTJw==
X-Gm-Message-State: AOAM532NZ5pP19P5G0Km+iInFuxWbhuEmyhAGF3DK6hTZfwkWzyZo+S9
        HkwBsdLzQmbSgmYgN20QMid2C9UbME8=
X-Google-Smtp-Source: ABdhPJwTFghG8KNDb1l3dikbiWbYS5O3eSOb9vADpG1MVC+DgV0BQiNuwEkHed3yGChNO0MYT5VObw==
X-Received: by 2002:a7b:c185:: with SMTP id y5mr160077wmi.95.1597760600012;
        Tue, 18 Aug 2020 07:23:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u66sm128341wmu.37.2020.08.18.07.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 07:23:19 -0700 (PDT)
Message-Id: <fc097c389a963065fc0bb5991bdebdca8824b121.1597760589.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.695.v2.git.1597760589.gitgitgadget@gmail.com>
References: <pull.695.git.1596728921.gitgitgadget@gmail.com>
        <pull.695.v2.git.1597760589.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 18 Aug 2020 14:23:07 +0000
Subject: [PATCH v2 10/11] maintenance: add auto condition for commit-graph
 task
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
index c54c3070b8..73e485bfc0 100644
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

