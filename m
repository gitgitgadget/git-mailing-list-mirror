Return-Path: <SRS0=DNVg=EI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA12CC2D0A3
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 23:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A75E2225E
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 23:45:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bpVZHj8N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbgKBXpl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Nov 2020 18:45:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725841AbgKBXpj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Nov 2020 18:45:39 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A855EC0617A6
        for <git@vger.kernel.org>; Mon,  2 Nov 2020 15:45:38 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id k10so15185151wrw.13
        for <git@vger.kernel.org>; Mon, 02 Nov 2020 15:45:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=68sc9B/0csd629noV8jhACYBrCHiFf55lnL+7AxCs08=;
        b=bpVZHj8NetvEY3rRfpEf/Eauxt7NjH4KsL2VYiZNSUEgB88hJmzUPW3PkeVfrPEVKX
         n1iBMg8Ati+P0AYKc4RGDwpgkYT3tjhXy94E77wMR1y3iCK47m+HfLQEP1VDnCaDbciV
         4m54WAi/21MAP5WHZh1ZRTLsWbpj1mpNU1ywnvhNfeEt+8atogv1aahFSDXvLpdOzc2O
         ud869hw+YhPl04ZVCFoogbK3IjfZHHsclcHiUdUShtLUv3X6lhO76TPErrtmR0K5MhBl
         CSxRu5hHmoRzezI+8SP9i3EG/tVIfX6Q8sZyh00nkvVHuDWn83n+hl2eadPzaCO2DYWp
         L0sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=68sc9B/0csd629noV8jhACYBrCHiFf55lnL+7AxCs08=;
        b=Ife9+g9nxl7I8ZgmpcWd1X60knSFe/KnZa4tsG+SB9dEqiIqAomGaGoPereVyo1m34
         8Ueltaj4wvM6jMk45YlPAOtjs7Kh+sx5Z4WNC/o8yMqGr6Ec1mhnzyJeMy/d8ZA51ocl
         dMwiWMapYsYrFlVw9g77I/VuFTO4Lm1sy7lMFy8tWpSI8GrK69gXIadpgiSAo9S81Mpm
         a8uVRqYHaeMB4yzQM2vLzzk8QwtkFqBC9JEoznGbWAQFamk8HNQZUMWXSXgVlpnm5QuI
         +fplQorqfqBFFNRoPdBZO60jUR9tg5zAEQlJgKBAbya1yqHBANdwS2vvpXWOBj9QQYY8
         ZAZg==
X-Gm-Message-State: AOAM533lMfvXPfTDb5uM3VNoRvCHODpboRAwSEHD0Tbat7EzKOYrgz0f
        Zv9UIZohbHYf1xhVfBfPfJe45fb7Q2s=
X-Google-Smtp-Source: ABdhPJzCm72p+BIAaWFYfpKr4TAzLpbKbgyL695g7wm2mkzfYNxlk/y5lnQGPqvuERGtLComHS6t2Q==
X-Received: by 2002:a5d:5612:: with SMTP id l18mr24101263wrv.372.1604360737180;
        Mon, 02 Nov 2020 15:45:37 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o63sm1053274wmo.2.2020.11.02.15.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 15:45:36 -0800 (PST)
Message-Id: <3357ea415e3437966f15bf73fbbeb21cda3df592.1604360734.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.895.v5.git.git.1604360734.gitgitgadget@gmail.com>
References: <pull.895.v4.git.git.1604003535.gitgitgadget@gmail.com>
        <pull.895.v5.git.git.1604360734.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 02 Nov 2020 23:45:31 +0000
Subject: [PATCH v5 1/4] merge-ort: barebones API of new merge strategy with
 empty implementation
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        Peter Baumann <peter.baumann@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
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

The next three commits will demonstrate various uses of this new API.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Makefile    |  1 +
 merge-ort.c | 52 +++++++++++++++++++++++++++++++++++++++++++++++
 merge-ort.h | 58 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 111 insertions(+)
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
index 0000000000..b487901d3e
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
+void merge_incore_nonrecursive(struct merge_options *opt,
+			       struct tree *merge_base,
+			       struct tree *side1,
+			       struct tree *side2,
+			       struct merge_result *result)
+{
+	die("Not yet implemented");
+}
+
+void merge_incore_recursive(struct merge_options *opt,
+			    struct commit_list *merge_bases,
+			    struct commit *side1,
+			    struct commit *side2,
+			    struct merge_result *result)
+{
+	die("Not yet implemented");
+}
diff --git a/merge-ort.h b/merge-ort.h
new file mode 100644
index 0000000000..74adccad16
--- /dev/null
+++ b/merge-ort.h
@@ -0,0 +1,58 @@
+#ifndef MERGE_ORT_H
+#define MERGE_ORT_H
+
+#include "merge-recursive.h"
+
+struct commit;
+struct tree;
+
+struct merge_result {
+	/* Whether the merge is clean */
+	int clean;
+
+	/*
+	 * Result of merge.  If !clean, represents what would go in worktree
+	 * (thus possibly including files containing conflict markers).
+	 */
+	struct tree *tree;
+
+	/*
+	 * Additional metadata used by merge_switch_to_result() or future calls
+	 * to merge_incore_*().  Includes data needed to update the index (if
+	 * !clean) and to print "CONFLICT" messages.  Not for external use.
+	 */
+	void *priv;
+};
+
+/*
+ * rename-detecting three-way merge with recursive ancestor consolidation.
+ * working tree and index are untouched.
+ */
+void merge_incore_recursive(struct merge_options *opt,
+			    struct commit_list *merge_bases,
+			    struct commit *side1,
+			    struct commit *side2,
+			    struct merge_result *result);
+
+/*
+ * rename-detecting three-way merge, no recursion.
+ * working tree and index are untouched.
+ */
+void merge_incore_nonrecursive(struct merge_options *opt,
+			       struct tree *merge_base,
+			       struct tree *side1,
+			       struct tree *side2,
+			       struct merge_result *result);
+
+/* Update the working tree and index from head to result after incore merge */
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

