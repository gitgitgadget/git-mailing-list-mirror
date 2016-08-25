Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E469D1FD99
	for <e@80x24.org>; Thu, 25 Aug 2016 11:20:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754968AbcHYLU0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Aug 2016 07:20:26 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33417 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753920AbcHYLUY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2016 07:20:24 -0400
Received: by mail-wm0-f68.google.com with SMTP id o80so6954507wme.0
        for <git@vger.kernel.org>; Thu, 25 Aug 2016 04:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ISk2ZuBWDToELp2IJ/Tn7S1VdcU2TIlM4jzRH4ZQh7I=;
        b=fKyRNkd2SCF2cMMpgn1FF0CtoWDLlpLNgabV0pxn0T+QIWxm80AoCd2VEIraeBQ/x3
         DSpHsXZmzl5CRLnkCj2RU3SI4aXSlhuRgVpHIsX9PbtF/1VFZe7nVnjZEKQ4uXZWL8cH
         RDq5G34vEQNiYf3wuk4rylgHQDgbZJtxV+7sKt12iiNNXZCB+BAQBiDL7XalTocb4lHp
         f8lr92YOHA4wvV9yFlfu763EmzMQY8YgFgiGSOe2aIuHHxcY2THsHxh7uu+3xklEifdp
         68xUv33+AdFoh1zzQFwLiJj5oAYOVOVv/Slxp8euPmCpHufR8sPx3b6e8WoZiqgdgEKE
         gKcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ISk2ZuBWDToELp2IJ/Tn7S1VdcU2TIlM4jzRH4ZQh7I=;
        b=T29pYpMB8DO7uN+iTfXog7/V+twNED4oR4CJFk1EjKSPvU2KAOVKaBl28kXISm6Voc
         LktVI7y486opaXPc2ecnFNFbfaQU/dwRANnJBh5angDU16qQInu4ohc1+f84ge5tR3W1
         f+oN19XMmetNL8VkMcxrnUICC7q7VKEeNdqVtYO9qvNl3VLej4YJC+7GS4SFSW+Uf9Sb
         v9trSDeS1jJEUzYjWekQEyVuiZDdYmydBa+qAd0F4rhBf7PNIhPFTktaD01bia2ZDed4
         y48NjjIWul/HIVMR4g2U24I2X5pJkEk7heQ2Zv/cRHSKeGyh4YQ6ov3qlxy6r6dglb8l
         CQkQ==
X-Gm-Message-State: AEkoouvuGeMavLFY/tMGXr6TBZgn7otmKgcPdOi1l8abFPLWIEZFdXwR4Civh1QuUswwcw==
X-Received: by 10.194.148.232 with SMTP id tv8mr6942787wjb.113.1472123292321;
        Thu, 25 Aug 2016 04:08:12 -0700 (PDT)
Received: from bcnf9f9l32.ads.autodesk.com (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id p71sm38304839wmf.9.2016.08.25.04.08.11
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 25 Aug 2016 04:08:11 -0700 (PDT)
From:   larsxschneider@gmail.com
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com, sbeller@google.com,
        Johannes.Schindelin@gmx.de, jnareb@gmail.com, mlbright@gmail.com,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v6 11/13] convert: make apply_filter() adhere to standard Git error handling
Date:   Thu, 25 Aug 2016 13:07:50 +0200
Message-Id: <20160825110752.31581-12-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.9.2
In-Reply-To: <20160825110752.31581-1-larsxschneider@gmail.com>
References: <20160825110752.31581-1-larsxschneider@gmail.com>
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

