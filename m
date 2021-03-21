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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4F88C43470
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 00:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C6BC61937
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 00:02:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbhCUACh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Mar 2021 20:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbhCUABu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Mar 2021 20:01:50 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A0DDC061574
        for <git@vger.kernel.org>; Sat, 20 Mar 2021 17:01:50 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id j4-20020a05600c4104b029010c62bc1e20so7163933wmi.3
        for <git@vger.kernel.org>; Sat, 20 Mar 2021 17:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z3mnO3qhEMgg8gs0MModCdWFcXwab8OR7ro599Z03MA=;
        b=Tc0NJF1gnPEQQ0hxMI8OGNIzDjW+5O7P356pEif50D75Wwcs81SR5ohfK3lUGgNzZm
         NoYxmtmoQMQmSdQWPuERjBufu1SxrMNfxJl/yT/A82mxutwKKhlpq0VnxILeeYUSiZ8e
         fQn10GouE7kGuvYF1JcPPx6yDogqM398QbykuMme20TGmbRgRsDg/I49tQc2Z/R5kkac
         DfgZZozcGDT2Ip3z3Z5ccItNkhqJC5bsXcB7F+C2GESTNK8XzJNz2wFyIcuWTQMoRdzv
         KfBGOt1vk9JfSlxJ3/ZaIoUIVAvp21qI1tfYqcN1MSnZmpmjTwMQmNVZAYTOPdWKyFdF
         QZ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z3mnO3qhEMgg8gs0MModCdWFcXwab8OR7ro599Z03MA=;
        b=CfLErl+ksLHq21X/NCE1dJBQC++gPOxq8SiDSak+8vTG79C9TzaGlkLNy/ESt5guak
         PG62EVwYQhLX43caF6TAu2Fz27rfaaiMG4msTWfILAgIOKO2VLh97SNBBHMMzJkCBBvR
         x485XG/fGQDO/QPZs7bI2hg5phXo7MwklmNlTSTNDMuj+Is4UxTRQGSJL5us8QacuF3c
         nHb5OT2UpSEp8RMAIC5FRPkuG+gsDg+Eq3aRKI/CtwJO6lnpp9HuroRdPhBWUGgYFN90
         DwTZqcMzxVC4dDEtGDn0rzPd0f8sobaRLDAJki4sHRwo6Q/qtwCFP1zJV25X6zSt0kTI
         6V0A==
X-Gm-Message-State: AOAM531CzYZhf9U5MrJpamuq0k0lhs6dAhwNc225reZDQpFERBfDz+SW
        dr5AwEA5ZY355B/hsTLagka2eTEMbrgrjQ==
X-Google-Smtp-Source: ABdhPJyTujJSmK3GbUzfQ5FdqFrJIAP1zfJ6SkXNymY6iQuL7KaDKp5vbZrsNT5aPGKyBtH2GC/u2w==
X-Received: by 2002:a7b:cd8f:: with SMTP id y15mr9669879wmj.185.1616284908715;
        Sat, 20 Mar 2021 17:01:48 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g5sm15304834wrq.30.2021.03.20.17.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Mar 2021 17:01:48 -0700 (PDT)
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
Subject: [PATCH v4 29/29] tree-walk.h API: add a tree_entry_extract_type() function
Date:   Sun, 21 Mar 2021 01:01:02 +0100
Message-Id: <4d51da4ea39c11ac56972da8fa4e5becff7294f7.1616282534.git.avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.282.gcc1ec606501
In-Reply-To: <cover.1616282533.git.avarab@gmail.com>
References: <20210316155829.31242-1-avarab@gmail.com> <cover.1616282533.git.avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add and use a tree_entry_extract_type() function. There were callers
of tree_entry_extract() which didn't care about the mode, but just the
type in the tree entry.

In emit_path() the "mode" variable was not used after the "isdir"
assignment, as can be seen in the diff with it being set to 0.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 match-trees.c | 12 ++++++------
 tree-diff.c   |  5 +++--
 tree-walk.h   | 11 +++++++++++
 3 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/match-trees.c b/match-trees.c
index 25bfb46fb02..89109659aa3 100644
--- a/match-trees.c
+++ b/match-trees.c
@@ -143,11 +143,11 @@ static void match_trees(const struct object_id *hash1,
 	while (one.size) {
 		const char *path;
 		const struct object_id *elem;
-		unsigned short mode;
+		enum object_type object_type;
 		int score;
 
-		elem = tree_entry_extract_mode(&one, &path, &mode);
-		if (!S_ISDIR(mode))
+		elem = tree_entry_extract_type(&one, &path, &object_type);
+		if (object_type != OBJ_TREE)
 			goto next;
 		score = score_trees(elem, hash2);
 		if (*best_score < score) {
@@ -198,14 +198,14 @@ static int splice_tree(const struct object_id *oid1, const char *prefix,
 
 	rewrite_here = NULL;
 	while (desc.size) {
+		enum object_type object_type;
 		const char *name;
-		unsigned short mode;
 		int len = tree_entry_len(&desc.entry);
 
-		tree_entry_extract_mode(&desc, &name, &mode);
+		tree_entry_extract_type(&desc, &name, &object_type);
 		if (len == toplen &&
 		    !memcmp(name, prefix, toplen)) {
-			if (!S_ISDIR(mode))
+			if (object_type != OBJ_TREE)
 				die("entry %s in tree %s is not a tree", name,
 				    oid_to_hex(oid1));
 
diff --git a/tree-diff.c b/tree-diff.c
index 918ad95fa61..8409374f0ba 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -208,10 +208,11 @@ static struct combine_diff_path *emit_path(struct combine_diff_path *p,
 		 * 1) all modes for tp[i]=tp[imin] should be the same wrt
 		 *    S_ISDIR, thanks to base_name_compare().
 		 */
-		tree_entry_extract_mode(&tp[imin], &path, &mode);
+		enum object_type object_type;
+		tree_entry_extract_type(&tp[imin], &path, &object_type);
 		pathlen = tree_entry_len(&tp[imin].entry);
 
-		isdir = S_ISDIR(mode);
+		isdir = object_type == OBJ_TREE;
 		oid = NULL;
 		mode = 0;
 	}
diff --git a/tree-walk.h b/tree-walk.h
index efcd7ccd10e..f5102ed5427 100644
--- a/tree-walk.h
+++ b/tree-walk.h
@@ -47,6 +47,7 @@ struct tree_desc {
  * appropriate variable to fill in (NULL won't do!):
  *
  * tree_entry_extract_mode(): const char *path, unsigned int mode
+ * tree_entry_extract_type(): const char *path, enum object_type
  * tree_entry_extract_all(): const char *path, unsigned int mode, enum object_type
  */
 static inline const struct object_id *tree_entry_extract_mode(struct tree_desc *desc,
@@ -58,6 +59,16 @@ static inline const struct object_id *tree_entry_extract_mode(struct tree_desc *
 	return &desc->entry.oid;
 }
 
+static inline const struct object_id *tree_entry_extract_type(struct tree_desc *desc,
+							      const char **pathp,
+							      enum object_type *object_typep)
+{
+	*pathp = desc->entry.path;
+	*object_typep = desc->entry.object_type;
+	return &desc->entry.oid;
+}
+
+
 static inline const struct object_id *tree_entry_extract_all(struct tree_desc *desc,
 							     const char **pathp,
 							     unsigned short *modep,
-- 
2.31.0.286.gc175f2cb894

