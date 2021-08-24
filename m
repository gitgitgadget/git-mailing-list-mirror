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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F14EFC4338F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 21:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD0456138B
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 21:55:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235603AbhHXVzt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 17:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238094AbhHXVzi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 17:55:38 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E0BEC06179A
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 14:54:54 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id q11so6408146wrr.9
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 14:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=SRL4Mqvbh7uOsuJTajy9S2zELRleSoolNi7hNuwdKlU=;
        b=LJnOvO3eVPCvMTgmr8jgKUHIaCnRvV90js3FKCIGhWB0Od9l5S3l1VcojvJHpQ16gb
         K9lMV3qq1qbv4qyDafttezcxRPfh/clAGNgpTpprW+y6shsyi9bkRJHNmTnFYvdAhEVk
         8I8gDjYECpypTRd1QTRMkM3OhSQw/IEBNlub/g1zGK9JJt4L/RXW5EP/bKfI8CXBoMX9
         0nH/1Y7qaJCJrgUucbSbJONTEZuZhAwrJU0i8tikOkvFkIlI8Xebacz7LRkHGV7ro/Lu
         6UKE1ggevwTAlb9kV8TCNGEFHLDhMOWyMtzcmfDLi5CeLMfuaqZlA8xYlgOk7YEJIrw2
         sIjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=SRL4Mqvbh7uOsuJTajy9S2zELRleSoolNi7hNuwdKlU=;
        b=GWMB+olticXi74g+h9T2nII06rlBdq8I/ZeK3SxGm8GTttRus97UMzkd3reEZF0KeL
         tevSqB5+U6BYp2t2xv0WJZzOR4/OIBbn2i4pT4P1jVrO0kcPylVRbd2hGcmCQGqOJZN0
         Nnp9qxtjypZ8vSXLLeOMzJ7qs9JpWHvAzh0EtKNidNZ6GzUewyz3HUieQeVgNI+qP76W
         aQUcIids9qncEbJVd0fP0zlPEfnIuc+LsSZ/YO0AgsypfW3WefVmFxx7ie5gxBzWXex/
         GT04Pjt3BrntwKtKGqD3oEfVuhESBNH4/vKtenk6gPR3u3Dse9u0BcUT1irD/FpG9e7N
         JI8A==
X-Gm-Message-State: AOAM530gSGjHSse2F1JB8txuNk02dmYAIWUQMKBb8wfqDzCcOpbgosGd
        FgQgrR7DciAQchSu2VJexfNUETn/+AQ=
X-Google-Smtp-Source: ABdhPJx1zm9o4AXJ+phAFrTCB4iTIJhgcXiePJ2sQDVK8h5z/AbqIN/ZRsgezYvAOaZTufOW+STDjw==
X-Received: by 2002:a5d:4c89:: with SMTP id z9mr11072106wrs.290.1629842092806;
        Tue, 24 Aug 2021 14:54:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o17sm3260856wmp.13.2021.08.24.14.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 14:54:52 -0700 (PDT)
Message-Id: <d31c641180645ee4059aab9230841ad90f9244fe.1629842085.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1018.git.1629842085.gitgitgadget@gmail.com>
References: <pull.1018.git.1629842085.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 24 Aug 2021 21:54:43 +0000
Subject: [PATCH 11/13] mv: refuse to move sparse paths
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com, matheus.bernardino@usp.br,
        stolee@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Since cmd_mv() does not operate on cache entries and instead directly
checks the filesystem, we can only use path_in_sparse_checkout() as a
mechanism for seeing if a path is sparse or not. Be sure to skip
returning a failure if '-k' is specified.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/mv.c                  | 19 +++++++
 t/t7002-mv-sparse-checkout.sh | 99 +++++++++++++++++++++++++++++++++++
 2 files changed, 118 insertions(+)
 create mode 100755 t/t7002-mv-sparse-checkout.sh

diff --git a/builtin/mv.c b/builtin/mv.c
index c2f96c8e895..b58fd4ce5ba 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -133,6 +133,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 	struct string_list src_for_dst = STRING_LIST_INIT_NODUP;
 	struct lock_file lock_file = LOCK_INIT;
 	struct cache_entry *ce;
+	struct string_list only_match_skip_worktree = STRING_LIST_INIT_NODUP;
 
 	git_config(git_default_config, NULL);
 
@@ -176,10 +177,22 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 		const char *src = source[i], *dst = destination[i];
 		int length, src_is_dir;
 		const char *bad = NULL;
+		int skip_sparse = 0;
 
 		if (show_only)
 			printf(_("Checking rename of '%s' to '%s'\n"), src, dst);
 
