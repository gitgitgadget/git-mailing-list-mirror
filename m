Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CE861F51C
	for <e@80x24.org>; Mon, 21 May 2018 02:03:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751109AbeEUCDe (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 May 2018 22:03:34 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:51102 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752716AbeEUCDT (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 20 May 2018 22:03:19 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:fc4d:8d90:22bd:91d8])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id E5A6C60749;
        Mon, 21 May 2018 02:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1526868198;
        bh=ErIE0H1kG2jznWXK3yQv/94VWxvzJ0dZX3YsSLqJaNQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=LoidKwGvjolhDJh0P3vFUtptZWkZy96lUtY1xsIRiYhMO/FwWbgpX0qR/6NbyW+pk
         oBOOs8LCFpetgQXpBwoKI3I2/3d2HNGD5o6wNB+10dNFunkEBL+zGU2zNmfxCCaZyR
         /qQuU1Z3WkHMAQmBlHuv4UgtLF/DmBKNBAe9Xd5NZFvKJjE6nnH9lMugJTIubylPo8
         rHsnpuz6qNp1879oshfneLJ3DM2SqUqBhf3tUUsENh373zgXw8kcubZTovqJ5M2otZ
         vBp/wUsJAAtiZMnCBjjkUE+FTgqelMoLlvShmzix+xCHSPPvPPrCqxhc/yj+X7tCnZ
         loBHRfqlhVr26D3Y0xof8j6cEiOGRSVhQ/l3AETrCjW7f2mFzlpU7OXxjBYyV6Sl2V
         PwjYWRgd3Xy58QC+cmQ5QLyPKPprQSuWtWhjcduoVoX6UR4jhzgs9hKmK4zrU2aAqE
         WYotS5YVdnzwlSZCO5Xa+f2v70UlWaeAfZBxjiXmhJ6cm/oaQvp
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH v4 26/28] t4045: abstract away SHA-1-specific constants
Date:   Mon, 21 May 2018 02:01:45 +0000
Message-Id: <20180521020147.648496-27-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d
In-Reply-To: <20180521020147.648496-1-sandals@crustytoothpaste.net>
References: <20180516015630.661349-1-sandals@crustytoothpaste.net>
 <20180521020147.648496-1-sandals@crustytoothpaste.net>
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
