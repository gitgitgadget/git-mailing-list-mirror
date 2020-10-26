Return-Path: <SRS0=PD7l=EB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99782C4363A
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 16:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DED222450
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 16:58:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i8+wZ/G4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1773902AbgJZQ6c (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Oct 2020 12:58:32 -0400
Received: from mail-wm1-f49.google.com ([209.85.128.49]:35192 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1786724AbgJZQ5d (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Oct 2020 12:57:33 -0400
Received: by mail-wm1-f49.google.com with SMTP id h22so2135604wmb.0
        for <git@vger.kernel.org>; Mon, 26 Oct 2020 09:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=w5aKZjwVpoj8oImy5JCRqpjH7fKAKGtZ+fkKJvgHGCw=;
        b=i8+wZ/G44d/gBHYOuSwvFGOsSxU81OuOIKQUfVXobd9b/TW9l6y0SYlIzLbvRND8AE
         1tSp54WYAtjVSPeB4qfUwN5BfeVT9xzbOsbXYX8Uyvwp0cFne5nGIZoszy4WYTfvOlDY
         1FQMfFMiVSSWzf7QEEjx/Akn1b/5B5Rtvpf1UE79RM67ZWErNR3Wwk/7W/jHgnh7dvSV
         VU7CY31pm6E438QgMkXnOBAgdekOqnGpAduq4dsyIWbiOig9c+xVJIBlW6hpc7E1FMJS
         53XbS1spA4LDmhLtdXmTIwRjhUKLRdVdSsGEW2ORQ69ZH7SzCpZ5RPbEPTmsiENclIoN
         xdoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=w5aKZjwVpoj8oImy5JCRqpjH7fKAKGtZ+fkKJvgHGCw=;
        b=BVJAu+q1IxGN5TOD0RDu8ciLD1bMffqqNWcr9UGaihxbL31f39MrZju6CcIajSXZqp
         lhWzd1cHGalz5Q2cOFc9BBy9KMcD65HYfNJkViijr9qnCTzVeMWzmQ/AikcyGQdmamo2
         E74BJCJpMcs0d2JQ+FWTYdCje+dmH/og8hS3d1GOBaeJoo7QOzVxTcwx9/0D0tnP8eZ/
         DCJUGxeS7Mb7DZ3G/mGC0CLywhrNHA4jNK4IpLj3QSSFt5gpWDn5hU9Zq25Jkf4JDefM
         C9jRGPeOLC52PSFOUzff061T80Y4BEEQvvrAWx75oubS3pJePXTVZ05u25yapYt02KBl
         RphQ==
X-Gm-Message-State: AOAM531sAOCc45XKLEImECP4ucrbq9MXHFnT/inTRuc4wtqeqMfdv1I3
        k3kkv7/qj9TUkek9+iF1tGw4RFvqXoc=
X-Google-Smtp-Source: ABdhPJw1vMSzELgm4tlgQmOK3aa+mqbXGwmkUldcB0eW68cf6XA6qI0wB9bZiW0C0DOX+VXxWMg0AQ==
X-Received: by 2002:a7b:cb98:: with SMTP id m24mr18045215wmi.133.1603731450356;
        Mon, 26 Oct 2020 09:57:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t19sm24765692wmi.26.2020.10.26.09.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 09:57:29 -0700 (PDT)
Message-Id: <b9e73975eab1f349be678779ff57155feb4c3501.1603731448.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.895.v2.git.git.1603731448.gitgitgadget@gmail.com>
References: <pull.895.git.git.1603286555.gitgitgadget@gmail.com>
        <pull.895.v2.git.git.1603731448.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 26 Oct 2020 16:57:25 +0000
Subject: [PATCH v2 1/4] merge-ort: barebones API of new merge strategy with
 empty implementation
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
index 0000000000..47d30cf538
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
+	 * to merge_inmemory_*().  Not for external use.
+	 */
+	void *priv;
+	unsigned ate;
+};
+
+/* rename-detecting three-way merge with recursive ancestor consolidation. */
+void merge_inmemory_recursive(struct merge_options *opt,
+			      struct commit_list *merge_bases,
+			      struct commit *side1,
+			      struct commit *side2,
+			      struct merge_result *result);
+
+/* rename-detecting three-way merge, no recursion. */
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

