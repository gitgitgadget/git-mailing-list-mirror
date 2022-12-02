Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D4AC47089
	for <git@archiver.kernel.org>; Fri,  2 Dec 2022 17:03:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234306AbiLBRDM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Dec 2022 12:03:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234134AbiLBRDD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2022 12:03:03 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6F6D1106
        for <git@vger.kernel.org>; Fri,  2 Dec 2022 09:03:01 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id m14so8713125wrh.7
        for <git@vger.kernel.org>; Fri, 02 Dec 2022 09:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hXpGXrc1/OUzdagiWr83qXxIQilAMJ2V3xHDQHKM0MA=;
        b=o8uquEDbNmCAdW+yuLi0igapzg1knpQgP4KcAwjhL6VgPRm3cIa92Lal8iAo5as8pK
         FbIoI0avn91KjmY6Sp5ECgariIt+DNsDn8TXzL+2C3W8Qh2quk5G//gMlIE5OQtCEoNF
         nn480W48Toh+02kdG8Acglmn7MJsZXid5hDmZcyAtu3nvo1RqvzhmXiDALocJB5uqmuu
         gbDDnrmRl9lgTg0CpWKHPqHurMXCI3oJ6IBkRP4f+bQxyHSIX5tooH1ETDz+ZcMnfy/U
         0HvJtxYvoXs6zBBb7hPZRiybZta1KS8spK/N2jhWLpjsT5aOIb/L1pmvD+EFWaFiKqEi
         RZhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hXpGXrc1/OUzdagiWr83qXxIQilAMJ2V3xHDQHKM0MA=;
        b=hJOVf4pmP8rRucFv0zkhATHwMrg2AmProCIjylnPyV1QD0bwwuyJVtY+FudBVIRLdE
         +hTSYOeKgO+MY4GmBxGmMA4KHauLTUad+4HU1iWSJpY9EvzSWtt/6IMoR3mSRzSK71c1
         R/2LVU0Gn3eOMutVfMs1YviGN3uBvajAK/ySziIm7+afafxthTwslSbVWW9EN7XWNcya
         ZndIqRnSBPNvKd17oAB2yP5zfMs3sJM86N6/Pi3x0T1JVJUT8T5mungA7YyhufZjv0dR
         dEOzh3nEF7sOIWe44Kovi1Zj7aAVc/9jI/3hBxeNM4dt+bWj/koRV35zK3Y0Mn3xpqjm
         oB/g==
X-Gm-Message-State: ANoB5pkFCudM8Uoi5kQZy3sID5inR5AwZIOcq6cYn3pWbznyVK+bprk7
        jViEn1Kf+DAGJqqwvYXFIiLnKeQ7F5E=
X-Google-Smtp-Source: AA0mqf4aLgJRrsLy65KUPmdk77fvOb+1FPN1i+KFZEZRyod10svJCe1lH7RNqjcsdNANL9QlMM2GPw==
X-Received: by 2002:adf:d22f:0:b0:242:481e:467 with SMTP id k15-20020adfd22f000000b00242481e0467mr1975057wrh.72.1670000579827;
        Fri, 02 Dec 2022 09:02:59 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v24-20020a05600c4d9800b003cfbe1da539sm8596582wmp.36.2022.12.02.09.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 09:02:59 -0800 (PST)
Message-Id: <pull.1389.git.git.1670000578395.gitgitgadget@gmail.com>
From:   "Rose via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 02 Dec 2022 17:02:58 +0000
Subject: [PATCH] maintenance: compare output of pthread functions for
 inequality with 0
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Rose <83477269+AtariDreams@users.noreply.github.com>,
        Seija <doremylover123@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Seija <doremylover123@gmail.com>

The documentation for pthread_create and pthread_sigmask state that:

"On success, pthread_create() returns 0;
on error, it returns an error number"

As such, we ought to check for an error
by seeing if the output is not 0.

Checking for "less than" is a mistake
as the error code numbers can be greater than 0.

Signed-off-by: Seija <doremylover123@gmail.com>
---
    maintenance: compare output of pthread functions for inequality with 0
    
    The documentation for pthread_create and pthread_sigmask state that "On
    success, pthread_create() returns 0; on error, it returns an error
    number, and the contents of *thread are undefined."
    
    As such, we ought to check for an error by seeing if the output is not
    0, rather than being less than 0, since nothing stops these functions
    from returning a positive number.
    
    Signed-off by: Seija doremylover123@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1389%2FAtariDreams%2Faddress-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1389/AtariDreams/address-v1
Pull-Request: https://github.com/git/git/pull/1389

 builtin/fsmonitor--daemon.c | 4 ++--
 run-command.c               | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index 6f30a4f93a7..52a08bb3b57 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -1209,7 +1209,7 @@ static int fsmonitor_run_daemon_1(struct fsmonitor_daemon_state *state)
 	 * events.
 	 */
 	if (pthread_create(&state->listener_thread, NULL,
-			   fsm_listen__thread_proc, state) < 0) {
+			   fsm_listen__thread_proc, state)) {
 		ipc_server_stop_async(state->ipc_server_data);
 		err = error(_("could not start fsmonitor listener thread"));
 		goto cleanup;
@@ -1220,7 +1220,7 @@ static int fsmonitor_run_daemon_1(struct fsmonitor_daemon_state *state)
 	 * Start the health thread to watch over our process.
 	 */
 	if (pthread_create(&state->health_thread, NULL,
-			   fsm_health__thread_proc, state) < 0) {
+			   fsm_health__thread_proc, state)) {
 		ipc_server_stop_async(state->ipc_server_data);
 		err = error(_("could not start fsmonitor health thread"));
 		goto cleanup;
diff --git a/run-command.c b/run-command.c
index 48b9ba6d6f0..756f1839aab 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1019,7 +1019,7 @@ static void *run_thread(void *data)
 		sigset_t mask;
 		sigemptyset(&mask);
 		sigaddset(&mask, SIGPIPE);
-		if (pthread_sigmask(SIG_BLOCK, &mask, NULL) < 0) {
+		if (pthread_sigmask(SIG_BLOCK, &mask, NULL)) {
 			ret = error("unable to block SIGPIPE in async thread");
 			return (void *)ret;
 		}

base-commit: 805265fcf7a737664a8321aaf4a0587b78435184
-- 
gitgitgadget
