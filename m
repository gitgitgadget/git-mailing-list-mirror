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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A60BC43381
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 15:32:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63F3223134
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 15:32:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391408AbhALPcV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 10:32:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391374AbhALPcU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 10:32:20 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20609C0617A2
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 07:31:40 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id e25so2507558wme.0
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 07:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=HHLHxrxflt0JGdqizd2Gl5+BYrxhvTM8hH7dP/QkbBk=;
        b=I7/h/rJqSaUamQX+c0SHq/fqu5lZrk/9F1eTn1dI04+RpI8iaQK1ZEjpDAw5pvVC9h
         AKocFCgwOf4iSTvUb9Eb5YTULrd+GyUKbXxeTMJu93zhg0SmDeMBT0RMe2tC2rjWmhwP
         FxeEIZxGOwjMG+sJmaBZGIBgazG4lZS5hbKLpQvsOMt1fEeP5PCUiR8f/z+pnSQQKw8f
         JA+Vz5+sGCi4SMgk5f9MOgby9zQNvHHqYx54zs1m8prTX0+asBiA3Q3vP8G/7f4txi+d
         0N6QsNAM2afIVcb4DFe5SCWBbuzStefCGmdGUJ0xYIKLhkkTqp4VCBTwYZeRPzP1nIpY
         TNPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=HHLHxrxflt0JGdqizd2Gl5+BYrxhvTM8hH7dP/QkbBk=;
        b=mbZMOeAq3mPbEB0FNeMCmq0Qt/Oor20aFF1RjUKX1yhBJF5r5JERvaIIoYp/9snTmX
         o1S5LOKmuobegK3TRwoGynA6gxN/GWQZr0beekJvU4DtXlSFjZMQqTNxMznR0JR1or10
         6YAzgxZ1QGSbD14dv8PjVD1lJYpxIjJC39BHzxsITfY2G2BXgWASfbvPPD5qVGxYZmT1
         OnEbFFoelkpQKac3RafLAGh+Jv+SwHqrvKk32kReTy5ElImGVF2V2GP3iGz+rk1vLfH0
         O8dxIFntoPKxPoMsEKpGnNUNXqQ3JlNNe7oCTBGHlN0WBh2+he3Z+N2XoaD6gFkX1y7v
         poMQ==
X-Gm-Message-State: AOAM530sZmI1oTDMpFUiUv9CGFuCh/hDA2JLWbDxt0QeSgbWSkZY7804
        jCP54z+sytz06GlRog8MUiWSfmqe+c0=
X-Google-Smtp-Source: ABdhPJxyiykoBOx/ChU2zhkWC9mAK3lLPBWZcmqyEq1jIts9e8lvygKY9lJDRqTX5ftQpWVtRevqcw==
X-Received: by 2002:a1c:e042:: with SMTP id x63mr4193084wmg.68.1610465498745;
        Tue, 12 Jan 2021 07:31:38 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h29sm6441264wrc.68.2021.01.12.07.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 07:31:38 -0800 (PST)
Message-Id: <7064c5e9ffa0e3e666ea6d146b0839680952757d.1610465493.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.766.git.1610465492.gitgitgadget@gmail.com>
References: <pull.766.git.1610465492.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 12 Jan 2021 15:31:27 +0000
Subject: [PATCH 05/10] simple-ipc: design documentation for new IPC mechanism
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

Brief design documentation for new IPC mechanism allowing
foreground Git client to talk with an existing daemon process
at a known location using a named pipe or unix domain socket.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 Documentation/technical/api-simple-ipc.txt | 31 ++++++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 Documentation/technical/api-simple-ipc.txt

diff --git a/Documentation/technical/api-simple-ipc.txt b/Documentation/technical/api-simple-ipc.txt
new file mode 100644
index 00000000000..920994a69d3
--- /dev/null
+++ b/Documentation/technical/api-simple-ipc.txt
@@ -0,0 +1,31 @@
+simple-ipc API
+==============
+
+The simple-ipc API is used to send an IPC message and response between
+a (presumably) foreground Git client process to a background server or
+daemon process.  The server process must already be running.  Multiple
+client processes can simultaneously communicate with the server
+process.
+
+Communication occurs over a named pipe on Windows and a Unix domain
+socket on other platforms.  Clients and the server rendezvous at a
+previously agreed-to application-specific pathname (which is outside
+the scope of this design).
+
+This IPC mechanism differs from the existing `sub-process.c` model
+(Documentation/technical/long-running-process-protocol.txt) and used
+by applications like Git-LFS because the server is assumed to be very
+long running system service.  In contrast, a "sub-process model process"
+is started with the foreground process and exits when the foreground
+process terminates.  How the server is started is also outside the
+scope of the IPC mechanism.
+
+The IPC protocol consists of a single request message from the client and
+an optional request message from the server.  For simplicity, pkt-line
+routines are used to hide chunking and buffering concerns.  Each side
+terminates their message with a flush packet.
+(Documentation/technical/protocol-common.txt)
+
+The actual format of the client and server messages is application
+specific.  The IPC layer transmits and receives an opaque buffer without
+any concern for the content within.
-- 
gitgitgadget

