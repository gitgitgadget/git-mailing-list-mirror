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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33461C433E9
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 19:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB8E364ECA
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 19:48:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbhBATsS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 14:48:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232322AbhBATqr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 14:46:47 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679D0C06178B
        for <git@vger.kernel.org>; Mon,  1 Feb 2021 11:45:57 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id a1so17964922wrq.6
        for <git@vger.kernel.org>; Mon, 01 Feb 2021 11:45:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qTI5/L9pM7HLuNqoOeZhRgOhPiAn0tFJz/94G2ot7cM=;
        b=s50sc0IBjQtHtOnfmZr8MeiNdfKlkzvZhfO6XKnPq1h9whUYE+cXAKgDmv4Im/Bcsh
         pT/d14Kxg8JMQalUzX6mLIqt4ztLmGre/gp6GInD8wnpzq8CQTEhM8qZs+qESxPijkjp
         FpmAZCCvQi1rQZKxoF7qMCjOe/d8kkAG88i64LwX/dYxcFqM0NcSYdeA5w5RB0bv2ndA
         MsF988uDFQiRpmDAUi84QO/0lSX5p7KFPZAvhR4Zhq7djT6t1ZPI+Eo/I3crgPhRv4k2
         X68arc69AXa9mUrR4a6F729t5fbbobY3jr5NX+vYFOsQ6GpZSNAqKvR6JM5gOpgtG7EL
         84kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=qTI5/L9pM7HLuNqoOeZhRgOhPiAn0tFJz/94G2ot7cM=;
        b=fJAHZ8UWdc9oWYSi2tuwWsqugazIGt6L/z7397zICOEjG01w01hgYjd+qqWXfHoYfk
         +kZANVpy+dNYCROaYavb1atjQmwM0gdXW3eetTXDhmWBoYGXaLqnw2Tj8/IiqdBStO1P
         Q4wnFeKVrdGGf//sH748VQCLf6hq37bCNOxT1SZL00AV/Xs4qWd8TBqTRJpnuW2n5ZiR
         tYNkKLDiFIotJU9lpuMqzK9fOQGxEHCVXajNBGuGyw7pG64TKj4g8KF+gbk4ywxJqBoD
         H/8Lod5sdl9+EKQjboOq0m0aaQOLM/tUF5xBc8mQT084RS/ErK2jmzYz/AqCHB+eYJvM
         dDKw==
X-Gm-Message-State: AOAM5332dAuSM1ZSv+4y8gNitoAA1/N+wl9z8U7EbXFTJBXjcf8UzvJI
        GkKT5if74i4qLp/XjN9iOl+FOlTcRwQ=
X-Google-Smtp-Source: ABdhPJxOxJ1P6MzzEI+x23NzT8aMsOGRluHSaTYxAX0s+RBHO0GZ/L9bJiRtbH7YSHCoiJEktObTmw==
X-Received: by 2002:adf:ecc1:: with SMTP id s1mr20802330wro.146.1612208756030;
        Mon, 01 Feb 2021 11:45:56 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j13sm297933wmi.24.2021.02.01.11.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 11:45:55 -0800 (PST)
Message-Id: <a7275b4bdc2a3cc285bd0e3bb62f3e1d6566c506.1612208747.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.766.v2.git.1612208747.gitgitgadget@gmail.com>
References: <pull.766.git.1610465492.gitgitgadget@gmail.com>
        <pull.766.v2.git.1612208747.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 01 Feb 2021 19:45:40 +0000
Subject: [PATCH v2 07/14] simple-ipc: design documentation for new IPC
 mechanism
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Jeff King <peff@peff.net>, Chris Torek <chris.torek@gmail.com>,
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
 Documentation/technical/api-simple-ipc.txt | 34 ++++++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 Documentation/technical/api-simple-ipc.txt

diff --git a/Documentation/technical/api-simple-ipc.txt b/Documentation/technical/api-simple-ipc.txt
new file mode 100644
index 00000000000..670a5c163e3
--- /dev/null
+++ b/Documentation/technical/api-simple-ipc.txt
@@ -0,0 +1,34 @@
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
+by applications like Git-LFS.  In the simple-ipc model the server is
+assumed to be a very long-running system service.  In contrast, in the
+LFS-style sub-process model the helper is started with the foreground
+process and exits when the foreground process terminates.
+
+How the simple-ipc server is started is also outside the scope of the
+IPC mechanism.  For example, the server might be started during
+maintenance operations.
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

