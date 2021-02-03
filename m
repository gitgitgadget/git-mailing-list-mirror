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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 816DAC433DB
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 15:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40BDC64F5D
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 15:40:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234185AbhBCPkY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Feb 2021 10:40:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234271AbhBCPhg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Feb 2021 10:37:36 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37666C061351
        for <git@vger.kernel.org>; Wed,  3 Feb 2021 07:35:06 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id 7so24889637wrz.0
        for <git@vger.kernel.org>; Wed, 03 Feb 2021 07:35:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ZpeyCC6Uj8x/EgLF5U4HUvxXJe+rqCgzupKMUyrx2y0=;
        b=V9i6qDXCCWN/HmXbbiIhry93nqdKsEyX+hw3EcB1VxU2hPcrerskSIB9G//5Q4Itco
         m8LiahhukSCWrTKLo4qByaLKsM5XqrHjBYXsFQeLQU4vRBGoYFUdKRfEN8yi9bAUB7sA
         Zxd1S9T58J949cBp+yxEQro/ZpGKkhOM7pD1lzjj/5B1t54204CrvhLYuJn0vdo0/O0n
         v+NolhFteMVBxUlv6xSK8AiA1V50z8+MKdG2SbyhBqt1DQE0A1NJH0xnK10e7Rc/Bft0
         YUumn7nZv7VtSnHNP8vY/zIiv8H+o1a41gNG4q82eV0JR3iTKcbdTLJZGpK4FAskg9P1
         hLzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ZpeyCC6Uj8x/EgLF5U4HUvxXJe+rqCgzupKMUyrx2y0=;
        b=hfrpYjVPmVt6o/lntNSOJpY4d/f1AMr5f4/nt2tZxPZz/+++xluvOxTT7EQFCXCfMe
         ytW8oZMhxc+ZHoCyVRDdMcqB3+OMURRZumsGPo2kb7lt0kwGEBl3AigVa+va8kINBWxi
         6sIkrZ7e8WN0qj9yxPfybJVF9FDhOrSTWh1aSItqpNpdMKbuYg7S2qyp49n8mj0AfSlz
         MP9+vLZhQfBE3Lnnj2Nu6Y5kDXaXIszbWN86qwLN9OTc8eIQZ2fmtqr/Cgy2d4FngMko
         AtS1HN+dBM3xWoKBWkSS1Vl1r7gzoynLs3pbsDFslEM7weF2dZeREt/w+IL9vMHrrlUL
         viYg==
X-Gm-Message-State: AOAM530wgEOaMG7ImNWm6wOhNc1Vy9mHfvCYIpyCQGttqeo8iZ1Jz7nJ
        YQ09qODEgbCnuctvBUpdnQbnwxRxpsg=
X-Google-Smtp-Source: ABdhPJy3oSs9xShpoaJLDsCmzGAqypQi9pxyJiA2yozdHO0duVGLxGPkgcqKY7LUMaws4kN+W56uCw==
X-Received: by 2002:a5d:4d8d:: with SMTP id b13mr4028341wru.178.1612366504799;
        Wed, 03 Feb 2021 07:35:04 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s4sm3397057wme.38.2021.02.03.07.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 07:35:04 -0800 (PST)
Message-Id: <5410d3ab61d1c9bb2a4d737bca8a81625e333da0.1612366490.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.860.v2.git.1612366490.gitgitgadget@gmail.com>
References: <pull.860.git.1612216941.gitgitgadget@gmail.com>
        <pull.860.v2.git.1612366490.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 03 Feb 2021 15:34:50 +0000
Subject: [PATCH v2 11/11] fsmonitor: refactor initialization of
 fsmonitor_last_update token
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

Isolate and document initialization of `istate->fsmonitor_last_update`.
This field should contain a fsmonitor-specific opaque token, but we
need to initialize it before we can actually talk to a fsmonitor process,
so we create a generic default value.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 fsmonitor.c | 35 ++++++++++++++++++++++++++++++++---
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/fsmonitor.c b/fsmonitor.c
index 64deeda597e..e12214b3007 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -343,16 +343,45 @@ void refresh_fsmonitor(struct index_state *istate)
 	istate->fsmonitor_last_update = strbuf_detach(&last_update_token, NULL);
 }
 
+/*
+ * The caller wants to turn on FSMonitor.  And when the caller writes
+ * the index to disk, a FSMonitor extension should be included.  This
+ * requires that `istate->fsmonitor_last_update` not be NULL.  But we
+ * have not actually talked to a FSMonitor process yet, so we don't
+ * have an initial value for this field.
+ *
+ * For a protocol V1 FSMonitor process, this field is a formatted
+ * "nanoseconds since epoch" field.  However, for a protocol V2
+ * FSMonitor process, this field is an opaque token.
+ *
+ * Historically, `add_fsmonitor()` has initialized this field to the
+ * current time for protocol V1 processes.  There are lots of race
+ * conditions here, but that code has shipped...
+ *
+ * The only true solution is to use a V2 FSMonitor and get a current
+ * or default token value (that it understands), but we cannot do that
+ * until we have actually talked to an instance of the FSMonitor process
+ * (but the protocol requires that we send a token first...).
+ *
+ * For simplicity, just initialize like we have a V1 process and require
+ * that V2 processes adapt.
+ */
+static void initialize_fsmonitor_last_update(struct index_state *istate)
+{
+	struct strbuf last_update = STRBUF_INIT;
+
+	strbuf_addf(&last_update, "%"PRIu64"", getnanotime());
+	istate->fsmonitor_last_update = strbuf_detach(&last_update, NULL);
+}
+
 void add_fsmonitor(struct index_state *istate)
 {
 	unsigned int i;
-	struct strbuf last_update = STRBUF_INIT;
 
 	if (!istate->fsmonitor_last_update) {
 		trace_printf_key(&trace_fsmonitor, "add fsmonitor");
 		istate->cache_changed |= FSMONITOR_CHANGED;
-		strbuf_addf(&last_update, "%"PRIu64"", getnanotime());
-		istate->fsmonitor_last_update = strbuf_detach(&last_update, NULL);
+		initialize_fsmonitor_last_update(istate);
 
 		/* reset the fsmonitor state */
 		for (i = 0; i < istate->cache_nr; i++)
-- 
gitgitgadget
