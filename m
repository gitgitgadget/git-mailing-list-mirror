Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57C67200B9
	for <e@80x24.org>; Sun,  6 May 2018 23:18:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751962AbeEFXSq (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 May 2018 19:18:46 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41104 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751931AbeEFXSk (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 6 May 2018 19:18:40 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 1A82F60764;
        Sun,  6 May 2018 23:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1525648719;
        bh=XEKVT3yPmx3r4ENn87G2DLpPzpqiCkYlXAwj93wMTso=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=bKr146EqxDMEYh8ZdUq0BiSUtpoigUvzOMZkMvLf/JC9PI0Cx1q24rnB0/GYTtXfT
         wbLEzyBWA7a4HqdqsKHzxs3XdrCA3QKg10JSC7Jw9bSN/s4Au/kWY9aF7WdEeoXooW
         BehMqfii/hx2ENfRM5sMBu+VRv0DsP/hb1T59D2uqRBdTnXoeXor4uNci+XM7f7+5d
         JK7YpU+OS2kde91XjQvR6sE0JklAq7DTWuJFUeeGWon0bGkbRg2JqsiV16UaUvk9Fm
         3YzW0GZsWv2w2Q0iJPeEnX1ot4O9260mCgZvrAtDqEdFWY9/fATTzg1gFj0nN+iKHN
         7fOBwuROBX3jo+ZBdABk+nWsAxh2DEN6PUpyMyXhCu/nJrkbJa8zHe0an6z/1SYBn3
         J2C4kSgU2Vz8XaIR1awPoykNmmbksY+BtqCvetyyl2qKAhuRs0oQMizqOTAP+DHv/A
         TKVLeQoc75C/wMb+MGF80Yox7GCbm5Vnt0Zmd4kV/Xzht/XxXcD
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH 09/28] t4044: skip test if not using SHA-1
Date:   Sun,  6 May 2018 23:17:33 +0000
Message-Id: <20180506231752.975110-10-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d
In-Reply-To: <20180506231752.975110-1-sandals@crustytoothpaste.net>
References: <20180506231752.975110-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This test relies on objects with colliding short names which are
necessarily dependent on the hash used.  Skip the test if we're not
using SHA-1.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t4044-diff-index-unique-abbrev.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/t/t4044-diff-index-unique-abbrev.sh b/t/t4044-diff-index-unique-abbrev.sh
index d5ce72be63..647905e01f 100755
--- a/t/t4044-diff-index-unique-abbrev.sh
+++ b/t/t4044-diff-index-unique-abbrev.sh
@@ -3,6 +3,12 @@
 test_description='test unique sha1 abbreviation on "index from..to" line'
 . ./test-lib.sh
 
+if ! test_have_prereq SHA1
+then
+       skip_all='not using SHA-1 for objects'
+       test_done
+fi
+
 cat >expect_initial <<EOF
 100644 blob 51d2738463ea4ca66f8691c91e33ce64b7d41bb1	foo
 EOF
