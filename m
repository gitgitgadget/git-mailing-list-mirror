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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F701C433E0
	for <git@archiver.kernel.org>; Sat, 13 Feb 2021 00:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CC3964E92
	for <git@archiver.kernel.org>; Sat, 13 Feb 2021 00:10:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbhBMAKQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Feb 2021 19:10:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbhBMAKB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Feb 2021 19:10:01 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C292C06178A
        for <git@vger.kernel.org>; Fri, 12 Feb 2021 16:09:20 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id v14so1334382wro.7
        for <git@vger.kernel.org>; Fri, 12 Feb 2021 16:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=yOVx8B7rIEXDZ/mpDexA8Qe2BDO2imKZikCVpUgG7e8=;
        b=GsHr4M2Tu5Q6CZ/aOgbE1QxeWODNKzbCdOwSr6iu8QJ1wfuTSpgqF5WwJr58WZ3el5
         bXzsfj/XGtGQ7ifTa//Ms6tVwuBNeg5gN1zRFY0aUcBMuVwGtHsLAn6WdbTW9xRqKW0+
         FZ9zuae0glg+q7BelMvpD+DWhGocSJVgkyWKPfs3nnuyN0aWGcCPvqqxSP5hogNRPGTv
         WpcnZDe3aPn3KJCm2947U0kVgEXhuuvt9Jtq1Oaxi9at8UjUO0HTXNoakGPorXnOVgG7
         Ol93G2WOUeZXqwptcEAYHLjZ3urORsHhnyNC5MJaZAkgt00+2WvNpYFKEIJT2MsWGv8u
         vLyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=yOVx8B7rIEXDZ/mpDexA8Qe2BDO2imKZikCVpUgG7e8=;
        b=uCTHEFXSfgvgs7sfB6UEi16uNzGqS9W80vig646IpNDAEQcW4c64mt5U0BKw5I5VPZ
         NIRFwviz/hiOXq64QgaMLsMORG1Qm8xRCEkROlIMx0oFLmbhQybhJ7AH8WfJ4Nt7UHe/
         RWdEq/y5G1x4NqrOoFFDnuliOdIR5ab9JHsg5to7JULswEhJrXeZJU3J8YbPM+Hxj2we
         9JLRp0+gBvvTvWF+mTUoS6gZpPM4rIhxWkMK0W/LZAZvdBKMG1xb3ItHCueBo4ApQwYf
         0J8j09rgfWpSKhlxc9c9x9+J30VxOmlNAPf0jZR1sXSISeJq9+C06MV8nozGUygobW9+
         oe0g==
X-Gm-Message-State: AOAM532E5lopbg4/pKf1yz+iXRf2D+pAHlHw2/WcqMzThFCQkBaeNDqQ
        UTdsNfdZsSUVTKQIKoOm99vV9wV1vvw=
X-Google-Smtp-Source: ABdhPJwdnvEbugDGSqVMV+jUgRBMXE5CAT7j1sXGvWhFkf6kIQvnyOQ35q3iawd7X4BJdmejqIzcVQ==
X-Received: by 2002:a5d:6045:: with SMTP id j5mr6011043wrt.365.1613174959250;
        Fri, 12 Feb 2021 16:09:19 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w12sm15364879wmi.4.2021.02.12.16.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 16:09:18 -0800 (PST)
Message-Id: <22eec60761a88107b2e337ce13eed1020352aa73.1613174954.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.766.v3.git.1613174954.gitgitgadget@gmail.com>
References: <pull.766.v2.git.1612208747.gitgitgadget@gmail.com>
        <pull.766.v3.git.1613174954.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 13 Feb 2021 00:09:06 +0000
Subject: [PATCH v3 05/12] simple-ipc: design documentation for new IPC
 mechanism
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <git@jeffhostetler.com>, Jeff King <peff@peff.net>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
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
index 000000000000..670a5c163e39
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

