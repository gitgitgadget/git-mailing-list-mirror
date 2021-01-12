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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3323C4332D
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 15:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 841E423131
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 15:32:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391411AbhALPce (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 10:32:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390853AbhALPce (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 10:32:34 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C754BC0617A7
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 07:31:44 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id g10so754933wmh.2
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 07:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9HXFQrxJfp/6g8c3JN4p4DCLEVDp2AADbHfDuC7ui/8=;
        b=XXg1SiPFyWVB2WcygUfHwtAHtfteRsrXRFKMPXdB8ae2sGkrQMkpdCgW4pK2zWmKVf
         +MKo2XkvvbwWl2kQ55wFShykfmOe8PyZKTIkMZqA/2tZuL9SNNiGxdY4AiSOWJ7qnDWN
         im8FHdZO+mpRSBQC9pP1LfdrseO7fwbAfcKriXJJBPWOjLF1FV55vR+Jjc7L0Sl27YSC
         VhOU3shwMBbsldhnpi/yJiHZaEAY16I6rIBcBHaQrFvyMm+i+olTEb1HTBozO9rZH0Wa
         jLjcg+rDOLN5GJhoBAeh71f2h173ms7SQTbVIa4TnCVAPnW5k70cT1A4x5bj1NGUFBkK
         jP+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=9HXFQrxJfp/6g8c3JN4p4DCLEVDp2AADbHfDuC7ui/8=;
        b=S0TK6dO83iKFDbRitvVoQ1VtaZEXuduxYjEX/k7sQjK5caMCfOzMT7XxbQIfFanAnu
         0bc58v3Fndg2uIB2YqO4BdGMoeTWnDiGo1EU/sPrdcKc8nBZNbGokIRs0V0lPDSqXTXD
         AxJ7N9jhc426iDBlo1C4AxvGZw6KPcQw9oEhpcTZsQ7wM6DWX1Mc8TbGGb/KGCRkfKAj
         Qb4GtnVrPSMzF1+ii1ModF+Dy1FGtqtAlteIBEPL24jpsbkf3y19RqoZWj0kzNNdeRPz
         w/KtEpvqqINvteGJeWcyKi6pnXRwjN/tjBqD6EEBX9sMDUQeiPQMC1UMd2ucTuyXBAlN
         Y98w==
X-Gm-Message-State: AOAM533W9tyTSQ1qkiLq36IHfK5/HhdbfssLUflytyBLe9Ymgv5UO05Y
        Zsu2yYHHnbach0xDSRtW1aPRFL2JQoY=
X-Google-Smtp-Source: ABdhPJwCwxvAICt0wtwRW9zjL8261zDM3dpDNBCaQKC07HQQAewwYwtRmHnuOgo4R9dYLMPWS6o2Hg==
X-Received: by 2002:a7b:cc94:: with SMTP id p20mr4096576wma.22.1610465502705;
        Tue, 12 Jan 2021 07:31:42 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s6sm6094397wro.79.2021.01.12.07.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 07:31:42 -0800 (PST)
Message-Id: <a1b15fb5cb0f09fd77ff95331b37ec18f13a540c.1610465493.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.766.git.1610465492.gitgitgadget@gmail.com>
References: <pull.766.git.1610465492.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 12 Jan 2021 15:31:32 +0000
Subject: [PATCH 10/10] simple-ipc: add Unix domain socket implementation
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

Create Unix domain socket based implementation of "simple-ipc".

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 Makefile                            |    2 +
 compat/simple-ipc/ipc-unix-socket.c | 1093 +++++++++++++++++++++++++++
 contrib/buildsystems/CMakeLists.txt |    2 +
 simple-ipc.h                        |    7 +-
 4 files changed, 1103 insertions(+), 1 deletion(-)
 create mode 100644 compat/simple-ipc/ipc-unix-socket.c

diff --git a/Makefile b/Makefile
index e7ba8853ea6..f2524c02ff0 100644
--- a/Makefile
+++ b/Makefile
@@ -1681,6 +1681,8 @@ ifdef NO_UNIX_SOCKETS
 	BASIC_CFLAGS += -DNO_UNIX_SOCKETS
 else
 	LIB_OBJS += unix-socket.o
+	LIB_OBJS += compat/simple-ipc/ipc-shared.o
+	LIB_OBJS += compat/simple-ipc/ipc-unix-socket.o
 endif
 
 ifdef USE_WIN32_IPC
diff --git a/compat/simple-ipc/ipc-unix-socket.c b/compat/simple-ipc/ipc-unix-socket.c
new file mode 100644
index 00000000000..be100049e4b
--- /dev/null
+++ b/compat/simple-ipc/ipc-unix-socket.c
@@ -0,0 +1,1093 @@
+#include "cache.h"
+#include "simple-ipc.h"
+#include "strbuf.h"
+#include "pkt-line.h"
+#include "thread-utils.h"
+#include "unix-socket.h"
+
+#ifdef NO_UNIX_SOCKETS
+#error compat/simple-ipc/ipc-unix-socket.c requires Unix sockets
+#endif
+
+enum ipc_active_state ipc_get_active_state(const char *path)
+{
+	enum ipc_active_state state = IPC_STATE__OTHER_ERROR;
+	struct ipc_client_connect_options options
+		= IPC_CLIENT_CONNECT_OPTIONS_INIT;
+	struct stat st;
+	int fd_test = -1;
+
+	options.wait_if_busy = 0;
+	options.wait_if_not_found = 0;
+
+	if (lstat(path, &st) == -1) {
+		switch (errno) {
+		case ENOENT:
+		case ENOTDIR:
+			return IPC_STATE__NOT_LISTENING;
+		default:
+			return IPC_STATE__INVALID_PATH;
+		}
+	}
+
+	/* also complain if a plain file is in the way */
+	if ((st.st_mode & S_IFMT) != S_IFSOCK)
+		return IPC_STATE__INVALID_PATH;
+
+	/*
+	 * Just because the filesystem has a S_IFSOCK type inode
+	 * at `path`, doesn't mean it that there is a server listening.
+	 * Ping it to be sure.
+	 */
+	state = ipc_client_try_connect(path, &options, &fd_test);
+	close(fd_test);
+
+	return state;
+}
+
+/*
+ * This value was chosen at random.
+ */
+#define WAIT_STEP_MS (50)
+
+/*
+ * Try to connect to the server.  If the server is just starting up or
+ * is very busy, we may not get a connection the first time.
+ */
+static enum ipc_active_state connect_to_server(
+	const char *path,
+	int timeout_ms,
+	const struct ipc_client_connect_options *options,
+	int *pfd)
+{
+	int wait_ms = 50;
+	int k;
+
+	*pfd = -1;
+
+	for (k = 0; k < timeout_ms; k += wait_ms) {
+		int fd = unix_stream_connect(path);
+
+		if (fd != -1) {
+			*pfd = fd;
+			return IPC_STATE__LISTENING;
+		}
+
+		if (errno == ENOENT) {
+			if (!options->wait_if_not_found)
+				return IPC_STATE__PATH_NOT_FOUND;
+
+			goto sleep_and_try_again;
+		}
+
+		if (errno == ETIMEDOUT) {
+			if (!options->wait_if_busy)
+				return IPC_STATE__NOT_LISTENING;
+
+			goto sleep_and_try_again;
+		}
+
+		if (errno == ECONNREFUSED) {
+			if (!options->wait_if_busy)
+				return IPC_STATE__NOT_LISTENING;
+
+			goto sleep_and_try_again;
+		}
+
+		return IPC_STATE__OTHER_ERROR;
+
+	sleep_and_try_again:
+		sleep_millisec(wait_ms);
+	}
+
+	return IPC_STATE__NOT_LISTENING;
+}
+
+/*
+ * A randomly chosen timeout value.
+ */
+#define MY_CONNECTION_TIMEOUT_MS (1000)
+
+enum ipc_active_state ipc_client_try_connect(
+	const char *path,
+	const struct ipc_client_connect_options *options,
+	int *pfd)
+{
+	enum ipc_active_state state = IPC_STATE__OTHER_ERROR;
+
+	*pfd = -1;
+
+	trace2_region_enter("ipc-client", "try-connect", NULL);
+	trace2_data_string("ipc-client", NULL, "try-connect/path", path);
+
+	state = connect_to_server(path, MY_CONNECTION_TIMEOUT_MS,
+				  options, pfd);
+
+	trace2_data_intmax("ipc-client", NULL, "try-connect/state",
+			   (intmax_t)state);
+	trace2_region_leave("ipc-client", "try-connect", NULL);
+	return state;
+}
+
+int ipc_client_send_command_to_fd(int fd, const char *message,
+				  struct strbuf *answer)
+{
+	int ret = 0;
+
+	strbuf_setlen(answer, 0);
+
+	trace2_region_enter("ipc-client", "send-command", NULL);
+
+	if (write_packetized_from_buf(message, strlen(message), fd, 1) < 0) {
+		ret = error(_("could not send IPC command"));
+		goto done;
+	}
+
+	if (read_packetized_to_strbuf(fd, answer, PACKET_READ_NEVER_DIE) < 0) {
+		ret = error(_("could not read IPC response"));
+		goto done;
+	}
+
+done:
+	trace2_region_leave("ipc-client", "send-command", NULL);
+	return ret;
+}
+
+int ipc_client_send_command(const char *path,
+			    const struct ipc_client_connect_options *options,
+			    const char *message, struct strbuf *answer)
+{
+	int fd;
+	int ret = -1;
+	enum ipc_active_state state;
+
+	state = ipc_client_try_connect(path, options, &fd);
+
+	if (state != IPC_STATE__LISTENING)
+		return ret;
+
+	ret = ipc_client_send_command_to_fd(fd, message, answer);
+	close(fd);
+	return ret;
+}
+
+static int set_socket_blocking_flag(int fd, int make_nonblocking)
+{
+	int flags;
+
+	flags = fcntl(fd, F_GETFL, NULL);
+
+	if (flags < 0)
+		return -1;
+
+	if (make_nonblocking)
+		flags |= O_NONBLOCK;
+	else
+		flags &= ~O_NONBLOCK;
+
+	return fcntl(fd, F_SETFL, flags);
+}
+
+/*
+ * Magic numbers used to annotate callback instance data.
+ * These are used to help guard against accidentally passing the
+ * wrong instance data across multiple levels of callbacks (which
+ * is easy to do if there are `void*` arguments).
+ */
+enum magic {
+	MAGIC_SERVER_REPLY_DATA,
+	MAGIC_WORKER_THREAD_DATA,
+	MAGIC_ACCEPT_THREAD_DATA,
+	MAGIC_SERVER_DATA,
+};
+
+struct ipc_server_reply_data {
+	enum magic magic;
+	int fd;
+	struct ipc_worker_thread_data *worker_thread_data;
+};
+
+struct ipc_worker_thread_data {
+	enum magic magic;
+	struct ipc_worker_thread_data *next_thread;
+	struct ipc_server_data *server_data;
+	pthread_t pthread_id;
+};
+
+struct ipc_accept_thread_data {
+	enum magic magic;
+	struct ipc_server_data *server_data;
+	int fd_listen;
+	ino_t inode_listen;
+	int fd_send_shutdown;
+	int fd_wait_shutdown;
+	pthread_t pthread_id;
+};
+
+/*
+ * With unix-sockets, the conceptual "ipc-server" is implemented as a single
+ * controller "accept-thread" thread and a pool of "worker-thread" threads.
+ * The former does the usual `accept()` loop and dispatches connections
+ * to an idle worker thread.  The worker threads wait in an idle loop for
+ * a new connection, communicate with the client and relay data to/from
+ * the `application_cb` and then wait for another connection from the
+ * server thread.  This avoids the overhead of constantly creating and
+ * destroying threads.
+ */
+struct ipc_server_data {
+	enum magic magic;
+	ipc_server_application_cb *application_cb;
+	void *application_data;
+	struct strbuf buf_path;
+
+	struct ipc_accept_thread_data *accept_thread;
+	struct ipc_worker_thread_data *worker_thread_list;
+
+	pthread_mutex_t work_available_mutex;
+	pthread_cond_t work_available_cond;
+
+	/*
+	 * Accepted but not yet processed client connections are kept
+	 * in a circular buffer FIFO.  The queue is empty when the
+	 * positions are equal.
+	 */
+	int *fifo_fds;
+	int queue_size;
+	int back_pos;
+	int front_pos;
+
+	int shutdown_requested;
+	int is_stopped;
+};
+
+/*
+ * Remove and return the oldest queued connection.
+ *
+ * Returns -1 if empty.
+ */
+static int fifo_dequeue(struct ipc_server_data *server_data)
+{
+	/* ASSERT holding mutex */
+
+	int fd;
+
+	if (server_data->back_pos == server_data->front_pos)
+		return -1;
+
+	fd = server_data->fifo_fds[server_data->front_pos];
+	server_data->fifo_fds[server_data->front_pos] = -1;
+
+	server_data->front_pos++;
+	if (server_data->front_pos == server_data->queue_size)
+		server_data->front_pos = 0;
+
+	return fd;
+}
+
+/*
+ * Push a new fd onto the back of the queue.
+ *
+ * Drop it and return -1 if queue is already full.
+ */
+static int fifo_enqueue(struct ipc_server_data *server_data, int fd)
+{
+	/* ASSERT holding mutex */
+
+	int next_back_pos;
+
+	next_back_pos = server_data->back_pos + 1;
+	if (next_back_pos == server_data->queue_size)
+		next_back_pos = 0;
+
+	if (next_back_pos == server_data->front_pos) {
+		/* Queue is full. Just drop it. */
+		close(fd);
+		return -1;
+	}
+
+	server_data->fifo_fds[server_data->back_pos] = fd;
+	server_data->back_pos = next_back_pos;
+
+	return fd;
+}
+
+/*
+ * Wait for a connection to be queued to the FIFO and return it.
+ *
+ * Returns -1 if someone has already requested a shutdown.
+ */
+static int worker_thread__wait_for_connection(
+	struct ipc_worker_thread_data *worker_thread_data)
+{
+	/* ASSERT NOT holding mutex */
+
+	struct ipc_server_data *server_data = worker_thread_data->server_data;
+	int fd = -1;
+
+	pthread_mutex_lock(&server_data->work_available_mutex);
+	for (;;) {
+		if (server_data->shutdown_requested)
+			break;
+
+		fd = fifo_dequeue(server_data);
+		if (fd >= 0)
+			break;
+
+		pthread_cond_wait(&server_data->work_available_cond,
+				  &server_data->work_available_mutex);
+	}
+	pthread_mutex_unlock(&server_data->work_available_mutex);
+
+	return fd;
+}
+
+/*
+ * Forward declare our reply callback function so that any compiler
+ * errors are reported when we actually define the function (in addition
+ * to any errors reported when we try to pass this callback function as
+ * a parameter in a function call).  The former are easier to understand.
+ */
+static ipc_server_reply_cb do_io_reply_callback;
+
+/*
+ * Relay application's response message to the client process.
+ * (We do not flush at this point because we allow the caller
+ * to chunk data to the client thru us.)
+ */
+static int do_io_reply_callback(struct ipc_server_reply_data *reply_data,
+		       const char *response, size_t response_len)
+{
+	if (reply_data->magic != MAGIC_SERVER_REPLY_DATA)
+		BUG("reply_cb called with wrong instance data");
+
+	return write_packetized_from_buf(response, response_len,
+					 reply_data->fd, 0);
+}
+
+/* A randomly chosen value. */
+#define MY_WAIT_POLL_TIMEOUT_MS (10)
+
+/*
+ * If the client hangs up without sending any data on the wire, just
+ * quietly close the socket and ignore this client.
+ *
+ * This worker thread is committed to reading the IPC request data
+ * from the client at the other end of this fd.  Wait here for the
+ * client to actually put something on the wire -- because if the
+ * client just does a ping (connect and hangup without sending any
+ * data), our use of the pkt-line read routines will spew an error
+ * message.
+ *
+ * Return -1 if the client hung up.
+ * Return 0 if data (possibly incomplete) is ready.
+ */
+static int worker_thread__wait_for_io_start(
+	struct ipc_worker_thread_data *worker_thread_data,
+	int fd)
+{
+	struct ipc_server_data *server_data = worker_thread_data->server_data;
+	struct pollfd pollfd[1];
+	int result;
+
+	for (;;) {
+		pollfd[0].fd = fd;
+		pollfd[0].events = POLLIN;
+
+		result = poll(pollfd, 1, MY_WAIT_POLL_TIMEOUT_MS);
+		if (result < 0) {
+			if (errno == EINTR)
+				continue;
+			goto cleanup;
+		}
+
+		if (result == 0) {
+			/* a timeout */
+
+			int in_shutdown;
+
+			pthread_mutex_lock(&server_data->work_available_mutex);
+			in_shutdown = server_data->shutdown_requested;
+			pthread_mutex_unlock(&server_data->work_available_mutex);
+
+			/*
+			 * If a shutdown is already in progress and this
+			 * client has not started talking yet, just drop it.
+			 */
+			if (in_shutdown)
+				goto cleanup;
+			continue;
+		}
+
+		if (pollfd[0].revents & POLLHUP)
+			goto cleanup;
+
+		if (pollfd[0].revents & POLLIN)
+			return 0;
+
+		goto cleanup;
+	}
+
+cleanup:
+	close(fd);
+	return -1;
+}
+
+/*
+ * Receive the request/command from the client and pass it to the
+ * registered request-callback.  The request-callback will compose
+ * a response and call our reply-callback to send it to the client.
+ */
+static int worker_thread__do_io(
+	struct ipc_worker_thread_data *worker_thread_data,
+	int fd)
+{
+	/* ASSERT NOT holding lock */
+
+	struct strbuf buf = STRBUF_INIT;
+	struct ipc_server_reply_data reply_data;
+	int ret = 0;
+
+	reply_data.magic = MAGIC_SERVER_REPLY_DATA;
+	reply_data.worker_thread_data = worker_thread_data;
+
+	reply_data.fd = fd;
+
+	ret = read_packetized_to_strbuf(reply_data.fd, &buf,
+					PACKET_READ_NEVER_DIE);
+	if (ret >= 0) {
+		ret = worker_thread_data->server_data->application_cb(
+			worker_thread_data->server_data->application_data,
+			buf.buf, do_io_reply_callback, &reply_data);
+
+		packet_flush_gently(reply_data.fd);
+	}
+	else {
+		/*
+		 * The client probably disconnected/shutdown before it
+		 * could send a well-formed message.  Ignore it.
+		 */
+	}
+
+	strbuf_release(&buf);
+	close(reply_data.fd);
+
+	return ret;
+}
+
+/*
+ * Block SIGPIPE on the current thread (so that we get EPIPE from
+ * write() rather than an actual signal).
+ *
+ * Note that using sigchain_push() and _pop() to control SIGPIPE
+ * around our IO calls is not thread safe:
+ * [] It uses a global stack of handler frames.
+ * [] It uses ALLOC_GROW() to resize it.
+ * [] Finally, according to the `signal(2)` man-page:
+ *    "The effects of `signal()` in a multithreaded process are unspecified."
+ */
+static void thread_block_sigpipe(sigset_t *old_set)
+{
+	sigset_t new_set;
+
+	sigemptyset(&new_set);
+	sigaddset(&new_set, SIGPIPE);
+
+	sigemptyset(old_set);
+	pthread_sigmask(SIG_BLOCK, &new_set, old_set);
+}
+
+/*
+ * Thread proc for an IPC worker thread.  It handles a series of
+ * connections from clients.  It pulls the next fd from the queue
+ * processes it, and then waits for the next client.
+ *
+ * Block SIGPIPE in this worker thread for the life of the thread.
+ * This avoids stray (and sometimes delayed) SIGPIPE signals caused
+ * by client errors and/or when we are under extremely heavy IO load.
+ *
+ * This means that the application callback will have SIGPIPE blocked.
+ * The callback should not change it.
+ */
+static void *worker_thread_proc(void *_worker_thread_data)
+{
+	struct ipc_worker_thread_data *worker_thread_data = _worker_thread_data;
+	struct ipc_server_data *server_data = worker_thread_data->server_data;
+	sigset_t old_set;
+	int fd, io;
+	int ret;
+
+	trace2_thread_start("ipc-worker");
+
+	thread_block_sigpipe(&old_set);
+
+	for (;;) {
+		fd = worker_thread__wait_for_connection(worker_thread_data);
+		if (fd == -1)
+			break; /* in shutdown */
+
+		io = worker_thread__wait_for_io_start(worker_thread_data, fd);
+		if (io == -1)
+			continue; /* client hung up without sending anything */
+
+		ret = worker_thread__do_io(worker_thread_data, fd);
+
+		if (ret == SIMPLE_IPC_QUIT) {
+			trace2_data_string("ipc-worker", NULL, "queue_stop_async",
+					   "application_quit");
+			/* The application told us to shutdown. */
+			ipc_server_stop_async(server_data);
+			break;
+		}
+	}
+
+	trace2_thread_exit();
+	return NULL;
+}
+
+/*
+ * Return 1 if someone deleted or stole the on-disk socket from us.
+ */
+static int socket_was_stolen(struct ipc_accept_thread_data *accept_thread_data)
+{
+	struct stat st;
+
+	if (lstat(accept_thread_data->server_data->buf_path.buf, &st) == -1)
+		return 1;
+
+	if (st.st_ino != accept_thread_data->inode_listen)
+		return 1;
+
+	return 0;
+}
+
+/* A randomly chosen value. */
+#define MY_ACCEPT_POLL_TIMEOUT_MS (60 * 1000)
+
+/*
+ * Accept a new client connection on our socket.  This uses non-blocking
+ * IO so that we can also wait for shutdown requests on our socket-pair
+ * without actually spinning on a fast timeout.
+ */
+static int accept_thread__wait_for_connection(
+	struct ipc_accept_thread_data *accept_thread_data)
+{
+	struct pollfd pollfd[2];
+	int result;
+
+	for (;;) {
+		pollfd[0].fd = accept_thread_data->fd_wait_shutdown;
+		pollfd[0].events = POLLIN;
+
+		pollfd[1].fd = accept_thread_data->fd_listen;
+		pollfd[1].events = POLLIN;
+
+		result = poll(pollfd, 2, MY_ACCEPT_POLL_TIMEOUT_MS);
+		if (result < 0) {
+			if (errno == EINTR)
+				continue;
+			return result;
+		}
+
+		if (result == 0) {
+			/* a timeout */
+
+			/*
+			 * If someone deletes or force-creates a new unix
+			 * domain socket at out path, all future clients
+			 * will be routed elsewhere and we silently starve.
+			 * If that happens, just queue a shutdown.
+			 */
+			if (socket_was_stolen(
+				    accept_thread_data)) {
+				trace2_data_string("ipc-accept", NULL,
+						   "queue_stop_async",
+						   "socket_stolen");
+				ipc_server_stop_async(
+					accept_thread_data->server_data);
+			}
+			continue;
+		}
+
+		if (pollfd[0].revents & POLLIN) {
+			/* shutdown message queued to socketpair */
+			return -1;
+		}
+
+		if (pollfd[1].revents & POLLIN) {
+			/* a connection is available on fd_listen */
+
+			int client_fd = accept(accept_thread_data->fd_listen,
+					       NULL, NULL);
+			if (client_fd >= 0)
+				return client_fd;
+
+			/*
+			 * An error here is unlikely -- it probably
+			 * indicates that the connecting process has
+			 * already dropped the connection.
+			 */
+			continue;
+		}
+
+		BUG("unandled poll result errno=%d r[0]=%d r[1]=%d",
+		    errno, pollfd[0].revents, pollfd[1].revents);
+	}
+}
+
+/*
+ * Thread proc for the IPC server "accept thread".  This waits for
+ * an incoming socket connection, appends it to the queue of available
+ * connections, and notifies a worker thread to process it.
+ *
+ * Block SIGPIPE in this thread for the life of the thread.  This
+ * avoids any stray SIGPIPE signals when closing pipe fds under
+ * extremely heavy loads (such as when the fifo queue is full and we
+ * drop incomming connections).
+ */
+static void *accept_thread_proc(void *_accept_thread_data)
+{
+	struct ipc_accept_thread_data *accept_thread_data = _accept_thread_data;
+	struct ipc_server_data *server_data = accept_thread_data->server_data;
+	sigset_t old_set;
+
+	trace2_thread_start("ipc-accept");
+
+	thread_block_sigpipe(&old_set);
+
+	for (;;) {
+		int client_fd = accept_thread__wait_for_connection(
+			accept_thread_data);
+
+		pthread_mutex_lock(&server_data->work_available_mutex);
+		if (server_data->shutdown_requested) {
+			pthread_mutex_unlock(&server_data->work_available_mutex);
+			if (client_fd >= 0)
+				close(client_fd);
+			break;
+		}
+
+		if (client_fd < 0) {
+			/* ignore transient accept() errors */
+		}
+		else {
+			fifo_enqueue(server_data, client_fd);
+			pthread_cond_broadcast(&server_data->work_available_cond);
+		}
+		pthread_mutex_unlock(&server_data->work_available_mutex);
+	}
+
+	trace2_thread_exit();
+	return NULL;
+}
+
+/*
+ * We can't predict the connection arrival rate relative to the worker
+ * processing rate, therefore we allow the "accept-thread" to queue up
+ * a generous number of connections, since we'd rather have the client
+ * not unnecessarily timeout if we can avoid it.  (The assumption is
+ * that this will be used for FSMonitor and a few second wait on a
+ * connection is better than having the client timeout and do the full
+ * computation itself.)
+ *
+ * The FIFO queue size is set to a multiple of the worker pool size.
+ * This value chosen at random.
+ */
+#define FIFO_SCALE (100)
+
+/*
+ * The backlog value for `listen(2)`.  This doesn't need to huge,
+ * rather just large enough for our "accept-thread" to wake up and
+ * queue incoming connections onto the FIFO without the kernel
+ * dropping any.
+ *
+ * This value chosen at random.
+ */
+#define LISTEN_BACKLOG (50)
+
+/*
+ * Create a unix domain socket at the given path to listen for
+ * client connections.  The resulting socket will then appear
+ * in the filesystem as an inode with S_IFSOCK.  The inode is
+ * itself created as part of the `bind(2)` operation.
+ *
+ * The term "socket" is ambiguous in this context.  We want to open a
+ * "socket-fd" that is bound to a "socket-inode" (path) on disk.  We
+ * listen on "socket-fd" for new connections and clients try to
+ * open/connect using the "socket-inode" pathname.
+ *
+ * Unix domain sockets have a fundamental design flaw because the
+ * "socket-inode" persists until the pathname is deleted; closing the listening
+ * "socket-fd" only closes the socket handle/descriptor, it does not delete
+ * the inode/pathname.
+ *
+ * Well-behaving service daemons are expected to also delete the inode
+ * before shutdown.  If a service crashes (or forgets) it can leave
+ * the (now stale) inode in the filesystem.  This behaves like a stale
+ * ".lock" file and may prevent future service instances from starting
+ * up correctly.  (Because they won't be able to bind.)
+ *
+ * When future service instances try to create the listener socket,
+ * `bind(2)` will fail with EADDRINUSE -- because the inode already
+ * exists.  However, the new instance cannot tell if it is a stale
+ * inode *or* another service instance is already running.
+ *
+ * One possible solution is to blindly unlink the inode before
+ * attempting to bind a new socket-fd (and thus create) a new
+ * socket-inode.  Then `bind(2)` should always succeed.  However, if
+ * there is an existing service instance, it would be orphaned --
+ * it would still be listening on a socket-fd that is still bound
+ * to an (unlinked) socket-inode, but that socket-inode is no longer
+ * associated with the pathname.  New client connections will arrive
+ * at our new socket-inode and not the existing server's.  (It is upto
+ * the existing server to detect that its socket-inode has been
+ * stolen and shutdown.)
+ *
+ * Since this is rather obscure and infrequent, we try to "gently"
+ * create the socket-inode without disturbing an existing service.
+ */
+static int create_listener_socket(const char *path,
+				  const struct ipc_server_opts *ipc_opts)
+{
+	int fd_listen;
+	int fd_client;
+	struct unix_stream_listen_opts uslg_opts = {
+		.listen_backlog_size = LISTEN_BACKLOG,
+		.force_unlink_before_bind = 0,
+		.disallow_chdir = ipc_opts->uds_disallow_chdir
+	};
+
+	trace2_data_string("ipc-server", NULL, "try-listen-gently", path);
+
+	/*
+	 * Assume socket-inode does not exist and try to (gently)
+	 * create a new socket-inode on disk at pathname and bind
+	 * socket-fd to it.
+	 */
+	fd_listen = unix_stream_listen_gently(path, &uslg_opts);
+	if (fd_listen >= 0)
+		return fd_listen;
+
+	if (errno != EADDRINUSE)
+		return error_errno(_("could not create socket '%s'"),
+				   path);
+
+	trace2_data_string("ipc-server", NULL, "try-detect-server", path);
+
+	/*
+	 * A socket-inode at pathname exists on disk, but we don't
+	 * know if it a server is using it or if it is a stale inode.
+	 *
+	 * poke it with a trivial connection to try to find out.
+	 */
+	fd_client = unix_stream_connect(path);
+	if (fd_client >= 0) {
+		/*
+		 * An existing service process is alive and accepted our
+		 * connection.
+		 */
+		close(fd_client);
+
+		/*
+		 * We cannot create a new socket-inode here, so we cannot
+		 * startup a new server on this pathname.
+		 */
+		errno = EADDRINUSE;
+		return error_errno(_("socket already in use '%s'"),
+				   path);
+	}
+
+	trace2_data_string("ipc-server", NULL, "try-listen-force", path);
+
+	/*
+	 * A socket-inode at pathname exists on disk, but we were not
+	 * able to connect to it, so we believe that this is a stale
+	 * socket-inode that a previous server forgot to delete.  Use
+	 * the tradional solution: force unlink it and create a new
+	 * one.
+	 *
+	 * TODO Note that it is possible that another server is
+	 * listening, but is either just starting up and not yet
+	 * responsive or is stuck somehow.  For now, I'm OK with
+	 * stealing the socket-inode from it in this case.
+	 */
+	uslg_opts.force_unlink_before_bind = 1;
+	fd_listen = unix_stream_listen_gently(path, &uslg_opts);
+	if (fd_listen >= 0)
+		return fd_listen;
+
+	return error_errno(_("could not force create socket '%s'"), path);
+}
+
+static int setup_listener_socket(const char *path, ino_t *inode,
+				 const struct ipc_server_opts *ipc_opts)
+{
+	int fd_listen;
+	struct stat st;
+
+	trace2_region_enter("ipc-server", "create-listener_socket", NULL);
+	fd_listen = create_listener_socket(path, ipc_opts);
+	trace2_region_leave("ipc-server", "create-listener_socket", NULL);
+
+	if (fd_listen < 0)
+		return fd_listen;
+
+	/*
+	 * We just bound a socket (descriptor) to a newly created unix
+	 * domain socket in the filesystem.  Capture the inode number
+	 * so we can later detect if/when someone else force-creates a
+	 * new socket and effectively steals the path from us.  (Which
+	 * would leave us listening to a socket that no client could
+	 * reach.)
+	 */
+	if (lstat(path, &st) < 0) {
+		int saved_errno = errno;
+
+		close(fd_listen);
+		unlink(path);
+
+		errno = saved_errno;
+		return error_errno(_("could not lstat listener socket '%s'"),
+				   path);
+	}
+
+	if (set_socket_blocking_flag(fd_listen, 1)) {
+		int saved_errno = errno;
+
+		close(fd_listen);
+		unlink(path);
+
+		errno = saved_errno;
+		return error_errno(_("making listener socket nonblocking '%s'"),
+				   path);
+	}
+
+	*inode = st.st_ino;
+
+	return fd_listen;
+}
+
+/*
+ * Start IPC server in a pool of background threads.
+ */
+int ipc_server_run_async(struct ipc_server_data **returned_server_data,
+			 const char *path, const struct ipc_server_opts *opts,
+			 ipc_server_application_cb *application_cb,
+			 void *application_data)
+{
+	struct ipc_server_data *server_data;
+	int fd_listen;
+	ino_t inode_listen;
+	int sv[2];
+	int k;
+	int nr_threads = opts->nr_threads;
+
+	*returned_server_data = NULL;
+
+	/*
+	 * Create a socketpair and set sv[1] to non-blocking.  This
+	 * will used to send a shutdown message to the accept-thread
+	 * and allows the accept-thread to wait on EITHER a client
+	 * connection or a shutdown request without spinning.
+	 */
+	if (socketpair(AF_UNIX, SOCK_STREAM, 0, sv) < 0)
+		return error_errno(_("could not create socketpair for '%s'"),
+				   path);
+
+	if (set_socket_blocking_flag(sv[1], 1)) {
+		int saved_errno = errno;
+		close(sv[0]);
+		close(sv[1]);
+		errno = saved_errno;
+		return error_errno(_("making socketpair nonblocking '%s'"),
+				   path);
+	}
+
+	fd_listen = setup_listener_socket(path, &inode_listen, opts);
+	if (fd_listen < 0) {
+		int saved_errno = errno;
+		close(sv[0]);
+		close(sv[1]);
+		errno = saved_errno;
+		return -1;
+	}
+
+	server_data = xcalloc(1, sizeof(*server_data));
+	server_data->magic = MAGIC_SERVER_DATA;
+	server_data->application_cb = application_cb;
+	server_data->application_data = application_data;
+	strbuf_init(&server_data->buf_path, 0);
+	strbuf_addstr(&server_data->buf_path, path);
+
+	if (nr_threads < 1)
+		nr_threads = 1;
+
+	pthread_mutex_init(&server_data->work_available_mutex, NULL);
+	pthread_cond_init(&server_data->work_available_cond, NULL);
+
+	server_data->queue_size = nr_threads * FIFO_SCALE;
+	server_data->fifo_fds = xcalloc(server_data->queue_size,
+					sizeof(*server_data->fifo_fds));
+
+	server_data->accept_thread =
+		xcalloc(1, sizeof(*server_data->accept_thread));
+	server_data->accept_thread->magic = MAGIC_ACCEPT_THREAD_DATA;
+	server_data->accept_thread->server_data = server_data;
+	server_data->accept_thread->fd_listen = fd_listen;
+	server_data->accept_thread->inode_listen = inode_listen;
+	server_data->accept_thread->fd_send_shutdown = sv[0];
+	server_data->accept_thread->fd_wait_shutdown = sv[1];
+
+	if (pthread_create(&server_data->accept_thread->pthread_id, NULL,
+			   accept_thread_proc, server_data->accept_thread))
+		die_errno(_("could not start accept_thread '%s'"), path);
+
+	for (k = 0; k < nr_threads; k++) {
+		struct ipc_worker_thread_data *wtd;
+
+		wtd = xcalloc(1, sizeof(*wtd));
+		wtd->magic = MAGIC_WORKER_THREAD_DATA;
+		wtd->server_data = server_data;
+
+		if (pthread_create(&wtd->pthread_id, NULL, worker_thread_proc,
+				   wtd)) {
+			if (k == 0)
+				die(_("could not start worker[0] for '%s'"),
+				    path);
+			/*
+			 * Limp along with the thread pool that we have.
+			 */
+			break;
+		}
+
+		wtd->next_thread = server_data->worker_thread_list;
+		server_data->worker_thread_list = wtd;
+	}
+
+	*returned_server_data = server_data;
+	return 0;
+}
+
+/*
+ * Gently tell the IPC server treads to shutdown.
+ * Can be run on any thread.
+ */
+int ipc_server_stop_async(struct ipc_server_data *server_data)
+{
+	/* ASSERT NOT holding mutex */
+
+	int fd;
+
+	if (!server_data)
+		return 0;
+
+	trace2_region_enter("ipc-server", "server-stop-async", NULL);
+
+	pthread_mutex_lock(&server_data->work_available_mutex);
+
+	server_data->shutdown_requested = 1;
+
+	/*
+	 * Write a byte to the shutdown socket pair to wake up the
+	 * accept-thread.
+	 */
+	if (write(server_data->accept_thread->fd_send_shutdown, "Q", 1) < 0)
+		error_errno("could not write to fd_send_shutdown");
+
+	/*
+	 * Drain the queue of existing connections.
+	 */
+	while ((fd = fifo_dequeue(server_data)) != -1)
+		close(fd);
+
+	/*
+	 * Gently tell worker threads to stop processing new connections
+	 * and exit.  (This does not abort in-process conversations.)
+	 */
+	pthread_cond_broadcast(&server_data->work_available_cond);
+
+	pthread_mutex_unlock(&server_data->work_available_mutex);
+
+	trace2_region_leave("ipc-server", "server-stop-async", NULL);
+
+	return 0;
+}
+
+/*
+ * Wait for all IPC server threads to stop.
+ */
+int ipc_server_await(struct ipc_server_data *server_data)
+{
+	pthread_join(server_data->accept_thread->pthread_id, NULL);
+
+	if (!server_data->shutdown_requested)
+		BUG("ipc-server: accept-thread stopped for '%s'",
+		    server_data->buf_path.buf);
+
+	while (server_data->worker_thread_list) {
+		struct ipc_worker_thread_data *wtd =
+			server_data->worker_thread_list;
+
+		pthread_join(wtd->pthread_id, NULL);
+
+		server_data->worker_thread_list = wtd->next_thread;
+		free(wtd);
+	}
+
+	server_data->is_stopped = 1;
+
+	return 0;
+}
+
+void ipc_server_free(struct ipc_server_data *server_data)
+{
+	struct ipc_accept_thread_data * accept_thread_data;
+
+	if (!server_data)
+		return;
+
+	if (!server_data->is_stopped)
+		BUG("cannot free ipc-server while running for '%s'",
+		    server_data->buf_path.buf);
+
+	accept_thread_data = server_data->accept_thread;
+	if (accept_thread_data) {
+		if (accept_thread_data->fd_listen != -1) {
+			/*
+			 * Only unlink the unix domain socket if we
+			 * created it.  That is, if another daemon
+			 * process force-created a new socket at this
+			 * path, and effectively steals our path
+			 * (which prevents us from receiving any
+			 * future clients), we don't want to do the
+			 * same thing to them.
+			 */
+			if (!socket_was_stolen(
+				    accept_thread_data))
+				unlink(server_data->buf_path.buf);
+
+			close(accept_thread_data->fd_listen);
+		}
+		if (accept_thread_data->fd_send_shutdown != -1)
+			close(accept_thread_data->fd_send_shutdown);
+		if (accept_thread_data->fd_wait_shutdown != -1)
+			close(accept_thread_data->fd_wait_shutdown);
+
+		free(server_data->accept_thread);
+	}
+
+	while (server_data->worker_thread_list) {
+		struct ipc_worker_thread_data *wtd =
+			server_data->worker_thread_list;
+
+		server_data->worker_thread_list = wtd->next_thread;
+		free(wtd);
+	}
+
+	pthread_cond_destroy(&server_data->work_available_cond);
+	pthread_mutex_destroy(&server_data->work_available_mutex);
+
+	strbuf_release(&server_data->buf_path);
+
+	free(server_data->fifo_fds);
+	free(server_data);
+}
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 4bd41054ee7..4c27a373414 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -248,6 +248,8 @@ endif()
 
 if(CMAKE_SYSTEM_NAME STREQUAL "Windows")
 	list(APPEND compat_SOURCES compat/simple-ipc/ipc-shared.c compat/simple-ipc/ipc-win32.c)
+else()
+	list(APPEND compat_SOURCES compat/simple-ipc/ipc-shared.c compat/simple-ipc/ipc-unix-socket.c)
 endif()
 
 set(EXE_EXTENSION ${CMAKE_EXECUTABLE_SUFFIX})
diff --git a/simple-ipc.h b/simple-ipc.h
index cd525e711bd..8a6dfc72c83 100644
--- a/simple-ipc.h
+++ b/simple-ipc.h
@@ -5,7 +5,7 @@
  * See Documentation/technical/api-simple-ipc.txt
  */
 
-#if defined(GIT_WINDOWS_NATIVE)
+#if defined(GIT_WINDOWS_NATIVE) || !defined(NO_UNIX_SOCKETS)
 #define SUPPORTS_SIMPLE_IPC
 #endif
 
@@ -151,6 +151,11 @@ struct ipc_server_data;
 struct ipc_server_opts
 {
 	int nr_threads;
+
+	/*
+	 * Disallow chdir() when creating a Unix domain socket.
+	 */
+	unsigned int uds_disallow_chdir:1;
 };
 
 /*
-- 
gitgitgadget
