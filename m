Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE1272027C
	for <e@80x24.org>; Thu,  1 Jun 2017 08:22:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751416AbdFAIWR (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 04:22:17 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34755 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751036AbdFAIWQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 04:22:16 -0400
Received: by mail-wm0-f68.google.com with SMTP id d127so9276929wmf.1
        for <git@vger.kernel.org>; Thu, 01 Jun 2017 01:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Wt1yXzvBDZTF875LA1ZYsO9BNDD0RMFsbpaVs6ce9sw=;
        b=UI2h2EGFhIT2TWdC/aTXZLREohrrzmVMnSuhfMXHEQTTLy9Bv3F6Y/+I4uXAZiIeSN
         2LHWuYz4MXP1jfdpPpJAGsEhCZ14tCrUXZ8odGKf0/fagKxXREw/RrJAi/vUOEJEnHCB
         hRjJ5k2lrMZHYxgiMuFk1l0zyukaij+DA6g1jTuJVz9UWTXqeUkkbpRfHQUIG0BVQUB8
         ToOkjwftveAIwcEMLQ1bXgRyEiw/BbVcHj6q/0j+XRMRWPsikQHilvWT8ZuVqK1XzlFV
         TcPdyw2y0dwtV14sHdSTSCuRMvrEiueBSXpYQoETzXZ45p4EmlPA8k/9G+g+Ip6qxHtd
         LZQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Wt1yXzvBDZTF875LA1ZYsO9BNDD0RMFsbpaVs6ce9sw=;
        b=S6DkF4GBV/p2YcZj2OiY4QnzdQ9uvxTt2mWxQwu0kQ8oKeUur0ouHeYFi3hO2DN5vO
         a2OW5keImuvCwWz4RV3csoWR03MLZeoff75S9tz82xnxbMl1bc8MIsnQvLbmdfcY+hCh
         oyZlCsx9W9LYKRcF9AQr39VaukhJ2/8v+WKYu6bLLJw4J6endNqtOrJFJDkZX3eB1KOv
         RWKoJ++7J26mtP19yvHOktnTh+VBGUNBf0sxXZ10u4XWH1TSq6pL+SouQh0JI5ctchdm
         EpQ5ZVE9o7XKXPIBkWD4XDyZ94/IC/e1X/2+jlmq7K56UyFBPvIw1q1ZRn6UsUMwgIGh
         cioQ==
X-Gm-Message-State: AODbwcDaAGN1Znb1/d87euudPU1+Ai8v6FOYRQMoB7FNUjMNZaSVguxN
        NH/vTfmsDvdN7MaC
X-Received: by 10.223.157.11 with SMTP id k11mr257539wre.71.1496305329697;
        Thu, 01 Jun 2017 01:22:09 -0700 (PDT)
Received: from slxBook4.fritz.box (p5DDB4864.dip0.t-ipconnect.de. [93.219.72.100])
        by smtp.gmail.com with ESMTPSA id 140sm15351595wmu.23.2017.06.01.01.22.08
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 01 Jun 2017 01:22:09 -0700 (PDT)
From:   Lars Schneider <larsxschneider@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, tboegi@web.de, e@80x24.org,
        ttaylorr@github.com, peartben@gmail.com
Subject: [PATCH v5 4/5] convert: move multiple file filter error handling to separate function
Date:   Thu,  1 Jun 2017 10:22:02 +0200
Message-Id: <20170601082203.50397-5-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170601082203.50397-1-larsxschneider@gmail.com>
References: <20170601082203.50397-1-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is useful for the subsequent patch 'convert: add "status=delayed" to
filter process protocol'.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 convert.c | 47 ++++++++++++++++++++++++++---------------------
 1 file changed, 26 insertions(+), 21 deletions(-)

diff --git a/convert.c b/convert.c
index f1e168bc30..a5e09bb0e8 100644
--- a/convert.c
+++ b/convert.c
@@ -565,6 +565,29 @@ static int start_multi_file_filter_fn(struct subprocess_entry *subprocess)
 	return err;
 }
 
+static void handle_filter_error(const struct strbuf *filter_status,
+				struct cmd2process *entry,
+				const unsigned int wanted_capability) {
+	if (!strcmp(filter_status->buf, "error")) {
+		/* The filter signaled a problem with the file. */
+	} else if (!strcmp(filter_status->buf, "abort") && wanted_capability) {
+		/*
+		 * The filter signaled a permanent problem. Don't try to filter
+		 * files with the same command for the lifetime of the current
+		 * Git process.
+		 */
+		 entry->supported_capabilities &= ~wanted_capability;
+	} else {
+		/*
+		 * Something went wrong with the protocol filter.
+		 * Force shutdown and restart if another blob requires filtering.
+		 */
+		error("external filter '%s' failed", entry->subprocess.cmd);
+		subprocess_stop(&subprocess_map, &entry->subprocess);
+		free(entry);
+	}
+}
+
 static int apply_multi_file_filter(const char *path, const char *src, size_t len,
 				   int fd, struct strbuf *dst, const char *cmd,
 				   const unsigned int wanted_capability)
@@ -656,28 +679,10 @@ static int apply_multi_file_filter(const char *path, const char *src, size_t len
 done:
 	sigchain_pop(SIGPIPE);
 
-	if (err) {
-		if (!strcmp(filter_status.buf, "error")) {
-			/* The filter signaled a problem with the file. */
-		} else if (!strcmp(filter_status.buf, "abort")) {
-			/*
-			 * The filter signaled a permanent problem. Don't try to filter
-			 * files with the same command for the lifetime of the current
-			 * Git process.
-			 */
-			 entry->supported_capabilities &= ~wanted_capability;
-		} else {
-			/*
-			 * Something went wrong with the protocol filter.
-			 * Force shutdown and restart if another blob requires filtering.
-			 */
-			error("external filter '%s' failed", cmd);
-			subprocess_stop(&subprocess_map, &entry->subprocess);
-			free(entry);
-		}
-	} else {
+	if (err)
+		handle_filter_error(&filter_status, entry, wanted_capability);
+	else
 		strbuf_swap(dst, &nbuf);
-	}
 	strbuf_release(&nbuf);
 	return !err;
 }
-- 
2.13.0

