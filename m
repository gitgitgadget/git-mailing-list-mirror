Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD6921F461
	for <e@80x24.org>; Sun, 18 Aug 2019 20:05:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727277AbfHRUF6 (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Aug 2019 16:05:58 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58054 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727254AbfHRUF4 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 18 Aug 2019 16:05:56 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:81dd:eb9b:e758:604b])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 05BD76075F;
        Sun, 18 Aug 2019 20:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1566158754;
        bh=UBPSEZIMddvV+aKB5l4VQIoEKh5xQWPR86YldcRf2kY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=CAf0a8jq51JDfnXWtbZrYlboR4LQemm1wJ9kJ1q0h8iN5DlSKr48sTH3jIXrhdtbL
         kOAiulsmkf9vbkjTr20wxzcUCQyLarp0s2cxpuqG/C9Ldu/qJdkvET7wQ91/BiGhp7
         4fhnJN8YJuk6GBImPCs0e2ILnashvVTRZN4ypwjW6d1v85fAmoMDBLpvhcdlyqa5E/
         XkVk0bOG5uhY9zkkGCcC3XOzDwsnITkrcU9qs1LtwNFHSvqFGDSAFH+gDk98+R2tTO
         Dhxf0nNN1QVpei1WUTdUu3lVp4Y8ABIUZcJ0uzVPyW5OS+SdwMSOufGo4WwpSbHg3u
         6tBH5Y8iI/AOj6yuKlYR/rn3CBS9sK+wwCHqKREHAloR8nKOSGNSQ4HxAKH+4EGUmr
         xpzB/rssRjJtKaHL5Bit5BVfjDQS143mvCIH6nxqP1R1Ti95MbaiPDqpSP3sl+o9a9
         n6uHgrUdst7OR1dmG12GKbiKWP9Q9P4LlJP91nVyQfT+QmEOULC
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH 25/26] builtin/show-index: replace sha1_to_hex
Date:   Sun, 18 Aug 2019 20:04:26 +0000
Message-Id: <20190818200427.870753-26-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.23.0.rc1.170.gbd704faa3e
In-Reply-To: <20190818200427.870753-1-sandals@crustytoothpaste.net>
References: <20190818200427.870753-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In this code path, we use sha1_to_hex to display the contents of a v1
pack index.  While we plan to switch to v3 indices for SHA-256, the v1
pack indices still function, so to support both algorithms, switch
sha1_to_hex to hash_to_hex.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/show-index.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/show-index.c b/builtin/show-index.c
index e95b84e8eb..0826f6a5a2 100644
--- a/builtin/show-index.c
+++ b/builtin/show-index.c
@@ -42,7 +42,7 @@ int cmd_show_index(int argc, const char **argv, const char *prefix)
 			if (fread(entry, 4 + hashsz, 1, stdin) != 1)
 				die("unable to read entry %u/%u", i, nr);
 			offset = ntohl(entry[0]);
-			printf("%u %s\n", offset, sha1_to_hex((void *)(entry+1)));
+			printf("%u %s\n", offset, hash_to_hex((void *)(entry+1)));
 		}
 	} else {
 		unsigned off64_nr = 0;
