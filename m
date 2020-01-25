Return-Path: <SRS0=JG/V=3O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A18C35242
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 23:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22DEB2071E
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 23:01:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="acd39g8R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729107AbgAYXBI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Jan 2020 18:01:08 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:46820 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728984AbgAYXAw (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 25 Jan 2020 18:00:52 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 36A8161487;
        Sat, 25 Jan 2020 23:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1579993251;
        bh=0kNVW9mFXumMyNnziPKJBXS3d3cMTpZajcHD+10y6zA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=acd39g8RVMxddU2Td73pStprUz8XjAeWKeHPj4L+zZSoEYb5lmr/e6mco8J2k+I93
         pOFXXnFXJeOVn7aa4fBq/lsReVJCVbP6G1Euk6zdJLXVuxTf9odx0GcUiupQfLmHKZ
         vl5xBYY+fqL+Jmz4kBVnE3SgyrwQ8IBXDGVypxTqHAWU4gF6xBS6weSXMgDpraJAiv
         9H8E5+eoJ8tfqxK8PN4tvzVc5OBYmRyI4ow2S3V3IxHmZEp/HjV2WIEULgwKCEBpty
         crCWKXxhe2AAW2JJB0JeMVMqrZpwhpPqApYvmBs9/NtUGgVEKVgjoNehXkk4ZSzoXO
         SPmD+ROYQLlSn+byPIF2KT6a8xyAdYCCZMcQ3KBdCc+a/NcJsrbzddwTNWCd4x730V
         7SSNT2Hr6++ouoL3w1xbBa6FLoe2UClRaDP5g78iisae+V40eumEJrgoEkSWHOHRO1
         99wkkjiXHwyNMXgWScE7258kmHJ2gruDjHrArmXjK2aHFuh+8iY
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 20/23] t5703: switch tests to use test_oid
Date:   Sat, 25 Jan 2020 23:00:29 +0000
Message-Id: <20200125230035.136348-24-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.0.24.g3f081b084b0
In-Reply-To: <20200125230035.136348-1-sandals@crustytoothpaste.net>
References: <20200125230035.136348-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To make this test work correctly with SHA-256, switch the hard-coded
invalid object IDs to use test_oid.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t5703-upload-pack-ref-in-want.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/t/t5703-upload-pack-ref-in-want.sh b/t/t5703-upload-pack-ref-in-want.sh
index 5511cdcec2..8aeeaac509 100755
--- a/t/t5703-upload-pack-ref-in-want.sh
+++ b/t/t5703-upload-pack-ref-in-want.sh
@@ -37,6 +37,7 @@ check_output () {
 #             \ | /
 #               a
 test_expect_success 'setup repository' '
+	test_oid_init &&
 	test_commit a &&
 	git checkout -b o/foo &&
 	test_commit b &&
@@ -333,7 +334,7 @@ test_expect_success 'server is initially ahead - no ref in want' '
 	git -C "$REPO" config uploadpack.allowRefInWant false &&
 	rm -rf local &&
 	cp -r "$LOCAL_PRISTINE" local &&
-	inconsistency master 1234567890123456789012345678901234567890 &&
+	inconsistency master $(test_oid numeric) &&
 	test_must_fail git -C local fetch 2>err &&
 	test_i18ngrep "fatal: remote error: upload-pack: not our ref" err
 '
@@ -342,7 +343,7 @@ test_expect_success 'server is initially ahead - ref in want' '
 	git -C "$REPO" config uploadpack.allowRefInWant true &&
 	rm -rf local &&
 	cp -r "$LOCAL_PRISTINE" local &&
-	inconsistency master 1234567890123456789012345678901234567890 &&
+	inconsistency master $(test_oid numeric) &&
 	git -C local fetch &&
 
 	git -C "$REPO" rev-parse --verify master >expected &&
