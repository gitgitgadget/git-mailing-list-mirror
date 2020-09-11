Return-Path: <SRS0=PYw/=CU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE3EC433E2
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 17:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4E0321D79
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 17:50:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cmkn/7GS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725856AbgIKRtx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Sep 2020 13:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbgIKRt3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Sep 2020 13:49:29 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DCB2C061796
        for <git@vger.kernel.org>; Fri, 11 Sep 2020 10:49:28 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id w5so12274913wrp.8
        for <git@vger.kernel.org>; Fri, 11 Sep 2020 10:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qmglJAGHC8EFypg6S2TILXjGQLzpcI22lHncL56C9Xs=;
        b=cmkn/7GSr8XqIV3yQymozgo2o/qhzEk2ub+fMdr7NXtXbWopij9pdV9dbB97KHje15
         d67Bi77rSVu1CI3sXdWvFgisQaR1yj/om5bg6mTBjyazu9jWRoUswyLUEzHVhCxCjHE6
         OOp0O+zUutEHZOk450Lc6wDieRfdTApsVOqTra3dDPCrM5HorKoIw0LEvgI46NEYR4dS
         66tmQUjNvHuzwZOKGXw6EzoxEkEIgOmi+lJfWtjlTxejMO55BoMyozagjctMrTRYxK63
         rgCiF69HIiFA5MKfSAwKFCx22gQ2zTTE7SXtinkarGnIuVZAnrr2IwhIEsLPyNzI/oAU
         5PZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=qmglJAGHC8EFypg6S2TILXjGQLzpcI22lHncL56C9Xs=;
        b=aNSon1nxZfdB4QeG2tS79zkszDTINHY5mHCzhN7LvqyYfc5Ua2bS25JRWVA3BudF1c
         Lhb7lLTc3WHNDgW3tTzPvZNQQ/H5DuZrR5xfVurKlxUC7Lz00T4xK8w2V13AAuir168k
         FYnn8TEkLAcXDc6X0IuUkqGaS9hTXexpANo4qcwysqOLpUSqMvmSLZodqtkbjLx/kh3K
         pNNnm26FEITYN3XTtLRSWRxdYQrDiHVfZR/My5qLk75vw7irxzPLRchb6Fzze/2ED682
         mlp8IzdmaIrWHiIkQiGGdbJwrjmyzVCPWluRDDpm/r7zGjOWSg3kaQKX6mp2vjHukMEq
         NUDQ==
X-Gm-Message-State: AOAM530Xwb7LXtsW+y3ux00itKQwFa3+JaRre8mN3YLILgVSadOEXzY3
        /LqLMHu0wG7vHlO/MeVM7vP0q9NY7rs=
X-Google-Smtp-Source: ABdhPJzPdHujEuzC2jLiv7srMXpjVmN9lbtYOr8t82SpSytH0/OAje9w4GuDdKewyQwKXkZx+ilArg==
X-Received: by 2002:adf:fd8d:: with SMTP id d13mr3255263wrr.104.1599846567160;
        Fri, 11 Sep 2020 10:49:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z13sm5687846wro.97.2020.09.11.10.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 10:49:26 -0700 (PDT)
Message-Id: <f609c1bde27558db2a9601ac34f8a51ce86f0e2c.1599846561.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.724.v2.git.1599846560.gitgitgadget@gmail.com>
References: <pull.724.git.1599234126.gitgitgadget@gmail.com>
        <pull.724.v2.git.1599846560.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 11 Sep 2020 17:49:19 +0000
Subject: [PATCH v2 6/7] maintenance: recommended schedule in register/start
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jrnieder@gmail.com, jonathantanmy@google.com, sluongng@gmail.com,
        congdanhqx@gmail.com,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The 'git maintenance (register|start)' subcommands add the current
repository to the global Git config so maintenance will operate on that
repository. It does not specify what maintenance should occur or how
often.

If a user sets any 'maintenance.<task>.schedule' config value, then
they have chosen a specific schedule for themselves and Git should
respect that.

However, in an effort to recommend a good schedule for repositories of
all sizes, set new config values for recommended tasks that are safe to
run in the background while users run foreground Git commands. These
commands are generally everything but the 'gc' task.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-maintenance.txt |  6 ++++
 builtin/gc.c                      | 46 +++++++++++++++++++++++++++++++
 t/t7900-maintenance.sh            | 16 +++++++++++
 3 files changed, 68 insertions(+)

