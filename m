Return-Path: <SRS0=bfGv=CG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C20C433E2
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 15:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B92C20678
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 15:45:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G6iyo8tk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728335AbgH1Ppu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Aug 2020 11:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728267AbgH1Ppf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Aug 2020 11:45:35 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B744FC061236
        for <git@vger.kernel.org>; Fri, 28 Aug 2020 08:45:25 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id c19so1072679wmd.1
        for <git@vger.kernel.org>; Fri, 28 Aug 2020 08:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=t13EbWJeubyTEm19LcAgWKvrkpEFAPWkjSKqbw4gHQE=;
        b=G6iyo8tkrJcuE4ISzalx3ojtsg8tkWlUPpfA0qV7oHaMhO+3YOrcpCWXdE+RftE6Mg
         +KISiHvZSc48S8dW+hmYSyx47i/MnrsWlEo9kNqfbgZAgMAY9Ml0mqfaHjdS+WxwpoG2
         bFtmOm70UdJjro5uxByYXRUcaZWCE2O8rsq5g7EtWj28N7GYnk4DFRn4ZEsx2jqe6FoH
         64VBxPMWu+hLQZN8Eo11uXN69FSWYcOgs04hs1KAsfmJm0YfrJ96RnKij2Ni75qVEafm
         FSPa8Y0g0vT0sHSLVMiEcuWvSjKVVfDL/JFyG6RuESDfgYTQvUAQBYRH3BX3XRP/5OY2
         scEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=t13EbWJeubyTEm19LcAgWKvrkpEFAPWkjSKqbw4gHQE=;
        b=WI7ESevmczorSQBhPHE49q1OcfaeKxt5x18ioKUIxbiwqhbUZmdSDK0GtGcuxAq/GN
         Ci2hL4/ed11bIEOT9Q+8X3NdUU8A54QxGLwIQk+mJxlLWHUGDOR0gsT08BiE/PXeQYsU
         fNH6Vz4TXbNgeHwWPkqTiPpumd1hoffuemLRd255TrMMvEdq0XKiqvyAukKpYaCqpbjF
         mnPytoSGBw0Ikk7zvUmMYceluWB1eyO6JdHNEuoEObEvP66HJaCzs44Tp2MZalh3xqYJ
         fW+1W/ylFi2hGaoVPm7DyLawfSju9mUHM8S0UTeol4mZzhH/lXB/tXtXSGpwvhVW4pAv
         iXPw==
X-Gm-Message-State: AOAM532tkF/Z2ELY6Bc3UVMLjnNaDLxnHF3Lmlnw9hToh275Vryq/NgH
        siwz0o1Y2IsWqzp2k49hXQ/P/HjUVCU=
X-Google-Smtp-Source: ABdhPJwFovzorOd4vHJsVkRgmDS0/lWGpHPz+jwnufeSy/VZQPtcc9CiJFxC30GnnDNjm50yX2gwXg==
X-Received: by 2002:a05:600c:10cf:: with SMTP id l15mr2240991wmd.149.1598629524046;
        Fri, 28 Aug 2020 08:45:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o5sm2707641wmc.33.2020.08.28.08.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 08:45:23 -0700 (PDT)
Message-Id: <62e8db8b2a8674fb40681478cbae8bbbd6936661.1598629517.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.680.v3.git.1598629517.gitgitgadget@gmail.com>
References: <pull.680.v2.git.1598380805.gitgitgadget@gmail.com>
        <pull.680.v3.git.1598629517.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 28 Aug 2020 15:45:17 +0000
Subject: [PATCH v3 6/6] maintenance: recommended schedule in register/start
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
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

Author's Note: I feel we should do _something_ to recommend a good
schedule to users, but I'm not 100% set on this schedule. This is the
schedule we use in Scalar and VFS for Git for very large repositories
using the GVFS protocol. While the schedule works in that environment,
it is possible that "normal" Git repositories could benefit from
something more obvious (such as running 'gc' weekly). However, this
patch gives us a place to start a conversation on what we should
recommend. For my purposes, Scalar will set these config values so we
can always differ from core Git's recommendations.

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
index 9914417e25..5f253d3458 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1408,6 +1408,49 @@ static int maintenance_run(int argc, const char **argv, const char *prefix)
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
@@ -1417,6 +1460,9 @@ static int maintenance_register(void)
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
