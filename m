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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA311C433E6
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 10:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93977619A4
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 10:31:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbhCVKah (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Mar 2021 06:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhCVK35 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Mar 2021 06:29:57 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F08CC061574
        for <git@vger.kernel.org>; Mon, 22 Mar 2021 03:29:56 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id p19so9169410wmq.1
        for <git@vger.kernel.org>; Mon, 22 Mar 2021 03:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/Lelo8/06j9WQIIf7GDhH+9BwIWlnOU4qaeio0Ut5GI=;
        b=nXl2kLf9N8g2TMp59d8Y3j8aCicaRKU4ctkR++SZfD4BXzvPshEoyYKBr11IlyEr4E
         aPEBcxS3hngskcg8OXUV8dOU6wDp9T0JvA918FNzniyMSmW/h/OhJK7ynLxkz3hiFgHT
         l5ODoP/UALhIxVQFExyNBTSyHVsATJkPBzBRSc4rCe3w1+CXgSIRyFwxF7zVCl/7c1Uh
         g+3D1gZzvvM3SRZigGDLco3S+/RYxq9MCIccbPe+aA6Qow2XrIcpq7ujluNnRDGmvHFW
         w/gv+ymutKGNyx7mopqyUVlMDBfo2qs5a5RO/aphT50pSmdfljE6jO9BanqYMikLqNto
         Rfig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/Lelo8/06j9WQIIf7GDhH+9BwIWlnOU4qaeio0Ut5GI=;
        b=BOZ1mizQmGmAXUWyCsteJwPSJLjtOaap5Ay/8zYNl8sCPIsq8Hut2PuB5eFw30vu4u
         ecHPgOAK2lifuHezasFjwPPg+Au/3qn5eQcT+X/04RH2SuZIgU2iatYK65nSgVqwKFW9
         xeE9uSar0++Fu9zHY5uDmJ0b0KA/4cg/av0JD2J2g+BOd5PgRhu01HRb7mKsxmB7oT6I
         US4xyaK3agXx5+7Jp83myRYwtbSuhxPl0zzKkCqVdd6WQT3pyEXqCaETEcx+ny4KDcOU
         QcSaDSZViCIHmcmb79BUek5j4rhUHIiQxGgro8sUVDw+9+4oOzmDObqvXzvqXn99vgxa
         E+KQ==
X-Gm-Message-State: AOAM531YVA9vW8ROuYB9s2tGdY/i3BPq6qwCAYhVI61pVDeDkE9JYf/s
        CTT0seMQ38QFC0M7qNv9kDJyHrVEL5o=
X-Google-Smtp-Source: ABdhPJwN82dypA6majrMArGpGRWUgI7tDHP/+CkZ3aXaLhJeNGh/X+J8fwS938kNDPwpSUPgQsoRXQ==
X-Received: by 2002:a05:600c:252:: with SMTP id 18mr15002616wmj.67.1616408994862;
        Mon, 22 Mar 2021 03:29:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u2sm19819326wrp.12.2021.03.22.03.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 03:29:54 -0700 (PDT)
Message-Id: <f829feb2aa93937b2e2fc493e8ea647051960658.1616408989.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.766.v7.git.1616408989.gitgitgadget@gmail.com>
References: <pull.766.v6.git.1615842509.gitgitgadget@gmail.com>
        <pull.766.v7.git.1616408989.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 22 Mar 2021 10:29:41 +0000
Subject: [PATCH v7 05/12] simple-ipc: design documentation for new IPC
 mechanism
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
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Brief design documentation for new IPC mechanism allowing
foreground Git client to talk with an existing daemon process
at a known location using a named pipe or unix domain socket.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 Documentation/technical/api-simple-ipc.txt | 105 +++++++++++++++++++++
 1 file changed, 105 insertions(+)
 create mode 100644 Documentation/technical/api-simple-ipc.txt

diff --git a/Documentation/technical/api-simple-ipc.txt b/Documentation/technical/api-simple-ipc.txt
new file mode 100644
index 000000000000..d79ad323e675
--- /dev/null
+++ b/Documentation/technical/api-simple-ipc.txt
@@ -0,0 +1,105 @@
+Simple-IPC API
+==============
+
+The Simple-IPC API is a collection of `ipc_` prefixed library routines
+and a basic communication protocol that allow an IPC-client process to
+send an application-specific IPC-request message to an IPC-server
+process and receive an application-specific IPC-response message.
+
+Communication occurs over a named pipe on Windows and a Unix domain
+socket on other platforms.  IPC-clients and IPC-servers rendezvous at
+a previously agreed-to application-specific pathname (which is outside
+the scope of this design) that is local to the computer system.
+
+The IPC-server routines within the server application process create a
+thread pool to listen for connections and receive request messages
+from multiple concurrent IPC-clients.  When received, these messages
+are dispatched up to the server application callbacks for handling.
+IPC-server routines then incrementally relay responses back to the
+IPC-client.
+
+The IPC-client routines within a client application process connect
+to the IPC-server and send a request message and wait for a response.
+When received, the response is returned back the caller.
+
+For example, the `fsmonitor--daemon` feature will be built as a server
+application on top of the IPC-server library routines.  It will have
+threads watching for file system events and a thread pool waiting for
+client connections.  Clients, such as `git status` will request a list
+of file system events since a point in time and the server will
+respond with a list of changed files and directories.  The formats of
+the request and response are application-specific; the IPC-client and
+IPC-server routines treat them as opaque byte streams.
+
+
+Comparison with sub-process model
+---------------------------------
+
+The Simple-IPC mechanism differs from the existing `sub-process.c`
+model (Documentation/technical/long-running-process-protocol.txt) and
+used by applications like Git-LFS.  In the LFS-style sub-process model
+the helper is started by the foreground process, communication happens
+via a pair of file descriptors bound to the stdin/stdout of the
+sub-process, the sub-process only serves the current foreground
+process, and the sub-process exits when the foreground process
+terminates.
+
+In the Simple-IPC model the server is a very long-running service.  It
+can service many clients at the same time and has a private socket or
+named pipe connection to each active client.  It might be started
+(on-demand) by the current client process or it might have been
+started by a previous client or by the OS at boot time.  The server
+process is not associated with a terminal and it persists after
+clients terminate.  Clients do not have access to the stdin/stdout of
+the server process and therefore must communicate over sockets or
+named pipes.
+
+
+Server startup and shutdown
+---------------------------
+
+How an application server based upon IPC-server is started is also
+outside the scope of the Simple-IPC design and is a property of the
+application using it.  For example, the server might be started or
+restarted during routine maintenance operations, or it might be
+started as a system service during the system boot-up sequence, or it
+might be started on-demand by a foreground Git command when needed.
+
+Similarly, server shutdown is a property of the application using
+the simple-ipc routines.  For example, the server might decide to
+shutdown when idle or only upon explicit request.
+
+
+Simple-IPC protocol
+-------------------
+
+The Simple-IPC protocol consists of a single request message from the
+client and an optional response message from the server.  Both the
+client and server messages are unlimited in length and are terminated
+with a flush packet.
+
+The pkt-line routines (Documentation/technical/protocol-common.txt)
+are used to simplify buffer management during message generation,
+transmission, and reception.  A flush packet is used to mark the end
+of the message.  This allows the sender to incrementally generate and
+transmit the message.  It allows the receiver to incrementally receive
+the message in chunks and to know when they have received the entire
+message.
+
+The actual byte format of the client request and server response
+messages are application specific.  The IPC layer transmits and
+receives them as opaque byte buffers without any concern for the
+content within.  It is the job of the calling application layer to
+understand the contents of the request and response messages.
+
+
+Summary
+-------
+
+Conceptually, the Simple-IPC protocol is similar to an HTTP REST
+request.  Clients connect, make an application-specific and
+stateless request, receive an application-specific
+response, and disconnect.  It is a one round trip facility for
+querying the server.  The Simple-IPC routines hide the socket,
+named pipe, and thread pool details and allow the application
+layer to focus on the application at hand.
-- 
gitgitgadget

