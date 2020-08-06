Return-Path: <SRS0=sa20=BQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EA0CC433DF
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 16:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7062823117
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 16:27:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rky2w6co"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728255AbgHFQ1s (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Aug 2020 12:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727115AbgHFQSr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Aug 2020 12:18:47 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB2BC002146
        for <git@vger.kernel.org>; Thu,  6 Aug 2020 08:48:52 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id a5so34506705wrm.6
        for <git@vger.kernel.org>; Thu, 06 Aug 2020 08:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=lCIavgK26TxWY6o7Jx/OsmHH6/0nLwidyNPcYgO+hw8=;
        b=Rky2w6co/0XqDC4inCbBZu3uGTS6Pbgo+L6Ro0Cx94qPBPlza6nVzikiX8dyL6S4uM
         yTyYfr00woBWjwtWahV2b8I2/xnLCE777LgVZn4Vio4LkpD+H/jjSGrnwwX6ZHfARgJe
         0npi00Tk2EnI27+RrPAqKywVJoT6nTTYpe+tmI0kAl9K0dG6UitibgbtrQWTh6q5K6mK
         udc28+pXUk7VuXtwPjp4mfp5AsU3a8KY6SDUJKbW2GrSsYnDmjP5ppgNrV7H+rPggsP6
         gFV9ReCbpY1ektwxwCR6uIJm2OlHERGrS8WOPK5bHF+C04NFNBiBd2dwjMrYhI8/S+XR
         a0uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=lCIavgK26TxWY6o7Jx/OsmHH6/0nLwidyNPcYgO+hw8=;
        b=ZRWvf4KF53yYzVFM5t/zml3EEnUxPgUvrHgOXcT1wqTKffstdO32Di/ZFXFXUdQ0ae
         4StQksR438/PIY8XhZrC6qfxk5XVLN2FAigqDVxha3Gdwd1kV2A8V9+fP0yBefRMNhzW
         qzMvF1+3QIfVx6vNgbLk/GvQY65SandYNxIQIYk17mp64M6GeYdyzsdGb9rZI/5b5Drz
         CkaNP5rxdpfKD+yV/dIqUo2pi4/y6iiO1bsWQP375LBRXXtfDW0pkFilfGiGIBK7fjO1
         TgHg9P1tCAcc2prCZwEFH7CnVrDOgASifghPE+jtxAw1QCK3gnnpg9awayYmJ5r1YHMd
         ONOQ==
X-Gm-Message-State: AOAM530E8B/68/UJPhAbjTF+hXD6k4W5+R2zSUq/obRI4v5ZPsFK7lfb
        KI6lBcpw//JVKgyIcgTEU+RK2rKv
X-Google-Smtp-Source: ABdhPJyyIbXkRJuakIECYrDWBnI+Y08Cpvolc+MdUoB6Oil5HDhIG1D+273VLxtqV/eCauJjiZlThw==
X-Received: by 2002:a5d:5712:: with SMTP id a18mr7857534wrv.184.1596728930753;
        Thu, 06 Aug 2020 08:48:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 3sm6672146wms.36.2020.08.06.08.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 08:48:50 -0700 (PDT)
Message-Id: <69bfc6a4b2bb1a86788e69a2a3ac6134085aa798.1596728921.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.695.git.1596728921.gitgitgadget@gmail.com>
References: <pull.695.git.1596728921.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 06 Aug 2020 15:48:38 +0000
Subject: [PATCH 08/11] maintenance: create maintenance.<task>.enabled config
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
 Documentation/config/maintenance.txt |  4 ++++
 Documentation/git-maintenance.txt    |  8 +++++---
 builtin/gc.c                         | 19 +++++++++++++++++++
 t/t7900-maintenance.sh               |  8 ++++++++
 5 files changed, 38 insertions(+), 3 deletions(-)
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
index 5911213c9c..e1a2a8902c 100644
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
diff --git a/builtin/gc.c b/builtin/gc.c
index 1b7d502b87..dc1d260858 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -873,6 +873,24 @@ static int maintenance_run(struct maintenance_opts *opts)
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
@@ -925,6 +943,7 @@ int cmd_maintenance(int argc, const char **argv, const char *prefix)
 				   builtin_maintenance_options);
 
 	opts.quiet = !isatty(2);
+	initialize_task_config();
 
 	argc = parse_options(argc, argv, prefix,
 			     builtin_maintenance_options,
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index bcc7131818..cdf0bf2e60 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -23,6 +23,14 @@ test_expect_success 'run [--auto|--quiet]' '
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

