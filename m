Return-Path: <SRS0=G+/Y=3C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD94C33CAE
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 12:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAFA520678
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 12:40:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="obFrzwy1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728759AbgAMMks (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jan 2020 07:40:48 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37708 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726946AbgAMMko (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 13 Jan 2020 07:40:44 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id B411C60806;
        Mon, 13 Jan 2020 12:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1578919243;
        bh=QHnDg5ZYTySZwXWhyF/Hv57H78VbkNYZhjhoZotl4fE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=obFrzwy1Pq6KLTU+bZgEb3upp0IVgk5tfEO+lSebBGqvCt5dRXf656uMucWPCrcsA
         0Uw1V+otr7cilr1POHzGebfjCMeSODuqmv59i58Y+XR4WG/k+Z99ENkioXn+jLxp0L
         3bOsBnMPj1yxqrUAoOXsQ0sP2KVXVEHMzsN+JpMZBY1+cNYCgVGsdWYopG0kVNbjQY
         1N+xjqLLlPBUFFkmUtATueTRpCl7eiBCpFb7WWzWUUiWgfddtReIP3U7LsMqOHq+gO
         labGCh2Mysw8wgviShtuMCXRtKaSX2o4gVojcqnOjPrfXnzl4KnzrdsGbLsemapM9L
         GHlraYd2eX+8IPb3FNejtHLKdMeH+TPDbwvWDTHPl8mxHiYc/thAna0rAH8tnNnzpp
         VPMK7MGRIxibZ+MuVYwiwQWK7UnYvubvhhieGVCvueHz2xwAEc7vuFBWgv7aXMD5EM
         I0kEAHMlNnBERR6a8q2h18TNTQB+TlWNFxPxokla8RDQlfn1RQj
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 21/24] t5703: switch tests to use test_oid
Date:   Mon, 13 Jan 2020 12:38:54 +0000
Message-Id: <20200113123857.3684632-22-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.0.rc2.338.g21a285fb81
In-Reply-To: <20200113123857.3684632-1-sandals@crustytoothpaste.net>
References: <20200113123857.3684632-1-sandals@crustytoothpaste.net>
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
 t/t5703-upload-pack-ref-in-want.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t5703-upload-pack-ref-in-want.sh b/t/t5703-upload-pack-ref-in-want.sh
index 852c01ecb4..8aeeaac509 100755
--- a/t/t5703-upload-pack-ref-in-want.sh
+++ b/t/t5703-upload-pack-ref-in-want.sh
@@ -334,7 +334,7 @@ test_expect_success 'server is initially ahead - no ref in want' '
 	git -C "$REPO" config uploadpack.allowRefInWant false &&
 	rm -rf local &&
 	cp -r "$LOCAL_PRISTINE" local &&
-	inconsistency master 1234567890123456789012345678901234567890 &&
+	inconsistency master $(test_oid numeric) &&
 	test_must_fail git -C local fetch 2>err &&
 	test_i18ngrep "fatal: remote error: upload-pack: not our ref" err
 '
@@ -343,7 +343,7 @@ test_expect_success 'server is initially ahead - ref in want' '
 	git -C "$REPO" config uploadpack.allowRefInWant true &&
 	rm -rf local &&
 	cp -r "$LOCAL_PRISTINE" local &&
-	inconsistency master 1234567890123456789012345678901234567890 &&
+	inconsistency master $(test_oid numeric) &&
 	git -C local fetch &&
 
 	git -C "$REPO" rev-parse --verify master >expected &&
