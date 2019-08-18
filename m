Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E01DB1F461
	for <e@80x24.org>; Sun, 18 Aug 2019 19:20:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbfHRTU5 (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Aug 2019 15:20:57 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:57808 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727087AbfHRTU4 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 18 Aug 2019 15:20:56 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:81dd:eb9b:e758:604b])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 985A26075D;
        Sun, 18 Aug 2019 19:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1566156055;
        bh=OnewIo6qRCkCQKRbTcNKQUB3wtB2MIjxzXh1u+soRZ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=irL22/Rgi1ej0PE4P/eCE6IUoeb/etKvp9RxcH41CxDLokCO1Vq84Rm5fGqlKqFOd
         AcmDBnm0iFKqb9RDtQusmCJAvbZA7WrVdf+Qhe+zsq9kqKFopyNN5jz42UX713ROEh
         Y0dnWQ9o2IkanH/YorQuGbkLhFUQ+E03PGcL7unJ0D1T5Xfet6dxtmzg5GrveE01H5
         2INxc0RGxLdu2EqeHxXUn/osskbHgpPeestTGr24b2q3o54DOE18mCG7z7jHekIO8j
         gF5iob1SouuiLhBQyybrRKcJTVeFcqHuRtOl0U/SbG6ynYBr4LOmX9l1CwpmZYe2/z
         Jk7lgp/8/p6tsqeSO8Og4JziV+hQEabyZjY9hMaLXNXEOiFIa3mxHCZrg3IaYxkfVt
         Sb5BnnIOQSj4Eb8nqbRuY+kr44445qWPwCWvV1vva6aZ67cAF293OO032L3trJLXXs
         TMiBsTX5zLBXXiLBvTi1DP8HviwRWpP5t1UVXmXI6QZtxyZy+WQ
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 07/14] t3430: avoid hard-coded object IDs
Date:   Sun, 18 Aug 2019 19:16:39 +0000
Message-Id: <20190818191646.868106-8-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.23.0.rc1.170.gbd704faa3e
In-Reply-To: <20190818191646.868106-1-sandals@crustytoothpaste.net>
References: <20190818191646.868106-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Compute the object IDs used in the todo list instead of hard-coding
them.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t3430-rebase-merges.sh | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
index 7b6c4847ad..c1ea2ee297 100755
--- a/t/t3430-rebase-merges.sh
+++ b/t/t3430-rebase-merges.sh
@@ -37,20 +37,27 @@ test_expect_success 'setup' '
 	test_commit A &&
 	git checkout -b first &&
 	test_commit B &&
+	b=$(git rev-parse --short HEAD) &&
 	git checkout master &&
 	test_commit C &&
+	c=$(git rev-parse --short HEAD) &&
 	test_commit D &&
+	d=$(git rev-parse --short HEAD) &&
 	git merge --no-commit B &&
 	test_tick &&
 	git commit -m E &&
 	git tag -m E E &&
+	e=$(git rev-parse --short HEAD) &&
 	git checkout -b second C &&
 	test_commit F &&
+	f=$(git rev-parse --short HEAD) &&
 	test_commit G &&
+	g=$(git rev-parse --short HEAD) &&
 	git checkout master &&
 	git merge --no-commit G &&
 	test_tick &&
 	git commit -m H &&
+	h=$(git rev-parse --short HEAD) &&
 	git tag -m H H &&
 	git checkout A &&
 	test_commit conflicting-G G.t
@@ -93,24 +100,24 @@ test_expect_success 'create completely different structure' '
 '
 
 test_expect_success 'generate correct todo list' '
-	cat >expect <<-\EOF &&
+	cat >expect <<-EOF &&
 	label onto
 
 	reset onto
-	pick d9df450 B
+	pick $b B
 	label E
 
 	reset onto
-	pick 5dee784 C
+	pick $c C
 	label branch-point
-	pick ca2c861 F
-	pick 088b00a G
+	pick $f F
+	pick $g G
 	label H
 
 	reset branch-point # C
-	pick 12bd07b D
-	merge -C 2051b56 E # E
-	merge -C 233d48a H # H
+	pick $d D
+	merge -C $e E # E
+	merge -C $h H # H
 
 	EOF
 
