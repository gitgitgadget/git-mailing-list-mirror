Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8ECCD1F406
	for <e@80x24.org>; Sun, 13 May 2018 02:25:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751991AbeEMCZP (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 May 2018 22:25:15 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:45214 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751851AbeEMCZO (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 12 May 2018 22:25:14 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:64f1:3b3f:8f13:59ed])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id D624760742;
        Sun, 13 May 2018 02:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1526178311;
        bh=t576ojGFsRiMEkPGa4Hn9wThwswnOWW6bCcV3zcUgJA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=Dlb7nkLa5mP3tnLZBYq2odDCqWAIm/eLTz1fLYDU0YubuxtQwjZy+20aY+lL7ZZRJ
         H4jF+Q0gFf0GM1XaM7hljTEnd14KOHJ6a2S6q9voFbFjn5hU3n+0FN7SrB/EGxW7A3
         pKuuaX4vJ/yImzbZdXYmpxk/LUoV2kfGkjXKMSjvhN5+YFacaCFIOkYtuiceHwCOcK
         mmvekNZF0U3AFZjfl4c9FcWjMEgvtMbwrTHthy9njWFzWJVFTToo+JgWO21gF2DA2F
         OYj6zGEbO14JJ4/gW8wO8N4Jb7LwUGn/GZzRqW4p3Svm79+WX764lVFJmqjvJadgLW
         V/KW+SDjU3XAufgWn8xWU2dRsw74l1o+Nq98hmWis78fKAMfuxKsvj/UEKCQwTm7sc
         0/SkATZC9kpkdc2mgJIgKo42d1bDx9O5PKC/oiEniKCUIvP+FwAMkrB1rNOXAEn4L9
         3ud5VfKQNY2B1FSI8NuFN+D8yLazrOodi8dV59XgniUie5qfldo
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 04/28] t/test-lib: introduce OID_REGEX
Date:   Sun, 13 May 2018 02:24:14 +0000
Message-Id: <20180513022438.60003-5-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d
In-Reply-To: <20180513022438.60003-1-sandals@crustytoothpaste.net>
References: <20180513022438.60003-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently we have a variable, $_x40, which contains a regex that matches
a full 40-character hex constant.  However, with NewHash, we'll have
object IDs that are longer than 40 characters.  In such a case, $_x40
will be a confusing name.  Create a $OID_REGEX variable which will
always reflect a regex matching the appropriate object ID, regardless of
the length of the current hash.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/test-lib.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 58c2ea52c6..fed21c3dfc 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -184,6 +184,7 @@ _x40="$_x35$_x05"
 # Zero SHA-1
 _z40=0000000000000000000000000000000000000000
 
+OID_REGEX="$_x40"
 ZERO_OID=$_z40
 EMPTY_TREE=4b825dc642cb6eb9a060e54bf8d69288fbee4904
 EMPTY_BLOB=e69de29bb2d1d6434b8b29ae775ad8c2e48c5391
@@ -196,7 +197,7 @@ LF='
 # when case-folding filenames
 u200c=$(printf '\342\200\214')
 
-export _x05 _x35 _x40 _z40 LF u200c EMPTY_TREE EMPTY_BLOB ZERO_OID
+export _x05 _x35 _x40 _z40 LF u200c EMPTY_TREE EMPTY_BLOB ZERO_OID OID_REGEX
 
 # Each test should start with something like this, after copyright notices:
 #
