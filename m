Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98A97C433E0
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 21:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 577E964E76
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 21:49:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232648AbhBQVtf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 16:49:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232029AbhBQVtc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 16:49:32 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC182C061574
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 13:48:51 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id g6so18940643wrs.11
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 13:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=vKbNZP1PORr6LD+7pUTIR6wDyX7dBBC77nSviFop1fc=;
        b=SxeERNTSr0lPXS8nHy3oK6xxPLTyCtKlzE/mnDMdZ+ZJn3X+dxLLcXuFJV1Q6Ln4/d
         nb7HDstnhRXr4kRvUsiKrhVGhXi5BAHx2A5HGl8JSRvCN6KFkScyKEQ8bFwCAf/gxafd
         ByX5WvGvKXPi1+3fCGJvst0mON0YURrMLenTLeOPzNkvdPO6ieEKbUJ8AlX6Kxi0+6oU
         OWbby1kg0eKM8VPVJfvGP4O8Kpi77uyFSrH2yqNzACn36TU8ZzQwosxPwPtY50J7KRYh
         hxrXwsQ9Q3OHUWQqDccGYQBwYrlYLbI/46ANrogV+jYtwA+gW5G3DwpilQmM5eAkF5lT
         eN3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=vKbNZP1PORr6LD+7pUTIR6wDyX7dBBC77nSviFop1fc=;
        b=ata1GcFJw6dNP9aq9GWkCievliNq7UzWB2yN+tRcqC46riDUtGwCOReGfQjqJlLQMe
         25rjqW7rKXPHOIeVHG5TKXElAvzEbLQJIK6Te8Z/vdhnBrzR5zQQGA8tCHMedR84N8xL
         /Up3PQ6PuUvHPnRdjHzmkm5om66MEsbSRLjYmxRkh0fvg68GJ+uynrdVC4uc37eeMbR4
         fU/If+iJElCIIh59Tmqnca0Ya9liE1BYnsJ3WFnD5JVXMj75aJCX0LWnYWn1X4QUeohx
         QuQcdLIIwrF4gM7fHFih5Zqmxvq/20dR5E4C4Y7KafA/w4HwDl2wdaTscVpNCBDNKHXd
         brQQ==
X-Gm-Message-State: AOAM532tpHaeNTnLVgeToDx8LN1OJU3tifrxF6QAEkEblerR5WRMqn7X
        +7ia1DDUY6nZbRo0uky/s0PNDirqPAo=
X-Google-Smtp-Source: ABdhPJy4je5ak40IMAkLXiB/GRk7S5KKsnRi4ZqHmmrLM4jJY4/bqsG6pLKL6P+h87uAVHVnq8vLog==
X-Received: by 2002:adf:f10c:: with SMTP id r12mr1099355wro.185.1613598530507;
        Wed, 17 Feb 2021 13:48:50 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x11sm5432984wrv.83.2021.02.17.13.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 13:48:50 -0800 (PST)
