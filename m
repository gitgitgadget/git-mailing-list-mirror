Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E94391F51C
	for <e@80x24.org>; Mon, 21 May 2018 02:02:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752594AbeEUCCN (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 May 2018 22:02:13 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:50790 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751030AbeEUCCJ (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 20 May 2018 22:02:09 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:fc4d:8d90:22bd:91d8])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 3B9F360732;
        Mon, 21 May 2018 02:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1526868127;
        bh=IHQ1mhtKA9lPZdP8AMJUizBUZJoCkJ5360LQLFN1asQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=fL8WgG9JQjTWyX1nVHq8KtNGz0SrYL2jJxgactHOv9PlBxf4zHh/0wAMahL6SWwSr
         jMUHhsqOow/XHVgV58tkCM1OPDOfAVRuiEzPgEwxHOsxF+t5JHnOCqXmCi6vACOG8p
         zlM25aVWekpOdSyqtnJvhCe3MUoEQqsaqadI5IOza4ldRFP0vH913w2znJZ/t2CV8G
         UN6bszyZcb2uN/KEjwfy92Xy9Nl7a1I75a6CpWyRkZaLUcfOxGV9BZhoYA2TsG69iV
         7xEDG42nfs1B58IDwd2Adc/Xw4JrYmk3JOM9Ouq4VWtz9gOU0s4AujYdyNzYgCx2bB
         9E5Vgv06UTYrC2Bs7MQQeh7lYXVTbWkUbKabRhc187zqzTQzt78jw3UUNa98PYsjxa
         oisUWshXVBe5I/yjMc6drHNl8CXq9KcGf3dJX15dUA7pX0LtD9xHJ3a/cTDO98sNj9
         kAafpofSkOYtEh/p19PkHq8VFwH2IVB4uVtSElINHEVv/DcMFEJ
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH v4 02/28] t/test-lib: introduce ZERO_OID
Date:   Mon, 21 May 2018 02:01:21 +0000
Message-Id: <20180521020147.648496-3-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d
In-Reply-To: <20180521020147.648496-1-sandals@crustytoothpaste.net>
References: <20180516015630.661349-1-sandals@crustytoothpaste.net>
 <20180521020147.648496-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently we have a variable, $_z40, which contains the all-zero object
ID.  However, with NewHash, we'll have an all-zero object ID which is
longer than 40 hex characters.  In such a case, $_z40 will be a
confusing name.  Create a $ZERO_OID variable which will always reflect
the all-zeros object ID, regardless of the length of the current hash.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/test-lib.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index fce728d2ea..58c2ea52c6 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -184,6 +184,7 @@ _x40="$_x35$_x05"
 # Zero SHA-1
 _z40=0000000000000000000000000000000000000000
 
+ZERO_OID=$_z40
 EMPTY_TREE=4b825dc642cb6eb9a060e54bf8d69288fbee4904
 EMPTY_BLOB=e69de29bb2d1d6434b8b29ae775ad8c2e48c5391
 
@@ -195,7 +196,7 @@ LF='
 # when case-folding filenames
 u200c=$(printf '\342\200\214')
 
-export _x05 _x35 _x40 _z40 LF u200c EMPTY_TREE EMPTY_BLOB
+export _x05 _x35 _x40 _z40 LF u200c EMPTY_TREE EMPTY_BLOB ZERO_OID
 
 # Each test should start with something like this, after copyright notices:
 #
