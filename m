Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 547E2C433EF
	for <git@archiver.kernel.org>; Wed,  8 Jun 2022 20:09:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232789AbiFHUJM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jun 2022 16:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbiFHUJH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jun 2022 16:09:07 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9EF4DE8
        for <git@vger.kernel.org>; Wed,  8 Jun 2022 13:09:05 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id j5-20020a05600c1c0500b0039c5dbbfa48so2392017wms.5
        for <git@vger.kernel.org>; Wed, 08 Jun 2022 13:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=VJSvuf4TKOlJ1Ehw6bYdV4AXbXiAnm3kYOGvWLHV/Vc=;
        b=F+nE3pabxa5bTWV1kyjej1ZTr5/MBTfWAx67HyoSliyOjoSe2YXjfjswcYhyHmjLfM
         E9qIwZ7QFueUPMFLgpTIPzl0CaQjfl9tKVJM3XXpt+WYcboG8iAbAS7uPWnF6TLKkvA9
         KJSwmpXFiboYfdpNFK7/w/2qWleVdJJGNgxSqYE+R7CtrEimlP6BzK9yPRt7/YSW2A53
         Nclt99D5MWNZbTY+7+8lpAZBsL3fSDZKOIrzU7csbdxWNKOBW7L5ldGBfuSvbxi3fECO
         5ZerBStzhy96OpWgVLRW9IqIjmBTJH/4Pq4zXcrgwaJq+mxp/a0JXNsLYy48SjV9k1mi
         XeFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=VJSvuf4TKOlJ1Ehw6bYdV4AXbXiAnm3kYOGvWLHV/Vc=;
        b=dfOgzTGT9e9eStqPWd4Xn7sGcNMTzdaJEioDJKD9PMnAL/noRWENLL8PQp7iIXlXC0
         EBlx+gC984dulFY++Fy/SNMilH/wwLMrqqo7G8Jat0WqilAr+6/uMG+TDpEodxQh7g4M
         OmztSZcncHQ2eBvvT6wTmqCcL1eN7ckjo/na+rltbvD+iLVeVepW4wLY6kpuwLrW0EG5
         EFzLeQqp4KuICAcWDJBXROo3zU7L+2VlUb7t9zOklz+Er4hAT0VCGmzoufgWobcS7HcY
         ojI5N5gvOn20spY8ld2trXVHRetjvXmwiS+PUPY2DkCDtOFXJZHRBlHsETRk01YIup4s
         xiKQ==
X-Gm-Message-State: AOAM5302vKjGpS6oyQsMKN8PyWeqnADmFQMdLCWi0mryBFdorzW2Octc
        RwZv+F4AVnQkykWyaIG6lHrpTudC3zIm8OsH
X-Google-Smtp-Source: ABdhPJztWva0mjS9ZBmC+EHN2JFkPelvK14EdGkb00R9hl/DFx8KNUrRfO5CccYv2hNc5VMJwTmGyg==
X-Received: by 2002:a05:600c:1c85:b0:39c:584d:bdaa with SMTP id k5-20020a05600c1c8500b0039c584dbdaamr873510wms.161.1654718943938;
        Wed, 08 Jun 2022 13:09:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e7-20020adff347000000b0020ff4b8efc6sm22167100wrp.80.2022.06.08.13.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 13:09:03 -0700 (PDT)
Message-Id: <pull.1254.git.1654718942.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 08 Jun 2022 20:08:58 +0000
Subject: [PATCH 0/4] Create branch_checked_out() helper
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmx.de, me@ttaylorr.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a replacement for some patches from v2 of my 'git rebase
--update-refs' topic [1]. After some feedback from Philip, I've decided to
pull that topic while I rework how I track the refs to rewrite [2]. This
series moves forward with the branch_checked_out() helper that was a bit
more complicated than expected at first glance. This series is a culmination
of the discussion started by Junio at [3].

[1]
https://lore.kernel.org/git/pull.1247.v2.git.1654634569.gitgitgadget@gmail.com
[2]
https://lore.kernel.org/git/34264915-8a37-62db-f954-0b5297639b34@github.com/
[3] https://lore.kernel.org/git/xmqqr140t9am.fsf@gitster.g/

Here is the patch outline:

 1. Add a basic form of branch_checked_out() that only looks at the HEAD of
    each worktree. Since this doesn't look at BISECT_HEAD or REBASE_HEAD,
    the helper isn't linked to any consumer in this patch. A test script is
    added that verifies the current behavior checks that are implemented,
    even if they are not connected yet.
 2. Make branch_checked_out() actually look at BISECT_HEAD and REBASE_HEAD.
    Add tests for those cases, which was previously untested in the Git test
    suite. Use branch_checked_out() in 'git branch -f' to demonstrate this
    helper works as expected.
 3. Use branch_checked_out() in 'git fetch' when checking refs that would be
    updated by the refspec. Add tests for that scenario, too.
 4. Use branch_checked_out() in 'git branch -D' to prevent deleting refs
    from under an existing checkout. The commit message here describes some
    barriers to removing other uses of find_shared_symref() that could be
    good investigations for later.

Thanks, -Stolee

Derrick Stolee (4):
  branch: add branch_checked_out() helper
  branch: check for bisects and rebases
  fetch: use new branch_checked_out() and add tests
  branch: use branch_checked_out() when deleting refs

 branch.c                  | 77 +++++++++++++++++++++++++++++++++----
 branch.h                  |  8 ++++
 builtin/branch.c          |  8 ++--
 builtin/fetch.c           | 25 ++++++------
 t/t2407-worktree-heads.sh | 81 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 173 insertions(+), 26 deletions(-)
 create mode 100755 t/t2407-worktree-heads.sh


base-commit: 2668e3608e47494f2f10ef2b6e69f08a84816bcb
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1254%2Fderrickstolee%2Fbranch-checked-out-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1254/derrickstolee/branch-checked-out-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1254
-- 
gitgitgadget
