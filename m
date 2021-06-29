Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29CCFC11F66
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 02:13:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1376661CEB
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 02:13:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbhF2CPh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Jun 2021 22:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbhF2CPg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jun 2021 22:15:36 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF14C061574
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 19:13:09 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id i94so23751695wri.4
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 19:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=MCJtugcBARQ08L1EY/iqkPQH6Xirz/Lg4Qy3RVESOYQ=;
        b=mVZo4LkNPrOsbmzfD1xkA1sBgESGFO3qEk54RsB18ficTxV2whaoVJxHEaw8Hc0k1p
         5lnSF2zc9f5cZVCudWiFylQE9RN3+eYgTT5AP2CbshGnQZcl+E4rRqTA6aaCqOOxmdz5
         fHp8BJ4wfmXtmzRycI5iMKoaXp7DujuKVQcQQhFCDZ5o/gurIui+/Q7zioA4HvWJoOar
         EaUXnLrILHbFc1vYKttqF+hdfK69sqM9sGzHn+Czj9LxKmP2FLrO/nOT2fsOdKrze4rk
         I6HTm5FLuQRCS1t5EWng01KNuvfNwweAR0/BDy7gZ5nmDhkC+ki2ATjKEvxSMM2xtVxd
         Wryw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=MCJtugcBARQ08L1EY/iqkPQH6Xirz/Lg4Qy3RVESOYQ=;
        b=DNy2uYPln5s/1ll4i5d5EqqlWVqPJsUMyBjeETrDJP3XDoaTKVJYS/gG51POhyxgVj
         oJq7q6uEo8Ac9wqsbkDz7oz8E77VUgGePRDhdwNt/Gq+VPgHFH8VcIIdOGWWcbfKFyU6
         /kGtB45gOKbBfU6ZgKJvDuaynSpRcwilA2wzVSHkZY81Oz1u5yq0S0Ztmc8d2CJ+X6Nm
         u9sE5GkiIaJSLMRGBIpXpyftIY0ZYihmgWt/nHYAub5msQGJhB02pUD249FIAKv5n4j0
         vejcs2YxgA62XLUwsxxwLzfQYDN3u8hCRlLFOqSQQkeSFeYFKLUZCS3LO8BHaV8zc3In
         ptHg==
X-Gm-Message-State: AOAM530K9PqHe8wshC+lIseHnYBZ9FjZ+aYIb/p3gKU1redkotUUWbtM
        or1M0kK9qV01U7mIj68mHN/4K8EsNoc=
X-Google-Smtp-Source: ABdhPJzoZtPzH8i06HaHDZwYKvi/GfDbOsr8Cd7ttSQQblrmELhQz6Z6/WLuAXFjUjM353K2+lk+rA==
X-Received: by 2002:a5d:4ad1:: with SMTP id y17mr31097182wrs.115.1624932787943;
        Mon, 28 Jun 2021 19:13:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w1sm2798297wmi.13.2021.06.28.19.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 19:13:07 -0700 (PDT)
Message-Id: <pull.973.git.1624932786.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 29 Jun 2021 02:13:01 +0000
Subject: [PATCH 0/5] Sparse index: integrate with commit and checkout
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com, matheus.bernardino@usp.br,
        stolee@gmail.com, Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series extends our integration of sparse-index to 'git commit' and 'git
checkout'.

This is based on ds/status-with-sparse-index (v7) and v2.32.0. The hard work
was already done in that topic, so these changes are simple.

Recall that we have delayed our integration with 'git add' until we can work
out the concerns about how to deal with pathspecs outside of the
sparse-checkout definition. Those concerns might have some overlap with how
'git commit' takes a pathspec, but this seems like a rare enough case to
handle here and we can be more careful with the behavior change in the next
series which will integrate with git add.

In addition to the tests that already exist in t1092, I have integrated
these changes in microsoft/git and tested them against the Scalar functional
tests, which go through quite a few complicated scenarios, verifying that
things work the same across the full index and sparse-index cases.

Thanks, -Stolee

Derrick Stolee (5):
  p2000: add 'git checkout -' test and decrease depth
  p2000: compress repo names
  commit: integrate with sparse-index
  sparse-index: recompute cache-tree
  checkout: stop expanding sparse indexes

 builtin/checkout.c                       |  8 ++--
 builtin/commit.c                         |  3 ++
 cache-tree.c                             |  2 -
 sparse-index.c                           |  2 +
 t/perf/p2000-sparse-operations.sh        | 47 ++++++++++++--------
 t/t1092-sparse-checkout-compatibility.sh | 55 ++++++++++++++++++++++--
 6 files changed, 89 insertions(+), 28 deletions(-)


base-commit: 1d744848ee6b58ccaf3a30f20abe9797ed5d2ce7
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-973%2Fderrickstolee%2Fsparse-index%2Fcommit-and-checkout-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-973/derrickstolee/sparse-index/commit-and-checkout-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/973
-- 
gitgitgadget
