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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F14D5C4338F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 21:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDA346127B
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 21:52:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236828AbhHXVwt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 17:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236513AbhHXVwk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 17:52:40 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32C69C0612E7
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 14:51:54 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id d22-20020a1c1d16000000b002e7777970f0so2848194wmd.3
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 14:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=uirt+/Fd9vyJ7GknotIoX/RPYOmGJD0KnjJarGrZ0yQ=;
        b=V9lhlbwBjJ/x2bBL7TW9vTa+7sWTlgz4oag0sDK1UEjrq9qn4BZ5d2tzdVntKaWAIJ
         X164Xq3jYrC0QN4eRX3h2zyxFm6ndxm3bRzE94HuK1vppmdRiXkT6H0A4vxqZ4gt1HY4
         qKq/uugdzLC72MzRMo7yJvcnVQVT8NMOQ15bBPwrGIQZu21Wj1oaFDwH8/I/3Xvz7cVJ
         6sluToZJ3JIZmVBBpaftuiPYaiUcToVxGqEbLYRRZBABhjZezIcc2C1NCbkiqeEy8Vdg
         R2eKs7oj22V7Oh93+jEnxn5kDlUAi69UPxzWkUy2Mz19NLEAlTwsUCtnBJGlW+uHvSJ/
         qJ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=uirt+/Fd9vyJ7GknotIoX/RPYOmGJD0KnjJarGrZ0yQ=;
        b=BnnbgF391cfIZr/Mi4PFxD18Vi0QTI5p24NKWgWSHnT1luBpATaKusA+pG73Oe9h9M
         QTS6S0BTmV9O1qPl6iN9dBD8tHbKBzGk+Gg0/26P5AMg2ftzDhr1sIoaOH+X6yi5RQ0R
         eas2G0Dexemf8Ms8k3ijhAPf1Zrzwj7MRpWnBBOzQOQGTSvqb+KuLv2oq55GWWyB5cRE
         6zhSfBUhOvgR+d9PoWXGRmLJaOeWcfb6f0XBliA7vmzgxry/tKopoP1XlQGcJuTvOGYA
         SaBKdycoD6dBkGFRUuX7C18H/8W0pibVfR/uKwSHI2lPlMovyODWUrCS5W9x+mS/SsqS
         nClw==
X-Gm-Message-State: AOAM531jCxmRdLngK9KEm5/3c93hDi/wRRChL+CsC72XoOEUUyFd8X1I
        3UbU58T4OgZDtPC6MTud+PU+JtY9yPA=
X-Google-Smtp-Source: ABdhPJwR/2OCx5+XmycwRbTDKbn8xK2F9s7T7jNOIyCz5rCdQchvo0WGYAiqLEO+CO4eSy3K61c6mA==
X-Received: by 2002:a05:600c:1911:: with SMTP id j17mr5966958wmq.164.1629841912813;
        Tue, 24 Aug 2021 14:51:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p12sm3098607wmq.44.2021.08.24.14.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 14:51:52 -0700 (PDT)
Message-Id: <8d55a6ba2fdf64cee4eb51f3cb6f9808bd0b7505.1629841904.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1009.v4.git.1629841904.gitgitgadget@gmail.com>
References: <pull.1009.v3.git.1629206602.gitgitgadget@gmail.com>
        <pull.1009.v4.git.1629841904.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 24 Aug 2021 21:51:44 +0000
Subject: [PATCH v4 10/10] sparse-checkout: add config to disable deleting dirs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com, matheus.bernardino@usp.br,
        stolee@gmail.com, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The clean_tracked_sparse_directories() method deletes the tracked
directories that go out of scope when the sparse-checkout cone changes,
at least in cone mode. This is new behavior, but is recommended based on
our understanding of how users are interacting with the feature in most
cases.

It is possible that some users will object to the new behavior, so
create a new configuration option 'index.deleteSparseDirectories' that
can be set to 'false' to make clean_tracked_sparse_directories() do
nothing. This will keep all untracked files in the working tree and
cause performance problems with the sparse index, but those trade-offs
are for the user to decide.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/config/index.txt     | 6 ++++++
 builtin/sparse-checkout.c          | 9 ++++++++-
 t/t1091-sparse-checkout-builtin.sh | 4 ++++
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/Documentation/config/index.txt b/Documentation/config/index.txt
index 75f3a2d1054..c65da20a931 100644
--- a/Documentation/config/index.txt
+++ b/Documentation/config/index.txt
@@ -1,3 +1,9 @@
+index.deleteSparseDirectories::
+	When enabled, the cone mode sparse-checkout feature will delete
+	directories that are outside of the sparse-checkout cone, unless
+	such a directory contains an untracked, non-ignored file. Defaults
+	to true.
+
 index.recordEndOfIndexEntries::
 	Specifies whether the index file should include an "End Of Index
 	Entry" section. This reduces index load time on multiprocessor
diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index d0f5c4702be..33ec729d9de 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -102,7 +102,7 @@ static int sparse_checkout_list(int argc, const char **argv)
 
 static void clean_tracked_sparse_directories(struct repository *r)
 {
-	int i, was_full = 0;
+	int i, value, was_full = 0;
 	struct strbuf path = STRBUF_INIT;
 	size_t pathlen;
 	struct string_list_item *item;
@@ -118,6 +118,13 @@ static void clean_tracked_sparse_directories(struct repository *r)
 	    !r->index->sparse_checkout_patterns->use_cone_patterns)
 		return;
 
+	/*
+	 * Users can disable this behavior.
+	 */
+	if (!repo_config_get_bool(r, "index.deletesparsedirectories", &value) &&
+	    !value)
+		return;
+
 	/*
 	 * Use the sparse index as a data structure to assist finding
 	 * directories that are safe to delete. This conversion to a
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index 71236981e64..e0f31186d89 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -666,6 +666,10 @@ test_expect_success 'cone mode clears ignored subdirectories' '
 	git -C repo status --porcelain=v2 >out &&
 	test_must_be_empty out &&
 
+	git -C repo -c index.deleteSparseDirectories=false sparse-checkout reapply &&
+	test_path_is_dir repo/folder1 &&
+	test_path_is_dir repo/deep/deeper2 &&
+
 	git -C repo sparse-checkout reapply &&
 	test_path_is_missing repo/folder1 &&
 	test_path_is_missing repo/deep/deeper2 &&
-- 
gitgitgadget
