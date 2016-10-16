Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 817A02098B
	for <e@80x24.org>; Sun, 16 Oct 2016 23:20:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756462AbcJPXU4 (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Oct 2016 19:20:56 -0400
Received: from mail-pa0-f67.google.com ([209.85.220.67]:33453 "EHLO
        mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756268AbcJPXUy (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Oct 2016 19:20:54 -0400
Received: by mail-pa0-f67.google.com with SMTP id hh10so8539619pac.0
        for <git@vger.kernel.org>; Sun, 16 Oct 2016 16:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VZBwd1knIN4y/ZgFSGhdb3wJg5s/1XW1zziSiPgbFkc=;
        b=LVDkNEpl8pXy2hUPJq53BAnryTLndVa4tfKfanXfWn3vw8nSZSYOzbB/iNwH5mNq94
         Qit47XBVoBnuAl005Sh6ECP26fnBSzdBy2QSuc8F88vH7q7b2jOCCRtsQ3cx8ZfAyP7I
         /NNpdD6kcbZFFqutYabX7CExqzSoWLwH8GbNyrBCxHlhrEeYyNgSZWkjxt5zKxpvlghb
         yRUJPYfxQCpJNPtV1hkX9VPLVviT1E13QcD0wJ+sRCdVKo4YuS9xdsXDgkqf0gDMuci+
         hgqp13DieqAsZPPQg++9kySdbLsKxPfceGhVh2WdAZuW9kYoqqy2Z/ZXe3un/XyZReTc
         Csqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VZBwd1knIN4y/ZgFSGhdb3wJg5s/1XW1zziSiPgbFkc=;
        b=bb7KuIugpmpGmpWmT+Jw9ZcevlRkB5vCjCkY6Flm6Fh5YRxYXDgYOU+ezixzrnNXxY
         YMT6iVBxN6QicnVfWu1d+ZANTDTnuBFxlW0tWpK4cVmvodngkrjpR9qhLG9XdscrO7Ll
         tZlOR4uM91hAmRqtLmB/TzDCuVMdCO5E8yxIdp7kgIa5BwZjMa82QB9iS+4QE9fJ8dKk
         mMXkGRhzjDF8CMVOhUM2T3YP9YHrcJCRVgOXZb+liBLlq8Doj44MHRl33X8n3hLA4dbd
         +w9KsO+Y75mKi6mEEqSLSSVkNNPfi0uxOyZm9oQ/T3i1ODFaZIl7IT1KjY8ud7tdCSIJ
         1jfg==
X-Gm-Message-State: AA6/9Rksq/BnDnfH6KUBDPZsHXFjBCyjJOjqwI/UfZxkDyRwYBdV2SukDAhjrNKUpPaLeQ==
X-Received: by 10.66.89.4 with SMTP id bk4mr28038161pab.22.1476660053475;
        Sun, 16 Oct 2016 16:20:53 -0700 (PDT)
Received: from rem3n8pj12.ads.autodesk.com (adsk-nat-ip4.autodesk.com. [132.188.71.4])
        by smtp.gmail.com with ESMTPSA id cp2sm10325691pad.3.2016.10.16.16.20.46
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 16 Oct 2016 16:20:48 -0700 (PDT)
From:   larsxschneider@gmail.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, jnareb@gmail.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, tboegi@web.de,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v11 03/14] run-command: move check_pipe() from write_or_die to run_command
Date:   Sun, 16 Oct 2016 16:20:27 -0700
Message-Id: <20161016232038.84951-4-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20161016232038.84951-1-larsxschneider@gmail.com>
References: <20161016232038.84951-1-larsxschneider@gmail.com>
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

