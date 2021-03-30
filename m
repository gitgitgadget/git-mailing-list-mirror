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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF25DC433E8
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 13:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 929BD61994
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 13:12:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232246AbhC3NLo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Mar 2021 09:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232135AbhC3NLP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Mar 2021 09:11:15 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A457C0613DB
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 06:11:14 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id v11so16161486wro.7
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 06:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=3o+t5/dOGp5xpMAAQd/XUzGtlCJPY6SPrX9Z+uQ/DZ4=;
        b=lltXkex0f+N5vdT0LbJu8Bol/t1IXEI7EA5wSjwp1wF8KCTobhPkci0sJbKWO3F9y/
         0jD5aqfnETuNiNHcD0sGsfMbBad39gUGYEG6spGEff9rNx24m+9f9Qq1CVgKH8eIfNvc
         Xdv7q7EG4iaRXEUI3SUGijwNEtvyTZW35gkYdz5a7+GThkwQb/1fyJoDsOqndyMTP+XG
         xG+S4BRw6keaaANTMinWZKsdVkxTLIDvl3nGvvnXJ5yQDe5IAsGvy/egmSmxFJvszKsl
         wqvhJU02INOy1NVM+Mu/ftLkVKSlplAdycKj0sLcy3MwnFhH8k6k1iicym5iPOfGcVst
         UKyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=3o+t5/dOGp5xpMAAQd/XUzGtlCJPY6SPrX9Z+uQ/DZ4=;
        b=mR+9ViWxjWJ7ZoZUS2NECAakOEjpImdwWjACYt/JJ1/tzdBYX4m2Y971iQANMGsU/Z
         2RwejjW/mitaTqwWdUPj+RZOT/TYh7I76x79tUgXUVNrIQCZ+gwPGM9GABULnjdRqJ6f
         oYvjqYD18HurncBjqUEMHKvmVK4wq+Y85prjuEu5RQPj/aiFEiF5gxfL1Ei5sMvCf3XS
         91/m5akesvarNy2sq5uWi7goVRLEz2bENufGJiC5J/lhwyma+Zis0a3sT+u6fGiVIyLv
         wFRva4aStpTKHIVaHfVgNUo+JaWJqa63qiB6wfTvrhibkzreLmfaBDQ+IhxDqwcyQZGi
         Xijg==
X-Gm-Message-State: AOAM530ssquhUnheRLcqzlqv3mLTmNHhbuxn/16K0BG4ODUkBGNWjfGX
        R0lQpmiXf5F1PgQR0aIi8CT3BVvCv08=
X-Google-Smtp-Source: ABdhPJx2BfdrzJn1iRDtoTtmccPHBizHgtfS32zSlUNLUWwWKvRgqRXVBo0OgNOOtGxlKeZTBcok1Q==
X-Received: by 2002:adf:d1e3:: with SMTP id g3mr34240078wrd.195.1617109873034;
        Tue, 30 Mar 2021 06:11:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o62sm5307691wmo.3.2021.03.30.06.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 06:11:12 -0700 (PDT)
Message-Id: <dd84a2a9121b52c4b9bf0a52d6e52f3e40075c6f.1617109864.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.883.v5.git.1617109864.gitgitgadget@gmail.com>
References: <pull.883.v4.git.1616507069.gitgitgadget@gmail.com>
        <pull.883.v5.git.1617109864.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 30 Mar 2021 13:10:51 +0000
Subject: [PATCH v5 08/21] test-tool: don't force full index
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

