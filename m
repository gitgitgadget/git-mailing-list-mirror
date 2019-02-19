Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E75611F453
	for <e@80x24.org>; Tue, 19 Feb 2019 00:06:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732298AbfBSAGR (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Feb 2019 19:06:17 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34854 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732253AbfBSAGO (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 18 Feb 2019 19:06:14 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:3dc7:72ec:75fa:fee5])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 784C260733;
        Tue, 19 Feb 2019 00:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1550534773;
        bh=R+M5dowM78UrTslSQWMskTM3dmdYk2a7spt8mNSWcP8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=QJKK2jhVAHhk1neDfg1OkMr4UA2R+g1cpWQebWRnTAl2qi8SmZnuUB8VOoR5rT5vo
         yyPqqGhmyRCDvO3Qgvyuk82QLel0TytlL2mx0FanfgCkCee8w2ta47cvbO6EP+heif
         5J842KPKkP+Oo67VL86ZzdMqHMM53UNoF7zBW9fsX54SpkCmJa7zKQ+62VaVG9e/9U
         rOcw7VcOROItikCshiDVDAwvRobNcAT91Y2JdpsQcjenls7KR+CvbPm5ZFv8xZq1Rn
         goKXHScO3CX/EZzrV//nWvLlgBJm7fBz3pD1rJvu3iBZD2C0uFABWNr9Z14PY3saHZ
         WzZiAyUk0g6te0nc9e4hcS9Z6QVrlkw9sZhrHkYzXhgwkFHE/w9IDSnolM2I19iW50
         LGS6aEbVkCvvTSAdvRAfGEnxI9c9hMn/6kbv3VAyHk4vjP7G8hPdHrMWXdNUWbpnv6
         GgCDgOukrZSJBzmX+AM74DzNltZrwOYmZHb3Kw2KmoEKVEWBRGK
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Jeff King <peff@peff.net>
Subject: [PATCH v2 30/35] refspec: make hash size independent
Date:   Tue, 19 Feb 2019 00:05:21 +0000
Message-Id: <20190219000526.476553-31-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e
In-Reply-To: <20190219000526.476553-1-sandals@crustytoothpaste.net>
References: <20190219000526.476553-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Switch a use of GIT_SHA1_HEXSZ to use the_hash_algo.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 refspec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/refspec.c b/refspec.c
index f529092fd6..9a9bf21934 100644
--- a/refspec.c
+++ b/refspec.c
@@ -72,7 +72,7 @@ static int parse_refspec(struct refspec_item *item, const char *refspec, int fet
 		/* LHS */
 		if (!*item->src)
 			; /* empty is ok; it means "HEAD" */
-		else if (llen == GIT_SHA1_HEXSZ && !get_oid_hex(item->src, &unused))
+		else if (llen == the_hash_algo->hexsz && !get_oid_hex(item->src, &unused))
 			item->exact_sha1 = 1; /* ok */
 		else if (!check_refname_format(item->src, flags))
 			; /* valid looking ref is ok */
