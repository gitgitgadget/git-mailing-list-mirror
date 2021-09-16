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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E2CC43219
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 19:54:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD73B61108
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 19:54:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235760AbhIPTzu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 15:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235479AbhIPTzs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Sep 2021 15:55:48 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD06C061574
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 12:54:27 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id q11so11321548wrr.9
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 12:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=wlmdQYlGnREvvhpH9kpcy1hpYBzeAs+xecwc7gpHNgs=;
        b=Kt9k6JhlTZpeLuZUz2u9VljFa1wwcL62lwVI7VrPBXLfkcwRYC6UtTx8FlwukUFBwr
         7md76Q8ZZFBmDXxJSIfas0lTTTAN9aJLQVOIJFUTlHTRPo6Dm+1PZBZ4PNlkTsZ4zkWF
         owbQuX6UNEkLZMI352cDF9GDGebKXzKV9XbOPMS14NgX+teBDFiQNqxtPy32HjBbOcCC
         pq362EjlLNaV4X9Rj8EnDFGlhChZ2Ga+3kuDwFMUTkRokNPrc1WCjDN4X3F0OjjKj9rq
         T384zchmS2skY9P9PJohmwlG8BumQhPNGbe0+4bGjpDug/5toygxL0gPV+dfJ39+Xiyq
         nsmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=wlmdQYlGnREvvhpH9kpcy1hpYBzeAs+xecwc7gpHNgs=;
        b=BStlpHWNbW+QDUF8WHazgzPg2UOJygauN+mbu+zcLXiPhBg9qO/ghi+gJpOwcL5uzz
         sjztmJXqhBKexXqrWzEvJAhFAG6e3SHGFijxeQo2B4x5SRGmA/MgvNt9fK8m+ov2FmEu
         iG2v3KID33ueGpyXpHpYr8sBRuZdHCslMS40edGNLP8EiwA7+D8WcHPQ736p45V0PyQh
         SYBZrhK0jInl+yM/L6FfjxzgAqI4T1T0zRraQakHJoBIwG1jcOmTX4HqynOoCYZF1YTC
         n6rVTe/u3a+z1Bo7RYz8B1dAvcQpoOGFSK7b6OcuBHHrMfGjjSN/LE5JanzL7qEAmjTs
         XXlg==
X-Gm-Message-State: AOAM531EQOtsuo5XmOoBQmRyrK7ZgxZejv+XNGuj8sSzKCrU0e8WfaMd
        2F4kLBDGEjESlj2ZXw98RxJnmN0JXFI=
X-Google-Smtp-Source: ABdhPJwoctLAz0veeLONC32R/LQHR0B//L4Q/L0ZCSxscmyM+cBgcazF+8EoRK6fixZxGv17OIYlXA==
X-Received: by 2002:a5d:4f06:: with SMTP id c6mr7980187wru.384.1631822066012;
        Thu, 16 Sep 2021 12:54:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a10sm4511506wrd.51.2021.09.16.12.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 12:54:25 -0700 (PDT)
Message-Id: <b584f133d280e002a1c05860168c275abb184119.1631822063.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.git.1631822063.gitgitgadget@gmail.com>
References: <pull.1041.git.1631822063.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 16 Sep 2021 19:54:20 +0000
Subject: [PATCH 2/5] fsmonitor-ipc: create client routines for
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

Create fsmonitor_ipc__*() client routines to spawn the built-in file
system monitor daemon and send it an IPC request using the `Simple
IPC` API.

Stub in empty fsmonitor_ipc__*() functions for unsupported platforms.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 Makefile        |   1 +
 fsmonitor-ipc.c | 176 ++++++++++++++++++++++++++++++++++++++++++++++++
 fsmonitor-ipc.h |  48 +++++++++++++
 3 files changed, 225 insertions(+)
 create mode 100644 fsmonitor-ipc.c
 create mode 100644 fsmonitor-ipc.h

diff --git a/Makefile b/Makefile
index 429c276058d..79e72ca9977 100644
--- a/Makefile
+++ b/Makefile
@@ -901,6 +901,7 @@ LIB_OBJS += fetch-pack.o
 LIB_OBJS += fmt-merge-msg.o
 LIB_OBJS += fsck.o
 LIB_OBJS += fsmonitor.o
+LIB_OBJS += fsmonitor-ipc.o
 LIB_OBJS += gettext.o
 LIB_OBJS += gpg-interface.o
 LIB_OBJS += graph.o
diff --git a/fsmonitor-ipc.c b/fsmonitor-ipc.c
new file mode 100644
index 00000000000..ccc32d2a17e
--- /dev/null
+++ b/fsmonitor-ipc.c
@@ -0,0 +1,176 @@
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

