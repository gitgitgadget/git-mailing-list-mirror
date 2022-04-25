Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 975C7C433F5
	for <git@archiver.kernel.org>; Mon, 25 Apr 2022 17:49:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244090AbiDYRwv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Apr 2022 13:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244112AbiDYRwf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Apr 2022 13:52:35 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE4F44773
        for <git@vger.kernel.org>; Mon, 25 Apr 2022 10:49:30 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id y21so9743402wmi.2
        for <git@vger.kernel.org>; Mon, 25 Apr 2022 10:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7tMfrmx3rf7lthw/GrffjNuSdoLDhRcNwiXfhwvNrzI=;
        b=LfZLx3Oc3xlgwMXGygItoBtDPDe4yAj0jlsPZsvpKXWRkdxecGKEJf06AfWl9nfc5K
         f8CMIsPfgS6px639Igghim2QfD/+kOXZ4Bcdp0iKP+3VOixYnXn32IEY+1xAl6Wp4kd5
         3fQ8liIGwpmQaps85FoCFSAMDjK4Pmlmd5oNskjW7reOFqx0jL+ZxWWP6MMo/FN+8HBP
         n/2cHvRApSUKuJ9BNeIcLDzEsDF8PtDyWZClaXE1z4FqDmiwVhCmmK59f3x/ysgRCIOC
         wunJmM9tKvYIklZPmIJkAFoZ510VgWlyEss8IMXyLToYYriA03Amwma4LRYztCVLM2W2
         eD4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7tMfrmx3rf7lthw/GrffjNuSdoLDhRcNwiXfhwvNrzI=;
        b=SD6owEYqY5KBDWDldFXIalhPXnashd6bAkxEMm89UFnVDYEe1vucGRFIuQAnBNtHcc
         YDXTXl0nFwiMAusdzx4ztdvuZT7qHUKyYaAz8V4kdsMAburqMEQpuiX2yzul3DLWS/s6
         l0ZHxFL5Pt13zAPfYhPlB1n3XFFE9JW6OR5Ul4ax3h68sEz3aOFWdbjcBrtJILkf6KE3
         dLBR+yrOxkhOIVZnegpeoy54gedc5CT/biQSNIKsjiCYMbl2ZzHQtWA7a5qAtVyGE0r/
         39K023FHrnZYDO/ewHswuVTsfjHZk3IojO+qEI1PUcjjvZ36v6Y2Rp1+CdZVvj/M1ou1
         zrmw==
X-Gm-Message-State: AOAM532XEA7fsAYHXGUgjcmsEV3bVlMmagmm09qyWSZvU71jlDRKuh1L
        h3ZL/Rs/2bjwRsAewHPZkiTfBmiFpbY=
X-Google-Smtp-Source: ABdhPJw/phmr+vvv+1tIHqjbunHElW1cFk6dGZayctU75Ex02kgkrUA3ABQhql+kKvq0NPGVPgjN4w==
X-Received: by 2002:a05:600c:502b:b0:38f:f7c6:3609 with SMTP id n43-20020a05600c502b00b0038ff7c63609mr17775700wmr.15.1650908968923;
        Mon, 25 Apr 2022 10:49:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a7-20020adffb87000000b00207982c7f4dsm9631444wrr.67.2022.04.25.10.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 10:49:28 -0700 (PDT)
Message-Id: <1daecbe45c1c3026b9eeb03d55a590c3c457a619.1650908958.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1171.git.1650908957.gitgitgadget@gmail.com>
References: <pull.1171.git.1650908957.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 25 Apr 2022 17:49:17 +0000
Subject: [PATCH 7/7] unpack-trees: preserve index sparsity
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, newren@gmail.com, gitster@pobox.com,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

When unpacking trees, set the default sparsity of the resultant index based
on repo settings and 'is_sparse_index_allowed()'.

Normally, when executing 'unpack_trees', the output index is marked sparse
when (and only when) it unpacks a sparse directory. However, an index may be
"sparse" even if it contains no sparse directories - when all files fall
inside the sparse-checkout definition or otherwise have SKIP_WORKTREE
disabled. Therefore, the output index may be marked "full" even when it is
"sparse", resulting in unnecessary 'ensure_full_index' calls when writing to
disk. Avoid this by setting the "default" index sparsity to match what is
expected for the repository.

As a consequence of this fix, the (non-merge) 'read-tree' performed when
applying a stash with untracked files no longer expands the index. Update
the corresponding test in 't1092'.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 t/t1092-sparse-checkout-compatibility.sh | 2 +-
 unpack-trees.c                           | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 8545a865e04..8443c7e65ae 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -1384,7 +1384,7 @@ test_expect_success 'sparse-index is not expanded: stash' '
 	ensure_not_expanded stash -u &&
 	(
 		WITHOUT_UNTRACKED_TXT=1 &&
-		! ensure_not_expanded stash pop
+		ensure_not_expanded stash pop
 	) &&
 
 	ensure_not_expanded stash create &&
diff --git a/unpack-trees.c b/unpack-trees.c
index 7f528d35cc2..a1d0ff3a4d3 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -11,6 +11,7 @@
 #include "refs.h"
 #include "attr.h"
 #include "split-index.h"
+#include "sparse-index.h"
 #include "submodule.h"
 #include "submodule-config.h"
 #include "fsmonitor.h"
@@ -1839,6 +1840,11 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 	o->result.fsmonitor_last_update =
 		xstrdup_or_null(o->src_index->fsmonitor_last_update);
 
+	if (!o->src_index->initialized &&
+	    !repo->settings.command_requires_full_index &&
+	    is_sparse_index_allowed(&o->result, 0))
+		o->result.sparse_index = 1;
+
 	/*
 	 * Sparse checkout loop #1: set NEW_SKIP_WORKTREE on existing entries
 	 */
-- 
gitgitgadget
