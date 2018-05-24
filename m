Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D495E1F51C
	for <e@80x24.org>; Thu, 24 May 2018 07:04:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935346AbeEXHEz (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 May 2018 03:04:55 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:39225 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751819AbeEXHEu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 May 2018 03:04:50 -0400
Received: by mail-ot0-f193.google.com with SMTP id l12-v6so693418oth.6
        for <git@vger.kernel.org>; Thu, 24 May 2018 00:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bN+OdLVGlYPShBdnDBWVUWTZ8crKvmqhsFzSxkle4Nk=;
        b=jlZTgw/DQ9OsVGqWMhJvrLwtu0HciDng1cEIAJEgkW9+fwXbKYkM1ae0CO/fpK/0jn
         0cJ8JT4F4gwmoMl4F/UtDDAtRRBlEZyw1DnX4eUJ+j0E9AlFAAphWyBRah43eiTNY0/r
         AA8Ox7nl5xVlJB4/9u8JTsoLLyCkOo4Yf8k4KQdiO3gqSJpyEcRENkK6/wBmE5Bh9ElG
         L/0GZkdhbhAEWkJo30QrgmQjde8+eOzV9qyaVLax9svT1qDx0lYZhHf9e5N+s2PLfNkt
         uMzUi1sZ8CO5CVfLh6+68BnJWeffV0qlqQbZAD2Ort9MZkOmbZzR2chksLmvtpqMnOFP
         A4Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bN+OdLVGlYPShBdnDBWVUWTZ8crKvmqhsFzSxkle4Nk=;
        b=UYDXZYriq8GdKcuuQ1/G6cg81H/3ezIBBFRGtRZA9GkrJuBfh0J0AI0TmGlSf1nUoT
         Qnof0ybdzjfOXcbz9STglkCAlxw0EIrwb1y0jq9Dyi72XNvLEzNKfCd9f2TSneiMftUL
         ZolPxQgDjcvZcExyqVaqLqOwynFJaFScAqBV2zLeBPunkfTECp9Oy3lUYjzcA3JIS791
         G/Sua2kBgBMAgM5+PFetUQJykHPobmtgEfibZHLhd3FpTX4dJUO/ai6aDNOvWllCysyr
         J5P+f/jV2Mjs1CkaRPG0T69KylCd4lJJyNFOD99UaDuBxp5xqrRNoVL0mAEfEeYSClbZ
         KHhQ==
X-Gm-Message-State: ALKqPwcz6hba+ayEP6Cw4CyqbH+YUrlB7BdSAqxoM1+2sRU97Mtgwqyk
        S7pwrUyO3fAb7IJJXORNrTOhkA==
X-Google-Smtp-Source: AB8JxZp6zedmYOTizLSpSMoBI/2lVQdGGN6jajmytRugGmyFm4bLVxTKK8Ic4k24NvXJzQI8VPs87g==
X-Received: by 2002:a9d:3c3b:: with SMTP id q56-v6mr4004632otc.226.1527145489261;
        Thu, 24 May 2018 00:04:49 -0700 (PDT)
Received: from tiger.attlocal.net ([2602:30a:2c28:20f0:7c1a:85e3:2ea9:5d7e])
        by smtp.gmail.com with ESMTPSA id q75-v6sm12076244ota.69.2018.05.24.00.04.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 May 2018 00:04:48 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Elijah Newren <newren@gmail.com>
Subject: [PATCH 2/5] t6036, t6042: use test_line_count instead of wc -l
Date:   Thu, 24 May 2018 00:04:36 -0700
Message-Id: <20180524070439.6367-3-newren@gmail.com>
X-Mailer: git-send-email 2.17.0.1.gda85003413
In-Reply-To: <20180524070439.6367-1-newren@gmail.com>
References: <20180524070439.6367-1-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6036-recursive-corner-cases.sh    | 102 ++++++++++++++++++---------
 t/t6042-merge-rename-corner-cases.sh |  99 +++++++++++++++++---------
 2 files changed, 134 insertions(+), 67 deletions(-)

diff --git a/t/t6036-recursive-corner-cases.sh b/t/t6036-recursive-corner-cases.sh
index cfe6a99771..3e659cff28 100755
--- a/t/t6036-recursive-corner-cases.sh
+++ b/t/t6036-recursive-corner-cases.sh
@@ -65,9 +65,12 @@ test_expect_success 'merge simple rename+criss-cross with no modifications' '
 
 		test_must_fail git merge -s recursive R2^0 &&
 
-		test 2 = $(git ls-files -s | wc -l) &&
-		test 2 = $(git ls-files -u | wc -l) &&
-		test 2 = $(git ls-files -o | wc -l) &&
+		git ls-files -s >out &&
+		test_line_count = 2 out &&
+		git ls-files -u >out &&
+		test_line_count = 2 out &&
+		git ls-files -o >out &&
+		test_line_count = 3 out &&
 
 		test $(git rev-parse :2:three) = $(git rev-parse L2:three) &&
 		test $(git rev-parse :3:three) = $(git rev-parse R2:three) &&
@@ -135,9 +138,12 @@ test_expect_success 'merge criss-cross + rename merges with basic modification'
 
 		test_must_fail git merge -s recursive R2^0 &&
 
-		test 2 = $(git ls-files -s | wc -l) &&
-		test 2 = $(git ls-files -u | wc -l) &&
-		test 2 = $(git ls-files -o | wc -l) &&
+		git ls-files -s >out &&
+		test_line_count = 2 out &&
+		git ls-files -u >out &&
+		test_line_count = 2 out &&
+		git ls-files -o >out &&
+		test_line_count = 3 out &&
 
 		test $(git rev-parse :2:three) = $(git rev-parse L2:three) &&
 		test $(git rev-parse :3:three) = $(git rev-parse R2:three) &&
@@ -211,9 +217,12 @@ test_expect_success 'git detects differently handled merges conflict' '
 
 		test_must_fail git merge -s recursive E^0 &&
 
-		test 3 = $(git ls-files -s | wc -l) &&
-		test 3 = $(git ls-files -u | wc -l) &&
-		test 0 = $(git ls-files -o | wc -l) &&
+		git ls-files -s >out &&
+		test_line_count = 3 out &&
+		git ls-files -u >out &&
+		test_line_count = 3 out &&
+		git ls-files -o >out &&
+		test_line_count = 1 out &&
 
 		test $(git rev-parse :2:new_a) = $(git rev-parse D:new_a) &&
 		test $(git rev-parse :3:new_a) = $(git rev-parse E:new_a) &&
@@ -297,8 +306,10 @@ test_expect_success 'git detects conflict merging criss-cross+modify/delete' '
 
 		test_must_fail git merge -s recursive E^0 &&
 
-		test 2 -eq $(git ls-files -s | wc -l) &&
-		test 2 -eq $(git ls-files -u | wc -l) &&
+		git ls-files -s >out &&
+		test_line_count = 2 out &&
+		git ls-files -u >out &&
+		test_line_count = 2 out &&
 
 		test $(git rev-parse :1:file) = $(git rev-parse master:file) &&
 		test $(git rev-parse :2:file) = $(git rev-parse B:file)
@@ -314,8 +325,10 @@ test_expect_success 'git detects conflict merging criss-cross+modify/delete, rev
 
 		test_must_fail git merge -s recursive D^0 &&
 
-		test 2 -eq $(git ls-files -s | wc -l) &&
-		test 2 -eq $(git ls-files -u | wc -l) &&
+		git ls-files -s >out &&
+		test_line_count = 2 out &&
+		git ls-files -u >out &&
+		test_line_count = 2 out &&
 
 		test $(git rev-parse :1:file) = $(git rev-parse master:file) &&
 		test $(git rev-parse :3:file) = $(git rev-parse B:file)
@@ -423,9 +436,12 @@ test_expect_success 'merge of D & E1 fails but has appropriate contents' '
 
 		test_must_fail git merge -s recursive E1^0 &&
 
-		test 2 -eq $(git ls-files -s | wc -l) &&
-		test 1 -eq $(git ls-files -u | wc -l) &&
-		test 0 -eq $(git ls-files -o | wc -l) &&
+		git ls-files -s >out &&
+		test_line_count = 2 out &&
+		git ls-files -u >out &&
+		test_line_count = 1 out &&
+		git ls-files -o >out &&
+		test_line_count = 1 out &&
 
 		test $(git rev-parse :0:ignore-me) = $(git rev-parse A:ignore-me) &&
 		test $(git rev-parse :2:a) = $(git rev-parse B:a)
@@ -440,9 +456,12 @@ test_expect_success 'merge of E1 & D fails but has appropriate contents' '
 
 		test_must_fail git merge -s recursive D^0 &&
 
-		test 2 -eq $(git ls-files -s | wc -l) &&
-		test 1 -eq $(git ls-files -u | wc -l) &&
-		test 0 -eq $(git ls-files -o | wc -l) &&
+		git ls-files -s >out &&
+		test_line_count = 2 out &&
+		git ls-files -u >out &&
+		test_line_count = 1 out &&
+		git ls-files -o >out &&
+		test_line_count = 1 out &&
 
 		test $(git rev-parse :0:ignore-me) = $(git rev-parse A:ignore-me) &&
 		test $(git rev-parse :3:a) = $(git rev-parse B:a)
@@ -457,9 +476,12 @@ test_expect_success 'merge of D & E2 fails but has appropriate contents' '
 
 		test_must_fail git merge -s recursive E2^0 &&
 
-		test 4 -eq $(git ls-files -s | wc -l) &&
-		test 3 -eq $(git ls-files -u | wc -l) &&
-		test 1 -eq $(git ls-files -o | wc -l) &&
+		git ls-files -s >out &&
+		test_line_count = 4 out &&
+		git ls-files -u >out &&
+		test_line_count = 3 out &&
+		git ls-files -o >out &&
+		test_line_count = 2 out &&
 
 		test $(git rev-parse :2:a) = $(git rev-parse B:a) &&
 		test $(git rev-parse :3:a/file) = $(git rev-parse E2:a/file) &&
@@ -478,9 +500,12 @@ test_expect_success 'merge of E2 & D fails but has appropriate contents' '
 
 		test_must_fail git merge -s recursive D^0 &&
 
-		test 4 -eq $(git ls-files -s | wc -l) &&
-		test 3 -eq $(git ls-files -u | wc -l) &&
-		test 1 -eq $(git ls-files -o | wc -l) &&
+		git ls-files -s >out &&
+		test_line_count = 4 out &&
+		git ls-files -u >out &&
+		test_line_count = 3 out &&
+		git ls-files -o >out &&
+		test_line_count = 2 out &&
 
 		test $(git rev-parse :3:a) = $(git rev-parse B:a) &&
 		test $(git rev-parse :2:a/file) = $(git rev-parse E2:a/file) &&
@@ -574,9 +599,12 @@ test_expect_success 'handle rename/rename(1to2)/modify followed by what looks li
 
 		git merge -s recursive E^0 &&
 
-		test 1 -eq $(git ls-files -s | wc -l) &&
-		test 0 -eq $(git ls-files -u | wc -l) &&
-		test 0 -eq $(git ls-files -o | wc -l) &&
+		git ls-files -s >out &&
+		test_line_count = 1 out &&
+		git ls-files -u >out &&
+		test_line_count = 0 out &&
+		git ls-files -o >out &&
+		test_line_count = 1 out &&
 
 		test $(git rev-parse HEAD:newname) = $(git rev-parse E:newname)
 	)
