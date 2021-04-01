Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A8AC41538
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 17:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 138AC61383
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 17:43:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235863AbhDARnR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Apr 2021 13:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234747AbhDARjm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Apr 2021 13:39:42 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB9CC0225BC
        for <git@vger.kernel.org>; Thu,  1 Apr 2021 08:41:13 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id j9so2254773wrx.12
        for <git@vger.kernel.org>; Thu, 01 Apr 2021 08:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=daAB+2L2OPG1QBkdGoK+7+40yncSFaJ1sOuvJFAzK/A=;
        b=rpDTXyuHw4OSlz6ebbkMfUt84a4+dwJoIxm2rl5iERoUkhX8r389O5DUGooXIOxWEJ
         bRRVbMRb/0aAYEzUQbkgz4zfHNtjmeNIUsbZ96LPuO5H3Lbylpdt057nVb4GldupBpsn
         0ofNI+NJAPVe6EjftODs4JKHmTZjOqbaTuRAnILyYyy8e6o4eV7uiGBnAb48DIRCaJC6
         IkKruOXWb6TrH7s1o4+XDh0XGOvy9o8iG+azfypnNQGU5cZdMojQtSlDnpQpCCmSp424
         4hYVQYBlyOS+YImkXpidBsngSv7hbM4wRaeQyrqTNeo0n6/2n6CWRLxE5hrt1UFtaDuG
         0pCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=daAB+2L2OPG1QBkdGoK+7+40yncSFaJ1sOuvJFAzK/A=;
        b=gypgLdCc5fVYW9Yb0aBh9Ujm+FeyVtsC5d4X2OG/lBjAHJeYyVsJZ84oh2D45fVRHE
         xs6YCNuUbnmAdn1g+LKKnNKaoDThrsrOxkjobyLtXAqCQOYZ+TApXoQHZKzH0NvxGxjo
         5It5vBzYvXEDI+baowaDc/hfq2l/9K0/5ITMaIzH4XIhCxmWhWN6UXaFP6lAx4/vn/gI
         GcvqV3j8rGqQ7Gv233R0U96QS/Jz5f7Szq0R0Y8Kf9NPg7YvTxkV2BCnu74Tqu4y8+eT
         5sAvofzjPAh6ljK7mAqHbAuPlTu5WZb3ECINVKDvhRIZ1kaTvcPCzpubJNQwn2ucZQfx
         X5SQ==
X-Gm-Message-State: AOAM531+Rw+mQKPEBC0WXQ40C1qnajtUmq/i8OSEG3HcMpDiXxO6Vqow
        tU+xnwl25UuL8HBk1vBaVJ7QKpY3PZw=
X-Google-Smtp-Source: ABdhPJxrp+ZRcjrDjh9C2eNSCJQvZi2oA1NaQB20ka9TUlzEqeYy66iwhnfluROrw6ba+dU6ll9kOg==
X-Received: by 2002:a5d:5051:: with SMTP id h17mr10272629wrt.80.1617291671910;
        Thu, 01 Apr 2021 08:41:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p14sm8533221wmc.30.2021.04.01.08.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 08:41:11 -0700 (PDT)
Message-Id: <77170e521f67ce92587d833334f6951a9f375d4d.1617291666.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.923.git.1617291666.gitgitgadget@gmail.com>
References: <pull.923.git.1617291666.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Apr 2021 15:40:48 +0000
Subject: [PATCH 06/23] fsmonitor--daemon: implement client command options
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Implement command options `--stop`, `--is-running`, `--query`,
`--query-index`, and `--flush` to control and query the status of a
`fsmonitor--daemon` server process (and implicitly start a server
process if necessary).

Later commits will implement the actual server and monitor
the file system.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 builtin/fsmonitor--daemon.c | 144 ++++++++++++++++++++++++++++++++++++
 1 file changed, 144 insertions(+)

diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index 6700bac92c7d..10434bce4b64 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -7,18 +7,144 @@
 #include "khash.h"
 
 static const char * const builtin_fsmonitor__daemon_usage[] = {
+	N_("git fsmonitor--daemon --stop"),
+	N_("git fsmonitor--daemon --is-running"),
+	N_("git fsmonitor--daemon --query <token>"),
+	N_("git fsmonitor--daemon --query-index"),
+	N_("git fsmonitor--daemon --flush"),
 	NULL
 };
 
 #ifdef HAVE_FSMONITOR_DAEMON_BACKEND
