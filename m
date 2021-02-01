Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FD86C433E0
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 19:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2904764E3C
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 19:47:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232274AbhBATrF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 14:47:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232326AbhBATqc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 14:46:32 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E47D2C061756
        for <git@vger.kernel.org>; Mon,  1 Feb 2021 11:45:51 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id i9so333074wmq.1
        for <git@vger.kernel.org>; Mon, 01 Feb 2021 11:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Xym3nKWKzlUnCAb4zvVTvJxqAgLDvkMKJ70WFy72O/g=;
        b=VHB02lzET5tnINiaEp4FOiVGFYktlq+UgOEglvxlcThoFnmJO34xLNdv6Uul4QyKQ8
         qrGg7MfU5wtFfl1bq/UAjnp6BvGDCM8gt2KdwvlQoJR52Jdd/AblOYMCvTOCo8xMdFjp
         FFa/LNRFICOArnYxAKkN/3kt6WgWaMnm3LMgg4xhHRphg8amrcR3C119jdKaGwUKMM4W
         NHIZbumv+UuJHYMdhr3+zC2BdpWj6pONUXFNnbm8fVk3rDho4fbpkG4QMwDCktUh5PEg
         VQxyW6rMB8j97cfF81J5ShgVWs37XKBgfucY9Q8NB1DnxSCR+yw2hEKFsJP7TaiNwKQl
         ejow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Xym3nKWKzlUnCAb4zvVTvJxqAgLDvkMKJ70WFy72O/g=;
        b=Cgmc/rNPvG48SwRtB4kYuOKgMfzq4OEYFpW8xyBRSLOyvJUQ9wDw0zIaPkTrMYccfF
         7BVFgnLRFuFBITYgiVE06epGNDH06K8zfkiFLLvcFPd1UH4/n6uynOJTyxOd6bDs4cgH
         ZoB8hwuG/cUSxg0BAopctOUd8sLMSw+pu77crqj2gIh6WFqX6QfgfoAMu0b25LDT5JKE
         HmjolN54HYghXjDGj0WOuM3vk0vDOV1PLrRUNOhdUR664lqymnb6uaYSMQibO9+xRZWx
         AkIq18EhNpBmkB9X9i3a5pFexrIIhOH5udWOd77dSoWy4USyIf5DUgD8Tg7bGETFBa07
         VsUg==
X-Gm-Message-State: AOAM533QQHIEf+8l9iZP5CAu+Ht3oMOqRQamUB3igKR3ovQKUuUeK3M9
        uGNj1dmeDWB+GKqhExNU/JWikLgEWn8=
X-Google-Smtp-Source: ABdhPJy9o8t18xXc7h5Q7ynZavjsMwC6q0Bf4ya3k4LgIekGYII4aA1IJMpdXdCdAL5+uhYAw6xTuA==
X-Received: by 2002:a1c:bc89:: with SMTP id m131mr444689wmf.32.1612208749436;
        Mon, 01 Feb 2021 11:45:49 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b138sm274687wmb.35.2021.02.01.11.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 11:45:48 -0800 (PST)
Message-Id: <pull.766.v2.git.1612208747.gitgitgadget@gmail.com>
In-Reply-To: <pull.766.git.1610465492.gitgitgadget@gmail.com>
References: <pull.766.git.1610465492.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 01 Feb 2021 19:45:33 +0000
Subject: [PATCH v2 00/14] Simple IPC Mechanism
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Jeff King <peff@peff.net>, Chris Torek <chris.torek@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is version 2 of my "Simple IPC" series and addresses the following
review comments:

[1] Redo packet_write_gently() to take a scratch buffer argument and fixup
callers to avoid potential thread-stack problems caused by a very large
stack buffer when used multi-threaded callers. This turned out to be a
little more involved than anticipated because the pkt-line code doesn't know
about its thread state nor an opportunity to initialize thread-state.

[2] Deleted the unix_stream_socket() helper function and inline it in the
few callers and then let those call sites decide whether to call die() or
not.

[3] Refactor unix_stream_listen() to take an "options" structure and to
incorporate the changes I described in my earlier
unix_stream_listen_gently().

[4] Update unix_stream_connect() to return errors rather than calling die().

[5] Update the simple-ipc server startup to detect dead and/or in-use Unix
domain sockets and/or create a new socket in a race-friendly way. I now use
a variation of the atomic lock-rename-trick when creating the socket
(details are in a large comment in the code).

Jeff Hostetler (10):
  pkt-line: promote static buffer in packet_write_gently() to callers
  pkt-line: add write_packetized_from_buf2() that takes scratch buffer
  simple-ipc: design documentation for new IPC mechanism
  simple-ipc: add win32 implementation
  simple-ipc: add t/helper/test-simple-ipc and t0052
  unix-socket: elimiate static unix_stream_socket() helper function
  unix-socket: add options to unix_stream_listen()
  unix-socket: add no-chdir option to unix_stream_listen()
  unix-socket: do not call die in unix_stream_connect()
  simple-ipc: add Unix domain socket implementation

Johannes Schindelin (3):
  pkt-line: optionally skip the flush packet in
    write_packetized_from_buf()
  pkt-line: (optionally) libify the packet readers
  pkt-line: accept additional options in read_packetized_to_strbuf()

