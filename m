Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50E481F461
	for <e@80x24.org>; Sun, 18 Aug 2019 20:05:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbfHRUFz (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Aug 2019 16:05:55 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58032 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727243AbfHRUFw (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 18 Aug 2019 16:05:52 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:81dd:eb9b:e758:604b])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 4D9D46075F;
        Sun, 18 Aug 2019 20:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1566158750;
        bh=Bv2j+DhOrV8jMrhKQZSvE4DWm519x+ybfy54s++TBu0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=AswC3TdERwF9uD9+UZZ38KkeKzEHAsOwJLBvexpLBkz+2g2VKxeRrhrhLEG71O/qo
         nyUUac/WkguGeyeSHFp4KhimiNkuHVwxl3C4gM1ilgwvRXEUf2nuBY5DV81H5k+xWh
         absPRUrfX0a5WjCIjtbRSvADXKH9UyVUDLZQxFvj4v3WNE2qO0he/PECTBsrPvbRwk
         LHBLlNXJ6YNCMYrNZgStaxarvMn0LRHVKRtRNYZvun71Viioo3rNxjZMKggSMNh6CG
         Dazv077xyueLKdOs7EkOvMWUQp/BzYB47tzncSSoSg10cQZFAR2TLu+A3BizS1f/xo
         MyMdGfzRcPg8VTUWfmXRvacNkUXm00zau/95CrjNsDBzUHhqyp8O6USIQeTEHwSFB4
         KkFDCYuTtNvw/z7q+3IoGRsaNXeomcgI9Qd4FFwI9xkz4guqmLnWW4DFNnSOUsuAlU
         o/BL0M9ccgYvG9IzRl+Mw2E+iA+6oBpqvBedcDLrjS5C8YCW42O
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH 21/26] packfile: replace sha1_to_hex
Date:   Sun, 18 Aug 2019 20:04:22 +0000
Message-Id: <20190818200427.870753-22-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.23.0.rc1.170.gbd704faa3e
In-Reply-To: <20190818200427.870753-1-sandals@crustytoothpaste.net>
References: <20190818200427.870753-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replace a use of sha1_to_hex with hash_to_hex so that this code works
with a hash algorithm other than SHA-1.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 packfile.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/packfile.c b/packfile.c
index fc43a6c52c..52dea88997 100644
--- a/packfile.c
+++ b/packfile.c
@@ -19,12 +19,12 @@
 #include "commit-graph.h"
 
 char *odb_pack_name(struct strbuf *buf,
-		    const unsigned char *sha1,
+		    const unsigned char *hash,
 		    const char *ext)
 {
 	strbuf_reset(buf);
 	strbuf_addf(buf, "%s/pack/pack-%s.%s", get_object_directory(),
-		    sha1_to_hex(sha1), ext);
+		    hash_to_hex(hash), ext);
 	return buf->buf;
 }
 
