Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 593B6C433F5
	for <git@archiver.kernel.org>; Fri, 11 Feb 2022 20:56:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353568AbiBKU4j (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Feb 2022 15:56:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353485AbiBKU4a (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Feb 2022 15:56:30 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65151B5
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 12:56:28 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id u1so3424885wrg.11
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 12:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6enTMMANNAxK1CGL3Ldk/yaPqbhSNHnwYfXVeNCe1iY=;
        b=IBhGLf/IT+46TT/HXIEaoh0tvSN/U4qUP6MMH+AjTz7mFPoYCkg/5HPeL2objpgu7H
         vHXQaKnflnD1RE2pSLFGxPhb2pSqtGvfX+8q67nzEUeaZNauFqOVHrBTDnBUiHGaHSpC
         Yn2h3NVlMWW/tLMxGDxvshN4RfDZi3dQuneiwryCic/2M73+Vyk7hpR+cxiCb2udRmSd
         2gppk28tKKF8UyhaiAPCVFWKIBZE3cKqSm+etHvSU1VBwIucbzw3mBi6o80BM7CCZiit
         t6CS8GHoxaznqHT8OLG0VfDQ4NvJAjLh5KvLJbUBQpMVdsxLjGgP5IbJXJQ0WEmSph7X
         OwDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6enTMMANNAxK1CGL3Ldk/yaPqbhSNHnwYfXVeNCe1iY=;
        b=6MOFcF2lZ1T9NGoX9Uj/nOoevTK8CT2vEMJNkCm6xFU7jASXgol+RRlrspEiUBlGsE
         9kROxNAjZKXKR2DAB6ti5stW6vDdi6L2F8WQm6sxparCL31me5me+jeVw7GhjARXVllA
         O5zahBqkc2LtFOaCzSjaImIE7iSTYxE+LNsOiNw++t6ARcn+N7/QnZGqO9Cg2ZCOXyNk
         8i2SpuT8trmPqEr3P+aKSjuxrB4AJzmMfjINaRYTBJeT6tjyzZB3srSBr2mLYAyCskaP
         uDkrf6igcFg8EjQ5mwEvZvceISC+/lubp3zTO7CUZ0+U4ijsW+e2s5TSEH0Vy6LFc8cR
         2aeg==
X-Gm-Message-State: AOAM533tcOWKJYsdKjdknelFcf4jremEqA9WzxQaGaKdZO4pPLoGlP3I
        cjhu4xOl42SbhvJEUQ52zmy8D4FvJNo=
X-Google-Smtp-Source: ABdhPJyKUyC0sLeLU2mrdCn9wv+kg233YMvCmdml1tA6p6s5QIMxETiyBjJpVvNZSQBBjuNSHyNNDA==
X-Received: by 2002:a5d:5989:: with SMTP id n9mr2686599wri.63.1644612986829;
        Fri, 11 Feb 2022 12:56:26 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b7sm11533215wrp.23.2022.02.11.12.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 12:56:26 -0800 (PST)
Message-Id: <9f00ada3dd35a5dde09dbf1527f0a8987392b05b.1644612979.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com>
References: <pull.1041.v4.git.1634826309.gitgitgadget@gmail.com>
        <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 11 Feb 2022 20:55:56 +0000
Subject: [PATCH v5 07/30] fsmonitor--daemon: implement 'stop' and 'status'
 commands
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
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
index f0498793379..5e3178b8bdd 100644
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
@@ -28,6 +73,12 @@ int cmd_fsmonitor__daemon(int argc, const char **argv, const char *prefix)
 		usage_with_options(builtin_fsmonitor__daemon_usage, options);
 	subcmd = argv[0];
 
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

