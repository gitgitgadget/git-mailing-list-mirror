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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28FB7C43332
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 02:14:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 032BD65020
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 02:14:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232694AbhCPCNr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 22:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbhCPCNj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Mar 2021 22:13:39 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C508C061756
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 19:13:39 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id l11so9665920wrp.7
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 19:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dOdkXA3KKD/sGvFKEkh2mvoW3ZAmihSjtFIzkl6Ppws=;
        b=JES6W/0igTs06v82L6mp35yFb5lUkjprlA9pKHYo+1v5xTFWxHrQy5mt6eHMUlznrb
         VPev82BMwuGkxRugAFeD7R7wQku/+GbTwzETU0n6lsPXPsYudtCPPF/m/SU2QuxMdzJY
         jY9ijHfUaflPi87O2/qf+HNjqSstOobrDo85rPCNKJ904DgVMcphffnn8vOkl724ZKhQ
         Go8nhjabFxTahCW4fza4OCc1s5Bc/fn5KiqG3QUL9witmVdR/7L2WuamCaIhnN5YR12G
         6T6GwbppN668+KD7fWeo1+ysNnGLOGwSOol1LM8H5bEjhdKAD3dEIoNyOMabIGDRWQD8
         Wwfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dOdkXA3KKD/sGvFKEkh2mvoW3ZAmihSjtFIzkl6Ppws=;
        b=K5eFnIdBNX28/Bwkfb19x05alJPj+cSd5t3PQmXXxV6atect7fOYX/JTo5jBVCPc6X
         SQ1x7JrYCREBLhHyyQKYF1ORCDSQlaOv5Ov/Yzq3iN8OcO28l4PX4MYwRbCJAMePkQBK
         4lTzzZSmmihuIAQTr/Y7eKVKHiWGUqPjE5dl71FNHo8xOQeond6GbS13aXo+fummT7z9
         zQg/NdwrmwCiUPgbvot6P6Lygl4v/lAhvRD6S/b7XyLHAXThCxYCcjCC4KgLASIDydhq
         ALz8X4hDxIltPxfTSt9SydcqZpKJWtOS14jn9d3kjhhyxuqOH7OPHvey/EV53AW4w7l0
         WS5g==
X-Gm-Message-State: AOAM532SHUKmhZgFt8HPieergtaCHT7MBlj+QwJpP6qia7tzzOQ7ZOcv
        ZEx7FemJRfh5CqEq/URL5UxEUVU/wXvrnQ==
X-Google-Smtp-Source: ABdhPJySacIeUU/TWDJcXnfxn5doMXQs3mdfhkAFQHD+aipnoOkd0nz0LE6CaEY9gySji3G70Q9Ubw==
X-Received: by 2002:adf:ce8a:: with SMTP id r10mr2276117wrn.17.1615860817928;
        Mon, 15 Mar 2021 19:13:37 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i8sm21092494wrx.43.2021.03.15.19.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 19:13:37 -0700 (PDT)
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
Subject: [PATCH v2 08/29] tree.h: format argument lists of read_tree_recursive() users
Date:   Tue, 16 Mar 2021 03:12:51 +0100
Message-Id: <20210316021312.13927-9-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc2.211.g1d0b8788b3
In-Reply-To: <20210308150650.18626-1-avarab@gmail.com>
References: <20210308150650.18626-1-avarab@gmail.com>
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
 archive.c          | 14 +++++++++-----
 builtin/checkout.c |  4 +++-
 builtin/log.c      |  5 +++--
 builtin/ls-tree.c  |  4 +++-
 merge-recursive.c  |  3 ++-
 tree.h             |  5 ++++-
 6 files changed, 24 insertions(+), 11 deletions(-)

diff --git a/archive.c b/archive.c
index c19300ecb9b..77d1238df98 100644
--- a/archive.c
+++ b/archive.c
@@ -138,8 +138,10 @@ static int check_attr_export_subst(const struct attr_check *check)
 }
 
 static int write_archive_entry(const struct object_id *oid, const char *base,
-		int baselen, const char *filename, unsigned mode, int stage,
-		void *context)
+			       int baselen, const char *filename,
+			       unsigned mode,
+			       int stage,
+			       void *context)
 {
 	static struct strbuf path = STRBUF_INIT;
 	struct archiver_context *c = context;
@@ -230,8 +232,9 @@ static int write_directory(struct archiver_context *c)
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
@@ -378,7 +381,8 @@ struct path_exists_context {
 };
 
 static int reject_entry(const struct object_id *oid, struct strbuf *base,
-			const char *filename, unsigned mode,
+			const char *filename,
+			unsigned mode,
 			void *context)
 {
 	int ret = -1;
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 0e663905200..0887352db2a 100644
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
index 980de590638..b7b76856a9f 100644
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
index 3a442631c71..8d5c3fd0582 100644
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
index 1c9b08695a3..689a3e00070 100644
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
index f0b079d2e91..c1a936fdc49 100644
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
 
 int read_tree_at(struct repository *r,
 		 struct tree *tree,
-- 
2.31.0.rc2.211.g1d0b8788b3

