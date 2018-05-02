Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8572721847
	for <e@80x24.org>; Wed,  2 May 2018 00:27:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753599AbeEBA13 (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 20:27:29 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37912 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753545AbeEBA1H (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 1 May 2018 20:27:07 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id CB74D609A1;
        Wed,  2 May 2018 00:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1525220826;
        bh=ReQtlHI0b9wRMkJ9v0f3rk2DW2+3ouZBfGpq1BSbI+c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=qDIuiW6B4DuBO+UeuumDbeKa6HZyk5BhDaNv55FqpKYJlLDcqFpQOSFi+9r0huNWl
         b6L5XprZDDKjEdstuoSMXrA/lvVEpX7bRa6zodVh+6fGWknsfx9MYR3QIx2wk0SwDQ
         1NqOJLIAB7mwbk3SPgZSCYliy/aYD9WIVKvLouWhRmevZT6W4QblnqU6Zd97gHPs+U
         BybSvG7TdYcXHP2kjDg4VRX0j63QNhfotIBmWmQvMXeX5FJ/V1wdJ67qbiqGnyh5kq
         ikgo5dskbNFFaKhlYkvHbim95Ohiz1D1mROcjojXOAQuC1Gs5iJO8TOI4ZrG86o3ZM
         LAmjTOZKHMsl2E99K7f25VwGjcXIiYcJoC0RC3rSeq7HMiwCiQZ9CFlGIgnjMOZXrl
         McFwR3Vtbj8GLtWyNUk/WgvqPnDztz+IrV8/ktPFf3x6qgznTwcbhA/c58eduGFuuA
         oTNoZNQJ/bMke9A6gvQXzEUmZOfNAwrDnIvEVdn5mu1OT8/nynD
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 42/42] merge-one-file: compute empty blob object ID
Date:   Wed,  2 May 2018 00:26:10 +0000
Message-Id: <20180502002610.915892-43-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d
In-Reply-To: <20180502002610.915892-1-sandals@crustytoothpaste.net>
References: <20180502002610.915892-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This script hard-codes the object ID of the empty blob.  To avoid any
problems when changing hashes, compute this value by calling git
hash-object.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 git-merge-one-file.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-merge-one-file.sh b/git-merge-one-file.sh
index 9879c59395..f6d9852d2f 100755
--- a/git-merge-one-file.sh
+++ b/git-merge-one-file.sh
@@ -120,7 +120,7 @@ case "${1:-.}${2:-.}${3:-.}" in
 	case "$1" in
 	'')
 		echo "Added $4 in both, but differently."
-		orig=$(git unpack-file e69de29bb2d1d6434b8b29ae775ad8c2e48c5391)
+		orig=$(git unpack-file $(git hash-object /dev/null))
 		;;
 	*)
 		echo "Auto-merging $4"
