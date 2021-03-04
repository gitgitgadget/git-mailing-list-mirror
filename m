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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE06C433E6
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 20:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 789FA64F45
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 20:19:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233421AbhCDUTC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Mar 2021 15:19:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235787AbhCDUSt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Mar 2021 15:18:49 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08931C0613D7
        for <git@vger.kernel.org>; Thu,  4 Mar 2021 12:17:35 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id w11so29028573wrr.10
        for <git@vger.kernel.org>; Thu, 04 Mar 2021 12:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Pg0hRzWV9wc4tAA1Swd3edXGA6m8g2h+5yi5YY2DU58=;
        b=Cp+7wx+CrPvNxqubfqLXnqL4MCVtIp39GNqxlVBzZGVqU8mGiQUkia2+H70PChfB3H
         Cqb9+ClkZK7Ops0PJcm1cnY8ZAnmzQ5UpfedjKfa7mFn2Kkqp2imUZAOw3kOIGQxD+BA
         T454JU/tpMZXFrFroTuqOu31P4m4dOM236yA0HKh8vBbqoycawQiYtEf0x/EBVCAV4/k
         un5on8JpRCtb77JUpVPJegYQikRlq2v1P3KCe1iHRDK1dEG+mxv2DosCv84P111I4fOV
         TTKvIzcBRNPQmLjm9oLNkIewupEEr94rUp9tSFttYcrXPDlJ0Zk4v3lGnbHBHafRNUOt
         7KEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Pg0hRzWV9wc4tAA1Swd3edXGA6m8g2h+5yi5YY2DU58=;
        b=oO+yIz1fDA/HzNJpEHnTKpbCdYSqgeSfbbh5d0om1z0eklcE4xkuVHcU8FiymJeYSA
         X5HiRj9r05yb8be+cmuIYDnOepJh5ec/+bVnmdXvNz6fqE45OVyS7DzmbTL4trXPnMNO
         vDx82fghVp0YJ57TVEuySh6LVfSeALg6R0UDbJ2iOwQKO17nWLcqrGgbe8bxJc43xjf/
         W3/0xqZ/nqokItrJ1cb8Gb4hsra/F6bFp9Y8FOXWbKf6F8gJIGQBuk0GX9arQ2jt18xF
         jsmwnmJ0AFVEgt3SKRmQ3wOCHLYi9oM8AqqVvP9FVXfQQObdvs1rx4kw8fM45DA1Odmy
         HLOg==
X-Gm-Message-State: AOAM532m4KP8/JHDOAFvZ5btIplygHUp++lf8e++sO8UmAGR/BtcsfKl
        ylkzj3CoZrkKxWWK1MIzRVlDTK+378w=
X-Google-Smtp-Source: ABdhPJzmAga/lxotCrANbjs7H0ooV3rfW4kxeR+HPJ7GnEdTjE7t9VjrasOOwp8SyZaz4NeNZ2H2FA==
X-Received: by 2002:a5d:684d:: with SMTP id o13mr5917479wrw.235.1614889053807;
        Thu, 04 Mar 2021 12:17:33 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 12sm768213wmw.43.2021.03.04.12.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 12:17:33 -0800 (PST)
Message-Id: <eadde22c735e45e114776bc6e2e3affecb14cdcb.1614889047.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.893.git.1614889047.gitgitgadget@gmail.com>
References: <pull.893.git.1614889047.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 04 Mar 2021 20:17:27 +0000
Subject: [PATCH 8/8] simple-ipc: update design documentation with more details
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

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 Documentation/technical/api-simple-ipc.txt | 131 ++++++++++++++++-----
 1 file changed, 101 insertions(+), 30 deletions(-)

diff --git a/Documentation/technical/api-simple-ipc.txt b/Documentation/technical/api-simple-ipc.txt
index 670a5c163e39..d79ad323e675 100644
--- a/Documentation/technical/api-simple-ipc.txt
+++ b/Documentation/technical/api-simple-ipc.txt
@@ -1,34 +1,105 @@
-simple-ipc API
+Simple-IPC API
 ==============
 
-The simple-ipc API is used to send an IPC message and response between
-a (presumably) foreground Git client process to a background server or
-daemon process.  The server process must already be running.  Multiple
-client processes can simultaneously communicate with the server
-process.
+The Simple-IPC API is a collection of `ipc_` prefixed library routines
+and a basic communication protocol that allow an IPC-client process to
+send an application-specific IPC-request message to an IPC-server
+process and receive an application-specific IPC-response message.
 
 Communication occurs over a named pipe on Windows and a Unix domain
-socket on other platforms.  Clients and the server rendezvous at a
-previously agreed-to application-specific pathname (which is outside
-the scope of this design).
-
-This IPC mechanism differs from the existing `sub-process.c` model
-(Documentation/technical/long-running-process-protocol.txt) and used
-by applications like Git-LFS.  In the simple-ipc model the server is
-assumed to be a very long-running system service.  In contrast, in the
-LFS-style sub-process model the helper is started with the foreground
-process and exits when the foreground process terminates.
-
-How the simple-ipc server is started is also outside the scope of the
-IPC mechanism.  For example, the server might be started during
-maintenance operations.
-
-The IPC protocol consists of a single request message from the client and
-an optional request message from the server.  For simplicity, pkt-line
-routines are used to hide chunking and buffering concerns.  Each side
-terminates their message with a flush packet.
-(Documentation/technical/protocol-common.txt)
-
-The actual format of the client and server messages is application
-specific.  The IPC layer transmits and receives an opaque buffer without
-any concern for the content within.
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
