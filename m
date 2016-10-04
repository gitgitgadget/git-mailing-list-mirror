Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA69520986
	for <e@80x24.org>; Tue,  4 Oct 2016 13:00:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754078AbcJDNAd (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 09:00:33 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36435 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753510AbcJDM7z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 08:59:55 -0400
Received: by mail-wm0-f68.google.com with SMTP id b184so19579780wma.3
        for <git@vger.kernel.org>; Tue, 04 Oct 2016 05:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VZBwd1knIN4y/ZgFSGhdb3wJg5s/1XW1zziSiPgbFkc=;
        b=x8fEpBrJm282vOQ3/fPueuTXfOoz35PXHvcXnURLhpLJi0nZbkTTS+MxoOr1HY1Q+8
         6FwVwlyOyUZ32TKWVk6tlaUcsOKO0Hs13xMWV4/W8AG4hl0FZnobBLGtxWS2EiYZ1lag
         qe2jdi7mvhj+soUXrY0i9w07mJCFjGQ+tNK4AZj1do/R60sKqRWd6KiCsEQIYk+tkcni
         idZOAkm1MtzC+RhbayZI7kL3kKg5jpWsOu4S6Cukp1OEdmow1w8UlGkuM+iQ99BMem/v
         M07gT92ugF2QvmlAUkn8wIZAvjl7+0lu/Z6CLxybrPk2pz0s0NeMTZiDi0rLnJ3K0ElF
         Q6YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VZBwd1knIN4y/ZgFSGhdb3wJg5s/1XW1zziSiPgbFkc=;
        b=nDe/DGWC3dQHs8JVpMJviqVf7uM3bwGFEQCIAuC5Q807NObnZkNmttRpngO7TVCYU3
         tTD2rlaUNcr6buWDJLDMIT3S3JKRu16tJvwU474J28ycmaNirgJ1N7t8+0c/LLDLYkPd
         G4b6A9q1Bi1rD7ZZoF6lg1B2g+hegBc2fZt8zO/926Vamvs2fLMoZQGQ6kIitKIY9qKk
         /pyWpcJRoEij081SEwi4i/HiEoDnp8VPdwVvkCs0Oo6S3lXSbfQ6rW6OMLVXSP2WSfXo
         b1L+BPCtLyiCgxz6vq+cOLSktNBE+ujY7b5oihxul+Flg44NxlVixP0SsJYqMYcxKGYe
         dBAw==
X-Gm-Message-State: AA6/9RkpgsVtdS2eWtiaBgVo7BQgSmY8JV4doWNzvbwUEmiMKpYIy3Vl898OlHS0cF64nA==
X-Received: by 10.28.92.82 with SMTP id q79mr3498660wmb.113.1475585994291;
        Tue, 04 Oct 2016 05:59:54 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id qo8sm3426934wjc.46.2016.10.04.05.59.53
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 04 Oct 2016 05:59:53 -0700 (PDT)
From:   larsxschneider@gmail.com
To:     git@vger.kernel.org
Cc:     ramsay@ramsayjones.plus.com, jnareb@gmail.com, gitster@pobox.com,
        j6t@kdbg.org, tboegi@web.de, peff@peff.net, mlbright@gmail.com,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v9 03/14] run-command: move check_pipe() from write_or_die to run_command
Date:   Tue,  4 Oct 2016 14:59:36 +0200
Message-Id: <20161004125947.67104-4-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20161004125947.67104-1-larsxschneider@gmail.com>
References: <20161004125947.67104-1-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

Move check_pipe() to run_command and make it public. This is necessary
to call the function from pkt-line in a subsequent patch.

While at it, make async_exit() static to run_command.c as it is no
longer used from outside.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 run-command.c  | 17 +++++++++++++++--
 run-command.h  |  2 +-
 write_or_die.c | 13 -------------
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/run-command.c b/run-command.c
index 5a4dbb6..3269362 100644
--- a/run-command.c
+++ b/run-command.c
@@ -634,7 +634,7 @@ int in_async(void)
 	return !pthread_equal(main_thread, pthread_self());
 }
 
-void NORETURN async_exit(int code)
+static void NORETURN async_exit(int code)
 {
 	pthread_exit((void *)(intptr_t)code);
 }
@@ -684,13 +684,26 @@ int in_async(void)
 	return process_is_async;
 }
 
-void NORETURN async_exit(int code)
+static void NORETURN async_exit(int code)
 {
 	exit(code);
 }
 
 #endif
 
+void check_pipe(int err)
+{
+	if (err == EPIPE) {
+		if (in_async())
+			async_exit(141);
+
+		signal(SIGPIPE, SIG_DFL);
+		raise(SIGPIPE);
+		/* Should never happen, but just in case... */
+		exit(141);
+	}
+}
+
 int start_async(struct async *async)
 {
 	int need_in, need_out;
diff --git a/run-command.h b/run-command.h
index 5066649..cf29a31 100644
--- a/run-command.h
+++ b/run-command.h
@@ -139,7 +139,7 @@ struct async {
 int start_async(struct async *async);
 int finish_async(struct async *async);
 int in_async(void);
-void NORETURN async_exit(int code);
+void check_pipe(int err);
 
 /**
  * This callback should initialize the child process and preload the
diff --git a/write_or_die.c b/write_or_die.c
index 0734432..eab8c8d 100644
--- a/write_or_die.c
+++ b/write_or_die.c
@@ -1,19 +1,6 @@
 #include "cache.h"
 #include "run-command.h"
 
-static void check_pipe(int err)
-{
-	if (err == EPIPE) {
-		if (in_async())
-			async_exit(141);
-
-		signal(SIGPIPE, SIG_DFL);
-		raise(SIGPIPE);
-		/* Should never happen, but just in case... */
-		exit(141);
-	}
-}
-
 /*
  * Some cases use stdio, but want to flush after the write
  * to get error handling (and to get better interactive
-- 
2.10.0

