Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 933F9C433F5
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 03:56:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236560AbhLJD76 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 22:59:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236530AbhLJD7y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 22:59:54 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F70DC061B38
        for <git@vger.kernel.org>; Thu,  9 Dec 2021 19:56:19 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id o13so12848685wrs.12
        for <git@vger.kernel.org>; Thu, 09 Dec 2021 19:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=xnhiBTxqFnTfE4NfWk9C3Gz7jvC0AWQYtNKFghSExCI=;
        b=Jd73I/29Z1/Q+JfVVLO8ERaHVrU/Uz8UzuGcu9f8VuzwNX6oQ6of9xARVpv13bi0ro
         xoxZFKiNZvXY3ZAB+M65RvRVxsgeEDpBu7L6yFUYUOjO99pPCKsWrGGYYjeiZcDYMn6T
         3EGKI2Z/UPwfSAt1aDDQoWYWvpWHLRVsx92PS6RbyZaTJ9aj6y/pbXYCpgabtb1hBdD/
         0W2XZS1bOoTsjddHnNsoboG8J/rrLOnfkZomLZ0R9AqPlYJoA9A64uCyMc5ds1CsqQa7
         KTJ4tUOTYopEiIVW8tqP/U2qIYfST5XN8/jPtCTVI4pAA0PhQa85y0pgO5SdUxJrnwJE
         90UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=xnhiBTxqFnTfE4NfWk9C3Gz7jvC0AWQYtNKFghSExCI=;
        b=P03bg9dVV28OophVCrAZgCMWjKJ9Cu5O2QuB31qu/PjY490imJgC8cKagRrCUI/9l2
         v+gw/aRG5nSTZ0Cnv/zS2jgFXeXME9B9aFqTvWx5PsKuNqWpCYAh/yy5ti4771Fkv8fo
         Hgwglaf9Ha9laKHfjRZtRU45Xh5ytEFV6rINroLzkoKkK4KawqGgSWyEgHTKXwTVaP9b
         ntdfZJDAo9KdqZs9djTJv4FOVEEmjuYukoCGuG1J3QGozDrLABplSLXiB4MnX0NK69k6
         a/D7m/TwiDiimfLIGsMXoJx7BsRkkgZu19Pbm0B+1yY591H6Xxmvnjtf48oV8fqwjvIX
         GHPw==
X-Gm-Message-State: AOAM5337ZLgBKb1h7Ym5ADqijmN1erugl9Rnwxs6fUMlugi6GvqXRVWH
        H+RnZM5Jz0LEAmuPIn3KYi3+hSqZZxs=
X-Google-Smtp-Source: ABdhPJy9WXVKDrTvSIwqJkASgVHrXZfVRXM4BsgIIZhCvc+AYYE5sDtoF0Hsi3ssV4GX0oUvwZa5mQ==
X-Received: by 2002:a5d:6d09:: with SMTP id e9mr11294352wrq.17.1639108578038;
        Thu, 09 Dec 2021 19:56:18 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l3sm1609588wmq.46.2021.12.09.19.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 19:56:17 -0800 (PST)
Message-Id: <7a812e0222cbe2d0c64782f68f41c5ecb995433d.1639108573.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1151.v3.git.git.1639108573.gitgitgadget@gmail.com>
References: <pull.1151.v2.git.git.1638908410.gitgitgadget@gmail.com>
        <pull.1151.v3.git.git.1639108573.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 10 Dec 2021 03:56:08 +0000
Subject: [PATCH v3 05/10] sparse-checkout: split out code for tweaking
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
index 0ee28f48134..f176435b6be 100644
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

