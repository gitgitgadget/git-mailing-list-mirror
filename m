Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A74CD1F424
	for <e@80x24.org>; Mon, 23 Apr 2018 23:40:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932798AbeDWXkv (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 19:40:51 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:60654 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932775AbeDWXkj (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 23 Apr 2018 19:40:39 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 831E86099F;
        Mon, 23 Apr 2018 23:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1524526837;
        bh=RI6VzCNpeffqA4xlvTrPoELpNd8ImF8Y7n1OAtLLr98=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=ytQR4927qRRrBUMfoB9gSfcpZiHqA77BMUG4hFZMtEMdG6ummrSKsCOD6LR8sN0vM
         hmkTnZqhXJlRB07vOIiS/YeVP1CENY5Fc+Tdn8z7LBxjpI01XpsgXheu+2yMpKVtBP
         AlUfdoxudcK1GL/tjIeu2+B5mYMqdPcTfn88AhfcnaDTtyf7Pa10t4pw9UsWEyKiGa
         E9h9Y+QvCarLTFlQPn6NLzIzfvsaYiQjgPLJvHB0hxBnrwUYtSYRYUxian8ih75JpG
         zbQNr4lgWGxdQLIfvnLhy0rz+9xUvOY+rt4Yu//qh1/n5jrLk7kaWiTJNAF9NUB8lX
         Rp15bcjgOV8yt5WsngCJLj1/+G2exgmB6VcnYhtz+eBkOXB35heX/pgZy0QCfPdpq0
         DSlHwmXfp3u2T1yTXwPyslpERN1AOdMOnj9oTAZT9yGDhPEVf1egRq5zJI/UnqWVVa
         HH2HfsmKdWkSb0zK0+01ZRo3GPyP34b8rOYr2mS4cBVcTjhlEyp
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 30/41] submodule: convert several uses of EMPTY_TREE_SHA1_HEX
Date:   Mon, 23 Apr 2018 23:39:40 +0000
Message-Id: <20180423233951.276447-31-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180423233951.276447-1-sandals@crustytoothpaste.net>
References: <20180423233951.276447-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert several uses of EMPTY_TREE_SHA1_HEX to use oid_to_hex and
the_hash_algo to avoid a dependency on a given hash algorithm.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 submodule.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/submodule.c b/submodule.c
index 9a50168b23..22a96b7af0 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1567,7 +1567,7 @@ static void submodule_reset_index(const char *path)
 				   get_super_prefix_or_empty(), path);
 	argv_array_pushl(&cp.args, "read-tree", "-u", "--reset", NULL);
 
-	argv_array_push(&cp.args, EMPTY_TREE_SHA1_HEX);
+	argv_array_push(&cp.args, oid_to_hex(the_hash_algo->empty_tree));
 
 	if (run_command(&cp))
 		die("could not reset submodule index");
@@ -1659,9 +1659,9 @@ int submodule_move_head(const char *path,
 		argv_array_push(&cp.args, "-m");
 
 	if (!(flags & SUBMODULE_MOVE_HEAD_FORCE))
-		argv_array_push(&cp.args, old_head ? old_head : EMPTY_TREE_SHA1_HEX);
+		argv_array_push(&cp.args, old_head ? old_head : oid_to_hex(the_hash_algo->empty_tree));
 
-	argv_array_push(&cp.args, new_head ? new_head : EMPTY_TREE_SHA1_HEX);
+	argv_array_push(&cp.args, new_head ? new_head : oid_to_hex(the_hash_algo->empty_tree));
 
 	if (run_command(&cp)) {
 		ret = -1;
