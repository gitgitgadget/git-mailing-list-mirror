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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7094EC2BB48
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 17:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A6B922ADC
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 17:54:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730841AbgLORyk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Dec 2020 12:54:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730804AbgLORyL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Dec 2020 12:54:11 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7544C0617A7
        for <git@vger.kernel.org>; Tue, 15 Dec 2020 09:53:30 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id r3so20779519wrt.2
        for <git@vger.kernel.org>; Tue, 15 Dec 2020 09:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=nIuyIOARPhQtreLsEnoTwXZduaCDfrdPYxbtSn8C4DA=;
        b=VujWLEm0JnACRGzpi40NjyqsKCnpVB+G09QDDdk35BeajVUZDWQl8iR6d+hDY27FLh
         gGWcoU7m6qjm0cLIdleOBZXdAjx/7Lm2BkWzmQiCqD1BRS/re5FFbmSFw11kZGaEdxzN
         lIUvWfrwiqYe9LTw6bd7Ttd45APsKtNejD2WHnkmeZNfkBispwM8DUaNAqodU6ZxRqK/
         H0EuUCIf++N1GSDZbS3omwNkzZUgk260XJ9j460fEjU6OemOKBEFG0y3eQo8/8LzKpmH
         ShncWBj9l/OkjG4BjqnfVMpHrZGNtmbxZNXSj19HAVnE5F9QPoosebEGDCHK8CY17IXf
         gmVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=nIuyIOARPhQtreLsEnoTwXZduaCDfrdPYxbtSn8C4DA=;
        b=kmHDpm4FvIuQhNxSEyVKGml7BlFpQQoNa6aBRpSiTSG9HoNdCdnNCXHm9STGIRye0z
         ngu0DWZEpQZ1ZCGYxwsYi/6qFCf5YEHkfO611jFkrUrcKZLUql+LJUPCEgYTOcgUs0qg
         nGePRGpaikYewvJfmDUnwKFgSna/lFkiOY1/0F06tMTELazdov6PeeWwcESM/zS6ekmx
         LfmGCYG+tkoI75fgYTHemsCRdpjYBu6Dt61Q8qaRenmOSRk0arg4sRx7GctshQHLCfC0
         G8ADrSb0mxs9+5ef7ItJRQKJV+wpyHwxge3tHfe54vy7LooPDSjiiJyp1cexHLw23VXw
         8jtQ==
X-Gm-Message-State: AOAM531QJlsqgBlUWxN+tUvnazqrBg0RV9MltjUpzj/XWHiZi0iwE/u1
        3pKhXCO9zwjv5E7vBB5vG7xEUtWjELk=
X-Google-Smtp-Source: ABdhPJxRVqNBbGTP70TWmf/BItLI4eI2R5ysiMZy05huQjkz0YAhMh6IqQbrUfvjqdc+77PCZTrhIg==
X-Received: by 2002:a5d:4f0e:: with SMTP id c14mr3894080wru.84.1608054809269;
        Tue, 15 Dec 2020 09:53:29 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z15sm40351557wrv.67.2020.12.15.09.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 09:53:28 -0800 (PST)
Message-Id: <0b455bd6fe7dff72c1849eb8466b97b96b2b90a9.1608054807.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.814.git.1608054807.gitgitgadget@gmail.com>
References: <pull.814.git.1608054807.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Dec 2020 17:53:25 +0000
Subject: [PATCH 1/3] merge-ort: copy a few small helper functions from
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

