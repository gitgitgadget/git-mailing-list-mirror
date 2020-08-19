Return-Path: <SRS0=/SyM=B5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DFC3C433E3
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 17:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFA4E207FF
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 17:17:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gMxK/FdF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbgHSRRm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Aug 2020 13:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbgHSRRN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Aug 2020 13:17:13 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6714C061346
        for <git@vger.kernel.org>; Wed, 19 Aug 2020 10:17:12 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id p20so22291848wrf.0
        for <git@vger.kernel.org>; Wed, 19 Aug 2020 10:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=pH+4E0BOt9rRfHDMb5OXdDsL4Wzt5LX8RegcuNrPwMg=;
        b=gMxK/FdFmxo37qKRq0//S1m0hpxmL1ONr0Riv3c3Yg16w9gm41RCGhUF9+e4HHif1N
         Nc4LsLls3XB9NUrrbdXkkYj6FT0YbCaRlID6vKz0TWqi1S4bnOuDw14+pARvNFSVY2H8
         es5FAv+T5R6ZgS6xURWaNDiwShcmtEhv7GgsWNSvaU+aGKGF1UU9wBo0QSPspkrlQWGA
         ZvxouwdYk1WrSamrq+YZENfgoGhgl6Uz7Ce9cPJ+X8ZPhUoYtEXQ/U+K3d3G1FVR6EgV
         i/ElDdXUPYxbl1OaeshOfKCNZUhjRKwIPMLj27kfuH47K7aHlMFEAush0FSmk8HrVv5i
         newg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=pH+4E0BOt9rRfHDMb5OXdDsL4Wzt5LX8RegcuNrPwMg=;
        b=hDheUDrgh0iP2nxYrpbEohmf47Jg8C/RHSS6Hq3GYJXIsQ11ColKHqwHoYyBLQPXp2
         Nick/q6Ds13RS1XPTLihn0j3mla9L4kzonMEPt22r0m+amZzXFJ0OpY3as7OzanVyTzj
         J18tU3hoEULS/Jawvm+p3xVQJDHFSu/LTmGkAlxEOtazXkjJuzr9cwxSuMmzowEx8q1v
         e1+tv0q21bMzaZQ/sCkGOpMnVulWSsNKI0mubseVIneF1DioE5fOz+ra7a+aUizn1owK
         zwqJkkuaMBRjfBO1L3BlGUGKSgbofQrKfrXLZtl5GJgHdBF7t8cLDHtruxGf3zVJSzrZ
         jqVw==
X-Gm-Message-State: AOAM5327YzhXL9X8aeFkIVKaIAkjZuuxBGJKF8ig8V9T7Pl3SYbkT6pA
        jNtXTxn9DiIrTv+w35xuLdEN/bXMu4M=
X-Google-Smtp-Source: ABdhPJyHYyru7jlIbJO4QMS4Pc1VGm///kbZmzDLfxVPvnzw85ANpUoZmxhvvLzD2x0LnlAZmuvBLQ==
X-Received: by 2002:a5d:49c9:: with SMTP id t9mr12292638wrs.302.1597857431383;
        Wed, 19 Aug 2020 10:17:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j4sm6335847wmi.48.2020.08.19.10.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 10:17:10 -0700 (PDT)
Message-Id: <40b1a0546ccea737df608aaffe90edf56377b4ce.1597857412.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.680.git.1597857408.gitgitgadget@gmail.com>
References: <pull.680.git.1597857408.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 19 Aug 2020 17:16:48 +0000
Subject: [PATCH 7/7] maintenance: recommended schedule in register/start
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
index 600272caa5..a4b46ea329 100644
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
index b09287f0fc..080d58735c 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1446,6 +1446,47 @@ static int task_option_parse(const struct option *opt,
 	return 0;
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
@@ -1455,6 +1496,9 @@ static int maintenance_register(void)
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
