Return-Path: <SRS0=jwDG=D4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 624AEC388F9
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 13:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE06422249
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 13:22:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j8Ebmsth"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437708AbgJUNWn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Oct 2020 09:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437452AbgJUNWn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Oct 2020 09:22:43 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB945C0613CE
        for <git@vger.kernel.org>; Wed, 21 Oct 2020 06:22:42 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id d3so2527821wma.4
        for <git@vger.kernel.org>; Wed, 21 Oct 2020 06:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=v+YPpewhWqpkOyvySZBdBaJAzALEezMP6S2PQTseFs0=;
        b=j8Ebmsth/Cs3+oKu8cR1FOKSIpjYJFIzke1MUjuq3MHCdOflC2i+uil59KMBtMk9zM
         CcMbP77HqiDPRdsAha+Gq/oCaVREKJWor5NCGHMB6Z5IRF81/2Cik0TpsvVEDaLoj3BS
         kNSzu9PGs21XpVfofJnGutKP5mkJVxRCpZke7M+VrSIkoh+lGEXlEPY6RznRCxiZ+s9N
         Ft4/s0fpkQ+CTsk/U078+TE32TSFM0UTPntF1SzWLkGUBOyxoS0rsDGyZFqm3DHNBGK2
         K1RgB3YWkrzt/hU22e1wYAfQGNBy0W+qC1QkdlLmU33GXbU16kFEFh5g5Imlnv13addE
         oeug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=v+YPpewhWqpkOyvySZBdBaJAzALEezMP6S2PQTseFs0=;
        b=mI5eel21vUrjTohR7QELPGrNwj47o74xrq6jCd1gGW5AbECxAnwFOJeq3iylSpDt22
         hO0n/B+abluyg1P+xOFfPq5jJHwa4T6fhqzWzKSTNeHduCGf5t+7YcITGKMJ3UnQgTq3
         k4LpB9Ysfubu/dTy69e0zjl6fZVZZrFWBhlFoG7kVva6k0k6TP7F/yXE+wFtSTUdU1gh
         gPGuTjzSLge+mcLBHGJslnS1+fkHXO6HtZL8soPvTwXxmxKjdVcybFmmsBA9EV381ujA
         a4x2v44qL/k2Ma1eVjhqD3EOyA/EByXB/PAOuteNGRjyM7KjsLBJwKrny7RqN+m+NxsC
         U9uw==
X-Gm-Message-State: AOAM5316w0GkhAapr/7HP6YfwwfK9li/YpjyXlLn6xXIi5S7TPoTk285
        p4p8LozK43nMgkdFHnEtfn06LBA0ETY=
X-Google-Smtp-Source: ABdhPJzwSrOlw7HfaLpfUWjmMkqPEOlOHeOzazAHRbZQEZGXtzssHOt21vfapKdGhZWCHgjjyUvhLg==
X-Received: by 2002:a1c:f417:: with SMTP id z23mr3433162wma.57.1603286560584;
        Wed, 21 Oct 2020 06:22:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x6sm3932174wmb.17.2020.10.21.06.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 06:22:40 -0700 (PDT)
Message-Id: <f597609b8872fc2bb4f32c439ab6f74c3e41ce24.1603286556.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.895.git.git.1603286555.gitgitgadget@gmail.com>
References: <pull.895.git.git.1603286555.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 21 Oct 2020 13:22:33 +0000
Subject: [PATCH 2/4] merge-ort-wrappers: new convience wrappers to mimic the
 old merge API
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

