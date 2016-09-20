Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9659209AA
	for <e@80x24.org>; Tue, 20 Sep 2016 19:03:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932893AbcITTDB (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Sep 2016 15:03:01 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33471 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932536AbcITTCz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Sep 2016 15:02:55 -0400
Received: by mail-wm0-f65.google.com with SMTP id w84so4915782wmg.0
        for <git@vger.kernel.org>; Tue, 20 Sep 2016 12:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5kTb4YjkCpw07q7rKBuNx9Jk7hz9n1LPL+V5hcst7JQ=;
        b=gAq4yxj9aE0OmuGqT4IjSmd6ezGrENpv18XLHx4QZhcP+FuzYlhkymCd0Xo+zGjxKp
         UIX3v2I1Smbv8JQXPPj9wLiVKAqq/kp0BMOahv9NlX6PvHQ7Sr4Qci8zY5iqoaqEi477
         0xTM6zT0mIUqv/7e3U4fkfoqMcyeea+BkT1WMSaKyds3X1eNsaoKvv6ukyLmc2QPc66W
         HIoWKH2StZWsKIEybe3aTI/PQnOuXnCGfCv1B9HvWW6me7iQL6d3gdp23rADwOnWWjQQ
         KP52rsi69NMbkIwhLoXxlH6hfAlUTQ7PEtDYg0RLfOQLcmJL29cP+Vqai64FDd/NC92w
         B9dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5kTb4YjkCpw07q7rKBuNx9Jk7hz9n1LPL+V5hcst7JQ=;
        b=l0ZDA57FgIS8cXIy931zI7xwb0P3QOpV4TCca7SoUcHahwwLwtA6rrrJ0ifMTyOZkw
         N5IFOvjus/gKzU3eTjz3SnfnwLP34eYYxqfdnVx+Oyxfbjgv0od73xt+x/1UHnETwFts
         sAbnkkWGmCkkYOQPYH/2OsmmIpT45b35vqvD3R2zobLVKg6LiTGv5FHkVZJs52RsJD+j
         yLvn5IjuYm1S4TnxuJ+Wot3zJ/am6cL0nnIUBRvm2MG+SbtQmZPorHq6BUVZEykB1o77
         NP3jNvphiTXoZXbPgp+UmFo4Y6TPNDNEZL858HJMMNshZ2475Cyt/R8r/PzQFct0ae+M
         Wd0w==
X-Gm-Message-State: AE9vXwM96tDJYw1NKMoSdg+y8BpxHysDAgHGP8q1ct/xiPxo8CV5XHqsyi5UuSecYCO3qg==
X-Received: by 10.194.95.105 with SMTP id dj9mr30691895wjb.20.1474398174173;
        Tue, 20 Sep 2016 12:02:54 -0700 (PDT)
Received: from slxBook4.fritz.box (p508BA5EF.dip0.t-ipconnect.de. [80.139.165.239])
        by smtp.gmail.com with ESMTPSA id gg10sm29820728wjd.4.2016.09.20.12.02.53
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 20 Sep 2016 12:02:53 -0700 (PDT)
From:   larsxschneider@gmail.com
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com, sbeller@google.com,
        jnareb@gmail.com, mlbright@gmail.com, tboegi@web.de,
        ramsay@ramsayjones.plus.com,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v8 03/11] run-command: move check_pipe() from write_or_die to run_command
Date:   Tue, 20 Sep 2016 21:02:39 +0200
Message-Id: <20160920190247.82189-4-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20160920190247.82189-1-larsxschneider@gmail.com>
References: <20160920190247.82189-1-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

Move check_pipe() to run_command and make it public. This is necessary
to call the function from pkt-line in a subsequent patch.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 run-command.c  | 13 +++++++++++++
 run-command.h  |  2 ++
 write_or_die.c | 13 -------------
 3 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/run-command.c b/run-command.c
index 5a4dbb6..b72f6d1 100644
--- a/run-command.c
+++ b/run-command.c
@@ -6,6 +6,19 @@
 #include "thread-utils.h"
 #include "strbuf.h"
 
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
 void child_process_init(struct child_process *child)
 {
 	memset(child, 0, sizeof(*child));
diff --git a/run-command.h b/run-command.h
index 5066649..e7c5f71 100644
--- a/run-command.h
+++ b/run-command.h
@@ -54,6 +54,8 @@ int finish_command(struct child_process *);
 int finish_command_in_signal(struct child_process *);
 int run_command(struct child_process *);
 
+void check_pipe(int err);
+
 /*
  * Returns the path to the hook file, or NULL if the hook is missing
  * or disabled. Note that this points to static storage that will be
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

