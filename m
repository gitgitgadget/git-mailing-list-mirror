Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED92AECAAD3
	for <git@archiver.kernel.org>; Thu,  1 Sep 2022 21:02:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235038AbiIAVCv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Sep 2022 17:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234952AbiIAVCh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2022 17:02:37 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB3636268
        for <git@vger.kernel.org>; Thu,  1 Sep 2022 14:02:36 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id c131-20020a1c3589000000b003a84b160addso1394665wma.2
        for <git@vger.kernel.org>; Thu, 01 Sep 2022 14:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date;
        bh=/qlE1PUtmx/m3+UVIXHu/J8DM6hxIuhonjidHbbNVEc=;
        b=L3P8y5TxNAwkeP+nHYN9TYr6VcZOmDYk2k/rA6IhVt/gEnUk+aZaMxzL/RSxoiUBFO
         gzfsqANuUHoQLmFrB052J7mIxPtzuAMyB2Cy/XtBe3+SVlyQcKesec/bxqOuG9YhkP++
         LXtSBUiEoHGF95mYnMKPGKgqYY9L/ro920cBZsgWaCEJvzgYyEtPKADeGrF+QD29H5fv
         6K7YjNdS8xKphK9QUDEqRb2D5qoTmna/n74tmBEOpVs6vMdZJ32ZVHzh7sndDXIoTWaW
         7ef1sQcpx3o5zhUmAWu+llS3mPVHRg+ZDogLkMvftdjBlXfUhxEX8xKAYlFBbODXtAzH
         ZAtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=/qlE1PUtmx/m3+UVIXHu/J8DM6hxIuhonjidHbbNVEc=;
        b=Wi9qniWO6EcYlJTcFwm9pkK5lwRxsGldA7cugWj3i+Pp90fyqy0BRA1D7rArUXBOCU
         DaPYQIHK7BnFAVJN3hVZpTC5l4nejgUzkXVWnehkDsqMzJfEswBej/PHdMNcIzu5V1Bu
         jne9mwSBuk2xkAYbyNp/hk/3rH5P/GzqZAkMc+3ySgxHbYPbHwM0DrkJLwQBVA+p9dMb
         KT8cVnKunv3qyzyBgap8vpxGk3L21vIkZFP0zyp/8exo6ToliW96wrf1+fBEtrxbKWGV
         SGw2+xDtGb1mg8hR759nQEgWzI4ic8WK2/raNYnEXvce53yig0XdoFrSBD2AktWCr1rD
         MRXA==
X-Gm-Message-State: ACgBeo113RpYMgXajxFvneQwqYvyWakn9Sb1j1mVXP5ARhI8f+VlZ2hM
        89l7G4iOYTheDzdZwwqfifkauSW28jQ=
X-Google-Smtp-Source: AA6agR7lih9RT6h7Bt2AXYSuEsOXXw6YlNtoSLvFXx36ZXSsBQb22ifK4wF6qJ5F/rNjuXiajlREdw==
X-Received: by 2002:a05:600c:22ca:b0:3a5:c30d:ca9f with SMTP id 10-20020a05600c22ca00b003a5c30dca9fmr579084wmg.25.1662066154915;
        Thu, 01 Sep 2022 14:02:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p7-20020a05600c358700b003a8418ee646sm7376526wmq.12.2022.09.01.14.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 14:02:34 -0700 (PDT)
Message-Id: <pull.1344.git.1662066153644.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Sep 2022 21:02:33 +0000
Subject: [PATCH] unpack-trees: fix sparse directory recursion check
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     shaoxuan.yuan02@gmail.com, gitster@pobox.com,
        derrickstolee@github.com, Victoria Dye <vdye@github.com>,
        Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Ensure 'is_sparse_directory_entry()' receives a valid 'name_entry *' if one
exists in the list of tree(s) being unpacked in 'unpack_callback()'.

Currently, 'is_sparse_directory_entry()' is called with the first
'name_entry' in the 'names' list of entries on 'unpack_callback()'. However,
this entry may be empty even when other elements of 'names' are not (such as
when switching from an orphan branch back to a "normal" branch). As a
result, 'is_sparse_directory_entry()' could incorrectly indicate that a
sparse directory is *not* actually sparse because the name of the index
entry does not match the (empty) 'name_entry' path.

Fix the issue by using the existing 'name_entry *p' value in
'unpack_callback()', which points to the first non-empty entry in 'names'.
Because 'p' is 'const', also update 'is_sparse_directory_entry()'s
'name_entry *' argument to be 'const'.

Finally, add a regression test case.

Reported-by: Derrick Stolee <derrickstolee@github.com>
Signed-off-by: Victoria Dye <vdye@github.com>
---
    unpack-trees: fix sparse directory recursion check
    
    This issue was found when the updates from v2.37.3 introduced a test
    failure in a downstream test suite.
    
    The issue stems from the fact that, before v2.37.3, 'unpack_callback()'
    could previously "assume" that 'names[0]' was non-empty if a cache entry
    was unpacked as a sparse index. When b15207b8cf (unpack-trees: unpack
    new trees as sparse directories, 2022-08-08)) was introduced, it
    invalidated that assumption by allowing sparse directories to be
    unpacked based on the contents of other 'names' entries, rather than
    unnecessarily recursing into them and unpacking files individually. As a
    result, certain scenarios could cause a sparse directory to be unpacked
    then also recursively unpacked via 'traverse_trees_recursive()',
    creating duplicate index entries.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1344%2Fvdye%2Fbugfix%2Fsparse-index-orphan-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1344/vdye/bugfix/sparse-index-orphan-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1344

 t/t1092-sparse-checkout-compatibility.sh | 9 +++++++++
 unpack-trees.c                           | 4 ++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 0302e36fd66..b9350c075c2 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -380,6 +380,15 @@ test_expect_success 'checkout with modified sparse directory' '
 	test_all_match git checkout base
 '
 
+test_expect_success 'checkout orphan then non-orphan' '
+	init_repos &&
+
+	test_all_match git checkout --orphan test-orphan &&
+	test_all_match git status --porcelain=v2 &&
+	test_all_match git checkout base &&
+	test_all_match git status --porcelain=v2
+'
+
 test_expect_success 'add outside sparse cone' '
 	init_repos &&
 
diff --git a/unpack-trees.c b/unpack-trees.c
index 90b92114be8..bae812156c4 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1423,7 +1423,7 @@ static void debug_unpack_callback(int n,
  * from the tree walk at the given traverse_info.
  */
 static int is_sparse_directory_entry(struct cache_entry *ce,
-				     struct name_entry *name,
+				     const struct name_entry *name,
 				     struct traverse_info *info)
 {
 	if (!ce || !name || !S_ISSPARSEDIR(ce->ce_mode))
@@ -1562,7 +1562,7 @@ static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, str
 			}
 		}
 
-		if (!is_sparse_directory_entry(src[0], names, info) &&
+		if (!is_sparse_directory_entry(src[0], p, info) &&
 		    !is_new_sparse_dir &&
 		    traverse_trees_recursive(n, dirmask, mask & ~dirmask,
 						    names, info) < 0) {

base-commit: d42b38dfb5edf1a7fddd9542d722f91038407819
-- 
gitgitgadget
