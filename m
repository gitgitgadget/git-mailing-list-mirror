Return-Path: <SRS0=JG/V=3O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B32B1C35246
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 23:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80D222071E
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 23:00:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="cA2HUaq5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729058AbgAYXA5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Jan 2020 18:00:57 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:46844 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728925AbgAYXAv (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 25 Jan 2020 18:00:51 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id C094D61485;
        Sat, 25 Jan 2020 23:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1579993251;
        bh=0kNVW9mFXumMyNnziPKJBXS3d3cMTpZajcHD+10y6zA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=cA2HUaq5RhD9NkpERzyYBYhBpGRe/6vgHnql6kPzkIwJWG1VzhR1jU/DavTDarsjs
         sZBpk1tBN/tcRj53qfu0OxB7oaaFsoKd5gpcQ3uzBhI5FxBlgHLhhtek5I5VN7/3Ms
         KLaq77XOGim5CZ+xa5CazsStAtXsbwHZZK9ML557UbFGcuUTUzIGYTbF9qeNigCuOu
         X0Ugqs2Wigj5xtVnS3xrNUo8QJYFvdM76hP/897TS00ugoois4MkHZViqmPiePji2Z
         sOxwgUXypHdMt1KVIJnS6lVpRHZNKqgX3K8jt00m6fIyXcLGeGrRW6m9aCL+aIDzde
         f2teZoCUcP1xzeCt24QgdEEJRo0sUK/EJmUmXIq/ZzYVjK36tHsnUg/H5Cq55fQ08m
         VyuEia9+9FPJmW4e7D4RGGbDDfkYVIkyyYt2l4kyEi48C9ZGAdjEEv3xzv2hRXnGbA
         8gFbGqjblXeMuhpgxqwIL2Ljybpi0+gJRqEp1PUprli5fPEKP3E
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 19/22] t5703: switch tests to use test_oid
Date:   Sat, 25 Jan 2020 23:00:28 +0000
Message-Id: <20200125230035.136348-23-sandals@crustytoothpaste.net>
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
