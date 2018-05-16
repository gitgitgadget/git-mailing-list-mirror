Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 46C4E1F406
	for <e@80x24.org>; Wed, 16 May 2018 01:59:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752622AbeEPB7H (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 May 2018 21:59:07 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:47554 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752610AbeEPB7F (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 15 May 2018 21:59:05 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:64f1:3b3f:8f13:59ed])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id CDC596074B;
        Wed, 16 May 2018 01:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1526435943;
        bh=ErIE0H1kG2jznWXK3yQv/94VWxvzJ0dZX3YsSLqJaNQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=QEDLuNivXY7Q39JMajXNMLUJFZM6F/J5c0d1jeNehbm8k+QIrnPnn7MrKqErffIu3
         pgwsYXQYTEevlKNC3F9eLdb9nT0KRE8poMfutJd22od3pNIT2rKKZJreCbYOJeo/wT
         zn7uy5dMMedc/Nfim8W9YdWlGQYeW7V6C1HHMCS1Izfm4FKgkKS2bclr1Gs98t+7wQ
         G+McdTdM2ZpZ3Q/1Mzl5IDuY5/KjVLY3E9WC7PeFbMkzt0XlvX1KOeqb/ZVQeP6PvE
         0mNzsIrqCpKATqQT469XUBFJqxqcMDnSJ2Z4i16cZqqDQm1nxgqbrXwNtQkAegUaTL
         9QL0ufiS9cpXA5HBnC6b8fuftiOC8ycQAf+KtbC4XBju5mn53U0Ff0n9V/OCdqy5Wj
         xl/sl35twR2xwW9H0DmCimLhmU45NvUc1BjOnjpQr+yP70scj6stfA9XDg4PdNOS6b
         0rQkPaz0IY+MF8cNErDFZhQmWoOKEyMsJRsQsTPkbz2L03JLMpG
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v3 26/28] t4045: abstract away SHA-1-specific constants
Date:   Wed, 16 May 2018 01:56:28 +0000
Message-Id: <20180516015630.661349-27-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d
In-Reply-To: <20180516015630.661349-1-sandals@crustytoothpaste.net>
References: <20180516015630.661349-1-sandals@crustytoothpaste.net>
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
