Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7542C43381
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 23:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B37CA64F5E
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 23:45:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233928AbhCOXon (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 19:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbhCOXoJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Mar 2021 19:44:09 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B067C06174A
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 16:44:09 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id 61so6543941wrm.12
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 16:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8FrFNY2Nd8vi+83mWellhgCpr1i73xbUDNIl5mi5Nn8=;
        b=rXmTNZc9TW/lSjuUtEJ0xQe2MxEMQEViFMl8G6VrT2DUKALnIFkDzJ+ceBr9I37N7Z
         CYJ/Foj3MSPEG9vShPwCRwEc2eqI8az0vi4jeDLmgJGQfzaNaJtwAskYCj5IHXrgtliK
         P8SPI+IyDU2SQaA989kZ9b24Epwos++RV2e6ZnYBofMDLvMcvM0ogUK0jmykOseLfjJp
         zre2hTx92obyJFDqbWEd3b+roLrfRD7nB2iucrkzRMs6vnCItCsjb7im8pBNb7b6bzmO
         7UVH8o79ZUscNB88wMs77Bt1/VKJiqwHGDY8Op2fZ8xdZHzZhZmciNJfng4PkPdxro3p
         bLsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8FrFNY2Nd8vi+83mWellhgCpr1i73xbUDNIl5mi5Nn8=;
        b=fBy4d19FtyZL7Wi/u9GBjlLn1Q2t1eTavDUKMtAJqIgtpCmSzgKaOe0AN4Tj3bbL7D
         B9DlJlpdL2AHEsBdXxcKtEcz16dtj/2wsgQA21jrHpcAJ8IW0cQi+MJBwazHjWqiOpoi
         CpvdzC1014bbaEINRIGdLtEercaBLs52HCAWJc8kWDnnG1WLRLET/SY/17v80SqJBM2x
         /mA2GNhf5HMSjfwf4evLCTPuYP+YaCvbXxgdFq/5T1rJLIzSML970E+mABxPrEvNIgiP
         nNtO4+0AYctA5+y0Df97JomBtf48pMnHcYElrn1MUCLeh0WnrmLKXnTX8IgNYUxue2Vv
         FRpQ==
X-Gm-Message-State: AOAM532p2t1JbC4WzjN0GB4RNLHupJDo4vgFNcMedeQxdlRY2vvMwriz
        S4VmZ+50DPsmAA+5wruFQYt4ma/3fEBJvQ==
X-Google-Smtp-Source: ABdhPJxiu9GKM5lulS33kzKZbcL27NTbmlndiDYrn/yF7hb/edNxej6omyKpCESn52dKCD07qdFWSA==
X-Received: by 2002:adf:fb91:: with SMTP id a17mr1948480wrr.118.1615851847566;
        Mon, 15 Mar 2021 16:44:07 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z7sm20417268wrt.70.2021.03.15.16.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 16:44:07 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 9/9] tree.h API: expose read_tree_1() as read_tree_at()
Date:   Tue, 16 Mar 2021 00:43:44 +0100
Message-Id: <20210315234344.28427-10-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc2.211.g1d0b8788b3
In-Reply-To: <20210308022138.28166-1-avarab@gmail.com>
References: <20210308022138.28166-1-avarab@gmail.com>
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
index f6de250d7ff..6a2a52967e4 100644
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
index 4fb713774a7..f0b079d2e91 100644
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
2.31.0.rc2.211.g1d0b8788b3

