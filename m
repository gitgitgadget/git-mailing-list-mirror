Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00632C433EF
	for <git@archiver.kernel.org>; Fri, 14 Jan 2022 16:07:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243022AbiANQHQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Jan 2022 11:07:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235975AbiANQHQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jan 2022 11:07:16 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B38BBC061574
        for <git@vger.kernel.org>; Fri, 14 Jan 2022 08:07:15 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id q141-20020a1ca793000000b00347b48dfb53so6709373wme.0
        for <git@vger.kernel.org>; Fri, 14 Jan 2022 08:07:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=i0r/8qhHcu08nQrBVr3atjtotTsHrUK075iISz5yqzI=;
        b=B0e7dD0ry+KZ4yPZ3uoXKuzRVdgLpH0O1q7mgTsGqsmA02gsr7gxiiKs4/usrb0r6E
         CACgy5rtv7vb8LSqJWdZbcj+vUO8Jt3cIPRy5ZywrCPJjhFlI0uK/lym6qkEUsfb7hQ1
         q9nca9m7h/nvVJhhqMBfcSLOKXcwCGtz7r1EvJpYNHsL24XrN6yvAWPg0RcvEWQAZwGK
         FyUYSqMOCwHu4ZeLrVFHEg65UKPOuqb/1z3X+9FDSnyTA+Qfb9rYcvmdy3K0wOB62bzO
         o5gKKvECNFItG0bwoDqja0TDPyuCoAKqS4chFx7Qxlr41HVR8ULFR8jauws8GYm1lzle
         36Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=i0r/8qhHcu08nQrBVr3atjtotTsHrUK075iISz5yqzI=;
        b=hBBykQMyUMczp/eBARgrNSE4j5RE/LT3FDFLfsmE3UssaB4Bb7pWupikBVF07a/158
         TB2DOuLZ/+Rs4hM9Dv25gXFYb8CclKJ5S7HnUibhaDViTuHbxmlKWE/O+pyrs2tHSKqR
         rVaowJFntxLoe+VtEt2WETTRiVuDfLzK5E0AW5T92tJkpngzrC13ca3m9wadWVpkkP0C
         w4biYb4Rbghf+xs7+PP2pTLc6qye5+42vgruPqyPFKcqlUxRkkJM9FxVrcVlCnWk2sxx
         JCu9n5zfnffmJ43BCi3IzKC8ZQTGGoemKBd/YJMOt1rWq08K25CYYIZemhIy3QNTFVfx
         9HkQ==
X-Gm-Message-State: AOAM5308cKX4+0Mu9fCQD7sWR6YcBCo1V+cHQotDzqFMYalTKq5FznR8
        +M/qR1JFTSw7aH7+6OKKkwYATTlBLvY=
X-Google-Smtp-Source: ABdhPJwzN9p8kfbO3XH5tf2BvPIgtsnt00+B1jpiF9sykY2iMVUqtEnhll9Gsp0r9ApU1GcRnJGRQA==
X-Received: by 2002:a05:600c:22da:: with SMTP id 26mr16251295wmg.121.1642176434035;
        Fri, 14 Jan 2022 08:07:14 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e4sm3273486wrq.51.2022.01.14.08.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 08:07:13 -0800 (PST)
Message-Id: <pull.1192.git.git.1642176433017.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 14 Jan 2022 16:07:12 +0000
Subject: [PATCH] leak tests: ignore some new leaks in a few tests
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

These test scripts have not changed at all recently, but topics in seen
have caused these to trigger the linux-leaks test.  It has been reported
on list, so let's fix the claim that these are leak free and when
someone investigates and fixes the problem, they can turn it back on.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
    leak tests: ignore some new leaks in a few tests
    
    linux-leaks passes when 'seen' is merged with this topic. A better fix
    is probably to bisect to determine which topic caused the memory leak
    and plug the leak in that topic (because these test scripts did not have
    any changes since the version when they previously passed), but a couple
    of quotes:
    
    """ This is sort of water under the bridge, as the other topic is
    already in 'master', but come to think of it, the strategy we used with
    TEST_PASSES_SANITIZE_LEAK variable was misguided.
    ... I am tempted to drop the "TEST_PASSES" bit from this script for now,
    """ (from https://lore.kernel.org/git/xmqqee6dz5s9.fsf@gitster.g/)
    
    """ But as to the "roadblock" I don't mind the
    TEST_PASSES_SANITIZE_LEAK=true being removed from the script at the
    slightest sign of trouble. Nobody should have to shift gears and chase
    down some memory leak... """ (from
    https://lore.kernel.org/git/211217.86a6gyyihr.gmgdl@evledraar.gmail.com/)

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1192%2Fnewren%2Fignore-leaks-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1192/newren/ignore-leaks-v1
Pull-Request: https://github.com/git/git/pull/1192

 t/t1430-bad-ref-name.sh                | 1 -
 t/t3211-peel-ref.sh                    | 1 -
 t/t6102-rev-list-unexpected-objects.sh | 1 -
 3 files changed, 3 deletions(-)

diff --git a/t/t1430-bad-ref-name.sh b/t/t1430-bad-ref-name.sh
index ff1c967d550..a3c689819fa 100755
--- a/t/t1430-bad-ref-name.sh
+++ b/t/t1430-bad-ref-name.sh
@@ -4,7 +4,6 @@ test_description='Test handling of ref names that check-ref-format rejects'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t3211-peel-ref.sh b/t/t3211-peel-ref.sh
index 9cbc34fc583..37b9d26f4b6 100755
--- a/t/t3211-peel-ref.sh
+++ b/t/t3211-peel-ref.sh
@@ -4,7 +4,6 @@ test_description='tests for the peel_ref optimization of packed-refs'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'create annotated tag in refs/tags' '
diff --git a/t/t6102-rev-list-unexpected-objects.sh b/t/t6102-rev-list-unexpected-objects.sh
index 6f0902b8638..52cde097dd5 100755
--- a/t/t6102-rev-list-unexpected-objects.sh
+++ b/t/t6102-rev-list-unexpected-objects.sh
@@ -2,7 +2,6 @@
 
 test_description='git rev-list should handle unexpected object types'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup well-formed objects' '

base-commit: 5ae4b10f85c8c2c00910cc805458c5c5464841e3
-- 
gitgitgadget