Junio C Hamano (1):
  ci/install-depends: attempt to fix "brew cask" stuff

 Documentation/technical/api-simple-ipc.txt |   34 +
 Makefile                                   |    8 +
 builtin/credential-cache--daemon.c         |    3 +-
 ci/install-dependencies.sh                 |    8 +-
 compat/simple-ipc/ipc-shared.c             |   28 +
 compat/simple-ipc/ipc-unix-socket.c        | 1127 ++++++++++++++++++++
 compat/simple-ipc/ipc-win32.c              |  751 +++++++++++++
 config.mak.uname                           |    2 +
 contrib/buildsystems/CMakeLists.txt        |    6 +
 convert.c                                  |    4 +-
 pkt-line.c                                 |   70 +-
 pkt-line.h                                 |   26 +-
 simple-ipc.h                               |  230 ++++
 t/helper/test-simple-ipc.c                 |  485 +++++++++
 t/helper/test-tool.c                       |    1 +
 t/helper/test-tool.h                       |    1 +
 t/t0052-simple-ipc.sh                      |  129 +++
 unix-socket.c                              |   67 +-
 unix-socket.h                              |   16 +-
 19 files changed, 2949 insertions(+), 47 deletions(-)
 create mode 100644 Documentation/technical/api-simple-ipc.txt
 create mode 100644 compat/simple-ipc/ipc-shared.c
 create mode 100644 compat/simple-ipc/ipc-unix-socket.c
 create mode 100644 compat/simple-ipc/ipc-win32.c
 create mode 100644 simple-ipc.h
 create mode 100644 t/helper/test-simple-ipc.c
 create mode 100755 t/t0052-simple-ipc.sh


base-commit: 71ca53e8125e36efbda17293c50027d31681a41f
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-766%2Fjeffhostetler%2Fsimple-ipc-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-766/jeffhostetler/simple-ipc-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/766

