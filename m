Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6047DC433E6
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 21:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AD9264F0F
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 21:09:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233486AbhCOVIs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 17:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbhCOVId (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Mar 2021 17:08:33 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 998F7C06174A
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 14:08:32 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id v11so6380236wro.7
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 14:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=DOycpx8uh3Rm8eofJA6li7HW4H4ybI2s3KqsEchCP5Q=;
        b=EMymzmBbZ8qfgV7vr9H87f5jE8Mwrz/+4/xB2zKqsfbBohggzfyxEhewXmnBUakVnz
         YmKG+ea5cLMU91x65kuWT79lG1BDlfyOmJCUFa7jZb8qqPIhnB0/pR5l6SY+enItZPwp
         M2QUo98RfxVEu0uCCfjgbeLBK78XH8Lyx0MgRO1kJ5UmExajT1eHCTTDseykk+VqXpk+
         kPZXI/SePbSotipCUd6bd+/UpppNYn9Rtqtx8uc2bvl+VZRwQhmIWaTjr8ru/Owr0zaF
         8ytwwPHIsanqDLfxW6/Y8g/2GgJyLH2cGLWzXTs7Cvye/JAddN6vmp7jEbqi7P6pMiD/
         hcEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=DOycpx8uh3Rm8eofJA6li7HW4H4ybI2s3KqsEchCP5Q=;
        b=bDa9iICaJu4SHplyjQdHRFGr3DA6/JRuNvuk0Ya8nj2pP/hpua7J745mqPu/TjSjXi
         iUIF3gWMKJZtS3ADoGxI4gkfjTqfDcAEiV1pzzqAoRdJlVroosqRV16NrlklweGZ+2mA
         M2GzRYP/qYxYO7MHESFS/re201TXg8MAthhMLgIldkUVFw2ypvAUnZOnitf7hF06i2zF
         6jtIwoZRcPGUfjTZe1ZSBvS3GamLZTtB7rRjdw3bGURq8w2b6Iy/z2sxq2ps7UuSPvXA
         6ZBft0W917bNlmzoOU6eJBawDWTqjRStLig6i5tQYM0q65dGcT7JzCVIMqobkzBectXd
         pT4w==
X-Gm-Message-State: AOAM530YFR7nOfo41A/Ilebs/9vPfACYyujEUDwo5uYIn6QOc5runQWZ
        sT36Zpd0hiTGvxVZLvFI5Uw/c/vzCiQ=
X-Google-Smtp-Source: ABdhPJxFyKoPFWUqNGGiTAzO5Aiu8BfJbrLi/WDB9hho1nzL4PjzuQXU+2Wh9eb/Uc2NoprpKD3nYA==
X-Received: by 2002:adf:f4c1:: with SMTP id h1mr1461490wrp.71.1615842511274;
        Mon, 15 Mar 2021 14:08:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j9sm855020wmi.24.2021.03.15.14.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 14:08:30 -0700 (PDT)
Message-Id: <pull.766.v6.git.1615842509.gitgitgadget@gmail.com>
In-Reply-To: <pull.766.v5.git.1615302157.gitgitgadget@gmail.com>
References: <pull.766.v5.git.1615302157.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 15 Mar 2021 21:08:17 +0000
Subject: [PATCH v6 00/12] Simple IPC Mechanism
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Jeff King <peff@peff.net>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Chris Torek <chris.torek@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is V6 of my "Simple IPC" series. This version addresses comments from
last week on V5. This includes:

 1. Removing "perf and" in pkt-line.c
 2. Better comments to describe the various timeout #define's.
 3. Remove the double-underscore and shorten the "unix_stream_server"
    prefix.

Thanks Jeff

Jeff Hostetler (9):
  pkt-line: eliminate the need for static buffer in
    packet_write_gently()
  simple-ipc: design documentation for new IPC mechanism
  simple-ipc: add win32 implementation
  unix-socket: eliminate static unix_stream_socket() helper function
  unix-socket: add backlog size option to unix_stream_listen()
  unix-socket: disallow chdir() when creating unix domain sockets
  unix-stream-server: create unix domain socket under lock
  simple-ipc: add Unix domain socket implementation
  t0052: add simple-ipc tests and t/helper/test-simple-ipc tool

Johannes Schindelin (3):
  pkt-line: do not issue flush packets in write_packetized_*()
  pkt-line: add PACKET_READ_GENTLE_ON_READ_ERROR option
  pkt-line: add options argument to read_packetized_to_strbuf()

 Documentation/technical/api-simple-ipc.txt |  105 ++
 Makefile                                   |    9 +
 builtin/credential-cache--daemon.c         |    3 +-
 builtin/credential-cache.c                 |    2 +-
 compat/simple-ipc/ipc-shared.c             |   28 +
 compat/simple-ipc/ipc-unix-socket.c        | 1000 ++++++++++++++++++++
 compat/simple-ipc/ipc-win32.c              |  751 +++++++++++++++
 config.mak.uname                           |    2 +
 contrib/buildsystems/CMakeLists.txt        |    8 +-
 convert.c                                  |   11 +-
 pkt-line.c                                 |   59 +-
 pkt-line.h                                 |   17 +-
 simple-ipc.h                               |  239 +++++
 t/helper/test-simple-ipc.c                 |  787 +++++++++++++++
 t/helper/test-tool.c                       |    1 +
 t/helper/test-tool.h                       |    1 +
 t/t0052-simple-ipc.sh                      |  122 +++
 unix-socket.c                              |   53 +-
 unix-socket.h                              |   12 +-
 unix-stream-server.c                       |  125 +++
 unix-stream-server.h                       |   33 +
 21 files changed, 3316 insertions(+), 52 deletions(-)
 create mode 100644 Documentation/technical/api-simple-ipc.txt
 create mode 100644 compat/simple-ipc/ipc-shared.c
 create mode 100644 compat/simple-ipc/ipc-unix-socket.c
 create mode 100644 compat/simple-ipc/ipc-win32.c
 create mode 100644 simple-ipc.h
 create mode 100644 t/helper/test-simple-ipc.c
 create mode 100755 t/t0052-simple-ipc.sh
 create mode 100644 unix-stream-server.c
 create mode 100644 unix-stream-server.h


base-commit: f01623b2c9d14207e497b21ebc6b3ec4afaf4b46
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-766%2Fjeffhostetler%2Fsimple-ipc-v6
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-766/jeffhostetler/simple-ipc-v6
Pull-Request: https://github.com/gitgitgadget/git/pull/766

Range-diff vs v5:

  1:  311ea4a5cd71 !  1:  fe35dc3d292d pkt-line: eliminate the need for static buffer in packet_write_gently()
     @@ pkt-line.c: int packet_write_fmt_gently(int fd, const char *fmt, ...)
      +	set_packet_header(header, packet_size);
      +
      +	/*
     -+	 * Write the header and the buffer in 2 parts so that we do not need
     -+	 * to allocate a buffer or rely on a static buffer.  This avoids perf
     -+	 * and multi-threading issues.
     ++	 * Write the header and the buffer in 2 parts so that we do
     ++	 * not need to allocate a buffer or rely on a static buffer.
     ++	 * This also avoids putting a large buffer on the stack which
     ++	 * might have multi-threading issues.
      +	 */
      +
      +	if (write_in_full(fd_out, header, 4) < 0 ||
  2:  25157c1f4873 =  2:  de11b3036148 pkt-line: do not issue flush packets in write_packetized_*()
  3:  af3d13113bc9 =  3:  3718da39da30 pkt-line: add PACKET_READ_GENTLE_ON_READ_ERROR option
  4:  b73e66a69b61 =  4:  b43df7ad0b7a pkt-line: add options argument to read_packetized_to_strbuf()
  5:  1ae99d824a21 =  5:  f829feb2aa93 simple-ipc: design documentation for new IPC mechanism
  6:  8b3ce40e4538 =  6:  58c3fb7cd776 simple-ipc: add win32 implementation
  7:  34df1af98e5b =  7:  4e8c352fb366 unix-socket: eliminate static unix_stream_socket() helper function
  8:  d6ff6e0e050a =  8:  3b71f52d8628 unix-socket: add backlog size option to unix_stream_listen()
  9:  21b8d3c63dbf =  9:  5972a198361c unix-socket: disallow chdir() when creating unix domain sockets
 10:  1ee9de55a106 ! 10:  02c885fd623d unix-stream-server: create unix domain socket under lock
     @@ unix-stream-server.c (new)
      +	return 0;
      +}
      +
     -+int unix_stream_server__create(
     -+	const char *path,
     -+	const struct unix_stream_listen_opts *opts,
     -+	long timeout_ms,
     -+	struct unix_stream_server_socket **new_server_socket)
     ++int unix_ss_create(const char *path,
     ++		   const struct unix_stream_listen_opts *opts,
     ++		   long timeout_ms,
     ++		   struct unix_ss_socket **new_server_socket)
      +{
      +	struct lock_file lock = LOCK_INIT;
      +	int fd_socket;
     -+	struct unix_stream_server_socket *server_socket;
     ++	struct unix_ss_socket *server_socket;
      +
      +	*new_server_socket = NULL;
      +
     @@ unix-stream-server.c (new)
      +	return 0;
      +}
      +
     -+void unix_stream_server__free(
     -+	struct unix_stream_server_socket *server_socket)
     ++void unix_ss_free(struct unix_ss_socket *server_socket)
      +{
      +	if (!server_socket)
      +		return;
      +
      +	if (server_socket->fd_socket >= 0) {
     -+		if (!unix_stream_server__was_stolen(server_socket))
     ++		if (!unix_ss_was_stolen(server_socket))
      +			unlink(server_socket->path_socket);
      +		close(server_socket->fd_socket);
      +	}
     @@ unix-stream-server.c (new)
      +	free(server_socket);
      +}
      +
     -+int unix_stream_server__was_stolen(
     -+	struct unix_stream_server_socket *server_socket)
     ++int unix_ss_was_stolen(struct unix_ss_socket *server_socket)
      +{
      +	struct stat st_now;
      +
     @@ unix-stream-server.h (new)
      +
      +#include "unix-socket.h"
      +
     -+struct unix_stream_server_socket {
     ++struct unix_ss_socket {
      +	char *path_socket;
      +	struct stat st_socket;
      +	int fd_socket;
     @@ unix-stream-server.h (new)
      + *
      + * Returns 0 on success, -1 on error, -2 if socket is in use.
      + */
     -+int unix_stream_server__create(
     -+	const char *path,
     -+	const struct unix_stream_listen_opts *opts,
     -+	long timeout_ms,
     -+	struct unix_stream_server_socket **server_socket);
     ++int unix_ss_create(const char *path,
     ++		   const struct unix_stream_listen_opts *opts,
     ++		   long timeout_ms,
     ++		   struct unix_ss_socket **server_socket);
      +
      +/*
      + * Close and delete the socket.
      + */
     -+void unix_stream_server__free(
     -+	struct unix_stream_server_socket *server_socket);
     ++void unix_ss_free(struct unix_ss_socket *server_socket);
      +
      +/*
      + * Return 1 if the inode of the pathname to our socket changes.
      + */
     -+int unix_stream_server__was_stolen(
     -+	struct unix_stream_server_socket *server_socket);
     ++int unix_ss_was_stolen(struct unix_ss_socket *server_socket);
      +
      +#endif /* UNIX_STREAM_SERVER_H */
 11:  f2e3b046cc8f ! 11:  4c2199231d05 simple-ipc: add Unix domain socket implementation
     @@ compat/simple-ipc/ipc-unix-socket.c (new)
      +}
      +
      +/*
     -+ * This value was chosen at random.
     ++ * Retry frequency when trying to connect to a server.
     ++ *
     ++ * This value should be short enough that we don't seriously delay our
     ++ * caller, but not fast enough that our spinning puts pressure on the
     ++ * system.
      + */
      +#define WAIT_STEP_MS (50)
      +
     @@ compat/simple-ipc/ipc-unix-socket.c (new)
      +	const struct ipc_client_connect_options *options,
      +	int *pfd)
      +{
     -+	int wait_ms = 50;
      +	int k;
      +
      +	*pfd = -1;
      +
     -+	for (k = 0; k < timeout_ms; k += wait_ms) {
     ++	for (k = 0; k < timeout_ms; k += WAIT_STEP_MS) {
      +		int fd = unix_stream_connect(path, options->uds_disallow_chdir);
      +
      +		if (fd != -1) {
     @@ compat/simple-ipc/ipc-unix-socket.c (new)
      +		return IPC_STATE__OTHER_ERROR;
      +
      +	sleep_and_try_again:
     -+		sleep_millisec(wait_ms);
     ++		sleep_millisec(WAIT_STEP_MS);
      +	}
      +
      +	return IPC_STATE__NOT_LISTENING;
      +}
      +
      +/*
     -+ * A randomly chosen timeout value.
     ++ * The total amount of time that we are willing to wait when trying to
     ++ * connect to a server.
     ++ *
     ++ * When the server is first started, it might take a little while for
     ++ * it to become ready to service requests.  Likewise, the server may
     ++ * be very (temporarily) busy and not respond to our connections.
     ++ *
     ++ * We should gracefully and silently handle those conditions and try
     ++ * again for a reasonable time period.
     ++ *
     ++ * The value chosen here should be long enough for the server
     ++ * to reliably heal from the above conditions.
      + */
      +#define MY_CONNECTION_TIMEOUT_MS (1000)
      +
     @@ compat/simple-ipc/ipc-unix-socket.c (new)
      +	enum magic magic;
      +	struct ipc_server_data *server_data;
      +
     -+	struct unix_stream_server_socket *server_socket;
     ++	struct unix_ss_socket *server_socket;
      +
      +	int fd_send_shutdown;
      +	int fd_wait_shutdown;
     @@ compat/simple-ipc/ipc-unix-socket.c (new)
      +			 * will be routed elsewhere and we silently starve.
      +			 * If that happens, just queue a shutdown.
      +			 */
     -+			if (unix_stream_server__was_stolen(
     ++			if (unix_ss_was_stolen(
      +				    accept_thread_data->server_socket)) {
      +				trace2_data_string("ipc-accept", NULL,
      +						   "queue_stop_async",
     @@ compat/simple-ipc/ipc-unix-socket.c (new)
      +static int create_listener_socket(
      +	const char *path,
      +	const struct ipc_server_opts *ipc_opts,
     -+	struct unix_stream_server_socket **new_server_socket)
     ++	struct unix_ss_socket **new_server_socket)
      +{
     -+	struct unix_stream_server_socket *server_socket = NULL;
     ++	struct unix_ss_socket *server_socket = NULL;
      +	struct unix_stream_listen_opts uslg_opts = UNIX_STREAM_LISTEN_OPTS_INIT;
      +	int ret;
      +
      +	uslg_opts.listen_backlog_size = LISTEN_BACKLOG;
      +	uslg_opts.disallow_chdir = ipc_opts->uds_disallow_chdir;
      +
     -+	ret = unix_stream_server__create(path, &uslg_opts, -1, &server_socket);
     ++	ret = unix_ss_create(path, &uslg_opts, -1, &server_socket);
      +	if (ret)
      +		return ret;
      +
      +	if (set_socket_blocking_flag(server_socket->fd_socket, 1)) {
      +		int saved_errno = errno;
     -+		unix_stream_server__free(server_socket);
     ++		unix_ss_free(server_socket);
      +		errno = saved_errno;
      +		return -1;
      +	}
     @@ compat/simple-ipc/ipc-unix-socket.c (new)
      +static int setup_listener_socket(
      +	const char *path,
      +	const struct ipc_server_opts *ipc_opts,
     -+	struct unix_stream_server_socket **new_server_socket)
     ++	struct unix_ss_socket **new_server_socket)
      +{
      +	int ret, saved_errno;
      +
     @@ compat/simple-ipc/ipc-unix-socket.c (new)
      +			 ipc_server_application_cb *application_cb,
      +			 void *application_data)
      +{
     -+	struct unix_stream_server_socket *server_socket = NULL;
     ++	struct unix_ss_socket *server_socket = NULL;
      +	struct ipc_server_data *server_data;
      +	int sv[2];
      +	int k;
     @@ compat/simple-ipc/ipc-unix-socket.c (new)
      +
      +	accept_thread_data = server_data->accept_thread;
      +	if (accept_thread_data) {
     -+		unix_stream_server__free(accept_thread_data->server_socket);
     ++		unix_ss_free(accept_thread_data->server_socket);
      +
      +		if (accept_thread_data->fd_send_shutdown != -1)
      +			close(accept_thread_data->fd_send_shutdown);
 12:  6ccc7472096f = 12:  132b6f3271be t0052: add simple-ipc tests and t/helper/test-simple-ipc tool

-- 
gitgitgadget
