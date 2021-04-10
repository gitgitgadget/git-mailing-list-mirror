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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C48AC43462
	for <git@archiver.kernel.org>; Sat, 10 Apr 2021 02:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77D5961105
	for <git@archiver.kernel.org>; Sat, 10 Apr 2021 02:04:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233827AbhDJCEO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 22:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232796AbhDJCEL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 22:04:11 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E83C061765
        for <git@vger.kernel.org>; Fri,  9 Apr 2021 19:03:57 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id n11-20020a05600c4f8bb029010e5cf86347so6085372wmq.1
        for <git@vger.kernel.org>; Fri, 09 Apr 2021 19:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Llo0Of7xrxXb6L4qe3wjXKvb7OepjL9FntDDDajZ5Mw=;
        b=bfSy4e8C7QUX2KgsMixc2BGMKIsKmd0bn3Ff6HL4h725zawcxvVNPPn2l9lPwXfP0s
         vOO5FHrXEwZcUr+5fFgOt3U27zZyqq4CwwT4tqNYs7jLFMazwgyMJ6yKzHRKL2i9abY1
         HDA6HY9CkMV3guZU/lrLPGD89hmvj1FtMg4CWdDpxKAJF++OECBeTAzq2CqBZybrE3tr
         +kEieXf9+JLxdcBbuMkkhpQizho9yc53UyNFxw2YUo03kPyC8aCkLJWtRkTO2ZGNsBYH
         rqqwlfx42Y71EXDvt/Pt9Qz9lMxqnH4c5wRNXTlCPKlPvY9a1oWaFUTFi5CDQJdVwGAu
         BFuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Llo0Of7xrxXb6L4qe3wjXKvb7OepjL9FntDDDajZ5Mw=;
        b=cAHCBqk/zAyt7yMmTxwBAHAzCuD0sVCgVLvPDvkS6/HWPrrd0/MDzd5VcNxbmu8csI
         pMLy+2xv9w4xaTt8SvvDMfzHj1mDx9r6zn8ZI9nm0GWnyH6ngUu2zZfJJ/SmFchIuSdz
         ZpWXPImDMkx5xYskJ0M0jVrvkO8ARAqeQVRRqbxlVWJz31KyGZlFcsOGFXA4ujHLhHO7
         oky5mILgA8aETzqgEiyS2Ghd0pq2pPJX6irWwbDku/0rWFGE8BxXP8qeI9nnsYS2yjSe
         /CqqmivX8SP8bh83xXZcMn83dK3Y7/KhH1I14GdFGWHUgk4cUtBIqOeiogsxNsCq8QzY
         qfLA==
X-Gm-Message-State: AOAM531V9bf8ZFu3b9fHEH0yxJr5KWHlbymXW8E+JEt9e+oNuylDaVLD
        GCJv748lLp4j9sfF2S0G+oTOV6vY8Go=
X-Google-Smtp-Source: ABdhPJwXDpSyP3G4UDySc1bMqM5rCD8qOddf3G/sA2nvzS57uqEcBIViqn0/uYSPKXF0E+pHWJJOJQ==
X-Received: by 2002:a05:600c:21d1:: with SMTP id x17mr16081963wmj.3.1618020227680;
        Fri, 09 Apr 2021 19:03:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v14sm6883348wrd.48.2021.04.09.19.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 19:03:47 -0700 (PDT)
Message-Id: <4c0e983ba56f030851370ef71887117db45e8479.1618020225.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.924.v3.git.1618020225.gitgitgadget@gmail.com>
References: <pull.924.v2.git.1617734870.gitgitgadget@gmail.com>
        <pull.924.v3.git.1618020225.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 10 Apr 2021 02:03:43 +0000
Subject: [PATCH v3 1/3] maintenance: simplify prefetch logic
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     tom.saeger@oracle.com, gitster@pobox.com, sunshine@sunshineco.com,
        Derrick Stolee <stolee@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The previous logic filled a string list with the names of each remote,
but instead we could simply run the appropriate 'git fetch' data
directly in the remote iterator. Do this for reduced code size, but also
because it sets up an upcoming change to use the remote's refspec. This
data is accessible from the 'struct remote' data that is now accessible
in fetch_remote().

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/gc.c | 33 ++++++++-------------------------
 1 file changed, 8 insertions(+), 25 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index ef7226d7bca4..fa8128de9ae1 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -873,55 +873,38 @@ static int maintenance_task_commit_graph(struct maintenance_run_opts *opts)
 	return 0;
 }
 
-static int fetch_remote(const char *remote, struct maintenance_run_opts *opts)
+static int fetch_remote(struct remote *remote, void *cbdata)
 {
+	struct maintenance_run_opts *opts = cbdata;
 	struct child_process child = CHILD_PROCESS_INIT;
 
 	child.git_cmd = 1;
-	strvec_pushl(&child.args, "fetch", remote, "--prune", "--no-tags",
+	strvec_pushl(&child.args, "fetch", remote->name, "--prune", "--no-tags",
 		     "--no-write-fetch-head", "--recurse-submodules=no",
 		     "--refmap=", NULL);
 
 	if (opts->quiet)
 		strvec_push(&child.args, "--quiet");
 
-	strvec_pushf(&child.args, "+refs/heads/*:refs/prefetch/%s/*", remote);
+	strvec_pushf(&child.args, "+refs/heads/*:refs/prefetch/%s/*", remote->name);
 
 	return !!run_command(&child);
 }
 
-static int append_remote(struct remote *remote, void *cbdata)
-{
-	struct string_list *remotes = (struct string_list *)cbdata;
-
-	string_list_append(remotes, remote->name);
-	return 0;
-}
-
 static int maintenance_task_prefetch(struct maintenance_run_opts *opts)
 {
-	int result = 0;
-	struct string_list_item *item;
-	struct string_list remotes = STRING_LIST_INIT_DUP;
-
 	git_config_set_multivar_gently("log.excludedecoration",
 					"refs/prefetch/",
 					"refs/prefetch/",
 					CONFIG_FLAGS_FIXED_VALUE |
 					CONFIG_FLAGS_MULTI_REPLACE);
 
-	if (for_each_remote(append_remote, &remotes)) {
-		error(_("failed to fill remotes"));
-		result = 1;
-		goto cleanup;
+	if (for_each_remote(fetch_remote, opts)) {
+		error(_("failed to prefetch remotes"));
+		return 1;
 	}
 
-	for_each_string_list_item(item, &remotes)
-		result |= fetch_remote(item->string, opts);
-
-cleanup:
-	string_list_clear(&remotes, 0);
-	return result;
+	return 0;
 }
 
 static int maintenance_task_gc(struct maintenance_run_opts *opts)
-- 
gitgitgadget

