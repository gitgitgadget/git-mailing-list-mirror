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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76065C15510
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 15:08:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6054A6523F
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 15:08:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbhCHPHz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Mar 2021 10:07:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231504AbhCHPHf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Mar 2021 10:07:35 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B21C06175F
        for <git@vger.kernel.org>; Mon,  8 Mar 2021 07:07:35 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id e10so11774712wro.12
        for <git@vger.kernel.org>; Mon, 08 Mar 2021 07:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a0WhpeKVinvDVZW2Pgr4IK7FFj6o05fXWt1Qooe4/5Y=;
        b=EojScPcseCuI5ewT5DEau2KJ30z8UY/kB0q1yk9Mzg/4JHWeR223c68z3nX4nw841P
         MWJIxDRlh38yO9J+1p+6XZnJ0V1EBEFQD0HJazf3dDw1Cwc2AMS4T9v47eHH7Ml4b6u7
         NSJ146kmhH/Btz1XOu1VbGouDSmS5xmW0Bc9t3ZYJL40MZ6b6TsMDTzNhSUGBG8hMrcj
         NKS/n3PnE5srA1FqTelq9BJMEUukBQ6+Ng9BnhR2fkiAzkt49UB2kr2R22O8Axy4yVoW
         MWdJ4BJHt96nODt00GEIAq4C2imxDO0btfdBOlvVOl2363AlQjDFtoHNqqFx7PsLXdjH
         zBqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a0WhpeKVinvDVZW2Pgr4IK7FFj6o05fXWt1Qooe4/5Y=;
        b=W2OAzUDmvpQWUSzoHZXq2OzqqTFr19GbiuhhXMDpiXimXJABA3MJGCsQQScVCuA82R
         0CjWM9dsg5uz4BXzQxiJh2u5OwmsYYWxwDGynVHFwHWe+63TRacxSjTj9P8WRtHnIv2x
         y088nmIrJ3usa5P5O7ig7OZHXQBcWptiL/PqrxBHB4uM/52LSgMJeeQJBiWPgw0vYLy4
         +bOOsab9Aq3qNJxSMuezQ+MXU0VJfWgTR0tKNRHeZut9boNXweXTA6KntgyRn9EfY8bJ
         N//qRbhQEFmuoQiDviIDYAbHGQ17F92GpNuZ/nR/ZCdwYo7fq3BSi27bYgCu4X4gqA0i
         Sw/Q==
X-Gm-Message-State: AOAM530RT14IkeKflvf+MdxXnaqlcBOGPPk1nfDxcDj6xSOQ8qQuwvCp
        cArda1NdcMqViP9vvJq3fQfCidVxTelyXQ==
X-Google-Smtp-Source: ABdhPJxyzl5DxOqtF/MJs2T78os/ocJb4nTySH4qh+0tXQeAjza94sE80v2zla9CzEd32Hld8Tuqjg==
X-Received: by 2002:a5d:6602:: with SMTP id n2mr23729501wru.262.1615216053765;
        Mon, 08 Mar 2021 07:07:33 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j13sm3820488wrt.29.2021.03.08.07.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 07:07:33 -0800 (PST)
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
Subject: [PATCH 29/30] tree.h API users: rename read_tree_fn_t's "mode" to "raw_mode"
Date:   Mon,  8 Mar 2021 16:06:49 +0100
Message-Id: <20210308150650.18626-30-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc0.126.g04f22c5b82
In-Reply-To: <20210308022138.28166-1-avarab@gmail.com>
References: <20210308022138.28166-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename the "mode" variable passed to read_tree_fn_t callbacks to
"raw_mode". This variable comes to us from the tree-walk.h API. By
renaming this variable we can easily see where its downstream users
are in a subsequent commit where we'll sprinkle some canon_mode()
here.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 archive.c          |  5 +++--
 builtin/log.c      |  2 +-
 builtin/ls-files.c | 11 ++++++-----
 builtin/ls-tree.c  |  6 +++---
 merge-recursive.c  |  2 +-
 5 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/archive.c b/archive.c
