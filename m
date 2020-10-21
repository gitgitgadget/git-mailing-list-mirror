Return-Path: <SRS0=jwDG=D4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D7A6C55178
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 13:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E385D21D7B
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 13:22:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BqIypbEQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438090AbgJUNWr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Oct 2020 09:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437860AbgJUNWo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Oct 2020 09:22:44 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD69C0613CF
        for <git@vger.kernel.org>; Wed, 21 Oct 2020 06:22:44 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id q5so2513723wmq.0
        for <git@vger.kernel.org>; Wed, 21 Oct 2020 06:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=lGrfOgvC7SqnKZIYbMOQeVni7I6tk/+NJI+xaLB4+PU=;
        b=BqIypbEQPT66lOK+8U8+q0asZXs7ria8m/bWa4ggZ1ERlAqG6tWMmo99/qzp7ziPy+
         oINxEKxqQMJ1RKDi3mK47tjnszCWCvr/ikCzbRa2Pn8Ls1R9qLY6089Oo4HVaKwx8TRM
         wR1VpqzOfmsWIO+GSXARyuPqWH2psX1J2uS9zxgGeCqxm8EXt3zUnBOcSzKzHjDgfBir
         lpdDupmI8mMjRdMGzbZ6s6IidLfQLjn6LAKc8+i3VCgJ7LF/reD8VH9lZH2BLb0wR00x
         I9EbTRfnmasLc47ATbJEi6koXn3kTQOSuV6D/RsToXxecVNFqzuJV14zakRUPbKZRBXf
         8rgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=lGrfOgvC7SqnKZIYbMOQeVni7I6tk/+NJI+xaLB4+PU=;
        b=L9I658qN/tRCmUirwRVA7WqhIcaaTAgVYcv9mnpQ+o1eNM02t/PDI8Hwn9a1/pTIYQ
         r6QQKa8o7CljjaK51fYyTUcdsldXnC1esGu1MEKEDmsEAS7spnDFbOkeoPP2jTOZIt9r
         /EWt0titavJE6oTPtxJdAvCJJYK2oJ5vQxj20aEjYqS/qRRxwsuS+U+o/cVbo5GRzOSB
         cTStpJ1EHIRsL6O5aF+1QH7nFJN5p6jJ5AiNzIU2VahCcQsWnu/62eGs3DnhEUFXuqWT
         aVLP2n8mc6dp9ZYyKptnPGKtCZ+ToBA8e8TvU2fWe285d0kAq+wzzuuhxdmxiE33gITM
         vl4A==
X-Gm-Message-State: AOAM5307Z8FtHqseLAN1XNetjftqGg4Wxrzy8W/cM8rCFNABcBfQZGDF
        0HVElb8WWe1dNH8zsaxGX3MEvLkOtLE=
X-Google-Smtp-Source: ABdhPJxy1nDS2qM7yaNhAtK3QWX5EtcGs0Fs6xSmBm0TybBdm0RuGqDs09LFwQDOSM0qo4hi/ZgaHQ==
X-Received: by 2002:a1c:5f85:: with SMTP id t127mr3159724wmb.31.1603286559722;
        Wed, 21 Oct 2020 06:22:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d20sm4247036wra.38.2020.10.21.06.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 06:22:38 -0700 (PDT)
Message-Id: <54ef18182cf3a4b5d02889c139e495fa68588652.1603286555.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.895.git.git.1603286555.gitgitgadget@gmail.com>
References: <pull.895.git.git.1603286555.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 21 Oct 2020 13:22:32 +0000
Subject: [PATCH 1/4] merge-ort: barebones API of new merge strategy with empty
 implementation
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

This is the beginning of a new merge strategy.  While there are some API
differences, and the implementation has some differences in behavior, it
is essentially meant as an eventual drop-in replacement for
merge-recursive.c.  However, it is being built to exist side-by-side
with merge-recursive so that we have plenty of time to find out how
those differences pan out in the real world while people can still fall
back to merge-recursive.  (Also, I intend to avoid modifying
merge-recursive during this process, to keep it stable.)

