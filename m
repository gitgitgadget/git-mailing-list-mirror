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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21BD5C11F64
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 14:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02BBA6141C
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 14:47:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232821AbhGAOuW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jul 2021 10:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232609AbhGAOuV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jul 2021 10:50:21 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E3D0C061764
        for <git@vger.kernel.org>; Thu,  1 Jul 2021 07:47:49 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id j1so8559785wrn.9
        for <git@vger.kernel.org>; Thu, 01 Jul 2021 07:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=q/IG4tajktxIQa8aqHJi11ZrCyXntesR5uZmvPlgdZ8=;
        b=KP9ABWulKLo8Q+G/LRSmLP7Sk9chgfyL4Bm3WX3U77zbfIbdOsyryyHoXMGqo6rNzb
         IZtbIL+X7NHieILVIKOPKYvho3BveB39x+1KZZz6IfuI6U6q+ZLGc4sQOQYu4TQV1jHx
         XFMHbI92J+jd7rIjra+d8NvXFQE/YOLKN6ESqpIW9IMFNRLoCVX+N4JtkcjUJkG6PESa
         7huslGm8sQ6KFYis/c9oJ/HnBaR/KnTEDXKI+ORb/wEE+TtWaCuZdV7YH4ulxsTkKFD4
         u7NvoDa74kde7iN48plwNQ46hhykvV0nAaTaCVW51/rEd9OgRNXhWhZHooHOfX1/1A6e
         o+mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=q/IG4tajktxIQa8aqHJi11ZrCyXntesR5uZmvPlgdZ8=;
        b=bR1Hiw1TyOChbssS5IzXh6FA6xPRR2GgyOIxlsEP9BfpnYeLJJeNoLV/5EYjrYzAOs
         ROnyAHaHKKbsYCzpkkSy/0rRCjv/MWPy781SRJhfucrc1Fe/G4aH1dbOLd+Cp89MB9D9
         crB5sva2BnYiUxWn7cf6s//Vepe3F0cr/YfYnrV/CoKlK/2hVuR8WpMytwQWOK4kqjqO
         Vxr9t2BZM1vL+HYNBiTdqJtcpuLUzpkOmDb964h5rxob3dU/Dq3liM6fX1iJA8R9mLZd
         aRSUZU4H/Ha7nSdCZVUd7DjI94Na+XI5q2zJ2cCj6oz/SgdVHAdau6EXRtcBopb5/bnK
         i1/Q==
X-Gm-Message-State: AOAM531ubyfo3cnDHAW6fYKkQxMVOmbsF1d9LhQz2AJvbg+OM16YqJKV
        lxaz1XOMqF3qOzI+utMEUxOdZdV5pao=
X-Google-Smtp-Source: ABdhPJzzJ+4xN/tyloeLIw4FVqyxdkgmwHuRSlHjdX0qmbSkVPYcUaW2JBabj7Y1SepktbbaC+hpjg==
X-Received: by 2002:a05:6000:1889:: with SMTP id a9mr44580371wri.141.1625150868146;
        Thu, 01 Jul 2021 07:47:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n7sm9081442wmq.37.2021.07.01.07.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 07:47:47 -0700 (PDT)
Message-Id: <dfcd3e5ac97b9a0834d4d8f28893fbb80c79bf09.1625150864.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
References: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
        <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Jul 2021 14:47:14 +0000
Subject: [PATCH v3 04/34] fsmonitor-ipc: create client routines for
 git-fsmonitor--daemon
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

Create fsmonitor_ipc__*() client routines to spawn the built-in file
system monitor daemon and send it an IPC request using the `Simple
IPC` API.

Stub in empty fsmonitor_ipc__*() functions for unsupported platforms.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 Makefile        |   1 +
 fsmonitor-ipc.c | 179 ++++++++++++++++++++++++++++++++++++++++++++++++
 fsmonitor-ipc.h |  48 +++++++++++++
 3 files changed, 228 insertions(+)
 create mode 100644 fsmonitor-ipc.c
 create mode 100644 fsmonitor-ipc.h

diff --git a/Makefile b/Makefile
index c3565fc0f8f..209c97aa22d 100644
--- a/Makefile
+++ b/Makefile
@@ -893,6 +893,7 @@ LIB_OBJS += fetch-pack.o
 LIB_OBJS += fmt-merge-msg.o
 LIB_OBJS += fsck.o
 LIB_OBJS += fsmonitor.o
+LIB_OBJS += fsmonitor-ipc.o
 LIB_OBJS += gettext.o
 LIB_OBJS += gpg-interface.o
 LIB_OBJS += graph.o
diff --git a/fsmonitor-ipc.c b/fsmonitor-ipc.c
new file mode 100644
index 00000000000..41706972520
--- /dev/null
+++ b/fsmonitor-ipc.c
@@ -0,0 +1,179 @@
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
index 00000000000..837c5e5b64a
--- /dev/null
+++ b/fsmonitor-ipc.h
@@ -0,0 +1,48 @@
+#ifndef FSMONITOR_IPC_H
+#define FSMONITOR_IPC_H
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
+ * This DOES NOT use the hook interface.
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

