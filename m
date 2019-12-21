Return-Path: <SRS0=QBG1=2L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9DC1C2D0C3
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 19:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5410206B7
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 19:50:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="X3Pk7S2z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbfLUTuY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Dec 2019 14:50:24 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:42024 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727423AbfLUTuP (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 21 Dec 2019 14:50:15 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 4A842607F4;
        Sat, 21 Dec 2019 19:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1576957814;
        bh=HgyeaCjz3Dw7PsQtjf2ulgT3KPniZUyIqId4U0cUyf0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=X3Pk7S2zTwzPCk4YuNYalmasqOfqOEvJCH4Ga6f4iQhu9NSXCX2GF92eTdbwwEw5R
         5oFJ15ArGmLSTKY6q9S3pxi4/b0yO0RWPa2XLkdf+BJaYMjGJIjZCHtsljOd8UOte0
         H1nd3lpcIReaFcnEp36X4Edm3WBL04JU7pQKLuXX54hvrQpdP4Eb+6xPK2heD+36Zd
         mZMMMsDwRXwFVQRYSBUPusD0c8CJAGyV9ibsG3JGDl0T7uI1vWZMAbS+hnuiW0LU8L
         e2NusZ6khaEjXqv8UsIkSl5OY2+zyQITTs1zX3KQWfDJRkeBieqUuQMqQ5xlVV21dw
         CD+KCKFV+BU9EMmgzjJ4F7h1xPYfk502Y0epMv22Fw1s8b3yB8VmZ+NavItAoXbT4B
         LnFTc935bq0+Ih2BI1i5gE07KXYe54YtA6Cj9Q+W5XRyIksca+xezixNrNClXI/c58
         50kH10FWlYdr0XHKPt1zIlG5cNHzl1Bg7Zb+r7POXd6Kxy6DBKW
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 18/20] t5562: use $ZERO_OID
Date:   Sat, 21 Dec 2019 19:49:34 +0000
Message-Id: <20191221194936.1346664-19-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.24.1.658.g99f4b37f93
In-Reply-To: <20191221194936.1346664-1-sandals@crustytoothpaste.net>
References: <20191221194936.1346664-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This test uses $_z40 to express an all-zeros object ID, which doesn't
work for SHA-256.  Use $ZERO_OID instead, which is the right size for
all hash values.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t5562-http-backend-content-length.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5562-http-backend-content-length.sh b/t/t5562-http-backend-content-length.sh
index f0f425b2cf..4a110b307e 100755
--- a/t/t5562-http-backend-content-length.sh
+++ b/t/t5562-http-backend-content-length.sh
@@ -59,7 +59,7 @@ test_expect_success 'setup' '
 	printf done | packetize >>fetch_body &&
 	test_copy_bytes 10 <fetch_body >fetch_body.trunc &&
 	hash_next=$(git commit-tree -p HEAD -m next HEAD^{tree}) &&
-	printf "%s %s refs/heads/newbranch\\0report-status\\n" "$_z40" "$hash_next" | packetize >push_body &&
+	printf "%s %s refs/heads/newbranch\\0report-status\\n" "$ZERO_OID" "$hash_next" | packetize >push_body &&
 	printf 0000 >>push_body &&
 	echo "$hash_next" | git pack-objects --stdout >>push_body &&
 	test_copy_bytes 10 <push_body >push_body.trunc &&
