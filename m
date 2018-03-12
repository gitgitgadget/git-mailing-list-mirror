Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5AA341F404
	for <e@80x24.org>; Mon, 12 Mar 2018 02:28:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932606AbeCLC2k (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Mar 2018 22:28:40 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34408 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932420AbeCLC2j (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 11 Mar 2018 22:28:39 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id B868A610D4;
        Mon, 12 Mar 2018 02:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1520821718;
        bh=qYZZTaLDY0NvNm9iyhl+irt6OgkiCiyC0riN6natRm4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=thdmntc6mqGMlj8AnSdEM7xjTldXzsBE8Gvp5zlIHo/1kfi0KUNqNayZH/tj9hnFD
         rBCDMi34hVTG/tS9VS7i22YhJHYJPeHWoW+mUlvPz948tAXgW2NoPFYADvA1d3ZPlD
         Ohm6bAh1jQ41X57IlM++lQlVkOB2o4WZrwCIgDTOkrUGXt3VkeyR/aIUC3fA7yEN4w
         4P7ukw+MKFjhN2FZwe/ufSwrQyIXwD+UNsdLCmr2CguK4cqLXVjHOvJgZpjiTM+S4P
         JnfaXVcwvUP+9934qfDHSH+JBemhf23jUFl4HUIgTAws/+WwGMy0hQI1LEWCJpCSWL
         c6vgAZAYdr1+HTusWI5wbudbUVuleWGqCvpXPn/57XmdI2FfxLfajsv0sj0nm2tCyJ
         ueB3qTX41d+zIzzDvZoJyEw/YfeKL1v1U9XITTthNsql/2VMDuZZI549HKmhk4Awpk
         0EcQLfxOJ3FeC9yyIan5+ZFBIppXdURioupzn6GMGGoaJjqlkaH
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Patryk Obara <patryk.obara@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 22/36] sha1_file: convert assert_sha1_type to object_id
Date:   Mon, 12 Mar 2018 02:27:42 +0000
Message-Id: <20180312022756.483934-23-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.16.2.660.g709887971b
In-Reply-To: <20180312022756.483934-1-sandals@crustytoothpaste.net>
References: <20180312022756.483934-1-sandals@crustytoothpaste.net>
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
index 27b5fd8a39..67a04fcd12 100644
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
index 00c99c7272..6d77787af9 100644
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
index cdcba4483b..a307037e88 100644
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
 		    type_name(expect));
 }
 
