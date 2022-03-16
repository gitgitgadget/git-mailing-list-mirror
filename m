Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF583C433F5
	for <git@archiver.kernel.org>; Wed, 16 Mar 2022 20:12:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240617AbiCPUNb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Mar 2022 16:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356732AbiCPUNW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Mar 2022 16:13:22 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB36C6E4C1
        for <git@vger.kernel.org>; Wed, 16 Mar 2022 13:12:07 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id h15so4528763wrc.6
        for <git@vger.kernel.org>; Wed, 16 Mar 2022 13:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=a9AtQavLTw02jgTKNRQQ6rCtDH9TTkehw1UKIDyxuEU=;
        b=VOP+jvQw4yhENu4/4YRxPGwJcEg3fu/+fn7eG7xXSieZMz+Cq4AjauAEZ82/LWwp3q
         mS2nyU434ieumkd/2humNVpnpCju0jL3yuyoXFNqXObv//A7kCRfNH/zrS4rZqLWXkaR
         ioumu6sYxq4+/+RAFQdU5orKOW1hM/2gKumIVYLTTc7vyBdVFL3Fn41ylFy0xGGuPfmI
         WAkHh0C2yjjR0IkZQjfSS28xAc+bcuRjLm8WKSqb6yJqxRgkTrShenwOjGI+KaRPfydv
         PX8kxfmrgp+Ox2tSSgQpPLafKWVew4BQ6Qar7vxV2l9ejW+wWV9H8NuA3uJzUTJjUhTe
         IP6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=a9AtQavLTw02jgTKNRQQ6rCtDH9TTkehw1UKIDyxuEU=;
        b=blrRXayn9OZAnKOfPfowRKzG5VTANgz3Pt9J9WBAUslt5dflJSsuAKS6WhYLb9U26C
         YIJiLRxvw+TpOYNd1avfKk0VA1w/L8n3D/sSENJd84FWowJuTsy0HpSNtQrX1TPPfKiA
         06C+aPnwoeZMC1KKv2eJjf3fZKczBpLdUYl13pqshg6ReqFNT5v821r7jh4WETXgLLWE
         NuPNxLSlz8GrAUUFOn1NOTZVRyuLZ497/H/3Mqw2pPiXOkEp0yGLcxrjmaO1IswCYynQ
         Plne4HsNxu5UzZJSbn1Jg0kB9VxgE1XZf1pLLmLwtjp5vWYv/vIMKz6kFdMbLDTby6Ve
         LCBw==
X-Gm-Message-State: AOAM5328ymGxAiZGT9ooo+QlcmW89wmFszZflSwld+aN0eh7hzlPQyMT
        pYqdjkRUymWMhsjVkZ7/wCAxwD46meM=
X-Google-Smtp-Source: ABdhPJyLGl8LLcJp0FQlNgLF8ItYjK6NJl9uM/KYvn7jplU7mQdiaUeI6E7VMsF2uLzoLpfisbbs5w==
X-Received: by 2002:a5d:4a0f:0:b0:1ed:d377:288a with SMTP id m15-20020a5d4a0f000000b001edd377288amr1194958wrq.3.1647461525899;
        Wed, 16 Mar 2022 13:12:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i15-20020a05600011cf00b001edc2966dd4sm2291457wrx.47.2022.03.16.13.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 13:12:05 -0700 (PDT)
Message-Id: <8ebfebcc3473e6a5d1052b14b3e9d43036cb6857.1647461522.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1179.git.1647461522.gitgitgadget@gmail.com>
References: <pull.1179.git.1647461522.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 16 Mar 2022 20:12:01 +0000
Subject: [PATCH 2/3] unpack-trees: increment cache_bottom for sparse
 directories
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, gitster@pobox.com, newren@gmail.com,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Correct tracking of the 'cache_bottom' for cases where sparse directories
are present in the index.

BACKGROUND
----------
The 'unpack_trees_options.cache_bottom' is a variable that tracks the
in-progress "bottom" of the cache as 'unpack_trees()' iterates through the
contents of the index. Most importantly, this value informs the sequential
return values of 'next_cache_entry()' which, in the "diff cache" usage of
'unpack_callback()', are either unpacked as-is or are passed into the diff
machinery.

The 'cache_bottom' is intended to track the position of the first entry in
the index that has not yet been diffed or unpacked. It is advanced in two
main ways: either it is incremented when an index entry is marked as "used"
(in 'mark_ce_used()'), indicating that it was unpacked or diffed, or when a
directory is unpacked, in which case it is increased by an amount equaling
the number of index entries inside that tree.

In 17a1bb570b (unpack-trees: preserve cache_bottom, 2021-07-14), it was
identified that sparse directories posed a problem to the above
'cache_bottom' advancement logic - because a sparse directory was both an
index entry that could be "used" and a directory that can be unpacked, the
'cache_bottom' would be incremented too many times. To solve this problem,
the 'mark_ce_used()' advancement of 'cache_bottom' was skipped for sparse
directories.

