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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC000C4363E
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 19:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF7C861056
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 19:10:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235992AbhCaTKf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Mar 2021 15:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235443AbhCaTKO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Mar 2021 15:10:14 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1139C061574
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 12:10:01 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id j9so19018343wrx.12
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 12:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HGHazN0uO95Nwe/gdbiBl2FhfwnycXz/r85BvXytOwU=;
        b=vSrOKIp+MGnc7kxFWE+iQoOMJgDbi2mvbyiuLHVBwDLcHQDzd9GLSsG/pNDTrJok/2
         Oj7loFtvw3TXszE2oFggug5bnEYnbQxKggL76o38sRdki67yih4KOuY5BLQu+cRKXf3O
         FpKTjeUkbrvgH1fHWXiJrWMd2mr1vBkykqt6kPYlE7S6Q6GkcQkQfPZ2MP2B28WE/sCH
         XaTX0sSmDA1PWrqAo9xG/QlVi0bQ0PJV3OIFBnNgE/F7PoRaAp5VRQsIg93EDnVBqxBa
         U17lcZtiqk3QJSlzy8LJE4Gi91wk+re4+Qai37nD6md3U7fyfJYbsLduooEuWcFjVBJV
         i5NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HGHazN0uO95Nwe/gdbiBl2FhfwnycXz/r85BvXytOwU=;
        b=nX+JCUJUqJFppLnj+kWr7EsxH2tFO9KTww50BYuGykmC0uSLgVfLKX84mPosGh6Fhl
         uIfiP81vOqOKz/4CFS3X2tin7Cw018sI8+Wu/E6SATre2ZFR8HwefbvHSNmLPBL08zbi
         rnDgHg0KuvR5tE8Z+lponltt3SBuYB42XRdS7VulxQ5pll7b5QUH4Sz0vNf4/pMZHrus
         x/EqX9u4AqIqSf08a5V+kdIV0fwImhJPyLEW4s4Du5/2pH0aJkfoQ8xfhNJGO2/2iBbD
         2PKTRnplnRWN5NyKJnTD9OrzUnT37GifOCsjioFx2gDocZcIZgITaAKytfVNvCGE28cJ
         hd+w==
X-Gm-Message-State: AOAM532mk7P5YjuTDispLnBgOuUY7HyzPI1bKRzrwBRaWM6coDCh5vzJ
        vDUxK8XNXH9a5lT1FckGrb+2gb6o7dTxHw==
X-Google-Smtp-Source: ABdhPJzGmOQlLIBz3qKrzF/0JMW+YAwBVuf0AM/fpm1IJSBP4T5We3RhAy0GZ7/36+noxBwUkkRnOQ==
X-Received: by 2002:a5d:564b:: with SMTP id j11mr5398948wrw.326.1617217800043;
        Wed, 31 Mar 2021 12:10:00 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l8sm6019268wrx.83.2021.03.31.12.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 12:09:59 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 12/18] tree.h: format argument lists of read_tree() users
Date:   Wed, 31 Mar 2021 21:09:40 +0200
Message-Id: <patch-12.19-960e15bc7d5-20210331T190531Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.474.g72d45d12706
In-Reply-To: <cover-00.19-00000000000-20210331T190531Z-avarab@gmail.com>
References: <87o8fcqrg8.fsf@evledraar.gmail.com> <cover-00.19-00000000000-20210331T190531Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Re-indent and format the argument list of read_tree() callbacks, and
the relevant functions they call.

This is a whitespace-only change to make changes in a later series
easier to read. In that series I'll be adding a new argument on the
"mode" line, so leave space on it for a new argument.

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
index 295615580d7..6af35a66b56 100644
--- a/archive.c
+++ b/archive.c
@@ -134,8 +134,9 @@ static int check_attr_export_subst(const struct attr_check *check)
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
@@ -225,8 +226,9 @@ static int write_directory(struct archiver_context *c)
 }
 
 static int queue_or_write_archive_entry(const struct object_id *oid,
-		struct strbuf *base, const char *filename,
-		unsigned mode, void *context)
+					struct strbuf *base, const char *filename,
+					unsigned mode,
+					void *context)
 {
 	struct archiver_context *c = context;
 
@@ -372,7 +374,8 @@ struct path_exists_context {
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
2.31.1.474.g72d45d12706

