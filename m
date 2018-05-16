Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C60FB1F406
	for <e@80x24.org>; Wed, 16 May 2018 01:59:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752588AbeEPB65 (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 May 2018 21:58:57 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:47470 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752289AbeEPB6z (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 15 May 2018 21:58:55 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:64f1:3b3f:8f13:59ed])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 6EE8D6074B;
        Wed, 16 May 2018 01:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1526435935;
        bh=Fqb8bmjnxCROGYtWRgjBR57rn9uqbvctuKrGC2JuG60=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=oqMANobWOwaV/RsSRbue9sAElfRXNI+X65OnDWGRqwCA5OGZF/Kaa1cvOzXvLTQ2l
         qkQ5T3Fkg3Mfz/JXzKA+gh2e5RqmJF0bL4fl/dELiyOe/dO/j373OyrtL/hfxMGwfX
         5L9Bdx/ETo/xjzJi5rXiJJZV74yAIDTI0dXlws0J2c9PWEJ+BR5qYRafAihSSMZ/4X
         yuRDjC4wOND5V2/l+3hxtMG2OmOa91o4yuTR/TKycZk2TVmeBxGCG91yN0vNXUMXNn
         tNtQEngyU3Aky+F9+NxVST88bhrvlLB01mMXbfmj3my9KvDWf0ofgGGOoRVeer+ZpC
         OuMH9AoTGCg5K7K7zsXMelVz6tzOlYewgw91Dx4G7wT3hqTLrtYBOfjaPtZ3R69+n+
         mBJzDJumHTIsC2WA00qjkOjwQRVfW689G7zZJ82nT05Mjt+qJIz1Z/c7wa4CQh69y5
         0MDLE0RsCFLjHd4SAHKzq67mRxR1XQsWUQfafi9SrJFv2nL82T0
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v3 18/28] t4020: abstract away SHA-1-specific constants
Date:   Wed, 16 May 2018 01:56:20 +0000
Message-Id: <20180516015630.661349-19-sandals@crustytoothpaste.net>
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
 t/t4020-diff-external.sh | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/t/t4020-diff-external.sh b/t/t4020-diff-external.sh
index 49d3f54b29..e009826fcb 100755
--- a/t/t4020-diff-external.sh
+++ b/t/t4020-diff-external.sh
@@ -13,6 +13,8 @@ test_expect_success setup '
 
 	test_tick &&
 	echo second >file &&
+	before=$(git hash-object file) &&
+	before=$(git rev-parse --short $before) &&
 	git add file &&
 	git commit -m second &&
 
@@ -180,9 +182,13 @@ test_expect_success 'no diff with -diff' '
 echo NULZbetweenZwords | perl -pe 'y/Z/\000/' > file
 
 test_expect_success 'force diff with "diff"' '
+	after=$(git hash-object file) &&
+	after=$(git rev-parse --short $after) &&
 	echo >.gitattributes "file diff" &&
 	git diff >actual &&
-	test_cmp "$TEST_DIRECTORY"/t4020/diff.NUL actual
+	sed -e "s/^index .*/index $before..$after 100644/" \
+		"$TEST_DIRECTORY"/t4020/diff.NUL >expected-diff &&
+	test_cmp expected-diff actual
 '
 
 test_expect_success 'GIT_EXTERNAL_DIFF with more than one changed files' '
@@ -237,7 +243,7 @@ test_expect_success 'diff --cached' '
 	git update-index --assume-unchanged file &&
 	echo second >file &&
 	git diff --cached >actual &&
-	test_cmp "$TEST_DIRECTORY"/t4020/diff.NUL actual
+	test_cmp expected-diff actual
 '
 
 test_expect_success 'clean up crlf leftovers' '
