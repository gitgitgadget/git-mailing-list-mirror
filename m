Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92A5D1F406
	for <e@80x24.org>; Wed, 16 May 2018 01:59:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752591AbeEPB66 (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 May 2018 21:58:58 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:47442 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752535AbeEPB6y (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 15 May 2018 21:58:54 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:64f1:3b3f:8f13:59ed])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 647A86074A;
        Wed, 16 May 2018 01:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1526435933;
        bh=b8Cmj3rpDBGYASOmH0kWFYygqK8O5kIz3q+5PI1NQZc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=sYEsEfAXdlmVpRG8DKGCDUDDKVaojifA8mwyEBwojLxRPPYPukrcVXlsgyMEI5ANa
         GbBX87qxeiQto+x4oGuf+gFQ43mVuG0MoSoGj7QlwZrcldsjk4I3pnAGBGkCCMKH/y
         bVEJhwkIgvee4Oj3yqsx/8kcqsLWtvQr6j478u1x7wdwSKJwf1ujYfZoEX8jlouhOy
         vFHEiD7L/f5CuB80xPJe/skBvlBHtznAnYSkOPImIC/Fm0qNAK9g5oR0hRMlV3dva5
         SRSLI3DnZELKpjhRiEK2FUNr6PJZonANyNwoOHkV+cdJCK6Ud7x/YgQNtm2Iv+7Nrg
         ORhgnQXlF0Pz6Qs38FxMwDyL5Gt0OcjX6dW6kZpZ4Pe3Df0fm3VYbMIA3UdgfBgwXk
         Hk7pAy/4uhIUKokZNN5a9sRMQH25lyB1sCni2cchg9zqVx6gkzsXefbwG/fKlaethh
         CSAPtTzHDb8T4t2fsFdApaqSXaED2XwRhOsBeeirNtDgzDixqfN
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v3 17/28] t4014: abstract away SHA-1-specific constants
Date:   Wed, 16 May 2018 01:56:19 +0000
Message-Id: <20180516015630.661349-18-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d
In-Reply-To: <20180516015630.661349-1-sandals@crustytoothpaste.net>
References: <20180516015630.661349-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adjust the test so that it computes values for blobs instead of using
hard-coded hashes.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t4014-format-patch.sh | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index dac3f349a3..349029f43b 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -578,7 +578,11 @@ test_expect_success 'excessive subject' '
 
 	rm -rf patches/ &&
 	git checkout side &&
+	before=$(git hash-object file) &&
+	before=$(git rev-parse --short $before) &&
 	for i in 5 6 1 2 3 A 4 B C 7 8 9 10 D E F; do echo "$i"; done >>file &&
+	after=$(git hash-object file) &&
+	after=$(git rev-parse --short $after) &&
 	git update-index file &&
 	git commit -m "This is an excessively long subject line for a message due to the habit some projects have of not having a short, one-line subject at the start of the commit message, but rather sticking a whole paragraph right at the start as the only thing in the commit message. It had better not become the filename for the patch." &&
 	git format-patch -o patches/ master..side &&
@@ -586,7 +590,6 @@ test_expect_success 'excessive subject' '
 '
 
 test_expect_success 'cover-letter inherits diff options' '
-
 	git mv file foo &&
 	git commit -m foo &&
 	git format-patch --no-renames --cover-letter -1 &&
@@ -616,7 +619,7 @@ test_expect_success 'shortlog of cover-letter wraps overly-long onelines' '
 '
 
 cat > expect << EOF
-index 40f36c6..2dc5c23 100644
+index $before..$after 100644
 --- a/file
 +++ b/file
 @@ -13,4 +13,20 @@ C
@@ -640,7 +643,7 @@ test_expect_success 'format-patch respects -U' '
 cat > expect << EOF
 
 diff --git a/file b/file
-index 40f36c6..2dc5c23 100644
+index $before..$after 100644
 --- a/file
 +++ b/file
 @@ -14,3 +14,19 @@ C
