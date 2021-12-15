Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 961B5C433F5
	for <git@archiver.kernel.org>; Wed, 15 Dec 2021 13:46:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237403AbhLONqM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Dec 2021 08:46:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234455AbhLONqL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Dec 2021 08:46:11 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1273AC061574
        for <git@vger.kernel.org>; Wed, 15 Dec 2021 05:46:11 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id t18so38251013wrg.11
        for <git@vger.kernel.org>; Wed, 15 Dec 2021 05:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=oQmxHYEK1Tfk+WRfOkxJ+n9gG/xNy+nTBTBvk3k8tr0=;
        b=ltmN77/saN32IKXzJyWFpuXk76mJ8wVCuTH0Uh10PRUtJeT9YhEx53awcF/+sO+YxJ
         L9O0sHIIZThQ/qMj7eKm+DyaaS5z84HrOTFtMNtWQTZaNgHuulBEVCcJ2mKBIH1NxUUx
         G5pMGwvikThkudSVKyjCa9YkIyxyuFg79j5zp11V6J1uOqy6qcTq1rq7/fRIa8lSNfTb
         GbRHSHUtZX4aznY8QnQ/hk7sxGLCE+RGkqWvSP8gJUHUAfBsI1rMoe+swNk3+g0PMkIW
         6qzfPfpJFPVXa/x8GQC3PPG41OED6v4y1RF+HQeEZj+0CvTwdIHy+9ErOKC3TGl5Iq1T
         56jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=oQmxHYEK1Tfk+WRfOkxJ+n9gG/xNy+nTBTBvk3k8tr0=;
        b=EyMugdNAS8/PsbBX9N0LqYvBzA5sEN9y9RiaxFWG2gDjdm2MDkyx0DiovOOqoAfJwd
         k1E8fkBcQ9pGFZK0AzTw+YgplGn7V1oL91sgJZeANuZoT6yOqtUL1Gh7bNHKmzCUHWgK
         LlRWbwpaHiEUJ+nZ0hu4KkmBHkzdUmobbJy55EPqPjVKDkD48hG+tikmovPzesQ+pnWE
         9KnAqVrXzyFM3ltXH5dTgTMkdIw8SwmzPYZq0socEMezBntqMRok6tNX628KUcYLIIHo
         cY9/xOFqG/U93I9GSmG2pvG9zYXlM28+LyHp8iNlsoYe5aOuGa4zQSu8XuguvZYpoBml
         WrtQ==
X-Gm-Message-State: AOAM531Grtzqkas2yZOijsPw7ZQOz+EHnmXGVAa48+sOqprJgq+6hd4e
        O1xYNr3QGicGfGZXHDd5iFA6Mm15nPhVCg==
X-Google-Smtp-Source: ABdhPJyybAPiYzzSrvvQ3RTVzAFbVt6KwUbdvRYTj4g2pUh/9OLp3SwszHY8jegHgpDtphAeN/L8HQ==
X-Received: by 2002:a5d:5511:: with SMTP id b17mr4482024wrv.676.1639575969371;
        Wed, 15 Dec 2021 05:46:09 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d2sm1858780wmb.31.2021.12.15.05.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 05:46:08 -0800 (PST)
Message-Id: <pull.1069.v3.git.1639575968.gitgitgadget@gmail.com>
In-Reply-To: <pull.1069.v2.git.1639149490.gitgitgadget@gmail.com>
References: <pull.1069.v2.git.1639149490.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 15 Dec 2021 13:46:05 +0000
Subject: [PATCH v3 0/3] sparse-checkout: fix segfault on malformed patterns
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, newren@gmail.com, vdye@github.com,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series fixes some issues with parsing sparse-checkout patterns when
core.sparseCheckoutCone is enabled but the sparse-checkout file itself
contains patterns that don't match the cone mode format.

The first patch fixes a segfault first reported in [1]. The other two
patches are from an earlier submission [2] that never got picked up and I
lost track of. There was another patch involving 'git sparse-checkout init
--cone' that isn't necessary, especially with Elijah doing some work in that
space right now.

[1] https://github.com/git-for-windows/git/issues/3498 [2]
https://lore.kernel.org/git/pull.1043.git.1632160658.gitgitgadget@gmail.com

Thanks, -Stolee


Updates in v2 and v3
====================

 * I intended to fix a typo in a patch, but accidentally sent the amend!
   commit in v2
 * v3 has the typo fix properly squashed in.
 * Added Elijah's review.

Derrick Stolee (3):
  sparse-checkout: fix segfault on malformed patterns
  sparse-checkout: fix OOM error with mixed patterns
  sparse-checkout: refuse to add to bad patterns

 builtin/sparse-checkout.c          |  5 ++++-
 dir.c                              |  5 +----
 t/t1091-sparse-checkout-builtin.sh | 31 +++++++++++++++++++++++++++++-
 3 files changed, 35 insertions(+), 6 deletions(-)


base-commit: abe6bb3905392d5eb6b01fa6e54d7e784e0522aa
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1069%2Fderrickstolee%2Fsparse-checkout%2Finput-bug-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1069/derrickstolee/sparse-checkout/input-bug-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1069

Range-diff vs v2:

 1:  a0e3dd335c9 ! 1:  1744a26845f sparse-checkout: fix segfault on malformed patterns
     @@ Commit message
          there is additional logic that attempts to remove the line from the hashset
          and free the data. This leads to a segfault in the 'git sparse-checkout
          list' command because it iterates over the contents of the hashset, which is
     -    no invalid.
     +    now invalid.
      
          The fix here is to stop trying to remove from the hashset. Better to leave
          bad data in the sparse-checkout matching logic (with a warning) than to
 2:  86fbf130c03 = 2:  a2fe867222e sparse-checkout: fix OOM error with mixed patterns
 3:  5d096e380a4 = 3:  a0e5a942ae0 sparse-checkout: refuse to add to bad patterns
 4:  7bacb3760f3 < -:  ----------- amend! sparse-checkout: fix segfault on malformed patterns

-- 
gitgitgadget
