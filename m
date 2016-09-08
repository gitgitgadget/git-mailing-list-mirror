Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2B152070F
	for <e@80x24.org>; Thu,  8 Sep 2016 18:22:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759360AbcIHSWH (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Sep 2016 14:22:07 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34020 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758565AbcIHSVv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2016 14:21:51 -0400
Received: by mail-wm0-f65.google.com with SMTP id w12so9036720wmf.1
        for <git@vger.kernel.org>; Thu, 08 Sep 2016 11:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XCrpJc+GNW+S0Umabdi78hZFrFHigS6202UbAthM1Cg=;
        b=jTUyOxe1AbIBM3gMbw1pZmHsBeeKaT/m46MjDBlsOrdofAybYnA/oqB6fD5UMYzavo
         sJoH8iF9TkV7wv0OqTX5hLN/0+1PqbAsL8I05LdIaZ1DhYcLQn2Cr9BubMVMuNfEiz6H
         bdX4B6YiH5oXq9towcBo58iApd+DXq8zQejW95FbnGZtRPw3CRw4gu58gAp5r3ajQLHi
         kU7GxAulRGO+63sapYWG2Ou2o3OoDmpnGoexiTQxrmnTIueWPWai7UvAvjRujQDAeaPf
         2vTqeHanFcf63uXlMDWCDRsLnItC6kRCbwPRNodKfsnUDspV+30ULWo5Em6WSDHY/Ntk
         YEMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XCrpJc+GNW+S0Umabdi78hZFrFHigS6202UbAthM1Cg=;
        b=V4XiGlhwsT3cl4HOIe2f6UpfQWMgPub+sbsGMqocxPXVaFG0B0BO+sc0THoJjnGBdk
         lYuz7zff0O1Z5PecqO4DXrT2d3OlvJ6Qw85fKzTl1LjovIWB7L73qs7FqSN70/g/ZMPP
         UOQT/qtoXZZgBAE86HFXwqE++FwTUFYQPWVzgzxXMS7thQHYzuNL0mMjfAFORI2nXiYQ
         XdoyTY+R0w0D7QPhw/1jUJ73Ty0ItJ08I2Uv3H8dkiJI8DbIHJcqWZK/xi8tLBkY+LJo
         A7dIXR3rV69kJ/WvPT6zfpkAZiZ61WDhGp7GYcMbf+NNrCROcxqjEZezoYdLfDO/TOHV
         akbg==
X-Gm-Message-State: AE9vXwOnYzWwK0pSczxF8nHm/pG4U/GNyFzkiEmRMy4qGznun2/PBKeByORY0s5Mh1JDgA==
X-Received: by 10.28.156.144 with SMTP id f138mr1687826wme.86.1473358910438;
        Thu, 08 Sep 2016 11:21:50 -0700 (PDT)
Received: from slxBook4.local.com (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id b128sm10967467wmb.21.2016.09.08.11.21.49
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 08 Sep 2016 11:21:49 -0700 (PDT)
From:   larsxschneider@gmail.com
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com, sbeller@google.com,
        Johannes.Schindelin@gmx.de, jnareb@gmail.com, mlbright@gmail.com,
        tboegi@web.de, jacob.keller@gmail.com,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v7 09/10] convert: make apply_filter() adhere to standard Git error handling
Date:   Thu,  8 Sep 2016 20:21:31 +0200
Message-Id: <20160908182132.50788-10-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20160908182132.50788-1-larsxschneider@gmail.com>
References: <20160908182132.50788-1-larsxschneider@gmail.com>
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
index 986c239..a068df7 100644
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
@@ -478,22 +478,22 @@ static int apply_filter(const char *path, const char *src, size_t len, int fd,
 
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
2.10.0

