Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FCFC1F404
	for <e@80x24.org>; Sun, 25 Feb 2018 21:13:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751985AbeBYVNA (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Feb 2018 16:13:00 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:33964 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751948AbeBYVMt (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 25 Feb 2018 16:12:49 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 9116060E5A;
        Sun, 25 Feb 2018 21:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1519593168;
        bh=AiN6MUHA779NJFN7C1av5+6y4YCEqAQ6XHZprcSa9qg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=kEhp7VNLVG2/OOfYZWFwaflNG+1nXPKARKjInIpWQs6uhSEHeBepnEgAXbe0rF/J/
         4HPqyyK/7EIgeREuBcKNtGU10JU+M5YyQMHJgYm8wPnyva26u9VQne/hOlN6tp90f9
         k+NP5ePh/pXBexHE6aJR8e7JFKPVQrV2BtvQYDGbbs69xpXxFoNUsT0+z03TxCdY6I
         riAL5WmMwUjyxjEGXNFvsyxiMIPZCxh6P6aaJd7in50r5xjdcN3JFnVg1jeMdnIPz5
         O+i4dZr1Lz/Eo7i5W1E6tBkyI/3cc8wT8WIl+cxuF9cViji3B6XkQ1qCLEM1XKe1x4
         QvLHiq4qDs7LWq3aJGdQTbPkwfEn99hAFs3GMcCigyOfMWass0pxU+zIpjcV5+gfwb
         S9vy9KGDkLq9iFy2+39SMKHC+7wBa7pnQ9DTHTUPws4TnGpNjwq03sJCfS4jPaUAEx
         DyLaJ+NzNrklRFisZEQGy842cq8mdUw/DK8TbBUhXl9xnH+crD7
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Patryk Obara <patryk.obara@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 22/36] sha1_file: convert assert_sha1_type to object_id
Date:   Sun, 25 Feb 2018 21:11:58 +0000
Message-Id: <20180225211212.477570-23-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.16.2.395.g2e18187dfd
In-Reply-To: <20180225211212.477570-1-sandals@crustytoothpaste.net>
References: <20180225211212.477570-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert this function to take a pointer to struct object_id and rename
it to assert_oid_type.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/commit-tree.c | 2 +-
 cache.h               | 2 +-
 commit.c              | 2 +-
 sha1_file.c           | 8 ++++----
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/builtin/commit-tree.c b/builtin/commit-tree.c
index e5bdf57b1e..ecf42191da 100644
--- a/builtin/commit-tree.c
+++ b/builtin/commit-tree.c
@@ -58,7 +58,7 @@ int cmd_commit_tree(int argc, const char **argv, const char *prefix)
 				usage(commit_tree_usage);
 			if (get_oid_commit(argv[i], &oid))
 				die("Not a valid object name %s", argv[i]);
-			assert_sha1_type(oid.hash, OBJ_COMMIT);
+			assert_oid_type(&oid, OBJ_COMMIT);
 			new_parent(lookup_commit(&oid), &parents);
 			continue;
 		}
diff --git a/cache.h b/cache.h
index f29ff43bbd..b1a117e404 100644
--- a/cache.h
+++ b/cache.h
@@ -1275,7 +1275,7 @@ extern int has_object_file_with_flags(const struct object_id *oid, int flags);
  */
 extern int has_loose_object_nonlocal(const unsigned char *sha1);
 
-extern void assert_sha1_type(const unsigned char *sha1, enum object_type expect);
+extern void assert_oid_type(const struct object_id *oid, enum object_type expect);
 
 /* Helper to check and "touch" a file */
 extern int check_and_freshen_file(const char *fn, int freshen);
diff --git a/commit.c b/commit.c
index e8a49b9c84..b9f028976f 100644
--- a/commit.c
+++ b/commit.c
@@ -1517,7 +1517,7 @@ int commit_tree_extended(const char *msg, size_t msg_len,
 	int encoding_is_utf8;
 	struct strbuf buffer;
 
-	assert_sha1_type(tree->hash, OBJ_TREE);
+	assert_oid_type(tree, OBJ_TREE);
 
 	if (memchr(msg, '\0', msg_len))
 		return error("a NUL byte in commit log message not allowed.");
diff --git a/sha1_file.c b/sha1_file.c
index 5dc85122c3..fa69d86309 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1966,13 +1966,13 @@ int read_pack_header(int fd, struct pack_header *header)
 	return 0;
 }
 
-void assert_sha1_type(const unsigned char *sha1, enum object_type expect)
+void assert_oid_type(const struct object_id *oid, enum object_type expect)
 {
-	enum object_type type = sha1_object_info(sha1, NULL);
+	enum object_type type = sha1_object_info(oid->hash, NULL);
 	if (type < 0)
-		die("%s is not a valid object", sha1_to_hex(sha1));
+		die("%s is not a valid object", oid_to_hex(oid));
 	if (type != expect)
-		die("%s is not a valid '%s' object", sha1_to_hex(sha1),
+		die("%s is not a valid '%s' object", oid_to_hex(oid),
 		    typename(expect));
 }
 
