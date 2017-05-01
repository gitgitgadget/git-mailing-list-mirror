Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 506E21F829
	for <e@80x24.org>; Mon,  1 May 2017 02:33:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S642409AbdEACdA (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Apr 2017 22:33:00 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:36046 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2999546AbdEACb0 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 30 Apr 2017 22:31:26 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id A05AF280B2;
        Mon,  1 May 2017 02:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1493605815;
        bh=8UI2oKXgbvWcYqUbOjf0DKULWPgoMyG02e1Xdpe/Hg8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZIC3YkO8gl4xuIYFK86+uUFD3YDu4pj/C11mcxavM0qnguoZ1aBcoVA6ZWk7NtBMJ
         hPcIHYWwQnOAoicFB9HHz98XXm8XaPoRtU6rPT1WGRJvwGRs0qVrZP1FUIXaYaQB6S
         Pg+FV/WOhFaE6x7f9zydJv/J9TFerf9DJNaoH5EKXpWWWtQANaUhdAb2hVSVfbnv3u
         06VDfvAXtKAD1O94k6HJHkOEsR0RNV/uIk5zbiWU8mcC8TyB8wUzvRQBS9tdiyP1B7
         F5grQr6qAOy3LL3brVpEBbjEMBnXWQ6k24brroqP0WqjDEXx8TT+1XMpVXD15umz6d
         EKXA427bzFjaZFL4vrf9nMRPGY/z/wCtTKfSDvqQO70chh0lTHgZB8hvYhGkgyyQgd
         zkMROvyoHqr2sp71E6Wv31DoalAmmjJBwGmMEVRZn+SKaonvd6kRGZmvU9RtWUqvHA
         DymrAoOcwsxq52pkMm4hALBokMeNHey8TcJzKkU2QnhKW2ppGhb
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 46/53] builtin/ls-files: convert overlay_tree_on_cache to object_id
Date:   Mon,  1 May 2017 02:29:39 +0000
Message-Id: <20170501022946.258735-47-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.13.0.rc0.306.g87b477812d
In-Reply-To: <20170501022946.258735-1-sandals@crustytoothpaste.net>
References: <20170501022946.258735-1-sandals@crustytoothpaste.net>
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
 
