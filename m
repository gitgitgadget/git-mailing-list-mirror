Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84D821F62D
	for <e@80x24.org>; Sun,  8 Jul 2018 23:37:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932910AbeGHXgw (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Jul 2018 19:36:52 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:54294 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932799AbeGHXgv (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 8 Jul 2018 19:36:51 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:5996:38d5:9b31:ef84])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 3D3F160746;
        Sun,  8 Jul 2018 23:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1531093010;
        bh=+xykSABiTsB/yGB6lP+eDwfiX1/awpZNsIUwB4X1jng=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=F0ijGjQVyrnW1le5NPJV32ydt5LwVrGi9a3e5O1/4IICpfrHbq897yUGdHPN0+IWK
         qwxWd0YlBbCrX3DRuYWWZv7GthTZCa0An/EGFW1IZ+dW+AgJaiiOKvqP0X1dswVfpa
         24DBKVTzzA7UF5Wem6OSr1mGD5taowgGcVOQWZfAtf+A4gSECAiPZsU0mN0oLjiDuv
         i/8Ez5gqCJm2tALrR3qNilj/22z7Qzr35HWRv0ZDroCWFaVCMiVLXZS9jXZOpU8yy1
         xPSxuiYGqTCdMU5JOg/4JcBgLtev1g148DGvJ5gCt0MhLsZV5YsvytqJ4Lu+5xNanj
         csJZgacHreAVs9WvrPbkVgN0s7Nv0oLBD3ETvPv1/RlpCjIDtlanKyLvKMCLT/Dm3l
         ABcTHM3+Tb5OrRk4oz/VQDtCSsXQFyAu57Hy1SEN/ZTFzBivY+/6MotED+otPxCcLs
         zKex4RQYDH6V2wlVwDbxi1gYx9TGOtNdd6YJH/pGAfGL0xg3KOD
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 02/17] tree-walk: replace hard-coded constants with the_hash_algo
Date:   Sun,  8 Jul 2018 23:36:23 +0000
Message-Id: <20180708233638.520172-3-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.18.0.399.gad0ab374a1
In-Reply-To: <20180708233638.520172-1-sandals@crustytoothpaste.net>
References: <20180708233638.520172-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the hard-coded 20-based values and replace them with uses of
the_hash_algo.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 tree-walk.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tree-walk.c b/tree-walk.c
index 8f5090862b..c1f27086a9 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -26,8 +26,9 @@ static int decode_tree_entry(struct tree_desc *desc, const char *buf, unsigned l
 {
 	const char *path;
 	unsigned int mode, len;
+	const unsigned hashsz = the_hash_algo->rawsz;
 
-	if (size < 23 || buf[size - 21]) {
+	if (size < hashsz + 3 || buf[size - (hashsz + 1)]) {
 		strbuf_addstr(err, _("too-short tree object"));
 		return -1;
 	}
