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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D578C4360C
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 15:59:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6B1064FEA
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 15:59:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238311AbhCPP7d (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 11:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238257AbhCPP6v (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 11:58:51 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 501DEC061756
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 08:58:49 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id g25so10369531wmh.0
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 08:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=grrajiSdCpFboFKIiSZ05vISxooNWFcM6cC+zP71AZI=;
        b=epqwaf0ZZdU8C1vjJSOM1FvUsyUy+cweceQgbxMur1y1OalSdtIBJRfL1mcqRydU4Q
         ldC0OPgolhjhiwkjGg+CfJBQ9M3hE7iw1g09L7kvfFfDuTz7OIvZP7oQTvaI8GScgz9p
         2fCQdcXm0udaodpNVaN2f9GeboPhKEV7eXMV3wGIg4HgKmgFpFJKgNui/HRNG8+2Q7i/
         sgETGCj1a0OQ4CRSu7iSfflvAfmgW7++AxTYdhjLIc4v3FeMXfkfMsMf8z216DG83Rj3
         zfeJnTKC2XDIURPl2eV3DkQquKa5627eXNgcrz2Cxflc5X3W2hanXT8gyeqFWjDEFFRJ
         VDWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=grrajiSdCpFboFKIiSZ05vISxooNWFcM6cC+zP71AZI=;
        b=BmHI8i02m+RWXgJc/vFa1fMQDWm0f7Z4sSkLHcBDwHZ+D31XjP11K4i7XdqD7ynAVc
         lF8PvxrhyBsbJK3SrnYq0+KLm9Bde8D5yFh1RzfCU9sNq8YuKSkNxjYr5aVtpZgIsaXS
         RSlkVul6fecoSYg56nfV5aJZ332R+R3BhEMvwvs6K/JytEiaICHpwolI5aAOavv5Hd6K
         UhRVbwVdp87hN818S7mS5fENc5AyTVhrVgdpHrbLR5fgrP4E/wDhPCAxvJnuf3pL7lMg
         9L69rwlCj6OG1bPsjZIubjgAl0JKteBhE3JfUj8NXDWdQIk+HNE0RVPnZWL5FchWQ/Ou
         Jizg==
X-Gm-Message-State: AOAM532O2rm1eKJlbYpWLFWe9uuSG0HjT32oY16g9uPlg4rDo6gvtoLY
        AGHyD+tEBj26H4C90kRJnlcyY2esL4A6HA==
X-Google-Smtp-Source: ABdhPJzq0f1OLaZR1bkOhX2YohE/OuxSm27uucScPq9XC3Rt4xT+8qwDg/pdiUI10lIyMWhXz1m1vw==
X-Received: by 2002:a1c:7406:: with SMTP id p6mr282609wmc.103.1615910327720;
        Tue, 16 Mar 2021 08:58:47 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m132sm3439060wmf.45.2021.03.16.08.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 08:58:47 -0700 (PDT)
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
Subject: [PATCH v3 11/32] tree.h: format argument lists of read_tree_recursive() users
Date:   Tue, 16 Mar 2021 16:58:08 +0100
Message-Id: <20210316155829.31242-12-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.256.gf0ddda3145
In-Reply-To: <20210316021312.13927-1-avarab@gmail.com>
References: <20210316021312.13927-1-avarab@gmail.com>
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
index c19300ecb9..77d1238df9 100644
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
index 0e66390520..0887352db2 100644
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
index 980de59063..b7b76856a9 100644
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
index 3a442631c7..8d5c3fd058 100644
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
index 1c9b08695a..689a3e0007 100644
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
index f0b079d2e9..c1a936fdc4 100644
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
2.31.0.256.gf0ddda3145

