Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8AE5621847
	for <e@80x24.org>; Wed,  2 May 2018 00:27:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753520AbeEBA1A (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 20:27:00 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37762 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753470AbeEBA0t (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 1 May 2018 20:26:49 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 0577B60B3C;
        Wed,  2 May 2018 00:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1525220808;
        bh=0LKYjvIG3xSCsRGG1QE9qSdeHFpvp7hiJ2+i8Rjb7o0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=D27RfIHb9hLHApWNNMtba8Jr+IbfQ/RXxeQcj9nNpZo6gWNvlBEAn2zHMTJ35WqtP
         tsgu3+Z7za8a2Rur3xGRXA/+r68uoFxaTEW52UgiDPXwephec5Bz04XTX0y45pwFNS
         6mkrmPPmjCIClg3JtN8n3SdzX3zeXnwR66DuPtTQ8wFwpIuDohei8Q14EH9iqnFXj1
         t9396+xLfR0QT3bbOr8y/4pRrPos7aZjFExVOmQ9PA3rNjGHX0rBWhabTpbacuK9SS
         gUjoy2p4/jT6nV16iBK0cEG/1BD3gIxXrgtDux0NULHv9HRr8hjEU5LzujjLLhU+EK
         1KvSBuBK4YXK1XDbiqsEh1PpLSPgwBDEERqzpq9jJIx9GlxLC2Yjj0Bw+/f73n1jdb
         QX4rfdWYb7aus8PmcJhmEPhY2lICwh3GwkMAFFF+O+nUlLfSS9Qc1tLgoDsD1fIC0y
         BMuGt/qORnwl8VsQy6MfRXwcTP5P96ITOQSds5M8ovRRZFG7+fn
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 27/42] builtin/am: convert uses of EMPTY_TREE_SHA1_BIN to the_hash_algo
Date:   Wed,  2 May 2018 00:25:55 +0000
Message-Id: <20180502002610.915892-28-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d
In-Reply-To: <20180502002610.915892-1-sandals@crustytoothpaste.net>
References: <20180502002610.915892-1-sandals@crustytoothpaste.net>
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
index d834f9e62b..206af06a18 100644
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
 
