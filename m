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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B710DC43331
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 15:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C3FA6522B
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 15:08:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbhCHPHp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Mar 2021 10:07:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbhCHPHP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Mar 2021 10:07:15 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD1EEC06174A
        for <git@vger.kernel.org>; Mon,  8 Mar 2021 07:07:14 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id a18so11766463wrc.13
        for <git@vger.kernel.org>; Mon, 08 Mar 2021 07:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v5GfDL+DkvYTyYZeZ1uEAAOtJODBBbRD8EpNiHANoAo=;
        b=FEK7T/g0nsXJIh5WCKzcNRQEjwRYg4QjiFjDql9P1hBhNJzLYSc49ooslVC/v24Hsu
         a16NxEzdVWFsIUsgP+8KK+ugAA5cihjUGIaDRIurAhHQrk1NBJACte3MywHqsyZMWrD3
         gE54O9+7lEO4gsX+GL6pZyT5qSSFh6x4eeiNVG+Cl/wdSQj4NdDf72htfRV7YUjYbaws
         wEFOGBRiNAkcWryQ1Ru3Jdh9kY61JhNgEX84MtK4WpI3OiC9/8952raLOgA3K05zYXhl
         MzPJmCJH6Eqe5ouSq884RrfsmFvsRevO6f+rbNfv0sUhSMewfvuBf7SL2IzRgo6UQ/It
         BlDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v5GfDL+DkvYTyYZeZ1uEAAOtJODBBbRD8EpNiHANoAo=;
        b=QGOh3OqzSWlB4UMuDOxeN1r6cVgbTOgCSXHJgZg4US/c2DxxZe/0Qe8o1UQmEL1vnx
         geB4O0JkHxKAi3HGwGS8o2WYoFCQ22c+EOZrcD5tbdnjqd4O1EJx/OFaLjRIRTHjkKAs
         jlUgU8V4GEFmwOchbyPCzVbGGiyYKXRhQ/WGXKozPTyY31fiUfCP/YCWCtpIcoel1ukQ
         jMLegylUln6/SQ/nRTYCDo1rkyAF/HlKDz3JUET2SV7PWP80hRkcV8A7qL5QQEVqckIN
         EREZmVX843SDwrgxFj8bGLx3lag8wOvS/3CQeiu8BnelGpbmhpuNibxnlMP1B6wtQLFb
         txsQ==
X-Gm-Message-State: AOAM530ymqLeI02bKU8A6WU/3NBuxGBg2X8eTmmkiP0EHq/xeFP+4amU
        sQ2akWiY6jDSrphTpD9UEngFlJ5F+n2d2g==
X-Google-Smtp-Source: ABdhPJzXxIe+YIW9RM1tUlHHidYYhpjQ/T4Lc9Pe2hMhFmpCl8gfTDWQdSXC7ufM0QUBl2xPH8gT8w==
X-Received: by 2002:adf:ef4a:: with SMTP id c10mr22656660wrp.427.1615216033195;
        Mon, 08 Mar 2021 07:07:13 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j13sm3820488wrt.29.2021.03.08.07.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 07:07:12 -0800 (PST)
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
Subject: [PATCH 05/30] tree-walk.c: migrate to using new "object_type" field when possible
Date:   Mon,  8 Mar 2021 16:06:25 +0100
Message-Id: <20210308150650.18626-6-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc0.126.g04f22c5b82
In-Reply-To: <20210308022138.28166-1-avarab@gmail.com>
References: <20210308022138.28166-1-avarab@gmail.com>
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
index b210967b73b..6e9161901d8 100644
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
2.31.0.rc0.126.g04f22c5b82

