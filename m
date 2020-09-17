Return-Path: <SRS0=cV3L=C2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64DE1C43461
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 18:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05FFE21973
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 18:15:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fnO6aJvH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbgIQSOy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Sep 2020 14:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbgIQSNS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Sep 2020 14:13:18 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22DEDC06121C
        for <git@vger.kernel.org>; Thu, 17 Sep 2020 11:12:04 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id k18so2984517wmj.5
        for <git@vger.kernel.org>; Thu, 17 Sep 2020 11:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=EwaUtjW05eztNq1hcyuxldE206s1lvSs488NYmfcjfA=;
        b=fnO6aJvHZwNS1ctkh9swCWsunYf0fH+SZkrlUsQ4IBx/01hfg7PYLQywIjnDNUhyQo
         YzT8bQeLDCAPT28zrebeOg3QX2xJlIYE+RkM/ejLkeKKL1228BdScimDJ1YU/aJU4x1l
         LxybKQEMYrCkfeX7ZhtWe6d7jjCCjl7CaX+W4bKCnqGTi1NKX24H/i/q30sESBePx8y3
         d9rllHxHUE2lkO1BeYd0MP1nOA1NjdwxHE5uNXkAejC6Flkc/HuvVgAxz/cYSVoMT54l
         FUyr+j/3T+5nbaKrG7sBKRzlBdj5ROksQIpvnQx1a6GRchQn/5DK9CnkF030xWMmbeF8
         /QqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=EwaUtjW05eztNq1hcyuxldE206s1lvSs488NYmfcjfA=;
        b=URqNKUExpuTTWSBsI9WTL1NToQjmPBYC7ZgiR+F7J9F4n3b8rIiYkMIcGGyHrEeJtQ
         MdSB9UITHl9p8to5R9cu4pu4nU+hZ9E4RPMNqPTxbzbVREp3/eJWwNdjYcUmvcSwvR/C
         +liAUgT+1lIFiieT0Qz0eQddBQajhe6zpw1o4Qq33uYHltoIIn4gHVYPSjuy3sRdu31O
         yz/UVc7BACDSoRIu+ZZ7gFdZdiAENhWKrbXRofEl6p1SOBUUO13bnZedw84dhjcJ+Bvm
         3o9ugMlvmHv5+5A/4wM8emRq95n9pIPU5QVZ6EhJLwVY4tVtKZqXjT/6zEJ4ZwBKgDls
         Mwkg==
X-Gm-Message-State: AOAM530GKpRLsflEME/0YOr+XmuMEas969wCDM3tJKz2jEvKpecwmLRy
        +V9VQpMizkJcTrSUdrnKpuPTmzzF2m4=
X-Google-Smtp-Source: ABdhPJwHM7FiuvXBpDX/+w6SzcI1206seQxxoiSAJ5at1zEnhzrLMdQzGqnbXs6eYs8OY85h14sGgg==
X-Received: by 2002:a1c:7918:: with SMTP id l24mr11690571wme.46.1600366322598;
        Thu, 17 Sep 2020 11:12:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u17sm576697wri.45.2020.09.17.11.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 11:12:02 -0700 (PDT)
Message-Id: <7a2a4e1e5278c7c94e0a6cfe1a1917724f826b0e.1600366313.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.695.v5.git.1600366313.gitgitgadget@gmail.com>
References: <pull.695.v4.git.1599224956.gitgitgadget@gmail.com>
        <pull.695.v5.git.1600366313.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 17 Sep 2020 18:11:51 +0000
Subject: [PATCH v5 10/11] maintenance: add auto condition for commit-graph
 task
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
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
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
index 13c24bca7d..4db853c561 100644
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

