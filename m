Return-Path: <SRS0=G1/z=CD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2913DC433E3
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 18:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12D712074D
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 18:34:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IcNynvpC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbgHYSeX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Aug 2020 14:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726429AbgHYSd6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Aug 2020 14:33:58 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A981FC061786
        for <git@vger.kernel.org>; Tue, 25 Aug 2020 11:33:57 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id 2so2663136wrj.10
        for <git@vger.kernel.org>; Tue, 25 Aug 2020 11:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=vK6iK0+RvphJs0HeXxn440+72BWzbhU3tPC7lZ3S1Hw=;
        b=IcNynvpCeH0xX9Gr6zDB5almb5EcDBrkt9TcsRoWJ5kuBgM+vslTwXSkgdDvFf/AMa
         kSi4QAqdHYBkAwwiOlXJO6K6un8DhWtfOgUazjKjtFzc3693BkdFfbt0NqSAMABzzNNE
         CHfWyrEHbyKTR6FFIn2JBMulGTbqtIFSN5gV92XWTNVhUWEgfjJiKcUdi5rcgdnsAROh
         +ET32I2IDYMcJ4vHAHlrUJGbD71oGr6AwYySDA75ye+4uX/gyNKW7FufFFMTss3WCKMd
         QbeC1xWMHvCnXnxuUQUL4RgBLWwMY/ruQ2+NfHGLE7VMxUGT4s91hL0rHVwiKVb3KO+h
         miZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=vK6iK0+RvphJs0HeXxn440+72BWzbhU3tPC7lZ3S1Hw=;
        b=gAAYLw/X+WpEKbeKgGVdERVWU4ZWurLFAr7mcbY2DD+RcLAekomJDhEDog3grmstoR
         /SlUzDXDudUqI3k4/LcEZFZ+YxJyfjw6loqQRFHTy+LxzMfyKUffwnwCaWl7jUplDhps
         AFaHZ4a22zqWh5Eo6P+mcLPREs32xLh0ehSgTqzXJL7Gx11oZQ06z9/yxL6fKfXjYPA/
         H6jiI9VpxOYRTUeFvH+QvYMmTa7IQnYQlYThQun1nSaFNuHuThXnSxNKmjennmH/f4cu
         lsVexEoYyEht+AQ8+PjHbc5pERH8CJ3m7d1wyO8TbgH3RQUsAKSoTCKtCUNC9AKJUiAP
         D+AQ==
X-Gm-Message-State: AOAM531mvkG41nTFsAWEt3Jb18LWNj3p6XmX1P2ZV/7+W8bi2u6+5kVc
        hJpDxa3bp3eQ9Txdaip1k6fw2JLc0C0=
X-Google-Smtp-Source: ABdhPJzjFxcRgwpHAekJ+6B14zqK4Rz/oTVCw2TtNDy/+TmH96CDBuWvUXnEFYbImlb6VbmlATDARw==
X-Received: by 2002:a05:6000:12c1:: with SMTP id l1mr11301403wrx.270.1598380436120;
        Tue, 25 Aug 2020 11:33:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h7sm7578222wmf.43.2020.08.25.11.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 11:33:55 -0700 (PDT)
Message-Id: <712f5f2d8ec3548c152c20b50b75a58b773ce3f4.1598380427.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.695.v3.git.1598380426.gitgitgadget@gmail.com>
References: <pull.695.v2.git.1597760589.gitgitgadget@gmail.com>
        <pull.695.v3.git.1598380426.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 25 Aug 2020 18:33:43 +0000
Subject: [PATCH v3 08/11] maintenance: create maintenance.<task>.enabled
 config
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
 Documentation/config/maintenance.txt |  6 ++++++
 Documentation/git-maintenance.txt    | 14 +++++++++-----
 builtin/gc.c                         | 19 +++++++++++++++++++
 t/t7900-maintenance.sh               |  8 ++++++++
 5 files changed, 44 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/config/maintenance.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 3042d80978..f93b6837e4 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -398,6 +398,8 @@ include::config/mailinfo.txt[]
 
 include::config/mailmap.txt[]
 