@@ -653,9 +681,12 @@ test_expect_failure 'detect rename/rename/add-source for virtual merge-base' '
 
 		git merge -s recursive E^0 &&
 
-		test 3 -eq $(git ls-files -s | wc -l) &&
-		test 0 -eq $(git ls-files -u | wc -l) &&
-		test 0 -eq $(git ls-files -o | wc -l) &&
+		git ls-files -s >out &&
+		test_line_count = 3 out &&
+		git ls-files -u >out &&
+		test_line_count = 0 out &&
+		git ls-files -o >out &&
+		test_line_count = 1 out &&
 
 		test $(git rev-parse HEAD:b) = $(git rev-parse A:a) &&
 		test $(git rev-parse HEAD:c) = $(git rev-parse A:a) &&
@@ -727,9 +758,12 @@ test_expect_success 'virtual merge base handles rename/rename(1to2)/add-dest' '
 
 		git merge -s recursive E^0 &&
 
-		test 2 -eq $(git ls-files -s | wc -l) &&
-		test 0 -eq $(git ls-files -u | wc -l) &&
-		test 0 -eq $(git ls-files -o | wc -l) &&
+		git ls-files -s >out &&
+		test_line_count = 2 out &&
+		git ls-files -u >out &&
+		test_line_count = 0 out &&
+		git ls-files -o >out &&
+		test_line_count = 1 out &&
 
 		test $(git rev-parse HEAD:a) = $(git rev-parse A:a) &&
 		test $(git rev-parse HEAD:c) = $(git rev-parse E:c)
