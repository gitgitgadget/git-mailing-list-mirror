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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78310C4361B
	for <git@archiver.kernel.org>; Sun, 13 Dec 2020 08:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E9A722D72
	for <git@archiver.kernel.org>; Sun, 13 Dec 2020 08:08:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404010AbgLMIHm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Dec 2020 03:07:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394077AbgLMIGe (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Dec 2020 03:06:34 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D79C0611CF
        for <git@vger.kernel.org>; Sun, 13 Dec 2020 00:04:48 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id g25so7095196wmh.1
        for <git@vger.kernel.org>; Sun, 13 Dec 2020 00:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=i7qANtG3qXKjHjlGq/JcCBpxVy3gkdyUMbD2qpW2pBQ=;
        b=CFvC4g/FOvzE6bnXdsxtJHLJfu7Kg0MiqKhrqZcwz9kR4P0Wktt4PDXYMS7UMGNeSM
         3QmsW26hEDGOG+RmxJb+jt5VK1bqkq2R5iCzZ1RerlQhAxXIleHnzUoiippTJqzyKiqO
         ptILAlt9XtTSoGUHWWJ+oUw+/X9Z4a6K9jf9cTy2Nd4jaqrJ/DE0hyZ3+ytha6p3N5Kb
         mBIb5gBoTESitGPimsKYhDJPxHwd+ImxORqBQKG7TPqzM+YuOgVnJlIYL8SQ8L6gEy19
         nrqVUIJTOb4VSvAf3w6SRV1FCY3FohyToOb220J6q2sQbJ6R8eJEBd0vYIa5bLGURIQN
         OZlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=i7qANtG3qXKjHjlGq/JcCBpxVy3gkdyUMbD2qpW2pBQ=;
        b=gWXuKVU6GnZNqn3nlHNPZhOGYZRAY1GmsA6IpLtDXHpE9IFJvOpzd0wC8GW+ybGHIS
         yo/8rqQb8Ehpd/JQOBamLH/4bhFejSrU0iGF4ECwg2ekN85fLGoHDO8zbiD8mPBMHnyD
         Uc36riYuCCt+hkPycHxK+F0VnEglYRsw8WrfyWEd3QceJEFrBt1dvuN/Ue8CSFZXDTAr
         SPuhsjbnk8zKN+bpZe+uPu9GEpoTH06NkEpLjkZTyS2XyS8xtDjbBPjuUL5DLmK+O2yP
         nzp45Ni3IWwToMwenWZ4ACl4eO6Ax6T6jRedtFJ4BlLoadbT4Cn8CB0D9y/yOAyLxXlk
         TfqQ==
X-Gm-Message-State: AOAM533Zm0rpLmjJlZ/c5XN82nF6uWpQ7y+XZl57YsV2spwWf3+05BN0
        kHERbkr2NuuFne1bdPKUhuHav+JZmU8=
X-Google-Smtp-Source: ABdhPJx89g2dkiTEnGxJXxWJhHDecrot+7M+80SSZ3Po7KmPjjoU9eMYTennwSdsxwkJpp+5qgN4rg==
X-Received: by 2002:a1c:bd43:: with SMTP id n64mr22099196wmf.169.1607846686986;
        Sun, 13 Dec 2020 00:04:46 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r82sm24105514wma.18.2020.12.13.00.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Dec 2020 00:04:46 -0800 (PST)
Message-Id: <55451a79eecf984d7adf54a324378227ea95e9d6.1607846667.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.923.v3.git.git.1607846667.gitgitgadget@gmail.com>
References: <pull.923.v2.git.git.1607114890.gitgitgadget@gmail.com>
        <pull.923.v3.git.git.1607846667.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 13 Dec 2020 08:04:27 +0000
Subject: [PATCH v3 20/20] merge-ort: free data structures in merge_finalize()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, dstolee@microsoft.com,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/merge-ort.c b/merge-ort.c
index 47cd772e805..51b049358e4 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -209,6 +209,16 @@ struct conflict_info {
 	assert((ci) && !(mi)->clean);        \
 } while (0)
 
+static void free_strmap_strings(struct strmap *map)
+{
+	struct hashmap_iter iter;
+	struct strmap_entry *entry;
+
+	strmap_for_each_entry(map, &iter, entry) {
+		free((char*)entry->key);
+	}
+}
+
 static int err(struct merge_options *opt, const char *err, ...)
 {
 	va_list params;
@@ -1153,7 +1163,27 @@ void merge_switch_to_result(struct merge_options *opt,
 void merge_finalize(struct merge_options *opt,
 		    struct merge_result *result)
 {
-	die("Not yet implemented");
+	struct merge_options_internal *opti = result->priv;
+
+	assert(opt->priv == NULL);
+
+	/*
+	 * We marked opti->paths with strdup_strings = 0, so that we
+	 * wouldn't have to make another copy of the fullpath created by
+	 * make_traverse_path from setup_path_info().  But, now that we've
+	 * used it and have no other references to these strings, it is time
+	 * to deallocate them.
+	 */
+	free_strmap_strings(&opti->paths);
+	strmap_clear(&opti->paths, 1);
+
+	/*
+	 * All keys and values in opti->conflicted are a subset of those in
+	 * opti->paths.  We don't want to deallocate anything twice, so we
+	 * don't free the keys and we pass 0 for free_values.
+	 */
+	strmap_clear(&opti->conflicted, 0);
+	FREE_AND_NULL(opti);
 }
 
 static void merge_start(struct merge_options *opt, struct merge_result *result)
-- 
gitgitgadget