Range-diff vs v1:

  1:  1155a45cf64 <  -:  ----------- pkt-line: use stack rather than static buffer in packet_write_gently()
  -:  ----------- >  1:  4c6766d4183 ci/install-depends: attempt to fix "brew cask" stuff
  -:  ----------- >  2:  3b03a8ff7a7 pkt-line: promote static buffer in packet_write_gently() to callers
  -:  ----------- >  3:  e671894b4c0 pkt-line: add write_packetized_from_buf2() that takes scratch buffer
  3:  edf5ac95d66 !  4:  0832f7d324d pkt-line: optionally skip the flush packet in write_packetized_from_buf()
     @@ Commit message
          packets before a final flush packet, so let's extend this function to
          prepare for that scenario.
      
     +    Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## convert.c ##
     @@ pkt-line.c: int write_packetized_from_fd(int fd_in, int fd_out)
      -int write_packetized_from_buf(const char *src_in, size_t len, int fd_out)
      +int write_packetized_from_buf(const char *src_in, size_t len, int fd_out,
      +			      int flush_at_end)
     + {
     + 	static struct packet_scratch_space scratch;
     + 
     +-	return write_packetized_from_buf2(src_in, len, fd_out, &scratch);
     ++	return write_packetized_from_buf2(src_in, len, fd_out,
     ++					  flush_at_end, &scratch);
     + }
     + 
     + int write_packetized_from_buf2(const char *src_in, size_t len, int fd_out,
     ++			       int flush_at_end,
     + 			       struct packet_scratch_space *scratch)
       {
       	int err = 0;
     - 	size_t bytes_written = 0;
     -@@ pkt-line.c: int write_packetized_from_buf(const char *src_in, size_t len, int fd_out)
     - 		err = packet_write_gently(fd_out, src_in + bytes_written, bytes_to_write);
     +@@ pkt-line.c: int write_packetized_from_buf2(const char *src_in, size_t len, int fd_out,
     + 		err = packet_write_gently(fd_out, src_in + bytes_written, bytes_to_write, scratch);
       		bytes_written += bytes_to_write;
       	}
      -	if (!err)
     @@ pkt-line.h: void packet_buf_write_len(struct strbuf *buf, const char *data, size
      -int write_packetized_from_buf(const char *src_in, size_t len, int fd_out);
      +int write_packetized_from_buf(const char *src_in, size_t len, int fd_out,
      +			      int flush_at_end);
     + int write_packetized_from_buf2(const char *src_in, size_t len, int fd_out,
     ++			       int flush_at_end,
     + 			       struct packet_scratch_space *scratch);
       
       /*
     -  * Read a packetized line into the buffer, which must be at least size bytes
  2:  b7d678bc918 !  5:  43bc4a26b79 pkt-line: (optionally) libify the packet readers
     @@ pkt-line.c: enum packet_read_status packet_read_with_status(int fd, char **src_b
       		*pktlen = -1;
      
       ## pkt-line.h ##
     -@@ pkt-line.h: int write_packetized_from_buf(const char *src_in, size_t len, int fd_out);
     +@@ pkt-line.h: int write_packetized_from_buf2(const char *src_in, size_t len, int fd_out,
        *
        * If options contains PACKET_READ_DIE_ON_ERR_PACKET, it dies when it sees an
        * ERR packet.
  4:  2f399ac107c =  6:  6a389a35335 pkt-line: accept additional options in read_packetized_to_strbuf()
  5:  7064c5e9ffa !  7:  a7275b4bdc2 simple-ipc: design documentation for new IPC mechanism
     @@ Documentation/technical/api-simple-ipc.txt (new)
      +
      +This IPC mechanism differs from the existing `sub-process.c` model
      +(Documentation/technical/long-running-process-protocol.txt) and used
     -+by applications like Git-LFS because the server is assumed to be very
     -+long running system service.  In contrast, a "sub-process model process"
     -+is started with the foreground process and exits when the foreground
     -+process terminates.  How the server is started is also outside the
     -+scope of the IPC mechanism.
     ++by applications like Git-LFS.  In the simple-ipc model the server is
     ++assumed to be a very long-running system service.  In contrast, in the
     ++LFS-style sub-process model the helper is started with the foreground
     ++process and exits when the foreground process terminates.
     ++
     ++How the simple-ipc server is started is also outside the scope of the
     ++IPC mechanism.  For example, the server might be started during
     ++maintenance operations.
      +
      +The IPC protocol consists of a single request message from the client and
      +an optional request message from the server.  For simplicity, pkt-line
  6:  9e27c07d785 !  8:  388366913d4 simple-ipc: add win32 implementation
     @@ compat/simple-ipc/ipc-win32.c (new)
      +enum ipc_active_state ipc_client_try_connect(
      +	const char *path,
      +	const struct ipc_client_connect_options *options,
     -+	int *pfd)
     ++	struct ipc_client_connection **p_connection)
      +{
      +	wchar_t wpath[MAX_PATH];
      +	enum ipc_active_state state = IPC_STATE__OTHER_ERROR;
     ++	int fd = -1;
      +
     -+	*pfd = -1;
     ++	*p_connection = NULL;
      +
      +	trace2_region_enter("ipc-client", "try-connect", NULL);
      +	trace2_data_string("ipc-client", NULL, "try-connect/path", path);
     @@ compat/simple-ipc/ipc-win32.c (new)
      +		state = IPC_STATE__INVALID_PATH;
      +	else
      +		state = connect_to_server(wpath, WINDOWS_CONNECTION_TIMEOUT_MS,
     -+					  options, pfd);
     ++					  options, &fd);
      +
      +	trace2_data_intmax("ipc-client", NULL, "try-connect/state",
      +			   (intmax_t)state);
      +	trace2_region_leave("ipc-client", "try-connect", NULL);
     ++
     ++	if (state == IPC_STATE__LISTENING) {
     ++		(*p_connection) = xcalloc(1, sizeof(struct ipc_client_connection));
     ++		(*p_connection)->fd = fd;
     ++	}
     ++
      +	return state;
      +}
      +
     -+int ipc_client_send_command_to_fd(int fd, const char *message,
     -+				  struct strbuf *answer)
     ++void ipc_client_close_connection(struct ipc_client_connection *connection)
     ++{
     ++	if (!connection)
     ++		return;
     ++
     ++	if (connection->fd != -1)
     ++		close(connection->fd);
     ++
     ++	free(connection);
     ++}
     ++
     ++int ipc_client_send_command_to_connection(
     ++	struct ipc_client_connection *connection,
     ++	const char *message, struct strbuf *answer)
      +{
      +	int ret = 0;
      +
     @@ compat/simple-ipc/ipc-win32.c (new)
      +
      +	trace2_region_enter("ipc-client", "send-command", NULL);
      +
     -+	if (write_packetized_from_buf(message, strlen(message), fd, 1) < 0) {
     ++	if (write_packetized_from_buf2(message, strlen(message),
     ++				       connection->fd, 1,
     ++				       &connection->scratch_write_buffer) < 0) {
      +		ret = error(_("could not send IPC command"));
      +		goto done;
      +	}
      +
     -+	FlushFileBuffers((HANDLE)_get_osfhandle(fd));
     ++	FlushFileBuffers((HANDLE)_get_osfhandle(connection->fd));
      +
     -+	if (read_packetized_to_strbuf(fd, answer, PACKET_READ_NEVER_DIE) < 0) {
     ++	if (read_packetized_to_strbuf(connection->fd, answer,
     ++				      PACKET_READ_NEVER_DIE) < 0) {
      +		ret = error(_("could not read IPC response"));
      +		goto done;
      +	}
     @@ compat/simple-ipc/ipc-win32.c (new)
      +			    const struct ipc_client_connect_options *options,
      +			    const char *message, struct strbuf *response)
      +{
     -+	int fd;
      +	int ret = -1;
      +	enum ipc_active_state state;
     ++	struct ipc_client_connection *connection = NULL;
      +
     -+	state = ipc_client_try_connect(path, options, &fd);
     ++	state = ipc_client_try_connect(path, options, &connection);
      +
      +	if (state != IPC_STATE__LISTENING)
      +		return ret;
      +
     -+	ret = ipc_client_send_command_to_fd(fd, message, response);
     -+	close(fd);
     ++	ret = ipc_client_send_command_to_connection(connection, message, response);
     ++
     ++	ipc_client_close_connection(connection);
     ++
      +	return ret;
      +}
      +
     @@ compat/simple-ipc/ipc-win32.c (new)
      +	struct ipc_server_data *server_data;
      +	pthread_t pthread_id;
      +	HANDLE hPipe;
     ++	struct packet_scratch_space scratch_write_buffer;
      +};
      +
      +/*
     @@ compat/simple-ipc/ipc-win32.c (new)
      +static int do_io_reply_callback(struct ipc_server_reply_data *reply_data,
      +		       const char *response, size_t response_len)
      +{
     ++	struct packet_scratch_space *scratch =
     ++		&reply_data->server_thread_data->scratch_write_buffer;
     ++
      +	if (reply_data->magic != MAGIC_SERVER_REPLY_DATA)
      +		BUG("reply_cb called with wrong instance data");
      +
     -+	return write_packetized_from_buf(response, response_len,
     -+					 reply_data->fd, 0);
     ++	return write_packetized_from_buf2(response, response_len,
     ++					  reply_data->fd, 0, scratch);
      +}
      +
      +/*
     @@ simple-ipc.h (new)
      +#endif
      +
      +#ifdef SUPPORTS_SIMPLE_IPC
     ++#include "pkt-line.h"
      +
      +/*
      + * Simple IPC Client Side API.
     @@ simple-ipc.h (new)
      + */
      +enum ipc_active_state ipc_get_active_state(const char *path);
      +
     ++struct ipc_client_connection {
     ++	int fd;
     ++	struct packet_scratch_space scratch_write_buffer;
     ++};
     ++
      +/*
      + * Try to connect to the daemon on the named pipe or socket.
      + *
     -+ * Returns IPC_STATE__LISTENING (and an fd) when connected.
     ++ * Returns IPC_STATE__LISTENING and a connection handle.
      + *
      + * Otherwise, returns info to help decide whether to retry or to
      + * spawn/respawn the server.
     @@ simple-ipc.h (new)
      +enum ipc_active_state ipc_client_try_connect(
      +	const char *path,
      +	const struct ipc_client_connect_options *options,
     -+	int *pfd);
     ++	struct ipc_client_connection **p_connection);
     ++
     ++void ipc_client_close_connection(struct ipc_client_connection *connection);
      +
      +/*
      + * Used by the client to synchronously send and receive a message with
     -+ * the server on the provided fd.
     ++ * the server on the provided client connection.
      + *
      + * Returns 0 when successful.
      + *
      + * Calls error() and returns non-zero otherwise.
      + */
     -+int ipc_client_send_command_to_fd(int fd, const char *message,
     -+				  struct strbuf *answer);
     ++int ipc_client_send_command_to_connection(
     ++	struct ipc_client_connection *connection,
     ++	const char *message, struct strbuf *answer);
      +
      +/*
      + * Used by the client to synchronously connect and send and receive a
  9:  69969c2b8d3 =  9:  f0bebf1cdb3 simple-ipc: add t/helper/test-simple-ipc and t0052
  -:  ----------- > 10:  f5d5445cf42 unix-socket: elimiate static unix_stream_socket() helper function
  7:  96268351ac6 ! 11:  7a6a69dfc20 unix-socket: create gentle version of unix_stream_listen()
     @@ Metadata
      Author: Jeff Hostetler <jeffhost@microsoft.com>
      
       ## Commit message ##
     -    unix-socket: create gentle version of unix_stream_listen()
     +    unix-socket: add options to unix_stream_listen()
      
     -    Create a gentle version of `unix_stream_listen()`.  This version does
     -    not call `die()` if a socket-fd cannot be created and does not assume
     -    that it is safe to `unlink()` an existing socket-inode.
     +    Update `unix_stream_listen()` to take an options structure to override
     +    default behaviors.  This includes the size of the `listen()` backlog
     +    and whether it should always unlink the socket file before trying to
     +    create a new one.  Also eliminate calls to `die()` if it cannot create
     +    a socket.
      
     -    `unix_stream_listen()` uses `unix_stream_socket()` helper function to
     -    create the socket-fd.  Avoid that helper because it calls `die()` on
     -    errors.
     -
     -    `unix_stream_listen()` always tries to `unlink()` the socket-path before
     -    calling `bind()`.  If there is an existing server/daemon already bound
     -    and listening on that socket-path, our `unlink()` would have the effect
     -    of disassociating the existing server's bound-socket-fd from the socket-path
     -    without notifying the existing server.  The existing server could continue
     -    to service existing connections (accepted-socket-fd's), but would not
     -    receive any futher new connections (since clients rendezvous via the
     -    socket-path).  The existing server would effectively be offline but yet
     -    appear to be active.
     +    Normally, `unix_stream_listen()` always tries to `unlink()` the
     +    socket-path before calling `bind()`.  If there is an existing
     +    server/daemon already bound and listening on that socket-path, our
     +    `unlink()` would have the effect of disassociating the existing
     +    server's bound-socket-fd from the socket-path without notifying the
     +    existing server.  The existing server could continue to service
     +    existing connections (accepted-socket-fd's), but would not receive any
     +    futher new connections (since clients rendezvous via the socket-path).
     +    The existing server would effectively be offline but yet appear to be
     +    active.
      
          Furthermore, `unix_stream_listen()` creates an opportunity for a brief
          race condition for connecting clients if they try to connect in the
     @@ Commit message
      
          Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
      
     + ## builtin/credential-cache--daemon.c ##
     +@@ builtin/credential-cache--daemon.c: static int serve_cache_loop(int fd)
     + 
     + static void serve_cache(const char *socket_path, int debug)
     + {
     ++	struct unix_stream_listen_opts opts = UNIX_STREAM_LISTEN_OPTS_INIT;
     + 	int fd;
     + 
     +-	fd = unix_stream_listen(socket_path);
     ++	fd = unix_stream_listen(socket_path, &opts);
     + 	if (fd < 0)
     + 		die_errno("unable to bind to '%s'", socket_path);
     + 
     +
       ## unix-socket.c ##
     -@@ unix-socket.c: int unix_stream_listen(const char *path)
     - 	errno = saved_errno;
     +@@ unix-socket.c: int unix_stream_connect(const char *path)
       	return -1;
       }
     -+
     -+int unix_stream_listen_gently(const char *path,
     -+			      const struct unix_stream_listen_opts *opts)
     -+{
     + 
     +-int unix_stream_listen(const char *path)
     ++int unix_stream_listen(const char *path,
     ++		       const struct unix_stream_listen_opts *opts)
     + {
     +-	int fd, saved_errno;
      +	int fd = -1;
     -+	int bind_successful = 0;
      +	int saved_errno;
     -+	struct sockaddr_un sa;
     -+	struct unix_sockaddr_context ctx;
     -+
     -+	if (unix_sockaddr_init(&sa, path, &ctx) < 0)
     -+		goto fail;
     ++	int bind_successful = 0;
     ++	int backlog;
     + 	struct sockaddr_un sa;
     + 	struct unix_sockaddr_context ctx;
     + 
     +-	unlink(path);
     +-
     + 	if (unix_sockaddr_init(&sa, path, &ctx) < 0)
     + 		return -1;
      +
     -+	fd = socket(AF_UNIX, SOCK_STREAM, 0);
     -+	if (fd < 0)
     + 	fd = socket(AF_UNIX, SOCK_STREAM, 0);
     + 	if (fd < 0)
     +-		die_errno("unable to create socket");
      +		goto fail;
      +
      +	if (opts->force_unlink_before_bind)
      +		unlink(path);
     -+
     -+	if (bind(fd, (struct sockaddr *)&sa, sizeof(sa)) < 0)
     -+		goto fail;
     + 
     + 	if (bind(fd, (struct sockaddr *)&sa, sizeof(sa)) < 0)
     + 		goto fail;
      +	bind_successful = 1;
     -+
     -+	if (listen(fd, opts->listen_backlog_size) < 0)
     -+		goto fail;
     -+
     -+	unix_sockaddr_cleanup(&ctx);
     -+	return fd;
     -+
     -+fail:
     -+	saved_errno = errno;
     -+	unix_sockaddr_cleanup(&ctx);
     -+	close(fd);
     + 
     +-	if (listen(fd, 5) < 0)
     ++	if (opts->listen_backlog_size > 0)
     ++		backlog = opts->listen_backlog_size;
     ++	else
     ++		backlog = 5;
     ++	if (listen(fd, backlog) < 0)
     + 		goto fail;
     + 
     + 	unix_sockaddr_cleanup(&ctx);
     +@@ unix-socket.c: int unix_stream_listen(const char *path)
     + fail:
     + 	saved_errno = errno;
     + 	unix_sockaddr_cleanup(&ctx);
     +-	close(fd);
     ++	if (fd != -1)
     ++		close(fd);
      +	if (bind_successful)
      +		unlink(path);
     -+	errno = saved_errno;
     -+	return -1;
     -+}
     + 	errno = saved_errno;
     + 	return -1;
     + }
      
       ## unix-socket.h ##
      @@
     - int unix_stream_connect(const char *path);
     - int unix_stream_listen(const char *path);
     + #ifndef UNIX_SOCKET_H
     + #define UNIX_SOCKET_H
       
      +struct unix_stream_listen_opts {
      +	int listen_backlog_size;
      +	unsigned int force_unlink_before_bind:1;
      +};
      +
     -+int unix_stream_listen_gently(const char *path,
     -+			      const struct unix_stream_listen_opts *opts);
     ++#define UNIX_STREAM_LISTEN_OPTS_INIT \
     ++{ \
     ++	.listen_backlog_size = 5, \
     ++	.force_unlink_before_bind = 1, \
     ++}
      +
     + int unix_stream_connect(const char *path);
     +-int unix_stream_listen(const char *path);
     ++int unix_stream_listen(const char *path,
     ++		       const struct unix_stream_listen_opts *opts);
     + 
       #endif /* UNIX_SOCKET_H */
  8:  383a9755669 ! 12:  745b6d5fb74 unix-socket: add no-chdir option to unix_stream_listen_gently()
     @@ Metadata
      Author: Jeff Hostetler <jeffhost@microsoft.com>
      
       ## Commit message ##
     -    unix-socket: add no-chdir option to unix_stream_listen_gently()
     +    unix-socket: add no-chdir option to unix_stream_listen()
      
          Calls to `chdir()` are dangerous in a multi-threaded context.  If
          `unix_stream_listen()` is given a socket pathname that is too big to
     @@ Commit message
          Teach `unix_sockaddr_init()` to not allow calls to `chdir()` when flag
          is set.
      
     -    Extend the public interface to `unix_stream_listen_gently()` to also
     -    expose this new flag.
     -
          Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
      
       ## unix-socket.c ##
     @@ unix-socket.c: int unix_stream_connect(const char *path)
       
       	if (unix_sockaddr_init(&sa, path, &ctx) < 0)
       		return -1;
     -@@ unix-socket.c: int unix_stream_listen(const char *path)
     - {
     - 	int fd, saved_errno;
     - 	struct sockaddr_un sa;
     --	struct unix_sockaddr_context ctx;
     -+	struct unix_sockaddr_context ctx = UNIX_SOCKADDR_CONTEXT_INIT;
     - 
     - 	unlink(path);
     - 
     -@@ unix-socket.c: int unix_stream_listen_gently(const char *path,
     +@@ unix-socket.c: int unix_stream_listen(const char *path,
       	int bind_successful = 0;
     - 	int saved_errno;
     + 	int backlog;
       	struct sockaddr_un sa;
      -	struct unix_sockaddr_context ctx;
      +	struct unix_sockaddr_context ctx = UNIX_SOCKADDR_CONTEXT_INIT;
     @@ unix-socket.c: int unix_stream_listen_gently(const char *path,
      +	ctx.disallow_chdir = opts->disallow_chdir;
       
       	if (unix_sockaddr_init(&sa, path, &ctx) < 0)
     - 		goto fail;
     + 		return -1;
      
       ## unix-socket.h ##
     -@@ unix-socket.h: int unix_stream_listen(const char *path);
     +@@
       struct unix_stream_listen_opts {
       	int listen_backlog_size;
       	unsigned int force_unlink_before_bind:1;
      +	unsigned int disallow_chdir:1;
       };
       
     - int unix_stream_listen_gently(const char *path,
     + #define UNIX_STREAM_LISTEN_OPTS_INIT \
     + { \
     + 	.listen_backlog_size = 5, \
     + 	.force_unlink_before_bind = 1, \
     ++	.disallow_chdir = 0, \
     + }
     + 
     + int unix_stream_connect(const char *path);
  -:  ----------- > 13:  2cca15a10ec unix-socket: do not call die in unix_stream_connect()
 10:  a1b15fb5cb0 ! 14:  72c1c209c38 simple-ipc: add Unix domain socket implementation
     @@ Commit message
      
          Create Unix domain socket based implementation of "simple-ipc".
      
     +    A set of `ipc_client` routines implement a client library to connect
     +    to an `ipc_server` over a Unix domain socket, send a simple request,
     +    and receive a single response.  Clients use blocking IO on the socket.
     +
     +    A set of `ipc_server` routines implement a thread pool to listen for
     +    and concurrently service client connections.
     +
     +    The server creates a new Unix domain socket at a known location.  If a
     +    socket already exists with that name, the server tries to determine if
     +    another server is already listening on the socket or if the socket is
     +    dead.  If socket is busy, the server exits with an error rather than
     +    stealing the socket.  If the socket is dead, the server creates a new
     +    one and starts up.
     +
     +    If while running, the server detects that its socket has been stolen
     +    by another server, it automatically exits.
     +
          Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
      
       ## Makefile ##
     @@ compat/simple-ipc/ipc-unix-socket.c (new)
      +	struct ipc_client_connect_options options
      +		= IPC_CLIENT_CONNECT_OPTIONS_INIT;
      +	struct stat st;
     -+	int fd_test = -1;
     ++	struct ipc_client_connection *connection_test = NULL;
      +
      +	options.wait_if_busy = 0;
      +	options.wait_if_not_found = 0;
     @@ compat/simple-ipc/ipc-unix-socket.c (new)
      +	 * at `path`, doesn't mean it that there is a server listening.
      +	 * Ping it to be sure.
      +	 */
     -+	state = ipc_client_try_connect(path, &options, &fd_test);
     -+	close(fd_test);
     ++	state = ipc_client_try_connect(path, &options, &connection_test);
     ++	ipc_client_close_connection(connection_test);
      +
      +	return state;
      +}
     @@ compat/simple-ipc/ipc-unix-socket.c (new)
      +enum ipc_active_state ipc_client_try_connect(
      +	const char *path,
      +	const struct ipc_client_connect_options *options,
     -+	int *pfd)
     ++	struct ipc_client_connection **p_connection)
      +{
      +	enum ipc_active_state state = IPC_STATE__OTHER_ERROR;
     ++	int fd = -1;
      +
     -+	*pfd = -1;
     ++	*p_connection = NULL;
      +
      +	trace2_region_enter("ipc-client", "try-connect", NULL);
      +	trace2_data_string("ipc-client", NULL, "try-connect/path", path);
      +
      +	state = connect_to_server(path, MY_CONNECTION_TIMEOUT_MS,
     -+				  options, pfd);
     ++				  options, &fd);
      +
      +	trace2_data_intmax("ipc-client", NULL, "try-connect/state",
      +			   (intmax_t)state);
      +	trace2_region_leave("ipc-client", "try-connect", NULL);
     ++
     ++	if (state == IPC_STATE__LISTENING) {
     ++		(*p_connection) = xcalloc(1, sizeof(struct ipc_client_connection));
     ++		(*p_connection)->fd = fd;
     ++	}
     ++
      +	return state;
      +}
      +
     -+int ipc_client_send_command_to_fd(int fd, const char *message,
     -+				  struct strbuf *answer)
     ++void ipc_client_close_connection(struct ipc_client_connection *connection)
     ++{
     ++	if (!connection)
     ++		return;
     ++
     ++	if (connection->fd != -1)
     ++		close(connection->fd);
     ++
     ++	free(connection);
     ++}
     ++
     ++int ipc_client_send_command_to_connection(
     ++	struct ipc_client_connection *connection,
     ++	const char *message, struct strbuf *answer)
      +{
      +	int ret = 0;
      +
     @@ compat/simple-ipc/ipc-unix-socket.c (new)
      +
      +	trace2_region_enter("ipc-client", "send-command", NULL);
      +
     -+	if (write_packetized_from_buf(message, strlen(message), fd, 1) < 0) {
     ++	if (write_packetized_from_buf2(message, strlen(message),
     ++				       connection->fd, 1,
     ++				       &connection->scratch_write_buffer) < 0) {
      +		ret = error(_("could not send IPC command"));
      +		goto done;
      +	}
      +
     -+	if (read_packetized_to_strbuf(fd, answer, PACKET_READ_NEVER_DIE) < 0) {
     ++	if (read_packetized_to_strbuf(connection->fd, answer,
     ++				      PACKET_READ_NEVER_DIE) < 0) {
      +		ret = error(_("could not read IPC response"));
      +		goto done;
      +	}
     @@ compat/simple-ipc/ipc-unix-socket.c (new)
      +			    const struct ipc_client_connect_options *options,
      +			    const char *message, struct strbuf *answer)
      +{
     -+	int fd;
      +	int ret = -1;
      +	enum ipc_active_state state;
     ++	struct ipc_client_connection *connection = NULL;
      +
     -+	state = ipc_client_try_connect(path, options, &fd);
     ++	state = ipc_client_try_connect(path, options, &connection);
      +
      +	if (state != IPC_STATE__LISTENING)
      +		return ret;
      +
     -+	ret = ipc_client_send_command_to_fd(fd, message, answer);
     -+	close(fd);
     ++	ret = ipc_client_send_command_to_connection(connection, message, answer);
     ++
     ++	ipc_client_close_connection(connection);
     ++
      +	return ret;
      +}
      +
     @@ compat/simple-ipc/ipc-unix-socket.c (new)
      +	struct ipc_worker_thread_data *next_thread;
      +	struct ipc_server_data *server_data;
      +	pthread_t pthread_id;
     ++	struct packet_scratch_space scratch_write_buffer;
      +};
      +
      +struct ipc_accept_thread_data {
      +	enum magic magic;
      +	struct ipc_server_data *server_data;
     ++
      +	int fd_listen;
     -+	ino_t inode_listen;
     ++	struct stat st_listen;
     ++
      +	int fd_send_shutdown;
      +	int fd_wait_shutdown;
      +	pthread_t pthread_id;
     @@ compat/simple-ipc/ipc-unix-socket.c (new)
      +static int do_io_reply_callback(struct ipc_server_reply_data *reply_data,
      +		       const char *response, size_t response_len)
      +{
     ++	struct packet_scratch_space *scratch =
     ++		&reply_data->worker_thread_data->scratch_write_buffer;
     ++
      +	if (reply_data->magic != MAGIC_SERVER_REPLY_DATA)
      +		BUG("reply_cb called with wrong instance data");
      +
     -+	return write_packetized_from_buf(response, response_len,
     -+					 reply_data->fd, 0);
     ++	return write_packetized_from_buf2(response, response_len,
     ++					  reply_data->fd, 0, scratch);
      +}
      +
      +/* A randomly chosen value. */
     @@ compat/simple-ipc/ipc-unix-socket.c (new)
      +static int socket_was_stolen(struct ipc_accept_thread_data *accept_thread_data)
      +{
      +	struct stat st;
     ++	struct stat *ref_st = &accept_thread_data->st_listen;
      +
      +	if (lstat(accept_thread_data->server_data->buf_path.buf, &st) == -1)
      +		return 1;
      +
     -+	if (st.st_ino != accept_thread_data->inode_listen)
     ++	if (st.st_ino != ref_st->st_ino)
      +		return 1;
      +
     ++	/* We might also consider the creation time on some platforms. */
     ++
      +	return 0;
      +}
      +
     @@ compat/simple-ipc/ipc-unix-socket.c (new)
      + * open/connect using the "socket-inode" pathname.
      + *
      + * Unix domain sockets have a fundamental design flaw because the
     -+ * "socket-inode" persists until the pathname is deleted; closing the listening
     -+ * "socket-fd" only closes the socket handle/descriptor, it does not delete
     -+ * the inode/pathname.
     ++ * "socket-inode" persists until the pathname is deleted; closing the
     ++ * listening "socket-fd" only closes the socket handle/descriptor, it
     ++ * does not delete the inode/pathname.
      + *
      + * Well-behaving service daemons are expected to also delete the inode
      + * before shutdown.  If a service crashes (or forgets) it can leave
     @@ compat/simple-ipc/ipc-unix-socket.c (new)
      + * inode *or* another service instance is already running.
      + *
      + * One possible solution is to blindly unlink the inode before
     -+ * attempting to bind a new socket-fd (and thus create) a new
     ++ * attempting to bind a new socket-fd and thus create a new
      + * socket-inode.  Then `bind(2)` should always succeed.  However, if
     -+ * there is an existing service instance, it would be orphaned --
     -+ * it would still be listening on a socket-fd that is still bound
     -+ * to an (unlinked) socket-inode, but that socket-inode is no longer
     ++ * there is an existing service instance, it would be orphaned -- it
     ++ * would still be listening on a socket-fd that is still bound to an
     ++ * (unlinked) socket-inode, but that socket-inode is no longer
      + * associated with the pathname.  New client connections will arrive
     -+ * at our new socket-inode and not the existing server's.  (It is upto
     -+ * the existing server to detect that its socket-inode has been
     -+ * stolen and shutdown.)
     ++ * at OUR new socket-inode -- rather than the existing server's
     ++ * socket.  (I suppose it is up to the existing server to detect that
     ++ * its socket-inode has been stolen and shutdown.)
     ++ *
     ++ * Another possible solution is to try to use the ".lock" trick, but
     ++ * bind() does not have a exclusive-create use bit like open() does,
     ++ * so we cannot have multiple servers fighting/racing to create the
     ++ * same file name without having losers lose without knowing that they
     ++ * lost.
     ++ *
     ++ * We try to avoid such stealing and would rather fail to run than
     ++ * steal an existing socket-inode (because we assume that the
     ++ * existing server has more context and value to the clients than a
     ++ * freshly started server).  However, if multiple servers are racing
     ++ * to start, we don't care which one wins -- none of them have any
     ++ * state information yet worth fighting for.
     ++ *
     ++ * Create a "unique" socket-inode (with our PID in it (and assume that
     ++ * we can force-delete an existing socket with that name)).  Stat it
     ++ * to get the inode number and ctime -- so that we can identify it as
     ++ * the one we created.  Then use the atomic-rename trick to install it
     ++ * in the real location.  (This will unlink an existing socket with
     ++ * that pathname -- and thereby steal the real socket-inode from an
     ++ * existing server.)
      + *
     -+ * Since this is rather obscure and infrequent, we try to "gently"
     -+ * create the socket-inode without disturbing an existing service.
     ++ * Elsewhere, our thread will periodically poll the socket-inode to
     ++ * see if someone else steals ours.
      + */
      +static int create_listener_socket(const char *path,
     -+				  const struct ipc_server_opts *ipc_opts)
     ++				  const struct ipc_server_opts *ipc_opts,
     ++				  struct stat *st_socket)
      +{
     ++	struct stat st;
     ++	struct strbuf buf_uniq = STRBUF_INIT;
      +	int fd_listen;
     -+	int fd_client;
     -+	struct unix_stream_listen_opts uslg_opts = {
     -+		.listen_backlog_size = LISTEN_BACKLOG,
     -+		.force_unlink_before_bind = 0,
     -+		.disallow_chdir = ipc_opts->uds_disallow_chdir
     -+	};
     -+
     -+	trace2_data_string("ipc-server", NULL, "try-listen-gently", path);
     -+
     -+	/*
     -+	 * Assume socket-inode does not exist and try to (gently)
     -+	 * create a new socket-inode on disk at pathname and bind
     -+	 * socket-fd to it.
     -+	 */
     -+	fd_listen = unix_stream_listen_gently(path, &uslg_opts);
     -+	if (fd_listen >= 0)
     -+		return fd_listen;
     ++	struct unix_stream_listen_opts uslg_opts = UNIX_STREAM_LISTEN_OPTS_INIT;
      +
     -+	if (errno != EADDRINUSE)
     -+		return error_errno(_("could not create socket '%s'"),
     -+				   path);
     -+
     -+	trace2_data_string("ipc-server", NULL, "try-detect-server", path);
     -+
     -+	/*
     -+	 * A socket-inode at pathname exists on disk, but we don't
     -+	 * know if it a server is using it or if it is a stale inode.
     -+	 *
     -+	 * poke it with a trivial connection to try to find out.
     -+	 */
     -+	fd_client = unix_stream_connect(path);
     -+	if (fd_client >= 0) {
     ++	if (!lstat(path, &st) && S_ISSOCK(st.st_mode)) {
     ++		int fd_client;
      +		/*
     -+		 * An existing service process is alive and accepted our
     -+		 * connection.
     ++		 * A socket-inode at `path` exists on disk, but we
     ++		 * don't know whether it belongs to an active server
     ++		 * or if the last server died without cleaning up.
     ++		 *
     ++		 * Poke it with a trivial connection to try to find out.
      +		 */
     -+		close(fd_client);
     -+
     -+		/*
     -+		 * We cannot create a new socket-inode here, so we cannot
     -+		 * startup a new server on this pathname.
     -+		 */
     -+		errno = EADDRINUSE;
     -+		return error_errno(_("socket already in use '%s'"),
     ++		trace2_data_string("ipc-server", NULL, "try-detect-server",
      +				   path);
     ++		fd_client = unix_stream_connect(path);
     ++		if (fd_client >= 0) {
     ++			close(fd_client);
     ++			errno = EADDRINUSE;
     ++			return error_errno(_("socket already in use '%s'"),
     ++					   path);
     ++		}
      +	}
      +
     -+	trace2_data_string("ipc-server", NULL, "try-listen-force", path);
     -+
      +	/*
     -+	 * A socket-inode at pathname exists on disk, but we were not
     -+	 * able to connect to it, so we believe that this is a stale
     -+	 * socket-inode that a previous server forgot to delete.  Use
     -+	 * the tradional solution: force unlink it and create a new
     -+	 * one.
     -+	 *
     -+	 * TODO Note that it is possible that another server is
     -+	 * listening, but is either just starting up and not yet
     -+	 * responsive or is stuck somehow.  For now, I'm OK with
     -+	 * stealing the socket-inode from it in this case.
     ++	 * Create pathname to our "unique" socket and set it up for
     ++	 * business.
      +	 */
     -+	uslg_opts.force_unlink_before_bind = 1;
     -+	fd_listen = unix_stream_listen_gently(path, &uslg_opts);
     -+	if (fd_listen >= 0)
     -+		return fd_listen;
     -+
     -+	return error_errno(_("could not force create socket '%s'"), path);
     -+}
     -+
     -+static int setup_listener_socket(const char *path, ino_t *inode,
     -+				 const struct ipc_server_opts *ipc_opts)
     -+{
     -+	int fd_listen;
     -+	struct stat st;
     -+
     -+	trace2_region_enter("ipc-server", "create-listener_socket", NULL);
     -+	fd_listen = create_listener_socket(path, ipc_opts);
     -+	trace2_region_leave("ipc-server", "create-listener_socket", NULL);
     ++	strbuf_addf(&buf_uniq, "%s.%d", path, getpid());
      +
     -+	if (fd_listen < 0)
     -+		return fd_listen;
     -+
     -+	/*
     -+	 * We just bound a socket (descriptor) to a newly created unix
     -+	 * domain socket in the filesystem.  Capture the inode number
     -+	 * so we can later detect if/when someone else force-creates a
     -+	 * new socket and effectively steals the path from us.  (Which
     -+	 * would leave us listening to a socket that no client could
     -+	 * reach.)
     -+	 */
     -+	if (lstat(path, &st) < 0) {
     ++	uslg_opts.listen_backlog_size = LISTEN_BACKLOG;
     ++	uslg_opts.force_unlink_before_bind = 1;
     ++	uslg_opts.disallow_chdir = ipc_opts->uds_disallow_chdir;
     ++	fd_listen = unix_stream_listen(buf_uniq.buf, &uslg_opts);
     ++	if (fd_listen < 0) {
      +		int saved_errno = errno;
     ++		error_errno(_("could not create listener socket '%s'"),
     ++			    buf_uniq.buf);
     ++		strbuf_release(&buf_uniq);
     ++		errno = saved_errno;
     ++		return -1;
     ++	}
      +
     ++	if (lstat(buf_uniq.buf, st_socket)) {
     ++		int saved_errno = errno;
     ++		error_errno(_("could not stat listener socket '%s'"),
     ++			    buf_uniq.buf);
      +		close(fd_listen);
     -+		unlink(path);
     -+
     ++		unlink(buf_uniq.buf);
     ++		strbuf_release(&buf_uniq);
      +		errno = saved_errno;
     -+		return error_errno(_("could not lstat listener socket '%s'"),
     -+				   path);
     ++		return -1;
      +	}
      +
      +	if (set_socket_blocking_flag(fd_listen, 1)) {
      +		int saved_errno = errno;
     -+
     ++		error_errno(_("could not set listener socket nonblocking '%s'"),
     ++			    buf_uniq.buf);
      +		close(fd_listen);
     -+		unlink(path);
     ++		unlink(buf_uniq.buf);
     ++		strbuf_release(&buf_uniq);
     ++		errno = saved_errno;
     ++		return -1;
     ++	}
      +
     ++	/*
     ++	 * Install it as the "real" socket so that clients will starting
     ++	 * connecting to our socket.
     ++	 */
     ++	if (rename(buf_uniq.buf, path)) {
     ++		int saved_errno = errno;
     ++		error_errno(_("could not create listener socket '%s'"), path);
     ++		close(fd_listen);
     ++		unlink(buf_uniq.buf);
     ++		strbuf_release(&buf_uniq);
      +		errno = saved_errno;
     -+		return error_errno(_("making listener socket nonblocking '%s'"),
     -+				   path);
     ++		return -1;
      +	}
      +
     -+	*inode = st.st_ino;
     ++	strbuf_release(&buf_uniq);
     ++	trace2_data_string("ipc-server", NULL, "try-listen", path);
     ++	return fd_listen;
     ++}
     ++
     ++static int setup_listener_socket(const char *path, struct stat *st_socket,
     ++				 const struct ipc_server_opts *ipc_opts)
     ++{
     ++	int fd_listen;
     ++
     ++	trace2_region_enter("ipc-server", "create-listener_socket", NULL);
     ++	fd_listen = create_listener_socket(path, ipc_opts, st_socket);
     ++	trace2_region_leave("ipc-server", "create-listener_socket", NULL);
      +
      +	return fd_listen;
      +}
     @@ compat/simple-ipc/ipc-unix-socket.c (new)
      +{
      +	struct ipc_server_data *server_data;
      +	int fd_listen;
     -+	ino_t inode_listen;
     ++	struct stat st_listen;
      +	int sv[2];
      +	int k;
      +	int nr_threads = opts->nr_threads;
     @@ compat/simple-ipc/ipc-unix-socket.c (new)
      +				   path);
      +	}
      +
     -+	fd_listen = setup_listener_socket(path, &inode_listen, opts);
     ++	fd_listen = setup_listener_socket(path, &st_listen, opts);
      +	if (fd_listen < 0) {
      +		int saved_errno = errno;
      +		close(sv[0]);
     @@ compat/simple-ipc/ipc-unix-socket.c (new)
      +	server_data->accept_thread->magic = MAGIC_ACCEPT_THREAD_DATA;
      +	server_data->accept_thread->server_data = server_data;
      +	server_data->accept_thread->fd_listen = fd_listen;
     -+	server_data->accept_thread->inode_listen = inode_listen;
     ++	server_data->accept_thread->st_listen = st_listen;
      +	server_data->accept_thread->fd_send_shutdown = sv[0];
      +	server_data->accept_thread->fd_wait_shutdown = sv[1];
      +

-- 
gitgitgadget
