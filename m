Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD8A9C4332E
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 15:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD0676521F
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 15:08:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbhCHPHr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Mar 2021 10:07:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbhCHPHR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Mar 2021 10:07:17 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1855DC06174A
        for <git@vger.kernel.org>; Mon,  8 Mar 2021 07:07:17 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id a18so11766602wrc.13
        for <git@vger.kernel.org>; Mon, 08 Mar 2021 07:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T1MbgDpaV0RQO60S8/kTJfOJiXg8NmINhu2GVxjiBkk=;
        b=RUAlgGdkEd96TZQNThxcx+jIZKHs+Hcn9B6S+/Gm8MjouajUGApM2NmUYCCZ/BDaxD
         Pi0i1YSGogy+vgFyngMckWTcDsoeXIgBXGtulLTxkwi9IVlLxkIWna9R0CZowqIvJC0I
         0wZvAMzbf2I1jwaVGhrBZeveLeZfzaVP23mUN/VsFApHSYM+xrAt1CqOqAFHaGSyts2l
         LFLZiW6C9J2CoEXOdygWVjiSfK3q7Tx6EUxxSXoSG5TSECsKxhlEVqMyhto24fOjc4Pl
         X4+YVvRXwZxq9wS7OF0ZWZHKSlFY7yrYEQiEkiknhL81WVu8cPzEyNdLSrreLzNoHK/h
         lD3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T1MbgDpaV0RQO60S8/kTJfOJiXg8NmINhu2GVxjiBkk=;
        b=A3LfebV7H++V98/ZM5LcIRMfHUo9u53uVm3KcAcm1rk/C77DHBJ1rb7Xx+ozE2mtK1
         xZaC7zRPsrAvXgKohwb2x1zcq+lrNRihmfiXCG24G0m1+PUgX78giBzsDtHox0j5o9eD
         YnX+S+Gp4XvsBtrYz8+jCH2nX3G0bQ3VGBrwdjvt02H3eGpUVND7iRsE9C8VUaTY5xF3
         fhQhFP9iAnApulqBVVy8v5pGDwNhz2oqmRw6LyFCo/YWE16iNo5TD/+IPjZXcIcV+NCG
         g2VKK4NRuYk7ED72Fl7mc4/s1tQp5TS+yfgj1+GYsQ9WTO4VmCCEA9s0gYpIipSqYFgG
         BteQ==
X-Gm-Message-State: AOAM531JMVl9ZrJ/8Ut10OZrPpCYtdqDKkMvRYcoNYjH6VB3Q4oDWmSa
        PZnIiNR1/Dw6Br3qnBIewSeo78vWL3iO7g==
X-Google-Smtp-Source: ABdhPJyuEO1Qn4GXUF10JD+D4C8cEjK8TILNXuspFV6zIlhwWLEWiB/SOAHgCEyVUSVBQgtWF9fTlw==
X-Received: by 2002:adf:d217:: with SMTP id j23mr23917849wrh.113.1615216035572;
        Mon, 08 Mar 2021 07:07:15 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j13sm3820488wrt.29.2021.03.08.07.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 07:07:15 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Kirill Smelkov <kirr@navytux.spb.ru>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 08/30] tree.h: format argument lists of read_tree_recursive() users
Date:   Mon,  8 Mar 2021 16:06:28 +0100
Message-Id: <20210308150650.18626-9-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc0.126.g04f22c5b82
In-Reply-To: <20210308022138.28166-1-avarab@gmail.com>
References: <20210308022138.28166-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In preparation for adding a new argument to read_tree_fn_t re-indent
and format the argument list of read_tree_recursive() callbacks, and
the relevant functions they call.

This is a whitespace-only change to make reading subsequent commits
easier. I'll be adding a new argument on the "mode" line, so leave
space on it.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 archive.c          | 13 ++++++++-----
 builtin/checkout.c |  4 +++-
 builtin/log.c      |  5 +++--
 builtin/ls-tree.c  |  4 +++-
 merge-recursive.c  |  3 ++-
 tree.h             |  5 ++++-
 6 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/archive.c b/archive.c