diff --git a/t/t6042-merge-rename-corner-cases.sh b/t/t6042-merge-rename-corner-cases.sh
index bec0192c3b..b76da8fcdf 100755
--- a/t/t6042-merge-rename-corner-cases.sh
+++ b/t/t6042-merge-rename-corner-cases.sh
@@ -116,9 +116,12 @@ test_expect_failure 'conflict caused if rename not detected' '
 		git checkout -q C^0 &&
 		git merge -s recursive B^0 &&
 
-		test 3 -eq $(git ls-files -s | wc -l) &&
-		test 0 -eq $(git ls-files -u | wc -l) &&
-		test 0 -eq $(git ls-files -o | wc -l) &&
+		git ls-files -s >out &&
+		test_line_count = 3 out &&
+		git ls-files -u >out &&
+		test_line_count = 0 out &&
+		git ls-files -o >out &&
+		test_line_count = 1 out &&
 
 		test_line_count = 6 c &&
 		test $(git rev-parse HEAD:a) = $(git rev-parse B:a) &&
@@ -203,9 +206,12 @@ test_expect_failure 'detect rename/add-source and preserve all data' '
 
 		git merge -s recursive C^0 &&
 
-		test 2 -eq $(git ls-files -s | wc -l) &&
-		test 2 -eq $(git ls-files -u | wc -l) &&
-		test 0 -eq $(git ls-files -o | wc -l) &&
+		git ls-files -s >out &&
+		test_line_count = 2 out &&
+		git ls-files -u >out &&
+		test_line_count = 2 out &&
+		git ls-files -o >out &&
+		test_line_count = 1 out &&
 
 		test -f a &&
 		test -f b &&
