Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0ED8C433EF
	for <git@archiver.kernel.org>; Fri, 11 Feb 2022 20:56:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353493AbiBKU42 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Feb 2022 15:56:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353468AbiBKU40 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Feb 2022 15:56:26 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42AE49E
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 12:56:24 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id o24so14521026wro.3
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 12:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4s+QbTMfcVQV/TgTnF7SKV0ZTozpIm4Oshz6VpC76rI=;
        b=DZ/kkn78RkiSFDAlBFUDknLigv4fCfkbg0Hm0UOK5qxDxOMNqyLUIP5T9XuOCSz6D4
         tf4t3BALEzsAe7oUA8cNTEnjCU+iX5KirgPJgssgDlSfkmLhEzJLgnqFK3GGMJmnhOIa
         qp1+4Yx8+a4kdXC89rqtxvLvGsmM0/Y37MpmcwzaWP3UBPFtP5g36quV7E4Jq57ULy5a
         JiE7nSxOujrqrTps/PxsfPiA1H9diF3AcvLMdilwHaBloKtTQyJ4QalLo4dO0WzGdvk/
         rndkpPEV+E5yJLTWYv5jFwfbriOXMoa/n02NaU98o4xmVk5njSypSN1YMLH3+VHp2HZv
         w5BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4s+QbTMfcVQV/TgTnF7SKV0ZTozpIm4Oshz6VpC76rI=;
        b=u1xMuMI5oZCcn7Z3gIwWusnS7Ka+RnAAz9TB1esw19D8Ik4eDA+zZ2+qj1Xv/SbDk2
         ffxfX5ScXJHYOLcNWUjU1sh6AjaoSsVhXop7F+bqONTgo2ERjG/Wx1H9yDh/a9HUnU19
         9NdtqA/UdB5oOKkc52DnG6F4M4LakGnYkQHxKLiWvf6WzomctEJEB73iTw9SWFvjjUH+
         06JCCzD6wQvY3poTu3OCbCGlKz0taozRYnYtA1p96+S0Rsa8KoOGBiUj8+4TyCANXrYZ
         jE79mz1wRZed08hMbbu+py7gPoB8rG+LK+sRhXSiFgR+CjdzjCtvsDt40vIAUifFeYlk
         xjcw==
X-Gm-Message-State: AOAM532/5NrEXWkgaG6tLVydvRidmgTcBwiH/m5IZrLo0uj8S9kMVy6I
        rT6VsKtpysXKuR6xplkct5o74MhLuQ8=
X-Google-Smtp-Source: ABdhPJz4qzqbxC2E9UooDNa55HhY3Wp8t2YQzIOb/lnquV4nvaobQLATg99eggFJs+hkzSuFSVdSHQ==
X-Received: by 2002:adf:e841:: with SMTP id d1mr2719039wrn.293.1644612982616;
        Fri, 11 Feb 2022 12:56:22 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bg23sm6316265wmb.5.2022.02.11.12.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 12:56:22 -0800 (PST)
Message-Id: <365964b766400654a9978092f8fe5cfaa525fd3b.1644612979.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com>
References: <pull.1041.v4.git.1634826309.gitgitgadget@gmail.com>
        <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 11 Feb 2022 20:55:51 +0000
Subject: [PATCH v5 02/30] fsmonitor-ipc: create client routines for
 git-fsmonitor--daemon
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

Create fsmonitor_ipc__*() client routines to spawn the built-in file
system monitor daemon and send it an IPC request using the `Simple
IPC` API.

Stub in empty fsmonitor_ipc__*() functions for unsupported platforms.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 Makefile        |   1 +
 fsmonitor-ipc.c | 171 ++++++++++++++++++++++++++++++++++++++++++++++++
 fsmonitor-ipc.h |  48 ++++++++++++++
 3 files changed, 220 insertions(+)
 create mode 100644 fsmonitor-ipc.c
 create mode 100644 fsmonitor-ipc.h

diff --git a/Makefile b/Makefile
index 8e07003840b..dee3ba4a0b1 100644
--- a/Makefile
+++ b/Makefile
@@ -899,6 +899,7 @@ LIB_OBJS += fetch-pack.o
 LIB_OBJS += fmt-merge-msg.o
 LIB_OBJS += fsck.o
 LIB_OBJS += fsmonitor.o
+LIB_OBJS += fsmonitor-ipc.o
 LIB_OBJS += gettext.o
 LIB_OBJS += gpg-interface.o
 LIB_OBJS += graph.o
