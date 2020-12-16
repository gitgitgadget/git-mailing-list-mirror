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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE3CC0018C
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 17:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B15A233FE
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 17:18:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgLPRR7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 12:17:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726921AbgLPRR6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 12:17:58 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF8EC061794
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 09:17:18 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id a3so3172657wmb.5
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 09:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=XGikWbQ/uqhrZg/jR4gVAQvl4psVFSLa+sJDq8YkCRk=;
        b=lzgt6kxdKRRLf3C00po0k+G03Eb/GgLpieOwGGYhsPPV3qjSJZXi+U0w0ORJ0HKrLQ
         /8pN4BCBPUe/OQA+rqjAqgI/k97b10hJUQFZMMDHGfv1W0spxWCSZKz6S0QCHIEZt23R
         SWo4iJkzrPPJhz5HVyxqnsM+OZIfIINUMiE5qK17dM5NI0CdNXUYOWZucc7G8R63HZwM
         UKMQXUdhm4wnBn/LRhMEwbcJ05zwnNgRitQGhj87NSn6+cV8VpMb6btr4YDrqVx7lao0
         ENVO7Bl23Vi2KF1vjlB01mEHLiaHdPetmIrrngI8Bfh6fYvhY4dHl3q72pAx7Z9AUl2N
         EaKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=XGikWbQ/uqhrZg/jR4gVAQvl4psVFSLa+sJDq8YkCRk=;
        b=ckpXAWju3aptb+7+7ZIIxrcs65jRU3mDD9WiZwqTTRSXzDqk2zYmr4Eb4YIlv/e6qf
         BwrGCw9nGFkik4KQEjo9kbEzdtr0kBDIA33Vdb/oLSLSo+LB4FmdoPJJ6DpX0q+GbVCT
         C/uXGr5N2olfo5e2yAn/NbXU7/WntZE9mv5Aub6oKWoHFyhohzofhc4YVpjJFmbq40+w
         jPIiK4XnDmFUFGvmsS57aKC1TjWPUwPZKgVN0rgoC9q+nTvqGdsb4fRr2j4rE9PTvfYq
         MX08IHcYNszOKCTZRYVg1SOFA2QxAjrcK/5OyiXXc1/sTPpGFSK7DpehSysNnOlGiw+q
         u3Bw==
X-Gm-Message-State: AOAM533SCAvEJgmQ2P4/5Ok9AoIO+Ab7Kho9Vmtdb0LWvnxkBO/7xEil
        yGCVlGmVyQHRr5Np4tHV704E7l/Qw5g=
X-Google-Smtp-Source: ABdhPJz+IwBCZr+063GKs66iIVOXdaMtUC7fVF8Hl5MMaoHAANDNJecaiwcaG8uUjoayiYvltsgkdA==
X-Received: by 2002:a7b:c157:: with SMTP id z23mr4371540wmi.35.1608139036825;
        Wed, 16 Dec 2020 09:17:16 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q1sm4068622wrj.8.2020.12.16.09.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 09:17:16 -0800 (PST)
Message-Id: <dcf28565ad35729a0c5a755689ab47185bf56ccd.1608139034.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.814.v3.git.1608139034.gitgitgadget@gmail.com>
References: <pull.814.v2.git.1608097965.gitgitgadget@gmail.com>
        <pull.814.v3.git.1608139034.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 16 Dec 2020 17:17:12 +0000
Subject: [PATCH v3 1/3] merge-ort: copy a few small helper functions from
 merge-recursive.c
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
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
index 414e7b7eeac..b66f8a6f100 100644
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
@@ -1348,6 +1350,36 @@ void merge_finalize(struct merge_options *opt,
 
 /*** Function Grouping: helper functions for merge_incore_*() ***/
 
+static inline void set_commit_tree(struct commit *c, struct tree *t)
+{
+	c->maybe_tree = t;
+}
+
+MAYBE_UNUSED
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
+MAYBE_UNUSED
+static struct commit_list *reverse_commit_list(struct commit_list *list)
+{
+	struct commit_list *previous = NULL, *current, *backup;
+	for (current = list; current; current = backup) {
+		backup = current->next;
+		current->next = previous;
+		previous = current;
+	}
+	return previous;
+}
+
 static void merge_start(struct merge_options *opt, struct merge_result *result)
 {
 	/* Sanity checks on opt */
-- 
gitgitgadget