@@ -223,9 +229,12 @@ test_expect_failure 'detect rename/add-source and preserve all data, merge other
 
 		git merge -s recursive B^0 &&
 
-		test 2 -eq $(git ls-files -s | wc -l) &&
-		test 2 -eq $(git ls-files -u | wc -l) &&
-		test 0 -eq $(git ls-files -o | wc -l) &&
+		git ls-files -s >out &&
+		test_line_count = 2 out &&
+		git ls-files -u >out &&
+		test_line_count = 2 out &&
+		git ls-files -o >out &&
+		test_line_count = 1 out &&
 
 		test -f a &&
 		test -f b &&
@@ -279,9 +288,12 @@ test_expect_success 'rename/directory conflict + clean content merge' '
 
 		test_must_fail git merge -s recursive right^0 &&
 
-		test 2 -eq $(git ls-files -s | wc -l) &&
-		test 1 -eq $(git ls-files -u | wc -l) &&
-		test 1 -eq $(git ls-files -o | wc -l) &&
+		git ls-files -s >out &&
+		test_line_count = 2 out &&
+		git ls-files -u >out &&
+		test_line_count = 1 out &&
+		git ls-files -o >out &&
+		test_line_count = 2 out &&
 
 		echo 0 >expect &&
 		git cat-file -p base:file >>expect &&
@@ -307,9 +319,12 @@ test_expect_success 'rename/directory conflict + content merge conflict' '
 
 		test_must_fail git merge -s recursive right^0 &&
 
-		test 4 -eq $(git ls-files -s | wc -l) &&
-		test 3 -eq $(git ls-files -u | wc -l) &&
-		test 1 -eq $(git ls-files -o | wc -l) &&
+		git ls-files -s >out &&
+		test_line_count = 4 out &&
+		git ls-files -u >out &&
+		test_line_count = 3 out &&
+		git ls-files -o >out &&
+		test_line_count = 2 out &&
 
 		git cat-file -p left-conflict:newfile >left &&
 		git cat-file -p base:file    >base &&
@@ -367,9 +382,12 @@ test_expect_success 'disappearing dir in rename/directory conflict handled' '
 
 		git merge -s recursive right^0 &&
 
