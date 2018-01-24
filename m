Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 911181F576
	for <e@80x24.org>; Wed, 24 Jan 2018 11:12:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933238AbeAXLM1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 06:12:27 -0500
Received: from mail-lf0-f66.google.com ([209.85.215.66]:44505 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933166AbeAXLMT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 06:12:19 -0500
Received: by mail-lf0-f66.google.com with SMTP id v188so4701072lfa.11
        for <git@vger.kernel.org>; Wed, 24 Jan 2018 03:12:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:in-reply-to
         :references;
        bh=h3bmnLy1TpLcZnJgQq5WrClr6s8o9JofBu1CKx0nRV8=;
        b=jUH1R4PE5kJqrjROTptMulNnf6hDco5+XojSLpG+XGShYWZM5Teb98pQU36g1lFSXF
         0wQqD3DwMGbj2qgt+TGsFv0ybFUdC7j0oMwfN7SwWJb2DH38ZWCa1XTCqsqiCx29lWph
         2oI8Wn0K6mK2HPobHgmneyrJGsf/4EvMN9iu9qlikutl0pAoc+/2Hb4vVLHiFneP8gBy
         ef7/K0aticTvYPCNr0b4Ln+r6ECvxnvfJQrgICHW9Go1Fin07Cv+7vT/VxnHdoRz94O+
         b8UNvrN29ZfljVTiLkMWnYTUctrF1/AHtHEPKW0f1os5+fTTKmZR12e7pr2QiBQyaKzI
         JIaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=h3bmnLy1TpLcZnJgQq5WrClr6s8o9JofBu1CKx0nRV8=;
        b=iqYR3lQtW6HXIIU3loSLiyvgKl/v8i+L13e/arFlw2k8xWqLVqO3HLGo+ZejpkkHJi
         daVwPzGccXIlxIBadwEFsYCsPZtm5rMHX0RyKTSDUhr6ZMDK/DKKkRN2ssgFzNsR8JGt
         493WtledDcz574B8S3kPuSmjqVGBVKp3f81GjM3xvgakqhS6kddhwc0LP0l9JXO+PXdm
         mB76h65y+7XsqHPhzeo4cpqKsv6gNUN+jy0f4xE0jQR1qGlhiS1YppIitbWsQ87Blm/3
         53iluJu83MzmB6agA1BnKANWUx0vuJtLGndM03emT56H/x25Ug+d0giRQCSAvqDfziUl
         wc4g==
X-Gm-Message-State: AKwxytcajYJWwM59g8TW1VlD6EXjxJIFA6Mw5pRjMNMU+UiwOO7Jak6Q
        4nHZivq4F/ajQSSXzqQ6dLlKJ+om
X-Google-Smtp-Source: AH8x226K1nCAfub+HxbXe4j8TOzlH07BUK17Ez14dRlVMOaLatP6PR2Oh/n5S/Vi+mBh8l1eKsbyFA==
X-Received: by 10.25.17.20 with SMTP id g20mr2988726lfi.124.1516792337574;
        Wed, 24 Jan 2018 03:12:17 -0800 (PST)
Received: from localhost.localdomain ([188.121.16.104])
        by smtp.gmail.com with ESMTPSA id i18sm14426ljd.27.2018.01.24.03.12.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Jan 2018 03:12:16 -0800 (PST)
From:   Patryk Obara <patryk.obara@gmail.com>
To:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH v3 07/14] match-trees: convert splice_tree to object_id
Date:   Wed, 24 Jan 2018 12:11:59 +0100
Message-Id: <cb58f6566ec5c7f6677123047e7e6ed7c5d73065.1516790478.git.patryk.obara@gmail.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <cover.1516790478.git.patryk.obara@gmail.com>
References: <cover.1516617960.git.patryk.obara@gmail.com>
 <cover.1516790478.git.patryk.obara@gmail.com>
In-Reply-To: <cover.1516790478.git.patryk.obara@gmail.com>
References: <cover.1516790478.git.patryk.obara@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert the definition of static recursive splice_tree function to use
struct object_id and adjust single caller.

Signed-off-by: Patryk Obara <patryk.obara@gmail.com>
---
 match-trees.c | 46 ++++++++++++++++++++++------------------------
 1 file changed, 22 insertions(+), 24 deletions(-)

