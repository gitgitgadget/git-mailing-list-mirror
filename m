Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 299861F406
	for <e@80x24.org>; Sun, 13 May 2018 02:25:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752063AbeEMCZ5 (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 May 2018 22:25:57 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:45338 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752031AbeEMCZv (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 12 May 2018 22:25:51 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:64f1:3b3f:8f13:59ed])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 28DD760744;
        Sun, 13 May 2018 02:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1526178350;
        bh=p2vCB/YVdCBSpcfjhwRNsE00G2jhOUAT6jcGCvp4ga0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=uc37S5JJ8tM/DsixJ7KfX5cfQE5nZwaultow5NWWzb8rWWTBQ4XUhqjt3h2HorgZ2
         /3fbSeRvMzsdP4zHHWPZyJ07Ea/UpDouDRxI1LLa7/Y7wGdp6k+07/b8nqar58oQnk
         DbsMsHzjUTthVa5rgYw7Ei8OLdjLkMMiUXu5BPm9GfD29WV6bICxx3k9hvSD6NUhj4
         Tsus4tMrN88wCdV2IyKUhFOzGKunph6/hK2rWLhM18rBQ1HJZgkj3RrdnrSzgrPEHJ
         0F458X0NXgGOxchbQHl+i9qnmUB2eiGARtsABVzQirL7h96licljtpZafdau24dZ8Y
         T2M1SYJLtbWXK8PRG15y0KKgLqjWZdsKsMM9v0M9y4X0hq2YSJQedww90GN8yyK0mn
         ZO1v8YhOPj8aXlTeTmM9IOryQe4wDy0DWfYEekXqaybMjT27CRn9CKEDoJRIvsYrkA
         kK3D8pwimGGDkrzFK2rTbk03jPbrDxpR3EoSjmGapTSPbFZ8x19
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 19/28] t4022: abstract away SHA-1-specific constants
Date:   Sun, 13 May 2018 02:24:29 +0000
Message-Id: <20180513022438.60003-20-sandals@crustytoothpaste.net>
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
 t/t4022-diff-rewrite.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/t/t4022-diff-rewrite.sh b/t/t4022-diff-rewrite.sh
index cb51d9f9d4..0f1287a8ce 100755
--- a/t/t4022-diff-rewrite.sh
+++ b/t/t4022-diff-rewrite.sh
@@ -13,6 +13,7 @@ test_expect_success setup '
 	  "nopqrstuvwxyzabcdefghijklmNOPQRSTUVWXYZABCDEFGHIJKLM" \
 	  <"$TEST_DIRECTORY"/../COPYING >test &&
 	echo "to be deleted" >test2 &&
+	blob=$(git rev-parse --short $(git hash-object test2)) &&
 	git add test2
 
 '
@@ -27,7 +28,7 @@ test_expect_success 'detect rewrite' '
 cat >expect <<EOF
 diff --git a/test2 b/test2
 deleted file mode 100644
-index 4202011..0000000
+index $blob..0000000
 --- a/test2
 +++ /dev/null
 @@ -1 +0,0 @@
@@ -43,7 +44,7 @@ test_expect_success 'show deletion diff without -D' '
 cat >expect <<EOF
 diff --git a/test2 b/test2
 deleted file mode 100644
-index 4202011..0000000
+index $blob..0000000
 EOF
 test_expect_success 'suppress deletion diff with -D' '
 
