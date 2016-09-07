Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3FAD1F859
	for <e@80x24.org>; Wed,  7 Sep 2016 15:13:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934423AbcIGPNZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Sep 2016 11:13:25 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:48120 "EHLO
        iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933183AbcIGPNY (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 7 Sep 2016 11:13:24 -0400
Received: from x590d6d43.dyn.telefonica.de ([89.13.109.67] helo=localhost.localdomain)
        by iramx2.ira.uni-karlsruhe.de with esmtpsa port 587 
        iface 141.3.10.81 id 1bheXM-0006Yc-QR; Wed, 07 Sep 2016 17:13:20 +0200
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc:     Leho Kraav <leho@conversionready.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 1/5] t7004-tag: delete unnecessary tags with test_when_finished
Date:   Wed,  7 Sep 2016 17:12:47 +0200
Message-Id: <20160907151251.30978-2-szeder@ira.uka.de>
X-Mailer: git-send-email 2.10.0.74.g6632b1b
In-Reply-To: <20160907151251.30978-1-szeder@ira.uka.de>
References: <20160906214550.Horde.ducOghtmsQb9pQ6lixxddVz@webmail.informatik.kit.edu>
 <20160907151251.30978-1-szeder@ira.uka.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1473261200.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The '--force is moot with a non-existing tag name' test creates two
new tags, which are then deleted right after the test is finished,
outside the test_expect_success block, allowing 'git tag -d's output to
pollute the test output.

Use test_when_finished to delete those tags.

Signed-off-by: SZEDER Gábor <szeder@ira.uka.de>
---
 t/t7004-tag.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 8b0f71a2ac15..396cffeeb5ad 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -122,11 +122,11 @@ test_expect_success '--force can create a tag with the name of one existing' '
 	tag_exists mytag'
 
 test_expect_success '--force is moot with a non-existing tag name' '
+	test_when_finished git tag -d newtag forcetag &&
 	git tag newtag >expect &&
 	git tag --force forcetag >actual &&
 	test_cmp expect actual
 '
-git tag -d newtag forcetag
 
 # deleting tags:
 
-- 
2.10.0.74.g6632b1b

