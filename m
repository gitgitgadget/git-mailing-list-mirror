Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 315C7207BD
	for <e@80x24.org>; Sun, 23 Apr 2017 21:37:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1046260AbdDWVhw (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Apr 2017 17:37:52 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:37618 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1046099AbdDWVgJ (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 23 Apr 2017 17:36:09 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 6BF95280DB;
        Sun, 23 Apr 2017 21:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1492983342;
        bh=hTgGGA20LmJnUnupDn3xJ8XbbhwKqeKc0Ot5VforoSo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SNamPtYG0hXsGVwAsRkHaahfmjDMUavokFd5Ap5SousErHRmKz8cLPaiAU3KvfK9/
         k/UzxQrpwfZw0eQj7nCKTCMWPsLnnszptgjM1+YdBsZdsssRb5ddtvtcQLAR+xJeyG
         HXOC+fX7tn+zkI3KpllhtrfDqH1I8wMdCWU2+cyI61UEt55qvUqJvZ35cylwZK+Aa1
         A5OcP1R8jP5Ph1sMEFhk48S+gDd7pty3DkfilXmFPo62gSRs0FDM1Uj+axAprIyrbH
         X3hsj44BQ+6KbhQCugQq+NawmBXyYtzHfLTTpa9Ft54cXZHPedWDPZ62N9UnbrWaKf
         /mJ5M/Z196tZexlxEDE94KjMb5B3fuGARNrd431siMjVXDBcpKnQhGby2p2uizfEDB
         G51fLEKF4wo5cMNthF4wc3GJqFqUwWzRtYqTskXnqkxYqhK0s7WsuK09xjRflTKE54
         RqAykMrH3G0qr9vXHlRiymXuBKE6gcA1qMJvLhJj8LNDna5Xtp1
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 46/53] builtin/ls-files: convert overlay_tree_on_cache to object_id
Date:   Sun, 23 Apr 2017 21:34:46 +0000
Message-Id: <20170423213453.253425-47-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.12.2.762.g0e3151a226
In-Reply-To: <20170423213453.253425-1-sandals@crustytoothpaste.net>
References: <20170423213453.253425-1-sandals@crustytoothpaste.net>
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
index d449e46db..948c7066c 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -407,14 +407,14 @@ static void prune_cache(const char *prefix, size_t prefixlen)
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
 
