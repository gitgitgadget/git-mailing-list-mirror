Return-Path: <SRS0=AzkS=BC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0604C433E4
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 17:57:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DF24206E3
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 17:57:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gi0lZOrF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730272AbgGWR5D (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jul 2020 13:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730222AbgGWR4z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jul 2020 13:56:55 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B57CBC0619DC
        for <git@vger.kernel.org>; Thu, 23 Jul 2020 10:56:54 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id 184so6019236wmb.0
        for <git@vger.kernel.org>; Thu, 23 Jul 2020 10:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=geCGmK1+y9ASuRDRnml2TDhrv4AHYRy13S19WWdthj4=;
        b=Gi0lZOrFfCbHWptN3Yu/2cbFmEwSoOTrUeBFgL5J7kQJFqjxppJExCY1Rz4pmIQbnG
         xqUvvirpAW82FPeI209kbEoGVgmvkLhKxGxw+ZLt5vbmEdwlq3RBOrDLjNlBEEdnYfIl
         dtxnzcthcFfuXRVTGy+kQso6hAm4GmOban1X3GaX7JKGm2VYlItGmG9wUDfcMeYgiEJe
         /h0rt0Y9hXM2mAl8VtDcRNgOMlm502PiZPzSb4POtYvnlhTbWakG7HNxAlt1EGgvJsSI
         pO9dvabWPYv/gvp5vhWOoh07XIbadT0nZHZS1e0P68P3DBHb4yMhn33sFH0hWddbwViA
         ov9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=geCGmK1+y9ASuRDRnml2TDhrv4AHYRy13S19WWdthj4=;
        b=DnOMZQvHqnvr5bn+Gn/eqsqSdwPgSdInJFGfry5VFZKEtFfHQtDYr1byi0PU/O9xJp
         3cB2Vms5heKnYH344LCpfOBCLHytciZzdSK8EoNTVVRZxSTnRA1EMnMNwy9BP9ARQwWS
         3RfP4PBs/98aKR9PRSeGIxlBX9uJp4M0dmTvlraq35VxQKKTfWk/Km0+dea8qPCupzKa
         dISwRdHHaw3qbgEUst9mu+oQRlKdrXWxApAtiSBxbmmwFSmx6thzcHY92JHcLzq4DzT3
         HENZbc+Qg9PXNwLsbWkUpetnSYrohQlgci4jwX86ApXfye+0evVGsqvBVDf1ORAAuVik
         JnZw==
X-Gm-Message-State: AOAM530olWHiEzpERbbZaJKjp4qNcVVspvqIcOoEvkpyx7A8/QD/hyxp
        0cFi2uD71UGMpoNIqg3vuIGNhM5k
X-Google-Smtp-Source: ABdhPJyoyJRi8GaUt8Qo7dGWxNlmRHDnVneXzfRBTr+a5OpiwRiIhp/41bwlFdvy38NDi+goD3xnGA==
X-Received: by 2002:a1c:ac81:: with SMTP id v123mr4939711wme.159.1595527013224;
        Thu, 23 Jul 2020 10:56:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u10sm4114790wml.29.2020.07.23.10.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 10:56:52 -0700 (PDT)
Message-Id: <a3c64930a0947315f2ee512f9b1a11b806f00186.1595527000.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.671.v2.git.1595527000.gitgitgadget@gmail.com>
References: <pull.671.git.1594131695.gitgitgadget@gmail.com>
        <pull.671.v2.git.1595527000.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 23 Jul 2020 17:56:34 +0000
Subject: [PATCH v2 12/18] maintenance: create maintenance.<task>.enabled
 config
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        steadmon@google.com, jrnieder@gmail.com, peff@peff.net,
        congdanhqx@gmail.com, phillip.wood123@gmail.com,
        emilyshaffer@google.com, sluongng@gmail.com,
        jonathantanmy@google.com,
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
 builtin/gc.c                         | 13 +++++++++++++
 t/t7900-maintenance.sh               | 12 ++++++++++++
 5 files changed, 36 insertions(+), 1 deletion(-)
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
index bda8df4aaa..4a61441bbc 100644
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
index 889d97afe7..b6dc4b1832 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1185,6 +1185,7 @@ static int maintenance_run(void)
 static void initialize_tasks(void)
 {
 	int i;
+	struct strbuf config_name = STRBUF_INIT;
 	num_tasks = 0;
 
 	for (i = 0; i < MAX_NUM_TASKS; i++)
@@ -1210,6 +1211,18 @@ static void initialize_tasks(void)
 	tasks[num_tasks]->name = "commit-graph";
 	tasks[num_tasks]->fn = maintenance_task_commit_graph;
 	num_tasks++;
+
+	for (i = 0; i < num_tasks; i++) {
+		int config_value;
+
+		strbuf_setlen(&config_name, 0);
+		strbuf_addf(&config_name, "maintenance.%s.enabled", tasks[i]->name);
+
+		if (!git_config_get_bool(config_name.buf, &config_value))
+			tasks[i]->enabled = config_value;
+	}
+
+	strbuf_release(&config_name);
 }
 
 static int task_option_parse(const struct option *opt,
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index ab5c961eb9..3ee51723e0 100755
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

