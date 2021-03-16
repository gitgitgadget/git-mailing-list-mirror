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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 152FDC43333
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 02:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02A9D65032
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 02:14:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234584AbhCPCO1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 22:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234516AbhCPCNy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Mar 2021 22:13:54 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC21EC06174A
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 19:13:53 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id b9so6658659wrt.8
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 19:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zOEKyH1dNIeFXPurPX3RtDhfc3plr4uGW5cRjBacpPE=;
        b=AFNp8FTdR1/2a29FCT2pVKJeZmWBLE08r+jYKZdAyDQuDJaYvkaGDlVolft0XG/LqO
         YtALBN5baXbIejBtbTaoT4FKuugeuZNh0h+2bSMPRSOMLQQdqx/c0eAZxsncCq5Bm9Uc
         pExWdib5G72ZK6aeLs6B76fzG8s5gAYqbDDI/IrIpx06nvVRgb42arEEB9xGHU+aSKd3
         x7/jlLdguXEEurAb/NoIAQ+7HwfaRc2DwTLdfhLu00AznpGg1LKtmahoWkN01/oOMO/l
         0LZt4VTp2ImDTYyRcyeZn7+V06U2clXxTROHyvar0MjwSAYeijgc5Gy0dmIko/JhtA18
         kNuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zOEKyH1dNIeFXPurPX3RtDhfc3plr4uGW5cRjBacpPE=;
        b=nJlNmalTbBj4Q26S35VdaTtArl8IzJy2Kidn8Pci5oRLS3nvxQ++ZQX08lkEkx2fWx
         mJf9khzAUn3WUmh+Y7PM0AiJqDndHlLPmVSwGq/WxD9Jf3fmE+6LnNbl1DXmW9cjoEsT
         b+xu0nB4V6uQhhf+0Ep+veDRolvn+qwTMlGMLOxteg2DvzOOsEtZaHuoLqnFzHD9o+DY
         ERd/c2WhV++rj1awPVzkptAo46RHo2NhGk3HGcEo1BVQ/5WboZjDVqVd3H+twlxip9Q6
         QusG/aJqxHuJW+FxCeTukXfnc0PdEV0JrWA+aLmm3ByF2yCRymBbIBtR7ICilmlgdMQA
         Ucng==
X-Gm-Message-State: AOAM531vK+LTsZg2vrWyRfawgMmV9cqa/eaxjmRzA9imipL8k9kby8m9
        Iy9O6ZH+qAkDOgRVYqvHCOnUerbfIUaUKw==
X-Google-Smtp-Source: ABdhPJzgKjljT1wQEjf0MibXRm4CwX09lzHprtBwu6AMtMQUyhMpPfErDnRvjQtwFz9gv6dvNWo8BA==
X-Received: by 2002:a5d:4485:: with SMTP id j5mr2193285wrq.339.1615860832260;
        Mon, 15 Mar 2021 19:13:52 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i8sm21092494wrx.43.2021.03.15.19.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 19:13:51 -0700 (PDT)
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
Subject: [PATCH v2 24/29] tree-entry.h API: rename tree_entry_extract() to tree_entry_extract_mode()
Date:   Tue, 16 Mar 2021 03:13:07 +0100
Message-Id: <20210316021312.13927-25-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc2.211.g1d0b8788b3
In-Reply-To: <20210308150650.18626-1-avarab@gmail.com>
References: <20210308150650.18626-1-avarab@gmail.com>
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
index 7c74c49d329..11678ba5826 100644
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
index 3177558313e..2afa4968109 100644
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
index 088ed52d6a3..65c7e4dbc8b 100644
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
index f51485250fb..805cda649ee 100644
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
2.31.0.rc2.211.g1d0b8788b3

