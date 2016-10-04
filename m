Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 575CB20986
	for <e@80x24.org>; Tue,  4 Oct 2016 13:00:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754137AbcJDNAG (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 09:00:06 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36524 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754120AbcJDNAD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 09:00:03 -0400
Received: by mail-wm0-f67.google.com with SMTP id b184so19580358wma.3
        for <git@vger.kernel.org>; Tue, 04 Oct 2016 06:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1YH5rFNkAJVqpBg1vnfXJQcoHwbdoIBemdhUvYwhJOk=;
        b=G7lGA+Z16nnkt4RYUL2rt9WS8coO9pmTVIxBrZau8aUqvqzZhL5HRwsmzCsf8a3cbW
         0IbB/hs9ORJ/exRhPo5jP+G1MRG23T2PJhXo1Qo8zx5F2py8xLsXOzeqNH9yv+ZRbX3V
         NLDP460YtFu7eksDk11w8eFtH/fmRwrx13mwVA6BxGxNPWOGos4XhZ1DiX2lHDaegErd
         fyS1EZvLKNr3o/6xUSH2wJb+t5UR3P2vKL+ABLzQ7F7nZYai/M8DaNiJj8YQIxIbsSGE
         d/tfFRc/l9zXrZ4tmS9R12KyFiGprp4eibrIAIupGFlMYfk9KDUniQFYbhYpHvWD5mOp
         a8Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1YH5rFNkAJVqpBg1vnfXJQcoHwbdoIBemdhUvYwhJOk=;
        b=UNkQFP3lo2CYqF0k+uhBZeeWEtueHgHvUfACRDordLMQFZ9NNYDSd1DuUwQs3Ak1f9
         OHOxmCIwWtrKp4OgCg6hRNaFNg9LrjiKPZLcp93s0rsXTQPQSDX4C9CIBp+USjUPdJod
         qJadChPiFYPR0lm2AoTUSQd3AbDnm0mrzehjtoynofyNNi5JNzCO1/QpDtqanC8Un+06
         6BHUK/KPgJdqBFAmJAO57c58zz4WDmBJOBszwL04jugRP4Whc+fzI6YyD9QCgaogde3g
         XdHcAYvcZ4RvwY+tvMajxyO66sCR1DTrG031a0ymEks1/GIhHJKpLeUeRd4VZKEn5kPU
         bJig==
X-Gm-Message-State: AA6/9RlN5UWHVcWhpOSbJp7HDfq7x4MutaHc7JzgC4JbPZb+0VuZxr4AifoVZdeXUt2xag==
X-Received: by 10.194.235.69 with SMTP id uk5mr2857208wjc.162.1475586002459;
        Tue, 04 Oct 2016 06:00:02 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id qo8sm3426934wjc.46.2016.10.04.06.00.01
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 04 Oct 2016 06:00:02 -0700 (PDT)
From:   larsxschneider@gmail.com
To:     git@vger.kernel.org
Cc:     ramsay@ramsayjones.plus.com, jnareb@gmail.com, gitster@pobox.com,
        j6t@kdbg.org, tboegi@web.de, peff@peff.net, mlbright@gmail.com,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v9 11/14] convert: make apply_filter() adhere to standard Git error handling
Date:   Tue,  4 Oct 2016 14:59:44 +0200
Message-Id: <20161004125947.67104-12-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20161004125947.67104-1-larsxschneider@gmail.com>
References: <20161004125947.67104-1-larsxschneider@gmail.com>
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

