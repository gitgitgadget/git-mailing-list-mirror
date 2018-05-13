Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8C3C1F406
	for <e@80x24.org>; Sun, 13 May 2018 02:26:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752078AbeEMC0A (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 May 2018 22:26:00 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:45402 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752061AbeEMCZ7 (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 12 May 2018 22:25:59 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:64f1:3b3f:8f13:59ed])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id C52E060739;
        Sun, 13 May 2018 02:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1526178358;
        bh=ErIE0H1kG2jznWXK3yQv/94VWxvzJ0dZX3YsSLqJaNQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=NEj4IaGibS4iQVD/YLwi0hHrDBMFTK04W3CJebrW8gUjAzWe36RNajauC7RKUHUL1
         pTuL4H5Vcr0STrl5i1Obpd0BnozuZExZM45r0bVzU4/25XN7F1bB1cpqKyDpAGYajS
         LAIOjSsO+Mrb5DLokk051oRGzAgthGIUYrkHJpqdxptcRFkamVQfMvfwinN7dGxH65
         PBFzrBEFV4EK+AAr9yFLaBK5kj2up3M6wHui3717UMZphvGGv+kkMmW4w4JBpJ/Z83
         UC08Juqho3+iuMpYpt1hu0a/Y4urs9kNOQUCHAjX5Hz8MqhtwzHUjQWhbCBIHrI7UG
         SODteHRh+w4GNADcX86fgXF8K7iONk1uQ5oeplDhFLA5i1gtcUd27ETvDT6qTUSAEl
         TazcitZyjfyXO8TtVrhlOKN/LTNQS3DL58tHhhzdJ3kc3svuv2dyWdiGFAvUkgFhgB
         lx9HFH1pw7FcXxNouuXjokqyySUjDVtSZ0UMT8S8c1SLuK25FJx
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 26/28] t4045: abstract away SHA-1-specific constants
Date:   Sun, 13 May 2018 02:24:36 +0000
Message-Id: <20180513022438.60003-27-sandals@crustytoothpaste.net>
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
 t/t4045-diff-relative.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/t4045-diff-relative.sh b/t/t4045-diff-relative.sh
index 6471a68701..36f8ed8a81 100755
--- a/t/t4045-diff-relative.sh
+++ b/t/t4045-diff-relative.sh
@@ -8,6 +8,7 @@ test_expect_success 'setup' '
 	echo content >file1 &&
 	mkdir subdir &&
 	echo other content >subdir/file2 &&
+	blob=$(git hash-object subdir/file2) &&
 	git add . &&
 	git commit -m one
 '
@@ -17,10 +18,11 @@ check_diff () {
 	shift
 	expect=$1
 	shift
+	short_blob=$(git rev-parse --short $blob)
 	cat >expected <<-EOF
 	diff --git a/$expect b/$expect
 	new file mode 100644
-	index 0000000..25c05ef
+	index 0000000..$short_blob
 	--- /dev/null
 	+++ b/$expect
 	@@ -0,0 +1 @@
@@ -68,7 +70,7 @@ check_raw () {
 	expect=$1
 	shift
 	cat >expected <<-EOF
-	:000000 100644 0000000000000000000000000000000000000000 25c05ef3639d2d270e7fe765a67668f098092bc5 A	$expect
+	:000000 100644 0000000000000000000000000000000000000000 $blob A	$expect
 	EOF
 	test_expect_success "--raw $*" "
 		git -C '$dir' diff --no-abbrev --raw $* HEAD^ >actual &&
