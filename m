Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F2141F424
	for <e@80x24.org>; Mon, 23 Apr 2018 23:41:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932813AbeDWXlo (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 19:41:44 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:60654 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932748AbeDWXke (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 23 Apr 2018 19:40:34 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id C1EC060B3A;
        Mon, 23 Apr 2018 23:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1524526833;
        bh=PJ2RB1LYbNZITtIIfxuZwHgyimk4TvXXH3JUNpje7mM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=DFh3dq5QuF6wdfT/VLKcU2rT/WJEnB8NvUfJ1qmGSKG+AKjS/THTTBnOZGBsL79uf
         xoqh44kPLa9QVDH7500GU9f4Yw0Y6+co30uagKqlJ9gMvx4YIVe1NxuFZBrB8oLuqJ
         T1h7+g6RKiHnwjFF7Mwp/JeS7SZHlxNVkdBLwEKmlFRnA/OYpmoyy8zxtbXIMpWyTF
         ayUvS4p19eDUtH8p4BXJfn28l2P+qenUQB1OLXa/cXbvXBHms2C9cljEoeSYBZrlKL
         VLwzkljshpKYzSfdQUP4eWTw0ldfPj+OcIi10xGXlG0Zgtn+dG1aglmG6bnLKZsjUL
         AXinW+noyWgWctaWxs9AynBS5lUOnc09U/xVw7fViV5dmKBAMcpH5YT6bZ0VW+WjDL
         P5xdrYtZdKMQGa5RSjgkone6jYICyZevrz+5lTHtQoPElahP9xfqjwk83NPedm70Sj
         v+/++M6b+8IWz7/7JLvf7mixKEwoz+JhiMbzpWhv1QJb1s7iFbU
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 26/41] builtin/am: convert uses of EMPTY_TREE_SHA1_BIN to the_hash_algo
Date:   Mon, 23 Apr 2018 23:39:36 +0000
Message-Id: <20180423233951.276447-27-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180423233951.276447-1-sandals@crustytoothpaste.net>
References: <20180423233951.276447-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert several uses of EMPTY_TREE_SHA1_BIN to use the_hash_algo
and struct object_id instead.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/am.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 9c82603f70..f445fcb593 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1542,7 +1542,7 @@ static int fall_back_threeway(const struct am_state *state, const char *index_pa
 	char *their_tree_name;
 
 	if (get_oid("HEAD", &our_tree) < 0)
-		hashcpy(our_tree.hash, EMPTY_TREE_SHA1_BIN);
+		oidcpy(&our_tree, the_hash_algo->empty_tree);
 
 	if (build_fake_ancestor(state, index_path))
 		return error("could not build fake ancestor");
@@ -2042,7 +2042,7 @@ static void am_skip(struct am_state *state)
 	am_rerere_clear();
 
 	if (get_oid("HEAD", &head))
-		hashcpy(head.hash, EMPTY_TREE_SHA1_BIN);
+		oidcpy(&head, the_hash_algo->empty_tree);
 
 	if (clean_index(&head, &head))
 		die(_("failed to clean index"));
@@ -2105,11 +2105,11 @@ static void am_abort(struct am_state *state)
 	curr_branch = resolve_refdup("HEAD", 0, &curr_head, NULL);
 	has_curr_head = curr_branch && !is_null_oid(&curr_head);
 	if (!has_curr_head)
-		hashcpy(curr_head.hash, EMPTY_TREE_SHA1_BIN);
+		oidcpy(&curr_head, the_hash_algo->empty_tree);
 
 	has_orig_head = !get_oid("ORIG_HEAD", &orig_head);
 	if (!has_orig_head)
-		hashcpy(orig_head.hash, EMPTY_TREE_SHA1_BIN);
+		oidcpy(&orig_head, the_hash_algo->empty_tree);
 
 	clean_index(&curr_head, &orig_head);
 
