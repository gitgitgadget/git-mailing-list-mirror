Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04E1E1F62D
	for <e@80x24.org>; Sun,  8 Jul 2018 23:37:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933274AbeGHXhG (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Jul 2018 19:37:06 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:54388 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933155AbeGHXhE (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 8 Jul 2018 19:37:04 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:5996:38d5:9b31:ef84])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 5E2426047B;
        Sun,  8 Jul 2018 23:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1531093023;
        bh=PhmtJjPV3BiFdxUT158dARGTTj2zSWVsO488SrMQCQI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=OZmpPIsidZuFcaOmvpxo97cfL3Uysv/8gI4WzR/m5TtdvKJFCfq7FXG6XCr2BIHBn
         QAcpztnJ1Vd7AGsJ/IJoPweb9Ie8Nne7AXaDkE5Nbymzyun1WlmD20n05527Xo19aH
         lRQJcru10iA72HOa39t6kA49nbnRzdKapUgVTGm5TTzSJ45qTyJIGKkUXipoSegCtn
         ywVYV1PFFOWE5n2Fz5UEaLC5odLsVOMHddSrLIWOkyDutp8oReKgyd6/Sek49FQz4g
         toDpGN2Lsr8NsNH5ORQw5+qB2sYy8jzyh91EsjIwYmBpSRUubatkOmY2jqMt/KLPPM
         RMfE5EvLDaWnCZpiGDxffzkkdy63urWpPOufeJDuFa2YwukzgaFihF0yjlI9mINFZ9
         FmuPn0riJuixELg+PRTXHrj/UwcJmhmYpmEeef8DGhjrBo6e+zDU4yf7tS/tMASgJL
         2aot7kmKBHcIE0S6E5KQTDKYj91balUSkshLyQB2CYbGRvfwG98
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 14/17] diff: switch GIT_SHA1_HEXSZ to use the_hash_algo
Date:   Sun,  8 Jul 2018 23:36:35 +0000
Message-Id: <20180708233638.520172-15-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.18.0.399.gad0ab374a1
In-Reply-To: <20180708233638.520172-1-sandals@crustytoothpaste.net>
References: <20180708233638.520172-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 diff.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/diff.c b/diff.c
index 639eb646b9..485ff6c264 100644
--- a/diff.c
+++ b/diff.c
@@ -3832,7 +3832,7 @@ static const char *diff_abbrev_oid(const struct object_id *oid, int abbrev)
 		char *hex = oid_to_hex(oid);
 		if (abbrev < 0)
 			abbrev = FALLBACK_DEFAULT_ABBREV;
-		if (abbrev > GIT_SHA1_HEXSZ)
+		if (abbrev > the_hash_algo->hexsz)
 			BUG("oid abbreviation out of range: %d", abbrev);
 		if (abbrev)
 			hex[abbrev] = '\0';
@@ -4947,7 +4947,7 @@ const char *diff_aligned_abbrev(const struct object_id *oid, int len)
 	const char *abbrev;
 
 	/* Do we want all 40 hex characters? */
-	if (len == GIT_SHA1_HEXSZ)
+	if (len == the_hash_algo->hexsz)
 		return oid_to_hex(oid);
 
 	/* An abbreviated value is fine, possibly followed by an ellipsis. */
@@ -4977,7 +4977,7 @@ const char *diff_aligned_abbrev(const struct object_id *oid, int len)
 	 * the automatic sizing is supposed to give abblen that ensures
 	 * uniqueness across all objects (statistically speaking).
 	 */
-	if (abblen < GIT_SHA1_HEXSZ - 3) {
+	if (abblen < the_hash_algo->hexsz - 3) {
 		static char hex[GIT_MAX_HEXSZ + 1];
 		if (len < abblen && abblen <= len + 2)
 			xsnprintf(hex, sizeof(hex), "%s%.*s", abbrev, len+3-abblen, "..");
