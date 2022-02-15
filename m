Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B5BBC4321E
	for <git@archiver.kernel.org>; Tue, 15 Feb 2022 16:00:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241237AbiBOQAu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 11:00:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241150AbiBOQA3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 11:00:29 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3703CC084E
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 07:59:55 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id s10so19372122wrb.1
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 07:59:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=lAazD7H5A5l+Nok2+GMiSl0y/i2VXNjLVlzgEY8/SB4=;
        b=gxZYeo0cX+c1cnjfhSa1RCryFFozcWwZNEImLk4+CMv9DWXaa6/tw8HXrxaRjzwjB8
         89I/Z2lh9jcICB7liZn/yVpW3ZZPb9ufsoFA5ylmEz5umHfWCbw/i8VHZs/yLRGV5OMm
         97D54bwuWlF+DlaJVJSbP+SsQLKZt3pK35TcWFW7jDDsvLJvP1+72jBA5OY0pPC81JS0
         8Z5Yj2pD9S65iVtylOul0jVdjPXGrHPYA7jl/WZZfv1szQps1KjEFbSKuGGc6vkaeC+U
         ivHOHMRisS42L5ymitylpvyvHwy4W/wJjBacBkrNXVct65dGYMa7dQHzqBnaCf6hYzdw
         XkPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=lAazD7H5A5l+Nok2+GMiSl0y/i2VXNjLVlzgEY8/SB4=;
        b=qxEPnXaQnuhGIl1hO9LiyjdCzXy/mn9qhcWGo484UEAk6r6ZMJvvXyJWfAfCzImwyO
         CPaVard41JyFIq1xvLPqIy/nqo6k6ZRkl6r+TVKmOxZI+aW8AHow86/cR2PQ4LkSqOIm
         7iU+JvQ0cqnkfJ1Z1HxmA3HTbK73p+dRhqFAbxeTmTZjYvEIEQx4KFSZnz42rTkAsaRa
         LjOb3XlR1TLU9a2/Twmk4z+3s0adefLYZ8lzyORf2fMBtB+0gXj8jMXiBpMxszhDBdVo
         1ixKaNbrVheU7Y1C7F4KdlJmNmhIJD4dqgJl2drcXCCRHoILam7tDSSmQvQTDOYdvsa0
         /77g==
X-Gm-Message-State: AOAM532K9KpAnRaOBbyzxgwGYmVAYuQC5sADeb8yY8chlRFYtkegAGLX
        yng5ysNrCRM4pS8FfjDKI5/aYsPG2Vc=
X-Google-Smtp-Source: ABdhPJwJ4QM/OCYWlk9x3L3i3eL/agc4DRI7b7DGfaOVUJ3aFsGtBHMjdyuGqtUwBFS3TgpbgVKQcQ==
X-Received: by 2002:adf:face:: with SMTP id a14mr3783354wrs.254.1644940793473;
        Tue, 15 Feb 2022 07:59:53 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n6sm15704214wru.114.2022.02.15.07.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 07:59:52 -0800 (PST)
Message-Id: <a398cdb8a04228ff94e2f5467c010f4917b27042.1644940774.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.git.1644940773.gitgitgadget@gmail.com>
References: <pull.1143.git.1644940773.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Feb 2022 15:59:28 +0000
Subject: [PATCH 18/23] fsm-health-win32: add framework to monitor daemon
 health
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

Create framework in Win32 version of the "health" thread to
periodically inspect the system and shutdown if warranted.

This version just includes the setup for the timeout in
WaitForMultipleObjects() and calls the (currently empty) table
of functions.

A later commit will add functions to the table to actually
inspect the system.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 compat/fsmonitor/fsm-health-win32.c | 54 ++++++++++++++++++++++++++++-
 1 file changed, 53 insertions(+), 1 deletion(-)

diff --git a/compat/fsmonitor/fsm-health-win32.c b/compat/fsmonitor/fsm-health-win32.c
index 94b1d020f25..3c3453369cd 100644
--- a/compat/fsmonitor/fsm-health-win32.c
+++ b/compat/fsmonitor/fsm-health-win32.c
@@ -4,6 +4,40 @@
 #include "fsm-health.h"
 #include "fsmonitor--daemon.h"
 
+/*
+ * Every minute wake up and test our health.
+ */
+#define WAIT_FREQ_MS (60 * 1000)
+
+enum interval_fn_ctx { CTX_INIT = 0, CTX_TERM, CTX_TIMER };
+
+typedef int (interval_fn)(struct fsmonitor_daemon_state *state,
+			  enum interval_fn_ctx ctx);
+
+static interval_fn *table[] = {
+	NULL, /* must be last */
+};
+
+/*
+ * Call all of the functions in the table.
+ * Shortcut and return first error.
+ *
+ * Return 0 if all succeeded.
+ */
+static int call_all(struct fsmonitor_daemon_state *state,
+		    enum interval_fn_ctx ctx)
+{
+	int k;
+
+	for (k = 0; table[k]; k++) {
+		int r = table[k](state, ctx);
+		if (r)
+			return r;
+	}
+
+	return 0;
+}
+
 struct fsm_health_data
 {
 	HANDLE hEventShutdown;
@@ -45,15 +79,31 @@ void fsm_health__dtor(struct fsmonitor_daemon_state *state)
 void fsm_health__loop(struct fsmonitor_daemon_state *state)
 {
 	struct fsm_health_data *data = state->health_data;
+	int r;
+
+	r = call_all(state, CTX_INIT);
+	if (r < 0)
+		goto force_error_stop;
+	if (r > 0)
+		goto force_shutdown;
 
 	for (;;) {
 		DWORD dwWait = WaitForMultipleObjects(data->nr_handles,
 						      data->hHandles,
-						      FALSE, INFINITE);
+						      FALSE, WAIT_FREQ_MS);
 
 		if (dwWait == WAIT_OBJECT_0 + HEALTH_SHUTDOWN)
 			goto clean_shutdown;
 
+		if (dwWait == WAIT_TIMEOUT) {
+			r = call_all(state, CTX_TIMER);
+			if (r < 0)
+				goto force_error_stop;
+			if (r > 0)
+				goto force_shutdown;
+			continue;
+		}
+
 		error(_("health thread wait failed [GLE %ld]"),
 		      GetLastError());
 		goto force_error_stop;
@@ -61,8 +111,10 @@ void fsm_health__loop(struct fsmonitor_daemon_state *state)
 
 force_error_stop:
 	state->health_error_code = -1;
+force_shutdown:
 	ipc_server_stop_async(state->ipc_server_data);
 clean_shutdown:
+	call_all(state, CTX_TERM);
 	return;
 }
 
-- 
gitgitgadget

