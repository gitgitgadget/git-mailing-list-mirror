Return-Path: <SRS0=PD7l=EB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F39C4C4363A
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 16:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B045A2068D
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 16:57:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="guMPMQAG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1786748AbgJZQ5f (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Oct 2020 12:57:35 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34851 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1786736AbgJZQ5d (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Oct 2020 12:57:33 -0400
Received: by mail-wm1-f68.google.com with SMTP id h22so2135645wmb.0
        for <git@vger.kernel.org>; Mon, 26 Oct 2020 09:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=v+YPpewhWqpkOyvySZBdBaJAzALEezMP6S2PQTseFs0=;
        b=guMPMQAGm0EfuAfufUMaCaC9jsdiQD2LaZFVjPDvEVvAjMDkG4Fuq4VMvWR4Kx/1x9
         cnmV3GHY359hOaEj6z5On+/BjT7xPsthEXG9+xhuf1fFgEe+4LrvOrfF+aBbXBcTlO3h
         HmfSc48E7TmH7xm0he1hlwe0m/9yaO2qcYXKt27QKGcQqkqALGbeeo5CZqiHgYkWdFGK
         jTwTMpfEqU0+saTUQ15ao0IV/wAxCyvPrS8w9QpKgNQuR0bYzWkzsut3bOD9n5KXul50
         JgYNgGrnvXSR5m5Amult+IDKcy63iFm1TEda2pSa9ggDNYwSQnBCtCUt7sI93nNcW9/O
         jYsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=v+YPpewhWqpkOyvySZBdBaJAzALEezMP6S2PQTseFs0=;
        b=qo8H3/tts3At1wWzfMQ9xGIx7E1fw95k0+NB7hOl99ozPwFmYHku6T3g4lWp9cnBH5
         JrX9fl4qL5RDUsmxeZVSwL1aSkSGqXzXK89Hs44RODeUx5MKtY399trmZLjFRX3wWgE5
         tUTc4+hJwyPe2Lm5OYKhgm+prLuegKouHHzeTtoE9Rn+WQLZQda8eVyKqS2DYhwJVmTx
         ZzhYHEi/yKLy2Y3FQsZk5hvUcMk4/lhqeE8NlPC3DhR7w8BmgVI7pIAXQI8q70H0lLR4
         Bon23exRFxzQYMpptKimXhgRpQL8RakFWP52vjJz9BGnMmdxmOzaswJk7RzQSEIjNUog
         361g==
X-Gm-Message-State: AOAM530cWFUhW/kYqQjX6jip/dDIfWrEa7NN/dK26RE0o40XqDLFAi4X
        k/bCy2/bJVMw7bMD+Ng8TKDER6NRpDc=
X-Google-Smtp-Source: ABdhPJy7W11J5EwKZfiYTQYMEpViUEr6JydfvfYf50Xcdu05Hk1v5U9yFCpbUc5yGnpIcwLNPi/vFg==
X-Received: by 2002:a1c:2601:: with SMTP id m1mr16094461wmm.12.1603731451341;
        Mon, 26 Oct 2020 09:57:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a199sm23437224wmd.8.2020.10.26.09.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 09:57:30 -0700 (PDT)
Message-Id: <a9fff811a2157f26908eb87f5b6e17dcf8c8e50d.1603731448.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.895.v2.git.git.1603731448.gitgitgadget@gmail.com>
References: <pull.895.git.git.1603286555.gitgitgadget@gmail.com>
        <pull.895.v2.git.git.1603731448.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 26 Oct 2020 16:57:26 +0000
Subject: [PATCH v2 2/4] merge-ort-wrappers: new convience wrappers to mimic
 the old merge API
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        Peter Baumann <peter.baumann@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

There are a few differences between the new API in merge-ort and the old
API in merge-recursive.  While the new API is more flexible, it might
feel like more work at times than the old API.  merge-ort-wrappers
creates two convenience wrappers taking the exact same arguments as the
old merge_trees() and merge_recursive() functions and implements them
via the new API.  This makes converting existing callsites easier, and
serves to highlight some of the differences in the API.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Makefile             |  1 +
 merge-ort-wrappers.c | 62 ++++++++++++++++++++++++++++++++++++++++++++
 merge-ort-wrappers.h | 25 ++++++++++++++++++
 3 files changed, 88 insertions(+)
 create mode 100644 merge-ort-wrappers.c
 create mode 100644 merge-ort-wrappers.h

