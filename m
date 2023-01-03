Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57430C54EBC
	for <git@archiver.kernel.org>; Tue,  3 Jan 2023 17:59:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238414AbjACR7l (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Jan 2023 12:59:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238612AbjACR7g (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jan 2023 12:59:36 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9EB212637
        for <git@vger.kernel.org>; Tue,  3 Jan 2023 09:59:35 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id g10so9652848wmo.1
        for <git@vger.kernel.org>; Tue, 03 Jan 2023 09:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=q1zM/G+l7xBBn3eniUdPvx+6S9sWlDwg6zmtcgLX3/Q=;
        b=cvv/XC7lZciPZmbcUI4oWXPYmmVOIxoH6lQ/T56pp3CQPLCAe1lVHg/RNZ6p2s0eXu
         EAdNwRJZhjTWkIDpdULeu/RpJQTIkpU5HjFNshIvG8IVK0f4XFWFauJ/jEVgQsi+yWt9
         EHruG5i4V+5MVWY0et2u/gzAJCkFrSdXdK8S4y/T8Xozt08OCs/ZICgtAkVlpxDfB8DV
         o9CiVN9bIV8bEm3MuMZAoaA81wt68bw8cECDhZUgUlK6HlAfXM55ShshhWXbQj+Q9hpm
         B/IpI8GO7O8ESuPmCt6fIjvkVC0aIr1NlsqttkejSLMKVxqVlbePuKIkj15KQVlDT1hr
         Nn5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q1zM/G+l7xBBn3eniUdPvx+6S9sWlDwg6zmtcgLX3/Q=;
        b=tjcXXNSARdPjtSb3TZv47LCZCuyA71m5tXg7+8fHvBJ2ymZZvuDniGyk8OVnni2xoS
         TMKXM6wIy5g6FEXv8XZuFz/KVULynMw0yTnag/7qo5WPnORhyrB1/+5slhN0hoEndo5Q
         WUp6KxQg4FgjKsp1u3xjt/rQrpYhi4LPqTg1iRfkbfscTlodI8LKv+Qg8/+PULUpEMq0
         qNjiZd5zr33V76ut+l93xWsUeQivbVwhYjTVYItoYUMgi2E4bPA+/0apWh+qm7T3NByF
         YuU4q8yHzEEAikjyogWqoS/mco5LPkf9Sgje/PuSjcsuhWX0x0uUZMLl/gwSBp6dH5bV
         lfGQ==
X-Gm-Message-State: AFqh2koqv7e9OSnYnYOZog6MidkTy5Qzcv4PNfVDJcvkDeD6k36L8hXV
        KQPL2E4mX9MG6dc0clpPBQcJwduhyME=
X-Google-Smtp-Source: AMrXdXtrNbWHscYPlOb26g93BIKQ/MeVU9s8XFGrLnVP2VRrYnRrmY0+bEyrALveljnMQ4GrAmjtwA==
X-Received: by 2002:a05:600c:3b82:b0:3d3:4877:e560 with SMTP id n2-20020a05600c3b8200b003d34877e560mr31281250wms.27.1672768773677;
        Tue, 03 Jan 2023 09:59:33 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l42-20020a05600c1d2a00b003cfbbd54178sm70543510wms.2.2023.01.03.09.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 09:59:33 -0800 (PST)
Message-Id: <pull.1423.git.git.1672768772484.gitgitgadget@gmail.com>
From:   "Rose via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 03 Jan 2023 17:59:32 +0000
Subject: [PATCH] run-command: make async_exit usage consistent
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Rose <83477269+AtariDreams@users.noreply.github.com>,
        Seija Kijin <doremylover123@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Seija Kijin <doremylover123@gmail.com>

Use async_exit instead of pthread_exit,
and make async_exit inline.

Functions were reordered
so that this would compile.

Luckily, the order remains consistent.

Signed-off-by: Seija Kijin <doremylover123@gmail.com>
---
    run-command: make async_exit usage consistent
    
    Use async_exit instead of pthread_exit, and make async_exit inline.
    
    Finally, make the parameter an unsigned int, because the Win32 API uses
    unsigned int, and for other platforms, we cast to void anyway.
    
    Signed-off-by: Seija Kijin doremylover123@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1423%2FAtariDreams%2Fconsistency-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1423/AtariDreams/consistency-v1
Pull-Request: https://github.com/git/git/pull/1423

 run-command.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/run-command.c b/run-command.c
index 756f1839aab..e1eab4cb69b 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1030,6 +1030,18 @@ static void *run_thread(void *data)
 	return (void *)ret;
 }
 
+int in_async(void)
+{
+	if (!main_thread_set)
+		return 0; /* no asyncs started yet */
+	return !pthread_equal(main_thread, pthread_self());
+}
+
+static inline void NORETURN async_exit(int code)
+{
+	pthread_exit((void *)(intptr_t)code);
+}
+
 static NORETURN void die_async(const char *err, va_list params)
 {
 	report_fn die_message_fn = get_die_message_routine();
@@ -1042,7 +1054,7 @@ static NORETURN void die_async(const char *err, va_list params)
 			close(async->proc_in);
 		if (async->proc_out >= 0)
 			close(async->proc_out);
-		pthread_exit((void *)128);
+		async_exit(128);
 	}
 
 	exit(128);
@@ -1055,18 +1067,6 @@ static int async_die_is_recursing(void)
 	return ret != NULL;
 }
 
-int in_async(void)
-{
-	if (!main_thread_set)
-		return 0; /* no asyncs started yet */
-	return !pthread_equal(main_thread, pthread_self());
-}
-
-static void NORETURN async_exit(int code)
-{
-	pthread_exit((void *)(intptr_t)code);
-}
-
 #else
 
 static struct {
@@ -1112,7 +1112,7 @@ int in_async(void)
 	return process_is_async;
 }
 
-static void NORETURN async_exit(int code)
+static inline void NORETURN async_exit(int code)
 {
 	exit(code);
 }

base-commit: 2b4f5a4e4bb102ac8d967cea653ed753b608193c
-- 
gitgitgadget
