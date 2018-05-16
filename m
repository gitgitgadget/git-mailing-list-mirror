Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E232E1F406
	for <e@80x24.org>; Wed, 16 May 2018 01:59:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752608AbeEPB7C (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 May 2018 21:59:02 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:47524 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752601AbeEPB7B (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 15 May 2018 21:59:01 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:64f1:3b3f:8f13:59ed])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id D30F760443;
        Wed, 16 May 2018 01:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1526435940;
        bh=bpafkCnGWOXAkjZtfjwOidjLfuBr/P8kAJMRSTCyA+s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=IAjqAl7UzO/QfeEFjJv+t9PGmwvYCr3tOf6mtGUSn0jPLUy/p0xXahvzu5TUb80HU
         rYYeLO3c8u9g2b+jd5YSmvWBPjqd1QFX8/xvOI6jdDVa8UTSUpnANNEAVFe6q/fjyd
         TeGNwZkO1+cJutcBgWeHwOkXRmQIad2VjG9XZrSjUCRSu7UN0RUIETT6jRNz7BrJoW
         mfZxO74bDaI6U7aidapeNbzoBCgC93Y4iMv2U9XcwMedgEZlius/+cGXi5qxxZ99bT
         gHH9E+6yCjmvEsPZNVSuyRRzCpK1sin4BA0RY/eyKsMgab9V5ZG9IinX3JUtNf623T
         zXftWN72+bjFluiCUvYzXUzqAS9ymeTtK0CaxPw2CSWFMkiI7DWTWXWHvbgdi6al9b
         t1eAAolAiXd1aiQdT4cny3AbsERuN5+qUpGjVm9ZXWwXWe2m85yE2bknCam/u7JuNs
         ojXN0P9eO6QAzrGtXnOlA5wlecC0a34xC5hJfiMd9vpMQyqTM2U
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v3 23/28] t/lib-diff-alternative: abstract away SHA-1-specific constants
Date:   Wed, 16 May 2018 01:56:25 +0000
Message-Id: <20180516015630.661349-24-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d
In-Reply-To: <20180516015630.661349-1-sandals@crustytoothpaste.net>
References: <20180516015630.661349-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adjust the test code so that it computes variables for blobs instead of
using hard-coded hashes.  This makes t4033 and t4050 (the patience and
histogram tests) pass.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/lib-diff-alternative.sh | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/t/lib-diff-alternative.sh b/t/lib-diff-alternative.sh
index 8b4dbf22d2..8d1e408bb5 100644
--- a/t/lib-diff-alternative.sh
+++ b/t/lib-diff-alternative.sh
@@ -59,9 +59,11 @@ int main(int argc, char **argv)
 }
 EOF
 
-	cat >expect <<\EOF
+	file1=$(git rev-parse --short $(git hash-object file1))
+	file2=$(git rev-parse --short $(git hash-object file2))
+	cat >expect <<EOF
 diff --git a/file1 b/file2
-index 6faa5a3..e3af329 100644
+index $file1..$file2 100644
 --- a/file1
 +++ b/file2
 @@ -1,26 +1,25 @@
@@ -136,9 +138,11 @@ e
 f
 EOF
 
-	cat >expect <<\EOF
+	uniq1=$(git rev-parse --short $(git hash-object uniq1))
+	uniq2=$(git rev-parse --short $(git hash-object uniq2))
+	cat >expect <<EOF
 diff --git a/uniq1 b/uniq2
-index b414108..0fdf397 100644
+index $uniq1..$uniq2 100644
 --- a/uniq1
 +++ b/uniq2
 @@ -1,6 +1,6 @@
