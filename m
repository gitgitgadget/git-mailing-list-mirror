Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4182C433E0
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 10:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D981619A4
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 10:30:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbhCVK3z (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Mar 2021 06:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhCVK3x (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Mar 2021 06:29:53 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 961A1C061574
        for <git@vger.kernel.org>; Mon, 22 Mar 2021 03:29:52 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id 61so16052525wrm.12
        for <git@vger.kernel.org>; Mon, 22 Mar 2021 03:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=YUUrQa0DaczNHaXYIzbTbFy1ge0QSHxB5pLTiAloQ8w=;
        b=ToEqFomv66CUr+hcbCaALX8t3uWmvH+1ZHCrJqLF1PtjXFyD1B6vf8ybdJ1qOpGN1e
         srCVkkeYMRERdumR/Eq+G/FUe1dckMOYU9bOLu64aMY+zr2y33filTQXkPzBsFBKHnHt
         Bh2EjFHRCG00KbaNFywrPYsI3nfWD9p5B1l9BSBICFZ9hDqDPM9Bitnb1HFe6QuoDrc4
         zV/tOMP9YhuRkTR0ZasZFzDE25YI8dp0Oe983HdtssHjK2yRGzM9O9TVJ6TzG6ihHaQi
         PyA0ty2a12dObUs9o0h8J3Tm8+9hwwXsgJl5KTIMEuzFgv7rU+kyC+7o3Y3bfH9nMSkr
         z5Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=YUUrQa0DaczNHaXYIzbTbFy1ge0QSHxB5pLTiAloQ8w=;
        b=X6hg0PzjHflb7eLWl0Kng+SP2mWYUyQKC7cOyZglus7+cdZV1ZMv4RP6xXoQhb+1gM
         jVFOwkn7EYHX0o391f+IUtj2hxKNJcOIJEQEfixwvSCmg+ELZ8EtxJms4lDb8CtuXpvk
         kRfjBSf3KMq6eqNK9H5gVBPH0Sm6z3M2NDCjmwFkx/2gBpxjiap4reWICXQmiO+Dci66
         8PS8XVM4Npg7qVwJkRCZB51pp+zRz+lzphZx7J1BQ6JBz8VC6rGx6u8bLPg1ONDW9c1E
         qcqB488UHNX5HGU91yJG0AH24J/g+xTqZIXrDOGBUO1qT1Jd+JrS39yt1i6v6lM/0fGV
         1U9w==
X-Gm-Message-State: AOAM533N7cYfbiSfTWiTU4nRQ/hbtZ63ZVBcQ6QLRS3FIJhuXeUzDdq9
        wW2vONYLxh7TYAtNPLx6Z2BvhkABRrA=
X-Google-Smtp-Source: ABdhPJx3ey1jjGrXBmRs6aoi807r8gbc75hjqLmMlMZYnGaCuPxUovebt6lFr0dX1GH8eSsYWXq5CA==
X-Received: by 2002:adf:828e:: with SMTP id 14mr17489690wrc.123.1616408991327;
        Mon, 22 Mar 2021 03:29:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r11sm19460187wrm.26.2021.03.22.03.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 03:29:50 -0700 (PDT)
Message-Id: <pull.766.v7.git.1616408989.gitgitgadget@gmail.com>
In-Reply-To: <pull.766.v6.git.1615842509.gitgitgadget@gmail.com>
References: <pull.766.v6.git.1615842509.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 22 Mar 2021 10:29:36 +0000
Subject: [PATCH v7 00/12] Simple IPC Mechanism
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

Here is version V7 of my simple-ipc series. The only change from V6 is to
squash in the CALLOC_ARRAY() suggestion.

$ git range-diff v2.31.0-rc1..pr-766/jeffhostetler/simple-ipc-v6
v2.31.0-rc1..HEAD 1: fe35dc3d29 = 1: fe35dc3d29 pkt-line: eliminate the need
for static buffer in packet_write_gently() 2: de11b30361 = 2: de11b30361
pkt-line: do not issue flush packets in write_packetized_*() 3: 3718da39da =
3: 3718da39da pkt-line: add PACKET_READ_GENTLE_ON_READ_ERROR option 4:
b43df7ad0b = 4: b43df7ad0b pkt-line: add options argument to
read_packetized_to_strbuf() 5: f829feb2aa = 5: f829feb2aa simple-ipc: design
documentation for new IPC mechanism 6: 58c3fb7cd7 = 6: 58c3fb7cd7
simple-ipc: add win32 implementation 7: 4e8c352fb3 = 7: 4e8c352fb3
unix-socket: eliminate static unix_stream_socket() helper function 8:
3b71f52d86 = 8: 3b71f52d86 unix-socket: add backlog size option to
unix_stream_listen() 9: 5972a19836 = 9: 5972a19836 unix-socket: disallow
chdir() when creating unix domain sockets 10: 02c885fd62 = 10: 02c885fd62
unix-stream-server: create unix domain socket under lock 11: 4c2199231d !
11: eee5f4796d simple-ipc: add Unix domain socket implementation @@
compat/simple-ipc/ipc-unix-socket.c (new) +
pthread_cond_init(&server_data->work_available_cond, NULL); + +
server_data->queue_size = nr_threads * FIFO_SCALE; -+ server_data->fifo_fds
= xcalloc(server_data->queue_size, -+ sizeof(*server_data->fifo_fds)); ++
CALLOC_ARRAY(server_data->fifo_fds, server_data->queue_size); + +
server_data->accept_thread = + xcalloc(1,
sizeof(*server_data->accept_thread)); 12: 132b6f3271 = 12: 8b5dcca684 t0052:
add simple-ipc tests and t/helper/test-simple-ipc tool

Jeff

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

 Documentation/technical/api-simple-ipc.txt | 105 +++
 Makefile                                   |   9 +
 builtin/credential-cache--daemon.c         |   3 +-
 builtin/credential-cache.c                 |   2 +-
 compat/simple-ipc/ipc-shared.c             |  28 +
 compat/simple-ipc/ipc-unix-socket.c        | 999 +++++++++++++++++++++
 compat/simple-ipc/ipc-win32.c              | 751 ++++++++++++++++
 config.mak.uname                           |   2 +
 contrib/buildsystems/CMakeLists.txt        |   8 +-
 convert.c                                  |  11 +-
 pkt-line.c                                 |  59 +-
 pkt-line.h                                 |  17 +-
 simple-ipc.h                               | 239 +++++
 t/helper/test-simple-ipc.c                 | 787 ++++++++++++++++
 t/helper/test-tool.c                       |   1 +
 t/helper/test-tool.h                       |   1 +
 t/t0052-simple-ipc.sh                      | 122 +++
 unix-socket.c                              |  53 +-
 unix-socket.h                              |  12 +-
 unix-stream-server.c                       | 125 +++
 unix-stream-server.h                       |  33 +
 21 files changed, 3315 insertions(+), 52 deletions(-)
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
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-766%2Fjeffhostetler%2Fsimple-ipc-v7
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-766/jeffhostetler/simple-ipc-v7
Pull-Request: https://github.com/gitgitgadget/git/pull/766

Range-diff vs v6:

  1:  fe35dc3d292d =  1:  fe35dc3d292d pkt-line: eliminate the need for static buffer in packet_write_gently()
  2:  de11b3036148 =  2:  de11b3036148 pkt-line: do not issue flush packets in write_packetized_*()
  3:  3718da39da30 =  3:  3718da39da30 pkt-line: add PACKET_READ_GENTLE_ON_READ_ERROR option
  4:  b43df7ad0b7a =  4:  b43df7ad0b7a pkt-line: add options argument to read_packetized_to_strbuf()
  5:  f829feb2aa93 =  5:  f829feb2aa93 simple-ipc: design documentation for new IPC mechanism
  6:  58c3fb7cd776 =  6:  58c3fb7cd776 simple-ipc: add win32 implementation
  7:  4e8c352fb366 =  7:  4e8c352fb366 unix-socket: eliminate static unix_stream_socket() helper function
  8:  3b71f52d8628 =  8:  3b71f52d8628 unix-socket: add backlog size option to unix_stream_listen()
  9:  5972a198361c =  9:  5972a198361c unix-socket: disallow chdir() when creating unix domain sockets
 10:  02c885fd623d = 10:  02c885fd623d unix-stream-server: create unix domain socket under lock
 11:  4c2199231d05 ! 11:  eee5f4796d37 simple-ipc: add Unix domain socket implementation
     @@ compat/simple-ipc/ipc-unix-socket.c (new)
      +	pthread_cond_init(&server_data->work_available_cond, NULL);
      +
      +	server_data->queue_size = nr_threads * FIFO_SCALE;
     -+	server_data->fifo_fds = xcalloc(server_data->queue_size,
     -+					sizeof(*server_data->fifo_fds));
     ++	CALLOC_ARRAY(server_data->fifo_fds, server_data->queue_size);
      +
      +	server_data->accept_thread =
      +		xcalloc(1, sizeof(*server_data->accept_thread));
 12:  132b6f3271be = 12:  8b5dcca68440 t0052: add simple-ipc tests and t/helper/test-simple-ipc tool

-- 
gitgitgadget
