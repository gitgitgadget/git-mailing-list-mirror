Return-Path: <SRS0=RB3M=7H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 637BBC433E1
	for <git@archiver.kernel.org>; Mon, 25 May 2020 20:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 405F62071A
	for <git@archiver.kernel.org>; Mon, 25 May 2020 20:00:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="kJ2oOfe5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390605AbgEYUAa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 May 2020 16:00:30 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38720 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390419AbgEYT7y (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 25 May 2020 15:59:54 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 7747B60D08;
        Mon, 25 May 2020 19:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1590436791;
        bh=YhcqSF7NVvsfDzpsd5p3oihZbPBd50K1aBOeC4FnGdY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=kJ2oOfe5LOyP18JbAU/o6AGF9eIHJuCvEGDdkRD8/DkuAukUzwTw1/yjcptXq2Oxj
         XlBo+PCUSgXBRh/L+Xh/rGeX0GBYvPsnm/rovGM7F4omUhj2yyd6it4VDEN5B0HC2t
         idPodP8EBCj+Dy6DP15Tifi9JVBsb7F3Z5v+lo8CDuq9ZG1BqL+BnxL1LodNc15G/H
         HVPt4lBm+2bOpqE+VwqtDXmKyyXf8Ol2joH8fEB18j+71OUwvHUziGr9xDnfJs40c/
         Ds858uyHZ2IQPtv2hRKRVs7bnXru3IQ3l9j4CFAAuLcSn/k1QNxAkFktQae6yr17zH
         /mvF2S9HrczFMTwe0T2xeK8SOPuZ0HviN/C5CmhCIGZkktlp2Sv60YguNxNDgzmnSH
         fdf5oG/+mnGuAkcjjEvIq+COHgDdMSLEY+PfBsDy9RYT5SReF9UlBUqY731uYLy8c1
         I0pudUcIX8wGD+HtCUCzP0nWMza4vEVSeGMDORbkKjn+5hSdwSW
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v2 20/44] t5562: pass object-format in synthesized test data
Date:   Mon, 25 May 2020 19:59:06 +0000
Message-Id: <20200525195930.309665-21-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652
In-Reply-To: <20200525195930.309665-1-sandals@crustytoothpaste.net>
References: <20200513005424.81369-1-sandals@crustytoothpaste.net>
 <20200525195930.309665-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ensure that we pass the object-format capability in the synthesized test
data so that this test works with algorithms other than SHA-1.

In addition, add an additional test using the old data for when we're
using SHA-1 so that we can be sure that we preserve backwards
compatibility with servers not offering the object-format capability.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t5562-http-backend-content-length.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/t/t5562-http-backend-content-length.sh b/t/t5562-http-backend-content-length.sh
index 3f4ac71f83..c6ec625497 100755
--- a/t/t5562-http-backend-content-length.sh
+++ b/t/t5562-http-backend-content-length.sh
@@ -46,6 +46,7 @@ ssize_b100dots() {
 }
 
 test_expect_success 'setup' '
+	test_oid_init &&
 	HTTP_CONTENT_ENCODING="identity" &&
 	export HTTP_CONTENT_ENCODING &&
 	git config http.receivepack true &&
@@ -62,8 +63,8 @@ test_expect_success 'setup' '
 	test_copy_bytes 10 <fetch_body >fetch_body.trunc &&
 	hash_next=$(git commit-tree -p HEAD -m next HEAD^{tree}) &&
 	{
-		printf "%s %s refs/heads/newbranch\\0report-status\\n" \
-			"$ZERO_OID" "$hash_next" | packetize &&
+		printf "%s %s refs/heads/newbranch\\0report-status object-format=%s\\n" \
+			"$ZERO_OID" "$hash_next" "$(test_oid algo)" | packetize &&
 		printf 0000 &&
 		echo "$hash_next" | git pack-objects --stdout
 	} >push_body &&
