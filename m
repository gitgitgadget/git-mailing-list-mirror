Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5EB0C433EF
	for <git@archiver.kernel.org>; Mon, 25 Apr 2022 17:49:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237973AbiDYRw2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Apr 2022 13:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244061AbiDYRw1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Apr 2022 13:52:27 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CDFE26AF2
        for <git@vger.kernel.org>; Mon, 25 Apr 2022 10:49:22 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id q20so9739069wmq.1
        for <git@vger.kernel.org>; Mon, 25 Apr 2022 10:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=1Q+jt/6jT73OwpAg6pfX9a07dyWIbU4ZEY4qLFYxTic=;
        b=V1d+Ndvb0mMg3O8vvw7fAOZ63M5/EGKnXSfMnthWB7RoA1IP1d/wA6rh9RBi1aQSUE
         kipGa/ZuGy2TBf01moDg8aktw+cLNsQka/fL0k5C9xjAk3enY4TU9elMCkvxMhxqE89n
         Q4XRfLMW2BIsX/WAfx8PTlk/1c/9yu4cMEx7rt0DIm+dem6ECyzJy9/PdTUxaFeW+5GK
         ktbtGOSmsBn3V3iM+MehG1eFjiZntnfbvMyZ3MvYxK+0XYO+df9/f5v7DqlskjbIkh+z
         zhl73kSrCqLlaNM200+aS31kSxrDszVKcsqybnLvLvJeuCBO7QvRDTEVscyc1SWpTxke
         tGcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1Q+jt/6jT73OwpAg6pfX9a07dyWIbU4ZEY4qLFYxTic=;
        b=Mv4C6jxcSQV6Pv/Spt2BxZfnKIbIKyX7JPxlksRGB89AOxbMNPCr+L+aoVRqa8Z2LS
         nQPVjC8P5v+N0nWssX3PE+fetKIV5lYI74VZYmkyezwi0oVllZUlLc1JeuzbJeTGOkYc
         Ep3K3/cTG4Gdi5suqH4OwQ5cFn3f7ZZDwXe8/JisEkohJPJRDJ3vGpkXlhtRNrs4E/qT
         JlMKRII/hGvJv90AcPyZ/+YGpY4RXDWoeA8bqziKNbkcVb7jtUThvx5a61R7T47tUHcj
         J9S7BUUIYQjPGyeKmKjpeFlbem/vErel+jEyBhQDm7krh3dQqSxe4SMf6QwnYHkcRICy
         hBDg==
X-Gm-Message-State: AOAM5318B1/V3pt7wo22O2uZdDKmY8pNVM0rfUnkZ8GHPB4J00SuIheV
        EzjnI2YbEpVlt5ffwl7UcHvQCAqYWZo=
X-Google-Smtp-Source: ABdhPJzYtz9aV8SI30GAmnR3H0As5LmT/HzZpNM5pKgfXCALvZZ4cgwNqoEjEOcwBWMjGHf4OkOXVw==
X-Received: by 2002:a1c:f617:0:b0:383:5aab:9c51 with SMTP id w23-20020a1cf617000000b003835aab9c51mr26437703wmc.79.1650908960112;
        Mon, 25 Apr 2022 10:49:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f189-20020a1c38c6000000b0038ff83b9792sm12035263wma.43.2022.04.25.10.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 10:49:19 -0700 (PDT)
Message-Id: <pull.1171.git.1650908957.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 25 Apr 2022 17:49:10 +0000
Subject: [PATCH 0/7] Sparse index: integrate with 'git stash'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, newren@gmail.com, gitster@pobox.com,
        Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series, in combination with the sparse index integrations of reset [1],
update-index [2], checkout-index [2], clean [2], and read-tree [3], allows
most subcommands of 'git stash' to use the sparse index end-to-end without
index expansion.