diff --git a/fsmonitor-ipc.c b/fsmonitor-ipc.c
new file mode 100644
index 00000000000..01c8c25bf50
--- /dev/null
+++ b/fsmonitor-ipc.c
@@ -0,0 +1,171 @@
+#include "cache.h"
+#include "fsmonitor.h"
+#include "simple-ipc.h"
+#include "fsmonitor-ipc.h"
+#include "run-command.h"
+#include "strbuf.h"
+#include "trace2.h"
+
+#ifdef HAVE_FSMONITOR_DAEMON_BACKEND
+
+int fsmonitor_ipc__is_supported(void)
+{
+	return 1;
+}
+
+GIT_PATH_FUNC(fsmonitor_ipc__get_path, "fsmonitor--daemon.ipc")
+
+enum ipc_active_state fsmonitor_ipc__get_state(void)
+{
+	return ipc_get_active_state(fsmonitor_ipc__get_path());
+}
+
+static int spawn_daemon(void)
+{
+	const char *args[] = { "fsmonitor--daemon", "start", NULL };
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
+	const char *tok = since_token ? since_token : "";
+	size_t tok_len = since_token ? strlen(since_token) : 0;
+
+	options.wait_if_busy = 1;
+	options.wait_if_not_found = 0;
+
+	trace2_region_enter("fsm_client", "query", NULL);
+	trace2_data_string("fsm_client", NULL, "query/command", tok);
+
+try_again:
+	state = ipc_client_try_connect(fsmonitor_ipc__get_path(), &options,
+				       &connection);
+
+	switch (state) {
+	case IPC_STATE__LISTENING:
+		ret = ipc_client_send_command_to_connection(
+			connection, tok, tok_len, answer);
+		ipc_client_close_connection(connection);
+
+		trace2_data_intmax("fsm_client", NULL,
+				   "query/response-length", answer->len);
+		goto done;
+
+	case IPC_STATE__NOT_LISTENING:
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
+	const char *c = command ? command : "";
+	size_t c_len = command ? strlen(command) : 0;
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
+	ret = ipc_client_send_command_to_connection(connection, c, c_len,
+						    answer);
+	ipc_client_close_connection(connection);
+
+	if (ret == -1) {
+		die("could not send '%s' command to fsmonitor--daemon", c);
+		return -1;
+	}
+
+	return 0;
+}
+
+#else
+
+/*
+ * A trivial implementation of the fsmonitor_ipc__ API for unsupported
+ * platforms.
+ */
+
+int fsmonitor_ipc__is_supported(void)
+{
+	return 0;
+}
+
+const char *fsmonitor_ipc__get_path(void)
+{
+	return NULL;
+}
+
+enum ipc_active_state fsmonitor_ipc__get_state(void)
+{
+	return IPC_STATE__OTHER_ERROR;
+}
+
+int fsmonitor_ipc__send_query(const char *since_token,
+			      struct strbuf *answer)
+{
+	return -1;
+}
+
+int fsmonitor_ipc__send_command(const char *command,
+				struct strbuf *answer)
+{
+	return -1;
+}
+
+#endif
diff --git a/fsmonitor-ipc.h b/fsmonitor-ipc.h
new file mode 100644
index 00000000000..b6a7067c3af
--- /dev/null
+++ b/fsmonitor-ipc.h
@@ -0,0 +1,48 @@
+#ifndef FSMONITOR_IPC_H
+#define FSMONITOR_IPC_H
+
+#include "simple-ipc.h"
+
+/*
+ * Returns true if built-in file system monitor daemon is defined
+ * for this platform.
+ */
+int fsmonitor_ipc__is_supported(void);
+
+/*
+ * Returns the pathname to the IPC named pipe or Unix domain socket
+ * where a `git-fsmonitor--daemon` process will listen.  This is a
+ * per-worktree value.
+ *
+ * Returns NULL if the daemon is not supported on this platform.
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
+ * Spawn a daemon process in the background if necessary.
+ *
+ * Returns -1 on error; 0 on success.
+ */
+int fsmonitor_ipc__send_query(const char *since_token,
+			      struct strbuf *answer);
+
+/*
+ * Connect to a `git-fsmonitor--daemon` process via simple-ipc and
+ * send a command verb.  If no daemon is available, we DO NOT try to
+ * start one.
+ *
+ * Returns -1 on error; 0 on success.
+ */
+int fsmonitor_ipc__send_command(const char *command,
+				struct strbuf *answer);
+
+#endif /* FSMONITOR_IPC_H */
-- 
gitgitgadget

