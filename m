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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 146C9C6377A
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 21:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6B1F613E4
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 21:07:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbhGUU0Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jul 2021 16:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbhGUU0Z (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jul 2021 16:26:25 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57FEBC061575
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 14:07:01 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id z8-20020a1c4c080000b029022d4c6cfc37so289562wmf.5
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 14:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=VfpQ8/vB5KZQzqnhkmqXW5khzD7dtXW+TXRSuTL/Sek=;
        b=Mnxw21mRdvJJzbEuiRBF6MiRkcH4v2mCys6YiR66e562f5npK/NSuaYgN7CR73Dw9Y
         +zLXrTXdXQh/DX+CZW8p53HYwar1rPMdv9xOBaIscC2tNTarv7ZObwYw412GgOuugmOr
         pvvr/g+KCiK7taqus3QuGx76LYccAHyAG2UhynA+rXFhFU9ak0zCwRw78FbfqJPknDci
         96vV9l8MmAvECgVmQBDYVweIKFfamAEon8bVfa3PNCr+2aIWpyikRpmfpHNMv0weDF7W
         ry6vUTKH8ng9zXfkpyjR/UlnyqmLvS47F7+bxxWsCpsCW/1Iv6G8/9xsu3mzzF0FvVAo
         KgGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=VfpQ8/vB5KZQzqnhkmqXW5khzD7dtXW+TXRSuTL/Sek=;
        b=L/2KG9MnbTp14K8P0C46Z+JzdD00ExpBpmpeLzL2nWdyuttjUAAWTdLEB0Q5wRSUNM
         sxM2wkhhml9AzbTOb308DhFtvFXNtA8+Xnybh6vv7NXtlVZ7sILnoUkxUYuB4VJF6wMG
         NYziz8gAD/5Ims3KU5USpXHpLVyDuyVrBX0qjHbCe6SmYqwogYYKQILEoEden+mi8ejl
         EpWPLxHMfAGiADBoaGZa35YA/3rkovP9PUOm3plXSibxQV9DpKwrOM8kfkMwDfGm0/BS
         9UwlKKcbisn84c3Hn4CiCWcG/UX39spcKN4SbXHjz5puWtphqeVpzLGN6uKGa8ckdiNG
         xMgw==
X-Gm-Message-State: AOAM533qdxCQMA8vh6/Tp7SRJ+7d05igmhyjBsBZL+E2tbFRITNUbdQJ
        ZH2/EgHZ/JrblsGFs1NanCV0OVyshNA=
X-Google-Smtp-Source: ABdhPJxGwAnnlT8rMoAntm6OiBUULPKVFjnuDIBxq5QWXBDA+qrljvPRYZqKzFSNzdEFNRXuLjUXRw==
X-Received: by 2002:a1c:35c2:: with SMTP id c185mr38932933wma.126.1626901620017;
        Wed, 21 Jul 2021 14:07:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q72sm21073358wme.14.2021.07.21.14.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 14:06:59 -0700 (PDT)
Message-Id: <pull.999.git.1626901619.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 21 Jul 2021 21:06:54 +0000
Subject: [PATCH 0/5] Sparse Index: Integrate with 'git add'
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

This patch series re-submits the 'git add' integration with sparse-index.
The performance gains are the same as before.

It is based on ds/commit-and-checkout-with-sparse-index.

This series was delayed from its initial submission for a couple reasons.

The first was because it was colliding with some changes in
mt/add-rm-in-sparse-checkout, so now we are far enough along that that
branch is in our history and we can work forwards.

The other concern was about how 'git add ' should respond when a path
outside of the sparse-checkout cone exists. One recommendation (that I am
failing to find a link to the message, sorry) was to disallow adding files
that would become index entries with SKIP_WORKTREE on. However, as I worked
towards that goal I found that change would cause problems for a realistic
scenario: merge conflicts outside of the sparse-checkout cone.

The first patch of this series adds tests that create merge conflicts
outside of the sparse cone and then presents different ways a user could
resolve the situation. We want all of them to be feasible, and this
includes:

 1. Reverting the file to a known version in history.
 2. Adding the file with its contents on disk.
 3. Moving the file to a new location in the sparse directory.

Without maintaining the behavior of adding files outside of the
sparse-checkout cone, we risk confusing users who get into this state. The
only workaround they would have is to modify their sparse-checkout
definition which might lead to expanding much more data than they need to
resolve the conflicts.

For that reason, I stopped trying to limit 'git add' to be within the cone.
I'm open to suggestions here, but we need an approach that works for
out-of-cone conflicts.

The one place I did continue to update is 'git add --refresh ' to match the
behavior added by mt/add-rm-in-sparse-checkout which outputs an error
message. This happens even when the file exists in the working directory,
but that seems appropriate enough.

Thanks, -Stolee

Derrick Stolee (5):
  t1092: test merge conflicts outside cone
  add: allow operating on a sparse-only index
  pathspec: stop calling ensure_full_index
  t1092: 'git add --refresh' difference with sparse-index
  add: ignore outside the sparse-checkout in refresh()

 builtin/add.c                            | 13 ++++-
 pathspec.c                               |  2 -
 t/t1092-sparse-checkout-compatibility.sh | 71 ++++++++++++++++++++----
 3 files changed, 72 insertions(+), 14 deletions(-)


base-commit: 71e301501c88399711a1bf8515d1747e92cfbb9b
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-999%2Fderrickstolee%2Fsparse-index%2Fadd-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-999/derrickstolee/sparse-index/add-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/999
-- 
gitgitgadget
