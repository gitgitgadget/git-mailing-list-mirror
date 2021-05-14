Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C61FBC433B4
	for <git@archiver.kernel.org>; Fri, 14 May 2021 18:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAD4161440
	for <git@archiver.kernel.org>; Fri, 14 May 2021 18:31:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233722AbhENScl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 May 2021 14:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbhENScd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 May 2021 14:32:33 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F139DC06175F
        for <git@vger.kernel.org>; Fri, 14 May 2021 11:31:20 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id b11-20020a7bc24b0000b0290148da0694ffso1868027wmj.2
        for <git@vger.kernel.org>; Fri, 14 May 2021 11:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7yWmoxa4P2IhgSPJe7dSIEDaLEpg2XrJKHHPNNjTM+s=;
        b=gF6+fkUuFl/3oPStvz44QlDWpG6FBg/3UDbBtooZsqd/1tk5X0LJk0esWJuC2xGoju
         U6579ZlW/kCdSR8YV9QHqSyVagDh3iHC0TgH/MgmgpwjQyY4E0X2tsjippw49I7oR+Ir
         Fe0A+yhR5IQ/ux7BZHBoBmpGVG3AywbGZyqsWqzFg1o+TZUgJuS+5HsJwSb9Yv0PsOci
         PzsyzAJHBzigI/QS5s1pUCYPEdM++aCd/fNkByL+FiVAPqdBgyh1TYTgXoZEy/LvDp0T
         PC9d69n09673OTwr75ClxLhSw/DbvRSBNgkJo+W+8+7fvGXbYcHID98+6dii5cKh+AFi
         zkBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7yWmoxa4P2IhgSPJe7dSIEDaLEpg2XrJKHHPNNjTM+s=;
        b=IS6FuEr03pDSewnQSA4RYYQ6VQ2WGb3cGCy64JgFGDPKO16bOGeHAFHpL0yM63SvUS
         /rs/LwJIjpzkX63okeq6vedpRncdL6GkktxsE8S+r0f6365EKeUIP9CNeWM+/l90Q24W
         BxRqQqPquciQVGcv7xQ7RSLlYUNAxU2NTq9POhDNjIweSrdjm3sHFJrzDADth6aJULGU
         KNEpnk8JD0+wgn6xKUQOpUbmakcEYWlI+hjZKeRHhnYXtQ/GPU/ybh5WDA3D8WMJFwsB
         rVDQ1Lv/8foRFiOi4TamnIpRiOj98AgLCvMDQtqdMMava6W81vexOP2Qo/IG6t60zdSY
         XS8Q==
X-Gm-Message-State: AOAM532KUyuPhCBUNKT6F/XZUDjOdHiYsODA3QEqcnKAxqbp8AD3SC8I
        j8xK4DaCb3H8O1odOSFhU710VGTK/o8=
X-Google-Smtp-Source: ABdhPJxUu/Rb+IW1JeaxB0Ui6fMlFtPSxzw//uNniNdfGTIktrv6Q120NRzhTbPQkKsazFKcSXNQxw==
X-Received: by 2002:a7b:cc15:: with SMTP id f21mr10961177wmh.86.1621017079758;
        Fri, 14 May 2021 11:31:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u126sm106111wmb.9.2021.05.14.11.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 11:31:19 -0700 (PDT)
Message-Id: <598375d3531fabe8582cb6d93838df09e1bd06c3.1621017072.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.932.v3.git.1621017072.gitgitgadget@gmail.com>
References: <pull.932.v2.git.1619213665.gitgitgadget@gmail.com>
        <pull.932.v3.git.1621017072.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 14 May 2021 18:31:06 +0000
Subject: [PATCH v3 07/12] unpack-trees: stop recursing into sparse directories
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

When walking trees using traverse_trees_recursive() and
unpack_callback(), we must not attempt to walk into a sparse directory
entry. There are no index entries within that directory to compare to
the tree object at that position, so skip over the entries of that tree.

This code is used in many places, so the only way to test it is to start
removing the command_requres_full_index option from one builtin at a
time and carefully test that its use of unpack_trees() behaves correctly
with a sparse-index. Such tests will be added by later changes.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 diff-lib.c     | 6 ++++++
 unpack-trees.c | 7 +++++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index b73cc1859a49..d5e7e01132ee 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -322,6 +322,9 @@ static void show_new_file(struct rev_info *revs,
 	unsigned int mode;
 	unsigned dirty_submodule = 0;
 
+	if (S_ISSPARSEDIR(new_file->ce_mode))
+		return;
+
 	/*
 	 * New file in the index: it might actually be different in
 	 * the working tree.
@@ -343,6 +346,9 @@ static int show_modified(struct rev_info *revs,
 	const struct object_id *oid;
 	unsigned dirty_submodule = 0;
 
+	if (S_ISSPARSEDIR(new_entry->ce_mode))
+		return 0;
+
 	if (get_stat_data(new_entry, &oid, &mode, cached, match_missing,
 			  &dirty_submodule, &revs->diffopt) < 0) {
 		if (report_missing)
diff --git a/unpack-trees.c b/unpack-trees.c
index ef6a2b1c951c..703b0bdc9dfd 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1261,6 +1261,7 @@ static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, str
 	struct cache_entry *src[MAX_UNPACK_TREES + 1] = { NULL, };
 	struct unpack_trees_options *o = info->data;
 	const struct name_entry *p = names;
+	unsigned unpack_tree = 1;
 
 	/* Find first entry with a real name (we could use "mask" too) */
 	while (!p->mode)
@@ -1307,7 +1308,8 @@ static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, str
 		}
 	}
 
-	if (unpack_nondirectories(n, mask, dirmask, src, names, info) < 0)
+	if (unpack_tree &&
+	    unpack_nondirectories(n, mask, dirmask, src, names, info) < 0)
 		return -1;
 
 	if (o->merge && src[0]) {
@@ -1337,7 +1339,8 @@ static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, str
 			}
 		}
 
-		if (traverse_trees_recursive(n, dirmask, mask & ~dirmask,
+		if (unpack_tree &&
+		    traverse_trees_recursive(n, dirmask, mask & ~dirmask,
 					     names, info) < 0)
 			return -1;
 		return mask;
-- 
gitgitgadget

