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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7901FC4345E
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 00:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 648B26193A
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 00:02:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbhCUACc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Mar 2021 20:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbhCUABr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Mar 2021 20:01:47 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E3BC061574
        for <git@vger.kernel.org>; Sat, 20 Mar 2021 17:01:46 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id e9so12850858wrw.10
        for <git@vger.kernel.org>; Sat, 20 Mar 2021 17:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2/yNYOjyZLfE/PPCwEVbyxIQT/xDUDMzYPPMQIuBPvI=;
        b=b0o4t8+1d3VFNmH+6eShnBz/v13rrTDecgfwQj10RsAzY6y+4SomLVaPkm/wdDJ/Q1
         lIKJQYchxqgdl4rzdjOkl+1ukhVKxanltbrIpF5ZLL3ckEdXCdM2JpX0eFRQQohQmw11
         K3L+0vK+0HUJIyP357xlcdX0Yq073zgS2Bcx532kxtTWp/TYpmXee4XNS/VTOgvaLqlp
         3QGV5kAhNdZ1EbNjMBdOYPDXcu6AC8C8Ug+Odzz0YZb9186W1rvJlVv3eIuMP5yof0hX
         FBoj9Pf186ycYfDOB8Dpb5YEycGImio7bim4PjLnBnnMbcsjgGEQRJdwO9SwUwgkAaT2
         4/gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2/yNYOjyZLfE/PPCwEVbyxIQT/xDUDMzYPPMQIuBPvI=;
        b=ncX5mbOiQvxEgeD9agIenYK/KcSY39ZzRa5qG/13P+iAsxzzKMV6PkJvJ/iP84YUqU
         4Gmx3ZzmtD6wDQL1KjBhsgZN1nVx6n8Y2TNqHUld3yWzAqkqg25WKxnDE/xYMyKgHJgQ
         aDPqBClzG02Tn8MBltaMZJMA38pIfcpPWVluH2ciTdisFbbX4206G6BfX9Q4CcYFdXDe
         kBKWlUzfMCk5ki79Sp2QCpn3bcoEG/SsykzJdvCXW+xKQbhAMD5L7l1+G7Zppys9mNx1
         yKJKeV+r78uFrOR49gcOUae7XMIpaCHxyHMUCBzOjgfiJ2PZO88npvGCTXpoTMiP2pWM
         cIJw==
X-Gm-Message-State: AOAM530tRwqGqfRb4D5rrvIL4piu62ROaPmmKjxTWmnwl9zA7MeQK1wt
        akC38oYHMHiCa3/xz1DYBqIAW/OSrVQoBg==
X-Google-Smtp-Source: ABdhPJwUED1TIMQXWw1MrP2ujirjah/vCd7xpZksgZTWZxPUNUO3dDzxec9NZp3O3XoPvvfL6N+glg==
X-Received: by 2002:adf:8562:: with SMTP id 89mr11265289wrh.101.1616284905109;
        Sat, 20 Mar 2021 17:01:45 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g5sm15304834wrq.30.2021.03.20.17.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Mar 2021 17:01:44 -0700 (PDT)
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
Subject: [PATCH v4 24/29] tree-entry.h API: rename tree_entry_extract() to tree_entry_extract_mode()
Date:   Sun, 21 Mar 2021 01:00:57 +0100
Message-Id: <a1bd81d64aa9f42e70848a0a0c2abc896b475e6f.1616282534.git.avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.282.gcc1ec606501
In-Reply-To: <cover.1616282533.git.avarab@gmail.com>
References: <20210316155829.31242-1-avarab@gmail.com> <cover.1616282533.git.avarab@gmail.com>
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
2.31.0.286.gc175f2cb894

