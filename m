Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B005FC433FE
	for <git@archiver.kernel.org>; Tue, 15 Feb 2022 16:00:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241160AbiBOQAh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 11:00:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241096AbiBOQA3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 11:00:29 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B18BF52E
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 07:59:52 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id h6so32894874wrb.9
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 07:59:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=aaxh25XeSH8sX61oAvJCISnnCm9H/WdtdhYBRpy7XFo=;
        b=aSAsOp5qGBqqwAunQzbuycz8gm5V8NnFIo6W5JAizs90wZX4x4TtlTcA5jTLhvyLXb
         jm3r/5rnsICcyP4nwYIFdFiajN87eIuutIMRS4LtZ/YzX1rzTVGKjpihIjCPK84mE2t8
         lO2AEh+qjb8sWesHIJnhgnu1gvYhSeCEjwlUPKudYzG9Ru7rrUB+aJw/C1PHJMJlF/vk
         BfELED9HKZV08d4s4/VPGaLQnuoOO/CSEPXIm3mjFR0ZKEHo2CP11gDYQ8Ip1jejVgmF
         TM0Hu9ZedeooekFoSHcdvRXFscmnZIcOU7FhLYxMUg6aUB1WKk7RS5moLQ6TCcwANaj7
         jECA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=aaxh25XeSH8sX61oAvJCISnnCm9H/WdtdhYBRpy7XFo=;
        b=DsNhdroJuitz6Ofuk4vgshme3vPLd859SjZVDbOSDihrjdsOFv41OR9q2XJSf+nxoJ
         7tVKlFLTwrThuEDjcyPluwDsCI6h8rFn6NSKHYZA+fq8cE5N7JGS9RpvMbrcy4E0wEQD
         E51wvKQYVsmqIGvoCStGA3AFBcCo8aJY17pKkg6dOuHjSccW9rxPT2HvANd81zfbl58j
         NUggdByX3GMoBsW78nyVGf51yOMTdDyZS1lECQaThPw8I4KULkIuIJXdY/Z5GJ8auuBA
         QAfHLytucoOxVNIXOhz7Kxya4IS76TZ7JFI5Z2/g4Nr6Gd8oT8kN3uwVEUSGjtYMhnpq
         z+mw==
X-Gm-Message-State: AOAM532R1L0xOnEewiP3sdYmxssFHERhQcIP7SCiF5jylzftajyYWmef
        JVgTMKF2/xxAf3R04dV4fq2uieouQxU=
X-Google-Smtp-Source: ABdhPJxwU9CTtHhCPdhlYzOAHNQcsFn0+cE00elCYyLh1iXZhihOTmr7ZRxSE6ItL4L+5Auh+Tvseg==
X-Received: by 2002:a5d:64e5:: with SMTP id g5mr3754751wri.361.1644940790780;
        Tue, 15 Feb 2022 07:59:50 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q2sm32178592wrw.14.2022.02.15.07.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 07:59:50 -0800 (PST)
Message-Id: <6b5642f7770d95f318eb04066e0291072bd8814e.1644940774.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.git.1644940773.gitgitgadget@gmail.com>
References: <pull.1143.git.1644940773.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Feb 2022 15:59:25 +0000
Subject: [PATCH 15/23] fsmonitor--daemon: prepare for adding health thread
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

Refactor daemon thread startup to make it easier to start
a third thread class to monitor the health of the daemon.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 builtin/fsmonitor--daemon.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index e9b3f44d791..f42fb2ab626 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -1162,6 +1162,8 @@ static int fsmonitor_run_daemon_1(struct fsmonitor_daemon_state *state)
 		 */
 		.uds_disallow_chdir = 0
 	};
+	int listener_started = 0;
+	int err = 0;
 
 	/*
 	 * Start the IPC thread pool before the we've started the file
@@ -1182,15 +1184,20 @@ static int fsmonitor_run_daemon_1(struct fsmonitor_daemon_state *state)
 	if (pthread_create(&state->listener_thread, NULL,
 			   fsm_listen__thread_proc, state) < 0) {
 		ipc_server_stop_async(state->ipc_server_data);
-		ipc_server_await(state->ipc_server_data);
-
-		return error(_("could not start fsmonitor listener thread"));
+		err = error(_("could not start fsmonitor listener thread"));
+		goto cleanup;
 	}
+	listener_started = 1;
 
 	/*
 	 * The daemon is now fully functional in background threads.
+	 * Our primary thread should now just wait while the threads
+	 * do all the work.
+	 */
+cleanup:
+	/*
 	 * Wait for the IPC thread pool to shutdown (whether by client
-	 * request or from filesystem activity).
+	 * request, from filesystem activity, or an error).
 	 */
 	ipc_server_await(state->ipc_server_data);
 
@@ -1199,10 +1206,16 @@ static int fsmonitor_run_daemon_1(struct fsmonitor_daemon_state *state)
 	 * event from the IPC thread pool, but it doesn't hurt to tell
 	 * it again.  And wait for it to shutdown.
 	 */
-	fsm_listen__stop_async(state);
-	pthread_join(state->listener_thread, NULL);
+	if (listener_started) {
+		fsm_listen__stop_async(state);
+		pthread_join(state->listener_thread, NULL);
+	}
 
-	return state->error_code;
+	if (err)
+		return err;
+	if (state->error_code)
+		return state->error_code;
+	return 0;
 }
 
 static int fsmonitor_run_daemon(void)
-- 
gitgitgadget

