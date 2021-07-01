Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F27BBC11F64
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 14:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFA5D6140C
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 14:47:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232920AbhGAOu3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jul 2021 10:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232566AbhGAOuX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jul 2021 10:50:23 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BADEC061764
        for <git@vger.kernel.org>; Thu,  1 Jul 2021 07:47:52 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id m9-20020a05600c3b09b02901f246b43bbeso4264230wms.3
        for <git@vger.kernel.org>; Thu, 01 Jul 2021 07:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=W24eIgcVkPMjgPidGJzbRp5I7QCe7bRzj3qpbqX2Z20=;
        b=MMwlg8Pd5wGLdz5Oh1LGutY6Dod6tPegRL197inFCRZSZFFOK2pgQe67H0D2WG9d7x
         OdmoYwX/XchQBytprnHL4YCqiarJgxTWcIJv56XIN4jYGLwAKl/xAeZVkvrZNl0WOfqH
         hGwD7vRD8FRU72fbROwvh/EChCK2mgZKBklUsDJ0AWBfeN8EZbAecjQzqL9FPRFgWPco
         Adn8JxXkay2jK+EtdZGwFS3MlpgbBuHlzy116L06TrIR9E5LGCXliNuJS89LEcujvfeG
         8Is66q5bhL5Qiv0hbI6qx++QWh3j1OBKf/eb+aZV0aaP5jkDQoVdjRaTz58k6RPGqpe5
         bkgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=W24eIgcVkPMjgPidGJzbRp5I7QCe7bRzj3qpbqX2Z20=;
        b=dW7G0igjJ4hR3l0WP6DfWBvyt4y2Q+C2pzfFD5qM+exQSeATzLqiwv2Lr/ugapoIqa
         ZDPe5v5q759fYJUNKFXXpi9SiinmVkarhkfFV9O3BDlzXNp13Cu/USKRPQwuXQmOhGHi
         MCAihbfUp8OWaD6YhV4BpUgi/Un96K1EwBrIML3PqUAraXpoPjYRXpFYevngiuoC1UFn
         5u4flOrPmvR0BsiL4+p8KgK8NjoZZAYu4qkTdqrGuSFOwiUhhBWNoK72yVF33sCvFwbd
         JTjjn2+iji/1cVpndm0MWEwW7Mz4YZSBr+PJkxInyhZ+CdxkUQgNdMF1tRGn9ZSsignL
         euFw==
X-Gm-Message-State: AOAM5319IgdCqlyIcgOTlTAzHe7iVQSqeI1dj6OAJKgiMRNVfeWrNR7d
        YaQW/47sHt9rwkdkJRbTnkZsyQKY4fQ=
X-Google-Smtp-Source: ABdhPJxa0L7SGet3oKE92LYjXJ9ao1KJlCKx1kss3Gs+IHkeQ0P+b7V9xPfzpkc59g6m5mWBx2YI1A==
X-Received: by 2002:a1c:59c3:: with SMTP id n186mr11263534wmb.48.1625150870978;
        Thu, 01 Jul 2021 07:47:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z5sm159029wrt.11.2021.07.01.07.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 07:47:50 -0700 (PDT)
Message-Id: <02e21384ef0ca4909e0bda2c78fa63c06be22a50.1625150864.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
References: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
        <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Jul 2021 14:47:19 +0000
Subject: [PATCH v3 09/34] fsmonitor--daemon: implement 'stop' and 'status'
 commands
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
 builtin/fsmonitor--daemon.c | 51 +++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index df2bad53111..62efd5ea787 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -7,10 +7,55 @@
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
+		printf(_("fsmonitor-daemon is watching '%s'\n"),
+		       the_repository->worktree);
+		return 0;
+
+	default:
+		printf(_("fsmonitor-daemon is not watching '%s'\n"),
+		       the_repository->worktree);
+		return 1;
+	}
+}
 
 int cmd_fsmonitor__daemon(int argc, const char **argv, const char *prefix)
 {
@@ -35,6 +80,12 @@ int cmd_fsmonitor__daemon(int argc, const char **argv, const char *prefix)
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

