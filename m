Return-Path: <SRS0=G1/z=CD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D65C433E4
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 18:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CAC32071E
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 18:40:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z48YzOCW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgHYSkb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Aug 2020 14:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726759AbgHYSkO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Aug 2020 14:40:14 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3D5C061755
        for <git@vger.kernel.org>; Tue, 25 Aug 2020 11:40:13 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id c19so1685536wmd.1
        for <git@vger.kernel.org>; Tue, 25 Aug 2020 11:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=zei/QNl/f24ejb0jKsnwgS7KGDd4U08Mr0i0BWWzX+w=;
        b=Z48YzOCWW8TVOpz+gslLOu/UZBVZa17hTcW8ktscRu+bI5/cDGRGQmzHQ871KDPqXh
         JFgAtSaFAORHenesRhOzgxy4OLkm181ISRTQcg679ZQ2XYLLJJR5fIvbfnDjOgbcoIUe
         HJdP0XgQGrSWkIPcGLx0Zwltm56Z3jZw9u0VoUIZ5igc/s/wM+RUUgkO14XabPMVA+yY
         p/KRXr6gVDLtK64ARkLq1UWW3hCFzGADhJl8XN7roGEYX8R4URB9Boggl9lU4waPLoqd
         k9HqfdH0Gj5KzeKJHO+taZHWqGQqZGaZdBtbyYwUk5lYSV5kceTJ1PoOBlvA6WTzjgFf
         x+tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=zei/QNl/f24ejb0jKsnwgS7KGDd4U08Mr0i0BWWzX+w=;
        b=VIv0dFWtOCQLW8YWMcWTf5ucpH7XNGkeCc+gr6s3jgmYfEhkUzLfpWeSpPYcPpKHqy
         21n+7LfLxCBXcjuoYVdEIbalc9PRnpUdm6QEcvXvzoZrqRY6WtwZel0pQBWA7AtjJFxN
         KzbxkOY8TrhMAWq9QVzdyKjcHICNIJKnAlpboQalTl4gnEUj44KRc3ijb0ojKuvP8urx
         7zcMLBRPCSmdLJrdNEycVRrH3fmZIXidoHh6V2kiPvDM7A5inR9eoqOpIOULmd0QbkRy
         AuKMNQMi29r+LdWRSGE1z80nq/LiPTs59Cn0fd7n2vIuiuihL6zdHG50N9z3CW30+vJy
         U23A==
X-Gm-Message-State: AOAM533YaJNL8S78atKmcoIJnR0n/pULknZxiFMnbZxiwl1dVEtA0i4d
        UM6s6REWqSGE/XloImoavMrbwBRlOMo=
X-Google-Smtp-Source: ABdhPJyoWNR73fMpAt4CnyhPElBxx000HZahJMcYBcv7DUmE024YESxnwYHn4H/MapbVCcWT93tKzg==
X-Received: by 2002:a1c:2543:: with SMTP id l64mr3060412wml.96.1598380812332;
        Tue, 25 Aug 2020 11:40:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f3sm7395755wmb.35.2020.08.25.11.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 11:40:11 -0700 (PDT)
Message-Id: <9ecabeb0551653835d4992a8ac984b9995bd92f0.1598380805.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.680.v2.git.1598380805.gitgitgadget@gmail.com>
References: <pull.680.git.1597857408.gitgitgadget@gmail.com>
        <pull.680.v2.git.1598380805.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 25 Aug 2020 18:40:04 +0000
Subject: [PATCH v2 7/7] maintenance: recommended schedule in register/start
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

The 'git maintenance (register|start)' subcommands add the current
repository to the global Git config so maintenance will operate on that
repository. It does not specify what maintenance should occur or how
often.

If a user sets any 'maintenance.<task>.scheduled' config value, then
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
something more obvious (such as running 'gc' once a day). However, this
patch gives us a place to start a conversation on what we should
recommend. For my purposes, Scalar will set these config values so we
can always differ from core Git's recommendations.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-maintenance.txt |  6 +++++
 builtin/gc.c                      | 44 +++++++++++++++++++++++++++++++
 t/t7900-maintenance.sh            |  5 ++++
 3 files changed, 55 insertions(+)

diff --git a/Documentation/git-maintenance.txt b/Documentation/git-maintenance.txt
index d0316db5ae..bba76f0b0d 100644
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
index d97af4e546..037402e47f 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1415,6 +1415,47 @@ static int maintenance_run(int argc, const char **argv, const char *prefix)
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
+		int value;
+
+		strbuf_setlen(&config_name, prefix);
+		strbuf_addf(&config_name, "%s.schedule", tasks[i].name);
+
+		if (!git_config_get_int(config_name.buf, &value))
+			found = 1;
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
+	git_config_set("maintenance.prefetch.schedule", "3500");
+
+	git_config_set("maintenance.commit-graph.enabled", "true");
+	git_config_set("maintenance.commit-graph.schedule", "3500");
+
+	git_config_set("maintenance.loose-objects.enabled", "true");
+	git_config_set("maintenance.loose-objects.schedule", "86000");
+
+	git_config_set("maintenance.incremental-repack.enabled", "true");
+	git_config_set("maintenance.incremental-repack.schedule", "86000");
+}
+
 static int maintenance_register(void)
 {
 	struct child_process config_set = CHILD_PROCESS_INIT;
@@ -1424,6 +1465,9 @@ static int maintenance_register(void)
 	if (!the_repository || !the_repository->gitdir)
 		return 0;
 
+	if (has_schedule_config())
+		set_recommended_schedule();
+
 	config_get.git_cmd = 1;
 	strvec_pushl(&config_get.args, "config", "--global", "--get", "maintenance.repo",
 		     the_repository->worktree ? the_repository->worktree
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 6491031be8..7417e5858a 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -300,6 +300,11 @@ test_expect_success 'register and unregister' '
 	git config --global --add maintenance.repo /existing2 &&
 	git config --global --get-all maintenance.repo >before &&
 	git maintenance register &&
+	test_cmp_config false maintenance.auto &&
+	test_cmp_config false maintenance.gc.enabled &&
+	test_cmp_config true maintenance.prefetch.enabled &&
+	test_cmp_config 3500 maintenance.commit-graph.schedule &&
+	test_cmp_config 86000 maintenance.incremental-repack.schedule &&
 	git config --global --get-all maintenance.repo >actual &&
 	cp before after &&
 	pwd >>after &&
-- 
gitgitgadget
