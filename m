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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F67C4332B
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 15:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FE4223131
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 15:33:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391553AbhALPdF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 10:33:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391418AbhALPc4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 10:32:56 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B51C0617A3
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 07:31:41 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id y187so2493913wmd.3
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 07:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=h+PAnlOeSqK84W0ERQY/gCR4c55jIsBF1I+soFiWDhY=;
        b=fa4H7ri5c++pE+VkYEwUjCHOgwABX1ll5rsi7cQwn1XcZsiwDy4rSLh8v9AbdXHRTn
         cUbcSlBCayZxDZEtR/1X4heTnQwpo5YCKPlKH/0n/+SJXKgFyYqbGdNLuDQfukoWvNnt
         eSbUE+MBPb2nkuEx2q33XqZOCT2zZ/Q/11dKGyY1hrJl1tqch9Xo7rsEPp627mMIDD9+
         OJHI4dZf/YwhE98qQWowlU7bXLBTkLrD6nu7ASWUTAfVaQV4je0NoBustLAjXKoNISce
         /0k6L8TpLnTBDYaS6Wf2UiSt3Z5zLe3Wov6ynARXBjjpbIPav8LS1xm0gN/6zj+geTpN
         whbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=h+PAnlOeSqK84W0ERQY/gCR4c55jIsBF1I+soFiWDhY=;
        b=IGG6PB4q033Votu/SiCNvbS+rXHFN3x9Qyk4YWL8ADnoqDdQ1iN95Y0BTPNPCGCl/Z
         w6YkLdPyPsuZit13fnSIKc16Qi0AI99BmtmO4Qct5ZbjofWcOu6OEollMrwJi9KygA/X
         6pqM4P0ESGNmZIPfn96FOaE5238mzvPZEDy+TFyqXHWLmMc6t5912O2nShI0g5q6Or7d
         3kUeagR8Vwf9uGg8DxjDiW01bqes0GRHWo+nQkhU80JCEiQgTQDpGPxMQQrZ8OQMTnW7
         IBfpnJpWsEoO+c/nUJiIFQ3f1gNmznQWbYayDzl2bkfd6opaxTcKy66BvtLxcE9H041A
         HX7A==
X-Gm-Message-State: AOAM532HqcNZCf1D4Odu++LXd6XCnMQTkXaAN3prQ0AGUd//uvB03m+W
        YauNVRZowlFJiIj5icCgLGmXfWG7nn4=
X-Google-Smtp-Source: ABdhPJzTkc2NAUVh1QpxADR5TerFxYaJ4Fi24T/X9gOSANSgDXKzZSf9EAiv/o7vpOk4EqT6rNwDyA==
X-Received: by 2002:a1c:4684:: with SMTP id t126mr4138001wma.165.1610465499574;
        Tue, 12 Jan 2021 07:31:39 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m2sm4220315wml.34.2021.01.12.07.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 07:31:39 -0800 (PST)
Message-Id: <9e27c07d7852c1476f5a2ca0bb0fe0c1f05e2de1.1610465493.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.766.git.1610465492.gitgitgadget@gmail.com>
References: <pull.766.git.1610465492.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 12 Jan 2021 15:31:28 +0000
Subject: [PATCH 06/10] simple-ipc: add win32 implementation
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

Create Windows implementation of "simple-ipc" using named pipes.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 Makefile                            |   5 +
 compat/simple-ipc/ipc-shared.c      |  28 ++
 compat/simple-ipc/ipc-win32.c       | 723 ++++++++++++++++++++++++++++
 config.mak.uname                    |   2 +
 contrib/buildsystems/CMakeLists.txt |   4 +
 simple-ipc.h                        | 216 +++++++++
 6 files changed, 978 insertions(+)
 create mode 100644 compat/simple-ipc/ipc-shared.c
 create mode 100644 compat/simple-ipc/ipc-win32.c
 create mode 100644 simple-ipc.h

diff --git a/Makefile b/Makefile
index 7b64106930a..c94d5847919 100644
--- a/Makefile
+++ b/Makefile
@@ -1682,6 +1682,11 @@ else
 	LIB_OBJS += unix-socket.o
 endif
 
+ifdef USE_WIN32_IPC
+	LIB_OBJS += compat/simple-ipc/ipc-shared.o
+	LIB_OBJS += compat/simple-ipc/ipc-win32.o
+endif
+
 ifdef NO_ICONV
 	BASIC_CFLAGS += -DNO_ICONV
 endif
