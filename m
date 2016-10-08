Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DD8D207EC
	for <e@80x24.org>; Sat,  8 Oct 2016 11:26:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935089AbcJHLZ6 (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Oct 2016 07:25:58 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34635 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933642AbcJHLZs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Oct 2016 07:25:48 -0400
Received: by mail-wm0-f65.google.com with SMTP id b201so6642296wmb.1
        for <git@vger.kernel.org>; Sat, 08 Oct 2016 04:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1YH5rFNkAJVqpBg1vnfXJQcoHwbdoIBemdhUvYwhJOk=;
        b=wWhWtEGyWRODWediZUh5OTWJhVZdthYTF0fx7x+wfysn8vwi5US6s+tNDl/J/JQGEV
         DrFlqb+La6ppsdurFn6FoQnZ0MkPfo3CAxC+j1zIIW19lgFU3HtPtqXS/dmnh8hCc5gv
         wXfnXTcr3vg9FcRaEcYZmoJ+xlgDRdVdyviRzWHj47TUrQyT2jeI/je1baK9b8RQKpGj
         b4fs8BcfSqo9hOIitc/V3ss2timCE6T6j7kgS843Ieks21BOhV5V7Dqsx3IwLz1xmBbc
         RVWqmTw6VlEIsI2DeWcBEaC4O490OI0r7oZlHH95ExPg5mQjjHwjMq7QtA4GUNs0SOk8
         Sc8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1YH5rFNkAJVqpBg1vnfXJQcoHwbdoIBemdhUvYwhJOk=;
        b=eQi5gj6Vi8iSmeyJf+btaQf3zktrsQoO5pmteLw2V0fGlXyHExvHDRdplavrn/w5T0
         fNb4h5gUobPOKoJHrMwKxB7T4muiV5KrkRMmZPYDzXGHPMh8Sq2cpyRxUOTbmABiq8YQ
         5M+sW9CNy+dIfPol9TxZU4nSNq+igQ6LbDl01wMrnhZlV60kJbeT4rcHP/QjS/uIGywa
         Fxa69I2vETAjpnt5pXQm83jbL37dYAH7l4vJRYjrxZ+8XWryHf/1TM9SfROIPLZ8I40w
         ZHbqAxoJaKHIkdX1xcDmtnJW3DYgjK/s8j0w9cU52c8cYc7NQdOBfZeuN+M5uQIZb7xP
         nbWw==
X-Gm-Message-State: AA6/9RmubDrL9nXU3qKNuBhxCY6IFqoHkQFus8OLcUlVrSAeACe2NBRMKrgjEJQLF0vfng==
X-Received: by 10.28.93.18 with SMTP id r18mr2498511wmb.28.1475925947121;
        Sat, 08 Oct 2016 04:25:47 -0700 (PDT)
Received: from slxBook4.fritz.box (p5DDB73B1.dip0.t-ipconnect.de. [93.219.115.177])
        by smtp.gmail.com with ESMTPSA id a1sm24599623wju.41.2016.10.08.04.25.46
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sat, 08 Oct 2016 04:25:46 -0700 (PDT)
From:   larsxschneider@gmail.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, jnareb@gmail.com, peff@peff.net,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v10 11/14] convert: make apply_filter() adhere to standard Git error handling
Date:   Sat,  8 Oct 2016 13:25:27 +0200
Message-Id: <20161008112530.15506-12-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20161008112530.15506-1-larsxschneider@gmail.com>
References: <20161008112530.15506-1-larsxschneider@gmail.com>
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

