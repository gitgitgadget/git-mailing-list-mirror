Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76CA8209A9
	for <e@80x24.org>; Sun, 16 Oct 2016 23:21:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757185AbcJPXVf (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Oct 2016 19:21:35 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36336 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757178AbcJPXVd (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Oct 2016 19:21:33 -0400
Received: by mail-pf0-f195.google.com with SMTP id r16so11508448pfg.3
        for <git@vger.kernel.org>; Sun, 16 Oct 2016 16:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1YH5rFNkAJVqpBg1vnfXJQcoHwbdoIBemdhUvYwhJOk=;
        b=USFg07OPqLJlyFfFrpog9qizl1tLqExOmYOa5fbN72nuudYxrv/Bj/fndaIE29PUCw
         ad3gyNRpH1du6MtEMmza9Hi/w++mJkCELlNeS/A7yhuj12lpP+pxI0JFnco4nLjV+Jgp
         M8MA7Ols4SWzCNo8U/O/e+itZvYY+/nMi19cG1BZapDd3u7lIFF3snykvMor3SC4JDd/
         pGPw7hSk+xPGEHdc8nTHKp1NqL4oQyX3XxSxw6D55Q/IvmgJA8o/Ko5Xup5tgcyEoXA3
         5syNov+bVi+JWOgrA81dLGWGF7ru5yNcHYYPG4etkCsGgWPjw/bqsACGk+CNpRB65LXs
         CPTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1YH5rFNkAJVqpBg1vnfXJQcoHwbdoIBemdhUvYwhJOk=;
        b=XwAlqrT9qNiBwjC2LbuJNnS9fEoGZpNnwf+hhwvdqRAEUNLbdPuh9m3m59girt53+r
         HBeuPFFVIlUcASelAfcUfS2zwVOAvjAeAGWF/LZxxujRj9aoz9KzcQQOzza8HQ2t5V/0
         oLENzVI4PFbN/oDxY4gFhPIi6WY1nsAcPuuDhibcaf0R/DPyGd3aCPs4UK75+O0GDANx
         A7xCjfHF5fasXBMHR37vaGmY5/6eGQyIh574jwphzkIVjVSR1axC12uVhxxT/pH1FugK
         KgGRPZbjaS5qBf2RfaWUbnHkCB+Odjsbo4oYQntMD1UDvEo9lKSmHD0yi5IBF0A8w968
         JUWg==
X-Gm-Message-State: AA6/9RnvkHZPMPTwYla+uq8Chamy/S8ig6ZPyIST+I1IveuWfi9MC5FXTnq+ZSr2kbJVtg==
X-Received: by 10.99.146.84 with SMTP id s20mr27890907pgn.9.1476660092950;
        Sun, 16 Oct 2016 16:21:32 -0700 (PDT)
Received: from rem3n8pj12.ads.autodesk.com (adsk-nat-ip4.autodesk.com. [132.188.71.4])
        by smtp.gmail.com with ESMTPSA id cp2sm10325691pad.3.2016.10.16.16.21.26
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 16 Oct 2016 16:21:29 -0700 (PDT)
From:   larsxschneider@gmail.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, jnareb@gmail.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, tboegi@web.de,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v11 11/14] convert: make apply_filter() adhere to standard Git error handling
Date:   Sun, 16 Oct 2016 16:20:35 -0700
Message-Id: <20161016232038.84951-12-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20161016232038.84951-1-larsxschneider@gmail.com>
References: <20161016232038.84951-1-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

apply_filter() returns a boolean that tells the caller if it
"did convert or did not convert". The variable `ret` was used throughout
the function to track errors whereas `1` denoted success and `0`
failure. This is unusual for the Git source where `0` denotes success.

Rename the variable and flip its value to make the function easier
readable for Git developers.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 convert.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/convert.c b/convert.c
index 986c239..597f561 100644
--- a/convert.c
+++ b/convert.c
@@ -451,7 +451,7 @@ static int apply_filter(const char *path, const char *src, size_t len, int fd,
 	 *
 	 * (child --> cmd) --> us
 	 */
-	int ret = 1;
+	int err = 0;
 	struct strbuf nbuf = STRBUF_INIT;
 	struct async async;
 	struct filter_params params;
@@ -477,23 +477,20 @@ static int apply_filter(const char *path, const char *src, size_t len, int fd,
 		return 0;	/* error was already reported */
 
 	if (strbuf_read(&nbuf, async.out, len) < 0) {
-		error("read from external filter '%s' failed", cmd);
-		ret = 0;
+		err = error("read from external filter '%s' failed", cmd);
 	}
 	if (close(async.out)) {
-		error("read from external filter '%s' failed", cmd);
-		ret = 0;
+		err = error("read from external filter '%s' failed", cmd);
 	}
 	if (finish_async(&async)) {
-		error("external filter '%s' failed", cmd);
-		ret = 0;
+		err = error("external filter '%s' failed", cmd);
 	}
 
-	if (ret) {
+	if (!err) {
 		strbuf_swap(dst, &nbuf);
 	}
 	strbuf_release(&nbuf);
-	return ret;
+	return !err;
 }
 
 static struct convert_driver {
-- 
2.10.0

