Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32AC2202AB
	for <e@80x24.org>; Fri, 30 Jun 2017 20:41:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752845AbdF3Ulj (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Jun 2017 16:41:39 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34529 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752840AbdF3Ulh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2017 16:41:37 -0400
Received: by mail-wr0-f194.google.com with SMTP id k67so39893952wrc.1
        for <git@vger.kernel.org>; Fri, 30 Jun 2017 13:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eVoG8bat0IXNG/PXiGhVyTf19MbcLYxpEfxhDvCZAZg=;
        b=sbkQxBrf+4hPLOSDwtY7xko4Kd2h0XK/yYpHvVhPmiC5uORbrfXIKSQ/jjtpnSLpJH
         q0bU4bg0EjhDN3kan1Rnm9J1iYJDMCsklzbQ8nqOYQTaVM5kZve3e6MLXQYZ5kQNWQvf
         n0hvOkPcEdjVvJkeaxCs1DxaVYLQJ/J7ZZWpDBDUzn9YwBgniTG7HIN87ODX1OFIw/Be
         uXNIGVWWhu/BgiRxX2MepoynkKqeylIDYAIOcrJIJNXuKOezjPSP5cDNn2zLEVEAaQ06
         q4nD7tQ0hAeNNS0S/YOVAs6aaEjVtleaCAOTMNGPTAlUgmgDK7JN71frsi0gKIe8GtB/
         lZEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eVoG8bat0IXNG/PXiGhVyTf19MbcLYxpEfxhDvCZAZg=;
        b=D+JUEBooB/6hDqmcfnnP4K2E1E28s4vcVkx8WBXaDjMK9F2RHzGkpD7iQUsPPDd+Ip
         mIrn76xqaOJJFe30MhkoC7cVA6NRlNmIyHsJn+baOwz7M20Rt5f7ocjUHR6NtQlNjdr9
         mGqyMUIVo+XbDyQWcgaeAOndbVBwNnON2uLkjF41CNip6CEqZZhm0+Z9M2m2rOsrFXg+
         1pGe5KxLMwmIhpNXWPqVyg2fSSobMxUWGU8M9/PYvCtVi9pnsXOtyZKDp7WwIlzlYxOk
         Rg0wzeQyklyxtkWWuWGCVjEA+De18XEbgKqHVZFz3/YpsPNoAO5l3bnWRwseQkuJOAAn
         xxyA==
X-Gm-Message-State: AKS2vOxq5yozOclTcwnuswvQ8iK9I6uA6fmJ+WlgplaiGEHDJcF/VuX0
        1TpJvXuRRlh+FDab
X-Received: by 10.223.148.37 with SMTP id 34mr25080776wrq.137.1498855296067;
        Fri, 30 Jun 2017 13:41:36 -0700 (PDT)
Received: from slxBook4.fritz.box (p5DDB4C89.dip0.t-ipconnect.de. [93.219.76.137])
        by smtp.gmail.com with ESMTPSA id v144sm10648239wmv.27.2017.06.30.13.41.35
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 30 Jun 2017 13:41:35 -0700 (PDT)
From:   Lars Schneider <larsxschneider@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, tboegi@web.de, e@80x24.org,
        ttaylorr@github.com, peartben@gmail.com
Subject: [PATCH v9 5/7] convert: move multiple file filter error handling to separate function
Date:   Fri, 30 Jun 2017 22:41:26 +0200
Message-Id: <20170630204128.48708-6-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.13.2
In-Reply-To: <20170630204128.48708-1-larsxschneider@gmail.com>
References: <20170630204128.48708-1-larsxschneider@gmail.com>
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

