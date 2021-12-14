Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8145BC433F5
	for <git@archiver.kernel.org>; Tue, 14 Dec 2021 04:09:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233951AbhLNEJ0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Dec 2021 23:09:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233806AbhLNEJS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 23:09:18 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A523DC061574
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 20:09:17 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id p18so13338004wmq.5
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 20:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=PGiJD1JW2LAfW4ipFuLomI28z7mSJwBE8j9UNJ/XZCI=;
        b=eVBmTrGUDtiKBA/xS53276qGLg9ZxTtRt+4MbS6KgcI8AHK2/1Ep2O44UptCClIMNU
         dzpL5ZgUyqPIerVtpGKmm2sx++9O7kcfc87kBlOPUZcfPRCE0GlvxCeLx3oS/Gs4YVBi
         kelhpSz/qxhGEnUEI2n7cocBL7VtUWFOQjDcul6aYl7cqt+qv1Bi57IaA5ObAia05bH/
         sSe7IQxmuUVbJBsAQmRp2PXdgm401OyXv5DtS2OJ3Lu3nqOh45l0w91AMIMcJbGykHC2
         7e3UTY9Aay9KB/C7PrOJXFNoqf5gK6BHbEglIPqyxwtTTVvZ/+bQcTwJvVFTBEjA2a3S
         KWHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=PGiJD1JW2LAfW4ipFuLomI28z7mSJwBE8j9UNJ/XZCI=;
        b=p5gKoOtNVkFQkOE0KgfFZNGqKqdi4GZnXC25FvLyjtmI+H0h3V/iMutHRb7TKFvzHs
         nthPKwZ0Gz5mR0nweer4HBdMBBCf030diqGxX80STGdxMSOIPAas3tZHwdGZBafv55dc
         afzdKDkg7G1TYy8TeaVA/4eGbGWQTBhYkpyTJyw4XFITJCcQGEYuinXeHZW1yX0XeLB9
         9Mr+qECJVnIQ0oJap6chwSquuT/URp4QIcQ6jhfdzpm19U6343r4p8u37hm9Q+EXTtXn
         iWEzeK41qjuhpq914Z3N4M5yiL/Kgsaxx/IPXKhRwQ0aiyXOCDYgL2IqTiI8Knkji1Ou
         Ao0A==
X-Gm-Message-State: AOAM5330UfsZvDPY1SNqF/rQBxZQQUaLckqsrLROpJdZq3YgJreMhB3T
        RGc/L/ClJnomkYEeq0hKjT0kDaTQ0ms=
X-Google-Smtp-Source: ABdhPJzq19wGQyUi5h31+d5gtDAKSaKlXVR0Wc9DKtOq0kvg1tWLRXnqx9jRvFOfc/6iuDBAkHx03g==
X-Received: by 2002:a1c:287:: with SMTP id 129mr43398076wmc.49.1639454956173;
        Mon, 13 Dec 2021 20:09:16 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z6sm12581073wrm.93.2021.12.13.20.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 20:09:15 -0800 (PST)
Message-Id: <3e9e28c8dd2b2b4b3ba435eedf07f2b8b43d00fd.1639454952.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1151.v4.git.git.1639454952.gitgitgadget@gmail.com>
References: <pull.1151.v3.git.git.1639108573.gitgitgadget@gmail.com>
        <pull.1151.v4.git.git.1639454952.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 14 Dec 2021 04:09:07 +0000
Subject: [PATCH v4 05/10] sparse-checkout: split out code for tweaking
 settings config
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Victoria Dye <vdye@github.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

`init` has some code for handling updates to either cone mode or
the sparse-index setting.  We would like to be able to reuse this
elsewhere, namely in `set` and `reapply`.  Split this function out,
and make it slightly more general so it can handle being called from
the new callers.

Reviewed-by: Derrick Stolee <dstolee@microsoft.com>
Reviewed-by: Victoria Dye <vdye@github.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/sparse-checkout.c | 56 ++++++++++++++++++++++++++-------------
 1 file changed, 37 insertions(+), 19 deletions(-)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 387903eafe7..3b74779bb48 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -383,6 +383,41 @@ static int set_config(enum sparse_checkout_mode mode)
 	return 0;
 }
 
+static int update_modes(int *cone_mode, int *sparse_index)
+{
+	int mode, record_mode;
+
+	/* Determine if we need to record the mode; ensure sparse checkout on */
+	record_mode = (*cone_mode != -1) || !core_apply_sparse_checkout;
+
+	/* If not specified, use previous definition of cone mode */
+	if (*cone_mode == -1 && core_apply_sparse_checkout)
+		*cone_mode = core_sparse_checkout_cone;
+
+	/* Set cone/non-cone mode appropriately */
+	core_apply_sparse_checkout = 1;
+	if (*cone_mode == 1) {
+		mode = MODE_CONE_PATTERNS;
+		core_sparse_checkout_cone = 1;
+	} else {
+		mode = MODE_ALL_PATTERNS;
+	}
+	if (record_mode && set_config(mode))
+		return 1;
+
+	/* Set sparse-index/non-sparse-index mode if specified */
+	if (*sparse_index >= 0) {
+		if (set_sparse_index_config(the_repository, *sparse_index) < 0)
+			die(_("failed to modify sparse-index config"));
+
+		/* force an index rewrite */
+		repo_read_index(the_repository);
+		the_repository->index->updated_workdir = 1;
+	}
+
+	return 0;
+}
+
 static char const * const builtin_sparse_checkout_init_usage[] = {
 	N_("git sparse-checkout init [--cone] [--[no-]sparse-index]"),
 	NULL
@@ -399,7 +434,6 @@ static int sparse_checkout_init(int argc, const char **argv)
 	char *sparse_filename;
 	int res;
 	struct object_id oid;
-	int mode;
 	struct strbuf pattern = STRBUF_INIT;
 
 	static struct option builtin_sparse_checkout_init_options[] = {
@@ -412,19 +446,14 @@ static int sparse_checkout_init(int argc, const char **argv)
 
 	repo_read_index(the_repository);
 
+	init_opts.cone_mode = -1;
 	init_opts.sparse_index = -1;
 
 	argc = parse_options(argc, argv, NULL,
 			     builtin_sparse_checkout_init_options,
 			     builtin_sparse_checkout_init_usage, 0);
 
-	if (init_opts.cone_mode) {
-		mode = MODE_CONE_PATTERNS;
-		core_sparse_checkout_cone = 1;
-	} else
-		mode = MODE_ALL_PATTERNS;
-
-	if (set_config(mode))
+	if (update_modes(&init_opts.cone_mode, &init_opts.sparse_index))
 		return 1;
 
 	memset(&pl, 0, sizeof(pl));
@@ -432,17 +461,6 @@ static int sparse_checkout_init(int argc, const char **argv)
 	sparse_filename = get_sparse_checkout_filename();
 	res = add_patterns_from_file_to_list(sparse_filename, "", 0, &pl, NULL, 0);
 
-	if (init_opts.sparse_index >= 0) {
-		if (set_sparse_index_config(the_repository, init_opts.sparse_index) < 0)
-			die(_("failed to modify sparse-index config"));
-
-		/* force an index rewrite */
-		repo_read_index(the_repository);
-		the_repository->index->updated_workdir = 1;
-	}
-
-	core_apply_sparse_checkout = 1;
-
 	/* If we already have a sparse-checkout file, use it. */
 	if (res >= 0) {
 		free(sparse_filename);
-- 
gitgitgadget

