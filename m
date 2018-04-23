Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D2D81F424
	for <e@80x24.org>; Mon, 23 Apr 2018 23:41:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932806AbeDWXlA (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 19:41:00 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:60722 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932795AbeDWXkv (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 23 Apr 2018 19:40:51 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 06BCE609A2;
        Mon, 23 Apr 2018 23:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1524526850;
        bh=4VOzy+8AG+sW/c6Uis/XofbpH1ic7jBKZOIXS3fKOqs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=YcUXseCVI5cbAbIUqAvB9VM97Cb7ws/E3f9IeqN1JE2F6Uxjc7Sdlnzn7vNHII+tq
         5/N98SYDMOu5z/kuR5VXksagUZrZfhzr7NqZu3m9mfTodo9unsrKHY8L/l1NxmQBrW
         CsRZAoroLiOyFflDRkiONSww2Bl6vv9yq3h4ljtHc/mdybbp2IY5lrFoB/AtdBeiUn
         sHEishsdGgs3GhAk/M6e+7zFb9rbNx+totKBCxlwcMVeIcyYn9ukfwXbibCa1U6qBn
         4zzBEy2qbrk2GKYR5CMlZovcDXhLECbkLIgBL8eqnIRZ0uYq9A9lmnVhsFfFWstPgK
         WocvqdxlvvQw+OmMwwrPTcrcHtYt8Q5kTUqAT6zqAi5WkRym44CZWJHp6U0Aim/wPW
         Ycjbwyt2Tg82PsZeQjc5vD+pEBji7QY4DYxQ9ovvao0/wCDlgEMhMAm7+rbw6ZaFHp
         epgljgcAc8G0c3bMFTe8AFOii+HwPpSLSM3uYaydObmoJapzbyh
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 41/41] merge-one-file: compute empty blob object ID
Date:   Mon, 23 Apr 2018 23:39:51 +0000
Message-Id: <20180423233951.276447-42-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180423233951.276447-1-sandals@crustytoothpaste.net>
References: <20180423233951.276447-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This script hard-codes the object ID of the empty tree.  To avoid any
problems when changing hashes, compute this value by calling git
hash-object.
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
