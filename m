Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE9CC4332E
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 16:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72E936510E
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 16:44:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238921AbhCPQny (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 12:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238870AbhCPQnM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 12:43:12 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115B0C061756
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 09:43:12 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 12so5446712wmf.5
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 09:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=3o+t5/dOGp5xpMAAQd/XUzGtlCJPY6SPrX9Z+uQ/DZ4=;
        b=fiJGxPqaOAGHbyhFsicEQnzJTTx04cxqYN6OrfyAt9CnDg7CbMU7BSYxHRqnM8PAgo
         Mf/qbZ+qaMb3yuyssWmqQ9MhP3B7F1QL4uhU2EgvNPdwjoiJLF4fPW/yZ1F4g7SyipS3
         ZIfjzw2HWk1At9MvBR8fLxuVl314NPmgI9e71iuk0wVaLA/d7XW3IcJAj93Jd6zlJ6HA
         fU6nR0zKUkFVpeOO3yqL6BZnGLlbYOiYWw1+EKRlT3IrhDv50HudmPcjW4YcIb9ZJlM7
         NTo/0u8XqENagGGihv60iVzH+fqXhulLDnnb+w2l3RDq6PsBp/hfZm0FT+QSyuyynw26
         7C0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=3o+t5/dOGp5xpMAAQd/XUzGtlCJPY6SPrX9Z+uQ/DZ4=;
        b=QveiO6PBpbaSxxtPV7upXWBd7jG8L81srGnhVLfo3SkY/P6vn3+NDfTbV025sqNEj1
         kyyWduNgbxOf4EIA18UP5i6WLWvkLz6mXnusBW+7Ka3v8yWogPDJF4T6ahE+3Ibj5xA5
         Iy3jrh2XhZMGZ6y+FBXqynK3lyFTh9Um7C6MSXB0u0WmhdNonleyDtseaiCORUpfh20+
         064SO2gyucSg/6jRdoU49c/f6KEe2rygqQLGFwLfq2tfn8BAaOKYR0sOs3UBxg39ziEi
         P9jnVXmoZ6nWDeO77DS/a0y2KybyTAHQeimMYA9pDJQiUVngxfHeU7a6SIoV+BZqN0e7
         kiJw==
X-Gm-Message-State: AOAM532+KOp8K8Eyaan7GUe50++2kP1846iXKZVIAZJSzStXWFQYW6QM
        9I1/1BrE2Gm+5RQHOXdx34cZoR7xiFI=
X-Google-Smtp-Source: ABdhPJyrundPj64HcUtHQNsC7Ma+Fa/hOfT63+ky5wWcfDruOBlZVkr8DHkUiUV4JxN0MKbiS5R0AQ==
X-Received: by 2002:a7b:c3c1:: with SMTP id t1mr464503wmj.47.1615912990906;
        Tue, 16 Mar 2021 09:43:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c2sm28778wmr.22.2021.03.16.09.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 09:43:10 -0700 (PDT)
Message-Id: <f4ad081f25bb2760937e3f64aba80aa1455a8e17.1615912983.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.883.v3.git.1615912983.gitgitgadget@gmail.com>
References: <pull.883.v2.git.1615404664.gitgitgadget@gmail.com>
        <pull.883.v3.git.1615912983.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 16 Mar 2021 16:42:51 +0000
Subject: [PATCH v3 08/20] test-tool: don't force full index
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com, pclouds@gmail.com,
        jrnieder@gmail.com,
        Martin =?UTF-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

We will use 'test-tool read-cache --table' to check that a sparse
index is written as part of init_repos. Since we will no longer always
expand a sparse index into a full index, add an '--expand' parameter
that adds a call to ensure_full_index() so we can compare a sparse index
directly against a full index, or at least what the in-memory index
looks like when expanded in this way.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/helper/test-read-cache.c               | 13 ++++++++++++-
 t/t1092-sparse-checkout-compatibility.sh |  5 +++++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/t/helper/test-read-cache.c b/t/helper/test-read-cache.c
index 6cfd8f2de71c..b52c174acc7a 100644
--- a/t/helper/test-read-cache.c
+++ b/t/helper/test-read-cache.c
@@ -4,6 +4,7 @@
 #include "blob.h"
 #include "commit.h"
 #include "tree.h"
+#include "sparse-index.h"
 
 static void print_cache_entry(struct cache_entry *ce)
 {
@@ -35,13 +36,19 @@ int cmd__read_cache(int argc, const char **argv)
 	struct repository *r = the_repository;
 	int i, cnt = 1;
 	const char *name = NULL;
-	int table = 0;
+	int table = 0, expand = 0;
+
+	initialize_the_repository();
+	prepare_repo_settings(r);
+	r->settings.command_requires_full_index = 0;
 
 	for (++argv, --argc; *argv && starts_with(*argv, "--"); ++argv, --argc) {
 		if (skip_prefix(*argv, "--print-and-refresh=", &name))
 			continue;
 		if (!strcmp(*argv, "--table"))
 			table = 1;
+		else if (!strcmp(*argv, "--expand"))
+			expand = 1;
 	}
 
 	if (argc == 1)
@@ -51,6 +58,10 @@ int cmd__read_cache(int argc, const char **argv)
 
 	for (i = 0; i < cnt; i++) {
 		repo_read_index(r);
+
+		if (expand)
+			ensure_full_index(r->index);
+
 		if (name) {
 			int pos;
 
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index de5d8461c993..a1aea141c62c 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -130,6 +130,11 @@ test_sparse_match () {
 	test_cmp sparse-checkout-err sparse-index-err
 }
 
+test_expect_success 'expanded in-memory index matches full index' '
+	init_repos &&
+	test_sparse_match test-tool read-cache --expand --table
+'
+
 test_expect_success 'status with options' '
 	init_repos &&
 	test_all_match git status --porcelain=v2 &&
-- 
gitgitgadget

