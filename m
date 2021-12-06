Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B8EC433F5
	for <git@archiver.kernel.org>; Mon,  6 Dec 2021 14:10:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245694AbhLFOOQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Dec 2021 09:14:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245660AbhLFOOK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Dec 2021 09:14:10 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB55C061A83
        for <git@vger.kernel.org>; Mon,  6 Dec 2021 06:10:41 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id o19-20020a1c7513000000b0033a93202467so7695027wmc.2
        for <git@vger.kernel.org>; Mon, 06 Dec 2021 06:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=T2uX2JhclnQc/NrbNmsAF8DpimRyu++Q63+s2QrpeIU=;
        b=qAMcU7KZzAcbMqkz35z55tzHBRG881131lpdCk6Jfu8j1vn9DdYXxn3rG1uj0gRsyP
         vFZZ+RPUWQB89T+p5zJoZD5FUYI+RaHE+jCwnpCItlzy9WUg2b6AtnlxaNfKpdS/2tGO
         gB65jk0PFG5xZZrO4pDBtJWvtDPpUWUWjrVXo6KV2uMnljQmMsrVuLLyJ/cWY28tYC3u
         2DGTv5MH/4fvCr/60vjZOoLasp4ZcaeTButoRyRpZnJWrDjXtmqf2YKXmc4kJ44xfmxI
         yXreMxxZe1aaCE7NtSWIdwFixExyq+5Q3VURW/Sj2peJobOA6KiBp5InfFA1f260Lmf1
         G+aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=T2uX2JhclnQc/NrbNmsAF8DpimRyu++Q63+s2QrpeIU=;
        b=3bqwUSiL9UlFdQHg8rJwfka7RitBuTcLmoel5cdsdao50VWl9OmYtxOpNcy+OcZSdr
         DJBDPpWRU+ypusbTIpu9FxnzyO++qCrxq8feNl/QJLnoQhK3EoXDacS9Lvgltso+B60T
         kreSUp78d5iS+YdkcISu9jn/cbdsyu0zopLRbIUKJyNC6pnPpw4g7kbSaWOGLVqCcILz
         rHvv/YU6aWua2es/cXoD7v0Cuwfkc3PnN4I+tZq3WZDyzXNGOBE3PmUOJHul8k8ZBWgv
         4RJ++IzXjFNjo+TgLMxK6CNnvoqFHhLqIl8Fpr2j5rKnDaTe9FbUM9iH87fGxQyYEH3H
         WkvQ==
X-Gm-Message-State: AOAM5338RM8+wNusFCaqA8PHWYlHdhafcV/QgTNPe3jZrsGIqyfd7KKi
        7OJ5vcBJ3aHX9p+KnEE8+sUCYlUNAjk=
X-Google-Smtp-Source: ABdhPJzYTgOYaqb66ZNUt79J3fX1ko1VIraKmvXByuxIHHZ7eJ9PYp8rabiAlEdfahtpWqmLLzu+kQ==
X-Received: by 2002:a1c:5414:: with SMTP id i20mr40016099wmb.88.1638799839803;
        Mon, 06 Dec 2021 06:10:39 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m34sm14289560wms.25.2021.12.06.06.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 06:10:39 -0800 (PST)
Message-Id: <aa37168dcb47c0144e9468e2d317b8b8efd20e46.1638799837.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1092.v2.git.1638799837.gitgitgadget@gmail.com>
References: <pull.1092.git.1638586534.gitgitgadget@gmail.com>
        <pull.1092.v2.git.1638799837.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 06 Dec 2021 14:10:37 +0000
Subject: [PATCH v2 2/2] unpack-trees: use traverse_path instead of name
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, vdye@github.com, gitster@pobox.com,
        newren@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The sparse_dir_matches_path() method compares a cache entry that is a
sparse directory entry against a 'struct traverse_info *info' and a
'struct name_entry *p' to see if the cache entry has exactly the right
name for those other inputs.

