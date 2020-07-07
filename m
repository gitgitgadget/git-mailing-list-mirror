Return-Path: <SRS0=WOg5=AS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 809B4C433E4
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 14:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E2FE2075B
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 14:21:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZVwzhNrN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728299AbgGGOVv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jul 2020 10:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728197AbgGGOVq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jul 2020 10:21:46 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D8BAC08C5E1
        for <git@vger.kernel.org>; Tue,  7 Jul 2020 07:21:46 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id s10so45291020wrw.12
        for <git@vger.kernel.org>; Tue, 07 Jul 2020 07:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8bUJwsqtBVIzso6QN6Sit2UclTlp04ZrfWwmdZv94Vg=;
        b=ZVwzhNrNRoMR8PAlWb/tWfD68VP6lAr57A2MRh4nVu3dVYkyEaQ6LW3wAdRjfVjt9j
         Mmw6khb3G2WA36ll4Mg+k2/++tjU+CPPDHFLiLpNXqvZWfj/35ZKMaPmRjFggPuvz6hu
         FXeM6DTb2TNuUsVZDleamxPTnUiXKCSekawnaxyfKFZ6ndXRfSoVgPTtyPnrvSiz6qpn
         Wh5K5ihzF4UjrjSFefUBkYWKrQxY2K1Mp861sqqAq4kk/7JQSPyjaFUb8b8Arouflbgb
         uc8pVjLLNV7jyoDzhHd4Lx1Ye9Dt42SHiUGnAnJZOyhyQuSlP2DuSARm3MRxmBQJh2h6
         1kmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8bUJwsqtBVIzso6QN6Sit2UclTlp04ZrfWwmdZv94Vg=;
        b=nwR0wmLAQNFsNJuMmtb5vWwFrgKDUeF/yg6kRWiHt0C1wUe5xWzHg/J6ws64anZXwV
         rxqVRp7bGo3Vnrbo+LAvYoAXDR2qSbAsgw2TXSEKkcWewiQk3ANiKq9seuW+UGjuQYQT
         JXXNh53npFQRQmrINaBnhMGFK4IeG5IA/YMVLL5SQV0hS0XbFHPPBnWSXaDBzuyaq8dZ
         5N8EscfiwcjZv1JnpVNKOuLlGcmLtYqIk3E5dpOyhef/rwwDlKoq9qs4o1MfHLTgpe0X
         Td1xHhJpTZa8nKywO4Ma0FhUqQHkAWwKSdey4eaYaAocjtaSLAaa9FWY5NvAI46X4Zpf
         LuBQ==
X-Gm-Message-State: AOAM531BJi3CwZcaS+OcGX4eJFhbwPW1C8agf4qHYvRy7fQyO9INW0Nr
        8QdHzCwYLdv//+/uZVpwpT+qadxB
X-Google-Smtp-Source: ABdhPJzBZM4y101P37lX28saRBcv906QV47JxHG3hKC9zqh6fb68Htk7SHvF+x6UknTWuqBWibhktg==
X-Received: by 2002:a5d:4845:: with SMTP id n5mr52927691wrs.353.1594131704835;
        Tue, 07 Jul 2020 07:21:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e5sm1177747wrs.33.2020.07.07.07.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 07:21:44 -0700 (PDT)
Message-Id: <c081a3bd293383da92041f0b8991e151303d9e56.1594131695.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.671.git.1594131695.gitgitgadget@gmail.com>
References: <pull.671.git.1594131695.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Jul 2020 14:21:24 +0000
Subject: [PATCH 10/21] maintenance: add --task option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        steadmon@google.com, jrnieder@gmail.com, peff@peff.net,
        congdanhqx@gmail.com, phillip.wood123@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

A user may want to only run certain maintenance tasks in a certain
order. Add the --task=<task> option, which allows a user to specify an
ordered list of tasks to run. These cannot be run multiple times,
however.

Here is where our array of maintenance_task pointers becomes critical.
We can sort the array of pointers based on the task order, but we do not
want to move the struct data itself in order to preserve the hashmap
references. We use the hashmap to match the --task=<task> arguments into
the task struct data.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-maintenance.txt |  4 ++
 builtin/gc.c                      | 62 ++++++++++++++++++++++++++++++-
 t/t7900-maintenance.sh            | 23 ++++++++++++
 3 files changed, 87 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-maintenance.txt b/Documentation/git-maintenance.txt
index 35b0be7d40..9204762e21 100644
--- a/Documentation/git-maintenance.txt
+++ b/Documentation/git-maintenance.txt
@@ -73,6 +73,10 @@ OPTIONS
 --quiet::
 	Do not report progress or other information over `stderr`.
 
