Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B9A11FADF
	for <e@80x24.org>; Thu, 18 Jan 2018 14:51:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932434AbeAROvW (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jan 2018 09:51:22 -0500
Received: from mail-lf0-f65.google.com ([209.85.215.65]:45729 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756624AbeAROvT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jan 2018 09:51:19 -0500
Received: by mail-lf0-f65.google.com with SMTP id x196so6992276lfd.12
        for <git@vger.kernel.org>; Thu, 18 Jan 2018 06:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:in-reply-to
         :references;
        bh=jxFZnz7v4UjOo3fQlEkx1N17KsOdUYWAtqjEBdFMLI8=;
        b=qoEyujYaPFvYJhIDClkyjYVK+NoAsikrIuixSRH4Osi7ZbKFyRJ1XosW7EI/hiaxm8
         em0YOv8n+Ewq7QkkcbL2It2wbt0zIV+kX6baa5dT9uTef7xyK98TvoFwugXVVwC3WQey
         LT7nJBrVVfHobZ3if6W3gWarfaoHPePKn34Q5UzPFSKb0Zw6Sd3Jp7dfb0MDkZqdy07Q
         L/QzwihlKLh0MW6s620dboOKapnK7ci3mvIiL9gW7c66aSI0Wmb90O+d1Amrj2fFgYd/
         bF+SHS5coo05J9t2923ORkIieyUabOQO433Bnx05RHv6hyQ/zK2Xcap0TFi3rc6Nuvq4
         8Vvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=jxFZnz7v4UjOo3fQlEkx1N17KsOdUYWAtqjEBdFMLI8=;
        b=YjpfdhUFJcfuUZu6hw144KwRuKjcZ9mb0X7xuXI7P8/svGThvwJlj02OISq2DJ8F1K
         5buqnol1zFRGjGC0eXGyh2VNit+SC/JfCly8I5HlkaMOJu3Jkwn3PD0g3jqX8XWxcTir
         TliSvwWe1kSxoWRzqEPrhAIvkkkyWsbww0l59162tav9dg604Ey4gjVZyVszoLEUsHXI
         n6uq/WDmknJwA2+c/nfAV2qsO77ZLZcbLvR/r6eBEm8QCdAvmRgerLjUhMlCnEb8EDut
         qiKNyXwA6QaukO8w9Cdq7WrHf2liKEkVlKaw33eP37DO1L0UVYyd5SEjyECVsbfk6l1m
         FTiQ==
X-Gm-Message-State: AKwxytdDgH+12rbk3U12fT3bUj3fzfcMYaWLzkLxvGBJvNqqqf+pNFC4
        gOb/t6eKFUQgUFFWFIGMwYFQZHP6/bM=
X-Google-Smtp-Source: ACJfBoswQH47NZdodm+myWw7mt6EOFyWpkXlchpdJpaNdtFn9D0Akn/e+aMSRcls3UeMWVrqwkiJAQ==
X-Received: by 10.46.16.154 with SMTP id 26mr12536771ljq.119.1516287077849;
        Thu, 18 Jan 2018 06:51:17 -0800 (PST)
Received: from localhost.localdomain ([188.121.16.104])
        by smtp.gmail.com with ESMTPSA id 23sm560988lju.28.2018.01.18.06.51.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Jan 2018 06:51:17 -0800 (PST)
From:   Patryk Obara <patryk.obara@gmail.com>
To:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.ath.cx>
Subject: [PATCH 07/11] match-trees: convert splice_tree to object_id
Date:   Thu, 18 Jan 2018 15:50:59 +0100
Message-Id: <2793d5d0cf51090e3c0f072c497d745d7fd23002.1516282880.git.patryk.obara@gmail.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <cover.1516282880.git.patryk.obara@gmail.com>
References: <cover.1516282880.git.patryk.obara@gmail.com>
In-Reply-To: <cover.1516282880.git.patryk.obara@gmail.com>
References: <cover.1516282880.git.patryk.obara@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert the definition of static recursive splice_tree function to use
struct object_id and adjust single caller.

Signed-off-by: Patryk Obara <patryk.obara@gmail.com>
---
 match-trees.c | 42 ++++++++++++++++++++----------------------
 1 file changed, 20 insertions(+), 22 deletions(-)

diff --git a/match-trees.c b/match-trees.c
index 396b7338df..0f899a7212 100644
--- a/match-trees.c
+++ b/match-trees.c
@@ -161,19 +161,17 @@ static void match_trees(const struct object_id *hash1,
  * A tree "hash1" has a subdirectory at "prefix".  Come up with a
  * tree object by replacing it with another tree "hash2".
  */
-static int splice_tree(const unsigned char *hash1,
-		       const char *prefix,
-		       const unsigned char *hash2,
-		       unsigned char *result)
+static int splice_tree(const struct object_id *hash1, const char *prefix,
+		       const struct object_id *hash2, struct object_id *result)
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
+	buf = read_sha1_file(hash1->hash, &type, &sz);
 	if (!buf)
-		die("cannot read tree %s", sha1_to_hex(hash1));
+		die("cannot read tree %s", oid_to_hex(hash1));
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
+				    oid_to_hex(hash1));
+			rewrite_here = (struct object_id *)oid;
 			break;
 		}
 		update_tree_entry(&desc);
 	}
 	if (!rewrite_here)
-		die("entry %.*s not found in tree %s",
-		    toplen, prefix, sha1_to_hex(hash1));
+		die("entry %.*s not found in tree %s", toplen, prefix,
+		    oid_to_hex(hash1));
 	if (*subpath) {
-		status = splice_tree(rewrite_here, subpath, hash2, subtree);
+		status = splice_tree(rewrite_here, subpath, hash2, &subtree);
 		if (status)
 			return status;
-		rewrite_with = subtree;
-	}
-	else
+		rewrite_with = &subtree;
+	} else {
 		rewrite_with = hash2;
-	hashcpy(rewrite_here, rewrite_with);
-	status = write_sha1_file(buf, sz, tree_type, result);
+	}
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

