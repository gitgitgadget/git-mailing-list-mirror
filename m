Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE6021F461
	for <e@80x24.org>; Sun, 18 Aug 2019 20:06:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727294AbfHRUGF (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Aug 2019 16:06:05 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:57982 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727216AbfHRUFn (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 18 Aug 2019 16:05:43 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:81dd:eb9b:e758:604b])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id EDA1A6077D;
        Sun, 18 Aug 2019 20:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1566158740;
        bh=wfl+I7qThgqbD3cdDOYFbXiHvwN9eVb9CLY3GSwWeYk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=YEed2LbeoAVCHUuTR5lC4XDkRjkc7odccLKQLnfzrZUn8V842IGlEhjfsfy+JswsW
         3XlQtH56hyD1Fz0I8qedSVUQaGs8GZWIc1/towE8fabbTntQVfwx/9JKpDF8Jta9tv
         yWQJbEJ57Gs5zqVyVDtXezXH1o37V2m3n2uabLqKmyIwADPH6EqPyPk6Smv88f27EV
         fY33zEp6LdVWSe9bbjaac8p/37X5xhNctOXYCXVLTfRj+iPbIog4uCte1EKMe/a+ic
         NVQDtYzOSBaiW2lnbRAGffOz2vTCD/ajqCTHRmO1qKagiD+uf+BDKpQbQZDMDbFGqP
         FYT6sTrqqolC3kfUXAbaM1CwxQHzJ1phVE9xzj1FMqCbf/alZPjO4zZdFzSPLP6+Mf
         CSbqi0SOCeUJ6s/8oHPqoLz9QrJo/vqSQ3n9VOxYgZV0oFf1CV7mDGhWEv4y11gw+8
         nKnU87u0sfBDiMJ7ol0WcZU21GoP4U1MUSpu7m1SuE/dAk8C+3X
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH 13/26] sha1-lookup: switch hard-coded constants to the_hash_algo
Date:   Sun, 18 Aug 2019 20:04:14 +0000
Message-Id: <20190818200427.870753-14-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.23.0.rc1.170.gbd704faa3e
In-Reply-To: <20190818200427.870753-1-sandals@crustytoothpaste.net>
References: <20190818200427.870753-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Switch a hard-coded 18 to be a reference to the_hash_algo.  Rename the
sha1 parameter to be called hash instead.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 sha1-lookup.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sha1-lookup.c b/sha1-lookup.c
index 796ab68da8..93d9af0805 100644
--- a/sha1-lookup.c
+++ b/sha1-lookup.c
@@ -50,7 +50,7 @@ static uint32_t take2(const unsigned char *sha1)
  * The sha1 of element i (between 0 and nr - 1) should be returned
  * by "fn(i, table)".
  */
-int sha1_pos(const unsigned char *sha1, void *table, size_t nr,
+int sha1_pos(const unsigned char *hash, void *table, size_t nr,
 	     sha1_access_fn fn)
 {
 	size_t hi = nr;
@@ -63,10 +63,10 @@ int sha1_pos(const unsigned char *sha1, void *table, size_t nr,
 	if (nr != 1) {
 		size_t lov, hiv, miv, ofs;
 
-		for (ofs = 0; ofs < 18; ofs += 2) {
+		for (ofs = 0; ofs < the_hash_algo->rawsz - 2; ofs += 2) {
 			lov = take2(fn(0, table) + ofs);
 			hiv = take2(fn(nr - 1, table) + ofs);
-			miv = take2(sha1 + ofs);
+			miv = take2(hash + ofs);
 			if (miv < lov)
 				return -1;
 			if (hiv < miv)
@@ -88,7 +88,7 @@ int sha1_pos(const unsigned char *sha1, void *table, size_t nr,
 
 	do {
 		int cmp;
-		cmp = hashcmp(fn(mi, table), sha1);
+		cmp = hashcmp(fn(mi, table), hash);
 		if (!cmp)
 			return mi;
 		if (cmp > 0)
