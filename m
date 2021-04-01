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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44367C433B4
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 18:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D0626112E
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 18:04:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237599AbhDASEA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Apr 2021 14:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237008AbhDAR7U (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Apr 2021 13:59:20 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 742A3C02D548
        for <git@vger.kernel.org>; Thu,  1 Apr 2021 08:41:20 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id b9so2265844wrt.8
        for <git@vger.kernel.org>; Thu, 01 Apr 2021 08:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Fq+75wZ+1cIqBx465IViCteahZviGOVpai2pd5+YxWU=;
        b=ALf+zPQ4ovCKG+BwNGhlzG+5p7egK+RyugLnR7N0GZYhv4+H6In/SrFeTYfy12E3Hj
         9w6ASVyBOuy6R5b9hICyG0PeO5XKoSLNlVgbPx9T5ByRNH9WAF1X2YJnzadS31lVdMc+
         agI7KJSCLu1dfuFxkXMoKshWuwUScqCwOQvDVS++R1cTUj9onkIcE7iJ/Sc0HXWbV5Wn
         5iLK4ecQUuc1tq7DjkCfCCc9rmw5L3BC3H15RNAZ9Dxeo4Dvc6jVjq8SgmY7iZIUM+A8
         vujlfXIswUfXBqlGJz8dIMF/h4hdVMI2gyijKyCCFj7PeuYgwu82iBREJy6nPmjEOxjG
         YM9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Fq+75wZ+1cIqBx465IViCteahZviGOVpai2pd5+YxWU=;
        b=mQ9ARxBFAfq5zJZIJlzpvewZBb0UKcSUGODng+2kI1976E97V0v4bfWF0JfnKoGPQz
         bghppsKTy2sAWzGE0X6E3oBDAlZCt+eJ0sGUfr5PxkQVeR/0IZxrcXOlE3kL2eBNbVlV
         4XoFF5Ceh3rwFidQChHD6HO1tJ7+plv5FjFqMgzt7omEVTFHb3imYSMBGF+75r0jogRO
         g+QNttkikTTE4/seJBY8Ojarc+GLc1WrVoAoz/LLZpYKMHAPe1kO9XrVuj2Bx6uu0cjk
         74pHVfAMkC3R6XCVo8N2MfAWGiR8x76CTe+wuLydhPbklcL282EMxdHIRaAhN0C4l5MS
         GAYA==
X-Gm-Message-State: AOAM530IhQOmUGo8k10ocahOI5VW6GmKMCdcsV8ukw27S82Mk3hAa6pD
        077zpbK64XUce+NcHqXYSx/SGtUJmiM=
X-Google-Smtp-Source: ABdhPJwQ/cOvUD/MIZCv+9Cr/VYU3RF8UcDXfS2NJpzSsJnN6YJh3DppmzWrd0nKjwWEOFdm4nM/8g==
X-Received: by 2002:adf:cd04:: with SMTP id w4mr10646130wrm.148.1617291679248;
        Thu, 01 Apr 2021 08:41:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c11sm10867359wrm.67.2021.04.01.08.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 08:41:18 -0700 (PDT)
Message-Id: <c6d5f045fb5644306a3676e5fa4145ba4c6e9b93.1617291666.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.923.git.1617291666.gitgitgadget@gmail.com>
References: <pull.923.git.1617291666.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Apr 2021 15:41:00 +0000
Subject: [PATCH 18/23] fsmonitor--daemon:: introduce client delay for testing
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

Define GIT_TEST_FSMONITOR_CLIENT_DELAY as a millisecond delay.

Introduce an artificial delay when processing client requests.
This make the CI/PR test suite a little more stable and avoids
the need to load up test scripts with sleep statements to avoid
racy failures.  This was mostly seen on 1 or 2 core CI build
machines where the test script would create a file and quickly
try to confirm that the daemon had seen it *before* the daemon
had received the kernel event and causing a test failure.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 builtin/fsmonitor--daemon.c | 38 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index e9a9aea59ad6..0cb09ef0b984 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -150,6 +150,30 @@ static int do_as_client__send_flush(void)
 	return 0;
 }
 
+static int lookup_client_test_delay(void)
+{
+	static int delay_ms = -1;
+
+	const char *s;
+	int ms;
+
+	if (delay_ms >= 0)
+		return delay_ms;
+
+	delay_ms = 0;
+
+	s = getenv("GIT_TEST_FSMONITOR_CLIENT_DELAY");
+	if (!s)
+		return delay_ms;
+
+	ms = atoi(s);
+	if (ms < 0)
+		return delay_ms;
+
+	delay_ms = ms;
+	return delay_ms;
+}
+
 /*
  * Requests to and from a FSMonitor Protocol V2 provider use an opaque
  * "token" as a virtual timestamp.  Clients can request a summary of all
@@ -526,6 +550,18 @@ static int do_handle_client(struct fsmonitor_daemon_state *state,
 		return SIMPLE_IPC_QUIT;
 	}
 
+	/*
+	 * For testing purposes, introduce an artificial delay in this
+	 * worker to allow the filesystem listener thread to receive
+	 * any fs events that may have been generated by the client
+	 * process on the other end of the pipe/socket.  This helps
+	 * make the CI/PR test suite runs a little more predictable
+	 * and hopefully eliminates the need to introduce `sleep`
+	 * commands in the test scripts.
+	 */
+	if (state->test_client_delay_ms)
+		sleep_millisec(state->test_client_delay_ms);
+
 	if (!strcmp(command, "flush")) {
 		/*
 		 * Flush all of our cached data and generate a new token
@@ -1038,7 +1074,7 @@ static int fsmonitor_run_daemon(void)
 	pthread_mutex_init(&state.main_lock, NULL);
 	state.error_code = 0;
 	state.current_token_data = fsmonitor_new_token_data();
-	state.test_client_delay_ms = 0;
+	state.test_client_delay_ms = lookup_client_test_delay();
 
 	/* Prepare to (recursively) watch the <worktree-root> directory. */
 	strbuf_init(&state.path_worktree_watch, 0);
-- 
gitgitgadget

