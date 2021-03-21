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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9429C433FC
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 00:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE3906193A
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 00:02:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbhCUACW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Mar 2021 20:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbhCUABl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Mar 2021 20:01:41 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D072CC061762
        for <git@vger.kernel.org>; Sat, 20 Mar 2021 17:01:40 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id e18so12870178wrt.6
        for <git@vger.kernel.org>; Sat, 20 Mar 2021 17:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=umcHrBnfXprdU0FGYz0m2EUWU5nY8ZdC6Qi91xkLy0A=;
        b=fOmlVyn8j3PDwi2yX9F1XL0ylBcAAVZirl4uQy85pRQic1suNg2W1YiquH8/wGhsYl
         KmW5G5+Px6lhQdxRYjDd+ECtochW4PTMBZlptS282RZSPiL+tKCFgRZ28qZ1TgzxjUeU
         RDlWqmuRCJKNceA4Wg8VnawufoJguMghjPr4J3qca6WPUR4+EmknzRUUmTI4YvIeG00G
         +mnqt8nrIgugxJspV4EszQskUAW8lT/0Y2Bjnzkpkk9+N/0O6MLpNi6ZOE1avmiC0MHT
         hAg8pMvRk9uYScurKOoAgYLC9+n3q82GjMRoGM86i9H7DPTrtIAPgC78u8PrYY1C7RN0
         AuQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=umcHrBnfXprdU0FGYz0m2EUWU5nY8ZdC6Qi91xkLy0A=;
        b=ESICdvxKbsbFjSiNlgUXxResZa/NpdhRQKArE6F//pczipF/yfecyi8MLrkQmHzLYG
         Vb91X3bA3yva5kNyyWyS2+3SNWlp5WNczt1yk/InWREhdxIzqkmr3x6w0gVnZZZGIvqD
         xTHtGmeN2PiiYt9Uf39NnivLC9dj9Pr95p3Sq2SifFjgwc34+S1b/yiHh7Oze1iBD2LG
         FlJ5xYdSr1iq98qBgQuPwwx16c+LeENs8YViIiQRvl4oNJaF0lSTg43JBdAMXQF8rAru
         rpIRtz1wjTJqEfBq8Cxy64KFHU3i8dGARd35Itimy+NivhF3OrMsPpX/S3wyFjToabvw
         7tqw==
X-Gm-Message-State: AOAM532bre0DP1bX53AhUrYWEl5yNOOR6ghY9R9vcJJX0EfBToB8AWJs
        AS+7W0Q3z0hekDs59Iy8bBgpPlwJf0K5mQ==
X-Google-Smtp-Source: ABdhPJzLR1Y3apGLdlBF3bhEZ/GYLKtppavnDJ/8akN3scJCygQtkILT/1T2YBBl4CYTk3a5lcusbA==
X-Received: by 2002:adf:cf0b:: with SMTP id o11mr11659828wrj.310.1616284893938;
        Sat, 20 Mar 2021 17:01:33 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g5sm15304834wrq.30.2021.03.20.17.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Mar 2021 17:01:33 -0700 (PDT)
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
Subject: [PATCH v4 10/29] tree.h: format argument lists of read_tree_recursive() users
Date:   Sun, 21 Mar 2021 01:00:43 +0100
Message-Id: <df43f1a76ac1ee484f5a3052244a9a2c4ea494bb.1616282534.git.avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.282.gcc1ec606501
In-Reply-To: <cover.1616282533.git.avarab@gmail.com>
References: <20210316155829.31242-1-avarab@gmail.com> <cover.1616282533.git.avarab@gmail.com>
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
index 4921dc8a69f..feed5c02fb2 100644
--- a/archive.c
+++ b/archive.c
@@ -137,8 +137,9 @@ static int check_attr_export_subst(const struct attr_check *check)
 }
 
 static int write_archive_entry(const struct object_id *oid, const char *base,
-		int baselen, const char *filename, unsigned mode,
-		void *context)
+			       int baselen, const char *filename,
+			       unsigned mode,
+			       void *context)
 {
 	static struct strbuf path = STRBUF_INIT;
 	struct archiver_context *c = context;
@@ -228,8 +229,9 @@ static int write_directory(struct archiver_context *c)
 }
 
 static int queue_or_write_archive_entry(const struct object_id *oid,
-		struct strbuf *base, const char *filename,
-		unsigned mode, void *context)
+					struct strbuf *base, const char *filename,
+					unsigned mode,
+					void *context)
 {
 	struct archiver_context *c = context;
 
@@ -375,7 +377,8 @@ struct path_exists_context {
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
index 97520a88646..57198b29fe7 100644
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
index 6efff003e21..10c8637ab3e 100644
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
 		 struct tree *tree, struct strbuf *base,
-- 
2.31.0.286.gc175f2cb894