index 6669a4bd147..db69a8acadb 100644
--- a/archive.c
+++ b/archive.c
@@ -138,8 +138,9 @@ static int check_attr_export_subst(const struct attr_check *check)
 }
 
 static int write_archive_entry(const struct object_id *oid, const char *base,
-		int baselen, const char *filename, unsigned mode, int stage,
-		void *context)
+			       int baselen, const char *filename,
+			       unsigned mode,
+			       int stage, void *context)
 {
 	static struct strbuf path = STRBUF_INIT;
 	struct archiver_context *c = context;
@@ -230,8 +231,9 @@ static int write_directory(struct archiver_context *c)
 }
 
 static int queue_or_write_archive_entry(const struct object_id *oid,
-		struct strbuf *base, const char *filename,
-		unsigned mode, void *context)
+					struct strbuf *base, const char *filename,
+					unsigned mode,
+					void *context)
 {
 	struct archiver_context *c = context;
 	int stage = 0;
@@ -378,7 +380,8 @@ struct path_exists_context {
 };
 
 static int reject_entry(const struct object_id *oid, struct strbuf *base,
-			const char *filename, unsigned mode,
+			const char *filename,
+			unsigned mode,
 			void *context)
 {
 	int ret = -1;
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 2c2d58a230f..a78b54624b0 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -114,7 +114,9 @@ static int post_checkout_hook(struct commit *old_commit, struct commit *new_comm
 }
 
 static int update_some(const struct object_id *oid, struct strbuf *base,
-		const char *pathname, unsigned mode, void *context)
+		       const char *pathname,
+		       unsigned mode,
+		       void *context)
 {
 	int len;
 	struct cache_entry *ce;
diff --git a/builtin/log.c b/builtin/log.c
index 58acb2b76ab..3766f553971 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -598,8 +598,9 @@ static int show_tag_object(const struct object_id *oid, struct rev_info *rev)
 }
 
 static int show_tree_object(const struct object_id *oid,
-		struct strbuf *base,
-		const char *pathname, unsigned mode, void *context)
+			    struct strbuf *base, const char *pathname,
+			    unsigned mode,
+			    void *context)
 {
 	FILE *file = context;
 	fprintf(file, "%s%s\n", pathname, S_ISDIR(mode) ? "/" : "");
diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index dbb31217beb..aaa41e66234 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -62,7 +62,9 @@ static int show_recursive(const char *base, int baselen, const char *pathname)
 }
 
 static int show_tree(const struct object_id *oid, struct strbuf *base,
-		const char *pathname, unsigned mode, void *context)
+		     const char *pathname,
+		     unsigned mode,
+		     void *context)
 {
 	int retval = 0;
 	int baselen;
diff --git a/merge-recursive.c b/merge-recursive.c
index 0baa6b5ca56..aa12543ecc9 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -453,7 +453,8 @@ static void unpack_trees_finish(struct merge_options *opt)
 
 static int save_files_dirs(const struct object_id *oid,
 			   struct strbuf *base, const char *path,
-			   unsigned int mode, void *context)
+			   unsigned int mode,
+			   void *context)
 {
 	struct path_hashmap_entry *entry;
 	int baselen = base->len;
diff --git a/tree.h b/tree.h
index 1309ab997e5..a7030e52679 100644
--- a/tree.h
+++ b/tree.h
@@ -31,7 +31,10 @@ struct tree *parse_tree_indirect(const struct object_id *oid);
 int cmp_cache_name_compare(const void *a_, const void *b_);
 
 #define READ_TREE_RECURSIVE 1
-typedef int (*read_tree_fn_t)(const struct object_id *, struct strbuf *, const char *, unsigned int, void *);
+typedef int (*read_tree_fn_t)(const struct object_id *, struct strbuf *,
+			      const char *,
+			      unsigned int,
+			      void *);
 
 int read_tree_recursive(struct repository *r,
 			struct tree *tree,
-- 
2.31.0.rc0.126.g04f22c5b82

