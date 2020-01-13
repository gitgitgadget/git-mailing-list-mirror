Return-Path: <SRS0=G+/Y=3C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCDFFC33CAF
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 12:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3AFC2073D
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 12:40:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Ccwo7hY/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728789AbgAMMk5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jan 2020 07:40:57 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37688 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728695AbgAMMkl (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 13 Jan 2020 07:40:41 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 787EE60801;
        Mon, 13 Jan 2020 12:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1578919240;
        bh=c545IyMuR7DdPUJnClTjechfdZUp/6Yx52J2M+FpRPg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=Ccwo7hY/vN+3sMuhNcsERPgVoEMvkeiDPKcWs4WnAHPHhD/hwni3ATWVRks2c8NGC
         wvbzWyiGUpt2o6SUivqKj5fJS6bY/v6H3YQRr9mswOeseD9cLVH1x9MJdMb+yq5MIN
         Yp2B8ybZapDb4A17Fc0vozyz2CX3ZQDJBMcr/zbYyXvfby3AH1A4aAjubVnOrRs2xX
         b/bMt3sIGWRw7BVtSNO1VAbJWI8y7Pl8xG7AGL+70zR8ej61ZCaNch5jGZFCm7EGBn
         Rw3CXBKPENsBd+BuNrtn8/U9HWAxnxxZnRW2Mf3+3n9hziN5SWpeLaB5XYjeYTK3BJ
         0n/w9vpSLUEBcZcvYdWwD1rOe+UPFFxduoTo/H/1iNDhMPbwSMX59N9Nq4ztcE9npT
         IXIE5qoXsMuHSQqyPBX+1AmHOL8kZ584HjqXoJmhD3l3uVhPxjlPU8go/qmkcSqfmy
         gUBve67YoRoTEmM00YGPgI16khoL8Kmvw5iv/qb0C8cpI6yIaOY
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 17/24] t5318: update for SHA-256
Date:   Mon, 13 Jan 2020 12:38:50 +0000
Message-Id: <20200113123857.3684632-18-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.0.rc2.338.g21a285fb81
In-Reply-To: <20200113123857.3684632-1-sandals@crustytoothpaste.net>
References: <20200113123857.3684632-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Switch two tests to use $ZERO_OID to represent the all-zeros object ID.
---
 t/t5318-commit-graph.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 3f03de6018..55a94072b1 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -629,7 +629,7 @@ test_expect_success 'corrupt commit-graph write (broken parent)' '
 		empty="$(git mktree </dev/null)" &&
 		cat >broken <<-EOF &&
 		tree $empty
-		parent 0000000000000000000000000000000000000000
+		parent $ZERO_OID
 		author whatever <whatever@example.com> 1234 -0000
 		committer whatever <whatever@example.com> 1234 -0000
 
@@ -650,7 +650,7 @@ test_expect_success 'corrupt commit-graph write (missing tree)' '
 		cd repo &&
 		tree="$(git mktree </dev/null)" &&
 		cat >broken <<-EOF &&
-		parent 0000000000000000000000000000000000000000
+		parent $ZERO_OID
 		author whatever <whatever@example.com> 1234 -0000
 		committer whatever <whatever@example.com> 1234 -0000
 
