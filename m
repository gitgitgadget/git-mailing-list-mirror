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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8E73C433E9
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 00:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B5C4601FE
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 00:02:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbhCUACL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Mar 2021 20:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbhCUABb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Mar 2021 20:01:31 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5028C061574
        for <git@vger.kernel.org>; Sat, 20 Mar 2021 17:01:30 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id o16so12867125wrn.0
        for <git@vger.kernel.org>; Sat, 20 Mar 2021 17:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pj7qVBS8v9g3R8SADpWt/k+MQ4qCi0/ybT8BQi9BA2w=;
        b=ToP+itpeCf2AJtDnKxn5MFme0QqTFCvgogEoEps/EPl3aVYcvabP6+8EFkPIGlXPne
         imDHEGmFSrMjOUA70EPNUVI5V0jyf1rJcglWq6DG7QaSYe7ltUsfHP9npgu+LVtQUT7f
         b4+4qX4ww/JhUEVuyuf/UQi7p3IjmuCTY0tDujjGuHG/7qJv0CHJlynq6gsCtmGKz9Xv
         NRNS33Lvhaha675R2IWQlx0SfgN7KX0dxERweinwTGQf9UBDVq094Ust8KhTTg0d1DKl
         kYmiK6JJUJolcReyiG1393vytQrf8MnJj8P/0NV5SzeQzLSEG282Lw15EX9XE3jSYx9d
         KCsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pj7qVBS8v9g3R8SADpWt/k+MQ4qCi0/ybT8BQi9BA2w=;
        b=b0FlTAkPCabkKYn9cB1c0gd4FJvdEpElF+dJabihV0nn+2ndRpCAYXQzOXxjLnKKqE
         zkREc014V3YQyFT9NaayfhKnA+y3uwKZAz+ine+gY2R2eDR3m51CQXlX396m9BHXckYm
         ltv/QT4Y/svs+FU70vWSPi+TzQY6UsVAGrFMwkeiiWcKpd0l/T0AUsEDZEhp9ONBwNh1
         JrRsvSGh+QpRktc65knDULtTBecm4NzbQwRwiYaLt4zeTY78enU0Dm7AwcAuDy765TVW
         4U/Qy8Svi/deS+eW/Lb5Xb98cvY1fXzcRwZzYzF2FgRhiybHS95UyJ+lTTs+wQa5bUm5
         TIGw==
X-Gm-Message-State: AOAM530xtjpClSN3/ntA7LpzLpVYm6z8g/7+wHjPjXxlN+HEseKerQWu
        9lrtQrzXWsYOyyGRlF7RIk/Yx7YLrlPpIQ==
X-Google-Smtp-Source: ABdhPJzsUgzy6digLnrkWlZh+qRvH4Kfh0GUBYRwC4Q5A6bsVMYvz+rYObAdkOQ+bL6WuSxNm6uaUA==
X-Received: by 2002:a5d:5043:: with SMTP id h3mr11085125wrt.120.1616284889399;
        Sat, 20 Mar 2021 17:01:29 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g5sm15304834wrq.30.2021.03.20.17.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Mar 2021 17:01:28 -0700 (PDT)
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
Subject: [PATCH v4 04/29] tree-walk.c: migrate to using new "object_type" field when possible
Date:   Sun, 21 Mar 2021 01:00:37 +0100
Message-Id: <c557b67231b3bf9dae3d298e4b9ffc58de1c413f.1616282534.git.avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.282.gcc1ec606501
In-Reply-To: <cover.1616282533.git.avarab@gmail.com>
References: <20210316155829.31242-1-avarab@gmail.com> <cover.1616282533.git.avarab@gmail.com>
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
2.31.0.286.gc175f2cb894

