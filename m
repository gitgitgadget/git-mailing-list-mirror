Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 619A8C433E0
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 19:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A76D64EC8
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 19:49:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbhBATtV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 14:49:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232446AbhBATqr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 14:46:47 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED258C061793
        for <git@vger.kernel.org>; Mon,  1 Feb 2021 11:45:59 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id s7so14953681wru.5
        for <git@vger.kernel.org>; Mon, 01 Feb 2021 11:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=YBm/h2Qr2CpzHRGAZM4aCsbcZbWtHUxXCpUESjtEil8=;
        b=CJPDzpq9mfI9g32sGpSQjgHPnsuD4jkZZID8yAjgMAm24WeZWgS2K+NNFErKGlnPjh
         jH0TMVyriabyyO+TDbc3+9n9Sp56mTnycKLEL9OpetMxe2RqA1FRft6foxA1lwjsC5Db
         rqI6/CsSsbu6vVG5xYJ3DA4q4zo8wDoNTnom47iSSGkAGO3moUH+7hTR0QKYaVz1O8Kl
         07EMM5NCHm4DQYM3P+S+eCs1x/BwYEXTRWHh+fzGLb/LQqNc8bL5FJpC0F0q+bxe3qi5
         6QoueKt37pGjlahObQmjPsIbdotKp/4BGizRrnNByYPaAQyOmpM4bbvkh3IUrV+h1gcT
         DC0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=YBm/h2Qr2CpzHRGAZM4aCsbcZbWtHUxXCpUESjtEil8=;
        b=KTyHTtEGooluVtapCuCjGERn7LRBTpoKRnmsX1dR6wxBvUtT2zGJAQZ1d4sLr2NL0q
         5v5O7bmoTXMAof0Z6DRwZiIUKwjE+9wY+w5uGnadjN1RCUAo3RhuUXzRAefCIiBDbLvJ
         wx41nbf9Kfcl7JFzV/XHp5xWddjfE4mBHu9XGOmNQgoMJh11hg8GAP2DPyB9FlyZH5vC
         i/xKjHxkaMwGl1m5UM+ozp9xeSCIHkR3Y88bnMgCEGF0Ppkz2Q6YOC69Tnbfk1p+G72I
         Apnko0uXVk8ZsDfqbzxpTkOKwTbpB2ZJ2tJQADzYwNidmi1QAcf8MNHOl8pCr1q/0+od
         Cggg==
X-Gm-Message-State: AOAM533QRQzqzqHd6d9yTVxDeNep1lTmDfr9HZP0DeSush9QrceFrqFr
        pqwJFUNbEA/eunfU9NlJB1UrpkSpyng=
X-Google-Smtp-Source: ABdhPJyqgDOFNOmt2JPOiv4o2j7f57magwhbT4MWb4RCcm+oV9yu0AurQyxg0uDllo3u39uOZEIKNQ==
X-Received: by 2002:a05:6000:11c5:: with SMTP id i5mr20177647wrx.302.1612208757979;
        Mon, 01 Feb 2021 11:45:57 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p12sm300920wmq.1.2021.02.01.11.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 11:45:57 -0800 (PST)
Message-Id: <f0bebf1cdb31f94cb111df100b3bcb5e2d93a91e.1612208747.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.766.v2.git.1612208747.gitgitgadget@gmail.com>
References: <pull.766.git.1610465492.gitgitgadget@gmail.com>
        <pull.766.v2.git.1612208747.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 01 Feb 2021 19:45:42 +0000
Subject: [PATCH v2 09/14] simple-ipc: add t/helper/test-simple-ipc and t0052
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Jeff King <peff@peff.net>, Chris Torek <chris.torek@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Create unit tests for "simple-ipc".  These are currently only enabled
on Windows.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 Makefile                   |   1 +
 t/helper/test-simple-ipc.c | 485 +++++++++++++++++++++++++++++++++++++
 t/helper/test-tool.c       |   1 +
 t/helper/test-tool.h       |   1 +
 t/t0052-simple-ipc.sh      | 129 ++++++++++
 5 files changed, 617 insertions(+)
 create mode 100644 t/helper/test-simple-ipc.c
 create mode 100755 t/t0052-simple-ipc.sh

diff --git a/Makefile b/Makefile
index c94d5847919..e7ba8853ea6 100644
--- a/Makefile
+++ b/Makefile
@@ -740,6 +740,7 @@ TEST_BUILTINS_OBJS += test-serve-v2.o
 TEST_BUILTINS_OBJS += test-sha1.o
 TEST_BUILTINS_OBJS += test-sha256.o
 TEST_BUILTINS_OBJS += test-sigchain.o
