Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE4A71F424
	for <e@80x24.org>; Mon, 23 Apr 2018 23:41:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932791AbeDWXlW (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 19:41:22 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:60700 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932779AbeDWXkl (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 23 Apr 2018 19:40:41 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 01441609A1;
        Mon, 23 Apr 2018 23:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1524526840;
        bh=ezDJTlYjmbPx6WM18V925HyrNxDepRgICPqUAcqBzcg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=06CWn4aeKh3GyUgLqAoZiEXN2UW/SDReuYXV2Kj90xRPpHJROE1IWKC0d13mz4mik
         JfK5bHCncW9mU/sDDdfyGeiaO9/3+zKk4jermrzYSM2l2od/T+ZFGRlyIqh/Fv/3qj
         7boVlQHHA3hyjUipFqZxtCb9Bkq037Y4ulfJJTOYqP7M4tZbhZc4JMcFR1oz5ncYdP
         GvwIx72Rhf88UyVLMGWntzHOYgvitByXMrKWB9hra1+yLYnGdaYeg0eIMj2mAokXoC
         kDNRnXWnEsUn/0gnNtKILrwbYCQCP+YXAbo4DMmfpozDZSFzwSFmx2a8PPxseu9YnJ
         I6R7C88jyB3eTfktWvfPnvyYqD/HUMe5a7att48xPBwkU+MCPJoXuN/pvHtx+sMPH1
         mZPnVq30oroqk5D0M31KkCf0NUq+HTivYwQYL8IlZ4OTG0vzG5ubd3O4BXqzVeg9N7
         y5q4ikzUCCUGMNB2R/CP5bzFeDulEQtXSKcKS72Pas2cS04eXBJ
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 32/41] builtin/receive-pack: convert one use of EMPTY_TREE_SHA1_HEX
Date:   Mon, 23 Apr 2018 23:39:42 +0000
Message-Id: <20180423233951.276447-33-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180423233951.276447-1-sandals@crustytoothpaste.net>
References: <20180423233951.276447-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert one use of EMPTY_TREE_SHA1_HEX to use oid_to_hex and
the_hash_algo to avoid a dependency on a given hash algorithm.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/receive-pack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 5f35596c14..c31ceb30c2 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -968,7 +968,7 @@ static const char *push_to_deploy(unsigned char *sha1,
 		return "Working directory has unstaged changes";
 
 	/* diff-index with either HEAD or an empty tree */
-	diff_index[4] = head_has_history() ? "HEAD" : EMPTY_TREE_SHA1_HEX;
+	diff_index[4] = head_has_history() ? "HEAD" : oid_to_hex(the_hash_algo->empty_tree);
 
 	child_process_init(&child);
 	child.argv = diff_index;
