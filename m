Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B37D8C433E0
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 22:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D37964ED0
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 22:03:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbhBAWD0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 17:03:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbhBAWDV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 17:03:21 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E596C0617AA
        for <git@vger.kernel.org>; Mon,  1 Feb 2021 14:02:35 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id e15so597596wme.0
        for <git@vger.kernel.org>; Mon, 01 Feb 2021 14:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ZpeyCC6Uj8x/EgLF5U4HUvxXJe+rqCgzupKMUyrx2y0=;
        b=cD8St/00TiYx10ap75dZzgrq1m3NVSd4Lijs+atmictHb6MmloeXKTjvTyUh/dsjNj
         n7RZgFIIGTVYV6nxVDxy8GROq8tMh3/xxRTtLPqA0QUBsPLUr4IQ979+cbJMTwIHSCMZ
         19rtXHYQtxOervfHyKIfa4/3auXskrwDXW50VgiE+O1jpJfGdXeqpY2sC3s6f3tDwtQ2
         KNcuDIZ4BK9yAxY0Qm6VAs4sQz1aY9686X1v8IjW7LBCkh7+r6YAoRXKFJKUJvf15mYB
         GuQTzt9xKLBXRKWbX2auqp8cEOFakrfnl0m2xjgViJqNZbFZCevgDxYimbejZ21scPBb
         wVHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ZpeyCC6Uj8x/EgLF5U4HUvxXJe+rqCgzupKMUyrx2y0=;
        b=fYHOupN+Bf97QCt4ZUxvCgnVAMPRuir9mWLoPMgP5BOE+W/QSdRdy0A7kuQmywJs5S
         +R1Zig794xcwSYoWZxvzOzD3qQ5nFvsj3WlpMxmA1jqWnricUM1dEqUtYmDyXBjWBp6U
         Zqis/CQ5Izb+mlHlFEwnPQNgN3/eCw6yTWca9l4FSl9EcMCEwcDC15ZeVPjx8rEk8erc
         iPoEyCeohEW32Uk15Waqtu4HNDcOGw1ZRFmrkpHHzx1VplQvTz1WTqTN1CvipRvZFZ5c
         s/xh93Igei84xHTG0drf0L2OgSDdnCzjOC391dQyM1gf1yJXdXvUKH0CtBT4J+YlF+Zr
         0+fw==
X-Gm-Message-State: AOAM532q+YOJerr3yuKEVm6AxDE9N7Q0Lx7T6/MLfROaHqif/p94ntQc
        p9t1vJ5daqeB8xR4wbJzFA65idENX0U=
X-Google-Smtp-Source: ABdhPJyTp8vQyYlPzEOJOWf04DhcreBDPRQoc0Cnwqr3jGojUnmlGQLa4UCDATV9XeL3TtiMsOiJqA==
X-Received: by 2002:a1c:7f94:: with SMTP id a142mr757548wmd.145.1612216954221;
        Mon, 01 Feb 2021 14:02:34 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g194sm529378wme.39.2021.02.01.14.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 14:02:33 -0800 (PST)
Message-Id: <4686196bbc6a583eda16d2f2274e29df98284a22.1612216941.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.860.git.1612216941.gitgitgadget@gmail.com>
References: <pull.860.git.1612216941.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 01 Feb 2021 22:02:20 +0000
Subject: [PATCH 11/11] fsmonitor: refactor initialization of
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
