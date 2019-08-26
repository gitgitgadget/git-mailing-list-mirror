Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 825741F4B7
	for <e@80x24.org>; Mon, 26 Aug 2019 01:44:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729083AbfHZBoK (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Aug 2019 21:44:10 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58300 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729058AbfHZBoJ (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 25 Aug 2019 21:44:09 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:60b7:b124:ccfa:d51])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 7C51860780;
        Mon, 26 Aug 2019 01:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1566783847;
        bh=OnewIo6qRCkCQKRbTcNKQUB3wtB2MIjxzXh1u+soRZ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=a5I7i10orq0rp+h9oeEn5hdQi6GS2Dad56PQ0cGHLsogkstRI2608ZA3Qw8Gt7j3U
         VxSSmZ3FVg9R5Q1BjO9u26+o0N7OkhkX1v9m6QPzB+vDyXpJNTTIQAn4C5UXj12mZk
         IKQH9mqRWYma9uWYoHcHGuhtWF3l4CKTY3hmAOpUbwUo+9XNFE6UPKz3Nm1CeK+9NL
         JB6IjDjVwan8FGyNlNi0OdrbDDQBNXyO1C8hNcmzJzlKjYajPgTZLcxpzHKWtdOqv/
         iH+m60p00nQ9KOqP4C0P4qO6n7GwbWRsqlhF9nebLnMv3zEMWqwnb9ezAQfwODKaRo
         lVbaYDIQjgpxRw2583xLFan5xpaJqaO181AAEmHeyYlRjEjmJDrnC0wMg76dNWnYg9
         XlEorTU8pF9HqCZDBkSQLJUBMVJfDp1dhakLAZKIpvYalLsrjYD4rbe9woaTLRZyNq
         hy/JPLvtzb8hmEnKZ3rXmJcSxiJtVbxAHzMSukH/UIqu52Oyw3r
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2 07/14] t3430: avoid hard-coded object IDs
Date:   Mon, 26 Aug 2019 01:43:37 +0000
Message-Id: <20190826014344.16008-8-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c
In-Reply-To: <20190826014344.16008-1-sandals@crustytoothpaste.net>
References: <20190818191646.868106-1-sandals@crustytoothpaste.net>
 <20190826014344.16008-1-sandals@crustytoothpaste.net>
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
 
