Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E795E202AB
	for <e@80x24.org>; Mon,  3 Jul 2017 18:55:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753227AbdGCSzt (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Jul 2017 14:55:49 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:52948 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752057AbdGCSzs (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 3 Jul 2017 14:55:48 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 57919280AE;
        Mon,  3 Jul 2017 18:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1499108146;
        bh=pe5YrZ54j2WuJd8S2/Cg8zTJd49z6hwLL+ENqZRwHXg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UuBWy0V0MbD8bst7Lla0nAA79P88SVJu1FPHMOxX89Tjs87Y2riwsEYdvORCti5FH
         2m9kQY9A0kEBZgU3QjHQD9kvTJhpQ8eemDkIx510+QLUC7Ec5D+KQaaXZQI5bya33s
         rg+GQiCAKWQSBjwNeSeg//9zttogeWk6b4pss2etqK9HLy1zj3gd+yA0Rg8SJo0m2W
         87WmadY5Itf22lYTFfIe8eI1VGCK43kSPAfdQxSxWwD5jplapI7TRDOEY/Jmu+sQ9d
         Si/RluRSTPSoK9Cdc8tSP/z/KlrNGSMwr9bIA18C9MXpzqnf/wFuaoyoWR+XyDqB4O
         OY0R5/e1QIRhFQQaxthmzudtQKBuDug4yv348KorZDy5DaFPdbBzf+u6SjVBJVbnBD
         YQ/7qPlcQ5+d51JfU7MZB3rLv0ujhrxV6vzcNTG7vmYMJ/7ti/EeaqDOrMedT74Fhn
         LkQH2Ki+KVMhcKsLvUt4KJ7Xw1f7q1QLe+w5j/+wlo02jJa/LwB
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>
Subject: [PATCH 01/12] builtin/fsck: convert remaining caller of get_sha1 to object_id
Date:   Mon,  3 Jul 2017 18:55:22 +0000
Message-Id: <20170703185533.51530-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.13.2.753.g7f5404b18
In-Reply-To: <20170703185533.51530-1-sandals@crustytoothpaste.net>
References: <20170703185533.51530-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/fsck.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 87c675689..d601d07fd 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -738,12 +738,12 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 	heads = 0;
 	for (i = 0; i < argc; i++) {
 		const char *arg = argv[i];
-		unsigned char sha1[20];
-		if (!get_sha1(arg, sha1)) {
-			struct object *obj = lookup_object(sha1);
+		struct object_id oid;
+		if (!get_oid(arg, &oid)) {
+			struct object *obj = lookup_object(oid.hash);
 
 			if (!obj || !(obj->flags & HAS_OBJ)) {
-				error("%s: object missing", sha1_to_hex(sha1));
+				error("%s: object missing", oid_to_hex(&oid));
 				errors_found |= ERROR_OBJECT;
 				continue;
 			}
