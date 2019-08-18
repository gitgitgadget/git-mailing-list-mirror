Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 535161F461
	for <e@80x24.org>; Sun, 18 Aug 2019 19:20:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbfHRTUr (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Aug 2019 15:20:47 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:57748 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726005AbfHRTUr (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 18 Aug 2019 15:20:47 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:81dd:eb9b:e758:604b])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 2CDDC60736;
        Sun, 18 Aug 2019 19:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1566156044;
        bh=P8yCDhvUZ0BVNjy3lVDLrSRJYFvrMTlDtO5h5NmPOdI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=c9crZbbDpc9046kJSehu5qHMQ+g2ekvoZOiM+0ebLYKqxJg76CPVzCbEC/oPw1BxB
         kKwjDusTv1xqMY6Cp0fMClpGaV2lwjapXMmLZ6wUgsq8LhmE41u7rhkb5N8XHeTqig
         xHqauCuhqkRy0qghUH4VBqZzNNdjTE+dbvPNS3VvfL9FfEk8FwE8pi8FeIEnhEXwK+
         xYX5hjKMmylxW4wn1fvctISOOksrV1xXHTtX48B7TnVvY1p2y95CwVdPt/iGSB7hup
         /GR192pEM3UwvauxJzUeBqtiKLk7zTanTarYqGg4Ikv+XpKyKPN+Vy/KRGQeL3A1Em
         gdjh0THwD0QTTDZxTK4Y+G+PCHV04Ft4mP4J3kg3LfN+keWtJYO1NaO9R6U2eoh0dv
         yUuJnFMANKl+Js0q2zkr6rkMabrtJtgN6btn2NofUjgrBHND11UknS9IOQbPCtdrkH
         JA3ddQQqjTl9YcjDmVWPef0KL7kk3izH03hL0B9zUOwhyIfxLLq
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 01/14] t3201: abstract away SHA-1-specific constants
Date:   Sun, 18 Aug 2019 19:16:33 +0000
Message-Id: <20190818191646.868106-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.23.0.rc1.170.gbd704faa3e
In-Reply-To: <20190818191646.868106-1-sandals@crustytoothpaste.net>
References: <20190818191646.868106-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adjust the test so that it computes variables for object IDs instead of
using hard-coded hashes.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t3201-branch-contains.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t3201-branch-contains.sh b/t/t3201-branch-contains.sh
index 0ea4fc4694..40251c9f8f 100755
--- a/t/t3201-branch-contains.sh
+++ b/t/t3201-branch-contains.sh
@@ -192,10 +192,10 @@ test_expect_success 'branch --merged with --verbose' '
 	EOF
 	test_cmp expect actual &&
 	git branch --verbose --merged topic >actual &&
-	cat >expect <<-\EOF &&
-	  master c77a0a9 second on master
-	* topic  2c939f4 [ahead 1] foo
-	  zzz    c77a0a9 second on master
+	cat >expect <<-EOF &&
+	  master $(git rev-parse --short master) second on master
+	* topic  $(git rev-parse --short topic ) [ahead 1] foo
+	  zzz    $(git rev-parse --short zzz   ) second on master
 	EOF
 	test_i18ncmp expect actual
 '
