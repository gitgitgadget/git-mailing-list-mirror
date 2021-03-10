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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF83C433E6
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 19:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCF8064FD6
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 19:32:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233832AbhCJTbs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 14:31:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233698AbhCJTbO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 14:31:14 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86AE0C061760
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 11:31:13 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id c76-20020a1c9a4f0000b029010c94499aedso11801410wme.0
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 11:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=885NXYHQSJrIfN0vMfTm3RjnUPnYjurF/r5iiY1SF1A=;
        b=TEAtemQPoOV8zsZj3V8SUluiRIUvWultI6MMdlI6Do5/yA5H2n/W6Ng5Ad5JSYJeyB
         jZ3JPaSpVQDLOGmb+u6atRjO3WwijxdINQuD+bwF4syi9EwF1Yfeut/SFF+rPa0Dfo2J
         8N6QnhfnLcDo4h2vtsVxPC0665SCzc57rDh/pG0eA9F/uQvEmmdPMAvUbip7Z75Bn++h
         TizsbVqHdFinX91uSDK5NLchHBYMPHrjGsMaoA2/Rxgjb9qovxK18D20LvVYxJcexU21
         /NSRMM01dpIOZLpovcCnhx5u0dooCsAX/J/Nl77viF0sgYUXcAsWXgMxY/Uzrc1SeB4K
         b1dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=885NXYHQSJrIfN0vMfTm3RjnUPnYjurF/r5iiY1SF1A=;
        b=j3YOgD0YRz4hQtVkVVdGSvI2Nn6SEUFnaEXVtAz5l+RYEYnWm52yNtit4QfpuJe/G0
         jS6yIq2fZjvLx1ifhGyYP/gopKbjXYNOEAFdyAPQfQMB+5CYVhIUTVGm2eZfpiOPeZQj
         oThcaZLhhS7RUM3uapojavO1JtjaRLPWkqkJWO/NN+pYiCfR17rMgrylV90Y22RatlS/
         6XfEIIuhJRG6xEwRY0/H20rkSjhkjEaP2GWxSYM+EK2UJdObRKYGPLNEYdyLu3uv+36U
         OISoetk/hH9ghgbrZpjOWjanHpd3QMOl33goNYpDBJiwHeq7EmOrfVl4xOfT0o9h8uww
         rjyA==
X-Gm-Message-State: AOAM5305cxzYLvkvg/9WI1P+k3R49CXCDCF35jMRBRKArSfEu9QrhWpL
        beThIdJKfVldMSK2HbJ6hcPIcGdy/rM=
X-Google-Smtp-Source: ABdhPJzZ+8GCqPYzlFDozFbWVp+7YiJluH7hbiJK6CICtX5pF3Hb5EKKajmT5RIqUcHPTyYtKYc8KQ==
X-Received: by 2002:a1c:f203:: with SMTP id s3mr4818418wmc.152.1615404672374;
        Wed, 10 Mar 2021 11:31:12 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j26sm320332wrh.57.2021.03.10.11.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 11:31:12 -0800 (PST)
Message-Id: <243541fc5820572faa518dfc157175a72a7a9ea8.1615404665.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.883.v2.git.1615404664.gitgitgadget@gmail.com>
References: <pull.883.git.1614111270.gitgitgadget@gmail.com>
        <pull.883.v2.git.1615404664.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 10 Mar 2021 19:30:51 +0000
Subject: [PATCH v2 08/20] test-tool: don't force full index
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
        Derrick Stolee <derrickstolee@github.com>,
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
index 71d6f9e4c014..4d789fe86b9d 100755
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