+/*
+ * Acting as a CLIENT.
+ *
+ * Send an IPC query to a `git-fsmonitor--daemon` SERVER process and
+ * ask for the changes since the given token.  This will implicitly
+ * start a daemon process if necessary.  The daemon process will
+ * persist after we exit.
+ *
+ * This feature is primarily used by the test suite.
+ */
+static int do_as_client__query_token(const char *token)
+{
+	struct strbuf answer = STRBUF_INIT;
+	int ret;
+
+	ret = fsmonitor_ipc__send_query(token, &answer);
+	if (ret < 0)
+		die(_("could not query fsmonitor--daemon"));
+
+	write_in_full(1, answer.buf, answer.len);
+	strbuf_release(&answer);
+
+	return 0;
+}
+
+/*
+ * Acting as a CLIENT.
+ *
+ * Read the `.git/index` to get the last token written to the FSMonitor index
+ * extension and use that to make a query.
+ *
+ * This feature is primarily used by the test suite.
+ */
+static int do_as_client__query_from_index(void)
+{
+	struct index_state *istate = the_repository->index;
+
+	setup_git_directory();
+	if (do_read_index(istate, the_repository->index_file, 0) < 0)
+		die("unable to read index file");
+	if (!istate->fsmonitor_last_update)
+		die("index file does not have fsmonitor extension");
+
+	return do_as_client__query_token(istate->fsmonitor_last_update);
+}
+
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
+/*
+ * Acting as a CLIENT.
+ *
+ * Send a "flush" command to the `git-fsmonitor--daemon` (if running)
+ * and tell it to flush its cache.
+ *
+ * This feature is primarily used by the test suite to simulate a loss of
+ * sync with the filesystem where we miss kernel events.
+ */
+static int do_as_client__send_flush(void)
+{
+	struct strbuf answer = STRBUF_INIT;
+	int ret;
+
+	ret = fsmonitor_ipc__send_command("flush", &answer);
+	if (ret)
+		return ret;
+
+	write_in_full(1, answer.buf, answer.len);
+	strbuf_release(&answer);
+
+	return 0;
+}
+
+static int is_ipc_daemon_listening(void)
+{
+	return fsmonitor_ipc__get_state() == IPC_STATE__LISTENING;
+}
 
 int cmd_fsmonitor__daemon(int argc, const char **argv, const char *prefix)
 {
 	enum daemon_mode {
 		UNDEFINED_MODE,
+		STOP,
+		IS_RUNNING,
+		QUERY,
+		QUERY_INDEX,
+		FLUSH,
 	} mode = UNDEFINED_MODE;
 
 	struct option options[] = {
+		OPT_CMDMODE(0, "stop", &mode, N_("stop the running daemon"),
+			    STOP),
+
+		OPT_CMDMODE(0, "is-running", &mode,
+			    N_("test whether the daemon is running"),
+			    IS_RUNNING),
+
+		OPT_CMDMODE(0, "query", &mode,
+			    N_("query the daemon (starting if necessary)"),
+			    QUERY),
+		OPT_CMDMODE(0, "query-index", &mode,
+			    N_("query the daemon (starting if necessary) using token from index"),
+			    QUERY_INDEX),
+		OPT_CMDMODE(0, "flush", &mode, N_("flush cached filesystem events"),
+			    FLUSH),
 		OPT_END()
 	};
 
@@ -31,6 +157,24 @@ int cmd_fsmonitor__daemon(int argc, const char **argv, const char *prefix)
 			     builtin_fsmonitor__daemon_usage, 0);
 
 	switch (mode) {
+	case STOP:
+		return !!do_as_client__send_stop();
+
+	case IS_RUNNING:
+		return !is_ipc_daemon_listening();
+
+	case QUERY:
+		if (argc != 1)
+			usage_with_options(builtin_fsmonitor__daemon_usage,
+					   options);
+		return !!do_as_client__query_token(argv[0]);
+
+	case QUERY_INDEX:
+		return !!do_as_client__query_from_index();
+
+	case FLUSH:
+		return !!do_as_client__send_flush();
+
 	case UNDEFINED_MODE:
 	default:
 		die(_("Unhandled command mode %d"), mode);
-- 
gitgitgadget