+TEST_BUILTINS_OBJS += test-simple-ipc.o
 TEST_BUILTINS_OBJS += test-strcmp-offset.o
 TEST_BUILTINS_OBJS += test-string-list.o
 TEST_BUILTINS_OBJS += test-submodule-config.o
diff --git a/t/helper/test-simple-ipc.c b/t/helper/test-simple-ipc.c
new file mode 100644
index 00000000000..4960e79cf18
--- /dev/null
+++ b/t/helper/test-simple-ipc.c
@@ -0,0 +1,485 @@
+/*
+ * test-simple-ipc.c: verify that the Inter-Process Communication works.
+ */
+
+#include "test-tool.h"
+#include "cache.h"
+#include "strbuf.h"
+#include "simple-ipc.h"
+#include "parse-options.h"
+#include "thread-utils.h"
+
+#ifndef SUPPORTS_SIMPLE_IPC
+int cmd__simple_ipc(int argc, const char **argv)
+{
+	die("simple IPC not available on this platform");
+}
+#else
+
+/*
+ * The test daemon defines an "application callback" that supports a
+ * series of commands (see `test_app_cb()`).
+ *
+ * Unknown commands are caught here and we send an error message back
+ * to the client process.
+ */
+static int app__unhandled_command(const char *command,
+				  ipc_server_reply_cb *reply_cb,
+				  struct ipc_server_reply_data *reply_data)
+{
+	struct strbuf buf = STRBUF_INIT;
+	int ret;
+
+	strbuf_addf(&buf, "unhandled command: %s", command);
+	ret = reply_cb(reply_data, buf.buf, buf.len);
+	strbuf_release(&buf);
+
+	return ret;
+}
+
+/*
+ * Reply with a single very large buffer.  This is to ensure that
+ * long response are properly handled -- whether the chunking occurs
+ * in the kernel or in the (probably pkt-line) layer.
+ */
+#define BIG_ROWS (10000)
+static int app__big_command(ipc_server_reply_cb *reply_cb,
+			    struct ipc_server_reply_data *reply_data)
+{
+	struct strbuf buf = STRBUF_INIT;
+	int row;
+	int ret;
+
+	for (row = 0; row < BIG_ROWS; row++)
+		strbuf_addf(&buf, "big: %.75d\n", row);
+
+	ret = reply_cb(reply_data, buf.buf, buf.len);
+	strbuf_release(&buf);
+
+	return ret;
+}
+
+/*
+ * Reply with a series of lines.  This is to ensure that we can incrementally
+ * compute the response and chunk it to the client.
+ */
+#define CHUNK_ROWS (10000)
+static int app__chunk_command(ipc_server_reply_cb *reply_cb,
+			      struct ipc_server_reply_data *reply_data)
+{
+	struct strbuf buf = STRBUF_INIT;
+	int row;
+	int ret;
+
+	for (row = 0; row < CHUNK_ROWS; row++) {
+		strbuf_setlen(&buf, 0);
+		strbuf_addf(&buf, "big: %.75d\n", row);
+		ret = reply_cb(reply_data, buf.buf, buf.len);
+	}
+
+	strbuf_release(&buf);
+
+	return ret;
+}
+
+/*
+ * Slowly reply with a series of lines.  This is to model an expensive to
+ * compute chunked response (which might happen if this callback is running
+ * in a thread and is fighting for a lock with other threads).
+ */
+#define SLOW_ROWS     (1000)
+#define SLOW_DELAY_MS (10)
+static int app__slow_command(ipc_server_reply_cb *reply_cb,
+			     struct ipc_server_reply_data *reply_data)
+{
+	struct strbuf buf = STRBUF_INIT;
+	int row;
+	int ret;
+
+	for (row = 0; row < SLOW_ROWS; row++) {
+		strbuf_setlen(&buf, 0);
+		strbuf_addf(&buf, "big: %.75d\n", row);
+		ret = reply_cb(reply_data, buf.buf, buf.len);
+		sleep_millisec(SLOW_DELAY_MS);
+	}
+
+	strbuf_release(&buf);
+
+	return ret;
+}
+
+/*
+ * The client sent a command followed by a (possibly very) large buffer.
+ */
+static int app__sendbytes_command(const char *received,
+				  ipc_server_reply_cb *reply_cb,
+				  struct ipc_server_reply_data *reply_data)
+{
+	struct strbuf buf_resp = STRBUF_INIT;
+	const char *p = "?";
+	int len_ballast = 0;
+	int k;
+	int errs = 0;
+	int ret;
+
+	if (skip_prefix(received, "sendbytes ", &p))
+		len_ballast = strlen(p);
+
+	/*
+	 * Verify that the ballast is n copies of a single letter.
+	 * And that the multi-threaded IO layer didn't cross the streams.
+	 */
+	for (k = 1; k < len_ballast; k++)
+		if (p[k] != p[0])
+			errs++;
+
+	if (errs)
+		strbuf_addf(&buf_resp, "errs:%d\n", errs);
+	else
+		strbuf_addf(&buf_resp, "rcvd:%c%08d\n", p[0], len_ballast);
+
+	ret = reply_cb(reply_data, buf_resp.buf, buf_resp.len);
+
+	strbuf_release(&buf_resp);
+
+	return ret;
+}
+
+/*
+ * An arbitrary fixed address to verify that the application instance
+ * data is handled properly.
+ */
+static int my_app_data = 42;
+
+static ipc_server_application_cb test_app_cb;
+
+/*
+ * This is "application callback" that sits on top of the "ipc-server".
+ * It completely defines the set of command verbs supported by this
+ * application.
+ */
+static int test_app_cb(void *application_data,
+		       const char *command,
+		       ipc_server_reply_cb *reply_cb,
+		       struct ipc_server_reply_data *reply_data)
+{
+	/*
+	 * Verify that we received the application-data that we passed
+	 * when we started the ipc-server.  (We have several layers of
+	 * callbacks calling callbacks and it's easy to get things mixed
+	 * up (especially when some are "void*").)
+	 */
+	if (application_data != (void*)&my_app_data)
+		BUG("application_cb: application_data pointer wrong");
+
+	if (!strcmp(command, "quit")) {
+		/*
+		 * Tell ipc-server to hangup with an empty reply.
+		 */
+		return SIMPLE_IPC_QUIT;
+	}
+
+	if (!strcmp(command, "ping")) {
+		const char *answer = "pong";
+		return reply_cb(reply_data, answer, strlen(answer));
+	}
+
+	if (!strcmp(command, "big"))
+		return app__big_command(reply_cb, reply_data);
+
+	if (!strcmp(command, "chunk"))
+		return app__chunk_command(reply_cb, reply_data);
+
+	if (!strcmp(command, "slow"))
+		return app__slow_command(reply_cb, reply_data);
+
+	if (starts_with(command, "sendbytes "))
+		return app__sendbytes_command(command, reply_cb, reply_data);
+
+	return app__unhandled_command(command, reply_cb, reply_data);
+}
+
+/*
+ * This process will run as a simple-ipc server and listen for IPC commands
+ * from client processes.
+ */
+static int daemon__run_server(const char *path, int argc, const char **argv)
+{
+	struct ipc_server_opts opts = {
+		.nr_threads = 5
+	};
+
+	const char * const daemon_usage[] = {
+		N_("test-helper simple-ipc daemon [<options>"),
+		NULL
+	};
+	struct option daemon_options[] = {
+		OPT_INTEGER(0, "threads", &opts.nr_threads,
+			    N_("number of threads in server thread pool")),
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, NULL, daemon_options, daemon_usage, 0);
+
+	if (opts.nr_threads < 1)
+		opts.nr_threads = 1;
+
+	/*
+	 * Synchronously run the ipc-server.  We don't need any application
+	 * instance data, so pass an arbitrary pointer (that we'll later
+	 * verify made the round trip).
+	 */
+	return ipc_server_run(path, &opts, test_app_cb, (void*)&my_app_data);
+}
+
+/*
+ * This process will run a quick probe to see if a simple-ipc server
+ * is active on this path.
+ *
+ * Returns 0 if the server is alive.
+ */
+static int client__probe_server(const char *path)
+{
+	enum ipc_active_state s;
+
+	s = ipc_get_active_state(path);
+	switch (s) {
+	case IPC_STATE__LISTENING:
+		return 0;
+
+	case IPC_STATE__NOT_LISTENING:
+		return error("no server listening at '%s'", path);
+
+	case IPC_STATE__PATH_NOT_FOUND:
+		return error("path not found '%s'", path);
+
+	case IPC_STATE__INVALID_PATH:
+		return error("invalid pipe/socket name '%s'", path);
+
+	case IPC_STATE__OTHER_ERROR:
+	default:
+		return error("other error for '%s'", path);
+	}
+}
+
+/*
+ * Send an IPC command to an already-running server daemon and print the
+ * response.
+ *
+ * argv[2] contains a simple (1 word) command verb that `test_app_cb()`
+ * (in the daemon process) will understand.
+ */
+static int client__send_ipc(int argc, const char **argv, const char *path)
+{
+	const char *command = argc > 2 ? argv[2] : "(no command)";
+	struct strbuf buf = STRBUF_INIT;
+	struct ipc_client_connect_options options
+		= IPC_CLIENT_CONNECT_OPTIONS_INIT;
+
+	options.wait_if_busy = 1;
+	options.wait_if_not_found = 0;
+
+	if (!ipc_client_send_command(path, &options, command, &buf)) {
+		printf("%s\n", buf.buf);
+		fflush(stdout);
+		strbuf_release(&buf);
+
+		return 0;
+	}
+
+	return error("failed to send '%s' to '%s'", command, path);
+}
+
+/*
+ * Send an IPC command followed by ballast to confirm that a large
+ * message can be sent and that the kernel or pkt-line layers will
+ * properly chunk it and that the daemon receives the entire message.
+ */
+static int do_sendbytes(int bytecount, char byte, const char *path)
+{
+	struct strbuf buf_send = STRBUF_INIT;
+	struct strbuf buf_resp = STRBUF_INIT;
+	struct ipc_client_connect_options options
+		= IPC_CLIENT_CONNECT_OPTIONS_INIT;
+
+	options.wait_if_busy = 1;
+	options.wait_if_not_found = 0;
+
+	strbuf_addstr(&buf_send, "sendbytes ");
+	strbuf_addchars(&buf_send, byte, bytecount);
+
+	if (!ipc_client_send_command(path, &options, buf_send.buf, &buf_resp)) {
+		strbuf_rtrim(&buf_resp);
+		printf("sent:%c%08d %s\n", byte, bytecount, buf_resp.buf);
+		fflush(stdout);
+		strbuf_release(&buf_send);
+		strbuf_release(&buf_resp);
+
+		return 0;
+	}
+
+	return error("client failed to sendbytes(%d, '%c') to '%s'",
+		     bytecount, byte, path);
+}
+
+/*
+ * Send an IPC command with ballast to an already-running server daemon.
+ */
+static int client__sendbytes(int argc, const char **argv, const char *path)
+{
+	int bytecount = 1024;
+	char *string = "x";
+	const char * const sendbytes_usage[] = {
+		N_("test-helper simple-ipc sendbytes [<options>]"),
+		NULL
+	};
+	struct option sendbytes_options[] = {
+		OPT_INTEGER(0, "bytecount", &bytecount, N_("number of bytes")),
+		OPT_STRING(0, "byte", &string, N_("byte"), N_("ballast")),
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, NULL, sendbytes_options, sendbytes_usage, 0);
+
+	return do_sendbytes(bytecount, string[0], path);
+}
+
+struct multiple_thread_data {
+	pthread_t pthread_id;
+	struct multiple_thread_data *next;
+	const char *path;
+	int bytecount;
+	int batchsize;
+	int sum_errors;
+	int sum_good;
+	char letter;
+};
+
+static void *multiple_thread_proc(void *_multiple_thread_data)
+{
+	struct multiple_thread_data *d = _multiple_thread_data;
+	int k;
+
+	trace2_thread_start("multiple");
+
+	for (k = 0; k < d->batchsize; k++) {
+		if (do_sendbytes(d->bytecount + k, d->letter, d->path))
+			d->sum_errors++;
+		else
+			d->sum_good++;
+	}
+
+	trace2_thread_exit();
+	return NULL;
+}
+
+/*
+ * Start a client-side thread pool.  Each thread sends a series of
+ * IPC requests.  Each request is on a new connection to the server.
+ */
+static int client__multiple(int argc, const char **argv, const char *path)
+{
+	struct multiple_thread_data *list = NULL;
+	int k;
+	int nr_threads = 5;
+	int bytecount = 1;
+	int batchsize = 10;
+	int sum_join_errors = 0;
+	int sum_thread_errors = 0;
+	int sum_good = 0;
+
+	const char * const multiple_usage[] = {
+		N_("test-helper simple-ipc multiple [<options>]"),
+		NULL
+	};
+	struct option multiple_options[] = {
+		OPT_INTEGER(0, "bytecount", &bytecount, N_("number of bytes")),
+		OPT_INTEGER(0, "threads", &nr_threads, N_("number of threads")),
+		OPT_INTEGER(0, "batchsize", &batchsize, N_("number of requests per thread")),
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, NULL, multiple_options, multiple_usage, 0);
+
+	if (bytecount < 1)
+		bytecount = 1;
+	if (nr_threads < 1)
+		nr_threads = 1;
+	if (batchsize < 1)
+		batchsize = 1;
+
+	for (k = 0; k < nr_threads; k++) {
+		struct multiple_thread_data *d = xcalloc(1, sizeof(*d));
+		d->next = list;
+		d->path = path;
+		d->bytecount = bytecount + batchsize*(k/26);
+		d->batchsize = batchsize;
+		d->sum_errors = 0;
+		d->sum_good = 0;
+		d->letter = 'A' + (k % 26);
+
+		if (pthread_create(&d->pthread_id, NULL, multiple_thread_proc, d)) {
+			warning("failed to create thread[%d] skipping remainder", k);
+			free(d);
+			break;
+		}
+
+		list = d;
+	}
+
+	while (list) {
+		struct multiple_thread_data *d = list;
+
+		if (pthread_join(d->pthread_id, NULL))
+			sum_join_errors++;
+
+		sum_thread_errors += d->sum_errors;
+		sum_good += d->sum_good;
+
+		list = d->next;
+		free(d);
+	}
+
+	printf("client (good %d) (join %d), (errors %d)\n",
+	       sum_good, sum_join_errors, sum_thread_errors);
+
+	return (sum_join_errors + sum_thread_errors) ? 1 : 0;
+}
+
+int cmd__simple_ipc(int argc, const char **argv)
+{
+	const char *path = "ipc-test";
+
+	if (argc == 2 && !strcmp(argv[1], "SUPPORTS_SIMPLE_IPC"))
+		return 0;
+
+	/* Use '!!' on all dispatch functions to map from `error()` style
+	 * (returns -1) style to `test_must_fail` style (expects 1) and
+	 * get less confusing shell error messages.
+	 */
+
+	if (argc == 2 && !strcmp(argv[1], "is-active"))
+		return !!client__probe_server(path);
+
+	if (argc >= 2 && !strcmp(argv[1], "daemon"))
+		return !!daemon__run_server(path, argc, argv);
+
+	/*
+	 * Client commands follow.  Ensure a server is running before
+	 * going any further.
+	 */
+	if (client__probe_server(path))
+		return 1;
+
+	if ((argc == 2 || argc == 3) && !strcmp(argv[1], "send"))
+		return !!client__send_ipc(argc, argv, path);
+
+	if (argc >= 2 && !strcmp(argv[1], "sendbytes"))
+		return !!client__sendbytes(argc, argv, path);
+
+	if (argc >= 2 && !strcmp(argv[1], "multiple"))
+		return !!client__multiple(argc, argv, path);
+
+	die("Unhandled argv[1]: '%s'", argv[1]);
+}
+#endif
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 9d6d14d9293..a409655f03b 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -64,6 +64,7 @@ static struct test_cmd cmds[] = {
 	{ "sha1", cmd__sha1 },
 	{ "sha256", cmd__sha256 },
 	{ "sigchain", cmd__sigchain },
+	{ "simple-ipc", cmd__simple_ipc },
 	{ "strcmp-offset", cmd__strcmp_offset },
 	{ "string-list", cmd__string_list },
 	{ "submodule-config", cmd__submodule_config },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index a6470ff62c4..564eb3c8e91 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -54,6 +54,7 @@ int cmd__sha1(int argc, const char **argv);
 int cmd__oid_array(int argc, const char **argv);
 int cmd__sha256(int argc, const char **argv);
 int cmd__sigchain(int argc, const char **argv);
+int cmd__simple_ipc(int argc, const char **argv);
 int cmd__strcmp_offset(int argc, const char **argv);
 int cmd__string_list(int argc, const char **argv);
 int cmd__submodule_config(int argc, const char **argv);
diff --git a/t/t0052-simple-ipc.sh b/t/t0052-simple-ipc.sh
new file mode 100755
index 00000000000..69588354545
--- /dev/null
+++ b/t/t0052-simple-ipc.sh
@@ -0,0 +1,129 @@
+#!/bin/sh
+
+test_description='simple command server'
+
+. ./test-lib.sh
+
+test-tool simple-ipc SUPPORTS_SIMPLE_IPC || {
+	skip_all='simple IPC not supported on this platform'
+	test_done
+}
+
+stop_simple_IPC_server () {
+	test -n "$SIMPLE_IPC_PID" || return 0
+
+	kill "$SIMPLE_IPC_PID" &&
+	SIMPLE_IPC_PID=
+}
+
+test_expect_success 'start simple command server' '
+	{ test-tool simple-ipc daemon --threads=8 & } &&
+	SIMPLE_IPC_PID=$! &&
+	test_atexit stop_simple_IPC_server &&
+
+	sleep 1 &&
+
+	test-tool simple-ipc is-active
+'
+
+test_expect_success 'simple command server' '
+	test-tool simple-ipc send ping >actual &&
+	echo pong >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'servers cannot share the same path' '
+	test_must_fail test-tool simple-ipc daemon &&
+	test-tool simple-ipc is-active
+'
+
+test_expect_success 'big response' '
+	test-tool simple-ipc send big >actual &&
+	test_line_count -ge 10000 actual &&
+	grep -q "big: [0]*9999\$" actual
+'
+
+test_expect_success 'chunk response' '
+	test-tool simple-ipc send chunk >actual &&
+	test_line_count -ge 10000 actual &&
+	grep -q "big: [0]*9999\$" actual
+'
+
+test_expect_success 'slow response' '
+	test-tool simple-ipc send slow >actual &&
+	test_line_count -ge 100 actual &&
+	grep -q "big: [0]*99\$" actual
+'
+
+# Send an IPC with n=100,000 bytes of ballast.  This should be large enough
+# to force both the kernel and the pkt-line layer to chunk the message to the
+# daemon and for the daemon to receive it in chunks.
+#
+test_expect_success 'sendbytes' '
+	test-tool simple-ipc sendbytes --bytecount=100000 --byte=A >actual &&
+	grep "sent:A00100000 rcvd:A00100000" actual
+'
+
+# Start a series of <threads> client threads that each make <batchsize>
+# IPC requests to the server.  Each (<threads> * <batchsize>) request
+# will open a new connection to the server and randomly bind to a server
+# thread.  Each client thread exits after completing its batch.  So the
+# total number of live client threads will be smaller than the total.
+# Each request will send a message containing at least <bytecount> bytes
+# of ballast.  (Responses are small.)
+#
+# The purpose here is to test threading in the server and responding to
+# many concurrent client requests (regardless of whether they come from
+# 1 client process or many).  And to test that the server side of the
+# named pipe/socket is stable.  (On Windows this means that the server
+# pipe is properly recycled.)
+#
+# On Windows it also lets us adjust the connection timeout in the
+# `ipc_client_send_command()`.
+#
+# Note it is easy to drive the system into failure by requesting an
+# insane number of threads on client or server and/or increasing the
+# per-thread batchsize or the per-request bytecount (ballast).
+# On Windows these failures look like "pipe is busy" errors.
+# So I've chosen fairly conservative values for now.
+#
+# We expect output of the form "sent:<letter><length> ..."
+# With terms (7, 19, 13) we expect:
+#   <letter> in [A-G]
+#   <length> in [19+0 .. 19+(13-1)]
+# and (7 * 13) successful responses.
+#
+test_expect_success 'stress test threads' '
+	test-tool simple-ipc multiple \
+		--threads=7 \
+		--bytecount=19 \
+		--batchsize=13 \
+		>actual &&
+	test_line_count = 92 actual &&
+	grep "good 91" actual &&
+	grep "sent:A" <actual >actual_a &&
+	cat >expect_a <<-EOF &&
+		sent:A00000019 rcvd:A00000019
+		sent:A00000020 rcvd:A00000020
+		sent:A00000021 rcvd:A00000021
+		sent:A00000022 rcvd:A00000022
+		sent:A00000023 rcvd:A00000023
+		sent:A00000024 rcvd:A00000024
+		sent:A00000025 rcvd:A00000025
+		sent:A00000026 rcvd:A00000026
+		sent:A00000027 rcvd:A00000027
+		sent:A00000028 rcvd:A00000028
+		sent:A00000029 rcvd:A00000029
+		sent:A00000030 rcvd:A00000030
+		sent:A00000031 rcvd:A00000031
+	EOF
+	test_cmp expect_a actual_a
+'
+
+test_expect_success '`quit` works' '
+	test-tool simple-ipc send quit &&
+	test_must_fail test-tool simple-ipc is-active &&
+	test_must_fail test-tool simple-ipc send ping
+'
+
+test_done
-- 
gitgitgadget

