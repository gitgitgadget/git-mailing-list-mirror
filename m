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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A75AC433E6
	for <git@archiver.kernel.org>; Wed, 30 Dec 2020 19:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E3A022262
	for <git@archiver.kernel.org>; Wed, 30 Dec 2020 19:27:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbgL3T1i (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Dec 2020 14:27:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbgL3T1h (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Dec 2020 14:27:37 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34AF9C061575
        for <git@vger.kernel.org>; Wed, 30 Dec 2020 11:26:57 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id v14so5710674wml.1
        for <git@vger.kernel.org>; Wed, 30 Dec 2020 11:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=OXAN55UXbgVOPmqR+PQwQUEvH96OvESTKa1SLY1IYkE=;
        b=fwfmcR9EeImNrCl31+2HmDuCulDw4DcvMN8sEz993TA/333QJzM3cTLeKIesE3YvKZ
         JmDjZFlDHXsRrBXSRrPbe5WznxyV+HkgcH/nd9MFaFxx6r2ZYNj7mBomhevAURpeIQbL
         pPWmHLYe9dcbZCfPDcwdCAr6OX7+9ssegoFbjD1wBkmQXzwpD7gUG65ZugS3GMK7Bvy+
         v7NnoaUxkKrq8jUxUSk6cAvxNbdDvONmxG0sA8LAF1aNIgInTQE5cAYqbCSzMHcc2N8s
         GpFAzICvZ8KpsQVAX8dvos0pLbQ1irQ5GnJtTUSQ0mtsGMjRclMmp2BtMYbWCT70wulG
         /YXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=OXAN55UXbgVOPmqR+PQwQUEvH96OvESTKa1SLY1IYkE=;
        b=HUZrzSd3aCYCVcwpf7Tkc9fKrycP+pheoXgCu33H/HpHyeFAjkE1OZ30kG7QIvb3KW
         TDS1dwp47+5E32C1r3Vxj5qW+95T+gwpjewenI8RnXuAEhn/S8K5EUHlSly7bdO/T7o6
         upjj+eNuqjaFnrhs8yvlSGmR2kXobKD49bbSxMxYWk7SKGkYsb4WNISQeR2t38S+e/gd
         BMQax4LltWXZnNZWuiJuD9wj5yi0RjcvH3lqTfNfatNPkwztXSre19vwJ0bmpulrlvOq
         mRd6Y3PY/nqxoME6K6rttSNZIo7RQKxJr53QgeapIomOFnHONV26OkfuNrZmM1bm+9Qe
         QiLw==
X-Gm-Message-State: AOAM531niSTb9SFcvBWNv136JoNmZNV4z8j0Hv82LsW2NOqYD5YDK94A
        mXbwNwhAMrLrDLuror1qaqTQMG98Hhg=
X-Google-Smtp-Source: ABdhPJxobZXi1f0ALRx6BMfgy9d9/nrDzyWrq1XblcgDutP6QYf2xRRtS+2P7UGBoMi9djmSfqvO5w==
X-Received: by 2002:a1c:7c09:: with SMTP id x9mr8899302wmc.98.1609356415781;
        Wed, 30 Dec 2020 11:26:55 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j2sm32597176wrh.78.2020.12.30.11.26.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Dec 2020 11:26:55 -0800 (PST)
Message-Id: <f727880add6e0380248279e1ad79f80762868a6c.1609356413.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.829.git.1609356413.gitgitgadget@gmail.com>
References: <pull.829.git.1609356413.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 30 Dec 2020 19:26:46 +0000
Subject: [PATCH 1/8] tree-walk: report recursion counts
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The traverse_trees() method recusively walks through trees, but also
prunes the tree-walk based on a callback. Some callers, such as
unpack_trees(), are quite complicated and can have wildly different
performance between two different commands.

Create constants that count these values and then report the results at
the end of a process. These counts are cumulative across multiple "root"
instances of traverse_trees(), but they provide reproducible values for
demonstrating improvements to the pruning algorithm when possible.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 tree-walk.c    | 33 +++++++++++++++++++++++++++++++++
 unpack-trees.c |  1 -
 2 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/tree-walk.c b/tree-walk.c
index 0160294712b..2d6226d5f18 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -4,6 +4,7 @@
 #include "object-store.h"
 #include "tree.h"
 #include "pathspec.h"
+#include "json-writer.h"
 
 static const char *get_mode(const char *str, unsigned int *modep)
 {
@@ -167,6 +168,25 @@ int tree_entry_gently(struct tree_desc *desc, struct name_entry *entry)
 	return 1;
 }
 
+static int traverse_trees_atexit_registered;
+static int traverse_trees_count;
+static int traverse_trees_cur_depth;
+static int traverse_trees_max_depth;
+
+static void trace2_traverse_trees_statistics_atexit(void)
+{
+	struct json_writer jw = JSON_WRITER_INIT;
+
+	jw_object_begin(&jw, 0);
+	jw_object_intmax(&jw, "traverse_trees_count", traverse_trees_count);
+	jw_object_intmax(&jw, "traverse_trees_max_depth", traverse_trees_max_depth);
+	jw_end(&jw);
+
+	trace2_data_json("traverse_trees", the_repository, "statistics", &jw);
+
+	jw_release(&jw);
+}
+
 void setup_traverse_info(struct traverse_info *info, const char *base)
 {
 	size_t pathlen = strlen(base);
@@ -180,6 +200,11 @@ void setup_traverse_info(struct traverse_info *info, const char *base)
 	info->namelen = pathlen;
 	if (pathlen)
 		info->prev = &dummy;
+
+	if (trace2_is_enabled() && !traverse_trees_atexit_registered) {
+		atexit(trace2_traverse_trees_statistics_atexit);
+		traverse_trees_atexit_registered = 1;
+	}
 }
 
 char *make_traverse_path(char *path, size_t pathlen,
@@ -416,6 +441,12 @@ int traverse_trees(struct index_state *istate,
 	int interesting = 1;
 	char *traverse_path;
 
+	traverse_trees_count++;
+	traverse_trees_cur_depth++;
+
+	if (traverse_trees_cur_depth > traverse_trees_max_depth)
+		traverse_trees_max_depth = traverse_trees_cur_depth;
+
 	if (n >= ARRAY_SIZE(entry))
 		BUG("traverse_trees() called with too many trees (%d)", n);
 
@@ -515,6 +546,8 @@ int traverse_trees(struct index_state *istate,
 	free(traverse_path);
 	info->traverse_path = NULL;
 	strbuf_release(&base);
+
+	traverse_trees_cur_depth--;
 	return error;
 }
 
diff --git a/unpack-trees.c b/unpack-trees.c
index 323280dd48b..02f484604ac 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1559,7 +1559,6 @@ static void populate_from_existing_patterns(struct unpack_trees_options *o,
 	free(sparse);
 }
 
-
 static int verify_absent(const struct cache_entry *,
 			 enum unpack_trees_error_types,
 			 struct unpack_trees_options *);
-- 
gitgitgadget

