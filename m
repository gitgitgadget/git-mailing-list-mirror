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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FE41C433E0
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 21:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED44F64E5F
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 21:50:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbhBQVu0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 16:50:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbhBQVuN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 16:50:13 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C26C06178A
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 13:48:55 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id v7so18929951wrr.12
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 13:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=yOVx8B7rIEXDZ/mpDexA8Qe2BDO2imKZikCVpUgG7e8=;
        b=ovYnAvYGYuZ+thKYKxuWAyJWnDjprGAG1oypYAddmAktt+SEXiIy8h4qB9mpK3rnjn
         BcPAaWrx5fKx6mGxc7HkGCfH5uqfdJnzH2nsqhcHz8+wRyM1gx8T7fqtqfK9kb1cPSJe
         sdyUwyPDh7QUCEZ6Gtd8U84npxsQmzSNesJGwIZeLvSYoHUeQMGsQ9+MZVik8/oBDyuO
         PtL13DQ2sgL8ZRusiNn/U4cO3U0P4wWJl9Oi7mklSufLPxR9xOVSPtfcEFzfsYFBcD63
         mF71ysxpwWSic63OEDMcOH84RwNzsi3TyB1/NzFmvPfPLXKiH/nk3lxeH55DD/RwfuVZ
         zpcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=yOVx8B7rIEXDZ/mpDexA8Qe2BDO2imKZikCVpUgG7e8=;
        b=W4cZMUIYgo0TD49o/h/eNY162BfWVDDggPxXNiMtms3BwUP4gicibREZNfF1jV21j2
         k0gxJ1cEmU7sOH6NpNlcxNRKUVCNKT9fFR9X4YRbGiStjQ9by7bDyAF43ZGsCDf9oyjH
         D+XFUrdPI5Eg6EqSNa9HlV3vhBcpz+VC1qqB1jgPjGXg5V+dx/TgtXj0gxeZK1Gx4sRG
         9knkwP7V2bHUIhNtWFM4VhlfgioAOvQtNix90nX5zAcSQV01qV4k3s7UrO2QUB7r9wxN
         ExeUFHjsiOvrStxGV0yFAWODxcxNjXzX1B9+gqH2LIC8owCf5K/8sl3QOvrrYO9uo4EZ
         Ei6A==
X-Gm-Message-State: AOAM533Di7MgBAbxFR0trMHQBRUOAC6VymWlWvgTUw1ApE/aw1eTvSUg
        rNHRkhuxeCWsYSqRAXs6OhVeZFY8y4g=
X-Google-Smtp-Source: ABdhPJyglrAwzEPpdh3XkbwarbHJ8dWwbEFlkpFZgaA07cjoZVA6wBaK2qOMsVzaUbMwXiTneyu0+g==
X-Received: by 2002:a5d:6148:: with SMTP id y8mr1154224wrt.238.1613598533780;
        Wed, 17 Feb 2021 13:48:53 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e16sm7468267wrt.36.2021.02.17.13.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 13:48:53 -0800 (PST)
Message-Id: <22eec60761a88107b2e337ce13eed1020352aa73.1613598529.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.766.v4.git.1613598529.gitgitgadget@gmail.com>
References: <pull.766.v3.git.1613174954.gitgitgadget@gmail.com>
        <pull.766.v4.git.1613598529.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 17 Feb 2021 21:48:41 +0000
Subject: [PATCH v4 05/12] simple-ipc: design documentation for new IPC
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

