Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25634C4360C
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 15:53:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 121A36511D
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 15:53:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238172AbhCPPxk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 11:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238089AbhCPPxD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 11:53:03 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B4E4C0613D7
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 08:52:57 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id e10so10719505wro.12
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 08:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Fx+jZmmd3ye+eq6ZLjonBFLDQMakFKrosuWsCcXVEJE=;
        b=H8FGztUC+JfStY0wYFzbrlM8LKDc5tCbh0WCuQ+To5xH+mqVTOgo3+b8IguVjfjrel
         BRTJVJX6MPwC4ulg798ZctToCyc6zpZm35MToJLxdXRMfuY5BGsr65Rkhn53mMHxFiuC
         u/JtRSFnByqWLarqQngnSlzaJtEVLiThnc3Pgez9HxVDEp/Di8sFsDTkzKqS+9/wIc5e
         IavouIqaAuu26VNS3yGgzgn7TYqWTTAgBRVJqZEksR0KRfWij263PTO+WzXNoJmYhrFw
         jRaP+FdvQ1/iOQWT56ykdhRRHEWqGBHVVq1zrp62ysVSqUEjPo15dDqn8OmQGsQU2UPe
         NeQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fx+jZmmd3ye+eq6ZLjonBFLDQMakFKrosuWsCcXVEJE=;
        b=qfSJ+/T0AEIdyxpFPHdhvs9OIztFkwRtFUYgsKlcXlPrcdv2cW6/k8JXJD48eKn0zV
         3XfOV4dk0UnBtK4nz1C6zbSpKj/FgTcimBjcCDfOV2RMbBl9kqBrYfAVE3NoS9+LtNL/
         VNmW19h9ZNZM6fAxgPgywvnyAFIfxy47Zr7Etq3fu5603/DwItVJWiHwLElJclHlKNeX
         HNiezHMrEpzWkYui+jXWGvFQ4cFM+Yd6ntyXEz8O5SiA/q7fS1/d9jScAi3L8p+WJgNJ
         TFYD+5q63pLVh9RAMFnjmhhYudzFGTbVW4jiSzuq5a+Bc0UgvLkj5G08fx7OkioGJyqQ
         qMqg==
X-Gm-Message-State: AOAM533SmF69N7/shtvKGPtB2m1kZ8Eq7Zwj5ehZGC9Bf3RVevQYGpl1
        XQ0NDxfodIFo33LwC4cMOaHzA+nDKcqumQ==
X-Google-Smtp-Source: ABdhPJyKglLRA2go7kVKL744Dey16hvSiEQA4IZB4gLp7rALDv0XtCkOAEfma9F8inJ/KUq1C9uLfw==
X-Received: by 2002:a5d:5411:: with SMTP id g17mr5643761wrv.194.1615909975743;
        Tue, 16 Mar 2021 08:52:55 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i11sm22224228wro.53.2021.03.16.08.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 08:52:55 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 9/9] tree.h API: expose read_tree_1() as read_tree_at()
Date:   Tue, 16 Mar 2021 16:52:44 +0100
Message-Id: <20210316155244.28328-10-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.256.gf0ddda3145
In-Reply-To: <20210315234344.28427-1-avarab@gmail.com>
References: <20210315234344.28427-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename the static read_tree_1() function to read_tree_at(). This will
allow for the old read_tree_recursive() mode of operation where we
start at a given path instead of "".

See [1] for the discussion of one such future in-tree user, unlike the
old read_tree_recursive() this function takes a strbuf. Since that's
what read_tree_1() used internally this should allow us to avoid
casting and/or reallocations in the future.

1. https://lore.kernel.org/git/xmqqft106sok.fsf@gitster.g/#t
---
 tree.c | 16 ++++++++--------
 tree.h |  6 ++++++
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/tree.c b/tree.c
index f6de250d7f..6a2a52967e 100644
--- a/tree.c
+++ b/tree.c
@@ -11,10 +11,10 @@
 
 const char *tree_type = "tree";
 
-static int read_tree_1(struct repository *r,
-		       struct tree *tree, struct strbuf *base,
-		       const struct pathspec *pathspec,
-		       read_tree_fn_t fn, void *context)
+int read_tree_at(struct repository *r,
+		 struct tree *tree, struct strbuf *base,
+		 const struct pathspec *pathspec,
+		 read_tree_fn_t fn, void *context)
 {
 	struct tree_desc desc;
 	struct name_entry entry;
@@ -71,9 +71,9 @@ static int read_tree_1(struct repository *r,
 		len = tree_entry_len(&entry);
 		strbuf_add(base, entry.path, len);
 		strbuf_addch(base, '/');
-		retval = read_tree_1(r, lookup_tree(r, &oid),
-				     base, pathspec,
-				     fn, context);
+		retval = read_tree_at(r, lookup_tree(r, &oid),
+				      base, pathspec,
+				      fn, context);
 		strbuf_setlen(base, oldlen);
 		if (retval)
 			return -1;
@@ -89,7 +89,7 @@ int read_tree(struct repository *r,
 	struct strbuf sb = STRBUF_INIT;
 	int ret;
 
-	ret = read_tree_1(r, tree, &sb, pathspec, fn, context);
+	ret = read_tree_at(r, tree, &sb, pathspec, fn, context);
 	strbuf_release(&sb);
 	return ret;
 }
diff --git a/tree.h b/tree.h
index 4fb713774a..f0b079d2e9 100644
--- a/tree.h
+++ b/tree.h
@@ -33,6 +33,12 @@ int cmp_cache_name_compare(const void *a_, const void *b_);
 #define READ_TREE_RECURSIVE 1
 typedef int (*read_tree_fn_t)(const struct object_id *, struct strbuf *, const char *, unsigned int, void *);
 
+int read_tree_at(struct repository *r,
+		 struct tree *tree,
+		 struct strbuf *at,
+		 const struct pathspec *pathspec,
+		 read_tree_fn_t fn, void *context);
+
 int read_tree(struct repository *r,
 	      struct tree *tree,
 	      const struct pathspec *pathspec,
-- 
2.31.0.256.gf0ddda3145