+--task=<task>::
+	If this option is specified one or more times, then only run the
+	specified tasks in the specified order.
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/builtin/gc.c b/builtin/gc.c
index a6b080627f..8f2143862c 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -715,6 +715,7 @@ static const char * const builtin_maintenance_usage[] = {
 struct maintenance_opts {
 	int auto_flag;
 	int quiet;
+	int tasks_selected;
 } opts;
 
 static int run_write_commit_graph(struct repository *r)
@@ -812,7 +813,9 @@ struct maintenance_task {
 	struct hashmap_entry ent;
 	const char *name;
 	maintenance_task_fn *fn;
-	unsigned enabled:1;
+	int task_order;
+	unsigned enabled:1,
+		 selected:1;
 };
 
 static int task_entry_cmp(const void *unused_cmp_data,
@@ -833,14 +836,30 @@ struct maintenance_task *tasks[MAX_NUM_TASKS];
 int num_tasks;
 struct hashmap task_map;
 
+static int compare_tasks_by_selection(const void *a_, const void *b_)
+{
+	const struct maintenance_task *a, *b;
+	a = (const struct maintenance_task *)a_;
+	b = (const struct maintenance_task *)b_;
+
+	return b->task_order - a->task_order;
+}
+
 static int maintenance_run(struct repository *r)
 {
 	int i;
 	int result = 0;
 
+	if (opts.tasks_selected)
+		QSORT(tasks, num_tasks, compare_tasks_by_selection);
+
 	for (i = 0; !result && i < num_tasks; i++) {
-		if (!tasks[i]->enabled)
+		if (opts.tasks_selected && !tasks[i]->selected)
+			continue;
+
+		if (!opts.tasks_selected && !tasks[i]->enabled)
 			continue;
+
 		result = tasks[i]->fn(r);
 	}
 
@@ -873,6 +892,42 @@ static void initialize_tasks(void)
 	}
 }
 
+static int task_option_parse(const struct option *opt,
+			     const char *arg, int unset)
+{
+	struct maintenance_task *task;
+	struct maintenance_task key;
+
+	BUG_ON_OPT_NEG(unset);
+
+	if (!arg || !strlen(arg)) {
+		error(_("--task requires a value"));
+		return 1;
+	}
+
+	opts.tasks_selected++;
+
+	key.name = arg;
+	hashmap_entry_init(&key.ent, strihash(key.name));
+
+	task = hashmap_get_entry(&task_map, &key, ent, NULL);
+
+	if (!task) {
+		error(_("'%s' is not a valid task"), arg);
+		return 1;
+	}
+
+	if (task->selected) {
+		error(_("task '%s' cannot be selected multiple times"), arg);
+		return 1;
+	}
+
+	task->selected = 1;
+	task->task_order = opts.tasks_selected;
+
+	return 0;
+}
+
 int cmd_maintenance(int argc, const char **argv, const char *prefix)
 {
 	struct repository *r = the_repository;
@@ -882,6 +937,9 @@ int cmd_maintenance(int argc, const char **argv, const char *prefix)
 			 N_("run tasks based on the state of the repository")),
 		OPT_BOOL(0, "quiet", &opts.quiet,
 			 N_("do not report progress or other information over stderr")),
+		OPT_CALLBACK_F(0, "task", NULL, N_("task"),
+			N_("run a specific task"),
+			PARSE_OPT_NONEG, task_option_parse),
 		OPT_END()
 	};
 
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 216ac0b19e..c09a9eb90b 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -21,4 +21,27 @@ test_expect_success 'run [--auto|--quiet]' '
 	grep ",\"gc\",\"--quiet\"" run-quiet.txt
 '
 
+test_expect_success 'run --task=<task>' '
+	GIT_TRACE2_EVENT="$(pwd)/run-commit-graph.txt" git maintenance run --task=commit-graph &&
+	GIT_TRACE2_EVENT="$(pwd)/run-gc.txt" git maintenance run --task=gc &&
+	GIT_TRACE2_EVENT="$(pwd)/run-commit-graph.txt" git maintenance run --task=commit-graph &&
+	GIT_TRACE2_EVENT="$(pwd)/run-both.txt" git maintenance run --task=commit-graph --task=gc &&
+	! grep ",\"gc\"" run-commit-graph.txt  &&
+	grep ",\"gc\"" run-gc.txt  &&
+	grep ",\"gc\"" run-both.txt  &&
+	grep ",\"commit-graph\",\"write\"" run-commit-graph.txt  &&
+	! grep ",\"commit-graph\",\"write\"" run-gc.txt  &&
+	grep ",\"commit-graph\",\"write\"" run-both.txt
+'
+
+test_expect_success 'run --task=bogus' '
+	test_must_fail git maintenance run --task=bogus 2>err &&
+	test_i18ngrep "is not a valid task" err
+'
+
+test_expect_success 'run --task duplicate' '
+	test_must_fail git maintenance run --task=gc --task=gc 2>err &&
+	test_i18ngrep "cannot be selected multiple times" err
+'
+
 test_done
-- 
gitgitgadget

