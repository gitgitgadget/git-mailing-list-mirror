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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67979C0018C
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 20:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EB4E233CE
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 20:36:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbgLPUgE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 15:36:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727459AbgLPUgD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 15:36:03 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B6CEC06179C
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 12:35:23 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id x22so3574883wmc.5
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 12:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=XGikWbQ/uqhrZg/jR4gVAQvl4psVFSLa+sJDq8YkCRk=;
        b=Sl7Slzgl4LKZPhRhMlCeZY2+qu9bp4E07R/xe+zmdc2Xfld93ZunUPnRLF1Mt7ax1v
         gfBeFNkHuIsLUnCx/qtXMVi7Js1hXpaRlzXCJE2GmPPzU8lqxK7Jv6PmAzWmlboHTk9m
         WfmHpvFx771imCqLYBbw4LIMRhC72BtIw5l5qTMxWFRTly755JITTt0yFtL8qvweIo3M
         t74NMcQfj0VibiFdgGdln2yOgvMdawBvr0VuJu7HyTB+ztzUSK2ULr8C23vxrCX9ZQ77
         MnR5ccRfUq0aH55TQPU+l+mLI5wCxImOEyJ5Fnlah7FqBjjKem5myXDnYhZk5YK7i3xr
         I5CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=XGikWbQ/uqhrZg/jR4gVAQvl4psVFSLa+sJDq8YkCRk=;
        b=KVpT2OKavw0Uch9jY+oJkyW3dS+3b2pUqNTeJ+WhW/bh4GT0wLdqcdU9U2NyjAMRIe
         uatUXoVOIexxaDuSei6+WTo/qJvehPxpP/DTagwSv0PQ3L5eZeblfTVFqwdkJbLMBXwN
         aLjuoilFeyF4XG4XLlJjX5xcbN0KyWD3t5+PfyIUDtygcuW31UdrCuGRlzC7+Tyd1Ejq
         A+xiJsNC0DgdFNQujP4Ijz9SKqSQdpkOSoBm/J3RIc5uDcpxtPkpYAd5Rc7wpzRddaVd
         w7MqK5iVpgQ9ZTwHXTrDvc3hMo5kYWmMoe0mj+sxsp7M/zLQKdz4tdfZmUkk4Oa8S1MN
         hoGA==
X-Gm-Message-State: AOAM5335VYy9IAMDF1cCGUM/MWSu+VNSDrHzT+uvOQscH4+58WlQ6qE+
        PO7M/goJ2+ZKlVZAgZQflS0RfY8rg8Q=
X-Google-Smtp-Source: ABdhPJyvqe1YuR5wcOTssUVeRguWSbaHCXE9+t6DEzNXx67i6KgDw1Vypf5/BS0LIUPhvon2h0MS6w==
X-Received: by 2002:a05:600c:22d9:: with SMTP id 25mr5057321wmg.158.1608150921770;
        Wed, 16 Dec 2020 12:35:21 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a62sm5432233wmh.40.2020.12.16.12.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 12:35:21 -0800 (PST)
Message-Id: <dcf28565ad35729a0c5a755689ab47185bf56ccd.1608150919.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.814.v4.git.1608150919.gitgitgadget@gmail.com>
References: <pull.814.v3.git.1608139034.gitgitgadget@gmail.com>
        <pull.814.v4.git.1608150919.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 16 Dec 2020 20:35:17 +0000
Subject: [PATCH v4 1/3] merge-ort: copy a few small helper functions from
 merge-recursive.c
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Felipe Contreras <felipe.contreras@gmail.com>,
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

