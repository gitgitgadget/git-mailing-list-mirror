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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5670AC11F69
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 03:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F79B61481
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 03:46:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233779AbhGADs7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Jun 2021 23:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbhGADsx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jun 2021 23:48:53 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 487BAC0617AF
        for <git@vger.kernel.org>; Wed, 30 Jun 2021 20:46:22 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id a13so6210723wrf.10
        for <git@vger.kernel.org>; Wed, 30 Jun 2021 20:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=35ri/oVrMbO6uA75NOizGkqjB2GcqWgsCqqYDqf0wbs=;
        b=D3sn0ZTNerBtfLcN1IpdbhmlwG50kiTnVOsRyWBycfBmXUxDKNLTpB7z33R2lCNHNO
         5rts6U9EocYI/OACDSwLiYz9dxtzI02uO92bxQa6W3FkPZRf3jneTpGnmEeY7W9wNLwh
         kKuWWmFFiPcFxY6//KqQpNkyGI+i74PXeYQEFT/THK31Q6ihref+p8aiCS8spyIiyRnc
         RmC5ngEK6Zvh9QTOrcg884DrmahnLkIV41e7nIKtd0HFwruao3COGmyV/Hqtvhv5CBn5
         tTIlVhv9X3jFf2f9ztwRmuTv9i5taa9Aw1J5uAkYOOV+FjpcL6FVOrR0uQkMISZTj7wO
         OSOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=35ri/oVrMbO6uA75NOizGkqjB2GcqWgsCqqYDqf0wbs=;
        b=BFaOBaxk6p1dJwJl/nS1LyxBshSpcuqWuzck5y+GGMfuStAVPCOnl1sL7DiplKGHv5
         xXBw0yCLVyp3L15uPvBLLHTp1vyMnAlnaIZKMA83BhILhtBYJP88yte2j9fpb664vlpU
         vTpKX13KqidSREm9zAmICeEkFOAhgT3B5b0miO1QUHe08QNumOty5hISk1cBadNkQG2+
         eYqDwoSWVCaVWXxzv8P6rV3yLkeWAFqgB9ZRyY6fYdCbq1z8vKUZQbGWvofIGxokkLTq
         +s3IPk0G5Uz2ug+pdI8NuJkfVBaNRG89bOyLLXmldXpjBJgKA78tPMZgCapTuvWSvkmG
         1alA==
X-Gm-Message-State: AOAM531KU0Kxh8JuKfuY0SCJFPORszTv6Se1+7VStNAYctMVGJ0UOzj8
        XYJQIC7r2EIXe0TVipjt0O6fhvf1yq4=
X-Google-Smtp-Source: ABdhPJw6XaRffA+hOyOTf/m1Veb/7W2WD4BVBQPMhxizwRaHd1vgwUqTfe95Da5Tzn/e6ddBfHTD2Q==
X-Received: by 2002:adf:eb43:: with SMTP id u3mr1804079wrn.83.1625111181003;
        Wed, 30 Jun 2021 20:46:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x21sm4051486wmj.6.2021.06.30.20.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 20:46:20 -0700 (PDT)
Message-Id: <7e28323b624ad2d8d12123783f00f5a8fbb248e8.1625111177.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.988.git.1625111177.gitgitgadget@gmail.com>
References: <pull.988.git.1625111177.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Jul 2021 03:46:14 +0000
Subject: [PATCH 4/7] merge-ort: add a handle_deferred_entries() helper
 function
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

In order to allow trivial directory resolution, we first need to be able
to gather more information to determine if the optimization is safe.  To
enable that, we need a way of deferring the recursion into the directory
until a later time.  Naturally, deferring the entry into a subtree means
that we need some function that will later recurse into the subdirectory
exactly the same way that collect_merge_info_callback() would have done.

Add a helper function that does this.  For now this function is not used
but a subsequent commit will change that.  Future commits will also make
the function sometimes resolve directories instead of traversing inside.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 64 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/merge-ort.c b/merge-ort.c
index 3d3f00b3b45..eb0e18d7546 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -1196,6 +1196,70 @@ static int collect_merge_info_callback(int n,
 	return mask;
 }
 
+MAYBE_UNUSED
+static int handle_deferred_entries(struct merge_options *opt,
+				   struct traverse_info *info)
+{
+	struct rename_info *renames = &opt->priv->renames;
+	struct hashmap_iter iter;
+	struct strmap_entry *entry;
+	int side, ret = 0;
+
+	for (side = MERGE_SIDE1; side <= MERGE_SIDE2; side++) {
+		renames->trivial_merges_okay[side] = 0;
+		strintmap_for_each_entry(&renames->possible_trivial_merges[side],
+					 &iter, entry) {
+			const char *path = entry->key;
+			unsigned dir_rename_mask = (intptr_t)entry->value;
+			struct conflict_info *ci;
+			unsigned dirmask;
+			struct tree_desc t[3];
+			void *buf[3] = {NULL,};
+			int i;
+
+			ci = strmap_get(&opt->priv->paths, path);
+			VERIFY_CI(ci);
+			dirmask = ci->dirmask;
+
+			info->name = path;
+			info->namelen = strlen(path);
+			info->pathlen = info->namelen + 1;
+
+			for (i = 0; i < 3; i++, dirmask >>= 1) {
+				if (i == 1 && ci->match_mask == 3)
+					t[1] = t[0];
+				else if (i == 2 && ci->match_mask == 5)
+					t[2] = t[0];
+				else if (i == 2 && ci->match_mask == 6)
+					t[2] = t[1];
+				else {
+					const struct object_id *oid = NULL;
+					if (dirmask & 1)
+						oid = &ci->stages[i].oid;
+					buf[i] = fill_tree_descriptor(opt->repo,
+								      t+i, oid);
+				}
+			}
+
+			ci->match_mask &= ci->filemask;
+			opt->priv->current_dir_name = path;
+			renames->dir_rename_mask = dir_rename_mask;
+			if (renames->dir_rename_mask == 0 ||
+			    renames->dir_rename_mask == 0x07)
+				ret = traverse_trees(NULL, 3, t, info);
+			else
+				ret = traverse_trees_wrapper(NULL, 3, t, info);
+
+			for (i = MERGE_BASE; i <= MERGE_SIDE2; i++)
+				free(buf[i]);
+
+			if (ret < 0)
+				return ret;
+		}
+	}
+	return ret;
+}
+
 static int collect_merge_info(struct merge_options *opt,
 			      struct tree *merge_base,
 			      struct tree *side1,
-- 
gitgitgadget

