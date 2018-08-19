Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39D611F954
	for <e@80x24.org>; Sun, 19 Aug 2018 17:54:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbeHSVGs (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Aug 2018 17:06:48 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:55038 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726527AbeHSVGs (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 19 Aug 2018 17:06:48 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:1024:89fd:c4a5:84be])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id BE03560752;
        Sun, 19 Aug 2018 17:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1534701256;
        bh=af7CHooCBh6cH+IcA4z0DRPS0JrXYraVs2FCJ3PeG44=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=t487mvehSlDa4yhl85G9GYhNqNeGUTQdY9hbxixh136dQeLeYeZm3fWY7TszHsVKb
         ji+cBvOfo+s2oXl1p7r+f4tYGF0Aih2esdKnU0ydSjIKqjcFTf8jCfyejDSVj+Ps+B
         mAa36pFe/0pb4v/Gm8aDSu+WejeO2YnOhxROvGoThKjjCr8y8TbhbVd/fc4GB1YDAf
         +CBuciPZfkcdDm/tZT0yJ0QQAMrjsAHOz89fNYWJrP68MhChKYKSrUBEOC7OFngJaL
         WerTabkpdk5mTaN1RfsKRfK+jJ1Dh3+RzWR7EBmPKI00pl0baPYSp9WNnCtI89oUBr
         gnn+1U9myhbyRDyoK/2yIsA+zZgU/jplG8A/LNXMJsfHd8s26W3hdJHt3ArOognoGr
         CpXsPRVkmlY2E9g3SGQr4ru3grdbAvKcSAZ3qiRUHqMcWbuf2rlR9YOd1lExrqGJP7
         /YAhQaSLqqRBYEXi8eO2Z/rowwlVRlF1PDyd21iaQ9s8lR2Xwg5
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v2 04/11] t0002: abstract away SHA-1 specific constants
Date:   Sun, 19 Aug 2018 17:53:44 +0000
Message-Id: <20180819175351.449973-5-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.18.0.1017.ga543ac7ca45
In-Reply-To: <20180819175351.449973-1-sandals@crustytoothpaste.net>
References: <20180819175351.449973-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adjust the test so that it computes variables for object IDs instead of
using hard-coded hashes.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t0002-gitfile.sh | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/t/t0002-gitfile.sh b/t/t0002-gitfile.sh
index 3691023d51..aa17023774 100755
--- a/t/t0002-gitfile.sh
+++ b/t/t0002-gitfile.sh
@@ -92,11 +92,12 @@ test_expect_success 'enter_repo non-strict mode' '
 		mv .git .realgit &&
 		echo "gitdir: .realgit" >.git
 	) &&
+	head=$(git -C enter_repo rev-parse HEAD) &&
 	git ls-remote enter_repo >actual &&
-	cat >expected <<-\EOF &&
-	946e985ab20de757ca5b872b16d64e92ff3803a9	HEAD
-	946e985ab20de757ca5b872b16d64e92ff3803a9	refs/heads/master
-	946e985ab20de757ca5b872b16d64e92ff3803a9	refs/tags/foo
+	cat >expected <<-EOF &&
+	$head	HEAD
+	$head	refs/heads/master
+	$head	refs/tags/foo
 	EOF
 	test_cmp expected actual
 '
@@ -107,20 +108,20 @@ test_expect_success 'enter_repo linked checkout' '
 		git worktree add  ../foo refs/tags/foo
 	) &&
 	git ls-remote foo >actual &&
-	cat >expected <<-\EOF &&
-	946e985ab20de757ca5b872b16d64e92ff3803a9	HEAD
-	946e985ab20de757ca5b872b16d64e92ff3803a9	refs/heads/master
-	946e985ab20de757ca5b872b16d64e92ff3803a9	refs/tags/foo
+	cat >expected <<-EOF &&
+	$head	HEAD
+	$head	refs/heads/master
+	$head	refs/tags/foo
 	EOF
 	test_cmp expected actual
 '
 
 test_expect_success 'enter_repo strict mode' '
 	git ls-remote --upload-pack="git upload-pack --strict" foo/.git >actual &&
-	cat >expected <<-\EOF &&
-	946e985ab20de757ca5b872b16d64e92ff3803a9	HEAD
-	946e985ab20de757ca5b872b16d64e92ff3803a9	refs/heads/master
-	946e985ab20de757ca5b872b16d64e92ff3803a9	refs/tags/foo
+	cat >expected <<-EOF &&
+	$head	HEAD
+	$head	refs/heads/master
+	$head	refs/tags/foo
 	EOF
 	test_cmp expected actual
 '
