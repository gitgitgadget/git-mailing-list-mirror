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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE84C4363E
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 17:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2968761383
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 17:44:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235720AbhDARnI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Apr 2021 13:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234536AbhDARh4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Apr 2021 13:37:56 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FBAFC0225B8
        for <git@vger.kernel.org>; Thu,  1 Apr 2021 08:41:10 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id x13so2256179wrs.9
        for <git@vger.kernel.org>; Thu, 01 Apr 2021 08:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=nXaGyCwufbowQyx7IWi+icYC2uFsuA2bq1r9jyL4u28=;
        b=jqHEzr0eNE0jErZPk0nCnCxSdo5hRdyfDqHWudoVsC3nMZK5vNjwWRTw9ar8s77H3c
         n85fGCrd4w8nvNpF8JB6LtywVElUVsqpVWbv7v+2oiD0Xxi6ItN9Q9XBGpiHSvC+HF/h
         5Vv9hrAZ4Pb+WbEDKC1lXh17LfZuHIgez+FSbav6NCpDbj1hA88GJWmD5thm4t4GPwWE
         P62IqB/GtjdlFWwkZ9FjHr5cL/QB3IoqRRFmUW0HnGm1IY8J25J9Vf+dDdL4Z8oQCGKQ
         KJIVILeE1vKC9nRntnl5ETVJRV9toLFzk2KG6SfsZHGFGMXePNSuuSFs/EDezD5bfnM0
         albg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=nXaGyCwufbowQyx7IWi+icYC2uFsuA2bq1r9jyL4u28=;
        b=SIrXQnt6R4fiHkBm0zD8eSLB8CMxGWPpxOSvoAWP+lJlwm3YkxE1X9LOPu9QA6OrsB
         MWr1Au9EXZGSvmgP884/Ho2k4Np9mCjxTTg0E6xCfQtZNnE6QJAOY3H05HnOVT6ynVEh
         VeW9qqLYGQ9iCEz7hxGT9LYzSBv/L0qv+WX2dSXELkqbngmSaQNYlR8BUP8vokcMdQQ9
         43m4+uWj7XLVnKKOQhPC344Cz2fy+vYG/ZZbRxtD66NCzasf9MKkxffQTmWx2//injzr
         /cr8oKlu55xOTh2xFDUBAKy9SF14iUdD8R5Lg6G9c8O7dvjBncycoT0GFPE8JG5SnDkF
         1ptA==
X-Gm-Message-State: AOAM533pdFyC5ZnB7pfjlCqSTdAuBogOYQqoJTNVnCoF1Evm3rQ8xjkW
        Vs/rxT82OqWfNM0O11ZY8feWdLhzzrY=
X-Google-Smtp-Source: ABdhPJzt+MHmEtuTXM6rzczAM50dvv6wd9ThgGxcRN4OvlusEgqsR1lZabZl2I41PqG+kud0WmULNQ==
X-Received: by 2002:adf:fcc7:: with SMTP id f7mr10533138wrs.400.1617291669339;
        Thu, 01 Apr 2021 08:41:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w22sm9500129wmi.22.2021.04.01.08.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 08:41:09 -0700 (PDT)
Message-Id: <3dac63eae201e6d0b949680e682238625cad59bd.1617291666.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.923.git.1617291666.gitgitgadget@gmail.com>
References: <pull.923.git.1617291666.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Apr 2021 15:40:44 +0000
Subject: [PATCH 02/23] fsmonitor-ipc: create client routines for
 git-fsmonitor--daemon
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

Create client routines to spawn a fsmonitor daemon and send it an IPC
request using `simple-ipc`.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 Makefile        |   1 +
 fsmonitor-ipc.c | 153 ++++++++++++++++++++++++++++++++++++++++++++++++
 fsmonitor-ipc.h |  48 +++++++++++++++
 help.c          |   4 ++
 4 files changed, 206 insertions(+)
 create mode 100644 fsmonitor-ipc.c
 create mode 100644 fsmonitor-ipc.h

diff --git a/Makefile b/Makefile
index a6a73c574191..50977911d41a 100644
--- a/Makefile
+++ b/Makefile
@@ -891,6 +891,7 @@ LIB_OBJS += fetch-pack.o
 LIB_OBJS += fmt-merge-msg.o
 LIB_OBJS += fsck.o
 LIB_OBJS += fsmonitor.o
