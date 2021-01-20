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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 069F8C433E6
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 16:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC7AE23358
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 16:56:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391172AbhATQ4k (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jan 2021 11:56:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404074AbhATQzZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jan 2021 11:55:25 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4458C0613ED
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 08:54:07 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id a9so20318585wrt.5
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 08:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=i6bsGcr92iaw2mbWyW6jBWtwOPrpstDD1S5j/W6nyDk=;
        b=V6J0VdCg0SdbYsVY/74XrPGltkO6yn2R4aA+fElsY1fyARaAdhk1CConUuSJdkptpE
         FVfbeHlHNpbrmgMqt5hFsMcG1yxX0sc4ciYrr9+Xi+iPv41VSC6F6/N/p7ReHZTZL8f5
         aeHaG37L+U4TooLPT/uA7Ki9SZwAcqahn4ENPUUqk1me2LBY/BIkB9ByctcGyYG6irHv
         ateqlLJzhTnP7Lb7e0tivWJx/Sx1zSM0gANQogl05jzzpK9Z5A8ooIFPU7540Mvlv9L8
         Zbt3JIQPBxy2S3VyJl3zdO6i3spdYfjp+1wKpHFi9/DzRuzvQ1qp5xWIAnfWTdoZ6htY
         FPMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=i6bsGcr92iaw2mbWyW6jBWtwOPrpstDD1S5j/W6nyDk=;
        b=JWNvvlazwmhNFmLNPXrzlqAS83wWDZLTROzFscpWS4vNSERt6pzEv8rTv1hO2yty8Q
         Td/LRLLQIfoZUARk610X+uvx/PA4ypLQFBHkOm/Sx4qbcipan0T4u1bleTIAMa3/WhzV
         4HPgzY0VvPZEcL0Yc0jkQF7fGGHt2Ly/KP+iTS5KmOFNyey3sfg61UoN9b1QzFhAgn+2
         s2uu6dILfcfR1I6OxddXMDwtqVbLeYkPaFcz1YcjyU8k+OEZpuyXJ2IufJiFnck3C2cX
         wB0nx52ddkJ9NpIirRrGvnnpL+m9/2mRjqw1ohdlmbcJjczyuyp4XT7/zHOVqlWX/1Ms
         JQzw==
X-Gm-Message-State: AOAM533OC/X9MlupGYW/ZRW/1QatzrhZA+XYOnd1RKvJehr5q1IYKAmy
        551ua/37iDKCWRl2f+o6zj8FeBkGpTA=
X-Google-Smtp-Source: ABdhPJxPdCeAiw+33U+iC4+YRDkP9Mjez8u2qHIwI+nCnwONDl+o82lezByBWtDdiCFSahklXtiVtQ==
X-Received: by 2002:adf:fbc5:: with SMTP id d5mr10198899wrs.82.1611161646365;
        Wed, 20 Jan 2021 08:54:06 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m2sm4729750wml.34.2021.01.20.08.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 08:54:05 -0800 (PST)
Message-Id: <64358ec7ea2b3df4a8f1099452579a7568996921.1611161639.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.839.git.1611161639.gitgitgadget@gmail.com>
References: <pull.839.git.1611161639.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 20 Jan 2021 16:53:56 +0000
Subject: [PATCH 6/9] sparse-checkout: load sparse-checkout patterns
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

A future feature will want to load the sparse-checkout patterns into a
pattern_list, but the current mechanism to do so is a bit complicated.
This is made difficult due to needing to find the sparse-checkout file
in different ways throughout the codebase.

The logic implemented in the new get_sparse_checkout_patterns() was
duplicated in populate_from_existing_patterns() in unpack-trees.c. Use
the new method instead, keeping the logic around handling the struct
unpack_trees_options.

The callers to get_sparse_checkout_filename() in
builtin/sparse-checkout.c manipulate the sparse-checkout file directly,
so it is not appropriate to replace logic in that file with
get_sparse_checkout_patterns().

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/sparse-checkout.c |  5 -----
 dir.c                     | 17 +++++++++++++++++
 dir.h                     |  2 ++
 unpack-trees.c            |  6 +-----
 4 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index e3140db2a0a..2306a9ad98e 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -22,11 +22,6 @@ static char const * const builtin_sparse_checkout_usage[] = {
 	NULL
 };
 
-static char *get_sparse_checkout_filename(void)
-{
-	return git_pathdup("info/sparse-checkout");
-}
-
 static void write_patterns_to_file(FILE *fp, struct pattern_list *pl)
 {
 	int i;
diff --git a/dir.c b/dir.c
index d637461da5c..d153a63bbd1 100644
--- a/dir.c
+++ b/dir.c
@@ -2998,6 +2998,23 @@ void setup_standard_excludes(struct dir_struct *dir)
 	}
 }
 
+char *get_sparse_checkout_filename(void)
+{
+	return git_pathdup("info/sparse-checkout");
+}
+
+int get_sparse_checkout_patterns(struct pattern_list *pl)
+{
+	int res;
+	char *sparse_filename = get_sparse_checkout_filename();
+
+	pl->use_cone_patterns = core_sparse_checkout_cone;
+	res = add_patterns_from_file_to_list(sparse_filename, "", 0, pl, NULL);
+
+	free(sparse_filename);
+	return res;
+}
+
 int remove_path(const char *name)
 {
 	char *slash;
diff --git a/dir.h b/dir.h
index a3c40dec516..facfae47402 100644
--- a/dir.h
+++ b/dir.h
@@ -448,6 +448,8 @@ int is_empty_dir(const char *dir);
 
 void setup_standard_excludes(struct dir_struct *dir);
 
+char *get_sparse_checkout_filename(void);
+int get_sparse_checkout_patterns(struct pattern_list *pl);
 
 /* Constants for remove_dir_recursively: */
 
diff --git a/unpack-trees.c b/unpack-trees.c
index af6e9b9c2fd..837b8bb42fb 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1549,14 +1549,10 @@ static void mark_new_skip_worktree(struct pattern_list *pl,
 static void populate_from_existing_patterns(struct unpack_trees_options *o,
 					    struct pattern_list *pl)
 {
-	char *sparse = git_pathdup("info/sparse-checkout");
-
-	pl->use_cone_patterns = core_sparse_checkout_cone;
-	if (add_patterns_from_file_to_list(sparse, "", 0, pl, NULL) < 0)
+	if (get_sparse_checkout_patterns(pl) < 0)
 		o->skip_sparse_checkout = 1;
 	else
 		o->pl = pl;
-	free(sparse);
 }
 
 
-- 
gitgitgadget

