Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 904DF207EC
	for <e@80x24.org>; Sat,  8 Oct 2016 11:25:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935055AbcJHLZq (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Oct 2016 07:25:46 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35488 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932697AbcJHLZi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Oct 2016 07:25:38 -0400
Received: by mail-wm0-f68.google.com with SMTP id f193so6634368wmg.2
        for <git@vger.kernel.org>; Sat, 08 Oct 2016 04:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VZBwd1knIN4y/ZgFSGhdb3wJg5s/1XW1zziSiPgbFkc=;
        b=a3F2Q+jcfr676MhZFzBON6oP7SXYtjbiUhbDQy4uk5CxRfXos8Hvp1ojEPDIqS7ZDd
         RplTdNJLOxlsQ314OoBx8nug5KM/lQqFxk7ZqTrc6psr/T/R8QDn6eTM2VhHbGxaPjx0
         YJgJ1xXy4HajMzDmaVx1C2EkaeJpRnMgWFU2tksFaPDYB+2y1nyH1+GEU3WKvLHjnX49
         rjxy52BGERxEz6Fl2d3NB+xv2mpA3hsonlB4ogbmnoD+PcP6ldqbENqEDMZroDPGTxSi
         fNWR4TxmmWEqSNOH03ND7Xp0NHeDrIgXbTPGmmKH7BJ+wUbeX38l8fWpH+21jis5IQe0
         YCTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VZBwd1knIN4y/ZgFSGhdb3wJg5s/1XW1zziSiPgbFkc=;
        b=bO81X+moudw0wE9nLTL4O5t2DMdfsXZ2FrnwfydC0mFwTlfOY1qv9BaK9nn2sojdHQ
         ZGO34+jRa8bOPrXYCJGq6t7rT8NGD/7Ig0jvHOiRWM1FDBm1RscWtfduvVFfinpnLYPs
         IR/F1PTQuSLcoPEsQNyfK0RAiKMcZuAofviOeAKD/O5fktG7ofhLnk/gm28siQ8D01Ca
         WUrF5nBEHlE490lWHs7IjNPI/6UbId/b4OOlnYIswpD6bfauScD/ab5D96fGyYzq79I2
         SkFfpDL4Oxts/ghlOeiH36wBq2yR74rpSxOZO85s2vM5bn4NOok4EQlZG2e7SyZSDfDv
         vQZg==
X-Gm-Message-State: AA6/9Rl2lMvq/iBPrWKY7kHNQfGFroBJjOGfigU4dieJeia7Uv4dG6GAx6ziAf4yBcGs7g==
X-Received: by 10.28.184.199 with SMTP id i190mr2452514wmf.43.1475925937344;
        Sat, 08 Oct 2016 04:25:37 -0700 (PDT)
Received: from slxBook4.fritz.box (p5DDB73B1.dip0.t-ipconnect.de. [93.219.115.177])
        by smtp.gmail.com with ESMTPSA id a1sm24599623wju.41.2016.10.08.04.25.36
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sat, 08 Oct 2016 04:25:36 -0700 (PDT)
From:   larsxschneider@gmail.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, jnareb@gmail.com, peff@peff.net,
        Lars Schneider <larsxschneider@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v10 03/14] run-command: move check_pipe() from write_or_die to run_command
Date:   Sat,  8 Oct 2016 13:25:19 +0200
Message-Id: <20161008112530.15506-4-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20161008112530.15506-1-larsxschneider@gmail.com>
References: <20161008112530.15506-1-larsxschneider@gmail.com>
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