INCORRECT CACHE_BOTTOM TRACKING
-------------------------------
Skipping the 'cache_bottom' advancement for sparse directories in
'mark_ce_used()' breaks down in two cases:

1. When the 'unpack_trees()' operation is *not* a "cache diff" (because the
   directory contents-based incrementing of 'cache_bottom' does not happen).
2. When a cache diff is performed with a pathspec (because
   'unpack_index_entry()' will unpack a sparse directory not matched by the
   pathspec without performing the directory contents-based increment).

The former luckily does not appear to affect 'git' behavior, likely because
'cache_bottom' is largely unused (non-"cache diff" 'unpack_trees()' uses
'find_index_entry()' - rather than 'next_cache_entry()' - to find the index
entries to unpack).

The latter, however, causes 'cache_bottom' to "lag behind" its intended
position by an amount equal to the number of sparse directories unpacked so
far with 'unpack_index_entry()'. If a repository is structured such that any
sparse directories are ordered lexicographically *after* any
pathspec-matching directories, though, this issue won't present any adverse
behavior.

This was the case with the 't1092-sparse-checkout-compatibility.sh' tests
before the addition of the 'before/' sparse directory (ordered *before* the
in-cone 'deep/' directory), therefore sidestepping the issue. Once the
'before/' directory was added, though, 'cache_bottom' began to lag behind
its intended position, causing 'next_cache_entry()' to return index entries
it had already processed and, ultimately, an incorrect diff.

CORRECTING CACHE_BOTTOM
-----------------------
The problems observed in 't1092' come from 'cache_bottom' lagging behind in
cases where the cache tree-based advancement doesn't occur. To solve this,
then, the fix in 17a1bb570b is "reversed"; rather than skipping
'cache_bottom' advancement in 'mark_ce_used()', we skip the directory
contents-based advancement for sparse directories. Now, every index entry
can be accounted for in 'cache_bottom':

* if you're working with a single index entry, 'cache_bottom' is incremented
  in 'mark_ce_used()'
* if you're working with a directory that contains index entries (but is not
  one itself), 'cache_bottom' is incremented by the number of entries in
  that directory.

Finally, change the 'test_expect_failure' tests in 't1092' failing due to
this bug back to 'test_expect_success'.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 t/t1092-sparse-checkout-compatibility.sh |  6 +++---
 unpack-trees.c                           | 16 ++++++++--------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 11141221b4d..e9533832aab 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -314,7 +314,7 @@ test_expect_success 'deep changes during checkout' '
 	test_all_match git checkout base
 '
 
-test_expect_failure 'add outside sparse cone' '
+test_expect_success 'add outside sparse cone' '
 	init_repos &&
 
 	run_on_sparse mkdir folder1 &&
@@ -356,7 +356,7 @@ test_expect_success 'commit including unstaged changes' '
 	test_all_match git status --porcelain=v2
 '
 
-test_expect_failure 'status/add: outside sparse cone' '
+test_expect_success 'status/add: outside sparse cone' '
 	init_repos &&
 
 	# folder1 is at HEAD, but outside the sparse cone
@@ -567,7 +567,7 @@ test_expect_success 'checkout and reset (keep)' '
 	test_all_match test_must_fail git reset --keep deepest
 '
 
-test_expect_failure 'reset with pathspecs inside sparse definition' '
+test_expect_success 'reset with pathspecs inside sparse definition' '
 	init_repos &&
 
 	write_script edit-contents <<-\EOF &&
diff --git a/unpack-trees.c b/unpack-trees.c
index 96525d2ec26..aac927faf08 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -595,13 +595,6 @@ static void mark_ce_used(struct cache_entry *ce, struct unpack_trees_options *o)
 {
 	ce->ce_flags |= CE_UNPACKED;
 
-	/*
-	 * If this is a sparse directory, don't advance cache_bottom.
-	 * That will be advanced later using the cache-tree data.
-	 */
-	if (S_ISSPARSEDIR(ce->ce_mode))
-		return;
-
 	if (o->cache_bottom < o->src_index->cache_nr &&
 	    o->src_index->cache[o->cache_bottom] == ce) {
 		int bottom = o->cache_bottom;
@@ -1442,7 +1435,14 @@ static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, str
 			 * it does not do any look-ahead, so this is safe.
 			 */
 			if (matches) {
-				o->cache_bottom += matches;
+				/*
+				 * Only increment the cache_bottom if the
+				 * directory isn't a sparse directory index
+				 * entry (if it is, it was already incremented)
+				 * in 'mark_ce_used()'
+				 */
+				if (!src[0] || !S_ISSPARSEDIR(src[0]->ce_mode))
+					o->cache_bottom += matches;
 				return mask;
 			}
 		}
-- 
gitgitgadget

