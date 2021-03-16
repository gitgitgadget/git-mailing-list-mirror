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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E015EC433E9
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 15:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA87864FEA
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 15:59:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238295AbhCPP7S (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 11:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238251AbhCPP6s (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 11:58:48 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 844ADC061764
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 08:58:43 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id z2so7715977wrl.5
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 08:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IXpQ/jRkC/QcIAOV4xkIQE1CbIuI96mg9DpitnJLhTk=;
        b=OjYCXpWiS/zfLLmq1kM6QqwAAeraVs13DlB88LoujAU9FUd7EO7ZIhr1wc5yizmnbu
         EZoJC4rbR30s7Bz+viJyIBraUtd2Furwf8sL8lGY2HNLmrzapYREtZc1EEB1l9VxdqX/
         CmnJD2lQCaanx517Yo1ZTbscP5Hj9HxapaHC+LcsHntykZCX96AS+//C8up/D/07XLEP
         m6Ku3fsUVyKuQRmjAxvCBY2k8gd4wpec6KBu+5COXHq+xNAE+ZT7JWX603unERd0yx7z
         WEnGMMMVAA/jzIDN5MmmvehLuop1tMxbP8hVDaaXv0lsxry+t7FdruGqpUlsQGkiL1hg
         QSHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IXpQ/jRkC/QcIAOV4xkIQE1CbIuI96mg9DpitnJLhTk=;
        b=L5rO29W66ywXk35rnTSoCKi8222X8AEPFfldjr4AqPPW/sradvu21GAqVG4qcltOah
         ydJ0+II26pMrVnL4Jym2pMG6txyRo+6gSoxuOkBmXsPmQNUpaMZkRgTyyB0/QdpWkjba
         yr3Pd+m9fBa6UpotO6dYmdzBvQD1hlhvByX73biT+aawNuxXM/SqhLcrEbP3FqBOv92X
         eukqtgnC7weKM2LxTVyaTG4QTHY47gGIIONLUhP8YDjOlMNF07LfTaVwngw0WVPEXYMR
         mFOZe4fxAkB7yQ8Ao2dVQ62xKJEUFnYvR9w/sekTCfTOIw5tVgqT64OHV20aWQKvXpEq
         0Gtg==
X-Gm-Message-State: AOAM530rR0DZ1Ppz/+2Miyok2nUZTgAQm7upJQkevgucXLgMd/Byk3cL
        LBg9RZtqzEMN7mmtXqd9X1tF4n5nqkQmGA==
X-Google-Smtp-Source: ABdhPJwtCrdgh3gKWfnC0cHiN+LdUApdFSolQP9jJJ1y/UQk9e3Wg1wu5JQjWMVJ14Yycof5aSBW0Q==
X-Received: by 2002:adf:f150:: with SMTP id y16mr5685295wro.414.1615910322005;
        Tue, 16 Mar 2021 08:58:42 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m132sm3439060wmf.45.2021.03.16.08.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 08:58:41 -0700 (PDT)
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
Subject: [PATCH v3 05/32] tree-walk.c: migrate to using new "object_type" field when possible
Date:   Tue, 16 Mar 2021 16:58:02 +0100
Message-Id: <20210316155829.31242-6-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.256.gf0ddda3145
In-Reply-To: <20210316021312.13927-1-avarab@gmail.com>
References: <20210316021312.13927-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 tree-walk.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/tree-walk.c b/tree-walk.c
index b210967b73..6e9161901d 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -521,7 +521,7 @@ int traverse_trees(struct index_state *istate,
 			if (!entry[i].path)
 				continue;
 			mask |= 1ul << i;
-			if (S_ISDIR(entry[i].mode))
+			if (entry[i].object_type == OBJ_TREE)
 				dirmask |= 1ul << i;
 			e = &entry[i];
 		}
@@ -892,8 +892,8 @@ static int match_entry(const struct pathspec_item *item,
 		 * nothing else (to handle 'submod/' and 'submod'
 		 * uniformly).
 		 */
-		if (!S_ISDIR(entry->mode) &&
-		    (!S_ISGITLINK(entry->mode) || matchlen > pathlen + 1))
+		if (entry->object_type != OBJ_TREE &&
+		    (entry->object_type != OBJ_COMMIT || matchlen > pathlen + 1))
 			return 0;
 	}
 
@@ -1038,7 +1038,7 @@ static enum interesting do_match(struct index_state *istate,
 		    ps->max_depth == -1)
 			return all_entries_interesting;
 		return within_depth(base->buf + base_offset, baselen,
-				    !!S_ISDIR(entry->mode),
+				    entry->object_type == OBJ_TREE,
 				    ps->max_depth) ?
 			entry_interesting : entry_not_interesting;
 	}
@@ -1071,7 +1071,7 @@ static enum interesting do_match(struct index_state *istate,
 
 			if (within_depth(base_str + matchlen + 1,
 					 baselen - matchlen - 1,
-					 !!S_ISDIR(entry->mode),
+					 entry->object_type == OBJ_TREE,
 					 ps->max_depth))
 				goto interesting;
 			else
@@ -1094,7 +1094,8 @@ static enum interesting do_match(struct index_state *istate,
 				 * Match all directories. We'll try to
 				 * match files later on.
 				 */
-				if (ps->recursive && S_ISDIR(entry->mode))
+				if (ps->recursive &&
+				    entry->object_type == OBJ_TREE)
 					return entry_interesting;
 
 				/*
@@ -1105,7 +1106,7 @@ static enum interesting do_match(struct index_state *istate,
 				 * be performed in the submodule itself.
 				 */
 				if (ps->recurse_submodules &&
-				    S_ISGITLINK(entry->mode) &&
+				    entry->object_type == OBJ_COMMIT &&
 				    !ps_strncmp(item, match + baselen,
 						entry->path,
 						item->nowildcard_len - baselen))
@@ -1154,7 +1155,8 @@ static enum interesting do_match(struct index_state *istate,
 		 * character.  More accurate matching can then
 		 * be performed in the submodule itself.
 		 */
-		if (ps->recurse_submodules && S_ISGITLINK(entry->mode) &&
+		if (ps->recurse_submodules &&
+		    entry->object_type == OBJ_COMMIT &&
 		    !ps_strncmp(item, match, base->buf + base_offset,
 				item->nowildcard_len)) {
 			strbuf_setlen(base, base_offset + baselen);
@@ -1170,7 +1172,7 @@ static enum interesting do_match(struct index_state *istate,
 		 * in future, see
 		 * https://lore.kernel.org/git/7vmxo5l2g4.fsf@alter.siamese.dyndns.org/
 		 */
-		if (ps->recursive && S_ISDIR(entry->mode))
+		if (ps->recursive && entry->object_type == OBJ_TREE)
 			return entry_interesting;
 		continue;
 interesting:
@@ -1193,7 +1195,7 @@ static enum interesting do_match(struct index_state *istate,
 			 * can probably return all_entries_interesting or
 			 * all_entries_not_interesting here if matched.
 			 */
-			if (S_ISDIR(entry->mode))
+			if (entry->object_type == OBJ_TREE)
 				return entry_interesting;
 
 			strbuf_add(base, entry->path, pathlen);
@@ -1269,7 +1271,7 @@ enum interesting tree_entry_interesting(struct index_state *istate,
 		return positive;
 
 	/* #15, #19 */
-	if (S_ISDIR(entry->mode) &&
+	if (entry->object_type == OBJ_TREE &&
 	    positive >= entry_interesting &&
 	    negative == entry_interesting)
 		return entry_interesting;
-- 
2.31.0.256.gf0ddda3145