diff --git a/match-trees.c b/match-trees.c
index 396b7338df..afb771c4f5 100644
--- a/match-trees.c
+++ b/match-trees.c
@@ -158,22 +158,20 @@ static void match_trees(const struct object_id *hash1,
 }
 
 /*
- * A tree "hash1" has a subdirectory at "prefix".  Come up with a
- * tree object by replacing it with another tree "hash2".
+ * A tree "oid1" has a subdirectory at "prefix".  Come up with a tree object by
+ * replacing it with another tree "oid2".
  */
-static int splice_tree(const unsigned char *hash1,
-		       const char *prefix,
-		       const unsigned char *hash2,
-		       unsigned char *result)
+static int splice_tree(const struct object_id *oid1, const char *prefix,
+		       const struct object_id *oid2, struct object_id *result)
 {
 	char *subpath;
 	int toplen;
 	char *buf;
 	unsigned long sz;
 	struct tree_desc desc;
-	unsigned char *rewrite_here;
-	const unsigned char *rewrite_with;
-	unsigned char subtree[20];
+	struct object_id *rewrite_here;
+	const struct object_id *rewrite_with;
+	struct object_id subtree;
 	enum object_type type;
 	int status;
 
@@ -182,9 +180,9 @@ static int splice_tree(const unsigned char *hash1,
 	if (*subpath)
 		subpath++;
 
-	buf = read_sha1_file(hash1, &type, &sz);
+	buf = read_sha1_file(oid1->hash, &type, &sz);
 	if (!buf)
-		die("cannot read tree %s", sha1_to_hex(hash1));
+		die("cannot read tree %s", oid_to_hex(oid1));
 	init_tree_desc(&desc, buf, sz);
 
 	rewrite_here = NULL;
@@ -197,26 +195,26 @@ static int splice_tree(const unsigned char *hash1,
 		if (strlen(name) == toplen &&
 		    !memcmp(name, prefix, toplen)) {
 			if (!S_ISDIR(mode))
-				die("entry %s in tree %s is not a tree",
-				    name, sha1_to_hex(hash1));
-			rewrite_here = (unsigned char *) oid->hash;
+				die("entry %s in tree %s is not a tree", name,
+				    oid_to_hex(oid1));
+			rewrite_here = (struct object_id *)oid;
 			break;
 		}
 		update_tree_entry(&desc);
 	}
 	if (!rewrite_here)
-		die("entry %.*s not found in tree %s",
-		    toplen, prefix, sha1_to_hex(hash1));
+		die("entry %.*s not found in tree %s", toplen, prefix,
+		    oid_to_hex(oid1));
 	if (*subpath) {
-		status = splice_tree(rewrite_here, subpath, hash2, subtree);
+		status = splice_tree(rewrite_here, subpath, oid2, &subtree);
 		if (status)
 			return status;
-		rewrite_with = subtree;
+		rewrite_with = &subtree;
+	} else {
+		rewrite_with = oid2;
 	}
-	else
-		rewrite_with = hash2;
-	hashcpy(rewrite_here, rewrite_with);
-	status = write_sha1_file(buf, sz, tree_type, result);
+	oidcpy(rewrite_here, rewrite_with);
+	status = write_sha1_file(buf, sz, tree_type, result->hash);
 	free(buf);
 	return status;
 }
@@ -280,7 +278,7 @@ void shift_tree(const struct object_id *hash1,
 	if (!*add_prefix)
 		return;
 
-	splice_tree(hash1->hash, add_prefix, hash2->hash, shifted->hash);
+	splice_tree(hash1, add_prefix, hash2, shifted);
 }
 
 /*
@@ -334,7 +332,7 @@ void shift_tree_by(const struct object_id *hash1,
 		 * shift tree2 down by adding shift_prefix above it
 		 * to match tree1.
 		 */
-		splice_tree(hash1->hash, shift_prefix, hash2->hash, shifted->hash);
+		splice_tree(hash1, shift_prefix, hash2, shifted);
 	else
 		/*
 		 * shift tree2 up by removing shift_prefix from it
-- 
2.14.3

