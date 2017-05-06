Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B0A8207F8
	for <e@80x24.org>; Sat,  6 May 2017 22:13:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754433AbdEFWNd (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 May 2017 18:13:33 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:37712 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754083AbdEFWL7 (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 6 May 2017 18:11:59 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 773DA280DA;
        Sat,  6 May 2017 22:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1494108678;
        bh=8UI2oKXgbvWcYqUbOjf0DKULWPgoMyG02e1Xdpe/Hg8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F5ckjyBRBWWNnQixHkhey/S5wDI06KJpmMbxadtc52VroyTR/IN4M8B0fIGdk9j3m
         z28jANiBrPZxwPSlJrEg5U2KpCavs9MXMcJL6K5MlTnSrQrY7KwD6u7Jzxwm08Ozjp
         HFXhOpoPGJSVLdfYtD/ZK7/Q2RJhvHziU1qPoJ385sXt8QmtensT6PZ/ynkT0CrhDK
         gxLhtb3nyQzROo1SMz8ly0iA+L+xU/xPJeAzccv7Q+qcMbY9bmDhhY62XyDN67JxoC
         NfJ4T8HsweVdoIPO0shGUX9o+47LRK7QOom1ejn6wUa1G9XTfaSP9Oq9wa18Hhp0Pm
         Gy+i304ktKCbnmAU2+rsjNtgN4o0ITKQqvVO8G1BvxyNVJMXSJc11IXl920wkSHlhf
         ArXMSbjbbXjZBaI5TzclRGkXSmItV4jShYt7k83oCEXUJCZMJmht8QNuMFcAv2BxTp
         j7AHbs5qS56wO2NVFybI0tsC+V2yVP/N09aPgDW4O2x70JIqoM7
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Brandon Williams <bmwill@google.com>
Subject: [PATCH v3 46/53] builtin/ls-files: convert overlay_tree_on_cache to object_id
Date:   Sat,  6 May 2017 22:10:31 +0000
Message-Id: <20170506221038.296722-47-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.13.0.rc1.294.g07d810a77f
In-Reply-To: <20170506221038.296722-1-sandals@crustytoothpaste.net>
References: <20170506221038.296722-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is another caller of parse_tree_indirect.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/ls-files.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index a6c70dbe9..da0ff849f 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -414,14 +414,14 @@ static void prune_cache(const char *prefix, size_t prefixlen)
 void overlay_tree_on_cache(const char *tree_name, const char *prefix)
 {
 	struct tree *tree;
-	unsigned char sha1[20];
+	struct object_id oid;
 	struct pathspec pathspec;
 	struct cache_entry *last_stage0 = NULL;
 	int i;
 
-	if (get_sha1(tree_name, sha1))
+	if (get_oid(tree_name, &oid))
 		die("tree-ish %s not found.", tree_name);
-	tree = parse_tree_indirect(sha1);
+	tree = parse_tree_indirect(oid.hash);
 	if (!tree)
 		die("bad tree-ish %s", tree_name);
 
