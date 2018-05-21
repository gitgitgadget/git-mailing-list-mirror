Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56AE41F51C
	for <e@80x24.org>; Mon, 21 May 2018 02:02:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752678AbeEUCCy (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 May 2018 22:02:54 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:50930 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752643AbeEUCCu (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 20 May 2018 22:02:50 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:fc4d:8d90:22bd:91d8])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id B37B560750;
        Mon, 21 May 2018 02:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1526868169;
        bh=B0WpHZQ2MtRfayvCzy7VAOmmYh69cjuIEjzR7rLM2TM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=zQI1u3x5jF9w/2fWp7NzQW9WZ83P9Aq3sOflY8WbEnd1ZZ9Ab664tNQoCgS761TkR
         Lvw3Q3Dh+trQXXNNKeuYWSBmY+h0s28t66fkpxh+mJYZmk/Mr7BwibyxMrbpOMykJc
         rudyqMTox8NFXjHFsvRmkV48gbIe7Rid6FbCW4Yd1Y7HvxiTF2h236b5kdn9sSEhYV
         ubvsAy1kSkJv03mfumGHz+yPC7b3wTNVFA/TLm2iPOv+ZUoRWmgDVTHPKlvYY5Ik0n
         R2Bqyd7AFotsR4FWCtFw3kB2aqWlL+9aCoRemKrztz8u5ChtTQ1b6zGZBIHVA0tCpu
         IBr3v14aHf62ynjeLDmDY7Luid4bmqiA88q5CddWerkCCQCwLkv99e/LMvSeuAHeva
         9gOD22oMfzKdE1pPBblzuob9qrBYjORf+ET820/gbQpPGAKmZUaks0WN/lGO1eT1tn
         BaRTy1vpCPK3mnVrmjqMz0p5xM0kCTpZ8wYXrRdUDpyvLXT99ET
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH v4 13/28] t3702: abstract away SHA-1-specific constants
Date:   Mon, 21 May 2018 02:01:32 +0000
Message-Id: <20180521020147.648496-14-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d
In-Reply-To: <20180521020147.648496-1-sandals@crustytoothpaste.net>
References: <20180516015630.661349-1-sandals@crustytoothpaste.net>
 <20180521020147.648496-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Strip out the index lines in the diff before comparing them, as these
will differ between hash algorithms.  This leads to a smaller, simpler
change than editing the index line.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t3702-add-edit.sh | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/t/t3702-add-edit.sh b/t/t3702-add-edit.sh
index 3cb74ca296..c6af7f82b5 100755
--- a/t/t3702-add-edit.sh
+++ b/t/t3702-add-edit.sh
@@ -40,7 +40,6 @@ test_expect_success 'setup' '
 
 cat > expected-patch << EOF
 diff --git a/file b/file
-index b9834b5..9020acb 100644
 --- a/file
 +++ b/file
 @@ -1,11 +1,6 @@
@@ -80,7 +79,6 @@ EOF
 
 cat > expected << EOF
 diff --git a/file b/file
-index b9834b5..ef6e94c 100644
 --- a/file
 +++ b/file
 @@ -1,10 +1,12 @@
@@ -100,7 +98,7 @@ EOF
 
 echo "#!$SHELL_PATH" >fake-editor.sh
 cat >> fake-editor.sh <<\EOF
-mv -f "$1" orig-patch &&
+egrep -v '^index' "$1" >orig-patch &&
 mv -f patch "$1"
 EOF
 
@@ -113,7 +111,8 @@ test_expect_success 'add -e' '
 	git add -e &&
 	test_cmp second-part file &&
 	test_cmp orig-patch expected-patch &&
-	git diff --cached > out &&
+	git diff --cached >actual &&
+	grep -v index actual >out &&
 	test_cmp out expected
 
 '
