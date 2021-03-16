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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27127C4321A
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 02:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 146D465027
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 02:14:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234589AbhCPCO2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 22:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234519AbhCPCNz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Mar 2021 22:13:55 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44157C06174A
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 19:13:55 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id u5-20020a7bcb050000b029010e9316b9d5so554852wmj.2
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 19:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XYMsH1f9RTk8cYGdkePdzOhe8idg5Uv3MYzNgv8XgRc=;
        b=pkh1gr0sYDtHan9R+sF9JzxGyjhkPXp69fN8/roUMJqrXB1L2QCfFUMs91MKyEJCcZ
         eM5uHElToir91Wz0lx5a4XLpwnkWJSoCMtsX9iPJ4usej8TnwGLjWTHo/3Ls/IansZYI
         dn553LKlEPCtH1Z6hXj/kvlwrRn9B1MW2paF9ShIO4VnXCOEwTbmdYSkdNLAGMDMBW7g
         ROfpormOi2MkEFs9bgx8Dbx+nNcn5Wa87MAvGtQStqvkxhSGnX+wwe/tNFSLHUXpyRN2
         8MCyrnpJMG0V5CllaJHz20Mdf1BU3VCnJzEKWxaZaPeXOsxozsqPJ9NNRIX9itb4lQNS
         sJ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XYMsH1f9RTk8cYGdkePdzOhe8idg5Uv3MYzNgv8XgRc=;
        b=Dq2c9PZO8OU4FgbJLP/0v0xbKvzj5XT1KZVF9Wc8elk73bPsOX/nPoB9WFqVfu9Rz8
         K5hFEOoSb0Zb+RSl5xi/PDkUmXcw3RzmCjYtobRL7rSqjPiJSkNHYhk6woFJx6BFGF16
         HMv1Cxqm6frdH/nm2E0dpc9fiaoISsWP2CVshjKVatS12l56YqZJz+COjWtbEHkButzd
         PPdIPqMCUD+YO2vPThf/zW2AP8XVFjXb10nmwurllw6T0Mtc41QA9NL3pZYdID8Vm5Cn
         nnbSX4uaCeQGKqY+CR/OMHJ8wHSOM+1W0wbFWQQjP/b/S261AabUN7+oFxte1azrUGyM
         4r4w==
X-Gm-Message-State: AOAM530rRoCoL74IdWfNc7C1RYb0k27XM2RfR65MityUc9xPUHMsBjGj
        Adnvd/VxGvhlCfiIczWJ20cJCrBDu2LyKA==
X-Google-Smtp-Source: ABdhPJw6NswrN8f/JYDh80zYunSyw8392TwsOYHAINcwQ62cbqePU85Ej9h37ZScq2pICtGHG3OkXw==
X-Received: by 2002:a05:600c:1550:: with SMTP id f16mr2211325wmg.97.1615860833773;
        Mon, 15 Mar 2021 19:13:53 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i8sm21092494wrx.43.2021.03.15.19.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 19:13:53 -0700 (PDT)
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
Subject: [PATCH v2 26/29] tree-walk.h API: add get_tree_entry_all()
Date:   Tue, 16 Mar 2021 03:13:09 +0100
Message-Id: <20210316021312.13927-27-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc2.211.g1d0b8788b3
In-Reply-To: <20210308150650.18626-1-avarab@gmail.com>
References: <20210308150650.18626-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a get_tree_entry_all() function and use it in the one caller who
cares about both the mode and the object type. Refactor it accordingly
to make it clear which parts care about the mode, and which about the
object_type.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/update-index.c | 6 ++++--
 tree-walk.c            | 9 +--------
 tree-walk.h            | 4 ++++
 3 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index 070510d6a88..b489a876392 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -599,16 +599,18 @@ static struct cache_entry *read_one_ent(const char *which,
 					struct object_id *ent, const char *path,
 					int namelen, int stage)
 {
+	enum object_type object_type;
 	unsigned short mode;
 	struct object_id oid;
 	struct cache_entry *ce;
 
-	if (get_tree_entry_mode(the_repository, ent, path, &oid, &mode)) {
+	if (get_tree_entry_all(the_repository, ent, path, &oid,
+			       &mode, &object_type)) {
 		if (which)
 			error("%s: not in %s branch.", path, which);
 		return NULL;
 	}
-	if (mode == S_IFDIR) {
+	if (object_type == OBJ_TREE) {
 		if (which)
 			error("%s: not a blob in %s branch.", path, which);
 		return NULL;
diff --git a/tree-walk.c b/tree-walk.c
index f4473276c9f..a90dbf87af4 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -559,13 +559,6 @@ struct dir_state {
 	struct object_id oid;
 };
 
-static int get_tree_entry_all(struct repository *r,
-			      const struct object_id *tree_oid,
-			      const char *name,
-			      struct object_id *oid,
-			      unsigned short *mode,
-			      enum object_type *object_type);
-
 static int find_tree_entry(struct repository *r, struct tree_desc *t,
 			   const char *name, struct object_id *result,
 			   unsigned short *mode,
@@ -605,7 +598,7 @@ static int find_tree_entry(struct repository *r, struct tree_desc *t,
 	return -1;
 }
 
-static int get_tree_entry_all(struct repository *r,
+int get_tree_entry_all(struct repository *r,
 		       const struct object_id *tree_oid,
 		       const char *name,
 		       struct object_id *oid,
diff --git a/tree-walk.h b/tree-walk.h
index a4c54871747..55ef88ef2e5 100644
--- a/tree-walk.h
+++ b/tree-walk.h
@@ -195,6 +195,7 @@ struct traverse_info {
  *
  * get_tree_entry_mode(): unsigned int mode
  * get_tree_entry_type(): enum object_type
+ * get_tree_entry_all(): unsigned int mode, enum object_type
  */
 int get_tree_entry_mode(struct repository *, const struct object_id *, const char *,
 			struct object_id *,
@@ -202,6 +203,9 @@ int get_tree_entry_mode(struct repository *, const struct object_id *, const cha
 int get_tree_entry_type(struct repository *, const struct object_id *, const char *,
 			struct object_id *,
 			enum object_type *);
+int get_tree_entry_all(struct repository *, const struct object_id *, const char *,
+		       struct object_id *,
+		       unsigned short *, enum object_type *);
 
 /**
  * Generate the full pathname of a tree entry based from the root of the
-- 
2.31.0.rc2.211.g1d0b8788b3