+LIB_OBJS += fsmonitor-ipc.o
 LIB_OBJS += gettext.o
 LIB_OBJS += gpg-interface.o
 LIB_OBJS += graph.o
diff --git a/fsmonitor-ipc.c b/fsmonitor-ipc.c
new file mode 100644
index 000000000000..b0dc334ff02d
--- /dev/null
+++ b/fsmonitor-ipc.c
@@ -0,0 +1,153 @@
+#include "cache.h"
+#include "fsmonitor.h"
+#include "fsmonitor-ipc.h"
+#include "run-command.h"
+#include "strbuf.h"
+#include "trace2.h"
+
+#ifdef HAVE_FSMONITOR_DAEMON_BACKEND
+#define FSMONITOR_DAEMON_IS_SUPPORTED 1
+#else
+#define FSMONITOR_DAEMON_IS_SUPPORTED 0
+#endif
+
+/*
+ * A trivial function so that this source file always defines at least
+ * one symbol even when the feature is not supported.  This quiets an
+ * annoying compiler error.
+ */
+int fsmonitor_ipc__is_supported(void)
+{
+	return FSMONITOR_DAEMON_IS_SUPPORTED;
+}
+
+#ifdef HAVE_FSMONITOR_DAEMON_BACKEND
+
+GIT_PATH_FUNC(fsmonitor_ipc__get_path, "fsmonitor")
+
+enum ipc_active_state fsmonitor_ipc__get_state(void)
+{
+	return ipc_get_active_state(fsmonitor_ipc__get_path());
+}
+
+static int spawn_daemon(void)
+{
+	const char *args[] = { "fsmonitor--daemon", "--start", NULL };
+
+	return run_command_v_opt_tr2(args, RUN_COMMAND_NO_STDIN | RUN_GIT_CMD,
+				    "fsmonitor");
+}
+
+int fsmonitor_ipc__send_query(const char *since_token,
+			      struct strbuf *answer)
+{
+	int ret = -1;
+	int tried_to_spawn = 0;
+	enum ipc_active_state state = IPC_STATE__OTHER_ERROR;
+	struct ipc_client_connection *connection = NULL;
+	struct ipc_client_connect_options options
+		= IPC_CLIENT_CONNECT_OPTIONS_INIT;
+
+	options.wait_if_busy = 1;
+	options.wait_if_not_found = 0;
+
+	trace2_region_enter("fsm_client", "query", NULL);
+
+	trace2_data_string("fsm_client", NULL, "query/command",
+			   since_token);
+
+try_again:
+	state = ipc_client_try_connect(fsmonitor_ipc__get_path(), &options,
+				       &connection);
+
+	switch (state) {
+	case IPC_STATE__LISTENING:
+		ret = ipc_client_send_command_to_connection(
+			connection, since_token, answer);
+		ipc_client_close_connection(connection);
+
+		trace2_data_intmax("fsm_client", NULL,
+				   "query/response-length", answer->len);
+
+		if (fsmonitor_is_trivial_response(answer))
+			trace2_data_intmax("fsm_client", NULL,
+					   "query/trivial-response", 1);
+
+		goto done;
+
+	case IPC_STATE__NOT_LISTENING:
+		ret = error(_("fsmonitor_ipc__send_query: daemon not available"));
+		goto done;
+
+	case IPC_STATE__PATH_NOT_FOUND:
+		if (tried_to_spawn)
+			goto done;
+
+		tried_to_spawn++;
+		if (spawn_daemon())
+			goto done;
+
+		/*
+		 * Try again, but this time give the daemon a chance to
+		 * actually create the pipe/socket.
+		 *
+		 * Granted, the daemon just started so it can't possibly have
+		 * any FS cached yet, so we'll always get a trivial answer.
+		 * BUT the answer should include a new token that can serve
+		 * as the basis for subsequent requests.
+		 */
+		options.wait_if_not_found = 1;
+		goto try_again;
+
+	case IPC_STATE__INVALID_PATH:
+		ret = error(_("fsmonitor_ipc__send_query: invalid path '%s'"),
+			    fsmonitor_ipc__get_path());
+		goto done;
+
+	case IPC_STATE__OTHER_ERROR:
+	default:
+		ret = error(_("fsmonitor_ipc__send_query: unspecified error on '%s'"),
+			    fsmonitor_ipc__get_path());
+		goto done;
+	}
+
+done:
+	trace2_region_leave("fsm_client", "query", NULL);
+
+	return ret;
+}
+
+int fsmonitor_ipc__send_command(const char *command,
+				struct strbuf *answer)
+{
+	struct ipc_client_connection *connection = NULL;
+	struct ipc_client_connect_options options
+		= IPC_CLIENT_CONNECT_OPTIONS_INIT;
+	int ret;
+	enum ipc_active_state state;
+
+	strbuf_reset(answer);
+
+	options.wait_if_busy = 1;
+	options.wait_if_not_found = 0;
+
+	state = ipc_client_try_connect(fsmonitor_ipc__get_path(), &options,
+				       &connection);
+	if (state != IPC_STATE__LISTENING) {
+		die("fsmonitor--daemon is not running");
+		return -1;
+	}
+
+	ret = ipc_client_send_command_to_connection(connection, command, answer);
+	ipc_client_close_connection(connection);
+
+	if (ret == -1) {
+		die("could not send '%s' command to fsmonitor--daemon",
+		    command);
+		return -1;
+	}
+
+	return 0;
+}
+
+#endif
diff --git a/fsmonitor-ipc.h b/fsmonitor-ipc.h
new file mode 100644
index 000000000000..7d21c1260151
--- /dev/null
+++ b/fsmonitor-ipc.h
@@ -0,0 +1,48 @@
+#ifndef FSMONITOR_IPC_H
+#define FSMONITOR_IPC_H
+
+/*
+ * Returns true if a filesystem notification backend is defined
+ * for this platform.  This symbol must always be visible and
+ * outside of the HAVE_ ifdef.
+ */
+int fsmonitor_ipc__is_supported(void);
+
+#ifdef HAVE_FSMONITOR_DAEMON_BACKEND
+#include "run-command.h"
+#include "simple-ipc.h"
+
+/*
+ * Returns the pathname to the IPC named pipe or Unix domain socket
+ * where a `git-fsmonitor--daemon` process will listen.  This is a
+ * per-worktree value.
+ */
+const char *fsmonitor_ipc__get_path(void);
+
+/*
+ * Try to determine whether there is a `git-fsmonitor--daemon` process
+ * listening on the IPC pipe/socket.
+ */
+enum ipc_active_state fsmonitor_ipc__get_state(void);
+
+/*
+ * Connect to a `git-fsmonitor--daemon` process via simple-ipc
+ * and ask for the set of changed files since the given token.
+ *
+ * This DOES NOT use the hook interface.
+ *
+ * Spawn a daemon process in the background if necessary.
+ */
+int fsmonitor_ipc__send_query(const char *since_token,
+			      struct strbuf *answer);
+
+/*
+ * Connect to a `git-fsmonitor--daemon` process via simple-ipc and
+ * send a command verb.  If no daemon is available, we DO NOT try to
+ * start one.
+ */
+int fsmonitor_ipc__send_command(const char *command,
+				struct strbuf *answer);
+
+#endif /* HAVE_FSMONITOR_DAEMON_BACKEND */
+#endif /* FSMONITOR_IPC_H */
diff --git a/help.c b/help.c
index 3c3bdec21356..e22ba1d246a5 100644
--- a/help.c
+++ b/help.c
@@ -11,6 +11,7 @@
 #include "version.h"
 #include "refs.h"
 #include "parse-options.h"
+#include "fsmonitor-ipc.h"
 
 struct category_description {
 	uint32_t category;
@@ -664,6 +665,9 @@ void get_version_info(struct strbuf *buf, int show_build_options)
 		strbuf_addf(buf, "sizeof-size_t: %d\n", (int)sizeof(size_t));
 		strbuf_addf(buf, "shell-path: %s\n", SHELL_PATH);
 		/* NEEDSWORK: also save and output GIT-BUILD_OPTIONS? */
+
+		if (fsmonitor_ipc__is_supported())
+			strbuf_addstr(buf, "feature: fsmonitor--daemon\n");
 	}
 }
 
-- 
gitgitgadget

