Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4EA1C433DF
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 17:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4C6121531
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 17:57:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="kqHA1Bjb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394668AbgFSR5o (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 13:57:44 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39526 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404207AbgFSR42 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 19 Jun 2020 13:56:28 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:7d4e:cde:7c41:71c2])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 34B7260A70;
        Fri, 19 Jun 2020 17:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1592589383;
        bh=YhcqSF7NVvsfDzpsd5p3oihZbPBd50K1aBOeC4FnGdY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=kqHA1BjbFQn+p0oWMsXmPnOzPX0mRq4ZG2o+2MgYSwNrF8HI+oP9a4HIF/dq84dOj
         QP7bkz6uuNWVtUoRgJ4qcCPDUutHKBPy6F34Vl180/nQmkZHx0Hvyeqx8R0PfsILXL
         JeWljfwgthobGPBG+V7OFS5EBVn3p43O5pKKo5kDBqn3FZoQpufgacr0sOMxyNbM1e
         ptYRJiZICMolaph1R6ttRtnYt+fUi1kfgv2bvuJkNtVSA79n6CXPVkV4QfaCNI6fsU
         C5QszsN3BmGjlSTpWYETmb4wGWryhZguYo5PNVTbJVyKOpmYXbThZs+NF4OyJ00emf
         ae14lYvlRs/Kn7nwcpJJe4OADH3B5GSNBGlwIAflzpzuIJYqPqd/8rQpipD2XvL1m6
         HBkuc/OqMEfIgi9w651TZm2zWpwN33j2KDK/D6TIGTLrx8IIrj6GTZlnNYfHl7FMcL
         5uftcBEl5iFye/HJ1hTnuC+OHRrGbrc8YWXI/1jrq/LFms/gfIg
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v3 20/44] t5562: pass object-format in synthesized test data
Date:   Fri, 19 Jun 2020 17:55:37 +0000
Message-Id: <20200619175601.569856-21-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9
In-Reply-To: <20200619175601.569856-1-sandals@crustytoothpaste.net>
References: <20200513005424.81369-1-sandals@crustytoothpaste.net>
 <20200619175601.569856-1-sandals@crustytoothpaste.net>
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
