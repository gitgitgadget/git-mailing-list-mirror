Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 748042023D
	for <e@80x24.org>; Wed, 28 Jun 2017 21:30:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751945AbdF1VaL (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Jun 2017 17:30:11 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35013 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751559AbdF1VaI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jun 2017 17:30:08 -0400
Received: by mail-wm0-f66.google.com with SMTP id 131so13756383wmq.2
        for <git@vger.kernel.org>; Wed, 28 Jun 2017 14:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eVoG8bat0IXNG/PXiGhVyTf19MbcLYxpEfxhDvCZAZg=;
        b=CvDGL1e7w3wxJf/BR6DRV95hcdN9+0zhcXOw8L7r7tP/S2HQUKX09WdTDkabgDQfbM
         WfXJtdt9Dh0QpGz+VotaF15VJrTKwvkMVrtRF5YGvR3MPGPFle7Nzw6aRzCQNnw494sV
         n2dPnLuIkU1pv3PzbeekJgA5ocrqXWSz+lGId6dJQxEsUTs3FJnaVsC/KHvIIlb3lNux
         36/KCeENApzMCaNLiLcZEfkr2NOcAfsfU1QmpkcT5R5KrQv2P59tNKrudfNjBa7Mf+je
         muk3zwkrm/faUXscAPzwB0V10o/svKVe2B+b5qY/yWrw6P96x+QDRYnt+jU4qEhApREf
         osVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eVoG8bat0IXNG/PXiGhVyTf19MbcLYxpEfxhDvCZAZg=;
        b=SXMDgIUuRNzRGsfutdQYzSPgCnvM2YihSid3J2PwB5FZ4wxvkyyeLBx/odA7CUd3R8
         M9ui+GlqsrAexDUzMmZ+DBCnAAO1gV+cE0JmzOwMmUaP2MS/+KbW/7kYL8KlZorhsO1/
         OEy6kB314fjVneEyl61Rkjt20xeEw5kAeQ0jbkuuijy/EkhrSzHCPhRcqCw+XJgEbHCL
         bS4zkIC/MQok/e+FyUpIjRbQcZ4Tyzt8zIe10S5Vk2ky2yh0NnAeNTU8wNTk47J0yM7U
         f7IjISDuZo4GEgnb0vbicu1oXi26ZSclfAoHgnB4uO9LH1eT3KuxWYuTZswE4ssdBYzg
         vf3g==
X-Gm-Message-State: AKS2vOwrNXIsHMLrlJroPdPOJNigxqNg2ZmVC55dixxBx8w4gIQhFnpS
        SOD8lTf/3Zc0EkYl
X-Received: by 10.28.191.134 with SMTP id o6mr9344637wmi.11.1498685401640;
        Wed, 28 Jun 2017 14:30:01 -0700 (PDT)
Received: from ccsh0hfn32.ads.autodesk.com (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id l20sm2581036wre.25.2017.06.28.14.30.00
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 28 Jun 2017 14:30:01 -0700 (PDT)
From:   Lars Schneider <larsxschneider@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, tboegi@web.de, e@80x24.org,
        ttaylorr@github.com, peartben@gmail.com
Subject: [PATCH v8 5/6] convert: move multiple file filter error handling to separate function
Date:   Wed, 28 Jun 2017 23:29:51 +0200
Message-Id: <20170628212952.60781-6-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.13.2
In-Reply-To: <20170628212952.60781-1-larsxschneider@gmail.com>
References: <20170628212952.60781-1-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactoring the filter error handling is useful for the subsequent patch
'convert: add "status=delayed" to filter process protocol'.

In addition, replace the parentheses around the empty "if" block with a
single semicolon to adhere to the Git style guide.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 convert.c | 47 ++++++++++++++++++++++++++---------------------
 1 file changed, 26 insertions(+), 21 deletions(-)

diff --git a/convert.c b/convert.c
index 9907e3b9ba..e55c034d86 100644
--- a/convert.c
+++ b/convert.c
@@ -565,6 +565,29 @@ static int start_multi_file_filter_fn(struct subprocess_entry *subprocess)
 	return err;
 }
 
+static void handle_filter_error(const struct strbuf *filter_status,
+				struct cmd2process *entry,
+				const unsigned int wanted_capability) {
+	if (!strcmp(filter_status->buf, "error"))
+		; /* The filter signaled a problem with the file. */
+	else if (!strcmp(filter_status->buf, "abort") && wanted_capability) {
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
2.13.2