diff --git a/compat/simple-ipc/ipc-shared.c b/compat/simple-ipc/ipc-shared.c
new file mode 100644
index 00000000000..1edec815953
--- /dev/null
+++ b/compat/simple-ipc/ipc-shared.c
@@ -0,0 +1,28 @@
+#include "cache.h"
+#include "simple-ipc.h"
+#include "strbuf.h"
+#include "pkt-line.h"
+#include "thread-utils.h"
+
+#ifdef SUPPORTS_SIMPLE_IPC
+
+int ipc_server_run(const char *path, const struct ipc_server_opts *opts,
+		   ipc_server_application_cb *application_cb,
+		   void *application_data)
+{
+	struct ipc_server_data *server_data = NULL;
+	int ret;
+
+	ret = ipc_server_run_async(&server_data, path, opts,
+				   application_cb, application_data);
+	if (ret)
+		return ret;
+
+	ret = ipc_server_await(server_data);
+
+	ipc_server_free(server_data);
+
+	return ret;
+}
+
+#endif /* SUPPORTS_SIMPLE_IPC */
diff --git a/compat/simple-ipc/ipc-win32.c b/compat/simple-ipc/ipc-win32.c
new file mode 100644
index 00000000000..475d9f02ff6
--- /dev/null
+++ b/compat/simple-ipc/ipc-win32.c
@@ -0,0 +1,723 @@
+#include "cache.h"
+#include "simple-ipc.h"
+#include "strbuf.h"
+#include "pkt-line.h"
+#include "thread-utils.h"
+
+#ifndef GIT_WINDOWS_NATIVE
+#error This file can only be compiled on Windows
+#endif
+
+static int initialize_pipe_name(const char *path, wchar_t *wpath, size_t alloc)
+{
+	int off = 0;
+	struct strbuf realpath = STRBUF_INIT;
+
+	if (!strbuf_realpath(&realpath, path, 0))
+		return -1;
+
+	off = swprintf(wpath, alloc, L"\\\\.\\pipe\\");
+	if (xutftowcs(wpath + off, realpath.buf, alloc - off) < 0)
+		return -1;
+
+	/* Handle drive prefix */
+	if (wpath[off] && wpath[off + 1] == L':') {
+		wpath[off + 1] = L'_';
+		off += 2;
+	}
+
+	for (; wpath[off]; off++)
+		if (wpath[off] == L'/')
+			wpath[off] = L'\\';
+
+	strbuf_release(&realpath);
+	return 0;
+}
+
+static enum ipc_active_state get_active_state(wchar_t *pipe_path)
+{
+	if (WaitNamedPipeW(pipe_path, NMPWAIT_USE_DEFAULT_WAIT))
+		return IPC_STATE__LISTENING;
+
+	if (GetLastError() == ERROR_SEM_TIMEOUT)
+		return IPC_STATE__NOT_LISTENING;
+
+	if (GetLastError() == ERROR_FILE_NOT_FOUND)
+		return IPC_STATE__PATH_NOT_FOUND;
+
+	return IPC_STATE__OTHER_ERROR;
+}
+
+enum ipc_active_state ipc_get_active_state(const char *path)
+{
+	wchar_t pipe_path[MAX_PATH];
+
+	if (initialize_pipe_name(path, pipe_path, ARRAY_SIZE(pipe_path)) < 0)
+		return IPC_STATE__INVALID_PATH;
+
+	return get_active_state(pipe_path);
+}
+
+#define WAIT_STEP_MS (50)
+
+static enum ipc_active_state connect_to_server(
+	const wchar_t *wpath,
+	DWORD timeout_ms,
+	const struct ipc_client_connect_options *options,
+	int *pfd)
+{
+	DWORD t_start_ms, t_waited_ms;
+	DWORD step_ms;
+	HANDLE hPipe = INVALID_HANDLE_VALUE;
+	DWORD mode = PIPE_READMODE_BYTE;
+	DWORD gle;
+
+	*pfd = -1;
+
+	for (;;) {
+		hPipe = CreateFileW(wpath, GENERIC_READ | GENERIC_WRITE,
+				    0, NULL, OPEN_EXISTING, 0, NULL);
+		if (hPipe != INVALID_HANDLE_VALUE)
+			break;
+
+		gle = GetLastError();
+
+		switch (gle) {
+		case ERROR_FILE_NOT_FOUND:
+			if (!options->wait_if_not_found)
+				return IPC_STATE__PATH_NOT_FOUND;
+			if (!timeout_ms)
+				return IPC_STATE__PATH_NOT_FOUND;
+
+			step_ms = (timeout_ms < WAIT_STEP_MS) ?
+				timeout_ms : WAIT_STEP_MS;
+			sleep_millisec(step_ms);
+
+			timeout_ms -= step_ms;
+			break; /* try again */
+
+		case ERROR_PIPE_BUSY:
+			if (!options->wait_if_busy)
+				return IPC_STATE__NOT_LISTENING;
+			if (!timeout_ms)
+				return IPC_STATE__NOT_LISTENING;
+
+			t_start_ms = (DWORD)(getnanotime() / 1000000);
+
+			if (!WaitNamedPipeW(wpath, timeout_ms)) {
+				if (GetLastError() == ERROR_SEM_TIMEOUT)
+					return IPC_STATE__NOT_LISTENING;
+
+				return IPC_STATE__OTHER_ERROR;
+			}
+
+			/*
+			 * A pipe server instance became available.
+			 * Race other client processes to connect to
+			 * it.
+			 *
+			 * But first decrement our overall timeout so
+			 * that we don't starve if we keep losing the
+			 * race.  But also guard against special
+			 * NPMWAIT_ values (0 and -1).
+			 */
+			t_waited_ms = (DWORD)(getnanotime() / 1000000) - t_start_ms;
+			if (t_waited_ms < timeout_ms)
+				timeout_ms -= t_waited_ms;
+			else
+				timeout_ms = 1;
+			break; /* try again */
+
+		default:
+			return IPC_STATE__OTHER_ERROR;
+		}
+	}
+
+	if (!SetNamedPipeHandleState(hPipe, &mode, NULL, NULL)) {
+		CloseHandle(hPipe);
+		return IPC_STATE__OTHER_ERROR;
+	}
+
+	*pfd = _open_osfhandle((intptr_t)hPipe, O_RDWR|O_BINARY);
+	if (*pfd < 0) {
+		CloseHandle(hPipe);
+		return IPC_STATE__OTHER_ERROR;
+	}
+
+	/* fd now owns hPipe */
+
+	return IPC_STATE__LISTENING;
+}
+
+/*
+ * The default connection timeout for Windows clients.
+ *
+ * This is not currently part of the ipc_ API (nor the config settings)
+ * because of differences between Windows and other platforms.
+ *
+ * This value was chosen at random.
+ */
+#define WINDOWS_CONNECTION_TIMEOUT_MS (30000)
+
+enum ipc_active_state ipc_client_try_connect(
+	const char *path,
+	const struct ipc_client_connect_options *options,
+	int *pfd)
+{
+	wchar_t wpath[MAX_PATH];
+	enum ipc_active_state state = IPC_STATE__OTHER_ERROR;
+
+	*pfd = -1;
+
+	trace2_region_enter("ipc-client", "try-connect", NULL);
+	trace2_data_string("ipc-client", NULL, "try-connect/path", path);
+
+	if (initialize_pipe_name(path, wpath, ARRAY_SIZE(wpath)) < 0)
+		state = IPC_STATE__INVALID_PATH;
+	else
+		state = connect_to_server(wpath, WINDOWS_CONNECTION_TIMEOUT_MS,
+					  options, pfd);
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
+	FlushFileBuffers((HANDLE)_get_osfhandle(fd));
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
+			    const char *message, struct strbuf *response)
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
+	ret = ipc_client_send_command_to_fd(fd, message, response);
+	close(fd);
+	return ret;
+}
+
+/*
+ * Duplicate the given pipe handle and wrap it in a file descriptor so
+ * that we can use pkt-line on it.
+ */
+static int dup_fd_from_pipe(const HANDLE pipe)
+{
+	HANDLE process = GetCurrentProcess();
+	HANDLE handle;
+	int fd;
+
+	if (!DuplicateHandle(process, pipe, process, &handle, 0, FALSE,
+			     DUPLICATE_SAME_ACCESS)) {
+		errno = err_win_to_posix(GetLastError());
+		return -1;
+	}
+
+	fd = _open_osfhandle((intptr_t)handle, O_RDWR|O_BINARY);
+	if (fd < 0) {
+		errno = err_win_to_posix(GetLastError());
+		CloseHandle(handle);
+		return -1;
+	}
+
+	/*
+	 * `handle` is now owned by `fd` and will be automatically closed
+	 * when the descriptor is closed.
+	 */
+
+	return fd;
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
+	MAGIC_SERVER_THREAD_DATA,
+	MAGIC_SERVER_DATA,
+};
+
+struct ipc_server_reply_data {
+	enum magic magic;
+	int fd;
+	struct ipc_server_thread_data *server_thread_data;
+};
+
+struct ipc_server_thread_data {
+	enum magic magic;
+	struct ipc_server_thread_data *next_thread;
+	struct ipc_server_data *server_data;
+	pthread_t pthread_id;
+	HANDLE hPipe;
+};
+
+/*
+ * On Windows, the conceptual "ipc-server" is implemented as a pool of
+ * n idential/peer "server-thread" threads.  That is, there is no
+ * hierarchy of threads; and therefore no controller thread managing
+ * the pool.  Each thread has an independent handle to the named pipe,
+ * receives incoming connections, processes the client, and re-uses
+ * the pipe for the next client connection.
+ *
+ * Therefore, the "ipc-server" only needs to maintain a list of the
+ * spawned threads for eventual "join" purposes.
+ *
+ * A single "stop-event" is visible to all of the server threads to
+ * tell them to shutdown (when idle).
+ */
+struct ipc_server_data {
+	enum magic magic;
+	ipc_server_application_cb *application_cb;
+	void *application_data;
+	struct strbuf buf_path;
+	wchar_t wpath[MAX_PATH];
+
+	HANDLE hEventStopRequested;
+	struct ipc_server_thread_data *thread_list;
+	int is_stopped;
+};
+
+enum connect_result {
+	CR_CONNECTED = 0,
+	CR_CONNECT_PENDING,
+	CR_CONNECT_ERROR,
+	CR_WAIT_ERROR,
+	CR_SHUTDOWN,
+};
+
+static enum connect_result queue_overlapped_connect(
+	struct ipc_server_thread_data *server_thread_data,
+	OVERLAPPED *lpo)
+{
+	if (ConnectNamedPipe(server_thread_data->hPipe, lpo))
+		goto failed;
+
+	switch (GetLastError()) {
+	case ERROR_IO_PENDING:
+		return CR_CONNECT_PENDING;
+
+	case ERROR_PIPE_CONNECTED:
+		SetEvent(lpo->hEvent);
+		return CR_CONNECTED;
+
+	default:
+		break;
+	}
+
+failed:
+	error(_("ConnectNamedPipe failed for '%s' (%lu)"),
+	      server_thread_data->server_data->buf_path.buf,
+	      GetLastError());
+	return CR_CONNECT_ERROR;
+}
+
+/*
+ * Use Windows Overlapped IO to wait for a connection or for our event
+ * to be signalled.
+ */
+static enum connect_result wait_for_connection(
+	struct ipc_server_thread_data *server_thread_data,
+	OVERLAPPED *lpo)
+{
+	enum connect_result r;
+	HANDLE waitHandles[2];
+	DWORD dwWaitResult;
+
+	r = queue_overlapped_connect(server_thread_data, lpo);
+	if (r != CR_CONNECT_PENDING)
+		return r;
+
+	waitHandles[0] = server_thread_data->server_data->hEventStopRequested;
+	waitHandles[1] = lpo->hEvent;
+
+	dwWaitResult = WaitForMultipleObjects(2, waitHandles, FALSE, INFINITE);
+	switch (dwWaitResult) {
+	case WAIT_OBJECT_0 + 0:
+		return CR_SHUTDOWN;
+
+	case WAIT_OBJECT_0 + 1:
+		ResetEvent(lpo->hEvent);
+		return CR_CONNECTED;
+
+	default:
+		return CR_WAIT_ERROR;
+	}
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
+/*
+ * Receive the request/command from the client and pass it to the
+ * registered request-callback.  The request-callback will compose
+ * a response and call our reply-callback to send it to the client.
+ *
+ * Simple-IPC only contains one round trip, so we flush and close
+ * here after the response.
+ */
+static int do_io(struct ipc_server_thread_data *server_thread_data)
+{
+	struct strbuf buf = STRBUF_INIT;
+	struct ipc_server_reply_data reply_data;
+	int ret = 0;
+
+	reply_data.magic = MAGIC_SERVER_REPLY_DATA;
+	reply_data.server_thread_data = server_thread_data;
+
+	reply_data.fd = dup_fd_from_pipe(server_thread_data->hPipe);
+	if (reply_data.fd < 0)
+		return error(_("could not create fd from pipe for '%s'"),
+			     server_thread_data->server_data->buf_path.buf);
+
+	ret = read_packetized_to_strbuf(reply_data.fd, &buf,
+					PACKET_READ_NEVER_DIE);
+	if (ret >= 0) {
+		ret = server_thread_data->server_data->application_cb(
+			server_thread_data->server_data->application_data,
+			buf.buf, do_io_reply_callback, &reply_data);
+
+		packet_flush_gently(reply_data.fd);
+
+		FlushFileBuffers((HANDLE)_get_osfhandle((reply_data.fd)));
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
+ * Handle IPC request and response with this connected client.  And reset
+ * the pipe to prepare for the next client.
+ */
+static int use_connection(struct ipc_server_thread_data *server_thread_data)
+{
+	int ret;
+
+	ret = do_io(server_thread_data);
+
+	FlushFileBuffers(server_thread_data->hPipe);
+	DisconnectNamedPipe(server_thread_data->hPipe);
+
+	return ret;
+}
+
+/*
+ * Thread proc for an IPC server worker thread.  It handles a series of
+ * connections from clients.  It cleans and reuses the hPipe between each
+ * client.
+ */
+static void *server_thread_proc(void *_server_thread_data)
+{
+	struct ipc_server_thread_data *server_thread_data = _server_thread_data;
+	HANDLE hEventConnected = INVALID_HANDLE_VALUE;
+	OVERLAPPED oConnect;
+	enum connect_result cr;
+	int ret;
+
+	assert(server_thread_data->hPipe != INVALID_HANDLE_VALUE);
+
+	trace2_thread_start("ipc-server");
+	trace2_data_string("ipc-server", NULL, "pipe",
+			   server_thread_data->server_data->buf_path.buf);
+
+	hEventConnected = CreateEventW(NULL, TRUE, FALSE, NULL);
+
+	memset(&oConnect, 0, sizeof(oConnect));
+	oConnect.hEvent = hEventConnected;
+
+	for (;;) {
+		cr = wait_for_connection(server_thread_data, &oConnect);
+
+		switch (cr) {
+		case CR_SHUTDOWN:
+			goto finished;
+
+		case CR_CONNECTED:
+			ret = use_connection(server_thread_data);
+			if (ret == SIMPLE_IPC_QUIT) {
+				ipc_server_stop_async(
+					server_thread_data->server_data);
+				goto finished;
+			}
+			if (ret > 0) {
+				/*
+				 * Ignore (transient) IO errors with this
+				 * client and reset for the next client.
+				 */
+			}
+			break;
+
+		case CR_CONNECT_PENDING:
+			/* By construction, this should not happen. */
+			BUG("ipc-server[%s]: unexpeced CR_CONNECT_PENDING",
+			    server_thread_data->server_data->buf_path.buf);
+
+		case CR_CONNECT_ERROR:
+		case CR_WAIT_ERROR:
+			/*
+			 * Ignore these theoretical errors.
+			 */
+			DisconnectNamedPipe(server_thread_data->hPipe);
+			break;
+
+		default:
+			BUG("unandled case after wait_for_connection");
+		}
+	}
+
+finished:
+	CloseHandle(server_thread_data->hPipe);
+	CloseHandle(hEventConnected);
+
+	trace2_thread_exit();
+	return NULL;
+}
+
+static HANDLE create_new_pipe(wchar_t *wpath, int is_first)
+{
+	HANDLE hPipe;
+	DWORD dwOpenMode, dwPipeMode;
+	LPSECURITY_ATTRIBUTES lpsa = NULL;
+
+	dwOpenMode = PIPE_ACCESS_INBOUND | PIPE_ACCESS_OUTBOUND |
+		FILE_FLAG_OVERLAPPED;
+
+	dwPipeMode = PIPE_TYPE_MESSAGE | PIPE_READMODE_BYTE | PIPE_WAIT |
+		PIPE_REJECT_REMOTE_CLIENTS;
+
+	if (is_first) {
+		dwOpenMode |= FILE_FLAG_FIRST_PIPE_INSTANCE;
+
+		/*
+		 * On Windows, the first server pipe instance gets to
+		 * set the ACL / Security Attributes on the named
+		 * pipe; subsequent instances inherit and cannot
+		 * change them.
+		 *
+		 * TODO Should we allow the application layer to
+		 * specify security attributes, such as `LocalService`
+		 * or `LocalSystem`, when we create the named pipe?
+		 * This question is probably not important when the
+		 * daemon is started by a foreground user process and
+		 * only needs to talk to the current user, but may be
+		 * if the daemon is run via the Control Panel as a
+		 * System Service.
+		 */
+	}
+
+	hPipe = CreateNamedPipeW(wpath, dwOpenMode, dwPipeMode,
+				 PIPE_UNLIMITED_INSTANCES, 1024, 1024, 0, lpsa);
+
+	return hPipe;
+}
+
+int ipc_server_run_async(struct ipc_server_data **returned_server_data,
+			 const char *path, const struct ipc_server_opts *opts,
+			 ipc_server_application_cb *application_cb,
+			 void *application_data)
+{
+	struct ipc_server_data *server_data;
+	wchar_t wpath[MAX_PATH];
+	HANDLE hPipeFirst = INVALID_HANDLE_VALUE;
+	int k;
+	int ret = 0;
+	int nr_threads = opts->nr_threads;
+
+	*returned_server_data = NULL;
+
+	ret = initialize_pipe_name(path, wpath, ARRAY_SIZE(wpath));
+	if (ret < 0)
+		return error(
+			_("could not create normalized wchar_t path for '%s'"),
+			path);
+
+	hPipeFirst = create_new_pipe(wpath, 1);
+	if (hPipeFirst == INVALID_HANDLE_VALUE)
+		return error(_("IPC server already running on '%s'"), path);
+
+	server_data = xcalloc(1, sizeof(*server_data));
+	server_data->magic = MAGIC_SERVER_DATA;
+	server_data->application_cb = application_cb;
+	server_data->application_data = application_data;
+	server_data->hEventStopRequested = CreateEvent(NULL, TRUE, FALSE, NULL);
+	strbuf_init(&server_data->buf_path, 0);
+	strbuf_addstr(&server_data->buf_path, path);
+	wcscpy(server_data->wpath, wpath);
+
+	if (nr_threads < 1)
+		nr_threads = 1;
+
+	for (k = 0; k < nr_threads; k++) {
+		struct ipc_server_thread_data *std;
+
+		std = xcalloc(1, sizeof(*std));
+		std->magic = MAGIC_SERVER_THREAD_DATA;
+		std->server_data = server_data;
+		std->hPipe = INVALID_HANDLE_VALUE;
+
+		std->hPipe = (k == 0)
+			? hPipeFirst
+			: create_new_pipe(server_data->wpath, 0);
+
+		if (std->hPipe == INVALID_HANDLE_VALUE) {
+			/*
+			 * If we've reached a pipe instance limit for
+			 * this path, just use fewer threads.
+			 */
+			free(std);
+			break;
+		}
+
+		if (pthread_create(&std->pthread_id, NULL,
+				   server_thread_proc, std)) {
+			/*
+			 * Likewise, if we're out of threads, just use
+			 * fewer threads than requested.
+			 *
+			 * However, we just give up if we can't even get
+			 * one thread.  This should not happen.
+			 */
+			if (k == 0)
+				die(_("could not start thread[0] for '%s'"),
+				    path);
+
+			CloseHandle(std->hPipe);
+			free(std);
+			break;
+		}
+
+		std->next_thread = server_data->thread_list;
+		server_data->thread_list = std;
+	}
+
+	*returned_server_data = server_data;
+	return 0;
+}
+
+int ipc_server_stop_async(struct ipc_server_data *server_data)
+{
+	if (!server_data)
+		return 0;
+
+	/*
+	 * Gently tell all of the ipc_server threads to shutdown.
+	 * This will be seen the next time they are idle (and waiting
+	 * for a connection).
+	 *
+	 * We DO NOT attempt to force them to drop an active connection.
+	 */
+	SetEvent(server_data->hEventStopRequested);
+	return 0;
+}
+
+int ipc_server_await(struct ipc_server_data *server_data)
+{
+	DWORD dwWaitResult;
+
+	if (!server_data)
+		return 0;
+
+	dwWaitResult = WaitForSingleObject(server_data->hEventStopRequested, INFINITE);
+	if (dwWaitResult != WAIT_OBJECT_0)
+		return error(_("wait for hEvent failed for '%s'"),
+			     server_data->buf_path.buf);
+
+	while (server_data->thread_list) {
+		struct ipc_server_thread_data *std = server_data->thread_list;
+
+		pthread_join(std->pthread_id, NULL);
+
+		server_data->thread_list = std->next_thread;
+		free(std);
+	}
+
+	server_data->is_stopped = 1;
+
+	return 0;
+}
+
+void ipc_server_free(struct ipc_server_data *server_data)
+{
+	if (!server_data)
+		return;
+
+	if (!server_data->is_stopped)
+		BUG("cannot free ipc-server while running for '%s'",
+		    server_data->buf_path.buf);
+
+	strbuf_release(&server_data->buf_path);
+
+	if (server_data->hEventStopRequested != INVALID_HANDLE_VALUE)
+		CloseHandle(server_data->hEventStopRequested);
+
+	while (server_data->thread_list) {
+		struct ipc_server_thread_data *std = server_data->thread_list;
+
+		server_data->thread_list = std->next_thread;
+		free(std);
+	}
+
+	free(server_data);
+}
diff --git a/config.mak.uname b/config.mak.uname
index 198ab1e58f8..76087cff678 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -421,6 +421,7 @@ ifeq ($(uname_S),Windows)
 	RUNTIME_PREFIX = YesPlease
 	HAVE_WPGMPTR = YesWeDo
 	NO_ST_BLOCKS_IN_STRUCT_STAT = YesPlease
+	USE_WIN32_IPC = YesPlease
 	USE_WIN32_MMAP = YesPlease
 	MMAP_PREVENTS_DELETE = UnfortunatelyYes
 	# USE_NED_ALLOCATOR = YesPlease
@@ -597,6 +598,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	RUNTIME_PREFIX = YesPlease
 	HAVE_WPGMPTR = YesWeDo
 	NO_ST_BLOCKS_IN_STRUCT_STAT = YesPlease
+	USE_WIN32_IPC = YesPlease
 	USE_WIN32_MMAP = YesPlease
 	MMAP_PREVENTS_DELETE = UnfortunatelyYes
 	USE_NED_ALLOCATOR = YesPlease
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index c151dd7257f..4bd41054ee7 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -246,6 +246,10 @@ elseif(CMAKE_SYSTEM_NAME STREQUAL "Linux")
 	list(APPEND compat_SOURCES unix-socket.c)
 endif()
 
+if(CMAKE_SYSTEM_NAME STREQUAL "Windows")
+	list(APPEND compat_SOURCES compat/simple-ipc/ipc-shared.c compat/simple-ipc/ipc-win32.c)
+endif()
+
 set(EXE_EXTENSION ${CMAKE_EXECUTABLE_SUFFIX})
 
 #header checks
diff --git a/simple-ipc.h b/simple-ipc.h
new file mode 100644
index 00000000000..cd525e711bd
--- /dev/null
+++ b/simple-ipc.h
@@ -0,0 +1,216 @@
+#ifndef GIT_SIMPLE_IPC_H
+#define GIT_SIMPLE_IPC_H
+
+/*
+ * See Documentation/technical/api-simple-ipc.txt
+ */
+
+#if defined(GIT_WINDOWS_NATIVE)
+#define SUPPORTS_SIMPLE_IPC
+#endif
+
+#ifdef SUPPORTS_SIMPLE_IPC
+
+/*
+ * Simple IPC Client Side API.
+ */
+
+enum ipc_active_state {
+	/*
+	 * The pipe/socket exists and the daemon is waiting for connections.
+	 */
+	IPC_STATE__LISTENING = 0,
+
+	/*
+	 * The pipe/socket exists, but the daemon is not listening.
+	 * Perhaps it is very busy.
+	 * Perhaps the daemon died without deleting the path.
+	 * Perhaps it is shutting down and draining existing clients.
+	 * Perhaps it is dead, but other clients are lingering and
+	 * still holding a reference to the pathname.
+	 */
+	IPC_STATE__NOT_LISTENING,
+
+	/*
+	 * The requested pathname is bogus and no amount of retries
+	 * will fix that.
+	 */
+	IPC_STATE__INVALID_PATH,
+
+	/*
+	 * The requested pathname is not found.  This usually means
+	 * that there is no daemon present.
+	 */
+	IPC_STATE__PATH_NOT_FOUND,
+
+	IPC_STATE__OTHER_ERROR,
+};
+
+struct ipc_client_connect_options {
+	/*
+	 * Spin under timeout if the server is running but can't
+	 * accept our connection yet.  This should always be set
+	 * unless you just want to poke the server and see if it
+	 * is alive.
+	 */
+	unsigned int wait_if_busy:1;
+
+	/*
+	 * Spin under timeout if the pipe/socket is not yet present
+	 * on the file system.  This is useful if we just started
+	 * the service and need to wait for it to become ready.
+	 */
+	unsigned int wait_if_not_found:1;
+};
+
+#define IPC_CLIENT_CONNECT_OPTIONS_INIT { \
+	.wait_if_busy = 0, \
+	.wait_if_not_found = 0, \
+}
+
+/*
+ * Determine if a server is listening on this named pipe or socket using
+ * platform-specific logic.  This might just probe the filesystem or it
+ * might make a trivial connection to the server using this pathname.
+ */
+enum ipc_active_state ipc_get_active_state(const char *path);
+
+/*
+ * Try to connect to the daemon on the named pipe or socket.
+ *
+ * Returns IPC_STATE__LISTENING (and an fd) when connected.
+ *
+ * Otherwise, returns info to help decide whether to retry or to
+ * spawn/respawn the server.
+ */
+enum ipc_active_state ipc_client_try_connect(
+	const char *path,
+	const struct ipc_client_connect_options *options,
+	int *pfd);
+
+/*
+ * Used by the client to synchronously send and receive a message with
+ * the server on the provided fd.
+ *
+ * Returns 0 when successful.
+ *
+ * Calls error() and returns non-zero otherwise.
+ */
+int ipc_client_send_command_to_fd(int fd, const char *message,
+				  struct strbuf *answer);
+
+/*
+ * Used by the client to synchronously connect and send and receive a
+ * message to the server listening at the given path.
+ *
+ * Returns 0 when successful.
+ *
+ * Calls error() and returns non-zero otherwise.
+ */
+int ipc_client_send_command(const char *path,
+			    const struct ipc_client_connect_options *options,
+			    const char *message, struct strbuf *answer);
+
+/*
+ * Simple IPC Server Side API.
+ */
+
+struct ipc_server_reply_data;
+
+typedef int (ipc_server_reply_cb)(struct ipc_server_reply_data *,
+				  const char *response,
+				  size_t response_len);
+
+/*
+ * Prototype for an application-supplied callback to process incoming
+ * client IPC messages and compose a reply.  The `application_cb` should
+ * use the provided `reply_cb` and `reply_data` to send an IPC response
+ * back to the client.  The `reply_cb` callback can be called multiple
+ * times for chunking purposes.  A reply message is optional and may be
+ * omitted if not necessary for the application.
+ *
+ * The return value from the application callback is ignored.
+ * The value `SIMPLE_IPC_QUIT` can be used to shutdown the server.
+ */
+typedef int (ipc_server_application_cb)(void *application_data,
+					const char *request,
+					ipc_server_reply_cb *reply_cb,
+					struct ipc_server_reply_data *reply_data);
+
+#define SIMPLE_IPC_QUIT -2
+
+/*
+ * Opaque instance data to represent an IPC server instance.
+ */
+struct ipc_server_data;
+
+/*
+ * Control parameters for the IPC server instance.
+ * Use this to hide platform-specific settings.
+ */
+struct ipc_server_opts
+{
+	int nr_threads;
+};
+
+/*
+ * Start an IPC server instance in one or more background threads
+ * and return a handle to the pool.
+ *
+ * Returns 0 if the asynchronous server pool was started successfully.
+ * Returns -1 if not.
+ *
+ * When a client IPC message is received, the `application_cb` will be
+ * called (possibly on a random thread) to handle the message and
+ * optionally compose a reply message.
+ */
+int ipc_server_run_async(struct ipc_server_data **returned_server_data,
+			 const char *path, const struct ipc_server_opts *opts,
+			 ipc_server_application_cb *application_cb,
+			 void *application_data);
+
+/*
+ * Gently signal the IPC server pool to shutdown.  No new client
+ * connections will be accepted, but existing connections will be
+ * allowed to complete.
+ */
+int ipc_server_stop_async(struct ipc_server_data *server_data);
+
+/*
+ * Block the calling thread until all threads in the IPC server pool
+ * have completed and been joined.
+ */
+int ipc_server_await(struct ipc_server_data *server_data);
+
+/*
+ * Close and free all resource handles associated with the IPC server
+ * pool.
+ */
+void ipc_server_free(struct ipc_server_data *server_data);
+
+/*
+ * Run an IPC server instance and block the calling thread of the
+ * current process.  It does not return until the IPC server has
+ * either shutdown or had an unrecoverable error.
+ *
+ * The IPC server handles incoming IPC messages from client processes
+ * and may use one or more background threads as necessary.
+ *
+ * Returns 0 after the server has completed successfully.
+ * Returns -1 if the server cannot be started.
+ *
+ * When a client IPC message is received, the `application_cb` will be
+ * called (possibly on a random thread) to handle the message and
+ * optionally compose a reply message.
+ *
+ * Note that `ipc_server_run()` is a synchronous wrapper around the
+ * above asynchronous routines.  It effectively hides all of the
+ * server state and thread details from the caller and presents a
+ * simple synchronous interface.
+ */
+int ipc_server_run(const char *path, const struct ipc_server_opts *opts,
+		   ipc_server_application_cb *application_cb,
+		   void *application_data);
+
+#endif /* SUPPORTS_SIMPLE_IPC */
+#endif /* GIT_SIMPLE_IPC_H */
-- 
gitgitgadget

