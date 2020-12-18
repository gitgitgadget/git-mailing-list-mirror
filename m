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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF8FC2BBD5
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 05:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECACF23A57
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 05:52:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732455AbgLRFwy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Dec 2020 00:52:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbgLRFwx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Dec 2020 00:52:53 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7165BC0611CB
        for <git@vger.kernel.org>; Thu, 17 Dec 2020 21:51:38 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id v14so1102991wml.1
        for <git@vger.kernel.org>; Thu, 17 Dec 2020 21:51:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=3VWdFNzHStrIFPMTrcpUhepqI3KmHCI8z1cXv60VA8M=;
        b=cJs2SDz4acEqKQvcXKr8YVFKHosoB/NNKU1yKMoJKaQCKVoFVdrZ0Fi7pmtBkAJNqB
         WKuTiTkUghMpmMz0CqKmXYeSqbZ7ZvOCx+p2lruxa63+Rhm+2wzYPTaNBuDAbBPfn/Fu
         ugRAHGggvYwjRWVpZNSIoqhzIuMpGGmkCYjvNPITSwGyJMxgX0oRMaVXdUwkzAjOm0H3
         aVmVuypmr1UvBeRdXEmOsHKKezKdUlh90wCCIR79InoMfp0x9YM7CKUxpeRNhle2UF10
         Ay4ZxSdxpBdFV2ykz/s8bDGO/PJPW7Bxjvqqzw+axp18fsHtKUZ3NT/PGXjuigWUGeiW
         3mFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=3VWdFNzHStrIFPMTrcpUhepqI3KmHCI8z1cXv60VA8M=;
        b=BxjX5gi5Ksg9zrGP31awLdpoFmTgJGynHBnhoYRb9bZfCdIEPMp4byBxRG/inVcSs3
         GTHiCIKI2O8Z9dJT61TMi8jm76UVUfGVC/3s+A29gX13Wzsa3XZ1K9PMn5K86a3NVvtL
         7Sgt8Sfs6YDAy3r1UiQzaUBbg1LPXQmKBkbhbZNvGjuXE6wqunwqadN/xv3FJAsTSDug
         5tCGphng3ajlFJUIbbPkjTagUh48lrBx2Z6B5JJuqkJZe8IHsVEfc5rgLNw8GUhXXj5I
         lof4T3xFuSX9z6/Ih0LWYnmemtZH5i2tQRmYnPYekU4Z/w1edHAjmccwFPnI/T0PVJHU
         gm3A==
X-Gm-Message-State: AOAM532PDBrmEvlqwDBceBGWMY1eBp7HVsni7evD4MYyNdApVXTzLNmn
        3yYKwnZjm7uxwJ9TfAq+9UEK+laUuKs=
X-Google-Smtp-Source: ABdhPJzqsoSgCKyWWXR/ppb4fV+ue8zJsvmLPeChaJi77MR0T/mOdZS2nNwxZsjmWjanUVxvybqoeQ==
X-Received: by 2002:a7b:c7d8:: with SMTP id z24mr2512962wmk.1.1608270696975;
        Thu, 17 Dec 2020 21:51:36 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b12sm17427652wmj.2.2020.12.17.21.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 21:51:36 -0800 (PST)
Message-Id: <b898876b119c669ac84a5197bba1750a6f7f1e52.1608270687.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.815.git.1608270687.gitgitgadget@gmail.com>
References: <pull.815.git.1608270687.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 18 Dec 2020 05:51:26 +0000
Subject: [PATCH 09/10] merge-ort: copy find_first_merges() implementation from
 merge-recursive.c
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Code is identical for the function body in the two files, the call
signature is just slightly different in merge-ort than merge-recursive
as noted a couple commits ago.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 56 insertions(+), 1 deletion(-)

diff --git a/merge-ort.c b/merge-ort.c
index bf704bcd34d..203fa987e43 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -25,6 +25,7 @@
 #include "dir.h"
 #include "ll-merge.h"
 #include "object-store.h"
+#include "revision.h"
 #include "strmap.h"
 #include "submodule.h"
 #include "tree.h"
@@ -658,7 +659,61 @@ static int find_first_merges(struct repository *repo,
 			     struct commit *b,
 			     struct object_array *result)
 {
-	die("Not yet implemented.");
+	int i, j;
+	struct object_array merges = OBJECT_ARRAY_INIT;
+	struct commit *commit;
+	int contains_another;
+
+	char merged_revision[GIT_MAX_HEXSZ + 2];
+	const char *rev_args[] = { "rev-list", "--merges", "--ancestry-path",
+				   "--all", merged_revision, NULL };
+	struct rev_info revs;
+	struct setup_revision_opt rev_opts;
+
+	memset(result, 0, sizeof(struct object_array));
+	memset(&rev_opts, 0, sizeof(rev_opts));
+
+	/* get all revisions that merge commit a */
+	xsnprintf(merged_revision, sizeof(merged_revision), "^%s",
+		  oid_to_hex(&a->object.oid));
+	repo_init_revisions(repo, &revs, NULL);
+	rev_opts.submodule = path;
+	/* FIXME: can't handle linked worktrees in submodules yet */
+	revs.single_worktree = path != NULL;
+	setup_revisions(ARRAY_SIZE(rev_args)-1, rev_args, &revs, &rev_opts);
+
+	/* save all revisions from the above list that contain b */
+	if (prepare_revision_walk(&revs))
+		die("revision walk setup failed");
+	while ((commit = get_revision(&revs)) != NULL) {
+		struct object *o = &(commit->object);
+		if (in_merge_bases(b, commit))
+			add_object_array(o, NULL, &merges);
+	}
+	reset_revision_walk();
+
+	/* Now we've got all merges that contain a and b. Prune all
+	 * merges that contain another found merge and save them in
+	 * result.
+	 */
+	for (i = 0; i < merges.nr; i++) {
+		struct commit *m1 = (struct commit *) merges.objects[i].item;
+
+		contains_another = 0;
+		for (j = 0; j < merges.nr; j++) {
+			struct commit *m2 = (struct commit *) merges.objects[j].item;
+			if (i != j && in_merge_bases(m2, m1)) {
+				contains_another = 1;
+				break;
+			}
+		}
+
+		if (!contains_another)
+			add_object_array(merges.objects[i].item, NULL, result);
+	}
+
+	object_array_clear(&merges);
+	return result->nr;
 }
 
 static int merge_submodule(struct merge_options *opt,
-- 
gitgitgadget

