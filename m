Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E48F21847
	for <e@80x24.org>; Wed,  2 May 2018 00:27:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753622AbeEBA1m (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 20:27:42 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37814 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753411AbeEBA0z (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 1 May 2018 20:26:55 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 8CA2860B38;
        Wed,  2 May 2018 00:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1525220814;
        bh=OR2vvSQj2Rx6YSwXzeps1ipkoROB4p0HewjB/clU+IQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=TDByuGea0mkHUyVPB90z5NWqdUhLUfnmZDg5/1qKU14rkk9fLA49uaYws+2pkyGtm
         apvDCqtDD+Ga4G3PzO4QEVVNlVyeVGKc08QaoX5ppfdNGyW2FhvXkQPA5hO460Hfzm
         beWRwo8J7gcgYUhVOPYHfSdWIrE1HNM8Nwgaa77ymJmaPkO4K+qjfvVCvN/gbigLtj
         ll2ipU1tvoVoysseTOR3Upvc3Ylz+kSsOkWVLIvk02/3Kj+Kh9t3KqSBo4G3BuuRxl
         Q5z1BsGGgPIkRIBNnUWveScyY/RBlLv7/aLZCjPeRvKxupD39exjK72diyuuEWuRjm
         gUa2kJUA5tILhyzSvAjjsqG4dPl1RZx3IAiCq3a6fDHTZNNWGqtxzs1mWj4+U9RlA2
         n5KyZRKR+rgOHqy/qFMjuCL0TWrMki3o0A0KvCeMAbOAIRDOA2jVecYdfOWA0slytl
         QvEjAX4wZv0MgVzRNG1EYUNhBD4nHOjenfimWsto2wsKZmq7zej
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 31/42] submodule: convert several uses of EMPTY_TREE_SHA1_HEX
Date:   Wed,  2 May 2018 00:25:59 +0000
Message-Id: <20180502002610.915892-32-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d
In-Reply-To: <20180502002610.915892-1-sandals@crustytoothpaste.net>
References: <20180502002610.915892-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert several uses of EMPTY_TREE_SHA1_HEX to use empty_tree_oid_hex to
avoid a dependency on a given hash algorithm.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 submodule.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/submodule.c b/submodule.c
index 9a50168b23..ee7eea4877 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1567,7 +1567,7 @@ static void submodule_reset_index(const char *path)
 				   get_super_prefix_or_empty(), path);
 	argv_array_pushl(&cp.args, "read-tree", "-u", "--reset", NULL);
 
-	argv_array_push(&cp.args, EMPTY_TREE_SHA1_HEX);
+	argv_array_push(&cp.args, empty_tree_oid_hex());
 
 	if (run_command(&cp))
 		die("could not reset submodule index");
@@ -1659,9 +1659,9 @@ int submodule_move_head(const char *path,
 		argv_array_push(&cp.args, "-m");
 
 	if (!(flags & SUBMODULE_MOVE_HEAD_FORCE))
-		argv_array_push(&cp.args, old_head ? old_head : EMPTY_TREE_SHA1_HEX);
+		argv_array_push(&cp.args, old_head ? old_head : empty_tree_oid_hex());
 
-	argv_array_push(&cp.args, new_head ? new_head : EMPTY_TREE_SHA1_HEX);
+	argv_array_push(&cp.args, new_head ? new_head : empty_tree_oid_hex());
 
 	if (run_command(&cp)) {
 		ret = -1;
