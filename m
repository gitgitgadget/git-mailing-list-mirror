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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE0EC433E6
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 14:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A17B2075B
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 14:22:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jLCnzxHw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728397AbgGGOV4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jul 2020 10:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728190AbgGGOVx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jul 2020 10:21:53 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3CD7C08C5EF
        for <git@vger.kernel.org>; Tue,  7 Jul 2020 07:21:50 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id o2so46716064wmh.2
        for <git@vger.kernel.org>; Tue, 07 Jul 2020 07:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=pRRDyipEvsh8Afegz6QZN2GHPuGxUiZhTzU8v+g42Rg=;
        b=jLCnzxHwZ694IPT2f8mM1Rlnnu700+A0Mu5IwjXG9kZ079+Ka8Xtedkm6WKjBIS84N
         5hGRaWLs+zDsZfbBUo4xLq1SFvTZT7TRRRQ6U1OWyJCdTZbZM7rgvfhoKIAJfB2u56MT
         Dm/BYS3pAX15R+UQbkv/hnnJnvnTjxoQ3Q5cU7qMKQv2T6SSv1zY9DtFOfe4ER5pMFN/
         M6MVMEvcHk8hZt8D2hWo+q8Z9GkpIn/Ru7L3Q0QvgCBXtUenA8icQK8K0Mm0oL3C9yCB
         da7f+gLRIzMOzUqeDtes6VWAEC7VoatVR48UYv3MfZ/5YTEvcsWOo7buBHP2nnudyttf
         vPHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=pRRDyipEvsh8Afegz6QZN2GHPuGxUiZhTzU8v+g42Rg=;
        b=q7BS8GXyMw4mYWhbXmHtgWo/ge702C2tpJEAWLkuy4NuFjxGbQLktqbaJ7yvWvBWlV
         99CaazmvNCd9aWmkyNyg6LMAnDpoCzEidTaaeKH/jCxpIKOjj+pmP69zCNxp+z+uy4uM
         YIQvJ6rm9WpVtiD0zkmAcCTDeWZcGxc5jLqbXk+BpU6XkiWZUwoRwrwR1C6WWnnfbomR
         NN2QDoj7pVCDiAco13YRHuT9zBga1HaW584uFw430n2yfdpH6tABx8g6RZhPqb29/LCt
         5BiVqElhpMZARlgJj2uClYjUVpfdWxhk/pBiYwegTJsignIlwbzO5h50M3251oce0XZ9
         VF9g==
X-Gm-Message-State: AOAM531S1eOi1EeqE/AombginSBmhsy9gvFhZYi3S9GnOsVTsqDES1fv
        81gETKZuUfrdqCc7SsYonBerTSBi
X-Google-Smtp-Source: ABdhPJxNa4mjpVkxBGbTn00maHzkzicpxGhXmtqnGiu/lSJVlJDyiCMfUGMq/VH4TBXB33NdVxXrKg==
X-Received: by 2002:a1c:c90d:: with SMTP id f13mr4755138wmb.185.1594131709399;
        Tue, 07 Jul 2020 07:21:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f197sm1433790wme.33.2020.07.07.07.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 07:21:48 -0700 (PDT)
Message-Id: <1551aec4fd55b26601aa8673bee946c7ce7438a6.1594131695.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.671.git.1594131695.gitgitgadget@gmail.com>
References: <pull.671.git.1594131695.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Jul 2020 14:21:30 +0000
Subject: [PATCH 16/21] maintenance: create maintenance.<task>.enabled config
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

Currently, a normal run of "git maintenance run" will only run the 'gc'
task, as it is the only one enabled. This is mostly for backwards-
compatible reasons since "git maintenance run --auto" commands replaced
previous "git gc --auto" commands after some Git processes. Users could
manually run specific maintenance tasks by calling "git maintenance run
--task=<task>" directly.

Allow users to customize which steps are run automatically using config.
The 'maintenance.<task>.enabled' option then can turn on these other
tasks (or turn off the 'gc' task).

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/config.txt             |  2 ++
 Documentation/config/maintenance.txt |  4 ++++
 Documentation/git-maintenance.txt    |  6 +++++-
 builtin/gc.c                         | 15 +++++++++++++--
 t/t7900-maintenance.sh               | 12 ++++++++++++
 5 files changed, 36 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/config/maintenance.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index ef0768b91a..2783b825f9 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -396,6 +396,8 @@ include::config/mailinfo.txt[]
 
 include::config/mailmap.txt[]
 
