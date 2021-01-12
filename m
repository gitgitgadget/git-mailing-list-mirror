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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A16DC433DB
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 15:32:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D14EF23132
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 15:32:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387812AbhALPcQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 10:32:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729960AbhALPcQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 10:32:16 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8041C061786
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 07:31:35 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id y17so2898082wrr.10
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 07:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=c4OB9RdYYuq2r8DhtN3CjizE/MAJTRNEoyjRaKc1u0k=;
        b=S30OqictR117pgF2crBl0uOFeI4A9C3dk8X7UKPrXS6F8WuIWI5f2qH9Z09ZCSg8yn
         f2ZJl19BFRArWqpU2LEyqzx5p9uPpNkNjlEQJOYpQgFpH+yijc/2lyDRj3NpDYvLjZs3
         bCiaeB07OC97A8vCSzUCEIpzZczPugy70r+0RzYeQe03SDQrcRk73k6rBmycwrHiw3ZH
         G4wwx+ZAtjbR7ohv8nyxJERcCsgec1dR/G43G48/7dX4i0BTEbxQqO/rw79ppDzx/dsN
         3x/lsahHn4f/qUAlV9Dy9GaCmlo1fLv0oEi6Q6Y52hhRe+4vOOWo+O0erIWP8deWAb5D
         UAlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=c4OB9RdYYuq2r8DhtN3CjizE/MAJTRNEoyjRaKc1u0k=;
        b=ijaoKGGViPoJ0jvPNv26w42WDj4BzZnA4Y46JXkQaCjP15OjJP5zSiXybUrHh/kUV+
         uXxjv3Mg3ohIPD6ZGCbY1KsAiKr3+6JT5L+l0uVHe3URgijCe8kPj9y385l3lCsJCjqt
         7uWe3U2u3KstJQYYMSbfCDtcXYnjz6omWkfLs3bjwKzurQLXDMRhkx7gkKdA+N3t3w9P
         nEkjGWdmj6YmdKdFfr+Ud2KRBJwCvWEk+wI1XtMm/of7yVJcB/ZO9Psu9aE4Ewlo9tUX
         pxR24JNGenm/Aq9jeY+XBRd4MNAxITjrgFl+zbir3yTTFWM1Xzgv5C6UuZrwqxco3EoD
         KJ2Q==
X-Gm-Message-State: AOAM530y1t/9E5709or2Ovac8laTfY3Gi6uhOM3TJrd6nDuvPiZ6bU5a
        dTjRJPXZZP1RMaVsN+sL3jo9NLNgGTM=
X-Google-Smtp-Source: ABdhPJwqs65M2I96bNEanneBfh/6FRGgvN1y9ZvSQ0AOhAF5oCUbLPsQI65Nd1ODd8YOiMWkrIhykA==
X-Received: by 2002:adf:f0d0:: with SMTP id x16mr5066687wro.162.1610465494450;
        Tue, 12 Jan 2021 07:31:34 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f14sm4620287wme.14.2021.01.12.07.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 07:31:33 -0800 (PST)
Message-Id: <pull.766.git.1610465492.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 12 Jan 2021 15:31:22 +0000
Subject: [PATCH 00/10] [RFC] Simple IPC Mechanism
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series introduces a multi-threaded IPC mechanism called "Simple IPC".
This is a library-layer feature to make it easy to create very long running
daemon/service applications and for unrelated Git commands to communicate
with them. Communication uses pkt-line messaging over a Windows named pipe
or Unix domain socket.

On the server side, Simple IPC implements a (platform-specific) connection
listener and worker thread-pool to accept and handle a series of client
connections. The server functionality is completely hidden behind the
ipc_server_run() and ipc_server_run_async() APIs. The daemon/service
application only needs to define an application-specific callback to handle
client requests.

Note that Simple IPC is completely unrelated to the long running process
feature (described in sub-process.h) where the lifetime of a "sub-process"
child is bound to that of the invoking parent process and communication
occurs over the child's stdin/stdout.

Simple IPC will serve as a basis for a future builtin FSMonitor daemon
feature.

Jeff Hostetler (7):
  pkt-line: use stack rather than static buffer in packet_write_gently()
  simple-ipc: design documentation for new IPC mechanism
  simple-ipc: add win32 implementation
  unix-socket: create gentle version of unix_stream_listen()
  unix-socket: add no-chdir option to unix_stream_listen_gently()
  simple-ipc: add t/helper/test-simple-ipc and t0052
  simple-ipc: add Unix domain socket implementation

Johannes Schindelin (3):
  pkt-line: (optionally) libify the packet readers
  pkt-line: optionally skip the flush packet in
    write_packetized_from_buf()
  pkt-line: accept additional options in read_packetized_to_strbuf()

 Documentation/technical/api-simple-ipc.txt |   31 +
 Makefile                                   |    8 +
 compat/simple-ipc/ipc-shared.c             |   28 +
 compat/simple-ipc/ipc-unix-socket.c        | 1093 ++++++++++++++++++++
 compat/simple-ipc/ipc-win32.c              |  723 +++++++++++++
 config.mak.uname                           |    2 +
 contrib/buildsystems/CMakeLists.txt        |    6 +
 convert.c                                  |    4 +-
 pkt-line.c                                 |   30 +-
 pkt-line.h                                 |   13 +-
 simple-ipc.h                               |  221 ++++
 t/helper/test-simple-ipc.c                 |  485 +++++++++
 t/helper/test-tool.c                       |    1 +
 t/helper/test-tool.h                       |    1 +
 t/t0052-simple-ipc.sh                      |  129 +++
 unix-socket.c                              |   58 +-
 unix-socket.h                              |    9 +
 17 files changed, 2828 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/technical/api-simple-ipc.txt
 create mode 100644 compat/simple-ipc/ipc-shared.c
 create mode 100644 compat/simple-ipc/ipc-unix-socket.c
 create mode 100644 compat/simple-ipc/ipc-win32.c
 create mode 100644 simple-ipc.h
 create mode 100644 t/helper/test-simple-ipc.c
 create mode 100755 t/t0052-simple-ipc.sh


base-commit: 71ca53e8125e36efbda17293c50027d31681a41f
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-766%2Fjeffhostetler%2Fsimple-ipc-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-766/jeffhostetler/simple-ipc-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/766
-- 
gitgitgadget
