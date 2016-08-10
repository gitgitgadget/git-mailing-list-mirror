Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C1EE1FD99
	for <e@80x24.org>; Wed, 10 Aug 2016 19:46:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S938689AbcHJSq1 (ORCPT <rfc822;e@80x24.org>);
	Wed, 10 Aug 2016 14:46:27 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33969 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934485AbcHJSqY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Aug 2016 14:46:24 -0400
Received: by mail-wm0-f67.google.com with SMTP id q128so11280563wma.1
        for <git@vger.kernel.org>; Wed, 10 Aug 2016 11:46:23 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TNxdVfOZvAtLnIbl2Cw330mrMZxLQNrlEOxwcU7haWA=;
        b=GBcgPaCiHOiPZaclwpyUfPDw/Wq2s4Rz/b/PUrMvLGQe04Px5EBa/oxgeIt+YNuXV0
         5gGkauQxLOJPI2HlipvYyyJdqK4Rte1CxOXOsKlhQqayhYPInwOCnMx0lFNdbYiz9LF2
         KeWzgcm1yyyzA4wW4IWy4LGjTZjA84722bQjTmQNw92oJhmQ1ss8Z2yXTIUlQMqPlAzA
         ZSlunsrjZcQ1YSvKTCi5bJgjTVlDwf0HXnEV44/AsHvfXag4AKL6a4YS9IzB2xJS9M6j
         mBpH24MTCS8KRl4cduc0h2quGj3WmC+nF3Buyhd+kXZcGS0FTYGbU6o1+mFD6MXOwTgK
         +Umw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TNxdVfOZvAtLnIbl2Cw330mrMZxLQNrlEOxwcU7haWA=;
        b=cm7B7na3ocfNvL6aeG2l2VbEy2Tzu1gXCHFymC67Rpx2c2n0BCkNwclk2StfSHgcIL
         RG9Q6kVDQWXQxZostFPWLy+DzNt/5uOCcLx8eKhPyctHDnnNcQO1CCews+3ceWiStlY6
         pGdrrWWvhcOISjdLh8TBqxMhwwCxjHLWViJpkcwN57VAzG6mb5zZW8gs3LUZ59eDwOkI
         ynyiITvdDvpugy+0ZigMVPGwwl7Es+7yglkiygqnI3xzdm4HDtCE6QBEo852x7fb0r5a
         DNIj/W4+fiJzQJ8urm8zWTs58aOO9LjGeRsSd3GXerF0BQNS3W5cv7b1dgUFS3gaJ9iX
         HcdQ==
X-Gm-Message-State: AEkoouuRjib689ieeZ9zpO4Vy5yxATr306X8CJVBQjvAyUHWW+DPqxazdkHak/MjdXgi2Q==
X-Received: by 10.28.183.134 with SMTP id h128mr3289597wmf.7.1470834266471;
        Wed, 10 Aug 2016 06:04:26 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id p83sm8319899wma.18.2016.08.10.06.04.25
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 10 Aug 2016 06:04:26 -0700 (PDT)
From:	larsxschneider@gmail.com
To:	git@vger.kernel.org
Cc:	gitster@pobox.com, jnareb@gmail.com, mlbright@gmail.com,
	e@80x24.org, peff@peff.net, Johannes.Schindelin@gmx.de,
	ben@wijen.net, Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v5 13/15] convert: make apply_filter() adhere to standard Git error handling
Date:	Wed, 10 Aug 2016 15:04:09 +0200
Message-Id: <20160810130411.12419-14-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.9.2
In-Reply-To: <20160810130411.12419-1-larsxschneider@gmail.com>
References: <20160803164225.46355-1-larsxschneider@gmail.com/>
 <20160810130411.12419-1-larsxschneider@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

apply_filter() returns a boolean that tells the caller if it
"did convert or did not convert". The variable `ret` was used throughout
the function to track errors wheras `1` denoted success and `0` failure.
This is unusual for the Git source where `0` denotes success.

Rename the variable and flip its value to make the function easier
readable for Git developers.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 convert.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/convert.c b/convert.c
index 522e2c5..bd17340 100644
--- a/convert.c
+++ b/convert.c
@@ -436,7 +436,7 @@ static int apply_filter(const char *path, const char *src, size_t len, int fd,
 	 *
 	 * (child --> cmd) --> us
 	 */
-	int ret = 1;
+	int err = 0;
 	struct strbuf nbuf = STRBUF_INIT;
 	struct async async;
 	struct filter_params params;
@@ -463,22 +463,22 @@ static int apply_filter(const char *path, const char *src, size_t len, int fd,
 
 	if (strbuf_read(&nbuf, async.out, len) < 0) {
 		error("read from external filter '%s' failed", cmd);
-		ret = 0;
+		err = -1;
 	}
 	if (close(async.out)) {
 		error("read from external filter '%s' failed", cmd);
-		ret = 0;
+		err = -1;
 	}
 	if (finish_async(&async)) {
 		error("external filter '%s' failed", cmd);
-		ret = 0;
+		err = -1;
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
2.9.2

