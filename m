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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5583DC433E6
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 13:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C7C52054F
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 13:06:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727923AbhAVNGg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jan 2021 08:06:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727497AbhAVNFj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jan 2021 08:05:39 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF9FC061797
        for <git@vger.kernel.org>; Fri, 22 Jan 2021 05:04:08 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id c124so4239851wma.5
        for <git@vger.kernel.org>; Fri, 22 Jan 2021 05:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=i6bsGcr92iaw2mbWyW6jBWtwOPrpstDD1S5j/W6nyDk=;
        b=pM2QzjPRufDyG510czEwrEfr++iizOLmzW+G47TjWKBqGmd1tsbu7dK9KF90bG5lQi
         4MshwBPwsHtiq24fs1y9OPQQQsl/yYBwGIdCpvG35MQ7bNKcKHIu/evJyX5emZpg6w7I
         Jfrjhi2H3zQAUpSVaOsjpxcBUBWAGwR8W36Eyws/wi/4osS3pYc6tyOFKEQ1jYxu1nVs
         VPo1A2gL2DKHvJy7ox3CLODQqYbzHcrmT0tI59fcrgmsLHYH/Wgur5yyKv9BH6rE/cwB
         mOLlQcwCFCCIdrPvDTnNO7PW825Thfk7cjw3sFR8p02XbnERndek9UmcW5CryDVb3Urk
         IweA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=i6bsGcr92iaw2mbWyW6jBWtwOPrpstDD1S5j/W6nyDk=;
        b=aFcYGHBA5CLPwuR5+Eyvl/6WboHEbp+4WQYYpwFXtlbzd4FTjI0+eLStRXc3j7TSfm
         p3oCpOmSzXVMnvBhPOUloBpVkeST05k9MeVJyMacS4c6HqwwJ1Mf/YXBeRRCZswcPDV4
         iyjqNcqmTfGuZ1FbyyOxFXFJ8Flr1EAzwGepa69ugaYL15MWqIiA91bVdqQ6p5Y+Nqhw
         YXBRLqyGfv23lJR45aO+M1+BoVmD+1gsdaYMbr1fctyu8aXewpZWdCq3eCMD5odb5HdB
         gIehtmXjUIKNpaFoJsRZhV8pUwsPKbf83hPcicnUbqgZccyP7Z2FaT7ewJe9HK9BFyc6
         tSnw==
X-Gm-Message-State: AOAM532pS/bkErfoWz3Eb2+B3GbEvLFSdR1Z+oPWmEO+783ylPzv143y
        FqvX8wWHetwgCQlOADr8efqpPvxhaiw=
X-Google-Smtp-Source: ABdhPJzR/+6aV3t0xwSyXDenvRR2uNtrQ7TUqvw6lRBRCC4HUP6FOgFNgVSOeRIU3XQ8lCc8/HA1cg==
X-Received: by 2002:a1c:9d8b:: with SMTP id g133mr3928204wme.44.1611320646849;
        Fri, 22 Jan 2021 05:04:06 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b11sm6562940wrp.60.2021.01.22.05.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 05:04:06 -0800 (PST)
Message-Id: <04d1daf7222e16f07f9c1eb92a7ecd020667da3c.1611320639.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.839.v2.git.1611320639.gitgitgadget@gmail.com>
References: <pull.839.git.1611161639.gitgitgadget@gmail.com>
        <pull.839.v2.git.1611320639.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 22 Jan 2021 13:03:57 +0000
Subject: [PATCH v2 6/8] sparse-checkout: load sparse-checkout patterns
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, Derrick Stolee <stolee@gmail.com>,
        gitster@pobox.com, Derrick Stolee <derrickstolee@github.com>,
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