The primary difference noticable here is that the updating of the
working tree and index is not done simultaneously with the merge
algorithm, but is a separate post-processing step.  The new API is
designed so that one can do repeated merges (e.g. during a rebase or
cherry-pick) and only update the index and working tree one time at the
end instead of updating it with every intermediate result.  Also, one
can perform a merge between two branches, neither of which match the
index or the working tree, without clobbering the index or working tree.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Makefile    |  1 +
 merge-ort.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 merge-ort.h | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 102 insertions(+)
 create mode 100644 merge-ort.c
 create mode 100644 merge-ort.h

diff --git a/Makefile b/Makefile
index 95571ee3fc..088770c2ae 100644
--- a/Makefile
+++ b/Makefile
@@ -921,6 +921,7 @@ LIB_OBJS += mailmap.o
 LIB_OBJS += match-trees.o
 LIB_OBJS += mem-pool.o
 LIB_OBJS += merge-blobs.o
+LIB_OBJS += merge-ort.o
 LIB_OBJS += merge-recursive.o
 LIB_OBJS += merge.o
 LIB_OBJS += mergesort.o
diff --git a/merge-ort.c b/merge-ort.c
new file mode 100644
index 0000000000..5230364a8d
--- /dev/null
+++ b/merge-ort.c
@@ -0,0 +1,52 @@
+/*
+ * "Ostensibly Recursive's Twin" merge strategy, or "ort" for short.  Meant
+ * as a drop-in replacement for the "recursive" merge strategy, allowing one
+ * to replace
+ *
+ *   git merge [-s recursive]
+ *
+ * with
+ *
+ *   git merge -s ort
+ *
+ * Note: git's parser allows the space between '-s' and its argument to be
+ * missing.  (Should I have backronymed "ham", "alsa", "kip", "nap, "alvo",
+ * "cale", "peedy", or "ins" instead of "ort"?)
+ */
+
+#include "cache.h"
+#include "merge-ort.h"
+
+void merge_switch_to_result(struct merge_options *opt,
+			    struct tree *head,
+			    struct merge_result *result,
+			    int update_worktree_and_index,
+			    int display_update_msgs)
+{
+	die("Not yet implemented");
+	merge_finalize(opt, result);
+}
+
+void merge_finalize(struct merge_options *opt,
+		    struct merge_result *result)
+{
+	die("Not yet implemented");
+}
+
+void merge_inmemory_nonrecursive(struct merge_options *opt,
+				 struct tree *merge_base,
+				 struct tree *side1,
+				 struct tree *side2,
+				 struct merge_result *result)
+{
+	die("Not yet implemented");
+}
+
+void merge_inmemory_recursive(struct merge_options *opt,
+			      struct commit_list *merge_bases,
+			      struct commit *side1,
+			      struct commit *side2,
+			      struct merge_result *result)
+{
+	die("Not yet implemented");
+}
diff --git a/merge-ort.h b/merge-ort.h
new file mode 100644
index 0000000000..9c655cd3ad
--- /dev/null
+++ b/merge-ort.h
@@ -0,0 +1,49 @@
+#ifndef MERGE_ORT_H
+#define MERGE_ORT_H
+
+#include "merge-recursive.h"
+
+struct commit;
+struct tree;
+
+struct merge_result {
+	/* whether the merge is clean */
+	int clean;
+
+	/* Result of merge.  If !clean, represents what would go in worktree */
+	struct tree *tree;
+
+	/*
+	 * Additional metadata used by merge_switch_to_result() or future calls
+	 * to merge_inmemory_*().
+	 */
+	unsigned _;
+	void *priv;
+};
+
+/* rename-detecting three-way merge, no recursion. */
+void merge_inmemory_recursive(struct merge_options *opt,
+			      struct commit_list *merge_bases,
+			      struct commit *side1,
+			      struct commit *side2,
+			      struct merge_result *result);
+
+/* rename-detecting three-way merge with recursive ancestor consolidation. */
+void merge_inmemory_nonrecursive(struct merge_options *opt,
+				 struct tree *merge_base,
+				 struct tree *side1,
+				 struct tree *side2,
+				 struct merge_result *result);
+
+/* Update the working tree and index from head to result after inmemory merge */
+void merge_switch_to_result(struct merge_options *opt,
+			    struct tree *head,
+			    struct merge_result *result,
+			    int update_worktree_and_index,
+			    int display_update_msgs);
+
+/* Do needed cleanup when not calling merge_switch_to_result() */
+void merge_finalize(struct merge_options *opt,
+		    struct merge_result *result);
+
+#endif
-- 
gitgitgadget

