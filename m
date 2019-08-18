Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E8421F461
	for <e@80x24.org>; Sun, 18 Aug 2019 20:05:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbfHRUFz (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Aug 2019 16:05:55 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58038 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727254AbfHRUFx (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 18 Aug 2019 16:05:53 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:81dd:eb9b:e758:604b])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 86FD86074A;
        Sun, 18 Aug 2019 20:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1566158751;
        bh=zgkmA4/Tx4lCIa/TrgtfzOsoeqLEKUBzzbJKm9L5UWQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=f/hgJzJttfr3Ezw9WgUX7T6zncEshNYDgSSnRkRsg9lDS3M31OvTk8BkHgDuBxkst
         qN40uYNvyf4uxwDap9ZFUzdoiLMYuCrPfo/3DvupJg4vcAkTT5aLIUOXYsA4lcq1nn
         NzaYx5sC7TmwhPCbEfTMdcBShVIe64No7U1WmWO6XD1mjjtT0n8bdhWhDrpmHJXgTy
         jwOR5RMxwnGq8RIpBQ8jyJ4aBEtnFbWvjWjHn25iMQRF1ZfI+IglpgKS2FUpPeGEtm
         mIOsVxfksnqvkkxl5fmDRrE8fKaV+4qupeZXPSL5CooidO2sVFlrG/FPt/RIWXma2y
         1LD644dtoT3aBSGWVyg4ZJePOLIzPVB3/7vgCrbn1FVoOsiDHl0JNaleGb6Ja4rKI3
         0y0xhnj6SR4bOJQ8Wp4IgY41eium8B+ToTDVJGEkLnH9NBIVuiyWAadxJ3wWtz8GHV
         zefOP0uYHAjYiLOTbuq8YLdoL/gbyWNMiKknUQA0g2x1p6NiPvx
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH 22/26] builtin/index-pack: replace sha1_to_hex
Date:   Sun, 18 Aug 2019 20:04:23 +0000
Message-Id: <20190818200427.870753-23-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.23.0.rc1.170.gbd704faa3e
In-Reply-To: <20190818200427.870753-1-sandals@crustytoothpaste.net>
References: <20190818200427.870753-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since sha1_to_hex is limited to SHA-1, replace it with hash_to_hex so
this code works with other algorithms.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/index-pack.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 0d55f73b0b..2abd550ce2 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1490,11 +1490,11 @@ static void final(const char *final_pack_name, const char *curr_pack_name,
 	}
 
 	if (!from_stdin) {
-		printf("%s\n", sha1_to_hex(hash));
+		printf("%s\n", hash_to_hex(hash));
 	} else {
 		struct strbuf buf = STRBUF_INIT;
 
-		strbuf_addf(&buf, "%s\t%s\n", report, sha1_to_hex(hash));
+		strbuf_addf(&buf, "%s\t%s\n", report, hash_to_hex(hash));
 		write_or_die(1, buf.buf, buf.len);
 		strbuf_release(&buf);
 
