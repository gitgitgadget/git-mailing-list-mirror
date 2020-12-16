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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3236BC4361B
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 05:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E70DD2333F
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 05:54:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725812AbgLPFx3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 00:53:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725274AbgLPFx3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 00:53:29 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC77C061793
        for <git@vger.kernel.org>; Tue, 15 Dec 2020 21:52:49 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id q18so14443203wrn.1
        for <git@vger.kernel.org>; Tue, 15 Dec 2020 21:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=nIuyIOARPhQtreLsEnoTwXZduaCDfrdPYxbtSn8C4DA=;
        b=hNrLFxktGje2Z8YMdthRb6R0W3KSlOK3WdwVjiVxleaETPi4CvxHjuCO+v73iKo7aD
         6ucdOBQOSIDADH9tca8XCPr3Iy9u723motO4qbWVSblzts15H31D4bsRFGFQuElS+3q6
         QbUKWJErmGBjU9zRnoxPEaUXFEgXBeszQdrWkYHVSV46HwW06B6Qv6yR/zTs49BM1WcJ
         +yDmUHlJTYg4PXi833whKN2YQA4LiaaEImglojeZXk8mJBucXLyNic9GFZQJgX4Bnk8f
         C/p60GWLuDoF1D6faNM60blG2qXFTkxcN8y8cF4FLVbtedEZL+RNVum4mKovmOqggvqi
         KECg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=nIuyIOARPhQtreLsEnoTwXZduaCDfrdPYxbtSn8C4DA=;
        b=Y/4aQi4sugGs3KBTz036OK9J61eqPsYuuXDc4zJc83ESmlvwoVc/JMvCwEAhajuo2d
         X9Krtda9H/lvoYVxjSTooMmWjSImh9KRcJnVLLVencUwV1vOb+/8WqNCGv043t/yXpjc
         9l3+4Ox5bWBNPrcc+cCWNQo/CK5nlALpiGeIj9TOt1zXHb2AyG/QzbMweUMSFDoLB2If
         TsAQBEbu63IKKYZibtzkVjLQRft6Ly9m7y4FHwpQ07ICyh3xAJBKgSbfBpXBtJQ4ElNg
         zmMxQHZiXF+Dz8JVhYIq+4jOaUpZ9JevMIc0HpHQtaBbyLXHudjOXnpj4TYr1xIPOM98
         ia1w==
X-Gm-Message-State: AOAM532Y/3PBQTCM9Welkw2t6NptgcMee0m6FGCIHRqxiqSf1CaahJFe
        2OCo1IVMzjRVuV78tFSPDlR5F2A0+1c=
X-Google-Smtp-Source: ABdhPJyy78sQuJf1wQ488u9TLzGuYtYKX2QvPMdRfJDyNaNRgGGqmt6407FcHt9ey2gC3ld7TvF0rg==
X-Received: by 2002:a5d:4bc5:: with SMTP id l5mr18924191wrt.15.1608097967535;
        Tue, 15 Dec 2020 21:52:47 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v20sm1307820wra.19.2020.12.15.21.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 21:52:47 -0800 (PST)
Message-Id: <0b455bd6fe7dff72c1849eb8466b97b96b2b90a9.1608097965.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.814.v2.git.1608097965.gitgitgadget@gmail.com>
References: <pull.814.git.1608054807.gitgitgadget@gmail.com>
        <pull.814.v2.git.1608097965.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 16 Dec 2020 05:52:42 +0000
Subject: [PATCH v2 1/3] merge-ort: copy a few small helper functions from
 merge-recursive.c
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

In a subsequent commit, we will implement the traditional recursiveness
that gave merge-recursive its name, namely merging non-unique
merge-bases to come up with a single virtual merge base.  Copy a few
helper functions from merge-recursive.c that we will use in the
implementation.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/merge-ort.c b/merge-ort.c
index 414e7b7eeac..05ba92c91a6 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -17,8 +17,10 @@
 #include "cache.h"
 #include "merge-ort.h"
 
+#include "alloc.h"
 #include "blob.h"
 #include "cache-tree.h"
+#include "commit.h"
 #include "commit-reach.h"
 #include "diff.h"
 #include "diffcore.h"
@@ -1348,6 +1350,34 @@ void merge_finalize(struct merge_options *opt,
 
 /*** Function Grouping: helper functions for merge_incore_*() ***/
 
+static inline void set_commit_tree(struct commit *c, struct tree *t)
+{
+	c->maybe_tree = t;
+}
+
+static struct commit *make_virtual_commit(struct repository *repo,
+					  struct tree *tree,
+					  const char *comment)
+{
+	struct commit *commit = alloc_commit_node(repo);
+
+	set_merge_remote_desc(commit, comment, (struct object *)commit);
+	set_commit_tree(commit, tree);
+	commit->object.parsed = 1;
+	return commit;
+}
+
+static struct commit_list *reverse_commit_list(struct commit_list *list)
+{
+	struct commit_list *next = NULL, *current, *backup;
+	for (current = list; current; current = backup) {
+		backup = current->next;
+		current->next = next;
+		next = current;
+	}
+	return next;
+}
+
 static void merge_start(struct merge_options *opt, struct merge_result *result)
 {
 	/* Sanity checks on opt */
@@ -1462,5 +1492,7 @@ void merge_incore_recursive(struct merge_options *opt,
 			    struct commit *side2,
 			    struct merge_result *result)
 {
+	(void)reverse_commit_list;
+	(void)make_virtual_commit;
 	die("Not yet implemented");
 }
-- 
gitgitgadget

