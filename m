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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F8AC4320A
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 21:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C6E06138B
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 21:55:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238658AbhHXVzq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 17:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238439AbhHXVzh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 17:55:37 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03AF5C061796
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 14:54:53 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id x2-20020a1c7c02000000b002e6f1f69a1eso2853468wmc.5
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 14:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=t4xYg8Az3c2cCDTZ+0YQBXjHrqNP5wx73T5m00T4gv8=;
        b=bK3fBCyxi37RVtWCjuXR2J69OAloWQOSZhi5tBX1K2Z6QgStlpZ9tz32jL9VyW5mnZ
         NqO9iwFsRRmaFtRWgP2sJZdCKTQHyQyr+mykify7q0I61f4bpXusyekHa7aCHVzp4F8R
         dg7pkDkqYRJw3noZHk38jfJzgLLGOF/IBVNN/KuKzRr8bW8Q7LVcD/R1Cv739rac1bLh
         qSviBYjwykW11qW5UDzr7RZNZ991IIA7ujpsbL/J27jmuaGoZJkQP1/SVvvvbBUWjilc
         kdGtY0WA+pD2pXU7UIFMhty30O5PrwUhxyoT4KszhD2V+zhK1qDy0c+mnM7s1fhOhjNH
         khOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=t4xYg8Az3c2cCDTZ+0YQBXjHrqNP5wx73T5m00T4gv8=;
        b=rwLGY/zeE0Yew4Wq6iqmzP+WvIfYMhVTa161nRjS2EHjXCveq7Oyv0JpUeZsvpxLuU
         3WKHJz7HVzLbCepp1YJuCAlrfgP1YCOD3Dzn9fKnuIku1VSGsniNi6AM+8fQnPrVd4GC
         QZoLSfLNcfY6EFbX5/E5oN6ZJDRYrUdD1og1g1T6OENLWgfOHhuHZkOZgGI8E3XA89Sj
         +3k9RxQGfBbRdEWtE82G38tlUdZCX5eZIpmGVIeudsT2sh72sJtBjEkmhdTrKL8LjbXC
         j3nqAKYhyUR+jI2vWcpGAPO/+JB5D/Jl0wQHtkuBMI/FCRNjF3AZbnLrc+5SSV5kMenb
         JbKA==
X-Gm-Message-State: AOAM5313YPz6u4XEey8eFMgDfK6Ml3kb2CvwOJ/ECmA2/BIrygC/hBww
        BUu+X3+YgakNpdTqYTuFf8absKe8e/0=
X-Google-Smtp-Source: ABdhPJzfBXv6O/GwhVgKZhFNkBc0yj5A4kJW1MCThcfLKwQLF8pBdkimKphIQzOg4cknN9tU94H76w==
X-Received: by 2002:a1c:80c3:: with SMTP id b186mr5747527wmd.105.1629842091680;
        Tue, 24 Aug 2021 14:54:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n15sm3140214wmq.7.2021.08.24.14.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 14:54:51 -0700 (PDT)
Message-Id: <6c9c986ff43fe7f065c27e61468534007e70d2a7.1629842085.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1018.git.1629842085.gitgitgadget@gmail.com>
References: <pull.1018.git.1629842085.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 24 Aug 2021 21:54:41 +0000
Subject: [PATCH 09/13] rm: add --sparse option
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

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-rm.txt      |  6 ++++++
 builtin/rm.c                  |  8 ++++++--
 t/t3602-rm-sparse-checkout.sh | 14 +++++++++++++-
 3 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-rm.txt b/Documentation/git-rm.txt
index 26e9b284704..81bc23f3cdb 100644
--- a/Documentation/git-rm.txt
+++ b/Documentation/git-rm.txt
@@ -72,6 +72,12 @@ For more details, see the 'pathspec' entry in linkgit:gitglossary[7].
 --ignore-unmatch::
 	Exit with a zero status even if no files matched.
 
+--sparse::
+	Allow updating index entries outside of the sparse-checkout cone.
+	Normally, `git rm` refuses to update index entries whose paths do
+	not fit within the sparse-checkout cone. See
+	linkgit:git-sparse-checkout[1] for more.
+
 -q::
 --quiet::
 	`git rm` normally outputs one line (in the form of an `rm` command)
diff --git a/builtin/rm.c b/builtin/rm.c
index 8a24c715e02..4208f3f9a5f 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -237,6 +237,7 @@ static int check_local_mod(struct object_id *head, int index_only)
 
 static int show_only = 0, force = 0, index_only = 0, recursive = 0, quiet = 0;
 static int ignore_unmatch = 0, pathspec_file_nul;
+static int include_sparse;
 static char *pathspec_from_file;
 
 static struct option builtin_rm_options[] = {
@@ -247,6 +248,7 @@ static struct option builtin_rm_options[] = {
 	OPT_BOOL('r', NULL,             &recursive,  N_("allow recursive removal")),
 	OPT_BOOL( 0 , "ignore-unmatch", &ignore_unmatch,
 				N_("exit with a zero status even if nothing matched")),
+	OPT_BOOL(0, "sparse", &include_sparse, N_("allow updating entries outside of the sparse-checkout cone")),
 	OPT_PATHSPEC_FROM_FILE(&pathspec_from_file),
 	OPT_PATHSPEC_FILE_NUL(&pathspec_file_nul),
 	OPT_END(),
@@ -298,7 +300,8 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 	ensure_full_index(&the_index);
 	for (i = 0; i < active_nr; i++) {
 		const struct cache_entry *ce = active_cache[i];
-		if (ce_skip_worktree(ce))
+
+		if (!include_sparse && ce_skip_worktree(ce))
 			continue;
 		if (!ce_path_match(&the_index, ce, &pathspec, seen))
 			continue;
@@ -322,7 +325,8 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 				seen_any = 1;
 			else if (ignore_unmatch)
 				continue;
-			else if (matches_skip_worktree(&pathspec, i, &skip_worktree_seen))
+			else if (!include_sparse &&
+				 matches_skip_worktree(&pathspec, i, &skip_worktree_seen))
 				string_list_append(&only_match_skip_worktree, original);
 			else
 				die(_("pathspec '%s' did not match any files"), original);
diff --git a/t/t3602-rm-sparse-checkout.sh b/t/t3602-rm-sparse-checkout.sh
index e9e9a15c74c..a34b978bfd8 100755
--- a/t/t3602-rm-sparse-checkout.sh
+++ b/t/t3602-rm-sparse-checkout.sh
@@ -36,13 +36,25 @@ done
 
 test_expect_success 'recursive rm does not remove sparse entries' '
 	git reset --hard &&
-	git sparse-checkout set sub/dir &&
+	git sparse-checkout set sub/dir/ &&
 	git rm -r sub &&
 	git status --porcelain -uno >actual &&
 	echo "D  sub/dir/e" >expected &&
 	test_cmp expected actual
 '
 
+test_expect_success 'recursive rm --sparse removes sparse entries' '
+	git reset --hard &&
+	git sparse-checkout set "sub/dir" &&
+	git rm --sparse -r sub &&
+	git status --porcelain -uno >actual &&
+	cat >expected <<-\EOF &&
+	D  sub/d
+	D  sub/dir/e
+	EOF
+	test_cmp expected actual
+'
+
 test_expect_success 'rm obeys advice.updateSparsePath' '
 	git reset --hard &&
 	git sparse-checkout set a &&
-- 
gitgitgadget

