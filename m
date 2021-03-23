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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A3FEC433E9
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 13:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15BB5619BA
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 13:45:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231683AbhCWNpC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Mar 2021 09:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231673AbhCWNol (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Mar 2021 09:44:41 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 045C6C0613DD
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 06:44:39 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id d8-20020a1c1d080000b029010f15546281so10718560wmd.4
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 06:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=3o+t5/dOGp5xpMAAQd/XUzGtlCJPY6SPrX9Z+uQ/DZ4=;
        b=q5/GXqz8fE0GDjlPfyGY+fBiu+AoLJrWb1pFVh52sjAvU3nhwRrh8dBaCMasQAEGrf
         /weBeiAKuLAJlQ1mK11uAlMs/iDWxPeb/FBfH9//VQf/jzzs6QXj7lB0szx3MXeStcRL
         E8P9jsHiPewvAsJiufGeYY/1cwvhVSdxGnjh2wKKi+Kfn8JSdUkeakrCn8ucAGx8u2pk
         UWgJaEeAC+Lrldlrtr6RsU3jfl/dtd+B2/4fzg3roaECdkbhF1xl82o8HSxNwotJ0jhi
         3/QeeamOYlkyYKVpfGRP8ES6yR8/h8IsciG2GM25793z+qfCX92fDc25OxB6u7xAYfT1
         1YUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=3o+t5/dOGp5xpMAAQd/XUzGtlCJPY6SPrX9Z+uQ/DZ4=;
        b=d2AqijdldHvwwMoI0nM/c9ZNASa7zzYrWYxClxRbYtF4/j2sZkeWB88nzWhdL37s32
         EaXWAVoIoMuFYIE6IkE4Ze8fXhYMM+OYd80S9s70uMT9xulJ1gQdTAN+pMYSZqtafSil
         5CdFLjtzG6JD948tPKrwe2jKzUgVdyxUdOcOwMbkuqr1CjT9mjStK5BO30RVqTaHjbHv
         NRzIk/GdJsyppN8Hktul/8i8ib2wyYXkXwM8dCz6r5Q0mNIOUSyTIXTbY3rCn5IiGe8r
         278F+yAkgJAC+JYiXS+Z9kx5SBvBYpDbIFzPfBWFezaI43fMcaH/tcAYWYQXoKuqvHhZ
         eyLg==
X-Gm-Message-State: AOAM531Bnd5SWPF91h3VlgeNrEQ+cypjvag++g71JvnTl6zCiiyMEnSE
        VZRL67km6GO6Xe5qBbr5TPgRbhpqDv0=
X-Google-Smtp-Source: ABdhPJwnGi5ZKDDyB2vU4vWQmIs9WzLE2Xvt+hZROuRbZL+Ot2a3IEfSNlbDpg88SXffCCNNL+pHeA==
X-Received: by 2002:a1c:10f:: with SMTP id 15mr3554184wmb.14.1616507077803;
        Tue, 23 Mar 2021 06:44:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m11sm22132231wrz.40.2021.03.23.06.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 06:44:37 -0700 (PDT)
Message-Id: <db7bbd06dbcc8ddab7811887a510b160686e4321.1616507069.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.883.v4.git.1616507069.gitgitgadget@gmail.com>
References: <pull.883.v3.git.1615912983.gitgitgadget@gmail.com>
        <pull.883.v4.git.1616507069.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 23 Mar 2021 13:44:16 +0000
Subject: [PATCH v4 08/20] test-tool: don't force full index
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