+		if (!path_in_sparse_checkout(src, &the_index)) {
+			string_list_append(&only_match_skip_worktree, src);
+			skip_sparse = 1;
+		}
+		if (!path_in_sparse_checkout(dst, &the_index)) {
+			string_list_append(&only_match_skip_worktree, dst);
+			skip_sparse = 1;
+		}
+		if (skip_sparse)
+			continue;
+
 		length = strlen(src);
 		if (lstat(src, &st) < 0)
 			bad = _("bad source");
@@ -266,6 +279,12 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 		}
 	}
 
+	if (only_match_skip_worktree.nr) {
+		advise_on_updating_sparse_paths(&only_match_skip_worktree);
+		if (!ignore_errors)
+			return 1;
+	}
+
 	for (i = 0; i < argc; i++) {
 		const char *src = source[i], *dst = destination[i];
 		enum update_mode mode = modes[i];
diff --git a/t/t7002-mv-sparse-checkout.sh b/t/t7002-mv-sparse-checkout.sh
new file mode 100755
index 00000000000..5397c6d07bd
--- /dev/null
+++ b/t/t7002-mv-sparse-checkout.sh
@@ -0,0 +1,99 @@
+#!/bin/sh
+
+test_description='git mv in sparse working trees'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' "
+	mkdir -p sub/dir sub/dir2 &&
+	touch a b c sub/d sub/dir/e sub/dir2/e &&
+	git add -A &&
+	git commit -m files &&
+
+	cat >sparse_error_header <<-EOF &&
+	The following pathspecs didn't match any eligible path, but they do match index
+	entries outside the current sparse checkout:
+	EOF
+
+	cat >sparse_hint <<-EOF
+	hint: Disable or modify the sparsity rules if you intend to update such entries.
+	hint: Disable this message with \"git config advice.updateSparsePath false\"
+	EOF
+"
+
+test_expect_success 'mv refuses to move sparse-to-sparse' '
+	rm -f e &&
+	git reset --hard &&
+	git sparse-checkout set a &&
+	touch b &&
+	test_must_fail git mv b e 2>stderr &&
+	cat sparse_error_header >expect &&
+	echo b >>expect &&
+	echo e >>expect &&
+	cat sparse_hint >>expect &&
+	test_cmp expect stderr
+'
+
+test_expect_success 'mv refuses to move sparse-to-sparse, ignores failure' '
+	rm -f e &&
+	git reset --hard &&
+	git sparse-checkout set a &&
+	touch b &&
+	git mv -k b e 2>stderr &&
+	cat sparse_error_header >expect &&
+	echo b >>expect &&
+	echo e >>expect &&
+	cat sparse_hint >>expect &&
+	test_cmp expect stderr
+'
+
+test_expect_success 'mv refuses to move non-sparse-to-sparse' '
+	rm -f e &&
+	git reset --hard &&
+	git sparse-checkout set a &&
+	test_must_fail git mv a e 2>stderr &&
+	cat sparse_error_header >expect &&
+	echo e >>expect &&
+	cat sparse_hint >>expect &&
+	test_cmp expect stderr
+'
+
+test_expect_success 'mv refuses to move sparse-to-non-sparse' '
+	rm -f e &&
+	git reset --hard &&
+	git sparse-checkout set a e &&
+	touch b &&
+	test_must_fail git mv b e 2>stderr &&
+	cat sparse_error_header >expect &&
+	echo b >>expect &&
+	cat sparse_hint >>expect &&
+	test_cmp expect stderr
+'
+
+test_expect_success 'recursive mv refuses to move (possible) sparse' '
+	rm -f e &&
+	git reset --hard &&
+	# Without cone mode, "sub" and "sub2" do not match
+	git sparse-checkout set sub/dir sub2/dir &&
+	test_must_fail git mv sub sub2 2>stderr &&
+	cat sparse_error_header >expect &&
+	echo sub >>expect &&
+	echo sub2 >>expect &&
+	cat sparse_hint >>expect &&
+	test_cmp expect stderr
+'
+
+test_expect_success 'recursive mv refuses to move sparse' '
+	git reset --hard &&
+	# Use cone mode so "sub/" matches the sparse-checkout patterns
+	git sparse-checkout init --cone &&
+	git sparse-checkout set sub/dir sub2/dir &&
+	test_must_fail git mv sub sub2 2>stderr &&
+	cat sparse_error_header >expect &&
+	echo sub/dir2/e >>expect &&
+	echo sub2/dir2/e >>expect &&
+	cat sparse_hint >>expect &&
+	test_cmp expect stderr
+'
+
+test_done
-- 
gitgitgadget

