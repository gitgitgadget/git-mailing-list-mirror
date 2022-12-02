Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA00C4321E
	for <git@archiver.kernel.org>; Fri,  2 Dec 2022 14:24:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232664AbiLBOYh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Dec 2022 09:24:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiLBOYg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2022 09:24:36 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5455DC7730
        for <git@vger.kernel.org>; Fri,  2 Dec 2022 06:24:35 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id m19so3640682wms.5
        for <git@vger.kernel.org>; Fri, 02 Dec 2022 06:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sRfGL/3RpF2IAYFknPk3eefJnSp+xuuML5GPkGyj074=;
        b=N0MO0brMVQQmhTUCKXeAUr8L/XZn0iDeaggU03AOHk/pq4kC6hp8vWYYh2Hjqbnbzj
         Zrq0O9bjnieiD9BpibXOf9/a4vz4nr3CL3kA47KFGZLvBbSku+ONAL03wqioHawJEWvY
         liOkJd2lY1VYuotvV+DasL64sbCDkKzXRQ0clQqHuHnyg5X5VQm2TKS5dGajZcRxfPmt
         pde2OdxbPI9giMiGYJ1PDtE36h24SOFcuuj0mYbY9FuZnhJLF23wuHhwJ+L1VDaA34G9
         bnr2w4AofyT+Z6xIwDQeTmanXoApnhAAlMcXvdjDzOFpTGnZmRJ1c0+Q0E1c7zL71TPP
         25dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sRfGL/3RpF2IAYFknPk3eefJnSp+xuuML5GPkGyj074=;
        b=KglyhETsXpvBbdE6e7H5ABXFD1ihjBoFjkkR+LKyNrKHvwLfTz1EEFENKxXlG4nkvC
         WFDIeh632wS5TkOwjwOuOFuvcdGB1//COh4aphb4yeTsYfmCbXvbjF4mGFogEBK6V3d+
         nrMtl4eO/Mh8b3yACjlOfutaJRw1iM1z1SFGF2IgAUoiG1q5iX0Rqwt50+9+yONDbpKa
         u1aLfMs3GnCQ1fTNtgqDpbm+WsHcLhjHKnVIv7yzf9jYylntcPdyWAXyGFXD1lwDUj+D
         vGl3YPbhjih0evkhjK+tG24XyufxmwBA8xC/cnPXnv85KVqLVmMzsRJCrOYuw7mU1alS
         PZ1Q==
X-Gm-Message-State: ANoB5pk8Ud1ZTWHsanHsmBxHkgoKNnvOhnpIgk7DfilBahrJbehuNNFj
        2o0gT4xeNWY98amkvKbhJgPams78txo=
X-Google-Smtp-Source: AA0mqf6dvu7AmaVFRmdyiVNhHsAQx90ifVLdHTwb7gaZwoThdnvuehiEr9eFfdQyTXhlER8w/X00jA==
X-Received: by 2002:a05:600c:3393:b0:3cf:81f3:1e4a with SMTP id o19-20020a05600c339300b003cf81f31e4amr57088438wmp.4.1669991073475;
        Fri, 02 Dec 2022 06:24:33 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w5-20020a5d6805000000b00241ce5d605dsm6898769wru.110.2022.12.02.06.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 06:24:33 -0800 (PST)
Message-Id: <pull.1436.git.1669991072393.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 02 Dec 2022 14:24:32 +0000
Subject: [PATCH] fsmonitor: eliminate call to deprecated FSEventStream
 function
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Stefan Sundin <git@stefansundin.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Jeff Hostetler <jeffhostetler@github.com>,
        Jeff Hostetler <jeffhostetler@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhostetler@github.com>

Replace the call to `FSEventStreamScheduleWithRunLoop()` function with
the suggested `FSEventStreamSetDispatchQueue()` function.

The MacOS version of the builtin FSMonitor feature uses the
`FSEventStreamScheduleWithRunLoop()` function to drive the event loop
and process FSEvents from the system.  This routine has now been
deprecated by Apple.  The MacOS 13 (Ventana) compiler tool chain now
generates a warning when compiling calls to this function.  In
DEVELOPER=1 mode, this now causes a compile error.

The `FSEventStreamSetDispatchQueue()` function is conceptually similar
and is the suggested replacement.  However, there are some subtle
thread-related differences.

Previously, the event stream would be processed by the
`fsm_listen__loop()` thread while it was in the `CFRunLoopRun()`
method.  (Conceptually, this was a blocking call on the lifetime of
the event stream where our thread drove the event loop and individual
events were handled by the `fsevent_callback()`.)

With the change, a "dispatch queue" is created and FSEvents will be
processed by a hidden queue-related thread (that calls the
`fsevent_callback()` on our behalf).  Our `fsm_listen__loop()` thread
maintains the original blocking model by waiting on a mutex/condition
variable pair while the hidden thread does all of the work.

Signed-off-by: Jeff Hostetler <jeffhostetler@github.com>
---
    fsmonitor: eliminate call to deprecated FSEventStream function
    
    This patch replaces the call to the now deprecated
    FSEventStreamScheduleWithRunLoop() function with
    FSEventStreamSetDispatchQueue() as suggested by the compiler warning in
    the MacOS version of FSMonitor.
    
    I have tested this on MacOS 13 on my Intel and M1 laptops. And it has
    passed all tests on the GGG CI builds. However, I don't have access to
    an older version of MacOS anymore. The docs say that this new (to us)
    function has been available since 10.6, so we should be OK using it on
    older versions of MacOS, but I cannot confirm that.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1436%2Fjeffhostetler%2Ffsmonitor-macos-dispatch-queue-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1436/jeffhostetler/fsmonitor-macos-dispatch-queue-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1436

 compat/fsmonitor/fsm-darwin-gcc.h    |  4 +---
 compat/fsmonitor/fsm-listen-darwin.c | 35 +++++++++++++++++++---------
 2 files changed, 25 insertions(+), 14 deletions(-)

