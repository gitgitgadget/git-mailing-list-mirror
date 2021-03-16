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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C626DC433E9
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 16:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 938AB65101
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 16:00:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238385AbhCPQAM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 12:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238276AbhCPP7E (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 11:59:04 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6EA0C06174A
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 08:59:03 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id n11-20020a05600c4f8bb029010e5cf86347so4069472wmq.1
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 08:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U5XIDHSD+13c2qHVPx6WWHeZIFpAoMOzQ1WKVVeV+6o=;
        b=QsEAt8Am+kWc5Hdul4GSbN4kz4BbPceTowul6k+gtKIpRrfXwe3+Uk6Msb/6hE1ePv
         sBPwKrPNAr+xq4xU5aIZVw07Y9DEcI4wuJcOhOn7pgByrooBJhP937UHRJnya4o4DL1A
         ACpaJgOKQ5tjf86ZCp+pTZvsOz/ql7p815KpgC8B3ndPdRXvQVrLCk2ADRDx8Eh4LUqK
         wNBbkb95nSD0I5eAke3SpE6RORMFAsSQFx9esEVtQM8jmnYiJJBXX8MAdr7nRoQTK/Rm
         ZSPDA5ACbEm4ZGwss5h/udMfOiE2a8FIguWgZ4qD+1LWE4q09Nutu5KIxdJxzVr/OWoq
         09Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U5XIDHSD+13c2qHVPx6WWHeZIFpAoMOzQ1WKVVeV+6o=;
        b=e6N8qx2rOj57ZT3XgVQz9Pqa0ffSg2BLWWYS6WE5KOrqZCNXt/E/c/IteayUBnE3Ah
         pWhdO148PkZoVXkhVau69BE64AUPsX0msfpx29Z+5Vfv/+S5KmFWA60Pre1AvDFpSNvw
         Njh3f8ez7CRCs+1yrMtmxeFwNWN9/t7PL3JtVu+gDFqDVspRZz2WE2B9iNb5+g8giw7n
         xNnOUoOienkkrLYj/Ljz+9Yy24c20K4mxfajPwab8xCV+JkHe1/OHezrgDsIOo/TjEGJ
         miTkhEB1PI4oQSns3XQCayB1puCouE5Ccs37AQq+373EWgZ3VcEsRxuECU3jWnyrj4bk
         KIKw==
X-Gm-Message-State: AOAM533Qi33L0qXRg7Iqa15AMrsDpk7ZhHNDr6Z9hOBHBrCTOruBcAXx
        o7IexwU7m8AVHd8c6rzqEtjPpiBx75laFQ==
X-Google-Smtp-Source: ABdhPJw+2iZ0ZUcOg7GkxuusmDn+FdGJvZjAEEsj1qB1qsG6NCdD1K+2m73j2LDSjRfhbJHZJ+AgoA==
X-Received: by 2002:a1c:3c02:: with SMTP id j2mr323279wma.92.1615910342113;
        Tue, 16 Mar 2021 08:59:02 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m132sm3439060wmf.45.2021.03.16.08.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 08:59:01 -0700 (PDT)
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
Subject: [PATCH v3 27/32] tree-entry.h API: rename tree_entry_extract() to tree_entry_extract_mode()
Date:   Tue, 16 Mar 2021 16:58:24 +0100
Message-Id: <20210316155829.31242-28-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.256.gf0ddda3145
In-Reply-To: <20210316021312.13927-1-avarab@gmail.com>
References: <20210316021312.13927-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As with the recent split of the get_tree_entry() function, rename the
tree_entry_extract() function to *_mode() in preparation for adding
other variants of it.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 fsck.c        | 2 +-
 match-trees.c | 4 ++--
 tree-diff.c   | 4 ++--
 tree-walk.h   | 6 +++---
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/fsck.c b/fsck.c
index 7c74c49d32..11678ba582 100644
--- a/fsck.c
+++ b/fsck.c
@@ -670,7 +670,7 @@ static int fsck_tree(const struct object_id *oid,
 		const char *name, *backslash;
 		const struct object_id *oid;
 
-		oid = tree_entry_extract(&desc, &name, &mode);
+		oid = tree_entry_extract_mode(&desc, &name, &mode);
 
 		has_null_sha1 |= is_null_oid(oid);
 		has_full_path |= !!strchr(name, '/');
diff --git a/match-trees.c b/match-trees.c
index 3177558313..2afa496810 100644
--- a/match-trees.c
+++ b/match-trees.c
@@ -146,7 +146,7 @@ static void match_trees(const struct object_id *hash1,
 		unsigned short mode;
 		int score;
 
-		elem = tree_entry_extract(&one, &path, &mode);
+		elem = tree_entry_extract_mode(&one, &path, &mode);
 		if (!S_ISDIR(mode))
 			goto next;
 		score = score_trees(elem, hash2);
@@ -202,7 +202,7 @@ static int splice_tree(const struct object_id *oid1, const char *prefix,
 		unsigned short mode;
 		int len = tree_entry_len(&desc.entry);
 
-		tree_entry_extract(&desc, &name, &mode);
+		tree_entry_extract_mode(&desc, &name, &mode);
 		if (len == toplen &&
 		    !memcmp(name, prefix, toplen)) {
 			if (!S_ISDIR(mode))
diff --git a/tree-diff.c b/tree-diff.c
index 088ed52d6a..65c7e4dbc8 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -196,7 +196,7 @@ static struct combine_diff_path *emit_path(struct combine_diff_path *p,
 
 	if (t) {
 		/* path present in resulting tree */
-		oid = tree_entry_extract(t, &path, &mode);
+		oid = tree_entry_extract_mode(t, &path, &mode);
 		pathlen = tree_entry_len(&t->entry);
 		isdir = S_ISDIR(mode);
 	} else {
@@ -207,7 +207,7 @@ static struct combine_diff_path *emit_path(struct combine_diff_path *p,
 		 * 1) all modes for tp[i]=tp[imin] should be the same wrt
 		 *    S_ISDIR, thanks to base_name_compare().
 		 */
-		tree_entry_extract(&tp[imin], &path, &mode);
+		tree_entry_extract_mode(&tp[imin], &path, &mode);
 		pathlen = tree_entry_len(&tp[imin].entry);
 
 		isdir = S_ISDIR(mode);
diff --git a/tree-walk.h b/tree-walk.h
index f51485250f..805cda649e 100644
--- a/tree-walk.h
+++ b/tree-walk.h
@@ -48,9 +48,9 @@ struct tree_desc {
  *
  * tree_entry_extract_mode(): const char *path, unsigned int mode
  */
-static inline const struct object_id *tree_entry_extract(struct tree_desc *desc,
-							 const char **pathp,
-							 unsigned short *modep)
+static inline const struct object_id *tree_entry_extract_mode(struct tree_desc *desc,
+							      const char **pathp,
+							      unsigned short *modep)
 {
 	*pathp = desc->entry.path;
 	*modep = desc->entry.mode;
-- 
2.31.0.256.gf0ddda3145

