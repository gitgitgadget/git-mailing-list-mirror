Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E76C47080
	for <git@archiver.kernel.org>; Sat, 22 May 2021 13:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB82E610A6
	for <git@archiver.kernel.org>; Sat, 22 May 2021 13:57:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbhEVN6u (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 May 2021 09:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbhEVN6n (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 May 2021 09:58:43 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A244CC06138F
        for <git@vger.kernel.org>; Sat, 22 May 2021 06:57:17 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id t206so12574044wmf.0
        for <git@vger.kernel.org>; Sat, 22 May 2021 06:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=PHaGE7WFcR5yICY5jz4l4JOBWPxGhBX+zjT5nluTxW0=;
        b=bBBsofVRyyOjg2zhM/LF+YViskoPm0BpXQ+j+IdxaNY1sIskYxGZPa49GfnobEbDnp
         60p5FngL7U24TN4JC202RTzEcqMLl47RICM/USWHllydKDo2SzkBBh+CF5Thzd8LwuAJ
         TERkPCFnQfnMPYnO4l9qXZYeXIU+sWSfWwPOyt8tJeOi+K15dFC6t7jVQHz6zQy3cck4
         8i/wy0SpEY+KEyJMkapPkiIwhY701A3Y/yQSvhgstjLWPjS3Jb3wmyjkGSLGiHamBqvI
         R6lbX7B8dZG5GmFtg/au2cYDvvT8B8NVmIrbDiuHn/GyXlAlJAkdfgbBZcUUCzx3wofj
         IKXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=PHaGE7WFcR5yICY5jz4l4JOBWPxGhBX+zjT5nluTxW0=;
        b=EJ3l1PRlPs4TKjQNXeJ+7wd+c6AaCtsHnEmFq7R9FjIYc3hnnHosIk4k/0h7YQSejM
         eIs2DzaOEmitwTIgybt6nhJ3RKUQQj1HtNPiXe8bMWHM10vcO5c2x1YT5wmYW1ChvXex
         gBFf2CiQt0iNziBX9pVEloKXZA6w07RmaaZGtP6UkmcKZRAkcEj6pMyFcL7pkfINoc5X
         J25u0Y4kjqhMtB+LlJ1f3Y6PgfEb+0lPJJ4NwA4ZvwoK6QNT2hMjp9zARtFj5QmlHaE5
         uWjsa0Xac7jDoS37ir621/OwZMQ95s9HQBcckZfsmN2p9dzOTkdyfyeSKz35nh0wnSAR
         K9dQ==
X-Gm-Message-State: AOAM530awsHV+aeLmDGwakkQ+vwpR120rKsf3mfcSofSe/bheizGVp42
        hRDDbH4QaE+dHRce7r6Y8atI5jRyLSE=
X-Google-Smtp-Source: ABdhPJxBwA4rSV/hvmCZoMTWcFh+uBLDNo10ktUIk/df+A4lS3JC8UFftNvga/JSebaBgEM82Vms9w==
X-Received: by 2002:a1c:2048:: with SMTP id g69mr13042943wmg.6.1621691836244;
        Sat, 22 May 2021 06:57:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j10sm5483172wrt.32.2021.05.22.06.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 May 2021 06:57:15 -0700 (PDT)
Message-Id: <4f401310539ea4bebf662c7ddf82bb74e9f1d8c8.1621691828.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
References: <pull.923.git.1617291666.gitgitgadget@gmail.com>
        <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 22 May 2021 13:56:48 +0000
Subject: [PATCH v2 09/28] fsmonitor--daemon: implement client command options
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Implement `stop` and `status` client commands to control and query the
status of a `fsmonitor--daemon` server process (and implicitly start a
server process if necessary).

Later commits will implement the actual server and monitor the file
system.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 builtin/fsmonitor--daemon.c | 49 +++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index df2bad531118..16ff68b65407 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -7,10 +7,53 @@
 #include "khash.h"
 
 static const char * const builtin_fsmonitor__daemon_usage[] = {
+	N_("git fsmonitor--daemon stop"),
+	N_("git fsmonitor--daemon status"),
 	NULL
 };
 
 #ifdef HAVE_FSMONITOR_DAEMON_BACKEND
+/*
+ * Acting as a CLIENT.
+ *
+ * Send a "quit" command to the `git-fsmonitor--daemon` (if running)
+ * and wait for it to shutdown.
+ */
+static int do_as_client__send_stop(void)
+{
+	struct strbuf answer = STRBUF_INIT;
+	int ret;
+
+	ret = fsmonitor_ipc__send_command("quit", &answer);
+
+	/* The quit command does not return any response data. */
+	strbuf_release(&answer);
+
+	if (ret)
+		return ret;
+
+	trace2_region_enter("fsm_client", "polling-for-daemon-exit", NULL);
+	while (fsmonitor_ipc__get_state() == IPC_STATE__LISTENING)
+		sleep_millisec(50);
+	trace2_region_leave("fsm_client", "polling-for-daemon-exit", NULL);
+
+	return 0;
+}
+
+static int do_as_client__status(void)
+{
+	enum ipc_active_state state = fsmonitor_ipc__get_state();
+
+	switch (state) {
+	case IPC_STATE__LISTENING:
+		printf(_("The built-in file system monitor is active\n"));
+		return 0;
+
+	default:
+		printf(_("The built-in file system monitor is not active\n"));
+		return 1;
+	}
+}
 
 int cmd_fsmonitor__daemon(int argc, const char **argv, const char *prefix)
 {
@@ -35,6 +78,12 @@ int cmd_fsmonitor__daemon(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, options,
 			     builtin_fsmonitor__daemon_usage, 0);
 
+	if (!strcmp(subcmd, "stop"))
+		return !!do_as_client__send_stop();
+
+	if (!strcmp(subcmd, "status"))
+		return !!do_as_client__status();
+
 	die(_("Unhandled subcommand '%s'"), subcmd);
 }
 
-- 
gitgitgadget

