Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE51420365
	for <e@80x24.org>; Thu, 13 Jul 2017 23:49:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752884AbdGMXth (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 19:49:37 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:59662 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752783AbdGMXtf (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 13 Jul 2017 19:49:35 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 178AF280AE;
        Thu, 13 Jul 2017 23:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1499989774;
        bh=YemzINMgvkIRF97oe25+IgIiZoB8Bp4vBGR61JGZChI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AgT/V6BALNz1D7zJDfG0eWW+9LyLZDPb4rKNy6WbLJRg4ilnFSfFH2MZCpMfNPXGA
         21xq+HSD1oZRO2hw9eYYrM5P66QcgPDhNTTa1GuP1zmj2veyiZM5LjQQ20iUwv9/j0
         17FRYKJ3R/rz1mZuEa4nX0GOYmH9bg8KLqRoIddhd98ltkFRLEAFimTQ4CsZAbxM3I
         0IgVW2LU4du0ZCZ2+RAqdAQsDaFxsKVY0bqC0KGrl76jcAu9vJKxzQeC4tNdbRet+7
         lhlBvmith1lUmk469KPkZCcDkamybL5c4oeH34bWjMBstFZxzA2bVy14/fzxPTVPzJ
         NOffNZNoC6tKKoV5+mig2P+YsFoqro+dgLCSPbsZAI2JXI2K0SfalnSJPx+83TJMAq
         kvcBINFE+OUCYGfaq7pOsauYJi7pSvdJptNObtNm+YaDEYze9mbktCkSpbUkIUjxgL
         S7HkSRpUL4i/wSB76GkHhXLBx/hNOv/Dx77Kq87VnruP6JnlC4U
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>
Subject: [PATCH v2 01/13] builtin/fsck: convert remaining caller of get_sha1 to object_id
Date:   Thu, 13 Jul 2017 23:49:18 +0000
Message-Id: <20170713234930.949612-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.13.2.932.g7449e964c
In-Reply-To: <20170713234930.949612-1-sandals@crustytoothpaste.net>
References: <20170713234930.949612-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/fsck.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 99dea7adf6..0e5a18e843 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -738,12 +738,12 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 	heads = 0;
 	for (i = 0; i < argc; i++) {
 		const char *arg = argv[i];
-		unsigned char sha1[20];
-		if (!get_sha1(arg, sha1)) {
-			struct object *obj = lookup_object(sha1);
+		struct object_id oid;
+		if (!get_oid(arg, &oid)) {
+			struct object *obj = lookup_object(oid.hash);
 
 			if (!obj || !(obj->flags & HAS_OBJ)) {
-				error("%s: object missing", sha1_to_hex(sha1));
+				error("%s: object missing", oid_to_hex(&oid));
 				errors_found |= ERROR_OBJECT;
 				continue;
 			}
