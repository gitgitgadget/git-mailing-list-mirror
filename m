Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3217C4332D
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 20:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EDED64F73
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 20:19:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238885AbhCDUSb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Mar 2021 15:18:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238881AbhCDUSL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Mar 2021 15:18:11 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45314C061761
        for <git@vger.kernel.org>; Thu,  4 Mar 2021 12:17:31 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id 7so29089745wrz.0
        for <git@vger.kernel.org>; Thu, 04 Mar 2021 12:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5fFrqSRpxgPapoWDUWDp7uN3boILXCdkNiW68K3a9Gc=;
        b=oYY8FJASFegl+RmS7INucolr+d+ud9lKBic/CCy5BiyroabGxdZkvzYpdMtQv4kbNE
         u1QaQpqcnGm+OPGEuIXeRwd4MfOD/RdQsD8pqFpueuryS1YtP5XvViCE2PjppHHagMEw
         K+S5mYwFxdl6QOzQD84l0AjV2mEOUW7eFKTp/H48S8P9kAbAuk+9NxEuf+/xaOSchRrN
         jK+VivNi/WEjXWgaoYJ21GJZu1EIjmmUje/ZqOlZ5zTQVUFzarjCNx6uC0yqJJX37h1Y
         XKgq4r73iiYOd/NnT5gu1XOsjhaqj8/VN3ub12Y3M6FObyZdGG4QskRvq5FDBgxdPgnD
         yjmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5fFrqSRpxgPapoWDUWDp7uN3boILXCdkNiW68K3a9Gc=;
        b=A8VDEaMAIczCFREz1tRlGz2dzuKZmur6wNzFLAqwOXm/KhQXkwDebKj7RjYcghTNbS
         JG5HzwyooyHZUPuyFPF4hWKk8NVwNBo7FX7i9oByUPiiMLd3ujVmSzNSNXtJI+qMmZE5
         oBNdJFWSCsl6w4qByBep+h2/W8vxMG7yw1iy52lau/GlrCz5KcB38O/GO3P3SMXmYUwr
         q2c/YIppUsJSYhnlDXCcUk6GbGVwYj3Fx0zxARuXM7++iMTLq9gHvMe27TxLV78gpKLm
         WDqRiusf63bPSXnLFHoPJeuJIlIORfUrpa1M5ROK6qIvWzIt2Q1nxxjevha4EryDWU4a
         sYfQ==
X-Gm-Message-State: AOAM5332ByLMIlyDkYyUAKH0+z5YsxOuJV+PkfRS5XwCIVJiPVVxIkhB
        BxHNnM0gE46jJBdZ2Wck3uqWaCU+pfc=
X-Google-Smtp-Source: ABdhPJyL2wetzvfMjMnBjp3lqrPl6qefvz7BiDgSi4IvG59E3qB9zpZytTYxSE4+K3HIE7SyG3vRDA==
X-Received: by 2002:adf:fbce:: with SMTP id d14mr5635707wrs.44.1614889050020;
        Thu, 04 Mar 2021 12:17:30 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c9sm810850wmb.33.2021.03.04.12.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 12:17:29 -0800 (PST)
Message-Id: <6ef867bf37d366071d5f0f101e7430d859f529b5.1614889047.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.893.git.1614889047.gitgitgadget@gmail.com>
References: <pull.893.git.1614889047.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 04 Mar 2021 20:17:21 +0000
Subject: [PATCH 2/8] unix-socket: simplify initialization of
 unix_stream_listen_opts
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

Change the public initialization of `struct unix_stream_listen_opts`
to be all zeroes.  Hide the default values for the timeout and backlog
values inside `unix-socket.c`.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 unix-socket.c | 11 +++++++++--
 unix-socket.h |  7 ++-----
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/unix-socket.c b/unix-socket.c
index 647bbde37f97..c9ea1de43bd2 100644
--- a/unix-socket.c
+++ b/unix-socket.c
@@ -2,6 +2,9 @@
 #include "lockfile.h"
 #include "unix-socket.h"
 
+#define DEFAULT_UNIX_STREAM_LISTEN_TIMEOUT (100)
+#define DEFAULT_UNIX_STREAM_LISTEN_BACKLOG (5)
+
 static int chdir_len(const char *orig, int len)
 {
 	char *path = xmemdupz(orig, len);
@@ -165,14 +168,18 @@ struct unix_stream_server_socket *unix_stream_server__listen_with_lock(
 	const struct unix_stream_listen_opts *opts)
 {
 	struct lock_file lock = LOCK_INIT;
+	long timeout;
 	int fd_socket;
 	struct unix_stream_server_socket *server_socket;
 
+	timeout = opts->timeout_ms;
+	if (opts->timeout_ms <= 0)
+		timeout = DEFAULT_UNIX_STREAM_LISTEN_TIMEOUT;
+
 	/*
 	 * Create a lock at "<path>.lock" if we can.
 	 */
-	if (hold_lock_file_for_update_timeout(&lock, path, 0,
-					      opts->timeout_ms) < 0) {
+	if (hold_lock_file_for_update_timeout(&lock, path, 0, timeout) < 0) {
 		error_errno(_("could not lock listener socket '%s'"), path);
 		return NULL;
 	}
diff --git a/unix-socket.h b/unix-socket.h
index 8faf5b692f90..bec925ee0213 100644
--- a/unix-socket.h
+++ b/unix-socket.h
@@ -7,13 +7,10 @@ struct unix_stream_listen_opts {
 	unsigned int disallow_chdir:1;
 };
 
-#define DEFAULT_UNIX_STREAM_LISTEN_TIMEOUT (100)
-#define DEFAULT_UNIX_STREAM_LISTEN_BACKLOG (5)
-
 #define UNIX_STREAM_LISTEN_OPTS_INIT \
 { \
-	.timeout_ms = DEFAULT_UNIX_STREAM_LISTEN_TIMEOUT, \
-	.listen_backlog_size = DEFAULT_UNIX_STREAM_LISTEN_BACKLOG, \
+	.timeout_ms = 0, \
+	.listen_backlog_size = 0, \
 	.disallow_chdir = 0, \
 }
 
-- 
gitgitgadget