Like the earlier series, this series starts with new tests ensuring
compatibility of the sparse index with non-sparse index full and sparse
checkouts [1/7]. Next, sparse index is trivially enabled [2/7].
Functionally, sparse index-enabled sparse-checkouts remain compatible with
non-sparse index sparse-checkouts, but there are still some cases where the
index (or a temporary index) is expanded unnecessarily. These cases are
fixed in three parts:

 * First, 'git stash -u' is made sparse index-compatible by ensuring the
   "temporary" index holding the stashed, untracked files is created as a
   sparse index whenever possible (per repo settings &
   'is_sparse_index_allowed()'). Patch [3/7] exposes
   'is_sparse_index_allowed()' to files outside of 'sparse-index.c', then
   patch [4/7] uses that function to mark the temporary index sparse when
   appropriate.
 * Next, 'git stash (apply|pop)' are made sparse index-compatible by
   changing their internal "merge" function (executed via
   'merge_recursive_generic()') from 'merge_recursive()' to
   'merge_ort_recursive()'. This requires first allowing
   'merge_recursive_generic()' to accept a merge function as an input
   (rather than hardcoding use of 'merge_recursive()') in patch [5/7], then
   changing the call in 'stash.c' to specify 'merge_ort_recursive()' in
   patch [6/7]. See note [4] for possible alternate implementations.
 * Finally, while patches 5 & 6 avoid index expansion for most cases of 'git
   stash (apply|pop)', applying a stash that includes untracked files still
   expands the index. This is a result of an internal 'read-tree' execution
   (specifically in its 'unpack_trees' call) creating a result index that is
   never sparse in-core, thus forcing the index to be unnecessarily
   collapsed and re-expanded in 'do_write_locked_index()'. In patch [7/7],
   'unpack_trees' is updated to set the default sparsity of the resultant
   index to "sparse" if allowed by repo settings and
   'is_sparse_index_allowed()' (similar to the change in patch 4).

Performance results (from the 'p2000' tests):

(git stash &&
 git stash pop)              master            this series
---------------------------------------------------------------------
full-v3                      4.07(2.42+1.34)   3.98(2.42+1.32) -2.2%
full-v4                      4.05(2.46+1.31)   4.00(2.49+1.29) -1.2%
sparse-v3                    7.48(4.81+2.57)   1.53(0.26+1.61) -79.5%
sparse-v4                    7.35(4.74+2.54)   1.59(0.27+1.63) -78.4%

(echo >>new &&
 git stash -u &&
 git stash pop)              master            this series
---------------------------------------------------------------------
full-v3                      4.21(2.62+1.45)   4.11(2.55+1.44) -2.4%
full-v4                      4.11(2.51+1.41)   4.02(2.49+1.41) -2.2%
sparse-v3                    7.35(4.64+2.66)   1.70(0.32+1.64) -76.9%
sparse-v4                    7.74(4.87+2.83)   1.70(0.32+1.66) -78.0%


[1]
https://lore.kernel.org/git/pull.1048.v6.git.1638201164.gitgitgadget@gmail.com/
[2]
https://lore.kernel.org/git/pull.1109.v2.git.1641924306.gitgitgadget@gmail.com/
[3]
https://lore.kernel.org/git/pull.1157.v3.git.1646166271.gitgitgadget@gmail.com/
[4] I went with changing 'stash' to always use 'merge-ort' in
'merge_recursive_generic()' as a sort of "middle ground" between "replace
'merge_recursive()' with 'merge_ort_recursive()' in all of its hardcoded
internal usage" and "only use 'merge-ort' if using a sparse index in 'git
stash', otherwise 'merge-recursive'". The former would extend the use of
'merge-ort' to 'git am' and 'git merge-recursive', whereas the latter is a
more cautious/narrowly-focused option. If anyone has any other thoughts, I'm
interested in hearing them.

Thanks!

-Victoria

Victoria Dye (7):
  stash: expand sparse-checkout compatibility testing
  stash: integrate with sparse index
  sparse-index: expose 'is_sparse_index_allowed()'
  read-cache: set sparsity when index is new
  merge-recursive: add merge function arg to 'merge_recursive_generic'
  stash: merge applied stash with merge-ort
  unpack-trees: preserve index sparsity

 builtin/am.c                             |  2 +-
 builtin/merge-recursive.c                |  2 +-
 builtin/stash.c                          |  6 +-
 merge-ort.c                              |  3 +-
 merge-recursive.c                        |  4 +-
 merge-recursive.h                        |  9 ++-
 read-cache.c                             | 18 ++++-
 sparse-index.c                           |  2 +-
 sparse-index.h                           |  1 +
 t/perf/p2000-sparse-operations.sh        |  2 +
 t/t1092-sparse-checkout-compatibility.sh | 94 +++++++++++++++++++++---
 unpack-trees.c                           |  6 ++
 12 files changed, 131 insertions(+), 18 deletions(-)


base-commit: 6cd33dceed60949e2dbc32e3f0f5e67c4c882e1e
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1171%2Fvdye%2Fsparse%2Fstash-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1171/vdye/sparse/stash-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1171
-- 
gitgitgadget