-		test 1 -eq $(git ls-files -s | wc -l) &&
-		test 0 -eq $(git ls-files -u | wc -l) &&
-		test 0 -eq $(git ls-files -o | wc -l) &&
+		git ls-files -s >out &&
+		test_line_count = 1 out &&
+		git ls-files -u >out &&
+		test_line_count = 0 out &&
+		git ls-files -o >out &&
+		test_line_count = 1 out &&
 
 		echo 0 >expect &&
 		git cat-file -p base:sub/file >>expect &&
@@ -426,10 +444,14 @@ test_expect_success 'handle rename/rename (2to1) conflict correctly' '
 		test_must_fail git merge -s recursive C^0 >out &&
 		test_i18ngrep "CONFLICT (rename/rename)" out &&
 
-		test 2 -eq $(git ls-files -s | wc -l) &&
-		test 2 -eq $(git ls-files -u | wc -l) &&
-		test 2 -eq $(git ls-files -u c | wc -l) &&
-		test 3 -eq $(git ls-files -o | wc -l) &&
+		git ls-files -s >out &&
+		test_line_count = 2 out &&
+		git ls-files -u >out &&
+		test_line_count = 2 out &&
+		git ls-files -u c >out &&
+		test_line_count = 2 out &&
+		git ls-files -o >out &&
+		test_line_count = 3 out &&
 
 		test ! -f a &&
 		test ! -f b &&
@@ -476,9 +498,12 @@ test_expect_success 'merge has correct working tree contents' '
 
 		test_must_fail git merge -s recursive B^0 &&
 
-		test 3 -eq $(git ls-files -s | wc -l) &&
-		test 3 -eq $(git ls-files -u | wc -l) &&
-		test 0 -eq $(git ls-files -o | wc -l) &&
+		git ls-files -s >out &&
+		test_line_count = 3 out &&
+		git ls-files -u >out &&
+		test_line_count = 3 out &&
+		git ls-files -o >out &&
+		test_line_count = 1 out &&
 
 		test $(git rev-parse :1:a) = $(git rev-parse A:a) &&
 		test $(git rev-parse :3:b) = $(git rev-parse A:a) &&
@@ -527,8 +552,10 @@ test_expect_failure 'detect conflict with rename/rename(1to2)/add-source merge'
 
 		test_must_fail git merge -s recursive C^0 &&
 
-		test 4 -eq $(git ls-files -s | wc -l) &&
-		test 0 -eq $(git ls-files -o | wc -l) &&
+		git ls-files -s >out &&
+		test_line_count = 4 out &&
+		git ls-files -o >out &&
+		test_line_count = 1 out &&
 
 		test $(git rev-parse 3:a) = $(git rev-parse C:a) &&
 		test $(git rev-parse 1:a) = $(git rev-parse A:a) &&
@@ -573,8 +600,10 @@ test_expect_failure 'rename/rename/add-source still tracks new a file' '
 		git checkout C^0 &&
 		git merge -s recursive B^0 &&
 
-		test 2 -eq $(git ls-files -s | wc -l) &&
-		test 0 -eq $(git ls-files -o | wc -l) &&
+		git ls-files -s >out &&
+		test_line_count = 2 out &&
+		git ls-files -o >out &&
+		test_line_count = 1 out &&
 
 		test $(git rev-parse HEAD:a) = $(git rev-parse C:a) &&
 		test $(git rev-parse HEAD:b) = $(git rev-parse A:a)
@@ -615,10 +644,14 @@ test_expect_success 'rename/rename/add-dest merge still knows about conflicting
 		git checkout C^0 &&
 		test_must_fail git merge -s recursive B^0 &&
 
-		test 5 -eq $(git ls-files -s | wc -l) &&
-		test 2 -eq $(git ls-files -u b | wc -l) &&
-		test 2 -eq $(git ls-files -u c | wc -l) &&
-		test 4 -eq $(git ls-files -o | wc -l) &&
+		git ls-files -s >out &&
+		test_line_count = 5 out &&
+		git ls-files -u b >out &&
+		test_line_count = 2 out &&
+		git ls-files -u c >out &&
+		test_line_count = 2 out &&
+		git ls-files -o >out &&
+		test_line_count = 5 out &&
 
 		test $(git rev-parse :1:a) = $(git rev-parse A:a) &&
 		test $(git rev-parse :2:b) = $(git rev-parse C:b) &&
-- 
2.17.0.1.gda85003413

