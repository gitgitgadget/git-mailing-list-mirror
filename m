Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA2BC433E0
	for <git@archiver.kernel.org>; Fri, 19 Feb 2021 18:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F268C64E5F
	for <git@archiver.kernel.org>; Fri, 19 Feb 2021 18:12:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbhBSSM6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Feb 2021 13:12:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbhBSSM4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Feb 2021 13:12:56 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F26E7C061574
        for <git@vger.kernel.org>; Fri, 19 Feb 2021 10:12:15 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id w4so7807579wmi.4
        for <git@vger.kernel.org>; Fri, 19 Feb 2021 10:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:mime-version:content-transfer-encoding
         :fcc:to:cc;
        bh=LXyYxiOGXHXdl4XUnbf5OQkbxWDf5gmms8FQsM1sM1c=;
        b=BfFQ1LWmhECjuT3pEPbKx9ApNlYkfuQPgrbmfbwZejUlQUHjKJdk7JuUuxrHtwbpfS
         q2bKLWKbQA3UEtPGu0XqQE/2O9NooJ2Xb+eSIO/sGsEjj6OZ5evwZQ4CbMbFbXjFK9UD
         Psm0DG1vX166vAqR13+16X4GYIiU+hSBLnobmMHDf82haoYn4cVXVLVMKiSxAJOcAvOu
         EZyV1yuIOpVA3fix9qnFh1nRGvxyFCGyrJzX8yOLoUq46EqMi8VfwUiPr9dpawfPo+8B
         eoOPzeUxl2uV1xWOZl3LETjSeLIRGmINWKGSq12CJ6yk2mKmXovVzThWm3VGxTZ9I63U
         6Log==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=LXyYxiOGXHXdl4XUnbf5OQkbxWDf5gmms8FQsM1sM1c=;
        b=jgiSZ9wZEozqQe/8ok9bp92xmSvxJaaxNPlCEEomkgrr2eq5ZIzVD29kuX4xUA/HFG
         Jg7vRepZx/gNEvkKzXbsL7QAB0cjgE9KeL+MpwSfTBmXSNC5z3WgnnHvFQHT6AdDqRz/
         0uzlJsnrs8/4u/OUsqfYebHeQLqFU3bx9awTmOAe7xo0Hkqs7hL2GFoC4EjRQzokmqr0
         RKwJ1Oo6FTYqLR7WtzNI/dibht5HOBMgsY/nSw83V9+Q6SPuKAlUW/6lFsABxsXpBj7t
         s2xGgufJ8IePTxnvpdWR9MnecdlvURsYXyjq/qnzMEdEiOtDd/bAhAg1WYdBqDWo1YvG
         e8kw==
X-Gm-Message-State: AOAM5308ixIMqXbJkSkwKzogQR6VZXU0h4SPn7y91+ItnHWwpVx8K2yW
        hF2mOiryw+WV77eSOYjRWxcB3O3SXhU=
X-Google-Smtp-Source: ABdhPJwKS2ELP7nFBqpwIK2BwHzbShixWkCUX3yJbe40ejr3qP1B08/JTvHM25xnzV8e1F6hVHBHrA==
X-Received: by 2002:a7b:c3c7:: with SMTP id t7mr9500328wmj.170.1613758334772;
        Fri, 19 Feb 2021 10:12:14 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s23sm12997577wmc.29.2021.02.19.10.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Feb 2021 10:12:14 -0800 (PST)
Message-Id: <pull.880.git.1613758333.gitgitgadget@gmail.com>
From:   "Andrej Shadura via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 19 Feb 2021 18:12:11 +0000
Subject: [PATCH 0/2] Add --no-filters option to git-add
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Andrej Shadura <andrew.shadura@collabora.co.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It is possible for a user to disable attribute-based filtering when
committing by doing one of the following:

 * Create .git/info/attributes unapplying all possible transforming
   attributes.
 * Use git hash-object and git update-index to stage files manually.

Doing the former requires keeping an up-to-date list of all attributes which
can transform files when committing or checking out. Doing the latter is
difficult, error-prone and slow when done from scripts.

Instead, similarly to git hash-object, --no-filter can be added to git add
to enable temporarily disabling filtering in an easy to use way.

These patches:

 * Add new flag ADD_CACHE_RAW to add_to_index()
 * Add new flag HASH_RAW to index_fd()
 * Make git hash-object use the new HASH_RAW flag for consistency
 * Add tests for the new git-add option.

Andrej Shadura (2):
  add: add option --no-filters to disable attribute-based filtering
  hash-object: use the new HASH_RAW flag instead of setting path to NULL

 Documentation/git-add.txt |  7 +++++-
 builtin/add.c             |  3 +++
 builtin/hash-object.c     | 17 ++++++---------
 cache.h                   |  2 ++
 object-file.c             |  2 +-
 read-cache.c              |  3 +++
 t/t2205-add-no-filters.sh | 46 +++++++++++++++++++++++++++++++++++++++
 7 files changed, 68 insertions(+), 12 deletions(-)
 create mode 100755 t/t2205-add-no-filters.sh


base-commit: 2283e0e9af55689215afa39c03beb2315ce18e83
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-880%2Fandrewshadura%2Fgit-add-no-filters-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-880/andrewshadura/git-add-no-filters-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/880
-- 
gitgitgadget
