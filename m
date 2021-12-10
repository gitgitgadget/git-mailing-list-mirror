Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5C37C433EF
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 15:18:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242745AbhLJPVs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Dec 2021 10:21:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242737AbhLJPVs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Dec 2021 10:21:48 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E18C7C0617A1
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 07:18:12 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id q3so15471995wru.5
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 07:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=3OvSyJ5Ip6UXzR7BvmTS4TqRt+rkDOY9D51ipEVq4v4=;
        b=eAb4SaAV+1b5STGk13xxAU1xjUPZuk9yZy2TDDxkRDGjlI81N3J7mXJuRH8AKnbuOB
         ufhBVLCFJLn3hjufE6m7b9K9krxs24Vy+/YLb+oCNWN7vtCHiNWzTIo8TFHZC5CKXrG/
         hL2j3U7vo8qEFVCvxHMBj8SKOnvgI4/Mv8ZbGu0N9QjPYT12IqMCmMBcFcTt3Qn15VOg
         1+6F8lGNeXPyhbBVIhib6wurlr4tqmIsMGxuGecC7y687vvM7c+AuEMGrsB2dQ3QQC+U
         PWyZwwTekl4PoODvIRV1v6mnlgIuyGPkjj7W+T78NTDEozECHm03Jeu3LMy3aldqwt4E
         E2bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=3OvSyJ5Ip6UXzR7BvmTS4TqRt+rkDOY9D51ipEVq4v4=;
        b=4qAafh4UKz+5EPxVnetJUmqllvAm801eYCP23+R74ziVrw17eHDgHlYQ8v0bgQKMjf
         eA6j15wCHU68yssBf2WGjQMG2oX0MjRi5df9i4A2W6h08QsVdZHbIW3rprrhqy/SX8do
         n+RCkTCQCSxooPF9R2XU2PqXNRK26I8H1nmKfWuDvPNNnnUBfK/FT4jgCIdY/XqVb83B
         fIdux06iekUisLeGgzReWE/qaJ5iVvcjCSwSo1k/g8YdB1Y2DJAr7Gaaf98bj5JVmUHu
         Vvr7T1Ubv7GUuDpMwh5Jg48Ahd+QZ94VhYvNf+ShQsPOIGwQ0bM/vvo7AP1xQs53okEF
         DllA==
X-Gm-Message-State: AOAM531elGgYCDqy0U2JdnXyHVor36nVpMHPcLa5uODtYMdemRjzYagq
        PrktB/pd4nevZ8KXI27D8oV4VKDGkUY=
X-Google-Smtp-Source: ABdhPJxJdJfM2YAQLXUEnfcz0BYgmzeb9kpgG5+kvUFg+ErQRDO+EpqfqKK17Xn0h5QThfn/G03BTg==
X-Received: by 2002:a05:6000:1862:: with SMTP id d2mr14468576wri.203.1639149491333;
        Fri, 10 Dec 2021 07:18:11 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o3sm12689755wms.10.2021.12.10.07.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 07:18:11 -0800 (PST)
Message-Id: <pull.1069.v2.git.1639149490.gitgitgadget@gmail.com>
In-Reply-To: <pull.1069.git.1638907336.gitgitgadget@gmail.com>
References: <pull.1069.git.1638907336.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 10 Dec 2021 15:18:07 +0000
Subject: [PATCH v2 0/4] sparse-checkout: fix segfault on malformed patterns
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

Derrick Stolee (4):
  sparse-checkout: fix segfault on malformed patterns
  sparse-checkout: fix OOM error with mixed patterns
  sparse-checkout: refuse to add to bad patterns
  amend! sparse-checkout: fix segfault on malformed patterns

 builtin/sparse-checkout.c          |  5 ++++-
 dir.c                              |  5 +----
 t/t1091-sparse-checkout-builtin.sh | 31 +++++++++++++++++++++++++++++-
 3 files changed, 35 insertions(+), 6 deletions(-)


base-commit: abe6bb3905392d5eb6b01fa6e54d7e784e0522aa
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1069%2Fderrickstolee%2Fsparse-checkout%2Finput-bug-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1069/derrickstolee/sparse-checkout/input-bug-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1069

Range-diff vs v1:

 1:  becbee16d2e ! 1:  a0e3dd335c9 sparse-checkout: fix segfault on malformed patterns
     @@ Commit message
          Add a test that triggers the segfault without the code change.
      
          Reported-by: John Burnett <johnburnett@johnburnett.com>
     +    Reviewed-by: Elijah Newren <newren@gmail.com>
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
       ## dir.c ##
 2:  239bf23eacb ! 2:  86fbf130c03 sparse-checkout: fix OOM error with mixed patterns
     @@ Commit message
      
          Reported-by: Calbabreaker <calbabreaker@gmail.com>
          Helped-by: Taylor Blau <me@ttaylorr.com>
     +    Reviewed-by: Elijah Newren <newren@gmail.com>
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
       ## builtin/sparse-checkout.c ##
 3:  cc52fb2b0b7 ! 3:  5d096e380a4 sparse-checkout: refuse to add to bad patterns
     @@ Commit message
          because of a test that adds non-cone mode patterns without cleaning them
          up. Perform that cleanup as part of the test now.
      
     +    Reviewed-by: Elijah Newren <newren@gmail.com>
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
       ## builtin/sparse-checkout.c ##
 -:  ----------- > 4:  7bacb3760f3 amend! sparse-checkout: fix segfault on malformed patterns

-- 
gitgitgadget