+include::config/maintenance.txt[]
+
 include::config/man.txt[]
 
 include::config/merge.txt[]
diff --git a/Documentation/config/maintenance.txt b/Documentation/config/maintenance.txt
new file mode 100644
index 0000000000..370cbfb42f
--- /dev/null
+++ b/Documentation/config/maintenance.txt
@@ -0,0 +1,4 @@
+maintenance.<task>.enabled::
+	This boolean config option controls whether the maintenance task
+	with name `<task>` is run when no `--task` option is specified.
+	By default, only `maintenance.gc.enabled` is true.
diff --git a/Documentation/git-maintenance.txt b/Documentation/git-maintenance.txt
index 945fda368b..261d2e0ee1 100644
--- a/Documentation/git-maintenance.txt
+++ b/Documentation/git-maintenance.txt
@@ -30,7 +30,11 @@ SUBCOMMANDS
 -----------
 
 run::
-	Run one or more maintenance tasks.
+	Run one or more maintenance tasks. If one or more `--task` options
+	are specified, then those tasks are run in that order. Otherwise,
+	the tasks are determined by which `maintenance.<task>.enabled`
+	config options are true. By default, only `maintenance.gc.enabled`
+	is true.
 
 TASKS
 -----
diff --git a/builtin/gc.c b/builtin/gc.c
index 582219156a..6ffe2213b4 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1208,9 +1208,10 @@ static int maintenance_run(struct repository *r)
 	return result;
 }
 
-static void initialize_tasks(void)
+static void initialize_tasks(struct repository *r)
 {
 	int i;
+	struct strbuf config_name = STRBUF_INIT;
 	num_tasks = 0;
 
 	for (i = 0; i < MAX_NUM_TASKS; i++)
@@ -1240,10 +1241,20 @@ static void initialize_tasks(void)
 	hashmap_init(&task_map, task_entry_cmp, NULL, MAX_NUM_TASKS);
 
 	for (i = 0; i < num_tasks; i++) {
+		int config_value;
+
 		hashmap_entry_init(&tasks[i]->ent,
 				   strihash(tasks[i]->name));
 		hashmap_add(&task_map, &tasks[i]->ent);
+
+		strbuf_setlen(&config_name, 0);
+		strbuf_addf(&config_name, "maintenance.%s.enabled", tasks[i]->name);
+
+		if (!repo_config_get_bool(r, config_name.buf, &config_value))
+			tasks[i]->enabled = config_value;
 	}
+
+	strbuf_release(&config_name);
 }
 
 static int task_option_parse(const struct option *opt,
@@ -1304,7 +1315,7 @@ int cmd_maintenance(int argc, const char **argv, const char *prefix)
 				   builtin_maintenance_options);
 
 	opts.quiet = !isatty(2);
-	initialize_tasks();
+	initialize_tasks(r);
 
 	argc = parse_options(argc, argv, prefix,
 			     builtin_maintenance_options,
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 43d32c131b..08aa50a724 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -21,6 +21,18 @@ test_expect_success 'run [--auto|--quiet]' '
 	grep ",\"gc\",\"--quiet\"" run-quiet.txt
 '
 
+test_expect_success 'maintenance.<task>.enabled' '
+	git config maintenance.gc.enabled false &&
+	git config maintenance.commit-graph.enabled true &&
+	git config maintenance.loose-objects.enabled true &&
+	GIT_TRACE2_EVENT="$(pwd)/run-config.txt" git maintenance run &&
+	! grep ",\"fetch\"" run-config.txt &&
+	! grep ",\"gc\"" run-config.txt &&
+	! grep ",\"multi-pack-index\"" run-config.txt &&
+	grep ",\"commit-graph\"" run-config.txt &&
+	grep ",\"prune-packed\"" run-config.txt
+'
+
 test_expect_success 'run --task=<task>' '
 	GIT_TRACE2_EVENT="$(pwd)/run-commit-graph.txt" git maintenance run --task=commit-graph &&
 	GIT_TRACE2_EVENT="$(pwd)/run-gc.txt" git maintenance run --task=gc &&
-- 
gitgitgadget

