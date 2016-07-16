Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8611E20195
	for <e@80x24.org>; Sat, 16 Jul 2016 05:07:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751380AbcGPFG4 (ORCPT <rfc822;e@80x24.org>);
	Sat, 16 Jul 2016 01:06:56 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:33006 "EHLO
	mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751317AbcGPFGt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jul 2016 01:06:49 -0400
Received: by mail-lf0-f66.google.com with SMTP id f93so8092099lfi.0
        for <git@vger.kernel.org>; Fri, 15 Jul 2016 22:06:48 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u63moPqcimB7rGvh33v+PhJ0TF8a3/RV+Rfl1Cl1lIY=;
        b=Vn8tjCXB7n4TRrLqp8U/SQZg7Vv1JYIOiKFlYgJIyF5WUZXvy8ABZdSkMUYyS0ZIXM
         C6cCxkPuggac4tgWw3h7goKD5s7RWz0I9Hg2+6i6BT7jTRBbPZnHiGOOpTRGz64R7qUo
         LV5fa8WUmUB0HeinP5qZpLVBtUc/HZq/8dMcGhbzIuUmcnawE04tDnGinUcGfnll8wCC
         SoL1elJTkIJlUxwsaWek5Y3aMHfB23U3w+dM9sApU6ntvz/D2wwTEaakP4aeD4WKeSXY
         htflhQalO+xFYQ+bw1aM9yPSGr/++9sVDP5lDs6CJUwhv+qhVLqju7JRCQnHJsLxnWxZ
         JYTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u63moPqcimB7rGvh33v+PhJ0TF8a3/RV+Rfl1Cl1lIY=;
        b=B7l+CG+v++Ncy99bczExOMpQIzplzGhbRx1FHVDs8GvgYH5RRmb3LJCpi6QuPT1vTD
         pnLCO+S3qESAGkHLaOm37sRCrUnQf7KpL4DubCUy0CTCR4/nkuMlUrpW6x6WLw9AOLot
         ThtoxyqVEByjzGdBXJZohDUEOVEneeSt0+XuuBRVDA0lfe7xzV1vTniR4L7nwZJIUc7Z
         tTT1SHxo3ei4OGVttl6aHe2vQT4DDa5oZFJpWotxkSjWOpI7jpjYQagRLDxXIbT9OuSt
         awRBBHl8B9zRc7gCvU0lQVkl/t2NJEcxS3Qv9eAfhSV601FeP7kNVRKHqTXF5+Js+4Oy
         d+TQ==
X-Gm-Message-State: ALyK8tJvuSpfSYwNdSvpt1JqfVJ6sfzYfR/5DMq9iiRueaQxJdepYOOrt3r2bKjDfBjnmA==
X-Received: by 10.46.32.131 with SMTP id g3mr11118561lji.46.1468645607504;
        Fri, 15 Jul 2016 22:06:47 -0700 (PDT)
Received: from duynguyen.does.not.exist (10.219.241.83.in-addr.dgcsystems.net. [83.241.219.10])
        by smtp.gmail.com with ESMTPSA id g40sm634654ljg.22.2016.07.15.22.06.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 15 Jul 2016 22:06:46 -0700 (PDT)
From:	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>, yuri.kanivetsky@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 4/4] cache-tree: do not generate empty trees as a result of all i-t-a subentries
Date:	Sat, 16 Jul 2016 07:06:27 +0200
Message-Id: <20160716050627.9416-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.9.1.566.gbd532d4
In-Reply-To: <20160716050627.9416-1-pclouds@gmail.com>
References: <20160709052356.30570-1-pclouds@gmail.com>
 <20160716050627.9416-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

If a subdirectory contains nothing but i-t-a entries, we generate an
empty tree object and add it to its parent tree. Which is wrong. Such
a subdirectory should not be added.

Note that this has a cascading effect. If subdir 'a/b/c' contains
nothing but i-t-a entries, we ignore it. But then if 'a/b' contains
only (the non-existing) 'a/b/c', then we should ignore 'a/b' while
building 'a' too. And it goes all the way up to top directory.

Noticed-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 cache-tree.c          | 10 +++++++++-
 t/t2203-add-intent.sh | 14 ++++++++++++++
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/cache-tree.c b/cache-tree.c
index c2676e8..f28b1f4 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -325,6 +325,7 @@ static int update_one(struct cache_tree *it,
 		const unsigned char *sha1;
 		unsigned mode;
 		int expected_missing = 0;
+		int contains_ita = 0;
 
 		path = ce->name;
 		pathlen = ce_namelen(ce);
@@ -341,7 +342,8 @@ static int update_one(struct cache_tree *it,
 			i += sub->count;
 			sha1 = sub->cache_tree->sha1;
 			mode = S_IFDIR;
-			if (sub->cache_tree->entry_count < 0) {
+			contains_ita = sub->cache_tree->entry_count < 0;
+			if (contains_ita) {
 				to_invalidate = 1;
 				expected_missing = 1;
 			}
@@ -380,6 +382,12 @@ static int update_one(struct cache_tree *it,
 			continue;
 		}
 
+		/*
+		 * "sub" can be an empty tree if all subentries are i-t-a.
+		 */
+		if (contains_ita && !hashcmp(sha1, EMPTY_TREE_SHA1_BIN))
+			continue;
+
 		strbuf_grow(&buffer, entlen + 100);
 		strbuf_addf(&buffer, "%o %.*s%c", mode, entlen, path + baselen, '\0');
 		strbuf_add(&buffer, sha1, 20);
diff --git a/t/t2203-add-intent.sh b/t/t2203-add-intent.sh
index 24aed2e..8f22c43 100755
--- a/t/t2203-add-intent.sh
+++ b/t/t2203-add-intent.sh
@@ -99,5 +99,19 @@ test_expect_success 'cache-tree does not ignore dir that has i-t-a entries' '
 	)
 '
 
+test_expect_success 'cache-tree does skip dir that becomes empty' '
+	rm -fr ita-in-dir &&
+	git init ita-in-dir &&
+	(
+		cd ita-in-dir &&
+		mkdir -p 1/2/3 &&
+		echo 4 >1/2/3/4 &&
+		git add -N 1/2/3/4 &&
+		git write-tree >actual &&
+		echo $EMPTY_TREE >expected &&
+		test_cmp expected actual
+	)
+'
+
 test_done
 
-- 
2.9.1.566.gbd532d4