diff --git a/Documentation/git-maintenance.txt b/Documentation/git-maintenance.txt
index 7f8c279fe8..364b3e32bf 100644
--- a/Documentation/git-maintenance.txt
+++ b/Documentation/git-maintenance.txt
@@ -37,6 +37,12 @@ register::
 	`maintenance.<task>.schedule`. The tasks that are enabled are safe
 	for running in the background without disrupting foreground
 	processes.
++
+If your repository has no 'maintenance.<task>.schedule' configuration
+values set, then Git will set configuration values to some recommended
+settings. These settings disable foreground maintenance while performing
+maintenance tasks in the background that will not interrupt foreground Git
+operations.
 
 run::
 	Run one or more maintenance tasks. If one or more `--task` options
diff --git a/builtin/gc.c b/builtin/gc.c
index 4f2d17c0c0..2ef4c0960c 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1409,6 +1409,49 @@ static int maintenance_run(int argc, const char **argv, const char *prefix)
 	return maintenance_run_tasks(&opts);
 }
 
+static int has_schedule_config(void)
+{
+	int i, found = 0;
+	struct strbuf config_name = STRBUF_INIT;
+	size_t prefix;
+
+	strbuf_addstr(&config_name, "maintenance.");
+	prefix = config_name.len;
+
+	for (i = 0; !found && i < TASK__COUNT; i++) {
+		char *value;
+
+		strbuf_setlen(&config_name, prefix);
+		strbuf_addf(&config_name, "%s.schedule", tasks[i].name);
+
+		if (!git_config_get_string(config_name.buf, &value)) {
+			found = 1;
+			FREE_AND_NULL(value);
+		}
+	}
+
+	strbuf_release(&config_name);
+	return found;
+}
+
+static void set_recommended_schedule(void)
+{
+	git_config_set("maintenance.auto", "false");
+	git_config_set("maintenance.gc.enabled", "false");
+
+	git_config_set("maintenance.prefetch.enabled", "true");
+	git_config_set("maintenance.prefetch.schedule", "hourly");
+
+	git_config_set("maintenance.commit-graph.enabled", "true");
+	git_config_set("maintenance.commit-graph.schedule", "hourly");
+
+	git_config_set("maintenance.loose-objects.enabled", "true");
+	git_config_set("maintenance.loose-objects.schedule", "daily");
+
+	git_config_set("maintenance.incremental-repack.enabled", "true");
+	git_config_set("maintenance.incremental-repack.schedule", "daily");
+}
+
 static int maintenance_register(void)
 {
 	struct child_process config_set = CHILD_PROCESS_INIT;
@@ -1418,6 +1461,9 @@ static int maintenance_register(void)
 	if (!the_repository || !the_repository->gitdir)
 		return 0;
 
+	if (!has_schedule_config())
+		set_recommended_schedule();
+
 	config_get.git_cmd = 1;
 	strvec_pushl(&config_get.args, "config", "--global", "--get", "maintenance.repo",
 		     the_repository->worktree ? the_repository->worktree
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 8803fcf621..5a31f3925b 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -309,7 +309,23 @@ test_expect_success 'register and unregister' '
 	git config --global --add maintenance.repo /existing1 &&
 	git config --global --add maintenance.repo /existing2 &&
 	git config --global --get-all maintenance.repo >before &&
+
+	# We still have maintenance.<task>.schedule config set,
+	# so this does not update the local schedule
+	git maintenance register &&
+	test_must_fail git config maintenance.auto &&
+
+	# Clear previous maintenance.<task>.schedule values
+	for task in loose-objects commit-graph incremental-repack
+	do
+		git config --unset maintenance.$task.schedule || return 1
+	done &&
 	git maintenance register &&
+	test_cmp_config false maintenance.auto &&
+	test_cmp_config false maintenance.gc.enabled &&
+	test_cmp_config true maintenance.prefetch.enabled &&
+	test_cmp_config hourly maintenance.commit-graph.schedule &&
+	test_cmp_config daily maintenance.incremental-repack.schedule &&
 	git config --global --get-all maintenance.repo >actual &&
 	cp before after &&
 	pwd >>after &&
-- 
gitgitgadget