Message-Id: <pull.766.v4.git.1613598529.gitgitgadget@gmail.com>
In-Reply-To: <pull.766.v3.git.1613174954.gitgitgadget@gmail.com>
References: <pull.766.v3.git.1613174954.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 17 Feb 2021 21:48:36 +0000
Subject: [PATCH v4 00/12] Simple IPC Mechanism
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <git@jeffhostetler.com>, Jeff King <peff@peff.net>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is V4 of my "Simple IPC" series. It addresses Gábor's comment WRT
shutting down the server to make unit tests more predictable on CI servers.
(https://lore.kernel.org/git/20210213093052.GJ1015009@szeder.dev)

Jeff

cc: Ævar Arnfjörð Bjarmason avarab@gmail.com cc: Jeff Hostetler
git@jeffhostetler.com cc: Jeff King peff@peff.net cc: Chris Torek
chris.torek@gmail.com

Jeff Hostetler (9):
  pkt-line: eliminate the need for static buffer in
    packet_write_gently()
  simple-ipc: design documentation for new IPC mechanism
  simple-ipc: add win32 implementation
  unix-socket: elimiate static unix_stream_socket() helper function
  unix-socket: add backlog size option to unix_stream_listen()
  unix-socket: disallow chdir() when creating unix domain sockets
  unix-socket: create `unix_stream_server__listen_with_lock()`
  simple-ipc: add Unix domain socket implementation
  t0052: add simple-ipc tests and t/helper/test-simple-ipc tool

Johannes Schindelin (3):
  pkt-line: do not issue flush packets in write_packetized_*()
  pkt-line: (optionally) libify the packet readers
  pkt-line: add options argument to read_packetized_to_strbuf()

 Documentation/technical/api-simple-ipc.txt |  34 +
 Makefile                                   |   8 +
 builtin/credential-cache--daemon.c         |   3 +-
 builtin/credential-cache.c                 |   2 +-
 compat/simple-ipc/ipc-shared.c             |  28 +
 compat/simple-ipc/ipc-unix-socket.c        | 979 +++++++++++++++++++++
 compat/simple-ipc/ipc-win32.c              | 749 ++++++++++++++++
 config.mak.uname                           |   2 +
 contrib/buildsystems/CMakeLists.txt        |   6 +
 convert.c                                  |  16 +-
 pkt-line.c                                 |  57 +-
 pkt-line.h                                 |  20 +-
 simple-ipc.h                               | 235 +++++
 t/helper/test-simple-ipc.c                 | 773 ++++++++++++++++
 t/helper/test-tool.c                       |   1 +
 t/helper/test-tool.h                       |   1 +
 t/t0052-simple-ipc.sh                      | 122 +++
 unix-socket.c                              | 168 +++-
 unix-socket.h                              |  47 +-
 19 files changed, 3198 insertions(+), 53 deletions(-)
 create mode 100644 Documentation/technical/api-simple-ipc.txt
 create mode 100644 compat/simple-ipc/ipc-shared.c
 create mode 100644 compat/simple-ipc/ipc-unix-socket.c
 create mode 100644 compat/simple-ipc/ipc-win32.c
 create mode 100644 simple-ipc.h
 create mode 100644 t/helper/test-simple-ipc.c
 create mode 100755 t/t0052-simple-ipc.sh


base-commit: 773e25afc41b1b6533fa9ae2cd825d0b4a697fad
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-766%2Fjeffhostetler%2Fsimple-ipc-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-766/jeffhostetler/simple-ipc-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/766

Range-diff vs v3:

  1:  2d6858b1625a =  1:  2d6858b1625a pkt-line: eliminate the need for static buffer in packet_write_gently()
  2:  91a9f63d6692 =  2:  91a9f63d6692 pkt-line: do not issue flush packets in write_packetized_*()
  3:  e05467def4e1 =  3:  e05467def4e1 pkt-line: (optionally) libify the packet readers
  4:  81e14bed955c =  4:  81e14bed955c pkt-line: add options argument to read_packetized_to_strbuf()
  5:  22eec60761a8 =  5:  22eec60761a8 simple-ipc: design documentation for new IPC mechanism
  6:  171ec43ecfa4 =  6:  171ec43ecfa4 simple-ipc: add win32 implementation
  7:  b368318e6a23 =  7:  b368318e6a23 unix-socket: elimiate static unix_stream_socket() helper function
  8:  985b2e02b2df =  8:  985b2e02b2df unix-socket: add backlog size option to unix_stream_listen()
  9:  1bfa36409d07 =  9:  1bfa36409d07 unix-socket: disallow chdir() when creating unix domain sockets
 10:  b443e11ac32f = 10:  b443e11ac32f unix-socket: create `unix_stream_server__listen_with_lock()`
 11:  43c8db9a4468 = 11:  43c8db9a4468 simple-ipc: add Unix domain socket implementation
 12:  1e5c856ade85 ! 12:  09568a6500dd t0052: add simple-ipc tests and t/helper/test-simple-ipc tool
     @@ t/helper/test-simple-ipc.c (new)
      +static ipc_server_application_cb test_app_cb;
      +
      +/*
     -+ * This is "application callback" that sits on top of the "ipc-server".
     -+ * It completely defines the set of command verbs supported by this
     -+ * application.
     ++ * This is the "application callback" that sits on top of the
     ++ * "ipc-server".  It completely defines the set of commands supported
     ++ * by this application.
      + */
      +static int test_app_cb(void *application_data,
      +		       const char *command,
     @@ t/helper/test-simple-ipc.c (new)
      + * Send an IPC command to an already-running server daemon and print the
      + * response.
      + *
     -+ * argv[2] contains a simple (1 word) command verb that `test_app_cb()`
     -+ * (in the daemon process) will understand.
     ++ * argv[2] contains a simple (1 word) command that `test_app_cb()` (in
     ++ * the daemon process) will understand.
      + */
      +static int client__send_ipc(int argc, const char **argv, const char *path)
      +{
     @@ t/helper/test-simple-ipc.c (new)
      +}
      +
      +/*
     ++ * Send an IPC command to an already-running server and ask it to
     ++ * shutdown.  "send quit" is an async request and queues a shutdown
     ++ * event in the server, so we spin and wait here for it to actually
     ++ * shutdown to make the unit tests a little easier to write.
     ++ */
     ++static int client__stop_server(int argc, const char **argv, const char *path)
     ++{
     ++	const char *send_quit[] = { argv[0], "send", "quit", NULL };
     ++	int max_wait_sec = 60;
     ++	int ret;
     ++	time_t time_limit, now;
     ++	enum ipc_active_state s;
     ++
     ++	const char * const stop_usage[] = {
     ++		N_("test-helper simple-ipc stop-daemon [<options>]"),
     ++		NULL
     ++	};
     ++
     ++	struct option stop_options[] = {
     ++		OPT_INTEGER(0, "max-wait", &max_wait_sec,
     ++			    N_("seconds to wait for daemon to stop")),
     ++		OPT_END()
     ++	};
     ++
     ++	argc = parse_options(argc, argv, NULL, stop_options, stop_usage, 0);
     ++
     ++	if (max_wait_sec < 0)
     ++		max_wait_sec = 0;
     ++
     ++	time(&time_limit);
     ++	time_limit += max_wait_sec;
     ++
     ++	ret = client__send_ipc(3, send_quit, path);
     ++	if (ret)
     ++		return ret;
     ++
     ++	for (;;) {
     ++		sleep_millisec(100);
     ++
     ++		s = ipc_get_active_state(path);
     ++
     ++		if (s != IPC_STATE__LISTENING) {
     ++			/*
     ++			 * The socket/pipe is gone and/or has stopped
     ++			 * responding.  Lets assume that the daemon
     ++			 * process has exited too.
     ++			 */
     ++			return 0;
     ++		}
     ++
     ++		time(&now);
     ++		if (now > time_limit)
     ++			return error(_("daemon has not shutdown yet"));
     ++	}
     ++}
     ++
     ++/*
      + * Send an IPC command followed by ballast to confirm that a large
      + * message can be sent and that the kernel or pkt-line layers will
      + * properly chunk it and that the daemon receives the entire message.
     @@ t/helper/test-simple-ipc.c (new)
      +	if (client__probe_server(path))
      +		return 1;
      +
     ++	if (argc >= 2 && !strcmp(argv[1], "stop-daemon"))
     ++		return !!client__stop_server(argc, argv, path);
     ++
      +	if ((argc == 2 || argc == 3) && !strcmp(argv[1], "send"))
      +		return !!client__send_ipc(argc, argv, path);
      +
     @@ t/t0052-simple-ipc.sh (new)
      +}
      +
      +stop_simple_IPC_server () {
     -+	test-tool simple-ipc send quit
     ++	test-tool simple-ipc stop-daemon
      +}
      +
      +test_expect_success 'start simple command server' '
     @@ t/t0052-simple-ipc.sh (new)
      +	test_cmp expect_a actual_a
      +'
      +
     -+# Sending a "quit" message to the server causes it to start an "async
     -+# shutdown" -- queuing shutdown events to all socket/pipe thread-pool
     -+# threads.  Each thread will process that event after finishing
     -+# (draining) any in-progress IO with other clients.  So when the "send
     -+# quit" client command exits, the ipc-server may still be running (but
     -+# it should be cleaning up).
     -+#
     -+# So, insert a generous sleep here to give the server time to shutdown.
     -+#
     -+test_expect_success '`quit` works' '
     -+	test-tool simple-ipc send quit &&
     -+
     -+	sleep 5 &&
     -+
     ++test_expect_success 'stop-daemon works' '
     ++	test-tool simple-ipc stop-daemon &&
      +	test_must_fail test-tool simple-ipc is-active &&
      +	test_must_fail test-tool simple-ipc send ping
      +'

-- 
gitgitgadget
