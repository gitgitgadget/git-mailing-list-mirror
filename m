Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73E21200B9
	for <e@80x24.org>; Sun,  6 May 2018 23:18:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752025AbeEFXSz (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 May 2018 19:18:55 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41142 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751960AbeEFXSq (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 6 May 2018 19:18:46 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 997496076A;
        Sun,  6 May 2018 23:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1525648725;
        bh=swiDRvMFXAekF35rtfuX+euzFmCyNWdrbdBBo9L9cjQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=gAFWVyuE4kUQO/vQ7FLMoQl5nLs5G2DFMtIAT21IopUiwi5Zm+UBIvXncx5Dk//oc
         1sFc4FT8X4FZSVJg/yP+ZBObC/vSiFvOYxMegCneUFVN1fG44O5HPZKa0yimEmNgrW
         m9dy5yYHMeg+HF/i6YXNhEkfBhLxvwevhuqMO3SV1AP6g5g3tox7MnA/SpE+prQOZM
         4PABL6XckclmvkffmOEb+/OX2Hjj+NbHyWDxLO3yKpoJhhr7+grqdO7h1qdSuoZ8fe
         8bVDs4Cd1eWFmlOcDW1u4aV9SslbU6RCrRHG+vR4uznKitaadtvszf5QOsUhz90Bij
         UQALu3mRNNWqrIAHj8O/wMLgvtQ8XrqmKl0MPcT4zIpDsl/C2RrqqnKt6QyWtxG5jV
         DjJJPc+8LmZZYd34kI8789ASGlprPdj0a7B7wNcZD2XvLkYzlniR7dLGHAwJtXexpU
         F6nZ+NfQZ1luuH+cc+5l0rSv0FHnBbhG9xeuZKRQBXFR/+KPyDA
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH 14/28] t3905: abstract away SHA-1-specific constants
Date:   Sun,  6 May 2018 23:17:38 +0000
Message-Id: <20180506231752.975110-15-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d
In-Reply-To: <20180506231752.975110-1-sandals@crustytoothpaste.net>
References: <20180506231752.975110-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adjust the test so that it computes variables for blobs instead of using
hard-coded hashes.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t3905-stash-include-untracked.sh | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/t/t3905-stash-include-untracked.sh b/t/t3905-stash-include-untracked.sh
index 3ea5b9bb3f..c073514385 100755
--- a/t/t3905-stash-include-untracked.sh
+++ b/t/t3905-stash-include-untracked.sh
@@ -34,25 +34,26 @@ test_expect_success 'stash save --include-untracked cleaned the untracked files'
 	git status --porcelain >actual &&
 	test_cmp expect actual
 '
-
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
@@ -109,10 +110,11 @@ test_expect_success 'stash save -u dirty index' '
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
