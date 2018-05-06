Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 857C6200B9
	for <e@80x24.org>; Sun,  6 May 2018 23:19:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752038AbeEFXTA (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 May 2018 19:19:00 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41162 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751989AbeEFXSt (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 6 May 2018 19:18:49 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id BD7866076B;
        Sun,  6 May 2018 23:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1525648728;
        bh=Fhu1Oin9SuVpDzNg7rIriw5oIkgsGwiho1rufSikRQY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=Yn2Wv6d5nNPQSd68a2Pu7nIcPJ7GDryb6RSDLXQYEHqvuV8dD5p8LhQAdLryoYt4Z
         RDSI1+RBjERZsQtRgyy7RMpY/V3sw4xMhsm7a7L7gbXah6poLIzFkZ+SQvgR3xDWyi
         Rr7d2dR/auu/XnGqQmTBqyadri1VrurDFOZOmPTFme6rxDteXAKEhSN75UG0Jh718G
         YTttGp1sXHhxoZkBXmegqKsoyB1YuPbzfmKwBmXXRpxGupz3kcRsp5M6ayJzetSAIX
         +jhSF+bxrnGQ2Nf5TKhNuzWDO2uqHykHUFxB6NguPkUUov5Nw2B9yBpLejfdM7HSPv
         4v9EEfRrLUG3PiKFzEqG6pQp0PGXysBMcgsokH3g+Mf6n0tKWfLGThge7c0mxCMNH2
         rVhqfvX6Yt3/hlNt7Y2DX37eG+XZ27qHqQUKG7NCcWXPZuz9/Z3mq8/Ow9jVVOhVLe
         ZC8JiEeQ21IYa1/JsZIR+lY55LobGIy1o20yMN/6mvxZv25Iz4e
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH 17/28] t4014: abstract away SHA-1-specific constants
Date:   Sun,  6 May 2018 23:17:41 +0000
Message-Id: <20180506231752.975110-18-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d
In-Reply-To: <20180506231752.975110-1-sandals@crustytoothpaste.net>
References: <20180506231752.975110-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adjust the test so that it computes values for blobs instead of using
hard-coded hashes.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t4014-format-patch.sh | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 163d64fc32..eb34d0faab 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -578,7 +578,9 @@ test_expect_success 'excessive subject' '
 
 	rm -rf patches/ &&
 	git checkout side &&
+	before=$(git rev-parse --short $(git hash-object file)) &&
 	for i in 5 6 1 2 3 A 4 B C 7 8 9 10 D E F; do echo "$i"; done >>file &&
+	after=$(git rev-parse --short $(git hash-object file)) &&
 	git update-index file &&
 	git commit -m "This is an excessively long subject line for a message due to the habit some projects have of not having a short, one-line subject at the start of the commit message, but rather sticking a whole paragraph right at the start as the only thing in the commit message. It had better not become the filename for the patch." &&
 	git format-patch -o patches/ master..side &&
@@ -586,7 +588,6 @@ test_expect_success 'excessive subject' '
 '
 
 test_expect_success 'cover-letter inherits diff options' '
-
 	git mv file foo &&
 	git commit -m foo &&
 	git format-patch --no-renames --cover-letter -1 &&
@@ -616,7 +617,7 @@ test_expect_success 'shortlog of cover-letter wraps overly-long onelines' '
 '
 
 cat > expect << EOF
-index 40f36c6..2dc5c23 100644
+index $before..$after 100644
 --- a/file
 +++ b/file
 @@ -13,4 +13,20 @@ C
@@ -640,7 +641,7 @@ test_expect_success 'format-patch respects -U' '
 cat > expect << EOF
 
 diff --git a/file b/file
-index 40f36c6..2dc5c23 100644
+index $before..$after 100644
 --- a/file
 +++ b/file
 @@ -14,3 +14,19 @@ C
