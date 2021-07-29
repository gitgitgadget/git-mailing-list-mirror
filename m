Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07596C4338F
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 17:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD85D6052B
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 17:27:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231835AbhG2R1b (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Jul 2021 13:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232080AbhG2R1Y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jul 2021 13:27:24 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24FD4C061765
        for <git@vger.kernel.org>; Thu, 29 Jul 2021 10:27:21 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id l18so7877973wrv.5
        for <git@vger.kernel.org>; Thu, 29 Jul 2021 10:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/LiEiCdbumU2nZE5OKuTRoscrNpPBhSIFUP8KVxTYnU=;
        b=N+OcILyantJlps8QrIkNjJO/zwKA+pjUOol00PAO/IHDB/pyOVnyeghVi1qeIpUDb1
         iD9DpLnHfG/OSQNsdfWCS3UtRJXx7Lg0ddmd6wBm8SRgQ8ljr8ATItNqdu/AgKJradWi
         AhSN/F0jLp6eevVg3wUAqE+4T4de4xNekVlDwZtjkfJBIKkptLk/Z5hVa3SbBUkj5kl4
         EUFxOyvo57CcW9Jwo1S+v5YVxnwhYzk3/wD5AHfrQ7XKefhk5rIgDYJzCHkqF0K5+g3r
         neKTakImz8L0h+xC3Vnp0npdwI9RwPUe0ClE9Rteko1wtK0V0blug+hpsPmM0GekL82U
         pYkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/LiEiCdbumU2nZE5OKuTRoscrNpPBhSIFUP8KVxTYnU=;
        b=ooBoNVAbwDg8MH1+y3+6wfZhYCELec+O2+Xs2Dg8IIbdSNbF42DHm+h05Kgr2T2hJ7
         F0g+g6lhKc5mk4NcNXVHzrx/W+NN4nqtg/uKDNX0PgwZcDCSqfnPEuMa3jWDMDnH4z57
         KM2F5KGlK+KJBoXXJbRzw3Ew/gs9Uviccqp8u/4L1J6TP6G8ePV1vbttPUH7tEywJ5oh
         REVQnCI39xq1PmuXloBpTyO6F/XPuGbeHQndZv6aN54hVZz1TjoCC8njCZ5vcqgPJk5q
         gxoMMK6q8ioT2rdAU/m5ojKlf+tqHj/PqlMs3C1qqVvfLSn8R2ZUhgAuU3UxHuPBtNqd
         W9fg==
X-Gm-Message-State: AOAM533rgJgi8ODyGpoaWEiwtC+SOw3kM6Kz0ljelk4uqcZo90XWnZ37
        P3fsE0YxNP4t9Uq7cQtvXfCkvnDpTgk=
X-Google-Smtp-Source: ABdhPJwETt5kQicpgGNCx6fbPwRY7JT6NNETSNDx6alCWYgX5W5f36TMpICYIXS0EHMgnyyaz0AvQQ==
X-Received: by 2002:adf:eccc:: with SMTP id s12mr5992862wro.331.1627579639643;
        Thu, 29 Jul 2021 10:27:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v6sm4072480wru.50.2021.07.29.10.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 10:27:19 -0700 (PDT)
Message-Id: <9212bbf4e3cab20fe49ab8e6dd4ac0277c4f2805.1627579637.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1009.git.1627579637.gitgitgadget@gmail.com>
References: <pull.1009.git.1627579637.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 29 Jul 2021 17:27:16 +0000
Subject: [PATCH 2/2] sparse-checkout: clear tracked sparse dirs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com, matheus.bernardino@usp.br,
        stolee@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

When changing the scope of a sparse-checkout using cone mode, we might
have some tracked directories go out of scope. The current logic removes
the tracked files from within those directories, but leaves the ignored
files within those directories. This is a bit unexpected to users who
have given input to Git saying they don't need those directories
anymore.

This is something that is new to the cone mode pattern type: the user
has explicitly said "I want these directories and _not_ those
directories." The typical sparse-checkout patterns more generally apply
to "I want files with with these patterns" so it is natural to leave
ignored files as they are. This focus on directories in cone mode
provides us an opportunity to change the behavior.

Leaving these ignored files in the sparse directories makes it
impossible to gain performance benefits in the sparse index. When we
track into these directories, we need to know if the files are ignored
or not, which might depend on the _tracked_ .gitignore file(s) within
the sparse directory. This depends on the indexed version of the file,
so the sparse directory must be expanded.

By deleting the sparse directories when changing scope (or running 'git
sparse-checkout reapply') we regain these performance benefits as if the
repository was in a clean state.

Since these ignored files are frequently build output or helper files
from IDEs, the users should not need the files now that the tracked
files are removed. If the tracked files reappear, then they will have
newer timestamps than the build artifacts, so the artifacts will need to
be regenerated anyway.

If users depend on ignored files within the sparse directories, then
they have created a bad shape in their repository. Regardless, such
shapes would create risk that changing the behavior for all cone mode
users might be too risky to take on at the moment. Since this data shape
makes it impossible to get performance benefits using the sparse index,
we limit the change to only be enabled when the sparse index is enabled.
Users can opt out of this behavior by disabline the sparse index.

Depending on user feedback or real-world use, we might want to consider
expanding the behavior change to all of cone mode. Since we are
currently restricting to the sparse index case, we can use the existence
of sparse directory entries in the index as indicators of which
directories should be removed.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-sparse-checkout.txt |  6 +++
 builtin/sparse-checkout.c             | 73 +++++++++++++++++++++++++++
 t/t1091-sparse-checkout-builtin.sh    | 42 +++++++++++++++
 3 files changed, 121 insertions(+)

diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
index fdcf43f87cb..c443189f418 100644
--- a/Documentation/git-sparse-checkout.txt
+++ b/Documentation/git-sparse-checkout.txt
@@ -210,6 +210,12 @@ case-insensitive check. This corrects for case mismatched filenames in the
 'git sparse-checkout set' command to reflect the expected cone in the working
 directory.
 
+When the sparse index is enabled through the `index.sparse` config option,
+the cone mode sparse-checkout patterns will also remove ignored files that
+are not within the sparse-checkout definition. This is important behavior
+to preserve the performance of the sparse index, but also matches that
+cone mode patterns care about directories, not files.
+
 
 SUBMODULES
 ----------
diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index a4bdd7c4940..5c03636b6ec 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -15,6 +15,7 @@
 #include "wt-status.h"
 #include "quote.h"
 #include "sparse-index.h"
+#include "run-command.h"
 
 static const char *empty_base = "";
 
@@ -100,6 +101,71 @@ static int sparse_checkout_list(int argc, const char **argv)
 	return 0;
 }
 
+static void clean_tracked_sparse_directories(struct repository *r)
+{
+	int i;
+	struct strbuf path = STRBUF_INIT;
+	size_t pathlen;
+
+	/*
+	 * If we are not using cone mode patterns, then we cannot
+	 * delete directories outside of the sparse cone.
+	 */
+	if (!r || !r->index || !r->index->sparse_checkout_patterns ||
+	    !r->index->sparse_checkout_patterns->use_cone_patterns)
+		return;
+	/*
+	 * NEEDSWORK: For now, only use this behavior when index.sparse
+	 * is enabled. We may want this behavior enabled whenever using
+	 * cone mode patterns.
+	 */
+	prepare_repo_settings(r);
+	if (!r->worktree || !r->settings.sparse_index)
+		return;
+
+	/*
+	 * Since we now depend on the sparse index to enable this
+	 * behavior, use it to our advantage. This process is more
+	 * complicated without it.
+	 */
+	convert_to_sparse(r->index);
+
+	strbuf_addstr(&path, r->worktree);
+	strbuf_complete(&path, '/');
+	pathlen = path.len;
+
+	for (i = 0; i < r->index->cache_nr; i++) {
+		struct cache_entry *ce = r->index->cache[i];
+
+		/*
+		 * Is this a sparse directory? If so, then definitely
+		 * include it. All contained content is outside of the
+		 * patterns.
+		 */
+		if (S_ISSPARSEDIR(ce->ce_mode) &&
+		    repo_file_exists(r, ce->name)) {
+			strbuf_setlen(&path, pathlen);
+			strbuf_addstr(&path, ce->name);
+
+			/*
+			 * Removal is "best effort". If something blocks
+			 * the deletion, then continue with a warning.
+			 */
+			if (remove_dir_recursively(&path, 0))
+				warning(_("failed to remove directory '%s'"), path.buf);
+		}
+	}
+
+	strbuf_release(&path);
+
+	/*
+	 * This is temporary: the sparse-checkout builtin is not
+	 * integrated with the sparse-index yet, so we need to keep
+	 * it full during the process.
+	 */
+	ensure_full_index(r->index);
+}
+
 static int update_working_directory(struct pattern_list *pl)
 {
 	enum update_sparsity_result result;
@@ -141,6 +207,8 @@ static int update_working_directory(struct pattern_list *pl)
 	else
 		rollback_lock_file(&lock_file);
 
+	clean_tracked_sparse_directories(r);
+
 	r->index->sparse_checkout_patterns = NULL;
 	return result;
 }
@@ -540,8 +608,11 @@ static int modify_pattern_list(int argc, const char **argv, enum modify_type m)
 {
 	int result;
 	int changed_config = 0;
+	struct pattern_list *old_pl = xcalloc(1, sizeof(*old_pl));
 	struct pattern_list *pl = xcalloc(1, sizeof(*pl));
 
+	get_sparse_checkout_patterns(old_pl);
+
 	switch (m) {
 	case ADD:
 		if (core_sparse_checkout_cone)
@@ -567,7 +638,9 @@ static int modify_pattern_list(int argc, const char **argv, enum modify_type m)
 		set_config(MODE_NO_PATTERNS);
 
 	clear_pattern_list(pl);
+	clear_pattern_list(old_pl);
 	free(pl);
+	free(old_pl);
 	return result;
 }
 
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index 38fc8340f5c..43eb314c94a 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -642,4 +642,46 @@ test_expect_success MINGW 'cone mode replaces backslashes with slashes' '
 	check_files repo/deep a deeper1
 '
 
+test_expect_success 'cone mode clears ignored subdirectories' '
+	rm repo/.git/info/sparse-checkout &&
+
+	# NEEDSWORK: --sparse-index is required for now
+	git -C repo sparse-checkout init --cone --sparse-index &&
+	git -C repo sparse-checkout set deep/deeper1 &&
+
+	cat >repo/.gitignore <<-\EOF &&
+	obj/
+	*.o
+	EOF
+
+	git -C repo add .gitignore &&
+	git -C repo commit -m ".gitignore" &&
+
+	mkdir -p repo/obj repo/folder1/obj repo/deep/deeper2/obj &&
+	for file in folder1/obj/a obj/a folder1/file.o folder1.o \
+		    deep/deeper2/obj/a deep/deeper2/file.o file.o
+	do
+		echo ignored >repo/$file || return 1
+	done &&
+
+	git -C repo status --porcelain=v2 >out &&
+	test_must_be_empty out &&
+
+	git -C repo sparse-checkout reapply &&
+	test_path_is_missing repo/folder1 &&
+	test_path_is_missing repo/deep/deeper2 &&
+	test_path_is_dir repo/obj &&
+	test_path_is_file repo/file.o &&
+
+	git -C repo status --porcelain=v2 >out &&
+	test_must_be_empty out &&
+
+	git -C repo sparse-checkout set deep/deeper2 &&
+	test_path_is_missing repo/deep/deeper1 &&
+	test_path_is_dir repo/deep/deeper2 &&
+
+	git -C repo status --porcelain=v2 >out &&
+	test_must_be_empty out
+'
+
 test_done
-- 
gitgitgadget
