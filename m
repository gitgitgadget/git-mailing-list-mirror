Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77555C433E5
	for <git@archiver.kernel.org>; Sat, 20 Mar 2021 22:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54FE061933
	for <git@archiver.kernel.org>; Sat, 20 Mar 2021 22:39:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbhCTWin (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Mar 2021 18:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbhCTWiS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Mar 2021 18:38:18 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0096AC061762
        for <git@vger.kernel.org>; Sat, 20 Mar 2021 15:38:17 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id 61so12735647wrm.12
        for <git@vger.kernel.org>; Sat, 20 Mar 2021 15:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zEuGGild4oP8e7gGPK2bLUkBdBnkIKme8qfGa0xYagI=;
        b=j5bQredPETDQUn54v1fZ/UBFNyYqv11DhV7aFY+X9PbeKUQ5H1aViMXPCFiIx1cA/V
         oeD2vFOnu/lDH9OcanVhaaKbre+VRKKqdOnDZ2d2hnT/48S3atKN7s6Y1NwlIdkqcmB1
         0+A33TaXd+2yeEnyP/CK86XEgwDqPg9EvJhmNIZS+tdRwwdth1dHQuATDpBkrmihssEJ
         FdiNfJ6q47M0+5jkyTd3d2sSttIYI9kOBMyGhKt4muy9g5Xqh/8pIH2HfA4jtxLX4m1l
         pSfdF8TSth4g0OccoJGJNPCiOLfsKzdX0tB6RV9aEbRa/96Zvr6u2Tz6B1hvwTnIOI/d
         389A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zEuGGild4oP8e7gGPK2bLUkBdBnkIKme8qfGa0xYagI=;
        b=DoYder167iHrGqZ2TCSeO7Z7MGm3u56nIXxxI3Tsa1S7A2Yr1f+Dnm9uAH5ShKiZ1U
         0kajTzetJ2SI7ufdoRDx8yCexj96FVMe268fcdMqqmDch5qFoW4bfUZA+Ou/eiW3qS+v
         /k+BELrgtUds5S7+7Ur5gJOgzJc247TZCw1rYZGxjk47zbcCWI20pt1FSD7oB6qhfPJo
         LruL8/zn4+WL2YCI5pfpzcKRaDijW3Oc4u5Zj7sgjGs4PBEb+Qt20qj6Kko6TK1z8BX9
         x14GUhmFwjk0Z5ueup5AkI/7cSXMk5LFlf5oIuapcIO527ck1JS4K0jgK2RcReC8u3lM
         pDFQ==
X-Gm-Message-State: AOAM531EZX1mOjCq60K3oQUvSYA9nx/zEBrxQwMxWdEz07/4Drl7N1Yc
        WNe+D0iHoFp561XqHTABzy8PJ9VwYOYlVA==
X-Google-Smtp-Source: ABdhPJxMuA0CZB21MOoEjjLKhCtXcP/GmSFnmZobfWoPqsL5UgLvj+4GBU90Ta9NYqReKnShiFemgg==
X-Received: by 2002:adf:b30f:: with SMTP id j15mr11204668wrd.132.1616279896572;
        Sat, 20 Mar 2021 15:38:16 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v2sm21472697wmj.1.2021.03.20.15.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Mar 2021 15:38:15 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 7/8] tree.h API: expose read_tree_1() as read_tree_at()
Date:   Sat, 20 Mar 2021 23:37:50 +0100
Message-Id: <d55e8d4042ba77f9fcc204afd74a8badfe83502d.1616279653.git.avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.286.gc175f2cb894
In-Reply-To: <cover.1616279653.git.avarab@gmail.com>
References: <xmqqpmzxy939.fsf@gitster.g> <cover.1616279653.git.avarab@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename the static read_tree_1() function to read_tree_at(). This
function works just like read_tree_recursive(), except you provide
your own strbuf.

This step doesn't make much sense now, but in follow-up commits I'll
remove the base/baselen/stage arguments to read_tree_recursive(). At
that point an anticipated in-tree user[1] for the old
read_tree_recursive() couldn't provide a path to start the
traversal.

Let's give them a function to do so with an API that makes more sense
for them, by taking a strbuf we should be able to avoid more casting
and/or reallocations in the future.

1. https://lore.kernel.org/git/xmqqft106sok.fsf@gitster.g
---
 tree.c | 17 +++++++++--------
 tree.h |  6 ++++++
 2 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/tree.c b/tree.c
index a6c12f2745a..f67c2153054 100644
--- a/tree.c
+++ b/tree.c
@@ -11,10 +11,11 @@
 
 const char *tree_type = "tree";
 
-static int read_tree_1(struct repository *r,
-		       struct tree *tree, struct strbuf *base,
-		       int stage, const struct pathspec *pathspec,
-		       read_tree_fn_t fn, void *context)
+int read_tree_at(struct repository *r,
+		 struct tree *tree, struct strbuf *base,
+		 int stage,
+		 const struct pathspec *pathspec,
+		 read_tree_fn_t fn, void *context)
 {
 	struct tree_desc desc;
 	struct name_entry entry;
@@ -71,9 +72,9 @@ static int read_tree_1(struct repository *r,
 		len = tree_entry_len(&entry);
 		strbuf_add(base, entry.path, len);
 		strbuf_addch(base, '/');
-		retval = read_tree_1(r, lookup_tree(r, &oid),
-				     base, stage, pathspec,
-				     fn, context);
+		retval = read_tree_at(r, lookup_tree(r, &oid),
+				      base, stage, pathspec,
+				      fn, context);
 		strbuf_setlen(base, oldlen);
 		if (retval)
 			return -1;
@@ -91,7 +92,7 @@ int read_tree_recursive(struct repository *r,
 	int ret;
 
 	strbuf_add(&sb, base, baselen);
-	ret = read_tree_1(r, tree, &sb, stage, pathspec, fn, context);
+	ret = read_tree_at(r, tree, &sb, stage, pathspec, fn, context);
 	strbuf_release(&sb);
 	return ret;
 }
diff --git a/tree.h b/tree.h
index 6b0b1dc211a..123fc41efe6 100644
--- a/tree.h
+++ b/tree.h
@@ -33,6 +33,12 @@ int cmp_cache_name_compare(const void *a_, const void *b_);
 #define READ_TREE_RECURSIVE 1
 typedef int (*read_tree_fn_t)(const struct object_id *, struct strbuf *, const char *, unsigned int, int, void *);
 
+int read_tree_at(struct repository *r,
+		 struct tree *tree, struct strbuf *base,
+		 int stage,
+		 const struct pathspec *pathspec,
+		 read_tree_fn_t fn, void *context);
+
 int read_tree_recursive(struct repository *r,
 			struct tree *tree,
 			const char *base, int baselen,
-- 
2.31.0.286.gc175f2cb894

