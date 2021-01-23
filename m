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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2054C433DB
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 20:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD1A922D2B
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 20:01:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726405AbhAWUAi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Jan 2021 15:00:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbhAWT7w (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Jan 2021 14:59:52 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B3A3C061797
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 11:58:28 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id c12so8368116wrc.7
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 11:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4enHWQFO5nB7n6onrNC7/5mXxlAlvnYX7+cK2osA/Ao=;
        b=ZN6yYa426IMhJt0XW8iyS1FkBZXmvNqyTN9j47hm9x7EHP+Pq7NGCNcm99MbbwXe7l
         EYgFUfR1VzLhmHLG46+DasOmFzriyIyGfPhehlFP4MCXN7vnXTaseGELxNL7OU2wCKyk
         nsX22RMy02acQ0/B5ae9q8cMm+ejzn7Cg2x2ypcIyKWpTCjjn3svBlsTkowoT3MfyJUN
         hwGLTWbW6wYizwzuYq0W9WSk40N+C7Xie421RbFcUhrJ8ppVTCtcGcfL/msfWopXHRmf
         KPV+EgtoVr6GO2dfMygcyTx271VjDCe7yEzV2J9SrU2wtl0+qPzDsvRzlcECDiqnllfl
         ifAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4enHWQFO5nB7n6onrNC7/5mXxlAlvnYX7+cK2osA/Ao=;
        b=Xc115/qLe9S6UutpdMwcRMYkzHtsMiATmucpwT1FXEY/XW/Ir0pEmtGBvq/eh9hX5c
         /K3a2havaX5QVdUUvDZPW4V/dc3EtMq3ZclqxOnaWQmCqmkk86EHWYS5Vo/631vtlNUq
         1Df/Cti2vt/Tk/qVAEb6rG0yWVSDRL3E1YEwqOM7mDRZTBC9bRHNnivJRlj12J+GasjK
         WoMuawiWy+su1BlVAlI7CTqUql2eQkimTS3GnqV9arLRr7Aee0aGheKgQzOmYYkWXrj7
         tXkIlrToxSJTXXYmMA/fRsaYhsX67A7JQRbnu6krReJsNaRxoflXiEwXvta0p+SGYTZG
         YaoQ==
X-Gm-Message-State: AOAM5322/liHH3UpgnxttftVJJyQgyu23G+o3wbVTGmqJjErDfp6BIxe
        cyQhiQfXhaSz6VgMGc76fjKtaFiuptw=
X-Google-Smtp-Source: ABdhPJyB/QxByBfKd3rZu1IJOgJrIaOcvYF1M06DZoDxk3lXzH/X/iJAL2T7IVar4u2DlXljljOl8A==
X-Received: by 2002:a05:6000:1803:: with SMTP id m3mr10099803wrh.34.1611431907067;
        Sat, 23 Jan 2021 11:58:27 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o17sm10655686wrp.34.2021.01.23.11.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jan 2021 11:58:26 -0800 (PST)
Message-Id: <554cc7647e63008e1e2cf2ae3813412e16cfcce7.1611431900.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.839.v3.git.1611431899.gitgitgadget@gmail.com>
References: <pull.839.v2.git.1611320639.gitgitgadget@gmail.com>
        <pull.839.v3.git.1611431899.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 23 Jan 2021 19:58:17 +0000
Subject: [PATCH v3 7/9] sparse-checkout: load sparse-checkout patterns
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
index a810b79657e..f5f668f532d 100644
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

