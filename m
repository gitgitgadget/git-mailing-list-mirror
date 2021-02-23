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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 819D1C433DB
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 20:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 501DB64E6B
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 20:16:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234224AbhBWUQn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Feb 2021 15:16:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233097AbhBWUP4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Feb 2021 15:15:56 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A2C2C061574
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 12:14:37 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id n4so23884889wrx.1
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 12:14:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=NqEYBl1g3sJlE+XWYlzSJZj6ZnwcBPsZfNGC9XtLscY=;
        b=NEtYO08GkHe20xAIN8ZqH+xiRps7GTjS2PUlcnTqG+hNIWNJourNptQgRc7iARV8JH
         MJa5iseLfKLl3x0GZsNg00SAo9cxvFqMIdpXlgmdhZeXzE4u3L0DF2BVBbuCLwICa9/u
         F/fsD05qWeUsS2PVQB4k7rLU6GyXxgmIIwR3fC5oGRcJPpq/LM+RZMv1I7oWVTU0JD3Y
         rLAErxgdFM4c2ml4pTPWAjHyd4BcIDL119vlaFIZwydDFxQrhrzyWcnZZojg28zKv2Nc
         vw/KaUC6M4kcw7Osq2cwdetZbLb9oeZrFm00iuXtJCjn4+rTSJeA0MI9qJHhsF+4vR77
         cSfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=NqEYBl1g3sJlE+XWYlzSJZj6ZnwcBPsZfNGC9XtLscY=;
        b=HCG2x635UXEmAFLGNgvMLAMdcz0r63+T+uZxHMjAE5dptB8f5cNbcd5t7UsU/OCpFE
         tXeT/mwYLzFJSoGiUjHEL2jOHISQA3Vxux45vFF/SwaMfEWMQfcBnp5gmjeSgM+Fftb0
         OFc6lMvXiPmy2dACR7OqmiI+OBeVz7s9UO8k7H9idOH8GXPES7SIl48JPRLLx+DUTMRk
         GaCmKmc4otF6i8PbwQs7XCuQwt01skzByimOb7SyonlqKOJIry0oObzrN5gA5fQBnAmv
         pf9QdyB3K9N04DB4rR4M5nPXMD4fBavUgBP6sZsirGLyENcqsZ6uRLfIkBEbshFBwWPC
         Ytbw==
X-Gm-Message-State: AOAM5313651RkkAiVe443ODa+3tbEO7v8Aq5EUJD73A1BESX2jZeem5+
        ulyUHWEANXOL/fDVStaLH4Fzewl8QvQ=
X-Google-Smtp-Source: ABdhPJz6zJ1mA5B+QuI2v8LamW1Fzm+8BNVZW6wivkp3NP6H231NPZ5ULlVMSCjaVmPEFUjbtYyVQA==
X-Received: by 2002:adf:c101:: with SMTP id r1mr28287700wre.38.1614111276027;
        Tue, 23 Feb 2021 12:14:36 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s23sm3588639wmc.29.2021.02.23.12.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 12:14:35 -0800 (PST)
Message-Id: <94373e2bfbbcdef85f3e9389e6239a44d3d0a598.1614111270.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.883.git.1614111270.gitgitgadget@gmail.com>
References: <pull.883.git.1614111270.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 23 Feb 2021 20:14:17 +0000
Subject: [PATCH 08/20] test-tool: don't force full index
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com, pclouds@gmail.com,
        jrnieder@gmail.com, Derrick Stolee <derrickstolee@github.com>,
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
index e4c3492f7d3e..4780429dca6b 100644
--- a/t/helper/test-read-cache.c
+++ b/t/helper/test-read-cache.c
@@ -1,6 +1,7 @@
 #include "test-tool.h"
 #include "cache.h"
 #include "config.h"
+#include "sparse-index.h"
 
 static void print_cache_entry(struct cache_entry *ce)
 {
@@ -30,13 +31,19 @@ int cmd__read_cache(int argc, const char **argv)
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
@@ -46,6 +53,10 @@ int cmd__read_cache(int argc, const char **argv)
 
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

