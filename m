Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44CB8209A9
	for <e@80x24.org>; Tue, 20 Sep 2016 19:03:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932975AbcITTDK (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Sep 2016 15:03:10 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34764 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932934AbcITTDE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Sep 2016 15:03:04 -0400
Received: by mail-wm0-f65.google.com with SMTP id l132so4895770wmf.1
        for <git@vger.kernel.org>; Tue, 20 Sep 2016 12:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=q6IDNkfZnJWbgYtec6ja1/ZL9grHbKifSk1xXmCbjPs=;
        b=MH3e4T5RkvqFuNdM+eObi/1BGZjCdq8wwVpMGRj3V7dQpcYy8vdc1LKITvtPqKe8s4
         gRfo0XbXKfVU/IPaf1XNP9ZLxqh/BBh6AkyB2o7eBuEZuckodnMlkXLNVjfmgdvSrZwn
         IDpOdeypbxkQjEYK4EoON1LfgTMM1EKFy32S1yoPPKtV54zdihjvFs26kL2ixd/i4+0G
         i5cr7H1x0Q3xLnvIh73MqISCkF29X8TLrCG09cWYjwlPHdCXfB3FGkasi88NUcForHCI
         57TpGql/j67t7HesnA4aOT4Z43t4txMXKlPe2Cy6wLbqUg2bMX7eoqIAS37vT66ILGKN
         scRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=q6IDNkfZnJWbgYtec6ja1/ZL9grHbKifSk1xXmCbjPs=;
        b=bL2kXNYzalzE89kWFxusEleqXBeYApo+1iKtDSAe+LX2wvE02I8BvJUx4q9Becejqx
         /udP3fJu7iuOjMsivm4gBFbZuWR2+uHJGG+JmggVItxIek9sXpVVh3Ccv4LsGvcyxO7/
         2Ep4+qxuwFXEDvwwcNSsMHVtIJ7z9rw8a8UVEFKgEEjuINcIsG3chTKkkgYPtcxuOW5A
         Hj8FazSyA+1cVcCX4OGcRLS5KUpnEXKT01DWMnkaWMJnETYHN5pK1GWbn/wqeXbvqYDX
         EZdbleNwl1A6P3Jqiw5OdkfX6oONBZTv40k8bbv9rwWXZ7DupTsyb4KMLQSkDfN0cdAJ
         TFvw==
X-Gm-Message-State: AE9vXwMrX5Hecfp/igxXl3XIQ1Bbosen9ifMliI0Zk1wvUBubMXuFWK/XNHrBXbe7v5qWw==
X-Received: by 10.28.199.3 with SMTP id x3mr5006057wmf.41.1474398182705;
        Tue, 20 Sep 2016 12:03:02 -0700 (PDT)
Received: from slxBook4.fritz.box (p508BA5EF.dip0.t-ipconnect.de. [80.139.165.239])
        by smtp.gmail.com with ESMTPSA id gg10sm29820728wjd.4.2016.09.20.12.03.01
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 20 Sep 2016 12:03:02 -0700 (PDT)
From:   larsxschneider@gmail.com
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com, sbeller@google.com,
        jnareb@gmail.com, mlbright@gmail.com, tboegi@web.de,
        ramsay@ramsayjones.plus.com,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v8 10/11] convert: make apply_filter() adhere to standard Git error handling
Date:   Tue, 20 Sep 2016 21:02:46 +0200
Message-Id: <20160920190247.82189-11-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20160920190247.82189-1-larsxschneider@gmail.com>
References: <20160920190247.82189-1-larsxschneider@gmail.com>
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

