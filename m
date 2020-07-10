Return-Path: <SRS0=TxkB=AV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78EA4C433E0
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 02:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5933F20663
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 02:48:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="095yC6q2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbgGJCsd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jul 2020 22:48:33 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40372 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726725AbgGJCs1 (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 9 Jul 2020 22:48:27 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id CB9ED60A60;
        Fri, 10 Jul 2020 02:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1594349306;
        bh=6vdJnTtdikEyvh2eoGCAUKW9eW10Iio5RbuTQEHrp4E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=095yC6q2xnsCPtoJaAP6EuVtvyvTiii1LKTOmp6ZU0z9TLqgvrRLk+52cwLU6VnV1
         /y+gRK07R9YsNnBTL9POGyYWoU/ahxbKu54aylH/yvhOvledYp6iG76Z0B7Gtr4SRG
         RKmLwLkz476n72fhsTkhwnPhwPxu1Eo3ay/N3DsbBQsqsdsg/sSUvv62dwmwWl3RME
         WG9j1J70zGXt9tpqOE21hL2lKKqYIIAYsjkTPx8KnTfHoQeO/9yi4kxzQvj0qzHr1T
         EP6/GLhZMf33F6gxPeGD4k+fGm+XspJ3drg2esletOQfM6aK0MefnYnIQ3evY/Jx18
         JcE/GcFnw6chvEdL0Ssk/LFo5uebmInlXcKAUCPhQNEq01OwqYVXYNSZ4jgADiOr8K
         kG1si+FTbxtsKdG0wDJ8GroWlJdvtm3k7b4dJrP/jz/nvwrJrO1QMWXB5aKKGnGxAl
         4+aWOgqquPJWrvhk8jpFNtlPfxXLE8Hy52QrcEBZCXKiAzF5FB2
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 05/38] t6100: make hash size independent
Date:   Fri, 10 Jul 2020 02:46:55 +0000
Message-Id: <20200710024728.3100527-6-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.27.0.353.gb9a2d1a020
In-Reply-To: <20200710024728.3100527-1-sandals@crustytoothpaste.net>
References: <20200710024728.3100527-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of hard-coding a constant 40, split the output of rev-list by
field.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t6100-rev-list-in-order.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t6100-rev-list-in-order.sh b/t/t6100-rev-list-in-order.sh
index b2bb0a7f61..e934bc239c 100755
--- a/t/t6100-rev-list-in-order.sh
+++ b/t/t6100-rev-list-in-order.sh
@@ -22,7 +22,7 @@ test_expect_success 'setup a commit history with trees, blobs' '
 
 test_expect_success 'rev-list --in-commit-order' '
 	git rev-list --in-commit-order --objects HEAD >actual.raw &&
-	cut -c 1-40 >actual <actual.raw &&
+	cut -d" " -f1 >actual <actual.raw &&
 
 	git cat-file --batch-check="%(objectname)" >expect.raw <<-\EOF &&
 		HEAD^{commit}
@@ -49,7 +49,7 @@ test_expect_success 'rev-list --in-commit-order' '
 
 test_expect_success 'rev-list lists blobs and trees after commits' '
 	git rev-list --objects HEAD >actual.raw &&
-	cut -c 1-40 >actual <actual.raw &&
+	cut -d" " -f1 >actual <actual.raw &&
 
 	git cat-file --batch-check="%(objectname)" >expect.raw <<-\EOF &&
 		HEAD^{commit}
