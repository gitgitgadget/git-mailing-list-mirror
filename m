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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 755FBC433E1
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 00:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5784B61936
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 00:02:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbhCUACK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Mar 2021 20:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbhCUAB3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Mar 2021 20:01:29 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1AF5C061762
        for <git@vger.kernel.org>; Sat, 20 Mar 2021 17:01:28 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id k128so5012027wmk.4
        for <git@vger.kernel.org>; Sat, 20 Mar 2021 17:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8CVLaIriFpXwJZ4DqdeseXsEucpm17UtJ7YKDS7a5Sc=;
        b=sj//gjvNnmUAxu2evnPCLupv9SXL+2FjPsbV2PIasNDKBMfIiVHO0d4w2UiXzFSzCD
         8cVvcRlUhiktPO5axfLEqDpNHlWBqJsA8ofl+Yi98fAcRjmn7Zm1BvvCAM6BXSecQttv
         TuT1tOXDaoGTYNI1WdUf4w5oN5IX5M9Gl34N9yHAJ1RbVQfBMOnp4HJorsNaM9JgvPN+
         gL+0j689LMnQQTA5inL3oXqh0tc5WxVDPP2eejDzIP71SrFVl2bV4DMgBhjxEk4erYL0
         sD6W7ADcGAQbHalnTCDi/xVhTRS+bFyqmjEt2O3XfYKYbUlGYSawLWnHPnW0QaSg5fSs
         SOkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8CVLaIriFpXwJZ4DqdeseXsEucpm17UtJ7YKDS7a5Sc=;
        b=muElHvlDNyZXjggOCNG9vwrF9hM70J+r0LDL5Cedy0Rr5+W1/ZgblIlUGbppMUgudj
         UhTfPAn9647wO70M17gyi1W2UCq75FObPyqbpTH4QQut39JCD3KFlgQKLzA7xKS0dNBB
         YUVao1MYitSz/iYLOfUnPXxvUBRUmiEloP/fSlebU7xvjcv9WoeENSA+GqrBKnDAUNXf
         KRh24tFrlu5xqsVYW8sAY33LAhMADPJIFHCZFobnaFlY1Bs+Ow6AwJfwpGO/AqmNrLpJ
         vDQ5JSxvo6kn6j9fAbHn5ZPAbxSb4gMhf+7LyqATgl5rt6JZXcjNQm8l82w9kj65huUz
         VfrA==
X-Gm-Message-State: AOAM532wIHsNHrhN8/gyOLV4104mZCAVMOnSyBK0h4g5n6R6e3yPfzSz
        +g1CI61nkn04pbzA7tQjnIkjiOhOMOyT3g==
X-Google-Smtp-Source: ABdhPJycWdBI4VkAYW/CbcdsCUQBjtPnwSpxwElyzxm+rkUq0Prra/0RhS158UqzT3mkbJ+ks+21LQ==
X-Received: by 2002:a05:600c:204a:: with SMTP id p10mr8810988wmg.55.1616284887198;
        Sat, 20 Mar 2021 17:01:27 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g5sm15304834wrq.30.2021.03.20.17.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Mar 2021 17:01:26 -0700 (PDT)
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
Subject: [PATCH v4 01/29] notes & match-trees: use name_entry's "pathlen" member
Date:   Sun, 21 Mar 2021 01:00:34 +0100
Message-Id: <0390b1e9dedd89ecffd4b7b4ecc68e3ac8f66147.1616282534.git.avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.282.gcc1ec606501
In-Reply-To: <cover.1616282533.git.avarab@gmail.com>
References: <20210316155829.31242-1-avarab@gmail.com> <cover.1616282533.git.avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change code that was doing a strlen() on the "path" from a name_entry
struct to instead use the pathlen given to us by decode_tree_entry().

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 match-trees.c | 7 +++----
 notes.c       | 4 ++--
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/match-trees.c b/match-trees.c
index f6c194c1cca..1011357ad0c 100644
--- a/match-trees.c
+++ b/match-trees.c
@@ -197,9 +197,10 @@ static int splice_tree(const struct object_id *oid1, const char *prefix,
 	while (desc.size) {
 		const char *name;
 		unsigned short mode;
+		int len = tree_entry_len(&desc.entry);
 
 		tree_entry_extract(&desc, &name, &mode);
-		if (strlen(name) == toplen &&
+		if (len == toplen &&
 		    !memcmp(name, prefix, toplen)) {
 			if (!S_ISDIR(mode))
 				die("entry %s in tree %s is not a tree", name,
@@ -214,9 +215,7 @@ static int splice_tree(const struct object_id *oid1, const char *prefix,
 			 *   - to discard the "const"; this is OK because we
 			 *     know it points into our non-const "buf"
 			 */
-			rewrite_here = (unsigned char *)(desc.entry.path +
-							 strlen(desc.entry.path) +
-							 1);
+			rewrite_here = (unsigned char *)(name + len + 1);
 			break;
 		}
 		update_tree_entry(&desc);
diff --git a/notes.c b/notes.c
index a19e4ad7943..e2fec12a39e 100644
--- a/notes.c
+++ b/notes.c
@@ -413,7 +413,7 @@ static void load_subtree(struct notes_tree *t, struct leaf_node *subtree,
 	while (tree_entry(&desc, &entry)) {
 		unsigned char type;
 		struct leaf_node *l;
-		size_t path_len = strlen(entry.path);
+		int path_len = entry.pathlen;
 
 		if (path_len == 2 * (hashsz - prefix_len)) {
 			/* This is potentially the remainder of the SHA-1 */
@@ -483,7 +483,7 @@ static void load_subtree(struct notes_tree *t, struct leaf_node *subtree,
 				strbuf_addch(&non_note_path, *q++);
 				strbuf_addch(&non_note_path, '/');
 			}
-			strbuf_addstr(&non_note_path, entry.path);
+			strbuf_add(&non_note_path, entry.path, path_len);
 			add_non_note(t, strbuf_detach(&non_note_path, NULL),
 				     entry.mode, entry.oid.hash);
 		}
-- 
2.31.0.286.gc175f2cb894

