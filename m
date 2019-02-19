Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2267D1F453
	for <e@80x24.org>; Tue, 19 Feb 2019 00:06:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732251AbfBSAGH (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Feb 2019 19:06:07 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34770 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732206AbfBSAGF (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 18 Feb 2019 19:06:05 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:3dc7:72ec:75fa:fee5])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 6EB3961095;
        Tue, 19 Feb 2019 00:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1550534762;
        bh=hXIxm2OltYi/N9VgtHCQFReQEeiQbRf+hi6+lBEL08E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=DNsQ2y33RlT913Nqa1PLPjOIOOT6LRR54xvRXFp1+nqgysholQwkngRbiX2ALmdZr
         MXMIg3phvRDpnzXukRlRi+2WH81mwuVsX30QtviXDIxnTzzq9kwuy1uRuQRTTJWAsD
         7tiIOpUCDSA88fhVpYRbe0MKOyTfeHe0CNiaqT77MJzYethrfwNTr0829aj2JQalsX
         DmYaJts3sHV+wNCwB1R8iCcwtzCp0vS/YjbdqJvHKFH4PpUqyPG81lC+HplbIFdt+v
         c/SvMnu1mF8y9Gj2YPAf3YTzlOxVghF6B0PLg6bK7C24n/tF2u6ZtgD8GU5ggnSayz
         IJOoQBsMlbKulhdeBN7RAPQHr/TK5zMJDwrR9S2MW7qw3lgwg/2rK9Itbrz25GOMZP
         rEJkCle4RkmWQ/2cSE+832fq38dNDkBJawMSPE3Ua/YG+/OeEZVC6XLDmYXykQ2eyl
         stU7z5F2PZLyXyOc35VZ1utYQuJ5Nb9PidVcogrvJQTDMCCpH2n
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Jeff King <peff@peff.net>
Subject: [PATCH v2 22/35] http: replace hard-coded constant with the_hash_algo
Date:   Tue, 19 Feb 2019 00:05:13 +0000
Message-Id: <20190219000526.476553-23-sandals@crustytoothpaste.net>
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

Replace a hard-coded 40 with a reference to the_hash_algo.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 http.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/http.c b/http.c
index a09adc518f..993ddc956a 100644
--- a/http.c
+++ b/http.c
@@ -2065,7 +2065,7 @@ int http_fetch_ref(const char *base, struct ref *ref)
 	url = quote_ref_url(base, ref->name);
 	if (http_get_strbuf(url, &buffer, &options) == HTTP_OK) {
 		strbuf_rtrim(&buffer);
-		if (buffer.len == 40)
+		if (buffer.len == the_hash_algo->hexsz)
 			ret = get_oid_hex(buffer.buf, &ref->old_oid);
 		else if (starts_with(buffer.buf, "ref: ")) {
 			ref->symref = xstrdup(buffer.buf + 5);
