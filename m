Return-Path: <SRS0=G+/Y=3C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F5F1C33CAD
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 12:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0E2220678
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 12:40:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="QUeL9Kpb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728761AbgAMMkt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jan 2020 07:40:49 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37706 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728721AbgAMMko (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 13 Jan 2020 07:40:44 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 39A7E60805;
        Mon, 13 Jan 2020 12:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1578919242;
        bh=UiEBiYonKIHRzY5R3z8HJ6v27fAEBjI9BEMPBGR3hDs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=QUeL9Kpb+HKzfFImD8ZSoolCPJjxQTV+Kd/YqxSqwjc1VJ7up9xlR53AU9r0OsXhO
         5zAzHiNB69I8PNbFKaZJVUlLbS819v0GdZtsVUHTqlcmsO2tNuwhhCJo5d+lqDes5R
         sASAFbl1tg1ZGRwafBBOlPlfLrWymTJdVpPHs4y94ruXPwfSNtPptpZ8DCfLa8RCT3
         O0S50YR74mf5hUmQCQheO4eVsGCpiGRxcp/tInMovBYocQj2XcUjC0RrOGmor1RJie
         d3mUJ5ZUAqQ8qq/osvLGu6GhAh8LpGcaQDbKC43lrFF2yLVOlOtuMMurPcRWdO0rL/
         w0ZCv91p5b/e/I2qDPYzenH3vCm1OjaAZsB8UiiGt/b1rSkJm/Fe22FCa34g3WD9aY
         Y5DViq/Q6P4s6pwq4RcQWH8Ei8XpJNQgnSiI4IIqzIEdm+crKxOKTEFiTkdUnAwAwk
         LviTbJkVIWFkEm+9av6DrqIBAQ6+pWFPzIJZc50/+4iYM4j0Yi1
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 20/24] t5703: make test work with SHA-256
Date:   Mon, 13 Jan 2020 12:38:53 +0000
Message-Id: <20200113123857.3684632-21-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.0.rc2.338.g21a285fb81
In-Reply-To: <20200113123857.3684632-1-sandals@crustytoothpaste.net>
References: <20200113123857.3684632-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This test used an object ID which was 40 hex characters in length,
causing the test not only not to pass, but to hang, when run with
SHA-256 as the hash.  Change this value to a fixed dummy object ID using
test_oid_init and test_oid.

Furthermore, ensure we extract an object ID of the appropriate length
using cut with fields instead of a fixed length.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t5703-upload-pack-ref-in-want.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t5703-upload-pack-ref-in-want.sh b/t/t5703-upload-pack-ref-in-want.sh
index 1424fabd4a..852c01ecb4 100755
--- a/t/t5703-upload-pack-ref-in-want.sh
+++ b/t/t5703-upload-pack-ref-in-want.sh
@@ -19,7 +19,7 @@ get_actual_commits () {
 		}' <out | test-tool pkt-line unpack-sideband >o.pack &&
 	git index-pack o.pack &&
 	git verify-pack -v o.idx >objs &&
-	grep commit objs | cut -c-40 | sort >actual_commits
+	grep commit objs | cut -d" " -f1 | sort >actual_commits
 }
 
 check_output () {
@@ -37,6 +37,7 @@ check_output () {
 #             \ | /
 #               a
 test_expect_success 'setup repository' '
+	test_oid_init &&
 	test_commit a &&
 	git checkout -b o/foo &&
 	test_commit b &&
