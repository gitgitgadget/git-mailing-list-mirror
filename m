Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C86F1F406
	for <e@80x24.org>; Sun, 13 May 2018 02:26:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752038AbeEMCZr (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 May 2018 22:25:47 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:45302 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752007AbeEMCZp (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 12 May 2018 22:25:45 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:64f1:3b3f:8f13:59ed])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id A876F6073E;
        Sun, 13 May 2018 02:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1526178345;
        bh=00NHiwA3V9AXjQzL1ROJt/TPi54L+pcIN8x/QSEaIH8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=nKq39wB7tgPBqj/job3p9XM0uNMeOgKcfbV25rQia7G/KFoxO5dXDZ9+Ra8r3V2c8
         wytD1oqQOm/lMZ9pUhRCVUPCP6bF2P26+2cVtE1MOmP1JWcdXRlLf7VBYVu5SCcqHR
         044ZIiFw9QOU5HowI0R18NwFg2kPC/qWoniVawDowNkQ3E2SuNh6Zy167acGa9p850
         SbQEJCUJJRXYP9QDfJYATWWI5dgwflUwNvPwNIa8pIen9irLsGSancTza6QAP60aVN
         8APyWrevp/f0p28C6l0UE9y4GHRk0lPu5mXdjXwp76NAYWW3Nk9rvgRrxspPafRgYT
         00HX5zEMha4zmHotPgd1zl2Mj69yg28z86wB+/PwVS68SW/58/R53S3DJweLeXFD19
         aO7tFS6BYF7mu+R8it5xG7pdkTrivBwko3arTwyk9jfBTQgBP4zaXDKQ0IndovNgij
         2I2fPfQUjieV9eNn7D3JalQ5VgaRaABRwdkHFPImk7GjiaxSR+S
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 14/28] t3905: abstract away SHA-1-specific constants
Date:   Sun, 13 May 2018 02:24:24 +0000
Message-Id: <20180513022438.60003-15-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d
In-Reply-To: <20180513022438.60003-1-sandals@crustytoothpaste.net>
References: <20180513022438.60003-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adjust the test so that it computes variables for blobs instead of using
hard-coded hashes.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t3905-stash-include-untracked.sh | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/t/t3905-stash-include-untracked.sh b/t/t3905-stash-include-untracked.sh
index 3ea5b9bb3f..597b0637d1 100755
--- a/t/t3905-stash-include-untracked.sh
+++ b/t/t3905-stash-include-untracked.sh
@@ -35,24 +35,26 @@ test_expect_success 'stash save --include-untracked cleaned the untracked files'
 	test_cmp expect actual
 '
 
+tracked=$(git rev-parse --short $(echo 1 | git hash-object --stdin))
+untracked=$(git rev-parse --short $(echo untracked | git hash-object --stdin))
 cat > expect.diff <<EOF
 diff --git a/HEAD b/HEAD
 new file mode 100644
-index 0000000..d00491f
+index 0000000..$tracked
 --- /dev/null
 +++ b/HEAD
 @@ -0,0 +1 @@
 +1
 diff --git a/file2 b/file2
 new file mode 100644
-index 0000000..d00491f
+index 0000000..$tracked
 --- /dev/null
 +++ b/file2
 @@ -0,0 +1 @@
 +1
 diff --git a/untracked/untracked b/untracked/untracked
 new file mode 100644
-index 0000000..5a72eb2
+index 0000000..$untracked
 --- /dev/null
 +++ b/untracked/untracked
 @@ -0,0 +1 @@
@@ -109,10 +111,11 @@ test_expect_success 'stash save -u dirty index' '
 	git stash -u
 '
 
+blob=$(git rev-parse --short $(echo 4 | git hash-object --stdin))
 cat > expect <<EOF
 diff --git a/file3 b/file3
 new file mode 100644
-index 0000000..b8626c4
+index 0000000..$blob
 --- /dev/null
 +++ b/file3
 @@ -0,0 +1 @@
