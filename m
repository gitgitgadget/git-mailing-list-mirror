Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E16F21847
	for <e@80x24.org>; Wed,  2 May 2018 00:27:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753612AbeEBA1h (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 20:27:37 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37836 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753393AbeEBA04 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 1 May 2018 20:26:56 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 5D783609A0;
        Wed,  2 May 2018 00:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1525220815;
        bh=5iq/hRk/SoMQcDiSuhxSdsBEzZgzDXP1J4dI/pWs+Es=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=JV3wXI6H7Li2007o18zpWox3Q7MsCpYtio1m8CkTtzC7EHbQpWym7mXtKwKZcdd98
         32YviysM6T3aG0ImG/vY9/qUtZrKSoVFeHz2nooLltwSN6y3UBAh2DRxp3BnXXPMHx
         UVAFMGTWWXyTjbjMoXvlM3e3fpSS/cK4u1DBc1ay9Ik1rLV4fyrf7HfFAH3Dbpk7ui
         fqT2qYnXjvSw7A5+d1ZBqfLvqN3zRYsMHN2RvbxxaywGhS/6NiPrK7CG6YyfL5Lz1/
         qgpmWJJAiMEoY5GyiCDBKf8fw6QvIHtQSkkaso6ONFzkIS0z++y585t1rGyz6MnCCu
         Fo2+sWeBrphWYsZYiPjz2xnwuD7Tihz/X0d8ftM9TY9qmJ8Ms6RREiKdzjvBZ/PAzs
         mIRf2uYM4e2li15iBzzlMs8ChgVJLEcxZaYlaJxdw/xXFaUqX+/yQWIa0vXQhML/hu
         WDuwDOL9BhC0wuPoFjYFHu/5smBTC6Kz9xdbI3/MOyKzbMYt0On
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 33/42] builtin/receive-pack: convert one use of EMPTY_TREE_SHA1_HEX
Date:   Wed,  2 May 2018 00:26:01 +0000
Message-Id: <20180502002610.915892-34-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d
In-Reply-To: <20180502002610.915892-1-sandals@crustytoothpaste.net>
References: <20180502002610.915892-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert one use of EMPTY_TREE_SHA1_HEX to use empty_tree_oid_hex to
avoid a dependency on a given hash algorithm.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/receive-pack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 6501d6b6cf..b6b3bc1334 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -968,7 +968,7 @@ static const char *push_to_deploy(unsigned char *sha1,
 		return "Working directory has unstaged changes";
 
 	/* diff-index with either HEAD or an empty tree */
-	diff_index[4] = head_has_history() ? "HEAD" : EMPTY_TREE_SHA1_HEX;
+	diff_index[4] = head_has_history() ? "HEAD" : empty_tree_oid_hex();
 
 	child_process_init(&child);
 	child.argv = diff_index;