index bc8f1c7546f..5b85aae8106 100644
--- a/archive.c
+++ b/archive.c
@@ -232,10 +232,11 @@ static int write_directory(struct archiver_context *c)
 
 static int queue_or_write_archive_entry(const struct object_id *oid,
 					struct strbuf *base, const char *filename,
-					enum object_type object_type, unsigned mode,
+					enum object_type object_type, unsigned raw_mode,
 					void *context)
 {
 	struct archiver_context *c = context;
+	unsigned mode = raw_mode;
 
 	while (c->bottom &&
 	       !(base->len >= c->bottom->len &&
@@ -382,7 +383,7 @@ struct path_exists_context {
 
 static int reject_entry(const struct object_id *oid, struct strbuf *base,
 			const char *filename,
-			enum object_type object_type, unsigned mode,
+			enum object_type object_type, unsigned raw_mode,
 			void *context)
 {
 	int ret = -1;
diff --git a/builtin/log.c b/builtin/log.c
index 19a916221d5..c3ef1b3e22d 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -599,7 +599,7 @@ static int show_tag_object(const struct object_id *oid, struct rev_info *rev)
 
 static int show_tree_object(const struct object_id *oid,
 			    struct strbuf *base, const char *pathname,
-			    enum object_type object_type, unsigned mode,
+			    enum object_type object_type, unsigned raw_mode,
 			    void *context)
 {
 	FILE *file = context;
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index f38df439410..391e6a9f141 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -425,10 +425,11 @@ static int read_one_entry_opt(struct index_state *istate,
 			      const struct object_id *oid,
 			      struct strbuf *base,
 			      const char *pathname,
-			      unsigned mode, int opt)
+			      unsigned raw_mode, int opt)
 {
 	int len;
 	struct cache_entry *ce;
+	unsigned mode = raw_mode;
 
 	if (S_ISDIR(mode))
 		return READ_TREE_RECURSIVE;
@@ -447,12 +448,12 @@ static int read_one_entry_opt(struct index_state *istate,
 
 static int read_one_entry(const struct object_id *oid, struct strbuf *base,
 			  const char *pathname,
-			  enum object_type object_type, unsigned mode,
+			  enum object_type object_type, unsigned raw_mode,
 			  void *context)
 {
 	struct index_state *istate = context;
 	return read_one_entry_opt(istate, oid, base, pathname,
-				  mode,
+				  raw_mode,
 				  ADD_CACHE_OK_TO_ADD|ADD_CACHE_SKIP_DFCHECK);
 }
 
@@ -462,12 +463,12 @@ static int read_one_entry(const struct object_id *oid, struct strbuf *base,
  */
 static int read_one_entry_quick(const struct object_id *oid, struct strbuf *base,
 				const char *pathname,
-				enum object_type object_type, unsigned mode,
+				enum object_type object_type, unsigned raw_mode,
 				void *context)
 {
 	struct index_state *istate = context;
 	return read_one_entry_opt(istate, oid, base, pathname,
-				  mode,
+				  raw_mode,
 				  ADD_CACHE_JUST_APPEND);
 }
 
diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index c6ec3ca751e..3f84603d391 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -63,7 +63,7 @@ static int show_recursive(const char *base, int baselen, const char *pathname)
 
 static int show_tree(const struct object_id *oid, struct strbuf *base,
 		     const char *pathname,
-		     enum object_type object_type, unsigned mode,
+		     enum object_type object_type, unsigned raw_mode,
 		     void *context)
 {
 	int retval = 0;
@@ -103,11 +103,11 @@ static int show_tree(const struct object_id *oid, struct strbuf *base,
 						  "%"PRIuMAX, (uintmax_t)size);
 			} else
 				xsnprintf(size_text, sizeof(size_text), "-");
-			printf("%06o %s %s %7s\t", mode, type,
+			printf("%06o %s %s %7s\t", raw_mode, type,
 			       find_unique_abbrev(oid, abbrev),
 			       size_text);
 		} else
-			printf("%06o %s %s\t", mode, type,
+			printf("%06o %s %s\t", raw_mode, type,
 			       find_unique_abbrev(oid, abbrev));
 	}
 	baselen = base->len;
diff --git a/merge-recursive.c b/merge-recursive.c
index b26d9d418f9..30fbe72ca06 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -453,7 +453,7 @@ static void unpack_trees_finish(struct merge_options *opt)
 
 static int save_files_dirs(const struct object_id *oid,
 			   struct strbuf *base, const char *path,
-			   enum object_type object_type, unsigned int mode,
+			   enum object_type object_type, unsigned int raw_mode,
 			   void *context)
 {
 	struct path_hashmap_entry *entry;
-- 
2.31.0.rc0.126.g04f22c5b82