This method was introduced in 523506d (unpack-trees: unpack sparse
directory entries, 2021-07-14), but included a significant mistake. The
path comparisons used 'info->name' instead of 'info->traverse_path'.
Since 'info->name' only stores a single tree entry name while
'info->traverse_path' stores the full path from root, this method does
not work when 'info' is in a subdirectory of a directory. Replacing the
right strings and their corresponding lengths make the method work
properly.

The previous change included a failing test that exposes this issue.
That test now passes. The critical detail is that as we go deep into
unpack_trees(), the logic for merging a sparse directory entry with a
tree entry during 'git checkout' relies on this
sparse_dir_matches_path() in order to avoid calling
traverse_trees_recursive() during unpack_callback() in this hunk:

	if (!is_sparse_directory_entry(src[0], names, info) &&
	    traverse_trees_recursive(n, dirmask, mask & ~dirmask,
					    names, info) < 0) {
		return -1;
	}

For deep paths, the short-circuit never occurred and
traverse_trees_recursive() was being called incorrectly and that was
causing other strange issues. Specifically, the error message from the
now-passing test previously included this:

      error: Your local changes to the following files would be overwritten by checkout:
              deep/deeper1/deepest2/a
              deep/deeper1/deepest3/a
      Please commit your changes or stash them before you switch branches.
      Aborting

These messages occurred because the 'current' cache entry in
twoway_merge() was showing as NULL because the index did not contain
entries for the paths contained within the sparse directory entries. We
instead had 'oldtree' given as the entry at HEAD and 'newtree' as the
entry in the target tree. This led to reject_merge() listing these
paths.

Now that sparse_dir_matches_path() works the same for deep paths as it
does for shallow depths, the rest of the logic kicks in to properly
handle modifying the sparse directory entries as designed.

Reported-by: Gustave Granroth <gus.gran@gmail.com>
Reported-by: Mike Marcelais <michmarc@exchange.microsoft.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t1092-sparse-checkout-compatibility.sh |  2 +-
 unpack-trees.c                           | 14 ++++++++------
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index e6aef40e9b3..f04a02c6b20 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -307,7 +307,7 @@ test_expect_success 'add, commit, checkout' '
 	test_all_match git checkout -
 '
 
-test_expect_failure 'deep changes during checkout' '
+test_expect_success 'deep changes during checkout' '
 	init_repos &&
 
 	test_sparse_match git sparse-checkout set deep/deeper1/deepest &&
diff --git a/unpack-trees.c b/unpack-trees.c
index 89ca95ce90b..d2363b44ec3 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1231,7 +1231,9 @@ static int find_cache_pos(struct traverse_info *info,
 
 /*
  * Given a sparse directory entry 'ce', compare ce->name to
- * info->name + '/' + p->path + '/' if info->name is non-empty.
+ * info->traverse_path + p->path + '/' if info->traverse_path
+ * is non-empty.
+ *
  * Compare ce->name to p->path + '/' otherwise. Note that
  * ce->name must end in a trailing '/' because it is a sparse
  * directory entry.
@@ -1243,11 +1245,11 @@ static int sparse_dir_matches_path(const struct cache_entry *ce,
 	assert(S_ISSPARSEDIR(ce->ce_mode));
 	assert(ce->name[ce->ce_namelen - 1] == '/');
 
-	if (info->namelen)
-		return ce->ce_namelen == info->namelen + p->pathlen + 2 &&
-		       ce->name[info->namelen] == '/' &&
-		       !strncmp(ce->name, info->name, info->namelen) &&
-		       !strncmp(ce->name + info->namelen + 1, p->path, p->pathlen);
+	if (info->pathlen)
+		return ce->ce_namelen == info->pathlen + p->pathlen + 1 &&
+		       ce->name[info->pathlen - 1] == '/' &&
+		       !strncmp(ce->name, info->traverse_path, info->pathlen) &&
+		       !strncmp(ce->name + info->pathlen, p->path, p->pathlen);
 	return ce->ce_namelen == p->pathlen + 1 &&
 	       !strncmp(ce->name, p->path, p->pathlen);
 }
-- 
gitgitgadget
