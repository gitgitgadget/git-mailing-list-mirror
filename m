Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C3A7C433EF
	for <git@archiver.kernel.org>; Sun, 13 Feb 2022 00:40:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232719AbiBMAkG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Feb 2022 19:40:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbiBMAkF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Feb 2022 19:40:05 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E13E60054
        for <git@vger.kernel.org>; Sat, 12 Feb 2022 16:40:01 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id w11so21158793wra.4
        for <git@vger.kernel.org>; Sat, 12 Feb 2022 16:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=hWDvu7E4Ik/QqMWenJDOpob4Fy8tD8W2FMs8T7YMlHk=;
        b=Br1AzpwwO94bQNQrXMjIKEMy3MSrcVtshcWIJdH4WNqBYD4zDQ9y4fcFccGoNyUIK3
         czAvrRBjgiTNOjDzEHkVQ3lF5iGx9LkjAyJSWBPWPOwDmLLRA/F49wrhpXNpinUBuv5g
         w0T8x9YVJb/iaLbgT3cONR1XANMu6DXZAColn55PWCZjpxLPgtttDnlU93nDSafaOvNJ
         X7iYfoDt86pmD4R5ZHpFN9a83AdQOF/jW6QA2VaJXystsZrli+qa7lFT3uET0rXz+Tic
         0gwV5KMX2TB8cdgT24CwkAI3VKxRqanG4JTC+a81l4ViYkdKnet5gwdl5+Yk1QuKBrpY
         uHdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hWDvu7E4Ik/QqMWenJDOpob4Fy8tD8W2FMs8T7YMlHk=;
        b=2MYUjG5FQxK8NhWX3jdTNjaxkxIFwIFSmsjK+lN3MiXYXUHKEofjJTqT/vhd7CnxsL
         AJCtuxPp4dFm+TTCKF72oW02m/iL3H7Dxu4UzoDXNW0ce1KmzmA9hN4dlkSm+mPKEwdk
         7BMLo/4WQ/njXwTMi1P4h4q7mbjn2Imj1FiL0unPxMV0+IV5XcTIB9Ivy4RphgxsU/7r
         ezxfbcOKDNUxeqh3nJ8EfiTHVz7Ahx6oLxb4j7CUdrWCjtL38Ftqsvbl75fsUPMyaiEi
         mgRmJ2luheOpB5I4SX4t4aCWq6YMpaSxjsfVB1LYECeFfAQhuzgQaV/BOXM9alocLomY
         MqWw==
X-Gm-Message-State: AOAM531Mlwrm5nV5qKiI4IRHZWf2MkLI/lWzfZ8RNS8C28zwvbdFB+Gs
        Y4xhizbKeDbBuFCe26YKvJDjz3X8wY4=
X-Google-Smtp-Source: ABdhPJxuM0A3dexS9NkzBOpHyYiDjUtRCQucAJ1mt/3xmkXSKaZTGUS/CkEZoq5mA0D3pU9fY79xfw==
X-Received: by 2002:a05:6000:180c:: with SMTP id m12mr3929409wrh.610.1644712799446;
        Sat, 12 Feb 2022 16:39:59 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p12sm7649826wmg.36.2022.02.12.16.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Feb 2022 16:39:58 -0800 (PST)
Message-Id: <pull.1118.git.1644712797.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 13 Feb 2022 00:39:50 +0000
Subject: [PATCH 0/7] RFC: sparse checkout: make --cone mode the default, and check add/set
 argument validity
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Victoria Dye <vdye@github.com>, Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Note (reason for RFC): this is RFC primarily because of dependencies (you
may not want to pick this up yet, Junio), though there is also a question of
whether to split patch 7 into two steps -- one for now and one we take in
some future release. In particular, the first step could be to have
sparse-checkout error out if neither --no-cone nor --cone are specified and
then change the default to be --cone in some future release. I don't think
splitting it into two steps is needed given (a) users who are unaware of the
change will still get useful error messages telling them that directories
are expected due to patches 4-6 of this series, and (b) the huge
"EXPERIMENTAL" warning and explicit note about likely behavioral changes in
git-sparse-checkout.txt serves as warning about the changes. However, the
two step approach is an alternative.

Note 2 (dependencies): this depends on en/present-despite-skipped (which
depends on vd/sparse-clean-etc) and on
ds/sparse-checkout-requires-per-worktree-config, because of otherwise heavy
text conflicts in patch 7 to git-sparse-checkout.txt. Given that neither of
those have merged to next yet, it may be premature to pick up this series.

This series continues attempts to make sparse-checkouts more user friendly.
A quick overview:

 * Patches 1-2 fix existing bugs from en/sparse-checkout-set
 * Patch 3 fixes sparse-checkout-from-subdirectories-ignores-"prefix" (see
   https://lore.kernel.org/git/29f0410e-6dfa-2e86-394d-b1fb735e7608@gmail.com/),
   at least in cone mode. In non-cone mode it is not clear if patch 3 is a
   "fix" or a "break" (see the "NON-CONE PROBLEMS" section of the manual
   added in patch 7, and
   https://lore.kernel.org/git/e1934710-e228-adc4-d37c-f706883bd27c@gmail.com/
   where Stolee suggested it might be incorrect).
 * Patches 4-6 check positional arguments to set/add and provide
   errors/warnings for very likely mistakes. It also adds a --skip-checks
   flag for overridding in case you have a very unusual situation.
 * Patch 7 makes cone mode the default, and makes large updates to the
   documentation both to explain why we changed the default, and to simplify
   the documentation since users can just use directories and ignore the
   intricacies of gitignore-style patterns and how they relate to sparse
   checkouts.

Elijah Newren (7):
  sparse-checkout: correct reapply's handling of options
  sparse-checkout: correctly set non-cone mode when expected
  sparse-checkout: pay attention to prefix for {set, add}
  sparse-checkout: error or warn when given individual files
  sparse-checkout: reject non-cone-mode patterns starting with a '#'
  sparse-checkout: reject arguments in cone-mode that look like patterns
  sparse-checkout: make --cone the default and deprecate --no-cone

 Documentation/git-sparse-checkout.txt | 228 +++++++++++++++++++-------
 builtin/sparse-checkout.c             |  86 +++++++++-
 t/t1091-sparse-checkout-builtin.sh    |  97 ++++++++++-
 t/t3602-rm-sparse-checkout.sh         |   6 +-
 t/t3705-add-sparse-checkout.sh        |   4 +-
 t/t6428-merge-conflicts-sparse.sh     |   4 +-
 t/t7002-mv-sparse-checkout.sh         |   2 +-
 t/t7012-skip-worktree-writing.sh      |   2 +-
 8 files changed, 345 insertions(+), 84 deletions(-)


base-commit: a813c7516ab581570509aa7a9c03ca05c769caf7
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1118%2Fnewren%2Fsparse-checkout-default-and-arg-validity-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1118/newren/sparse-checkout-default-and-arg-validity-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1118
-- 
gitgitgadget
