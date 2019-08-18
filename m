Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 342A11F461
	for <e@80x24.org>; Sun, 18 Aug 2019 20:05:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbfHRUFp (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Aug 2019 16:05:45 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:57980 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727202AbfHRUFk (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 18 Aug 2019 16:05:40 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:81dd:eb9b:e758:604b])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id BD09860779;
        Sun, 18 Aug 2019 20:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1566158739;
        bh=7S/PkHZPrbgdRJuayj4IuVWHdhu73n6pBjf3qBu2fwM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=Vip71UHAX+fT0y70ucfHz7K9ZuhRHy6Q6vakWBajCtRsWzSMXTzzb2T2baj7pJEii
         76XH0mv0Bh8kNZu8aQzPM9bT/N/c1D/pQk2cl8xOf/W/Srjr64pPRbsmf0i7eIw1IM
         ZuizQm1ZRlJQfuDjmyCNUbQy3C1NxddwhtRGUddbZ8yInHBbPR0V2bnM0lW28AFtac
         Ezfv5HP7O70AfX6jP6+2xSzhl8m4qHWjfdLLACwKE/RPq+5uZlUAr7m6jFAi9Vu8qU
         YdbRz8dFPDq1sddEfK80YKHHwq/7Rsn9RtEdTJvxz8SfgQ11ZJHnK1IwKtAoe8ovOD
         kjA+cTjf8MuKIDgkBV1Mm9w2UjplIb7bb5+ZcIXIjYjgkrsKdLqqdp2itv7qhwLqU2
         MtQCdLwJ2NxBgXNRgXIX2zdgp4t+lM0g87DyCn9gM9prTD1NPhCSjyWNM2lQMcAbGY
         mkM+oXzIgapgo7IrjN6/UNm5336aUi2klbYjobmMi18UQ+TescR
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH 12/26] config: use the_hash_algo in abbrev comparison
Date:   Sun, 18 Aug 2019 20:04:13 +0000
Message-Id: <20190818200427.870753-13-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.23.0.rc1.170.gbd704faa3e
In-Reply-To: <20190818200427.870753-1-sandals@crustytoothpaste.net>
References: <20190818200427.870753-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Switch one use of a hard-coded 40 constant to use the_hash_algo.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 config.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/config.c b/config.c
index 3900e4947b..b0f79aab21 100644
--- a/config.c
+++ b/config.c
@@ -1204,7 +1204,7 @@ static int git_default_core_config(const char *var, const char *value, void *cb)
 			default_abbrev = -1;
 		else {
 			int abbrev = git_config_int(var, value);
-			if (abbrev < minimum_abbrev || abbrev > 40)
+			if (abbrev < minimum_abbrev || abbrev > the_hash_algo->hexsz)
 				return error(_("abbrev length out of range: %d"), abbrev);
 			default_abbrev = abbrev;
 		}