diff --git a/compat/fsmonitor/fsm-darwin-gcc.h b/compat/fsmonitor/fsm-darwin-gcc.h
index 1c75c3d48e7..3496e29b3a1 100644
--- a/compat/fsmonitor/fsm-darwin-gcc.h
+++ b/compat/fsmonitor/fsm-darwin-gcc.h
@@ -80,9 +80,7 @@ void CFRunLoopRun(void);
 void CFRunLoopStop(CFRunLoopRef run_loop);
 CFRunLoopRef CFRunLoopGetCurrent(void);
 extern CFStringRef kCFRunLoopDefaultMode;
-void FSEventStreamScheduleWithRunLoop(FSEventStreamRef stream,
-				      CFRunLoopRef run_loop,
-				      CFStringRef run_loop_mode);
+void FSEventStreamSetDispatchQueue(FSEventStreamRef stream, dispatch_queue_t q);
 unsigned char FSEventStreamStart(FSEventStreamRef stream);
 void FSEventStreamStop(FSEventStreamRef stream);
 void FSEventStreamInvalidate(FSEventStreamRef stream);
diff --git a/compat/fsmonitor/fsm-listen-darwin.c b/compat/fsmonitor/fsm-listen-darwin.c
index cc9af1e3cb3..97a55a6f0a4 100644
--- a/compat/fsmonitor/fsm-listen-darwin.c
+++ b/compat/fsmonitor/fsm-listen-darwin.c
@@ -1,4 +1,5 @@
 #ifndef __clang__
+#include <dispatch/dispatch.h>
 #include "fsm-darwin-gcc.h"
 #else
 #include <CoreFoundation/CoreFoundation.h>
@@ -38,7 +39,9 @@ struct fsm_listen_data
 
 	FSEventStreamRef stream;
 
-	CFRunLoopRef rl;
+	dispatch_queue_t dq;
+	pthread_cond_t dq_finished;
+	pthread_mutex_t dq_lock;
 
 	enum shutdown_style {
 		SHUTDOWN_EVENT = 0,
@@ -379,8 +382,11 @@ force_shutdown:
 	fsmonitor_batch__free_list(batch);
 	string_list_clear(&cookie_list, 0);
 
+	pthread_mutex_lock(&data->dq_lock);
 	data->shutdown_style = FORCE_SHUTDOWN;
-	CFRunLoopStop(data->rl);
+	pthread_cond_broadcast(&data->dq_finished);
+	pthread_mutex_unlock(&data->dq_lock);
+
 	strbuf_release(&tmp);
 	return;
 }
@@ -441,10 +447,6 @@ int fsm_listen__ctor(struct fsmonitor_daemon_state *state)
 	if (!data->stream)
 		goto failed;
 
-	/*
-	 * `data->rl` needs to be set inside the listener thread.
-	 */
-
 	return 0;
 
 failed:
@@ -471,6 +473,11 @@ void fsm_listen__dtor(struct fsmonitor_daemon_state *state)
 		FSEventStreamRelease(data->stream);
 	}
 
+	if (data->dq)
+		dispatch_release(data->dq);
+	pthread_cond_destroy(&data->dq_finished);
+	pthread_mutex_destroy(&data->dq_lock);
+
 	FREE_AND_NULL(state->listen_data);
 }
 
@@ -479,9 +486,11 @@ void fsm_listen__stop_async(struct fsmonitor_daemon_state *state)
 	struct fsm_listen_data *data;
 
 	data = state->listen_data;
-	data->shutdown_style = SHUTDOWN_EVENT;
 
-	CFRunLoopStop(data->rl);
+	pthread_mutex_lock(&data->dq_lock);
+	data->shutdown_style = SHUTDOWN_EVENT;
+	pthread_cond_broadcast(&data->dq_finished);
+	pthread_mutex_unlock(&data->dq_lock);
 }
 
 void fsm_listen__loop(struct fsmonitor_daemon_state *state)
@@ -490,9 +499,11 @@ void fsm_listen__loop(struct fsmonitor_daemon_state *state)
 
 	data = state->listen_data;
 
-	data->rl = CFRunLoopGetCurrent();
+	pthread_mutex_init(&data->dq_lock, NULL);
+	pthread_cond_init(&data->dq_finished, NULL);
+	data->dq = dispatch_queue_create("FSMonitor", NULL);
 
-	FSEventStreamScheduleWithRunLoop(data->stream, data->rl, kCFRunLoopDefaultMode);
+	FSEventStreamSetDispatchQueue(data->stream, data->dq);
 	data->stream_scheduled = 1;
 
 	if (!FSEventStreamStart(data->stream)) {
@@ -501,7 +512,9 @@ void fsm_listen__loop(struct fsmonitor_daemon_state *state)
 	}
 	data->stream_started = 1;
 
-	CFRunLoopRun();
+	pthread_mutex_lock(&data->dq_lock);
+	pthread_cond_wait(&data->dq_finished, &data->dq_lock);
+	pthread_mutex_unlock(&data->dq_lock);
 
 	switch (data->shutdown_style) {
 	case FORCE_ERROR_STOP:

base-commit: 7452749a781d84244ecd08c6f6ca7e5df67dfce8
-- 
gitgitgadget