+include::config/maintenance.txt[]
+
 include::config/man.txt[]
 
 include::config/merge.txt[]
diff --git a/Documentation/config/maintenance.txt b/Documentation/config/maintenance.txt
new file mode 100644
index 0000000000..4402b8b49f
--- /dev/null
+++ b/Documentation/config/maintenance.txt
@@ -0,0 +1,6 @@
+maintenance.<task>.enabled::
+	This boolean config option controls whether the maintenance task
+	with name `<task>` is run when no `--task` option is specified to
+	`git maintenance run`. These config values are ignored if a
+	`--task` option exists. By default, only `maintenance.gc.enabled`
+	is true.
diff --git a/Documentation/git-maintenance.txt b/Documentation/git-maintenance.txt
index 819ca41ab6..6abcb8255a 100644
--- a/Documentation/git-maintenance.txt
+++ b/Documentation/git-maintenance.txt
@@ -30,9 +30,11 @@ SUBCOMMANDS
 -----------
 
 run::
-	Run one or more maintenance tasks. If one or more `--task=<task>`
-	options are specified, then those tasks are run in the provided
-	order. Otherwise, only the `gc` task is run.
+	Run one or more maintenance tasks. If one or more `--task` options
+	are specified, then those tasks are run in that order. Otherwise,
+	the tasks are determined by which `maintenance.<task>.enabled`
+	config options are true. By default, only `maintenance.gc.enabled`
+	is true.
 
 TASKS
 -----
@@ -67,8 +69,10 @@ OPTIONS
 
 --task=<task>::
 	If this option is specified one or more times, then only run the
-	specified tasks in the specified order. See the 'TASKS' section
-	for the list of accepted `<task>` values.
+	specified tasks in the specified order. If no `--task=<task>`
+	arguments are specified, then only the tasks with
+	`maintenance.<task>.enabled` configured as `true` are considered.
+	See the 'TASKS' section for the list of accepted `<task>` values.
 
 GIT
 ---
diff --git a/builtin/gc.c b/builtin/gc.c
index 1cebb7282d..67a8d405a1 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -841,6 +841,24 @@ static int maintenance_run_tasks(struct maintenance_run_opts *opts)
 	return result;
 }
 
+static void initialize_task_config(void)
+{
+	int i;
+	struct strbuf config_name = STRBUF_INIT;
+	for (i = 0; i < TASK__COUNT; i++) {
+		int config_value;
+
+		strbuf_setlen(&config_name, 0);
+		strbuf_addf(&config_name, "maintenance.%s.enabled",
+			    tasks[i].name);
+
+		if (!git_config_get_bool(config_name.buf, &config_value))
+			tasks[i].enabled = config_value;
+	}
+
+	strbuf_release(&config_name);
+}
+
 static int task_option_parse(const struct option *opt,
 			     const char *arg, int unset)
 {
@@ -889,6 +907,7 @@ static int maintenance_run(int argc, const char **argv, const char *prefix)
 	memset(&opts, 0, sizeof(opts));
 
 	opts.quiet = !isatty(2);
+	initialize_task_config();
 
 	for (i = 0; i < TASK__COUNT; i++)
 		tasks[i].selected_order = -1;
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 792765aff7..290abb7832 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -25,6 +25,14 @@ test_expect_success 'run [--auto|--quiet]' '
 	test_subcommand git gc --no-quiet <run-no-quiet.txt
 '
 
+test_expect_success 'maintenance.<task>.enabled' '
+	git config maintenance.gc.enabled false &&
+	git config maintenance.commit-graph.enabled true &&
+	GIT_TRACE2_EVENT="$(pwd)/run-config.txt" git maintenance run 2>err &&
+	test_subcommand ! git gc --quiet <run-config.txt &&
+	test_subcommand git commit-graph write --split --reachable --no-progress <run-config.txt
+'
+
 test_expect_success 'run --task=<task>' '
 	GIT_TRACE2_EVENT="$(pwd)/run-commit-graph.txt" \
 		git maintenance run --task=commit-graph 2>/dev/null &&
-- 
gitgitgadget

