Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF6541F404
	for <e@80x24.org>; Sun, 25 Mar 2018 19:21:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752019AbeCYTVV (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Mar 2018 15:21:21 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:42510 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751840AbeCYTVT (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 25 Mar 2018 15:21:19 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 419B66099D;
        Sun, 25 Mar 2018 19:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1522005678;
        bh=1+tbzYpfUJVJPQwgReZkBocitQzh+ei19L5ISI5LPpI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=d5tCRneHwaFQBvzG5wb7ZqVhFT6G/cl1IznR/O6qXfdmv2NSO3lDvX3twm9T4D5d7
         R6hk4PKulgMkBV9rBp0PWQcESX1x7RVyfnQlKSOc5Qnnv0fqVYzDfKZBq01WcJ6xmu
         ZZq7pk+hhLFenur9oYhkMfc3UiyQ4xI+sY6kot8vx27BTDSywPVkIylQJjqPlFQXlv
         Ihd5awSP13jCPA20z38cAEwghYHuv+9i102hCyWp/VjmFyj9tBjFMnryQlTrJ2mi4N
         3x55Y+Ds1stzzbDHBDFHFajgaoDH+joboB6xQU8x1avD4/XqM/TGIRKkm6H9Dv5HV6
         2SaARqgkYRKyoB+0pCw0VUPYmkRatotmenkn88HWwKMuzoS9fzMEsDV5bpsU3+fqFb
         KzmnveGBSQXlF0gH/GuPadkBMApJ7P261C/yFP21FRMUYUgpuZ9Jn0ocFkblQlv2jW
         d9bsG2TvAoSOGBKCS2s5HnaDXgTU0HUUIH5F56uPyFLybwLQ6QC
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH 05/10] t1411: abstract away SHA-1-specific constants
Date:   Sun, 25 Mar 2018 19:20:50 +0000
Message-Id: <20180325192055.841459-6-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.rc1.317.g4a561d2cc9
In-Reply-To: <20180325192055.841459-1-sandals@crustytoothpaste.net>
References: <20180325192055.841459-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adjust the test so that it uses a variable consisting of the current
HEAD instead of a hard-coded hash.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t1411-reflog-show.sh | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/t/t1411-reflog-show.sh b/t/t1411-reflog-show.sh
index 6ac7734d79..596907758d 100755
--- a/t/t1411-reflog-show.sh
+++ b/t/t1411-reflog-show.sh
@@ -10,6 +10,7 @@ test_expect_success 'setup' '
 	git commit -m one
 '
 
+commit=$(git rev-parse --short HEAD)
 cat >expect <<'EOF'
 Reflog: HEAD@{0} (C O Mitter <committer@example.com>)
 Reflog message: commit (initial): one
@@ -20,8 +21,8 @@ test_expect_success 'log -g shows reflog headers' '
 	test_cmp expect actual
 '
 
-cat >expect <<'EOF'
-e46513e HEAD@{0}: commit (initial): one
+cat >expect <<EOF
+$commit HEAD@{0}: commit (initial): one
 EOF
 test_expect_success 'oneline reflog format' '
 	git log -g -1 --oneline >actual &&
@@ -33,8 +34,8 @@ test_expect_success 'reflog default format' '
 	test_cmp expect actual
 '
 
-cat >expect <<'EOF'
-commit e46513e
+cat >expect <<EOF
+commit $commit
 Reflog: HEAD@{0} (C O Mitter <committer@example.com>)
 Reflog message: commit (initial): one
 Author: A U Thor <author@example.com>
@@ -56,8 +57,8 @@ test_expect_success 'using @{now} syntax shows reflog date (multiline)' '
 	test_cmp expect actual
 '
 
-cat >expect <<'EOF'
-e46513e HEAD@{Thu Apr 7 15:13:13 2005 -0700}: commit (initial): one
+cat >expect <<EOF
+$commit HEAD@{Thu Apr 7 15:13:13 2005 -0700}: commit (initial): one
 EOF
 test_expect_success 'using @{now} syntax shows reflog date (oneline)' '
 	git log -g -1 --oneline HEAD@{now} >actual &&
@@ -82,8 +83,8 @@ test_expect_success 'using --date= shows reflog date (multiline)' '
 	test_cmp expect actual
 '
 
-cat >expect <<'EOF'
-e46513e HEAD@{Thu Apr 7 15:13:13 2005 -0700}: commit (initial): one
+cat >expect <<EOF
+$commit HEAD@{Thu Apr 7 15:13:13 2005 -0700}: commit (initial): one
 EOF
 test_expect_success 'using --date= shows reflog date (oneline)' '
 	git log -g -1 --oneline --date=default >actual &&
@@ -109,8 +110,8 @@ test_expect_success 'log.date does not invoke "--date" magic (multiline)' '
 	test_cmp expect actual
 '
 
-cat >expect <<'EOF'
-e46513e HEAD@{0}: commit (initial): one
+cat >expect <<EOF
+$commit HEAD@{0}: commit (initial): one
 EOF
 test_expect_success 'log.date does not invoke "--date" magic (oneline)' '
 	test_config log.date raw &&
