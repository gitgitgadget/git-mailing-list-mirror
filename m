Return-Path: <SRS0=U/aV=EE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87167C4742C
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 20:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D7292072E
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 20:32:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="prf7wOhr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbgJ2Uch (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Oct 2020 16:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726433AbgJ2Uce (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Oct 2020 16:32:34 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2865C0613D6
        for <git@vger.kernel.org>; Thu, 29 Oct 2020 13:32:19 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id h22so1066663wmb.0
        for <git@vger.kernel.org>; Thu, 29 Oct 2020 13:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+Y+9I9keb2Y2wQTpn35Y0+o6yoPUrfiqSOD46QH93r8=;
        b=prf7wOhrQX1OqrN2unb3QBwAy4WedM9i3t3NkKaxGEpM0AvgcULKquSzSpFGUJyzlH
         8s3QQVk+r0Qsdlcg1W6G8ueLdFlCkP3nRkc8eTv3mKjhEcq+1oB6Hw95IUa47N6oGQec
         m3ekYzKr5mlbpC1Dn8udTtNk1SF/2ev6tMcbCvPMGf6FEpobux1/vv1CpPjHRiZdem7+
         O0hKZbdUV7kSs1yLCnJNbhKWNRYpE1tILj2t1RBLGTd8YyS/m6CzWhYGASuMat1kuZEb
         +Fxr/65EJByLKkXGzbmQK/+fT6ULSD1ckB8kLiokFqJAfiXc+qUt6FCaAqp9mf72hhWV
         RmiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+Y+9I9keb2Y2wQTpn35Y0+o6yoPUrfiqSOD46QH93r8=;
        b=tC9+nANwx1j9NRpId4ysxLv69vj3BphLJ2zq9WRU9MTSxZdZZ81fWc/B96AgpiylvN
         QMM+2dL695Lh/9UExRsf6Wpnrq1ud5aTRetjPrsX7SCG9cgtc8NNZ+6iyOg3sktuo7iP
         nx3n0bskMYqVH8QRYHPZtPKGblzO6o/nHj0ZqgYOQSHjcK3cjCbiPmLixuxtIy9reTmo
         hlDoN9gIzFVClVlZmk6EFKLSplmb1V1fLrvMSwqEpv4+7wzZysSsF1jW6K2j67I8cG87
         Ex9XXghlgrxX/xgAu0l38RPLVb60sE2YnwtAGBWcP92gNRVT9WKO5DcNI9/CjQMmu75G
         cJVQ==
X-Gm-Message-State: AOAM533IFSq6nqTPo4u3PiOXfGSMqEKEs2ieXPm/Txi9hVVnu0JEln1F
        KV2phjEpdBRlEdNN2mQ3aaW6iNNWzaI=
X-Google-Smtp-Source: ABdhPJyrohXYCMPDms3A9T4GXKY4c8DKkjiEtlWkqeDIf+93pxEwCSMS/jLHTUEHw9VQnRQlrdVDQA==
X-Received: by 2002:a1c:4057:: with SMTP id n84mr885650wma.116.1604003538404;
        Thu, 29 Oct 2020 13:32:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 71sm7706282wrm.20.2020.10.29.13.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 13:32:17 -0700 (PDT)
Message-Id: <d7f6a834ab4942b3af329eff9c883fcf7affd7f4.1604003535.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.895.v4.git.git.1604003535.gitgitgadget@gmail.com>
References: <pull.895.v3.git.git.1603764490.gitgitgadget@gmail.com>
        <pull.895.v4.git.git.1604003535.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 29 Oct 2020 20:32:12 +0000
Subject: [PATCH v4 2/4] merge-ort-wrappers: new convience wrappers to mimic
 the old merge API
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
index 0000000000..7eec25f93a
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
+	merge_incore_nonrecursive(opt, merge_base, head, merge, &result);
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
+	merge_incore_recursive(opt, merge_bases, side1, side2, &tmp);
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