diff --git a/Makefile b/Makefile
index 088770c2ae..382fe73c76 100644
--- a/Makefile
+++ b/Makefile
@@ -922,6 +922,7 @@ LIB_OBJS += match-trees.o
 LIB_OBJS += mem-pool.o
 LIB_OBJS += merge-blobs.o
 LIB_OBJS += merge-ort.o
+LIB_OBJS += merge-ort-wrappers.o
 LIB_OBJS += merge-recursive.o
 LIB_OBJS += merge.o
 LIB_OBJS += mergesort.o
diff --git a/merge-ort-wrappers.c b/merge-ort-wrappers.c
new file mode 100644
index 0000000000..e96c1a71be
--- /dev/null
+++ b/merge-ort-wrappers.c
@@ -0,0 +1,62 @@
+#include "cache.h"
+#include "merge-ort.h"
+#include "merge-ort-wrappers.h"
+
+#include "commit.h"
+
+static int unclean(struct merge_options *opt, struct tree *head)
+{
+	/* Sanity check on repo state; index must match head */
+	struct strbuf sb = STRBUF_INIT;
+
+	if (head && repo_index_has_changes(opt->repo, head, &sb)) {
+		fprintf(stderr, _("Your local changes to the following files would be overwritten by merge:\n  %s"),
+		    sb.buf);
+		strbuf_release(&sb);
+		return -1;
+	}
+
+	return 0;
+}
+
+int merge_ort_nonrecursive(struct merge_options *opt,
+			   struct tree *head,
+			   struct tree *merge,
+			   struct tree *merge_base)
+{
+	struct merge_result result;
+
+	if (unclean(opt, head))
+		return -1;
+
+	if (oideq(&merge_base->object.oid, &merge->object.oid)) {
+		printf(_("Already up to date!"));
+		return 1;
+	}
+
+	memset(&result, 0, sizeof(result));
+	merge_inmemory_nonrecursive(opt, merge_base, head, merge, &result);
+	merge_switch_to_result(opt, head, &result, 1, 1);
+
+	return result.clean;
+}
+
+int merge_ort_recursive(struct merge_options *opt,
+			struct commit *side1,
+			struct commit *side2,
+			struct commit_list *merge_bases,
+			struct commit **result)
+{
+	struct tree *head = repo_get_commit_tree(opt->repo, side1);
+	struct merge_result tmp;
+
+	if (unclean(opt, head))
+		return -1;
+
+	memset(&tmp, 0, sizeof(tmp));
+	merge_inmemory_recursive(opt, merge_bases, side1, side2, &tmp);
+	merge_switch_to_result(opt, head, &tmp, 1, 1);
+	*result = NULL;
+
+	return tmp.clean;
+}
diff --git a/merge-ort-wrappers.h b/merge-ort-wrappers.h
new file mode 100644
index 0000000000..0c4c57adbb
--- /dev/null
+++ b/merge-ort-wrappers.h
@@ -0,0 +1,25 @@
+#ifndef MERGE_ORT_WRAPPERS_H
+#define MERGE_ORT_WRAPPERS_H
+
+#include "merge-recursive.h"
+
+/*
+ * rename-detecting three-way merge, no recursion.
+ * Wrapper mimicking the old merge_trees() function.
+ */
+int merge_ort_nonrecursive(struct merge_options *opt,
+			   struct tree *head,
+			   struct tree *merge,
+			   struct tree *common);
+
+/*
+ * rename-detecting three-way merge with recursive ancestor consolidation.
+ * Wrapper mimicking the old merge_recursive() function.
+ */
+int merge_ort_recursive(struct merge_options *opt,
+			struct commit *h1,
+			struct commit *h2,
+			struct commit_list *ancestors,
+			struct commit **result);
+
+#endif
-- 
gitgitgadget

